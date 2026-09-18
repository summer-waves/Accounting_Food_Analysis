# Trailhead Burger Co. — Restaurant Financial Analysis & Accounting Reconciliation

A self-built portfolio project simulating the day-to-day work at a multi-location restaurant chain — built to practice the exact skill set (Excel, SQL/T-SQL, Power BI, journal entries, variance analysis, and discrepancy investigation).

## The Business Scenario

Trailhead Burger Co. is a fictional 5-restaurant chain across Texas. The dataset covers Q1 2026 (Jan–Mar) with 205 double-entry journal transactions (410 debit/credit lines) across dine-in, drive-thru, and third-party delivery channels.

## The Core Finding

While reconciling monthly financials, I identified that **Restaurant #104 (Laredo)** posted a food-cost percentage of **42% in March**, against a fleet-wide norm of **30%** — a 12-point spike isolated to one location and one month. Drilling into the underlying transactions traced the cause to a vendor (Gulf Coast Meat Supply) inventory posting, and confirmed it was the single largest unfavorable budget variance in the entire quarter ($12,842.56, a 7.17% miss).

This finding was independently reproduced and cross-validated across three separate tools — Excel, SQLite, and Microsoft SQL Server — before being visualized in Power BI, to prove the numbers were consistent regardless of platform.

## Tools & Skills Demonstrated

| Tool | What I built |
|---|---|
| **Excel** | Chart of accounts, journal entry ledger, PivotTables (Revenue, Food Cost, and a combined Food Cost % with a Calculated Field), data validation |
| **T-SQL (SQL Server)** | General ledger rollups, trial balance checks, monthly income statements, a subquery-based discrepancy detector, budget variance analysis, window functions (RANK, LAG, running totals), correlated subqueries |
| **Power BI** | A 4-page dashboard (Financial Overview, Restaurant Performance, Variance Analysis, Data Quality) built on a star-schema data model with 5 relationships, 15+ DAX measures, and conditional formatting to visually flag the outlier restaurant |

## Repository Structure

```
├── excel/
│   └── Trailhead_Financial_Analysis.xlsx      # Chart of accounts, transactions, PivotTables
├── sql/
│   ├── schema_and_data_sqlserver.sql          # T-SQL schema + data load
│   ├── queries_sqlserver.sql                  # 10 core queries (GL, trial balance, variance, discrepancy detection)
├── powerbi/
│   ├── Power_BI_Source_Data.xlsx              # Clean source tables for the data model
│   ├── Trailhead_Dashboard_Theme.json         # Custom report theme
│   └── Food_Cost_Analysis_Dashboard_Pages.pdf     # Final 4-page dashboard
└── README.md
```

## Key Accounting Concepts Applied

- Double-entry bookkeeping (every transaction's debits = credits, verified via trial balance)
- Journal entries → general ledger → income statement flow
- Budget vs. actual variance analysis (favorable/unfavorable classification)
- Reconciliation and data-quality checks (automated unbalanced-transaction detection)

## Why This Project

Built to prepare for an Accounting Data Analyst role, with a focus on the specific gap between "can build a dashboard" and "understands where the numbers come from and how to investigate when they don't look right."
