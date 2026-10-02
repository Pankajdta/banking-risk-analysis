create database banking_case;
USE banking_case;

SELECT COUNT(*) AS total_customers
FROM customers;


SELECT
    COUNT(*) AS total_rows,
    COUNT(`Client ID`) AS client_id_records,
    COUNT(`Estimated Income`) AS income_records,
    COUNT(`Superannuation Savings`) AS superannuation_records,
    COUNT(`Credit Card Balance`) AS credit_card_balance_records,
    COUNT(`Bank Loans`) AS loan_records,
    COUNT(`Bank Deposits`) AS deposit_records,
    COUNT(`Checking Accounts`) AS checking_records,
    COUNT(`Saving Accounts`) AS saving_records,
    COUNT(`Foreign Currency Account`) AS foreign_currency_records,
    COUNT(`Risk Weighting`) AS risk_records
FROM customers;


-- ============================================================
-- DUPLICATE CLIENT CHECK
-- ============================================================
SELECT
    `Client ID`,
    COUNT(*) AS duplicate_count
FROM customers
GROUP BY `Client ID`
HAVING COUNT(*) > 1;


-- ============================================================
-- INCOME BAND ANALYSIS
-- Low  : 0 - 99,999
-- Med  : 100,000 - 299,999
-- High : 300,000+
-- ============================================================

SELECT
    CASE
        WHEN `Estimated Income` < 100000 THEN 'Low'
        WHEN `Estimated Income` < 300000 THEN 'Med'
        ELSE 'High'
    END AS Income_Band,
    COUNT(*) AS Customer_Count
FROM customers
GROUP BY Income_Band
ORDER BY Customer_Count DESC;

-- ============================================================
-- RISK WEIGHTING DISTRIBUTION
-- ============================================================

SELECT
    `Risk Weighting`,
    COUNT(*) AS Customer_Count
FROM customers
GROUP BY `Risk Weighting`
ORDER BY `Risk Weighting`;


-- ============================================================
-- RISK + INCOME BAND
-- customer risk segmentation
-- ============================================================

SELECT
    `Risk Weighting`,
    CASE
        WHEN `Estimated Income` < 100000 THEN 'Low'
        WHEN `Estimated Income` < 300000 THEN 'Med'
        ELSE 'High'
    END AS Income_Band,
    COUNT(*) AS Customer_Count
FROM customers
GROUP BY
    `Risk Weighting`,
    Income_Band
ORDER BY
    `Risk Weighting`,
    Income_Band;


-- ============================================================
-- CREDIT CARD ANALYSIS
-- ============================================================

SELECT
    `Amount of Credit Cards`,
    COUNT(*) AS Customer_Count,
    AVG(`Credit Card Balance`) AS Avg_Credit_Card_Balance,
    SUM(`Credit Card Balance`) AS Total_Credit_Card_Balance
FROM customers
GROUP BY `Amount of Credit Cards`
ORDER BY `Amount of Credit Cards`;


-- ============================================================
-- LOAN ANALYSIS BY RISK
-- ============================================================

SELECT
    `Risk Weighting`,
    COUNT(*) AS Customer_Count,
    AVG(`Bank Loans`) AS Avg_Bank_Loans,
    SUM(`Bank Loans`) AS Total_Bank_Loans
FROM customers
GROUP BY `Risk Weighting`
ORDER BY `Risk Weighting`;


-- ============================================================
-- DEPOSIT ANALYSIS BY RISK
-- ============================================================

SELECT
    `Risk Weighting`,
    COUNT(*) AS Customer_Count,
    AVG(`Bank Deposits`) AS Avg_Bank_Deposits,
    SUM(`Bank Deposits`) AS Total_Bank_Deposits
FROM customers
GROUP BY `Risk Weighting`
ORDER BY `Risk Weighting`;



-- ============================================================
-- DEPOSIT ANALYSIS BY RISK
-- ============================================================
SELECT
    AVG(`Bank Deposits`) AS Avg_Bank_Deposits,
    AVG(`Checking Accounts`) AS Avg_Checking_Accounts,
    AVG(`Saving Accounts`) AS Avg_Saving_Accounts,
    AVG(`Foreign Currency Account`) AS Avg_Foreign_Currency_Account
FROM customers;


-- ============================================================
-- BUSINESS LENDING BY RISK
-- ============================================================

