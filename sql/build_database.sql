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


/*
------------------------------------------------------------
Project : MRA ETL
Database: MRAs
Table   : accounts
Purpose : Stores the master customer account information.
------------------------------------------------------------
*/

USE MRAs;
GO

CREATE TABLE customer_accounts
(
    account_number VARCHAR(20) NOT NULL PRIMARY KEY,

    old_account_number VARCHAR(20),

    customer_name VARCHAR(255) NOT NULL,

    meter_number VARCHAR(20),

    region VARCHAR(100),

    county VARCHAR(100),

    sector_name VARCHAR(100),

    zone_name VARCHAR(100),

    itinerary VARCHAR(100),

    tariff VARCHAR(50),

    contract_status VARCHAR(100),

    created_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME()
);

GO


/*
------------------------------------------------------------
Project : MRA ETL
Database: MRAs
Table   : lp_accs
Purpose : Stores Large Power customer information.
------------------------------------------------------------
*/

USE MRAs;
GO

CREATE TABLE lp_accs
(
    lp_account_id BIGINT IDENTITY(1,1) PRIMARY KEY,

    account_number VARCHAR(20) NOT NULL,

    old_account_number VARCHAR(20),

    customer_name VARCHAR(255),

    meter_number VARCHAR(20),

    region VARCHAR(100),

    county VARCHAR(100),

    tariff VARCHAR(50),

    contract_status VARCHAR(100),

    route_reference VARCHAR(100),

    recent_communication_time DATETIME2,

    communication_interval_days INT,

    communication_status VARCHAR(100),

    staff_assigned VARCHAR(255),

    created_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME()
);

GO


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

/*
------------------------------------------------------------
Project : MRA ETL
Database: MRAs
Table   : admd
Purpose : Stores ADMD inspection records.
------------------------------------------------------------
*/

USE MRAs;
GO

CREATE TABLE admd
(
    admd_id BIGINT IDENTITY(1,1) PRIMARY KEY,

    account_number VARCHAR(20) NOT NULL,

    customer_name VARCHAR(255),

    meter_number VARCHAR(20),

    staff_no VARCHAR(20),

    region VARCHAR(100),

    county VARCHAR(100),

    sector_name VARCHAR(100),

    zone_name VARCHAR(100),

    tariff VARCHAR(50),

    contract_status VARCHAR(100),

    kva_demand DECIMAL(18,2),

    kva_contract DECIMAL(18,2),

    difference DECIMAL(18,2),

    remarks VARCHAR(500),

    created_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME()
);

GO

/*
------------------------------------------------------------
Project : MRA ETL
Database: MRAs
Table   : change_of_tariff
Purpose : Stores tariff change recommendations.
------------------------------------------------------------
*/

USE MRAs;
GO

CREATE TABLE change_of_tariff
(
    tariff_change_id BIGINT IDENTITY(1,1) PRIMARY KEY,

    account_number VARCHAR(20) NOT NULL,

    customer_name VARCHAR(255),

    meter_number VARCHAR(20),

    staff_no VARCHAR(20),

    region VARCHAR(100),

    county VARCHAR(100),

    tariff VARCHAR(50),

    tariff_range VARCHAR(100),

    average_consumption DECIMAL(18,2),

    contract_status VARCHAR(100),

    remarks VARCHAR(500),

    created_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME()
);

GO

/*
------------------------------------------------------------
Project : MRA ETL
Database: MRAs
Table   : cons_deviation
Purpose : Stores consumption deviation analysis.
------------------------------------------------------------
*/

USE MRAs;
GO

CREATE TABLE cons_deviation
(
    deviation_id BIGINT IDENTITY(1,1) PRIMARY KEY,

    account_number VARCHAR(20) NOT NULL,

    customer_name VARCHAR(255),

    meter_number VARCHAR(20),

    staff_no VARCHAR(20),

    region VARCHAR(100),

    county VARCHAR(100),

    tariff VARCHAR(50),

    average_consumption DECIMAL(18,2),

    current_cycle DECIMAL(18,2),

    previous_cycle DECIMAL(18,2),

    percentage_difference DECIMAL(18,2),

    payment_form VARCHAR(100),

    remarks VARCHAR(500),

    created_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME()
);

GO

/*
------------------------------------------------------------
Project : MRA ETL
Database: MRAs
Table   : load_factor
Purpose : Stores load factor analysis.
------------------------------------------------------------
*/

USE MRAs;
GO

CREATE TABLE load_factor
(
    load_factor_id BIGINT IDENTITY(1,1) PRIMARY KEY,

    account_number VARCHAR(20) NOT NULL,

    customer_name VARCHAR(255),

    meter_number VARCHAR(20),

    staff_no VARCHAR(20),

    region VARCHAR(100),

    county VARCHAR(100),

    tariff VARCHAR(50),

    contract_status VARCHAR(100),

    high_rate DECIMAL(18,2),

    low_rate DECIMAL(18,2),

    kva_demand DECIMAL(18,2),

    kw_demand DECIMAL(18,2),

    load_factor DECIMAL(18,2),

    remarks VARCHAR(500),

    created_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME()
);

