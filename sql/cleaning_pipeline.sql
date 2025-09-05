-- SQL pipeline for cleaning and transforming the Default of Credit Card Clients dataset.
--
-- This script is written for Google BigQuery but should work on any ANSI-SQL
-- engine with minor modifications.  Adjust dataset and table names as needed.

-- -----------------------------------------------------------------------------
-- 1. Create a staging table
--
-- The raw CSV can be uploaded to a cloud storage bucket and ingested into BigQuery
-- using the `bq load` command.  Here we define the table schema explicitly so
-- that numeric types are correctly assigned.  The target label is called
-- `default payment next month` in the original dataset; spaces are replaced
-- with underscores for convenience.

CREATE OR REPLACE TABLE `YOUR_PROJECT.YOUR_DATASET.raw_credit` (
  ID INT64,
  LIMIT_BAL INT64,
  SEX INT64,
  EDUCATION INT64,
  MARRIAGE INT64,
  AGE INT64,
  PAY_0 INT64,
  PAY_2 INT64,
  PAY_3 INT64,
  PAY_4 INT64,
  PAY_5 INT64,
  PAY_6 INT64,
  BILL_AMT1 FLOAT64,
  BILL_AMT2 FLOAT64,
  BILL_AMT3 FLOAT64,
  BILL_AMT4 FLOAT64,
  BILL_AMT5 FLOAT64,
  BILL_AMT6 FLOAT64,
  PAY_AMT1 FLOAT64,
  PAY_AMT2 FLOAT64,
  PAY_AMT3 FLOAT64,
  PAY_AMT4 FLOAT64,
  PAY_AMT5 FLOAT64,
  PAY_AMT6 FLOAT64,
  default_payment_next_month INT64
);

-- Example command to load the CSV from Cloud Storage into the staging table:
-- bq load --skip_leading_rows=1 --source_format=CSV \
--   YOUR_PROJECT:YOUR_DATASET.raw_credit \
--   gs://your-bucket/default_of_credit_card_clients.csv \
--   ./sql/cleaning_pipeline.sql

-- -----------------------------------------------------------------------------
-- 2. Create a clean analytical table
--
-- Drop the `ID` column, rename the target variable and compute engineered
-- features such as average bill amount and total payment.  These derived
-- features can help improve model performance and provide useful KPIs for
-- dashboards.

CREATE OR REPLACE TABLE `YOUR_PROJECT.YOUR_DATASET.clean_credit` AS
SELECT
  -- Demographic and credit variables
  LIMIT_BAL,
  SEX,
  EDUCATION,
  MARRIAGE,
  AGE,
  PAY_0,
  PAY_2,
  PAY_3,
  PAY_4,
  PAY_5,
  PAY_6,
  BILL_AMT1,
  BILL_AMT2,
  BILL_AMT3,
  BILL_AMT4,
  BILL_AMT5,
  BILL_AMT6,
  PAY_AMT1,
  PAY_AMT2,
  PAY_AMT3,
  PAY_AMT4,
  PAY_AMT5,
  PAY_AMT6,
  -- Label: 1 indicates default next month
  default_payment_next_month AS default_payment,
  -- Engineered features
  (BILL_AMT1 + BILL_AMT2 + BILL_AMT3 + BILL_AMT4 + BILL_AMT5 + BILL_AMT6) / 6 AS avg_bill_amt,
  (PAY_AMT1 + PAY_AMT2 + PAY_AMT3 + PAY_AMT4 + PAY_AMT5 + PAY_AMT6) AS total_pay_amt,
  SAFE_DIVIDE((PAY_AMT1 + PAY_AMT2 + PAY_AMT3 + PAY_AMT4 + PAY_AMT5 + PAY_AMT6),
              (BILL_AMT1 + BILL_AMT2 + BILL_AMT3 + BILL_AMT4 + BILL_AMT5 + BILL_AMT6)) AS pay_to_bill_ratio
FROM `YOUR_PROJECT.YOUR_DATASET.raw_credit`;

-- -----------------------------------------------------------------------------
-- The resulting table (`clean_credit`) can be used directly by BI tools and
-- machine-learning pipelines.  Additional feature engineering can be added here,
-- such as bucketing age groups or creating interaction terms.  Always verify
-- that your transformations make sense for the business context.
