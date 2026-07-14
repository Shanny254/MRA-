/*
------------------------------------------------------------
Project : MRA ETL
Database: MRAs
Table   : offline_smart_meters
Purpose : Stores offline smart meter information.
------------------------------------------------------------
*/

USE MRAs;
GO

CREATE TABLE offline_smart_meters
(
    offline_meter_id BIGINT IDENTITY(1,1) PRIMARY KEY,

    account_number VARCHAR(20) NOT NULL,

    customer_name VARCHAR(255),

    meter_number VARCHAR(20),

    region VARCHAR(100),

    county VARCHAR(100),

    zone_name VARCHAR(100),

    itinerary VARCHAR(100),

    communication_status VARCHAR(100),

    model_name VARCHAR(100),

    meter_phase VARCHAR(50),

    contract_type VARCHAR(50),

    latitude DECIMAL(10,8),

    longitude DECIMAL(11,8),

    created_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME()
);

GO