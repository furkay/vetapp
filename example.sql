/*
 Navicat Premium Data Transfer

 Source Server         : test
 Source Server Type    : MySQL
 Source Server Version : 100411
 Source Host           : localhost:3306
 Source Schema         : test

 Target Server Type    : MySQL
 Target Server Version : 100411
 File Encoding         : 65001

 Date: 26/05/2020 17:18:05
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for pets
-- ----------------------------
DROP TABLE IF EXISTS `pets`;
CREATE TABLE `pets`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `petType` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `year` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `userName` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pets
-- ----------------------------
INSERT INTO `pets` VALUES (1, 'Van Kedisi', '14.01.2018', 'furkay');
INSERT INTO `pets` VALUES (2, 'Ankara Kedisi', '14.02.2019', 'furkay');
INSERT INTO `pets` VALUES (3, 'Almana Kurdu', '22.02.2012', 'canari');
INSERT INTO `pets` VALUES (4, 'Pug', '12.12.2002', 'hamdi');
INSERT INTO `pets` VALUES (5, 'Hint Bülbülü', '12.01.2020', 'ozcan');
INSERT INTO `pets` VALUES (6, 'Siyam Kedisi', '01.01.2010', 'tasci');

-- ----------------------------
-- Table structure for treatments
-- ----------------------------
DROP TABLE IF EXISTS `treatments`;
CREATE TABLE `treatments`  (
  `petID` int(11) NOT NULL,
  `medicineNames` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `treatmentName` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `treatmentDate` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`petID`, `treatmentDate`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of treatments
-- ----------------------------
INSERT INTO `treatments` VALUES (1, 'teys', 'Ayak Kirilmis', '14.07.2019');
INSERT INTO `treatments` VALUES (3, 'Kalp Ilaci', 'Kalp Hastasi', '12.02.2020');
INSERT INTO `treatments` VALUES (4, 'Ilac Yok', 'Kisirlastirma Tedavisi', '12.12.2011');
INSERT INTO `treatments` VALUES (5, 'Ilac Yok', 'Kisirlastirma', '12.02.2011');
INSERT INTO `treatments` VALUES (5, 'Bit Ilaci', 'Bit Tedavisi', '12.12.2012');
INSERT INTO `treatments` VALUES (6, 'tosta', 'Tüy Dökme', '13.04.2013');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `adress` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `number` varchar(11) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `level` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES ('ahmet', 'Istanbul/Kartal', '05566679988', '123456', 'Veteriner');
INSERT INTO `users` VALUES ('canari', 'Istanbul/Beylikduzu', '05313251342', '123456', 'Uye');
INSERT INTO `users` VALUES ('furkay', 'Bolu/Merkez', '05514222130', '123456', 'Uye');
INSERT INTO `users` VALUES ('haluk', 'Istanbul/Beylikduzu', '05344322115', '123456', 'Veteriner');
INSERT INTO `users` VALUES ('hamdi', 'Istanbul/Kartal', '05328866453', '123456', 'Uye');
INSERT INTO `users` VALUES ('haydar', 'Istanbul/Kartal', '05544422211', '123456', 'Veteriner');
INSERT INTO `users` VALUES ('kasim', 'Istanbul/Kartal', '05533366677', '123456', 'Veteriner');
INSERT INTO `users` VALUES ('kemal', 'Istanbul/Kartal', '05324433244', '123456', 'Veteriner');
INSERT INTO `users` VALUES ('levent', 'Istanbul/Beylikduzu', '05443332223', '123456', 'Veteriner');
INSERT INTO `users` VALUES ('ozcan', 'Bolu/Bahcelievler', '05334211041', '123456', 'Uye');
INSERT INTO `users` VALUES ('tasci', 'Bolu/Merkez', '05324113032', '123456', 'Uye');

-- ----------------------------
-- Table structure for vaccines
-- ----------------------------
DROP TABLE IF EXISTS `vaccines`;
CREATE TABLE `vaccines`  (
  `petID` int(11) NOT NULL,
  `vaccineName` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `vaccineDate` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`petID`, `vaccineName`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of vaccines
-- ----------------------------
INSERT INTO `vaccines` VALUES (1, 'Kuduz Asisi', '14.03.2019');
INSERT INTO `vaccines` VALUES (3, 'Kuduz Asisi', '10.03.2020');
INSERT INTO `vaccines` VALUES (4, 'Kuduz Asisi', '12.01.2011');
INSERT INTO `vaccines` VALUES (5, 'Kuduz Asisi', '12.02.2013');
INSERT INTO `vaccines` VALUES (6, 'Kuduz Asisi', '09.02.2020');

-- ----------------------------
-- Table structure for vets
-- ----------------------------
DROP TABLE IF EXISTS `vets`;
CREATE TABLE `vets`  (
  `id` int(11) NOT NULL,
  `vergiNo` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kullaniciAdi` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `klinik` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `sifre` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`kullaniciAdi`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of vets
-- ----------------------------
INSERT INTO `vets` VALUES (8487, '989812', 'ahmet', 'Doga Klinik', '123456');
INSERT INTO `vets` VALUES (1552, '332344', 'haluk', 'Yeni Klinik', '123456');
INSERT INTO `vets` VALUES (9848, '999311', 'haydar', 'Tek Klinik', '123456');
INSERT INTO `vets` VALUES (1386, '989812', 'kasim', 'Doga Klinik', '123456');
INSERT INTO `vets` VALUES (7568, '989812', 'kemal', 'Doga Klinik', '123456');
INSERT INTO `vets` VALUES (5569, '332344', 'levent', 'Yeni Klinik', '123456');

SET FOREIGN_KEY_CHECKS = 1;
