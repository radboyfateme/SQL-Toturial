use master


create Database dbtest3
      on(Name='Mydatabase', FileName='C:\DataBase\Mydatabase.mdf',SIZE=8MB)
	  Log on (Name='Mydatabase_Log', FileName='C:\DataBase\Mydatabase_log.ldf',SIZE=4MB)

----------------------------------------------------------------------------------------------

select Distinct [PersonId],[Name]
from People
---------------------------------------------------------------------------------------
select * 
from people
where [name] like  '%[^a]'
---------------------------------------------------------------------------------------
select * 
from people
order by Avg
offset 3 rows
fetch next 1 rows only
---------------------------------------------------------------------------------------
use master
GO
Create Database dbshop
GO
Use dbshop
Go
Create Table Roles(
        RoleId int primary key NOT NULL,
		RoleTitle varchar(50) NOT NULL,
)
GO
INSERT INTO Roles (RoleId, RoleTitle) VALUES
(1, 'Manager'),
(2, 'Employee');
GO
Create Table Users(
            UserId int primary key identity(1,1) NOT NULL,
			FirstName varchar(40) NOT NULL,
			LastName  varchar(40) NOT NULL,
			MobileNumber char(11) NOT NULL,
			[Password] varchar(50) Null,
			RegisterDate datetime NULL,
			IsActive bit NULL DEFAULT(1),
			RoleId int Null,
			Foreign Key (RoleId) References Roles(RoleId)
)
GO
Insert INTO Users(FirstName,LastName,MobileNumber,RegisterDate,RoleId)
            Values('Hanar','Rad','09100000000',GETDATE(),1),
			      ('Ferman','Xosravi','09100000000',GETDATE(),2),
				  ('Zizi','Farhad','09100000000',GETDATE(),2),
				  ('Sara','Toski','09100000000',GETDATE(),2),
				  ('Zara','Ahmadi','09100000000',GETDATE(),2)

GO
Create Table ProductGroups(
            ProductGroupId int Primary key NOT NULL,
			ProductGroupTitle varchar(50) NOT NULL,
			ParentGroupId int NULL
)
GO
Insert INTO ProductGroups Values(1,'FoodStuffs',NULL),
                                (2,'Detergents',Null),
								(3,'Clothing', NULL),
								(4,'Home Appliances',NULL),
								(5,'Digital Goods',NULL),
								(6,'Sporting Goods',NULL),
								(7,'Dairy',1),
								(8,'MensWear',3),
								(9,'TV',4),
								(10,'Camera',5),
								(11,'Mobile',5),
								(12,'Snacks',1),
								(13,'Protein',1),
								(14,'Beverages',1),
								(15,'Fridge',4),
								(16,'Oven',4)
GO
Create Table Products(
       ProductId int primary key Identity(1,1) NOT NULL,
	   ProductGroupId int NULL,
	   ProductName varchar(50) NOT NULL,
	   Price int NOT NULL default(0),
	   ImageName varchar(50) default('photo.png'),
	   RegisterDate datetime default(GetDate()),
	   RegisteredUserId int NOT NULL,
	   Foreign key (ProductGroupId) References ProductGroups(ProductGroupId),
	   Foreign key (RegisteredUserId) References Users(UserId),
)
GO
Insert Into Products(ProductName,Price,ProductGroupId,RegisteredUserId)
             Values('Chips',5000,12,3),
			       ('Cheetoz',7000,12,3),
				   ('Sausage',64000,12,3),
				   ('Sode',5000,14,3),
				   ('Bleach',28000,2,3),
				   ('Soap',35000,2,4),
				   ('Liquid Soap',42000,2,4),
				   ('Socks',15000,8,5),
				   ('T-shirt',80000,8,4),
				   ('Fotball Ball',350000,6,5),
				   ('Samsung Fridge',54000000,15,3),
				   ('Hat',120000,8,4),
				   ('Cmera Canon',28000000,10,5),
				   ('Shawl',58000,8,5),
				   ('Samsung Mobile',6700000,11,3),
				   ('TV Soni',31000000,9,4),
				   ('Oven Singer',15600000,16,3),
				   ('Microwave EL JI',25000000,16,3),
				   ('Sun Flower Seed ',4500,NULL,3)
