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

    period INT,

    region VARCHAR(100),

    county VARCHAR(100),

    business_unit VARCHAR(100),

    sector_name VARCHAR(100),

    zone_name VARCHAR(100),

    itinerary VARCHAR(100),

    customer_type VARCHAR(100),

    tariff VARCHAR(50),

    tariff_desc VARCHAR(100),

    classification VARCHAR(100),

    amount_kes DECIMAL(18,2),

    units_kwhrs DECIMAL(18,2),

    invoice_date DATE,

    bill_type VARCHAR(50),

    bill_status VARCHAR(50),

    estimated_reading BIT,

    created_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME()
);

GO