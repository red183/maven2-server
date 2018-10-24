-- 服务网点继承组织架构，保留主要字段，其它的不考虑纳入逻辑。
-- 主要字段包括：id,parent_id,parent_ids,name,sort,type,grade,useable,commons
DROP TABLE IF EXISTS BS_SERVICE_SITE;
CREATE TABLE BS_SERVICE_SITE
(
	id VARCHAR(64) NOT NULL COMMENT '主键',	-- 等于 SYS_OFFICE 的 ID，也等于后台用户的 COMPANY_ID
	geo_lng VARCHAR(20) COMMENT '经度',
	geo_lat VARCHAR(20) COMMENT '纬度',
	geo_address VARCHAR(100) COMMENT '地址',
	telephone VARCHAR(50) COMMENT '电话',
	hot_line VARCHAR(50) COMMENT '热线',
	web_site VARCHAR(100) COMMENT '官网',
	email_site VARCHAR(100) COMMENT '邮箱',
	PRIMARY KEY (id)
);

-- 微信用户列表 NOT NULL
DROP TABLE IF EXISTS BS_WX_OPEN;
CREATE TABLE BS_WX_OPEN
(
	id VARCHAR(64) NOT NULL COMMENT '主键',
	open_id VARCHAR(64) UNIQUE NOT NULL COMMENT '微信OPEN_ID',
	union_id VARCHAR(64) COMMENT '微信UNION_ID',
	nick_name VARCHAR(50) NOT NULL COMMENT '昵称',
	head_url VARCHAR(255) COMMENT '头像',
	sex VARCHAR(5) COMMENT '性别，以微信提供的值为准',
	create_by varchar(64),
	create_date datetime NOT NULL,
	update_by varchar(64),
	update_date datetime NOT NULL,
	remarks varchar(255),
	del_flag char(1) DEFAULT '0' NOT NULL,
	PRIMARY KEY (id)
);

-- 地址管理 NOT NULL
DROP TABLE IF EXISTS BS_USER_CONTACT;
CREATE TABLE BS_USER_CONTACT
(
	id VARCHAR(64) NOT NULL COMMENT '主键',
	geo_lng VARCHAR(20) COMMENT '经度',
	geo_lat VARCHAR(20) COMMENT '纬度',
	geo_address VARCHAR(100) NOT NULL COMMENT '联系地址',
	telephone VARCHAR(50) NOT NULL COMMENT '联系电话',
	contact_name VARCHAR(20) NOT NULL COMMENT '姓名',
	unit_name VARCHAR(100) NOT NULL COMMENT '单位名称',
	create_by varchar(64),
	create_date datetime NOT NULL,
	update_by varchar(64),
	update_date datetime NOT NULL,
	remarks varchar(255),
	del_flag char(1) DEFAULT '0' NOT NULL,
	PRIMARY KEY (id)
);

-- 企业管理
DROP TABLE IF EXISTS BS_COMPANY;
CREATE TABLE BS_COMPANY
(
	id VARCHAR(64) NOT NULL COMMENT '主键',
	no VARCHAR(64) UNIQUE NOT NULL COMMENT '编号',
	title VARCHAR(64) NOT NULL COMMENT '名称',
	address VARCHAR(200) NOT NULL COMMENT '地址',
	create_by varchar(64) NOT NULL COMMENT '创建人',
	create_date datetime NOT NULL COMMENT '创建日期',
	update_by varchar(64) NOT NULL COMMENT '更新人',
	update_date datetime NOT NULL COMMENT '更新日期',
	remarks varchar(255) COMMENT '备注',
	del_flag char(1) DEFAULT '0' NOT NULL COMMENT '删除标志',
	PRIMARY KEY (id)
);

