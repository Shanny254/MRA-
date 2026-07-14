CREATE TABLE dbo.staff
(
    staff_no VARCHAR(50) NOT NULL PRIMARY KEY,

    staff_name VARCHAR(255) NOT NULL,

    county VARCHAR(100) NULL,

    work_station VARCHAR(100) NULL,

    section VARCHAR(100) NULL,

    created_at DATETIME2 NOT NULL
        DEFAULT GETDATE()
);