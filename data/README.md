## Data folder

This folder holds the raw data used in the project. Because the **Default of Credit Card Clients** dataset is licensed through the UCI Machine Learning Repository and other mirrors, it is **not stored** in the repository by default. To populate this folder:

1. Download the CSV from the Data Science Dojo mirror: <https://code.datasciencedojo.com/datasciencedojo/datasets/raw/master/Default%20of%20Credit%20Card%20Clients/default%20of%20credit%20card%20clients.csv>.
2. Rename the file to `default_of_credit_card_clients.csv` and copy it into this `data/` directory.
3. Alternatively, download the original Excel file from the UCI Machine Learning Repository and convert it to CSV using your preferred tool (`pandas`, `Excel`, `LibreOffice` etc.).

Once the file is here, the notebooks and SQL scripts will automatically detect it. The raw dataset contains 30,000 records and 23 features describing client demographics and credit behaviour, with the binary target column labelled `default payment next month`.
