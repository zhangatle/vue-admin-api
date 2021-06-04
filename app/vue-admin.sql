/*
 Navicat Premium Data Transfer

 Source Server         : 本机
 Source Server Type    : MySQL
 Source Server Version : 80025
 Source Host           : localhost:3306
 Source Schema         : vue-admin

 Target Server Type    : MySQL
 Target Server Version : 80025
 File Encoding         : 65001

 Date: 04/06/2021 11:26:21
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for articles
-- ----------------------------
DROP TABLE IF EXISTS `articles`;
CREATE TABLE `articles` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `author` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '作者',
  `content` text COLLATE utf8mb4_unicode_ci COMMENT '内容',
  `channel_id` bigint NOT NULL COMMENT '栏目id',
  `img` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '文章题图ID',
  `title` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '标题',
  `created_by` bigint DEFAULT NULL COMMENT '创建人',
  `updated_by` bigint DEFAULT NULL COMMENT '最后更新人',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='文章';

-- ----------------------------
-- Records of articles
-- ----------------------------
BEGIN;
INSERT INTO `articles` VALUES (1, 'enilu', '<div id=\"articleContent\" class=\"content\">\n<div class=\"ad-wrap\">\n<p style=\"margin: 0 0 10px 0;\">一般我们都有这样的需求：我需要知道库中的数据是由谁创建，什么时候创建，最后一次修改时间是什么时候，最后一次修改人是谁。web-flash最新代码已经实现该需求，具体实现方式网上有很多资料，这里做会搬运工，将web-flash的实现步骤罗列如下：%%</p>\n</div>\n<p>在Spring jpa中可以通过在实体bean的属性或者方法上添加以下注解来实现上述需求@CreatedDate、@CreatedBy、@LastModifiedDate、@LastModifiedBy。</p>\n<ul class=\" list-paddingleft-2\">\n<li>\n<p>@CreatedDate 表示该字段为创建时间时间字段，在这个实体被insert的时候，会设置值</p>\n</li>\n<li>\n<p>@CreatedBy 表示该字段为创建人，在这个实体被insert的时候，会设置值</p>\n</li>\n<li>\n<p>@LastModifiedDate 最后修改时间 实体被update的时候会设置</p>\n</li>\n<li>\n<p>@LastModifiedBy 最后修改人 实体被update的时候会设置</p>\n</li>\n</ul>\n<h2>使用方式</h2>\n<h3>实体类添加注解</h3>\n<ul class=\" list-paddingleft-2\">\n<li>\n<p>首先在实体中对应的字段加上上述4个注解</p>\n</li>\n<li>\n<p>在web-flash中我们提取了一个基础实体类BaseEntity，并将对应的字段添加上述4个注解,所有需要记录维护信息的表对应的实体都集成该类</p>\n</li>\n</ul>\n<pre>import&nbsp;org.springframework.data.annotation.CreatedBy;\nimport&nbsp;org.springframework.data.annotation.CreatedDate;\nimport&nbsp;org.springframework.data.annotation.LastModifiedBy;\nimport&nbsp;org.springframework.data.annotation.LastModifiedDate;\nimport&nbsp;javax.persistence.Column;\nimport&nbsp;javax.persistence.GeneratedValue;\nimport&nbsp;javax.persistence.Id;\nimport&nbsp;javax.persistence.MappedSuperclass;\nimport&nbsp;java.io.Serializable;\nimport&nbsp;java.util.Date;\n@MappedSuperclass\n@Data\npublic&nbsp;abstract&nbsp;class&nbsp;BaseEntity&nbsp;implements&nbsp;Serializable&nbsp;{\n&nbsp;&nbsp;&nbsp;&nbsp;@Id\n&nbsp;&nbsp;&nbsp;&nbsp;@GeneratedValue\n&nbsp;&nbsp;&nbsp;&nbsp;private&nbsp;Long&nbsp;id;\n&nbsp;&nbsp;&nbsp;&nbsp;@CreatedDate\n&nbsp;&nbsp;&nbsp;&nbsp;@Column(name&nbsp;=&nbsp;\"create_time\",columnDefinition=\"DATETIME&nbsp;COMMENT&nbsp;\'创建时间/注册时间\'\")\n&nbsp;&nbsp;&nbsp;&nbsp;private&nbsp;Date&nbsp;createTime;\n&nbsp;&nbsp;&nbsp;&nbsp;@Column(name&nbsp;=&nbsp;\"create_by\",columnDefinition=\"bigint&nbsp;COMMENT&nbsp;\'创建人\'\")\n&nbsp;&nbsp;&nbsp;&nbsp;@CreatedBy\n&nbsp;&nbsp;&nbsp;&nbsp;private&nbsp;Long&nbsp;createBy;\n&nbsp;&nbsp;&nbsp;&nbsp;@LastModifiedDate\n&nbsp;&nbsp;&nbsp;&nbsp;@Column(name&nbsp;=&nbsp;\"modify_time\",columnDefinition=\"DATETIME&nbsp;COMMENT&nbsp;\'最后更新时间\'\")\n&nbsp;&nbsp;&nbsp;&nbsp;private&nbsp;Date&nbsp;modifyTime;\n&nbsp;&nbsp;&nbsp;&nbsp;@LastModifiedBy\n&nbsp;&nbsp;&nbsp;&nbsp;@Column(name&nbsp;=&nbsp;\"modify_by\",columnDefinition=\"bigint&nbsp;COMMENT&nbsp;\'最后更新人\'\")\n&nbsp;&nbsp;&nbsp;&nbsp;private&nbsp;Long&nbsp;modifyBy;\n}</pre>\n<h3>实现AuditorAware接口返回操作人员的id</h3>\n<p>配置完上述4个注解后，在jpa.save方法被调用的时候，时间字段会自动设置并插入数据库，但是CreatedBy和LastModifiedBy并没有赋值 这两个信息需要实现AuditorAware接口来返回操作人员的id</p>\n<ul class=\" list-paddingleft-2\">\n<li>\n<p>首先需要在项目启动类添加@EnableJpaAuditing 注解来启用审计功能</p>\n</li>\n</ul>\n<pre>@SpringBootApplication\n@EnableJpaAuditing\npublic&nbsp;class&nbsp;AdminApplication&nbsp;extends&nbsp;WebMvcConfigurerAdapter&nbsp;{\n&nbsp;//省略\n}</pre>\n<ul class=\" list-paddingleft-2\">\n<li>\n<p>然后实现AuditorAware接口返回操作人员的id</p>\n</li>\n</ul>\n<pre>@Configuration\npublic&nbsp;class&nbsp;UserIDAuditorConfig&nbsp;implements&nbsp;AuditorAware&lt;Long&gt;&nbsp;{\n&nbsp;&nbsp;&nbsp;&nbsp;@Override\n&nbsp;&nbsp;&nbsp;&nbsp;public&nbsp;Long&nbsp;getCurrentAuditor()&nbsp;{\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ShiroUser&nbsp;shiroUser&nbsp;=&nbsp;ShiroKit.getUser();\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if(shiroUser!=null){\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return&nbsp;shiroUser.getId();\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return&nbsp;null;\n&nbsp;&nbsp;&nbsp;&nbsp;}\n}</pre>\n</div>', 1, '1', 'web-flash 将所有表增加维护人员和维护时间信息', 1, 1, NULL, NULL);
INSERT INTO `articles` VALUES (2, 'enilu.cn', '<div id=\"articleContent\" class=\"content\">\n<div class=\"ad-wrap\">\n<p style=\"margin: 0 0 10px 0;\"><a style=\"color: #a00; font-weight: bold;\" href=\"https://my.oschina.net/u/3985214/blog/3018099?tdsourcetag=s_pcqq_aiomsg\" target=\"_blank\" rel=\"noopener\" data-traceid=\"news_detail_above_texlink_1\" data-tracepid=\"news_detail_above_texlink\">开发十年，就只剩下这套架构体系了！ &gt;&gt;&gt;</a>&nbsp;&nbsp;<img style=\"max-height: 32px; max-width: 32px;\" src=\"https://www.oschina.net/img/hot3.png\" align=\"\" /></p>\n</div>\n<h3>国际化</h3>\n<ul class=\" list-paddingleft-2\">\n<li>\n<p>web-flash实现国际化了.</p>\n</li>\n<li>\n<p>不了解上面两个的区别的同学可以再回顾下这个<a href=\"http://www.enilu.cn/web-flash/base/web-flash.html\">文档</a></p>\n</li>\n<li>\n<p>web-flash实现国际化的方式参考vue-element-admin的&nbsp;<a href=\"https://panjiachen.github.io/vue-element-admin-site/zh/guide/advanced/i18n.html\" target=\"_blank\" rel=\"noopener\">官方文档</a>,这里不再赘述,强烈建议你先把文档读了之后再看下面的内容。</p>\n</li>\n</ul>\n<h3>默认约定</h3>\n<p>针对网站资源进行国际园涉及到的国际化资源的管理维护，这里给出一些web-flash的资源分类建议，当然，你也可以根据你的实际情况进行调整。</p>\n<ul class=\" list-paddingleft-2\">\n<li>\n<p>src/lang/为国际化资源目录,目前提供了英文（en.js）和中文(zh.js)的两种语言实现。</p>\n</li>\n<li>\n<p>目前资源语言资源文件中是json配置主要有以下几个节点：</p>\n</li>\n<ul class=\" list-paddingleft-2\" style=\"list-style-type: square;\">\n<li>\n<p>route 左侧菜单资源</p>\n</li>\n<li>\n<p>navbar 顶部导航栏资源</p>\n</li>\n<li>\n<p>button 公共的按钮资源，比如：添加、删除、修改、确定、取消之类等等</p>\n</li>\n<li>\n<p>common 其他公共的资源，比如一些弹出框标题、提示信息、label等等</p>\n</li>\n<li>\n<p>login 登录页面资源</p>\n</li>\n<li>\n<p>config 参数管理界面资源</p>\n</li>\n</ul>\n<li>\n<p>目前针对具体的页面资源只做了登录和参数管理两个页面，其他具体业务界面仅针对公共的按钮做了国际化，你可以参考config页面资源进行配置进行进一步配置：/src/views/cfg/</p>\n</li>\n<li>\n<p>如果你有其他资源在上面对应的节点添加即可，针对每个页面特有的资源以页面名称作为几点进行维护，这样方便记忆和维护，不容易出错。</p>\n</li>\n</ul>\n<h3>添加新的语言支持</h3>\n<p>如果英文和中文两种语言不够，那么你可以通过下面步骤添加语言支持</p>\n<ul class=\" list-paddingleft-2\">\n<li>\n<p>在src/lang/目录下新增对应的资源文件</p>\n</li>\n<li>\n<p>在src/lang/index.js中import对应的资源文件</p>\n</li>\n<li>\n<p>在src/lang/index.js中的messages变量中加入新的语言声明</p>\n</li>\n<li>\n<p>在src/components/LangSelect/index.vue的语言下拉框中增加新的语言选项</p>\n</li>\n</ul>\n<h3>演示地址</h3>\n<ul class=\" list-paddingleft-2\">\n<li>\n<p>vue版本后台管理&nbsp;<a href=\"http://106.75.35.53:8082/vue/#/login\" target=\"_blank\" rel=\"noopener\">http://106.75.35.53:8082/vue/#/login</a></p>\n</li>\n<li>CMS内容管理系统的h5前端demo:<a href=\"http://106.75.35.53:8082/mobile/#/index\" target=\"_blank\" rel=\"noopener\">http://106.75.35.53:8082/mobile/#/index</a></li>\n</ul>\n</div>', 1, '2', 'web-flash1.0.1 发布，增加国际化和定时任务管理功能', 1, 1, NULL, NULL);
INSERT INTO `articles` VALUES (3, 'enilu.cn', '<div class=\"content\" id=\"articleContent\">\r\n                        <div class=\"ad-wrap\">\r\n                                                    <p style=\"margin:0 0 10px 0;\"><a data-traceid=\"news_detail_above_texlink_1\" data-tracepid=\"news_detail_above_texlink\" style=\"color:#A00;font-weight:bold;\" href=\"https://my.oschina.net/u/3985214/blog/3018099?tdsourcetag=s_pcqq_aiomsg\" target=\"_blank\">开发十年，就只剩下这套架构体系了！ &gt;&gt;&gt;</a>&nbsp;&nbsp;<img src=\"https://www.oschina.net/img/hot3.png\" align=\"\" style=\"max-height: 32px; max-width: 32px;\"></p>\r\n                                    </div>\r\n                        <p>web-flash使用的Spring Boot从1.5.1升级到2.1.1</p><p>下面为升级过程</p><ul class=\" list-paddingleft-2\"><li><p>版本升级</p><pre>&lt;spring.boot.version&gt;2.1.1.RELEASE&lt;/spring.boot.version&gt;\r\n&lt;springframework.version&gt;5.1.3.RELEASE&lt;springframework.version&gt;</pre></li><li><p>配置增加</p><pre>spring.main.allow-bean-definition-overriding=true\r\nspring.jpa.hibernate.use-new-id-generator-mappings=false</pre></li></ul><ul class=\" list-paddingleft-2\"><li><p>审计功能调整，调整后代码:</p><pre>@Configuration\r\npublic&nbsp;class&nbsp;UserIDAuditorConfig&nbsp;implements&nbsp;AuditorAware&lt;Long&gt;&nbsp;{\r\n&nbsp;&nbsp;&nbsp;&nbsp;@Override\r\n&nbsp;&nbsp;&nbsp;&nbsp;public&nbsp;Optional&lt;Long&gt;&nbsp;getCurrentAuditor()&nbsp;{\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ShiroUser&nbsp;shiroUser&nbsp;=&nbsp;ShiroKit.getUser();\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if(shiroUser!=null){\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return&nbsp;Optional.of(shiroUser.getId());\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return&nbsp;null;\r\n&nbsp;&nbsp;&nbsp;&nbsp;}\r\n}</pre></li><li><p>repository调整</p></li><ul class=\" list-paddingleft-2\" style=\"list-style-type: square;\"><li><p>之前的 delete(Long id)方法没有了，替换为：deleteById(Long id)</p></li><li><p>之前的 T findOne(Long id)方法没有了，替换为：		</p><pre>Optional&lt;T&gt;&nbsp;optional&nbsp;=&nbsp;***Repository.findById(id);\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if&nbsp;(optional.isPresent())&nbsp;{\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return&nbsp;optional.get();\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return&nbsp;null;</pre></li></ul><li><p>随着这次Spring Boot的升级也顺便做了一些其他内容的调整和重构</p></li><ul class=\" list-paddingleft-2\" style=\"list-style-type: square;\"><li><p>springframework也从4.3.5.RELEASE升级到5.1.3.RELEASE</p></li><li><p>为减小复杂度service去掉接口和实现类的结构，基础功能的service直接使用实现类；当然具体业务中如果有需求你也可以这没用</p></li><li><p>去掉了一些暂时用不到的maven依赖</p></li><li><p>完善了基础功能的审计功能(之前有介绍审计功能的实现翻番，后续会专门发一篇文档来说明审计功能在系统总的具体用法，当然聪明的你看代码就知道了)</p></li></ul></ul>\r\n                    </div>', 1, '1', 'web-flash 升级 Spring Boot 到 2.1.1 版本', 1, 1, NULL, NULL);
INSERT INTO `articles` VALUES (4, 'enilu.cn', 'H5通用官网系统', 2, '17', 'H5通用官网系统', 1, 1, NULL, NULL);
INSERT INTO `articles` VALUES (5, 'enilu.cn', 'H5通用论坛系统', 2, '18', 'H5通用论坛系统', 1, 1, NULL, NULL);
INSERT INTO `articles` VALUES (6, 'enilu.cn', '官网建设方案', 3, '19', '官网建设方案', 1, 1, NULL, NULL);
INSERT INTO `articles` VALUES (7, 'enilu.cn', '论坛建设方案', 3, '22', '论坛建设方案', 1, 1, NULL, NULL);
INSERT INTO `articles` VALUES (8, 'enilu.cn', '案例1', 4, '3', '案例1', 1, 1, NULL, NULL);
INSERT INTO `articles` VALUES (9, 'enilu.cn', '案例2', 4, '20', '案例2', 1, 1, NULL, NULL);
INSERT INTO `articles` VALUES (14, 'test5', '<p>aaaaa<img class=\"wscnph\" src=\"http://127.0.0.1:8082/file/download?idFile=12\" /></p>', 4, '21', 'IDEA的代码生成插件发布啦', 1, 1, NULL, NULL);
INSERT INTO `articles` VALUES (15, 'enilu', '<p><img class=\"wscnph\" src=\"http://127.0.0.1:8082/file/download?idFile=24\" /></p>', 1, '25', '程序员头冷', 1, 1, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for banners
-- ----------------------------
DROP TABLE IF EXISTS `banners`;
CREATE TABLE `banners` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `file_id` bigint DEFAULT NULL COMMENT 'banner图id',
  `title` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '标题',
  `type` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '类型',
  `url` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '点击banner跳转到url',
  `created_by` bigint DEFAULT NULL COMMENT '创建人',
  `updated_by` bigint DEFAULT NULL COMMENT '最后更新人',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Banner';

-- ----------------------------
-- Records of banners
-- ----------------------------
BEGIN;
INSERT INTO `banners` VALUES (1, 1, '不打开链接', 'index', 'javascript:', 1, NULL, NULL, NULL);
INSERT INTO `banners` VALUES (2, 2, '打打开站内链接', 'index', '/contact', 1, NULL, NULL, NULL);
INSERT INTO `banners` VALUES (3, 6, '打开外部链接', 'index', 'http://www.baidu.com', 1, NULL, NULL, NULL);
INSERT INTO `banners` VALUES (4, 1, '不打开链接', 'product', 'javascript:', 1, NULL, NULL, NULL);
INSERT INTO `banners` VALUES (5, 2, '打打开站内链接', 'product', '/contact', 1, NULL, NULL, NULL);
INSERT INTO `banners` VALUES (6, 6, '打开外部链接', 'product', 'http://www.baidu.com', 1, NULL, NULL, NULL);
INSERT INTO `banners` VALUES (7, 1, '不打开链接', 'solution', 'javascript:', 1, NULL, NULL, NULL);
INSERT INTO `banners` VALUES (8, 2, '打打开站内链接', 'solution', '/contact', 1, NULL, NULL, NULL);
INSERT INTO `banners` VALUES (9, 6, '打开外部链接', 'solution', 'http://www.baidu.com', 1, NULL, NULL, NULL);
INSERT INTO `banners` VALUES (10, 1, '不打开链接', 'case', 'javascript:', 1, NULL, NULL, NULL);
INSERT INTO `banners` VALUES (11, 2, '打打开站内链接', 'case', '/contact', 1, NULL, NULL, NULL);
INSERT INTO `banners` VALUES (12, 6, '打开外部链接', 'case', 'http://www.baidu.com', 1, NULL, NULL, NULL);
INSERT INTO `banners` VALUES (14, 1, '不打开链接', 'news', 'javascript:', 1, NULL, NULL, NULL);
INSERT INTO `banners` VALUES (15, 2, '打打开站内链接', 'news', '/contact', 1, NULL, NULL, NULL);
INSERT INTO `banners` VALUES (16, 6, '打开外部链接', 'news', 'http://www.baidu.com', 1, NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for channels
-- ----------------------------
DROP TABLE IF EXISTS `channels`;
CREATE TABLE `channels` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `code` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '编码',
  `name` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '名称',
  `created_by` bigint DEFAULT NULL COMMENT '创建人',
  `updated_by` bigint DEFAULT NULL COMMENT '最后更新人',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='文章栏目';

-- ----------------------------
-- Records of channels
-- ----------------------------
BEGIN;
INSERT INTO `channels` VALUES (1, 'news', '动态资讯', NULL, NULL, NULL, NULL);
INSERT INTO `channels` VALUES (2, 'product', '产品服务', NULL, NULL, NULL, NULL);
INSERT INTO `channels` VALUES (3, 'solution', '解决方案', NULL, NULL, NULL, NULL);
INSERT INTO `channels` VALUES (4, 'case', '精选案例', NULL, NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for config
-- ----------------------------
DROP TABLE IF EXISTS `config`;
CREATE TABLE `config` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `desc` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '备注',
  `name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '参数名',
  `value` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '参数值',
  `created_by` bigint DEFAULT NULL COMMENT '创建人',
  `updated_by` bigint DEFAULT NULL COMMENT '最后更新人',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统参数';

-- ----------------------------
-- Records of config
-- ----------------------------
BEGIN;
INSERT INTO `config` VALUES (1, 'update by 2020-06-21 21:30:00', 'system.app.name', 'web-flash', NULL, NULL, NULL, NULL);
INSERT INTO `config` VALUES (2, '系统默认上传文件路径', 'system.file.upload.path', '/data/web-flash/runtime/upload', NULL, NULL, NULL, NULL);
INSERT INTO `config` VALUES (3, '腾讯sms接口appid', 'api.tencent.sms.appid', '1400219425', NULL, NULL, NULL, NULL);
INSERT INTO `config` VALUES (4, '腾讯sms接口appkey', 'api.tencent.sms.appkey', '5f71ed5325f3b292946530a1773e997a', NULL, NULL, NULL, NULL);
INSERT INTO `config` VALUES (5, '腾讯sms接口签名参数', 'api.tencent.sms.sign', '需要去申请咯', NULL, NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for contacts
-- ----------------------------
DROP TABLE IF EXISTS `contacts`;
CREATE TABLE `contacts` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `email` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '电子邮箱',
  `mobile` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '联系电话',
  `remark` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `user_name` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '邀约人名称',
  `created_by` bigint DEFAULT NULL COMMENT '创建人',
  `updated_by` bigint DEFAULT NULL COMMENT '最后更新人',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='邀约信息';

-- ----------------------------
-- Records of contacts
-- ----------------------------
BEGIN;
INSERT INTO `contacts` VALUES (1, 'test@qq.com', '15011111111', '测试联系，哈哈哈', '张三', NULL, NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for departments
-- ----------------------------
DROP TABLE IF EXISTS `departments`;
CREATE TABLE `departments` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `fullname` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `num` int DEFAULT NULL,
  `pid` bigint DEFAULT NULL,
  `pids` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `simplename` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tips` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `version` int DEFAULT NULL,
  `created_by` bigint DEFAULT NULL COMMENT '创建人',
  `updated_by` bigint DEFAULT NULL COMMENT '最后更新人',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='部门';

-- ----------------------------
-- Records of departments
-- ----------------------------
BEGIN;
INSERT INTO `departments` VALUES (1, '总公司', 1, 0, '[0],', '总公司', '', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `departments` VALUES (2, '开发部', 2, 1, '[0],[1],', '开发部', '', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `departments` VALUES (3, '运营部', 3, 1, '[0],[1],', '运营部', '', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `departments` VALUES (4, '战略部', 4, 1, '[0],[1],', '战略部', '', NULL, NULL, NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for dictionaries
-- ----------------------------
DROP TABLE IF EXISTS `dictionaries`;
CREATE TABLE `dictionaries` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `num` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pid` bigint DEFAULT NULL,
  `tips` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` bigint DEFAULT NULL COMMENT '创建人',
  `updated_by` bigint DEFAULT NULL COMMENT '最后更新人',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='字典';

-- ----------------------------
-- Records of dictionaries
-- ----------------------------
BEGIN;
INSERT INTO `dictionaries` VALUES (16, '状态', '0', 0, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `dictionaries` VALUES (17, '启用', '1', 16, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `dictionaries` VALUES (18, '禁用', '2', 16, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `dictionaries` VALUES (29, '性别', '0', 0, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `dictionaries` VALUES (30, '男', '1', 29, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `dictionaries` VALUES (31, '女', '2', 29, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `dictionaries` VALUES (35, '账号状态', '0', 0, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `dictionaries` VALUES (36, '启用', '1', 35, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `dictionaries` VALUES (37, '冻结', '2', 35, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `dictionaries` VALUES (38, '已删除', '3', 35, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `dictionaries` VALUES (53, '证件类型', '0', 0, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `dictionaries` VALUES (54, '身份证', '1', 53, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `dictionaries` VALUES (55, '护照', '2', 53, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `dictionaries` VALUES (68, '是否', '0', 0, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `dictionaries` VALUES (69, '是', '1', 68, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `dictionaries` VALUES (70, '否', '0', 68, NULL, NULL, NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for file_info
-- ----------------------------
DROP TABLE IF EXISTS `file_info`;
CREATE TABLE `file_info` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `original_file_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `real_file_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` bigint DEFAULT NULL COMMENT '创建人',
  `updated_by` bigint DEFAULT NULL COMMENT '最后更新人',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='文件';

-- ----------------------------
-- Records of file_info
-- ----------------------------
BEGIN;
INSERT INTO `file_info` VALUES (1, 'banner1.png', '7e9ebc08-b194-4f85-8997-d97ccb0d2c2d.png', NULL, NULL, NULL, NULL);
INSERT INTO `file_info` VALUES (2, 'banner2.png', '756b9ca8-562f-4bf5-a577-190dcdd25c29.png', NULL, NULL, NULL, NULL);
INSERT INTO `file_info` VALUES (3, 'offcial_site.png', 'b0304e2b-0ee3-4966-ac9f-a075b13d4af6.png', NULL, NULL, NULL, NULL);
INSERT INTO `file_info` VALUES (4, 'bbs.png', '67486aa5-500c-4993-87ad-7e1fbc90ac1a.png', NULL, NULL, NULL, NULL);
INSERT INTO `file_info` VALUES (5, 'product.png', '1f2b05e0-403a-41e0-94a2-465f0c986b78.png', NULL, NULL, NULL, NULL);
INSERT INTO `file_info` VALUES (6, 'profile.jpg', '40ead888-14d1-4e9f-abb3-5bfb056a966a.jpg', NULL, NULL, NULL, NULL);
INSERT INTO `file_info` VALUES (7, '2303938_1453211.png', '87b037da-b517-4007-a66e-ba7cc8cfd6ea.png', NULL, NULL, NULL, NULL);
INSERT INTO `file_info` VALUES (8, 'login.png', '26835cc4-059e-4900-aff5-a41f2ea6a61d.png', NULL, NULL, NULL, NULL);
INSERT INTO `file_info` VALUES (9, 'login.png', '7ec7553b-7c9e-44d9-b9c2-3d89b11cf842.png', NULL, NULL, NULL, NULL);
INSERT INTO `file_info` VALUES (10, 'login.png', '357c4aad-19fd-4600-9fb6-e62aafa3df25.png', NULL, NULL, NULL, NULL);
INSERT INTO `file_info` VALUES (11, 'index.png', '55dd582b-033e-440d-8e8d-c8d39d01f1bb.png', NULL, NULL, NULL, NULL);
INSERT INTO `file_info` VALUES (12, 'login.png', '70507c07-e8bc-492f-9f0a-00bf1c23e329.png', NULL, NULL, NULL, NULL);
INSERT INTO `file_info` VALUES (13, 'index.png', 'cd539518-d15a-4cda-a19f-251169f5d1a4.png', NULL, NULL, NULL, NULL);
INSERT INTO `file_info` VALUES (14, 'login.png', '194c8a38-be94-483c-8875-3c62a857ead7.png', NULL, NULL, NULL, NULL);
INSERT INTO `file_info` VALUES (15, 'index.png', '6a6cb215-d0a7-4574-a45e-5fa04dcfdf90.png', NULL, NULL, NULL, NULL);
INSERT INTO `file_info` VALUES (16, '测试文档.doc', 'd9d77815-496f-475b-a0f8-1d6dcb86e6ab.doc', NULL, NULL, NULL, NULL);
INSERT INTO `file_info` VALUES (17, '首页.png', 'd5aba978-f8af-45c5-b079-673decfbdf26.png', NULL, NULL, NULL, NULL);
INSERT INTO `file_info` VALUES (18, '资讯.png', '7e07520d-5b73-4712-800b-16f88d133db2.png', NULL, NULL, NULL, NULL);
INSERT INTO `file_info` VALUES (19, '产品服务.png', '99214651-8cb8-4488-b572-12c6aa21f30a.png', NULL, NULL, NULL, NULL);
INSERT INTO `file_info` VALUES (20, '67486aa5-500c-4993-87ad-7e1fbc90ac1a.png', '31fdc83e-7688-41f5-b153-b6816d5dfb06.png', NULL, NULL, NULL, NULL);
INSERT INTO `file_info` VALUES (21, '67486aa5-500c-4993-87ad-7e1fbc90ac1a.png', 'ffaf0563-3115-477b-b31d-47a4e80a75eb.png', NULL, NULL, NULL, NULL);
INSERT INTO `file_info` VALUES (22, '7e07520d-5b73-4712-800b-16f88d133db2.png', '8928e5d4-933a-4953-9507-f60b78e3ccee.png', NULL, NULL, NULL, NULL);
INSERT INTO `file_info` VALUES (23, '756b9ca8-562f-4bf5-a577-190dcdd25c29.png', '7d64ba36-adc4-4982-9ec2-8c68db68861b.png', NULL, NULL, NULL, NULL);
INSERT INTO `file_info` VALUES (24, 'timg.jpg', '6483eb26-775c-4fe2-81bf-8dd49ac9b6b1.jpg', NULL, NULL, NULL, NULL);
INSERT INTO `file_info` VALUES (25, 'timg.jpg', '7fe918a2-c59a-4d17-ad77-f65dd4e163bf.jpg', NULL, NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for login_logs
-- ----------------------------
DROP TABLE IF EXISTS `login_logs`;
CREATE TABLE `login_logs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ip` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `logname` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `message` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `succeed` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `created_by` bigint DEFAULT NULL COMMENT '创建人',
  `updated_by` bigint DEFAULT NULL COMMENT '最后更新人',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='登录日志';

-- ----------------------------
-- Records of login_logs
-- ----------------------------
BEGIN;
INSERT INTO `login_logs` VALUES (71, '127.0.0.1', '登录日志', NULL, '成功', 1, NULL, NULL, NULL, NULL);
INSERT INTO `login_logs` VALUES (72, '127.0.0.1', '登录日志', NULL, '成功', 1, NULL, NULL, NULL, NULL);
INSERT INTO `login_logs` VALUES (73, '127.0.0.1', '登录日志', NULL, '成功', 1, NULL, NULL, NULL, NULL);
INSERT INTO `login_logs` VALUES (74, '127.0.0.1', '登录日志', NULL, '成功', 1, NULL, NULL, NULL, NULL);
INSERT INTO `login_logs` VALUES (75, '127.0.0.1', '登录日志', NULL, '成功', 1, NULL, NULL, NULL, NULL);
INSERT INTO `login_logs` VALUES (76, '127.0.0.1', '登录日志', NULL, '成功', 1, NULL, NULL, NULL, NULL);
INSERT INTO `login_logs` VALUES (77, '127.0.0.1', '登录日志', NULL, '成功', 1, NULL, NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for menus
-- ----------------------------
DROP TABLE IF EXISTS `menus`;
CREATE TABLE `menus` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `code` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '编号',
  `component` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '页面组件',
  `hidden` tinyint DEFAULT NULL COMMENT '是否隐藏',
  `icon` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '图标',
  `ismenu` int NOT NULL COMMENT '是否是菜单1:菜单,0:按钮',
  `isopen` int DEFAULT NULL COMMENT '是否默认打开1:是,0:否',
  `levels` int NOT NULL COMMENT '级别',
  `name` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '名称',
  `num` int NOT NULL COMMENT '顺序',
  `pcode` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '父菜单编号',
  `pcodes` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '递归父级菜单编号',
  `status` int NOT NULL COMMENT '状态1:启用,0:禁用',
  `tips` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '鼠标悬停提示信息',
  `url` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '链接标识',
  `created_by` bigint DEFAULT NULL COMMENT '创建人',
  `updated_by` bigint DEFAULT NULL COMMENT '最后更新人',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `UK_s37unj3gh67ujhk83lqva8i1t` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='菜单';

-- ----------------------------
-- Records of menus
-- ----------------------------
BEGIN;
INSERT INTO `menus` VALUES (1, 'system', 'layout', 0, 'system', 1, 1, 1, '系统管理', 1, '0', '[0],', 1, NULL, '/system', NULL, NULL, NULL, NULL);
INSERT INTO `menus` VALUES (2, 'cms', 'layout', 0, 'documentation', 1, NULL, 1, 'CMS管理', 3, '0', '[0],', 1, NULL, '/cms', NULL, NULL, NULL, NULL);
INSERT INTO `menus` VALUES (3, 'operationMgr', 'layout', 0, 'operation', 1, NULL, 1, '运维管理', 2, '0', '[0],', 1, NULL, '/optionMgr', NULL, NULL, NULL, NULL);
INSERT INTO `menus` VALUES (4, 'mgr', 'views/system/user/index', 0, 'user', 1, NULL, 2, '用户管理', 1, 'system', '[0],[system],', 1, NULL, '/mgr', NULL, NULL, NULL, NULL);
INSERT INTO `menus` VALUES (5, 'mgrAdd', NULL, 0, NULL, 0, NULL, 3, '添加用户', 1, 'mgr', '[0],[system],[mgr],', 1, NULL, '/mgr/add', NULL, NULL, NULL, NULL);
INSERT INTO `menus` VALUES (6, 'mgrEdit', NULL, 0, NULL, 0, NULL, 3, '修改用户', 2, 'mgr', '[0],[system],[mgr],', 1, NULL, '/mgr/edit', NULL, NULL, NULL, NULL);
INSERT INTO `menus` VALUES (7, 'mgrDelete', NULL, 0, NULL, 0, 0, 3, '删除用户', 3, 'mgr', '[0],[system],[mgr],', 1, NULL, '/mgr/delete', NULL, NULL, NULL, NULL);
INSERT INTO `menus` VALUES (8, 'mgrReset', NULL, 0, NULL, 0, 0, 3, '重置密码', 4, 'mgr', '[0],[system],[mgr],', 1, NULL, '/mgr/reset', NULL, NULL, NULL, NULL);
INSERT INTO `menus` VALUES (9, 'setRole', NULL, 0, NULL, 0, 0, 3, '分配角色', 5, 'mgr', '[0],[system],[mgr],', 1, NULL, '/mgr/setRole', NULL, NULL, NULL, NULL);
INSERT INTO `menus` VALUES (10, 'mgrUnfreeze', NULL, 0, NULL, 0, 0, 3, '解除冻结用户', 6, 'mgr', '[0],[system],[mgr],', 1, NULL, '/mgr/unfreeze', NULL, NULL, NULL, NULL);
INSERT INTO `menus` VALUES (11, 'mgrSetRole', NULL, 0, NULL, 0, 0, 3, '分配角色', 7, 'mgr', '[0],[system],[mgr],', 1, NULL, '/mgr/setRole', NULL, NULL, NULL, NULL);
INSERT INTO `menus` VALUES (12, 'role', 'views/system/role/index', 0, 'peoples', 1, 0, 2, '角色管理', 2, 'system', '[0],[system],', 1, NULL, '/role', NULL, NULL, NULL, NULL);
INSERT INTO `menus` VALUES (13, 'roleAdd', NULL, 0, NULL, 0, 0, 3, '添加角色', 1, 'role', '[0],[system],[role],', 1, NULL, '/role/add', NULL, NULL, NULL, NULL);
INSERT INTO `menus` VALUES (14, 'roleEdit', NULL, 0, NULL, 0, 0, 3, '修改角色', 2, 'role', '[0],[system],[role],', 1, NULL, '/role/edit', NULL, NULL, NULL, NULL);
INSERT INTO `menus` VALUES (15, 'roleDelete', NULL, 0, NULL, 0, 0, 3, '删除角色', 3, 'role', '[0],[system],[role],', 1, NULL, '/role/remove', NULL, NULL, NULL, NULL);
INSERT INTO `menus` VALUES (16, 'roleSetAuthority', NULL, 0, NULL, 0, 0, 3, '配置权限', 4, 'role', '[0],[system],[role],', 1, NULL, '/role/setAuthority', NULL, NULL, NULL, NULL);
INSERT INTO `menus` VALUES (17, 'menu', 'views/system/menu/index', 0, 'menu', 1, 0, 2, '菜单管理', 4, 'system', '[0],[system],', 1, NULL, '/menu', NULL, NULL, NULL, NULL);
INSERT INTO `menus` VALUES (18, 'menuAdd', NULL, 0, NULL, 0, 0, 3, '添加菜单', 1, 'menu', '[0],[system],[menu],', 1, NULL, '/menu/add', NULL, NULL, NULL, NULL);
INSERT INTO `menus` VALUES (19, 'menuEdit', NULL, 0, NULL, 0, 0, 3, '修改菜单', 2, 'menu', '[0],[system],[menu],', 1, NULL, '/menu/edit', NULL, NULL, NULL, NULL);
INSERT INTO `menus` VALUES (20, 'menuDelete', NULL, 0, NULL, 0, 0, 3, '删除菜单', 3, 'menu', '[0],[system],[menu],', 1, NULL, '/menu/remove', NULL, NULL, NULL, NULL);
INSERT INTO `menus` VALUES (21, 'dept', 'views/system/dept/index', 0, 'dept', 1, NULL, 2, '部门管理', 3, 'system', '[0],[system],', 1, NULL, '/dept', NULL, NULL, NULL, NULL);
INSERT INTO `menus` VALUES (22, 'dict', 'views/system/dict/index', 0, 'dict', 1, NULL, 2, '字典管理', 4, 'system', '[0],[system],', 1, NULL, '/dict', NULL, NULL, NULL, NULL);
INSERT INTO `menus` VALUES (23, 'deptEdit', NULL, 0, NULL, 0, NULL, 3, '修改部门', 1, 'dept', '[0],[system],[dept],', 1, NULL, '/dept/update', NULL, NULL, NULL, NULL);
INSERT INTO `menus` VALUES (24, 'deptDelete', NULL, 0, NULL, 0, NULL, 3, '删除部门', 1, 'dept', '[0],[system],[dept],', 1, NULL, '/dept/delete', NULL, NULL, NULL, NULL);
INSERT INTO `menus` VALUES (25, 'dictAdd', NULL, 0, NULL, 0, NULL, 3, '添加字典', 1, 'dict', '[0],[system],[dict],', 1, NULL, '/dict/add', NULL, NULL, NULL, NULL);
INSERT INTO `menus` VALUES (26, 'dictEdit', NULL, 0, NULL, 0, NULL, 3, '修改字典', 1, 'dict', '[0],[system],[dict],', 1, NULL, '/dict/update', NULL, NULL, NULL, NULL);
INSERT INTO `menus` VALUES (27, 'dictDelete', NULL, 0, NULL, 0, NULL, 3, '删除字典', 1, 'dict', '[0],[system],[dict],', 1, NULL, '/dict/delete', NULL, NULL, NULL, NULL);
INSERT INTO `menus` VALUES (28, 'deptList', NULL, 0, NULL, 0, NULL, 3, '部门列表', 5, 'dept', '[0],[system],[dept],', 1, NULL, '/dept/list', NULL, NULL, NULL, NULL);
INSERT INTO `menus` VALUES (29, 'deptDetail', NULL, 0, NULL, 0, NULL, 3, '部门详情', 6, 'dept', '[0],[system],[dept],', 1, NULL, '/dept/detail', NULL, NULL, NULL, NULL);
INSERT INTO `menus` VALUES (30, 'dictList', NULL, 0, NULL, 0, NULL, 3, '字典列表', 5, 'dict', '[0],[system],[dict],', 1, NULL, '/dict/list', NULL, NULL, NULL, NULL);
INSERT INTO `menus` VALUES (31, 'dictDetail', NULL, 0, NULL, 0, NULL, 3, '字典详情', 6, 'dict', '[0],[system],[dict],', 1, NULL, '/dict/detail', NULL, NULL, NULL, NULL);
INSERT INTO `menus` VALUES (32, 'deptAdd', NULL, 0, NULL, 0, NULL, 3, '添加部门', 1, 'dept', '[0],[system],[dept],', 1, NULL, '/dept/add', NULL, NULL, NULL, NULL);
INSERT INTO `menus` VALUES (33, 'cfg', 'views/system/cfg/index', 0, 'cfg', 1, NULL, 2, '参数管理', 10, 'system', '[0],[system],', 1, NULL, '/cfg', NULL, NULL, NULL, NULL);
INSERT INTO `menus` VALUES (34, 'cfgAdd', NULL, 0, NULL, 0, NULL, 3, '添加参数', 1, 'cfg', '[0],[system],[cfg],', 1, NULL, '/cfg/add', NULL, NULL, NULL, NULL);
INSERT INTO `menus` VALUES (35, 'cfgEdit', NULL, 0, NULL, 0, NULL, 3, '修改参数', 2, 'cfg', '[0],[system],[cfg],', 1, NULL, '/cfg/update', NULL, NULL, NULL, NULL);
INSERT INTO `menus` VALUES (36, 'cfgDelete', NULL, 0, NULL, 0, NULL, 3, '删除参数', 3, 'cfg', '[0],[system],[cfg],', 1, NULL, '/cfg/delete', NULL, NULL, NULL, NULL);
INSERT INTO `menus` VALUES (37, 'task', 'views/system/task/index', 0, 'task', 1, NULL, 2, '任务管理', 11, 'system', '[0],[system],', 1, NULL, '/task', NULL, NULL, NULL, NULL);
INSERT INTO `menus` VALUES (38, 'taskAdd', NULL, 0, NULL, 0, NULL, 3, '添加任务', 1, 'task', '[0],[system],[task],', 1, NULL, '/task/add', NULL, NULL, NULL, NULL);
INSERT INTO `menus` VALUES (39, 'taskEdit', NULL, 0, NULL, 0, NULL, 3, '修改任务', 2, 'task', '[0],[system],[task],', 1, NULL, '/task/update', NULL, NULL, NULL, NULL);
INSERT INTO `menus` VALUES (40, 'taskDelete', NULL, 0, NULL, 0, NULL, 3, '删除任务', 3, 'task', '[0],[system],[task],', 1, NULL, '/task/delete', NULL, NULL, NULL, NULL);
INSERT INTO `menus` VALUES (41, 'channel', 'views/cms/channel/index', 0, 'channel', 1, NULL, 2, '栏目管理', 1, 'cms', '[0],[cms],', 1, NULL, '/channel', NULL, NULL, NULL, NULL);
INSERT INTO `menus` VALUES (42, 'article', 'views/cms/article/index', 0, 'documentation', 1, NULL, 2, '文章管理', 2, 'cms', '[0],[cms],', 1, NULL, '/article', NULL, NULL, NULL, NULL);
INSERT INTO `menus` VALUES (43, 'banner', 'views/cms/banner/index', 0, 'banner', 1, NULL, 2, 'banner管理', 3, 'cms', '[0],[cms],', 1, NULL, '/banner', NULL, NULL, NULL, NULL);
INSERT INTO `menus` VALUES (44, 'contacts', 'views/cms/contacts/index', 0, 'contacts', 1, NULL, 2, '邀约管理', 4, 'cms', '[0],[cms],', 1, NULL, '/contacts', NULL, NULL, NULL, NULL);
INSERT INTO `menus` VALUES (45, 'file', 'views/cms/file/index', 0, 'file', 1, NULL, 2, '文件管理', 5, 'cms', '[0],[cms],', 1, NULL, '/fileMgr', NULL, NULL, NULL, NULL);
INSERT INTO `menus` VALUES (46, 'editArticle', 'views/cms/article/edit.vue', 0, 'articleEdit', 1, NULL, 2, '新建文章', 1, 'cms', '[0],[cms],', 1, NULL, '/cms/articleEdit', NULL, NULL, NULL, NULL);
INSERT INTO `menus` VALUES (47, 'taskLog', 'views/system/task/taskLog', 1, 'task', 1, NULL, 2, '任务日志', 4, 'system', '[0],[system],', 1, NULL, '/taskLog', NULL, NULL, NULL, NULL);
INSERT INTO `menus` VALUES (48, 'log', 'views/operation/log/index', 0, 'log', 1, NULL, 2, '业务日志', 6, 'operationMgr', '[0],[operationMgr],', 1, NULL, '/log', NULL, NULL, NULL, NULL);
INSERT INTO `menus` VALUES (49, 'loginLog', 'views/operation/loginLog/index', 0, 'logininfor', 1, NULL, 2, '登录日志', 6, 'operationMgr', '[0],[operationMgr],', 1, NULL, '/loginLog', NULL, NULL, NULL, NULL);
INSERT INTO `menus` VALUES (50, 'logClear', NULL, 0, NULL, 0, NULL, 3, '清空日志', 3, 'log', '[0],[system],[log],', 1, NULL, '/log/delLog', NULL, NULL, NULL, NULL);
INSERT INTO `menus` VALUES (51, 'logDetail', NULL, 0, NULL, 0, NULL, 3, '日志详情', 3, 'log', '[0],[system],[log],', 1, NULL, '/log/detail', NULL, NULL, NULL, NULL);
INSERT INTO `menus` VALUES (52, 'loginLogClear', NULL, 0, NULL, 0, NULL, 3, '清空登录日志', 1, 'loginLog', '[0],[system],[loginLog],', 1, NULL, '/loginLog/delLoginLog', NULL, NULL, NULL, NULL);
INSERT INTO `menus` VALUES (53, 'loginLogList', NULL, 0, NULL, 0, NULL, 3, '登录日志列表', 2, 'loginLog', '[0],[system],[loginLog],', 1, NULL, '/loginLog/list', NULL, NULL, NULL, NULL);
INSERT INTO `menus` VALUES (54, 'druid', 'views/operation/druid/index', 0, 'monitor', 1, NULL, 2, '数据库管理', 1, 'operationMgr', '[0],[operationMgr],', 1, NULL, '/druid', NULL, NULL, NULL, NULL);
INSERT INTO `menus` VALUES (55, 'swagger', 'views/operation/api/index', 0, 'swagger', 1, NULL, 2, '接口文档', 2, 'operationMgr', '[0],[operationMgr],', 1, NULL, '/swagger', NULL, NULL, NULL, NULL);
INSERT INTO `menus` VALUES (56, 'messageMgr', 'layout', 0, 'message', 1, NULL, 1, '消息管理', 4, '0', '[0],', 1, NULL, '/message', NULL, NULL, NULL, NULL);
INSERT INTO `menus` VALUES (57, 'msg', 'views/message/message/index', 0, 'message', 1, NULL, 2, '历史消息', 1, 'messageMgr', '[0],[messageMgr],', 1, NULL, '/history', NULL, NULL, NULL, NULL);
INSERT INTO `menus` VALUES (58, 'msgTpl', 'views/message/template/index', 0, 'template', 1, NULL, 2, '消息模板', 2, 'messageMgr', '[0],[messageMgr],', 1, NULL, '/template', NULL, NULL, NULL, NULL);
INSERT INTO `menus` VALUES (59, 'msgSender', 'views/message/sender/index', 0, 'sender', 1, NULL, 2, '消息发送者', 3, 'messageMgr', '[0],[messageMgr],', 1, NULL, '/sender', NULL, NULL, NULL, NULL);
INSERT INTO `menus` VALUES (60, 'msgClear', NULL, 0, NULL, 1, NULL, 2, '清空历史消息', 3, 'messageMgr', '[0],[messageMgr],', 1, NULL, '/message/clear', NULL, NULL, NULL, NULL);
INSERT INTO `menus` VALUES (61, 'msgTplEdit', NULL, 0, NULL, 0, NULL, 3, '编辑模板', 1, 'msgTpl', '[0],[messageMgr],[msgTpl]', 1, NULL, '/template/edit', NULL, NULL, NULL, NULL);
INSERT INTO `menus` VALUES (62, 'msgTplDelete', NULL, 0, NULL, 0, NULL, 3, '删除模板', 2, 'msgTpl', '[0],[messageMgr],[msgTpl]', 1, NULL, '/template/remove', NULL, NULL, NULL, NULL);
INSERT INTO `menus` VALUES (63, 'msgSenderEdit', NULL, 0, NULL, 0, NULL, 3, '编辑发送器', 1, 'msgSender', '[0],[messageMgr],[msgSender]', 1, NULL, '/sender/edit', NULL, NULL, NULL, NULL);
INSERT INTO `menus` VALUES (64, 'msgSenderDelete', NULL, 0, NULL, 0, NULL, 3, '删除发送器', 2, 'msgSender', '[0],[messageMgr],[msgSender]', 1, NULL, '/sender/remove', NULL, NULL, NULL, NULL);
INSERT INTO `menus` VALUES (65, 'fileUpload', NULL, 0, NULL, 0, NULL, 3, '上传文件', 1, 'file', '[0],[cms],[file],', 1, NULL, '/file/upload', NULL, NULL, NULL, NULL);
INSERT INTO `menus` VALUES (66, 'bannerEdit', NULL, 0, NULL, 0, NULL, 3, '编辑banner', 1, 'banner', '[0],[cms],[banner],', 1, NULL, '/banner/edit', NULL, NULL, NULL, NULL);
INSERT INTO `menus` VALUES (67, 'bannerDelete', NULL, 0, NULL, 0, NULL, 3, '删除banner', 2, 'banner', '[0],[cms],[banner],', 1, NULL, '/banner/remove', NULL, NULL, NULL, NULL);
INSERT INTO `menus` VALUES (68, 'channelEdit', NULL, 0, NULL, 0, NULL, 3, '编辑栏目', 1, 'channel', '[0],[cms],[channel],', 1, NULL, '/channel/edit', NULL, NULL, NULL, NULL);
INSERT INTO `menus` VALUES (69, 'channelDelete', NULL, 0, NULL, 0, NULL, 3, '删除栏目', 2, 'channel', '[0],[cms],[channel],', 1, NULL, '/channel/remove', NULL, NULL, NULL, NULL);
INSERT INTO `menus` VALUES (70, 'deleteArticle', NULL, 0, NULL, 0, NULL, 3, '删除文章', 2, 'article', '[0],[cms],[article]', 1, NULL, '/article/remove', NULL, NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for message_senders
-- ----------------------------
DROP TABLE IF EXISTS `message_senders`;
CREATE TABLE `message_senders` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `class_name` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '发送类',
  `name` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '名称',
  `tpl_code` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '短信运营商模板编号',
  `created_by` bigint DEFAULT NULL COMMENT '创建人',
  `updated_by` bigint DEFAULT NULL COMMENT '最后更新人',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='消息发送者';

-- ----------------------------
-- Records of message_senders
-- ----------------------------
BEGIN;
INSERT INTO `message_senders` VALUES (1, 'tencentSmsSender', ' 腾讯短信服务', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `message_senders` VALUES (2, 'defaultEmailSender', '默认邮件发送器', NULL, NULL, NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for message_templates
-- ----------------------------
DROP TABLE IF EXISTS `message_templates`;
CREATE TABLE `message_templates` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `code` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '编号',
  `cond` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '发送条件',
  `content` text COLLATE utf8mb4_unicode_ci COMMENT '内容',
  `message_sender_id` bigint NOT NULL COMMENT '发送者id',
  `title` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '标题',
  `type` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '消息类型,0:短信,1:邮件',
  `created_by` bigint DEFAULT NULL COMMENT '创建人',
  `updated_by` bigint DEFAULT NULL COMMENT '最后更新人',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='消息模板';

-- ----------------------------
-- Records of message_templates
-- ----------------------------
BEGIN;
INSERT INTO `message_templates` VALUES (1, 'REGISTER_CODE', '注册页面，点击获取验证码', '【腾讯云】校验码{1}，请于5分钟内完成验证，如非本人操作请忽略本短信。', 1, '注册验证码', '0', NULL, NULL, NULL, NULL);
INSERT INTO `message_templates` VALUES (2, 'EMAIL_TEST', '测试发送', '你好:{1},欢迎使用{2}', 2, '测试邮件', '1', NULL, NULL, NULL, NULL);
INSERT INTO `message_templates` VALUES (3, 'EMAIL_HTML_TEMPLATE_TEST', '测试发送模板邮件', '你好<strong>${userName}</strong>欢迎使用<font color=\"red\">${appName}</font>,这是html模板邮件', 2, '测试发送模板邮件', '1', NULL, NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for messages
-- ----------------------------
DROP TABLE IF EXISTS `messages`;
CREATE TABLE `messages` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `content` text COLLATE utf8mb4_unicode_ci COMMENT '消息内容',
  `receiver` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '接收者',
  `state` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '消息类型,0:初始,1:成功,2:失败',
  `tpl_code` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '模板编码',
  `type` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '消息类型,0:短信,1:邮件',
  `created_by` bigint DEFAULT NULL COMMENT '创建人',
  `updated_by` bigint DEFAULT NULL COMMENT '最后更新人',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='历史消息';

-- ----------------------------
-- Records of messages
-- ----------------------------
BEGIN;
INSERT INTO `messages` VALUES (1, '【腾讯云】校验码1032，请于5分钟内完成验证，如非本人操作请忽略本短信。', '15011112222', '2', 'REGISTER_CODE', '0', NULL, NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for notices
-- ----------------------------
DROP TABLE IF EXISTS `notices`;
CREATE TABLE `notices` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `content` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` int DEFAULT NULL,
  `created_by` bigint DEFAULT NULL COMMENT '创建人',
  `updated_by` bigint DEFAULT NULL COMMENT '最后更新人',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='通知';

-- ----------------------------
-- Records of notices
-- ----------------------------
BEGIN;
INSERT INTO `notices` VALUES (1, '欢迎使用web-flash后台管理系统', '欢迎光临', 10, NULL, NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for operation_logs
-- ----------------------------
DROP TABLE IF EXISTS `operation_logs`;
CREATE TABLE `operation_logs` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `classname` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `logname` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `logtype` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `message` text COLLATE utf8mb4_unicode_ci COMMENT '详细信息',
  `method` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `succeed` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `userid` int DEFAULT NULL,
  `created_by` bigint DEFAULT NULL COMMENT '创建人',
  `updated_by` bigint DEFAULT NULL COMMENT '最后更新人',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='操作日志';

-- ----------------------------
-- Records of operation_logs
-- ----------------------------
BEGIN;
INSERT INTO `operation_logs` VALUES (1, 'cn.enilu.flash.api.controller.cms.ArticleMgrController', '添加参数', '业务日志', '参数名称=system.app.name', 'upload', '成功', 1, NULL, NULL, NULL, NULL);
INSERT INTO `operation_logs` VALUES (2, 'cn.enilu.flash.api.controller.cms.ArticleMgrController', '修改参数', '业务日志', '参数名称=system.app.name', 'upload', '成功', 1, NULL, NULL, NULL, NULL);
INSERT INTO `operation_logs` VALUES (3, 'cn.enilu.flash.api.controller.cms.ArticleMgrController', '编辑文章', '业务日志', '参数名称=system.app.name', 'upload', '成功', 1, NULL, NULL, NULL, NULL);
INSERT INTO `operation_logs` VALUES (4, 'cn.enilu.flash.api.controller.cms.ArticleMgrController', '编辑栏目', '业务日志', '参数名称=system.app.name', 'upload', '成功', 1, NULL, NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for relations
-- ----------------------------
DROP TABLE IF EXISTS `relations`;
CREATE TABLE `relations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `menu_id` bigint DEFAULT NULL,
  `role_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=144 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='菜单角色关系';

-- ----------------------------
-- Records of relations
-- ----------------------------
BEGIN;
INSERT INTO `relations` VALUES (1, 42, 1);
INSERT INTO `relations` VALUES (2, 70, 1);
INSERT INTO `relations` VALUES (3, 46, 1);
INSERT INTO `relations` VALUES (4, 43, 1);
INSERT INTO `relations` VALUES (5, 67, 1);
INSERT INTO `relations` VALUES (6, 66, 1);
INSERT INTO `relations` VALUES (7, 33, 1);
INSERT INTO `relations` VALUES (8, 34, 1);
INSERT INTO `relations` VALUES (9, 36, 1);
INSERT INTO `relations` VALUES (10, 35, 1);
INSERT INTO `relations` VALUES (11, 41, 1);
INSERT INTO `relations` VALUES (12, 69, 1);
INSERT INTO `relations` VALUES (13, 68, 1);
INSERT INTO `relations` VALUES (14, 2, 1);
INSERT INTO `relations` VALUES (15, 44, 1);
INSERT INTO `relations` VALUES (16, 21, 1);
INSERT INTO `relations` VALUES (17, 32, 1);
INSERT INTO `relations` VALUES (18, 24, 1);
INSERT INTO `relations` VALUES (19, 29, 1);
INSERT INTO `relations` VALUES (20, 23, 1);
INSERT INTO `relations` VALUES (21, 28, 1);
INSERT INTO `relations` VALUES (22, 22, 1);
INSERT INTO `relations` VALUES (23, 25, 1);
INSERT INTO `relations` VALUES (24, 27, 1);
INSERT INTO `relations` VALUES (25, 31, 1);
INSERT INTO `relations` VALUES (26, 26, 1);
INSERT INTO `relations` VALUES (27, 30, 1);
INSERT INTO `relations` VALUES (28, 54, 1);
INSERT INTO `relations` VALUES (29, 45, 1);
INSERT INTO `relations` VALUES (30, 65, 1);
INSERT INTO `relations` VALUES (31, 48, 1);
INSERT INTO `relations` VALUES (32, 50, 1);
INSERT INTO `relations` VALUES (33, 51, 1);
INSERT INTO `relations` VALUES (34, 49, 1);
INSERT INTO `relations` VALUES (35, 52, 1);
INSERT INTO `relations` VALUES (36, 53, 1);
INSERT INTO `relations` VALUES (37, 17, 1);
INSERT INTO `relations` VALUES (38, 18, 1);
INSERT INTO `relations` VALUES (39, 20, 1);
INSERT INTO `relations` VALUES (40, 19, 1);
INSERT INTO `relations` VALUES (41, 56, 1);
INSERT INTO `relations` VALUES (42, 4, 1);
INSERT INTO `relations` VALUES (43, 5, 1);
INSERT INTO `relations` VALUES (44, 7, 1);
INSERT INTO `relations` VALUES (45, 6, 1);
INSERT INTO `relations` VALUES (46, 9, 1);
INSERT INTO `relations` VALUES (47, 8, 1);
INSERT INTO `relations` VALUES (48, 11, 1);
INSERT INTO `relations` VALUES (49, 10, 1);
INSERT INTO `relations` VALUES (50, 57, 1);
INSERT INTO `relations` VALUES (51, 60, 1);
INSERT INTO `relations` VALUES (52, 59, 1);
INSERT INTO `relations` VALUES (53, 64, 1);
INSERT INTO `relations` VALUES (54, 63, 1);
INSERT INTO `relations` VALUES (55, 58, 1);
INSERT INTO `relations` VALUES (56, 62, 1);
INSERT INTO `relations` VALUES (57, 61, 1);
INSERT INTO `relations` VALUES (58, 3, 1);
INSERT INTO `relations` VALUES (59, 12, 1);
INSERT INTO `relations` VALUES (60, 13, 1);
INSERT INTO `relations` VALUES (61, 15, 1);
INSERT INTO `relations` VALUES (62, 14, 1);
INSERT INTO `relations` VALUES (63, 16, 1);
INSERT INTO `relations` VALUES (64, 55, 1);
INSERT INTO `relations` VALUES (65, 1, 1);
INSERT INTO `relations` VALUES (66, 37, 1);
INSERT INTO `relations` VALUES (67, 38, 1);
INSERT INTO `relations` VALUES (68, 40, 1);
INSERT INTO `relations` VALUES (69, 39, 1);
INSERT INTO `relations` VALUES (70, 47, 1);
INSERT INTO `relations` VALUES (128, 41, 2);
INSERT INTO `relations` VALUES (129, 42, 2);
INSERT INTO `relations` VALUES (130, 43, 2);
INSERT INTO `relations` VALUES (131, 44, 2);
INSERT INTO `relations` VALUES (132, 45, 2);
INSERT INTO `relations` VALUES (133, 46, 2);
INSERT INTO `relations` VALUES (134, 65, 2);
INSERT INTO `relations` VALUES (135, 66, 2);
INSERT INTO `relations` VALUES (136, 67, 2);
INSERT INTO `relations` VALUES (137, 68, 2);
INSERT INTO `relations` VALUES (138, 69, 2);
INSERT INTO `relations` VALUES (139, 70, 2);
INSERT INTO `relations` VALUES (143, 2, 2);
COMMIT;

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `department_id` bigint DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `num` int DEFAULT NULL,
  `pid` bigint DEFAULT NULL,
  `tips` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `version` int DEFAULT NULL,
  `created_by` bigint DEFAULT NULL COMMENT '创建人',
  `updated_by` bigint DEFAULT NULL COMMENT '最后更新人',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='角色';

-- ----------------------------
-- Records of roles
-- ----------------------------
BEGIN;
INSERT INTO `roles` VALUES (1, 24, '超级管理员', 1, 0, 'administrator', 1, NULL, NULL, NULL, NULL);
INSERT INTO `roles` VALUES (2, 25, '网站管理员', 1, 1, 'developer', NULL, NULL, NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for task_logs
-- ----------------------------
DROP TABLE IF EXISTS `task_logs`;
CREATE TABLE `task_logs` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `exec_at` datetime DEFAULT NULL COMMENT '执行时间',
  `exec_success` int DEFAULT NULL COMMENT '执行结果（成功:1、失败:0)',
  `id_task` bigint DEFAULT NULL,
  `job_exception` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '抛出异常',
  `name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '任务名',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='定时任务日志';

-- ----------------------------
-- Records of task_logs
-- ----------------------------
BEGIN;
INSERT INTO `task_logs` VALUES (1, '2020-06-21 18:00:00', 1, 1, NULL, '测试任务', NULL, NULL);
INSERT INTO `task_logs` VALUES (2, '2020-06-21 18:30:00', 1, 1, NULL, '测试任务', NULL, NULL);
INSERT INTO `task_logs` VALUES (3, '2020-06-21 19:00:00', 1, 1, NULL, '测试任务', NULL, NULL);
INSERT INTO `task_logs` VALUES (4, '2020-06-21 19:30:00', 1, 1, NULL, '测试任务', NULL, NULL);
INSERT INTO `task_logs` VALUES (5, '2020-06-21 20:00:00', 1, 1, NULL, '测试任务', NULL, NULL);
INSERT INTO `task_logs` VALUES (6, '2020-06-21 20:30:00', 1, 1, NULL, '测试任务', NULL, NULL);
INSERT INTO `task_logs` VALUES (7, '2020-06-21 21:00:00', 1, 1, NULL, '测试任务', NULL, NULL);
INSERT INTO `task_logs` VALUES (8, '2020-06-21 21:30:00', 1, 1, NULL, '测试任务', NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for tasks
-- ----------------------------
DROP TABLE IF EXISTS `tasks`;
CREATE TABLE `tasks` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `concurrent` tinyint DEFAULT NULL COMMENT '是否允许并发',
  `cron` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '定时规则',
  `data` text COLLATE utf8mb4_unicode_ci COMMENT '执行参数',
  `disabled` tinyint DEFAULT NULL COMMENT '是否禁用',
  `exec_at` datetime DEFAULT NULL COMMENT '执行时间',
  `exec_result` text COLLATE utf8mb4_unicode_ci COMMENT '执行结果',
  `job_class` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '执行类',
  `job_group` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '任务组名',
  `name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '任务名',
  `note` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '任务说明',
  `created_by` bigint DEFAULT NULL COMMENT '创建人',
  `updated_by` bigint DEFAULT NULL COMMENT '最后更新人',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='定时任务';

-- ----------------------------
-- Records of tasks
-- ----------------------------
BEGIN;
INSERT INTO `tasks` VALUES (1, 0, '0 0/30 * * * ?', '{\n\"appname\": \"web-flash\",\n\"version\":1\n}\n            \n            \n            \n            \n            \n            \n            \n            \n            \n            \n            \n            ', 0, '2020-06-21 21:30:00', '执行成功', 'cn.enilu.flash.service.task.job.HelloJob', 'default', '测试任务', '测试任务,每30分钟执行一次', NULL, NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `account` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '登录名',
  `password` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '密码',
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '姓名',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '头像',
  `birthday` datetime DEFAULT NULL COMMENT '生日',
  `email` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'email',
  `phone` varchar(16) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '手机号',
  `department_id` bigint DEFAULT NULL COMMENT '部门id',
  `role_ids` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '角色id列表，以逗号分隔',
  `sex` tinyint DEFAULT NULL COMMENT '性别',
  `status` tinyint DEFAULT NULL COMMENT '状态',
  `version` int DEFAULT NULL COMMENT '版本',
  `created_by` bigint DEFAULT NULL COMMENT '创建人',
  `updated_by` bigint DEFAULT NULL COMMENT '最后更新人',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `account` (`account`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='账号';

-- ----------------------------
-- Records of users
-- ----------------------------
BEGIN;
INSERT INTO `users` VALUES (-1, 'system', NULL, '应用系统', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL);
INSERT INTO `users` VALUES (1, 'admin', 'b5a51391f271f062867e5984e2fcffee', '管理员', NULL, '2017-05-05 00:00:00', 'eniluzt@qq.com', '15021222222', 2, '1', 2, 1, 2, NULL, 1, NULL, NULL);
INSERT INTO `users` VALUES (2, 'developer', 'fac36d5616fe9ebd460691264b28ee27', '网站管理员', NULL, '2017-12-31 00:00:00', 'eniluzt@qq.com', '15022222222', 3, '2,', 1, 1, NULL, NULL, 1, NULL, NULL);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
