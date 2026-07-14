/*
------------------------------------------------------------
Project : MRA ETL
Database: MRAs
Table   : admd
Purpose : Stores ADMD inspection information.
------------------------------------------------------------
*/

USE MRAs;
GO

CREATE TABLE admd
(
    admd_id BIGINT IDENTITY(1,1) PRIMARY KEY,

    account_number VARCHAR(20) NOT NULL,

    staff_no VARCHAR(20),

    county VARCHAR(100),

    kva_demand DECIMAL(18,2),

    kva_contract DECIMAL(18,2),

    difference DECIMAL(18,2),

    remarks VARCHAR(500),

    created_at DATETIME2 DEFAULT SYSDATETIME()
);

GO