-------------------------TASK 1-----------------------------------------
--Question 1
--Creating the data tables
CREATE TABLE Customer (
    CustomerID int IDENTITY(1,1) PRIMARY KEY,
    FirstName varchar(255) NOT NULL,
    LastName varchar(255) NOT NULL,
    Address varchar(255) NOT NULL,
    DateofBirth date NOT NULL,
    Email varchar(255) NOT NULL,
    Telephone varchar(20)
);
CREATE TABLE Account (
    AccountID INT  IDENTITY(1,1) PRIMARY KEY,
    CustomerID  INT NOT NULL,
    AccountType varchar(20) NOT NULL,
    AccountNumber varchar(20) NOT NULL,
    Password varchar(20) NOT NULL,
    Username varchar(20) NOT NULL
    CONSTRAINT FK_Account_Customer
        FOREIGN KEY (CustomerID)
        REFERENCES Customer(CustomerID)
);
CREATE TABLE Transactions(
    TransactionID INT  IDENTITY(1,1) PRIMARY KEY,
    CustomerID  INT NOT NULL,
    AccountID INT NOT NULL,
    TransactionDate DATE NOT NULL,
    CompletionDate DATE NULL,
    Amount DECIMAL(10,2) NOT NULL,
    TransactionType varchar(50) NOT NULL
    CONSTRAINT FK_Transactions_Account
        FOREIGN KEY (AccountID)
        REFERENCES Account(AccountID)
);
CREATE TABLE OverdueFee (
    OverdueFeeID INT  IDENTITY(1,1) PRIMARY KEY,
    TransactionID INT NOT NULL,
    DaysOverdue INT NOT NULL,
    FeeAmount INT NOT NULL,
    TotalOwed INT NOT NULL,
    TotalRepaid INT NOT NULL,
    OustandingBalance INT NOT NULL,
    CONSTRAINT FK_OverdueFee_Transaction
        FOREIGN KEY (TransactionID)
        REFERENCES Transactions(TransactionID)   
);

--Spelt "Oustanding" wrong after creating the databse so I had to rename it
EXEC sp_rename 'OverdueFee.OustandingBalance', 'OutstandingBalance', 'COLUMN';

CREATE TABLE Repayment (
    RepaymentID INT  IDENTITY(1,1) PRIMARY KEY,
    OverdueFeeID INT NOT NULL,
    RepaymentDate DATE NOT NULL,
    Amount INT NOT NULL,
    PaymentMethod varchar(250) NOT NULL,
    CONSTRAINT FK_Repayment_OverdueFee
        FOREIGN KEY (OverdueFeeID)
        REFERENCES OverdueFee(OverdueFeeID) 
);

--Inserting values into the Customer table
INSERT INTO Customer (FirstName, LastName, Address, DateOfBirth, Email, Telephone)
VALUES
('Sarah', 'Mathews', '17 The Close, Salford', '1998-10-12', 'SMathews@yahoo.com', '0732394567'),
('Luke', 'Smith', '23 Creek Meadows, Salford', '1977-09-03', 'LukeS@yahoo.com', '0776438905'),
('Sasha', 'Rigley', '7 Soho House, Manchester', '1981-05-11', 'saRig@gmail.com', '0798535679'),
('Ruth', 'Curran', '11 Hillview, Trafford', '1987-02-19', 'Ruthyy@outlook.com', '0789658432'),
('Gary', 'Hill', '112 Soraith, Manchester', '1993-07-24', 'Gazza@hotmail.com', '0789518953'),
('James', 'Wilson', '33 Cedar Drive, Bury', '1982-01-05', 'jWilson@gmail.com', '0762953094'),
('Olivia', 'Green', '56 Willow Street, Rochdale', '1998-12-22', 'oGreen@yahoo.com', '0795309341');

--Added more columns to the Accounts table
ALTER TABLE Account
ADD Balance DECIMAL(10,2) NULL;
ALTER TABLE Account
ADD InterestRate DECIMAL(5,2) NULL;
ALTER TABLE Account
ADD OpeningDate DECIMAL(10,2) NULL;
ALTER TABLE Account ADD CreditLimit DECIMAL(10,2) NULL;

