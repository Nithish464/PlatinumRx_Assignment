USE mydb;

-- Q1: Last booked room per user
WITH ranked_bookings AS (
    SELECT
        u.user_id,
        u.name,
        b.room_no,
        b.booking_date,
        ROW_NUMBER() OVER (
            PARTITION BY u.user_id
            ORDER BY b.booking_date DESC
        ) AS rn
    FROM users u
    JOIN bookings b ON b.user_id = u.user_id
)
SELECT user_id, name, room_no AS last_booked_room_no, booking_date AS last_booking_date
FROM ranked_bookings
WHERE rn = 1
ORDER BY user_id;

-- Q2: Total billing for November 2021 bookings
SELECT
    b.booking_id,
    SUM(bc.item_quantity * i.item_rate) AS total_billing_amount
FROM bookings b
JOIN booking_commercials bc ON bc.booking_id = b.booking_id
JOIN items i ON i.item_id = bc.item_id
WHERE b.booking_date >= '2021-11-01'
  AND b.booking_date < '2021-12-01'
GROUP BY b.booking_id
ORDER BY b.booking_id;

-- Q3: Bills > 1000 in October 2021
SELECT
    bc.bill_id,
    SUM(bc.item_quantity * i.item_rate) AS bill_amount
FROM booking_commercials bc
JOIN items i ON i.item_id = bc.item_id
WHERE bc.bill_date >= '2021-10-01'
  AND bc.bill_date < '2021-11-01'
GROUP BY bc.bill_id
HAVING SUM(bc.item_quantity * i.item_rate) > 1000
ORDER BY bill_amount DESC;

-- Q4: Most and Least ordered item per month
WITH monthly_item_totals AS (
    SELECT
        DATE_FORMAT(bc.bill_date, '%Y-%m') AS bill_month,
        i.item_id,
        i.item_name,
        SUM(bc.item_quantity) AS total_qty_ordered
    FROM booking_commercials bc
    JOIN items i ON i.item_id = bc.item_id
    WHERE YEAR(bc.bill_date) = 2021
    GROUP BY DATE_FORMAT(bc.bill_date, '%Y-%m'), i.item_id, i.item_name
),
ranked AS (
    SELECT
        bill_month,
        item_id,
        item_name,
        total_qty_ordered,
        RANK() OVER (PARTITION BY bill_month ORDER BY total_qty_ordered DESC) AS rank_most,
        RANK() OVER (PARTITION BY bill_month ORDER BY total_qty_ordered ASC)  AS rank_least
    FROM monthly_item_totals
)
SELECT bill_month, item_name, total_qty_ordered, 'Most Ordered' AS order_category
FROM ranked WHERE rank_most = 1
UNION ALL
SELECT bill_month, item_name, total_qty_ordered, 'Least Ordered' AS order_category
FROM ranked WHERE rank_least = 1
ORDER BY bill_month, order_category;

-- Q5: Customer with 2nd highest bill per month
WITH bill_totals AS (
    SELECT
        bc.bill_id,
        DATE_FORMAT(bc.bill_date, '%Y-%m') AS bill_month,
        b.user_id,
        u.name,
        SUM(bc.item_quantity * i.item_rate) AS bill_amount
    FROM booking_commercials bc
    JOIN bookings b ON b.booking_id = bc.booking_id
    JOIN users u ON u.user_id = b.user_id
    JOIN items i ON i.item_id = bc.item_id
    WHERE YEAR(bc.bill_date) = 2021
    GROUP BY bc.bill_id, DATE_FORMAT(bc.bill_date, '%Y-%m'), b.user_id, u.name
),
ranked_bills AS (
    SELECT
        bill_month, bill_id, user_id, name, bill_amount,
        DENSE_RANK() OVER (PARTITION BY bill_month ORDER BY bill_amount DESC) AS bill_rank
    FROM bill_totals
)
SELECT bill_month, bill_id, user_id, name AS customer_name, bill_amount
FROM ranked_bills
WHERE bill_rank = 2
ORDER BY bill_month;