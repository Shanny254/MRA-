USE MRA;
GO

/*==============================================================
CUSTOMER_ACCOUNT
==============================================================*/
ALTER TABLE customer_account
ADD
    sys_accnumber VARCHAR(30) NULL;
GO


/*==============================================================
LOCATION
==============================================================*/
ALTER TABLE location
ADD
    itinerary_type VARCHAR(100) NULL,
    feeder_id VARCHAR(50) NULL,
    mfc_feeder_name VARCHAR(255) NULL;
GO


/*==============================================================
OFFLINE_SMART_METERS
==============================================================*/
ALTER TABLE offline_smart_meters
ADD
    contract_type VARCHAR(100) NULL,
    itin_type VARCHAR(100) NULL;
GO


/*==============================================================
OFFLINE_METERS_CYCLE_READING
==============================================================*/
ALTER TABLE offline_meters_cycle_reading
ADD
    system_region VARCHAR(100) NULL,
    system_county VARCHAR(100) NULL,
    sys_mtrnumber VARCHAR(30) NULL,
    sys_accnumber VARCHAR(30) NULL,
    globalid VARCHAR(100) NULL,
    created_user VARCHAR(100) NULL,
    created_date DATETIME2 NULL,
    last_edited_user VARCHAR(100) NULL,
    last_edited_date DATETIME2 NULL;
GO


/*==============================================================
ORDINARY_DEBTLIST
==============================================================*/
ALTER TABLE ordinary_debtlist
ADD
    cod_tariff VARCHAR(50) NULL,
    x_coordinate DECIMAL(12,8) NULL,
    y_coordinate DECIMAL(12,8) NULL;
GO


/*==============================================================
LP_DEBT
==============================================================*/
ALTER TABLE lp_debt
ADD
    legacy_number VARCHAR(30) NULL,
    vat DECIMAL(18,2) NULL,
    admd DECIMAL(18,2) NULL,
    avg_6_month_bill DECIMAL(18,2) NULL,
    deposit_amount DECIMAL(18,2) NULL,
    guarantee_amount DECIMAL(18,2) NULL;
GO


/*==============================================================
ADMD
==============================================================*/
ALTER TABLE admd
ADD
    niss VARCHAR(30) NULL,
    kva_demand DECIMAL(18,2) NULL,
    kva_contract DECIMAL(18,2) NULL,
    difference DECIMAL(18,2) NULL;
GO


/*==============================================================
CHANGE_OF_TARIFF
==============================================================*/
ALTER TABLE change_of_tariff
ADD
    niss VARCHAR(30) NULL,
    avg_consumption DECIMAL(18,2) NULL,
    tariff_range VARCHAR(100) NULL;
GO


/*==============================================================
ZERO_CONS
==============================================================*/
ALTER TABLE zero_cons
ADD
    niss VARCHAR(30) NULL,
    total_amount DECIMAL(18,2) NULL,
    invoice_date DATE NULL;
GO


/*==============================================================
LOAD_FACTOR
==============================================================*/
ALTER TABLE load_factor
ADD
    niss VARCHAR(30) NULL,
    high_rate DECIMAL(18,2) NULL,
    low_rate DECIMAL(18,2) NULL,
    kva_demand DECIMAL(18,2) NULL,
    kw_demand DECIMAL(18,2) NULL;
GO


/*==============================================================
PF_1ST_TIME
==============================================================*/
ALTER TABLE pf_1st_time
ADD
    kva_units DECIMAL(18,2) NULL,
    kw_units DECIMAL(18,2) NULL,
    hr_units DECIMAL(18,2) NULL,
    lr_units DECIMAL(18,2) NULL,
    pf_amount DECIMAL(18,2) NULL;
GO


/*==============================================================
POOR_PF
==============================================================*/
ALTER TABLE poor_pf
ADD
    niss VARCHAR(30) NULL,
    bill_amount DECIMAL(18,2) NULL,
    kva_demand DECIMAL(18,2) NULL,
    kw_demand DECIMAL(18,2) NULL,
    high_rate DECIMAL(18,2) NULL,
    low_rate DECIMAL(18,2) NULL,
    pf_surcharge DECIMAL(18,2) NULL;
GO


/*==============================================================
CONS_DEVIATION
==============================================================*/
ALTER TABLE cons_deviation
ADD
    avg_consumption DECIMAL(18,2) NULL,
    current_cycle VARCHAR(50) NULL,
    previous_cycle VARCHAR(50) NULL,
    percentage_difference DECIMAL(18,2) NULL,
    id_payment_form VARCHAR(50) NULL,
    niss VARCHAR(30) NULL;
GO


/*==============================================================
POSTPAID_BILLING
==============================================================*/
ALTER TABLE postpaid_billing
ADD
    period VARCHAR(30) NULL,
    tariff_desc VARCHAR(100) NULL,
    classification VARCHAR(100) NULL,
    invoice_date DATE NULL,
    bill_type VARCHAR(100) NULL,
    bill_status VARCHAR(100) NULL,
    ind_estimated BIT NULL;
GO


/*==============================================================
ORDINARY_ACS_METER_RDG
==============================================================*/
ALTER TABLE ordinary_acs_meter_rdg
ADD
    period VARCHAR(30) NULL,
    cod_tariff VARCHAR(50) NULL,
    billing_type VARCHAR(100) NULL,
    billed_units DECIMAL(18,2) NULL,
    times_billed_zero INT NULL;
GO