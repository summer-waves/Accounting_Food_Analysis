-- =====================================================================
-- Trailhead Burger Co. — SQL Practice Queries (SQL Server / T-SQL version)
-- Run schema_and_data_sqlserver.sql first, then these against the same DB.
--
-- Only a few things differ from the SQLite version you saw first:
--   strftime('%Y-%m', date)  ->  FORMAT(date, 'yyyy-MM')
--   LIMIT n                  ->  SELECT TOP n ... (goes right after SELECT)
--   Everything else (JOIN, GROUP BY, CASE, subqueries, CTEs) is identical
--   T-SQL syntax — that part of SQL really is portable across engines.
-- =====================================================================

-- ---------------------------------------------------------------------
-- 1. Reference tables
-- ---------------------------------------------------------------------
SELECT * FROM chart_of_accounts;
SELECT * FROM restaurants;
SELECT * FROM vendors;

-- ---------------------------------------------------------------------
-- 2. General Ledger — SUM + GROUP BY
-- ---------------------------------------------------------------------
SELECT
    a.account_id,
    a.account_name,
    a.account_type,
    ROUND(SUM(t.debit), 2)  AS total_debits,
    ROUND(SUM(t.credit), 2) AS total_credits,
    ROUND(SUM(t.debit - t.credit), 2) AS net_balance
FROM transactions t
JOIN chart_of_accounts a ON a.account_id = t.account_id
GROUP BY a.account_id, a.account_name, a.account_type
ORDER BY a.account_id;

-- ---------------------------------------------------------------------
-- 3. Trial Balance
-- ---------------------------------------------------------------------
SELECT
    ROUND(SUM(debit), 2)  AS total_debits,
    ROUND(SUM(credit), 2) AS total_credits,
    ROUND(SUM(debit) - SUM(credit), 2) AS difference,
    CASE WHEN ROUND(SUM(debit) - SUM(credit), 2) = 0
         THEN 'BALANCED' ELSE 'OUT OF BALANCE - investigate' END AS status
FROM transactions;

-- ---------------------------------------------------------------------
-- 4. Monthly Income Statement (company-wide)
--    FORMAT(date, 'yyyy-MM') is T-SQL's equivalent of SQLite's strftime
-- ---------------------------------------------------------------------
SELECT
    FORMAT(t.txn_date, 'yyyy-MM') AS month,
    a.account_type,
    a.account_name,
    ROUND(SUM(
        CASE WHEN a.account_type = 'Revenue' THEN t.credit - t.debit
             ELSE t.debit - t.credit END
    ), 2) AS amount
FROM transactions t
JOIN chart_of_accounts a ON a.account_id = t.account_id
WHERE a.account_type IN ('Revenue', 'Expense')
GROUP BY FORMAT(t.txn_date, 'yyyy-MM'), a.account_type, a.account_name
ORDER BY month, a.account_type, a.account_name;

-- ---------------------------------------------------------------------
-- 5. Revenue, Food Cost & Food Cost % by restaurant, by month
-- ---------------------------------------------------------------------
SELECT
    r.restaurant_id,
    r.restaurant_name,
    FORMAT(t.txn_date, 'yyyy-MM') AS month,
    ROUND(SUM(CASE WHEN t.account_id IN ('4000','4010') THEN t.credit - t.debit ELSE 0 END), 2) AS revenue,
    ROUND(SUM(CASE WHEN t.account_id = '5000' THEN t.debit - t.credit ELSE 0 END), 2) AS food_cost,
    ROUND(
        SUM(CASE WHEN t.account_id = '5000' THEN t.debit - t.credit ELSE 0 END) * 1.0 /
        NULLIF(SUM(CASE WHEN t.account_id IN ('4000','4010') THEN t.credit - t.debit ELSE 0 END), 0)
    , 4) AS food_cost_pct
FROM transactions t
JOIN restaurants r ON r.restaurant_id = t.restaurant_id
GROUP BY r.restaurant_id, r.restaurant_name, FORMAT(t.txn_date, 'yyyy-MM')
ORDER BY month, r.restaurant_id;

