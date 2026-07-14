/*
------------------------------------------------------------
Project : MRA ETL
Database: MRAs
Table   : lp_debt
Purpose : Stores large power customer debt information.
------------------------------------------------------------
*/

USE MRAs;
GO

CREATE TABLE lp_debt
(
    lp_debt_id BIGINT IDENTITY(1,1) PRIMARY KEY,

    account_number VARCHAR(20) NOT NULL,

    region VARCHAR(100),

    county VARCHAR(100),

    office_name VARCHAR(100),

    contract_status VARCHAR(100),

    customer_type VARCHAR(100),

    customer_category VARCHAR(100),

    supply_location VARCHAR(255),

    tariff VARCHAR(50),

    last_monthly_bill DECIMAL(18,2),

    vat DECIMAL(18,2),

    overdue_amount DECIMAL(18,2),

    debt DECIMAL(18,2),

    max_due_date DATE,

    admd DECIMAL(18,2),

    average_six_month_bill DECIMAL(18,2),

    deposit_amount DECIMAL(18,2),

    guarantee_amount DECIMAL(18,2),

    created_at DATETIME2 DEFAULT SYSDATETIME()
);

GO