/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/


--CREATE STORE PROCEDURE LOAD THE FREQUENTLY DATA NEED
CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME,@batch_start_time datetime, @batch_end_time datetime;
	begin try
		--FULL LOAD(FIRST DELETE THE CONTENT ON THE TABLE THEN INSERT NEW DATA)
		SET @batch_start_time = GETDATE();
		print'====================================================================';
		print'Loading Bronze Layer';
		print'====================================================================';

		--bronze.crm_cust_info
		print'--------------------------------------------------------------------';
		print'Loading CRM TABLES';
		print'--------------------------------------------------------------------';

		SET @start_time = GETDATE();
		print'>>>>>>> Truncating Table: bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info;

		print'>>>>>>> Inserting Data into Table: bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\AbelCWanda\Documents\Courses\Analytics Mentoring 2026\DW-PROJECT\Proj1(SQL-DW)\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK 
		);

		SET @end_time = GETDATE();
		PRINT'>>> Load Duration '+CAST(datediff(second,@start_time,@end_time) as nvarchar) +' SECONDS';
		PRINT'>>> ---------------------------------';


		--bronze.crm_prd_info
		SET @start_time = GETDATE();
		print'>>>>>>> Truncating Table: bronze.crm_prd_info';
		TRUNCATE TABLE bronze.crm_prd_info;

		print'>>>>>>> Inserting Data into Table: bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\AbelCWanda\Documents\Courses\Analytics Mentoring 2026\DW-PROJECT\Proj1(SQL-DW)\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT'>>> Load Duration '+CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR)+' SECONDS';
		PRINT'>>> ---------------------------------';

		--bronze.crm_sales_details
		SET @start_time = GETDATE();
		print'>>>>>>> Truncating Table: bronze.crm_sales_details ';
		TRUNCATE TABLE bronze.crm_sales_details;
		print'>>>>>>> Inserting Data into Table: bronze.crm_sales_details ';
		BULK INSERT bronze.crm_sales_details 
		FROM 'C:\Users\AbelCWanda\Documents\Courses\Analytics Mentoring 2026\DW-PROJECT\Proj1(SQL-DW)\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT'>>> Load Duration '+CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR)+' SECONDS';
		PRINT'>>> ---------------------------------';


		print'--------------------------------------------------------------------';
		print'Loading ERP TABLES';
		print'--------------------------------------------------------------------';

		--bronze.erp_cust_az12
		SET @start_time = GETDATE();
		print'>>>>>>> Truncating Table: bronze.erp_cust_az12';
		TRUNCATE TABLE bronze.erp_cust_az12;
		print'>>>>>>> Inserting Data into Table: bronze.erp_cust_az12';
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\AbelCWanda\Documents\Courses\Analytics Mentoring 2026\DW-PROJECT\Proj1(SQL-DW)\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT'>>> Load Duration '+CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR)+' SECONDS';
		PRINT'>>> ---------------------------------';


		--bronze.erp_loc_a101
		SET @start_time = GETDATE();
		print'>>>>>>> Truncating Table: bronze.erp_loc_a101';
		TRUNCATE TABLE bronze.erp_loc_a101;
		print'>>>>>>> Inserting Data into Table: bronze.erp_loc_a101';
		BULK INSERT bronze.erp_loc_a101 
		FROM 'C:\Users\AbelCWanda\Documents\Courses\Analytics Mentoring 2026\DW-PROJECT\Proj1(SQL-DW)\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT'>>> Load Duration '+CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR)+' SECONDS';
		PRINT'>>> ---------------------------------';


		--bronze.erp_px_cat_g1v2
		SET @start_time = GETDATE();
		print'>>>>>>> Truncating Table: bronze.erp_px_cat_g1v2';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;
		print'>>>>>>> Inserting Data into Table: bronze.erp_px_cat_g1v2';
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\AbelCWanda\Documents\Courses\Analytics Mentoring 2026\DW-PROJECT\Proj1(SQL-DW)\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT'>>> Load Duration '+CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR)+' SECONDS';
		PRINT'>>> ---------------------------------';


		SET @batch_end_time = GETDATE();
		print'==========================================================================================';
		print'Loading Bronze Layer Is COMPLETED';
		PRINT'	- Total Load Duration =   '+CAST(datediff(second,@batch_start_time,@batch_end_time) as nvarchar) +' SECONDS';
		print'==========================================================================================';
	end try
	begin catch
		print'=====================================================================================';
		print'ERROR OCURRED DURING LOADING BRONZE LAYER';
		PRINT'ERROR MESSAGE: '+ERROR_MESSAGE();
		PRINT'ERROR MESSAGE: '+CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT'ERROR MESSAGE: '+CAST(ERROR_STATE() AS NVARCHAR);
		print'=====================================================================================';
	end catch
END

GO
EXEC bronze.load_bronze
GO
