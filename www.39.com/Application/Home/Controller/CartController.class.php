<?php
namespace Home\Controller;
use Think\Controller;
class CartController extends Controller{
    public function add()
    {
        if(IS_POST)
        {
            header('Content-Type:text/html;charset=utf-8;');
            //var_dump($_POST);
            $cartModel = D('Cart');
            if($cartModel->create(I('post.'),1))
            {
                if($cartModel->add())
                {
                    $this-> success('添加成功！',U('lst'));
                    exit;
                }
            }
            $this ->error('添加失败，原因：'.$cartModel->getError());
        }
    }
    /*********获取购物车中的商品详细信息**************/
    public function lst()
    {
        //echo "lst";
        $cartModel = D('Cart');
        $data = $cartModel->cartList();
        $this ->assign(array(
            'data'=>$data,
            '_page_title' => '购物车列表',
            '_page_keywords' => '购物车列表',
            '_page_description' => '购物车列表',
        ));
        //var_dump($data);
        $this ->display();
    }
    public function ajaxCartList()
	{
		$cartModel = D('Cart');
		$data = $cartModel->cartList();
		echo json_encode($data);
	}
    
}
