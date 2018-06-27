<?php
namespace Admin\Controller;
//use Think\Controller;
class GoodsController extends BaseController 
{
    public function goods_number1(){
        $id = I('get.id');
        $gaModel = D('goods_attr');
        $gaData = $gaModel->alias('a')
        ->field('a.*,b.attr_name')
        ->join('LEFT JOIN __ATTRIBUTE__ b ON a.attr_id = b.id')
        ->where(array(
            'goods_id' => array('eq',$id),
            'b.attr_type'=> array('eq','可选'),
        ))->select();
        $_gaData = array();
        foreach ($gaData as $k => $v)
        {
            $_gaData[$v['attr_name']][] = $v; 
        }
        $this ->assign(array(
            'gaData' => $_gaData,
        ));
        $this -> assign(array(
            '_page_title' => '库存量',
            '_page_btn_name' => '返回列表',
            '_page_btn_link' =>U('lst'),
        ));
        $this ->display();
        //var_dump($_gaData);
       //echo "test!";
    }
          
    /**
	 * 库存量页面
	 *
	 */
	public function goods_number()
	{
		// 接收商品ID
		$id = I('get.id');
		$gnModel = D('goods_number');
		
		// 处理表单
		if(IS_POST)
		{
			// 先删除原库存
			$gnModel->where(array(
				'goods_id' => array('eq', $id),
			))->delete();
			//var_dump($_POST);die;
			$gaid = I('post.goods_attr_id');
			$gn = I('post.goods_number');
			// 先计算商品属性ID和库存量的比例
			$gaidCount = count($gaid);
			$gnCount = count($gn);
			$rate = $gaidCount/$gnCount;
			// 循环库存量
			$_i = 0;  // 取第几个商品属性ID
			foreach ($gn as $k => $v)
			{
				$_goodsAttrId = array();  // 把下面取出来的ID放这里
				// 后来从商品属性ID数组中取出 $rate 个，循环一次取一个
				for($i=0; $i<$rate; $i++)
				{
					$_goodsAttrId[] = $gaid[$_i];
					$_i++;
				}
				// 先升序排列
				sort($_goodsAttrId, SORT_NUMERIC);  // 以数字的形式排序
				// 把取出来的商品属性ID转化成字符串
				$_goodsAttrId = (string)implode(',', $_goodsAttrId);
				$gnModel->add(array(
					'goods_id' => $id,
					'goods_attr_id' => $_goodsAttrId,
					'goods_number' => $v,
				));
			}
			$this->success('设置成功！', U('goods_number?id='.I('get.id')));
			exit;
		}
		
		// 根据商品ID取出这件商品所有可选属性的值
		$gaModel = D('goods_attr');
		$gaData = $gaModel->alias('a')
		->field('a.*,b.attr_name')
		->join('LEFT JOIN __ATTRIBUTE__ b ON a.attr_id=b.id')
		->where(array(
			'a.goods_id' => array('eq', $id),
			'b.attr_type' => array('eq', '可选'),
		))->select();
		// 处理这个二维数组：转化成三维：把属性相同的放到一起
		$_gaData = array();
		foreach ($gaData as $k => $v)
		{
			$_gaData[$v['attr_name']][] = $v;
		}
		
		// 先取出这件商品已经设置过的库存量
		$gnData = $gnModel->where(array(
			'goods_id' => $id,
		))->select();
		//var_dump($gnData);
		
		$this->assign(array(
			'gaData' => $_gaData,
			'gnData' => $gnData,
		));
		
		// 设置页面信息
		$this->assign(array(
			'_page_title' => '库存量',
			'_page_btn_name' => '返回列表',
			'_page_btn_link' => U('lst'),
		));
   		// 1.显示表单
   		$this->display();
	}

