/*
------------------------------------------------------------
Project : MRA ETL
Database: MRAs
Table   : ordinary_debtlist
Purpose : Stores ordinary customer debt information.
------------------------------------------------------------
*/

USE MRAs;
GO

CREATE TABLE ordinary_debtlist
(
    debt_id BIGINT IDENTITY(1,1) PRIMARY KEY,

    account_number VARCHAR(20) NOT NULL,

    customer_name VARCHAR(255),

    meter_number VARCHAR(20),

    region VARCHAR(100),

    county VARCHAR(100),

    sector_name VARCHAR(100),

    zone_name VARCHAR(100),

    office_name VARCHAR(100),

    business_unit VARCHAR(100),

    reading_unit VARCHAR(100),

    contract_status VARCHAR(100),

    termination_date DATE,

    customer_type VARCHAR(100),

    customer_category VARCHAR(100),

    last_monthly_bill DECIMAL(18,2),

    overdue_amount DECIMAL(18,2),

    debt DECIMAL(18,2),

    credit DECIMAL(18,2),

    total_balance DECIMAL(18,2),

    max_due_date DATE,

    tariff VARCHAR(50),

    classification VARCHAR(100),

    deposit DECIMAL(18,2),

    stima_loan_balance DECIMAL(18,2),

    work_order_number VARCHAR(50),

    work_order_type VARCHAR(100),

    work_order_status VARCHAR(100),

    work_order_age_days INT,

    latitude DECIMAL(10,8),

    longitude DECIMAL(11,8),

    created_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME()
);

GO