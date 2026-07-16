/*
------------------------------------------------------------
Project : MRA ETL
Database: MRA
Table   : poor_pf
Purpose : Stores poor Power Factor analysis records.
------------------------------------------------------------
*/

USE MRA;
GO

CREATE TABLE poor_pf
(
    poor_pf_id BIGINT IDENTITY(1,1) PRIMARY KEY,

    account_number VARCHAR(20) NOT NULL,

    inspection_date DATE,

    power_factor DECIMAL(5,2),

    reactive_power DECIMAL(18,2),

    apparent_power DECIMAL(18,2),

    active_power DECIMAL(18,2),

    power_loss DECIMAL(18,2),

    penalty_amount DECIMAL(18,2),

    correction_required BIT,

    correction_status VARCHAR(100),

    recommendation VARCHAR(1000),

    remarks VARCHAR(1000),

    created_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME(),

    updated_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME()
);

GO