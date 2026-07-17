/*
------------------------------------------------------------
Project : MRA ETL
Database: MRA
Table   : customer_account
Purpose : Stores one record for each KPLC customer account.
------------------------------------------------------------
*/

USE MRA;
GO

CREATE TABLE customer_account
(
    account_number VARCHAR(20) NOT NULL
        PRIMARY KEY,

    old_account_number VARCHAR(20),

    customer_name VARCHAR(255) NOT NULL,

    meter_number VARCHAR(30),

    tariff VARCHAR(50),

    contract_status VARCHAR(100),

    created_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME(),

    updated_at DATETIME2 NULL
);

GO

/*
------------------------------------------------------------
Project : MRA ETL
Database: MRA
Table   : location
Purpose : Master table for KPLC geographical hierarchy.
------------------------------------------------------------
*/

USE MRA;
GO

CREATE TABLE location
(
    location_id INT IDENTITY(1,1) PRIMARY KEY,

    region VARCHAR(100) NOT NULL,

    county VARCHAR(100) NOT NULL,

    sector_name VARCHAR(100),

    zone_name VARCHAR(100),

    itinerary VARCHAR(100),

    business_unit VARCHAR(100),

    office_name VARCHAR(100),

    reading_unit VARCHAR(100),

    supply_location VARCHAR(255),

    latitude DECIMAL(10,7),

    longitude DECIMAL(10,7),

    created_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME(),

    updated_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME()
);

GO


/*
------------------------------------------------------------
Project : MRA ETL
Database: MRA
Table   : meter
Purpose : Master table for all KPLC meters.
------------------------------------------------------------
*/

USE MRA;
GO

CREATE TABLE meter
(
    meter_number VARCHAR(30) NOT NULL PRIMARY KEY,

    meter_serial_number VARCHAR(50),

    meter_type VARCHAR(50),

    meter_phase_type VARCHAR(50),

    model_name VARCHAR(100),

    mark_name VARCHAR(100),

    created_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME(),

    updated_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME()
);

GO

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

/*
------------------------------------------------------------
Project : MRA ETL
Database: MRA
Table   : admd
Purpose : Stores ADMD inspection and analysis records.
------------------------------------------------------------
*/

USE MRA;
GO

CREATE TABLE admd
(
    admd_id BIGINT IDENTITY(1,1) PRIMARY KEY,

    account_number VARCHAR(20) NOT NULL,

    inspection_date DATE,

    current_admd DECIMAL(18,2),

    previous_admd DECIMAL(18,2),

    admd_variance DECIMAL(18,2),

    admd_status VARCHAR(100),

    remarks VARCHAR(1000),

    created_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME(),

    updated_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME()
);

GO

/*
------------------------------------------------------------
Project : MRA ETL
Database: MRA
Table   : change_of_tariff
Purpose : Stores customer tariff change history.
------------------------------------------------------------
*/

USE MRA;
GO

CREATE TABLE change_of_tariff
(
    tariff_change_id BIGINT IDENTITY(1,1) PRIMARY KEY,

    account_number VARCHAR(20) NOT NULL,

    previous_tariff VARCHAR(50),

    new_tariff VARCHAR(50),

    change_date DATE,

    reason_for_change VARCHAR(255),

    approved_by VARCHAR(100),

    remarks VARCHAR(1000),

    created_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME(),

    updated_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME()
);

GO

/*
------------------------------------------------------------
Project : MRA ETL
Database: MRA
Table   : cons_deviation
Purpose : Stores customer consumption deviation analysis.
------------------------------------------------------------
*/

USE MRA;
GO

CREATE TABLE cons_deviation
(
    cons_deviation_id BIGINT IDENTITY(1,1) PRIMARY KEY,

    account_number VARCHAR(20) NOT NULL,

    analysis_period DATE,

    previous_consumption DECIMAL(18,2),

    current_consumption DECIMAL(18,2),

    consumption_difference DECIMAL(18,2),

    percentage_change DECIMAL(18,2),

    deviation_status VARCHAR(100),

    remarks VARCHAR(1000),

    created_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME(),

    updated_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME()
);

GO

/*
------------------------------------------------------------
Project : MRA ETL
Database: MRA
Table   : load_factor
Purpose : Stores customer load factor analysis records.
------------------------------------------------------------
*/

USE MRA;
GO

CREATE TABLE load_factor
(
    load_factor_id BIGINT IDENTITY(1,1) PRIMARY KEY,

    account_number VARCHAR(20) NOT NULL,

    analysis_period DATE,

    maximum_demand DECIMAL(18,2),

    average_load DECIMAL(18,2),

    load_factor DECIMAL(18,4),

    utilization_percentage DECIMAL(5,2),

    analysis_status VARCHAR(100),

    remarks VARCHAR(1000),

    created_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME(),

    updated_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME()
);

GO

/*
------------------------------------------------------------
Project : MRA ETL
Database: MRA
Table   : lp_accs
Purpose : Stores Large Power account communication records.
------------------------------------------------------------
*/

USE MRA;
GO

