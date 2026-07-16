/*
------------------------------------------------------------
Project : MRA ETL
Database: MRA
Table   : staff
Purpose : Master table for all KPLC staff.
------------------------------------------------------------
*/

USE MRA;
GO

CREATE TABLE staff
(
    staff_no VARCHAR(20) NOT NULL PRIMARY KEY,

    staff_name VARCHAR(255),

    county VARCHAR(100),

    workstation VARCHAR(100),

    section_name VARCHAR(100),

    created_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME(),

    updated_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME()
);

GO