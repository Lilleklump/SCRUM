-- phpMyAdmin SQL Dump
-- version 3.5.7
-- http://www.phpmyadmin.net
--
-- Värd: localhost
-- Skapad: 19 dec 2013 kl 23:25
-- Serverversion: 5.5.29
-- PHP-version: 5.4.10

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Databas: `scrum`
--

-- --------------------------------------------------------

--
-- Tabellstruktur `tbl_attendandant`
--

CREATE TABLE `tbl_attendandant` (
  `attendant_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL DEFAULT '0' COMMENT '0 om elev går program. elev måste ha kurs ELLER program, ej båda',
  `program_id` int(11) NOT NULL DEFAULT '0' COMMENT '0 om elev går fristående kurs. elev måste ha kurs ELLER program, ej båda',
  PRIMARY KEY (`attendant_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Dumpning av Data i tabell `tbl_attendandant`
--

INSERT INTO `tbl_attendandant` (`attendant_id`, `user_id`, `course_id`, `program_id`) VALUES
(1, 3, 0, 1),
(2, 4, 0, 1),
(3, 5, 0, 2),
(4, 6, 0, 2),
(5, 7, 5, 0);

-- --------------------------------------------------------

--
-- Tabellstruktur `tbl_booking`
--

CREATE TABLE `tbl_booking` (
  `booking_id` int(11) NOT NULL AUTO_INCREMENT,
  `booking_starttime` datetime NOT NULL COMMENT 'tid på dagen (t.ex. 0000-00-00 09:00)',
  `booking_endtime` datetime NOT NULL COMMENT 'tid på dagen (t.ex. 0000-00-00 12:00)',
  `booking_startdate` datetime NOT NULL COMMENT 'datum (t.ex. 2013-01-01 00:00)',
  `booking_enddate` datetime NOT NULL COMMENT 'datum (t.ex. 2013-06-30 00:00)',
  `course_id` int(11) NOT NULL,
  `classroom_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL COMMENT 'person som gjorde bokningen',
  PRIMARY KEY (`booking_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumpning av Data i tabell `tbl_booking`
--

INSERT INTO `tbl_booking` (`booking_id`, `booking_starttime`, `booking_endtime`, `booking_startdate`, `booking_enddate`, `course_id`, `classroom_id`, `user_id`) VALUES
(1, '0000-00-00 09:00:00', '0000-00-00 12:00:00', '2013-11-26 00:00:00', '2014-03-26 00:00:00', 1, 3, 1),
(2, '0000-00-00 09:00:00', '0000-00-00 16:00:00', '2014-01-01 00:00:00', '2014-06-30 00:00:00', 3, 1, 2),
(3, '0000-00-00 13:00:00', '0000-00-00 16:00:00', '2013-11-26 00:00:00', '2014-03-26 00:00:00', 5, 3, 1);

-- --------------------------------------------------------

--
-- Tabellstruktur `tbl_classroom`
--

CREATE TABLE `tbl_classroom` (
  `classroom_id` int(11) NOT NULL AUTO_INCREMENT,
  `classroom_name` varchar(255) NOT NULL,
  `classroom_type` int(11) NOT NULL,
  `classroom_numberofseats` int(11) NOT NULL,
  `classroom_equipment` varchar(255) NOT NULL,
  PRIMARY KEY (`classroom_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumpning av Data i tabell `tbl_classroom`
--

INSERT INTO `tbl_classroom` (`classroom_id`, `classroom_name`, `classroom_type`, `classroom_numberofseats`, `classroom_equipment`) VALUES
(1, 'Sal 1', 1, 25, 'Whiteboard, projektor'),
(2, 'Sal 2', 1, 30, 'Whiteboard, projektor'),
(3, 'Datasal 1', 2, 20, 'Projektor, stationära datorer'),
(4, 'Grupprum 1', 3, 10, 'Whiteboard');

-- --------------------------------------------------------

--
-- Tabellstruktur `tbl_classroomtype`
--

CREATE TABLE `tbl_classroomtype` (
  `classroomtype_id` int(11) NOT NULL AUTO_INCREMENT,
  `classroomtype_name` varchar(255) NOT NULL,
  PRIMARY KEY (`classroomtype_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumpning av Data i tabell `tbl_classroomtype`
--

INSERT INTO `tbl_classroomtype` (`classroomtype_id`, `classroomtype_name`) VALUES
(1, 'Lektionssal'),
(2, 'Datorsal'),
(3, 'Grupprum');

-- --------------------------------------------------------

--
-- Tabellstruktur `tbl_computerloan`
--

CREATE TABLE `tbl_computerloan` (
  `computerloan_id` int(11) NOT NULL AUTO_INCREMENT,
  `computerloan_serialnumber` varchar(255) NOT NULL,
  `computerloan_available` tinyint(1) NOT NULL,
  `computerloan_loandate` datetime NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`computerloan_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumpning av Data i tabell `tbl_computerloan`
--

INSERT INTO `tbl_computerloan` (`computerloan_id`, `computerloan_serialnumber`, `computerloan_available`, `computerloan_loandate`, `user_id`) VALUES
(1, 'ASDF1234GHG', 1, '0000-00-00 00:00:00', 0),
(2, 'JHGFi456oFG3', 0, '2013-11-20 00:00:00', 3);

-- --------------------------------------------------------

--
-- Tabellstruktur `tbl_course`
--

CREATE TABLE `tbl_course` (
  `course_id` int(11) NOT NULL AUTO_INCREMENT,
  `course_name` varchar(255) NOT NULL,
  `course_startdate` datetime NOT NULL,
  `course_enddate` datetime NOT NULL,
  `program_id` int(11) NOT NULL,
  PRIMARY KEY (`course_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Dumpning av Data i tabell `tbl_course`
--

INSERT INTO `tbl_course` (`course_id`, `course_name`, `course_startdate`, `course_enddate`, `program_id`) VALUES
(1, 'Testkurs 1', '2013-11-26 00:00:00', '2014-03-26 00:00:00', 1),
(2, 'Testkurs 2', '2014-03-30 00:00:00', '2014-06-26 00:00:00', 1),
(3, 'Testkurs 3', '2014-01-01 00:00:00', '2014-06-30 00:00:00', 2),
(4, 'Testkurs 4', '2014-07-01 00:00:00', '2014-12-31 00:00:00', 2),
(5, 'Fristående kurs 1', '2013-11-01 00:00:00', '2013-11-30 00:00:00', 0);

-- --------------------------------------------------------

--
-- Tabellstruktur `tbl_grade`
--

CREATE TABLE `tbl_grade` (
  `grade_id` int(11) NOT NULL AUTO_INCREMENT,
  `grade_grade` varchar(100) NOT NULL,
  `grade_comment` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL COMMENT 'elev som betyget är ägnat till',
  `course_id` int(11) NOT NULL COMMENT 'kurs som betyget är ägnat till',
  PRIMARY KEY (`grade_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

--
-- Dumpning av Data i tabell `tbl_grade`
--

INSERT INTO `tbl_grade` (`grade_id`, `grade_grade`, `grade_comment`, `user_id`, `course_id`) VALUES
(1, 'G', 'Blablabla gränsfall men klarade G', 6, 1),
(2, 'VG', 'Blablabla jobbat bra ', 7, 3),
(3, 'VG', 'Ett test betyg', 3, 3),
(8, 'IG', 'Inte bra bosse.', 4, 3);

-- --------------------------------------------------------

--
-- Tabellstruktur `tbl_lia`
--

CREATE TABLE `tbl_lia` (
  `lia_id` int(11) NOT NULL AUTO_INCREMENT,
  `lia_startdate` datetime NOT NULL,
  `lia_stopdate` datetime NOT NULL,
  `lia_comment` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`lia_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumpning av Data i tabell `tbl_lia`
--

INSERT INTO `tbl_lia` (`lia_id`, `lia_startdate`, `lia_stopdate`, `lia_comment`, `user_id`) VALUES
(1, '2014-01-22 00:00:00', '2014-04-22 00:00:00', 'Hos företag Testson & Co. AB', 4),
(2, '2014-02-20 00:00:00', '2014-05-22 00:00:00', 'Hos företag Coolface AB', 5);

-- --------------------------------------------------------

--
-- Tabellstruktur `tbl_news`
--

CREATE TABLE `tbl_news` (
  `news_id` int(11) NOT NULL AUTO_INCREMENT,
  `news_title` varchar(255) NOT NULL,
  `news_content` text NOT NULL,
  `news_date` varchar(255) NOT NULL,
  `news_author` int(11) NOT NULL,
  PRIMARY KEY (`news_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

--
-- Dumpning av Data i tabell `tbl_news`
--

INSERT INTO `tbl_news` (`news_id`, `news_title`, `news_content`, `news_date`, `news_author`) VALUES
(3, 'Nyhet1', 'Bacon ipsum dolor sit amet kielbasa hamburger cow pork. Cow ham jowl kevin swine. Doner filet mignon tail pork belly sausage beef ribs spare ribs shankle brisket sirloin pastrami kevin cow kielbasa jerky. Beef ribs cow spare ribs, t-bone andouille ground round prosciutto swine sausage. Swine meatball pastrami, beef tenderloin ham hock shank shankle rump strip steak beef ribs turducken fatback hamburger ribeye. Ham bresaola shoulder pork chop, sausage meatball pork rump spare ribs cow bacon filet mignon. Prosciutto pastrami pork loin, kevin kielbasa swine rump spare ribs beef ribs strip steak pork chop pork frankfurter sausage ground round.', '10:42 - 27/07/2013', 2);

-- --------------------------------------------------------

--
-- Tabellstruktur `tbl_program`
--

CREATE TABLE `tbl_program` (
  `program_id` int(11) NOT NULL AUTO_INCREMENT,
  `program_name` varchar(255) NOT NULL,
  `program_startdate` datetime NOT NULL,
  `program_enddate` datetime NOT NULL,
  PRIMARY KEY (`program_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumpning av Data i tabell `tbl_program`
--

INSERT INTO `tbl_program` (`program_id`, `program_name`, `program_startdate`, `program_enddate`) VALUES
(1, 'Testprogram 1', '2013-11-26 00:00:00', '2014-08-27 00:00:00'),
(2, 'Testprogram 2', '2014-01-01 00:00:00', '2014-12-18 00:00:00');

-- --------------------------------------------------------

--
-- Tabellstruktur `tbl_user`
--

CREATE TABLE `tbl_user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_firstname` varchar(255) NOT NULL,
  `user_lastname` varchar(255) NOT NULL,
  `user_email` varchar(255) NOT NULL,
  `user_phonenumber` varchar(255) NOT NULL,
  `user_username` varchar(255) NOT NULL,
  `user_password` varchar(255) NOT NULL,
  `user_lastlogin` datetime NOT NULL,
  `usertype_id` int(11) NOT NULL,
  `user_program` int(11) NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=13 ;

--
-- Dumpning av Data i tabell `tbl_user`
--

INSERT INTO `tbl_user` (`user_id`, `user_firstname`, `user_lastname`, `user_email`, `user_phonenumber`, `user_username`, `user_password`, `user_lastlogin`, `usertype_id`, `user_program`) VALUES
(1, 'Samuel', 'Johansson', 'test@test.se', '070123123', 'samuel', 'samuel', '2013-12-18 21:49:51', 2, 1),
(2, 'Robert', 'Karlsson', 'test@test.se', '070321321', 'robert', 'robert', '0000-00-00 00:00:00', 2, 1),
(3, 'Pelle', 'Pellsson', 'test@test.se', '070111111', 'ppp', 'ppp', '2013-12-19 23:22:55', 1, 2),
(4, 'Bosse', 'Boss', 'test@test.se', '070111111', 'bbb', 'bbb', '0000-00-00 00:00:00', 1, 1),
(5, 'Mia', 'Yoo', 'test@test.se', '070111111', 'mmm', 'mmm', '0000-00-00 00:00:00', 1, 1),
(6, 'Frida', 'Falkman', 'test@test.se', '070111111', 'fff', 'fff', '0000-00-00 00:00:00', 1, 2),
(7, 'Woody', 'Wood', 'test@test.se', '070111111', 'www', 'www', '0000-00-00 00:00:00', 1, 2),
(8, 'Elin', 'Testsson', 'test@test.se', '070888888', 'eee', 'eee', '2013-12-18 21:51:30', 3, 2),
(9, 'Jens', 'Jensen', 'test@test.se', '070999999', 'jjj', 'jjj', '0000-00-00 00:00:00', 4, 2);

-- --------------------------------------------------------

--
-- Tabellstruktur `tbl_usertype`
--

CREATE TABLE `tbl_usertype` (
  `usertype_id` int(11) NOT NULL AUTO_INCREMENT,
  `usertype_name` varchar(255) NOT NULL,
  `usertype_rights` int(11) NOT NULL COMMENT 'avgör vad användaren ska kunna göra i systemet',
  PRIMARY KEY (`usertype_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumpning av Data i tabell `tbl_usertype`
--

INSERT INTO `tbl_usertype` (`usertype_id`, `usertype_name`, `usertype_rights`) VALUES
(1, 'Elev', 1),
(2, 'Lärare', 2),
(3, 'Utbildningsledare', 4),
(4, 'Administratör', 16);
