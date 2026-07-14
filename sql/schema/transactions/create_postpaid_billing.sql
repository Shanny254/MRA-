/*
------------------------------------------------------------
Project : MRA ETL
Database: MRAs
Table   : postpaid_billing
Purpose : Stores postpaid billing information.
------------------------------------------------------------
*/

USE MRAs;
GO

CREATE TABLE postpaid_billing
(
    postpaid_billing_id BIGINT IDENTITY(1,1) PRIMARY KEY,

    account_number VARCHAR(20) NOT NULL,

    customer_name VARCHAR(255),

    meter_number VARCHAR(20),

    region VARCHAR(100),

    county VARCHAR(100),

    sector_name VARCHAR(100),

    zone_name VARCHAR(100),

    itinerary VARCHAR(100),

    tariff VARCHAR(50),

    contract_status VARCHAR(100),

    bill_month DATE,

    units_billed DECIMAL(18,2),

    amount_billed DECIMAL(18,2),

    amount_paid DECIMAL(18,2),

    balance DECIMAL(18,2),

    created_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME()
);

GO