<?php
namespace Admin\Model;
use Think\Model;
class GoodsModel extends Model 
{
	// 添加时调用create方法允许接收的字段
	protected $insertFields = 'goods_name,market_price,shop_price,is_on_sale,goods_desc,brand_id,cat_id,type_id,promote_price,promote_start_date,promote_end_date,is_new,is_best,is_hot,sort_num,is_floor';
	// 修改时调用create方法允许接收的字段
	protected $updateFields = 'id,goods_name,market_price,shop_price,is_on_sale,goods_desc,brand_id,cat_id,type_id,promote_price,promote_start_date,promote_end_date,is_new,is_best,is_hot,sort_num,is_floor';
	//定义验证规则
	protected $_validate = array(
            array('cat_id', 'require', '必须选择分类！', 1),
	    array('goods_name', 'require', '商品名称不能为空！', 1),
	    array('market_price', 'currency', '市场价格必须是货币类型！', 1),
	    array('shop_price', 'currency', '本店价格必须是货币类型！', 1),
	);
	
	// 这个方法在添加之前会自动被调用 --》 钩子方法
	// 第一个参数：表单中即将要插入到数据库中的数据->数组
	// &按引用传递：函数内部要修改函数外部传进来的变量必须按钮引用传递，除非传递的是一个对象,因为对象默认是按引用传递的
	protected function _before_insert(&$data, $option)
	{
            
            
                /*****************处理扩展分类****************
                $ecid = I('post.ext_cat_id');
                if($ecid)
                {
                    $gcModel = D('goods_cat');
                    foreach ($ecid as $k => $v)
                    {
                        if(empty($v))
                            continue;
                        $gcModel->add(array(
                            'cat_id' => $v,
                            'goods_id' => $data['id'],
                        ));
                    }
                }*/
		/**************** 处理LOGO *******************/
		// 判断有没有选择图片
		if($_FILES['logo']['error'] == 0)
		{
                    $ret = uploadOne('logo','Goods',array(//表单图片名字，保存图片的二级目录
                        array(700,700),
                        array(350,350),
                        array(130,130),
                        array(50,50),
                    ));
                    $data['logo'] = $ret['images'][0];
                    $data['mbig_logo'] = $ret['images'][1];
                    $data['big_logo'] = $ret['images'][2];
                    $data['mid_logo'] = $ret['images'][3];
                    $data['sm_logo'] = $ret['images'][4];
                    
                    
		    /*$upload = new \Think\Upload();// 实例化上传类
		    $upload->maxSize = 1024 * 1024 ; // 1M
		    $upload->exts = array('jpg', 'gif', 'png', 'jpeg');// 设置附件上传类型
		    $upload->rootPath = './Public/Uploads/'; // 设置附件上传根目录
		    $upload->savePath = 'Goods/'; // 设置附件上传（子）目录
		    // 上传文件 
		    $info   =   $upload->upload();
		    if(!$info)
		    {
		    	// 获取失败原因把错误信息保存到 模型的error属性中，然后在控制器里会调用$model->getError()获取到错误信息并由控制器打印
		    	$this->error = $upload->getError();
		        return FALSE;
		    }
		    else
		    {*/
		    	/**************** 生成缩略图 *****************/
		    	// 先拼成原图上的路径
		    	/*$logo = $info['logo']['savepath'] . $info['logo']['savename'];
		    	// 拼出缩略图的路径和名称
		    	$mbiglogo = $info['logo']['savepath'] .'mbig_'. $info['logo']['savename'];
		    	$biglogo = $info['logo']['savepath'] .'big_'. $info['logo']['savename'];
		    	$midlogo = $info['logo']['savepath'] .'mid_'. $info['logo']['savename'];
		    	$smlogo = $info['logo']['savepath'] .'sm_'. $info['logo']['savename'];
		    	$image = new \Think\Image(); 
		    	// 打开要生成缩略图的图片
		    	$image->open('./Public/Uploads/'.$logo);
		    	// 生成缩略图
		    	$image->thumb(700, 700)->save('./Public/Uploads/'.$mbiglogo);
		    	$image->thumb(350, 350)->save('./Public/Uploads/'.$biglogo);
		    	$image->thumb(130, 130)->save('./Public/Uploads/'.$midlogo);
		    	$image->thumb(50, 50)->save('./Public/Uploads/'.$smlogo);*/
		    	/**************** 把路径放到表单中 *****************/
		    	/*$data['logo'] = $logo;
		    	$data['mbig_logo'] = $mbiglogo;
		    	$data['big_logo'] = $biglogo;
		    	$data['mid_logo'] = $midlogo;
		    	$data['sm_logo'] = $smlogo;
		    }*/
		}
		// 获取当前时间并添加到表单中这样就会插入到数据库中
		$data['addtime'] = date('Y-m-d H:i:s', time());
		// 我们自己来过滤这个字段
		$data['goods_desc'] = removeXSS($_POST['goods_desc']);
	}
        /**
	 * 取出一个分类下所有商品的ID[即考虑主分类也考虑了扩展分类】
	 *
	 * @param unknown_type $catId
	 */
	public function getGoodsIdByCatId($catId)
	{
		// 先取出所有子分类的ID
		$catModel = D('Admin/Category');
		$children = $catModel->getChildren($catId);
		// 和子分类放一起
		$children[] = $catId;
		/*************** 取出主分类或者扩展分类在这些分类中的商品 ****************/
		// 取出主分类下的商品ID
		$gids = $this->field('id')->where(array(
			'cat_id' => array('in', $children),
		))->select();
		// 取出扩展分类下的商品的ID
		$gcModel = D('goods_cat');
		$gids1 = $gcModel->field('DISTINCT goods_id id')->where(array(
			'cat_id' => array('IN', $children)
		))->select();
		// 把主分类的ID和扩展分类下的商品ID合并成一个二维数组【两个都不为空时合并，否则取出不为空的数组】
		if($gids && $gids1)
			$gids = array_merge($gids, $gids1);
		elseif ($gids1)
			$gids = $gids1;
		// 二维转一维并去重
		$id = array();
		foreach ($gids as $k => $v)
		{
			if(!in_array($v['id'], $id))
				$id[] = $v['id'];
		}
		return $id;
	}
        public function search($perPage = 5){
            /************搜索***************/
            $where = array();//空的where条件
            /*************** 搜索 ******************/
            //商品名称
            $gn = I('get.gn');
                $where['goods_name'] = array('like',"%$gn%");//WHERE goods_name LIKE "%gn%"
            //价格
            $fp = I('get.fp');
            $tp = I('get.tp');
            //判断
            if($fp && $tp)
                $where['shop_price'] = array('between',array($fp,$tp));//WHERE shop_price BETWEEN $fp AND $tp
            elseif($fp)
                $where['shop_price'] = array('egt',$fp);//WHERE shop_price => $fp
            elseif($tp)
                $where['shop_price'] = array('elt',$tp);//WHERE shop_price< = $tp
            //是否上架
            $ios = I('get.ios');
            if($ios)
                $where['is_on_sale'] = array('eq',$ios);//WHERE is_on_sale = $ios
            //添加时间
            $fa = I('get.fa');
            $ta = I('get.ta');
            if($fa && $ta)
                $where['addtime'] = array('between',array($fa,$ta));//WHERE addtime BETWEEN $fa AND $ta
            elseif($fa)
                $where['addtime'] = array('egt',$fa);//WHERE addtime => $fa
            elseif($ta)
                $where['addtime'] = array('elt',$ta);//WHERE addtime< = $ta
             // 品牌
	    $brandId = I('get.brand_id');
	        if($brandId)
		$where['brand_id'] = array('eq', $brandId);
             //主分类的搜索
                $catId = I('get.cat_id');
                if($catId)
                {
                    //先取出所有子分类的ID
                    /*$catModel = D('category');
                    $children = $catModel -> getChildren($catId);
                    //和子分类放一起
                    $children[] = $catId;
                    $where['a.cat_id'] = array('IN',$children);*/
                    // 先查询出这个分类ID下所有的商品ID
	            $gids = $this->getGoodsIdByCatId($catId);
	            var_dump($gids);
	            exit;
		    // 应用到取数据的WHERE上
		    $where['a.id'] = array('in', $gids);
                }
            /************翻页***************/
            //取出总的记录条数
            $count = $this -> where($where)-> count();
            //生成翻页类的对象
            $pageObj = new \Think\Page($count,$perPage);
            //设置样式
            $pageObj ->setConfig('next', '下一页');
            $pageObj ->setConfig('prev', '上一页');
            //生成页面下面显示 上一页和下一页的字符串
            $pageString = $pageObj -> show();
            /***************** 排序 *****************/
		$orderby = 'id';      // 默认的排序字段 
		$orderway = 'desc';   // 默认的排序方式
		$odby = I('get.odby');
		if($odby)
		{
			if($odby == 'id_asc')
				$orderway = 'asc';
			elseif ($odby == 'price_desc')
				$orderby = 'shop_price';
			elseif ($odby == 'price_asc')
			{
				$orderby = 'shop_price';
				$orderway = 'asc';
			}
		}
            /************** 取某一页的数据 ***************/
                $data = $this->order("$orderby $orderway")                    // 排序
		->field('a.*,b.brand_name,c.cat_name,GROUP_CONCAT(e.cat_name SEPARATOR "<br />") ext_cat_name')
		->alias('a')
		->join('LEFT JOIN __BRAND__ b ON a.brand_id=b.id      
		        LEFT JOIN __CATEGORY__ c ON a.cat_id=c.id
		        LEFT JOIN __GOODS_CAT__ d ON a.id=d.goods_id 
		        LEFT JOIN __CATEGORY__ e ON d.cat_id=e.id')
		->where($where)                                               // 搜索
		->limit($pageObj->firstRow.','.$pageObj->listRows)            // 翻页
		->group('a.id')
		->select();
                
		/*$data = $this->order("$orderby $orderway")                    // 排序
                ->field('a.*,b.brand_name,c.cat_name,GROUP_CONCAT(e.cat_name) ext_cat_name')
		->alias('a')
		->join('LEFT JOIN __BRAND__ b ON a.brand_id=b.id  
                        LEFT JOIN __CATEGORY__ c ON a.cat_id = c.id 
                        LEFT JOIN __GOODS_CAT__ d ON a.id = d.goods_id 
                        LEFT JOIN __CATEGORY__ e ON d.cat_id = e.id')
		->where($where)                                               // 搜索
		->limit($pageObj->firstRow.','.$pageObj->listRows)            // 翻页
                ->group('a.id')
		->select();*/
            
            /*************返回数据**************/
            return array(
                'data' => $data,  //翻页字符串
                'page' => $pageString,
            );
        }
       
        protected function _before_update(&$data, $option)
	{
                $id = $option['where']['id'];   //要修改的商品的ID
                /*************修改商品属性****************/
                $gaid = I('post.goods_attr_id');
                $attrValue = I('post.attr_value');
                $gaModel = D('goods_attr');
                $_i = 0;
                foreach($attrValue as $k => $v)
                {
                    foreach($v as $k1 => $v1)
                    {
                        if($gaid[$_i] == '')
                            $gaModel -> add(array(
                               'goods_id' => $id,
                                'attr_id' => $k,
                                'attr_value' => $v1,
                            ));
                        else
                            $gaModel -> where(array(
                                'id' => array('eq',$gaid[$_i]),
                            ))->setField ('attr_value',$v1);
                        
                        $_i++;
                    }
                }
                
                
                
                /************ 处理扩展分类 ***************/
		$ecid = I('post.ext_cat_id');
		$gcModel = D('goods_cat');
		// 先删除原分类数据
		$gcModel->where(array(
			'goods_id' => array('eq', $id),
		))->delete();
		if($ecid)
		{
			foreach ($ecid as $k => $v)
			{
				if(empty($v))
					continue ;
				$gcModel->add(array(
					'cat_id' => $v,
					'goods_id' => $id,
				));
			}
		}
                /************ 处理相册图片 *****************/
		if(isset($_FILES['pic']))
		{
			$pics = array();
			foreach ($_FILES['pic']['name'] as $k => $v)
			{
				$pics[] = array(
					'name' => $v,
					'type' => $_FILES['pic']['type'][$k],
					'tmp_name' => $_FILES['pic']['tmp_name'][$k],
					'error' => $_FILES['pic']['error'][$k],
					'size' => $_FILES['pic']['size'][$k],
				);
			}
			$_FILES = $pics;  // 把处理好的数组赋给$_FILES，因为uploadOne函数是到$_FILES中找图片
			$gpModel = D('goods_pic');
			// 循环每个上传
			foreach ($pics as $k => $v)
			{
				if($v['error'] == 0)
				{
					$ret = uploadOne($k, 'Goods', array(
						array(650, 650),
						array(350, 350),
						array(50, 50),
					));
					if($ret['ok'] == 1)
					{
						$gpModel->add(array(
							'pic' => $ret['images'][0],
							'big_pic' => $ret['images'][1],
							'mid_pic' => $ret['images'][2],
							'sm_pic' => $ret['images'][3],
							'goods_id' => $id,
						));
					}
				}
			}
		}
                /*****************处理会员价格*****************/
                $mp = I('post.member_price');
                $mpModel = D('member_price');
                //先删除原来的会员价格
                $mpModel ->where(array(
                    'goods_id' => array('eq',$id),
                )) ->delete();
                foreach($mp as $k => $v)
                {
                    $_v = (float)$v;
                    //如果设置了会员价格就插入到表中
                    if($_v > 0)
                    {
                        $mpModel->add(array(
                            'price' => $_v,
                            'level_id' => $k,
                            'goods_id' => $id,
                        ));
                    }
                }
		/**************** 处理LOGO *******************/
		// 判断有没有选择图片
		if($_FILES['logo']['error'] == 0)
		{
		    $upload = new \Think\Upload();// 实例化上传类
		    $upload->maxSize = 1024 * 1024 ; // 1M
		    $upload->exts = array('jpg', 'gif', 'png', 'jpeg');// 设置附件上传类型
		    $upload->rootPath = './Public/Uploads/'; // 设置附件上传根目录
		    $upload->savePath = 'Goods/'; // 设置附件上传（子）目录
		    // 上传文件 
		    $info   =   $upload->upload();
		    if(!$info)
		    {
		    	// 获取失败原因把错误信息保存到 模型的error属性中，然后在控制器里会调用$model->getError()获取到错误信息并由控制器打印
		    	$this->error = $upload->getError();
		        return FALSE;
		    }
		    else
		    {
		    	/**************** 生成缩略图 *****************/
		    	// 先拼成原图上的路径
		    	$logo = $info['logo']['savepath'] . $info['logo']['savename'];
		    	// 拼出缩略图的路径和名称
		    	$mbiglogo = $info['logo']['savepath'] .'mbig_'. $info['logo']['savename'];
		    	$biglogo = $info['logo']['savepath'] .'big_'. $info['logo']['savename'];
		    	$midlogo = $info['logo']['savepath'] .'mid_'. $info['logo']['savename'];
		    	$smlogo = $info['logo']['savepath'] .'sm_'. $info['logo']['savename'];
		    	$image = new \Think\Image(); 
		    	// 打开要生成缩略图的图片
		    	$image->open('./Public/Uploads/'.$logo);
		    	// 生成缩略图
		    	$image->thumb(700, 700)->save('./Public/Uploads/'.$mbiglogo);
		    	$image->thumb(350, 350)->save('./Public/Uploads/'.$biglogo);
		    	$image->thumb(130, 130)->save('./Public/Uploads/'.$midlogo);
		    	$image->thumb(50, 50)->save('./Public/Uploads/'.$smlogo);
		    	/**************** 把路径放到表单中 *****************/
		    	$data['logo'] = $logo;
		    	$data['mbig_logo'] = $mbiglogo;
		    	$data['big_logo'] = $biglogo;
		    	$data['mid_logo'] = $midlogo;
		    	$data['sm_logo'] = $smlogo;
                        
                        
                        /********************删除原来的图片***********************/
                        //先查出原来的图片路径
                        $logoLogo = $this -> field('logo,mbig_logo,big_logo,mid_logo,sm_logo') -> find($id);
                        //从硬盘上删除
                        unlink('./Public/Uploads/'.$oldLogo['logo']);
                        unlink('./Public/Uploads/'.$oldLogo['mbig_logo']);
                        unlink('./Public/Uploads/'.$oldLogo['big_logo']);
                        unlink('./Public/Uploads/'.$oldLogo['mid_logo']);
                        unlink('./Public/Uploads/'.$oldLogo['sm_logo']);
		    }
		}
                
		// 我们自己来过滤这个字段
		$data['goods_desc'] = removeXSS($_POST['goods_desc']);
	}
        protected function _before_delete($options) {
            $id = $options['where']['id'];  //要修改商品的id
            /*********** 删除商品库存量 ***************/
		$gnModel = D('goods_number');
		$gnModel->where(array(
			'goods_id' => array('eq', $id),
		))->delete();
            /*********************删除商品属性***********************/
            $gcModel = D('goods_attr');
            $gcModel ->where(array(
                'goods_id' => array('eq',$id),
            ))->delete();
            /*********************删除扩展分类***********************/
            $gcModel = D('goods_cat');
            $gcModel ->where(array(
                'goods_id' => array('eq',$id),
            ))->delete();
            /*********************删除相册中的图片*******************/
            //先从相册表中取出相册所在硬盘的路径
            $gpModel = D('goods_pic');
            $pics = $gpModel->field('pic,sm_pic,mid_pic,big_pic')->where(array(
                'goods_id' => array('eq',$id),
            ))->select();
            //循环每个图片从硬盘上删除图片
            foreach($pics as $k => $v)
                deleteImage ($v); //删除pic,sm_pic.mid_pic,big_pic四张图片
           /**********************删除原来的图片*********************/
           //先查出原来的图片路径
                    $oldLogo = $this -> field('logo,mbig_logo,big_logo,mid_logo,sm_logo') -> find($id);
                    //从硬盘上删除
                    /*unlink('./Public/Uploads/'.$oldLogo['logo']);
                    unlink('./Public/Uploads/'.$oldLogo['mbig_logo']);
                    unlink('./Public/Uploads/'.$oldLogo['big_logo']);
                    unlink('./Public/Uploads/'.$oldLogo['mid_logo']);
                    unlink('./Public/Uploads/'.$oldLogo['sm_logo']);*/
                    deleteImage($oldLogo);
                    /***********删除会员价格***********/
                    $mpModel = D("member_price");
                    $mpModel ->where(array(
                        'goods_id' => array('eq',$id),
                    ))->delete();
                    }
           
         protected function _after_insert($data, $options) {
             $attrValue = I('post.attr_value');
             $gaModel = D('goods_attr');
             foreach ($attrValue as $k => $v)
             {
                 //把属性值的数组去重
                 $v = array_unique($v);
                 foreach ($v as $k1 => $v1)
                 {
                     $gaModel -> add(array(
                         'goods_id' => $data['id'],
                         'attr_id' => $k,
                         'attr_value' => $v1,
                     ));
                 }
             }
             $ecid = I('post.ext_cat_id');
		if($ecid)
		{
			$gcModel = D('goods_cat');
			foreach ($ecid as $k => $v)
			{
				if(empty($v))
					continue ;
				$gcModel->add(array(
					'cat_id' => $v,
					'goods_id' => $data['id'],
				));
			}
		}
            /************ 处理相册图片 *****************/
		if(isset($_FILES['pic']))
		{
			$pics = array();
			foreach ($_FILES['pic']['name'] as $k => $v)
			{
				$pics[] = array(
					'name' => $v,
					'type' => $_FILES['pic']['type'][$k],
					'tmp_name' => $_FILES['pic']['tmp_name'][$k],
					'error' => $_FILES['pic']['error'][$k],
					'size' => $_FILES['pic']['size'][$k],
				);
			}
			$_FILES = $pics;  // 把处理好的数组赋给$_FILES，因为uploadOne函数是到$_FILES中找图片
			$gpModel = D('goods_pic');
			// 循环每个上传
			foreach ($pics as $k => $v)
			{
				if($v['error'] == 0)
				{
					$ret = uploadOne($k, 'Goods', array(
						array(650, 650),
						array(350, 350),
						array(50, 50),
					));
					if($ret['ok'] == 1)
					{
						$gpModel->add(array(
							'pic' => $ret['images'][0],
							'big_pic' => $ret['images'][1],
							'mid_pic' => $ret['images'][2],
							'sm_pic' => $ret['images'][3],
							'goods_id' => $data['id'],
						));
					}
				}
			}
		}
             
             
                        $mp = I('post.member_price');
                        $mpModel = D('member_price');
                        foreach ($mp as $k => $v)
		        {
			   $_v = (float)$v;
			   // 如果设置了会员价格就插入到表中
			   if($_v > 0)
			   {
				$mpModel->add(array(
					'price' => $_v,
					'level_id' => $k,
					'goods_id' => $data['id'],
				));
			   }
		       }
                }
        /*
         * 取出当前正在促销的商品
         */
                public function getPromoteGoods($limit=5){
                    $today = date('Y-m-d H:i');
		return $this->field('id,goods_name,mid_logo,promote_price')
		->where(array(
			'is_on_sale' => array('eq', '是'),
			'promote_price' => array('gt', 0),
			'promote_start_date' => array('elt', $today),
			'promote_end_date' => array('egt', $today),
		))
		->limit($limit)
                ->order('sort_num ASC')
                ->select();
                }
                /*
                 * 取出三种推荐框的数据
                 */
                public function getRecGoods($recType,$limit = 5){
                    return $this->field('id,goods_name,mid_logo,shop_price')
		->where(array(
			'is_on_sale' => array('eq', '是'),
			"$recType" => array('eq', '是'),
		))
		->limit($limit)
                ->order('sort_num ASC')           
                ->select();
                }
                /************获取会员价格**************/
                public function getMemberPrice($goodsId)
                {
                    $today = date('Y-m-d H:i');
                    $levelId = session('level_id');
                    //取出商品的促销价格
                    $promotePrice = $this ->field('promote_price')->where(array(
                        'id' =>array('eq',$goodsId),
                       'promote_price' => array('gt',0),
                        'promote_start_date' => array('elt',$today),
                        'promote_end_date' =>array('egt',$today),
                    ))->find();
                    //判断会员有没有登录
                    if($levelId)
                    {
                        $mpModel = D('member_price');
                        $mpData = $mpModel->field('price') -> where(array(
                            'goods_id' =>array('eq',$goodsId),
                            'level_id' =>array('eq',$levelId),
                        ))->find();
                        //这个级别有没有设置会员
                        if($mpData['price'])
                        {
                            if($promotePrice['promote_price'])
                                return min($promotePrice['promote_price'],$mpData['price']);
                            else
                                return $mpData['price'];
                        }
                        else
                        {
                            //如果没有设置这个级别的价格就直接返回本店价格
                            $p = $this ->field('shop_price') ->find($goodsId);
                            if($promotePrice['promote_price'])
                                return min($promotePrice['promote_price'],$p['shop_price']);
                                else
                                    return $p['shop_price'];
                        } 
                    }
                    else
                    {
                        $p = $this->field('shop_price')->find($goodsId);
                        if($promotePrice['promote_price'])
                            return min($promotePrice['promote_price'],$p['shop_price']);
                        else
                            return $p['shop_price'];
                    }
                }
/**
	 * 获取某个分类下某一页的商品
	 *
	 * @param unknown_type $catId
	 * @param unknown_type $perPage
	 */
	public function cat_search($catId, $pageSize = 60)
	{
		/*************** 搜索 *************************/
		// 根据分类ID搜索出这个分类下商品的ID
		$goodsId = $this->getGoodsIdByCatId($catId);
		//var_dump($goods_id);
		if($goodsId == null){
			return FALSE;
		}
		$where['a.id'] = array('in', $goodsId);
		// 品牌
		$brandId = I('get.brand_id');
		if($brandId)
			$where['a.brand_id'] = array('eq', (int)$brandId);
		// 价格
		$price = I('get.price');
		if($price)
		{
			$price = explode('-', $price);
			$where['a.shop_price'] = array('between', $price);
		}
		
		/******************************************* 商品搜索开始 ************************************************/
		$gaModel = D('goods_attr');
		$attrGoodsId = NULL;  // 根据每个属性搜索出来的商品的ID
		// 根据属性搜索 : 循环所有的参数找出属性的参数进行查询
		foreach ($_GET as $k => $v)
		{
			// 如果变量是以attr_开头的说明是一个属性的查询, 格式：attr_1/黑色-颜色
			if(strpos($k, 'attr_') === 0)
			{
				// 先解析出属性ID和属性值
				$attrId = str_replace('attr_', '', $k); // 属性id
				// 先取出最后一个-往后的字符串
				$attrName = strrchr($v, '-');
				$attrValue = str_replace($attrName, '', $v);
				// 根据属性ID和属性值搜索出这个属性值下的商品id：并返回一个字符串格式：1,2,3,4,5,6,7
				$gids = $gaModel->field('GROUP_CONCAT(goods_id) gids')->where(array(
					'attr_id' => array('eq', $attrId),
					'attr_value' => array('eq', $attrValue),
				))->find();
				// var_dump($gids);
				// exit;
				// 判断是有商品
				if($gids['gids'])
				{
					$gids['gids'] = explode(',', $gids['gids']);
					// 说明是搜索的第一个属性
					if($attrGoodsId === NULL)
						$attrGoodsId = $gids['gids'];  // 先暂存起来
					else 
					{
						// 和上一个属性搜索出来的结果求集
						$attrGoodsId = array_intersect($attrGoodsId, $gids['gids']);
						// 如果已经没有商品满足条件就不用再考虑下一个属性了
						if(empty($attrGoodsId))
						{
							$where['a.id'] = array('eq', 0);
							break;
						}
					}
				}
				else 
				{
					// 前几次的交集结果清空
					$attrGoodsId = array();
					// 如果这个属性下没有商品就应该向where中添加一个不可能满足的条件，这样后面取商品时就取不出来了！
					$where['a.id'] = array('eq', 0);
					// 取出循环，不用再查询下一个属性了
					break;
				}
			}
		}
		// 判断如果循环求次之后这个数组还不为空说明这些就是满足所有条件的商品id
		if($attrGoodsId)
			$where['a.id'] = array('IN', $attrGoodsId);
		/******************************************* 商品搜索结束 ************************************************/	
			
		
		
		/**************** 翻页 *********************/
		// 取出总的记录数，以及所有的商品ID的字符串
		//$count = $this->alias('a')->where($where)->count();  // 这个只能取总记录数，改成下面这行，即取总记录数，又取出了商品ID
		$count = $this->alias('a')->field('COUNT(a.id) goods_count,GROUP_CONCAT(a.id) goods_id')->where($where)->find();
		// 把商品ID返回
		$data['goods_id'] = explode(',', $count['goods_id']);
		
		$page = new \Think\Page($count['goods_count'], $pageSize);
		// 配置翻页的样式
		$page->setConfig('prev', '上一页');
		$page->setConfig('next', '下一页');
		$data['page'] = $page->show();
		
		/*********************** 排序 ********************/
		$oderby = 'xl';    // 默认
		$oderway = 'desc'; // 默认
		$odby = I('get.odby');
		if($odby)
		{
			if($odby == 'addtime')
				$oderby = 'a.addtime';
			if(strpos($odby, 'price_') === 0)
			{
				$oderby = 'a.shop_price';
				if($odby == 'price_asc')
					$oderway = 'asc';
			}
		}
		
		/**************** 取数据 ********************/
		$data['data'] = $this->alias('a')
		->field('a.id,a.goods_name,a.mid_logo,a.shop_price,SUM(b.goods_number) xl')
		->join('LEFT JOIN __ORDER_GOODS__ b 
				 ON (a.id=b.goods_id 
				      AND 
				     b.order_id IN(SELECT id FROM __ORDER__ WHERE pay_status="是"))')
		->where($where)
		->group('a.id')
		->limit($page->firstRow.','.$page->listRows)
		->order("$oderby $oderway")
		->select();
		
		return $data;
	}
	
	/**
	 * 获取某个关键字下某一页的商品
	 *
	 * @param unknown_type $key
	 * @param unknown_type $perPage
	 */
	public function key_search($key, $pageSize = 60)
	{
		/*************** 搜索 *************************/
		
		//$goodsId = $this->getGoodsIdByCatId($catId);
		
		// 根据关键字【商品名称、商品描述、商品属性值】取出商品ID
		$goodsId = $this->alias('a')
		->field('GROUP_CONCAT(DISTINCT a.id) gids')
		->join('LEFT JOIN __GOODS_ATTR__ b ON a.id=b.goods_id')
		->where(array(
			'a.is_on_sale' => array('eq', '是'),
			'a.goods_name' => array('exp', " LIKE '%$key%' OR a.goods_desc LIKE '%$key%' OR attr_value LIKE '%$key%'"),
		))
		->find();
		$goodsId = explode(',', $goodsId['gids']);
		
		$where['a.id'] = array('in', $goodsId);
		// 品牌
		$brandId = I('get.brand_id');
		if($brandId)
			$where['a.brand_id'] = array('eq', (int)$brandId);
		// 价格
		$price = I('get.price');
		if($price)
		{
			$price = explode('-', $price);
			$where['a.shop_price'] = array('between', $price);
		}
		
		/******************************************* 商品搜索开始 ************************************************/
		$gaModel = D('goods_attr');
		$attrGoodsId = NULL;  // 根据每个属性搜索出来的商品的ID
		// 根据属性搜索 : 循环所有的参数找出属性的参数进行查询
		foreach ($_GET as $k => $v)
		{
			// 如果变量是以attr_开头的说明是一个属性的查询, 格式：attr_1/黑色-颜色
			if(strpos($k, 'attr_') === 0)
			{
				// 先解析出属性ID和属性值
				$attrId = str_replace('attr_', '', $k); // 属性id
				// 先取出最后一个-往后的字符串
				$attrName = strrchr($v, '-');
				$attrValue = str_replace($attrName, '', $v);
				// 根据属性ID和属性值搜索出这个属性值下的商品id：并返回一个字符串格式：1,2,3,4,5,6,7
				$gids = $gaModel->field('GROUP_CONCAT(goods_id) gids')->where(array(
					'attr_id' => array('eq', $attrId),
					'attr_value' => array('eq', $attrValue),
				))->find();
				// 判断是有商品
				if($gids['gids'])
				{
					$gids['gids'] = explode(',', $gids['gids']);
					// 说明是搜索的第一个属性
					if($attrGoodsId === NULL)
						$attrGoodsId = $gids['gids'];  // 先暂存起来
					else 
					{
						// 和上一个属性搜索出来的结果求集
						$attrGoodsId = array_intersect($attrGoodsId, $gids['gids']);
						// 如果已经没有商品满足条件就不用再考虑下一个属性了
						if(empty($attrGoodsId))
						{
							$where['a.id'] = array('eq', 0);
							break;
						}
					}
				}
				else 
				{
					// 前几次的交集结果清空
					$attrGoodsId = array();
					// 如果这个属性下没有商品就应该向where中添加一个不可能满足的条件，这样后面取商品时就取不出来了！
					$where['a.id'] = array('eq', 0);
					// 取出循环，不用再查询下一个属性了
					break;
				}
			}
		}
		// 判断如果循环求次之后这个数组还不为空说明这些就是满足所有条件的商品id
		if($attrGoodsId)
			$where['a.id'] = array('IN', $attrGoodsId);
		/******************************************* 商品搜索结束 ************************************************/	
			
		
		
		/**************** 翻页 *********************/
		// 取出总的记录数，以及所有的商品ID的字符串
		//$count = $this->alias('a')->where($where)->count();  // 这个只能取总记录数，改成下面这行，即取总记录数，又取出了商品ID
		$count = $this->alias('a')->field('COUNT(a.id) goods_count,GROUP_CONCAT(a.id) goods_id')->where($where)->find();
		// 把商品ID返回
		$data['goods_id'] = explode(',', $count['goods_id']);
		
		$page = new \Think\Page($count['goods_count'], $pageSize);
		// 配置翻页的样式
		$page->setConfig('prev', '上一页');
		$page->setConfig('next', '下一页');
		$data['page'] = $page->show();
		
		/*********************** 排序 ********************/
		$oderby = 'xl';    // 默认
		$oderway = 'desc'; // 默认
		$odby = I('get.odby');
		if($odby)
		{
			if($odby == 'addtime')
				$oderby = 'a.addtime';
			if(strpos($odby, 'price_') === 0)
			{
				$oderby = 'a.shop_price';
				if($odby == 'price_asc')
					$oderway = 'asc';
			}
		}
		
		/**************** 取数据 ********************/
		$data['data'] = $this->alias('a')
		->field('a.id,a.goods_name,a.mid_logo,a.shop_price,SUM(b.goods_number) xl')
		->join('LEFT JOIN __ORDER_GOODS__ b 
				 ON (a.id=b.goods_id 
				      AND 
				     b.order_id IN(SELECT id FROM __ORDER__ WHERE pay_status="是"))')
		->where($where)
		->group('a.id')
		->limit($page->firstRow.','.$page->listRows)
		->order("$oderby $oderway")
		->select();
		
		return $data;
	}
}












