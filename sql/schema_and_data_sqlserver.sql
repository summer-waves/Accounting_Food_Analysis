-- =====================================================================
-- Trailhead Burger Co. — SQL Server Setup Script
-- Run this whole script once in SSMS (against a new or existing DB)
-- to recreate the exact same data used in the SQLite version.
-- =====================================================================

CREATE TABLE chart_of_accounts (
    account_id      VARCHAR(10) PRIMARY KEY,
    account_name    VARCHAR(50) NOT NULL,
    account_type    VARCHAR(20) NOT NULL,
    normal_balance  VARCHAR(10) NOT NULL
);

CREATE TABLE restaurants (
    restaurant_id   VARCHAR(10) PRIMARY KEY,
    restaurant_name VARCHAR(100) NOT NULL
);

CREATE TABLE vendors (
    vendor_id       VARCHAR(10) PRIMARY KEY,
    vendor_name     VARCHAR(100) NOT NULL
);

CREATE TABLE transactions (
    line_id         INT PRIMARY KEY,
    transaction_id  VARCHAR(10) NOT NULL,
    txn_date        DATE NOT NULL,
    restaurant_id   VARCHAR(10) NOT NULL REFERENCES restaurants(restaurant_id),
    account_id      VARCHAR(10) NOT NULL REFERENCES chart_of_accounts(account_id),
    debit           DECIMAL(12,2) NOT NULL DEFAULT 0,
    credit          DECIMAL(12,2) NOT NULL DEFAULT 0,
    description     VARCHAR(100),
    payment_method  VARCHAR(50),
    channel         VARCHAR(30),
    vendor_id       VARCHAR(10) REFERENCES vendors(vendor_id),
    department      VARCHAR(50)
);

CREATE TABLE budget (
    account_id      VARCHAR(10) NOT NULL REFERENCES chart_of_accounts(account_id),
    budget_month    VARCHAR(7) NOT NULL,
    budget_amount   DECIMAL(12,2) NOT NULL,
    PRIMARY KEY (account_id, budget_month)
);
GO

-- chart_of_accounts (17 rows)
INSERT INTO chart_of_accounts VALUES ('1000', 'Cash', 'Asset', 'Debit');
INSERT INTO chart_of_accounts VALUES ('1010', 'Accounts Receivable', 'Asset', 'Debit');
INSERT INTO chart_of_accounts VALUES ('1020', 'Inventory', 'Asset', 'Debit');
INSERT INTO chart_of_accounts VALUES ('1030', 'Equipment', 'Asset', 'Debit');
INSERT INTO chart_of_accounts VALUES ('2000', 'Accounts Payable', 'Liability', 'Credit');
INSERT INTO chart_of_accounts VALUES ('2010', 'Loan Payable', 'Liability', 'Credit');
INSERT INTO chart_of_accounts VALUES ('3000', 'Owner''s Equity', 'Equity', 'Credit');
INSERT INTO chart_of_accounts VALUES ('4000', 'Restaurant Sales', 'Revenue', 'Credit');
INSERT INTO chart_of_accounts VALUES ('4010', 'Delivery Sales', 'Revenue', 'Credit');
INSERT INTO chart_of_accounts VALUES ('5000', 'Food Cost', 'Expense', 'Debit');
INSERT INTO chart_of_accounts VALUES ('5010', 'Labor', 'Expense', 'Debit');
INSERT INTO chart_of_accounts VALUES ('5020', 'Rent', 'Expense', 'Debit');
INSERT INTO chart_of_accounts VALUES ('5030', 'Utilities', 'Expense', 'Debit');
INSERT INTO chart_of_accounts VALUES ('5040', 'Delivery Fees', 'Expense', 'Debit');
INSERT INTO chart_of_accounts VALUES ('5050', 'CC Processing Fees', 'Expense', 'Debit');
INSERT INTO chart_of_accounts VALUES ('5060', 'Marketing', 'Expense', 'Debit');
INSERT INTO chart_of_accounts VALUES ('5070', 'Franchise Fees', 'Expense', 'Debit');

-- restaurants (5 rows)
INSERT INTO restaurants VALUES ('101', 'Trailhead Burger Co. #101 - San Antonio, TX');
INSERT INTO restaurants VALUES ('102', 'Trailhead Burger Co. #102 - Austin, TX');
INSERT INTO restaurants VALUES ('103', 'Trailhead Burger Co. #103 - Corpus Christi, TX');
INSERT INTO restaurants VALUES ('104', 'Trailhead Burger Co. #104 - Laredo, TX');
INSERT INTO restaurants VALUES ('105', 'Trailhead Burger Co. #105 - Houston, TX');

-- vendors (9 rows)
INSERT INTO vendors VALUES ('V01', 'Gulf Coast Meat Supply');
INSERT INTO vendors VALUES ('V02', 'Fresh Produce Partners');
INSERT INTO vendors VALUES ('V03', 'Lone Star Beverage Distributing');
INSERT INTO vendors VALUES ('V04', 'Southwest Packaging Co.');
INSERT INTO vendors VALUES ('V05', 'QuickDash Delivery Platform');
INSERT INTO vendors VALUES ('V07', 'CityWide Utilities');
INSERT INTO vendors VALUES ('V08', 'Prime Property Management');
INSERT INTO vendors VALUES ('V09', 'BrightSign Marketing Agency');
INSERT INTO vendors VALUES ('V10', 'Trailhead Burger Co. - Corporate');

-- budget (30 rows)
INSERT INTO budget VALUES ('4000', '2026-01', 470000.0);
INSERT INTO budget VALUES ('4000', '2026-02', 480000.0);
INSERT INTO budget VALUES ('4000', '2026-03', 490000.0);
INSERT INTO budget VALUES ('4010', '2026-01', 103000.0);
INSERT INTO budget VALUES ('4010', '2026-02', 106000.0);
INSERT INTO budget VALUES ('4010', '2026-03', 108000.0);
INSERT INTO budget VALUES ('5000', '2026-01', 172000.0);
INSERT INTO budget VALUES ('5000', '2026-02', 176000.0);
INSERT INTO budget VALUES ('5000', '2026-03', 179000.0);
INSERT INTO budget VALUES ('5010', '2026-01', 149000.0);
INSERT INTO budget VALUES ('5010', '2026-02', 152000.0);
INSERT INTO budget VALUES ('5010', '2026-03', 155000.0);
INSERT INTO budget VALUES ('5020', '2026-01', 45000.0);
INSERT INTO budget VALUES ('5020', '2026-02', 45000.0);
INSERT INTO budget VALUES ('5020', '2026-03', 45000.0);
INSERT INTO budget VALUES ('5030', '2026-01', 12000.0);
INSERT INTO budget VALUES ('5030', '2026-02', 12000.0);
INSERT INTO budget VALUES ('5030', '2026-03', 12200.0);
INSERT INTO budget VALUES ('5040', '2026-01', 17000.0);
INSERT INTO budget VALUES ('5040', '2026-02', 17500.0);
INSERT INTO budget VALUES ('5040', '2026-03', 17800.0);
INSERT INTO budget VALUES ('5050', '2026-01', 14300.0);
INSERT INTO budget VALUES ('5050', '2026-02', 14600.0);
INSERT INTO budget VALUES ('5050', '2026-03', 14900.0);
INSERT INTO budget VALUES ('5060', '2026-01', 17200.0);
INSERT INTO budget VALUES ('5060', '2026-02', 17600.0);
INSERT INTO budget VALUES ('5060', '2026-03', 17900.0);
INSERT INTO budget VALUES ('5070', '2026-01', 22900.0);
INSERT INTO budget VALUES ('5070', '2026-02', 23400.0);
INSERT INTO budget VALUES ('5070', '2026-03', 23900.0);

