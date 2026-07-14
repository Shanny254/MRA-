/*
------------------------------------------------------------
Project : MRA ETL
Database: MRAs
Table   : accounts
Purpose : Stores the master customer account information.
------------------------------------------------------------
*/

USE MRAs;
GO

CREATE TABLE accounts
(
    account_number VARCHAR(20) NOT NULL PRIMARY KEY,

    old_account_number VARCHAR(20),

    customer_name VARCHAR(255) NOT NULL,

    meter_number VARCHAR(20),

    region VARCHAR(100),

    county VARCHAR(100),

    sector_name VARCHAR(100),

    zone_name VARCHAR(100),

    itinerary VARCHAR(100),

    tariff VARCHAR(50),

    contract_status VARCHAR(100),

    created_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME()
);

GO