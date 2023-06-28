-- MySQL dump 10.13  Distrib 8.0.30, for Win64 (x86_64)
--
-- Host: localhost    Database: todoapp
-- ------------------------------------------------------
-- Server version	8.0.30

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
-- Table structure for table `alerts`
--

DROP TABLE IF EXISTS `alerts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alerts` (
  `idAlert` int NOT NULL AUTO_INCREMENT,
  `alertMessage` varchar(255) NOT NULL,
  `alertDate` date NOT NULL,
  `userId` int NOT NULL,
  PRIMARY KEY (`idAlert`),
  KEY `fk_alertUser_id_idx` (`userId`),
  CONSTRAINT `fk_alerUser_id` FOREIGN KEY (`userId`) REFERENCES `user` (`iduser`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alerts`
--

LOCK TABLES `alerts` WRITE;
/*!40000 ALTER TABLE `alerts` DISABLE KEYS */;
INSERT INTO `alerts` VALUES (1,'Task \"Pick up tamplates from publishing\" is due tomorrow and is not complete.','2023-06-12',4),(2,'Task \"Take exam in C++\" is due tomorrow and is not complete.','2023-06-12',3),(3,'Task \"List of bugs\" is due tomorrow and is not complete.','2023-06-12',4);
/*!40000 ALTER TABLE `alerts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tag`
--

DROP TABLE IF EXISTS `tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tag` (
  `idtag` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`idtag`),
  UNIQUE KEY `idtag_UNIQUE` (`idtag`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tag`
--

LOCK TABLES `tag` WRITE;
/*!40000 ALTER TABLE `tag` DISABLE KEYS */;
INSERT INTO `tag` VALUES (1,'Personal'),(2,'Study'),(3,'Work'),(4,'Finance'),(5,'Project'),(6,'Course'),(7,'Shopping'),(8,'Travel');
/*!40000 ALTER TABLE `tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `taglist`
--

DROP TABLE IF EXISTS `taglist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `taglist` (
  `idtagList` int NOT NULL AUTO_INCREMENT,
  `tagId` int NOT NULL,
  `listItemId` int NOT NULL,
  PRIMARY KEY (`idtagList`),
  KEY `fk_tagId_idx` (`tagId`),
  KEY `fk_listItemId_idx` (`listItemId`),
  CONSTRAINT `fk_listItemId` FOREIGN KEY (`listItemId`) REFERENCES `todoitem` (`idtoDoItem`),
  CONSTRAINT `fk_tagId` FOREIGN KEY (`tagId`) REFERENCES `tag` (`idtag`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `taglist`
--

LOCK TABLES `taglist` WRITE;
/*!40000 ALTER TABLE `taglist` DISABLE KEYS */;
INSERT INTO `taglist` VALUES (1,1,1),(2,2,2),(3,3,3),(4,7,1),(5,6,2),(6,5,3);
/*!40000 ALTER TABLE `taglist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `todoitem`
--

DROP TABLE IF EXISTS `todoitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `todoitem` (
  `idtoDoItem` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `description` varchar(245) DEFAULT NULL,
  `isCompleted` enum('T','F') NOT NULL,
  `reminder` date DEFAULT NULL,
  `listId` int NOT NULL,
  PRIMARY KEY (`idtoDoItem`),
  UNIQUE KEY `idtoDoItem_UNIQUE` (`idtoDoItem`),
  KEY `fk_listId_idx` (`listId`),
  CONSTRAINT `fk_listId` FOREIGN KEY (`listId`) REFERENCES `todolist` (`idList`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15250 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `todoitem`
--

LOCK TABLES `todoitem` WRITE;
/*!40000 ALTER TABLE `todoitem` DISABLE KEYS */;
INSERT INTO `todoitem` VALUES (1,'Shoping List','List of groceries for the next (25) week','T',NULL,2),(2,'Frank\'s birthday','Buy a book','F','2023-06-15',1),(3,'Call Victor Brayan','Public Policy Discussion','F','2023-06-10',3),(4,'Prepare financial report for May','Include activities with kids','F',NULL,4),(5,'To do groceries','Milk, eggs, tea, oil, pasta, apples, bananas','T',NULL,5),(6,'Take exam in C++','Read about pointers','F','2023-06-13',6),(7,'Read about macro economy','Economy','F',NULL,7),(8,'Pick up tamplates from publishing','B.V. book','F','2023-06-13',8),(9,'Make Facebook post about last event','It was amazing adventure ...','F',NULL,9),(10,'List of bugs','include isEmpy and if Exist validation ','F','2023-06-13',10);
/*!40000 ALTER TABLE `todoitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `todolist`
--

DROP TABLE IF EXISTS `todolist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `todolist` (
  `idList` int NOT NULL AUTO_INCREMENT,
  `listName` varchar(200) NOT NULL,
  `userId` int NOT NULL,
  `reminder` timestamp(6) NULL DEFAULT NULL,
  `created` timestamp(6) NULL DEFAULT NULL,
  PRIMARY KEY (`idList`),
  UNIQUE KEY `idList_UNIQUE` (`idList`),
  KEY `fk_userId_idx` (`userId`),
  CONSTRAINT `fk_userId` FOREIGN KEY (`userId`) REFERENCES `user` (`iduser`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `todolist`
--

LOCK TABLES `todolist` WRITE;
/*!40000 ALTER TABLE `todolist` DISABLE KEYS */;
INSERT INTO `todolist` VALUES (1,'Personal',1,'2023-06-06 08:00:00.000000','2023-06-12 11:57:59.000000'),(2,'Home',1,'2023-06-06 18:00:00.000000','2023-06-12 11:57:59.000000'),(3,'Work',1,'2023-06-15 18:00:00.000000','2023-06-12 11:57:59.000000'),(4,'Scouterna',2,NULL,'2023-06-12 11:57:59.000000'),(5,'Shopping List',3,NULL,'2023-06-12 11:57:59.000000'),(6,'University',3,NULL,'2023-06-12 11:57:59.000000'),(7,'University',1,NULL,'2023-06-12 11:57:59.000000'),(8,'Job',4,NULL,'2023-06-12 11:57:59.000000'),(9,'Work',3,NULL,'2023-06-12 11:57:59.000000'),(10,'BugFix',4,NULL,'2023-06-12 11:57:59.000000');
/*!40000 ALTER TABLE `todolist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `iduser` int NOT NULL,
  `name` varchar(45) NOT NULL,
  `surname` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  PRIMARY KEY (`iduser`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'Daria','Nahorna','qwerty','darCo@gmail.com'),(2,'Johan','Möller','123456789','johan@scout.se'),(3,'Lotta','Thorsson','jG0ZhD7l0','lottaT@holline.uk'),(4,'Emil','Bergman','Hm&03ls','bergmanE@bing.com');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-06-12 14:30:36
