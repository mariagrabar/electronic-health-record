-- MySQL dump 10.13  Distrib 8.0.31, for macos12 (x86_64)
--
-- Host: 127.0.0.1    Database: ehr
-- ------------------------------------------------------
-- Server version	8.0.32

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `appointment`
--

DROP TABLE IF EXISTS `appointment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appointment` (
  `appointment_id` varchar(50) NOT NULL,
  `patient_id` varchar(50) DEFAULT NULL,
  `doctor_id` varchar(50) DEFAULT NULL,
  `appointment_date` date DEFAULT NULL,
  `appointment_time` time DEFAULT NULL,
  `appointment_type` varchar(50) DEFAULT NULL,
  `appointment_status` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`appointment_id`),
  KEY `patient_id` (`patient_id`),
  KEY `doctor_id` (`doctor_id`),
  CONSTRAINT `appointment_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_ID`),
  CONSTRAINT `appointment_ibfk_2` FOREIGN KEY (`doctor_id`) REFERENCES `doctor` (`doctor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appointment`
--

LOCK TABLES `appointment` WRITE;
/*!40000 ALTER TABLE `appointment` DISABLE KEYS */;
INSERT INTO `appointment` VALUES ('A0001','P0001','D0006','2023-11-19','14:00:00','Preoperative assessment','Completed'),('A0002','P0002','D0002','2023-11-21','11:30:00','Routine checkup','Completed'),('A0003','P0003','D0001','2023-11-22','14:30:00','Routine checkup','Rescheduled'),('A0004','P0003','D0001','2023-11-23','14:00:00','Routine checkup','Completed'),('A0005','P0005','D0004','2023-11-24','17:45:00','Follow-up appointment','Completed'),('A0006','P0001','D0006','2023-11-25','12:00:00','Surgery','Completed'),('A0007','P0009','D0005','2023-11-24','11:30:00','Specialist consultation','Completed'),('A0008','P0006','D0004','2023-11-24','11:45:00','Follow-up appointment','Completed'),('A0009','P0008','D0002','2023-11-28','10:15:00','Routine checkup','Pending');
/*!40000 ALTER TABLE `appointment` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `prevent_double_booking` BEFORE INSERT ON `appointment` FOR EACH ROW BEGIN
	IF EXISTS (
		SELECT 1
        FROM appointment
        WHERE doctor_id = NEW.doctor_id
			AND appointment_date = NEW.appointment_date)
	THEN
		SIGNAL SQLSTATE '45000' -- Identifies SQL error conditions. --
        SET MESSAGE_TEXT = 'This timeslot is not available.';
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `bmi_per_lifestyle`
--

DROP TABLE IF EXISTS `bmi_per_lifestyle`;
/*!50001 DROP VIEW IF EXISTS `bmi_per_lifestyle`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `bmi_per_lifestyle` AS SELECT 
 1 AS `patient_first_name`,
 1 AS `patient_last_name`,
 1 AS `bmi`,
 1 AS `blood_pressure`,
 1 AS `heart_rate`,
 1 AS `allergy`,
 1 AS `lifestyle_habits`,
 1 AS `genetic_predisposition`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `diagnosis`
--

DROP TABLE IF EXISTS `diagnosis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `diagnosis` (
  `diagnosis_id` varchar(50) NOT NULL,
  `visit_id` varchar(50) DEFAULT NULL,
  `diagnosis_description` varchar(50) DEFAULT NULL,
  `diagnosis_date` date DEFAULT NULL,
  PRIMARY KEY (`diagnosis_id`),
  KEY `visit_id` (`visit_id`),
  CONSTRAINT `diagnosis_ibfk_1` FOREIGN KEY (`visit_id`) REFERENCES `visit` (`visit_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `diagnosis`
--

LOCK TABLES `diagnosis` WRITE;
/*!40000 ALTER TABLE `diagnosis` DISABLE KEYS */;
INSERT INTO `diagnosis` VALUES ('DG0001','V0001','Dental decay','2023-11-19'),('DG0002','V0003','Common cold','2023-11-23'),('DG0003','V0004','Celiac disease','2023-11-24'),('DG0004','V0005','Scoliosis','2023-11-24'),('DG0005','V0007','Asthma','2023-11-24');
/*!40000 ALTER TABLE `diagnosis` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctor`
--

DROP TABLE IF EXISTS `doctor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doctor` (
  `doctor_id` varchar(50) NOT NULL,
  `doctor_first_name` varchar(50) DEFAULT NULL,
  `doctor_last_name` varchar(50) DEFAULT NULL,
  `specialisation` varchar(50) DEFAULT NULL,
  `doctor_email` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`doctor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctor`
--

LOCK TABLES `doctor` WRITE;
/*!40000 ALTER TABLE `doctor` DISABLE KEYS */;
INSERT INTO `doctor` VALUES ('D0001','Lucas','Parker','General practitioner','lucas@email.com'),('D0002','Isabella','Thompson','General practitioner','isabella@email.com'),('D0003','Mason','Carter','Dentist','mason@email.com'),('D0004','Chloe','Williams','Pediatrician','chloe@email.com'),('D0005','Noah','Anderson','Pediatrician','noah@email.com'),('D0006','Lily','Hayes','Dentist','lily@email.com');
/*!40000 ALTER TABLE `doctor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medical_history`
--

DROP TABLE IF EXISTS `medical_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `medical_history` (
  `medical_history_id` varchar(50) NOT NULL,
  `patient_id` varchar(50) DEFAULT NULL,
  `allergy` varchar(50) DEFAULT NULL,
  `lifestyle_habits` varchar(50) DEFAULT NULL,
  `genetic_predisposition` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`medical_history_id`),
  KEY `patient_id` (`patient_id`),
  CONSTRAINT `medical_history_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medical_history`
--

LOCK TABLES `medical_history` WRITE;
/*!40000 ALTER TABLE `medical_history` DISABLE KEYS */;
INSERT INTO `medical_history` VALUES ('MH0001','P0001','Local anesthetics','High sugar diet',NULL),('MH0002','P0002','Dust','Regular exercise','IBS'),('MH0003','P0003',NULL,'Sedentary lifestyle',NULL),('MH0004','P0004','Gluten',NULL,'Celiac disease'),('MH0005','P0005',NULL,NULL,NULL),('MH0006','P0006','Dust',NULL,'Asthma'),('MH0007','P0007','Pollen',NULL,NULL),('MH0008','P0008',NULL,'Sedentary lifestyle','Type 1 diabetes'),('MH0009','P0009',NULL,'Intense exercise','Scoliosis'),('MH0010','P0010','Local anesthetics','High protein diet','Type 1 diabetes');
/*!40000 ALTER TABLE `medical_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient`
--

DROP TABLE IF EXISTS `patient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patient` (
  `patient_ID` varchar(50) NOT NULL,
  `patient_first_name` varchar(50) DEFAULT NULL,
  `patient_last_name` varchar(50) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `patient_email` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`patient_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient`
--

LOCK TABLES `patient` WRITE;
/*!40000 ALTER TABLE `patient` DISABLE KEYS */;
INSERT INTO `patient` VALUES ('P0001','Dexter','Mitchell','1986-08-15','dexter@email.com'),('P0002','Stella','Reynolds','1998-04-02','stella@email.com'),('P0003','Caleb','Turner','2005-09-23','caleb@email.com'),('P0004','Nora','Harrison','1959-02-11','nora@email.com'),('P0005','Ethan','Palmer','2018-06-07','ethan@email.com'),('P0006','Zoey','Foster','2016-10-30','zoey@email.com'),('P0007','Oliver','Jensen','1987-12-25','oliver@email.com'),('P0008','Maya','Bennet','1951-03-18','maya@email.com'),('P0009','Leo','Chambers','2009-01-14','leo@email.com'),('P0010','Ava','Richardson','2003-07-09','ava@email.com'),('P0011','Anna','Smith','2001-06-06','anna@email.com');
/*!40000 ALTER TABLE `patient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient_entry_log`
--

DROP TABLE IF EXISTS `patient_entry_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patient_entry_log` (
  `patient_id` varchar(50) DEFAULT NULL,
  `entry_timestamp` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient_entry_log`
--

LOCK TABLES `patient_entry_log` WRITE;
/*!40000 ALTER TABLE `patient_entry_log` DISABLE KEYS */;
INSERT INTO `patient_entry_log` VALUES ('P0001','2023-11-25 16:39:34'),('P0002','2023-11-25 16:39:34'),('P0003','2023-11-25 16:39:34'),('P0004','2023-11-25 16:39:34'),('P0005','2023-11-25 16:39:34'),('P0006','2023-11-25 16:39:34'),('P0007','2023-11-25 16:39:34'),('P0008','2023-11-25 16:39:34'),('P0009','2023-11-25 16:39:34'),('P0010','2023-11-25 16:39:34'),('P0011','2023-11-25 16:44:34');
/*!40000 ALTER TABLE `patient_entry_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `recent_diagnosis`
--

DROP TABLE IF EXISTS `recent_diagnosis`;
/*!50001 DROP VIEW IF EXISTS `recent_diagnosis`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `recent_diagnosis` AS SELECT 
 1 AS `patient_first_name`,
 1 AS `patient_last_name`,
 1 AS `diagnosis_description`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `resource_allocation`
--

DROP TABLE IF EXISTS `resource_allocation`;
/*!50001 DROP VIEW IF EXISTS `resource_allocation`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `resource_allocation` AS SELECT 
 1 AS `doctor_first_name`,
 1 AS `doctor_last_name`,
 1 AS `appointment_date`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `visit`
--

DROP TABLE IF EXISTS `visit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `visit` (
  `visit_id` varchar(50) NOT NULL,
  `patient_id` varchar(50) DEFAULT NULL,
  `doctor_id` varchar(50) DEFAULT NULL,
  `appointment_id` varchar(50) DEFAULT NULL,
  `notes` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`visit_id`),
  KEY `patient_id` (`patient_id`),
  KEY `doctor_id` (`doctor_id`),
  KEY `appointment_id` (`appointment_id`),
  CONSTRAINT `visit_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_ID`),
  CONSTRAINT `visit_ibfk_2` FOREIGN KEY (`doctor_id`) REFERENCES `doctor` (`doctor_id`),
  CONSTRAINT `visit_ibfk_3` FOREIGN KEY (`appointment_id`) REFERENCES `appointment` (`appointment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `visit`
--

LOCK TABLES `visit` WRITE;
/*!40000 ALTER TABLE `visit` DISABLE KEYS */;
INSERT INTO `visit` VALUES ('V0001','P0001','D0006','A0001','Advanced dental decay in tooth #14'),('V0002','P0002','D0002','A0002','Advised on maintaining healthy lifestyle'),('V0003','P0003','D0001','A0004','Common cold confirmed; rest and hydration recommended'),('V0004','P0005','D0004','A0005','Genetic testing and serological blood tests confirmed celiac disease, gluten-free diet recommended'),('V0005','P0009','D0005','A0007','Physical therapy recommended'),('V0007','P0006','D0004','A0008','Inhaler given');
/*!40000 ALTER TABLE `visit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vital`
--

DROP TABLE IF EXISTS `vital`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vital` (
  `vital_id` varchar(50) NOT NULL,
  `visit_id` varchar(50) DEFAULT NULL,
  `height` int DEFAULT NULL,
  `weight` int DEFAULT NULL,
  `blood_pressure` varchar(50) DEFAULT NULL,
  `heart_rate` int DEFAULT NULL,
  `body_temperature` decimal(3,1) DEFAULT NULL,
  PRIMARY KEY (`vital_id`),
  KEY `visit_id` (`visit_id`),
  CONSTRAINT `vital_ibfk_1` FOREIGN KEY (`visit_id`) REFERENCES `visit` (`visit_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vital`
--

LOCK TABLES `vital` WRITE;
/*!40000 ALTER TABLE `vital` DISABLE KEYS */;
INSERT INTO `vital` VALUES ('VT0001','V0002',162,54,'120/80',77,36.7),('VT0002','V0003',173,61,'119/81',100,37.0),('VT0003','V0005',170,55,NULL,NULL,NULL),('VT0004','V0007',115,25,'90/70',110,36.5);
/*!40000 ALTER TABLE `vital` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'ehr'
--
/*!50106 SET @save_time_zone= @@TIME_ZONE */ ;
/*!50106 DROP EVENT IF EXISTS `log_patient_entry_time` */;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8mb4 */ ;;
/*!50003 SET character_set_results = utf8mb4 */ ;;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`root`@`localhost`*/ /*!50106 EVENT `log_patient_entry_time` ON SCHEDULE EVERY 5 MINUTE STARTS '2023-11-25 16:39:34' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
    -- Insert the log entry for newly added patients during the last 5 minutes. --
    INSERT INTO patient_entry_log (patient_id, entry_timestamp)
    SELECT patient_id, NOW()
    FROM patient
    WHERE patient_id NOT IN (SELECT patient_id FROM patient_entry_log);
END */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
DELIMITER ;
/*!50106 SET TIME_ZONE= @save_time_zone */ ;

--
-- Dumping routines for database 'ehr'
--
/*!50003 DROP FUNCTION IF EXISTS `calculate_bmi` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `calculate_bmi`(height FLOAT, weight FLOAT) RETURNS float
    DETERMINISTIC
BEGIN
    DECLARE bmi FLOAT;
    DECLARE b_height FLOAT;
    DECLARE b_weight FLOAT;
    SET b_height = height;
    SET b_weight = weight;
    SET bmi = b_weight / ((b_height/100) * (b_height/100));
    RETURN bmi;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_appointment_status` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_appointment_status`(
    IN update_appointment_id VARCHAR(50),
    IN update_status VARCHAR(50))
BEGIN
    UPDATE appointment
    SET appointment_status = update_status
    WHERE appointment_id = update_appointment_id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `bmi_per_lifestyle`
--

/*!50001 DROP VIEW IF EXISTS `bmi_per_lifestyle`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `bmi_per_lifestyle` AS select `p`.`patient_first_name` AS `patient_first_name`,`p`.`patient_last_name` AS `patient_last_name`,`calculate_bmi`(`v`.`height`,`v`.`weight`) AS `bmi`,`v`.`blood_pressure` AS `blood_pressure`,`v`.`heart_rate` AS `heart_rate`,`m`.`allergy` AS `allergy`,`m`.`lifestyle_habits` AS `lifestyle_habits`,`m`.`genetic_predisposition` AS `genetic_predisposition` from (((`patient` `p` join `visit` `vi` on((`p`.`patient_ID` = `vi`.`patient_id`))) join `vital` `v` on((`vi`.`visit_id` = `v`.`visit_id`))) join `medical_history` `m` on((`p`.`patient_ID` = `m`.`patient_id`))) where (`m`.`lifestyle_habits` is not null) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `recent_diagnosis`
--

/*!50001 DROP VIEW IF EXISTS `recent_diagnosis`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `recent_diagnosis` AS select `p`.`patient_first_name` AS `patient_first_name`,`p`.`patient_last_name` AS `patient_last_name`,`d`.`diagnosis_description` AS `diagnosis_description` from ((`patient` `p` join `visit` `v` on((`p`.`patient_ID` = `v`.`patient_id`))) join `diagnosis` `d` on((`v`.`visit_id` = `d`.`visit_id`))) order by `p`.`patient_first_name` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `resource_allocation`
--

/*!50001 DROP VIEW IF EXISTS `resource_allocation`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `resource_allocation` AS select `d`.`doctor_first_name` AS `doctor_first_name`,`d`.`doctor_last_name` AS `doctor_last_name`,`a`.`appointment_date` AS `appointment_date` from (`doctor` `d` left join `appointment` `a` on((`d`.`doctor_id` = `a`.`doctor_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-11-25 16:50:25
