create database sales
create table salesman(salesman_id int primary key, name varchar(50), city varchar(30),commision float)
insert into salesman values(5001, 'James Hoog', 'New York', 0.15)
insert into salesman values(5002, 'Nail Knite', 'Paris', 0.13)
insert into salesman values(5005, 'Pit Alex', 'London', 0.11)
insert into salesman values(5006, 'Mc Lyon', 'Paris', 0.14)
insert into salesman values(5007, 'Paul Adam', 'Rome', 0.13)
insert into salesman values(5003, 'Lauson Hen', 'San Jose', 0.12)



create table customer(customer_id int primary key,   cust_name varchar(50),    city varchar(30),grade int,salesman_id int foreign key REFERENCES salesman(salesman_id))
insert into customer values(3002, 'Nick Rimando', 'New York', 100, 5001)
insert into customer values(3007, 'Brad Davis', 'New York', 200, 5001)
insert into customer values(3005, 'Graham Zusi', 'California', 200, 5002)
insert into customer values(3008, 'Julian Green', 'London', 300, 5002)
insert into customer values(3004, 'Fabian Johnson', 'Paris', 300, 5006)
insert into customer values(3009, 'Geoff Cameron', 'Berlin', 100, 5003)
insert into Customer values(3003, 'Jozy Altidor', 'Moscow', 200, 5007)
insert into Customer values(3001, 'Brad Guzan', 'London', NULL, 5005)



create table orders(
	order_no numeric(5) primary key, purch_amt decimal(8,2), order_date date, 
	customer_id int foreign key references customer(customer_id), salesman_id int foreign key references salesman(salesman_id))

insert into orders values(70001, 150.5, '2012-10-05', 3005, 5002)
insert into orders values(70009, 270.65, '2012-09-10', 3001, 5005)
insert into orders values(70002, 65.26, '2012-10-05', 3002, 5001)
insert into orders values(70004, 110.5, '2012-08-17', 3009, 5003)
insert into orders values(70007, 948.5, '2012-09-10', 3005, 5002)
insert into orders values(70005, 2400.6, '2012-07-27', 3007, 5001)
insert into orders values(70008, 5760, '2012-09-10', 3002, 5001)
insert into orders values(70010, 1983.43, '2012-10-10', 3004, 5006)
insert into orders values(70003, 2480.4, '2012-10-10', 3009, 5003)
insert into orders values(70012, 250.45, '2012-06-27', 3008, 5002)
insert into orders values(70011, 75.29, '2012-08-17', 3003, 5007)
insert into orders values(70013, 3045.6, '2012-04-25', 3002, 5001)

select * from salesman;
select * from customer;
select * from orders;

--------------------------------------0---------------------------------------
select [name],cust_name,salesman.city from salesman inner join customer  
on customer.city = salesman.city 

select order_no, purch_amt, cust_name,city from orders inner join customer 
on customer.customer_id = orders.customer_id 
where purch_amt between 500 and 2000;

select cust_name as [Customer Name] , [name] as Salesman from customer c INNER JOIN salesman s
ON c.salesman_id = s.salesman_id;select c.cust_name as [Customer Name] , s.name as Salesman, c.city as [customer city] ,s.commision as comission from customer c INNER JOIN salesman s
ON c.salesman_id = s.salesman_id 
where s.commision > 0.12;

select c.cust_name as [Customer Name] , s.name as Salesman, c.city as [customer city],s.city as [salesman city]  ,s.commision as comission 
from customer c INNER JOIN salesman s
ON c.salesman_id = s.salesman_id 
where s.commision > 0.12 and c.city != s.city;


select order_no, order_date, purch_amt, cust_name as [Customer Name], grade,  s.name as Salesman , commision 
from orders o INNER JOIN customer c
ON o.customer_id=c.customer_id 
INNER JOIN salesman s ON o.salesman_id=s.salesman_id;

---------------------------------------------------------
SELECT * FROM orders o NATURAL JOIN customer c
on o.customer_id=c.customer_id 
NATURAL JOIN salesman s on o.salesman_id=s.salesman_id;

select *
from orders o INNER JOIN customer c
ON o.customer_id=c.customer_id 
INNER JOIN salesman s ON o.salesman_id=s.salesman_id;

select *
from orders o cross JOIN customer c
cross JOIN salesman s
where o.customer_id=c.customer_id 
 and o.salesman_id=s.salesman_id;

 ------------------------------------


select c.cust_name as [Customer Name] ,c.city as [customer city] , s.name as Salesman, s.city as [salesman city],c.grade 
from customer c inner JOIN salesman s
ON c.salesman_id = s.salesman_id 
order by c.customer_id asc ;


select c.cust_name as [Customer Name] ,c.city as [customer city] , s.name as Salesman, s.city as [salesman city],c.grade 
from customer c inner JOIN salesman s
ON c.salesman_id = s.salesman_id
where c.grade < 300
order by c.customer_id asc ;

select order_no, order_date, purch_amt, cust_name as [Customer Name],c.city as [customer city]
from customer c left outer JOIN orders o
ON c.customer_id = o.customer_id
order by o.order_date asc ;

select cust_name as [Customer Name],c.city as [customer city],order_no, order_date, purch_amt,s.name as Salesman,s.commision as comission 
from customer c left outer join  orders o  
ON o.customer_id=c.customer_id 
left outer join salesman s ON c.salesman_id=s.salesman_id ;

12
select count(name) as oder,s.name from customer c right outer join salesman s 
ON  s.salesman_id=c.salesman_id
group by s.name
order by oder


13
select s.name as Salesman,cust_name as [Customer Name],c.city,c.grade,order_no, order_date, purch_amt
from customer c right outer join   salesman s 
ON s.salesman_id = c.salesman_id 
left outer join orders o  ON c.customer_id=o.customer_id ;


14
select s.name as Salesman,cust_name as [Customer Name],c.city,c.grade, 
o.order_no, o.order_date,o.purch_amt 
from customer c right outer join salesman s 
ON  c.salesman_id=s.salesman_id 
left outer join orders o  ON c.customer_id=o.customer_id
where o.purch_amt > 2000 and grade is not null 



15
select s.name as Salesman,cust_name as [Customer Name],purch_amt,grade from customer c right outer join salesman s 
ON  c.salesman_id=s.salesman_id 
left outer join orders o  ON c.customer_id=o.customer_id
where o.purch_amt > 2000 and grade is not null ;


16
select cust_name as [Customer Name],c.city as [customer city],order_no, order_date, purch_amt
from customer c full outer join orders o  ON c.customer_id=o.customer_id
where  grade is not null ;


17. 
select *
from customer cross join salesman


18. 
select *
from salesman s cross join  customer c 
where s.city is not null;

19
select *
from salesman s cross join  customer c 
where s.city is not null and c.grade is not null;

select *
from salesman s cross join  customer c 
where s.city !=c.city and  c.grade is not null and s.city is not null;

