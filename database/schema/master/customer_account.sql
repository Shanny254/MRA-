/*
------------------------------------------------------------
Project : MRA ETL
Database: MRA
Table   : customer_account
Purpose : Stores one record for each KPLC customer account.
------------------------------------------------------------
*/

USE MRA;
GO

CREATE TABLE customer_account
(
    account_number VARCHAR(20) NOT NULL
        PRIMARY KEY,

    old_account_number VARCHAR(20),

    customer_name VARCHAR(255) NOT NULL,

    meter_number VARCHAR(30),

    tariff VARCHAR(50),

    contract_status VARCHAR(100),

    created_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME(),

    updated_at DATETIME2 NULL
);

GO