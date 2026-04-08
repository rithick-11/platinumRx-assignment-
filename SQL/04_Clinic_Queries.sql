
-- 04_Clinic_Queries.sql  –  Part B: Clinic System (Q1–Q5)

SET @yr  = 2021;
SET @mth = 11; 


-- ── Q1: Revenue from each sales channel for a given year ──────────────────

SELECT
    sales_channel,
    SUM(amount) AS total_revenue
FROM clinic_sales
WHERE YEAR(datetime) = @yr
GROUP BY sales_channel
ORDER BY total_revenue DESC;


-- ── Q2: Top 10 most valuable customers for a given year ───────────────────

SELECT
    cs.uid,
    c.name,
    SUM(cs.amount) AS total_spend
FROM clinic_sales cs
JOIN customer c ON c.uid = cs.uid
WHERE YEAR(cs.datetime) = @yr
GROUP BY cs.uid, c.name
ORDER BY total_spend DESC
LIMIT 10;


-- ── Q3: Month-wise revenue, expense, profit & status for a given year ─────

WITH rev AS (
    SELECT
        MONTH(datetime) AS mth,
        SUM(amount)     AS revenue
    FROM clinic_sales
    WHERE YEAR(datetime) = @yr
    GROUP BY MONTH(datetime)
),
exp AS (
    SELECT
        MONTH(datetime) AS mth,
        SUM(amount)     AS expense
    FROM expenses
    WHERE YEAR(datetime) = @yr
    GROUP BY MONTH(datetime)
)
SELECT
    COALESCE(r.mth, e.mth)                        AS month_number,
    COALESCE(r.revenue, 0)                         AS revenue,
    COALESCE(e.expense, 0)                         AS expense,
    COALESCE(r.revenue, 0) - COALESCE(e.expense,0) AS profit,
    CASE
        WHEN COALESCE(r.revenue,0) - COALESCE(e.expense,0) >= 0
        THEN 'profitable'
        ELSE 'not-profitable'
    END AS status
FROM rev r
FULL OUTER JOIN exp e ON e.mth = r.mth   -- use LEFT JOIN + UNION if MySQL
ORDER BY month_number;

-- ── Q4: Most profitable clinic in each city for a given month ─────────────

WITH clinic_profit AS (
    SELECT
        cl.cid,
        cl.clinic_name,
        cl.city,
        COALESCE(SUM(s.amount), 0) - COALESCE(SUM(e.amount), 0) AS profit
    FROM clinics cl
    LEFT JOIN clinic_sales s
           ON s.cid = cl.cid
          AND YEAR(s.datetime)  = @yr
          AND MONTH(s.datetime) = @mth
    LEFT JOIN expenses e
           ON e.cid = cl.cid
          AND YEAR(e.datetime)  = @yr
          AND MONTH(e.datetime) = @mth
    GROUP BY cl.cid, cl.clinic_name, cl.city
),
ranked AS (
    SELECT *,
           RANK() OVER (PARTITION BY city ORDER BY profit DESC) AS rnk
    FROM clinic_profit
)
SELECT city, clinic_name, profit AS highest_profit
FROM ranked
WHERE rnk = 1
ORDER BY city;


-- ── Q5: 2nd least profitable clinic per state for a given month ───────────

WITH clinic_profit AS (
    SELECT
        cl.cid,
        cl.clinic_name,
        cl.state,
        COALESCE(SUM(s.amount), 0) - COALESCE(SUM(e.amount), 0) AS profit
    FROM clinics cl
    LEFT JOIN clinic_sales s
           ON s.cid = cl.cid
          AND YEAR(s.datetime)  = @yr
          AND MONTH(s.datetime) = @mth
    LEFT JOIN expenses e
           ON e.cid = cl.cid
          AND YEAR(e.datetime)  = @yr
          AND MONTH(e.datetime) = @mth
    GROUP BY cl.cid, cl.clinic_name, cl.state
),
ranked AS (
    SELECT *,
           DENSE_RANK() OVER (PARTITION BY state ORDER BY profit ASC) AS rnk
    FROM clinic_profit
)
SELECT state, clinic_name, profit AS second_least_profit
FROM ranked
WHERE rnk = 2
ORDER BY state;