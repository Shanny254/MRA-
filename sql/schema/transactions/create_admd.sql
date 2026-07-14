/*
------------------------------------------------------------
Project : MRA ETL
Database: MRAs
Table   : admd
Purpose : Stores ADMD inspection records.
------------------------------------------------------------
*/

USE MRAs;
GO

CREATE TABLE admd
(
    admd_id BIGINT IDENTITY(1,1) PRIMARY KEY,

    account_number VARCHAR(20) NOT NULL,

    customer_name VARCHAR(255),

    meter_number VARCHAR(20),

    staff_no VARCHAR(20),

    region VARCHAR(100),

    county VARCHAR(100),

    sector_name VARCHAR(100),

    zone_name VARCHAR(100),

    tariff VARCHAR(50),

    contract_status VARCHAR(100),

    kva_demand DECIMAL(18,2),

    kva_contract DECIMAL(18,2),

    difference DECIMAL(18,2),

    remarks VARCHAR(500),

    created_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME()
);

GO