-- transactions (410 rows)
INSERT INTO transactions VALUES (1, 'T0001', '2026-01-02', '101', '1000', 60000.0, 0.0, 'Owner capital contribution', 'N/A', 'Corporate', NULL, 'Finance');
INSERT INTO transactions VALUES (2, 'T0001', '2026-01-02', '101', '3000', 0.0, 60000.0, 'Owner capital contribution', 'N/A', 'Corporate', NULL, 'Finance');
INSERT INTO transactions VALUES (3, 'T0002', '2026-01-02', '101', '1000', 40000.0, 0.0, 'Proceeds from equipment loan', 'N/A', 'Corporate', NULL, 'Finance');
INSERT INTO transactions VALUES (4, 'T0002', '2026-01-02', '101', '2010', 0.0, 40000.0, 'Proceeds from equipment loan', 'N/A', 'Corporate', NULL, 'Finance');
INSERT INTO transactions VALUES (5, 'T0003', '2026-01-02', '101', '1030', 95000.0, 0.0, 'Purchase of kitchen equipment', 'N/A', 'Corporate', 'V10', 'Operations');
INSERT INTO transactions VALUES (6, 'T0003', '2026-01-02', '101', '1000', 0.0, 95000.0, 'Purchase of kitchen equipment', 'N/A', 'Corporate', 'V10', 'Operations');
INSERT INTO transactions VALUES (7, 'T0004', '2026-01-02', '102', '1000', 60000.0, 0.0, 'Owner capital contribution', 'N/A', 'Corporate', NULL, 'Finance');
INSERT INTO transactions VALUES (8, 'T0004', '2026-01-02', '102', '3000', 0.0, 60000.0, 'Owner capital contribution', 'N/A', 'Corporate', NULL, 'Finance');
INSERT INTO transactions VALUES (9, 'T0005', '2026-01-02', '102', '1000', 40000.0, 0.0, 'Proceeds from equipment loan', 'N/A', 'Corporate', NULL, 'Finance');
INSERT INTO transactions VALUES (10, 'T0005', '2026-01-02', '102', '2010', 0.0, 40000.0, 'Proceeds from equipment loan', 'N/A', 'Corporate', NULL, 'Finance');
INSERT INTO transactions VALUES (11, 'T0006', '2026-01-02', '102', '1030', 95000.0, 0.0, 'Purchase of kitchen equipment', 'N/A', 'Corporate', 'V10', 'Operations');
INSERT INTO transactions VALUES (12, 'T0006', '2026-01-02', '102', '1000', 0.0, 95000.0, 'Purchase of kitchen equipment', 'N/A', 'Corporate', 'V10', 'Operations');
INSERT INTO transactions VALUES (13, 'T0007', '2026-01-02', '103', '1000', 60000.0, 0.0, 'Owner capital contribution', 'N/A', 'Corporate', NULL, 'Finance');
INSERT INTO transactions VALUES (14, 'T0007', '2026-01-02', '103', '3000', 0.0, 60000.0, 'Owner capital contribution', 'N/A', 'Corporate', NULL, 'Finance');
INSERT INTO transactions VALUES (15, 'T0008', '2026-01-02', '103', '1000', 40000.0, 0.0, 'Proceeds from equipment loan', 'N/A', 'Corporate', NULL, 'Finance');
INSERT INTO transactions VALUES (16, 'T0008', '2026-01-02', '103', '2010', 0.0, 40000.0, 'Proceeds from equipment loan', 'N/A', 'Corporate', NULL, 'Finance');
INSERT INTO transactions VALUES (17, 'T0009', '2026-01-02', '103', '1030', 95000.0, 0.0, 'Purchase of kitchen equipment', 'N/A', 'Corporate', 'V10', 'Operations');
INSERT INTO transactions VALUES (18, 'T0009', '2026-01-02', '103', '1000', 0.0, 95000.0, 'Purchase of kitchen equipment', 'N/A', 'Corporate', 'V10', 'Operations');
INSERT INTO transactions VALUES (19, 'T0010', '2026-01-02', '104', '1000', 60000.0, 0.0, 'Owner capital contribution', 'N/A', 'Corporate', NULL, 'Finance');
INSERT INTO transactions VALUES (20, 'T0010', '2026-01-02', '104', '3000', 0.0, 60000.0, 'Owner capital contribution', 'N/A', 'Corporate', NULL, 'Finance');
INSERT INTO transactions VALUES (21, 'T0011', '2026-01-02', '104', '1000', 40000.0, 0.0, 'Proceeds from equipment loan', 'N/A', 'Corporate', NULL, 'Finance');
INSERT INTO transactions VALUES (22, 'T0011', '2026-01-02', '104', '2010', 0.0, 40000.0, 'Proceeds from equipment loan', 'N/A', 'Corporate', NULL, 'Finance');
INSERT INTO transactions VALUES (23, 'T0012', '2026-01-02', '104', '1030', 95000.0, 0.0, 'Purchase of kitchen equipment', 'N/A', 'Corporate', 'V10', 'Operations');
INSERT INTO transactions VALUES (24, 'T0012', '2026-01-02', '104', '1000', 0.0, 95000.0, 'Purchase of kitchen equipment', 'N/A', 'Corporate', 'V10', 'Operations');
INSERT INTO transactions VALUES (25, 'T0013', '2026-01-02', '105', '1000', 60000.0, 0.0, 'Owner capital contribution', 'N/A', 'Corporate', NULL, 'Finance');
INSERT INTO transactions VALUES (26, 'T0013', '2026-01-02', '105', '3000', 0.0, 60000.0, 'Owner capital contribution', 'N/A', 'Corporate', NULL, 'Finance');
INSERT INTO transactions VALUES (27, 'T0014', '2026-01-02', '105', '1000', 40000.0, 0.0, 'Proceeds from equipment loan', 'N/A', 'Corporate', NULL, 'Finance');
INSERT INTO transactions VALUES (28, 'T0014', '2026-01-02', '105', '2010', 0.0, 40000.0, 'Proceeds from equipment loan', 'N/A', 'Corporate', NULL, 'Finance');
INSERT INTO transactions VALUES (29, 'T0015', '2026-01-02', '105', '1030', 95000.0, 0.0, 'Purchase of kitchen equipment', 'N/A', 'Corporate', 'V10', 'Operations');
INSERT INTO transactions VALUES (30, 'T0015', '2026-01-02', '105', '1000', 0.0, 95000.0, 'Purchase of kitchen equipment', 'N/A', 'Corporate', 'V10', 'Operations');
INSERT INTO transactions VALUES (31, 'T0016', '2026-01-05', '101', '1000', 100000.0, 0.0, 'Weekly dine-in & drive-thru sales', 'Cash', 'Dine-In', NULL, 'Restaurant Ops');
INSERT INTO transactions VALUES (32, 'T0016', '2026-01-05', '101', '4000', 0.0, 100000.0, 'Weekly dine-in & drive-thru sales', 'Cash', 'Dine-In', NULL, 'Restaurant Ops');
INSERT INTO transactions VALUES (33, 'T0017', '2026-01-07', '101', '1010', 22000.0, 0.0, 'Delivery sales via QuickDash', 'Delivery Platform Settlement', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (34, 'T0017', '2026-01-07', '101', '4010', 0.0, 22000.0, 'Delivery sales via QuickDash', 'Delivery Platform Settlement', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (35, 'T0018', '2026-01-10', '101', '1000', 22000.0, 0.0, 'Collection of delivery platform settlement', 'Delivery Platform Settlement', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (36, 'T0018', '2026-01-10', '101', '1010', 0.0, 22000.0, 'Collection of delivery platform settlement', 'Delivery Platform Settlement', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (37, 'T0019', '2026-01-10', '101', '5040', 3300.0, 0.0, 'Delivery platform commission fee', 'Cash', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (38, 'T0019', '2026-01-10', '101', '1000', 0.0, 3300.0, 'Delivery platform commission fee', 'Cash', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (39, 'T0020', '2026-01-08', '101', '1020', 38430.0, 0.0, 'Food & beverage inventory purchase', 'N/A', 'Corporate', 'V01', 'Supply Chain');
INSERT INTO transactions VALUES (40, 'T0020', '2026-01-08', '101', '2000', 0.0, 38430.0, 'Food & beverage inventory purchase', 'N/A', 'Corporate', 'V01', 'Supply Chain');
INSERT INTO transactions VALUES (41, 'T0021', '2026-01-28', '101', '5000', 36600.0, 0.0, 'Cost of food sold - monthly usage', 'N/A', 'Corporate', 'V01', 'Restaurant Ops');
INSERT INTO transactions VALUES (42, 'T0021', '2026-01-28', '101', '1020', 0.0, 36600.0, 'Cost of food sold - monthly usage', 'N/A', 'Corporate', 'V01', 'Restaurant Ops');
INSERT INTO transactions VALUES (43, 'T0022', '2026-01-15', '101', '5010', 31720.0, 0.0, 'Bi-weekly payroll', 'Cash', 'Corporate', NULL, 'Human Resources');
INSERT INTO transactions VALUES (44, 'T0022', '2026-01-15', '101', '1000', 0.0, 31720.0, 'Bi-weekly payroll', 'Cash', 'Corporate', NULL, 'Human Resources');
INSERT INTO transactions VALUES (45, 'T0023', '2026-01-01', '101', '5020', 9500.0, 0.0, 'Monthly rent payment', 'Cash', 'Corporate', 'V08', 'Finance');
INSERT INTO transactions VALUES (46, 'T0023', '2026-01-01', '101', '1000', 0.0, 9500.0, 'Monthly rent payment', 'Cash', 'Corporate', 'V08', 'Finance');
INSERT INTO transactions VALUES (47, 'T0024', '2026-01-20', '101', '5030', 2600.0, 0.0, 'Monthly utilities payment', 'Cash', 'Corporate', 'V07', 'Facilities');
INSERT INTO transactions VALUES (48, 'T0024', '2026-01-20', '101', '1000', 0.0, 2600.0, 'Monthly utilities payment', 'Cash', 'Corporate', 'V07', 'Facilities');
INSERT INTO transactions VALUES (49, 'T0025', '2026-01-28', '101', '5050', 3050.0, 0.0, 'Credit card processing fees', 'Cash', 'Corporate', NULL, 'Finance');
INSERT INTO transactions VALUES (50, 'T0025', '2026-01-28', '101', '1000', 0.0, 3050.0, 'Credit card processing fees', 'Cash', 'Corporate', NULL, 'Finance');
INSERT INTO transactions VALUES (51, 'T0026', '2026-01-12', '101', '5060', 3660.0, 0.0, 'Local store marketing spend', 'Cash', 'Corporate', 'V09', 'Marketing');
INSERT INTO transactions VALUES (52, 'T0026', '2026-01-12', '101', '1000', 0.0, 3660.0, 'Local store marketing spend', 'Cash', 'Corporate', 'V09', 'Marketing');
INSERT INTO transactions VALUES (53, 'T0027', '2026-01-30', '101', '5070', 4880.0, 0.0, 'Monthly franchise fee to corporate', 'Cash', 'Corporate', 'V10', 'Finance');
INSERT INTO transactions VALUES (54, 'T0027', '2026-01-30', '101', '1000', 0.0, 4880.0, 'Monthly franchise fee to corporate', 'Cash', 'Corporate', 'V10', 'Finance');
INSERT INTO transactions VALUES (55, 'T0028', '2026-02-05', '101', '1000', 102000.0, 0.0, 'Weekly dine-in & drive-thru sales', 'Cash', 'Dine-In', NULL, 'Restaurant Ops');
INSERT INTO transactions VALUES (56, 'T0028', '2026-02-05', '101', '4000', 0.0, 102000.0, 'Weekly dine-in & drive-thru sales', 'Cash', 'Dine-In', NULL, 'Restaurant Ops');
INSERT INTO transactions VALUES (57, 'T0029', '2026-02-07', '101', '1010', 22440.0, 0.0, 'Delivery sales via QuickDash', 'Delivery Platform Settlement', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (58, 'T0029', '2026-02-07', '101', '4010', 0.0, 22440.0, 'Delivery sales via QuickDash', 'Delivery Platform Settlement', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (59, 'T0030', '2026-02-10', '101', '1000', 22440.0, 0.0, 'Collection of delivery platform settlement', 'Delivery Platform Settlement', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (60, 'T0030', '2026-02-10', '101', '1010', 0.0, 22440.0, 'Collection of delivery platform settlement', 'Delivery Platform Settlement', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (61, 'T0031', '2026-02-10', '101', '5040', 3366.0, 0.0, 'Delivery platform commission fee', 'Cash', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (62, 'T0031', '2026-02-10', '101', '1000', 0.0, 3366.0, 'Delivery platform commission fee', 'Cash', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (63, 'T0032', '2026-02-08', '101', '1020', 39198.6, 0.0, 'Food & beverage inventory purchase', 'N/A', 'Corporate', 'V02', 'Supply Chain');
INSERT INTO transactions VALUES (64, 'T0032', '2026-02-08', '101', '2000', 0.0, 39198.6, 'Food & beverage inventory purchase', 'N/A', 'Corporate', 'V02', 'Supply Chain');
INSERT INTO transactions VALUES (65, 'T0033', '2026-02-28', '101', '5000', 37332.0, 0.0, 'Cost of food sold - monthly usage', 'N/A', 'Corporate', 'V02', 'Restaurant Ops');
INSERT INTO transactions VALUES (66, 'T0033', '2026-02-28', '101', '1020', 0.0, 37332.0, 'Cost of food sold - monthly usage', 'N/A', 'Corporate', 'V02', 'Restaurant Ops');
INSERT INTO transactions VALUES (67, 'T0034', '2026-02-15', '101', '5010', 32354.4, 0.0, 'Bi-weekly payroll', 'Cash', 'Corporate', NULL, 'Human Resources');
INSERT INTO transactions VALUES (68, 'T0034', '2026-02-15', '101', '1000', 0.0, 32354.4, 'Bi-weekly payroll', 'Cash', 'Corporate', NULL, 'Human Resources');
INSERT INTO transactions VALUES (69, 'T0035', '2026-02-01', '101', '5020', 9500.0, 0.0, 'Monthly rent payment', 'Cash', 'Corporate', 'V08', 'Finance');
INSERT INTO transactions VALUES (70, 'T0035', '2026-02-01', '101', '1000', 0.0, 9500.0, 'Monthly rent payment', 'Cash', 'Corporate', 'V08', 'Finance');
INSERT INTO transactions VALUES (71, 'T0036', '2026-02-20', '101', '5030', 2678.0, 0.0, 'Monthly utilities payment', 'Cash', 'Corporate', 'V07', 'Facilities');
INSERT INTO transactions VALUES (72, 'T0036', '2026-02-20', '101', '1000', 0.0, 2678.0, 'Monthly utilities payment', 'Cash', 'Corporate', 'V07', 'Facilities');
INSERT INTO transactions VALUES (73, 'T0037', '2026-02-28', '101', '5050', 3111.0, 0.0, 'Credit card processing fees', 'Cash', 'Corporate', NULL, 'Finance');
INSERT INTO transactions VALUES (74, 'T0037', '2026-02-28', '101', '1000', 0.0, 3111.0, 'Credit card processing fees', 'Cash', 'Corporate', NULL, 'Finance');
INSERT INTO transactions VALUES (75, 'T0038', '2026-02-12', '101', '5060', 3733.2, 0.0, 'Local store marketing spend', 'Cash', 'Corporate', 'V09', 'Marketing');
INSERT INTO transactions VALUES (76, 'T0038', '2026-02-12', '101', '1000', 0.0, 3733.2, 'Local store marketing spend', 'Cash', 'Corporate', 'V09', 'Marketing');
INSERT INTO transactions VALUES (77, 'T0039', '2026-02-28', '101', '5070', 4977.6, 0.0, 'Monthly franchise fee to corporate', 'Cash', 'Corporate', 'V10', 'Finance');
INSERT INTO transactions VALUES (78, 'T0039', '2026-02-28', '101', '1000', 0.0, 4977.6, 'Monthly franchise fee to corporate', 'Cash', 'Corporate', 'V10', 'Finance');
INSERT INTO transactions VALUES (79, 'T0040', '2026-02-18', '101', '2000', 33598.8, 0.0, 'Payment on vendor account payable', 'Cash', 'Corporate', 'V02', 'Finance');
INSERT INTO transactions VALUES (80, 'T0040', '2026-02-18', '101', '1000', 0.0, 33598.8, 'Payment on vendor account payable', 'Cash', 'Corporate', 'V02', 'Finance');
INSERT INTO transactions VALUES (81, 'T0041', '2026-03-05', '101', '1000', 104000.0, 0.0, 'Weekly dine-in & drive-thru sales', 'Cash', 'Dine-In', NULL, 'Restaurant Ops');
INSERT INTO transactions VALUES (82, 'T0041', '2026-03-05', '101', '4000', 0.0, 104000.0, 'Weekly dine-in & drive-thru sales', 'Cash', 'Dine-In', NULL, 'Restaurant Ops');
INSERT INTO transactions VALUES (83, 'T0042', '2026-03-07', '101', '1010', 22880.0, 0.0, 'Delivery sales via QuickDash', 'Delivery Platform Settlement', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (84, 'T0042', '2026-03-07', '101', '4010', 0.0, 22880.0, 'Delivery sales via QuickDash', 'Delivery Platform Settlement', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (85, 'T0043', '2026-03-10', '101', '1000', 22880.0, 0.0, 'Collection of delivery platform settlement', 'Delivery Platform Settlement', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (86, 'T0043', '2026-03-10', '101', '1010', 0.0, 22880.0, 'Collection of delivery platform settlement', 'Delivery Platform Settlement', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (87, 'T0044', '2026-03-10', '101', '5040', 3432.0, 0.0, 'Delivery platform commission fee', 'Cash', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (88, 'T0044', '2026-03-10', '101', '1000', 0.0, 3432.0, 'Delivery platform commission fee', 'Cash', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (89, 'T0045', '2026-03-08', '101', '1020', 39967.2, 0.0, 'Food & beverage inventory purchase', 'N/A', 'Corporate', 'V01', 'Supply Chain');
INSERT INTO transactions VALUES (90, 'T0045', '2026-03-08', '101', '2000', 0.0, 39967.2, 'Food & beverage inventory purchase', 'N/A', 'Corporate', 'V01', 'Supply Chain');
INSERT INTO transactions VALUES (91, 'T0046', '2026-03-28', '101', '5000', 38064.0, 0.0, 'Cost of food sold - monthly usage', 'N/A', 'Corporate', 'V01', 'Restaurant Ops');
INSERT INTO transactions VALUES (92, 'T0046', '2026-03-28', '101', '1020', 0.0, 38064.0, 'Cost of food sold - monthly usage', 'N/A', 'Corporate', 'V01', 'Restaurant Ops');
INSERT INTO transactions VALUES (93, 'T0047', '2026-03-15', '101', '5010', 32988.8, 0.0, 'Bi-weekly payroll', 'Cash', 'Corporate', NULL, 'Human Resources');
INSERT INTO transactions VALUES (94, 'T0047', '2026-03-15', '101', '1000', 0.0, 32988.8, 'Bi-weekly payroll', 'Cash', 'Corporate', NULL, 'Human Resources');
INSERT INTO transactions VALUES (95, 'T0048', '2026-03-01', '101', '5020', 9500.0, 0.0, 'Monthly rent payment', 'Cash', 'Corporate', 'V08', 'Finance');
INSERT INTO transactions VALUES (96, 'T0048', '2026-03-01', '101', '1000', 0.0, 9500.0, 'Monthly rent payment', 'Cash', 'Corporate', 'V08', 'Finance');
INSERT INTO transactions VALUES (97, 'T0049', '2026-03-20', '101', '5030', 2756.0, 0.0, 'Monthly utilities payment', 'Cash', 'Corporate', 'V07', 'Facilities');
INSERT INTO transactions VALUES (98, 'T0049', '2026-03-20', '101', '1000', 0.0, 2756.0, 'Monthly utilities payment', 'Cash', 'Corporate', 'V07', 'Facilities');
INSERT INTO transactions VALUES (99, 'T0050', '2026-03-28', '101', '5050', 3172.0, 0.0, 'Credit card processing fees', 'Cash', 'Corporate', NULL, 'Finance');
INSERT INTO transactions VALUES (100, 'T0050', '2026-03-28', '101', '1000', 0.0, 3172.0, 'Credit card processing fees', 'Cash', 'Corporate', NULL, 'Finance');
INSERT INTO transactions VALUES (101, 'T0051', '2026-03-12', '101', '5060', 3806.4, 0.0, 'Local store marketing spend', 'Cash', 'Corporate', 'V09', 'Marketing');
INSERT INTO transactions VALUES (102, 'T0051', '2026-03-12', '101', '1000', 0.0, 3806.4, 'Local store marketing spend', 'Cash', 'Corporate', 'V09', 'Marketing');
INSERT INTO transactions VALUES (103, 'T0052', '2026-03-30', '101', '5070', 5075.2, 0.0, 'Monthly franchise fee to corporate', 'Cash', 'Corporate', 'V10', 'Finance');
INSERT INTO transactions VALUES (104, 'T0052', '2026-03-30', '101', '1000', 0.0, 5075.2, 'Monthly franchise fee to corporate', 'Cash', 'Corporate', 'V10', 'Finance');
INSERT INTO transactions VALUES (105, 'T0053', '2026-03-18', '101', '2000', 34257.6, 0.0, 'Payment on vendor account payable', 'Cash', 'Corporate', 'V01', 'Finance');
INSERT INTO transactions VALUES (106, 'T0053', '2026-03-18', '101', '1000', 0.0, 34257.6, 'Payment on vendor account payable', 'Cash', 'Corporate', 'V01', 'Finance');
INSERT INTO transactions VALUES (107, 'T0054', '2026-01-05', '102', '1000', 95000.0, 0.0, 'Weekly dine-in & drive-thru sales', 'Cash', 'Dine-In', NULL, 'Restaurant Ops');
INSERT INTO transactions VALUES (108, 'T0054', '2026-01-05', '102', '4000', 0.0, 95000.0, 'Weekly dine-in & drive-thru sales', 'Cash', 'Dine-In', NULL, 'Restaurant Ops');
INSERT INTO transactions VALUES (109, 'T0055', '2026-01-07', '102', '1010', 20900.0, 0.0, 'Delivery sales via QuickDash', 'Delivery Platform Settlement', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (110, 'T0055', '2026-01-07', '102', '4010', 0.0, 20900.0, 'Delivery sales via QuickDash', 'Delivery Platform Settlement', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (111, 'T0056', '2026-01-10', '102', '1000', 20900.0, 0.0, 'Collection of delivery platform settlement', 'Delivery Platform Settlement', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (112, 'T0056', '2026-01-10', '102', '1010', 0.0, 20900.0, 'Collection of delivery platform settlement', 'Delivery Platform Settlement', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (113, 'T0057', '2026-01-10', '102', '5040', 3135.0, 0.0, 'Delivery platform commission fee', 'Cash', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (114, 'T0057', '2026-01-10', '102', '1000', 0.0, 3135.0, 'Delivery platform commission fee', 'Cash', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (115, 'T0058', '2026-01-08', '102', '1020', 36508.5, 0.0, 'Food & beverage inventory purchase', 'N/A', 'Corporate', 'V01', 'Supply Chain');
INSERT INTO transactions VALUES (116, 'T0058', '2026-01-08', '102', '2000', 0.0, 36508.5, 'Food & beverage inventory purchase', 'N/A', 'Corporate', 'V01', 'Supply Chain');
INSERT INTO transactions VALUES (117, 'T0059', '2026-01-28', '102', '5000', 34770.0, 0.0, 'Cost of food sold - monthly usage', 'N/A', 'Corporate', 'V01', 'Restaurant Ops');
INSERT INTO transactions VALUES (118, 'T0059', '2026-01-28', '102', '1020', 0.0, 34770.0, 'Cost of food sold - monthly usage', 'N/A', 'Corporate', 'V01', 'Restaurant Ops');
INSERT INTO transactions VALUES (119, 'T0060', '2026-01-15', '102', '5010', 30134.0, 0.0, 'Bi-weekly payroll', 'Cash', 'Corporate', NULL, 'Human Resources');
INSERT INTO transactions VALUES (120, 'T0060', '2026-01-15', '102', '1000', 0.0, 30134.0, 'Bi-weekly payroll', 'Cash', 'Corporate', NULL, 'Human Resources');
INSERT INTO transactions VALUES (121, 'T0061', '2026-01-01', '102', '5020', 9000.0, 0.0, 'Monthly rent payment', 'Cash', 'Corporate', 'V08', 'Finance');
INSERT INTO transactions VALUES (122, 'T0061', '2026-01-01', '102', '1000', 0.0, 9000.0, 'Monthly rent payment', 'Cash', 'Corporate', 'V08', 'Finance');
INSERT INTO transactions VALUES (123, 'T0062', '2026-01-20', '102', '5030', 2400.0, 0.0, 'Monthly utilities payment', 'Cash', 'Corporate', 'V07', 'Facilities');
INSERT INTO transactions VALUES (124, 'T0062', '2026-01-20', '102', '1000', 0.0, 2400.0, 'Monthly utilities payment', 'Cash', 'Corporate', 'V07', 'Facilities');
INSERT INTO transactions VALUES (125, 'T0063', '2026-01-28', '102', '5050', 2897.5, 0.0, 'Credit card processing fees', 'Cash', 'Corporate', NULL, 'Finance');
INSERT INTO transactions VALUES (126, 'T0063', '2026-01-28', '102', '1000', 0.0, 2897.5, 'Credit card processing fees', 'Cash', 'Corporate', NULL, 'Finance');
INSERT INTO transactions VALUES (127, 'T0064', '2026-01-12', '102', '5060', 3477.0, 0.0, 'Local store marketing spend', 'Cash', 'Corporate', 'V09', 'Marketing');
INSERT INTO transactions VALUES (128, 'T0064', '2026-01-12', '102', '1000', 0.0, 3477.0, 'Local store marketing spend', 'Cash', 'Corporate', 'V09', 'Marketing');
INSERT INTO transactions VALUES (129, 'T0065', '2026-01-30', '102', '5070', 4636.0, 0.0, 'Monthly franchise fee to corporate', 'Cash', 'Corporate', 'V10', 'Finance');
INSERT INTO transactions VALUES (130, 'T0065', '2026-01-30', '102', '1000', 0.0, 4636.0, 'Monthly franchise fee to corporate', 'Cash', 'Corporate', 'V10', 'Finance');
INSERT INTO transactions VALUES (131, 'T0066', '2026-02-05', '102', '1000', 96900.0, 0.0, 'Weekly dine-in & drive-thru sales', 'Cash', 'Dine-In', NULL, 'Restaurant Ops');
INSERT INTO transactions VALUES (132, 'T0066', '2026-02-05', '102', '4000', 0.0, 96900.0, 'Weekly dine-in & drive-thru sales', 'Cash', 'Dine-In', NULL, 'Restaurant Ops');
INSERT INTO transactions VALUES (133, 'T0067', '2026-02-07', '102', '1010', 21318.0, 0.0, 'Delivery sales via QuickDash', 'Delivery Platform Settlement', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (134, 'T0067', '2026-02-07', '102', '4010', 0.0, 21318.0, 'Delivery sales via QuickDash', 'Delivery Platform Settlement', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (135, 'T0068', '2026-02-10', '102', '1000', 21318.0, 0.0, 'Collection of delivery platform settlement', 'Delivery Platform Settlement', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (136, 'T0068', '2026-02-10', '102', '1010', 0.0, 21318.0, 'Collection of delivery platform settlement', 'Delivery Platform Settlement', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (137, 'T0069', '2026-02-10', '102', '5040', 3197.7, 0.0, 'Delivery platform commission fee', 'Cash', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (138, 'T0069', '2026-02-10', '102', '1000', 0.0, 3197.7, 'Delivery platform commission fee', 'Cash', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (139, 'T0070', '2026-02-08', '102', '1020', 37238.67, 0.0, 'Food & beverage inventory purchase', 'N/A', 'Corporate', 'V02', 'Supply Chain');
INSERT INTO transactions VALUES (140, 'T0070', '2026-02-08', '102', '2000', 0.0, 37238.67, 'Food & beverage inventory purchase', 'N/A', 'Corporate', 'V02', 'Supply Chain');
INSERT INTO transactions VALUES (141, 'T0071', '2026-02-28', '102', '5000', 35465.4, 0.0, 'Cost of food sold - monthly usage', 'N/A', 'Corporate', 'V02', 'Restaurant Ops');
INSERT INTO transactions VALUES (142, 'T0071', '2026-02-28', '102', '1020', 0.0, 35465.4, 'Cost of food sold - monthly usage', 'N/A', 'Corporate', 'V02', 'Restaurant Ops');
INSERT INTO transactions VALUES (143, 'T0072', '2026-02-15', '102', '5010', 30736.68, 0.0, 'Bi-weekly payroll', 'Cash', 'Corporate', NULL, 'Human Resources');
INSERT INTO transactions VALUES (144, 'T0072', '2026-02-15', '102', '1000', 0.0, 30736.68, 'Bi-weekly payroll', 'Cash', 'Corporate', NULL, 'Human Resources');
INSERT INTO transactions VALUES (145, 'T0073', '2026-02-01', '102', '5020', 9000.0, 0.0, 'Monthly rent payment', 'Cash', 'Corporate', 'V08', 'Finance');
INSERT INTO transactions VALUES (146, 'T0073', '2026-02-01', '102', '1000', 0.0, 9000.0, 'Monthly rent payment', 'Cash', 'Corporate', 'V08', 'Finance');
INSERT INTO transactions VALUES (147, 'T0074', '2026-02-20', '102', '5030', 2472.0, 0.0, 'Monthly utilities payment', 'Cash', 'Corporate', 'V07', 'Facilities');
INSERT INTO transactions VALUES (148, 'T0074', '2026-02-20', '102', '1000', 0.0, 2472.0, 'Monthly utilities payment', 'Cash', 'Corporate', 'V07', 'Facilities');
INSERT INTO transactions VALUES (149, 'T0075', '2026-02-28', '102', '5050', 2955.45, 0.0, 'Credit card processing fees', 'Cash', 'Corporate', NULL, 'Finance');
INSERT INTO transactions VALUES (150, 'T0075', '2026-02-28', '102', '1000', 0.0, 2955.45, 'Credit card processing fees', 'Cash', 'Corporate', NULL, 'Finance');
INSERT INTO transactions VALUES (151, 'T0076', '2026-02-12', '102', '5060', 3546.54, 0.0, 'Local store marketing spend', 'Cash', 'Corporate', 'V09', 'Marketing');
INSERT INTO transactions VALUES (152, 'T0076', '2026-02-12', '102', '1000', 0.0, 3546.54, 'Local store marketing spend', 'Cash', 'Corporate', 'V09', 'Marketing');
INSERT INTO transactions VALUES (153, 'T0077', '2026-02-28', '102', '5070', 4728.72, 0.0, 'Monthly franchise fee to corporate', 'Cash', 'Corporate', 'V10', 'Finance');
INSERT INTO transactions VALUES (154, 'T0077', '2026-02-28', '102', '1000', 0.0, 4728.72, 'Monthly franchise fee to corporate', 'Cash', 'Corporate', 'V10', 'Finance');
INSERT INTO transactions VALUES (155, 'T0078', '2026-02-18', '102', '2000', 31918.86, 0.0, 'Payment on vendor account payable', 'Cash', 'Corporate', 'V02', 'Finance');
INSERT INTO transactions VALUES (156, 'T0078', '2026-02-18', '102', '1000', 0.0, 31918.86, 'Payment on vendor account payable', 'Cash', 'Corporate', 'V02', 'Finance');
INSERT INTO transactions VALUES (157, 'T0079', '2026-03-05', '102', '1000', 98800.0, 0.0, 'Weekly dine-in & drive-thru sales', 'Cash', 'Dine-In', NULL, 'Restaurant Ops');
INSERT INTO transactions VALUES (158, 'T0079', '2026-03-05', '102', '4000', 0.0, 98800.0, 'Weekly dine-in & drive-thru sales', 'Cash', 'Dine-In', NULL, 'Restaurant Ops');
INSERT INTO transactions VALUES (159, 'T0080', '2026-03-07', '102', '1010', 21736.0, 0.0, 'Delivery sales via QuickDash', 'Delivery Platform Settlement', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (160, 'T0080', '2026-03-07', '102', '4010', 0.0, 21736.0, 'Delivery sales via QuickDash', 'Delivery Platform Settlement', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (161, 'T0081', '2026-03-10', '102', '1000', 21736.0, 0.0, 'Collection of delivery platform settlement', 'Delivery Platform Settlement', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (162, 'T0081', '2026-03-10', '102', '1010', 0.0, 21736.0, 'Collection of delivery platform settlement', 'Delivery Platform Settlement', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (163, 'T0082', '2026-03-10', '102', '5040', 3260.4, 0.0, 'Delivery platform commission fee', 'Cash', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (164, 'T0082', '2026-03-10', '102', '1000', 0.0, 3260.4, 'Delivery platform commission fee', 'Cash', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (165, 'T0083', '2026-03-08', '102', '1020', 37968.84, 0.0, 'Food & beverage inventory purchase', 'N/A', 'Corporate', 'V01', 'Supply Chain');
INSERT INTO transactions VALUES (166, 'T0083', '2026-03-08', '102', '2000', 0.0, 37968.84, 'Food & beverage inventory purchase', 'N/A', 'Corporate', 'V01', 'Supply Chain');
INSERT INTO transactions VALUES (167, 'T0084', '2026-03-28', '102', '5000', 36160.8, 0.0, 'Cost of food sold - monthly usage', 'N/A', 'Corporate', 'V01', 'Restaurant Ops');
INSERT INTO transactions VALUES (168, 'T0084', '2026-03-28', '102', '1020', 0.0, 36160.8, 'Cost of food sold - monthly usage', 'N/A', 'Corporate', 'V01', 'Restaurant Ops');
INSERT INTO transactions VALUES (169, 'T0085', '2026-03-15', '102', '5010', 31339.36, 0.0, 'Bi-weekly payroll', 'Cash', 'Corporate', NULL, 'Human Resources');
INSERT INTO transactions VALUES (170, 'T0085', '2026-03-15', '102', '1000', 0.0, 31339.36, 'Bi-weekly payroll', 'Cash', 'Corporate', NULL, 'Human Resources');
INSERT INTO transactions VALUES (171, 'T0086', '2026-03-01', '102', '5020', 9000.0, 0.0, 'Monthly rent payment', 'Cash', 'Corporate', 'V08', 'Finance');
INSERT INTO transactions VALUES (172, 'T0086', '2026-03-01', '102', '1000', 0.0, 9000.0, 'Monthly rent payment', 'Cash', 'Corporate', 'V08', 'Finance');
INSERT INTO transactions VALUES (173, 'T0087', '2026-03-20', '102', '5030', 2544.0, 0.0, 'Monthly utilities payment', 'Cash', 'Corporate', 'V07', 'Facilities');
INSERT INTO transactions VALUES (174, 'T0087', '2026-03-20', '102', '1000', 0.0, 2544.0, 'Monthly utilities payment', 'Cash', 'Corporate', 'V07', 'Facilities');
INSERT INTO transactions VALUES (175, 'T0088', '2026-03-28', '102', '5050', 3013.4, 0.0, 'Credit card processing fees', 'Cash', 'Corporate', NULL, 'Finance');
INSERT INTO transactions VALUES (176, 'T0088', '2026-03-28', '102', '1000', 0.0, 3013.4, 'Credit card processing fees', 'Cash', 'Corporate', NULL, 'Finance');
INSERT INTO transactions VALUES (177, 'T0089', '2026-03-12', '102', '5060', 3616.08, 0.0, 'Local store marketing spend', 'Cash', 'Corporate', 'V09', 'Marketing');
INSERT INTO transactions VALUES (178, 'T0089', '2026-03-12', '102', '1000', 0.0, 3616.08, 'Local store marketing spend', 'Cash', 'Corporate', 'V09', 'Marketing');
INSERT INTO transactions VALUES (179, 'T0090', '2026-03-30', '102', '5070', 4821.44, 0.0, 'Monthly franchise fee to corporate', 'Cash', 'Corporate', 'V10', 'Finance');
INSERT INTO transactions VALUES (180, 'T0090', '2026-03-30', '102', '1000', 0.0, 4821.44, 'Monthly franchise fee to corporate', 'Cash', 'Corporate', 'V10', 'Finance');
INSERT INTO transactions VALUES (181, 'T0091', '2026-03-18', '102', '2000', 32544.72, 0.0, 'Payment on vendor account payable', 'Cash', 'Corporate', 'V01', 'Finance');
INSERT INTO transactions VALUES (182, 'T0091', '2026-03-18', '102', '1000', 0.0, 32544.72, 'Payment on vendor account payable', 'Cash', 'Corporate', 'V01', 'Finance');
INSERT INTO transactions VALUES (183, 'T0092', '2026-01-05', '103', '1000', 80000.0, 0.0, 'Weekly dine-in & drive-thru sales', 'Cash', 'Dine-In', NULL, 'Restaurant Ops');
INSERT INTO transactions VALUES (184, 'T0092', '2026-01-05', '103', '4000', 0.0, 80000.0, 'Weekly dine-in & drive-thru sales', 'Cash', 'Dine-In', NULL, 'Restaurant Ops');
INSERT INTO transactions VALUES (185, 'T0093', '2026-01-07', '103', '1010', 17600.0, 0.0, 'Delivery sales via QuickDash', 'Delivery Platform Settlement', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (186, 'T0093', '2026-01-07', '103', '4010', 0.0, 17600.0, 'Delivery sales via QuickDash', 'Delivery Platform Settlement', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (187, 'T0094', '2026-01-10', '103', '1000', 17600.0, 0.0, 'Collection of delivery platform settlement', 'Delivery Platform Settlement', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (188, 'T0094', '2026-01-10', '103', '1010', 0.0, 17600.0, 'Collection of delivery platform settlement', 'Delivery Platform Settlement', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (189, 'T0095', '2026-01-10', '103', '5040', 2640.0, 0.0, 'Delivery platform commission fee', 'Cash', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (190, 'T0095', '2026-01-10', '103', '1000', 0.0, 2640.0, 'Delivery platform commission fee', 'Cash', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (191, 'T0096', '2026-01-08', '103', '1020', 30744.0, 0.0, 'Food & beverage inventory purchase', 'N/A', 'Corporate', 'V01', 'Supply Chain');
INSERT INTO transactions VALUES (192, 'T0096', '2026-01-08', '103', '2000', 0.0, 30744.0, 'Food & beverage inventory purchase', 'N/A', 'Corporate', 'V01', 'Supply Chain');
INSERT INTO transactions VALUES (193, 'T0097', '2026-01-28', '103', '5000', 29280.0, 0.0, 'Cost of food sold - monthly usage', 'N/A', 'Corporate', 'V01', 'Restaurant Ops');
INSERT INTO transactions VALUES (194, 'T0097', '2026-01-28', '103', '1020', 0.0, 29280.0, 'Cost of food sold - monthly usage', 'N/A', 'Corporate', 'V01', 'Restaurant Ops');
INSERT INTO transactions VALUES (195, 'T0098', '2026-01-15', '103', '5010', 25376.0, 0.0, 'Bi-weekly payroll', 'Cash', 'Corporate', NULL, 'Human Resources');
INSERT INTO transactions VALUES (196, 'T0098', '2026-01-15', '103', '1000', 0.0, 25376.0, 'Bi-weekly payroll', 'Cash', 'Corporate', NULL, 'Human Resources');
INSERT INTO transactions VALUES (197, 'T0099', '2026-01-01', '103', '5020', 7500.0, 0.0, 'Monthly rent payment', 'Cash', 'Corporate', 'V08', 'Finance');
INSERT INTO transactions VALUES (198, 'T0099', '2026-01-01', '103', '1000', 0.0, 7500.0, 'Monthly rent payment', 'Cash', 'Corporate', 'V08', 'Finance');
INSERT INTO transactions VALUES (199, 'T0100', '2026-01-20', '103', '5030', 2100.0, 0.0, 'Monthly utilities payment', 'Cash', 'Corporate', 'V07', 'Facilities');
INSERT INTO transactions VALUES (200, 'T0100', '2026-01-20', '103', '1000', 0.0, 2100.0, 'Monthly utilities payment', 'Cash', 'Corporate', 'V07', 'Facilities');
INSERT INTO transactions VALUES (201, 'T0101', '2026-01-28', '103', '5050', 2440.0, 0.0, 'Credit card processing fees', 'Cash', 'Corporate', NULL, 'Finance');
INSERT INTO transactions VALUES (202, 'T0101', '2026-01-28', '103', '1000', 0.0, 2440.0, 'Credit card processing fees', 'Cash', 'Corporate', NULL, 'Finance');
INSERT INTO transactions VALUES (203, 'T0102', '2026-01-12', '103', '5060', 2928.0, 0.0, 'Local store marketing spend', 'Cash', 'Corporate', 'V09', 'Marketing');
INSERT INTO transactions VALUES (204, 'T0102', '2026-01-12', '103', '1000', 0.0, 2928.0, 'Local store marketing spend', 'Cash', 'Corporate', 'V09', 'Marketing');
INSERT INTO transactions VALUES (205, 'T0103', '2026-01-30', '103', '5070', 3904.0, 0.0, 'Monthly franchise fee to corporate', 'Cash', 'Corporate', 'V10', 'Finance');
INSERT INTO transactions VALUES (206, 'T0103', '2026-01-30', '103', '1000', 0.0, 3904.0, 'Monthly franchise fee to corporate', 'Cash', 'Corporate', 'V10', 'Finance');
INSERT INTO transactions VALUES (207, 'T0104', '2026-02-05', '103', '1000', 81600.0, 0.0, 'Weekly dine-in & drive-thru sales', 'Cash', 'Dine-In', NULL, 'Restaurant Ops');
INSERT INTO transactions VALUES (208, 'T0104', '2026-02-05', '103', '4000', 0.0, 81600.0, 'Weekly dine-in & drive-thru sales', 'Cash', 'Dine-In', NULL, 'Restaurant Ops');
INSERT INTO transactions VALUES (209, 'T0105', '2026-02-07', '103', '1010', 17952.0, 0.0, 'Delivery sales via QuickDash', 'Delivery Platform Settlement', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (210, 'T0105', '2026-02-07', '103', '4010', 0.0, 17952.0, 'Delivery sales via QuickDash', 'Delivery Platform Settlement', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (211, 'T0106', '2026-02-10', '103', '1000', 17952.0, 0.0, 'Collection of delivery platform settlement', 'Delivery Platform Settlement', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (212, 'T0106', '2026-02-10', '103', '1010', 0.0, 17952.0, 'Collection of delivery platform settlement', 'Delivery Platform Settlement', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (213, 'T0107', '2026-02-10', '103', '5040', 2692.8, 0.0, 'Delivery platform commission fee', 'Cash', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (214, 'T0107', '2026-02-10', '103', '1000', 0.0, 2692.8, 'Delivery platform commission fee', 'Cash', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (215, 'T0108', '2026-02-08', '103', '1020', 31358.88, 0.0, 'Food & beverage inventory purchase', 'N/A', 'Corporate', 'V02', 'Supply Chain');
INSERT INTO transactions VALUES (216, 'T0108', '2026-02-08', '103', '2000', 0.0, 31358.88, 'Food & beverage inventory purchase', 'N/A', 'Corporate', 'V02', 'Supply Chain');
INSERT INTO transactions VALUES (217, 'T0109', '2026-02-28', '103', '5000', 29865.6, 0.0, 'Cost of food sold - monthly usage', 'N/A', 'Corporate', 'V02', 'Restaurant Ops');
INSERT INTO transactions VALUES (218, 'T0109', '2026-02-28', '103', '1020', 0.0, 29865.6, 'Cost of food sold - monthly usage', 'N/A', 'Corporate', 'V02', 'Restaurant Ops');
INSERT INTO transactions VALUES (219, 'T0110', '2026-02-15', '103', '5010', 25883.52, 0.0, 'Bi-weekly payroll', 'Cash', 'Corporate', NULL, 'Human Resources');
INSERT INTO transactions VALUES (220, 'T0110', '2026-02-15', '103', '1000', 0.0, 25883.52, 'Bi-weekly payroll', 'Cash', 'Corporate', NULL, 'Human Resources');
INSERT INTO transactions VALUES (221, 'T0111', '2026-02-01', '103', '5020', 7500.0, 0.0, 'Monthly rent payment', 'Cash', 'Corporate', 'V08', 'Finance');
INSERT INTO transactions VALUES (222, 'T0111', '2026-02-01', '103', '1000', 0.0, 7500.0, 'Monthly rent payment', 'Cash', 'Corporate', 'V08', 'Finance');
INSERT INTO transactions VALUES (223, 'T0112', '2026-02-20', '103', '5030', 2163.0, 0.0, 'Monthly utilities payment', 'Cash', 'Corporate', 'V07', 'Facilities');
INSERT INTO transactions VALUES (224, 'T0112', '2026-02-20', '103', '1000', 0.0, 2163.0, 'Monthly utilities payment', 'Cash', 'Corporate', 'V07', 'Facilities');
INSERT INTO transactions VALUES (225, 'T0113', '2026-02-28', '103', '5050', 2488.8, 0.0, 'Credit card processing fees', 'Cash', 'Corporate', NULL, 'Finance');
INSERT INTO transactions VALUES (226, 'T0113', '2026-02-28', '103', '1000', 0.0, 2488.8, 'Credit card processing fees', 'Cash', 'Corporate', NULL, 'Finance');
INSERT INTO transactions VALUES (227, 'T0114', '2026-02-12', '103', '5060', 2986.56, 0.0, 'Local store marketing spend', 'Cash', 'Corporate', 'V09', 'Marketing');
INSERT INTO transactions VALUES (228, 'T0114', '2026-02-12', '103', '1000', 0.0, 2986.56, 'Local store marketing spend', 'Cash', 'Corporate', 'V09', 'Marketing');
INSERT INTO transactions VALUES (229, 'T0115', '2026-02-28', '103', '5070', 3982.08, 0.0, 'Monthly franchise fee to corporate', 'Cash', 'Corporate', 'V10', 'Finance');
INSERT INTO transactions VALUES (230, 'T0115', '2026-02-28', '103', '1000', 0.0, 3982.08, 'Monthly franchise fee to corporate', 'Cash', 'Corporate', 'V10', 'Finance');
INSERT INTO transactions VALUES (231, 'T0116', '2026-02-18', '103', '2000', 26879.04, 0.0, 'Payment on vendor account payable', 'Cash', 'Corporate', 'V02', 'Finance');
INSERT INTO transactions VALUES (232, 'T0116', '2026-02-18', '103', '1000', 0.0, 26879.04, 'Payment on vendor account payable', 'Cash', 'Corporate', 'V02', 'Finance');
INSERT INTO transactions VALUES (233, 'T0117', '2026-03-05', '103', '1000', 83200.0, 0.0, 'Weekly dine-in & drive-thru sales', 'Cash', 'Dine-In', NULL, 'Restaurant Ops');
INSERT INTO transactions VALUES (234, 'T0117', '2026-03-05', '103', '4000', 0.0, 83200.0, 'Weekly dine-in & drive-thru sales', 'Cash', 'Dine-In', NULL, 'Restaurant Ops');
INSERT INTO transactions VALUES (235, 'T0118', '2026-03-07', '103', '1010', 18304.0, 0.0, 'Delivery sales via QuickDash', 'Delivery Platform Settlement', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (236, 'T0118', '2026-03-07', '103', '4010', 0.0, 18304.0, 'Delivery sales via QuickDash', 'Delivery Platform Settlement', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (237, 'T0119', '2026-03-10', '103', '1000', 18304.0, 0.0, 'Collection of delivery platform settlement', 'Delivery Platform Settlement', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (238, 'T0119', '2026-03-10', '103', '1010', 0.0, 18304.0, 'Collection of delivery platform settlement', 'Delivery Platform Settlement', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (239, 'T0120', '2026-03-10', '103', '5040', 2745.6, 0.0, 'Delivery platform commission fee', 'Cash', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (240, 'T0120', '2026-03-10', '103', '1000', 0.0, 2745.6, 'Delivery platform commission fee', 'Cash', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (241, 'T0121', '2026-03-08', '103', '1020', 31973.76, 0.0, 'Food & beverage inventory purchase', 'N/A', 'Corporate', 'V01', 'Supply Chain');
INSERT INTO transactions VALUES (242, 'T0121', '2026-03-08', '103', '2000', 0.0, 31973.76, 'Food & beverage inventory purchase', 'N/A', 'Corporate', 'V01', 'Supply Chain');
INSERT INTO transactions VALUES (243, 'T0122', '2026-03-28', '103', '5000', 30451.2, 0.0, 'Cost of food sold - monthly usage', 'N/A', 'Corporate', 'V01', 'Restaurant Ops');
INSERT INTO transactions VALUES (244, 'T0122', '2026-03-28', '103', '1020', 0.0, 30451.2, 'Cost of food sold - monthly usage', 'N/A', 'Corporate', 'V01', 'Restaurant Ops');
INSERT INTO transactions VALUES (245, 'T0123', '2026-03-15', '103', '5010', 26391.04, 0.0, 'Bi-weekly payroll', 'Cash', 'Corporate', NULL, 'Human Resources');
INSERT INTO transactions VALUES (246, 'T0123', '2026-03-15', '103', '1000', 0.0, 26391.04, 'Bi-weekly payroll', 'Cash', 'Corporate', NULL, 'Human Resources');
INSERT INTO transactions VALUES (247, 'T0124', '2026-03-01', '103', '5020', 7500.0, 0.0, 'Monthly rent payment', 'Cash', 'Corporate', 'V08', 'Finance');
INSERT INTO transactions VALUES (248, 'T0124', '2026-03-01', '103', '1000', 0.0, 7500.0, 'Monthly rent payment', 'Cash', 'Corporate', 'V08', 'Finance');
INSERT INTO transactions VALUES (249, 'T0125', '2026-03-20', '103', '5030', 2226.0, 0.0, 'Monthly utilities payment', 'Cash', 'Corporate', 'V07', 'Facilities');
INSERT INTO transactions VALUES (250, 'T0125', '2026-03-20', '103', '1000', 0.0, 2226.0, 'Monthly utilities payment', 'Cash', 'Corporate', 'V07', 'Facilities');
INSERT INTO transactions VALUES (251, 'T0126', '2026-03-28', '103', '5050', 2537.6, 0.0, 'Credit card processing fees', 'Cash', 'Corporate', NULL, 'Finance');
INSERT INTO transactions VALUES (252, 'T0126', '2026-03-28', '103', '1000', 0.0, 2537.6, 'Credit card processing fees', 'Cash', 'Corporate', NULL, 'Finance');
INSERT INTO transactions VALUES (253, 'T0127', '2026-03-12', '103', '5060', 3045.12, 0.0, 'Local store marketing spend', 'Cash', 'Corporate', 'V09', 'Marketing');
INSERT INTO transactions VALUES (254, 'T0127', '2026-03-12', '103', '1000', 0.0, 3045.12, 'Local store marketing spend', 'Cash', 'Corporate', 'V09', 'Marketing');
INSERT INTO transactions VALUES (255, 'T0128', '2026-03-30', '103', '5070', 4060.16, 0.0, 'Monthly franchise fee to corporate', 'Cash', 'Corporate', 'V10', 'Finance');
INSERT INTO transactions VALUES (256, 'T0128', '2026-03-30', '103', '1000', 0.0, 4060.16, 'Monthly franchise fee to corporate', 'Cash', 'Corporate', 'V10', 'Finance');
INSERT INTO transactions VALUES (257, 'T0129', '2026-03-18', '103', '2000', 27406.08, 0.0, 'Payment on vendor account payable', 'Cash', 'Corporate', 'V01', 'Finance');
INSERT INTO transactions VALUES (258, 'T0129', '2026-03-18', '103', '1000', 0.0, 27406.08, 'Payment on vendor account payable', 'Cash', 'Corporate', 'V01', 'Finance');
INSERT INTO transactions VALUES (259, 'T0130', '2026-01-05', '104', '1000', 85000.0, 0.0, 'Weekly dine-in & drive-thru sales', 'Cash', 'Dine-In', NULL, 'Restaurant Ops');
INSERT INTO transactions VALUES (260, 'T0130', '2026-01-05', '104', '4000', 0.0, 85000.0, 'Weekly dine-in & drive-thru sales', 'Cash', 'Dine-In', NULL, 'Restaurant Ops');
INSERT INTO transactions VALUES (261, 'T0131', '2026-01-07', '104', '1010', 18700.0, 0.0, 'Delivery sales via QuickDash', 'Delivery Platform Settlement', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (262, 'T0131', '2026-01-07', '104', '4010', 0.0, 18700.0, 'Delivery sales via QuickDash', 'Delivery Platform Settlement', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (263, 'T0132', '2026-01-10', '104', '1000', 18700.0, 0.0, 'Collection of delivery platform settlement', 'Delivery Platform Settlement', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (264, 'T0132', '2026-01-10', '104', '1010', 0.0, 18700.0, 'Collection of delivery platform settlement', 'Delivery Platform Settlement', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (265, 'T0133', '2026-01-10', '104', '5040', 2805.0, 0.0, 'Delivery platform commission fee', 'Cash', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (266, 'T0133', '2026-01-10', '104', '1000', 0.0, 2805.0, 'Delivery platform commission fee', 'Cash', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (267, 'T0134', '2026-01-08', '104', '1020', 32665.5, 0.0, 'Food & beverage inventory purchase', 'N/A', 'Corporate', 'V01', 'Supply Chain');
INSERT INTO transactions VALUES (268, 'T0134', '2026-01-08', '104', '2000', 0.0, 32665.5, 'Food & beverage inventory purchase', 'N/A', 'Corporate', 'V01', 'Supply Chain');
INSERT INTO transactions VALUES (269, 'T0135', '2026-01-28', '104', '5000', 31110.0, 0.0, 'Cost of food sold - monthly usage', 'N/A', 'Corporate', 'V01', 'Restaurant Ops');
INSERT INTO transactions VALUES (270, 'T0135', '2026-01-28', '104', '1020', 0.0, 31110.0, 'Cost of food sold - monthly usage', 'N/A', 'Corporate', 'V01', 'Restaurant Ops');
INSERT INTO transactions VALUES (271, 'T0136', '2026-01-15', '104', '5010', 26962.0, 0.0, 'Bi-weekly payroll', 'Cash', 'Corporate', NULL, 'Human Resources');
INSERT INTO transactions VALUES (272, 'T0136', '2026-01-15', '104', '1000', 0.0, 26962.0, 'Bi-weekly payroll', 'Cash', 'Corporate', NULL, 'Human Resources');
INSERT INTO transactions VALUES (273, 'T0137', '2026-01-01', '104', '5020', 8000.0, 0.0, 'Monthly rent payment', 'Cash', 'Corporate', 'V08', 'Finance');
INSERT INTO transactions VALUES (274, 'T0137', '2026-01-01', '104', '1000', 0.0, 8000.0, 'Monthly rent payment', 'Cash', 'Corporate', 'V08', 'Finance');
INSERT INTO transactions VALUES (275, 'T0138', '2026-01-20', '104', '5030', 2200.0, 0.0, 'Monthly utilities payment', 'Cash', 'Corporate', 'V07', 'Facilities');
INSERT INTO transactions VALUES (276, 'T0138', '2026-01-20', '104', '1000', 0.0, 2200.0, 'Monthly utilities payment', 'Cash', 'Corporate', 'V07', 'Facilities');
INSERT INTO transactions VALUES (277, 'T0139', '2026-01-28', '104', '5050', 2592.5, 0.0, 'Credit card processing fees', 'Cash', 'Corporate', NULL, 'Finance');
INSERT INTO transactions VALUES (278, 'T0139', '2026-01-28', '104', '1000', 0.0, 2592.5, 'Credit card processing fees', 'Cash', 'Corporate', NULL, 'Finance');
INSERT INTO transactions VALUES (279, 'T0140', '2026-01-12', '104', '5060', 3111.0, 0.0, 'Local store marketing spend', 'Cash', 'Corporate', 'V09', 'Marketing');
INSERT INTO transactions VALUES (280, 'T0140', '2026-01-12', '104', '1000', 0.0, 3111.0, 'Local store marketing spend', 'Cash', 'Corporate', 'V09', 'Marketing');
INSERT INTO transactions VALUES (281, 'T0141', '2026-01-30', '104', '5070', 4148.0, 0.0, 'Monthly franchise fee to corporate', 'Cash', 'Corporate', 'V10', 'Finance');
INSERT INTO transactions VALUES (282, 'T0141', '2026-01-30', '104', '1000', 0.0, 4148.0, 'Monthly franchise fee to corporate', 'Cash', 'Corporate', 'V10', 'Finance');
INSERT INTO transactions VALUES (283, 'T0142', '2026-02-05', '104', '1000', 86700.0, 0.0, 'Weekly dine-in & drive-thru sales', 'Cash', 'Dine-In', NULL, 'Restaurant Ops');
INSERT INTO transactions VALUES (284, 'T0142', '2026-02-05', '104', '4000', 0.0, 86700.0, 'Weekly dine-in & drive-thru sales', 'Cash', 'Dine-In', NULL, 'Restaurant Ops');
INSERT INTO transactions VALUES (285, 'T0143', '2026-02-07', '104', '1010', 19074.0, 0.0, 'Delivery sales via QuickDash', 'Delivery Platform Settlement', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (286, 'T0143', '2026-02-07', '104', '4010', 0.0, 19074.0, 'Delivery sales via QuickDash', 'Delivery Platform Settlement', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (287, 'T0144', '2026-02-10', '104', '1000', 19074.0, 0.0, 'Collection of delivery platform settlement', 'Delivery Platform Settlement', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (288, 'T0144', '2026-02-10', '104', '1010', 0.0, 19074.0, 'Collection of delivery platform settlement', 'Delivery Platform Settlement', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (289, 'T0145', '2026-02-10', '104', '5040', 2861.1, 0.0, 'Delivery platform commission fee', 'Cash', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (290, 'T0145', '2026-02-10', '104', '1000', 0.0, 2861.1, 'Delivery platform commission fee', 'Cash', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (291, 'T0146', '2026-02-08', '104', '1020', 33318.81, 0.0, 'Food & beverage inventory purchase', 'N/A', 'Corporate', 'V02', 'Supply Chain');
INSERT INTO transactions VALUES (292, 'T0146', '2026-02-08', '104', '2000', 0.0, 33318.81, 'Food & beverage inventory purchase', 'N/A', 'Corporate', 'V02', 'Supply Chain');
INSERT INTO transactions VALUES (293, 'T0147', '2026-02-28', '104', '5000', 31732.2, 0.0, 'Cost of food sold - monthly usage', 'N/A', 'Corporate', 'V02', 'Restaurant Ops');
INSERT INTO transactions VALUES (294, 'T0147', '2026-02-28', '104', '1020', 0.0, 31732.2, 'Cost of food sold - monthly usage', 'N/A', 'Corporate', 'V02', 'Restaurant Ops');
INSERT INTO transactions VALUES (295, 'T0148', '2026-02-15', '104', '5010', 27501.24, 0.0, 'Bi-weekly payroll', 'Cash', 'Corporate', NULL, 'Human Resources');
INSERT INTO transactions VALUES (296, 'T0148', '2026-02-15', '104', '1000', 0.0, 27501.24, 'Bi-weekly payroll', 'Cash', 'Corporate', NULL, 'Human Resources');
INSERT INTO transactions VALUES (297, 'T0149', '2026-02-01', '104', '5020', 8000.0, 0.0, 'Monthly rent payment', 'Cash', 'Corporate', 'V08', 'Finance');
INSERT INTO transactions VALUES (298, 'T0149', '2026-02-01', '104', '1000', 0.0, 8000.0, 'Monthly rent payment', 'Cash', 'Corporate', 'V08', 'Finance');
INSERT INTO transactions VALUES (299, 'T0150', '2026-02-20', '104', '5030', 2266.0, 0.0, 'Monthly utilities payment', 'Cash', 'Corporate', 'V07', 'Facilities');
INSERT INTO transactions VALUES (300, 'T0150', '2026-02-20', '104', '1000', 0.0, 2266.0, 'Monthly utilities payment', 'Cash', 'Corporate', 'V07', 'Facilities');
INSERT INTO transactions VALUES (301, 'T0151', '2026-02-28', '104', '5050', 2644.35, 0.0, 'Credit card processing fees', 'Cash', 'Corporate', NULL, 'Finance');
INSERT INTO transactions VALUES (302, 'T0151', '2026-02-28', '104', '1000', 0.0, 2644.35, 'Credit card processing fees', 'Cash', 'Corporate', NULL, 'Finance');
INSERT INTO transactions VALUES (303, 'T0152', '2026-02-12', '104', '5060', 3173.22, 0.0, 'Local store marketing spend', 'Cash', 'Corporate', 'V09', 'Marketing');
INSERT INTO transactions VALUES (304, 'T0152', '2026-02-12', '104', '1000', 0.0, 3173.22, 'Local store marketing spend', 'Cash', 'Corporate', 'V09', 'Marketing');
INSERT INTO transactions VALUES (305, 'T0153', '2026-02-28', '104', '5070', 4230.96, 0.0, 'Monthly franchise fee to corporate', 'Cash', 'Corporate', 'V10', 'Finance');
INSERT INTO transactions VALUES (306, 'T0153', '2026-02-28', '104', '1000', 0.0, 4230.96, 'Monthly franchise fee to corporate', 'Cash', 'Corporate', 'V10', 'Finance');
INSERT INTO transactions VALUES (307, 'T0154', '2026-02-18', '104', '2000', 28558.98, 0.0, 'Payment on vendor account payable', 'Cash', 'Corporate', 'V02', 'Finance');
INSERT INTO transactions VALUES (308, 'T0154', '2026-02-18', '104', '1000', 0.0, 28558.98, 'Payment on vendor account payable', 'Cash', 'Corporate', 'V02', 'Finance');
INSERT INTO transactions VALUES (309, 'T0155', '2026-03-05', '104', '1000', 88400.0, 0.0, 'Weekly dine-in & drive-thru sales', 'Cash', 'Dine-In', NULL, 'Restaurant Ops');
INSERT INTO transactions VALUES (310, 'T0155', '2026-03-05', '104', '4000', 0.0, 88400.0, 'Weekly dine-in & drive-thru sales', 'Cash', 'Dine-In', NULL, 'Restaurant Ops');
INSERT INTO transactions VALUES (311, 'T0156', '2026-03-07', '104', '1010', 19448.0, 0.0, 'Delivery sales via QuickDash', 'Delivery Platform Settlement', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (312, 'T0156', '2026-03-07', '104', '4010', 0.0, 19448.0, 'Delivery sales via QuickDash', 'Delivery Platform Settlement', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (313, 'T0157', '2026-03-10', '104', '1000', 19448.0, 0.0, 'Collection of delivery platform settlement', 'Delivery Platform Settlement', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (314, 'T0157', '2026-03-10', '104', '1010', 0.0, 19448.0, 'Collection of delivery platform settlement', 'Delivery Platform Settlement', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (315, 'T0158', '2026-03-10', '104', '5040', 2917.2, 0.0, 'Delivery platform commission fee', 'Cash', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (316, 'T0158', '2026-03-10', '104', '1000', 0.0, 2917.2, 'Delivery platform commission fee', 'Cash', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (317, 'T0159', '2026-03-08', '104', '1020', 47560.97, 0.0, 'Food & beverage inventory purchase', 'N/A', 'Corporate', 'V01', 'Supply Chain');
INSERT INTO transactions VALUES (318, 'T0159', '2026-03-08', '104', '2000', 0.0, 47560.97, 'Food & beverage inventory purchase', 'N/A', 'Corporate', 'V01', 'Supply Chain');
INSERT INTO transactions VALUES (319, 'T0160', '2026-03-28', '104', '5000', 45296.16, 0.0, 'Cost of food sold - monthly usage', 'N/A', 'Corporate', 'V01', 'Restaurant Ops');
INSERT INTO transactions VALUES (320, 'T0160', '2026-03-28', '104', '1020', 0.0, 45296.16, 'Cost of food sold - monthly usage', 'N/A', 'Corporate', 'V01', 'Restaurant Ops');
INSERT INTO transactions VALUES (321, 'T0161', '2026-03-15', '104', '5010', 28040.48, 0.0, 'Bi-weekly payroll', 'Cash', 'Corporate', NULL, 'Human Resources');
INSERT INTO transactions VALUES (322, 'T0161', '2026-03-15', '104', '1000', 0.0, 28040.48, 'Bi-weekly payroll', 'Cash', 'Corporate', NULL, 'Human Resources');
INSERT INTO transactions VALUES (323, 'T0162', '2026-03-01', '104', '5020', 8000.0, 0.0, 'Monthly rent payment', 'Cash', 'Corporate', 'V08', 'Finance');
INSERT INTO transactions VALUES (324, 'T0162', '2026-03-01', '104', '1000', 0.0, 8000.0, 'Monthly rent payment', 'Cash', 'Corporate', 'V08', 'Finance');
INSERT INTO transactions VALUES (325, 'T0163', '2026-03-20', '104', '5030', 2332.0, 0.0, 'Monthly utilities payment', 'Cash', 'Corporate', 'V07', 'Facilities');
INSERT INTO transactions VALUES (326, 'T0163', '2026-03-20', '104', '1000', 0.0, 2332.0, 'Monthly utilities payment', 'Cash', 'Corporate', 'V07', 'Facilities');
INSERT INTO transactions VALUES (327, 'T0164', '2026-03-28', '104', '5050', 2696.2, 0.0, 'Credit card processing fees', 'Cash', 'Corporate', NULL, 'Finance');
INSERT INTO transactions VALUES (328, 'T0164', '2026-03-28', '104', '1000', 0.0, 2696.2, 'Credit card processing fees', 'Cash', 'Corporate', NULL, 'Finance');
INSERT INTO transactions VALUES (329, 'T0165', '2026-03-12', '104', '5060', 3235.44, 0.0, 'Local store marketing spend', 'Cash', 'Corporate', 'V09', 'Marketing');
INSERT INTO transactions VALUES (330, 'T0165', '2026-03-12', '104', '1000', 0.0, 3235.44, 'Local store marketing spend', 'Cash', 'Corporate', 'V09', 'Marketing');
INSERT INTO transactions VALUES (331, 'T0166', '2026-03-30', '104', '5070', 4313.92, 0.0, 'Monthly franchise fee to corporate', 'Cash', 'Corporate', 'V10', 'Finance');
INSERT INTO transactions VALUES (332, 'T0166', '2026-03-30', '104', '1000', 0.0, 4313.92, 'Monthly franchise fee to corporate', 'Cash', 'Corporate', 'V10', 'Finance');
INSERT INTO transactions VALUES (333, 'T0167', '2026-03-18', '104', '2000', 40766.54, 0.0, 'Payment on vendor account payable', 'Cash', 'Corporate', 'V01', 'Finance');
INSERT INTO transactions VALUES (334, 'T0167', '2026-03-18', '104', '1000', 0.0, 40766.54, 'Payment on vendor account payable', 'Cash', 'Corporate', 'V01', 'Finance');
INSERT INTO transactions VALUES (335, 'T0168', '2026-01-05', '105', '1000', 110000.0, 0.0, 'Weekly dine-in & drive-thru sales', 'Cash', 'Dine-In', NULL, 'Restaurant Ops');
INSERT INTO transactions VALUES (336, 'T0168', '2026-01-05', '105', '4000', 0.0, 110000.0, 'Weekly dine-in & drive-thru sales', 'Cash', 'Dine-In', NULL, 'Restaurant Ops');
INSERT INTO transactions VALUES (337, 'T0169', '2026-01-07', '105', '1010', 24200.0, 0.0, 'Delivery sales via QuickDash', 'Delivery Platform Settlement', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (338, 'T0169', '2026-01-07', '105', '4010', 0.0, 24200.0, 'Delivery sales via QuickDash', 'Delivery Platform Settlement', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (339, 'T0170', '2026-01-10', '105', '1000', 24200.0, 0.0, 'Collection of delivery platform settlement', 'Delivery Platform Settlement', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (340, 'T0170', '2026-01-10', '105', '1010', 0.0, 24200.0, 'Collection of delivery platform settlement', 'Delivery Platform Settlement', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (341, 'T0171', '2026-01-10', '105', '5040', 3630.0, 0.0, 'Delivery platform commission fee', 'Cash', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (342, 'T0171', '2026-01-10', '105', '1000', 0.0, 3630.0, 'Delivery platform commission fee', 'Cash', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (343, 'T0172', '2026-01-08', '105', '1020', 42273.0, 0.0, 'Food & beverage inventory purchase', 'N/A', 'Corporate', 'V01', 'Supply Chain');
INSERT INTO transactions VALUES (344, 'T0172', '2026-01-08', '105', '2000', 0.0, 42273.0, 'Food & beverage inventory purchase', 'N/A', 'Corporate', 'V01', 'Supply Chain');
INSERT INTO transactions VALUES (345, 'T0173', '2026-01-28', '105', '5000', 40260.0, 0.0, 'Cost of food sold - monthly usage', 'N/A', 'Corporate', 'V01', 'Restaurant Ops');
INSERT INTO transactions VALUES (346, 'T0173', '2026-01-28', '105', '1020', 0.0, 40260.0, 'Cost of food sold - monthly usage', 'N/A', 'Corporate', 'V01', 'Restaurant Ops');
INSERT INTO transactions VALUES (347, 'T0174', '2026-01-15', '105', '5010', 34892.0, 0.0, 'Bi-weekly payroll', 'Cash', 'Corporate', NULL, 'Human Resources');
INSERT INTO transactions VALUES (348, 'T0174', '2026-01-15', '105', '1000', 0.0, 34892.0, 'Bi-weekly payroll', 'Cash', 'Corporate', NULL, 'Human Resources');
INSERT INTO transactions VALUES (349, 'T0175', '2026-01-01', '105', '5020', 11000.0, 0.0, 'Monthly rent payment', 'Cash', 'Corporate', 'V08', 'Finance');
INSERT INTO transactions VALUES (350, 'T0175', '2026-01-01', '105', '1000', 0.0, 11000.0, 'Monthly rent payment', 'Cash', 'Corporate', 'V08', 'Finance');
INSERT INTO transactions VALUES (351, 'T0176', '2026-01-20', '105', '5030', 2900.0, 0.0, 'Monthly utilities payment', 'Cash', 'Corporate', 'V07', 'Facilities');
INSERT INTO transactions VALUES (352, 'T0176', '2026-01-20', '105', '1000', 0.0, 2900.0, 'Monthly utilities payment', 'Cash', 'Corporate', 'V07', 'Facilities');
INSERT INTO transactions VALUES (353, 'T0177', '2026-01-28', '105', '5050', 3355.0, 0.0, 'Credit card processing fees', 'Cash', 'Corporate', NULL, 'Finance');
INSERT INTO transactions VALUES (354, 'T0177', '2026-01-28', '105', '1000', 0.0, 3355.0, 'Credit card processing fees', 'Cash', 'Corporate', NULL, 'Finance');
INSERT INTO transactions VALUES (355, 'T0178', '2026-01-12', '105', '5060', 4026.0, 0.0, 'Local store marketing spend', 'Cash', 'Corporate', 'V09', 'Marketing');
INSERT INTO transactions VALUES (356, 'T0178', '2026-01-12', '105', '1000', 0.0, 4026.0, 'Local store marketing spend', 'Cash', 'Corporate', 'V09', 'Marketing');
INSERT INTO transactions VALUES (357, 'T0179', '2026-01-30', '105', '5070', 5368.0, 0.0, 'Monthly franchise fee to corporate', 'Cash', 'Corporate', 'V10', 'Finance');
INSERT INTO transactions VALUES (358, 'T0179', '2026-01-30', '105', '1000', 0.0, 5368.0, 'Monthly franchise fee to corporate', 'Cash', 'Corporate', 'V10', 'Finance');
INSERT INTO transactions VALUES (359, 'T0180', '2026-02-05', '105', '1000', 112200.0, 0.0, 'Weekly dine-in & drive-thru sales', 'Cash', 'Dine-In', NULL, 'Restaurant Ops');
INSERT INTO transactions VALUES (360, 'T0180', '2026-02-05', '105', '4000', 0.0, 112200.0, 'Weekly dine-in & drive-thru sales', 'Cash', 'Dine-In', NULL, 'Restaurant Ops');
INSERT INTO transactions VALUES (361, 'T0181', '2026-02-07', '105', '1010', 24684.0, 0.0, 'Delivery sales via QuickDash', 'Delivery Platform Settlement', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (362, 'T0181', '2026-02-07', '105', '4010', 0.0, 24684.0, 'Delivery sales via QuickDash', 'Delivery Platform Settlement', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (363, 'T0182', '2026-02-10', '105', '1000', 24684.0, 0.0, 'Collection of delivery platform settlement', 'Delivery Platform Settlement', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (364, 'T0182', '2026-02-10', '105', '1010', 0.0, 24684.0, 'Collection of delivery platform settlement', 'Delivery Platform Settlement', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (365, 'T0183', '2026-02-10', '105', '5040', 3702.6, 0.0, 'Delivery platform commission fee', 'Cash', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (366, 'T0183', '2026-02-10', '105', '1000', 0.0, 3702.6, 'Delivery platform commission fee', 'Cash', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (367, 'T0184', '2026-02-08', '105', '1020', 43118.46, 0.0, 'Food & beverage inventory purchase', 'N/A', 'Corporate', 'V02', 'Supply Chain');
INSERT INTO transactions VALUES (368, 'T0184', '2026-02-08', '105', '2000', 0.0, 43118.46, 'Food & beverage inventory purchase', 'N/A', 'Corporate', 'V02', 'Supply Chain');
INSERT INTO transactions VALUES (369, 'T0185', '2026-02-28', '105', '5000', 41065.2, 0.0, 'Cost of food sold - monthly usage', 'N/A', 'Corporate', 'V02', 'Restaurant Ops');
INSERT INTO transactions VALUES (370, 'T0185', '2026-02-28', '105', '1020', 0.0, 41065.2, 'Cost of food sold - monthly usage', 'N/A', 'Corporate', 'V02', 'Restaurant Ops');
INSERT INTO transactions VALUES (371, 'T0186', '2026-02-15', '105', '5010', 35589.84, 0.0, 'Bi-weekly payroll', 'Cash', 'Corporate', NULL, 'Human Resources');
INSERT INTO transactions VALUES (372, 'T0186', '2026-02-15', '105', '1000', 0.0, 35589.84, 'Bi-weekly payroll', 'Cash', 'Corporate', NULL, 'Human Resources');
INSERT INTO transactions VALUES (373, 'T0187', '2026-02-01', '105', '5020', 11000.0, 0.0, 'Monthly rent payment', 'Cash', 'Corporate', 'V08', 'Finance');
INSERT INTO transactions VALUES (374, 'T0187', '2026-02-01', '105', '1000', 0.0, 11000.0, 'Monthly rent payment', 'Cash', 'Corporate', 'V08', 'Finance');
INSERT INTO transactions VALUES (375, 'T0188', '2026-02-20', '105', '5030', 2987.0, 0.0, 'Monthly utilities payment', 'Cash', 'Corporate', 'V07', 'Facilities');
INSERT INTO transactions VALUES (376, 'T0188', '2026-02-20', '105', '1000', 0.0, 2987.0, 'Monthly utilities payment', 'Cash', 'Corporate', 'V07', 'Facilities');
INSERT INTO transactions VALUES (377, 'T0189', '2026-02-28', '105', '5050', 3422.1, 0.0, 'Credit card processing fees', 'Cash', 'Corporate', NULL, 'Finance');
INSERT INTO transactions VALUES (378, 'T0189', '2026-02-28', '105', '1000', 0.0, 3422.1, 'Credit card processing fees', 'Cash', 'Corporate', NULL, 'Finance');
INSERT INTO transactions VALUES (379, 'T0190', '2026-02-12', '105', '5060', 4106.52, 0.0, 'Local store marketing spend', 'Cash', 'Corporate', 'V09', 'Marketing');
INSERT INTO transactions VALUES (380, 'T0190', '2026-02-12', '105', '1000', 0.0, 4106.52, 'Local store marketing spend', 'Cash', 'Corporate', 'V09', 'Marketing');
INSERT INTO transactions VALUES (381, 'T0191', '2026-02-28', '105', '5070', 5475.36, 0.0, 'Monthly franchise fee to corporate', 'Cash', 'Corporate', 'V10', 'Finance');
INSERT INTO transactions VALUES (382, 'T0191', '2026-02-28', '105', '1000', 0.0, 5475.36, 'Monthly franchise fee to corporate', 'Cash', 'Corporate', 'V10', 'Finance');
INSERT INTO transactions VALUES (383, 'T0192', '2026-02-18', '105', '2000', 36958.68, 0.0, 'Payment on vendor account payable', 'Cash', 'Corporate', 'V02', 'Finance');
INSERT INTO transactions VALUES (384, 'T0192', '2026-02-18', '105', '1000', 0.0, 36958.68, 'Payment on vendor account payable', 'Cash', 'Corporate', 'V02', 'Finance');
INSERT INTO transactions VALUES (385, 'T0193', '2026-03-05', '105', '1000', 114400.0, 0.0, 'Weekly dine-in & drive-thru sales', 'Cash', 'Dine-In', NULL, 'Restaurant Ops');
INSERT INTO transactions VALUES (386, 'T0193', '2026-03-05', '105', '4000', 0.0, 114400.0, 'Weekly dine-in & drive-thru sales', 'Cash', 'Dine-In', NULL, 'Restaurant Ops');
INSERT INTO transactions VALUES (387, 'T0194', '2026-03-07', '105', '1010', 25168.0, 0.0, 'Delivery sales via QuickDash', 'Delivery Platform Settlement', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (388, 'T0194', '2026-03-07', '105', '4010', 0.0, 25168.0, 'Delivery sales via QuickDash', 'Delivery Platform Settlement', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (389, 'T0195', '2026-03-10', '105', '1000', 25168.0, 0.0, 'Collection of delivery platform settlement', 'Delivery Platform Settlement', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (390, 'T0195', '2026-03-10', '105', '1010', 0.0, 25168.0, 'Collection of delivery platform settlement', 'Delivery Platform Settlement', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (391, 'T0196', '2026-03-10', '105', '5040', 3775.2, 0.0, 'Delivery platform commission fee', 'Cash', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (392, 'T0196', '2026-03-10', '105', '1000', 0.0, 3775.2, 'Delivery platform commission fee', 'Cash', 'Delivery', 'V05', 'Restaurant Ops');
INSERT INTO transactions VALUES (393, 'T0197', '2026-03-08', '105', '1020', 43963.92, 0.0, 'Food & beverage inventory purchase', 'N/A', 'Corporate', 'V01', 'Supply Chain');
INSERT INTO transactions VALUES (394, 'T0197', '2026-03-08', '105', '2000', 0.0, 43963.92, 'Food & beverage inventory purchase', 'N/A', 'Corporate', 'V01', 'Supply Chain');
INSERT INTO transactions VALUES (395, 'T0198', '2026-03-28', '105', '5000', 41870.4, 0.0, 'Cost of food sold - monthly usage', 'N/A', 'Corporate', 'V01', 'Restaurant Ops');
INSERT INTO transactions VALUES (396, 'T0198', '2026-03-28', '105', '1020', 0.0, 41870.4, 'Cost of food sold - monthly usage', 'N/A', 'Corporate', 'V01', 'Restaurant Ops');
INSERT INTO transactions VALUES (397, 'T0199', '2026-03-15', '105', '5010', 36287.68, 0.0, 'Bi-weekly payroll', 'Cash', 'Corporate', NULL, 'Human Resources');
INSERT INTO transactions VALUES (398, 'T0199', '2026-03-15', '105', '1000', 0.0, 36287.68, 'Bi-weekly payroll', 'Cash', 'Corporate', NULL, 'Human Resources');
INSERT INTO transactions VALUES (399, 'T0200', '2026-03-01', '105', '5020', 11000.0, 0.0, 'Monthly rent payment', 'Cash', 'Corporate', 'V08', 'Finance');
INSERT INTO transactions VALUES (400, 'T0200', '2026-03-01', '105', '1000', 0.0, 11000.0, 'Monthly rent payment', 'Cash', 'Corporate', 'V08', 'Finance');
INSERT INTO transactions VALUES (401, 'T0201', '2026-03-20', '105', '5030', 3074.0, 0.0, 'Monthly utilities payment', 'Cash', 'Corporate', 'V07', 'Facilities');
INSERT INTO transactions VALUES (402, 'T0201', '2026-03-20', '105', '1000', 0.0, 3074.0, 'Monthly utilities payment', 'Cash', 'Corporate', 'V07', 'Facilities');
INSERT INTO transactions VALUES (403, 'T0202', '2026-03-28', '105', '5050', 3489.2, 0.0, 'Credit card processing fees', 'Cash', 'Corporate', NULL, 'Finance');
INSERT INTO transactions VALUES (404, 'T0202', '2026-03-28', '105', '1000', 0.0, 3489.2, 'Credit card processing fees', 'Cash', 'Corporate', NULL, 'Finance');
INSERT INTO transactions VALUES (405, 'T0203', '2026-03-12', '105', '5060', 4187.04, 0.0, 'Local store marketing spend', 'Cash', 'Corporate', 'V09', 'Marketing');
INSERT INTO transactions VALUES (406, 'T0203', '2026-03-12', '105', '1000', 0.0, 4187.04, 'Local store marketing spend', 'Cash', 'Corporate', 'V09', 'Marketing');
INSERT INTO transactions VALUES (407, 'T0204', '2026-03-30', '105', '5070', 5582.72, 0.0, 'Monthly franchise fee to corporate', 'Cash', 'Corporate', 'V10', 'Finance');
INSERT INTO transactions VALUES (408, 'T0204', '2026-03-30', '105', '1000', 0.0, 5582.72, 'Monthly franchise fee to corporate', 'Cash', 'Corporate', 'V10', 'Finance');
INSERT INTO transactions VALUES (409, 'T0205', '2026-03-18', '105', '2000', 37683.36, 0.0, 'Payment on vendor account payable', 'Cash', 'Corporate', 'V01', 'Finance');
INSERT INTO transactions VALUES (410, 'T0205', '2026-03-18', '105', '1000', 0.0, 37683.36, 'Payment on vendor account payable', 'Cash', 'Corporate', 'V01', 'Finance');
GO

-- Sanity check: this should return a balanced trial balance
SELECT SUM(debit) AS total_debits, SUM(credit) AS total_credits FROM transactions;