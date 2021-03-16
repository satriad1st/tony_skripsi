/*
SQLyog Ultimate v11.11 (64 bit)
MySQL - 5.6.20 : Database - apriori_resep_makanan
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`apriori_resep_makanan` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;

USE `apriori_resep_makanan`;

/*Table structure for table `confidence` */

DROP TABLE IF EXISTS `confidence`;

CREATE TABLE `confidence` (
  `kombinasi1` varchar(255) DEFAULT NULL,
  `kombinasi2` varchar(255) DEFAULT NULL,
  `support_xUy` double DEFAULT NULL,
  `support_x` double DEFAULT NULL,
  `confidence` double DEFAULT NULL,
  `lolos` tinyint(4) DEFAULT NULL,
  `min_support` double DEFAULT NULL,
  `min_confidence` double DEFAULT NULL,
  `nilai_uji_lift` double DEFAULT NULL,
  `korelasi_rule` varchar(100) DEFAULT NULL,
  `id_process` int(11) NOT NULL DEFAULT '0',
  `jumlah_a` int(11) DEFAULT NULL,
  `jumlah_b` int(11) DEFAULT NULL,
  `jumlah_ab` int(11) DEFAULT NULL,
  `px` double DEFAULT NULL,
  `py` double DEFAULT NULL,
  `pxuy` double DEFAULT NULL,
  `from_itemset` int(11) DEFAULT NULL COMMENT 'dari itemset 2/3'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Data for the table `confidence` */

/*Table structure for table `itemset1` */

DROP TABLE IF EXISTS `itemset1`;

CREATE TABLE `itemset1` (
  `atribut` varchar(200) DEFAULT NULL,
  `jumlah` int(11) DEFAULT NULL,
  `support` double DEFAULT NULL,
  `lolos` tinyint(4) DEFAULT NULL,
  `id_process` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `itemset1` */

/*Table structure for table `itemset2` */

DROP TABLE IF EXISTS `itemset2`;

CREATE TABLE `itemset2` (
  `atribut1` varchar(200) DEFAULT NULL,
  `atribut2` varchar(200) DEFAULT NULL,
  `jumlah` int(11) DEFAULT NULL,
  `support` double DEFAULT NULL,
  `lolos` tinyint(4) DEFAULT NULL,
  `id_process` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `itemset2` */

/*Table structure for table `itemset3` */

DROP TABLE IF EXISTS `itemset3`;

CREATE TABLE `itemset3` (
  `atribut1` varchar(200) DEFAULT NULL,
  `atribut2` varchar(200) DEFAULT NULL,
  `atribut3` varchar(200) DEFAULT NULL,
  `jumlah` int(11) DEFAULT NULL,
  `support` double DEFAULT NULL,
  `lolos` tinyint(4) DEFAULT NULL,
  `id_process` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `itemset3` */

/*Table structure for table `process_log` */

DROP TABLE IF EXISTS `process_log`;

CREATE TABLE `process_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `min_support` double DEFAULT NULL,
  `min_confidence` double DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `process_log` */

/*Table structure for table `temporary` */

DROP TABLE IF EXISTS `temporary`;

CREATE TABLE `temporary` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `menu` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4;

/*Data for the table `temporary` */

insert  into `temporary`(`id`,`menu`) values (2,'Ayam'),(3,'Bawang'),(4,'Ikan'),(5,'garam'),(6,'gula'),(7,'kuda');

/*Table structure for table `transaksi` */

DROP TABLE IF EXISTS `transaksi`;

CREATE TABLE `transaksi` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `transaction_date` date DEFAULT NULL,
  `produk` text,
  `menu` text,
  `ref` text,
  `score` float DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=latin1;

/*Data for the table `transaksi` */

insert  into `transaksi`(`id`,`transaction_date`,`produk`,`menu`,`ref`,`score`) values (1,'2021-02-12','Beras Ketan,Santan,Daun Pandan,Garam,Ikan Tongkol Kukus,Daun Jeruk,Serai,Kemangi,Jeruk Nipis,Tomat,Kaldu Bubuk,Merica Bubuk,Gula Pasir,Minyak Goreng,Daun Pisang,Cabai Rawit','Lalampa khas Manado','https://cookpad.com/id/resep/14203324-lalampa-khas-manado-kudapan-tradisional-nusantara',21),(2,'2021-02-12','ayam,keentang,telor,cabe kriting,bamer,baput,kunyit,jahe,lengkuas,daun kunyit,sereh geprek,daun jeruk,daun salam,garam,gula,kaldu ayam,santan,bumbu pemasak kalio','Kalio Ayam','https://cookpad.com/id/resep/13490173-kalio-ayam-masakan-daerah-padang',23),(3,'2021-02-12','ketimun,tauge,daun kemangi,kacang panjang,terong bulat,kacang tanah,lemon cina,bawang merah,bawang putih,terasi abc,cabe kecil,cabe besar,garam,masako','Sayu ulang ulang','https://cookpad.com/id/resep/13160583-sayur-ulang-ulang-daerah-seram-timur-guli-guli-maluku',20),(4,'2021-02-12','ikan baung,bawang merah,bawang putih,asam jawa,laos,kunyit,kemiri,garam,penyedap rasa,terasi','sayur asam khas khas kalimantan tengah derah arut','https://cookpad.com/id/resep/9822251-sayur-asam-khas-kalimantan-tengah-daerah-arut',18),(5,'2021-02-12','ayam,santan kental,santan encer,bawang merah,sereh,lengkuas,daun salam,daun kunyit,daun jeruk,air asam jawa,bunga lawang,garam,kunyit,sereh,jahe,lengkuas cabe merah keriting,bawang putih,kelapa parut,cengkih,jinten,kapulaga,kayu manis,ketumbar','Rendang ayam warisan daerah','https://cookpad.com/id/resep/8156415-rendang-ayam-warisan-daerah-dengan-ayam-organic',27),(6,'2021-02-12','ikan laut,daun salam,daun jeruk,lengkuas geprek,air,bumbu haus,cabe merah keriting,bawang merah,bawang putih,kunyit,kemiri,merica,ketumbar,asam jawa,gula merah,garam,jahe','ikan pindang ala daerah emak','https://cookpad.com/id/resep/6970628-ikan-pindang-ala-daerah-emak',19),(7,'2021-02-12','lontong,tahu,tauge,sambal kacang,jeruk purut,kecap,cabe rawit,air asam','lontong sambal daerah pati','https://cookpad.com/id/resep/6707066-lontong-sambal-daerah-pati',14),(8,'2021-02-12','tahu putih,telor,tauge,kol,timun,daun bawang,kerupuk,lontong,seledri,kacang goreng,cabe rawit,cabe merah,bawang putih,ebi,garam,gula merah,kaldu jamur,kecap manis,asem,air','tahu tepo khas ngawi','https://cookpad.com/id/resep/5547844-81tahu-tepo-khas-daerah-ngawi',23),(9,'2021-02-12','ikan nila,bawang putih,bawang merah,kunyit,jahe,lngkuas,batang serai,daun kincai,tomat merah,cabe merah','sambar unjeak ikan nila','https://cookpad.com/id/resep/1870590-sambal-unjeak-ikan-nila-khas-daerah-lebong-bengkulu',18),(10,'2021-02-12','singkong,gula merah,santan,garam halus','jemblem jajanan daerah sidoarja jatim','https://cookpad.com/id/resep/10314461-jemblem-jajanan-daerah-sidoarjo-jatim',13),(11,'2021-02-12','kacang tanah,cabe merah,bawang ptih,daun jeruk,kencur,gula merah,asam jawa,garam','bumbu pecel madiun','https://cookpad.com/id/resep/14671026-bumbu-pecel-madiun-termudah',17),(12,'2021-02-12','ikan kembung,bawang merah,cabai rawit,bawang putih,daun jeruk,serai,jeruk limau,minyak,kaldu bubuk & garam,tepung beras','kembung sambal matah','https://cookpad.com/id/resep/14671030-kembung-sambal-matah',18),(13,'2021-02-12','kecombrang,serai,bawang merah,cabe merah keriting,cabe rawit hijau,daun jeruk,jeruk nipis,garam,terasu,minyak','sambal matah kecombrang','https://cookpad.com/id/resep/14670637-sambal-matah-kecombrang',19),(14,'2021-02-12','kacang panjang,kol,bawang merah,bawang putih,cabe merah keriting,cabe rawit merah,kunyitm jahe,lenkuas,geprek,daun salam,daun kunyit,daun jeruk,serai,garam,kaldu,kunyit,santan','gulai ala rm kapau','https://cookpad.com/id/resep/14668450-gulai-ala-rm-kapau',20),(15,'2021-02-12','rebung,nangka,jahe,lengkuas,bawang merah,bawang putih,cabe merah,cabe rawit,kunyit,daun salam,jeruk,kunyit,sereh,asam kandis,ketumbang,garam,pemasak kambing,santan kental','gulai rebung nangka','https://cookpad.com/id/resep/14669543-gulai-rebung-nangka',19),(16,'2021-02-12','daging ayam cacah,tepung terigu,telur,garam merca,kaldu ayam,tahu putih,daun salam,daun jeruk,serai,lengkuas,gula jawa,garam,merica,kaldu ayam,santan murni,bawang merah,bawang putih,biji ketumber,kemiri','terik bola ayam dan tahu','https://cookpad.com/id/resep/14670636-terik-bola-ayam-dan-tahu',18),(17,'2021-02-12','tempe,rawit,cabe merah,baput,gula,garam,air,minyak','sambal tempe','https://cookpad.com/id/resep/14079099-sambal-tempe',13),(18,'2021-02-12','kerang dara,kelapa sangrai,santai kental,minyak,gula merah,garam,air asam,salam,daun jeruk sobek,daun kunyit sobek,sereh pukul,lengkuas,baput,bamer,ketumbar,lada,jintan,sangrai,cabe,kemiri,jahe,kunyit,bakar','rendang kerang','https://cookpad.com/id/resep/14670074-rendang-kerang',21),(19,'2021-02-12','cabe kerinting,cabe rawit setan,bawang merah,bawang putih,tomat merah,kemiri,irisan gula jawa,terasi,garam,kaldu bubuk,jaruk nipis','sambal terasi','https://cookpad.com/id/resep/14670431-sambal-terasi',25),(20,'2021-02-12','terung,kelapa parut,minyak goreng,air,bumbu,cabe merah,bawang putih,bawang merah,ebi,laos,garam gula','sambal goreng terung','https://cookpad.com/id/resep/14670146-sambal-goreng-terung',24),(21,'2021-02-12','daing ayam,sapi,es batu,putih telur,bawang merah,bawang putih,tepung tapioka,baking powder,garam,kaldu,bubuk,lada bubuk','bakso ayam mix sapi','https://cookpad.com/id/resep/14670065-bakso-ayam-mix-sapi',25),(22,'2021-02-12','ikan tongkol,bawang putih,bawang merah,cabai hijau,cabai rawit,tomat kecil,garam,gula,kaldu jamur,penyedap rasa,lada','ikan tongkol sambal ijo','https://cookpad.com/id/resep/14669460-ikan-tongkol-sambal-ijo',23),(23,'2021-02-12','cabai rawit gendut,bawang merah,minyak,garam,gula,kaldu jamur','sambal bawang','https://cookpad.com/id/resep/14669516-sambal-bawang-ala-bu-rudy',21),(24,'2021-02-12','terong ungu,garam,micin,cabe rawit,jeruk nipis','tarung babanam bacacapan','https://cookpad.com/id/resep/14465899-155-tarung-babanam-bacacapan-banjar',12);

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(200) DEFAULT NULL,
  `nama` varchar(200) DEFAULT NULL,
  `password` text,
  `level` tinyint(4) NOT NULL DEFAULT '0',
  `last_login` datetime DEFAULT NULL,
  `inactive` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `users` */

insert  into `users`(`id`,`username`,`nama`,`password`,`level`,`last_login`,`inactive`) values (1,'admin','Administrator','21232f297a57a5a743894a0e4a801fc3',1,'2017-02-22 01:49:04',0),(2,'user','User Direktur','ee11cbb19052e40b07aac0ca060c23ee',0,'2016-05-22 09:19:02',0);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
