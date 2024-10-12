-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: tienda
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
-- Table structure for table `categorias`
--

DROP TABLE IF EXISTS `categorias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categorias` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre_UNIQUE` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categorias`
--

LOCK TABLES `categorias` WRITE;
/*!40000 ALTER TABLE `categorias` DISABLE KEYS */;
INSERT INTO `categorias` VALUES (2,'DISCOS DURO'),(1,'MEMORIAS RAM'),(3,'MONITORES'),(4,'TECLADOS');
/*!40000 ALTER TABLE `categorias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detalles_orden`
--

DROP TABLE IF EXISTS `detalles_orden`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detalles_orden` (
  `id` int NOT NULL AUTO_INCREMENT,
  `idorden` int NOT NULL,
  `idproducto` int NOT NULL,
  `cantidad` int NOT NULL,
  `fecha_creacion` datetime DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizacion` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `idproducto_idx` (`idproducto`),
  KEY `idorden_idx` (`idorden`),
  CONSTRAINT `idorden` FOREIGN KEY (`idorden`) REFERENCES `orden` (`id`),
  CONSTRAINT `idproducto` FOREIGN KEY (`idproducto`) REFERENCES `productos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=187 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalles_orden`
--

LOCK TABLES `detalles_orden` WRITE;
/*!40000 ALTER TABLE `detalles_orden` DISABLE KEYS */;
INSERT INTO `detalles_orden` VALUES (174,26,2,1,'2024-03-29 12:34:40','2024-03-29 12:34:40'),(175,26,3,1,'2024-03-29 12:34:42','2024-03-29 12:34:42'),(176,26,4,1,'2024-03-29 12:34:44','2024-03-29 12:34:44'),(177,27,2,1,'2024-03-29 13:01:17','2024-03-29 13:01:17'),(178,27,3,1,'2024-03-29 13:01:18','2024-03-29 13:01:18'),(179,27,4,1,'2024-03-29 13:01:20','2024-03-29 13:01:20'),(180,27,7,1,'2024-03-29 13:01:25','2024-03-29 13:01:25'),(181,27,26,1,'2024-03-29 13:01:26','2024-03-29 13:01:26'),(182,27,27,1,'2024-03-29 13:01:28','2024-03-29 13:01:28'),(183,28,2,1,'2024-03-29 13:04:35','2024-03-29 13:04:35'),(184,28,27,1,'2024-03-29 13:04:39','2024-03-29 13:04:39'),(185,28,26,1,'2024-03-29 13:04:40','2024-03-29 13:04:40'),(186,28,28,1,'2024-03-29 13:04:44','2024-03-29 13:04:44');
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

--
-- Table structure for table `orden`
--