-- 设备信息管理
DROP TABLE IF EXISTS BS_DEVICE;
CREATE TABLE BS_DEVICE
(
	id VARCHAR(64) NOT NULL COMMENT '主键',
	no VARCHAR(64) UNIQUE NOT NULL COMMENT '编号',
	title VARCHAR(64) NOT NULL COMMENT '名称',
	brand VARCHAR(64) NOT NULL COMMENT '品牌',
	unit VARCHAR(20) COMMENT '单位',
	model VARCHAR(20) COMMENT '型号规格',
	num INT COMMENT '数量',
	purchase_date datetime NOT NULL COMMENT '购买日期',
	create_by varchar(64) NOT NULL COMMENT '创建人',
	create_date datetime NOT NULL COMMENT '创建日期',
	update_by varchar(64) NOT NULL COMMENT '更新人',
	update_date datetime NOT NULL COMMENT '更新日期',
	remarks varchar(255) COMMENT '备注',
	del_flag char(1) DEFAULT '0' NOT NULL COMMENT '删除标志',
	PRIMARY KEY (id)
);

-- 项目信息管理
DROP TABLE IF EXISTS BS_PROJECT;
CREATE TABLE BS_PROJECT
(
	id VARCHAR(64) NOT NULL COMMENT '主键',
	no VARCHAR(64) UNIQUE NOT NULL COMMENT '编号',
	title VARCHAR(64) NOT NULL COMMENT '名称',
	company_id VARCHAR(64) NOT NULL COMMENT '企业ID',
	contract_price BIGINT NOT NULL COMMENT '合同价格',
	contract_sign_date datetime NOT NULL COMMENT '合同签订日期',
	contract_check_date datetime NOT NULL COMMENT '合同验收日期',
	contract_service_date datetime NOT NULL COMMENT '合同售后期限',
	contract_official_name VARCHAR(20) NOT NULL COMMENT '负责人',
	contract_official_telephone VARCHAR(20) NOT NULL COMMENT '联系电话',
	belong_category VARCHAR(50) NOT NULL COMMENT '所属领域',
	belong_nature VARCHAR(50) NOT NULL COMMENT '所属性质',
	belong_province_id VARCHAR(64) NOT NULL COMMENT '所属地区-省、直辖市',
	belong_city_id VARCHAR(64) NOT NULL COMMENT '所属性质-市',
	belong_county_id VARCHAR(64) NOT NULL COMMENT '所属性质-区、县',
	belong_address VARCHAR(200) NOT NULL COMMENT '详细地址',
	perf_cash BIGINT NOT NULL COMMENT '履约保证金',
	content varchar(255) NOT NULL COMMENT '项目内容',
	usable CHAR(1) NOT NULL DEFAULT '0' COMMENT '是否可用，1是0否',
	create_by varchar(64) NOT NULL COMMENT '创建人',
	create_date datetime NOT NULL COMMENT '创建日期',
	update_by varchar(64) NOT NULL COMMENT '更新人',
	update_date datetime NOT NULL COMMENT '更新日期',
	remarks varchar(255) COMMENT '备注',
	del_flag char(1) DEFAULT '0' NOT NULL COMMENT '删除标志',
	PRIMARY KEY (id)
);

-- 项目与设备关联表
DROP TABLE IF EXISTS BS_PROJECT_DEVICE;
CREATE TABLE BS_PROJECT_DEVICE
(
	id VARCHAR(64) NOT NULL COMMENT '主键',
	project_id VARCHAR(64) NOT NULL COMMENT '项目ID',
	device_id VARCHAR(64) NOT NULL COMMENT '设备ID',
	PRIMARY KEY (id)
);

-- 项目与附件关联表
DROP TABLE IF EXISTS BS_PROJECT_ATTACHMENT;
CREATE TABLE BS_PROJECT_ATTACHMENT
(
	id VARCHAR(64) NOT NULL COMMENT '主键',
	project_id VARCHAR(64) NOT NULL COMMENT '项目ID',
	file_id VARCHAR(64) NOT NULL COMMENT '附件ID',
	PRIMARY KEY (id)
);