GO

/*
------------------------------------------------------------
Project : MRA ETL
Database: MRAs
Table   : lp_debt
Purpose : Stores Large Power customer debt information.
------------------------------------------------------------
*/

USE MRAs;
GO

CREATE TABLE lp_debt
(
    lp_debt_id BIGINT IDENTITY(1,1) PRIMARY KEY,

    account_number VARCHAR(20) NOT NULL,

    customer_name VARCHAR(255),

    meter_number VARCHAR(20),

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

    created_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME()
);

GO

/*
------------------------------------------------------------
Project : MRA ETL
Database: MRAs
Table   : offline_meters_cycle_reading
Purpose : Stores meter inspection and cycle reading information.
------------------------------------------------------------
*/

USE MRAs;
GO

CREATE TABLE offline_meters_cycle_reading
(
    inspection_id BIGINT IDENTITY(1,1) PRIMARY KEY,

    account_number VARCHAR(20) NOT NULL,

    customer_name VARCHAR(255),

    meter_number VARCHAR(20),

    staff_no VARCHAR(20),

    region VARCHAR(100),

    county VARCHAR(100),

    itinerary VARCHAR(100),

    model_name VARCHAR(100),

    meter_phase_type VARCHAR(50),

    campaign_type VARCHAR(100),

    system_payment VARCHAR(50),

    inspection_status VARCHAR(50),

    meter_serial_number_input VARCHAR(50),

    total_reading DECIMAL(18,2),

    high_rate_reading DECIMAL(18,2),

    low_rate_reading DECIMAL(18,2),

    kva_reading DECIMAL(18,2),

    kw_reading DECIMAL(18,2),

    remarks VARCHAR(500),

    sim_serial VARCHAR(50),

    operation VARCHAR(100),

    overdue_debt DECIMAL(18,2),

    revenue_collected DECIMAL(18,2),

    payment_mode VARCHAR(50),

    meter_type VARCHAR(50),

    has_overdue_debt BIT,

    tampered_meter BIT,

    faulty_meter BIT,

    idle_meter BIT,

    bypassed_meter BIT,

    kva DECIMAL(18,2),

    kwh DECIMAL(18,2),

    number_of_meters_on_site INT,

    earth_current DECIMAL(18,2),

    read_status VARCHAR(50),

    inspection_date DATE,

    validation_status VARCHAR(100),

    created_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME()
);

GO

/*
------------------------------------------------------------
Project : MRA ETL
Database: MRAs
Table   : offline_smart_meters
Purpose : Stores offline smart meter information.
------------------------------------------------------------
*/

USE MRAs;
GO

CREATE TABLE offline_smart_meters
(
    offline_meter_id BIGINT IDENTITY(1,1) PRIMARY KEY,

    account_number VARCHAR(20) NOT NULL,

    customer_name VARCHAR(255),

    meter_number VARCHAR(20),

    region VARCHAR(100),

    county VARCHAR(100),

    zone_name VARCHAR(100),

    itinerary VARCHAR(100),

    communication_status VARCHAR(100),

    model_name VARCHAR(100),

    meter_phase VARCHAR(50),

    contract_type VARCHAR(50),

    latitude DECIMAL(10,8),

    longitude DECIMAL(11,8),

    created_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME()
);

GO

/*
------------------------------------------------------------
Project : MRA ETL
Database: MRAs
Table   : ordinary_acs_meter_rdg
Purpose : Stores ordinary ACS meter reading information.
------------------------------------------------------------
*/

USE MRAs;
GO

CREATE TABLE ordinary_acs_meter_rdg
(
    reading_id BIGINT IDENTITY(1,1) PRIMARY KEY,

    account_number VARCHAR(20) NOT NULL,

    customer_name VARCHAR(255),

    meter_number VARCHAR(20),

    period INT,

    region VARCHAR(100),

    county VARCHAR(100),

    sector_name VARCHAR(100),

    zone_name VARCHAR(100),

    itinerary VARCHAR(100),

    tariff VARCHAR(50),

    billing_type VARCHAR(50),

    billed_units DECIMAL(18,2),

    reading_from_meter DECIMAL(18,2),

    previous_value DECIMAL(18,2),

    reader_code VARCHAR(50),

    meter_reader VARCHAR(150),

    estimated_reading BIT,

    self_read BIT,

    times_billed_zero INT,

    usage_type VARCHAR(100),

    created_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME()
);

GO

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

/*
------------------------------------------------------------
Project : MRA ETL
Database: MRAs
Table   : pf_1st_time
Purpose : Stores first-time power factor analysis.
------------------------------------------------------------
*/

USE MRAs;
GO

