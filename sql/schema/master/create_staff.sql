/*
------------------------------------------------------------
Project : MRA ETL
Database: MRAs
Table   : staff
Purpose : Stores KPLC staff information.
------------------------------------------------------------
*/

USE MRAs;
GO

CREATE TABLE staff
(
    staff_no VARCHAR(20) NOT NULL PRIMARY KEY,

    staff_name VARCHAR(255) NOT NULL,

    county VARCHAR(100),

    workstation VARCHAR(100),

    section_name VARCHAR(100),

    created_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME()
);

GO