-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: 2018-06-26 14:26:09
-- 服务器版本： 5.7.19
-- PHP Version: 5.6.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `php39`
--

-- --------------------------------------------------------

--
-- 表的结构 `p39_admin`
--

DROP TABLE IF EXISTS `p39_admin`;
CREATE TABLE IF NOT EXISTS `p39_admin` (
  `id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `username` varchar(30) NOT NULL COMMENT '用户名',
  `password` char(32) NOT NULL COMMENT '密码',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='管理员';

--
-- 转存表中的数据 `p39_admin`
--

INSERT INTO `p39_admin` (`id`, `username`, `password`) VALUES
(1, 'root', '21232f297a57a5a743894a0e4a801fc3'),
(3, 'admin', 'e10adc3949ba59abbe56e057f20f883e'),
(4, 'Rambo', 'e10adc3949ba59abbe56e057f20f883e');

-- --------------------------------------------------------

--
-- 表的结构 `p39_admin_role`
--

DROP TABLE IF EXISTS `p39_admin_role`;
CREATE TABLE IF NOT EXISTS `p39_admin_role` (
  `admin_id` mediumint(8) UNSIGNED NOT NULL COMMENT '管理员id',
  `role_id` mediumint(8) UNSIGNED NOT NULL COMMENT '角色id',
  KEY `admin_id` (`admin_id`),
  KEY `role_id` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='管理员角色';

--
-- 转存表中的数据 `p39_admin_role`
--

INSERT INTO `p39_admin_role` (`admin_id`, `role_id`) VALUES
(3, 1),
(4, 2);

-- --------------------------------------------------------

--
-- 表的结构 `p39_attribute`
--

DROP TABLE IF EXISTS `p39_attribute`;
CREATE TABLE IF NOT EXISTS `p39_attribute` (
  `id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `attr_name` varchar(30) NOT NULL COMMENT '属性名称',
  `attr_type` enum('唯一','可选') NOT NULL COMMENT '属性类型',
  `attr_option_values` varchar(300) NOT NULL DEFAULT '' COMMENT '属性可选值',
  `type_id` mediumint(8) UNSIGNED NOT NULL COMMENT '所属类型Id',
  PRIMARY KEY (`id`),
  KEY `type_id` (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='属性表';

--
-- 转存表中的数据 `p39_attribute`
--

INSERT INTO `p39_attribute` (`id`, `attr_name`, `attr_type`, `attr_option_values`, `type_id`) VALUES
(11, '颜色', '可选', '红色,白色,黑色', 4),
(12, '添加时间', '唯一', '2018', 4),
(13, '出版社', '唯一', '清华出版社', 5);

-- --------------------------------------------------------

--
-- 表的结构 `p39_brand`
--

DROP TABLE IF EXISTS `p39_brand`;
CREATE TABLE IF NOT EXISTS `p39_brand` (
  `id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `brand_name` varchar(30) NOT NULL COMMENT '品牌名称',
  `site_url` varchar(150) NOT NULL DEFAULT '' COMMENT '官方网址',
  `logo` varchar(150) NOT NULL DEFAULT '' COMMENT '品牌Logo图片',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='品牌';

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

DROP TABLE IF EXISTS `p39_cart`;
CREATE TABLE IF NOT EXISTS `p39_cart` (
  `id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `goods_id` mediumint(8) UNSIGNED NOT NULL COMMENT '商品Id',
  `goods_attr_id` varchar(150) NOT NULL DEFAULT '' COMMENT '商品属性Id',
  `goods_number` mediumint(8) UNSIGNED NOT NULL COMMENT '购买的数量',
  `member_id` mediumint(8) UNSIGNED NOT NULL COMMENT '会员Id',
  PRIMARY KEY (`id`),
  KEY `member_id` (`member_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='购物车';

-- --------------------------------------------------------

--
-- 表的结构 `p39_category`
--

DROP TABLE IF EXISTS `p39_category`;
CREATE TABLE IF NOT EXISTS `p39_category` (
  `id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `cat_name` varchar(30) NOT NULL COMMENT '分类名称',
  `parent_id` mediumint(8) UNSIGNED NOT NULL DEFAULT '0' COMMENT '上级分类的Id,0:顶级分类',
  `is_floor` enum('是','否') NOT NULL DEFAULT '否',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 COMMENT='是否推荐楼层';

--
-- 转存表中的数据 `p39_category`
--

INSERT INTO `p39_category` (`id`, `cat_name`, `parent_id`, `is_floor`) VALUES
(1, '家用电器', 0, '是'),
(2, '手机、数码、京东通信', 0, '是'),
(3, '电脑、办公', 0, '否'),
(4, '家居、家具、家装、厨具', 0, '否'),
(5, '男装、女装、内衣、珠宝', 0, '否'),
(6, '个护化妆', 0, '否'),
(8, '运动户外', 0, '否'),
(9, '汽车、汽车用品', 0, '否'),
(16, '大家电', 1, '是'),
(17, '生活电器', 1, '是'),
(18, '厨房电器', 1, '否'),
(19, '个护健康', 1, '是'),
(20, '五金家装', 1, '否'),
(21, 'iphone', 2, '是'),
(22, '冰箱', 16, '否');

-- --------------------------------------------------------

--
-- 表的结构 `p39_comment`
--

DROP TABLE IF EXISTS `p39_comment`;
CREATE TABLE IF NOT EXISTS `p39_comment` (
  `id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `goods_id` mediumint(8) UNSIGNED NOT NULL COMMENT '商品Id',
  `member_id` mediumint(8) UNSIGNED NOT NULL COMMENT '会员Id',
  `content` varchar(200) NOT NULL COMMENT '内容',
  `addtime` datetime NOT NULL COMMENT '发表时间',
  `star` tinyint(3) UNSIGNED NOT NULL COMMENT '分值',
  `click_count` smallint(5) UNSIGNED NOT NULL DEFAULT '0' COMMENT '有用的数字',
  PRIMARY KEY (`id`),
  KEY `goods_id` (`goods_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='评论';

-- --------------------------------------------------------

--
-- 表的结构 `p39_comment_reply`
--

DROP TABLE IF EXISTS `p39_comment_reply`;
CREATE TABLE IF NOT EXISTS `p39_comment_reply` (
  `id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `comment_id` mediumint(8) UNSIGNED NOT NULL COMMENT '评论Id',
  `member_id` mediumint(8) UNSIGNED NOT NULL COMMENT '会员Id',
  `content` varchar(200) NOT NULL COMMENT '内容',
  `addtime` datetime NOT NULL COMMENT '发表时间',
  PRIMARY KEY (`id`),
  KEY `comment_id` (`comment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='评论回复';

-- --------------------------------------------------------

--
-- 表的结构 `p39_goods`
--

DROP TABLE IF EXISTS `p39_goods`;
CREATE TABLE IF NOT EXISTS `p39_goods` (
  `id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Id',
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
  `brand_id` mediumint(8) UNSIGNED NOT NULL DEFAULT '0' COMMENT '品牌id',
  `cat_id` mediumint(8) UNSIGNED NOT NULL DEFAULT '0' COMMENT '主分类Id',
  `type_id` mediumint(8) UNSIGNED NOT NULL DEFAULT '0' COMMENT '类型Id',
  `promote_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '促销价格',
  `promote_start_date` datetime NOT NULL COMMENT '促销开始时间',
  `promote_end_date` datetime NOT NULL COMMENT '促销结束时间',
  `is_new` enum('是','否') NOT NULL DEFAULT '否' COMMENT '是否新品',
  `is_hot` enum('是','否') NOT NULL DEFAULT '否' COMMENT '是否热卖',
  `is_best` enum('是','否') NOT NULL DEFAULT '否' COMMENT '是否精品',
  `sort_num` tinyint(3) UNSIGNED NOT NULL DEFAULT '100' COMMENT '排序的数字',
  `is_floor` enum('是','否') NOT NULL DEFAULT '否',
  PRIMARY KEY (`id`),
  KEY `shop_price` (`shop_price`),
  KEY `addtime` (`addtime`),
  KEY `is_on_sale` (`is_on_sale`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8 COMMENT='是否推荐楼层';

--
-- 转存表中的数据 `p39_goods`
--

INSERT INTO `p39_goods` (`id`, `goods_name`, `market_price`, `shop_price`, `goods_desc`, `is_on_sale`, `is_delete`, `addtime`, `logo`, `sm_logo`, `mid_logo`, `big_logo`, `mbig_logo`, `brand_id`, `cat_id`, `type_id`, `promote_price`, `promote_start_date`, `promote_end_date`, `is_new`, `is_hot`, `is_best`, `sort_num`, `is_floor`) VALUES
(36, 'iphoneX', '2999.00', '2899.00', '<p>iphoneX</p><p>iphoneX</p><p>iphoneX</p>', '是', '否', '2018-03-10 20:17:12', 'Goods/2018-03-10/5aa3ccc8223ec.png', 'Goods/2018-03-10/thumb_3_5aa3ccc8223ec.png', 'Goods/2018-03-10/thumb_2_5aa3ccc8223ec.png', 'Goods/2018-03-10/thumb_1_5aa3ccc8223ec.png', 'Goods/2018-03-10/thumb_0_5aa3ccc8223ec.png', 2, 2, 4, '2789.00', '2018-03-10 20:16:00', '2018-03-10 20:16:00', '是', '是', '是', 100, '是'),
(37, '小米Note3', '1799.00', '1789.00', '<p><em><strong>小米Note3,吴亦凡代言</strong></em><br /></p>', '是', '否', '2018-06-26 20:19:47', 'Goods/2018-06-26/5b322f63575f8.png', 'Goods/2018-06-26/thumb_3_5b322f63575f8.png', 'Goods/2018-06-26/thumb_2_5b322f63575f8.png', 'Goods/2018-06-26/thumb_1_5b322f63575f8.png', 'Goods/2018-06-26/thumb_0_5b322f63575f8.png', 3, 2, 4, '1699.00', '2018-06-26 20:18:00', '2018-06-29 20:18:00', '是', '是', '是', 100, '是'),
(38, '华为P10', '2999.00', '2989.00', '', '是', '否', '2018-06-26 21:30:28', 'Goods/2018-06-26/5b323ff3e0e7f.jpg', 'Goods/2018-06-26/thumb_3_5b323ff3e0e7f.jpg', 'Goods/2018-06-26/thumb_2_5b323ff3e0e7f.jpg', 'Goods/2018-06-26/thumb_1_5b323ff3e0e7f.jpg', 'Goods/2018-06-26/thumb_0_5b323ff3e0e7f.jpg', 1, 2, 4, '2888.00', '2018-06-26 21:29:00', '2018-06-29 00:00:00', '是', '是', '是', 100, '是'),
(39, 'VIVO x20', '1000.00', '1000.00', '', '是', '否', '2018-06-26 21:33:34', 'Goods/2018-06-26/5b3240ae6c6c9.png', 'Goods/2018-06-26/thumb_3_5b3240ae6c6c9.png', 'Goods/2018-06-26/thumb_2_5b3240ae6c6c9.png', 'Goods/2018-06-26/thumb_1_5b3240ae6c6c9.png', 'Goods/2018-06-26/thumb_0_5b3240ae6c6c9.png', 4, 2, 4, '999.00', '2018-06-26 21:33:00', '2018-06-29 00:00:00', '是', '是', '是', 100, '是');

-- --------------------------------------------------------

--
-- 表的结构 `p39_goods_attr`
--

DROP TABLE IF EXISTS `p39_goods_attr`;
CREATE TABLE IF NOT EXISTS `p39_goods_attr` (
  `id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `attr_value` varchar(150) NOT NULL DEFAULT '' COMMENT '属性值',
  `attr_id` mediumint(8) UNSIGNED NOT NULL COMMENT '属性Id',
  `goods_id` mediumint(8) UNSIGNED NOT NULL COMMENT '商品Id',
  PRIMARY KEY (`id`),
  KEY `goods_id` (`goods_id`),
  KEY `attr_id` (`attr_id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8 COMMENT='商品属性';

--
-- 转存表中的数据 `p39_goods_attr`
--

INSERT INTO `p39_goods_attr` (`id`, `attr_value`, `attr_id`, `goods_id`) VALUES
(20, '白色', 11, 36),
(21, '2018', 12, 36),
(22, '红色', 11, 37),
(23, '2018', 12, 37),
(24, '白色', 11, 38),
(25, '2018', 12, 38),
(26, '白色', 11, 39),
(27, '2018', 12, 39);

-- --------------------------------------------------------

--
-- 表的结构 `p39_goods_cat`
--

DROP TABLE IF EXISTS `p39_goods_cat`;
CREATE TABLE IF NOT EXISTS `p39_goods_cat` (
  `cat_id` mediumint(8) UNSIGNED NOT NULL COMMENT '分类id',
  `goods_id` mediumint(8) UNSIGNED NOT NULL COMMENT '商品Id',
  KEY `goods_id` (`goods_id`),
  KEY `cat_id` (`cat_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商品扩展分类';

--
-- 转存表中的数据 `p39_goods_cat`
--

INSERT INTO `p39_goods_cat` (`cat_id`, `goods_id`) VALUES
(21, 36);

-- --------------------------------------------------------

--
-- 表的结构 `p39_goods_number`
--

DROP TABLE IF EXISTS `p39_goods_number`;
CREATE TABLE IF NOT EXISTS `p39_goods_number` (
  `goods_id` mediumint(8) UNSIGNED NOT NULL COMMENT '商品Id',
  `goods_number` mediumint(8) UNSIGNED NOT NULL DEFAULT '0' COMMENT '库存量',
  `goods_attr_id` varchar(150) NOT NULL COMMENT '商品属性表的ID,如果有多个，就用程序拼成字符串存到这个字段中',
  KEY `goods_id` (`goods_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='库存量';

--
-- 转存表中的数据 `p39_goods_number`
--

INSERT INTO `p39_goods_number` (`goods_id`, `goods_number`, `goods_attr_id`) VALUES
(36, 71, '20'),
(37, 998, '22');

-- --------------------------------------------------------

--
-- 表的结构 `p39_goods_pic`
--

DROP TABLE IF EXISTS `p39_goods_pic`;
CREATE TABLE IF NOT EXISTS `p39_goods_pic` (
  `id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `pic` varchar(150) NOT NULL COMMENT '原图',
  `sm_pic` varchar(150) NOT NULL COMMENT '小图',
  `mid_pic` varchar(150) NOT NULL COMMENT '中图',
  `big_pic` varchar(150) NOT NULL COMMENT '大图',
  `goods_id` mediumint(8) UNSIGNED NOT NULL COMMENT '商品Id',
  PRIMARY KEY (`id`),
  KEY `goods_id` (`goods_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COMMENT='商品相册';

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
(11, 'Goods/2018-03-20/5ab0c5c84c33f.png', 'Goods/2018-03-20/thumb_2_5ab0c5c84c33f.png', 'Goods/2018-03-20/thumb_1_5ab0c5c84c33f.png', 'Goods/2018-03-20/thumb_0_5ab0c5c84c33f.png', 36),
(12, 'Goods/2018-06-26/5b322f655e478.png', 'Goods/2018-06-26/thumb_2_5b322f655e478.png', 'Goods/2018-06-26/thumb_1_5b322f655e478.png', 'Goods/2018-06-26/thumb_0_5b322f655e478.png', 37),
(13, 'Goods/2018-06-26/5b322f658daff.png', 'Goods/2018-06-26/thumb_2_5b322f658daff.png', 'Goods/2018-06-26/thumb_1_5b322f658daff.png', 'Goods/2018-06-26/thumb_0_5b322f658daff.png', 37),
(14, 'Goods/2018-06-26/5b322f9c70d3a.png', 'Goods/2018-06-26/thumb_2_5b322f9c70d3a.png', 'Goods/2018-06-26/thumb_1_5b322f9c70d3a.png', 'Goods/2018-06-26/thumb_0_5b322f9c70d3a.png', 37),
(15, 'Goods/2018-06-26/5b323ff4ee2e8.jpg', 'Goods/2018-06-26/thumb_2_5b323ff4ee2e8.jpg', 'Goods/2018-06-26/thumb_1_5b323ff4ee2e8.jpg', 'Goods/2018-06-26/thumb_0_5b323ff4ee2e8.jpg', 38),
(16, 'Goods/2018-06-26/5b3240aeee6eb.png', 'Goods/2018-06-26/thumb_2_5b3240aeee6eb.png', 'Goods/2018-06-26/thumb_1_5b3240aeee6eb.png', 'Goods/2018-06-26/thumb_0_5b3240aeee6eb.png', 39);

-- --------------------------------------------------------

--
-- 表的结构 `p39_member`
--

DROP TABLE IF EXISTS `p39_member`;
CREATE TABLE IF NOT EXISTS `p39_member` (
  `id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `username` varchar(30) NOT NULL COMMENT '用户名',
  `password` char(32) NOT NULL COMMENT '密码',
  `face` varchar(150) NOT NULL DEFAULT '' COMMENT '头像',
  `jifen` mediumint(8) UNSIGNED NOT NULL DEFAULT '0' COMMENT '积分',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='会员';

--
-- 转存表中的数据 `p39_member`
--

INSERT INTO `p39_member` (`id`, `username`, `password`, `face`, `jifen`) VALUES
(1, 'user1', 'e10adc3949ba59abbe56e057f20f883e', '', 0);

-- --------------------------------------------------------

--
-- 表的结构 `p39_member_level`
--

DROP TABLE IF EXISTS `p39_member_level`;
CREATE TABLE IF NOT EXISTS `p39_member_level` (
  `id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `level_name` varchar(30) NOT NULL COMMENT '级别名称',
  `jifen_bottom` mediumint(8) UNSIGNED NOT NULL COMMENT '积分下限',
  `jifen_top` mediumint(8) UNSIGNED NOT NULL COMMENT '积分上限',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='会员级别';

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

DROP TABLE IF EXISTS `p39_member_price`;
CREATE TABLE IF NOT EXISTS `p39_member_price` (
  `price` decimal(10,2) NOT NULL COMMENT '会员价格',
  `level_id` mediumint(8) UNSIGNED NOT NULL COMMENT '级别Id',
  `goods_id` mediumint(8) UNSIGNED NOT NULL COMMENT '商品Id',
  KEY `level_id` (`level_id`),
  KEY `goods_id` (`goods_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会员价格';

--
-- 转存表中的数据 `p39_member_price`
--

INSERT INTO `p39_member_price` (`price`, `level_id`, `goods_id`) VALUES
('2999.00', 1, 36),
('2789.00', 2, 36),
('2760.00', 3, 36),
('2750.00', 4, 36),
('1699.00', 1, 37),
('1689.00', 2, 37),
('1679.00', 3, 37),
('1650.00', 4, 37),
('2999.00', 1, 38),
('2989.00', 2, 38),
('2899.00', 3, 38),
('2890.00', 4, 38),
('1000.00', 1, 39),
('1000.00', 2, 39),
('1000.00', 3, 39),
('1000.00', 4, 39);

-- --------------------------------------------------------

--
-- 表的结构 `p39_order`
--

DROP TABLE IF EXISTS `p39_order`;
CREATE TABLE IF NOT EXISTS `p39_order` (
  `id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `member_id` mediumint(8) UNSIGNED NOT NULL COMMENT '会员Id',
  `addtime` int(10) UNSIGNED NOT NULL COMMENT '下单时间',
  `pay_status` enum('是','否') NOT NULL DEFAULT '否' COMMENT '支付状态',
  `pay_time` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '支付时间',
  `total_price` decimal(10,2) NOT NULL COMMENT '定单总价',
  `shr_name` varchar(30) NOT NULL COMMENT '收货人姓名',
  `shr_tel` varchar(30) NOT NULL COMMENT '收货人电话',
  `shr_province` varchar(30) NOT NULL COMMENT '收货人省',
  `shr_city` varchar(30) NOT NULL COMMENT '收货人城市',
  `shr_area` varchar(30) NOT NULL COMMENT '收货人地区',
  `shr_address` varchar(30) NOT NULL COMMENT '收货人详细地址',
  `post_status` tinyint(3) UNSIGNED NOT NULL DEFAULT '0' COMMENT '发货状态,0:未发货,1:已发货2:已收到货',
  `post_number` varchar(30) NOT NULL DEFAULT '' COMMENT '快递号',
  PRIMARY KEY (`id`),
  KEY `member_id` (`member_id`),
  KEY `addtime` (`addtime`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='定单基本信息';

--
-- 转存表中的数据 `p39_order`
--

INSERT INTO `p39_order` (`id`, `member_id`, `addtime`, `pay_status`, `pay_time`, `total_price`, `shr_name`, `shr_tel`, `shr_province`, `shr_city`, `shr_area`, `shr_address`, `post_status`, `post_number`) VALUES
(1, 1, 1521716739, '否', 0, '17994.00', 'Rambo', '17875511996', '上海', '朝阳区', '西二旗', 'address', 0, ''),
(2, 1, 1521716843, '否', 0, '17994.00', 'Rambo', '17875511996', '北京', '朝阳区', '西二旗', 'address', 0, ''),
(3, 1, 1521716910, '否', 0, '17994.00', 'Rambo', '17875511996', '北京', '朝阳区', '西二旗', 'address', 0, ''),
(4, 1, 1522142688, '否', 0, '5998.00', 'Rambo', '17875511996', '北京', '朝阳区', '西三旗', 'a', 0, ''),
(5, 1, 1522151547, '否', 0, '2999.00', 'Rambo', '17875511996', '北京', '东城区', '西二旗', 'address', 0, ''),
(6, 1, 1522234134, '否', 0, '2999.00', 'Rambo', '17875511996', '北京', '朝阳区', '西二旗', 'address', 0, ''),
(7, 1, 1526520098, '否', 0, '5998.00', 'aa', '17875511996', '北京', '朝阳区', '西二旗', 'aaaaa', 0, ''),
(8, 1, 1529324452, '否', 0, '2999.00', 'AAA', 'AAAAA', '北京', '朝阳区', '西二旗', 'aaaaa', 0, ''),
(9, 1, 1529763168, '否', 0, '5998.00', 'AAA', 'AAAAA', '北京', '朝阳区', '西二旗', 'aaaaa', 0, ''),
(10, 1, 1529929862, '否', 0, '11996.00', 'Rambo', '17875511996', '北京', '朝阳区', '西二旗', 'address', 0, ''),
(11, 1, 1530015777, '否', 0, '6397.00', 'Rambo', '12345678910', '北京', '朝阳区', '西二旗', 'Beijing Road', 0, ''),
(12, 1, 1530023104, '否', 0, '8997.00', 'Rambo', '17875511996', '北京', '朝阳区', '西二旗', 'Beijing Road', 0, '');

-- --------------------------------------------------------

--
-- 表的结构 `p39_order_goods`
--

DROP TABLE IF EXISTS `p39_order_goods`;
CREATE TABLE IF NOT EXISTS `p39_order_goods` (
  `id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `order_id` mediumint(8) UNSIGNED NOT NULL COMMENT '定单Id',
  `goods_id` mediumint(8) UNSIGNED NOT NULL COMMENT '商品Id',
  `goods_attr_id` varchar(150) NOT NULL DEFAULT '' COMMENT '商品属性id',
  `goods_number` mediumint(8) UNSIGNED NOT NULL COMMENT '购买的数量',
  `price` decimal(10,2) NOT NULL COMMENT '购买的价格',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `goods_id` (`goods_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COMMENT='定单商品表';

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
(9, 6, 36, '20', 1, '2999.00'),
(10, 7, 36, '20', 2, '2999.00'),
(11, 8, 36, '20', 1, '2999.00'),
(12, 9, 36, '20', 2, '2999.00'),
(13, 10, 36, '20', 4, '2999.00'),
(14, 11, 36, '20', 1, '2999.00'),
(15, 11, 37, '22', 2, '1699.00'),
(16, 12, 36, '20', 3, '2999.00');

-- --------------------------------------------------------

--
-- 表的结构 `p39_privilege`
--

DROP TABLE IF EXISTS `p39_privilege`;
CREATE TABLE IF NOT EXISTS `p39_privilege` (
  `id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `pri_name` varchar(30) NOT NULL COMMENT '权限名称',
  `module_name` varchar(30) NOT NULL DEFAULT '' COMMENT '模块名称',
  `controller_name` varchar(30) NOT NULL DEFAULT '' COMMENT '控制器名称',
  `action_name` varchar(30) NOT NULL DEFAULT '' COMMENT '方法名称',
  `parent_id` mediumint(8) UNSIGNED NOT NULL DEFAULT '0' COMMENT '上级权限Id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8 COMMENT='权限';

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

DROP TABLE IF EXISTS `p39_role`;
CREATE TABLE IF NOT EXISTS `p39_role` (
  `id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `role_name` varchar(30) NOT NULL COMMENT '角色名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='角色';

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

DROP TABLE IF EXISTS `p39_role_pri`;
CREATE TABLE IF NOT EXISTS `p39_role_pri` (
  `pri_id` mediumint(8) UNSIGNED NOT NULL COMMENT '权限id',
  `role_id` mediumint(8) UNSIGNED NOT NULL COMMENT '角色id',
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

DROP TABLE IF EXISTS `p39_type`;
CREATE TABLE IF NOT EXISTS `p39_type` (
  `id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `type_name` varchar(30) NOT NULL COMMENT '类型名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='类型';

--
-- 转存表中的数据 `p39_type`
--

INSERT INTO `p39_type` (`id`, `type_name`) VALUES
(4, '手机'),
(5, '书籍'),
(6, '家电');

-- --------------------------------------------------------

--
-- 表的结构 `p39_yinxiang`
--

DROP TABLE IF EXISTS `p39_yinxiang`;
CREATE TABLE IF NOT EXISTS `p39_yinxiang` (
  `id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `goods_id` mediumint(8) UNSIGNED NOT NULL COMMENT '商品Id',
  `yx_name` varchar(30) NOT NULL COMMENT '印象名称',
  `yx_count` smallint(5) UNSIGNED NOT NULL DEFAULT '1' COMMENT '印象的次数',
  PRIMARY KEY (`id`),
  KEY `goods_id` (`goods_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='印象';
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
