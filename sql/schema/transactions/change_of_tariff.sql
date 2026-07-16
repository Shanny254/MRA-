/*
------------------------------------------------------------
Project : MRA ETL
Database: MRA
Table   : change_of_tariff
Purpose : Stores customer tariff change history.
------------------------------------------------------------
*/

USE MRA;
GO

CREATE TABLE change_of_tariff
(
    tariff_change_id BIGINT IDENTITY(1,1) PRIMARY KEY,

    account_number VARCHAR(20) NOT NULL,

    previous_tariff VARCHAR(50),

    new_tariff VARCHAR(50),

    change_date DATE,

    reason_for_change VARCHAR(255),

    approved_by VARCHAR(100),

    remarks VARCHAR(1000),

    created_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME(),

    updated_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME()
);

GO