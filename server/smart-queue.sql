/*
Navicat MariaDB Data Transfer

Source Server         : localhost
Source Server Version : 100110
Source Host           : localhost:3306
Source Database       : smart-queue

Target Server Type    : MariaDB
Target Server Version : 100110
File Encoding         : 65001

Date: 2016-03-07 06:09:49
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
  `entrytime` int(11) DEFAULT NULL,
  `entryuser` varchar(50) DEFAULT NULL,
  `modifiedtime` int(11) DEFAULT NULL,
  `modifieduser` varchar(50) DEFAULT NULL,
  `deletedtime` int(11) DEFAULT NULL,
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
  `entrytime` int(11) DEFAULT NULL,
  `entryuser` varchar(50) DEFAULT NULL,
  `modifiedtime` int(11) DEFAULT NULL,
  `modifieduser` varchar(50) DEFAULT NULL,
  `deletedtime` int(11) DEFAULT NULL,
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
  `number` int(11) NOT NULL,
  `date` int(11) NOT NULL,
  `ipaddress` varchar(255) DEFAULT NULL,
  `useragent` varchar(255) DEFAULT NULL,
  `session` varchar(255) DEFAULT NULL,
  `entrytime` int(11) DEFAULT NULL,
  `entryuser` varchar(50) DEFAULT NULL,
  `deletedtime` int(11) DEFAULT NULL,
  `deleteduser` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of queue_archive
-- ----------------------------

-- ----------------------------
-- Table structure for queue_number
-- ----------------------------
DROP TABLE IF EXISTS `queue_number`;
CREATE TABLE `queue_number` (
  `numberid` int(11) NOT NULL AUTO_INCREMENT,
  `queueid` int(11) NOT NULL,
  `number` int(11) NOT NULL,
  `date` int(11) NOT NULL,
  `ipaddress` varchar(255) DEFAULT NULL,
  `useragent` varchar(255) DEFAULT NULL,
  `session` varchar(255) DEFAULT NULL,
  `entrytime` int(11) DEFAULT NULL,
  `entryuser` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`numberid`),
  UNIQUE KEY `Unique number` (`queueid`,`number`,`date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of queue_number
-- ----------------------------

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
  `isenabled` int(1) NOT NULL DEFAULT '1',
  `klienid` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`userid`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('1', 'admin', '202cb962ac59075b964b07152d234b70', 'Administrator', null, 'developer@akhdani.co.id', null, '1', '0');

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
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of sys_usergroup
-- ----------------------------
INSERT INTO `sys_usergroup` VALUES ('1', 'admin', '1', '0', '0');
INSERT INTO `sys_usergroup` VALUES ('2', 'operator', '2', '1', '1');
INSERT INTO `sys_usergroup` VALUES ('3', 'user', '4', '1', '1');
