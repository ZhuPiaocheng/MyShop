<?php
namespace Home\Controller;
use Think\Controller;
class SearchController extends NavController{

    // 分类搜索
    public function cat_search2()
    {
    	$catId = I('get.cat_id');
    	
    	// 取出商品和翻页
    	$goodsModel = D('Admin/Goods');
    	$data = $goodsModel->cat_search($catId);
    	//var_dump($data);
    	// 根据上面搜索出来的商品计算筛选条件
    	$catModel = D('Admin/Category');
    	$searchFilter = $catModel->getSearchConditionByGoodsId($data['goods_id']);
    	
    	// 设置页面信息
    	$this->assign(array(
    		'page' => $data['page'],
    		'data' => $data['data'],
    		'searchFilter' => $searchFilter,
    		'_page_title' => '分类搜索页',
    		'_page_keywords' => '分类搜索页',
    		'_page_description' => '分类搜索页',
    	));
    	$this->display();
    }
    //分类搜索
    public function cat_search(){
        $catId = I('get.cat_id');
        // 取出商品和翻页
        $goodsModel = D('Admin/Goods');
        $data = $goodsModel->cat_search($catId);
        if(!$data){
            $this -> error('没有商品',U('Index/index'),1);
        }
        //取出筛选条件
        $catModel = D('Admin/Category');
        $searchFilter = $catModel -> getSearchConditionByCatId($catId);
        //取出商品和翻页
        //$catModel = D('Admin/Goods');
        //$data = $goodsModel->cat_search($catId);
        //設置頁面信息
        $this ->assign(array(
            'page' => $data['page'],
            'data' => $data['data'],
            'searchFilter' => $searchFilter,
            '_page_title' => '分类搜索页',
    	    '_page_keywords' => '分类搜索页',
    	    '_page_description' => '分类搜索页',
        ));
        //var_dump($searchFilter);
        //echo "cat_search!";
        $this ->display();
    }
}