--Inserting values into the Account table
INSERT INTO Account 
(CustomerID, AccountType, AccountNumber, Password, Username, Balance, InterestRate, OpeningDate, CreditLimit)
VALUES
(1, 'Savings', 'ACC1001', 'SarahPass1', 'sarah_sav', 2500.00, 1.20, '2023-01-10', NULL),
(2, 'Current', 'ACC2001', 'LukePass1', 'luke_curr', 800.00, NULL, '2022-11-20', NULL),
(3, 'Credit', 'ACC3001', 'SashaCC1', 'sasha_cc', -1987.00, 19.90, '2023-03-01', 2000.00),
(4, 'Loan', 'ACC4001', 'RuthLoan1', 'ruth_loan', -3000.00, 4.20, '2023-04-12', NULL),
(5, 'Savings', 'ACC5001', 'GarySav1', 'gary_sav', 1500.00, 1.20, '2023-05-05', NULL),
(6, 'Credit', 'ACC6001', 'JamesCC1', 'james_cc', -900.00, 21.50, '2023-06-18', 3000.00),
(7, 'Savings', 'ACC7001', 'OliviaSav1', 'olivia_sav', 3200.00, 1.20, '2023-07-01', NULL);

--Inserting values into the Transactions table
INSERT INTO Transactions
(AccountID, CustomerID, TransactionDate, CompletionDate, Amount, TransactionType)
VALUES
(1, 1, '2023-08-01', '2023-08-01', 45.00, 'Purchase'),
(1, 1, '2023-08-03', NULL, 120.00, 'LoanRepayment'),
(1, 1, '2023-08-05', '2023-08-05', 300.00, 'Deposit'),
(1, 1, '2023-08-07', '2023-08-07', 20.00, 'Withdrawal'),
(1, 1, '2023-08-10', '2023-08-10', 75.00, 'Purchase'),
(1, 1, '2023-08-12', NULL, 60.00, 'CreditRepayment'),
(1, 1, '2023-08-15', '2023-08-15', 500.00, 'Deposit'),
(1, 1, '2023-08-18', '2023-08-18', 40.00, 'Withdrawal'),
(1, 1, '2023-08-20', '2023-08-20', 90.00, 'Purchase'),
(1, 1, '2023-08-22', NULL, 110.00, 'LoanRepayment'),

(2, 2, '2023-08-01', '2023-08-01', 80.00, 'Purchase'),
(2, 2, '2023-08-03', NULL, 150.00, 'LoanRepayment'),
(2, 2, '2023-08-05', '2023-08-05', 200.00, 'Deposit'),
(2, 2, '2023-08-07', '2023-08-07', 30.00, 'Withdrawal'),
(2, 2, '2023-08-10', '2023-08-10', 60.00, 'Purchase'),
(2, 2, '2023-08-12', NULL, 90.00, 'CreditRepayment'),
(2, 2, '2023-08-15', '2023-08-15', 350.00, 'Deposit'),
(2, 2, '2023-08-18', '2023-08-18', 25.00, 'Withdrawal'),
(2, 2, '2023-08-20', '2023-08-20', 110.00, 'Purchase'),
(2, 2, '2023-08-22', NULL, 130.00, 'LoanRepayment'),


(3, 3, '2023-08-01', '2023-08-01', 55.00, 'Purchase'),
(3, 3, '2023-08-03', NULL, 140.00, 'LoanRepayment'),
(3, 3, '2023-08-05', '2023-08-05', 250.00, 'Deposit'),
(3, 3, '2023-08-07', '2023-08-07', 35.00, 'Withdrawal'),
(3, 3, '2023-08-10', '2023-08-10', 85.00, 'Purchase'),
(3, 3, '2023-08-12', NULL, 70.00, 'CreditRepayment'),
(3, 3, '2023-08-15', '2023-08-15', 400.00, 'Deposit'),
(3, 3, '2023-08-18', '2023-08-18', 45.00, 'Withdrawal'),
(3, 3, '2023-08-20', '2023-08-20', 95.00, 'Purchase'),
(3, 3, '2023-08-22', NULL, 125.00, 'LoanRepayment'),


