/*
------------------------------------------------------------
Project : MRA ETL
Database: MRA
Table   : ordinary_acs_meter_rdg
Purpose : Stores ordinary customer meter reading records.
------------------------------------------------------------
*/

USE MRA;
GO

CREATE TABLE ordinary_acs_meter_rdg
(
    reading_id BIGINT IDENTITY(1,1) PRIMARY KEY,

    account_number VARCHAR(20) NOT NULL,

    meter_number VARCHAR(30),

    previous_reading DECIMAL(18,2),

    current_reading DECIMAL(18,2),

    consumption DECIMAL(18,2),

    reading_date DATE,

    read_status VARCHAR(100),

    reader_code VARCHAR(50),

    meter_reader VARCHAR(255),

    reading_from_meter VARCHAR(50),

    previous_value DECIMAL(18,2),

    estimated_reading BIT,

    self_read BIT,

    usage_type VARCHAR(100),

    created_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME(),

    updated_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME()
);

GO