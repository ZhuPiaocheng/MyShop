<?php
namespace Home\Model;
use Think\Model;
class CartModel extends Model
{
    //加入购物车时允许接收的字段
    protected $insertFields = 'goods_id,goods_attr_id,goods_number';
    //加入购物车时的表单验证
    protected $_validate = array(
        array('goods_id','require','必须选择商品',1),
        array('goods_number','chkGoodsNumber','库存量不足！',1,'callback'),
    );
    //检查库存量
    public function chkGoodsNumber($goodsNumber)
    {
        //选择的商品属性id
        $gaid = I('post.goods_attr_id');
        sort($gaid,SORT_NUMERIC);
        $gaid = (String)implode(',', $gaid);
        //取出库存量
        $gnModel = D('goods_number');
        $gn = $gnModel->field('goods_number')->where(array(
            'goods_id' => I('post.goods_id'),
            'goods_attr_id' => $gaid,
        ))->find();
        //返回库存量是否够
        return($gn['goods_number'] >= $goodsNumber);
    }
    //重写父类的ADD方法：判断如果没有登录是存COOKIE，否则存数据库
    public function add()
    {
        $memberId = session('m_id');
        //先把商品属性ID升序并转化为字符串
        sort($this->goods_attr_id,SORT_NUMERIC);
        $this -> goods_attr_id = (String)implode(',', $this->goods_attr_id);
        //判断有没有登录
        if($memberId)
        {
            $goodsNumber = $this->goods_number;//先把表单中的库存量存到这个变量中，否则调用find之后就没有了
            //从数据库中取出数据，并存到模型中【覆盖原数据】
            $has = $this->field('id')->where(array(
                'member_id' =>$memberId,
                'goods_id' => $this->goods_id,
                'goods_attr_id' => $this->goods_attr_id,
            ))->find();
            //如果购物车中已经有这个商品就在原数量上加上这次购买的数量
            if($has)
            {
                $this ->where(array(
                    'id' => array('eq',$has['id']),
                ))->setInc('goods_number',$goodsNumber);
            }
            else
                parent::add(array(
                    'member_id' => $memberId,
                    'goods_id' => $this->goods_id,
                    'goods_attr_id' => $this->goods_attr_id,
                    'goods_number' => $this->goods_number,
                ));
        }
        else
        {
            //从COOKIE中取出购物车的一维数组
            $cart = isset($_COOKIE['cart'])? unserialize($_COOKIE['cart']):array();
            //先拼一个下标
            $key = $this->goods_id.'-'.$this->goods_attr_id;
            if(isset($cart['key']))
                $cart['$key'] += $this->goods_number;
            else
                //把商品加进去
                $cart[$key] = $this->goods_number;
            //把一维数组存回到COOKIE
            setcookie('cart',  serialize($cart),  time()+30*86400,'/');
        }
    }
}