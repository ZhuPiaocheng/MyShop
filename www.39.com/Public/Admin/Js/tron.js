/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
$(".tron").mouseover(function(){
    //修改这个tr里面的td背景颜色
    $(this).find("td").css('backgroundColor','#DEE7F5'); 
    });
 $(".tron").mouseout(function(){
        $(this).find("td").css('backgroundColor','#fff');
    });
