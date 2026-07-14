/*
------------------------------------------------------------
Project : MRA ETL
Database: MRAs
Table   : ordinary_acs_meter_rdg
Purpose : Stores ordinary ACS meter readings.
------------------------------------------------------------
*/

USE MRAs;
GO

CREATE TABLE ordinary_acs_meter_rdg
(
    reading_id BIGINT IDENTITY(1,1) PRIMARY KEY,

    account_number VARCHAR(20) NOT NULL,

    customer_name VARCHAR(255),

    meter_number VARCHAR(20),

    region VARCHAR(100),

    county VARCHAR(100),

    sector_name VARCHAR(100),

    zone_name VARCHAR(100),

    itinerary VARCHAR(100),

    tariff VARCHAR(50),

    contract_status VARCHAR(100),

    previous_reading DECIMAL(18,2),

    current_reading DECIMAL(18,2),

    consumption DECIMAL(18,2),

    reading_date DATE,

    read_status VARCHAR(100),

    created_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME()
);

GO