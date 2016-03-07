/*
Navicat MariaDB Data Transfer

Source Server         : localhost
Source Server Version : 100110
Source Host           : localhost:3306
Source Database       : smart-queue

Target Server Type    : MariaDB
Target Server Version : 100110
File Encoding         : 65001

Date: 2016-03-07 21:29:14
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for master_client
-- ----------------------------
DROP TABLE IF EXISTS `master_client`;
CREATE TABLE `master_client` (
  `clientid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `shortname` varchar(50) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `isactive` int(1) NOT NULL DEFAULT '0',
  `entrytime` bigint(20) DEFAULT NULL,
  `entryuser` varchar(50) DEFAULT NULL,
  `modifiedtime` bigint(20) DEFAULT NULL,
  `modifieduser` varchar(50) DEFAULT NULL,
  `deletedtime` bigint(20) DEFAULT NULL,
  `deleteduser` varchar(50) DEFAULT NULL,
  `isdeleted` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`clientid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of master_client
-- ----------------------------
INSERT INTO `master_client` VALUES ('1', 'Rumah Sakit Al-Islam', 'RSAI', 'Jl. Soekarno Hatta No. 644 Bandung', '(022) 7510583 ', null, '1', null, null, null, null, null, null, '0');
INSERT INTO `master_client` VALUES ('2', 'Yayasan Kesehatan Telkom', 'Yakes Telkom', 'Jl. Sentot Alibasyah No. 4 Bandung Jawa Barat', '(022) 7102738', null, '1', null, null, null, null, null, null, '0');

-- ----------------------------
-- Table structure for master_type
-- ----------------------------
DROP TABLE IF EXISTS `master_type`;
CREATE TABLE `master_type` (
  `typeid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`typeid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of master_type
-- ----------------------------
INSERT INTO `master_type` VALUES ('1', 'Antrian Pendaftaran', 'Antrian berurutan, pengunjung mengambil nomor antrian, dari loket akan memanggil nomor sesuai urutan');
INSERT INTO `master_type` VALUES ('2', 'Antrian Terjadwal', 'Antrian dimana pengunjung dapat memilih nomor antrian dengan waktu yang diinginkan');

-- ----------------------------
-- Table structure for queue
-- ----------------------------
DROP TABLE IF EXISTS `queue`;
CREATE TABLE `queue` (
  `queueid` int(11) NOT NULL,
  `clientid` int(11) NOT NULL,
  `date` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `starttime` int(11) DEFAULT NULL,
  `endtime` int(11) DEFAULT NULL,
  `avgtime` int(11) DEFAULT NULL,
  `isactive` int(1) NOT NULL DEFAULT '1',
  `entrytime` bigint(20) DEFAULT NULL,
  `entryuser` varchar(50) DEFAULT NULL,
  `modifiedtime` bigint(20) DEFAULT NULL,
  `modifieduser` varchar(50) DEFAULT NULL,
  `deletedtime` bigint(20) DEFAULT NULL,
  `deleteduser` varchar(50) DEFAULT NULL,
  `isdeleted` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`queueid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of queue
-- ----------------------------

-- ----------------------------
-- Table structure for queue_archive
-- ----------------------------
DROP TABLE IF EXISTS `queue_archive`;
CREATE TABLE `queue_archive` (
  `numberid` int(11) NOT NULL,
  `queueid` int(11) NOT NULL,
  `counterid` int(11) DEFAULT NULL,
  `number` int(11) NOT NULL,
  `date` int(11) NOT NULL,
  `ipaddress` varchar(255) DEFAULT NULL,
  `useragent` varchar(255) DEFAULT NULL,
  `session` varchar(255) DEFAULT NULL,
  `entrytime` bigint(20) DEFAULT NULL,
  `entryuser` varchar(50) DEFAULT NULL,
  `deletedtime` bigint(20) DEFAULT NULL,
  `deleteduser` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of queue_archive
-- ----------------------------

-- ----------------------------
-- Table structure for queue_counter
-- ----------------------------
DROP TABLE IF EXISTS `queue_counter`;
CREATE TABLE `queue_counter` (
  `counterid` int(11) NOT NULL AUTO_INCREMENT,
  `queueid` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `entrytime` bigint(20) DEFAULT NULL,
  `entryuser` varchar(50) DEFAULT NULL,
  `modifiedtime` bigint(20) DEFAULT NULL,
  `modifieduser` varchar(50) DEFAULT NULL,
  `deletedtime` bigint(20) DEFAULT NULL,
  `deleteduser` varchar(50) DEFAULT NULL,
  `isdeleted` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`counterid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of queue_counter
-- ----------------------------

-- ----------------------------
-- Table structure for queue_number
-- ----------------------------
DROP TABLE IF EXISTS `queue_number`;
CREATE TABLE `queue_number` (
  `numberid` int(11) NOT NULL AUTO_INCREMENT,
  `queueid` int(11) NOT NULL,
  `counterid` int(11) NOT NULL,
  `number` int(11) NOT NULL,
  `date` int(11) NOT NULL,
  `ipaddress` varchar(255) DEFAULT NULL,
  `useragent` varchar(255) DEFAULT NULL,
  `session` varchar(255) DEFAULT NULL,
  `entrytime` bigint(20) DEFAULT NULL,
  `entryuser` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`numberid`),
  UNIQUE KEY `Unique number` (`queueid`,`number`,`date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of queue_number
-- ----------------------------

-- ----------------------------
-- Table structure for sys_session
-- ----------------------------
DROP TABLE IF EXISTS `sys_session`;
CREATE TABLE `sys_session` (
  `sessionid` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) NOT NULL,
  `token` text,
  `ipaddress` varchar(255) DEFAULT NULL,
  `useragent` varchar(255) DEFAULT NULL,
  `entrytime` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`sessionid`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of sys_session
-- ----------------------------
INSERT INTO `sys_session` VALUES ('4', '8', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiI4IiwidXNlcm5hbWUiOiJ1c2VyIiwibmFtZSI6IlVzZXIiLCJhZGRyZXNzIjpudWxsLCJlbWFpbCI6InRlc3RpbmdAZ21haWwuY29tIiwicGhvbmUiOm51bGwsInVzZXJncm91cGlkIjoiNCIsImlzZW5hYmxlZCI6IjEiLCJjbGllbnRpZCI6IjAiLCJ1c2VyZ3JvdXBuYW1lIjoidXNlciIsInVzZXJsZXZlbCI6IjgiLCJpc2Rpc3BsYXllZCI6IjEiLCJpc2FsbG93cmVnaXN0cmF0aW9uIjoiMSIsImlzbG9nZ2VkaW4iOiIwIiwiZXhwIjoxNDU3NDA0MDAzfQ.Z79LpbhKeNl-q5BjDdCEp7lWRqLr-zU03vlp98xN9uQ', null, null, '20160307152643');

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `userid` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `name` varchar(255) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `usergroupid` int(11) NOT NULL DEFAULT '0',
  `isenabled` int(1) NOT NULL DEFAULT '1',
  `clientid` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`userid`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('1', 'sysadmin', '202cb962ac59075b964b07152d234b70', 'System Administrator', null, 'developer@akhdani.co.id', null, '1', '1', '0');
INSERT INTO `sys_user` VALUES ('2', 'admin1', '202cb962ac59075b964b07152d234b70', 'Administrator RSAI', null, 'admin@rsai.com', null, '2', '1', '1');
INSERT INTO `sys_user` VALUES ('3', 'admin2', '202cb962ac59075b964b07152d234b70', 'Administrator Yakes Telkom', null, 'admin@yakestelkom.org', null, '2', '1', '2');
INSERT INTO `sys_user` VALUES ('4', 'op11', '202cb962ac59075b964b07152d234b70', 'Operator RSAI 1', null, 'op1@rsai.com', null, '3', '1', '1');
INSERT INTO `sys_user` VALUES ('5', 'op12', '202cb962ac59075b964b07152d234b70', 'Operator RSAI 2', null, 'op2@rsai.com', null, '3', '1', '1');
INSERT INTO `sys_user` VALUES ('6', 'op21', '202cb962ac59075b964b07152d234b70', 'Operator Yakes Telkom', null, 'op1@yakestelkom.org', null, '3', '1', '2');
INSERT INTO `sys_user` VALUES ('7', 'op22', '202cb962ac59075b964b07152d234b70', 'Operator Yakes Telkom', null, 'op2@yakestelkom.org', null, '3', '1', '2');
INSERT INTO `sys_user` VALUES ('8', 'user', '202cb962ac59075b964b07152d234b70', 'User', null, 'testing@gmail.com', null, '4', '1', '0');

-- ----------------------------
-- Table structure for sys_usergroup
-- ----------------------------
DROP TABLE IF EXISTS `sys_usergroup`;
CREATE TABLE `sys_usergroup` (
  `usergroupid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `level` int(1) NOT NULL DEFAULT '0',
  `isdisplayed` int(1) NOT NULL DEFAULT '1',
  `isallowregistration` int(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`usergroupid`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of sys_usergroup
-- ----------------------------
INSERT INTO `sys_usergroup` VALUES ('1', 'sysadmin', '1', '0', '0');
INSERT INTO `sys_usergroup` VALUES ('2', 'admin', '2', '1', '1');
INSERT INTO `sys_usergroup` VALUES ('3', 'operator', '4', '1', '1');
INSERT INTO `sys_usergroup` VALUES ('4', 'user', '8', '1', '1');

-- ----------------------------
-- View structure for view_sys_user
-- ----------------------------
DROP VIEW IF EXISTS `view_sys_user`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_sys_user` AS select `u`.`userid` AS `userid`,`u`.`username` AS `username`,`u`.`password` AS `password`,`u`.`name` AS `name`,`u`.`address` AS `address`,`u`.`email` AS `email`,`u`.`phone` AS `phone`,`u`.`usergroupid` AS `usergroupid`,`u`.`isenabled` AS `isenabled`,`u`.`clientid` AS `clientid`,`ug`.`name` AS `usergroupname`,`ug`.`level` AS `userlevel`,`ug`.`isdisplayed` AS `isdisplayed`,`ug`.`isallowregistration` AS `isallowregistration`,(select count(`s`.`userid`) from `sys_session` `s` where (`s`.`userid` = `u`.`userid`)) AS `isloggedin` from (`sys_user` `u` left join `sys_usergroup` `ug` on((`ug`.`usergroupid` = `u`.`usergroupid`))) ;
