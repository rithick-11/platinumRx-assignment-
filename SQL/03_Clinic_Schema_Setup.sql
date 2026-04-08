
-- 03_Clinic_Schema_Setup.sql

CREATE TABLE clinics (
    cid         VARCHAR(50) PRIMARY KEY,
    clinic_name VARCHAR(100),
    city        VARCHAR(100),
    state       VARCHAR(100),
    country     VARCHAR(100)
);

CREATE TABLE customer (
    uid    VARCHAR(50) PRIMARY KEY,
    name   VARCHAR(100),
    mobile VARCHAR(15)
);

CREATE TABLE clinic_sales (
    oid          VARCHAR(50) PRIMARY KEY,
    uid          VARCHAR(50),
    cid          VARCHAR(50),
    amount       DECIMAL(12, 2),
    datetime     DATETIME,
    sales_channel VARCHAR(50),
    FOREIGN KEY (uid) REFERENCES customer(uid),
    FOREIGN KEY (cid) REFERENCES clinics(cid)
);

CREATE TABLE expenses (
    eid         VARCHAR(50) PRIMARY KEY,
    cid         VARCHAR(50),
    description VARCHAR(255),
    amount      DECIMAL(12, 2),
    datetime    DATETIME,
    FOREIGN KEY (cid) REFERENCES clinics(cid)
);

-- ── Sample Data ───────────────────────────────────────────────

INSERT INTO clinics VALUES
('c-001', 'HealthFirst',   'Bengaluru', 'Karnataka',      'India'),
('c-002', 'CurePlus',      'Bengaluru', 'Karnataka',      'India'),
('c-003', 'MedCare',       'Mumbai',    'Maharashtra',    'India'),
('c-004', 'WellnessHub',   'Mumbai',    'Maharashtra',    'India'),
('c-005', 'QuickHeal',     'Chennai',   'Tamil Nadu',     'India');

INSERT INTO customer VALUES
('cust-001', 'Arjun Kumar',  '9800000001'),
('cust-002', 'Priya Sharma', '9800000002'),
('cust-003', 'Ravi Patel',   '9800000003'),
('cust-004', 'Sneha Rao',    '9800000004'),
('cust-005', 'Vikram Nair',  '9800000005'),
('cust-006', 'Anita Das',    '9800000006'),
('cust-007', 'Rohit Joshi',  '9800000007'),
('cust-008', 'Kavya Menon',  '9800000008'),
('cust-009', 'Suresh Iyer',  '9800000009'),
('cust-010', 'Deepa Nair',   '9800000010'),
('cust-011', 'Arun Pillai',  '9800000011');

INSERT INTO clinic_sales VALUES
('ord-001', 'cust-001', 'c-001',  5000.00, '2021-01-10 09:00:00', 'online'),
('ord-002', 'cust-002', 'c-001', 12000.00, '2021-01-15 11:00:00', 'walk-in'),
('ord-003', 'cust-003', 'c-002',  8000.00, '2021-02-05 10:00:00', 'online'),
('ord-004', 'cust-001', 'c-002', 15000.00, '2021-02-20 14:00:00', 'referral'),
('ord-005', 'cust-004', 'c-003', 20000.00, '2021-03-10 09:30:00', 'walk-in'),
('ord-006', 'cust-005', 'c-003',  3000.00, '2021-03-25 16:00:00', 'online'),
('ord-007', 'cust-006', 'c-004', 25000.00, '2021-04-01 08:00:00', 'referral'),
('ord-008', 'cust-001', 'c-001', 18000.00, '2021-04-15 13:00:00', 'walk-in'),
('ord-009', 'cust-007', 'c-005',  9000.00, '2021-05-10 10:00:00', 'online'),
('ord-010', 'cust-002', 'c-001', 11000.00, '2021-05-20 15:00:00', 'referral'),
('ord-011', 'cust-008', 'c-002',  7000.00, '2021-06-05 09:00:00', 'walk-in'),
('ord-012', 'cust-009', 'c-003', 30000.00, '2021-06-18 11:00:00', 'online'),
('ord-013', 'cust-010', 'c-004', 22000.00, '2021-07-07 14:00:00', 'referral'),
('ord-014', 'cust-011', 'c-005',  6000.00, '2021-07-20 10:00:00', 'walk-in'),
('ord-015', 'cust-001', 'c-001', 40000.00, '2021-08-01 09:00:00', 'online'),
('ord-016', 'cust-003', 'c-002', 16000.00, '2021-08-15 12:00:00', 'walk-in'),
('ord-017', 'cust-004', 'c-003',  5500.00, '2021-09-10 10:00:00', 'referral'),
('ord-018', 'cust-005', 'c-004', 19000.00, '2021-09-25 15:00:00', 'online'),
('ord-019', 'cust-001', 'c-005',  8500.00, '2021-10-05 09:00:00', 'walk-in'),
('ord-020', 'cust-002', 'c-001', 14000.00, '2021-10-20 11:00:00', 'referral'),
('ord-021', 'cust-006', 'c-002', 11500.00, '2021-11-03 08:00:00', 'online'),
('ord-022', 'cust-007', 'c-003', 27000.00, '2021-11-18 14:00:00', 'walk-in'),
('ord-023', 'cust-008', 'c-004',  9500.00, '2021-12-02 10:00:00', 'referral'),
('ord-024', 'cust-009', 'c-005', 13000.00, '2021-12-15 16:00:00', 'online'),
('ord-025', 'cust-010', 'c-001', 21000.00, '2021-12-28 09:00:00', 'walk-in');

INSERT INTO expenses VALUES
('exp-001', 'c-001', 'salaries',         8000.00, '2021-01-31 00:00:00'),
('exp-002', 'c-001', 'supplies',         2000.00, '2021-02-28 00:00:00'),
('exp-003', 'c-002', 'rent',             5000.00, '2021-02-28 00:00:00'),
('exp-004', 'c-003', 'utilities',        1500.00, '2021-03-31 00:00:00'),
('exp-005', 'c-004', 'equipment',       10000.00, '2021-04-30 00:00:00'),
('exp-006', 'c-001', 'salaries',         8000.00, '2021-04-30 00:00:00'),
('exp-007', 'c-005', 'supplies',         3000.00, '2021-05-31 00:00:00'),
('exp-008', 'c-002', 'salaries',         6000.00, '2021-06-30 00:00:00'),
('exp-009', 'c-003', 'rent',             4000.00, '2021-06-30 00:00:00'),
('exp-010', 'c-004', 'maintenance',      2500.00, '2021-07-31 00:00:00'),
('exp-011', 'c-001', 'salaries',         8000.00, '2021-08-31 00:00:00'),
('exp-012', 'c-005', 'utilities',        1200.00, '2021-09-30 00:00:00'),
('exp-013', 'c-002', 'equipment',        7000.00, '2021-10-31 00:00:00'),
('exp-014', 'c-003', 'salaries',         9000.00, '2021-11-30 00:00:00'),
('exp-015', 'c-004', 'supplies',         3500.00, '2021-12-31 00:00:00'),
('exp-016', 'c-001', 'marketing',        4000.00, '2021-12-31 00:00:00');
