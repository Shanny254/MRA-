/*
------------------------------------------------------------
Project : MRA ETL
Database: MRA
Table   : load_factor
Purpose : Stores customer load factor analysis records.
------------------------------------------------------------
*/

USE MRA;
GO

CREATE TABLE load_factor
(
    load_factor_id BIGINT IDENTITY(1,1) PRIMARY KEY,

    account_number VARCHAR(20) NOT NULL,

    analysis_period DATE,

    maximum_demand DECIMAL(18,2),

    average_load DECIMAL(18,2),

    load_factor DECIMAL(18,4),

    utilization_percentage DECIMAL(5,2),

    analysis_status VARCHAR(100),

    remarks VARCHAR(1000),

    created_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME(),

    updated_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME()
);

GO