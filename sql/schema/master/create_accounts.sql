/*
------------------------------------------------------------
Project : MRA ETL
Database: MRAs
Table   : accounts
Purpose : Stores customer account information.
------------------------------------------------------------


Business Rule

- account_number stores the current KPLC account number.
- If an account is renumbered, the previous number is stored in old_account_number.

*/

USE MRAs;
GO

CREATE TABLE accounts
(
    account_number VARCHAR(20) PRIMARY KEY,

    old_account_number VARCHAR(20),

    customer_name VARCHAR(255),

    meter_number VARCHAR(50),

    region VARCHAR(100),

    county VARCHAR(100),

    sector_name VARCHAR(100),

    zone_name VARCHAR(100),

    itinerary VARCHAR(50),

    tariff VARCHAR(50),

    contract_status VARCHAR(100),

    created_at DATETIME2
        DEFAULT SYSDATETIME()
);

GO