-------------------------------------------------------------------------------------------------------
Select *
From Products
Select  SUM(price) As[Total Price]
from Products
Select max(Price) AS [Cheapest]
from products
select AVG(price) AS[AVG]
From Products
select COUNT(Price) AS [Number of Goods]
from products
select COUNT_BIG(PRICE) AS [Number of GOODS]
FROM Products
--------------------------------------------------------------------------
select  [ProductName], [Price], [ImageName], [RegisterDate], [RegisteredUserId],(select AVG(price) from products) As 'Avg of price'
from products
where price >100000

--------------------------------------------------------------------------------------------------
select FirstName,LastName
From Users

Select *
From Users
Where RoleId=2
--------------------------------------------------------------------
select [ProductGroupId], [ProductGroupTitle]
from ProductGroups
Where ProductGroupTitle='Detergents'
-----------------------------------------------------------------------------
select productId,ProductName,Price
from products
where productgroupid IN(
                   Select productGroupId
				   from productGroups

				   where ProductGroupTitle='Fridge' OR ProductGroupTitle='Snacks' OR ProductGroupTitle='Detergents'
)
-----------------------------------------------------------------------------------------------
select productId,ProductName,Price
from products
where productgroupid NOT IN(
                   Select productGroupId
				   from productGroups
				   where ProductGroupTitle='Fridge' OR ProductGroupTitle='Snacks' OR ProductGroupTitle='Detergents'
)


---------------------------------------------------------------------------------------------------
select productId,productName,Price
from Products
where price> Any(
        select price
		from products
		)
-----------------------------------------------------------------------------
select productId,productName,Price
from Products
where price>= All(
        select price
		from products
		)
---------------------------------------------------------------------------
select * 
from Products
where Exists(
        select *
		from ProductGroups
		where ProductGroupTitle='detergents'
		)
---------------------------------------------------------------------------------------------------        
select * 
from Products
where Exists(
        select *
		from ProductGroups
		where ProductGroupTitle='building'
		)
--------------------------------------------------------------------------------------------------------------
Create Database dbTest2
GO
Use dbtest2
GO
Create Table Customer1(
     CustomerId int identity primary key not null,
	  Fname varchar(50)
	  )
Insert INTO Customer1(Fname)Values('hanar'),('ferman'),('sara'),('ali'),('ahmad'),('zara')

create table [Order](
         OrderId int identity primary key not null,
		 customerId int null,
		 price int not null,
		 foreign key (CustomerId) References  Customer1(customerId)
		 )
GO
Insert INTO [order](customerId,Price) Values(2,30000),
                                            (1,45000),
											(5,60000),
											(null,50000),
											(2,40000)
--------------------------------------------------------------------------------------------
select *
from Customer1

select *
from [order]
-----------------------------------------------------------------------------------------------
select *
from [order]

select*
from Customer1
where CustomerId NOT IN(
            select Distinct CustomerId
            From [Order]
)
---------------------------------------------------------------------------------------------------
select*
from Customer1
where  NOT EXISTS(
            select Distinct CustomerId
            From [Order]
			where Customer1.CustomerId=[order].customerId  
			--# not in cannot work where there is null
)
---------------------------------------------------------------------------------------------------------
use master
go
drop database if Exists dbtest3
go
create database  dbtest3 
go
use dbtest3
go
create table Users(
       UserId int primary key,
	   Fname varchar(50),
	   Lname varchar(50)
	   )

insert INTO Users Values(1,'hanar','rad'),
                         (2,'ferman','khosravi'),
						 (3,'zara','amiri'),
						 (4,'sara','fargad')
create Table Students(
      StudentId int primary key,
	  Firstname varchar(50),
	  Lastname varchar(50),
	  MobileNumber varchar(12)
	  )

Insert INTO Students Values(1,'mahammad','jafari','0910000000'),
                           (2,'naser','sadeghi','0910000000'),
						   (3,'saeeid','mosavi','0910000000'),
						   (4,'ali','malaki','0910000000'),
						   (5,'bahram','ghasemi','0910000000')
       
	   
select [UserId], [Fname], [Lname]
from Users   
union
select [StudentId], [Firstname], [Lastname]
from Students
-----------------------------------------------------------------
select [UserId], [Fname], [Lname]
from Users   
intersect
select [StudentId], [Firstname], [Lastname]
from Students
------------------------------------------------------------------------------
select [UserId], [Fname], [Lname]
from Users   
Except
select [StudentId], [Firstname], [Lastname]
from Students