(4, 4, '2023-08-01', '2023-08-01', 65.00, 'Purchase'),
(4, 4, '2023-08-03', NULL, 160.00, 'LoanRepayment'),
(4, 4, '2023-08-05', '2023-08-05', 280.00, 'Deposit'),
(4, 4, '2023-08-07', '2023-08-07', 50.00, 'Withdrawal'),
(4, 4, '2023-08-10', '2023-08-10', 95.00, 'Purchase'),
(4, 4, '2023-08-12', NULL, 85.00, 'CreditRepayment'),
(4, 4, '2023-08-15', '2023-08-15', 450.00, 'Deposit'),
(4, 4, '2023-08-18', '2023-08-18', 30.00, 'Withdrawal'),
(4, 4, '2023-08-20', '2023-08-20', 120.00, 'Purchase'),
(4, 4, '2023-08-22', NULL, 140.00, 'LoanRepayment'),


(5, 5, '2023-08-01', '2023-08-01', 70.00, 'Purchase'),
(5, 5, '2023-08-03', NULL, 180.00, 'LoanRepayment'),
(5, 5, '2023-08-05', '2023-08-05', 320.00, 'Deposit'),
(5, 5, '2023-08-07', '2023-08-07', 40.00, 'Withdrawal'),
(5, 5, '2023-08-10', '2023-08-10', 100.00, 'Purchase'),
(5, 5, '2023-08-12', NULL, 95.00, 'CreditRepayment'),
(5, 5, '2023-08-15', '2023-08-15', 480.00, 'Deposit'),
(5, 5, '2023-08-18', '2023-08-18', 35.00, 'Withdrawal'),
(5, 5, '2023-08-20', '2023-08-20', 130.00, 'Purchase'),
(5, 5, '2023-08-22', NULL, 150.00, 'LoanRepayment'),


(6, 6, '2023-08-01', '2023-08-01', 85.00, 'Purchase'),
(6, 6, '2023-08-03', NULL, 200.00, 'LoanRepayment'),
(6, 6, '2023-08-05', '2023-08-05', 350.00, 'Deposit'),
(6, 6, '2023-08-07', '2023-08-07', 55.00, 'Withdrawal'),
(6, 6, '2023-08-10', '2023-08-10', 115.00, 'Purchase'),
(6, 6, '2023-08-12', NULL, 105.00, 'CreditRepayment'),
(6, 6, '2023-08-15', '2023-08-15', 520.00, 'Deposit'),
(6, 6, '2023-08-18', '2023-08-18', 45.00, 'Withdrawal'),
(6, 6, '2023-08-20', '2023-08-20', 140.00, 'Purchase'),
(6, 6, '2023-08-22', NULL, 160.00, 'LoanRepayment'),


(7, 7, '2023-08-01', '2023-08-01', 95.00, 'Purchase'),
(7, 7, '2023-08-03', NULL, 220.00, 'LoanRepayment'),
(7, 7, '2023-08-05', '2023-08-05', 380.00, 'Deposit'),
(7, 7, '2023-08-07', '2023-08-07', 60.00, 'Withdrawal'),
(7, 7, '2023-08-10', '2023-08-10', 125.00, 'Purchase'),
(7, 7, '2023-08-12', NULL, 115.00, 'CreditRepayment'),
(7, 7, '2023-08-15', '2023-08-15', 550.00, 'Deposit'),
(7, 7, '2023-08-18', '2023-08-18', 50.00, 'Withdrawal'),
(7, 7, '2023-08-20', '2023-08-20', 150.00, 'Purchase'),
(7, 7, '2023-08-22', NULL, 170.00, 'LoanRepayment');

--Inserting values into the OverdueFee table
INSERT INTO OverdueFee (TransactionID, DaysOverdue, FeeAmount, TotalOwed, TotalRepaid, OutstandingBalance)
VALUES
(1, 10, 15.00, 165.00, 0.00, 165.00),
(3, 5, 8.00, 88.00, 20.00, 68.00),
(4, 12, 18.00, 218.00, 0.00, 218.00),
(5, 7, 10.00, 130.00, 50.00, 80.00),
(1, 3, 5.00, 155.00, 0.00, 155.00),
(3, 1, 2.00, 82.00, 10.00, 72.00),
(4, 2, 4.00, 204.00, 0.00, 204.00);

