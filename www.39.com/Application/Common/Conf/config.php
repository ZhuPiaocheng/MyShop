<?php
return array(
	//'配置项'=>'配置值'
     'DB_TYPE'              =>  'mysqli',        // 数据库类型
    'DB_HOST'               =>  'localhost',     // 服务器地址
    'DB_NAME'               =>  'php39',         // 数据库名
    'DB_USER'               =>  'root',          // 用户名
    'DB_PWD'                =>  '',              // 密码
    'DB_PORT'               =>  '3306',          // 端口
    'DB_PREFIX'             =>  'p39_',          // 数据库表前缀  
    'DB_DEBUG'  	    =>  TRUE,            // 数据库调试模式 开启后可以记录SQL日志
    'DB_FIELDS_CACHE'       =>  true,            // 启用字段缓存
    'DB_CHARSET'            =>  'utf8',          // 数据库编码默认采用utf8
    'DEFAULT_FILTER'        =>  'trim,htmlspecialchars', // 默认参数过滤方法 用于I函数...
    'SHOW_PAGE_TRACE'       => true,             //页面底部显示跟踪信息
    /*****************图片相关配置********************/
    'IMAGE_CONFIG' => array(
        'maxSize' => 1024 * 1024,
        'exts' => array('jpg', 'gif', 'png', 'jpeg'),
        'rootPath' => './Public/Uploads/',  //图片上传路径
        'viewPath' => __ROOT__.'/Public/Uploads/',   //图片显示路径
    ),
);