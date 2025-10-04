
/*
==================================================================================

Stored Procedure: Load Bronze Layer (Source  -> Bronze)

==================================================================================
Script Purpose:
	This stored procedure loads data into the 'bronze' schema from the external CSV files.
	It performs the following actions:
		- Truncates the bronze tables before loading data
		- Uses the 'BULK INSERT' command to load data from CSV files to bronze tables.
	Parameters:
		None.
	 This stored procedure does not accept any parameters or return any values.

	Usage Example:
		EXEC bronze.load_bronze;
==================================================================================
*/

USE XYZ;
GO

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME
	BEGIN TRY
	SET @batch_start_time = GETDATE()
		PRINT '=======================================';
		PRINT 'Loading Bronze Layer';
		PRINT '=======================================';


		PRINT '---------------------------------------';
		PRINT 'Loading Customer Large Table';
		PRINT '---------------------------------------';

		SET @start_time = GETDATE()
		PRINT '>> Truncating Table: bronze.customers_large'


		TRUNCATE TABLE bronze.customers_large;
		BULK INSERT bronze.customers_large
		FROM 'C:\Users\adeso\OneDrive\Documents\XYZ Data Warehouse\customers_large.csv'
		WITH (
			 FIRSTROW = 2,
			 FIELDTERMINATOR = ',',
			 TABLOCK
		);

		SET @end_time = GETDATE()
		
		PRINT '---------------------------------------';
		PRINT 'Loading Order Item Table';
		PRINT '---------------------------------------';

		SET @start_time = GETDATE()
		PRINT '>> Truncating Table: bronze.order_items_large'
		TRUNCATE TABLE bronze.order_items_large;
		BULK INSERT bronze.order_items_large
		FROM 'C:\Users\adeso\OneDrive\Documents\XYZ Data Warehouse\order_items_large.csv'
		WITH (
			 FIRSTROW = 2,
			 FIELDTERMINATOR = ',',
			 TABLOCK
		);

		SET @end_time = GETDATE()

		PRINT '---------------------------------------';
		PRINT 'Loading Orders Table';
		PRINT '---------------------------------------';

		SET @start_time = GETDATE()
		TRUNCATE TABLE bronze.orders_large;
		BULK INSERT bronze.orders_large
		FROM 'C:\Users\adeso\OneDrive\Documents\XYZ Data Warehouse\orders_large.csv'
		WITH (
			 FIRSTROW = 2,
			 FIELDTERMINATOR = ',',
			 TABLOCK
		);

		SET @end_time = GETDATE()

		PRINT '---------------------------------------';
		PRINT 'Loading Payment Table';
		PRINT '---------------------------------------';

		SET @start_time = GETDATE()
		TRUNCATE TABLE bronze.payments_large;
		BULK INSERT bronze.payments_large
		FROM 'C:\Users\adeso\OneDrive\Documents\XYZ Data Warehouse\payments_large.csv'
		WITH (
			 FIRSTROW = 2,
			 FIELDTERMINATOR = ',',
			 TABLOCK
		);

		SET @end_time = GETDATE()

		PRINT '---------------------------------------';
		PRINT 'Loading Product Table';
		PRINT '---------------------------------------';

		SET @start_time = GETDATE()
		TRUNCATE TABLE bronze.products_large;
		BULK INSERT bronze.products_large
		FROM 'C:\Users\adeso\OneDrive\Documents\XYZ Data Warehouse\products_large.csv'
		WITH (
			 FIRSTROW = 2,
			 FIELDTERMINATOR = ',',
			 TABLOCK
		);

		SET @end_time = GETDATE()


		PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR) + 'seconds'
		PRINT '-----------------------'

		SET @batch_end_time = GETDATE()
		PRINT '============================'
		PRINT 'Loading Bronze Layer is Completed';
		PRINT ' -Total Load Duration: '+ CAST(DATEDIFF(SECOND,@batch_start_time,@batch_end_time) AS NVARCHAR) + 'seconds'
		PRINT '============================'

	END TRY
	BEGIN CATCH
		PRINT '========================================================'
		PRINT 'ERROR OCCURRED DURING LOADING BRONZE LAYER'
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Message' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Message' + CAST(ERROR_STATE() AS NVARCHAR);

		PRINT '======================================================='
	END CATCH

END
