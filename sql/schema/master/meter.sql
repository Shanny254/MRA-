/*
------------------------------------------------------------
Project : MRA ETL
Database: MRA
Table   : meter
Purpose : Master table for all KPLC meters.
------------------------------------------------------------
*/

USE MRA;
GO

CREATE TABLE meter
(
    meter_number VARCHAR(30) NOT NULL PRIMARY KEY,

    meter_serial_number VARCHAR(50),

    meter_type VARCHAR(50),

    meter_phase_type VARCHAR(50),

    model_name VARCHAR(100),

    mark_name VARCHAR(100),

    created_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME(),

    updated_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME()
);

GO