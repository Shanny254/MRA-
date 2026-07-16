/*
------------------------------------------------------------
Project : MRA ETL
Database: MRA
Table   : ordinary_debtlist
Purpose : Stores debt information for ordinary customer accounts.
------------------------------------------------------------
*/

USE MRA;
GO

CREATE TABLE ordinary_debtlist
(
    debt_id BIGINT IDENTITY(1,1) PRIMARY KEY,

    account_number VARCHAR(20) NOT NULL,

    termination_date DATE,

    customer_type VARCHAR(100),

    customer_category VARCHAR(100),

    last_monthly_bill DECIMAL(18,2),

    overdue_amount DECIMAL(18,2),

    debt DECIMAL(18,2),

    credit DECIMAL(18,2),

    total_balance DECIMAL(18,2),

    max_due_date DATE,

    classification VARCHAR(100),

    deposit DECIMAL(18,2),

    stimaloan_balance DECIMAL(18,2),

    work_order_number VARCHAR(100),

    work_order_type VARCHAR(100),

    work_order_status VARCHAR(100),

    work_order_age_days INT,

    created_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME(),

    updated_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME()
);

GO