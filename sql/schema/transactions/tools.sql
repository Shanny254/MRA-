/*
------------------------------------------------------------
Project : MRA ETL
Database: MRA
Table   : tools
Purpose : Stores tools assigned to KPLC staff.
------------------------------------------------------------
*/

USE MRA;
GO

CREATE TABLE tools
(
    tool_assignment_id BIGINT IDENTITY(1,1) PRIMARY KEY,

    staff_no VARCHAR(20) NOT NULL,

    clamp_meter VARCHAR(100),

    digital_multimeter VARCHAR(100),

    phase_sequence VARCHAR(100),

    screw_driver_set VARCHAR(100),

    allen_keys_set VARCHAR(100),

    adjustable_spanner VARCHAR(100),

    voltage_tester VARCHAR(100),

    non_contact_voltage_tester VARCHAR(100),

    hacksaw VARCHAR(100),

    retractable_knife VARCHAR(100),

    pliers_set VARCHAR(100),

    loop_impedance_tester VARCHAR(100),

    cordless_drill VARCHAR(100),

    handheld_terminal VARCHAR(100),

    kplc_simcard VARCHAR(100),

    mileage VARCHAR(100),

    dust_coat VARCHAR(100),

    safety_boot VARCHAR(100),

    helmet VARCHAR(100),

    electrical_gloves VARCHAR(100),

    created_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME(),

    updated_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME()
);

GO