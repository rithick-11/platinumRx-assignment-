-- 02_Hotel_Queries.sql  –  Part A: Hotel System (Q1–Q5)

-- Q1: For every user, get user_id and their last booked room_no ──────────

SELECT
    u.user_id,
    u.name,
    b.room_no AS last_booked_room
FROM users u
JOIN bookings b
  ON b.booking_id = (
      SELECT booking_id
      FROM   bookings
      WHERE  user_id = u.user_id
      ORDER  BY booking_date DESC
      LIMIT  1
  );



-- ── Q2: booking_id and total billing amount for bookings in November 2021 ──

SELECT
    b.booking_id,
    SUM(bc.item_quantity * i.item_rate) AS total_billing_amount
FROM bookings b
JOIN booking_commercials bc ON bc.booking_id = b.booking_id
JOIN items i                ON i.item_id    = bc.item_id
WHERE b.booking_date >= '2021-11-01'
  AND b.booking_date  < '2021-12-01'
GROUP BY b.booking_id;


-- ── Q3: bill_id and bill amount for bills in October 2021 where amount > 1000

SELECT
    bc.bill_id,
    SUM(bc.item_quantity * i.item_rate) AS bill_amount
FROM booking_commercials bc
JOIN items i ON i.item_id = bc.item_id
WHERE bc.bill_date >= '2021-10-01'
  AND bc.bill_date  < '2021-11-01'
GROUP BY bc.bill_id
HAVING SUM(bc.item_quantity * i.item_rate) > 1000;


-- ── Q4: Most & least ordered item per month of 2021 ───────────────────────

WITH monthly_item_qty AS (
    SELECT
        DATE_FORMAT(bc.bill_date, '%Y-%m') AS yr_month,
        i.item_name,
        SUM(bc.item_quantity)              AS total_qty
    FROM booking_commercials bc
    JOIN items i ON i.item_id = bc.item_id
    WHERE YEAR(bc.bill_date) = 2021
    GROUP BY yr_month, i.item_name
),
ranked AS (
    SELECT
        yr_month,
        item_name,
        total_qty,
        RANK() OVER (PARTITION BY yr_month ORDER BY total_qty DESC) AS rnk_most,
        RANK() OVER (PARTITION BY yr_month ORDER BY total_qty ASC)  AS rnk_least
    FROM monthly_item_qty
)
SELECT
    yr_month,
    MAX(CASE WHEN rnk_most  = 1 THEN item_name END) AS most_ordered_item,
    MAX(CASE WHEN rnk_least = 1 THEN item_name END) AS least_ordered_item
FROM ranked
WHERE rnk_most = 1 OR rnk_least = 1
GROUP BY yr_month
ORDER BY yr_month;


-- ── Q5: Customer(s) with the 2nd highest bill value per month of 2021 ─────

WITH bill_totals AS (
    SELECT
        DATE_FORMAT(bc.bill_date, '%Y-%m') AS yr_month,
        b.user_id,
        bc.bill_id,
        SUM(bc.item_quantity * i.item_rate) AS bill_amount
    FROM booking_commercials bc
    JOIN bookings b ON b.booking_id = bc.booking_id
    JOIN items    i ON i.item_id    = bc.item_id
    WHERE YEAR(bc.bill_date) = 2021
    GROUP BY yr_month, b.user_id, bc.bill_id
),
ranked AS (
    SELECT
        yr_month,
        user_id,
        bill_id,
        bill_amount,
        DENSE_RANK() OVER (PARTITION BY yr_month ORDER BY bill_amount DESC) AS rnk
    FROM bill_totals
)
SELECT
    r.yr_month,
    r.bill_id,
    r.bill_amount,
    u.name AS customer_name
FROM ranked r
JOIN users u ON u.user_id = r.user_id
WHERE r.rnk = 2
ORDER BY r.yr_month;