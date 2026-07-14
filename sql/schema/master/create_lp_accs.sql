/*
------------------------------------------------------------
Project : MRA ETL
Database: MRAs
Table   : lp_accs
Purpose : Stores large power customer account information.
------------------------------------------------------------
*/

USE MRAs;
GO

CREATE TABLE lp_accs
(
    lp_account_id BIGINT IDENTITY(1,1) PRIMARY KEY,

    account_number VARCHAR(20) NOT NULL,
    old_account_number VARCHAR(20),

    tariff VARCHAR(50),

    contract_status VARCHAR(50),

    route_reference VARCHAR(100),

    recent_communication_time DATETIME,

    communication_interval_days INT,

    communication_status VARCHAR(50),

    staff_assigned VARCHAR(100),

    created_at DATETIME2 DEFAULT SYSDATETIME()
);

GO