SELECT
    `Risk Weighting`,
    COUNT(*) AS Customer_Count,
    AVG(`Business Lending`) AS Avg_Business_Lending,
    SUM(`Business Lending`) AS Total_Business_Lending
FROM customers
GROUP BY `Risk Weighting`
ORDER BY `Risk Weighting`;


-- ============================================================
-- LOYALTY CLASSIFICATION ANALYSIS
-- ============================================================

SELECT
    `Loyalty Classification`,
    COUNT(*) AS Customer_Count,
    AVG(`Estimated Income`) AS Avg_Income,
    AVG(`Bank Deposits`) AS Avg_Deposits,
    AVG(`Bank Loans`) AS Avg_Loans
FROM customers
GROUP BY `Loyalty Classification`
ORDER BY Customer_Count DESC;


-- ============================================================
-- OCCUPATION ANALYSIS
-- ============================================================

SELECT
    `Occupation`,
    COUNT(*) AS Customer_Count,
    AVG(`Estimated Income`) AS Avg_Income,
    AVG(`Bank Loans`) AS Avg_Loans
FROM customers
GROUP BY `Occupation`
ORDER BY Customer_Count DESC;


-- ============================================================
-- FEE STRUCTURE ANALYSIS
-- ============================================================

SELECT
    `Fee Structure`,
    COUNT(*) AS Customer_Count,
    AVG(`Estimated Income`) AS Avg_Income,
    AVG(`Bank Deposits`) AS Avg_Deposits
FROM customers
GROUP BY `Fee Structure`
ORDER BY Customer_Count DESC;


-- ============================================================
-- PROPERTIES OWNED ANALYSIS
-- ============================================================

SELECT
    `Properties Owned`,
    COUNT(*) AS Customer_Count,
    AVG(`Estimated Income`) AS Avg_Income,
    AVG(`Bank Loans`) AS Avg_Loans
FROM customers
GROUP BY `Properties Owned`
ORDER BY `Properties Owned`;


-- ============================================================
-- CUSTOMER FINANCIAL SUMMARY BY RISK
-- ============================================================

SELECT
    `Risk Weighting`,
    COUNT(*) AS Customers,
    SUM(`Estimated Income`) AS Total_Income,
    AVG(`Estimated Income`) AS Avg_Income,
    SUM(`Bank Loans`) AS Total_Loans,
    AVG(`Bank Loans`) AS Avg_Loans,
    SUM(`Bank Deposits`) AS Total_Deposits,
    AVG(`Bank Deposits`) AS Avg_Deposits,
    SUM(`Business Lending`) AS Total_Business_Lending
FROM customers
GROUP BY `Risk Weighting`
ORDER BY `Risk Weighting`;


-- ============================================================
-- HIGH-LOAN CUSTOMERS
-- ============================================================

SELECT
    `ï»¿Client ID`,
    `Estimated Income`,
    `Bank Loans`,
    `Bank Deposits`,
    `Credit Card Balance`,
    `Risk Weighting`
FROM customers
WHERE `Bank Loans` > 1000000
ORDER BY `Bank Loans` DESC;


-- ============================================================
-- HIGH LOAN + HIGH CREDIT CARD BALANCE
-- ============================================================

SELECT
    `ï»¿Client ID`,
    `Estimated Income`,
    `Bank Loans`,
    `Credit Card Balance`,
    `Bank Deposits`,
    `Risk Weighting`
FROM customers
WHERE `Bank Loans` > 2000000
  AND `Credit Card Balance` > 5000
ORDER BY `Bank Loans` DESC;


-- ============================================================
-- CUSTOMER RISK ANALYSIS VIEW
-- ============================================================

CREATE OR REPLACE VIEW customer_risk_analysis AS
SELECT
    `ï»¿Client ID`,
    `Age`,
    `Estimated Income`,
    `Superannuation Savings`,
    `Amount of Credit Cards`,
    `Credit Card Balance`,
    `Bank Loans`,
    `Bank Deposits`,
    `Checking Accounts`,
    `Saving Accounts`,
    `Foreign Currency Account`,
    `Business Lending`,
    `Properties Owned`,
    `Risk Weighting`,
    `Loyalty Classification`,
    `Occupation`,
    `Fee Structure`,
    CASE
        WHEN `Estimated Income` < 100000 THEN 'Low'
        WHEN `Estimated Income` < 300000 THEN 'Med'
        ELSE 'High'
    END AS Income_Band
FROM customers;


-- view
SELECT *
FROM customer_risk_analysis;


