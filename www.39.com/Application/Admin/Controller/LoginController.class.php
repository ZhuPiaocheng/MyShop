<?php
namespace Admin\Controller;
use Think\Controller;
/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
class LoginController extends Controller{
    public function login()
    {
        $model = D('Admin');
        //接收表单并且验证表单
        if(IS_POST)
        {
            if($model -> validate($model->_login_validate)->create())
        {
            if($model->login())
            {
                $this ->success('登录成功！',U('Index/index'));
                exit;
            }
        }
        $this ->error($model->getError());
        //echo "login!";
        
        }
        $this ->display();
    }
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
    public function logout(){
        $model = D('Admin');
        $model -> logout();
        redirect('login');
    }
}
