USE mydb;

SET @target_year  = 2021;
SET @target_month = 3;

-- Q1: Revenue from each sales channel
SELECT
    sales_channel,
    SUM(amount) AS total_revenue
FROM clinic_sales
WHERE YEAR(datetime) = @target_year
GROUP BY sales_channel
ORDER BY total_revenue DESC;

-- Q2: Top 10 most valuable customers
SELECT
    cs.uid,
    c.name            AS customer_name,
    c.mobile,
    SUM(cs.amount)    AS total_spend
FROM clinic_sales cs
JOIN customer     c  ON c.uid = cs.uid
WHERE YEAR(cs.datetime) = @target_year
GROUP BY cs.uid, c.name, c.mobile
ORDER BY total_spend DESC
LIMIT 10;

-- Q3: Month-wise revenue, expense, profit, status
WITH monthly_revenue AS (
    SELECT
        DATE_FORMAT(datetime, '%Y-%m') AS month,
        SUM(amount)                    AS total_revenue
    FROM clinic_sales
    WHERE YEAR(datetime) = @target_year
    GROUP BY DATE_FORMAT(datetime, '%Y-%m')
),
monthly_expense AS (
    SELECT
        DATE_FORMAT(datetime, '%Y-%m') AS month,
        SUM(amount)                    AS total_expense
    FROM expenses
    WHERE YEAR(datetime) = @target_year
    GROUP BY DATE_FORMAT(datetime, '%Y-%m')
)
SELECT
    r.month,
    r.total_revenue,
    COALESCE(e.total_expense, 0)                    AS total_expense,
    r.total_revenue - COALESCE(e.total_expense, 0)  AS profit,
    CASE
        WHEN r.total_revenue - COALESCE(e.total_expense, 0) > 0
        THEN 'Profitable'
        ELSE 'Not-Profitable'
    END                                             AS status
FROM monthly_revenue r
LEFT JOIN monthly_expense e ON e.month = r.month
ORDER BY r.month;

-- Q4: Most profitable clinic per city for a given month
WITH clinic_revenue AS (
    SELECT cid, SUM(amount) AS revenue
    FROM clinic_sales
    WHERE YEAR(datetime) = @target_year AND MONTH(datetime) = @target_month
    GROUP BY cid
),
clinic_expense AS (
    SELECT cid, SUM(amount) AS expense
    FROM expenses
    WHERE YEAR(datetime) = @target_year AND MONTH(datetime) = @target_month
    GROUP BY cid
),
clinic_profit AS (
    SELECT
        cl.cid,
        cl.clinic_name,
        cl.city,
        cl.state,
        COALESCE(r.revenue, 0) - COALESCE(e.expense, 0) AS profit
    FROM clinics      cl
    LEFT JOIN clinic_revenue r ON r.cid = cl.cid
    LEFT JOIN clinic_expense e ON e.cid = cl.cid
),
ranked AS (
    SELECT *,
        RANK() OVER (PARTITION BY city ORDER BY profit DESC) AS rnk
    FROM clinic_profit
)
SELECT city, cid, clinic_name, state, profit AS clinic_profit
FROM ranked
WHERE rnk = 1
ORDER BY city;

-- Q5: Second least profitable clinic per state for a given month
WITH clinic_revenue AS (
    SELECT cid, SUM(amount) AS revenue
    FROM clinic_sales
    WHERE YEAR(datetime) = @target_year AND MONTH(datetime) = @target_month
    GROUP BY cid
),
clinic_expense AS (
    SELECT cid, SUM(amount) AS expense
    FROM expenses
    WHERE YEAR(datetime) = @target_year AND MONTH(datetime) = @target_month
    GROUP BY cid
),
clinic_profit AS (
    SELECT
        cl.cid,
        cl.clinic_name,
        cl.city,
        cl.state,
        COALESCE(r.revenue, 0) - COALESCE(e.expense, 0) AS profit
    FROM clinics      cl
    LEFT JOIN clinic_revenue r ON r.cid = cl.cid
    LEFT JOIN clinic_expense e ON e.cid = cl.cid
),
ranked AS (
    SELECT *,
        DENSE_RANK() OVER (PARTITION BY state ORDER BY profit ASC) AS rnk
    FROM clinic_profit
)
SELECT state, cid, clinic_name, city, profit AS clinic_profit
FROM ranked
WHERE rnk = 2
ORDER BY state;