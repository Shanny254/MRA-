/*
------------------------------------------------------------
Project : MRA ETL
Database: MRAs
Table   : load_factor
Purpose : Stores load factor analysis.
------------------------------------------------------------
*/

USE MRAs;
GO

CREATE TABLE load_factor
(
    load_factor_id BIGINT IDENTITY(1,1) PRIMARY KEY,

    account_number VARCHAR(20) NOT NULL,

    staff_no VARCHAR(20),

    county VARCHAR(100),

    tariff VARCHAR(50),

    high_rate DECIMAL(18,2),

    low_rate DECIMAL(18,2),

    kva_demand DECIMAL(18,2),

    kw_demand DECIMAL(18,2),

    load_factor DECIMAL(18,2),

    remarks VARCHAR(500),

    created_at DATETIME2 DEFAULT SYSDATETIME()
);

GO