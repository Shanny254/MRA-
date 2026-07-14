/*
------------------------------------------------------------
Project : MRA ETL
Database: MRAs
Table   : ordinary_acs_meter_rdg
Purpose : Stores ordinary ACS meter reading records.
------------------------------------------------------------
*/

USE MRAs;
GO

CREATE TABLE ordinary_acs_meter_rdg
(
    reading_id BIGINT IDENTITY(1,1) PRIMARY KEY,

    account_number VARCHAR(20) NOT NULL,

    billing_period DATE,

    tariff VARCHAR(50),

    billing_type VARCHAR(50),

    billed_units DECIMAL(18,2),

    reading_from_meter DECIMAL(18,2),

    previous_reading DECIMAL(18,2),

    reader_code VARCHAR(50),

    meter_reader VARCHAR(100),

    estimated_reading BIT,

    self_read BIT,

    times_billed_zero INT,

    usage_type VARCHAR(100),

    created_at DATETIME2 DEFAULT SYSDATETIME()
);

GO