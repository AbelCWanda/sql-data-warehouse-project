--CREATE DATABASE 'DataWareHouse'
use master;
go

--drop and recreate the 'DataWareHouse' database
IF Exists (Select 1 from sys.databases where name = 'DataWareHouse')
BEGIN
	ALTER DATABASE DataWareHouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE DataWareHouse;
END;
go

--create the 'DataWareHouse' database
create database DataWareHouse;
GO
use DataWareHouse;


--create schemas

create schema bronze;
go
create schema silver;
go
create schema gold;
go