CREATE TABLE pf_1st_time
(
    pf_id BIGINT IDENTITY(1,1) PRIMARY KEY,

    account_number VARCHAR(20) NOT NULL,

    customer_name VARCHAR(255),

    meter_number VARCHAR(20),

    staff_no VARCHAR(20),

    region VARCHAR(100),

    county VARCHAR(100),

    tariff VARCHAR(50),

    supply_location VARCHAR(255),

    kva_units DECIMAL(18,2),

    kw_units DECIMAL(18,2),

    high_rate_units DECIMAL(18,2),

    low_rate_units DECIMAL(18,2),

    power_factor_amount DECIMAL(18,2),

    remarks VARCHAR(500),

    created_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME()
);

GO

/*
------------------------------------------------------------
Project : MRA ETL
Database: MRAs
Table   : poor_pf
Purpose : Stores poor power factor analysis.
------------------------------------------------------------
*/

USE MRAs;
GO

CREATE TABLE poor_pf
(
    poor_pf_id BIGINT IDENTITY(1,1) PRIMARY KEY,

    account_number VARCHAR(20) NOT NULL,

    customer_name VARCHAR(255),

    meter_number VARCHAR(20),

    staff_no VARCHAR(20),

    region VARCHAR(100),

    county VARCHAR(100),

    tariff VARCHAR(50),

    bill_amount DECIMAL(18,2),

    kva_demand DECIMAL(18,2),

    kw_demand DECIMAL(18,2),

    high_rate DECIMAL(18,2),

    low_rate DECIMAL(18,2),

    power_factor DECIMAL(18,2),

    power_factor_surcharge DECIMAL(18,2),

    remarks VARCHAR(500),

    created_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME()
);

GO

/*
------------------------------------------------------------
Project : MRA ETL
Database: MRAs
Table   : postpaid_billing
Purpose : Stores postpaid billing information.
------------------------------------------------------------
*/

USE MRAs;
GO

CREATE TABLE postpaid_billing
(
    postpaid_billing_id BIGINT IDENTITY(1,1) PRIMARY KEY,

    account_number VARCHAR(20) NOT NULL,

    customer_name VARCHAR(255),

    period INT,

    region VARCHAR(100),

    county VARCHAR(100),

    business_unit VARCHAR(100),

    sector_name VARCHAR(100),

    zone_name VARCHAR(100),

    itinerary VARCHAR(100),

    customer_type VARCHAR(100),

    tariff VARCHAR(50),

    tariff_desc VARCHAR(100),

    classification VARCHAR(100),

    amount_kes DECIMAL(18,2),

    units_kwhrs DECIMAL(18,2),

    invoice_date DATE,

    bill_type VARCHAR(50),

    bill_status VARCHAR(50),

    estimated_reading BIT,

    created_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME()
);

GO

/*
------------------------------------------------------------
Project : MRA ETL
Database: MRAs
Table   : smart_meter_billing
Purpose : Stores smart meter billing transactions.
------------------------------------------------------------
*/

USE MRAs;
GO

CREATE TABLE smart_meter_billing
(
    billing_id BIGINT IDENTITY(1,1) PRIMARY KEY,

    account_number VARCHAR(20) NOT NULL,

    customer_name VARCHAR(255),

    meter_number VARCHAR(20),

    region VARCHAR(100),

    county VARCHAR(100),

    zone_name VARCHAR(100),

    itinerary VARCHAR(100),

    feeder_id VARCHAR(50),

    mfc_feeder_name VARCHAR(150),

    previous_active_energy DECIMAL(18,2),

    previous_kva DECIMAL(18,2),

    previous_kw DECIMAL(18,2),

    previous_high_rate DECIMAL(18,2),

    previous_low_rate DECIMAL(18,2),

    read_status VARCHAR(50),

    current_active_energy DECIMAL(18,2),

    current_kva DECIMAL(18,2),

    current_kw DECIMAL(18,2),

    current_high_rate DECIMAL(18,2),

    current_low_rate DECIMAL(18,2),

    total_consumption DECIMAL(18,2),

    total_amount DECIMAL(18,2),

    created_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME()
);

GO

/*
------------------------------------------------------------
Project : MRA ETL
Database: MRAs
Table   : zero_cons
Purpose : Stores zero consumption accounts.
------------------------------------------------------------
*/

USE MRAs;
GO

CREATE TABLE zero_cons
(
    zero_cons_id BIGINT IDENTITY(1,1) PRIMARY KEY,

    account_number VARCHAR(20) NOT NULL,

    customer_name VARCHAR(255),

    meter_number VARCHAR(20),

    staff_no VARCHAR(20),

    region VARCHAR(100),

    county VARCHAR(100),

    sector_name VARCHAR(100),

    zone_name VARCHAR(100),

    tariff VARCHAR(50),

    contract_status VARCHAR(100),

    total_amount DECIMAL(18,2),

    invoice_date DATE,

    remarks VARCHAR(500),

    created_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME()
);

GO

