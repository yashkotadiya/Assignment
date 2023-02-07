Create Database DB3

CREATE TABLE Employee (
emp_id int  NOT NULL,
emp_name varchar(20) default NULL,
mngr_id int default NULL,
salary decimal(7,2) default NULL,
dept_id int default NULL
)
INSERT INTO Employee VALUES
		(7369,	'SMITH',	7902,	800.00,		0),
		(7499,	'ALLEN',	7698,	1600.00,	30),
		(7521,	'WARD',		7698,	1250.00,	30),
		(7566,	'JONES',	7839,	2975.00,	20),
		(7654,	'MARTIN',	7698,	1250.00,	30),
		(7698,	'BLAKE',	7839,	2850.00,	30),
		(7782,	'CLARK',	7839,	2450.00,	10),
		(7788,	'SCOTT',	7566,	3000.00,	20),
		(7839,	'KING',		NULL,	5000.00,	10),
		(7844,	'TURNER',	7698,	1500.00,	30),
		(7876,	'ADAMS',	7788,	1100.00,	20),
		(7900,	'JAMES',	7698,	950.00,		30),
		(7902,	'FORD',		7566,	3000.00,	20),
		(7934,	'MILLER',	7782,	1300.00,	10);

CREATE TABLE Department (
dept_id INT NOT NULL,
dept_name varchar(30) default NULL,
);

INSERT INTO Department VALUES (10,'ACCOUNTING'),
(20,'RESEARCH'),
(30,'SALES'),
(40,'OPERATIONS');



Select * from Department
Select * from Employee

ALter table Employee ADD Constraint PK_Employee_emp_id Primary Key (emp_id)

Alter Table Department Add Constraint PK_Department_dept_id Primary Key (dept_id)

Alter Table Employee ADD CONSTRAINT FK_Employee_dept_id Foreign Key (dept_id) references Department (dept_id)