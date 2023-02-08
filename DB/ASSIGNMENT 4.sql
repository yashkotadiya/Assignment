
--1
alter PROCEDURE que1
AS
	SELECT CustomerID, AVG(Freight) as AvgFreight
	FROM Orders
	GROUP BY CustomerID
GO

insert into orders values ( 'ALFKI', 1,'1997-08-25 00:00:00.000', '1997-08-01 00:00:00.000','1997-01-01 00:00:00.000', 1,80, 'Wolski Zajazd', 'ul. Filtrowa 68',
'Warszawa', 'Tachira', 24100, 'brazil')

exec que1

UPDATE Orders SET Freight=100 WHERE OrderID = 10248
SELECT * FROM Orders WHERE OrderID = 10248

create TRIGGER tr_que1_update
ON orders
INSTEAD OF UPDATE
AS
BEGIN 
	Declare @OrderID int
	Declare @CustomerID varchar(50)
	Declare @Freight money
	Declare @AvgFreight money

	Declare @t_ave TABLE(CustomerID nchar(5), AvgFreight money)
	INSERT @t_ave
	exec que1
	
	Select * Into #Temptable FROM Inserted

	While(Exists(Select OrderID from #TempTable))
      Begin
		Select TOP 1 @OrderID = OrderID, @CustomerID = CustomerID, @Freight=Freight
		FROM #Temptable
		SET @AvgFreight = (SELECT AvgFreight FROM @t_ave WHERE CustomerID = @CustomerID)

		Print @Freight
		Print @AvgFreight

			IF @Freight > @AvgFreight 
			BEGIN	
				RAISERROR ('ABOVE AVERAGE',16,1)
			END
			ELSE 
			BEGIN
				UPDATE Orders SET Freight = @Freight WHERE OrderID=@OrderID 
			END

		Delete from #TempTable where OrderID = @OrderID
		
      End
END

alter TRIGGER tr_que1_insert
ON orders
INSTEAD OF INSERT
AS
BEGIN 
	Declare @OrderID int
	Declare @CustomerID varchar(50)
	Declare @Freight money
	Declare @AvgFreight money

	Declare @t_ave TABLE(CustomerID nchar(5), AvgFreight money)
	INSERT @t_ave
	exec que1
	
	Select *  Into #Temptable FROM Inserted
	
	While(Exists(Select OrderID from #TempTable))
      Begin
		Select TOP 1 @OrderID = OrderID, @CustomerID = CustomerID, @Freight=Freight
		FROM #Temptable
		SET @AvgFreight = (SELECT AvgFreight FROM @t_ave WHERE CustomerID = @CustomerID)

		IF @Freight > @AvgFreight 
		BEGIN	
			RAISERROR ('ABOVE AVERAGE',16,1)
		END
		ELSE 
		BEGIN
			INSERT INTO Orders (CustomerID,EmployeeID,OrderDate,RequiredDate,ShippedDate,ShipVia,Freight,ShipName,ShipAddress,ShipCity,ShipRegion,ShipPostalCode,ShipCountry)
			SELECT CustomerID,EmployeeID,OrderDate,RequiredDate,ShippedDate,ShipVia,Freight,ShipName,ShipAddress,ShipCity,ShipRegion,ShipPostalCode,ShipCountry
			From Inserted
		END

		Delete from #TempTable where OrderID = @OrderID
		
      End
END



select * from Orders;
select CustomerID,avg(Freight) from Orders group by CustomerID ;
select * from Customers





--2
alter procedure sp_SalesByCountry
	@Employeename varchar(20)
as
begin


	select e.EmployeeID,o.ShipCountry,count(o.OrderID) as [Total Orders] 
	from Employees e inner join Orders o on e.EmployeeID = o.EmployeeID 
	where e.FirstName = @Employeename
	group by o.ShipCountry,e.EmployeeID

end

exec sp_salesbyCountry @Employeename ='Nancy' 


select e.EmployeeID,o.ShipCountry,count(o.OrderID) as [Total Orders] 
from Employees e inner join Orders o on e.EmployeeID = o.EmployeeID 
group by e.EmployeeID,o.ShipCountry






--3
select year(OrderDate) as [year], count(OrderID) as [Total Orders] from Orders 
group by year(OrderDate) 

alter procedure sp_SalesByYear
@year int
as
begin

	select year(OrderDate) as [year], count(OrderID) as [Total Orders] from Orders 
	where year(OrderDate) = @year
	group by year(OrderDate)

end

exec sp_SalesByYear 1996





--4
select c.CategoryID, c.CategoryName as [Category], count(o.OrderID) as [Total Orders] 
from Categories c inner join Products p  on c.CategoryID = p.CategoryID 
inner join [Order Details] o on p.ProductID = o.ProductID
group by c.CategoryID, c.CategoryName


alter procedure sp_SalesByCategory
@CategoryID int
as
begin
	
	select c.CategoryID, c.CategoryName, count(o.OrderID) as [Total Orders] 
	from Categories c inner join Products p  on c.CategoryID = p.CategoryID 
	inner join [Order Details] o on p.ProductID = o.ProductID
	where c.CategoryID = @CategoryID
	group by c.CategoryID, c.CategoryName

end

exec sp_SalesByCategory 1




--5
alter procedure sp_TopMostExpencive
as
begin

	select top 10 ProductName,UnitPrice from Products order by UnitPrice desc

end

exec sp_TopMostExpencive



--6

alter procedure sp_InsertIntoOrderDeatils
@OrderID int,
@ProductID int,
@UnitPrice money,
@Quantity smallint,
@Discount real
as
begin

	insert into [Order Details]
	values(@OrderID,@ProductID,@UnitPrice,@Quantity,@Discount)

end

exec sp_InsertIntoOrderDeatils 10248,2,11.00,1,1.00





--7
update [Order Details] 
set  UnitPrice=2, Quantity=2, Discount=0.5
where OrderID = 10248 and ProductID = 1

alter procedure sp_UpdateOrderDetails
@OrderID int,
@ProductID int,
@UnitPrice money,
@Quantity smallint,
@Discount real
as
begin

	update [Order Details] 
	set  UnitPrice=@UnitPrice, Quantity=@Quantity, Discount=@Discount
	where OrderID = @OrderID and ProductID = @ProductID

end

exec sp_UpdateOrderDetails @OrderID=10248,@ProductID=1,@UnitPrice=22.00,@Quantity=2,@Discount=0.10
