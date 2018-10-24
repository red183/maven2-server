CREATE USER 'legal-neimenggu'@'localhost' IDENTIFIED BY 'legal-neimenggu';
GRANT ALL PRIVILEGES ON `legal-neimenggu` . * TO 'legal-neimenggu'@'localhost';
CREATE DATABASE IF NOT EXISTS `legal-neimenggu` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;