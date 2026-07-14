/*
------------------------------------------------------------
Project : MRA ETL
Database: MRAs
Table   : tools
Purpose : Stores tools assigned to KPLC staff.
------------------------------------------------------------
*/

USE MRAs;
GO

CREATE TABLE tools
(
    staff_no VARCHAR(20) NOT NULL PRIMARY KEY,

    county VARCHAR(100),

    workstation VARCHAR(100),

    section_name VARCHAR(100),

    staff_name VARCHAR(255),

    clamp_meter BIT,

    digital_multimeter BIT,

    phase_sequence BIT,

    screw_driver_set BIT,

    allen_keys_set BIT,

    adjustable_spanner BIT,

    voltage_tester BIT,

    non_contact_voltage_tester BIT,

    hacksaw BIT,

    retractable_knife BIT,

    pliers_set BIT,

    loop_impedance_tester BIT,

    cordless_drill BIT,

    handheld_terminal BIT,

    kplc_simcard BIT,

    mileage DECIMAL(10,2),

    dust_coat BIT,

    safety_boot BIT,

    helmet BIT,

    electrical_gloves BIT,

    created_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME()
);

GO