/*
------------------------------------------------------------
Project : MRA ETL
Database: MRAs
Purpose : Creates the MRAs database.
------------------------------------------------------------
*/

IF DB_ID('MRAs') IS NULL
BEGIN
    CREATE DATABASE MRAs;
END;
GO

USE MRAs;
GO