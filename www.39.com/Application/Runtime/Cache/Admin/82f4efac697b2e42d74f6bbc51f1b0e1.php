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
    
    
 
<div class="main-div">
    <form name="main_form" method="POST" action="/www.39.com/index.php/Admin/Admin/add.html" enctype="multipart/form-data">
        <table cellspacing="1" cellpadding="3" width="100%">
            <tr>
                <td class="label">角色列表：</td>
                    <td>
                    <?php foreach($roleData as $k => $v):?>
                       <input   type="checkbox" name="role_id[]" value="<?php echo $v['id'];?>" />
                       <?php echo $v['role_name'];?>
                    <?php endforeach;?>
                </td>
            </tr>
            <tr>
                <td class="label">用户名：</td>
                <td>
                    <input  type="text" name="username" value="" />
                </td>
            </tr>
            <tr>
                <td class="label">密码：</td>
                <td>
                    <input type="password" size="25" name="password" />
                </td>
            </tr>
            <tr>
                <td class="label">确认密码：</td>
                <td>
                    <input type="password" size="25" name="cpassword" />
                </td>
            </tr>
            <tr>
                <td colspan="99" align="center">
                    <input type="submit" class="button" value=" 确定 " />
                    <input type="reset" class="button" value=" 重置 " />
                </td>
            </tr>
        </table>
    </form>
</div>


<script>
</script>
    
    
    <div id="footer">
共执行 9 个查询，用时 0.025161 秒，Gzip 已禁用，内存占用 3.258 MB<br />
版权所有 &copy; 2005-2012 上海商派网络科技有限公司，并保留所有权利。</div>
</body>
</html>