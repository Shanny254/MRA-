/*
------------------------------------------------------------
Project : MRA ETL
Database: MRA
Table   : lp_debt
Purpose : Stores Large Power debt information.
------------------------------------------------------------
*/

USE MRA;
GO

CREATE TABLE lp_debt
(
    lp_debt_id BIGINT IDENTITY(1,1) PRIMARY KEY,

    account_number VARCHAR(20) NOT NULL,

    bill_month DATE,

    overdue_amount DECIMAL(18,2),

    current_balance DECIMAL(18,2),

    debt_amount DECIMAL(18,2),

    credit_amount DECIMAL(18,2),

    total_balance DECIMAL(18,2),

    last_payment_date DATE,

    last_payment_amount DECIMAL(18,2),

    debt_age_days INT,

    created_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME(),

    updated_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME()
);

GO