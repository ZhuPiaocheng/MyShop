<?php if (!defined('THINK_PATH')) exit();?><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>管理中心 - 商品列表 </title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="/www.39.com/Public/Admin/Styles/general.css" rel="stylesheet" type="text/css" />
<link href="/www.39.com/Public/Admin/Styles/main.css" rel="stylesheet" type="text/css" />
</head>
<body>
<h1>
    <if($_page_btn_name); >
    <span class="action-span"><a href="<?php echo $_page_btn_link;?>"><?php echo $_page_btn_name;?></a>
    </span><endif/>
    <span class="action-span1"><a href="__GROUP__">管理中心</a></span>
    <span id="search_id" class="action-span1"> - <?php echo $_page_title;?> </span>
    <div style="clear:both"></div>
</h1>
    
    
 
<style>
#ul_pic_list li{margin:5px;list-style-type:none;}
#old_pic_list li{float:left;width:150px;height:150px;margin:5px;list-style-type:none;}
</style>
    <div id="tabbody-div">
        <form action="/www.39.com/index.php/Admin/Category/edit/id/2.html" method="post" enctype="multipart/form-data">
            <input type = "hidden" name = "id" value="<?php echo I('get.id');?>"/>
            <table width="90%"  class="tab_table" align="center">
                <tr>
                    <td class="label">上级分类：</td>
                    <td>
                    <select name="parent_id">
                    	<option value="0">顶级分类</option>
                    	<?php foreach ($catData as $k => $v): if($v['id'] == $data['id'] || in_array($v['id'], $children)) continue ; if($v['id'] == $data['parent_id']) $select = 'selected="selected"'; else $select = ''; ?>
                    	<option <?php echo $select; ?> value="<?php echo $v['id']; ?>"><?php echo str_repeat('-', 8*$v['level']) . $v['cat_name']; ?></option>
                    	<?php endforeach; ?>
                    </select>
                </td>
                </tr>
                <tr>
                    <td class="label">商品分类：</td>
                    <td>
                        <input type = "text" name = 'cat_name' value = "<?php echo $data['cat_name']?>"/>
                    </td>
                </tr>
                <tr>
                    <td class="label">是否推荐楼层：</td>
                    <td>
                        <input type="radio" name="is_floor" value="是" <?php if($data['is_floor'] == '是') echo 'checked="checked"'; ?> /> 是
                        <input type="radio" name="is_floor" value="否" <?php if($data['is_floor'] == '否') echo 'checked="checked"'; ?>/> 否
                    </td>
                </tr>
            </table>
           
            <div class="button-div">
                <input type="submit" value=" 确定 " class="button"/>
                <input type="reset" value=" 重置 " class="button" />
            </div>
        </form>
    </div>

    
    
    <div id="footer">
共执行 9 个查询，用时 0.025161 秒，Gzip 已禁用，内存占用 3.258 MB<br />
版权所有 &copy; 2005-2012 上海商派网络科技有限公司，并保留所有权利。</div>
</body>
</html>