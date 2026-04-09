USE mydb;

CREATE TABLE clinics (
    cid         VARCHAR(50)  PRIMARY KEY,
    clinic_name VARCHAR(100) NOT NULL,
    city        VARCHAR(100),
    state       VARCHAR(100),
    country     VARCHAR(100)
);

CREATE TABLE customer (
    uid    VARCHAR(50)  PRIMARY KEY,
    name   VARCHAR(100) NOT NULL,
    mobile VARCHAR(15)
);

CREATE TABLE clinic_sales (
    oid           VARCHAR(50)    PRIMARY KEY,
    uid           VARCHAR(50)    NOT NULL,
    cid           VARCHAR(50)    NOT NULL,
    amount        DECIMAL(12, 2) NOT NULL,
    datetime      DATETIME       NOT NULL,
    sales_channel VARCHAR(50)    NOT NULL,
    FOREIGN KEY (uid) REFERENCES customer(uid),
    FOREIGN KEY (cid) REFERENCES clinics(cid)
);

CREATE TABLE expenses (
    eid         VARCHAR(50)    PRIMARY KEY,
    cid         VARCHAR(50)    NOT NULL,
    description VARCHAR(200),
    amount      DECIMAL(12, 2) NOT NULL,
    datetime    DATETIME       NOT NULL,
    FOREIGN KEY (cid) REFERENCES clinics(cid)
);

INSERT INTO clinics (cid, clinic_name, city, state, country) VALUES
('cnc-001', 'HealthFirst Clinic',  'Mumbai',     'Maharashtra', 'India'),
('cnc-002', 'CareWell Clinic',     'Mumbai',     'Maharashtra', 'India'),
('cnc-003', 'MediCare Centre',     'Pune',       'Maharashtra', 'India'),
('cnc-004', 'LifeLine Clinic',     'Chennai',    'Tamil Nadu',  'India'),
('cnc-005', 'Apollo Mini Clinic',  'Chennai',    'Tamil Nadu',  'India'),
('cnc-006', 'Wellness Hub',        'Coimbatore', 'Tamil Nadu',  'India');

INSERT INTO customer (uid, name, mobile) VALUES
('cust-001', 'Arun Sharma',   '9800000001'),
('cust-002', 'Meena Pillai',  '9800000002'),
('cust-003', 'Karthik Raj',   '9800000003'),
('cust-004', 'Divya Nair',    '9800000004'),
('cust-005', 'Suresh Babu',   '9800000005'),
('cust-006', 'Anitha Kumari', '9800000006');

INSERT INTO clinic_sales (oid, uid, cid, amount, datetime, sales_channel) VALUES
('ord-001', 'cust-001', 'cnc-001', 15000, '2021-01-05 10:00:00', 'online'),
('ord-002', 'cust-002', 'cnc-001', 22000, '2021-01-12 11:00:00', 'offline'),
('ord-003', 'cust-003', 'cnc-002',  8000, '2021-01-18 14:00:00', 'app'),
('ord-004', 'cust-004', 'cnc-003', 12000, '2021-01-25 09:00:00', 'online'),
('ord-005', 'cust-001', 'cnc-004', 30000, '2021-02-03 10:00:00', 'offline'),
('ord-006', 'cust-005', 'cnc-004', 18000, '2021-02-14 12:00:00', 'online'),
('ord-007', 'cust-006', 'cnc-005',  9500, '2021-02-20 15:00:00', 'app'),
('ord-008', 'cust-002', 'cnc-001', 25000, '2021-03-07 08:00:00', 'online'),
('ord-009', 'cust-003', 'cnc-002', 11000, '2021-03-15 11:00:00', 'offline'),
('ord-010', 'cust-004', 'cnc-006', 16000, '2021-03-22 13:00:00', 'sodat'),
('ord-011', 'cust-001', 'cnc-001', 20000, '2021-04-01 09:00:00', 'online'),
('ord-012', 'cust-005', 'cnc-003', 13500, '2021-04-10 10:00:00', 'app'),
('ord-013', 'cust-006', 'cnc-004', 27000, '2021-05-05 11:00:00', 'offline'),
('ord-014', 'cust-002', 'cnc-005', 19000, '2021-05-19 14:00:00', 'online'),
('ord-015', 'cust-003', 'cnc-001', 31000, '2021-06-11 09:00:00', 'sodat'),
('ord-016', 'cust-004', 'cnc-002',  7500, '2021-06-25 16:00:00', 'app'),
('ord-017', 'cust-001', 'cnc-004', 22000, '2021-07-04 10:00:00', 'online'),
('ord-018', 'cust-005', 'cnc-005', 14000, '2021-08-08 11:00:00', 'offline'),
('ord-019', 'cust-006', 'cnc-006', 10500, '2021-09-14 12:00:00', 'app'),
('ord-020', 'cust-002', 'cnc-001', 17000, '2021-10-20 13:00:00', 'online'),
('ord-021', 'cust-003', 'cnc-002', 23000, '2021-11-11 08:00:00', 'sodat'),
('ord-022', 'cust-004', 'cnc-003', 28000, '2021-12-30 09:00:00', 'offline');

INSERT INTO expenses (eid, cid, description, amount, datetime) VALUES
('exp-001', 'cnc-001', 'First-aid supplies',  3000, '2021-01-05 07:00:00'),
('exp-002', 'cnc-001', 'Staff salaries',     10000, '2021-01-31 08:00:00'),
('exp-003', 'cnc-002', 'Equipment rent',      5000, '2021-01-20 09:00:00'),
('exp-004', 'cnc-003', 'Medicines stock',     8000, '2021-01-28 10:00:00'),
('exp-005', 'cnc-004', 'Staff salaries',     12000, '2021-02-28 08:00:00'),
('exp-006', 'cnc-005', 'Maintenance',         2500, '2021-02-15 09:00:00'),
('exp-007', 'cnc-001', 'Marketing',           4000, '2021-03-10 10:00:00'),
('exp-008', 'cnc-002', 'Utilities',           3500, '2021-03-25 11:00:00'),
('exp-009', 'cnc-006', 'Medicines stock',     9000, '2021-03-18 12:00:00'),
('exp-010', 'cnc-001', 'Staff salaries',     10000, '2021-04-30 08:00:00'),
('exp-011', 'cnc-003', 'Equipment rent',      6000, '2021-05-20 09:00:00'),
('exp-012', 'cnc-004', 'Medicines stock',     7000, '2021-06-15 10:00:00'),
('exp-013', 'cnc-005', 'Utilities',           2000, '2021-07-10 11:00:00'),
('exp-014', 'cnc-006', 'Staff salaries',      8000, '2021-08-31 08:00:00'),
('exp-015', 'cnc-001', 'Marketing',           3000, '2021-09-05 09:00:00'),
('exp-016', 'cnc-002', 'Maintenance',         4500, '2021-10-12 10:00:00'),
('exp-017', 'cnc-003', 'Medicines stock',     5500, '2021-11-18 11:00:00'),
('exp-018', 'cnc-004', 'Staff salaries',     11000, '2021-12-31 08:00:00');