/*
------------------------------------------------------------
Project : MRA ETL
Database: MRAs
Table   : pf_1st_time
Purpose : Stores first-time power factor analysis.
------------------------------------------------------------
*/

USE MRAs;
GO

CREATE TABLE pf_1st_time
(
    pf_id BIGINT IDENTITY(1,1) PRIMARY KEY,

    account_number VARCHAR(20) NOT NULL,

    customer_name VARCHAR(255),

    meter_number VARCHAR(20),

    staff_no VARCHAR(20),

    region VARCHAR(100),

    county VARCHAR(100),

    tariff VARCHAR(50),

    supply_location VARCHAR(255),

    kva_units DECIMAL(18,2),

    kw_units DECIMAL(18,2),

    high_rate_units DECIMAL(18,2),

    low_rate_units DECIMAL(18,2),

    power_factor_amount DECIMAL(18,2),

    remarks VARCHAR(500),

    created_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME()
);

GO