    // 处理删除属性
	public function ajaxDelAttr()
	{
		$goodsId = addslashes(I('get.goods_id'));
		$gaid = addslashes(I('get.gaid'));
		$gaModel = D('goods_attr');
		$gaModel->delete($gaid);
		// 删除相关库存量数据
		$gnModel = D('goods_number');
		$gnModel->where(array(
			'goods_id' => array('EXP' ,"=$goodsId or AND FIND_IN_SET($gaid, attr_list)"),
		))->delete();
	}
    // 处理获取属性的AJAX请求
	public function ajaxGetAttr()
	{
		$typeId = I('get.type_id');
		$attrModel = D('Attribute');
		$attrData = $attrModel->where(array(
			'type_id' => array('eq', $typeId),
		))->select();
		echo json_encode($attrData);
	}
    // 处理AJAX删除图片的请求
	public function ajaxDelPic()
	{
		$picId = I('get.picid');
		// 根据ID从硬盘上数据删除中删除图片
		$gpModel = D('goods_pic');
		$pic = $gpModel->field('pic,sm_pic,mid_pic,big_pic')->find($picId);
		// 从硬盘删除图片
		deleteImage($pic);
		// 从数据库中删除记录
		$gpModel->delete($picId);
	}
	// 显示和处理表单
	public function add()
        {
   		
        // 判断用户是否提交了表单
		if(IS_POST)
		{
                       
                    $pics = array();
                    foreach ($_FILES['pic']['name'] as $k => $v)
                    {
                        $pics[] = array(
                            'name' => $v,
                            'type' => $_FILES['pic']['type'][$k],
                            'tmp_name' => $_FILES['pic']['error'][$k],
                            'size' => $_FILES['pic']['size'][$k],
                        );
                    }
                    //var_dump($pics);
                    //var_dump($_FILES);
                    //var_dump($_POST);
                    //var_dump($_POST);
                    //die;
                    
			$model = D('goods');
			// 2. CREATE方法：a. 接收数据并保存到模型中 b.根据模型中定义的规则验证表单
			/**
			 * 第一个参数：要接收的数据默认是$_POST
			 * 第二个参数：表单的类型。当前是添加还是修改的表单,1：添加 2：修改
			 * $_POST：表单中原始的数据 ，I('post.')：过滤之后的$_POST的数据，过滤XSS攻击
			 */
			//添加数据create('data',1)
			if($model->create(I('post.'), 1))
			{
				// 插入到数据库中
				if($model->add())  // 在add()里又先调用了_before_insert方法
				{
					// 显示成功信息并等待1秒之后跳转
					$this->success('操作成功！', U('lst'));
					//exit;
				}
			}
			// 如果走到 这说明上面失败了在这里处理失败的请求
			// 从模型中取出失败的原因
			$error = $model->getError();
			// 由控制器显示错误信息,并在3秒跳回上一个页面
			$this->error($error);
		}
                //$brandModel = D('brand');
                //$brandData = $brandModel->select();
                $mlModel = D('member_level');
                $mlData = $mlModel -> select();
                //取出下拉框所有分类
                $catModel = D('category');
                $catData = $catModel->getTree();
                
                //设置页面信息
                $this ->assign(array(
                //    'brandData' => $brandData,
                    'catData' => $catData,
                    'mlData'=> $mlData,
                    '_page_title' => '添加新商品',
                    '_page_btn_name' => '商品列表',
                    '_page_btn_link' => U('lst'),
                ));
   		// 1.显示表单
   		$this->display();
	}
	