--Inserting values into the Repayment table
INSERT INTO Repayment 
(OverdueFeeID, RepaymentDate, Amount, PaymentMethod)
VALUES
(1,'2023-02-02 10:00', 0.00, 'None'),
(2,'2023-03-11 11:30', 0.00, 'None'),
(3,'2023-03-28 14:00', 20.00, 'Card'),
(4,'2023-05-10 09:45', 0.00, 'None'),
(5,'2023-05-16 12:10', 0.00, 'None'),
(6,'2023-07-15 16:20', 50.00, 'Bank Transfer'),
(7,'2023-07-11 10:30', 0.00, 'None'),

(1,'2023-02-10 09:20', 10.00, 'Card'),
(1,'2023-02-18 15:45', 5.00, 'Cash'),

(2,'2023-03-20 13:00', 15.00, 'Bank Transfer'),
(2,'2023-03-29 10:15', 5.00, 'Card'),

(3,'2023-04-05 11:40', 30.00, 'Card'),
(3,'2023-04-15 16:00', 10.00, 'Cash'),

(4,'2023-05-18 14:25', 25.00, 'Bank Transfer'),
(4,'2023-05-30 09:50', 15.00, 'Card'),

(5,'2023-05-25 12:30', 20.00, 'Cash'),
(5,'2023-06-02 11:10', 10.00, 'Card'),

(6,'2023-07-22 17:45', 40.00, 'Card'),
(6,'2023-07-30 10:00', 30.00, 'Cash'),

(7,'2023-07-18 09:30', 20.00, 'Bank Transfer'),
(7,'2023-07-25 13:15', 10.00, 'Card');

--Updating Address values inserted in the Customer table to be 3NF
ALTER TABLE Customer
ADD Address1 VARCHAR(255);
ALTER TABLE Customer
ADD Address2 VARCHAR(255);
ALTER TABLE Customer
ADD City VARCHAR(100);
ALTER TABLE Customer
ADD Postcode VARCHAR(20);

--Adding CustomerID column to Repayment table. Assuming RepaymentID and CustomerID are the same
ALTER TABLE Repayment
ADD CustomerID INT;

--Inserting values into the new columns added to the Customer table
ALTER TABLE Customer
DROP column Address2
UPDATE Customer
SET Address1 = '17 The Close',
    City = 'Salford',
    Postcode = 'M33GY'
WHERE CustomerID = 1;

UPDATE Customer
SET Address1 = '23 Creek Meadows',
    City = 'Moston',
    Postcode = 'M53TY'
WHERE CustomerID = 2;

UPDATE Customer
SET Address1 = '7 Soho House',
    City = 'Manchester',
    Postcode = 'M68RF'
WHERE CustomerID = 3;

UPDATE Customer
SET Address1 = '11 Hillview',
    City = 'Trafford',
    Postcode = 'M27UL'
WHERE CustomerID = 4;

UPDATE Customer
SET Address1 = '112 Soraith',
    City = 'Manchester',
    Postcode = 'M79RH'
WHERE CustomerID = 5;

UPDATE Customer
SET Address1 = '33 Cedar Drive',
    City = 'Bury',
    Postcode = 'M47JS'
WHERE CustomerID = 6;

UPDATE Customer
SET Address1 = '56 Willow Street',
    City = 'Rochdale',
    Postcode = 'M50YH'
WHERE CustomerID = 7;

--Question 2 
--(A) Function created to search bank accounts or products by account/product name. 
CREATE FUNCTION SearchAccounts 
(
    @aName NVARCHAR(50), --Reads either a partical or full name of the customer
    @pName NVARCHAR(50) --Reads either a partial or full account type
)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        a.AccountType,
        c.FirstName + ' ' + c.LastName AS FullName,
        a.OpeningDate --Account opening date
    FROM Account AS a
    INNER JOIN Customer AS c --Joining the Customer and account table today
        ON a.CustomerID = c.CustomerID  --Matches Customer name to Account type
    WHERE c.FirstName LIKE @aName + '%'--Filter by customer first name
       OR a.AccountType LIKE @pName + '%'--Filter by Account type
);

--(B) Return all loan or credit payments due in less than 5 days.
CREATE FUNCTION PaymentsDueSoon()
RETURNS TABLE
AS
RETURN
(
    SELECT 
        r.RepaymentID, --Unique repayment identifyer
        r.Amount, --Ammount to be repaid
        r.RepaymentDate, --Date to be repaid
        r.PaymentMethod --Repayment method
    FROM Repayment AS r
    WHERE r.RepaymentDate <= DATEADD(DAY, 5, GETDATE()) --Checks dates which are 5 days from todays date
      AND r.RepaymentDate >= GETDATE() 
);
--Update a date value to be within 5 days to validate function
UPDATE Repayment
SET RepaymentDate = '2026-03-17 10:00'
WHERE RepaymentDate = '2023-02-02 10:00';

