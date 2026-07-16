/*
------------------------------------------------------------
Project : MRA ETL
Database: MRA
Table   : offline_smart_meters
Purpose : Stores offline smart meter communication records.
------------------------------------------------------------
*/

USE MRA;
GO

CREATE TABLE offline_smart_meters
(
    offline_meter_id BIGINT IDENTITY(1,1) PRIMARY KEY,

    account_number VARCHAR(20) NOT NULL,

    staff_no VARCHAR(20) NULL,

    meter_number VARCHAR(30) NULL,

    meter_type VARCHAR(100) NULL,

    communication_status VARCHAR(100) NULL,

    last_communication_time DATETIME2 NULL,

    latitude DECIMAL(10,8) NULL,

    longitude DECIMAL(11,8) NULL,

    created_at DATETIME2 NOT NULL
        CONSTRAINT DF_offline_smart_meters_created_at
        DEFAULT SYSDATETIME()
);

GO