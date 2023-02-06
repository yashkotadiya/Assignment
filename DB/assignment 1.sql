select * from Products

select ProductID as ID, ProductName as Name, UnitPrice as Price from Products 
where UnitPrice < 20;

select ProductID as ID, ProductName as Name, UnitPrice as Price from Products 
where UnitPrice <= 25 and UnitPrice >=15;

select ProductName as Name, UnitPrice as Price from Products
where UnitPrice > (select avg(UnitPrice) from Products) ;

select top 10  ProductName as Name, UnitPrice as Price from Products
order by UnitPrice DESC;

select count(Discontinued) from Products 
where Discontinued = 0;

select count(Discontinued) from Products 
where Discontinued = 1;

select Discontinued,count(Discontinued) as numberofproduct from Products
group by Discontinued; 

select  ProductName as Name,UnitsOnOrder as [units on order] , UnitsInStock as  [units in stock] from Products 
where UnitsOnOrder > UnitsInStock;
