/*
------------------------------------------------------------
Project : MRA ETL
Database: MRA
Table   : smart_meter_billing
Purpose : Stores smart meter billing readings.
------------------------------------------------------------
*/

USE MRA;
GO

CREATE TABLE smart_meter_billing
(
    billing_id BIGINT IDENTITY(1,1) PRIMARY KEY,

    account_number VARCHAR(20) NOT NULL,

    meter_number VARCHAR(30),

    previous_active_energy DECIMAL(18,2),

    current_active_energy DECIMAL(18,2),

    previous_high_rate DECIMAL(18,2),

    current_high_rate DECIMAL(18,2),

    previous_low_rate DECIMAL(18,2),

    current_low_rate DECIMAL(18,2),

    previous_kw DECIMAL(18,2),

    current_kw DECIMAL(18,2),

    previous_kva DECIMAL(18,2),

    current_kva DECIMAL(18,2),

    total_consumption DECIMAL(18,2),

    total_amount DECIMAL(18,2),

    read_status VARCHAR(100),

    created_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME(),

    updated_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME()
);

GO