-- 自助报修
DROP TABLE IF EXISTS BS_ACT_SELF_REPAIR;
CREATE TABLE BS_ACT_SELF_REPAIR
(
	id VARCHAR(64) NOT NULL COMMENT '主键',
	project_id VARCHAR(64) COMMENT '项目ID',
	leader_id VARCHAR(64) COMMENT '主要维修员ID',
	service_type VARCHAR(64) COMMENT '服务类型',
	service_mode VARCHAR(64) COMMENT '服务方式',
	contact_id VARCHAR(64) NOT NULL COMMENT '地址管理ID',
	cause VARCHAR(500) NOT NULL COMMENT '报修原因',
	sche_arrive_date datetime COMMENT '预计到达日期',
	sche_complete_date datetime COMMENT '预计完成日期',
	real_take_date datetime COMMENT '实际领取时间',
	real_arrive_date datetime COMMENT '实际到达时间',
	real_complete_date datetime COMMENT '实际完成时间',
	service_status VARCHAR(20) COMMENT '服务状态',
	dispatch_status VARCHAR(1) COMMENT '派修状态：1有效，0无效',
	dispatch_by varchar(64) COMMENT '派修人',
	dispatch_date datetime COMMENT '派修日期',
	complete_status VARCHAR(1) COMMENT '完成任务：1已完成，0未完成',
	complete_memo VARCHAR(500) COMMENT '完成任务状态0时的备注',
	archive_by varchar(64) COMMENT '归档人',
	archive_date datetime COMMENT '归档日期',
	archive_memo VARCHAR(500) COMMENT '归档状态时的备注',
	create_by varchar(64) NOT NULL COMMENT '创建人',
	create_date datetime NOT NULL COMMENT '创建日期',
	update_by varchar(64) NOT NULL COMMENT '最后更新人',
	update_date datetime NOT NULL COMMENT '最后更新日期',
	remarks varchar(255) COMMENT '备注',
	del_flag char(1) DEFAULT '0' NOT NULL COMMENT '删除标志',
	PRIMARY KEY (id)
);

DROP TABLE IF EXISTS BS_ACT_SELF_REPAIR_ATTACHMENT;
CREATE TABLE BS_ACT_SELF_REPAIR_ATTACHMENT
(
	id VARCHAR(64) NOT NULL COMMENT '主键',
	repair_id VARCHAR(64) NOT NULL COMMENT '自助报修ID',
	file_id VARCHAR(64) NOT NULL COMMENT '附件ID',
	PRIMARY KEY (id)
);

DROP TABLE IF EXISTS BS_ACT_SELF_REPAIR_ENGINEER;
DROP TABLE IF EXISTS BS_ACT_SELF_REPAIR_ENGINEER;
CREATE TABLE BS_ACT_SELF_REPAIR_ENGINEER
(
	id VARCHAR(64) NOT NULL COMMENT '主键',
	repair_id VARCHAR(64) NOT NULL COMMENT '自助报修ID',
	user_id VARCHAR(64) NOT NULL COMMENT '用户ID',
	PRIMARY KEY (id)
);

DROP TABLE IF EXISTS BS_ACT_SELF_REPAIR_DEVICE;
CREATE TABLE BS_ACT_SELF_REPAIR_DEVICE
(
	id VARCHAR(64) NOT NULL COMMENT '主键',
	repair_id VARCHAR(64) NOT NULL COMMENT '自助报修ID',
	device_id VARCHAR(64) NOT NULL COMMENT '设备ID',
	PRIMARY KEY (id)
);

-- 报修评价
DROP TABLE IF EXISTS BS_SALES_COMMENT;
CREATE TABLE BS_SALES_COMMENT
(
	id VARCHAR(64) NOT NULL COMMENT '主键',
	repair_id VARCHAR(64) NOT NULL COMMENT '自助报修ID',
	grade int NOT NULL COMMENT '评价等级',
	good_impression VARCHAR(30)  NULL COMMENT '评价印象/(字典表配置):专业，耐心',
  bad_impression VARCHAR(30)  NULL COMMENT '评价印象/(字典表配置):效率低，粗心',
	`desc`  VARCHAR(255)  NULL COMMENT '评价文本描述',
	create_by varchar(64) NOT NULL COMMENT '创建人/评价人',
	create_date datetime NOT NULL COMMENT '创建日期',
	update_by varchar(64) NOT NULL COMMENT '最后更新人',
	update_date datetime NOT NULL COMMENT '最后更新日期',
	remarks varchar(255) COMMENT '备注',
	del_flag char(1) DEFAULT '0' NOT NULL COMMENT '删除标志',
	PRIMARY KEY (id)
);
