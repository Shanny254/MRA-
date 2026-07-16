/*
------------------------------------------------------------
Project : MRA ETL
Database: MRA
Table   : postpaid_billing
Purpose : Stores monthly postpaid billing information.
------------------------------------------------------------
*/

USE MRA;
GO

CREATE TABLE postpaid_billing
(
    billing_id BIGINT IDENTITY(1,1) PRIMARY KEY,

    account_number VARCHAR(20) NOT NULL,

    bill_month DATE NOT NULL,

    units_billed DECIMAL(18,2),

    amount_billed DECIMAL(18,2),

    amount_paid DECIMAL(18,2),

    balance DECIMAL(18,2),

    tariff VARCHAR(50),

    contract_status VARCHAR(100),

    created_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME(),

    updated_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME()
);

GO