DROP TABLE IF EXISTS `orden`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orden` (
  `id` int NOT NULL AUTO_INCREMENT,
  `total` decimal(10,2) DEFAULT '0.00',
  `lista_productos` json DEFAULT NULL,
  `numero_comprobante` varchar(100) DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizacion` datetime DEFAULT CURRENT_TIMESTAMP,
  `activo` tinyint NOT NULL DEFAULT '1',
  `idusuario` int NOT NULL,
  `idstatus` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `idusuario_idx` (`idusuario`),
  KEY `idstatus_idx` (`idstatus`),
  CONSTRAINT `idstatus` FOREIGN KEY (`idstatus`) REFERENCES `status` (`id`),
  CONSTRAINT `idusuario` FOREIGN KEY (`idusuario`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orden`
--

LOCK TABLES `orden` WRITE;
/*!40000 ALTER TABLE `orden` DISABLE KEYS */;
INSERT INTO `orden` VALUES (26,3383000.00,NULL,'PGrolM4t0WDZewS','2024-03-28 20:44:19','2024-03-29 13:00:46',1,23,3),(27,4651078.00,NULL,'AwTE2IqivTsp4yZ','2024-03-29 13:01:17','2024-03-29 13:01:41',1,23,3),(28,4157078.00,NULL,'9avChHjfjRyrc1w','2024-03-29 13:04:35','2024-03-29 13:04:59',1,23,3);
/*!40000 ALTER TABLE `orden` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productos`
--

DROP TABLE IF EXISTS `productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `descripcion` varchar(10000) DEFAULT NULL,
  `precio` float NOT NULL,
  `activo` tinyint DEFAULT '1',
  `fecha_creacion` datetime DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizacion` datetime DEFAULT CURRENT_TIMESTAMP,
  `stock` int DEFAULT '0',
  `imagen` varchar(500) DEFAULT NULL,
  `idcategoria` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_idx` (`idcategoria`),
  CONSTRAINT `idcategoria` FOREIGN KEY (`idcategoria`) REFERENCES `categorias` (`id`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productos`
--

LOCK TABLES `productos` WRITE;
/*!40000 ALTER TABLE `productos` DISABLE KEYS */;
INSERT INTO `productos` VALUES (1,'MEMORIA RAM DDR4 KIGNSTON 900','MEMORIA RAM DDR4, 3200 MHZ 8GB MARCA KIGNSTON 800',110000,0,'2023-04-01 15:54:08','2023-11-17 17:10:13',1,'a629621c-2253-463d-84d8-a88500c62328.jpg',1),(2,'MEMORIA RAM DDR5 KIGNSTON','MEMORIA RAM DDR5, 4800 MHZ 8GB MARCA KIGNSTON',3100000,1,'2023-04-01 15:54:08','2023-04-30 19:56:52',1,'a68c39af-1de3-4536-a6e0-1598c15ca7a8.jpg',1),(3,'MEMORIA RAM DDR4 SAMSUNG 700900','MEMORIA RAM DDR4, 3200 MHZ 8GB MARCA SAMSUNG',123000,1,'2023-04-06 15:54:08','2024-03-28 21:13:40',1,'e1436fa9-be83-4e71-a2e2-388b53069744.jpg',3),(4,'MEMORIA RAM DDR5 SAMSUNG','MEMORIA RAM DDR5, 4800 MHZ 8GB MARCA SAMSUNG',160000,1,'2023-04-06 15:54:08','2024-03-23 15:12:57',100,'f7116a5c-7544-414a-9463-bf49e550a5cd.jpg',1),(7,'SSD 480GB WESTERN DIGITAL GREEN','SSD 480GB WESTERN DIGITAL GREEN',290000,1,'2023-04-06 15:54:08','2023-04-30 19:56:52',1,'aa6b0663-5c20-4ea7-ac90-3d236f7b7a5a.jpg',2),(26,'SSD SANDISK S90078','7878787878',78,1,'2023-10-28 18:09:10','2023-10-28 18:09:10',78,'7d9366f8-10b4-415f-a9e1-d4fb5b5fb03d.jpg',2),(27,'MONITOR LG 29WL500','MONITOR LG 29WL500  29\" PULGADAS 29WL500 NEGRO',978000,1,'2023-10-28 19:05:17','2023-10-28 19:05:17',34,'adaddd04-b1b5-4da6-a137-53860cf06515.jpg',3),(28,'OSITO TRIPON # 7','OSITO CARIÑOSITO',79000,1,'2023-10-28 19:06:53','2024-03-23 20:51:51',68,'844e5c69-3b30-4521-a50b-b8988531789b.jpg',4),(29,'SAMSUNG NEO QLED 8K','SAMSUNG NEO QLED 8K 65 PULGADAS',3700000,1,'2023-10-28 19:22:46','2023-10-28 19:22:46',23,'25274b38-55de-48ab-9a27-f2961ec88eaf.jpg',3),(30,'SSD SANDISK S900','345345345',45,1,'2023-10-28 19:32:59','2023-10-28 19:32:59',4,'f8ef0fc0-4a97-47ea-9712-405607ae6919.jpg',2),(31,'NEO QLED SAMSUNG','TEST TST',4500000,1,'2023-11-04 17:12:31','2023-11-04 17:12:31',78,'89ea9379-1ea4-4774-9ee7-c8c8b36942cd.jpg',3);
/*!40000 ALTER TABLE `productos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rol`
--

DROP TABLE IF EXISTS `rol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rol` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre_UNIQUE` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rol`
--

LOCK TABLES `rol` WRITE;
/*!40000 ALTER TABLE `rol` DISABLE KEYS */;
INSERT INTO `rol` VALUES (2,'ADMIN'),(1,'CLIENTE'),(3,'EMPLEADO');
/*!40000 ALTER TABLE `rol` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `status`
--

DROP TABLE IF EXISTS `status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `status` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre_UNIQUE` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `status`
--

LOCK TABLES `status` WRITE;
/*!40000 ALTER TABLE `status` DISABLE KEYS */;
INSERT INTO `status` VALUES (1,'CREADA'),(7,'DEVUELTO'),(2,'ELIMINADA'),(6,'ENVIADA'),(3,'PAGO'),(4,'PAGO APROVADO'),(5,'PAGO RECHAZO'),(8,'RECIBIDA');
/*!40000 ALTER TABLE `status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  `numero_doc` varchar(50) NOT NULL,
  `direccion` varchar(100) NOT NULL,
  `telefono` varchar(45) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(200) NOT NULL,
  `activo` tinyint NOT NULL DEFAULT '1',
  `fecha_creacion` datetime DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizacion` datetime DEFAULT CURRENT_TIMESTAMP,
  `idrol` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  KEY `idrol_idx` (`idrol`),
  CONSTRAINT `idrol` FOREIGN KEY (`idrol`) REFERENCES `rol` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'Pepe','Lopez','1000123','calle 23','3003452312','pepe@gmail.com','U2FsdGVkX19p40mXg6844NSxda2mGUS+wkfw7Fy72WM=',1,'2023-04-29 20:36:03','2023-04-29 20:36:03',1),(2,'Pedro','Marin','12345','Calle 22','3214556765','juan@gmail.com','1234',1,'2023-05-27 10:49:42','2023-05-27 10:49:42',1),(3,'Juan','Marin','12345','Calle 22','3214556765','juan1@gmail.com','U2FsdGVkX1+vhgHztaepDXIkEgJ46DcUzON56pMMCTo=',1,'2023-05-27 15:15:54','2023-05-27 15:15:54',1),(4,'luis','perez','12345','Calle 23','3214556765','juan2@gmail.com','U2FsdGVkX19BTU8imtqt4RXuyJVvpApEQlSG2nE5Ib4=',1,'2023-07-01 10:21:36','2023-07-01 10:21:36',1),(5,'Claudia','Mora','108752345','calle 45','7779999','claudia@gmail.com','U2FsdGVkX1816jCCOFMtY85XsDe16M24sieceinrVPI=',1,'2023-10-17 17:16:06','2023-11-23 14:28:31',1),(6,'Claudia1','Mora','2353425','calle4','23345345','claudia1@gmail.com','U2FsdGVkX1+mjbUxPMkGXasudvn7PfDH2HOwW2KrSWc=',1,'2023-10-17 17:19:39','2023-10-17 17:19:39',1),(7,'Claudia2','Mora','3252345234','Carrera 31','3453454333','claudia2@gmail.com','U2FsdGVkX196341afJudTN+mWRuHTedp2eGWr8S9DdY=',1,'2023-10-17 17:26:41','2023-10-17 17:26:41',1),(8,'pepe','lopez','23432443','Carrera 34','3105667890','pepep@gmail.com','U2FsdGVkX1+bFJrgsRXrUFpQhk6/jLaRsg65xgz8EHs=',1,'2023-10-17 17:33:30','2023-10-17 17:33:30',1),(9,'admin','admin','123456','kr 23','3115704567','admin@admin.com','U2FsdGVkX1/xQvXz8YgyUp8P8iYGVPbpTcMWmVt6NgI=',1,'2023-11-04 11:09:50','2023-11-23 14:39:07',2),(10,'admin 2','admin 2','123456','kr 23','3115704567','admin2@admin.com','U2FsdGVkX1/jDMOmVlQzNbtJArD4RevmlO7KNZU3fHA=',1,'2023-11-04 11:09:50','2023-11-04 11:09:50',2),(20,'cdewe','wwer','234234','Carrera 31','4234243','admin444@admin.com','U2FsdGVkX19Q9i7zLRCM6po0d/uG4WgA26XyRx4NbXs=',1,'2023-11-17 16:07:30','2023-11-17 16:07:30',2),(21,'Sebastián','Marín','10234554','Carrera 777','4004565','jhoanmarin89@hotmail.com','U2FsdGVkX1/ZjkdGWjsoXY1Y+di5Ogi7VDWzLAbznGE=',1,'2023-11-17 18:01:40','2024-03-23 14:58:01',3),(22,'Admin','super admin','123456789','calle 23','3115433456','computershop190@gmail.com','U2FsdGVkX1+Ut5tE1k02ItCG5qeZRZazIu6qDer63m4=',1,'2024-03-23 14:57:12','2024-03-23 14:57:38',2),(23,'Jhoan','Marín','45667677','Kr 31 # 17 - 224','3115765050','jhoanmarin89@gmail.com','U2FsdGVkX1+tvzqLJ6KMMU4GJv6aNVQ1aaXbwaibDAU=',1,'2024-03-23 15:01:21','2024-03-23 15:01:21',1);
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'tienda'
--

--
-- Dumping routines for database 'tienda'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-03-29 13:28:19
