<?php
namespace Admin\Model;
use Think\Model;
/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
class GoodsModel extends Model{
    //定义验证规则
    protected $insertFields = 'goods_name,market_price,shop_price,is_on_sale,goods_desc';
    protected $_validate = array(
        array('goods_name','require','商品名称不能为空！',1),
        array('market_price','currency','市场价格必须是货币类型！',1),
        array('shop_price','currency','本店价格必须是货币类型'),
    );
    //这个方法再添加之前会被自动调用--》钩子方法
    //第一个参数：表单中即将要插入到数据库中的数据-》数组
    //&按引用传递：函数内部要修改函数外部传进来的变量必须按引用传递，除非传递的是一个对象，因为对象默认是按引用来传递的
    protected function _before_insert(&$data, $option) {
        //处理LOGO
        //判断有没有选择图片
        if($_POST['logo']['error'] == 0){
            $upload = new \Think\Upload();// 实例化上传类    
            $upload ->maxSize   =     1024*1024 ;// 设置附件上传大小  1M  
            $upload ->exts      =     array('jpg', 'gif', 'png', 'jpeg');// 设置附件上传类型    
            $upload ->rootPath  =      './Public/Uploads/'; // 设置附件上传目录   
            $upload ->savePath = 'Goods';  //设置附件上传（子）目录
           // 上传文件     
            $info   =   $upload->upload();    
            if(!$info) {
              // 上传错误提示错误信息        
              $this->error($upload->getError());
              return FALSE;
            }else{
                  /*********************生成缩略图****************************/
                  //先拼成原图的路径
                  $logo = $info['logo']['savepath'].$info['logo'].['savename'];
                  //拼出要生成缩略图的图片
                  $mbiglogo = $info['logo']['savepath'].'mbig_'.$info['logo']['savename'];
                  $biglogo = $info['logo']['savepath'].'big_'.$info['logo']['savename'];
                  $midlogo = $info['logo']['savepath'].'mid_'.$info['logo']['savename'];
                  $smlogo = $info['logo']['savepath'].'sm_'.$info['logo']['savename'];
                  //打开要生成缩略图的图片
                  $image = new \Think\Image(); 
                  $image->open('/.Public/Uploads'.$logo);
                  //生成缩略图
                  $image->thumb(700,700 )->save('./Public/Goods/'.$mbiglogo);
                  $image->thumb(350, 350)->save('./Public/Goods/'.$biglogo);
                  $image->thumb(130,130 )->save('./Public/Goods/'.$midlogo);
                  $image->thumb(50,50 )->save('./Public/Goods/'.$smlogo);
                  /********************把路径放到数据表中*****************/
                  $data['logo'] = $logo;
                  $data['mbiglogo'] = $mbiglogo;
                  $data['biglogo'] = $biglogo;
                  $data['midlogo'] = $midlogo;
                  $data['smlogo'] = $smlogo;
                  
              } 
        }
        
  
        //获取当前时间并添加到表单中这样就会插入到数据据中
        $data['addtime'] = date('Y-m-d H:i:s',time());
        $data['goods_desc'] = removeXSS($_POST['goods_desc']);
    }
}