--(C) Procedure to insert a new bank customer into the database
CREATE PROCEDURE addNewcustomer
    @FirstName VARCHAR(255),
    @LastName VARCHAR(255),
    @Address1 VARCHAR(255),
    @City   VARCHAR(100),
    @Postcode VARCHAR(20),
    @DateofBirth date,
    @Email VARCHAR(255),
    @Telephone VARCHAR(20)
AS
BEGIN
    INSERT INTO Customer (FirstName, LastName, DateofBirth, Email, Telephone, Address1, City, Postcode)
    VALUES (@FirstName, @LastName, @DateofBirth, @Email, @Telephone, @Address1, @City, @Postcode);
END;

--(D) Procedure to update customer table
CREATE PROCEDURE updateCustomerdetails
    @CustomerID INT,
    @FirstName VARCHAR(255),
    @LastName VARCHAR(255),
    @Address1 VARCHAR(255),
    @City   VARCHAR(100),
    @Postcode VARCHAR(20),
    @DateofBirth date,
    @Email VARCHAR(255),
    @Telephone VARCHAR(20)
AS
BEGIN
    UPDATE Customer 
    SET
    FirstName = @FirstName, 
    LastName = @LastName, 
    DateofBirth = @DateofBirth, 
    Email = @Email, 
    Telephone = @Telephone, 
    Address1 = @Address1, 
    City = @City, 
    Postcode = @Postcode
    WHERE CustomerID = @CustomerID;
END;

--Question3
--View of all transactions including overdue fees or payments, showing all
past and current transactions with any associated overdue fees.
CREATE VIEW transactionswithFees
AS
SELECT 
    t.TransactionID,
    t.CustomerID,
    t.AccountID,
    t.Amount AS TransactionAmount,
    t.TransactionDate,
    t.TransactionType,
    o.FeeAmount AS OverdueFee,
    o.OutstandingBalance
FROM Transactions AS t
LEFT JOIN OverdueFee AS o 
    ON t.TransactionID = o.TransactionID;

--Question 4
--Adding column AccounSstatus to Account table
ALTER TABLE Account
ADD AccountStatus VARCHAR(20);
--Setting all account status's to active
UPDATE Account
SET AccountStatus = 'Active'
--Trigger to Close account if Balance is 0 after a payment has been made
DROP TRIGGER IF EXISTS trg_CloseAccountAfterFinalPayment
GO
CREATE TRIGGER trg_CloseAccountAfterFinalPayment
ON Account
AFTER UPDATE --Trigger to start once an update is made on the Account table
AS
BEGIN
    UPDATE a
    SET a.AccountStatus = 'Closed' --Sets account status to "Closed"
    FROM Account a
    JOIN inserted i ON a.AccountID = i.AccountID
    WHERE i.Balance = 0; --Checks if balance is 0
END;


--Question 5
--Select all customers who have paid less than 50% of Total owed
SELECT 
    c.CustomerID,
    c.FirstName,
    c.LastName,
    o.FeeAmount,
    o.TotalRepaid,
    (o.TotalRepaid * 1.0 / o.FeeAmount) * 100 AS PercentPaid -- Calculates the percentage repaid 
FROM OverdueFee o
INNER JOIN Transactions t -- Join to Transactions to link each overdue fee to the correct customer
    ON o.TransactionID = t.TransactionID
INNER JOIN Customer c  --Retrieves customer details
    ON t.CustomerID = c.CustomerID
WHERE o.TotalRepaid < (0.5 * o.FeeAmount); --  only return customers who have repaid less than 50% of the total owed

--Question 7
--Select all customers who have used more than 80% of their of credit limit
SELECT 
    a.AccountID,
    a.CustomerID,
    c.FirstName + ' ' + c.LastName AS FullName,
    a.AccountType,
    a.Balance,
    a.CreditLimit,
    (ABS(a.Balance) / NULLIF(a.CreditLimit, 0)) * 100 AS CreditUsagePercent --Calculate credit usage as a percentage of the credit limit
