SET SESSION FOREIGN_KEY_CHECKS=0;

/* Drop Indexes */
-- DROP INDEX sys_frontend_name ON sys_frontend;
-- DROP INDEX sys_frontend_code ON sys_frontend;

/* Drop Tables */
DROP TABLE IF EXISTS sys_frontend;

/* Create Tables */
CREATE TABLE sys_frontend
(
	id varchar(64) NOT NULL,
	name varchar(100) NOT NULL,
	address varchar(50) NOT NULL COMMENT 'IP地址',
	uri_code varchar(50) NOT NULL COMMENT '监控范围',
	fs_id varchar(100) NOT NULL COMMENT '前置服务器ID',
	fs_secret varchar(200) NOT NULL COMMENT '前置服务器密钥',
	create_by varchar(64) NOT NULL,
	create_date datetime NOT NULL,
	update_by varchar(64) NOT NULL,
	update_date datetime NOT NULL,
	remarks varchar(255),
	del_flag char(1) DEFAULT '0' NOT NULL,
	PRIMARY KEY (id)
);

/* Create Indexes */
-- CREATE INDEX sys_frontend_name ON sys_frontend (name ASC);
-- CREATE INDEX sys_frontend_code ON sys_frontend (code ASC);