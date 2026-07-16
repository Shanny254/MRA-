/*
------------------------------------------------------------
Project : MRA ETL
Database: MRA
Table   : admd
Purpose : Stores ADMD inspection and analysis records.
------------------------------------------------------------
*/

USE MRA;
GO

CREATE TABLE admd
(
    admd_id BIGINT IDENTITY(1,1) PRIMARY KEY,

    account_number VARCHAR(20) NOT NULL,

    inspection_date DATE,

    current_admd DECIMAL(18,2),

    previous_admd DECIMAL(18,2),

    admd_variance DECIMAL(18,2),

    admd_status VARCHAR(100),

    remarks VARCHAR(1000),

    created_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME(),

    updated_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME()
);

GO