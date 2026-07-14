/*
------------------------------------------------------------
Project : MRA ETL
Database: MRAs
Table   : zero_cons
Purpose : Stores zero consumption accounts.
------------------------------------------------------------
*/

USE MRAs;
GO

CREATE TABLE zero_cons
(
    zero_cons_id BIGINT IDENTITY(1,1) PRIMARY KEY,

    account_number VARCHAR(20) NOT NULL,

    staff_no VARCHAR(20),

    county VARCHAR(100),

    tariff VARCHAR(50),

    total_amount DECIMAL(18,2),

    invoice_date DATE,

    remarks VARCHAR(500),

    created_at DATETIME2 DEFAULT SYSDATETIME()
);

GO