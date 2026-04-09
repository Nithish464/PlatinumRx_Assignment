CREATE DATABASE mydb;
USE mydb;

CREATE TABLE users (
    user_id         VARCHAR(50)  PRIMARY KEY,
    name            VARCHAR(100) NOT NULL,
    phone_number    VARCHAR(15),
    mail_id         VARCHAR(100),
    billing_address TEXT
);

CREATE TABLE bookings (
    booking_id   VARCHAR(50) PRIMARY KEY,
    booking_date DATETIME    NOT NULL,
    room_no      VARCHAR(50) NOT NULL,
    user_id      VARCHAR(50) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE items (
    item_id   VARCHAR(50)    PRIMARY KEY,
    item_name VARCHAR(100)   NOT NULL,
    item_rate DECIMAL(10, 2) NOT NULL
);

CREATE TABLE booking_commercials (
    id            VARCHAR(50)    PRIMARY KEY,
    booking_id    VARCHAR(50)    NOT NULL,
    bill_id       VARCHAR(50)    NOT NULL,
    bill_date     DATETIME       NOT NULL,
    item_id       VARCHAR(50)    NOT NULL,
    item_quantity DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id),
    FOREIGN KEY (item_id)    REFERENCES items(item_id)
);

INSERT INTO users (user_id, name, phone_number, mail_id, billing_address) VALUES
('usr-001', 'John Doe',   '9700000001', 'john.doe@example.com',   '10, MG Road, Mumbai'),
('usr-002', 'Jane Smith', '9700000002', 'jane.smith@example.com', '22, Anna Salai, Chennai'),
('usr-003', 'Raj Kumar',  '9700000003', 'raj.kumar@example.com',  '5, Park Street, Kolkata'),
('usr-004', 'Priya Nair', '9700000004', 'priya.nair@example.com', '8, Brigade Road, Bangalore');

INSERT INTO items (item_id, item_name, item_rate) VALUES
('itm-001', 'Tawa Paratha',          18.00),
('itm-002', 'Mix Veg',               89.00),
('itm-003', 'Paneer Butter Masala', 150.00),
('itm-004', 'Dal Makhani',          120.00),
('itm-005', 'Veg Biryani',          180.00),
('itm-006', 'Masala Chai',           25.00),
('itm-007', 'Mineral Water',         20.00),
('itm-008', 'Club Sandwich',        110.00),
('itm-009', 'Cold Coffee',           80.00),
('itm-010', 'Gulab Jamun',           60.00);

INSERT INTO bookings (booking_id, booking_date, room_no, user_id) VALUES
('bk-001', '2021-09-01 10:00:00', 'rm-101', 'usr-001'),
('bk-002', '2021-09-15 14:30:00', 'rm-102', 'usr-002'),
('bk-003', '2021-10-05 09:00:00', 'rm-103', 'usr-003'),
('bk-004', '2021-10-20 11:00:00', 'rm-104', 'usr-004'),
('bk-005', '2021-10-25 16:00:00', 'rm-101', 'usr-001'),
('bk-006', '2021-11-03 08:00:00', 'rm-102', 'usr-002'),
('bk-007', '2021-11-18 13:00:00', 'rm-103', 'usr-003'),
('bk-008', '2021-12-10 07:00:00', 'rm-104', 'usr-004'),
('bk-009', '2021-12-22 15:00:00', 'rm-101', 'usr-001');

INSERT INTO booking_commercials (id, booking_id, bill_id, bill_date, item_id, item_quantity) VALUES
('bc-001', 'bk-001', 'bl-001', '2021-09-02 12:00:00', 'itm-001', 3),
('bc-002', 'bk-001', 'bl-001', '2021-09-02 12:00:00', 'itm-002', 2),
('bc-003', 'bk-002', 'bl-002', '2021-09-16 09:00:00', 'itm-003', 1),
('bc-004', 'bk-002', 'bl-002', '2021-09-16 09:00:00', 'itm-006', 2),
('bc-005', 'bk-003', 'bl-003', '2021-10-06 11:00:00', 'itm-005', 2),
('bc-006', 'bk-003', 'bl-003', '2021-10-06 11:00:00', 'itm-004', 3),
('bc-007', 'bk-003', 'bl-003', '2021-10-06 11:00:00', 'itm-007', 4),
('bc-008', 'bk-004', 'bl-004', '2021-10-21 14:00:00', 'itm-008', 5),
('bc-009', 'bk-004', 'bl-004', '2021-10-21 14:00:00', 'itm-009', 3),
('bc-010', 'bk-004', 'bl-004', '2021-10-21 14:00:00', 'itm-010', 6),
('bc-011', 'bk-005', 'bl-005', '2021-10-26 10:00:00', 'itm-001', 10),
('bc-012', 'bk-005', 'bl-005', '2021-10-26 10:00:00', 'itm-003', 5),
('bc-013', 'bk-005', 'bl-005', '2021-10-26 10:00:00', 'itm-005', 3),
('bc-014', 'bk-006', 'bl-006', '2021-11-04 13:00:00', 'itm-002', 4),
('bc-015', 'bk-006', 'bl-006', '2021-11-04 13:00:00', 'itm-004', 2),
('bc-016', 'bk-006', 'bl-006', '2021-11-04 13:00:00', 'itm-006', 5),
('bc-017', 'bk-007', 'bl-007', '2021-11-19 08:00:00', 'itm-003', 3),
('bc-018', 'bk-007', 'bl-007', '2021-11-19 08:00:00', 'itm-008', 2),
('bc-019', 'bk-007', 'bl-007', '2021-11-19 08:00:00', 'itm-010', 4),
('bc-020', 'bk-008', 'bl-008', '2021-12-11 09:00:00', 'itm-001', 6),
('bc-021', 'bk-008', 'bl-008', '2021-12-11 09:00:00', 'itm-005', 2),
('bc-022', 'bk-009', 'bl-009', '2021-12-23 11:00:00', 'itm-002', 5),
('bc-023', 'bk-009', 'bl-009', '2021-12-23 11:00:00', 'itm-009', 3),
('bc-024', 'bk-009', 'bl-009', '2021-12-23 11:00:00', 'itm-007', 2);