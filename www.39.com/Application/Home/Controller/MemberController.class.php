<?php
namespace Home\Controller;
use Think\Controller;
class MemberController extends Controller{
    public function ajaxChkLogin(){
		if(session('m_id'))
			echo json_encode(array(
				'login' => 1,
				'username' => session('m_username'),
			));
		else 
			echo json_encode(array(
				'login' => 0,
			));
        }
    //制作验证码
     public function chkcode()
    {
        $Verify = new \Think\Verify(array(
            'fontSize'  =>  20,              // 验证码字体大小(px)
            'imageW'    =>  145,               // 验证码图片宽度
            'length'    =>  4,               // 验证码位数
            'useNoise'  =>  TRUE,            // 是否添加杂点
        ));
        $Verify ->entry();
    }
    public function login(){
        if(IS_POST)
        {
            $model = D('Admin/Member');
            if($model->validate($model->_login_validate)->create())
            {
                if($model->login())
                {
                    //默认地址
                    $returnUrl = 'http://localhost/www.39.com/index.php/Home/';
                    $ru = session('returnUrl');
                    if($ru)
                    {
                        session('returnUrl',null);
                        $returnUrl = $ru;
                    }
                    $this->success('登录成功！',$returnUrl);
                    exit;
                }
            }
            $this->error($model->getError());
        }
        //设置页面信息
        $this->assign(array(
            '_page_title'=> '登录',
            '_page_keywords'=> '登录',
            '_page_description'=> '登录',
        ));
        //echo "login";
        $this -> display();
    }
    public function regist(){
        if(IS_POST){
            $model = D('Admin/Member');
            if($model->create(I('post.'),1))
            {
                if($model->add())
                {
                    $this ->success('注册成功！',U('login'));
                    exit;
                }
            }
            $this ->error($model->getError());
        }
        //设置页面信息
        $this ->assign(array(
             '_page_title'=> '注册',
            '_page_keywords'=> '注册',
            '_page_description'=> '注册',
        ));
        //echo "logout!";
        $this->display();
    }
    public function logout()
    {
    	$model = D('Admin/Member');
    	$model->logout();
    	redirect('http://localhost/www.39.com/index.php/');
    }
}
