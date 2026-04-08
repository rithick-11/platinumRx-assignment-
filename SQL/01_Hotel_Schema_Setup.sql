
-- 01_Hotel_Schema_Setup.sql

CREATE TABLE users (
    user_id        VARCHAR(50) PRIMARY KEY,
    name           VARCHAR(100),
    phone_number   VARCHAR(15),
    mail_id        VARCHAR(100),
    billing_address VARCHAR(255)
);

CREATE TABLE bookings (
    booking_id   VARCHAR(50) PRIMARY KEY,
    booking_date DATETIME,
    room_no      VARCHAR(50),
    user_id      VARCHAR(50),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE items (
    item_id   VARCHAR(50) PRIMARY KEY,
    item_name VARCHAR(100),
    item_rate DECIMAL(10, 2)
);

CREATE TABLE booking_commercials (
    id            VARCHAR(50) PRIMARY KEY,
    booking_id    VARCHAR(50),
    bill_id       VARCHAR(50),
    bill_date     DATETIME,
    item_id       VARCHAR(50),
    item_quantity DECIMAL(10, 2),
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id),
    FOREIGN KEY (item_id)    REFERENCES items(item_id)
);

-- ── Sample Data ───────────────────────────────────────────────

INSERT INTO users VALUES
('u-001', 'John Doe',   '9700000001', 'john@example.com',  '10, MG Road, Bengaluru'),
('u-002', 'Jane Smith', '9700000002', 'jane@example.com',  '22, Park St, Mumbai'),
('u-003', 'Bob Ray',    '9700000003', 'bob@example.com',   '5, Ring Rd, Delhi'),
('u-004', 'Alice Tan',  '9700000004', 'alice@example.com', '8, Anna Salai, Chennai');

INSERT INTO items VALUES
('itm-001', 'Tawa Paratha',  18.00),
('itm-002', 'Mix Veg',       89.00),
('itm-003', 'Paneer Tikka', 150.00),
('itm-004', 'Dal Makhani',   99.00),
('itm-005', 'Lassi',         45.00);

INSERT INTO bookings VALUES
('bk-001', '2021-09-10 10:00:00', 'rm-101', 'u-001'),
('bk-002', '2021-10-05 14:00:00', 'rm-202', 'u-002'),
('bk-003', '2021-10-12 09:30:00', 'rm-303', 'u-001'),
('bk-004', '2021-11-01 11:00:00', 'rm-404', 'u-003'),
('bk-005', '2021-11-15 16:00:00', 'rm-101', 'u-004'),
('bk-006', '2021-11-20 08:00:00', 'rm-202', 'u-002'),
('bk-007', '2021-12-01 12:00:00', 'rm-505', 'u-001');

INSERT INTO booking_commercials VALUES
-- bk-001  Sep  bill bl-001
('bc-001', 'bk-001', 'bl-001', '2021-09-10 12:00:00', 'itm-001', 3),
('bc-002', 'bk-001', 'bl-001', '2021-09-10 12:00:00', 'itm-002', 1),
-- bk-002  Oct  bill bl-002  (total = 150*2+99*1 = 399)
('bc-003', 'bk-002', 'bl-002', '2021-10-05 15:00:00', 'itm-003', 2),
('bc-004', 'bk-002', 'bl-002', '2021-10-05 15:00:00', 'itm-004', 1),
-- bk-003  Oct  bill bl-003  (total = 89*5+45*3 = 445+135 = 580)
('bc-005', 'bk-003', 'bl-003', '2021-10-12 10:00:00', 'itm-002', 5),
('bc-006', 'bk-003', 'bl-003', '2021-10-12 10:00:00', 'itm-005', 3),
-- bk-003  Oct  bill bl-004  (total = 150*5+99*3 = 750+297 = 1047)
('bc-007', 'bk-003', 'bl-004', '2021-10-12 11:00:00', 'itm-003', 5),
('bc-008', 'bk-003', 'bl-004', '2021-10-12 11:00:00', 'itm-004', 3),
-- bk-004  Nov  bill bl-005
('bc-009', 'bk-004', 'bl-005', '2021-11-01 12:00:00', 'itm-001', 4),
('bc-010', 'bk-004', 'bl-005', '2021-11-01 12:00:00', 'itm-003', 3),
-- bk-005  Nov  bill bl-006
('bc-011', 'bk-005', 'bl-006', '2021-11-15 17:00:00', 'itm-002', 6),
('bc-012', 'bk-005', 'bl-006', '2021-11-15 17:00:00', 'itm-004', 4),
-- bk-006  Nov  bill bl-007
('bc-013', 'bk-006', 'bl-007', '2021-11-20 09:00:00', 'itm-005', 10),
('bc-014', 'bk-006', 'bl-007', '2021-11-20 09:00:00', 'itm-003', 2);