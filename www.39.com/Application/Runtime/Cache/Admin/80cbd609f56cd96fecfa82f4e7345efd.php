<?php if (!defined('THINK_PATH')) exit();?><!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->

<html>
    <head>
        <script type="text/javascript" src="/www.39.com/Public/umeditor1_2_2-utf8-php/third-party/jquery.min.js"></script>
        <title>TODO supply a title</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body>
        <script>
function addNewTr(btn)
{
    //alert("aaa");
    var tr = $(btn).parent().parent();
    if($(btn).val()=="+")
    {
       var newTr = tr.clone();
       newTr.find(":button").val("-");
       $("#submit").before(newTr);
    }
    else
       tr.remove();
}

function test(){ 
alert("aaa");
var sourceNode = document.getElementById("cat_list"); // 获得被克隆的节点对象
var clonedNode = sourceNode.cloneNode(true); // 克隆节点 
//clonedNode.setAttribute("id", "div-0"); // 修改一下id 值，避免id 重复 
sourceNode.parentNode.appendChild(clonedNode); // 在父节点插入克隆的节点 
} 
</script>
        <ul>
	      <li id="cat_list">add</li> 
                <li>ccc</li>              
	 </ul>
        <input type = "button" onclick="test()" value="+"/>
        <input type="button" onclick="addNewTr();" value="test" >
        
        <table width = 200 border = 1 >
            <tr id="TR" align="center">
                <td>a</td>
                <td>b<input onclick="addNewTr(this);" type="button" value="+"/></td>
            </tr>
            <tr id="submit">
                <td colspan="2" align="center"><input  type="submit" value="submit" ></td>
            </tr>
	</table>
    </body>
</html>
<script>
function addNewTr(btn)
{
    //alert("aaa");
    var tr = $(btn).parent().parent();
    if($btn).val()=="+")
    {
       var newTr = tr.clone();
       newTr.find(":button").val("-");
       $("#submit").before(newTr);
    }
    else
       tr.remove();
}

function test(){ 
alert("aaa");
var sourceNode = document.getElementById("cat_list"); // 获得被克隆的节点对象
var clonedNode = sourceNode.cloneNode(true); // 克隆节点 
//clonedNode.setAttribute("id", "div-0"); // 修改一下id 值，避免id 重复 
sourceNode.parentNode.appendChild(clonedNode); // 在父节点插入克隆的节点 
} 
</script>
<script type="text/javascript" src="/www.39.com/Public/Admin/Js/tron.js"></script>