/*
------------------------------------------------------------
Project : MRA ETL
Database: MRA
Table   : pf_1st_time
Purpose : Stores first-time Power Factor (PF) inspection records.
------------------------------------------------------------
*/

USE MRA;
GO

CREATE TABLE pf_1st_time
(
    pf_1st_time_id BIGINT IDENTITY(1,1) PRIMARY KEY,

    account_number VARCHAR(20) NOT NULL,

    inspection_date DATE,

    current_power_factor DECIMAL(5,2),

    target_power_factor DECIMAL(5,2),

    reactive_power DECIMAL(18,2),

    apparent_power DECIMAL(18,2),

    pf_status VARCHAR(100),

    recommendation VARCHAR(1000),

    remarks VARCHAR(1000),

    created_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME(),

    updated_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME()
);

GO