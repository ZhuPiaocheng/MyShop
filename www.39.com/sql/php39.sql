-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: 2018-04-12 04:42:48
-- 服务器版本： 5.6.17
-- PHP Version: 5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `php39`
--

-- --------------------------------------------------------

--
-- 表的结构 `p39_admin`
--

CREATE TABLE IF NOT EXISTS `p39_admin` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `username` varchar(30) NOT NULL COMMENT '用户名',
  `password` char(32) NOT NULL COMMENT '密码',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='管理员' AUTO_INCREMENT=5 ;

--
-- 转存表中的数据 `p39_admin`
--

INSERT INTO `p39_admin` (`id`, `username`, `password`) VALUES
(1, 'root', '21232f297a57a5a743894a0e4a801fc3'),
(3, 'admin', '21232f297a57a5a743894a0e4a801fc3'),
(4, '测试', 'e10adc3949ba59abbe56e057f20f883e');

-- --------------------------------------------------------

--
-- 表的结构 `p39_admin_role`
--

CREATE TABLE IF NOT EXISTS `p39_admin_role` (
  `admin_id` mediumint(8) unsigned NOT NULL COMMENT '管理员id',
  `role_id` mediumint(8) unsigned NOT NULL COMMENT '角色id',
  KEY `admin_id` (`admin_id`),
  KEY `role_id` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='管理员角色';

--
-- 转存表中的数据 `p39_admin_role`
--

INSERT INTO `p39_admin_role` (`admin_id`, `role_id`) VALUES
(4, 1),
(4, 2),
(3, 1);

-- --------------------------------------------------------

--
-- 表的结构 `p39_attribute`
--

CREATE TABLE IF NOT EXISTS `p39_attribute` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `attr_name` varchar(30) NOT NULL COMMENT '属性名称',
  `attr_type` enum('唯一','可选') NOT NULL COMMENT '属性类型',
  `attr_option_values` varchar(300) NOT NULL DEFAULT '' COMMENT '属性可选值',
  `type_id` mediumint(8) unsigned NOT NULL COMMENT '所属类型Id',
  PRIMARY KEY (`id`),
  KEY `type_id` (`type_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='属性表' AUTO_INCREMENT=13 ;

--
-- 转存表中的数据 `p39_attribute`
--

INSERT INTO `p39_attribute` (`id`, `attr_name`, `attr_type`, `attr_option_values`, `type_id`) VALUES
(11, '颜色', '可选', '红色,白色,黑色', 4),
(12, '添加时间', '唯一', '2018', 4);

-- --------------------------------------------------------

--
-- 表的结构 `p39_brand`
--

CREATE TABLE IF NOT EXISTS `p39_brand` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `brand_name` varchar(30) NOT NULL COMMENT '品牌名称',
  `site_url` varchar(150) NOT NULL DEFAULT '' COMMENT '官方网址',
  `logo` varchar(150) NOT NULL DEFAULT '' COMMENT '品牌Logo图片',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='品牌' AUTO_INCREMENT=7 ;

--
-- 转存表中的数据 `p39_brand`
--

INSERT INTO `p39_brand` (`id`, `brand_name`, `site_url`, `logo`) VALUES
(1, 'huawei', 'wwww.huawei.com', 'Brand/2017-11-09/5a044d56bbbe8.jpg'),
(2, 'iphone', 'www.iphone.com', 'Brand/2017-11-16/5a0d5298323af.png'),
(3, '小米', 'www.xiaomi.com', 'Brand/2017-11-16/5a0d52b73f094.png'),
(4, 'VIVO', 'www.vivo.com', 'Brand/2017-11-16/5a0d52d289931.png'),
(5, '黑莓', 'www.heimei.com', 'Brand/2017-11-20/5a129899aadf1.png'),
(6, '魅族', 'www.meizu.com', 'Brand/2017-11-20/5a1298bdcef46.png');

-- --------------------------------------------------------

--
-- 表的结构 `p39_cart`
--

CREATE TABLE IF NOT EXISTS `p39_cart` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `goods_id` mediumint(8) unsigned NOT NULL COMMENT '商品Id',
  `goods_attr_id` varchar(150) NOT NULL DEFAULT '' COMMENT '商品属性Id',
  `goods_number` mediumint(8) unsigned NOT NULL COMMENT '购买的数量',
  `member_id` mediumint(8) unsigned NOT NULL COMMENT '会员Id',
  PRIMARY KEY (`id`),
  KEY `member_id` (`member_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='购物车' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `p39_category`
--

CREATE TABLE IF NOT EXISTS `p39_category` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `cat_name` varchar(30) NOT NULL COMMENT '分类名称',
  `parent_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '上级分类的Id,0:顶级分类',
  `is_floor` enum('是','否') NOT NULL DEFAULT '否',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='是否推荐楼层' AUTO_INCREMENT=25 ;

--
-- 转存表中的数据 `p39_category`
--

INSERT INTO `p39_category` (`id`, `cat_name`, `parent_id`, `is_floor`) VALUES
(1, '家用电器', 0, '是'),
(2, '手机、数码、京东通信', 0, '否'),
(3, '电脑、办公', 0, '否'),
(4, '家居、家具、家装、厨具', 0, '否'),
(5, '男装、女装、内衣、珠宝', 0, '否'),
(6, '个护化妆', 0, '否'),
(8, '运动户外', 0, '否'),
(9, '汽车、汽车用品', 0, '否'),
(10, '母婴、玩具乐器', 0, '否'),
(11, '食品、酒类、生鲜、特产', 0, '否'),
(12, '营养保健', 0, '否'),
(13, '图书、音像、电子书', 0, '否'),
(14, '彩票、旅行、充值、票务', 0, '否'),
(16, '大家电', 1, '是'),
(17, '生活电器', 1, '是'),
(18, '厨房电器', 1, '否'),
(19, '个护健康', 1, '是'),
(20, '五金家装', 1, '否'),
(21, 'iphone', 2, '是'),
(22, '冰箱', 16, '否'),
(23, '冰箱1', 22, '否'),
(24, '冰箱2', 23, '否');

-- --------------------------------------------------------

--
-- 表的结构 `p39_comment`
--

CREATE TABLE IF NOT EXISTS `p39_comment` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `goods_id` mediumint(8) unsigned NOT NULL COMMENT '商品Id',
  `member_id` mediumint(8) unsigned NOT NULL COMMENT '会员Id',
  `content` varchar(200) NOT NULL COMMENT '内容',
  `addtime` datetime NOT NULL COMMENT '发表时间',
  `star` tinyint(3) unsigned NOT NULL COMMENT '分值',
  `click_count` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '有用的数字',
  PRIMARY KEY (`id`),
  KEY `goods_id` (`goods_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='评论' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `p39_comment_reply`
--

CREATE TABLE IF NOT EXISTS `p39_comment_reply` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `comment_id` mediumint(8) unsigned NOT NULL COMMENT '评论Id',
  `member_id` mediumint(8) unsigned NOT NULL COMMENT '会员Id',
  `content` varchar(200) NOT NULL COMMENT '内容',
  `addtime` datetime NOT NULL COMMENT '发表时间',
  PRIMARY KEY (`id`),
  KEY `comment_id` (`comment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='评论回复' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `p39_goods`
--

CREATE TABLE IF NOT EXISTS `p39_goods` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `goods_name` varchar(150) NOT NULL COMMENT '商品名称',
  `market_price` decimal(10,2) NOT NULL COMMENT '市场价格',
  `shop_price` decimal(10,2) NOT NULL COMMENT '本店价格',
  `goods_desc` longtext COMMENT '商品描述',
  `is_on_sale` enum('是','否') NOT NULL DEFAULT '是' COMMENT '是否上架',
  `is_delete` enum('是','否') NOT NULL DEFAULT '否' COMMENT '是否放到回收站',
  `addtime` datetime NOT NULL COMMENT '添加时间',
  `logo` varchar(150) NOT NULL DEFAULT '' COMMENT '原图',
  `sm_logo` varchar(150) NOT NULL DEFAULT '' COMMENT '小图',
  `mid_logo` varchar(150) NOT NULL DEFAULT '' COMMENT '中图',
  `big_logo` varchar(150) NOT NULL DEFAULT '' COMMENT '大图',
  `mbig_logo` varchar(150) NOT NULL DEFAULT '' COMMENT '更大图',
  `brand_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '品牌id',
  `cat_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '主分类Id',
  `type_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '类型Id',
  `promote_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '促销价格',
  `promote_start_date` datetime NOT NULL COMMENT '促销开始时间',
  `promote_end_date` datetime NOT NULL COMMENT '促销结束时间',
  `is_new` enum('是','否') NOT NULL DEFAULT '否' COMMENT '是否新品',
  `is_hot` enum('是','否') NOT NULL DEFAULT '否' COMMENT '是否热卖',
  `is_best` enum('是','否') NOT NULL DEFAULT '否' COMMENT '是否精品',
  `sort_num` tinyint(3) unsigned NOT NULL DEFAULT '100' COMMENT '排序的数字',
  `is_floor` enum('是','否') NOT NULL DEFAULT '否',
  PRIMARY KEY (`id`),
  KEY `shop_price` (`shop_price`),
  KEY `addtime` (`addtime`),
  KEY `is_on_sale` (`is_on_sale`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='是否推荐楼层' AUTO_INCREMENT=37 ;

--
-- 转存表中的数据 `p39_goods`
--

INSERT INTO `p39_goods` (`id`, `goods_name`, `market_price`, `shop_price`, `goods_desc`, `is_on_sale`, `is_delete`, `addtime`, `logo`, `sm_logo`, `mid_logo`, `big_logo`, `mbig_logo`, `brand_id`, `cat_id`, `type_id`, `promote_price`, `promote_start_date`, `promote_end_date`, `is_new`, `is_hot`, `is_best`, `sort_num`, `is_floor`) VALUES
(1, 'goods1', '20.00', '15.00', 'goods1', '是', '否', '0000-00-00 00:00:00', '', '', '', '', '', 0, 0, 0, '0.00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '否', '否', '否', 100, '否'),
(2, 'goods2', '36.00', '32.25', 'goods2', '是', '否', '2017-11-02 20:24:29', '', '', '', '', '', 0, 0, 0, '0.00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '否', '否', '否', 100, '否'),
(3, 'goods3', '35.00', '33.50', '&lt;p&gt;&amp;lt;script&amp;gt; alert(&amp;quot;hi！&amp;quot;);&amp;lt;/script&amp;gt;&lt;br/&gt;&lt;/p&gt;', '是', '否', '2017-11-03 16:48:23', '', '', '', '', '', 0, 0, 0, '0.00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '否', '否', '否', 100, '否'),
(5, 'goods4', '50.00', '48.90', '', '是', '否', '2017-11-03 17:06:12', 'Goods/2017-11-09/5a0443289156c.jpg', 'Goods/2017-11-09/sm_5a0443289156c.jpg', 'Goods/2017-11-09/mid_5a0443289156c.jpg', 'Goods/2017-11-09/big_5a0443289156c.jpg', 'Goods/2017-11-09/mbig_5a0443289156c.jpg', 0, 0, 0, '0.00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '否', '否', '否', 100, '否'),
(9, '魅族', '1455.00', '1439.00', '', '是', '否', '2017-11-03 19:29:34', 'Goods/2017-11-08/5a02e52434f82.jpg', 'Goods/2017-11-08/sm_5a02e52434f82.jpg', 'Goods/2017-11-08/mid_5a02e52434f82.jpg', 'Goods/2017-11-08/big_5a02e52434f82.jpg', 'Goods/2017-11-08/mbig_5a02e52434f82.jpg', 0, 0, 0, '0.00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '否', '否', '否', 100, '否'),
(10, 'adsa', '0.00', '0.00', '', '是', '否', '2017-11-03 21:22:04', 'Goods/2017-11-08/5a02e53e0fdd8.jpg', 'Goods/2017-11-08/sm_5a02e53e0fdd8.jpg', 'Goods/2017-11-08/mid_5a02e53e0fdd8.jpg', 'Goods/2017-11-08/big_5a02e53e0fdd8.jpg', 'Goods/2017-11-08/mbig_5a02e53e0fdd8.jpg', 0, 0, 0, '0.00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '否', '否', '否', 100, '否'),
(11, 'goods6', '0.00', '0.00', '', '是', '否', '2017-11-05 15:33:32', 'Goods/2017-11-05/59febecc40a85.jpg', 'Goods/2017-11-05/sm_59febecc40a85.jpg', 'Goods/2017-11-05/mid_59febecc40a85.jpg', 'Goods/2017-11-05/big_59febecc40a85.jpg', 'Goods/2017-11-05/mbig_59febecc40a85.jpg', 0, 0, 0, '0.00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '否', '否', '否', 100, '否'),
(12, 'iphone', '4699.00', '4599.00', '', '是', '否', '2017-11-06 17:07:48', 'Goods/2017-11-06/5a002664b2147.jpg', 'Goods/2017-11-06/sm_5a002664b2147.jpg', 'Goods/2017-11-06/mid_5a002664b2147.jpg', 'Goods/2017-11-06/big_5a002664b2147.jpg', 'Goods/2017-11-06/mbig_5a002664b2147.jpg', 2, 0, 0, '0.00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '否', '否', '否', 100, '否'),
(13, '小米5', '1999.00', '1899.00', '', '是', '否', '2017-11-06 17:08:29', 'Goods/2017-11-06/5a00268d9ccbe.jpg', 'Goods/2017-11-06/sm_5a00268d9ccbe.jpg', 'Goods/2017-11-06/mid_5a00268d9ccbe.jpg', 'Goods/2017-11-06/big_5a00268d9ccbe.jpg', 'Goods/2017-11-06/mbig_5a00268d9ccbe.jpg', 3, 0, 0, '0.00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '否', '否', '否', 100, '否'),
(14, '联想', '1569.00', '1325.00', '', '是', '否', '2017-11-06 17:09:06', 'Goods/2017-11-06/5a0026b240466.jpg', 'Goods/2017-11-06/sm_5a0026b240466.jpg', 'Goods/2017-11-06/mid_5a0026b240466.jpg', 'Goods/2017-11-06/big_5a0026b240466.jpg', 'Goods/2017-11-06/mbig_5a0026b240466.jpg', 0, 0, 0, '0.00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '否', '否', '否', 100, '否'),
(15, '黑莓', '1000.00', '879.00', '', '是', '否', '2017-11-06 17:10:25', 'Goods/2017-11-06/5a0027016df90.jpg', 'Goods/2017-11-06/sm_5a0027016df90.jpg', 'Goods/2017-11-06/mid_5a0027016df90.jpg', 'Goods/2017-11-06/big_5a0027016df90.jpg', 'Goods/2017-11-06/mbig_5a0027016df90.jpg', 1, 0, 0, '0.00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '否', '否', '否', 100, '否'),
(16, '华为p8', '1550.00', '1489.00', '', '是', '否', '2017-11-06 17:10:49', 'Goods/2017-11-06/5a0027194ac74.jpg', 'Goods/2017-11-06/sm_5a0027194ac74.jpg', 'Goods/2017-11-06/mid_5a0027194ac74.jpg', 'Goods/2017-11-06/big_5a0027194ac74.jpg', 'Goods/2017-11-06/mbig_5a0027194ac74.jpg', 1, 0, 0, '0.00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '否', '否', '否', 100, '否'),
(17, '华为P10', '2999.00', '2899.00', '', '是', '否', '2017-11-16 17:11:45', 'Goods/2017-11-16/5a0d56511ac3f.jpg', 'Goods/2017-11-16/thumb_3_5a0d56511ac3f.jpg', 'Goods/2017-11-16/thumb_2_5a0d56511ac3f.jpg', 'Goods/2017-11-16/thumb_1_5a0d56511ac3f.jpg', 'Goods/2017-11-16/thumb_0_5a0d56511ac3f.jpg', 1, 0, 0, '0.00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '否', '否', '否', 100, '否'),
(21, '小米Note', '1999.00', '1899.00', '', '是', '否', '2017-11-18 17:16:48', 'Goods/2017-11-18/5a0ffa80944fa.png', 'Goods/2017-11-18/thumb_3_5a0ffa80944fa.png', 'Goods/2017-11-18/thumb_2_5a0ffa80944fa.png', 'Goods/2017-11-18/thumb_1_5a0ffa80944fa.png', 'Goods/2017-11-18/thumb_0_5a0ffa80944fa.png', 3, 0, 0, '0.00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '否', '否', '否', 100, '否'),
(23, 'VIVO R10', '1000.00', '999.00', '', '是', '否', '2017-11-19 18:59:52', 'Goods/2017-11-20/5a1298212231b.png', 'Goods/2017-11-20/sm_5a1298212231b.png', 'Goods/2017-11-20/mid_5a1298212231b.png', 'Goods/2017-11-20/big_5a1298212231b.png', 'Goods/2017-11-20/mbig_5a1298212231b.png', 4, 0, 0, '0.00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '否', '否', '否', 100, '否'),
(24, 'HUAWEI G9 Plus', '1000.00', '999.00', '', '是', '否', '2017-11-19 19:00:38', 'Goods/2017-11-20/5a1297de50f85.jpg', 'Goods/2017-11-20/sm_5a1297de50f85.jpg', 'Goods/2017-11-20/mid_5a1297de50f85.jpg', 'Goods/2017-11-20/big_5a1297de50f85.jpg', 'Goods/2017-11-20/mbig_5a1297de50f85.jpg', 1, 0, 0, '0.00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '否', '否', '否', 100, '否'),
(25, '000', '0.00', '0.00', '', '是', '否', '2017-11-20 19:36:10', 'Goods/2017-11-20/5a12be2a6c4a0.jpg', 'Goods/2017-11-20/thumb_3_5a12be2a6c4a0.jpg', 'Goods/2017-11-20/thumb_2_5a12be2a6c4a0.jpg', 'Goods/2017-11-20/thumb_1_5a12be2a6c4a0.jpg', 'Goods/2017-11-20/thumb_0_5a12be2a6c4a0.jpg', 1, 17, 0, '0.00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '否', '否', '否', 100, '否'),
(26, 'X', '0.00', '0.00', '', '是', '否', '2017-11-20 19:58:45', 'Goods/2017-11-20/5a12c3758147b.png', 'Goods/2017-11-20/thumb_3_5a12c3758147b.png', 'Goods/2017-11-20/thumb_2_5a12c3758147b.png', 'Goods/2017-11-20/thumb_1_5a12c3758147b.png', 'Goods/2017-11-20/thumb_0_5a12c3758147b.png', 2, 24, 0, '0.00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '否', '否', '否', 100, '否'),
(27, '00', '0.00', '0.00', '', '是', '否', '2017-11-20 20:02:10', '', '', '', '', '', 1, 23, 0, '0.00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '否', '否', '否', 100, '否'),
(28, '海尔', '0.00', '0.00', '', '是', '否', '2017-11-23 21:51:18', '', '', '', '', '', 0, 16, 0, '0.00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '否', '否', '否', 100, '否'),
(29, '格力空调001', '999.00', '998.00', '', '是', '否', '2017-11-25 20:26:48', 'Goods/2018-02-12/5a8133e12e12e.png', 'Goods/2018-02-12/sm_5a8133e12e12e.png', 'Goods/2018-02-12/mid_5a8133e12e12e.png', 'Goods/2018-02-12/big_5a8133e12e12e.png', 'Goods/2018-02-12/mbig_5a8133e12e12e.png', 1, 16, 1, '969.00', '2018-03-14 21:53:00', '2018-03-14 21:53:00', '否', '否', '否', 100, '是'),
(30, '属性测试', '0.00', '0.00', '', '是', '否', '2017-12-06 16:12:08', 'Goods/2018-02-12/5a8133d6bc15a.png', 'Goods/2018-02-12/sm_5a8133d6bc15a.png', 'Goods/2018-02-12/mid_5a8133d6bc15a.png', 'Goods/2018-02-12/big_5a8133d6bc15a.png', 'Goods/2018-02-12/mbig_5a8133d6bc15a.png', 1, 20, 1, '0.00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '是', '是', '是', 120, '是'),
(31, '属性测试', '0.00', '0.00', '', '是', '否', '2017-12-06 16:14:05', 'Goods/2018-02-12/5a8133ccd0da7.png', 'Goods/2018-02-12/sm_5a8133ccd0da7.png', 'Goods/2018-02-12/mid_5a8133ccd0da7.png', 'Goods/2018-02-12/big_5a8133ccd0da7.png', 'Goods/2018-02-12/mbig_5a8133ccd0da7.png', 1, 1, 1, '0.00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '否', '是', '否', 140, '否'),
(32, '属性测试', '0.00', '0.00', '', '是', '否', '2017-12-06 16:14:42', 'Goods/2018-02-12/5a8133c1c63b3.png', 'Goods/2018-02-12/sm_5a8133c1c63b3.png', 'Goods/2018-02-12/mid_5a8133c1c63b3.png', 'Goods/2018-02-12/big_5a8133c1c63b3.png', 'Goods/2018-02-12/mbig_5a8133c1c63b3.png', 1, 1, 2, '0.00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '是', '是', '否', 100, '否'),
(33, '属性测试', '0.00', '0.00', '', '是', '否', '2017-12-06 16:17:19', 'Goods/2017-12-10/5a2cf5a1a4f6b.jpg', 'Goods/2017-12-10/sm_5a2cf5a1a4f6b.jpg', 'Goods/2017-12-10/mid_5a2cf5a1a4f6b.jpg', 'Goods/2017-12-10/big_5a2cf5a1a4f6b.jpg', 'Goods/2017-12-10/mbig_5a2cf5a1a4f6b.jpg', 1, 1, 1, '99.00', '2018-02-01 00:00:00', '2018-02-01 00:00:00', '是', '是', '否', 110, '是'),
(35, 'test', '2999.00', '2899.00', '<p><strong></strong>test1<br /></p>', '是', '否', '2018-03-10 20:13:57', 'Goods/2018-03-10/5aa3cc053f710.png', 'Goods/2018-03-10/thumb_3_5aa3cc053f710.png', 'Goods/2018-03-10/thumb_2_5aa3cc053f710.png', 'Goods/2018-03-10/thumb_1_5aa3cc053f710.png', 'Goods/2018-03-10/thumb_0_5aa3cc053f710.png', 1, 1, 1, '2789.00', '2018-03-10 20:12:00', '2018-03-10 20:12:00', '是', '是', '是', 100, '是'),
(36, 'iphoneX', '2999.00', '2899.00', '<p>iphoneX</p><p>iphoneX</p><p>iphoneX</p>', '是', '否', '2018-03-10 20:17:12', 'Goods/2018-03-10/5aa3ccc8223ec.png', 'Goods/2018-03-10/thumb_3_5aa3ccc8223ec.png', 'Goods/2018-03-10/thumb_2_5aa3ccc8223ec.png', 'Goods/2018-03-10/thumb_1_5aa3ccc8223ec.png', 'Goods/2018-03-10/thumb_0_5aa3ccc8223ec.png', 2, 2, 4, '2789.00', '2018-03-10 20:16:00', '2018-03-10 20:16:00', '是', '是', '是', 100, '是');

-- --------------------------------------------------------

--
-- 表的结构 `p39_goods_attr`
--

CREATE TABLE IF NOT EXISTS `p39_goods_attr` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `attr_value` varchar(150) NOT NULL DEFAULT '' COMMENT '属性值',
  `attr_id` mediumint(8) unsigned NOT NULL COMMENT '属性Id',
  `goods_id` mediumint(8) unsigned NOT NULL COMMENT '商品Id',
  PRIMARY KEY (`id`),
  KEY `goods_id` (`goods_id`),
  KEY `attr_id` (`attr_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='商品属性' AUTO_INCREMENT=22 ;

--
-- 转存表中的数据 `p39_goods_attr`
--

INSERT INTO `p39_goods_attr` (`id`, `attr_value`, `attr_id`, `goods_id`) VALUES
(20, '白色', 11, 36),
(21, '2018', 12, 36);

-- --------------------------------------------------------

--
-- 表的结构 `p39_goods_cat`
--

CREATE TABLE IF NOT EXISTS `p39_goods_cat` (
  `cat_id` mediumint(8) unsigned NOT NULL COMMENT '分类id',
  `goods_id` mediumint(8) unsigned NOT NULL COMMENT '商品Id',
  KEY `goods_id` (`goods_id`),
  KEY `cat_id` (`cat_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商品扩展分类';

--
-- 转存表中的数据 `p39_goods_cat`
--

INSERT INTO `p39_goods_cat` (`cat_id`, `goods_id`) VALUES
(22, 33),
(16, 35),
(22, 29),
(23, 29),
(17, 29),
(21, 36);

-- --------------------------------------------------------

--
-- 表的结构 `p39_goods_number`
--

CREATE TABLE IF NOT EXISTS `p39_goods_number` (
  `goods_id` mediumint(8) unsigned NOT NULL COMMENT '商品Id',
  `goods_number` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '库存量',
  `goods_attr_id` varchar(150) NOT NULL COMMENT '商品属性表的ID,如果有多个，就用程序拼成字符串存到这个字段中',
  KEY `goods_id` (`goods_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='库存量';

--
-- 转存表中的数据 `p39_goods_number`
--

INSERT INTO `p39_goods_number` (`goods_id`, `goods_number`, `goods_attr_id`) VALUES
(32, 200, '59,66'),
(33, 100, '2,71'),
(33, 110, '1,71'),
(33, 120, '3,71'),
(33, 130, '53,71'),
(36, 84, '20'),
(35, 94, '');

-- --------------------------------------------------------

--
-- 表的结构 `p39_goods_pic`
--

CREATE TABLE IF NOT EXISTS `p39_goods_pic` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `pic` varchar(150) NOT NULL COMMENT '原图',
  `sm_pic` varchar(150) NOT NULL COMMENT '小图',
  `mid_pic` varchar(150) NOT NULL COMMENT '中图',
  `big_pic` varchar(150) NOT NULL COMMENT '大图',
  `goods_id` mediumint(8) unsigned NOT NULL COMMENT '商品Id',
  PRIMARY KEY (`id`),
  KEY `goods_id` (`goods_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='商品相册' AUTO_INCREMENT=12 ;

--
-- 转存表中的数据 `p39_goods_pic`
--

INSERT INTO `p39_goods_pic` (`id`, `pic`, `sm_pic`, `mid_pic`, `big_pic`, `goods_id`) VALUES
(1, 'Goods/2017-11-20/5a12c4428543c.jpg', 'Goods/2017-11-20/thumb_2_5a12c4428543c.jpg', 'Goods/2017-11-20/thumb_1_5a12c4428543c.jpg', 'Goods/2017-11-20/thumb_0_5a12c4428543c.jpg', 27),
(2, 'Goods/2017-11-20/5a12c442b692c.png', 'Goods/2017-11-20/thumb_2_5a12c442b692c.png', 'Goods/2017-11-20/thumb_1_5a12c442b692c.png', 'Goods/2017-11-20/thumb_0_5a12c442b692c.png', 27),
(4, 'Goods/2017-11-20/5a12ca7ee392c.png', 'Goods/2017-11-20/thumb_2_5a12ca7ee392c.png', 'Goods/2017-11-20/thumb_1_5a12ca7ee392c.png', 'Goods/2017-11-20/thumb_0_5a12ca7ee392c.png', 27),
(5, 'Goods/2018-03-10/5aa3cc05bff90.png', 'Goods/2018-03-10/thumb_2_5aa3cc05bff90.png', 'Goods/2018-03-10/thumb_1_5aa3cc05bff90.png', 'Goods/2018-03-10/thumb_0_5aa3cc05bff90.png', 35),
(6, 'Goods/2018-03-10/5aa3cc05d6eae.png', 'Goods/2018-03-10/thumb_2_5aa3cc05d6eae.png', 'Goods/2018-03-10/thumb_1_5aa3cc05d6eae.png', 'Goods/2018-03-10/thumb_0_5aa3cc05d6eae.png', 35),
(7, 'Goods/2018-03-14/5aa92862ded6c.png', 'Goods/2018-03-14/thumb_2_5aa92862ded6c.png', 'Goods/2018-03-14/thumb_1_5aa92862ded6c.png', 'Goods/2018-03-14/thumb_0_5aa92862ded6c.png', 29),
(8, 'Goods/2018-03-14/5aa9286320f59.jpg', 'Goods/2018-03-14/thumb_2_5aa9286320f59.jpg', 'Goods/2018-03-14/thumb_1_5aa9286320f59.jpg', 'Goods/2018-03-14/thumb_0_5aa9286320f59.jpg', 29),
(9, 'Goods/2018-03-14/5aa928634fa86.png', 'Goods/2018-03-14/thumb_2_5aa928634fa86.png', 'Goods/2018-03-14/thumb_1_5aa928634fa86.png', 'Goods/2018-03-14/thumb_0_5aa928634fa86.png', 29),
(10, 'Goods/2018-03-14/5aa928636efab.png', 'Goods/2018-03-14/thumb_2_5aa928636efab.png', 'Goods/2018-03-14/thumb_1_5aa928636efab.png', 'Goods/2018-03-14/thumb_0_5aa928636efab.png', 29),
(11, 'Goods/2018-03-20/5ab0c5c84c33f.png', 'Goods/2018-03-20/thumb_2_5ab0c5c84c33f.png', 'Goods/2018-03-20/thumb_1_5ab0c5c84c33f.png', 'Goods/2018-03-20/thumb_0_5ab0c5c84c33f.png', 36);

-- --------------------------------------------------------

--
-- 表的结构 `p39_member`
--

CREATE TABLE IF NOT EXISTS `p39_member` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `username` varchar(30) NOT NULL COMMENT '用户名',
  `password` char(32) NOT NULL COMMENT '密码',
  `face` varchar(150) NOT NULL DEFAULT '' COMMENT '头像',
  `jifen` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '积分',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='会员' AUTO_INCREMENT=2 ;

--
-- 转存表中的数据 `p39_member`
--

INSERT INTO `p39_member` (`id`, `username`, `password`, `face`, `jifen`) VALUES
(1, 'user1', 'e10adc3949ba59abbe56e057f20f883e', '', 0);

-- --------------------------------------------------------

--
-- 表的结构 `p39_member_level`
--

CREATE TABLE IF NOT EXISTS `p39_member_level` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `level_name` varchar(30) NOT NULL COMMENT '级别名称',
  `jifen_bottom` mediumint(8) unsigned NOT NULL COMMENT '积分下限',
  `jifen_top` mediumint(8) unsigned NOT NULL COMMENT '积分上限',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='会员级别' AUTO_INCREMENT=5 ;

--
-- 转存表中的数据 `p39_member_level`
--

INSERT INTO `p39_member_level` (`id`, `level_name`, `jifen_bottom`, `jifen_top`) VALUES
(1, '注册会员', 0, 5000),
(2, '初级会员', 5001, 10000),
(3, '高级会员', 10001, 20000),
(4, 'vip', 20001, 50000);

-- --------------------------------------------------------

--
-- 表的结构 `p39_member_price`
--

CREATE TABLE IF NOT EXISTS `p39_member_price` (
  `price` decimal(10,2) NOT NULL COMMENT '会员价格',
  `level_id` mediumint(8) unsigned NOT NULL COMMENT '级别Id',
  `goods_id` mediumint(8) unsigned NOT NULL COMMENT '商品Id',
  KEY `level_id` (`level_id`),
  KEY `goods_id` (`goods_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会员价格';

--
-- 转存表中的数据 `p39_member_price`
--

INSERT INTO `p39_member_price` (`price`, `level_id`, `goods_id`) VALUES
('999.00', 1, 24),
('988.00', 2, 24),
('980.00', 3, 24),
('950.00', 4, 24),
('1999.00', 1, 23),
('1989.00', 2, 23),
('1899.00', 3, 23),
('1889.00', 4, 23),
('6666.00', 1, 26),
('5555.00', 2, 26),
('4444.00', 3, 26),
('3333.00', 4, 26),
('2999.00', 1, 35),
('2989.00', 2, 35),
('2699.00', 3, 35),
('2599.00', 4, 35),
('1000.00', 1, 29),
('998.00', 2, 29),
('980.00', 3, 29),
('960.00', 4, 29),
('2999.00', 1, 36),
('2789.00', 2, 36),
('2760.00', 3, 36),
('2750.00', 4, 36);

-- --------------------------------------------------------

--
-- 表的结构 `p39_order`
--

CREATE TABLE IF NOT EXISTS `p39_order` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `member_id` mediumint(8) unsigned NOT NULL COMMENT '会员Id',
  `addtime` int(10) unsigned NOT NULL COMMENT '下单时间',
  `pay_status` enum('是','否') NOT NULL DEFAULT '否' COMMENT '支付状态',
  `pay_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '支付时间',
  `total_price` decimal(10,2) NOT NULL COMMENT '定单总价',
  `shr_name` varchar(30) NOT NULL COMMENT '收货人姓名',
  `shr_tel` varchar(30) NOT NULL COMMENT '收货人电话',
  `shr_province` varchar(30) NOT NULL COMMENT '收货人省',
  `shr_city` varchar(30) NOT NULL COMMENT '收货人城市',
  `shr_area` varchar(30) NOT NULL COMMENT '收货人地区',
  `shr_address` varchar(30) NOT NULL COMMENT '收货人详细地址',
  `post_status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '发货状态,0:未发货,1:已发货2:已收到货',
  `post_number` varchar(30) NOT NULL DEFAULT '' COMMENT '快递号',
  PRIMARY KEY (`id`),
  KEY `member_id` (`member_id`),
  KEY `addtime` (`addtime`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='定单基本信息' AUTO_INCREMENT=7 ;

--
-- 转存表中的数据 `p39_order`
--

INSERT INTO `p39_order` (`id`, `member_id`, `addtime`, `pay_status`, `pay_time`, `total_price`, `shr_name`, `shr_tel`, `shr_province`, `shr_city`, `shr_area`, `shr_address`, `post_status`, `post_number`) VALUES
(1, 1, 1521716739, '否', 0, '17994.00', 'Rambo', '17875511996', '上海', '朝阳区', '西二旗', 'address', 0, ''),
(2, 1, 1521716843, '否', 0, '17994.00', 'Rambo', '17875511996', '北京', '朝阳区', '西二旗', 'address', 0, ''),
(3, 1, 1521716910, '否', 0, '17994.00', 'Rambo', '17875511996', '北京', '朝阳区', '西二旗', 'address', 0, ''),
(4, 1, 1522142688, '否', 0, '5998.00', 'Rambo', '17875511996', '北京', '朝阳区', '西三旗', 'a', 0, ''),
(5, 1, 1522151547, '否', 0, '2999.00', 'Rambo', '17875511996', '北京', '东城区', '西二旗', 'address', 0, ''),
(6, 1, 1522234134, '否', 0, '2999.00', 'Rambo', '17875511996', '北京', '朝阳区', '西二旗', 'address', 0, '');

-- --------------------------------------------------------

--
-- 表的结构 `p39_order_goods`
--

CREATE TABLE IF NOT EXISTS `p39_order_goods` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `order_id` mediumint(8) unsigned NOT NULL COMMENT '定单Id',
  `goods_id` mediumint(8) unsigned NOT NULL COMMENT '商品Id',
  `goods_attr_id` varchar(150) NOT NULL DEFAULT '' COMMENT '商品属性id',
  `goods_number` mediumint(8) unsigned NOT NULL COMMENT '购买的数量',
  `price` decimal(10,2) NOT NULL COMMENT '购买的价格',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `goods_id` (`goods_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='定单商品表' AUTO_INCREMENT=10 ;

--
-- 转存表中的数据 `p39_order_goods`
--

INSERT INTO `p39_order_goods` (`id`, `order_id`, `goods_id`, `goods_attr_id`, `goods_number`, `price`) VALUES
(1, 1, 36, '20', 4, '2999.00'),
(2, 1, 35, '', 2, '2999.00'),
(3, 2, 36, '20', 4, '2999.00'),
(4, 2, 35, '', 2, '2999.00'),
(5, 3, 36, '20', 4, '2999.00'),
(6, 3, 35, '', 2, '2999.00'),
(7, 4, 36, '20', 2, '2999.00'),
(8, 5, 36, '20', 1, '2999.00'),
(9, 6, 36, '20', 1, '2999.00');

-- --------------------------------------------------------

--
-- 表的结构 `p39_privilege`
--

CREATE TABLE IF NOT EXISTS `p39_privilege` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `pri_name` varchar(30) NOT NULL COMMENT '权限名称',
  `module_name` varchar(30) NOT NULL DEFAULT '' COMMENT '模块名称',
  `controller_name` varchar(30) NOT NULL DEFAULT '' COMMENT '控制器名称',
  `action_name` varchar(30) NOT NULL DEFAULT '' COMMENT '方法名称',
  `parent_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '上级权限Id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='权限' AUTO_INCREMENT=39 ;

--
-- 转存表中的数据 `p39_privilege`
--

INSERT INTO `p39_privilege` (`id`, `pri_name`, `module_name`, `controller_name`, `action_name`, `parent_id`) VALUES
(1, '商品模块', '', '', '', 0),
(2, '商品列表', 'Admin', 'Goods', 'lst', 1),
(3, '添加商品', 'Admin', 'Goods', 'add', 2),
(4, '修改商品', 'Admin', 'Goods', 'edit', 2),
(5, '删除商品', 'Admin', 'Goods', 'delete', 2),
(6, '分类列表', 'Admin', 'Category', 'lst', 1),
(7, '添加分类', 'Admin', 'Category', 'add', 6),
(8, '修改分类', 'Admin', 'Category', 'edit', 6),
(9, '删除分类', 'Admin', 'Category', 'delete', 6),
(10, 'RBAC', '', '', '', 0),
(11, '权限列表', 'Admin', 'Privilege', 'lst', 10),
(12, '添加权限', 'Privilege', 'Admin', 'add', 11),
(13, '修改权限', 'Admin', 'Privilege', 'edit', 11),
(14, '删除权限', 'Admin', 'Privilege', 'delete', 11),
(15, '角色列表', 'Admin', 'Role', 'lst', 10),
(16, '添加角色', 'Admin', 'Role', 'add', 15),
(17, '修改角色', 'Admin', 'Role', 'edit', 15),
(18, '删除角色', 'Admin', 'Role', 'delete', 15),
(19, '管理员列表', 'Admin', 'Admin', 'lst', 10),
(20, '添加管理员', 'Admin', 'Admin', 'add', 19),
(21, '修改管理员', 'Admin', 'Admin', 'edit', 19),
(22, '删除管理员', 'Admin', 'Admin', 'delete', 19),
(23, '类型列表', 'Admin', 'Type', 'lst', 1),
(24, '添加类型', 'Admin', 'Type', 'add', 23),
(25, '修改类型', 'Admin', 'Type', 'edit', 23),
(26, '删除类型', 'Admin', 'Type', 'delete', 23),
(27, '属性列表', 'Admin', 'Attribute', 'lst', 23),
(28, '添加属性', 'Admin', 'Attribute', 'add', 27),
(29, '修改属性', 'Admin', 'Attribute', 'edit', 27),
(30, '删除属性', 'Admin', 'Attribute', 'delete', 27),
(31, 'ajax删除商品属性', 'Admin', 'Goods', 'ajaxDelGoodsAttr', 4),
(32, 'ajax删除商品相册图片', 'Admin', 'Goods', 'ajaxDelImage', 4),
(33, '会员管理', '', '', '', 0),
(34, '会员级别列表', 'Admin', 'MemberLevel', 'lst', 33),
(35, '添加会员级别', 'Admin', 'MemberLevel', 'add', 34),
(36, '修改会员级别', 'Admin', 'MemberLevel', 'edit', 34),
(37, '删除会员级别', 'Admin', 'MemberLevel', 'delete', 34),
(38, '品牌列表', 'Admin', 'Brand', 'lst', 1);

-- --------------------------------------------------------

--
-- 表的结构 `p39_role`
--

CREATE TABLE IF NOT EXISTS `p39_role` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `role_name` varchar(30) NOT NULL COMMENT '角色名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='角色' AUTO_INCREMENT=3 ;

--
-- 转存表中的数据 `p39_role`
--

INSERT INTO `p39_role` (`id`, `role_name`) VALUES
(1, '商品模块管理员'),
(2, '员工');

-- --------------------------------------------------------

--
-- 表的结构 `p39_role_pri`
--

CREATE TABLE IF NOT EXISTS `p39_role_pri` (
  `pri_id` mediumint(8) unsigned NOT NULL COMMENT '权限id',
  `role_id` mediumint(8) unsigned NOT NULL COMMENT '角色id',
  KEY `pri_id` (`pri_id`),
  KEY `role_id` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色权限';

--
-- 转存表中的数据 `p39_role_pri`
--

INSERT INTO `p39_role_pri` (`pri_id`, `role_id`) VALUES
(1, 2),
(2, 2),
(3, 2),
(4, 2),
(31, 2),
(32, 2),
(5, 2),
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(31, 1),
(32, 1),
(5, 1),
(6, 1),
(7, 1),
(8, 1),
(9, 1),
(23, 1),
(24, 1),
(25, 1),
(26, 1),
(27, 1),
(28, 1),
(29, 1),
(30, 1),
(38, 1);

-- --------------------------------------------------------

--
-- 表的结构 `p39_type`
--

CREATE TABLE IF NOT EXISTS `p39_type` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `type_name` varchar(30) NOT NULL COMMENT '类型名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='类型' AUTO_INCREMENT=5 ;

--
-- 转存表中的数据 `p39_type`
--

INSERT INTO `p39_type` (`id`, `type_name`) VALUES
(4, '手机');

-- --------------------------------------------------------

--
-- 表的结构 `p39_yinxiang`
--

CREATE TABLE IF NOT EXISTS `p39_yinxiang` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `goods_id` mediumint(8) unsigned NOT NULL COMMENT '商品Id',
  `yx_name` varchar(30) NOT NULL COMMENT '印象名称',
  `yx_count` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT '印象的次数',
  PRIMARY KEY (`id`),
  KEY `goods_id` (`goods_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='印象' AUTO_INCREMENT=1 ;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
