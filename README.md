## Credit Default Analysis with SQL, BI & Cloud AI

This project demonstrates an end‑to‑end analysis pipeline for a **credit default** problem.  Using a public dataset of credit card clients from Taiwan, we build an analytic workflow that spans data ingestion, transformation, exploration, machine‑learning and business intelligence dashboards.  The entire project is structured to be reproducible on your local machine or in the cloud (Google BigQuery, Azure, AWS) and serves as a comprehensive portfolio piece for data analysts.

### 💂 Project structure

```text
credit-default-analysis-sql-bi-cloud-ai/
├── data/          # information on the dataset and instructions to download it
├── sql/           # BigQuery SQL scripts for data cleansing and feature engineering
├── notebooks/     # Python notebooks for EDA, modelling and exporting results
├── dashboards/    # Power BI (.pbix) and Tableau (.twb) dashboard files (placeholders)
├── docs/          # diagrams, sample outputs and documentation
└── README.md      # this file
```

### 📦 Dataset

The analysis uses the **Default of Credit Card Clients** dataset, which contains 30 000 instances and 23 features describing the demographics, credit history and payment behaviour of Taiwanese credit‑card clients.  The target variable indicates whether a client **defaulted on their payment in the following month**.  According to the UCI Machine Learning Repository, the dataset has no missing values and is intended for classification tasks【133051598662495†screenshot】.  Kaggle’s data card notes that the file includes demographic factors, credit data, history of payment and bill statements from April 2005 to September 2005【322121409565861†screenshot】.

> **Important:** The raw data file is not included in this repository because it is large and subject to licensing.  You can download the CSV version of the dataset from the UCI repository or Data Science Dojo and place it inside the `data/` folder:

1. Go to the Data Science Dojo mirror and download `default of credit card clients.csv` from <https://code.datasciencedojo.com/datasciencedojo/datasets/raw/master/Default%20of%20Credit%20Card%20Clients/default%20of%20credit%20card%20clients.csv>.
2. Rename the file to `default_of_credit_card_clients.csv` and copy it into `data/`.

Alternatively, you may download the original Excel file from the UCI site and convert it to CSV.  Once the CSV is in the `data/` folder, the notebooks will automatically load it.

### ⚙️ BigQuery pipeline

The `sql/cleaning_pipeline.sql` script contains SQL statements that can be executed in Google BigQuery (or any ANSI‑SQL engine) to create a clean, analytical table from the raw dataset.  The script performs the following operations:

1. **Load raw data** into a staging table using BigQuery’s file import.
2. **Cast numeric fields** to appropriate data types and remove the `ID` column.
3. **Engineer new features**, such as average bill amounts and payment ratios.
4. **Create an analytical table** suitable for modelling and BI.

You can run the script in the BigQuery console or through the `bq` CLI.  Adjust the dataset and table names (`YOUR_DATASET.raw_credit`, `YOUR_DATASET.clean_credit`) as needed.

### 💹 Dashboards

Two interactive dashboards are provided as examples (placeholders only):

* **Power BI**: The `.pbix` file (to be added in `dashboards/`) presents management‑level KPIs such as default rate by demographic group, credit limit distribution, and risk scores.
* **Tableau**: The `.twb` file (to be added in `dashboards/`) focuses on storytelling, showing temporal trends in default rates and geographic breakdowns (if available in the data).

The raw dataset does not include geographic information, but you could augment it by joining with external lookup tables (e.g. region by client ID).  Use the clean table created in BigQuery as the data source for both dashboards.

### 🤖 Machine‑learning notebook

The Jupyter notebook in `notebooks/credit_default_analysis.ipynb` contains code for:

* Loading the CSV dataset into a pandas DataFrame.
* Exploring distributions, correlations and default rates.
* Splitting the data into training and test sets and standardising features.
* Building a **logistic regression** model (and optionally an XGBoost model) to predict the probability of default.
* Evaluating the model using metrics such as accuracy, precision, recall and ROC‑AUC, and plotting the ROC curve.

The notebook is designed to run locally (with Python 3, pandas, scikit‑learn and matplotlib) or in cloud services like Vertex AI notebooks or AWS SageMaker.  No colours are specified in charts, in accordance with standard guidelines.

### ☁️ Cloud integration

The project is cloud‑agnostic.  Here is a high‑level architecture:

1. **Storage**: Upload the raw CSV to a cloud storage bucket (e.g. Google Cloud Storage, Amazon S3 or Azure Blob Storage).
2. **Data warehouse**: Use BigQuery (GCP), Redshift (AWS) or Synapse (Azure) to ingest the raw file into a staging table.
3. **Transformation**: Run the SQL script (`sql/cleaning_pipeline.sql`) to create a clean analytical table.
4. **Analytics & dashboards**: Connect Power BI and Tableau to the analytical table; build interactive reports for stakeholders.
5. **Machine learning**: Run the notebook in a managed notebook service (Vertex AI, SageMaker, Azure ML) or locally; optionally deploy the model as an API for real‑time scoring.

### 📚 References

* UCI Machine Learning Repository: Default of Credit Card Clients dataset – the dataset contains 30 000 instances, 23 features and no missing values【133051598662495†screenshot】.
* Kaggle data card – the dataset captures default payments, demographic factors, credit data, history of payment and bill statements of credit card clients in Taiwan from April 2005 to September 2005【322121409565861†screenshot】.

Feel free to fork this repository and extend the analysis with additional models, feature engineering or visualisations.  Contributions are welcome!
