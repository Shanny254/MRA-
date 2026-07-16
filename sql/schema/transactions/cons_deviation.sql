/*
------------------------------------------------------------
Project : MRA ETL
Database: MRA
Table   : cons_deviation
Purpose : Stores customer consumption deviation analysis.
------------------------------------------------------------
*/

USE MRA;
GO

CREATE TABLE cons_deviation
(
    cons_deviation_id BIGINT IDENTITY(1,1) PRIMARY KEY,

    account_number VARCHAR(20) NOT NULL,

    analysis_period DATE,

    previous_consumption DECIMAL(18,2),

    current_consumption DECIMAL(18,2),

    consumption_difference DECIMAL(18,2),

    percentage_change DECIMAL(18,2),

    deviation_status VARCHAR(100),

    remarks VARCHAR(1000),

    created_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME(),

    updated_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME()
);

GO