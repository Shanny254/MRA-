/*
------------------------------------------------------------
Project : MRA ETL
Database: MRAs
Table   : smart_meter_billing
Purpose : Stores smart meter billing transactions.
------------------------------------------------------------
*/

USE MRAs;
GO

CREATE TABLE smart_meter_billing
(
    billing_id BIGINT IDENTITY(1,1) PRIMARY KEY,

    account_number VARCHAR(20) NOT NULL,

    customer_name VARCHAR(255),

    meter_number VARCHAR(20),

    region VARCHAR(100),

    county VARCHAR(100),

    zone_name VARCHAR(100),

    itinerary VARCHAR(100),

    feeder_id VARCHAR(50),

    mfc_feeder_name VARCHAR(150),

    previous_active_energy DECIMAL(18,2),

    previous_kva DECIMAL(18,2),

    previous_kw DECIMAL(18,2),

    previous_high_rate DECIMAL(18,2),

    previous_low_rate DECIMAL(18,2),

    read_status VARCHAR(50),

    current_active_energy DECIMAL(18,2),

    current_kva DECIMAL(18,2),

    current_kw DECIMAL(18,2),

    current_high_rate DECIMAL(18,2),

    current_low_rate DECIMAL(18,2),

    total_consumption DECIMAL(18,2),

    total_amount DECIMAL(18,2),

    created_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME()
);

GO