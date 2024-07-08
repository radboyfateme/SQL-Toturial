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
			      ('Ferman','Xosravi','09100000000',GETDATE(),1),
				  ('Zizi','Farhad','09100000000',GETDATE(),1),
				  ('Sara','Toski','09100000000',GETDATE(),1),
				  ('Zara','Ahmadi','09100000000',GETDATE(),1)

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