-- ---------------------------------------------------------------------
-- 6. THE DISCREPANCY QUERY — subquery version.
--    Which restaurant(s) had a March food-cost % above the fleet average?
-- ---------------------------------------------------------------------
WITH march_financials AS (
    SELECT
        r.restaurant_id,
        r.restaurant_name,
        SUM(CASE WHEN t.account_id IN ('4000','4010') THEN t.credit - t.debit ELSE 0 END) AS revenue,
        SUM(CASE WHEN t.account_id = '5000' THEN t.debit - t.credit ELSE 0 END) AS food_cost
    FROM transactions t
    JOIN restaurants r ON r.restaurant_id = t.restaurant_id
    WHERE FORMAT(t.txn_date, 'yyyy-MM') = '2026-03'
    GROUP BY r.restaurant_id, r.restaurant_name
)
SELECT
    restaurant_id,
    restaurant_name,
    ROUND(revenue, 2) AS march_revenue,
    ROUND(food_cost, 2) AS march_food_cost,
    ROUND(food_cost * 1.0 / revenue, 4) AS food_cost_pct
FROM march_financials
WHERE (food_cost * 1.0 / revenue) > (
    SELECT AVG(food_cost * 1.0 / revenue) FROM march_financials
)
ORDER BY food_cost_pct DESC;

-- ---------------------------------------------------------------------
-- 7. Vendor detail behind Restaurant #104's March food-cost postings
-- ---------------------------------------------------------------------
SELECT
    t.txn_date,
    t.transaction_id,
    a.account_name,
    v.vendor_name,
    t.debit,
    t.credit,
    t.description
FROM transactions t
JOIN chart_of_accounts a ON a.account_id = t.account_id
LEFT JOIN vendors v ON v.vendor_id = t.vendor_id
WHERE t.restaurant_id = '104'
  AND FORMAT(t.txn_date, 'yyyy-MM') = '2026-03'
  AND t.account_id IN ('1020', '5000')
ORDER BY t.txn_date;

-- ---------------------------------------------------------------------
-- 8. Variance Analysis — Actual vs. Budget
-- ---------------------------------------------------------------------
WITH actuals AS (
    SELECT
        a.account_id,
        a.account_name,
        a.account_type,
        FORMAT(t.txn_date, 'yyyy-MM') AS month,
        SUM(CASE WHEN a.account_type = 'Revenue' THEN t.credit - t.debit
                 ELSE t.debit - t.credit END) AS actual
    FROM transactions t
    JOIN chart_of_accounts a ON a.account_id = t.account_id
    WHERE a.account_type IN ('Revenue', 'Expense')
    GROUP BY a.account_id, a.account_name, a.account_type, FORMAT(t.txn_date, 'yyyy-MM')
)
SELECT
    ac.account_name,
    ac.account_type,
    ac.month,
    ROUND(ac.actual, 2)  AS actual,
    ROUND(b.budget_amount, 2) AS budget,
    ROUND(ac.actual - b.budget_amount, 2) AS dollar_variance,
    ROUND((ac.actual - b.budget_amount) * 1.0 / b.budget_amount, 4) AS pct_variance,
    CASE
        WHEN ac.account_type = 'Revenue' AND ac.actual > b.budget_amount THEN 'Favorable'
        WHEN ac.account_type = 'Revenue' AND ac.actual < b.budget_amount THEN 'Unfavorable'
        WHEN ac.account_type = 'Expense' AND ac.actual > b.budget_amount THEN 'Unfavorable'
        WHEN ac.account_type = 'Expense' AND ac.actual < b.budget_amount THEN 'Favorable'
        ELSE 'On Budget'
    END AS flag
FROM actuals ac
JOIN budget b ON b.account_id = ac.account_id AND b.budget_month = ac.month
ORDER BY ac.month, ac.account_type, ac.account_name;

-- ---------------------------------------------------------------------
-- 9. Data-quality check: any transaction_id without matching debit/credit?
-- ---------------------------------------------------------------------
SELECT
    transaction_id,
    ROUND(SUM(debit), 2) AS total_debit,
    ROUND(SUM(credit), 2) AS total_credit
FROM transactions
GROUP BY transaction_id
HAVING ROUND(SUM(debit), 2) <> ROUND(SUM(credit), 2);

-- ---------------------------------------------------------------------
-- 10. TOP n syntax difference: top 3 vendors by total spend
--     (SQLite used LIMIT 3 at the end; T-SQL uses TOP 3 right after SELECT)
-- ---------------------------------------------------------------------
SELECT TOP 3
    v.vendor_id,
    v.vendor_name,
    ROUND(SUM(t.debit), 2) AS total_debits
FROM transactions t
JOIN vendors v ON v.vendor_id = t.vendor_id
GROUP BY v.vendor_id, v.vendor_name
ORDER BY total_debits DESC;
