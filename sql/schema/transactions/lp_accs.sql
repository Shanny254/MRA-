/*
------------------------------------------------------------
Project : MRA ETL
Database: MRA
Table   : lp_accs
Purpose : Stores Large Power account communication records.
------------------------------------------------------------
*/

USE MRA;
GO

CREATE TABLE lp_accs
(
    lp_acc_id BIGINT IDENTITY(1,1) PRIMARY KEY,

    account_number VARCHAR(20) NOT NULL,

    meter_number VARCHAR(30),

    route_reference VARCHAR(100),

    communication_status VARCHAR(100),

    recent_communication_time DATETIME2,

    communication_interval_days INT,

    staff_assigned VARCHAR(255),

    created_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME(),

    updated_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME()
);

GO