CREATE TABLE lp_accs
(
    lp_acc_id BIGINT IDENTITY(1,1) PRIMARY KEY,

    account_number VARCHAR(20) NOT NULL,

    meter_number VARCHAR(30),

    route_reference VARCHAR(100),

    communication_status VARCHAR(100),

    recent_communication_time DATETIME2,

    communication_interval_days INT,

    staff_assigned VARCHAR(255),

    created_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME(),

    updated_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME()
);

GO

/*
------------------------------------------------------------
Project : MRA ETL
Database: MRA
Table   : lp_accs
Purpose : Stores Large Power account communication records.
------------------------------------------------------------
*/

USE MRA;
GO

CREATE TABLE lp_accs
(
    lp_acc_id BIGINT IDENTITY(1,1) PRIMARY KEY,

    account_number VARCHAR(20) NOT NULL,

    meter_number VARCHAR(30),

    route_reference VARCHAR(100),

    communication_status VARCHAR(100),

    recent_communication_time DATETIME2,

    communication_interval_days INT,

    staff_assigned VARCHAR(255),

    created_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME(),

    updated_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME()
);

GO

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

/*
------------------------------------------------------------
Project : MRA ETL
Database: MRA
Table   : offline_meters_cycle_reading
Purpose : Stores field inspection and cycle reading records.
------------------------------------------------------------
*/

USE MRA;
GO

CREATE TABLE offline_meters_cycle_reading
(
    inspection_id BIGINT IDENTITY(1,1) PRIMARY KEY,

    account_number VARCHAR(20) NOT NULL,

    meter_number VARCHAR(30) NOT NULL,

    staff_no VARCHAR(20) NOT NULL,

    inspection_date DATE,

    campaign_type VARCHAR(100),

    inspection_status VARCHAR(100),

    validation_status VARCHAR(100),

    operation VARCHAR(100),

    meter_serial_number_input VARCHAR(50),

    meter_phase_type VARCHAR(50),

    model_name VARCHAR(100),

    mark_name VARCHAR(100),

    meter_type VARCHAR(50),

    system_payment VARCHAR(50),

    payment_mode VARCHAR(50),

    total_reading DECIMAL(18,2),

    high_rate_reading DECIMAL(18,2),

    low_rate_reading DECIMAL(18,2),

    kva_reading DECIMAL(18,2),

    kw_reading DECIMAL(18,2),

    kva DECIMAL(18,2),

    kwh DECIMAL(18,2),

    earth_current DECIMAL(18,2),

    number_of_meters_on_site INT,

    overdue_debt DECIMAL(18,2),

    revenue_collected DECIMAL(18,2),

    has_overdue_debt BIT,

    tampered_meter BIT,

    faulty_meter BIT,

    idle_meter BIT,

    bypassed_meter BIT,

    read_status VARCHAR(100),

    remarks VARCHAR(1000),

    sim_serial VARCHAR(50),

    created_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME(),

    updated_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME()
);

GO

/*
------------------------------------------------------------
Project : MRA ETL
Database: MRA
Table   : offline_smart_meters
Purpose : Stores offline smart meter communication records.
------------------------------------------------------------
*/

USE MRA;
GO

CREATE TABLE offline_smart_meters
(
    offline_meter_id BIGINT IDENTITY(1,1) PRIMARY KEY,

    account_number VARCHAR(20) NOT NULL,

    staff_no VARCHAR(20) NULL,

    meter_number VARCHAR(30) NULL,

    meter_type VARCHAR(100) NULL,

    communication_status VARCHAR(100) NULL,

    last_communication_time DATETIME2 NULL,

    latitude DECIMAL(10,8) NULL,

    longitude DECIMAL(11,8) NULL,

    created_at DATETIME2 NOT NULL
        CONSTRAINT DF_offline_smart_meters_created_at
        DEFAULT SYSDATETIME()
);

GO

/*
------------------------------------------------------------
Project : MRA ETL
Database: MRA
Table   : ordinary_acs_meter_rdg
Purpose : Stores ordinary customer meter reading records.
------------------------------------------------------------
*/

USE MRA;
GO

CREATE TABLE ordinary_acs_meter_rdg
(
    reading_id BIGINT IDENTITY(1,1) PRIMARY KEY,

    account_number VARCHAR(20) NOT NULL,

    meter_number VARCHAR(30),

    previous_reading DECIMAL(18,2),

    current_reading DECIMAL(18,2),

    consumption DECIMAL(18,2),

    reading_date DATE,

    read_status VARCHAR(100),

    reader_code VARCHAR(50),

    meter_reader VARCHAR(255),

    reading_from_meter VARCHAR(50),

    previous_value DECIMAL(18,2),

    estimated_reading BIT,

    self_read BIT,

    usage_type VARCHAR(100),

    created_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME(),

    updated_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME()
);

GO

/*
------------------------------------------------------------
Project : MRA ETL
Database: MRA
Table   : ordinary_debtlist
Purpose : Stores debt information for ordinary customer accounts.
------------------------------------------------------------
*/

USE MRA;
GO

