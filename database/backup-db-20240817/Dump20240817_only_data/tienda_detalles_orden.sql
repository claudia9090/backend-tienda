CREATE DATABASE  IF NOT EXISTS `tienda` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `tienda`;
-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: tienda
-- ------------------------------------------------------
-- Server version	8.0.36

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
-- Dumping data for table `detalles_orden`
--

LOCK TABLES `detalles_orden` WRITE;
/*!40000 ALTER TABLE `detalles_orden` DISABLE KEYS */;
INSERT INTO `detalles_orden` VALUES (174,26,2,1,'2024-03-29 12:34:40','2024-03-29 12:34:40'),(175,26,3,1,'2024-03-29 12:34:42','2024-03-29 12:34:42'),(176,26,4,1,'2024-03-29 12:34:44','2024-03-29 12:34:44'),(177,27,2,1,'2024-03-29 13:01:17','2024-03-29 13:01:17'),(178,27,3,1,'2024-03-29 13:01:18','2024-03-29 13:01:18'),(179,27,4,1,'2024-03-29 13:01:20','2024-03-29 13:01:20'),(180,27,7,1,'2024-03-29 13:01:25','2024-03-29 13:01:25'),(181,27,26,1,'2024-03-29 13:01:26','2024-03-29 13:01:26'),(182,27,27,1,'2024-03-29 13:01:28','2024-03-29 13:01:28'),(183,28,2,1,'2024-03-29 13:04:35','2024-03-29 13:04:35'),(184,28,27,1,'2024-03-29 13:04:39','2024-03-29 13:04:39'),(185,28,26,1,'2024-03-29 13:04:40','2024-03-29 13:04:40'),(186,28,28,1,'2024-03-29 13:04:44','2024-03-29 13:04:44'),(187,29,26,1,'2024-03-30 19:49:48','2024-03-30 19:49:48'),(188,29,27,1,'2024-03-30 19:49:50','2024-03-30 19:49:50'),(189,29,29,1,'2024-03-30 19:49:53','2024-03-30 19:49:53'),(190,29,31,1,'2024-03-30 19:49:59','2024-03-30 19:49:59'),(191,29,4,1,'2024-03-30 19:50:37','2024-03-30 19:50:37'),(192,30,4,1,'2024-03-30 19:53:53','2024-03-30 19:53:53'),(193,30,26,1,'2024-03-30 19:53:59','2024-03-30 19:53:59'),(194,30,28,1,'2024-03-30 19:54:03','2024-03-30 19:54:03'),(195,30,31,1,'2024-03-30 19:54:13','2024-03-30 19:54:13'),(196,31,3,1,'2024-04-26 22:18:00','2024-04-26 22:18:00'),(197,31,4,1,'2024-04-26 22:18:02','2024-04-26 22:18:02'),(199,32,2,1,'2024-04-26 22:18:58','2024-04-26 22:18:58'),(200,32,3,1,'2024-04-26 22:19:00','2024-04-26 22:19:00'),(201,32,4,1,'2024-04-26 22:19:02','2024-04-26 22:19:02'),(202,32,2,1,'2024-04-26 22:19:39','2024-04-26 22:19:39'),(203,32,3,1,'2024-04-26 22:19:42','2024-04-26 22:19:42'),(204,32,3,1,'2024-04-26 22:19:44','2024-04-26 22:19:44'),(205,32,4,1,'2024-04-26 22:19:45','2024-04-26 22:19:45'),(206,32,7,1,'2024-04-26 22:19:47','2024-04-26 22:19:47'),(207,33,2,1,'2024-04-26 22:21:09','2024-04-26 22:21:09'),(208,33,3,1,'2024-04-26 22:21:11','2024-04-26 22:21:11'),(209,33,4,1,'2024-04-26 22:21:12','2024-04-26 22:21:12'),(210,34,2,1,'2024-05-03 22:40:44','2024-05-03 22:40:44'),(214,34,3,1,'2024-05-03 22:44:17','2024-05-03 22:44:17'),(216,34,3,1,'2024-05-03 22:45:00','2024-05-03 22:45:00'),(217,34,4,1,'2024-05-03 22:45:02','2024-05-03 22:45:02'),(218,34,2,1,'2024-05-03 22:45:04','2024-05-03 22:45:04'),(219,34,7,1,'2024-05-03 22:45:07','2024-05-03 22:45:07'),(220,34,26,1,'2024-05-03 22:45:09','2024-05-03 22:45:09'),(221,34,27,1,'2024-05-03 22:45:11','2024-05-03 22:45:11'),(222,34,3,1,'2024-05-03 22:46:02','2024-05-03 22:46:02'),(223,34,27,1,'2024-05-03 22:46:03','2024-05-03 22:46:03'),(224,34,29,1,'2024-05-03 22:46:05','2024-05-03 22:46:05'),(225,35,2,1,'2024-08-17 13:49:13','2024-08-17 13:49:13');
/*!40000 ALTER TABLE `detalles_orden` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`usermysql`@`localhost`*/ /*!50003 TRIGGER `detalles_orden_AFTER_INSERT` AFTER INSERT ON `detalles_orden` FOR EACH ROW BEGIN
	UPDATE orden set
    fecha_actualizacion = now(),
    total = (SELECT sum(prod.precio * det.cantidad) total FROM detalles_orden det
			INNER JOIN productos prod ON prod.id = det.idproducto
			WHERE det.idorden = NEW.idorden)
	WHERE orden.id = NEW.idorden;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`usermysql`@`localhost`*/ /*!50003 TRIGGER `detalles_orden_AFTER_UPDATE` AFTER UPDATE ON `detalles_orden` FOR EACH ROW BEGIN
	UPDATE orden set
    fecha_actualizacion = now(),
    total = (SELECT sum(prod.precio * det.cantidad) total FROM detalles_orden det
			INNER JOIN productos prod ON prod.id = det.idproducto
			WHERE det.idorden = NEW.idorden)
	WHERE orden.id = NEW.idorden;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`usermysql`@`localhost`*/ /*!50003 TRIGGER `detalles_orden_AFTER_DELETE` AFTER DELETE ON `detalles_orden` FOR EACH ROW BEGIN
	/*DECLARE v_total int;  -- declarar variable y asignarle un valor
    SET v_total = 234;*/
	UPDATE orden set
    fecha_actualizacion = now(),
    total = IFNULL((SELECT sum(prod.precio * det.cantidad) total FROM detalles_orden det
			inner join productos prod on prod.id = det.idproducto
			where det.idorden = old.idorden), 0)
	where orden.id = old.idorden;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-08-17 14:22:18
