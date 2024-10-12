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
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-03-29 13:29:36
