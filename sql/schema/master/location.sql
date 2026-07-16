/*
------------------------------------------------------------
Project : MRA ETL
Database: MRA
Table   : location
Purpose : Master table for KPLC geographical hierarchy.
------------------------------------------------------------
*/

USE MRA;
GO

CREATE TABLE location
(
    location_id INT IDENTITY(1,1) PRIMARY KEY,

    region VARCHAR(100) NOT NULL,

    county VARCHAR(100) NOT NULL,

    sector_name VARCHAR(100),

    zone_name VARCHAR(100),

    itinerary VARCHAR(100),

    business_unit VARCHAR(100),

    office_name VARCHAR(100),

    reading_unit VARCHAR(100),

    supply_location VARCHAR(255),

    latitude DECIMAL(10,7),

    longitude DECIMAL(10,7),

    created_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME(),

    updated_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME()
);

GO