CREATE TABLE ordinary_debtlist
(
    debt_id BIGINT IDENTITY(1,1) PRIMARY KEY,

    account_number VARCHAR(20) NOT NULL,

    termination_date DATE,

    customer_type VARCHAR(100),

    customer_category VARCHAR(100),

    last_monthly_bill DECIMAL(18,2),

    overdue_amount DECIMAL(18,2),

    debt DECIMAL(18,2),

    credit DECIMAL(18,2),

    total_balance DECIMAL(18,2),

    max_due_date DATE,

    classification VARCHAR(100),

    deposit DECIMAL(18,2),

    stimaloan_balance DECIMAL(18,2),

    work_order_number VARCHAR(100),

    work_order_type VARCHAR(100),

    work_order_status VARCHAR(100),

    work_order_age_days INT,

    created_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME(),

    updated_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME()
);

GO

/*
------------------------------------------------------------
Project : MRA ETL
Database: MRA
Table   : pf_1st_time
Purpose : Stores first-time Power Factor (PF) inspection records.
------------------------------------------------------------
*/

USE MRA;
GO

CREATE TABLE pf_1st_time
(
    pf_1st_time_id BIGINT IDENTITY(1,1) PRIMARY KEY,

    account_number VARCHAR(20) NOT NULL,

    inspection_date DATE,

    current_power_factor DECIMAL(5,2),

    target_power_factor DECIMAL(5,2),

    reactive_power DECIMAL(18,2),

    apparent_power DECIMAL(18,2),

    pf_status VARCHAR(100),

    recommendation VARCHAR(1000),

    remarks VARCHAR(1000),

    created_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME(),

    updated_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME()
);

GO

/*
------------------------------------------------------------
Project : MRA ETL
Database: MRA
Table   : poor_pf
Purpose : Stores poor Power Factor analysis records.
------------------------------------------------------------
*/

USE MRA;
GO

CREATE TABLE poor_pf
(
    poor_pf_id BIGINT IDENTITY(1,1) PRIMARY KEY,

    account_number VARCHAR(20) NOT NULL,

    inspection_date DATE,

    power_factor DECIMAL(5,2),

    reactive_power DECIMAL(18,2),

    apparent_power DECIMAL(18,2),

    active_power DECIMAL(18,2),

    power_loss DECIMAL(18,2),

    penalty_amount DECIMAL(18,2),

    correction_required BIT,

    correction_status VARCHAR(100),

    recommendation VARCHAR(1000),

    remarks VARCHAR(1000),

    created_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME(),

    updated_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME()
);

GO

/*
------------------------------------------------------------
Project : MRA ETL
Database: MRA
Table   : postpaid_billing
Purpose : Stores monthly postpaid billing information.
------------------------------------------------------------
*/

USE MRA;
GO

CREATE TABLE postpaid_billing
(
    billing_id BIGINT IDENTITY(1,1) PRIMARY KEY,

    account_number VARCHAR(20) NOT NULL,

    bill_month DATE NOT NULL,

    units_billed DECIMAL(18,2),

    amount_billed DECIMAL(18,2),

    amount_paid DECIMAL(18,2),

    balance DECIMAL(18,2),

    tariff VARCHAR(50),

    contract_status VARCHAR(100),

    created_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME(),

    updated_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME()
);

GO

/*
------------------------------------------------------------
Project : MRA ETL
Database: MRA
Table   : smart_meter_billing
Purpose : Stores smart meter billing readings.
------------------------------------------------------------
*/

USE MRA;
GO

CREATE TABLE smart_meter_billing
(
    billing_id BIGINT IDENTITY(1,1) PRIMARY KEY,

    account_number VARCHAR(20) NOT NULL,

    meter_number VARCHAR(30),

    previous_active_energy DECIMAL(18,2),

    current_active_energy DECIMAL(18,2),

    previous_high_rate DECIMAL(18,2),

    current_high_rate DECIMAL(18,2),

    previous_low_rate DECIMAL(18,2),

    current_low_rate DECIMAL(18,2),

    previous_kw DECIMAL(18,2),

    current_kw DECIMAL(18,2),

    previous_kva DECIMAL(18,2),

    current_kva DECIMAL(18,2),

    total_consumption DECIMAL(18,2),

    total_amount DECIMAL(18,2),

    read_status VARCHAR(100),

    created_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME(),

    updated_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME()
);

GO

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

/*
------------------------------------------------------------
Project : MRA ETL
Database: MRA
Table   : zero_cons
Purpose : Stores zero consumption analysis records.
------------------------------------------------------------
*/

USE MRA;
GO

CREATE TABLE zero_cons
(
    zero_cons_id BIGINT IDENTITY(1,1) PRIMARY KEY,

    account_number VARCHAR(20) NOT NULL,

    billing_period DATE,

    consecutive_zero_months INT,

    average_previous_consumption DECIMAL(18,2),

    current_consumption DECIMAL(18,2),

    suspected_reason VARCHAR(255),

    investigation_status VARCHAR(100),

    remarks VARCHAR(1000),

    created_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME(),

    updated_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME()
);

GO