	// 商品列表页
	public function lst()
	{
            $model = D('goods');
            //返回数据和翻页
            $data = $model -> search();
            $this ->assign($data);
            //$brandModel = D('brand');
            //$brandData = $brandModel->select();
            //dump($brandData);
            //  取出下拉框所有分类
            $catModel = D('category');
            $catData = $catModel -> getTree();
            //设置页面信息
                $this ->assign(array(
                   // 'brandData' => $brandData,
                    'catData' => $catData,
                    '_page_title' => '商品列表',
                    '_page_btn_name' => '添加新商品',
                    '_page_btn_link' => U('add'),
                ));
            $this ->display();
	}
        //修改商品
        public function edit()
        {
            $id = I('get.id');
	    $model = D('goods');
            //dump($_POST);die;
            // 判断用户是否提交了表单                    
		if(IS_POST)
		{       //dump($_POST);die;
			if($model->create(I('post.'), 2))
			{
				// 修改到数据库中
				if(FALSE !== $model->save())  // 在save()里又先调用了_before_update方法,
				{
					// 显示成功信息并等待1秒之后跳转
					$this->success('操作成功！', U('lst'));
					exit;
				}
			}
			// 如果走到 这说明上面失败了在这里处理失败的请求
			// 从模型中取出失败的原因
			$error = $model->getError();
			// 由控制器显示错误信息,并在3秒跳回上一个页面
			$this->error($error);
		}
                $data = $model -> find($id);
                $this ->assign('data',$data);
                //设置页面信息
                //取出品牌表
                //$brandModel = D('brand');
                //$brandData = $brandModel ->select();
                
                //取出会员级别
                $mlModel = D('member_level');
                $mlData = $mlModel -> select();
                
                
                
                //取出这件商品设置好的会员价格
                $mpModel =  D('member_price');
                $mpData = $mpModel->where(array(
			'goods_id' => array('eq', $id),
		))->select();
               // var_dump($mpData);
              
		// 把这二维转一维：  level_id => price
		$_mpData = array();
		foreach ($mpData as $k => $v)
		{
			$_mpData[$v['level_id']] = $v['price'];
		}
                $gpModel = D('goods_pic');
                $gpData = $gpModel->field('id,mid_pic')->where(array(
                    'goods_id' => array('eq',$id),
                ))->select();
                //取出下拉框所有分类
                $catModel = D('category');
                $catData = $catModel->getTree();
                //取出扩展分类ID
                $gcModel = D('goods_cat');
                $gcData = $gcModel ->field('cat_id')->where(array(
                    'goods_id' => array('eq',$id),
                ))->select();
                
                //取出这件商品已经设置了的属性值
                /*$gaModel = D('goods_attr');
                $gaData -> $gaModel->alias('a')->field('a.*,b.attr_name,b.attr_type,b.attr_option_values')
                        
                        ->join('LEFT JOIN __ATTRIBUTE__ b ON a.attr_id=b.id')
                        ->where(array(
                                'a.goods_id' => array('eq',$id),
                                )) -> select();*/
                
                // 取出当前类型下所有的属性
		$attrModel = D('Attribute');
		$attrData = $attrModel->alias('a')
		->field('a.id attr_id,a.attr_name,a.attr_type,a.attr_option_values,b.attr_value,b.id')
		->join('LEFT JOIN __GOODS_ATTR__ b ON (a.id=b.attr_id AND b.goods_id='.$id.')')
		->where(array(
			'a.type_id' => array('eq', $data['type_id']),
		))->select();
                $this ->assign(array(
                    //'brandData' => $brandData,
                    'catData' =>$catData,
                    'mlData' => $mlData,
                    'mpData' => $_mpData,
                    'gpData' => $gpData,
                    'gcData' => $gcData,
                    'gaData' => $attrData,
                    '_page_title' => '修改商品',
                    '_page_btn_name' => '商品列表',
                    '_page_btn_link' => U('lst'),
                ));
   		// 1.显示表单
   		$this->display();
        }
        // 显示和处理表单
        //删除商品
        public function delete()
        {
            $model = D('goods');
            if(FALSE !== $model->delete(I('get.id')))
                $this ->success ('删除成功！',U('lst'));
            else
                $this -> error('删除失败！原因：'.$model->getError());
        }
        public function test()
        {
            $this ->display();
        }
        public function test1(){
            //echo "test1";
            $this->display();
        }
}