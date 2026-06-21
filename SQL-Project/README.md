SQL Project: Online Banking & NHS Prescriptions Database
A full end‑to‑end SQL project covering database design, normalisation, stored procedures, functions, views, triggers, and analytical SQL using two real‑world scenarios:
Online Banking System
NHS Prescriptions Database (Bolton region)
This project demonstrates strong SQL skills across schema design, data integrity, business logic, and analytical querying.

Project Overview
This project contains two major SQL builds:
1 - Online Banking Database
A relational database designed to manage customers, accounts, transactions, overdue fees, and repayments.
“The main aim of task 1 was to create a system that supports efficient data management, ensures data integrity, and enables accurate tracking of customer activity and account performance.”
2 - NHS Prescriptions Database
A database built from real NHS prescribing CSV files for the Bolton area.
“These files represent a small extract from a much larger national dataset that tracks every prescription issued across England each month.”

Database Design (Banking System)
ERD & Normalisation
The system was fully normalised to 3NF to reduce redundancy and improve integrity.
“The database is fully normalised to Third Normal Form (3NF) to ensure data integrity, reduce redundancy, and improve performance.”
Key Tables
- Customer
- Account
- Transactions
- OverdueFee
- Repayment
Key Design Choices
- Atomic address fields (Address1, City, Postcode)
- INT IDENTITY primary keys
- Foreign keys enforcing referential integrity
- DECIMAL(10,2) for monetary values
- CHECK, UNIQUE, NOT NULL constraints

Core SQL Features Implemented
Table‑Valued Functions
- SearchAccounts
Searches accounts by customer name or account type using wildcard matching.
“The function accepts two parameters… used to filter the results returned from the Account and Customer tables.”
- PaymentsDueSoon
Returns repayments due within the next 5 days using GETDATE() and DATEADD.
“The function always returns up to date results without requiring manual input.”
- Stored Procedures
addNewCustomer
Safely inserts new customers using parameterised inputs.
“By using parameters… reduces the risk of SQL injection and helps prevent accidental insertion of invalid data.”
updateCustomerDetails
Updates customer information securely and accurately.
- Views
transactionsWithFees
LEFT JOIN between Transactions and OverdueFee to show all transactions, even those without fees.
“A view acts as a virtual table… presenting a live, queryable window into existing data.”
- Triggers
trg_ClosedAccountAfterFinalPayment
Automatically closes an account when its balance reaches zero.
“Any time a credit repayment… reaches zero, the system automatically marks the account as closed.”
Balance Recalculation Trigger
Ensures account balances always match transaction history.

Analytical SQL Queries (Banking System)
- Customers who paid < 50% of overdue fees
Joins OverdueFee → Transactions → Customer and calculates repayment percentage.
“I compared the TotalRepaid value directly against half of the FeeAmount.”
- Customers who used > 80% of credit limit
Uses ABS(), NULLIF(), and subqueries to ensure accuracy.
- Overdue repayments with 3% daily fee
Recalculates balances, sums repayments, and applies fee logic.

NHS Prescriptions Database
- Data Import
-CSV files imported using Visual Studio’s Importer Dados extension.
“I used the Importer Dados extension… selected the file… checked all the suggested data types… imported the file.”
Analytical Queries
- Drugs in tablet/capsule form
- Total quantity per prescription
- Most prescribed chemical substance per month (using CTEs)
- Avg/Min/Max cost per BNF chapter

Data Integrity, Security & Concurrency
- Data Integrity
Balances recalculated directly from Transactions
Repayments summed from Repayment table
Overdue fees updated automatically
- Concurrency
SQL Server row‑level locking prevents race conditions.
- Security
Staff cannot manually change balances
Parameterised procedures prevent SQL injection
- Backup Strategy
Transactional tables prioritised for frequent backups.

Key Takeaways
- Strong understanding of relational design & 3NF
- Confident with stored procedures, triggers, functions, and views
- Ability to enforce business rules at the database level
- Experience analysing real NHS prescribing data
- Ability to detect data quality issues and build analytical SQL solutions
