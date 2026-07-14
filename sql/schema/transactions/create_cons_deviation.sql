/*
------------------------------------------------------------
Project : MRA ETL
Database: MRAs
Table   : cons_deviation
Purpose : Stores consumption deviation analysis.
------------------------------------------------------------
*/

USE MRAs;
GO

CREATE TABLE cons_deviation
(
    deviation_id BIGINT IDENTITY(1,1) PRIMARY KEY,

    account_number VARCHAR(20) NOT NULL,

    customer_name VARCHAR(255),

    meter_number VARCHAR(20),

    staff_no VARCHAR(20),

    region VARCHAR(100),

    county VARCHAR(100),

    tariff VARCHAR(50),

    average_consumption DECIMAL(18,2),

    current_cycle DECIMAL(18,2),

    previous_cycle DECIMAL(18,2),

    percentage_difference DECIMAL(18,2),

    payment_form VARCHAR(100),

    remarks VARCHAR(500),

    created_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME()
);

GO