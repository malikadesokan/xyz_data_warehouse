/*
============================================================================================
DDL Create Bronze Layer (Source ======> Bronze)
============================================================================================
Purpose:
	This script creates tables at the bronze layer. The script creates fields that mirror the
	number of columns and data type for each of the CSV files.

============================================================================================
Create Bronze Tables
============================================================================================

*/


IF OBJECT_ID('bronze.customers_large', 'U') IS NOT NULL
   DROP TABLE bronze.customers_large;
GO

CREATE TABLE bronze.customers_large (
	customer_id NVARCHAR(50),
	first_name NVARCHAR (50),
	last_name NVARCHAR(50),
	email NVARCHAR(50),
	phone NVARCHAR(50),
	signup_date DATE
)

IF OBJECT_ID('bronze.order_items_large', 'U') IS NOT NULL
   DROP TABLE bronze.order_items_large;
GO

CREATE TABLE bronze.order_items_large (
	order_id NVARCHAR(50),
	product_id NVARCHAR(50),
	quantity INT,
	discount FLOAT
)

IF OBJECT_ID('bronze.orders_large', 'U') IS NOT NULL
   DROP TABLE bronze.orders_large;
GO

CREATE TABLE bronze.orders_large (
	order_id NVARCHAR(50),
	customer_id NVARCHAR(50),
	order_date DATE,
	order_status NVARCHAR(50),
	shipping_cost FLOAT
)

IF OBJECT_ID('bronze.payments_large', 'U') IS NOT NULL
   DROP TABLE bronze.payments_large;
GO

CREATE TABLE bronze.payments_large (
	payment_id NVARCHAR(50),
	order_id NVARCHAR(50),
	payment_date DATE,
	amount FLOAT,
	method NVARCHAR(50)
)

IF OBJECT_ID('bronze.products_large', 'U') IS NOT NULL
   DROP TABLE bronze.products_large;
GO

CREATE TABLE bronze.products_large (
	product_id NVARCHAR(50),
	product_name NVARCHAR(50),
	category NVARCHAR(50),
	unit_price FLOAT,
	active NVARCHAR(50)
)

