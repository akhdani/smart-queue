/*
Navicat MariaDB Data Transfer

Source Server         : localhost
Source Server Version : 100110
Source Host           : localhost:3306
Source Database       : smart-queue

Target Server Type    : MariaDB
Target Server Version : 100110
File Encoding         : 65001

Date: 2016-03-10 07:58:50
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
  `queueid` int(11) NOT NULL AUTO_INCREMENT,
  `typeid` int(11) NOT NULL DEFAULT '1',
  `clientid` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `numberid` int(11) NOT NULL DEFAULT '0',
  `number` int(11) NOT NULL DEFAULT '0',
  `counterid` int(1) NOT NULL DEFAULT '0',
  `counter` varchar(50) DEFAULT '0',
  `starttime` varchar(5) DEFAULT NULL,
  `endtime` varchar(5) DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of queue
-- ----------------------------
INSERT INTO `queue` VALUES ('1', '1', '1', 'Kassa A', 'Antrian Pendaftaran Umum', '2', '2', '1', 'Loket 1', '10:00', '17:00', '60', '1', '20160308061107', 'admin1', '20160309120959', 'op11', null, null, '0');
INSERT INTO `queue` VALUES ('2', '1', '1', 'Kassa B', 'Antrian Pendaftaran BPJS & Kontraktor', '0', '0', '0', null, '08:00', '12:00', '60', '1', '20160308061155', 'admin1', null, null, null, null, '0');
INSERT INTO `queue` VALUES ('3', '1', '2', 'Kassa A', 'Antrian Pendaftaran Umum', '0', '0', '0', null, '08:00', '12:00', '60', '1', '20160308061231', 'admin2', null, null, null, null, '0');

-- ----------------------------
-- Table structure for queue_archive
-- ----------------------------
DROP TABLE IF EXISTS `queue_archive`;
CREATE TABLE `queue_archive` (
  `numberid` int(11) NOT NULL,
  `queueid` int(11) NOT NULL,
  `counterid` int(11) DEFAULT NULL,
  `clientid` int(11) NOT NULL,
  `number` int(11) NOT NULL,
  `date` int(11) NOT NULL,
  `ipaddress` varchar(255) DEFAULT NULL,
  `useragent` varchar(255) DEFAULT NULL,
  `session` varchar(255) DEFAULT NULL,
  `entrytime` bigint(20) DEFAULT NULL,
  `entryuser` varchar(50) DEFAULT NULL,
  `deletedtime` bigint(20) DEFAULT NULL,
  `deleteduser` varchar(50) DEFAULT NULL,
  `iscancel` int(1) NOT NULL,
  `canceltime` bigint(20) DEFAULT NULL,
  `canceluser` varchar(50) DEFAULT NULL
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
  `clientid` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `numberid` int(11) NOT NULL DEFAULT '0',
  `number` int(11) NOT NULL DEFAULT '0',
  `entrytime` bigint(20) DEFAULT NULL,
  `entryuser` varchar(50) DEFAULT NULL,
  `modifiedtime` bigint(20) DEFAULT NULL,
  `modifieduser` varchar(50) DEFAULT NULL,
  `deletedtime` bigint(20) DEFAULT NULL,
  `deleteduser` varchar(50) DEFAULT NULL,
  `isdeleted` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`counterid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of queue_counter
-- ----------------------------
INSERT INTO `queue_counter` VALUES ('1', '1', '1', 'Loket 1', 'Loket 1', '0', '0', '20160308071316', 'admin1', null, null, null, null, '0');
INSERT INTO `queue_counter` VALUES ('2', '1', '1', 'Loket 2', 'Loket 2', '0', '0', '20160308072103', 'admin1', null, null, null, null, '0');

-- ----------------------------
-- Table structure for queue_number
-- ----------------------------
DROP TABLE IF EXISTS `queue_number`;
CREATE TABLE `queue_number` (
  `numberid` int(11) NOT NULL AUTO_INCREMENT,
  `queueid` int(11) NOT NULL,
  `clientid` int(11) NOT NULL,
  `number` int(11) NOT NULL,
  `date` int(11) NOT NULL,
  `ipaddress` varchar(255) DEFAULT NULL,
  `useragent` varchar(255) DEFAULT NULL,
  `session` varchar(255) DEFAULT NULL,
  `starttime` int(11) DEFAULT NULL,
  `endtime` int(11) DEFAULT NULL,
  `isfinish` int(1) NOT NULL DEFAULT '0',
  `counterid` int(11) NOT NULL DEFAULT '0',
  `entrytime` bigint(20) DEFAULT NULL,
  `entryuser` varchar(50) DEFAULT NULL,
  `iscancel` int(1) NOT NULL DEFAULT '0',
  `canceltime` bigint(20) DEFAULT NULL,
  `canceluser` varchar(50) DEFAULT NULL,
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
) ENGINE=MyISAM AUTO_INCREMENT=108 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of sys_session
-- ----------------------------
INSERT INTO `sys_session` VALUES ('4', '8', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiI4IiwidXNlcm5hbWUiOiJ1c2VyIiwibmFtZSI6IlVzZXIiLCJhZGRyZXNzIjpudWxsLCJlbWFpbCI6InRlc3RpbmdAZ21haWwuY29tIiwicGhvbmUiOm51bGwsInVzZXJncm91cGlkIjoiNCIsImlzZW5hYmxlZCI6IjEiLCJjbGllbnRpZCI6IjAiLCJ1c2VyZ3JvdXBuYW1lIjoidXNlciIsInVzZXJsZXZlbCI6IjgiLCJpc2Rpc3BsYXllZCI6IjEiLCJpc2FsbG93cmVnaXN0cmF0aW9uIjoiMSIsImlzbG9nZ2VkaW4iOiIwIiwiZXhwIjoxNDU3NDA0MDAzfQ.Z79LpbhKeNl-q5BjDdCEp7lWRqLr-zU03vlp98xN9uQ', null, null, '20160307152643');
INSERT INTO `sys_session` VALUES ('9', '8', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiI4IiwidXNlcm5hbWUiOiJ1c2VyMSIsIm5hbWUiOiJVc2VyIDEiLCJhZGRyZXNzIjpudWxsLCJlbWFpbCI6InVzZXIxQGdtYWlsLmNvbSIsInBob25lIjpudWxsLCJ1c2VyZ3JvdXBpZCI6IjQiLCJpc2VuYWJsZWQiOiIxIiwiY2xpZW50aWQiOiIwIiwiY291bnRlcmlkIjoiMCIsInVzZXJncm91cG5hbWUiOiJ1c2VyIiwidXNlcmxldmVsIjoiOCIsImlzZGlzcGxheWVkIjoiMSIsImlzYWxsb3dyZWdpc3RyYXRpb24iOiIxIiwiaXNsb2dnZWRpbiI6IjEiLCJleHAiOjE0NTc0NjEzMTh9.q5jnBecFl2nWf_4rp4evORAjEG-U0Nw39xSFmtB7CiY', null, null, '20160308072158');
INSERT INTO `sys_session` VALUES ('12', '4', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiI0IiwidXNlcm5hbWUiOiJvcDExIiwibmFtZSI6Ik9wZXJhdG9yIFJTQUkgMSIsImFkZHJlc3MiOm51bGwsImVtYWlsIjoib3AxQHJzYWkuY29tIiwicGhvbmUiOm51bGwsInVzZXJncm91cGlkIjoiMyIsImlzZW5hYmxlZCI6IjEiLCJjbGllbnRpZCI6IjEiLCJjb3VudGVyaWQiOiIxIiwidXNlcmdyb3VwbmFtZSI6Im9wZXJhdG9yIiwidXNlcmxldmVsIjoiNCIsImlzZGlzcGxheWVkIjoiMSIsImlzYWxsb3dyZWdpc3RyYXRpb24iOiIxIiwiaXNsb2dnZWRpbiI6IjAiLCJleHAiOjE0NTc1NDEyMzl9.7-irwqk77wF54u8xYXqbTDNPKPDHz7JNi_XGwCB4Y6U', null, null, '20160309113359');
INSERT INTO `sys_session` VALUES ('13', '1', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiIxIiwidXNlcm5hbWUiOiJzeXNhZG1pbiIsIm5hbWUiOiJTeXN0ZW0gQWRtaW5pc3RyYXRvciIsImFkZHJlc3MiOm51bGwsImVtYWlsIjoiZGV2ZWxvcGVyQGFraGRhbmkuY28uaWQiLCJwaG9uZSI6bnVsbCwidXNlcmdyb3VwaWQiOiIxIiwiaXNlbmFibGVkIjoiMSIsImNsaWVudGlkIjoiMCIsImNvdW50ZXJpZCI6IjAiLCJ1c2VyZ3JvdXBuYW1lIjoic3lzYWRtaW4iLCJ1c2VybGV2ZWwiOiIxIiwiaXNkaXNwbGF5ZWQiOiIwIiwiaXNhbGxvd3JlZ2lzdHJhdGlvbiI6IjAiLCJpc2xvZ2dlZGluIjoiMCIsImV4cCI6MTQ1NzYxMTY5OH0.-WxLWOYzT33Gn4Pe6MPOu2lofc_iRovlXz4jx1DclE8', null, null, '20160310070818');
INSERT INTO `sys_session` VALUES ('14', '1', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiIxIiwidXNlcm5hbWUiOiJzeXNhZG1pbiIsIm5hbWUiOiJTeXN0ZW0gQWRtaW5pc3RyYXRvciIsImFkZHJlc3MiOm51bGwsImVtYWlsIjoiZGV2ZWxvcGVyQGFraGRhbmkuY28uaWQiLCJwaG9uZSI6bnVsbCwidXNlcmdyb3VwaWQiOiIxIiwiaXNlbmFibGVkIjoiMSIsImNsaWVudGlkIjoiMCIsImNvdW50ZXJpZCI6IjAiLCJ1c2VyZ3JvdXBuYW1lIjoic3lzYWRtaW4iLCJ1c2VybGV2ZWwiOiIxIiwiaXNkaXNwbGF5ZWQiOiIwIiwiaXNhbGxvd3JlZ2lzdHJhdGlvbiI6IjAiLCJpc2xvZ2dlZGluIjoiMSIsImV4cCI6MTQ1NzYxMTcwM30.k-ozJW9mEagC7rE43wSK1qraNxa-y8riC2vMEau434w', null, null, '20160310070823');
INSERT INTO `sys_session` VALUES ('15', '1', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiIxIiwidXNlcm5hbWUiOiJzeXNhZG1pbiIsIm5hbWUiOiJTeXN0ZW0gQWRtaW5pc3RyYXRvciIsImFkZHJlc3MiOm51bGwsImVtYWlsIjoiZGV2ZWxvcGVyQGFraGRhbmkuY28uaWQiLCJwaG9uZSI6bnVsbCwidXNlcmdyb3VwaWQiOiIxIiwiaXNlbmFibGVkIjoiMSIsImNsaWVudGlkIjoiMCIsImNvdW50ZXJpZCI6IjAiLCJ1c2VyZ3JvdXBuYW1lIjoic3lzYWRtaW4iLCJ1c2VybGV2ZWwiOiIxIiwiaXNkaXNwbGF5ZWQiOiIwIiwiaXNhbGxvd3JlZ2lzdHJhdGlvbiI6IjAiLCJpc2xvZ2dlZGluIjoiMiIsImV4cCI6MTQ1NzYxMTcyMn0.kLhvRioVnLAkbg2o6tldfbQtYQ2OSpF_KcPYDdLGtWA', null, null, '20160310070842');
INSERT INTO `sys_session` VALUES ('16', '1', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiIxIiwidXNlcm5hbWUiOiJzeXNhZG1pbiIsIm5hbWUiOiJTeXN0ZW0gQWRtaW5pc3RyYXRvciIsImFkZHJlc3MiOm51bGwsImVtYWlsIjoiZGV2ZWxvcGVyQGFraGRhbmkuY28uaWQiLCJwaG9uZSI6bnVsbCwidXNlcmdyb3VwaWQiOiIxIiwiaXNlbmFibGVkIjoiMSIsImNsaWVudGlkIjoiMCIsImNvdW50ZXJpZCI6IjAiLCJ1c2VyZ3JvdXBuYW1lIjoic3lzYWRtaW4iLCJ1c2VybGV2ZWwiOiIxIiwiaXNkaXNwbGF5ZWQiOiIwIiwiaXNhbGxvd3JlZ2lzdHJhdGlvbiI6IjAiLCJpc2xvZ2dlZGluIjoiMyIsImV4cCI6MTQ1NzYxMTc1N30.rfA31QThI944Y1yzOcB9BUIXmOCqAVLkaOqZcqYD7Yc', null, null, '20160310070917');
INSERT INTO `sys_session` VALUES ('17', '1', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiIxIiwidXNlcm5hbWUiOiJzeXNhZG1pbiIsIm5hbWUiOiJTeXN0ZW0gQWRtaW5pc3RyYXRvciIsImFkZHJlc3MiOm51bGwsImVtYWlsIjoiZGV2ZWxvcGVyQGFraGRhbmkuY28uaWQiLCJwaG9uZSI6bnVsbCwidXNlcmdyb3VwaWQiOiIxIiwiaXNlbmFibGVkIjoiMSIsImNsaWVudGlkIjoiMCIsImNvdW50ZXJpZCI6IjAiLCJ1c2VyZ3JvdXBuYW1lIjoic3lzYWRtaW4iLCJ1c2VybGV2ZWwiOiIxIiwiaXNkaXNwbGF5ZWQiOiIwIiwiaXNhbGxvd3JlZ2lzdHJhdGlvbiI6IjAiLCJpc2xvZ2dlZGluIjoiNCIsImV4cCI6MTQ1NzYxMTc4Mn0.bKgGKf7nP5yQrO6Q4EFDaaWzYPd2mTxdobf6zeeVGSg', null, null, '20160310070942');
INSERT INTO `sys_session` VALUES ('18', '1', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiIxIiwidXNlcm5hbWUiOiJzeXNhZG1pbiIsIm5hbWUiOiJTeXN0ZW0gQWRtaW5pc3RyYXRvciIsImFkZHJlc3MiOm51bGwsImVtYWlsIjoiZGV2ZWxvcGVyQGFraGRhbmkuY28uaWQiLCJwaG9uZSI6bnVsbCwidXNlcmdyb3VwaWQiOiIxIiwiaXNlbmFibGVkIjoiMSIsImNsaWVudGlkIjoiMCIsImNvdW50ZXJpZCI6IjAiLCJ1c2VyZ3JvdXBuYW1lIjoic3lzYWRtaW4iLCJ1c2VybGV2ZWwiOiIxIiwiaXNkaXNwbGF5ZWQiOiIwIiwiaXNhbGxvd3JlZ2lzdHJhdGlvbiI6IjAiLCJpc2xvZ2dlZGluIjoiNSIsImV4cCI6MTQ1NzYxMTgwMn0.JhHQchQXqZbcBWgfw6SWKWlMI0Q9kMXsFHpFgCPIfYM', null, null, '20160310071002');
INSERT INTO `sys_session` VALUES ('19', '1', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiIxIiwidXNlcm5hbWUiOiJzeXNhZG1pbiIsIm5hbWUiOiJTeXN0ZW0gQWRtaW5pc3RyYXRvciIsImFkZHJlc3MiOm51bGwsImVtYWlsIjoiZGV2ZWxvcGVyQGFraGRhbmkuY28uaWQiLCJwaG9uZSI6bnVsbCwidXNlcmdyb3VwaWQiOiIxIiwiaXNlbmFibGVkIjoiMSIsImNsaWVudGlkIjoiMCIsImNvdW50ZXJpZCI6IjAiLCJ1c2VyZ3JvdXBuYW1lIjoic3lzYWRtaW4iLCJ1c2VybGV2ZWwiOiIxIiwiaXNkaXNwbGF5ZWQiOiIwIiwiaXNhbGxvd3JlZ2lzdHJhdGlvbiI6IjAiLCJpc2xvZ2dlZGluIjoiNiIsImV4cCI6MTQ1NzYxMTg0Mn0.aD1qsuL0S0HRFvXfqEgZvEb_Nr3k-4seqqOvoOaGzf8', null, null, '20160310071042');
INSERT INTO `sys_session` VALUES ('20', '1', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiIxIiwidXNlcm5hbWUiOiJzeXNhZG1pbiIsIm5hbWUiOiJTeXN0ZW0gQWRtaW5pc3RyYXRvciIsImFkZHJlc3MiOm51bGwsImVtYWlsIjoiZGV2ZWxvcGVyQGFraGRhbmkuY28uaWQiLCJwaG9uZSI6bnVsbCwidXNlcmdyb3VwaWQiOiIxIiwiaXNlbmFibGVkIjoiMSIsImNsaWVudGlkIjoiMCIsImNvdW50ZXJpZCI6IjAiLCJ1c2VyZ3JvdXBuYW1lIjoic3lzYWRtaW4iLCJ1c2VybGV2ZWwiOiIxIiwiaXNkaXNwbGF5ZWQiOiIwIiwiaXNhbGxvd3JlZ2lzdHJhdGlvbiI6IjAiLCJpc2xvZ2dlZGluIjoiNyIsImV4cCI6MTQ1NzYxMTg2Nn0.dWJVv7emBn1fV7lok-pnap_xFgRC8-uIZOkP8wakidA', null, null, '20160310071106');
INSERT INTO `sys_session` VALUES ('64', '8', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiI4IiwidXNlcm5hbWUiOiJ1c2VyMSIsIm5hbWUiOiJVc2VyIDEiLCJhZGRyZXNzIjpudWxsLCJlbWFpbCI6InVzZXIxQGdtYWlsLmNvbSIsInBob25lIjpudWxsLCJ1c2VyZ3JvdXBpZCI6IjQiLCJpc2VuYWJsZWQiOiIxIiwiY2xpZW50aWQiOiIwIiwiY291bnRlcmlkIjoiMCIsInVzZXJncm91cG5hbWUiOiJ1c2VyIiwidXNlcmxldmVsIjoiOCIsImlzZGlzcGxheWVkIjoiMSIsImlzYWxsb3dyZWdpc3RyYXRpb24iOiIxIiwiaXNsb2dnZWRpbiI6IjgiLCJleHAiOjE0NTc2MTQzMTh9.LuvS-0E6D4M_U4sFlRDAI-KEJj0EXRpP3lgwQ4PbyrQ', null, null, '20160310075158');
INSERT INTO `sys_session` VALUES ('22', '8', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiI4IiwidXNlcm5hbWUiOiJ1c2VyMSIsIm5hbWUiOiJVc2VyIDEiLCJhZGRyZXNzIjpudWxsLCJlbWFpbCI6InVzZXIxQGdtYWlsLmNvbSIsInBob25lIjpudWxsLCJ1c2VyZ3JvdXBpZCI6IjQiLCJpc2VuYWJsZWQiOiIxIiwiY2xpZW50aWQiOiIwIiwiY291bnRlcmlkIjoiMCIsInVzZXJncm91cG5hbWUiOiJ1c2VyIiwidXNlcmxldmVsIjoiOCIsImlzZGlzcGxheWVkIjoiMSIsImlzYWxsb3dyZWdpc3RyYXRpb24iOiIxIiwiaXNsb2dnZWRpbiI6IjMiLCJleHAiOjE0NTc2MTM0Mjl9.Ze0Xv4a_u9w5B2sesfOMGN4xnO_YEgHihhDmk77xd9U', null, null, '20160310073709');
INSERT INTO `sys_session` VALUES ('23', '1', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiIxIiwidXNlcm5hbWUiOiJzeXNhZG1pbiIsIm5hbWUiOiJTeXN0ZW0gQWRtaW5pc3RyYXRvciIsImFkZHJlc3MiOm51bGwsImVtYWlsIjoiZGV2ZWxvcGVyQGFraGRhbmkuY28uaWQiLCJwaG9uZSI6bnVsbCwidXNlcmdyb3VwaWQiOiIxIiwiaXNlbmFibGVkIjoiMSIsImNsaWVudGlkIjoiMCIsImNvdW50ZXJpZCI6IjAiLCJ1c2VyZ3JvdXBuYW1lIjoic3lzYWRtaW4iLCJ1c2VybGV2ZWwiOiIxIiwiaXNkaXNwbGF5ZWQiOiIwIiwiaXNhbGxvd3JlZ2lzdHJhdGlvbiI6IjAiLCJpc2xvZ2dlZGluIjoiOCIsImV4cCI6MTQ1NzYxMzQyOX0.8bjjbalRh8Ptkixj-GBxJZ17xMtfLqfo7ETc7l9mzAM', null, null, '20160310073709');
INSERT INTO `sys_session` VALUES ('24', '1', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiIxIiwidXNlcm5hbWUiOiJzeXNhZG1pbiIsIm5hbWUiOiJTeXN0ZW0gQWRtaW5pc3RyYXRvciIsImFkZHJlc3MiOm51bGwsImVtYWlsIjoiZGV2ZWxvcGVyQGFraGRhbmkuY28uaWQiLCJwaG9uZSI6bnVsbCwidXNlcmdyb3VwaWQiOiIxIiwiaXNlbmFibGVkIjoiMSIsImNsaWVudGlkIjoiMCIsImNvdW50ZXJpZCI6IjAiLCJ1c2VyZ3JvdXBuYW1lIjoic3lzYWRtaW4iLCJ1c2VybGV2ZWwiOiIxIiwiaXNkaXNwbGF5ZWQiOiIwIiwiaXNhbGxvd3JlZ2lzdHJhdGlvbiI6IjAiLCJpc2xvZ2dlZGluIjoiOSIsImV4cCI6MTQ1NzYxMzQzMH0.INMiWgy_YDDcVYweUdSzgo-ub1NIzDvXjPxXuvDY8Vc', null, null, '20160310073710');
INSERT INTO `sys_session` VALUES ('25', '1', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiIxIiwidXNlcm5hbWUiOiJzeXNhZG1pbiIsIm5hbWUiOiJTeXN0ZW0gQWRtaW5pc3RyYXRvciIsImFkZHJlc3MiOm51bGwsImVtYWlsIjoiZGV2ZWxvcGVyQGFraGRhbmkuY28uaWQiLCJwaG9uZSI6bnVsbCwidXNlcmdyb3VwaWQiOiIxIiwiaXNlbmFibGVkIjoiMSIsImNsaWVudGlkIjoiMCIsImNvdW50ZXJpZCI6IjAiLCJ1c2VyZ3JvdXBuYW1lIjoic3lzYWRtaW4iLCJ1c2VybGV2ZWwiOiIxIiwiaXNkaXNwbGF5ZWQiOiIwIiwiaXNhbGxvd3JlZ2lzdHJhdGlvbiI6IjAiLCJpc2xvZ2dlZGluIjoiMTAiLCJleHAiOjE0NTc2MTM0MzB9.4Vio5Y7AUSiJVquHCzPsK0IejjRNaWLfjyg0W6Jksk0', null, null, '20160310073710');
INSERT INTO `sys_session` VALUES ('26', '1', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiIxIiwidXNlcm5hbWUiOiJzeXNhZG1pbiIsIm5hbWUiOiJTeXN0ZW0gQWRtaW5pc3RyYXRvciIsImFkZHJlc3MiOm51bGwsImVtYWlsIjoiZGV2ZWxvcGVyQGFraGRhbmkuY28uaWQiLCJwaG9uZSI6bnVsbCwidXNlcmdyb3VwaWQiOiIxIiwiaXNlbmFibGVkIjoiMSIsImNsaWVudGlkIjoiMCIsImNvdW50ZXJpZCI6IjAiLCJ1c2VyZ3JvdXBuYW1lIjoic3lzYWRtaW4iLCJ1c2VybGV2ZWwiOiIxIiwiaXNkaXNwbGF5ZWQiOiIwIiwiaXNhbGxvd3JlZ2lzdHJhdGlvbiI6IjAiLCJpc2xvZ2dlZGluIjoiMTEiLCJleHAiOjE0NTc2MTM0MzB9.hdlEw2-nWqz-cDVdeCdzO4j7v2f2LxCPgVYa90hEMvI', null, null, '20160310073710');
INSERT INTO `sys_session` VALUES ('27', '1', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiIxIiwidXNlcm5hbWUiOiJzeXNhZG1pbiIsIm5hbWUiOiJTeXN0ZW0gQWRtaW5pc3RyYXRvciIsImFkZHJlc3MiOm51bGwsImVtYWlsIjoiZGV2ZWxvcGVyQGFraGRhbmkuY28uaWQiLCJwaG9uZSI6bnVsbCwidXNlcmdyb3VwaWQiOiIxIiwiaXNlbmFibGVkIjoiMSIsImNsaWVudGlkIjoiMCIsImNvdW50ZXJpZCI6IjAiLCJ1c2VyZ3JvdXBuYW1lIjoic3lzYWRtaW4iLCJ1c2VybGV2ZWwiOiIxIiwiaXNkaXNwbGF5ZWQiOiIwIiwiaXNhbGxvd3JlZ2lzdHJhdGlvbiI6IjAiLCJpc2xvZ2dlZGluIjoiMTIiLCJleHAiOjE0NTc2MTM0MzB9.gy6J7iuOhueTsSZ6yXA16jj2XrPkrPT8sxdQmzLjG9s', null, null, '20160310073710');
INSERT INTO `sys_session` VALUES ('28', '1', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiIxIiwidXNlcm5hbWUiOiJzeXNhZG1pbiIsIm5hbWUiOiJTeXN0ZW0gQWRtaW5pc3RyYXRvciIsImFkZHJlc3MiOm51bGwsImVtYWlsIjoiZGV2ZWxvcGVyQGFraGRhbmkuY28uaWQiLCJwaG9uZSI6bnVsbCwidXNlcmdyb3VwaWQiOiIxIiwiaXNlbmFibGVkIjoiMSIsImNsaWVudGlkIjoiMCIsImNvdW50ZXJpZCI6IjAiLCJ1c2VyZ3JvdXBuYW1lIjoic3lzYWRtaW4iLCJ1c2VybGV2ZWwiOiIxIiwiaXNkaXNwbGF5ZWQiOiIwIiwiaXNhbGxvd3JlZ2lzdHJhdGlvbiI6IjAiLCJpc2xvZ2dlZGluIjoiMTMiLCJleHAiOjE0NTc2MTM0MzF9.4T8yAsFszAMAZM7Hei592jx8NT2n2Ian3D2azEVFS8M', null, null, '20160310073711');
INSERT INTO `sys_session` VALUES ('29', '8', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiI4IiwidXNlcm5hbWUiOiJ1c2VyMSIsIm5hbWUiOiJVc2VyIDEiLCJhZGRyZXNzIjpudWxsLCJlbWFpbCI6InVzZXIxQGdtYWlsLmNvbSIsInBob25lIjpudWxsLCJ1c2VyZ3JvdXBpZCI6IjQiLCJpc2VuYWJsZWQiOiIxIiwiY2xpZW50aWQiOiIwIiwiY291bnRlcmlkIjoiMCIsInVzZXJncm91cG5hbWUiOiJ1c2VyIiwidXNlcmxldmVsIjoiOCIsImlzZGlzcGxheWVkIjoiMSIsImlzYWxsb3dyZWdpc3RyYXRpb24iOiIxIiwiaXNsb2dnZWRpbiI6IjQiLCJleHAiOjE0NTc2MTM2NDB9.OgAERKcc0CP0C6u_SW3E_2TgWqYUjkxddKDIpqNwK1I', null, null, '20160310074040');
INSERT INTO `sys_session` VALUES ('30', '1', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiIxIiwidXNlcm5hbWUiOiJzeXNhZG1pbiIsIm5hbWUiOiJTeXN0ZW0gQWRtaW5pc3RyYXRvciIsImFkZHJlc3MiOm51bGwsImVtYWlsIjoiZGV2ZWxvcGVyQGFraGRhbmkuY28uaWQiLCJwaG9uZSI6bnVsbCwidXNlcmdyb3VwaWQiOiIxIiwiaXNlbmFibGVkIjoiMSIsImNsaWVudGlkIjoiMCIsImNvdW50ZXJpZCI6IjAiLCJ1c2VyZ3JvdXBuYW1lIjoic3lzYWRtaW4iLCJ1c2VybGV2ZWwiOiIxIiwiaXNkaXNwbGF5ZWQiOiIwIiwiaXNhbGxvd3JlZ2lzdHJhdGlvbiI6IjAiLCJpc2xvZ2dlZGluIjoiMTQiLCJleHAiOjE0NTc2MTM2NDR9.0D0F7_3W318G9kPztTCmYWSHHz8CsaI8zsHmpdNfPuo', null, null, '20160310074044');
INSERT INTO `sys_session` VALUES ('31', '1', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiIxIiwidXNlcm5hbWUiOiJzeXNhZG1pbiIsIm5hbWUiOiJTeXN0ZW0gQWRtaW5pc3RyYXRvciIsImFkZHJlc3MiOm51bGwsImVtYWlsIjoiZGV2ZWxvcGVyQGFraGRhbmkuY28uaWQiLCJwaG9uZSI6bnVsbCwidXNlcmdyb3VwaWQiOiIxIiwiaXNlbmFibGVkIjoiMSIsImNsaWVudGlkIjoiMCIsImNvdW50ZXJpZCI6IjAiLCJ1c2VyZ3JvdXBuYW1lIjoic3lzYWRtaW4iLCJ1c2VybGV2ZWwiOiIxIiwiaXNkaXNwbGF5ZWQiOiIwIiwiaXNhbGxvd3JlZ2lzdHJhdGlvbiI6IjAiLCJpc2xvZ2dlZGluIjoiMTUiLCJleHAiOjE0NTc2MTM2NDR9.mZuMtTREBFxTw4K_YgMi-4mbqo0kkR64YxkLpq4-ur0', null, null, '20160310074044');
INSERT INTO `sys_session` VALUES ('32', '1', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiIxIiwidXNlcm5hbWUiOiJzeXNhZG1pbiIsIm5hbWUiOiJTeXN0ZW0gQWRtaW5pc3RyYXRvciIsImFkZHJlc3MiOm51bGwsImVtYWlsIjoiZGV2ZWxvcGVyQGFraGRhbmkuY28uaWQiLCJwaG9uZSI6bnVsbCwidXNlcmdyb3VwaWQiOiIxIiwiaXNlbmFibGVkIjoiMSIsImNsaWVudGlkIjoiMCIsImNvdW50ZXJpZCI6IjAiLCJ1c2VyZ3JvdXBuYW1lIjoic3lzYWRtaW4iLCJ1c2VybGV2ZWwiOiIxIiwiaXNkaXNwbGF5ZWQiOiIwIiwiaXNhbGxvd3JlZ2lzdHJhdGlvbiI6IjAiLCJpc2xvZ2dlZGluIjoiMTYiLCJleHAiOjE0NTc2MTM2NDV9.i6xtMU4tggzPpa6YVUFgb8OKC9sdF3xyEunVbmvkahE', null, null, '20160310074045');
INSERT INTO `sys_session` VALUES ('33', '1', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiIxIiwidXNlcm5hbWUiOiJzeXNhZG1pbiIsIm5hbWUiOiJTeXN0ZW0gQWRtaW5pc3RyYXRvciIsImFkZHJlc3MiOm51bGwsImVtYWlsIjoiZGV2ZWxvcGVyQGFraGRhbmkuY28uaWQiLCJwaG9uZSI6bnVsbCwidXNlcmdyb3VwaWQiOiIxIiwiaXNlbmFibGVkIjoiMSIsImNsaWVudGlkIjoiMCIsImNvdW50ZXJpZCI6IjAiLCJ1c2VyZ3JvdXBuYW1lIjoic3lzYWRtaW4iLCJ1c2VybGV2ZWwiOiIxIiwiaXNkaXNwbGF5ZWQiOiIwIiwiaXNhbGxvd3JlZ2lzdHJhdGlvbiI6IjAiLCJpc2xvZ2dlZGluIjoiMTciLCJleHAiOjE0NTc2MTM2NDV9.y6wMMewJT5x6_XR2dU06iyNI9-dDGsMc2HbhnRFsF2I', null, null, '20160310074045');
INSERT INTO `sys_session` VALUES ('34', '1', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiIxIiwidXNlcm5hbWUiOiJzeXNhZG1pbiIsIm5hbWUiOiJTeXN0ZW0gQWRtaW5pc3RyYXRvciIsImFkZHJlc3MiOm51bGwsImVtYWlsIjoiZGV2ZWxvcGVyQGFraGRhbmkuY28uaWQiLCJwaG9uZSI6bnVsbCwidXNlcmdyb3VwaWQiOiIxIiwiaXNlbmFibGVkIjoiMSIsImNsaWVudGlkIjoiMCIsImNvdW50ZXJpZCI6IjAiLCJ1c2VyZ3JvdXBuYW1lIjoic3lzYWRtaW4iLCJ1c2VybGV2ZWwiOiIxIiwiaXNkaXNwbGF5ZWQiOiIwIiwiaXNhbGxvd3JlZ2lzdHJhdGlvbiI6IjAiLCJpc2xvZ2dlZGluIjoiMTgiLCJleHAiOjE0NTc2MTM2NDV9.e76Wyfsuk4m9KlV5Um96wW1Z6qjQl6CCEWkcOVObkfU', null, null, '20160310074045');
INSERT INTO `sys_session` VALUES ('35', '1', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiIxIiwidXNlcm5hbWUiOiJzeXNhZG1pbiIsIm5hbWUiOiJTeXN0ZW0gQWRtaW5pc3RyYXRvciIsImFkZHJlc3MiOm51bGwsImVtYWlsIjoiZGV2ZWxvcGVyQGFraGRhbmkuY28uaWQiLCJwaG9uZSI6bnVsbCwidXNlcmdyb3VwaWQiOiIxIiwiaXNlbmFibGVkIjoiMSIsImNsaWVudGlkIjoiMCIsImNvdW50ZXJpZCI6IjAiLCJ1c2VyZ3JvdXBuYW1lIjoic3lzYWRtaW4iLCJ1c2VybGV2ZWwiOiIxIiwiaXNkaXNwbGF5ZWQiOiIwIiwiaXNhbGxvd3JlZ2lzdHJhdGlvbiI6IjAiLCJpc2xvZ2dlZGluIjoiMTkiLCJleHAiOjE0NTc2MTM2NDV9.fpZ5f4W0Tr9nVaMy1RXqTCOsvebi2xupfzQ9cOluanE', null, null, '20160310074045');
INSERT INTO `sys_session` VALUES ('36', '8', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiI4IiwidXNlcm5hbWUiOiJ1c2VyMSIsIm5hbWUiOiJVc2VyIDEiLCJhZGRyZXNzIjpudWxsLCJlbWFpbCI6InVzZXIxQGdtYWlsLmNvbSIsInBob25lIjpudWxsLCJ1c2VyZ3JvdXBpZCI6IjQiLCJpc2VuYWJsZWQiOiIxIiwiY2xpZW50aWQiOiIwIiwiY291bnRlcmlkIjoiMCIsInVzZXJncm91cG5hbWUiOiJ1c2VyIiwidXNlcmxldmVsIjoiOCIsImlzZGlzcGxheWVkIjoiMSIsImlzYWxsb3dyZWdpc3RyYXRpb24iOiIxIiwiaXNsb2dnZWRpbiI6IjUiLCJleHAiOjE0NTc2MTM3MDR9.uEuEd-4OukOF-7lEpRbKn5UAfOZR1KdNn7TPTnYjxIs', null, null, '20160310074144');
INSERT INTO `sys_session` VALUES ('37', '1', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiIxIiwidXNlcm5hbWUiOiJzeXNhZG1pbiIsIm5hbWUiOiJTeXN0ZW0gQWRtaW5pc3RyYXRvciIsImFkZHJlc3MiOm51bGwsImVtYWlsIjoiZGV2ZWxvcGVyQGFraGRhbmkuY28uaWQiLCJwaG9uZSI6bnVsbCwidXNlcmdyb3VwaWQiOiIxIiwiaXNlbmFibGVkIjoiMSIsImNsaWVudGlkIjoiMCIsImNvdW50ZXJpZCI6IjAiLCJ1c2VyZ3JvdXBuYW1lIjoic3lzYWRtaW4iLCJ1c2VybGV2ZWwiOiIxIiwiaXNkaXNwbGF5ZWQiOiIwIiwiaXNhbGxvd3JlZ2lzdHJhdGlvbiI6IjAiLCJpc2xvZ2dlZGluIjoiMjAiLCJleHAiOjE0NTc2MTM3MDV9.DUrmJmsvxBDby8nVkanp57XoHdTwjr_lvctnZDZof4k', null, null, '20160310074145');
INSERT INTO `sys_session` VALUES ('38', '1', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiIxIiwidXNlcm5hbWUiOiJzeXNhZG1pbiIsIm5hbWUiOiJTeXN0ZW0gQWRtaW5pc3RyYXRvciIsImFkZHJlc3MiOm51bGwsImVtYWlsIjoiZGV2ZWxvcGVyQGFraGRhbmkuY28uaWQiLCJwaG9uZSI6bnVsbCwidXNlcmdyb3VwaWQiOiIxIiwiaXNlbmFibGVkIjoiMSIsImNsaWVudGlkIjoiMCIsImNvdW50ZXJpZCI6IjAiLCJ1c2VyZ3JvdXBuYW1lIjoic3lzYWRtaW4iLCJ1c2VybGV2ZWwiOiIxIiwiaXNkaXNwbGF5ZWQiOiIwIiwiaXNhbGxvd3JlZ2lzdHJhdGlvbiI6IjAiLCJpc2xvZ2dlZGluIjoiMjEiLCJleHAiOjE0NTc2MTM3MDV9.W4kEr06dnBjPGMdjStEdgEGnI_vLiFoQ5uEnGv9vIkw', null, null, '20160310074145');
INSERT INTO `sys_session` VALUES ('39', '1', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiIxIiwidXNlcm5hbWUiOiJzeXNhZG1pbiIsIm5hbWUiOiJTeXN0ZW0gQWRtaW5pc3RyYXRvciIsImFkZHJlc3MiOm51bGwsImVtYWlsIjoiZGV2ZWxvcGVyQGFraGRhbmkuY28uaWQiLCJwaG9uZSI6bnVsbCwidXNlcmdyb3VwaWQiOiIxIiwiaXNlbmFibGVkIjoiMSIsImNsaWVudGlkIjoiMCIsImNvdW50ZXJpZCI6IjAiLCJ1c2VyZ3JvdXBuYW1lIjoic3lzYWRtaW4iLCJ1c2VybGV2ZWwiOiIxIiwiaXNkaXNwbGF5ZWQiOiIwIiwiaXNhbGxvd3JlZ2lzdHJhdGlvbiI6IjAiLCJpc2xvZ2dlZGluIjoiMjIiLCJleHAiOjE0NTc2MTM3MDV9.8SbFuajm5eDXyaLFMED4amCSK1UdYUwT9WVFhrEWm08', null, null, '20160310074145');
INSERT INTO `sys_session` VALUES ('40', '1', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiIxIiwidXNlcm5hbWUiOiJzeXNhZG1pbiIsIm5hbWUiOiJTeXN0ZW0gQWRtaW5pc3RyYXRvciIsImFkZHJlc3MiOm51bGwsImVtYWlsIjoiZGV2ZWxvcGVyQGFraGRhbmkuY28uaWQiLCJwaG9uZSI6bnVsbCwidXNlcmdyb3VwaWQiOiIxIiwiaXNlbmFibGVkIjoiMSIsImNsaWVudGlkIjoiMCIsImNvdW50ZXJpZCI6IjAiLCJ1c2VyZ3JvdXBuYW1lIjoic3lzYWRtaW4iLCJ1c2VybGV2ZWwiOiIxIiwiaXNkaXNwbGF5ZWQiOiIwIiwiaXNhbGxvd3JlZ2lzdHJhdGlvbiI6IjAiLCJpc2xvZ2dlZGluIjoiMjMiLCJleHAiOjE0NTc2MTM3MDZ9.-wBevkRi_kfJ1kB5aU1k22ONzPXK70trtSk2w8M6Ziw', null, null, '20160310074146');
INSERT INTO `sys_session` VALUES ('41', '1', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiIxIiwidXNlcm5hbWUiOiJzeXNhZG1pbiIsIm5hbWUiOiJTeXN0ZW0gQWRtaW5pc3RyYXRvciIsImFkZHJlc3MiOm51bGwsImVtYWlsIjoiZGV2ZWxvcGVyQGFraGRhbmkuY28uaWQiLCJwaG9uZSI6bnVsbCwidXNlcmdyb3VwaWQiOiIxIiwiaXNlbmFibGVkIjoiMSIsImNsaWVudGlkIjoiMCIsImNvdW50ZXJpZCI6IjAiLCJ1c2VyZ3JvdXBuYW1lIjoic3lzYWRtaW4iLCJ1c2VybGV2ZWwiOiIxIiwiaXNkaXNwbGF5ZWQiOiIwIiwiaXNhbGxvd3JlZ2lzdHJhdGlvbiI6IjAiLCJpc2xvZ2dlZGluIjoiMjQiLCJleHAiOjE0NTc2MTM3MDZ9.1znJ8a1R1llh1xMhZbv1QvFVVjJR9O1N4rWvib6ereo', null, null, '20160310074146');
INSERT INTO `sys_session` VALUES ('42', '1', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiIxIiwidXNlcm5hbWUiOiJzeXNhZG1pbiIsIm5hbWUiOiJTeXN0ZW0gQWRtaW5pc3RyYXRvciIsImFkZHJlc3MiOm51bGwsImVtYWlsIjoiZGV2ZWxvcGVyQGFraGRhbmkuY28uaWQiLCJwaG9uZSI6bnVsbCwidXNlcmdyb3VwaWQiOiIxIiwiaXNlbmFibGVkIjoiMSIsImNsaWVudGlkIjoiMCIsImNvdW50ZXJpZCI6IjAiLCJ1c2VyZ3JvdXBuYW1lIjoic3lzYWRtaW4iLCJ1c2VybGV2ZWwiOiIxIiwiaXNkaXNwbGF5ZWQiOiIwIiwiaXNhbGxvd3JlZ2lzdHJhdGlvbiI6IjAiLCJpc2xvZ2dlZGluIjoiMjUiLCJleHAiOjE0NTc2MTM3MDd9.ZAlGYap-wOpTQU2SHFozIaoFHa2cO6CpW6CIsSDM17E', null, null, '20160310074147');
INSERT INTO `sys_session` VALUES ('43', '8', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiI4IiwidXNlcm5hbWUiOiJ1c2VyMSIsIm5hbWUiOiJVc2VyIDEiLCJhZGRyZXNzIjpudWxsLCJlbWFpbCI6InVzZXIxQGdtYWlsLmNvbSIsInBob25lIjpudWxsLCJ1c2VyZ3JvdXBpZCI6IjQiLCJpc2VuYWJsZWQiOiIxIiwiY2xpZW50aWQiOiIwIiwiY291bnRlcmlkIjoiMCIsInVzZXJncm91cG5hbWUiOiJ1c2VyIiwidXNlcmxldmVsIjoiOCIsImlzZGlzcGxheWVkIjoiMSIsImlzYWxsb3dyZWdpc3RyYXRpb24iOiIxIiwiaXNsb2dnZWRpbiI6IjYiLCJleHAiOjE0NTc2MTQwMzJ9.oUFJQO19pehKBqDMUvnbgQbRzmFwZj_aui7K4hl7KIA', null, null, '20160310074712');
INSERT INTO `sys_session` VALUES ('44', '1', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiIxIiwidXNlcm5hbWUiOiJzeXNhZG1pbiIsIm5hbWUiOiJTeXN0ZW0gQWRtaW5pc3RyYXRvciIsImFkZHJlc3MiOm51bGwsImVtYWlsIjoiZGV2ZWxvcGVyQGFraGRhbmkuY28uaWQiLCJwaG9uZSI6bnVsbCwidXNlcmdyb3VwaWQiOiIxIiwiaXNlbmFibGVkIjoiMSIsImNsaWVudGlkIjoiMCIsImNvdW50ZXJpZCI6IjAiLCJ1c2VyZ3JvdXBuYW1lIjoic3lzYWRtaW4iLCJ1c2VybGV2ZWwiOiIxIiwiaXNkaXNwbGF5ZWQiOiIwIiwiaXNhbGxvd3JlZ2lzdHJhdGlvbiI6IjAiLCJpc2xvZ2dlZGluIjoiMjYiLCJleHAiOjE0NTc2MTQwMzN9.g6WsiEtOvssvGE-MruVWo8WduB-26489UMvMI6dJ44M', null, null, '20160310074713');
INSERT INTO `sys_session` VALUES ('45', '1', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiIxIiwidXNlcm5hbWUiOiJzeXNhZG1pbiIsIm5hbWUiOiJTeXN0ZW0gQWRtaW5pc3RyYXRvciIsImFkZHJlc3MiOm51bGwsImVtYWlsIjoiZGV2ZWxvcGVyQGFraGRhbmkuY28uaWQiLCJwaG9uZSI6bnVsbCwidXNlcmdyb3VwaWQiOiIxIiwiaXNlbmFibGVkIjoiMSIsImNsaWVudGlkIjoiMCIsImNvdW50ZXJpZCI6IjAiLCJ1c2VyZ3JvdXBuYW1lIjoic3lzYWRtaW4iLCJ1c2VybGV2ZWwiOiIxIiwiaXNkaXNwbGF5ZWQiOiIwIiwiaXNhbGxvd3JlZ2lzdHJhdGlvbiI6IjAiLCJpc2xvZ2dlZGluIjoiMjciLCJleHAiOjE0NTc2MTQwMzN9.3Q5CfWXzlysR7l1XO4WG2EkeN4nHYfIraEaAANpjs0U', null, null, '20160310074713');
INSERT INTO `sys_session` VALUES ('46', '1', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiIxIiwidXNlcm5hbWUiOiJzeXNhZG1pbiIsIm5hbWUiOiJTeXN0ZW0gQWRtaW5pc3RyYXRvciIsImFkZHJlc3MiOm51bGwsImVtYWlsIjoiZGV2ZWxvcGVyQGFraGRhbmkuY28uaWQiLCJwaG9uZSI6bnVsbCwidXNlcmdyb3VwaWQiOiIxIiwiaXNlbmFibGVkIjoiMSIsImNsaWVudGlkIjoiMCIsImNvdW50ZXJpZCI6IjAiLCJ1c2VyZ3JvdXBuYW1lIjoic3lzYWRtaW4iLCJ1c2VybGV2ZWwiOiIxIiwiaXNkaXNwbGF5ZWQiOiIwIiwiaXNhbGxvd3JlZ2lzdHJhdGlvbiI6IjAiLCJpc2xvZ2dlZGluIjoiMjgiLCJleHAiOjE0NTc2MTQwMzN9.Ucb52ylmo95rF5pdkH0PcMBm415vQQLQkB7AyTYic_8', null, null, '20160310074713');
INSERT INTO `sys_session` VALUES ('47', '1', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiIxIiwidXNlcm5hbWUiOiJzeXNhZG1pbiIsIm5hbWUiOiJTeXN0ZW0gQWRtaW5pc3RyYXRvciIsImFkZHJlc3MiOm51bGwsImVtYWlsIjoiZGV2ZWxvcGVyQGFraGRhbmkuY28uaWQiLCJwaG9uZSI6bnVsbCwidXNlcmdyb3VwaWQiOiIxIiwiaXNlbmFibGVkIjoiMSIsImNsaWVudGlkIjoiMCIsImNvdW50ZXJpZCI6IjAiLCJ1c2VyZ3JvdXBuYW1lIjoic3lzYWRtaW4iLCJ1c2VybGV2ZWwiOiIxIiwiaXNkaXNwbGF5ZWQiOiIwIiwiaXNhbGxvd3JlZ2lzdHJhdGlvbiI6IjAiLCJpc2xvZ2dlZGluIjoiMjkiLCJleHAiOjE0NTc2MTQwMzN9.ywR7semG6NPixUAdGKarnygFE-Ig_nqeQGdJI9C94yQ', null, null, '20160310074713');
INSERT INTO `sys_session` VALUES ('48', '1', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiIxIiwidXNlcm5hbWUiOiJzeXNhZG1pbiIsIm5hbWUiOiJTeXN0ZW0gQWRtaW5pc3RyYXRvciIsImFkZHJlc3MiOm51bGwsImVtYWlsIjoiZGV2ZWxvcGVyQGFraGRhbmkuY28uaWQiLCJwaG9uZSI6bnVsbCwidXNlcmdyb3VwaWQiOiIxIiwiaXNlbmFibGVkIjoiMSIsImNsaWVudGlkIjoiMCIsImNvdW50ZXJpZCI6IjAiLCJ1c2VyZ3JvdXBuYW1lIjoic3lzYWRtaW4iLCJ1c2VybGV2ZWwiOiIxIiwiaXNkaXNwbGF5ZWQiOiIwIiwiaXNhbGxvd3JlZ2lzdHJhdGlvbiI6IjAiLCJpc2xvZ2dlZGluIjoiMzAiLCJleHAiOjE0NTc2MTQwMzN9.xU6HFcmfUQBur1hr8CCSs6_YbbBZUERQ2b_IveWNqIs', null, null, '20160310074713');
INSERT INTO `sys_session` VALUES ('49', '1', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiIxIiwidXNlcm5hbWUiOiJzeXNhZG1pbiIsIm5hbWUiOiJTeXN0ZW0gQWRtaW5pc3RyYXRvciIsImFkZHJlc3MiOm51bGwsImVtYWlsIjoiZGV2ZWxvcGVyQGFraGRhbmkuY28uaWQiLCJwaG9uZSI6bnVsbCwidXNlcmdyb3VwaWQiOiIxIiwiaXNlbmFibGVkIjoiMSIsImNsaWVudGlkIjoiMCIsImNvdW50ZXJpZCI6IjAiLCJ1c2VyZ3JvdXBuYW1lIjoic3lzYWRtaW4iLCJ1c2VybGV2ZWwiOiIxIiwiaXNkaXNwbGF5ZWQiOiIwIiwiaXNhbGxvd3JlZ2lzdHJhdGlvbiI6IjAiLCJpc2xvZ2dlZGluIjoiMzEiLCJleHAiOjE0NTc2MTQwMzR9.ocABHEHJH881iysYDkgC2mPjhForh_V81fThWXcvUpk', null, null, '20160310074714');
INSERT INTO `sys_session` VALUES ('50', '8', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiI4IiwidXNlcm5hbWUiOiJ1c2VyMSIsIm5hbWUiOiJVc2VyIDEiLCJhZGRyZXNzIjpudWxsLCJlbWFpbCI6InVzZXIxQGdtYWlsLmNvbSIsInBob25lIjpudWxsLCJ1c2VyZ3JvdXBpZCI6IjQiLCJpc2VuYWJsZWQiOiIxIiwiY2xpZW50aWQiOiIwIiwiY291bnRlcmlkIjoiMCIsInVzZXJncm91cG5hbWUiOiJ1c2VyIiwidXNlcmxldmVsIjoiOCIsImlzZGlzcGxheWVkIjoiMSIsImlzYWxsb3dyZWdpc3RyYXRpb24iOiIxIiwiaXNsb2dnZWRpbiI6IjciLCJleHAiOjE0NTc2MTQwODh9.AszUxhwJ8pc0eqQ4G09yAJs0H129NLmAHOqCRVT7-pc', null, null, '20160310074808');
INSERT INTO `sys_session` VALUES ('51', '1', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiIxIiwidXNlcm5hbWUiOiJzeXNhZG1pbiIsIm5hbWUiOiJTeXN0ZW0gQWRtaW5pc3RyYXRvciIsImFkZHJlc3MiOm51bGwsImVtYWlsIjoiZGV2ZWxvcGVyQGFraGRhbmkuY28uaWQiLCJwaG9uZSI6bnVsbCwidXNlcmdyb3VwaWQiOiIxIiwiaXNlbmFibGVkIjoiMSIsImNsaWVudGlkIjoiMCIsImNvdW50ZXJpZCI6IjAiLCJ1c2VyZ3JvdXBuYW1lIjoic3lzYWRtaW4iLCJ1c2VybGV2ZWwiOiIxIiwiaXNkaXNwbGF5ZWQiOiIwIiwiaXNhbGxvd3JlZ2lzdHJhdGlvbiI6IjAiLCJpc2xvZ2dlZGluIjoiMzIiLCJleHAiOjE0NTc2MTQwODh9.9dp-fcLjhKAJ_QSatT2YP91ctLkqjBRU-5VD-D7iSS4', null, null, '20160310074808');
INSERT INTO `sys_session` VALUES ('52', '1', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiIxIiwidXNlcm5hbWUiOiJzeXNhZG1pbiIsIm5hbWUiOiJTeXN0ZW0gQWRtaW5pc3RyYXRvciIsImFkZHJlc3MiOm51bGwsImVtYWlsIjoiZGV2ZWxvcGVyQGFraGRhbmkuY28uaWQiLCJwaG9uZSI6bnVsbCwidXNlcmdyb3VwaWQiOiIxIiwiaXNlbmFibGVkIjoiMSIsImNsaWVudGlkIjoiMCIsImNvdW50ZXJpZCI6IjAiLCJ1c2VyZ3JvdXBuYW1lIjoic3lzYWRtaW4iLCJ1c2VybGV2ZWwiOiIxIiwiaXNkaXNwbGF5ZWQiOiIwIiwiaXNhbGxvd3JlZ2lzdHJhdGlvbiI6IjAiLCJpc2xvZ2dlZGluIjoiMzMiLCJleHAiOjE0NTc2MTQwODl9.7ql6zlRq0_WO4vbbRMgskjO197-SHf_hJJ2D3dTkeH4', null, null, '20160310074809');
INSERT INTO `sys_session` VALUES ('53', '1', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiIxIiwidXNlcm5hbWUiOiJzeXNhZG1pbiIsIm5hbWUiOiJTeXN0ZW0gQWRtaW5pc3RyYXRvciIsImFkZHJlc3MiOm51bGwsImVtYWlsIjoiZGV2ZWxvcGVyQGFraGRhbmkuY28uaWQiLCJwaG9uZSI6bnVsbCwidXNlcmdyb3VwaWQiOiIxIiwiaXNlbmFibGVkIjoiMSIsImNsaWVudGlkIjoiMCIsImNvdW50ZXJpZCI6IjAiLCJ1c2VyZ3JvdXBuYW1lIjoic3lzYWRtaW4iLCJ1c2VybGV2ZWwiOiIxIiwiaXNkaXNwbGF5ZWQiOiIwIiwiaXNhbGxvd3JlZ2lzdHJhdGlvbiI6IjAiLCJpc2xvZ2dlZGluIjoiMzQiLCJleHAiOjE0NTc2MTQwODl9.RvfmNv-0iFEIUeRE8LeX31ZG32V3YJT5rVGMMLgoAso', null, null, '20160310074809');
INSERT INTO `sys_session` VALUES ('54', '1', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiIxIiwidXNlcm5hbWUiOiJzeXNhZG1pbiIsIm5hbWUiOiJTeXN0ZW0gQWRtaW5pc3RyYXRvciIsImFkZHJlc3MiOm51bGwsImVtYWlsIjoiZGV2ZWxvcGVyQGFraGRhbmkuY28uaWQiLCJwaG9uZSI6bnVsbCwidXNlcmdyb3VwaWQiOiIxIiwiaXNlbmFibGVkIjoiMSIsImNsaWVudGlkIjoiMCIsImNvdW50ZXJpZCI6IjAiLCJ1c2VyZ3JvdXBuYW1lIjoic3lzYWRtaW4iLCJ1c2VybGV2ZWwiOiIxIiwiaXNkaXNwbGF5ZWQiOiIwIiwiaXNhbGxvd3JlZ2lzdHJhdGlvbiI6IjAiLCJpc2xvZ2dlZGluIjoiMzUiLCJleHAiOjE0NTc2MTQwODl9.uvMDunyRu5hKfwUGrvhLmjpmQ4t-4YOV6n7KlztHyV4', null, null, '20160310074809');
INSERT INTO `sys_session` VALUES ('55', '1', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiIxIiwidXNlcm5hbWUiOiJzeXNhZG1pbiIsIm5hbWUiOiJTeXN0ZW0gQWRtaW5pc3RyYXRvciIsImFkZHJlc3MiOm51bGwsImVtYWlsIjoiZGV2ZWxvcGVyQGFraGRhbmkuY28uaWQiLCJwaG9uZSI6bnVsbCwidXNlcmdyb3VwaWQiOiIxIiwiaXNlbmFibGVkIjoiMSIsImNsaWVudGlkIjoiMCIsImNvdW50ZXJpZCI6IjAiLCJ1c2VyZ3JvdXBuYW1lIjoic3lzYWRtaW4iLCJ1c2VybGV2ZWwiOiIxIiwiaXNkaXNwbGF5ZWQiOiIwIiwiaXNhbGxvd3JlZ2lzdHJhdGlvbiI6IjAiLCJpc2xvZ2dlZGluIjoiMzYiLCJleHAiOjE0NTc2MTQwODl9.BFwWuXLMsZG61Gg_wJhSFkPU1yUCVj38e0-40OLPLmU', null, null, '20160310074809');
INSERT INTO `sys_session` VALUES ('56', '1', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiIxIiwidXNlcm5hbWUiOiJzeXNhZG1pbiIsIm5hbWUiOiJTeXN0ZW0gQWRtaW5pc3RyYXRvciIsImFkZHJlc3MiOm51bGwsImVtYWlsIjoiZGV2ZWxvcGVyQGFraGRhbmkuY28uaWQiLCJwaG9uZSI6bnVsbCwidXNlcmdyb3VwaWQiOiIxIiwiaXNlbmFibGVkIjoiMSIsImNsaWVudGlkIjoiMCIsImNvdW50ZXJpZCI6IjAiLCJ1c2VyZ3JvdXBuYW1lIjoic3lzYWRtaW4iLCJ1c2VybGV2ZWwiOiIxIiwiaXNkaXNwbGF5ZWQiOiIwIiwiaXNhbGxvd3JlZ2lzdHJhdGlvbiI6IjAiLCJpc2xvZ2dlZGluIjoiMzciLCJleHAiOjE0NTc2MTQwODl9.h_x62BzWtgsouEcnnKn_45WQWIqS2ZRTR7yj-rY8l44', null, null, '20160310074809');
INSERT INTO `sys_session` VALUES ('57', '8', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiI4IiwidXNlcm5hbWUiOiJ1c2VyMSIsIm5hbWUiOiJVc2VyIDEiLCJhZGRyZXNzIjpudWxsLCJlbWFpbCI6InVzZXIxQGdtYWlsLmNvbSIsInBob25lIjpudWxsLCJ1c2VyZ3JvdXBpZCI6IjQiLCJpc2VuYWJsZWQiOiIxIiwiY2xpZW50aWQiOiIwIiwiY291bnRlcmlkIjoiMCIsInVzZXJncm91cG5hbWUiOiJ1c2VyIiwidXNlcmxldmVsIjoiOCIsImlzZGlzcGxheWVkIjoiMSIsImlzYWxsb3dyZWdpc3RyYXRpb24iOiIxIiwiaXNsb2dnZWRpbiI6IjgiLCJleHAiOjE0NTc2MTQxMTV9.iltXhE7QdMYCIVWLklAxF_0p0FUIuAmnjuR_Mfm-I4E', null, null, '20160310074835');
INSERT INTO `sys_session` VALUES ('58', '1', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiIxIiwidXNlcm5hbWUiOiJzeXNhZG1pbiIsIm5hbWUiOiJTeXN0ZW0gQWRtaW5pc3RyYXRvciIsImFkZHJlc3MiOm51bGwsImVtYWlsIjoiZGV2ZWxvcGVyQGFraGRhbmkuY28uaWQiLCJwaG9uZSI6bnVsbCwidXNlcmdyb3VwaWQiOiIxIiwiaXNlbmFibGVkIjoiMSIsImNsaWVudGlkIjoiMCIsImNvdW50ZXJpZCI6IjAiLCJ1c2VyZ3JvdXBuYW1lIjoic3lzYWRtaW4iLCJ1c2VybGV2ZWwiOiIxIiwiaXNkaXNwbGF5ZWQiOiIwIiwiaXNhbGxvd3JlZ2lzdHJhdGlvbiI6IjAiLCJpc2xvZ2dlZGluIjoiMzgiLCJleHAiOjE0NTc2MTQxMTZ9.LkOdSuUqNzUupSMjRS1R25C4_UqRDKHhmHpAfH3m1mw', null, null, '20160310074836');
INSERT INTO `sys_session` VALUES ('59', '1', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiIxIiwidXNlcm5hbWUiOiJzeXNhZG1pbiIsIm5hbWUiOiJTeXN0ZW0gQWRtaW5pc3RyYXRvciIsImFkZHJlc3MiOm51bGwsImVtYWlsIjoiZGV2ZWxvcGVyQGFraGRhbmkuY28uaWQiLCJwaG9uZSI6bnVsbCwidXNlcmdyb3VwaWQiOiIxIiwiaXNlbmFibGVkIjoiMSIsImNsaWVudGlkIjoiMCIsImNvdW50ZXJpZCI6IjAiLCJ1c2VyZ3JvdXBuYW1lIjoic3lzYWRtaW4iLCJ1c2VybGV2ZWwiOiIxIiwiaXNkaXNwbGF5ZWQiOiIwIiwiaXNhbGxvd3JlZ2lzdHJhdGlvbiI6IjAiLCJpc2xvZ2dlZGluIjoiMzkiLCJleHAiOjE0NTc2MTQxMTZ9.zE4e3-wZiFyzTIXSnTQZGEhuTXIww9SMt7on6jKe-_8', null, null, '20160310074836');
INSERT INTO `sys_session` VALUES ('60', '1', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiIxIiwidXNlcm5hbWUiOiJzeXNhZG1pbiIsIm5hbWUiOiJTeXN0ZW0gQWRtaW5pc3RyYXRvciIsImFkZHJlc3MiOm51bGwsImVtYWlsIjoiZGV2ZWxvcGVyQGFraGRhbmkuY28uaWQiLCJwaG9uZSI6bnVsbCwidXNlcmdyb3VwaWQiOiIxIiwiaXNlbmFibGVkIjoiMSIsImNsaWVudGlkIjoiMCIsImNvdW50ZXJpZCI6IjAiLCJ1c2VyZ3JvdXBuYW1lIjoic3lzYWRtaW4iLCJ1c2VybGV2ZWwiOiIxIiwiaXNkaXNwbGF5ZWQiOiIwIiwiaXNhbGxvd3JlZ2lzdHJhdGlvbiI6IjAiLCJpc2xvZ2dlZGluIjoiNDAiLCJleHAiOjE0NTc2MTQxMTZ9.YLl1NqWeMkZibHsSfs-lo6YP-0QteE98UfQVfPIr6Uc', null, null, '20160310074836');
INSERT INTO `sys_session` VALUES ('61', '1', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiIxIiwidXNlcm5hbWUiOiJzeXNhZG1pbiIsIm5hbWUiOiJTeXN0ZW0gQWRtaW5pc3RyYXRvciIsImFkZHJlc3MiOm51bGwsImVtYWlsIjoiZGV2ZWxvcGVyQGFraGRhbmkuY28uaWQiLCJwaG9uZSI6bnVsbCwidXNlcmdyb3VwaWQiOiIxIiwiaXNlbmFibGVkIjoiMSIsImNsaWVudGlkIjoiMCIsImNvdW50ZXJpZCI6IjAiLCJ1c2VyZ3JvdXBuYW1lIjoic3lzYWRtaW4iLCJ1c2VybGV2ZWwiOiIxIiwiaXNkaXNwbGF5ZWQiOiIwIiwiaXNhbGxvd3JlZ2lzdHJhdGlvbiI6IjAiLCJpc2xvZ2dlZGluIjoiNDEiLCJleHAiOjE0NTc2MTQxMTZ9.0Du4FKUD2bgCeHtAdMRpi8Vp5d7zhzcbO1L-wcsZyO0', null, null, '20160310074836');
INSERT INTO `sys_session` VALUES ('62', '1', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiIxIiwidXNlcm5hbWUiOiJzeXNhZG1pbiIsIm5hbWUiOiJTeXN0ZW0gQWRtaW5pc3RyYXRvciIsImFkZHJlc3MiOm51bGwsImVtYWlsIjoiZGV2ZWxvcGVyQGFraGRhbmkuY28uaWQiLCJwaG9uZSI6bnVsbCwidXNlcmdyb3VwaWQiOiIxIiwiaXNlbmFibGVkIjoiMSIsImNsaWVudGlkIjoiMCIsImNvdW50ZXJpZCI6IjAiLCJ1c2VyZ3JvdXBuYW1lIjoic3lzYWRtaW4iLCJ1c2VybGV2ZWwiOiIxIiwiaXNkaXNwbGF5ZWQiOiIwIiwiaXNhbGxvd3JlZ2lzdHJhdGlvbiI6IjAiLCJpc2xvZ2dlZGluIjoiNDIiLCJleHAiOjE0NTc2MTQxMTZ9.xXrYjauk2GhlZFE-7atCkn1oLPgRVhFyE851OM6h9Go', null, null, '20160310074836');
INSERT INTO `sys_session` VALUES ('63', '1', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiIxIiwidXNlcm5hbWUiOiJzeXNhZG1pbiIsIm5hbWUiOiJTeXN0ZW0gQWRtaW5pc3RyYXRvciIsImFkZHJlc3MiOm51bGwsImVtYWlsIjoiZGV2ZWxvcGVyQGFraGRhbmkuY28uaWQiLCJwaG9uZSI6bnVsbCwidXNlcmdyb3VwaWQiOiIxIiwiaXNlbmFibGVkIjoiMSIsImNsaWVudGlkIjoiMCIsImNvdW50ZXJpZCI6IjAiLCJ1c2VyZ3JvdXBuYW1lIjoic3lzYWRtaW4iLCJ1c2VybGV2ZWwiOiIxIiwiaXNkaXNwbGF5ZWQiOiIwIiwiaXNhbGxvd3JlZ2lzdHJhdGlvbiI6IjAiLCJpc2xvZ2dlZGluIjoiNDMiLCJleHAiOjE0NTc2MTQxMTd9.cd-aSqrDi5MSMj5VQcSTCtq2r-GgGfbUMzOCY1KNOII', null, null, '20160310074837');
INSERT INTO `sys_session` VALUES ('65', '1', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiIxIiwidXNlcm5hbWUiOiJzeXNhZG1pbiIsIm5hbWUiOiJTeXN0ZW0gQWRtaW5pc3RyYXRvciIsImFkZHJlc3MiOm51bGwsImVtYWlsIjoiZGV2ZWxvcGVyQGFraGRhbmkuY28uaWQiLCJwaG9uZSI6bnVsbCwidXNlcmdyb3VwaWQiOiIxIiwiaXNlbmFibGVkIjoiMSIsImNsaWVudGlkIjoiMCIsImNvdW50ZXJpZCI6IjAiLCJ1c2VyZ3JvdXBuYW1lIjoic3lzYWRtaW4iLCJ1c2VybGV2ZWwiOiIxIiwiaXNkaXNwbGF5ZWQiOiIwIiwiaXNhbGxvd3JlZ2lzdHJhdGlvbiI6IjAiLCJpc2xvZ2dlZGluIjoiNDQiLCJleHAiOjE0NTc2MTQzMjJ9.c8XioN6nGSn0xXxJdh2BQhSGPjKRsJc6nvD2SeoHzQI', null, null, '20160310075202');
INSERT INTO `sys_session` VALUES ('66', '1', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiIxIiwidXNlcm5hbWUiOiJzeXNhZG1pbiIsIm5hbWUiOiJTeXN0ZW0gQWRtaW5pc3RyYXRvciIsImFkZHJlc3MiOm51bGwsImVtYWlsIjoiZGV2ZWxvcGVyQGFraGRhbmkuY28uaWQiLCJwaG9uZSI6bnVsbCwidXNlcmdyb3VwaWQiOiIxIiwiaXNlbmFibGVkIjoiMSIsImNsaWVudGlkIjoiMCIsImNvdW50ZXJpZCI6IjAiLCJ1c2VyZ3JvdXBuYW1lIjoic3lzYWRtaW4iLCJ1c2VybGV2ZWwiOiIxIiwiaXNkaXNwbGF5ZWQiOiIwIiwiaXNhbGxvd3JlZ2lzdHJhdGlvbiI6IjAiLCJpc2xvZ2dlZGluIjoiNDUiLCJleHAiOjE0NTc2MTQzMjN9.Vz8ndpXnJYCfo11MqIdSetXk-7x6eCEo4JdhEc64CiA', null, null, '20160310075203');
INSERT INTO `sys_session` VALUES ('67', '1', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiIxIiwidXNlcm5hbWUiOiJzeXNhZG1pbiIsIm5hbWUiOiJTeXN0ZW0gQWRtaW5pc3RyYXRvciIsImFkZHJlc3MiOm51bGwsImVtYWlsIjoiZGV2ZWxvcGVyQGFraGRhbmkuY28uaWQiLCJwaG9uZSI6bnVsbCwidXNlcmdyb3VwaWQiOiIxIiwiaXNlbmFibGVkIjoiMSIsImNsaWVudGlkIjoiMCIsImNvdW50ZXJpZCI6IjAiLCJ1c2VyZ3JvdXBuYW1lIjoic3lzYWRtaW4iLCJ1c2VybGV2ZWwiOiIxIiwiaXNkaXNwbGF5ZWQiOiIwIiwiaXNhbGxvd3JlZ2lzdHJhdGlvbiI6IjAiLCJpc2xvZ2dlZGluIjoiNDYiLCJleHAiOjE0NTc2MTQzMjN9.9CYGQnjsf3sXJm_64HjxPmIz0tAlhTPXh96AqS2lXpA', null, null, '20160310075203');
INSERT INTO `sys_session` VALUES ('68', '1', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiIxIiwidXNlcm5hbWUiOiJzeXNhZG1pbiIsIm5hbWUiOiJTeXN0ZW0gQWRtaW5pc3RyYXRvciIsImFkZHJlc3MiOm51bGwsImVtYWlsIjoiZGV2ZWxvcGVyQGFraGRhbmkuY28uaWQiLCJwaG9uZSI6bnVsbCwidXNlcmdyb3VwaWQiOiIxIiwiaXNlbmFibGVkIjoiMSIsImNsaWVudGlkIjoiMCIsImNvdW50ZXJpZCI6IjAiLCJ1c2VyZ3JvdXBuYW1lIjoic3lzYWRtaW4iLCJ1c2VybGV2ZWwiOiIxIiwiaXNkaXNwbGF5ZWQiOiIwIiwiaXNhbGxvd3JlZ2lzdHJhdGlvbiI6IjAiLCJpc2xvZ2dlZGluIjoiNDciLCJleHAiOjE0NTc2MTQzMjN9.rtc4So9cAnaM2oTE0ibfbwLDY5FnRpF10tel56Tshx8', null, null, '20160310075203');
INSERT INTO `sys_session` VALUES ('69', '1', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiIxIiwidXNlcm5hbWUiOiJzeXNhZG1pbiIsIm5hbWUiOiJTeXN0ZW0gQWRtaW5pc3RyYXRvciIsImFkZHJlc3MiOm51bGwsImVtYWlsIjoiZGV2ZWxvcGVyQGFraGRhbmkuY28uaWQiLCJwaG9uZSI6bnVsbCwidXNlcmdyb3VwaWQiOiIxIiwiaXNlbmFibGVkIjoiMSIsImNsaWVudGlkIjoiMCIsImNvdW50ZXJpZCI6IjAiLCJ1c2VyZ3JvdXBuYW1lIjoic3lzYWRtaW4iLCJ1c2VybGV2ZWwiOiIxIiwiaXNkaXNwbGF5ZWQiOiIwIiwiaXNhbGxvd3JlZ2lzdHJhdGlvbiI6IjAiLCJpc2xvZ2dlZGluIjoiNDgiLCJleHAiOjE0NTc2MTQzMjN9.mtuJUt0Nvg2fa5MukbOvcr2mhZbeg7NE8aZ4QX7IpBM', null, null, '20160310075203');
INSERT INTO `sys_session` VALUES ('70', '1', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiIxIiwidXNlcm5hbWUiOiJzeXNhZG1pbiIsIm5hbWUiOiJTeXN0ZW0gQWRtaW5pc3RyYXRvciIsImFkZHJlc3MiOm51bGwsImVtYWlsIjoiZGV2ZWxvcGVyQGFraGRhbmkuY28uaWQiLCJwaG9uZSI6bnVsbCwidXNlcmdyb3VwaWQiOiIxIiwiaXNlbmFibGVkIjoiMSIsImNsaWVudGlkIjoiMCIsImNvdW50ZXJpZCI6IjAiLCJ1c2VyZ3JvdXBuYW1lIjoic3lzYWRtaW4iLCJ1c2VybGV2ZWwiOiIxIiwiaXNkaXNwbGF5ZWQiOiIwIiwiaXNhbGxvd3JlZ2lzdHJhdGlvbiI6IjAiLCJpc2xvZ2dlZGluIjoiNDkiLCJleHAiOjE0NTc2MTQzMjN9.388voG67Lqsg5hm8YGqfsSGg_54adRoV1V0NQI0lO8Y', null, null, '20160310075203');
INSERT INTO `sys_session` VALUES ('71', '8', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiI4IiwidXNlcm5hbWUiOiJ1c2VyMSIsIm5hbWUiOiJVc2VyIDEiLCJhZGRyZXNzIjpudWxsLCJlbWFpbCI6InVzZXIxQGdtYWlsLmNvbSIsInBob25lIjpudWxsLCJ1c2VyZ3JvdXBpZCI6IjQiLCJpc2VuYWJsZWQiOiIxIiwiY2xpZW50aWQiOiIwIiwiY291bnRlcmlkIjoiMCIsInVzZXJncm91cG5hbWUiOiJ1c2VyIiwidXNlcmxldmVsIjoiOCIsImlzZGlzcGxheWVkIjoiMSIsImlzYWxsb3dyZWdpc3RyYXRpb24iOiIxIiwiaXNsb2dnZWRpbiI6IjkiLCJleHAiOjE0NTc2MTQzNzJ9.c7f3OKXxAqF_uE8S9CMkYXIUFdJemo-PFdCA8sS7_D8', null, null, '20160310075252');
INSERT INTO `sys_session` VALUES ('72', '8', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiI4IiwidXNlcm5hbWUiOiJ1c2VyMSIsIm5hbWUiOiJVc2VyIDEiLCJhZGRyZXNzIjpudWxsLCJlbWFpbCI6InVzZXIxQGdtYWlsLmNvbSIsInBob25lIjpudWxsLCJ1c2VyZ3JvdXBpZCI6IjQiLCJpc2VuYWJsZWQiOiIxIiwiY2xpZW50aWQiOiIwIiwiY291bnRlcmlkIjoiMCIsInVzZXJncm91cG5hbWUiOiJ1c2VyIiwidXNlcmxldmVsIjoiOCIsImlzZGlzcGxheWVkIjoiMSIsImlzYWxsb3dyZWdpc3RyYXRpb24iOiIxIiwiaXNsb2dnZWRpbiI6IjEwIiwiZXhwIjoxNDU3NjE0Mzg5fQ.U_0h1gqaqOV4Nq0s6MbDhk8GwYwgKRHTrd1gs1KMwEo', null, null, '20160310075309');
INSERT INTO `sys_session` VALUES ('73', '1', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiIxIiwidXNlcm5hbWUiOiJzeXNhZG1pbiIsIm5hbWUiOiJTeXN0ZW0gQWRtaW5pc3RyYXRvciIsImFkZHJlc3MiOm51bGwsImVtYWlsIjoiZGV2ZWxvcGVyQGFraGRhbmkuY28uaWQiLCJwaG9uZSI6bnVsbCwidXNlcmdyb3VwaWQiOiIxIiwiaXNlbmFibGVkIjoiMSIsImNsaWVudGlkIjoiMCIsImNvdW50ZXJpZCI6IjAiLCJ1c2VyZ3JvdXBuYW1lIjoic3lzYWRtaW4iLCJ1c2VybGV2ZWwiOiIxIiwiaXNkaXNwbGF5ZWQiOiIwIiwiaXNhbGxvd3JlZ2lzdHJhdGlvbiI6IjAiLCJpc2xvZ2dlZGluIjoiNTAiLCJleHAiOjE0NTc2MTQ0MjJ9.GqEWJK5jonvJYcw5c6prHY1sztsDT4yQ7YcmNNDWSZU', null, null, '20160310075342');
INSERT INTO `sys_session` VALUES ('74', '1', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiIxIiwidXNlcm5hbWUiOiJzeXNhZG1pbiIsIm5hbWUiOiJTeXN0ZW0gQWRtaW5pc3RyYXRvciIsImFkZHJlc3MiOm51bGwsImVtYWlsIjoiZGV2ZWxvcGVyQGFraGRhbmkuY28uaWQiLCJwaG9uZSI6bnVsbCwidXNlcmdyb3VwaWQiOiIxIiwiaXNlbmFibGVkIjoiMSIsImNsaWVudGlkIjoiMCIsImNvdW50ZXJpZCI6IjAiLCJ1c2VyZ3JvdXBuYW1lIjoic3lzYWRtaW4iLCJ1c2VybGV2ZWwiOiIxIiwiaXNkaXNwbGF5ZWQiOiIwIiwiaXNhbGxvd3JlZ2lzdHJhdGlvbiI6IjAiLCJpc2xvZ2dlZGluIjoiNTEiLCJleHAiOjE0NTc2MTQ0MjJ9.z19eTPmQYwONY40r3ddnkORpqdMEph8MhiQN0zZSKs0', null, null, '20160310075342');
INSERT INTO `sys_session` VALUES ('75', '1', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiIxIiwidXNlcm5hbWUiOiJzeXNhZG1pbiIsIm5hbWUiOiJTeXN0ZW0gQWRtaW5pc3RyYXRvciIsImFkZHJlc3MiOm51bGwsImVtYWlsIjoiZGV2ZWxvcGVyQGFraGRhbmkuY28uaWQiLCJwaG9uZSI6bnVsbCwidXNlcmdyb3VwaWQiOiIxIiwiaXNlbmFibGVkIjoiMSIsImNsaWVudGlkIjoiMCIsImNvdW50ZXJpZCI6IjAiLCJ1c2VyZ3JvdXBuYW1lIjoic3lzYWRtaW4iLCJ1c2VybGV2ZWwiOiIxIiwiaXNkaXNwbGF5ZWQiOiIwIiwiaXNhbGxvd3JlZ2lzdHJhdGlvbiI6IjAiLCJpc2xvZ2dlZGluIjoiNTIiLCJleHAiOjE0NTc2MTQ0MjN9.XKgnkbs5aSSClbuWZxwy5IyUna7lp20v0UsrKSiLlhc', null, null, '20160310075343');
INSERT INTO `sys_session` VALUES ('76', '1', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiIxIiwidXNlcm5hbWUiOiJzeXNhZG1pbiIsIm5hbWUiOiJTeXN0ZW0gQWRtaW5pc3RyYXRvciIsImFkZHJlc3MiOm51bGwsImVtYWlsIjoiZGV2ZWxvcGVyQGFraGRhbmkuY28uaWQiLCJwaG9uZSI6bnVsbCwidXNlcmdyb3VwaWQiOiIxIiwiaXNlbmFibGVkIjoiMSIsImNsaWVudGlkIjoiMCIsImNvdW50ZXJpZCI6IjAiLCJ1c2VyZ3JvdXBuYW1lIjoic3lzYWRtaW4iLCJ1c2VybGV2ZWwiOiIxIiwiaXNkaXNwbGF5ZWQiOiIwIiwiaXNhbGxvd3JlZ2lzdHJhdGlvbiI6IjAiLCJpc2xvZ2dlZGluIjoiNTMiLCJleHAiOjE0NTc2MTQ0MjN9.duE9-MLIZImIDrT0uLpAohLnZC9sFcyviXYob48zClU', null, null, '20160310075343');
INSERT INTO `sys_session` VALUES ('77', '1', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiIxIiwidXNlcm5hbWUiOiJzeXNhZG1pbiIsIm5hbWUiOiJTeXN0ZW0gQWRtaW5pc3RyYXRvciIsImFkZHJlc3MiOm51bGwsImVtYWlsIjoiZGV2ZWxvcGVyQGFraGRhbmkuY28uaWQiLCJwaG9uZSI6bnVsbCwidXNlcmdyb3VwaWQiOiIxIiwiaXNlbmFibGVkIjoiMSIsImNsaWVudGlkIjoiMCIsImNvdW50ZXJpZCI6IjAiLCJ1c2VyZ3JvdXBuYW1lIjoic3lzYWRtaW4iLCJ1c2VybGV2ZWwiOiIxIiwiaXNkaXNwbGF5ZWQiOiIwIiwiaXNhbGxvd3JlZ2lzdHJhdGlvbiI6IjAiLCJpc2xvZ2dlZGluIjoiNTQiLCJleHAiOjE0NTc2MTQ0MjN9.XE71vUWKDFJoxa3lfc8SgnU5lTDQpElcvaqlNiPwmas', null, null, '20160310075343');
INSERT INTO `sys_session` VALUES ('78', '1', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiIxIiwidXNlcm5hbWUiOiJzeXNhZG1pbiIsIm5hbWUiOiJTeXN0ZW0gQWRtaW5pc3RyYXRvciIsImFkZHJlc3MiOm51bGwsImVtYWlsIjoiZGV2ZWxvcGVyQGFraGRhbmkuY28uaWQiLCJwaG9uZSI6bnVsbCwidXNlcmdyb3VwaWQiOiIxIiwiaXNlbmFibGVkIjoiMSIsImNsaWVudGlkIjoiMCIsImNvdW50ZXJpZCI6IjAiLCJ1c2VyZ3JvdXBuYW1lIjoic3lzYWRtaW4iLCJ1c2VybGV2ZWwiOiIxIiwiaXNkaXNwbGF5ZWQiOiIwIiwiaXNhbGxvd3JlZ2lzdHJhdGlvbiI6IjAiLCJpc2xvZ2dlZGluIjoiNTUiLCJleHAiOjE0NTc2MTQ0MjN9.eY104IbIBxeOQVApuC5mmfxmOO0o49DJwddjP7U5dRE', null, null, '20160310075343');
INSERT INTO `sys_session` VALUES ('79', '8', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiI4IiwidXNlcm5hbWUiOiJ1c2VyMSIsIm5hbWUiOiJVc2VyIDEiLCJhZGRyZXNzIjpudWxsLCJlbWFpbCI6InVzZXIxQGdtYWlsLmNvbSIsInBob25lIjpudWxsLCJ1c2VyZ3JvdXBpZCI6IjQiLCJpc2VuYWJsZWQiOiIxIiwiY2xpZW50aWQiOiIwIiwiY291bnRlcmlkIjoiMCIsInVzZXJncm91cG5hbWUiOiJ1c2VyIiwidXNlcmxldmVsIjoiOCIsImlzZGlzcGxheWVkIjoiMSIsImlzYWxsb3dyZWdpc3RyYXRpb24iOiIxIiwiaXNsb2dnZWRpbiI6IjExIiwiZXhwIjoxNDU3NjE0NDQwfQ.ut3GY2j_JWLNJOHxZGvBh-hCc8x5EhLjH8w_BtZbYWM', null, null, '20160310075400');
INSERT INTO `sys_session` VALUES ('80', '8', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiI4IiwidXNlcm5hbWUiOiJ1c2VyMSIsIm5hbWUiOiJVc2VyIDEiLCJhZGRyZXNzIjpudWxsLCJlbWFpbCI6InVzZXIxQGdtYWlsLmNvbSIsInBob25lIjpudWxsLCJ1c2VyZ3JvdXBpZCI6IjQiLCJpc2VuYWJsZWQiOiIxIiwiY2xpZW50aWQiOiIwIiwiY291bnRlcmlkIjoiMCIsInVzZXJncm91cG5hbWUiOiJ1c2VyIiwidXNlcmxldmVsIjoiOCIsImlzZGlzcGxheWVkIjoiMSIsImlzYWxsb3dyZWdpc3RyYXRpb24iOiIxIiwiaXNsb2dnZWRpbiI6IjEyIiwiZXhwIjoxNDU3NjE0NDc4fQ.AEd1vsNiveohndzi9dt-NmbcnYEtAkLl9hzdOFYEfV4', null, null, '20160310075438');
INSERT INTO `sys_session` VALUES ('81', '1', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiIxIiwidXNlcm5hbWUiOiJzeXNhZG1pbiIsIm5hbWUiOiJTeXN0ZW0gQWRtaW5pc3RyYXRvciIsImFkZHJlc3MiOm51bGwsImVtYWlsIjoiZGV2ZWxvcGVyQGFraGRhbmkuY28uaWQiLCJwaG9uZSI6bnVsbCwidXNlcmdyb3VwaWQiOiIxIiwiaXNlbmFibGVkIjoiMSIsImNsaWVudGlkIjoiMCIsImNvdW50ZXJpZCI6IjAiLCJ1c2VyZ3JvdXBuYW1lIjoic3lzYWRtaW4iLCJ1c2VybGV2ZWwiOiIxIiwiaXNkaXNwbGF5ZWQiOiIwIiwiaXNhbGxvd3JlZ2lzdHJhdGlvbiI6IjAiLCJpc2xvZ2dlZGluIjoiNTYiLCJleHAiOjE0NTc2MTQ0ODd9.zkBqYd28ARnExcPORqKpON6_r-IQv_eEuzQy7mKlcbo', null, null, '20160310075447');
INSERT INTO `sys_session` VALUES ('82', '1', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiIxIiwidXNlcm5hbWUiOiJzeXNhZG1pbiIsIm5hbWUiOiJTeXN0ZW0gQWRtaW5pc3RyYXRvciIsImFkZHJlc3MiOm51bGwsImVtYWlsIjoiZGV2ZWxvcGVyQGFraGRhbmkuY28uaWQiLCJwaG9uZSI6bnVsbCwidXNlcmdyb3VwaWQiOiIxIiwiaXNlbmFibGVkIjoiMSIsImNsaWVudGlkIjoiMCIsImNvdW50ZXJpZCI6IjAiLCJ1c2VyZ3JvdXBuYW1lIjoic3lzYWRtaW4iLCJ1c2VybGV2ZWwiOiIxIiwiaXNkaXNwbGF5ZWQiOiIwIiwiaXNhbGxvd3JlZ2lzdHJhdGlvbiI6IjAiLCJpc2xvZ2dlZGluIjoiNTciLCJleHAiOjE0NTc2MTQ0ODd9.vyjw7Y3bWWq_cq4sjmATTS0M8HVH1j8gQL7WtUYg1-M', null, null, '20160310075447');
INSERT INTO `sys_session` VALUES ('83', '1', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiIxIiwidXNlcm5hbWUiOiJzeXNhZG1pbiIsIm5hbWUiOiJTeXN0ZW0gQWRtaW5pc3RyYXRvciIsImFkZHJlc3MiOm51bGwsImVtYWlsIjoiZGV2ZWxvcGVyQGFraGRhbmkuY28uaWQiLCJwaG9uZSI6bnVsbCwidXNlcmdyb3VwaWQiOiIxIiwiaXNlbmFibGVkIjoiMSIsImNsaWVudGlkIjoiMCIsImNvdW50ZXJpZCI6IjAiLCJ1c2VyZ3JvdXBuYW1lIjoic3lzYWRtaW4iLCJ1c2VybGV2ZWwiOiIxIiwiaXNkaXNwbGF5ZWQiOiIwIiwiaXNhbGxvd3JlZ2lzdHJhdGlvbiI6IjAiLCJpc2xvZ2dlZGluIjoiNTgiLCJleHAiOjE0NTc2MTQ0ODh9._PCGR0iBgfqLv1gJ4AlF0urWem7O-P5EkpP1V7kSHzI', null, null, '20160310075448');
INSERT INTO `sys_session` VALUES ('84', '1', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiIxIiwidXNlcm5hbWUiOiJzeXNhZG1pbiIsIm5hbWUiOiJTeXN0ZW0gQWRtaW5pc3RyYXRvciIsImFkZHJlc3MiOm51bGwsImVtYWlsIjoiZGV2ZWxvcGVyQGFraGRhbmkuY28uaWQiLCJwaG9uZSI6bnVsbCwidXNlcmdyb3VwaWQiOiIxIiwiaXNlbmFibGVkIjoiMSIsImNsaWVudGlkIjoiMCIsImNvdW50ZXJpZCI6IjAiLCJ1c2VyZ3JvdXBuYW1lIjoic3lzYWRtaW4iLCJ1c2VybGV2ZWwiOiIxIiwiaXNkaXNwbGF5ZWQiOiIwIiwiaXNhbGxvd3JlZ2lzdHJhdGlvbiI6IjAiLCJpc2xvZ2dlZGluIjoiNTkiLCJleHAiOjE0NTc2MTQ0ODh9.CyEMoIMyBX6xP_Owh5RWW9SSA50hKdWBWsowTHK1LwU', null, null, '20160310075448');
INSERT INTO `sys_session` VALUES ('85', '1', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiIxIiwidXNlcm5hbWUiOiJzeXNhZG1pbiIsIm5hbWUiOiJTeXN0ZW0gQWRtaW5pc3RyYXRvciIsImFkZHJlc3MiOm51bGwsImVtYWlsIjoiZGV2ZWxvcGVyQGFraGRhbmkuY28uaWQiLCJwaG9uZSI6bnVsbCwidXNlcmdyb3VwaWQiOiIxIiwiaXNlbmFibGVkIjoiMSIsImNsaWVudGlkIjoiMCIsImNvdW50ZXJpZCI6IjAiLCJ1c2VyZ3JvdXBuYW1lIjoic3lzYWRtaW4iLCJ1c2VybGV2ZWwiOiIxIiwiaXNkaXNwbGF5ZWQiOiIwIiwiaXNhbGxvd3JlZ2lzdHJhdGlvbiI6IjAiLCJpc2xvZ2dlZGluIjoiNjAiLCJleHAiOjE0NTc2MTQ0ODh9.KtyeySMr7dTHiqVv1CYiVh0NSxTo8U5WTkTBtjATrCY', null, null, '20160310075448');
INSERT INTO `sys_session` VALUES ('86', '1', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiIxIiwidXNlcm5hbWUiOiJzeXNhZG1pbiIsIm5hbWUiOiJTeXN0ZW0gQWRtaW5pc3RyYXRvciIsImFkZHJlc3MiOm51bGwsImVtYWlsIjoiZGV2ZWxvcGVyQGFraGRhbmkuY28uaWQiLCJwaG9uZSI6bnVsbCwidXNlcmdyb3VwaWQiOiIxIiwiaXNlbmFibGVkIjoiMSIsImNsaWVudGlkIjoiMCIsImNvdW50ZXJpZCI6IjAiLCJ1c2VyZ3JvdXBuYW1lIjoic3lzYWRtaW4iLCJ1c2VybGV2ZWwiOiIxIiwiaXNkaXNwbGF5ZWQiOiIwIiwiaXNhbGxvd3JlZ2lzdHJhdGlvbiI6IjAiLCJpc2xvZ2dlZGluIjoiNjEiLCJleHAiOjE0NTc2MTQ0ODh9.UaX6UmJv1T5_cTCcgfwfoindJgPKVdumedu0G-zyOuw', null, null, '20160310075448');
INSERT INTO `sys_session` VALUES ('87', '8', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiI4IiwidXNlcm5hbWUiOiJ1c2VyMSIsIm5hbWUiOiJVc2VyIDEiLCJhZGRyZXNzIjpudWxsLCJlbWFpbCI6InVzZXIxQGdtYWlsLmNvbSIsInBob25lIjpudWxsLCJ1c2VyZ3JvdXBpZCI6IjQiLCJpc2VuYWJsZWQiOiIxIiwiY2xpZW50aWQiOiIwIiwiY291bnRlcmlkIjoiMCIsInVzZXJncm91cG5hbWUiOiJ1c2VyIiwidXNlcmxldmVsIjoiOCIsImlzZGlzcGxheWVkIjoiMSIsImlzYWxsb3dyZWdpc3RyYXRpb24iOiIxIiwiaXNsb2dnZWRpbiI6IjEzIiwiZXhwIjoxNDU3NjE0NTQ3fQ.V-VxJbLkDUJ_ykDx6_Af8XbbA-2dZ4ZxJwKIIf3Z4H8', null, null, '20160310075547');
INSERT INTO `sys_session` VALUES ('88', '1', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiIxIiwidXNlcm5hbWUiOiJzeXNhZG1pbiIsIm5hbWUiOiJTeXN0ZW0gQWRtaW5pc3RyYXRvciIsImFkZHJlc3MiOm51bGwsImVtYWlsIjoiZGV2ZWxvcGVyQGFraGRhbmkuY28uaWQiLCJwaG9uZSI6bnVsbCwidXNlcmdyb3VwaWQiOiIxIiwiaXNlbmFibGVkIjoiMSIsImNsaWVudGlkIjoiMCIsImNvdW50ZXJpZCI6IjAiLCJ1c2VyZ3JvdXBuYW1lIjoic3lzYWRtaW4iLCJ1c2VybGV2ZWwiOiIxIiwiaXNkaXNwbGF5ZWQiOiIwIiwiaXNhbGxvd3JlZ2lzdHJhdGlvbiI6IjAiLCJpc2xvZ2dlZGluIjoiNjIiLCJleHAiOjE0NTc2MTQ1NTB9.m89g8xVZTuulv7D6ScH9uJZCDrfTf0c6b94H68EggVQ', null, null, '20160310075550');
INSERT INTO `sys_session` VALUES ('89', '1', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiIxIiwidXNlcm5hbWUiOiJzeXNhZG1pbiIsIm5hbWUiOiJTeXN0ZW0gQWRtaW5pc3RyYXRvciIsImFkZHJlc3MiOm51bGwsImVtYWlsIjoiZGV2ZWxvcGVyQGFraGRhbmkuY28uaWQiLCJwaG9uZSI6bnVsbCwidXNlcmdyb3VwaWQiOiIxIiwiaXNlbmFibGVkIjoiMSIsImNsaWVudGlkIjoiMCIsImNvdW50ZXJpZCI6IjAiLCJ1c2VyZ3JvdXBuYW1lIjoic3lzYWRtaW4iLCJ1c2VybGV2ZWwiOiIxIiwiaXNkaXNwbGF5ZWQiOiIwIiwiaXNhbGxvd3JlZ2lzdHJhdGlvbiI6IjAiLCJpc2xvZ2dlZGluIjoiNjMiLCJleHAiOjE0NTc2MTQ1NTB9.8ulTCB8FC--hb_anSf8hM5K-s4TFFvADa9LYDZG97rc', null, null, '20160310075550');
INSERT INTO `sys_session` VALUES ('90', '1', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiIxIiwidXNlcm5hbWUiOiJzeXNhZG1pbiIsIm5hbWUiOiJTeXN0ZW0gQWRtaW5pc3RyYXRvciIsImFkZHJlc3MiOm51bGwsImVtYWlsIjoiZGV2ZWxvcGVyQGFraGRhbmkuY28uaWQiLCJwaG9uZSI6bnVsbCwidXNlcmdyb3VwaWQiOiIxIiwiaXNlbmFibGVkIjoiMSIsImNsaWVudGlkIjoiMCIsImNvdW50ZXJpZCI6IjAiLCJ1c2VyZ3JvdXBuYW1lIjoic3lzYWRtaW4iLCJ1c2VybGV2ZWwiOiIxIiwiaXNkaXNwbGF5ZWQiOiIwIiwiaXNhbGxvd3JlZ2lzdHJhdGlvbiI6IjAiLCJpc2xvZ2dlZGluIjoiNjQiLCJleHAiOjE0NTc2MTQ1NTB9.smimKFOON5Ni3TYm7TJlc6MCaET3cOTMOQU7mleIDo4', null, null, '20160310075550');
INSERT INTO `sys_session` VALUES ('91', '1', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiIxIiwidXNlcm5hbWUiOiJzeXNhZG1pbiIsIm5hbWUiOiJTeXN0ZW0gQWRtaW5pc3RyYXRvciIsImFkZHJlc3MiOm51bGwsImVtYWlsIjoiZGV2ZWxvcGVyQGFraGRhbmkuY28uaWQiLCJwaG9uZSI6bnVsbCwidXNlcmdyb3VwaWQiOiIxIiwiaXNlbmFibGVkIjoiMSIsImNsaWVudGlkIjoiMCIsImNvdW50ZXJpZCI6IjAiLCJ1c2VyZ3JvdXBuYW1lIjoic3lzYWRtaW4iLCJ1c2VybGV2ZWwiOiIxIiwiaXNkaXNwbGF5ZWQiOiIwIiwiaXNhbGxvd3JlZ2lzdHJhdGlvbiI6IjAiLCJpc2xvZ2dlZGluIjoiNjUiLCJleHAiOjE0NTc2MTQ1NTB9.UHEIkDi_uvYlyC8Z8ajR0Gd-6dZtcvpOhgd_JjmVeNA', null, null, '20160310075550');
INSERT INTO `sys_session` VALUES ('92', '1', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiIxIiwidXNlcm5hbWUiOiJzeXNhZG1pbiIsIm5hbWUiOiJTeXN0ZW0gQWRtaW5pc3RyYXRvciIsImFkZHJlc3MiOm51bGwsImVtYWlsIjoiZGV2ZWxvcGVyQGFraGRhbmkuY28uaWQiLCJwaG9uZSI6bnVsbCwidXNlcmdyb3VwaWQiOiIxIiwiaXNlbmFibGVkIjoiMSIsImNsaWVudGlkIjoiMCIsImNvdW50ZXJpZCI6IjAiLCJ1c2VyZ3JvdXBuYW1lIjoic3lzYWRtaW4iLCJ1c2VybGV2ZWwiOiIxIiwiaXNkaXNwbGF5ZWQiOiIwIiwiaXNhbGxvd3JlZ2lzdHJhdGlvbiI6IjAiLCJpc2xvZ2dlZGluIjoiNjYiLCJleHAiOjE0NTc2MTQ1NTF9.Qaq80ksDSNZFJMHG6jUMjWxtECaIeJpBCjL7ulF4B3I', null, null, '20160310075551');
INSERT INTO `sys_session` VALUES ('93', '1', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiIxIiwidXNlcm5hbWUiOiJzeXNhZG1pbiIsIm5hbWUiOiJTeXN0ZW0gQWRtaW5pc3RyYXRvciIsImFkZHJlc3MiOm51bGwsImVtYWlsIjoiZGV2ZWxvcGVyQGFraGRhbmkuY28uaWQiLCJwaG9uZSI6bnVsbCwidXNlcmdyb3VwaWQiOiIxIiwiaXNlbmFibGVkIjoiMSIsImNsaWVudGlkIjoiMCIsImNvdW50ZXJpZCI6IjAiLCJ1c2VyZ3JvdXBuYW1lIjoic3lzYWRtaW4iLCJ1c2VybGV2ZWwiOiIxIiwiaXNkaXNwbGF5ZWQiOiIwIiwiaXNhbGxvd3JlZ2lzdHJhdGlvbiI6IjAiLCJpc2xvZ2dlZGluIjoiNjciLCJleHAiOjE0NTc2MTQ1NTF9.298-f6ItlSqRpTx3LkhaC8Wt5QGVozzDJzH_ojNWNbk', null, null, '20160310075551');
INSERT INTO `sys_session` VALUES ('94', '8', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiI4IiwidXNlcm5hbWUiOiJ1c2VyMSIsIm5hbWUiOiJVc2VyIDEiLCJhZGRyZXNzIjpudWxsLCJlbWFpbCI6InVzZXIxQGdtYWlsLmNvbSIsInBob25lIjpudWxsLCJ1c2VyZ3JvdXBpZCI6IjQiLCJpc2VuYWJsZWQiOiIxIiwiY2xpZW50aWQiOiIwIiwiY291bnRlcmlkIjoiMCIsInVzZXJncm91cG5hbWUiOiJ1c2VyIiwidXNlcmxldmVsIjoiOCIsImlzZGlzcGxheWVkIjoiMSIsImlzYWxsb3dyZWdpc3RyYXRpb24iOiIxIiwiaXNsb2dnZWRpbiI6IjE0IiwiZXhwIjoxNDU3NjE0NTkzfQ.cMZ-WCXUE1GyVJn1tENs3vERZ4K-5lpQ_3SO0f5Y3oo', null, null, '20160310075633');
INSERT INTO `sys_session` VALUES ('95', '1', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiIxIiwidXNlcm5hbWUiOiJzeXNhZG1pbiIsIm5hbWUiOiJTeXN0ZW0gQWRtaW5pc3RyYXRvciIsImFkZHJlc3MiOm51bGwsImVtYWlsIjoiZGV2ZWxvcGVyQGFraGRhbmkuY28uaWQiLCJwaG9uZSI6bnVsbCwidXNlcmdyb3VwaWQiOiIxIiwiaXNlbmFibGVkIjoiMSIsImNsaWVudGlkIjoiMCIsImNvdW50ZXJpZCI6IjAiLCJ1c2VyZ3JvdXBuYW1lIjoic3lzYWRtaW4iLCJ1c2VybGV2ZWwiOiIxIiwiaXNkaXNwbGF5ZWQiOiIwIiwiaXNhbGxvd3JlZ2lzdHJhdGlvbiI6IjAiLCJpc2xvZ2dlZGluIjoiNjgiLCJleHAiOjE0NTc2MTQ2MDB9.p6kC15g2COBgD0IP_NKaKDQFGIbuN_j6qJzD7LgKedw', null, null, '20160310075640');
INSERT INTO `sys_session` VALUES ('96', '1', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiIxIiwidXNlcm5hbWUiOiJzeXNhZG1pbiIsIm5hbWUiOiJTeXN0ZW0gQWRtaW5pc3RyYXRvciIsImFkZHJlc3MiOm51bGwsImVtYWlsIjoiZGV2ZWxvcGVyQGFraGRhbmkuY28uaWQiLCJwaG9uZSI6bnVsbCwidXNlcmdyb3VwaWQiOiIxIiwiaXNlbmFibGVkIjoiMSIsImNsaWVudGlkIjoiMCIsImNvdW50ZXJpZCI6IjAiLCJ1c2VyZ3JvdXBuYW1lIjoic3lzYWRtaW4iLCJ1c2VybGV2ZWwiOiIxIiwiaXNkaXNwbGF5ZWQiOiIwIiwiaXNhbGxvd3JlZ2lzdHJhdGlvbiI6IjAiLCJpc2xvZ2dlZGluIjoiNjkiLCJleHAiOjE0NTc2MTQ2MDB9.WiSpau8ok0z3tsCJXxIWvNeVJ1uIE9-8_q2GTA84joY', null, null, '20160310075640');
INSERT INTO `sys_session` VALUES ('97', '1', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiIxIiwidXNlcm5hbWUiOiJzeXNhZG1pbiIsIm5hbWUiOiJTeXN0ZW0gQWRtaW5pc3RyYXRvciIsImFkZHJlc3MiOm51bGwsImVtYWlsIjoiZGV2ZWxvcGVyQGFraGRhbmkuY28uaWQiLCJwaG9uZSI6bnVsbCwidXNlcmdyb3VwaWQiOiIxIiwiaXNlbmFibGVkIjoiMSIsImNsaWVudGlkIjoiMCIsImNvdW50ZXJpZCI6IjAiLCJ1c2VyZ3JvdXBuYW1lIjoic3lzYWRtaW4iLCJ1c2VybGV2ZWwiOiIxIiwiaXNkaXNwbGF5ZWQiOiIwIiwiaXNhbGxvd3JlZ2lzdHJhdGlvbiI6IjAiLCJpc2xvZ2dlZGluIjoiNzAiLCJleHAiOjE0NTc2MTQ2MDB9.wMCI98VO6_vxChjFWuE9jjnPIlv69IFT1yWyxXnxRjM', null, null, '20160310075640');
INSERT INTO `sys_session` VALUES ('98', '1', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiIxIiwidXNlcm5hbWUiOiJzeXNhZG1pbiIsIm5hbWUiOiJTeXN0ZW0gQWRtaW5pc3RyYXRvciIsImFkZHJlc3MiOm51bGwsImVtYWlsIjoiZGV2ZWxvcGVyQGFraGRhbmkuY28uaWQiLCJwaG9uZSI6bnVsbCwidXNlcmdyb3VwaWQiOiIxIiwiaXNlbmFibGVkIjoiMSIsImNsaWVudGlkIjoiMCIsImNvdW50ZXJpZCI6IjAiLCJ1c2VyZ3JvdXBuYW1lIjoic3lzYWRtaW4iLCJ1c2VybGV2ZWwiOiIxIiwiaXNkaXNwbGF5ZWQiOiIwIiwiaXNhbGxvd3JlZ2lzdHJhdGlvbiI6IjAiLCJpc2xvZ2dlZGluIjoiNzEiLCJleHAiOjE0NTc2MTQ2MDB9.N40yJSj92NoJu5qMAE0mEyQEoBDrJo5BLLsxMUF9qsk', null, null, '20160310075640');
INSERT INTO `sys_session` VALUES ('99', '1', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiIxIiwidXNlcm5hbWUiOiJzeXNhZG1pbiIsIm5hbWUiOiJTeXN0ZW0gQWRtaW5pc3RyYXRvciIsImFkZHJlc3MiOm51bGwsImVtYWlsIjoiZGV2ZWxvcGVyQGFraGRhbmkuY28uaWQiLCJwaG9uZSI6bnVsbCwidXNlcmdyb3VwaWQiOiIxIiwiaXNlbmFibGVkIjoiMSIsImNsaWVudGlkIjoiMCIsImNvdW50ZXJpZCI6IjAiLCJ1c2VyZ3JvdXBuYW1lIjoic3lzYWRtaW4iLCJ1c2VybGV2ZWwiOiIxIiwiaXNkaXNwbGF5ZWQiOiIwIiwiaXNhbGxvd3JlZ2lzdHJhdGlvbiI6IjAiLCJpc2xvZ2dlZGluIjoiNzIiLCJleHAiOjE0NTc2MTQ2MDB9.X01c6YUvZRTOiM30h-BLMiKKRuA-krncoyi4u9e1QPc', null, null, '20160310075640');
INSERT INTO `sys_session` VALUES ('100', '1', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiIxIiwidXNlcm5hbWUiOiJzeXNhZG1pbiIsIm5hbWUiOiJTeXN0ZW0gQWRtaW5pc3RyYXRvciIsImFkZHJlc3MiOm51bGwsImVtYWlsIjoiZGV2ZWxvcGVyQGFraGRhbmkuY28uaWQiLCJwaG9uZSI6bnVsbCwidXNlcmdyb3VwaWQiOiIxIiwiaXNlbmFibGVkIjoiMSIsImNsaWVudGlkIjoiMCIsImNvdW50ZXJpZCI6IjAiLCJ1c2VyZ3JvdXBuYW1lIjoic3lzYWRtaW4iLCJ1c2VybGV2ZWwiOiIxIiwiaXNkaXNwbGF5ZWQiOiIwIiwiaXNhbGxvd3JlZ2lzdHJhdGlvbiI6IjAiLCJpc2xvZ2dlZGluIjoiNzMiLCJleHAiOjE0NTc2MTQ2MDF9.eN0pdTDnnrdnW7dEno2pn8d64wMHKcmSInBmCzhxdLE', null, null, '20160310075641');
INSERT INTO `sys_session` VALUES ('101', '8', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiI4IiwidXNlcm5hbWUiOiJ1c2VyMSIsIm5hbWUiOiJVc2VyIDEiLCJhZGRyZXNzIjpudWxsLCJlbWFpbCI6InVzZXIxQGdtYWlsLmNvbSIsInBob25lIjpudWxsLCJ1c2VyZ3JvdXBpZCI6IjQiLCJpc2VuYWJsZWQiOiIxIiwiY2xpZW50aWQiOiIwIiwiY291bnRlcmlkIjoiMCIsInVzZXJncm91cG5hbWUiOiJ1c2VyIiwidXNlcmxldmVsIjoiOCIsImlzZGlzcGxheWVkIjoiMSIsImlzYWxsb3dyZWdpc3RyYXRpb24iOiIxIiwiaXNsb2dnZWRpbiI6IjE1IiwiZXhwIjoxNDU3NjE0NjYxfQ.d-Jrl3KiqEpdvPyAe0sEDymMGYT1tUGBdBpXRhwxtDA', null, null, '20160310075741');
INSERT INTO `sys_session` VALUES ('102', '1', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiIxIiwidXNlcm5hbWUiOiJzeXNhZG1pbiIsIm5hbWUiOiJTeXN0ZW0gQWRtaW5pc3RyYXRvciIsImFkZHJlc3MiOm51bGwsImVtYWlsIjoiZGV2ZWxvcGVyQGFraGRhbmkuY28uaWQiLCJwaG9uZSI6bnVsbCwidXNlcmdyb3VwaWQiOiIxIiwiaXNlbmFibGVkIjoiMSIsImNsaWVudGlkIjoiMCIsImNvdW50ZXJpZCI6IjAiLCJ1c2VyZ3JvdXBuYW1lIjoic3lzYWRtaW4iLCJ1c2VybGV2ZWwiOiIxIiwiaXNkaXNwbGF5ZWQiOiIwIiwiaXNhbGxvd3JlZ2lzdHJhdGlvbiI6IjAiLCJpc2xvZ2dlZGluIjoiNzQiLCJleHAiOjE0NTc2MTQ2Njd9.KAd2H3V_Vg87ClfctKrw0wL_CwqCb3THWamevbZuCcI', null, null, '20160310075747');
INSERT INTO `sys_session` VALUES ('103', '1', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiIxIiwidXNlcm5hbWUiOiJzeXNhZG1pbiIsIm5hbWUiOiJTeXN0ZW0gQWRtaW5pc3RyYXRvciIsImFkZHJlc3MiOm51bGwsImVtYWlsIjoiZGV2ZWxvcGVyQGFraGRhbmkuY28uaWQiLCJwaG9uZSI6bnVsbCwidXNlcmdyb3VwaWQiOiIxIiwiaXNlbmFibGVkIjoiMSIsImNsaWVudGlkIjoiMCIsImNvdW50ZXJpZCI6IjAiLCJ1c2VyZ3JvdXBuYW1lIjoic3lzYWRtaW4iLCJ1c2VybGV2ZWwiOiIxIiwiaXNkaXNwbGF5ZWQiOiIwIiwiaXNhbGxvd3JlZ2lzdHJhdGlvbiI6IjAiLCJpc2xvZ2dlZGluIjoiNzUiLCJleHAiOjE0NTc2MTQ2Njd9.05ttHLhcLewG7hpiy_f_1pIviMwU3HClKFzHcLsBlgA', null, null, '20160310075747');
INSERT INTO `sys_session` VALUES ('104', '1', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiIxIiwidXNlcm5hbWUiOiJzeXNhZG1pbiIsIm5hbWUiOiJTeXN0ZW0gQWRtaW5pc3RyYXRvciIsImFkZHJlc3MiOm51bGwsImVtYWlsIjoiZGV2ZWxvcGVyQGFraGRhbmkuY28uaWQiLCJwaG9uZSI6bnVsbCwidXNlcmdyb3VwaWQiOiIxIiwiaXNlbmFibGVkIjoiMSIsImNsaWVudGlkIjoiMCIsImNvdW50ZXJpZCI6IjAiLCJ1c2VyZ3JvdXBuYW1lIjoic3lzYWRtaW4iLCJ1c2VybGV2ZWwiOiIxIiwiaXNkaXNwbGF5ZWQiOiIwIiwiaXNhbGxvd3JlZ2lzdHJhdGlvbiI6IjAiLCJpc2xvZ2dlZGluIjoiNzYiLCJleHAiOjE0NTc2MTQ2Njd9.nIeACwou2fwWJKoZKwxvViVTuC7CDdEpPJtQ0sbPDJ4', null, null, '20160310075747');
INSERT INTO `sys_session` VALUES ('105', '1', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiIxIiwidXNlcm5hbWUiOiJzeXNhZG1pbiIsIm5hbWUiOiJTeXN0ZW0gQWRtaW5pc3RyYXRvciIsImFkZHJlc3MiOm51bGwsImVtYWlsIjoiZGV2ZWxvcGVyQGFraGRhbmkuY28uaWQiLCJwaG9uZSI6bnVsbCwidXNlcmdyb3VwaWQiOiIxIiwiaXNlbmFibGVkIjoiMSIsImNsaWVudGlkIjoiMCIsImNvdW50ZXJpZCI6IjAiLCJ1c2VyZ3JvdXBuYW1lIjoic3lzYWRtaW4iLCJ1c2VybGV2ZWwiOiIxIiwiaXNkaXNwbGF5ZWQiOiIwIiwiaXNhbGxvd3JlZ2lzdHJhdGlvbiI6IjAiLCJpc2xvZ2dlZGluIjoiNzciLCJleHAiOjE0NTc2MTQ2Njh9.Dv10K7CzjXU1syejqlJw5KGMLfvCU1FJXFBGrsJoLYw', null, null, '20160310075748');
INSERT INTO `sys_session` VALUES ('106', '1', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiIxIiwidXNlcm5hbWUiOiJzeXNhZG1pbiIsIm5hbWUiOiJTeXN0ZW0gQWRtaW5pc3RyYXRvciIsImFkZHJlc3MiOm51bGwsImVtYWlsIjoiZGV2ZWxvcGVyQGFraGRhbmkuY28uaWQiLCJwaG9uZSI6bnVsbCwidXNlcmdyb3VwaWQiOiIxIiwiaXNlbmFibGVkIjoiMSIsImNsaWVudGlkIjoiMCIsImNvdW50ZXJpZCI6IjAiLCJ1c2VyZ3JvdXBuYW1lIjoic3lzYWRtaW4iLCJ1c2VybGV2ZWwiOiIxIiwiaXNkaXNwbGF5ZWQiOiIwIiwiaXNhbGxvd3JlZ2lzdHJhdGlvbiI6IjAiLCJpc2xvZ2dlZGluIjoiNzgiLCJleHAiOjE0NTc2MTQ2Njh9.kLZELuefUsF51TgpCB7UPeNNcLBVc2ATQL-asiE7b4g', null, null, '20160310075748');
INSERT INTO `sys_session` VALUES ('107', '1', 'eyJ0eXAiOiJzZWxmIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyaWQiOiIxIiwidXNlcm5hbWUiOiJzeXNhZG1pbiIsIm5hbWUiOiJTeXN0ZW0gQWRtaW5pc3RyYXRvciIsImFkZHJlc3MiOm51bGwsImVtYWlsIjoiZGV2ZWxvcGVyQGFraGRhbmkuY28uaWQiLCJwaG9uZSI6bnVsbCwidXNlcmdyb3VwaWQiOiIxIiwiaXNlbmFibGVkIjoiMSIsImNsaWVudGlkIjoiMCIsImNvdW50ZXJpZCI6IjAiLCJ1c2VyZ3JvdXBuYW1lIjoic3lzYWRtaW4iLCJ1c2VybGV2ZWwiOiIxIiwiaXNkaXNwbGF5ZWQiOiIwIiwiaXNhbGxvd3JlZ2lzdHJhdGlvbiI6IjAiLCJpc2xvZ2dlZGluIjoiNzkiLCJleHAiOjE0NTc2MTQ2Njh9.eOsY68ElOSVxy4aFOuuhmhHipnlqnfFUzfO7-4SHHUw', null, null, '20160310075748');

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
  `counterid` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`userid`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('1', 'sysadmin', '202cb962ac59075b964b07152d234b70', 'System Administrator', null, 'developer@akhdani.co.id', null, '1', '1', '0', '0');
INSERT INTO `sys_user` VALUES ('2', 'admin1', '202cb962ac59075b964b07152d234b70', 'Administrator RSAI', null, 'admin@rsai.com', null, '2', '1', '1', '0');
INSERT INTO `sys_user` VALUES ('3', 'admin2', '202cb962ac59075b964b07152d234b70', 'Administrator Yakes Telkom', null, 'admin@yakestelkom.org', null, '2', '1', '2', '0');
INSERT INTO `sys_user` VALUES ('4', 'op11', '202cb962ac59075b964b07152d234b70', 'Operator RSAI 1', null, 'op1@rsai.com', null, '3', '1', '1', '1');
INSERT INTO `sys_user` VALUES ('5', 'op12', '202cb962ac59075b964b07152d234b70', 'Operator RSAI 2', null, 'op2@rsai.com', null, '3', '1', '1', '2');
INSERT INTO `sys_user` VALUES ('6', 'op21', '202cb962ac59075b964b07152d234b70', 'Operator Yakes Telkom', null, 'op1@yakestelkom.org', null, '3', '1', '2', '3');
INSERT INTO `sys_user` VALUES ('7', 'op22', '202cb962ac59075b964b07152d234b70', 'Operator Yakes Telkom', null, 'op2@yakestelkom.org', null, '3', '1', '2', '4');
INSERT INTO `sys_user` VALUES ('8', 'user1', '202cb962ac59075b964b07152d234b70', 'User 1', null, 'user1@gmail.com', null, '4', '1', '0', '0');
INSERT INTO `sys_user` VALUES ('9', 'user2', '202cb962ac59075b964b07152d234b70', 'User 2', null, 'user2@gmail.com', null, '4', '1', '0', '0');

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
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_sys_user` AS select `u`.`userid` AS `userid`,`u`.`username` AS `username`,`u`.`password` AS `password`,`u`.`name` AS `name`,`u`.`address` AS `address`,`u`.`email` AS `email`,`u`.`phone` AS `phone`,`u`.`usergroupid` AS `usergroupid`,`u`.`isenabled` AS `isenabled`,`u`.`clientid` AS `clientid`,`u`.`counterid` AS `counterid`,`ug`.`name` AS `usergroupname`,`ug`.`level` AS `userlevel`,`ug`.`isdisplayed` AS `isdisplayed`,`ug`.`isallowregistration` AS `isallowregistration`,(select count(`s`.`userid`) from `sys_session` `s` where (`s`.`userid` = `u`.`userid`)) AS `isloggedin` from (`sys_user` `u` left join `sys_usergroup` `ug` on((`ug`.`usergroupid` = `u`.`usergroupid`))) ;
