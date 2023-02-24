/*admin table */ 
CREATE TABLE admin (
    admin_id BIGINT IDENTITY(1,1) PRIMARY KEY NOT NULL CONSTRAINT check_negative CHECK (admin_id > 0),
    first_name VARCHAR(16)  DEFAULT NULL,
    last_name VARCHAR(16)  DEFAULT NULL,
    email VARCHAR(128) NOT NULL,
	password VARCHAR(255) NOT NULL,
    created_at DATETIME  NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT NULL,
    deleted_at DATETIME DEFAULT NULL 
);


--Country table 
CREATE TABLE country  (
	country_id BIGINT IDENTITY(1,1) PRIMARY KEY CHECK(country_id > 0) NOT NULL,
	name varchar(255) NOT NULL ,
	ISO varchar(16),
	created_at DATETIME  NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT NULL,
    deleted_at DATETIME DEFAULT NULL 
);
-- City table /
CREATE TABLE city (
	city_id bigint NOT NULL IDENTITY(1,1) CHECK(city_id>0) PRIMARY KEY,
	country_id bigint NOT NULL FOREIGN KEY (country_id) REFERENCES Country(country_id),
	name varchar(255) NOT NULL ,
	created_at DATETIME  NOT NULL DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT NULL,
	deleted_at DATETIME DEFAULT NULL 
);

--banner table /
CREATE TABLE banner (
	banner_id bigint NOT NULL IDENTITY(1,1) PRIMARY KEY,
	image varchar(512) NOT NULL ,
	[text] text ,
	sort_order INT,
	created_at DATETIME  NOT NULL DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT NULL,
	deleted_at DATETIME DEFAULT NULL 
);

--user table /
CREATE TABLE [user](
	[user_id] bigint NOT NULL IDENTITY(1,1) PRIMARY KEY,
	first_name varchar(16) DEFAULT NULL,
	last_name varchar(16) DEFAULT NULL,
	email varchar(128) NOT NULL,
	password varchar(255) NOT NULL,
	phone_number int NOT NULL ,
	avatar varchar(2048) DEFAULT NULL,
	why_i_volunteer text DEFAULT NULL,
	employee_id varchar(16) DEFAULT NULL,
	department varchar(16) DEFAULT Null,
	city_id bigint NOT NULL FOREIGN KEY(city_id) REFERENCES City(city_id),
	country_id bigint NOT NULL FOREIGN KEY (country_id) REFERENCES Country(country_id),
	profile_text text DEFAULT NULL,
	linked_in_url varchar(255) DEFAULT NULL,
	title varchar(255) DEFAULT NULL,
	status varchar(2) NOT NULL CHECK(status IN('0','1')) DEFAULT '1',  
	created_at DATETIME  NOT NULL DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT NULL,
	deleted_at DATETIME DEFAULT NULL
);

-- story-invite table /
create table story_invite (
	story_invite_id bigint NOT NULL IDENTITY(1,1) PRIMARY KEY,
	story_id bigint NOT NULL CHECK(story_id>0),
	from_user_id bigint NOT NULL CHECK(from_user_id>0),
	to_user_id bigint NOT NULL CHECK(to_user_id>0),
	created_at DATETIME  NOT NULL DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT NULL,
	deleted_at DATETIME DEFAULT NULL
);

/* Skill table*/
create table skill(
	skill_id int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	skill_name varchar(64),
	status tinyint NOT NULL DEFAULT 1,
	created_at DATETIME  NOT NULL DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT NULL,
	deleted_at DATETIME DEFAULT NULL
);

/* password_reset table*/
create table password_reset(
	email varchar(191) NOT NULL,
	token varchar(191) NOT NULL,
	created_at DATETIME  NOT NULL DEFAULT CURRENT_TIMESTAMP
);

/*mission_theme table */
create table mission_theme (
	mission_theme_id bigint NOT NULL IDENTITY(1,1) PRIMARY KEY,
	title varchar(255) ,
	status tinyint NOT NULL DEFAULT 1,
	created_at DATETIME  NOT NULL DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT NULL,
	deleted_at DATETIME DEFAULT NULL
);

