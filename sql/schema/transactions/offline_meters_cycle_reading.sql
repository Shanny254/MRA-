/*
------------------------------------------------------------
Project : MRA ETL
Database: MRA
Table   : offline_meters_cycle_reading
Purpose : Stores field inspection and cycle reading records.
------------------------------------------------------------
*/

USE MRA;
GO

CREATE TABLE offline_meters_cycle_reading
(
    inspection_id BIGINT IDENTITY(1,1) PRIMARY KEY,

    account_number VARCHAR(20) NOT NULL,

    meter_number VARCHAR(30) NOT NULL,

    staff_no VARCHAR(20) NOT NULL,

    inspection_date DATE,

    campaign_type VARCHAR(100),

    inspection_status VARCHAR(100),

    validation_status VARCHAR(100),

    operation VARCHAR(100),

    meter_serial_number_input VARCHAR(50),

    meter_phase_type VARCHAR(50),

    model_name VARCHAR(100),

    mark_name VARCHAR(100),

    meter_type VARCHAR(50),

    system_payment VARCHAR(50),

    payment_mode VARCHAR(50),

    total_reading DECIMAL(18,2),

    high_rate_reading DECIMAL(18,2),

    low_rate_reading DECIMAL(18,2),

    kva_reading DECIMAL(18,2),

    kw_reading DECIMAL(18,2),

    kva DECIMAL(18,2),

    kwh DECIMAL(18,2),

    earth_current DECIMAL(18,2),

    number_of_meters_on_site INT,

    overdue_debt DECIMAL(18,2),

    revenue_collected DECIMAL(18,2),

    has_overdue_debt BIT,

    tampered_meter BIT,

    faulty_meter BIT,

    idle_meter BIT,

    bypassed_meter BIT,

    read_status VARCHAR(100),

    remarks VARCHAR(1000),

    sim_serial VARCHAR(50),

    created_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME(),

    updated_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME()
);

GO