/*
------------------------------------------------------------
Project : MRA ETL
Database: MRAs
Table   : postpaid_billing
Purpose : Stores postpaid customer billing information.
------------------------------------------------------------
*/

USE MRAs;
GO

CREATE TABLE postpaid_billing
(
    billing_id BIGINT IDENTITY(1,1) PRIMARY KEY,

    account_number VARCHAR(20) NOT NULL,

    billing_period DATE,

    customer_type VARCHAR(100),

    tariff VARCHAR(50),

    tariff_description VARCHAR(100),

    classification VARCHAR(100),

    amount_kes DECIMAL(18,2),

    units_kwh DECIMAL(18,2),

    invoice_date DATE,

    bill_type VARCHAR(50),

    bill_status VARCHAR(50),

    estimated_bill BIT,

    created_at DATETIME2 DEFAULT SYSDATETIME()
);

GO