--mission table--

create table mission(
mission_id bigint not null identity(1,1) primary key ,
theme_id bigint NOT NULL FOREIGN KEY (theme_id) REFERENCES mission_theme(mission_theme_id),
city_id bigint NOT NULL FOREIGN KEY (city_id) REFERENCES City(city_id),
country_id bigint NOT NULL FOREIGN KEY (country_id) REFERENCES Country(country_id),
title	varchar(128) not null ,
short_description	text,			
[description]	text  default Null,
start_date	datetime default Null , 
end_date	datetime default Null,
mission_type varchar(20) not null CHECK(mission_type IN('TIME', 'GO' )) ,
status varchar(4) not null CHECK(status IN(0 , 1 )) ,
organization_name	varchar(255) default null,
organization_detail	text default null,
[availability] varchar(20)  null CHECK([availability] IN('daily', 'weekly' , 'week-end' , 'monthly' )) ,
created_at DATETIME  NOT NULL DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT NULL,
deleted_at DATETIME DEFAULT NULL
)


--comment table 
CREATE TABLE comment (
	comment_id bigint NOT NULL IDENTITY(1,1) PRIMARY KEY,
	[user_id] bigint not null FOREIGN KEY ([user_id]) REFERENCES [user]([user_id]),
	mission_id bigint NOT NULL FOREIGN KEY (mission_id) REFERENCES mission(mission_id),
	approval_status	varchar(20) not null CHECK(approval_status in('PENDING',  'PUBLISHED')) default 'PENDING',	
	created_at DATETIME  NOT NULL DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT NULL,
	deleted_at DATETIME DEFAULT NULL 
);

--CMS PAGE TABLE--

create table cms_page(
cms_page_id bigint not null identity(1,1) primary key ,
title varchar(255),
[description]	text ,		
slug	varchar(255) not null ,
status varchar(4) not null CHECK(status IN(0 , 1 )) default 1 ,
created_at DATETIME  NOT NULL DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT NULL,
deleted_at DATETIME DEFAULT NULL 
)

--favorite mission table --

create table favorite_mission(
favorite_mission_id bigint not null identity(1,1) primary key ,
[user_id] bigint not null FOREIGN KEY ([user_id]) REFERENCES [user]([user_id]),
mission_id bigint NOT NULL FOREIGN KEY (mission_id) REFERENCES mission(mission_id),
created_at DATETIME  NOT NULL DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT NULL,
deleted_at DATETIME DEFAULT NULL 
)

--goal mission table--

create table goal_mission(
goal_mission_id	bigint not null identity(1,1) primary key ,
mission_id bigint NOT NULL FOREIGN KEY (mission_id) REFERENCES mission(mission_id),
goal_objective_text varchar(255) null default null,
goal_value int not null ,
created_at DATETIME  NOT NULL DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT NULL,
deleted_at DATETIME DEFAULT NULL 
)

--mission application table--

create table mission_application(
mission_application_id	bigint not null identity(1,1) primary key ,
[user_id] bigint not null FOREIGN KEY ([user_id]) REFERENCES [user]([user_id]),
mission_id bigint NOT NULL FOREIGN KEY (mission_id) REFERENCES mission(mission_id),
applied_at datetime not null,
approval_status	varchar(20) not null CHECK(approval_status in('PENDING',  'APPROVE', 'DECLINE' )) default 'PENDING',	
created_at DATETIME  NOT NULL DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT NULL,
deleted_at DATETIME DEFAULT NULL 
)

--mission document table--

create table mission_document(
mission_document_id	bigint not null identity(1,1) primary key ,
mission_id bigint NOT NULL FOREIGN KEY (mission_id) REFERENCES mission(mission_id),
document_name varchar(255),
document_type varchar(255),
document_path varchar(255) null,
created_at DATETIME  NOT NULL DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT NULL,
deleted_at DATETIME DEFAULT NULL 
)

--mission invite table--

