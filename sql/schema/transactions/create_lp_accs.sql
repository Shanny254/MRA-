/*
------------------------------------------------------------
Project : MRA ETL
Database: MRAs
Table   : lp_accs
Purpose : Stores Large Power customer information.
------------------------------------------------------------
*/

USE MRAs;
GO

CREATE TABLE lp_accs
(
    lp_account_id BIGINT IDENTITY(1,1) PRIMARY KEY,

    account_number VARCHAR(20) NOT NULL,

    old_account_number VARCHAR(20),

    customer_name VARCHAR(255),

    meter_number VARCHAR(20),

    region VARCHAR(100),

    county VARCHAR(100),

    tariff VARCHAR(50),

    contract_status VARCHAR(100),

    route_reference VARCHAR(100),

    recent_communication_time DATETIME2,

    communication_interval_days INT,

    communication_status VARCHAR(100),

    staff_assigned VARCHAR(255),

    created_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME()
);

GO