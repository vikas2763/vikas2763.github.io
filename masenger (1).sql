-- phpMyAdmin SQL Dump
-- version 4.0.10.20
-- https://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Oct 23, 2017 at 04:11 PM
-- Server version: 5.6.37
-- PHP Version: 5.6.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `masenger`
--

-- --------------------------------------------------------

--
-- Table structure for table `group`
--

CREATE TABLE IF NOT EXISTS `group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(500) NOT NULL,
  `group_pick` varchar(1000) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `group_users`
--

CREATE TABLE IF NOT EXISTS `group_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `Isadmin` tinyint(1) NOT NULL,
  `isActive` tinyint(1) NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `group_id` (`group_id`,`user_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `message`
--

CREATE TABLE IF NOT EXISTS `message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `creator_id` int(11) NOT NULL,
  `subject` varchar(500) NOT NULL,
  `parent_message_id` int(11) NOT NULL,
  `message_body` text NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`,`parent_message_id`),
  KEY `parent_message_id` (`parent_message_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `message_recipient`
--

CREATE TABLE IF NOT EXISTS `message_recipient` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `recipient_id` int(11) NOT NULL,
  `senderId` int(11) NOT NULL,
  `recipient_group_id` int(11) NOT NULL,
  `messageID` int(11) NOT NULL,
  `isRead` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `recipient_id` (`recipient_id`,`messageID`,`recipient_group_id`),
  KEY `messageID` (`messageID`),
  KEY `recipient_group_id` (`recipient_group_id`),
  KEY `senderId` (`senderId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `Email` varchar(500) NOT NULL,
  `password` varchar(500) NOT NULL,
  `name` text NOT NULL,
  `devicetoken` varchar(500) NOT NULL,
  `device` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Email` (`Email`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=10 ;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `Email`, `password`, `name`, `devicetoken`, `device`) VALUES
(1, 'codingbrains11@gmailo.com', '123456', 'vikas shukla', 'mnbmnbmnb6uy567u5v675675b675 7tug ujhg7 i', 'android'),
(2, 'test@gmail.com', 'scvsdfsd', 'fdsffds', 'fgfdghfhgfhj', 'mkhjjjhkjhk'),
(4, 'codingbrains121@gmailo.com', '123456', 'shukla', 'mnbmnbmnb6uy567u5v675675b675 7tug ujhg7 i', 'android'),
(5, 'test1@gmail.com', 'scvsdfsd', 'fdsffds', 'fgfdghfhgfhj', 'mkhjjjhkjhk'),
(6, 'raghu1@gmail.com', 'scvsdfsd', 'fdsffds', 'fgfdghfhgfhj', 'mkhjjjhkjhk'),
(7, 'vikas@gmail.com', 'scvsdfsd', 'fdsffds', 'fgfdghfhgfhj', 'mkhjjjhkjhk'),
(8, 'deepak@gmail.com', 'scvsdfsd', 'fdsffds', 'fgfdghfhgfhj', 'mkhjjjhkjhk'),
(9, 'shubh@gmail.com', 'scvsdfsd', 'fdsffds', 'fgfdghfhgfhj', 'mkhjjjhkjhk');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `group_users`
--
ALTER TABLE `group_users`
  ADD CONSTRAINT `groupId` FOREIGN KEY (`group_id`) REFERENCES `group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `userid_frk` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `message`
--
ALTER TABLE `message`
  ADD CONSTRAINT `parentid` FOREIGN KEY (`parent_message_id`) REFERENCES `message` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `userid` FOREIGN KEY (`creator_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `message_recipient`
--
ALTER TABLE `message_recipient`
  ADD CONSTRAINT `group_frk` FOREIGN KEY (`recipient_group_id`) REFERENCES `group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `msg_id` FOREIGN KEY (`messageID`) REFERENCES `message` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `usr_frk` FOREIGN KEY (`recipient_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