create table mission_invite(
mission_invite_id bigint not null identity(1,1) primary key ,
mission_id bigint NOT NULL FOREIGN KEY (mission_id) REFERENCES mission(mission_id),
from_user_id bigint NOT NULL FOREIGN KEY (from_user_id) REFERENCES [user]([user_id]),
to_user_id bigint NOT NULL FOREIGN KEY (to_user_id) REFERENCES [user]([user_id]),
created_at DATETIME  NOT NULL DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT NULL,
deleted_at DATETIME DEFAULT NULL 
)

--missionn media table--

create table mission_media(
mission_media_id bigint not null identity(1,1) primary key ,
mission_id bigint NOT NULL FOREIGN KEY (mission_id) REFERENCES mission(mission_id),
media_name varchar(64),
media_type varchar(4),
media_path varchar(255) null,
[default] varchar(4) not null CHECK([default] IN(0 , 1 )) default 0 ,
created_at DATETIME  NOT NULL DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT NULL,
deleted_at DATETIME DEFAULT NULL 
)

--mission rating table--

create table mission_rating(
mission_rating_id bigint not null identity(1,1) primary key ,
[user_id] bigint not null FOREIGN KEY ([user_id]) REFERENCES [user]([user_id]),
mission_id bigint NOT NULL FOREIGN KEY (mission_id) REFERENCES mission(mission_id),
rating varchar(4) not null CHECK(rating IN(0 , 1, 2 , 3 , 4 , 5  ))  ,
created_at DATETIME  NOT NULL DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT NULL,
deleted_at DATETIME DEFAULT NULL 
)

--mission skill table--

create table mission_skill(
mission_skill_id bigint not null identity(1,1) primary key ,
skill_id int NOT NULL FOREIGN KEY (skill_id) REFERENCES skill(skill_id),
mission_id bigint NOT NULL FOREIGN KEY (mission_id) REFERENCES mission(mission_id),
created_at DATETIME  NOT NULL DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT NULL,
deleted_at DATETIME DEFAULT NULL 
)

--story table--

create table story(
story_id bigint not null identity(1,1) primary key ,
[user_id] bigint not null FOREIGN KEY ([user_id]) REFERENCES [user]([user_id]),
mission_id bigint NOT NULL FOREIGN KEY (mission_id) REFERENCES mission(mission_id),
title varchar(255) default null,
description	text default null,
[status]	varchar(20) not null CHECK([status]in( 'DRAFT' , 'PENDING',  'PUBLISHED', 'DECLINED' )) default 'DRAFT',	
published_at DATETIME   default null ,
created_at DATETIME  NOT NULL DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT NULL,
deleted_at DATETIME DEFAULT NULL 
)

--story media table--

create table story_media(
story_media_id bigint not null identity(1,1) primary key ,
story_id bigint NOT NULL FOREIGN KEY (story_id) REFERENCES story(story_id),
type varchar(8) not null,
path text not null,
created_at DATETIME  NOT NULL DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT NULL,
deleted_at DATETIME DEFAULT NULL 
)

--timesheet table--

create table timesheet(
timesheet_id bigint not null identity(1,1) primary key ,
[user_id] bigint  null FOREIGN KEY ([user_id]) REFERENCES [user]([user_id]),
mission_id bigint NULL FOREIGN KEY (mission_id) REFERENCES mission(mission_id),
time time null,
action int null,
date_volunteered datetime not null ,
notes text null,
[status]	varchar(20) not null CHECK([status]in( 'APPROVED' , 'DECLINED',  'SUBMIT_FOR_APPROVAL' )) default 'PENDING',	
created_at DATETIME  NOT NULL DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT NULL,
deleted_at DATETIME DEFAULT NULL 
)

--user skill table --

create table user_skill(
user_skill_id bigint not null identity(1,1) primary key ,
[user_id] bigint  null FOREIGN KEY ([user_id]) REFERENCES [user]([user_id]),
skill_id int NOT NULL FOREIGN KEY (skill_id) REFERENCES skill(skill_id),
created_at DATETIME  NOT NULL DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT NULL,
deleted_at DATETIME DEFAULT NULL 
)