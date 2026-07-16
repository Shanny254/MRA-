/*
------------------------------------------------------------
Project : MRA ETL
Database: MRA
Table   : zero_cons
Purpose : Stores zero consumption analysis records.
------------------------------------------------------------
*/

USE MRA;
GO

CREATE TABLE zero_cons
(
    zero_cons_id BIGINT IDENTITY(1,1) PRIMARY KEY,

    account_number VARCHAR(20) NOT NULL,

    billing_period DATE,

    consecutive_zero_months INT,

    average_previous_consumption DECIMAL(18,2),

    current_consumption DECIMAL(18,2),

    suspected_reason VARCHAR(255),

    investigation_status VARCHAR(100),

    remarks VARCHAR(1000),

    created_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME(),

    updated_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME()
);

GO