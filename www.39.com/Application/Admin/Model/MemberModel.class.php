<?php
namespace Admin\Model;
use Think\Model;
class MemberModel extends Model 
{
	protected $insertFields = array('username','password','cpassword','chkcode','must_click');
	protected $updateFields = array('id','username','password','cpassword');
       
	// 添加和修改会员时使用的表单验证规则
	protected $_validate = array(
		array('must_click', 'require', '必须同意注册协议！', 1, 'regex', 3),
		array('username', 'require', '用户名不能为空！', 1, 'regex', 3),
		array('username', '1,30', '用户名的值最长不能超过 30 个字符！', 1, 'length', 3),
		array('password', 'require', '密码不能为空！', 1, 'regex', 1),
		array('password', '6,20', '密码的值最长不能超过 6-20 个字符！', 1, 'length', 3),
		array('cpassword', 'password', '两次密码输入不一致！', 1, 'confirm', 3),
		array('username', '', '用户名已经存在！', 1, 'unique', 3),
		array('chkcode', 'require', '验证码不能为空！', 1),
		array('chkcode', 'check_verify', '验证码不正确！', 1, 'callback'),
	);
        // 为登录的表单定义一个验证规则 
	public $_login_validate = array(
		array('username', 'require', '用户名不能为空！', 1),
		array('password', 'require', '密码不能为空！', 1),
		array('chkcode', 'require', '验证码不能为空！', 1),
		array('chkcode', 'check_verify', '验证码不正确！', 1, 'callback'),
	);
        // 验证验证码是否正确
	function check_verify($code, $id = ''){
	    $verify = new \Think\Verify();
	    return $verify->check($code, $id);
	}
        public function login()
	{
		// 从模型中获取用户名和密码
		$username = $this->username;
		$password = $this->password;
		// 先查询这个用户名是否存在
		$user = $this->where(array(
			'username' => array('eq', $username),
		))->find();
		if($user)
		{
			if($user['password'] == md5($password))
			{
				// 登录成功存session
				session('m_id', $user['id']);
				session('m_username', $user['username']);
                                session('face','/Public/Home/image/user1.gif');
                                //计算当前会员级别ID并存SESSION
                                $mlModel = D('member_level');
                                $levelId = $mlModel->field('id')->where(
                                        array(
                                            'jifen_bottom' => array('elt',$user['jifen']),
                                            'jifen_top' => array('egt',$user['jifen']),
                                        ))->find();
                                session('level_id',$levelId['id']);
                                //move CartData in cart to DB
                                $cartModel = D('Home/cart');
                                $cartModel ->moveDataToDb();
				return TRUE;
			}
			else 
			{
				$this->error = '密码不正确！';
				return FALSE;
			}
		}
		else 
		{
			$this->error = '用户名不存在！';
			return FALSE;
		}
	}
	public function search($pageSize = 20)
	{
		/**************************************** 搜索 ****************************************/
		$where = array();
		if($username = I('get.username'))
			$where['username'] = array('like', "%$username%");
		/************************************* 翻页 ****************************************/
		$count = $this->alias('a')->where($where)->count();
		$page = new \Think\Page($count, $pageSize);
		// 配置翻页的样式
		$page->setConfig('prev', '上一页');
		$page->setConfig('next', '下一页');
		$data['page'] = $page->show();
		/************************************** 取数据 ******************************************/
		$data['data'] = $this->alias('a')
		->field('a.*,GROUP_CONCAT(c.role_name) role_name')
		->join('LEFT JOIN __ADMIN_ROLE__ b ON a.id=b.admin_id 
		        LEFT JOIN __ROLE__ c ON b.role_id=c.id')
		->where($where)
		->group('a.id')
		->limit($page->firstRow.','.$page->listRows)
		->select();
		return $data;
	}
	// 添加前
	protected function _before_insert(&$data, $option)
	{
            $data['password'] = md5($data['password']);
	}
	// 修改前
	/*protected function _before_update(&$data, $option)
	{
            $roleId = I('post.role_id');
            $arModel = D('admin_role');
            $arModel -> where(array(
                'admin_id' => $option['where']['id'],
            ))->delete();
            foreach($roleId as $v)
            {
                $arModel -> add(array(
                        'admin_id' => $option['where']['id'],
                        'role_id'=> $v,
                        ));
            }
            if($data['password'])
            {
                $data['password'] = md5($data['password']);
            }
            else
                unset ($data['password']);
	}
	// 删除前
	protected function _before_delete($option)
	{
		if(is_array($option['where']['id']))
		{
			$this->error = '不支持批量删除';
			return FALSE;
		}
                if($option['where']['id'] == 1)
                {
                    $this -> error = "超级管理员无法删除！";
                    return FALSE;
                }
                //从中间表把这个权限相关的数据删除
                $arModel = D('admin_role');
                $arData = $rpModel -> where(array(
                    'admin_id' => array('eq',$option['where']['id']),
                ))->delete();
	}
         protected function _after_insert($data, $options) {
            $roleId = I('post.role_id');
            $arModel = D('admin_role');
            foreach($roleId as $v)
            {
                $arModel -> add(array(
                        'admin_id' => $data['id'],
                        'role_id'=> $v,
                        ));
            }
            
        }*/
        public function logout(){
            session(NULL);
        }
	/************************************ 其他方法 ********************************************/
}