FROM Account AS a 
INNER JOIN Customer AS c ON a.CustomerID = c.CustomerID --Match each customer to its account 
WHERE a.AccountType = 'Credit' --Only look at Credit accounts
  AND (ABS(a.Balance) / NULLIF(a.CreditLimit, 0)) > 0.8 --Identify accounts using more than 80% of their credit limit
  AND a.AccountID IN -- Ensure the account has at least one purchase transaction
  (
      SELECT DISTINCT AccountID
      FROM Transactions
      WHERE TransactionType = 'Purchase'
  );
--To test the select statment I mannually set the balance to 1900
UPDATE Account
SET Balance = 1900
WHERE Username = 'sasha_cc';
SELECT * FROM Account


--Update Balance to align with transactions in Transactions table
--Needed to match the balance in the account table to match transcation details for data credibility
UPDATE Account
SET Balance = t.NewBalance
FROM Account a
JOIN ( 
    SELECT -- Calculate the new balance for each account
        AccountID,
        SUM(
            CASE 
                WHEN TransactionType = 'Deposit' THEN Amount --Add all debit type transactions ammount to balance
                WHEN TransactionType IN ('Purchase', 'Withdrawal', 'LoanRepayment', 'CreditRepayment')--Subtracts all credit type transactions from balance
                    THEN -Amount
                ELSE 0
            END
        ) AS NewBalance --Updated Balance
    FROM Transactions
    GROUP BY AccountID
) t ON a.AccountID = t.AccountID;

--View of all customers reapyments which are more than 3 days (Multiple parts)
--Trigger to update Balance according to Transactions
--Once a trasaction is created (Inserted into the transaction table) the. balance is updated
CREATE TRIGGER trg_UpdateBalance
ON Transactions
AFTER INSERT
AS
BEGIN
    UPDATE a
    SET a.Balance =
        CASE 
            WHEN i.TransactionType = 'Deposit' THEN a.Balance + i.Amount -- Add funds for deposits
            WHEN i.TransactionType IN ('Payment', 'LoanRepayment', 'CreditRepayment') THEN a.Balance - i.Amount -- Reduce balance for repayments
            WHEN i.TransactionType IN ('Purchase', 'Withdrawal') THEN a.Balance - i.Amount -- Reduce balance for spending
            ELSE a.Balance --Do nothing for any other transaction
        END
    FROM Account a
    JOIN inserted i ON a.AccountID = i.AccountID; --Only updated. asociated account
END;

-- Update OverdueFee TotalPaid to align with repayment table
UPDATE OverdueFee
SET TotalRepaid = r.TotalPaid
FROM OverdueFee o
JOIN (
    SELECT OverdueFeeID, SUM(Amount) AS TotalPaid
    FROM Repayment
    GROUP BY OverdueFeeID
) r ON o.OverdueFeeID = r.OverdueFeeID;
--Update Oustanding Balance according to Total repaid
UPDATE OverdueFee
SET OutstandingBalance = TotalOwed - TotalRepaid;
--View of all customers reapyments which are more than 3 days ovverdue and applies a 3% daily fee for each day overdue
CREATE VIEW OverDueFeeCharges AS
SELECT 
    t.CustomerID,
    t.AccountID,
    o.OverdueFeeID,
    o.DaysOverdue,
    r.AmountOwed,
    o.TransactionID,
    r.AmountOwed * 0.03 * (o.DaysOverdue - 3) AS OverdueFee, -- Calculate overdue fee which is 3% per day after the first 3 days
    r.AmountOwed + (r.AmountOwed * 0.03 * (o.DaysOverdue - 3)) AS TotalDue  -- Calculates the total amount due including the overdue fee
FROM OverdueFee o
INNER JOIN ( --Aggregate total repayment amount per overdue fee record
    SELECT OverdueFeeID, SUM(Amount) AS AmountOwed
    FROM Repayment
    GROUP BY OverdueFeeID
) r ON o.OverdueFeeID = r.OverdueFeeID
INNER JOIN Transactions t ON o.TransactionID = t.TransactionID -- Matches the overdue fee to the original transaction and customer
WHERE o.DaysOverdue > 3;

--Inserted the data twice in the account table so Balance should be 215
UPDATE Account
SET Balance = 215
WHERE Balance = 0




