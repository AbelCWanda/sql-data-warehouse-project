/*
=============================================================
Create Database and Schemas
=============================================================
Script Purpose:
    This script creates a new database named 'DataWarehouse' after checking if it already exists. 
    If the database exists, it is dropped and recreated. Additionally, the script sets up three schemas 
    within the database: 'bronze', 'silver', and 'gold'.
	
WARNING:
    Running this script will drop the entire 'DataWarehouse' database if it exists. 
    All data in the database will be permanently deleted. Proceed with caution 
    and ensure you have proper backups before running this script.
*/


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
