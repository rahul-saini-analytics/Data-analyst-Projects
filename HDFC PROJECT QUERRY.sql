
	SELECT * FROM HDFC_DATASETS

---1.Customer Transaction Summary: Write an SQL query to generate a report summarizing the total deposits, withdrawals, and transfers per customer.

SELECT 
    AccountNumber,
    SUM(CASE WHEN TransactionType = 'Deposit' THEN Amount ELSE 0 END) AS Total_Deposits,
    SUM(CASE WHEN TransactionType = 'Withdrawal' THEN Amount ELSE 0 END) AS Total_Withdrawals,
    SUM(CASE WHEN TransactionType = 'Transfer' THEN Amount ELSE 0 END) AS Total_Transfers
FROM HDFC_DATASETS
GROUP BY AccountNumber;

---2.Daily Transaction Volume: Create a query that calculates the number of transactions and total transaction amount per day.

SELECT 
    TransactionDate, 
    COUNT(*) AS Transaction_Count, 
    SUM(Amount) AS Total_Transaction_Amount
FROM HDFC_DATASETS
GROUP BY TransactionDate
ORDER BY TransactionDate;

---3.Branch Performance Analysis: Develop an SQL query to rank branches by total transaction amount.

SELECT 
    BranchCode, 
    SUM(Amount) AS Total_Amount,
    RANK() OVER (ORDER BY SUM(Amount) asc) AS Branch_Rank
FROM HDFC_DATASETS
GROUP BY BranchCode;

---4.Frequent Transaction Hours: Find the most common transaction time by analyzing hourly trends in the dataset.

SELECT 
    TransactionTime, 
    COUNT(*) AS Transaction_Count
FROM HDFC_DATASETS
GROUP BY TransactionTime
ORDER BY Transaction_Count DESC;

---5.High-Value Transactions: Write a query to identify transactions above a specified threshold (e.g., $10,000).

SELECT * 
FROM HDFC_DATASETS
WHERE Amount > 1000
ORDER BY Amount DESC;

---6.Currency Conversion Report: Assume exchange rates and convert all transactions to USD for analysis.

SELECT 
    TransactionID,
    AccountNumber,
    Amount,
    Currency,
    CASE 
        WHEN Currency = 'GBP' THEN Amount * 1.3
        WHEN Currency = 'JPY' THEN Amount * 0.009
        ELSE Amount 
    END AS Amount_in_USD
FROM HDFC_DATASETS;

---7.Fraud Detection: Identify accounts with unusually high transaction activity in a short period.
SELECT 
    AccountNumber, 
    TransactionDate, 
    COUNT(*) AS Transaction_Count
FROM HDFC_DATASETS
GROUP BY AccountNumber, TransactionDate
HAVING COUNT(*) > 5
ORDER BY Transaction_Count DESC;


---8.Transaction Type Distribution: Create a query to show the percentage distribution of each transaction type.

SELECT 
    TransactionType, 
    COUNT(*) AS Count, 
    (COUNT(*) * 100.0 / (SELECT COUNT(*) FROM HDFC_DATASETS)) AS Percentage
FROM HDFC_DATASETS
GROUP BY TransactionType;

---9.Account Activity Monitoring: Find inactive accounts (no transactions in the last 3 months).

SELECT DISTINCT AccountNumber
FROM HDFC_DATASETS
WHERE TransactionDate < DATEADD(MONTH,-3, '2024-02-01');

---10.Weekend vs. Weekday Transactions: Compare transaction volumes and amounts on weekends versus weekdays.

SELECT 
    CASE 
        WHEN DATEPART(WEEKDAY, TransactionDate) IN (1, 7) THEN 'Weekend'
        ELSE 'Weekday'
    END AS Day_Type,
    COUNT(*) AS Transaction_Count,
    SUM(Amount) AS Total_Amount
FROM HDFC_DATASETS
GROUP BY CASE 
            WHEN DATEPART(WEEKDAY, TransactionDate) IN (1, 7) THEN 'Weekend'
            ELSE 'Weekday'
         END;
