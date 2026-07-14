/*
------------------------------------------------------------
Project : MRA ETL
Database: MRAs
Table   : offline_meters_cycle_reading
Purpose : Stores meter inspection and cycle reading information.
------------------------------------------------------------
*/

USE MRAs;
GO

CREATE TABLE offline_meters_cycle_reading
(
    inspection_id BIGINT IDENTITY(1,1) PRIMARY KEY,

    account_number VARCHAR(20) NOT NULL,

    customer_name VARCHAR(255),

    meter_number VARCHAR(20),

    staff_no VARCHAR(20),

    region VARCHAR(100),

    county VARCHAR(100),

    itinerary VARCHAR(100),

    model_name VARCHAR(100),

    meter_phase_type VARCHAR(50),

    campaign_type VARCHAR(100),

    system_payment VARCHAR(50),

    inspection_status VARCHAR(50),

    meter_serial_number_input VARCHAR(50),

    total_reading DECIMAL(18,2),

    high_rate_reading DECIMAL(18,2),

    low_rate_reading DECIMAL(18,2),

    kva_reading DECIMAL(18,2),

    kw_reading DECIMAL(18,2),

    remarks VARCHAR(500),

    sim_serial VARCHAR(50),

    operation VARCHAR(100),

    overdue_debt DECIMAL(18,2),

    revenue_collected DECIMAL(18,2),

    payment_mode VARCHAR(50),

    meter_type VARCHAR(50),

    has_overdue_debt BIT,

    tampered_meter BIT,

    faulty_meter BIT,

    idle_meter BIT,

    bypassed_meter BIT,

    kva DECIMAL(18,2),

    kwh DECIMAL(18,2),

    number_of_meters_on_site INT,

    earth_current DECIMAL(18,2),

    read_status VARCHAR(50),

    inspection_date DATE,

    validation_status VARCHAR(100),

    created_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME()
);

GO