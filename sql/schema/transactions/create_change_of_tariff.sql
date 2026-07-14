/*
------------------------------------------------------------
Project : MRA ETL
Database: MRAs
Table   : change_of_tariff
Purpose : Stores tariff change recommendations.
------------------------------------------------------------
*/

USE MRAs;
GO

CREATE TABLE change_of_tariff
(
    tariff_change_id BIGINT IDENTITY(1,1) PRIMARY KEY,

    account_number VARCHAR(20) NOT NULL,

    customer_name VARCHAR(255),

    meter_number VARCHAR(20),

    staff_no VARCHAR(20),

    region VARCHAR(100),

    county VARCHAR(100),

    tariff VARCHAR(50),

    tariff_range VARCHAR(100),

    average_consumption DECIMAL(18,2),

    contract_status VARCHAR(100),

    remarks VARCHAR(500),

    created_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME()
);

GO