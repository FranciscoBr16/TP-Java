CREATE DATABASE  IF NOT EXISTS `gimnasio` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `gimnasio`;
-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: localhost    Database: gimnasio
-- ------------------------------------------------------
-- Server version	8.0.42

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
-- Table structure for table `abono`
--

DROP TABLE IF EXISTS `abono`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `abono` (
  `id_abono` int NOT NULL AUTO_INCREMENT,
  `nombreAbono` varchar(45) NOT NULL,
  `cant_reservas` int DEFAULT NULL,
  `precio` int DEFAULT NULL,
  `descripcion` varchar(45) DEFAULT NULL,
  `estado` tinyint DEFAULT '1',
  `imagen` varchar(450) DEFAULT NULL,
  PRIMARY KEY (`id_abono`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `abono`
--

LOCK TABLES `abono` WRITE;
/*!40000 ALTER TABLE `abono` DISABLE KEYS */;
INSERT INTO `abono` VALUES (1,'Simple',8,4000,'2 reservas por semana',1,'/GYM/img/plan1.jpg'),(2,'Estandar',12,5500,'3 reservas por semana',1,'/GYM/img/plan2.jpg'),(3,'Premium',30,8500,'Todos los dias',1,'/GYM/img/plan3.jpg'),(4,'Plan Estudiantil 2',34,444,'requisitos: Certificado alumno Regular',0,'/GYM/img/inputs/abon4.jpg');
/*!40000 ALTER TABLE `abono` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clase`
--

DROP TABLE IF EXISTS `clase`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clase` (
  `id_clase` int NOT NULL AUTO_INCREMENT,
  `nombre_clase` varchar(45) DEFAULT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `cupo` int DEFAULT NULL,
  `horario` varchar(45) DEFAULT NULL,
  `id_empleado` int DEFAULT NULL,
  `imagen` varchar(255) DEFAULT NULL,
  `dia` varchar(45) DEFAULT NULL,
  `tipo` varchar(45) DEFAULT NULL,
  `estado` tinyint DEFAULT '1',
  PRIMARY KEY (`id_clase`),
  KEY `fk_empleado_idx` (`id_empleado`),
  CONSTRAINT `fk_empleado` FOREIGN KEY (`id_empleado`) REFERENCES `empleado` (`id_empleado`)
) ENGINE=InnoDB AUTO_INCREMENT=138 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clase`
--

LOCK TABLES `clase` WRITE;
/*!40000 ALTER TABLE `clase` DISABLE KEYS */;
INSERT INTO `clase` VALUES (1,'Yoga','Clase de Yoga que combina posturas físicas, técnicas de respiración y meditación, buscando mejorar la flexibilidad, fuerza y equilibrio, así como promover la relajación y la conexión mente-cuerpo',18,'17:00',1,'/GYM/img/inputs/act1.png','Martes','actividad',1),(2,'Zumba','La clase de Zumba es una experiencia energética que fusiona movimientos de baile con ritmos contagiosos, proporcionando un entrenamiento cardiovascular divertido y lleno de ritmo.',25,'19:00',2,'/GYM/img/zumba.png','Miercoles','actividad',1),(3,'Boxeo','Una clase de boxeo implica un entrenamiento intenso que combina golpes en sacos y entrenamiento cardiovascular, proporcionando una forma efectiva de mejorar la fuerza, la resistencia y la coordinación, además de liberar estrés.',15,'18:00',4,'/GYM/img/boxeo.png','Jueves','actividad',1),(101,'Musculacion',NULL,35,'13:00',NULL,NULL,'Lunes','musculacion',1),(102,'Musculacion',NULL,35,'14:00',NULL,NULL,'Lunes','musculacion',1),(103,'Musculacion',NULL,35,'15:00',NULL,NULL,'Lunes','musculacion',1),(104,'Musculacion',NULL,35,'16:00',NULL,NULL,'Lunes','musculacion',1),(105,'Musculacion',NULL,35,'17:00',NULL,NULL,'Lunes','musculacion',1),(106,'Musculacion',NULL,35,'18:00',NULL,NULL,'Lunes','musculacion',1),(107,'Musculacion',NULL,35,'19:00',NULL,NULL,'Lunes','musculacion',1),(108,'Musculacion',NULL,35,'13:00',NULL,NULL,'Martes','musculacion',1),(109,'Musculacion',NULL,35,'14:00',NULL,NULL,'Martes','musculacion',1),(110,'Musculacion',NULL,35,'15:00',NULL,NULL,'Martes','musculacion',1),(111,'Musculacion',NULL,35,'16:00',NULL,NULL,'Martes','musculacion',1),(112,'Musculacion',NULL,35,'17:00',NULL,NULL,'Martes','musculacion',1),(113,'Musculacion',NULL,35,'18:00',NULL,NULL,'Martes','musculacion',1),(114,'Musculacion',NULL,35,'19:00',NULL,NULL,'Martes','musculacion',1),(115,'Musculacion',NULL,35,'13:00',NULL,NULL,'Miercoles','musculacion',1),(116,'Musculacion',NULL,35,'14:00',NULL,NULL,'Miercoles','musculacion',1),(117,'Musculacion',NULL,35,'15:00',NULL,NULL,'Miercoles','musculacion',1),(118,'Musculacion',NULL,35,'16:00',NULL,NULL,'Miercoles','musculacion',1),(119,'Musculacion',NULL,35,'17:00',NULL,NULL,'Miercoles','musculacion',1),(120,'Musculacion',NULL,35,'18:00',NULL,NULL,'Miercoles','musculacion',1),(121,'Musculacion',NULL,35,'19:00',NULL,NULL,'Miercoles','musculacion',1),(122,'Musculacion','',35,'13:00',NULL,NULL,'Jueves','musculacion',1),(123,'Musculacion',NULL,35,'14:00',NULL,NULL,'Jueves','musculacion',1),(124,'Musculacion',NULL,35,'15:00',NULL,NULL,'Jueves','musculacion',1),(125,'Musculacion',NULL,35,'16:00',NULL,NULL,'Jueves','musculacion',1),(126,'Musculacion',NULL,35,'17:00',NULL,NULL,'Jueves','musculacion',1),(127,'Musculacion',NULL,35,'18:00',NULL,NULL,'Jueves','musculacion',1),(128,'Musculacion',NULL,35,'19:00',NULL,NULL,'Jueves','musculacion',1),(130,'Musculacion',NULL,35,'13:00',NULL,NULL,'Viernes','musculacion',1),(131,'Musculacion',NULL,35,'14:00',NULL,NULL,'Viernes','musculacion',1),(132,'Musculacion',NULL,35,'15:00',NULL,NULL,'Viernes','musculacion',1),(133,'Musculacion',NULL,35,'16:00',NULL,NULL,'Viernes','musculacion',1),(134,'Musculacion',NULL,35,'17:00',NULL,NULL,'Viernes','musculacion',1),(135,'Musculacion',NULL,35,'18:00',NULL,NULL,'Viernes','musculacion',1),(136,'Musculacion',NULL,35,'19:00',NULL,NULL,'Viernes','musculacion',1);
/*!40000 ALTER TABLE `clase` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contrato`
--

DROP TABLE IF EXISTS `contrato`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contrato` (
  `dni_usuario` varchar(45) NOT NULL,
  `id_abono` int NOT NULL AUTO_INCREMENT,
  `fecha_desde` date NOT NULL,
  `fecha_hasta` date NOT NULL,
  `clases_disponibles` int NOT NULL,
  PRIMARY KEY (`dni_usuario`,`fecha_desde`,`fecha_hasta`),
  KEY `fk_abono_idx` (`id_abono`),
  CONSTRAINT `fk_abono` FOREIGN KEY (`id_abono`) REFERENCES `abono` (`id_abono`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_usuario2` FOREIGN KEY (`dni_usuario`) REFERENCES `usuario` (`dni`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contrato`
--

LOCK TABLES `contrato` WRITE;
/*!40000 ALTER TABLE `contrato` DISABLE KEYS */;
INSERT INTO `contrato` VALUES ('00000001',3,'2023-12-01','2023-12-31',27),('42424242',1,'2023-11-01','2023-11-30',8);
/*!40000 ALTER TABLE `contrato` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `descuento`
--

DROP TABLE IF EXISTS `descuento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `descuento` (
  `id_descuento` int NOT NULL AUTO_INCREMENT,
  `porc_descuento` float NOT NULL,
  PRIMARY KEY (`id_descuento`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `descuento`
--

LOCK TABLES `descuento` WRITE;
/*!40000 ALTER TABLE `descuento` DISABLE KEYS */;
INSERT INTO `descuento` VALUES (1,0),(2,0.3),(3,0.2),(4,0.1);
/*!40000 ALTER TABLE `descuento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detalle-factura`
--

DROP TABLE IF EXISTS `detalle-factura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detalle-factura` (
  `nro_factura` int NOT NULL,
  `id_producto` int NOT NULL,
  `cantidad` int DEFAULT NULL,
  `sub_total` float DEFAULT NULL,
  PRIMARY KEY (`nro_factura`,`id_producto`),
  KEY `fk_producto_idx` (`id_producto`),
  CONSTRAINT `fk_producto4` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id_producto`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalle-factura`
--

LOCK TABLES `detalle-factura` WRITE;
/*!40000 ALTER TABLE `detalle-factura` DISABLE KEYS */;
/*!40000 ALTER TABLE `detalle-factura` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `empleado`
--

DROP TABLE IF EXISTS `empleado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empleado` (
  `id_empleado` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `apellido` varchar(45) DEFAULT NULL,
  `mail` varchar(45) DEFAULT NULL,
  `fecha_desde` date DEFAULT NULL,
  `rol` varchar(45) DEFAULT NULL,
  `imagen` varchar(255) DEFAULT NULL,
  `estado` tinyint DEFAULT '1',
  PRIMARY KEY (`id_empleado`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empleado`
--

LOCK TABLES `empleado` WRITE;
/*!40000 ALTER TABLE `empleado` DISABLE KEYS */;
INSERT INTO `empleado` VALUES (1,'Benjamín','Fares','benjabaldursgate@gmail.com','2023-08-23','Mira a tu novia','/GYM/img/empleados/emp_1.jpg',1),(2,'Francisco','Bruno','fransbebobruno@gmail.com','2023-08-23','Recepcionista','/GYM/img/empleados/FB233.jpg',1),(3,'Santiago','Auat','santiauat@hotmail.com','2023-08-23','Instructor','/GYM/img/empleados/emp_3.png',1),(4,'Jerónimo','Álvarez','jeroaguiladorada@gmail.com','2023-08-23','Maestro','/GYM/img/empleados/emp_4.png',1);
/*!40000 ALTER TABLE `empleado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `factura`
--

DROP TABLE IF EXISTS `factura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `factura` (
  `nro_factura` int NOT NULL AUTO_INCREMENT,
  `fecha` date DEFAULT NULL,
  `tipo` char(1) DEFAULT NULL,
  `cuit` varchar(45) DEFAULT NULL,
  `dni` varchar(45) NOT NULL,
  `total` float DEFAULT NULL,
  `estado` varchar(45) DEFAULT '0',
  PRIMARY KEY (`nro_factura`),
  KEY `fk_usuario2_idx` (`dni`),
  CONSTRAINT `fk_usuario3` FOREIGN KEY (`dni`) REFERENCES `usuario` (`dni`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `factura`
--

LOCK TABLES `factura` WRITE;
/*!40000 ALTER TABLE `factura` DISABLE KEYS */;
INSERT INTO `factura` VALUES (1,'2023-12-12','C','6942069','00000001',10000,'pendiente pago'),(2,'2023-12-13','C','6942069','00000001',700,'pagado'),(3,'2026-01-13','C','6942069','42424242',8000,'rechazada'),(4,'2026-01-14','C','6942069','42424242',18000,'PENDIENTE_PAGO');
/*!40000 ALTER TABLE `factura` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indumentaria`
--

DROP TABLE IF EXISTS `indumentaria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `indumentaria` (
  `id_producto` int NOT NULL,
  `talle` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_producto`),
  CONSTRAINT `fk_producto1` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id_producto`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indumentaria`
--

LOCK TABLES `indumentaria` WRITE;
/*!40000 ALTER TABLE `indumentaria` DISABLE KEYS */;
INSERT INTO `indumentaria` VALUES (2,'XL'),(3,NULL),(4,'39'),(5,'L'),(8,'M'),(9,'12 oz');
/*!40000 ALTER TABLE `indumentaria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inscripcion`
--

DROP TABLE IF EXISTS `inscripcion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inscripcion` (
  `dni` varchar(45) NOT NULL,
  `id_clase` int NOT NULL,
  `fecha` date NOT NULL,
  PRIMARY KEY (`dni`,`id_clase`,`fecha`),
  KEY `fk_clase_idx` (`id_clase`),
  CONSTRAINT `fk_clase` FOREIGN KEY (`id_clase`) REFERENCES `clase` (`id_clase`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_usuario4` FOREIGN KEY (`dni`) REFERENCES `usuario` (`dni`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inscripcion`
--

LOCK TABLES `inscripcion` WRITE;
/*!40000 ALTER TABLE `inscripcion` DISABLE KEYS */;
INSERT INTO `inscripcion` VALUES ('00000001',1,'2023-10-18'),('00000001',1,'2023-12-15'),('00000001',2,'2023-10-18'),('00000001',2,'2023-12-15'),('00000001',3,'2023-12-15');
/*!40000 ALTER TABLE `inscripcion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `precio`
--

DROP TABLE IF EXISTS `precio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `precio` (
  `id_producto` int NOT NULL,
  `fecha_desde` date NOT NULL,
  `precio` int DEFAULT NULL,
  PRIMARY KEY (`id_producto`,`fecha_desde`),
  CONSTRAINT `fk_producto3` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id_producto`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `precio`
--

LOCK TABLES `precio` WRITE;
/*!40000 ALTER TABLE `precio` DISABLE KEYS */;
INSERT INTO `precio` VALUES (1,'2023-08-08',700),(2,'2023-09-09',8000),(2,'2023-12-01',9000),(2,'2023-12-08',9550),(2,'2023-12-12',10000),(3,'2023-12-06',8000),(4,'2023-12-06',18000),(5,'2023-12-07',700),(7,'2026-01-01',1400),(8,'2026-01-01',18000),(9,'2026-01-01',32000);
/*!40000 ALTER TABLE `precio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `producto`
--

DROP TABLE IF EXISTS `producto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `producto` (
  `id_producto` int NOT NULL AUTO_INCREMENT,
  `stock` int NOT NULL DEFAULT '0',
  `descripcion` varchar(255) DEFAULT NULL,
  `imagen` varchar(255) DEFAULT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_producto`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `producto`
--

LOCK TABLES `producto` WRITE;
/*!40000 ALTER TABLE `producto` DISABLE KEYS */;
INSERT INTO `producto` VALUES (1,29,'bebida isotónica diseñada para rehidratar y reponer electrolitos, ofreciendo una mezcla refrescante que ayuda en la recuperación después de la actividad física.','/GYM/img/productos/powerade-500ml.jpg','Powerade x500 ml'),(2,21,'camiseta deportiva, apta para sublimación de alta calidad','/GYM/img/productos/camiseta-deportiva.png','Camiseta Deportiva'),(3,1,'Cake','/GYM/img/productos/ind_3.jpg','Prote'),(4,1,'zapatilas deportivas Jaguar','/GYM/img/productos/ind_4.png','Zapatillas'),(5,0,'Medias para practicar boxeo','/GYM/img/productos/ind_6.jpg','Medias de Boxeo'),(7,24,'Agua purificada ideal para la hidratación antes, durante y después de la actividad física.','/GYM/img/productos/agua.jpg','Agua Smart Water'),(8,2,'Short cómodo y liviano que permite libertad de movimiento durante la actividad física.','/GYM/img/productos/short.jpg','Pantalón corto deportivo'),(9,4,'Guantes acolchados diseñados para entrenamientos de boxeo y deportes de contacto.','/GYM/img/productos/guantes.jpg','Guantes de boxeo');
/*!40000 ALTER TABLE `producto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `suplemento`
--

DROP TABLE IF EXISTS `suplemento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `suplemento` (
  `id_producto` int NOT NULL,
  `unidad` varchar(45) DEFAULT NULL,
  `valor` float DEFAULT NULL,
  PRIMARY KEY (`id_producto`),
  CONSTRAINT `fk_producto2` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id_producto`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `suplemento`
--

LOCK TABLES `suplemento` WRITE;
/*!40000 ALTER TABLE `suplemento` DISABLE KEYS */;
INSERT INTO `suplemento` VALUES (1,'ml',500),(3,'g',900),(7,'ml',500);
/*!40000 ALTER TABLE `suplemento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `dni` varchar(45) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `apellido` varchar(45) NOT NULL,
  `clave` varchar(45) NOT NULL,
  `correo` varchar(45) NOT NULL,
  `telefono` varchar(45) NOT NULL,
  `beneficio` tinyint(1) DEFAULT '0',
  `admin` tinyint(1) DEFAULT '0',
  `imagen` varchar(255) DEFAULT NULL,
  `fechaNacimiento` date DEFAULT NULL,
  `estado` tinyint DEFAULT '1',
  PRIMARY KEY (`dni`),
  UNIQUE KEY `telefono_UNIQUE` (`telefono`),
  UNIQUE KEY `correo_UNIQUE` (`correo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES ('00000001','Usuario','Deprueba','contrasenia','prueba@gmail.com','34343434',1,0,'/GYM/img/perfil/imgperfil1.jpg','2000-10-10',1),('42424242','Santi','Auat','santi','soyaua@gmail.com','3464440838',0,0,'/GYM/img/perfil/imgperfil2.jpg','2000-12-11',1),('69696969','admin','admin','admin123','abz@gmail.com','123456789',0,1,'/GYM/img/perfil/imgperfil1.jpg','2000-12-11',1);
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-01-14 17:24:39
