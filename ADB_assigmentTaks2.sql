---------------------------------TASK 2---------------------------
--Create Databse
CREATE DATABASE PrescriptionsDB;

--Question 2
--Returns details of all drugs which are in the form of tablets or capsules
SELECT * 
FROM Drugs
WHERE BNF_DESCRIPTION LIKE '%tablets' OR BNF_DESCRIPTION LIKE '%capsules';

--Question 3
--Returns the total quantity for each of prescriptions
SELECT 
    PRESCRIPTION_CODE,
    ROUND(ITEMS * QUANTITY, 0) AS PrescriptionsTotalQuantity
FROM Prescriptions;

--Question 4
--Returns a list of all the distinct most prescribed chemical substance per month
WITH MonthlyTotals AS ( -- Calculate total prescriptions per drug per month
    SELECT
        d.CHEMICAL_SUBSTANCE_BNF_DESCR, --Drug name
        s.REPORT_MONTH, 
        COUNT(*) AS TotalPrescriptions ---- Number of prescriptions for that drug in that month
    FROM Prescription_Summary AS s
    INNER JOIN Prescriptions AS p
        ON s.PRACTICE_CODE = p.PRACTICE_CODE -- Matches each prescriptions to the correct practice/month
    INNER JOIN Drugs AS d
        ON p.BNF_CODE = d.BNF_CODE
    GROUP BY
        d.CHEMICAL_SUBSTANCE_BNF_DESCR,
        s.REPORT_MONTH
),
-- Checks the highest prescription count in that month
MaxPerMonth AS (
    SELECT
        REPORT_MONTH,
        MAX(TotalPrescriptions) AS MaxCount
    FROM MonthlyTotals
    GROUP BY REPORT_MONTH
)
--   Return only the drugs whose prescription count matches the maximum
--   for their respective month.
SELECT
    mt.REPORT_MONTH,
    mt.CHEMICAL_SUBSTANCE_BNF_DESCR,
    mt.TotalPrescriptions
FROM MonthlyTotals mt
JOIN MaxPerMonth mp
    ON mt.REPORT_MONTH = mp.REPORT_MONTH
   AND mt.TotalPrescriptions = mp.MaxCount
ORDER BY mt.REPORT_MONTH;

--Question 5
--Rturns the number of prescriptions for each BNF_CHAPTER_PLUS_CODE,
--along with the average cost for that chapter code, and the minimum and maximum prescription
--costs for that chapter code
SELECT 
    d.BNF_CHAPTER_PLUS_CODE,
    COUNT(p.PRESCRIPTION_CODE) AS NumberOfPrescriptions,    -- Total number of prescriptions issued within this BNF chapter
    -- COUNT(*) would also work, but counting the prescription code is explicit
    AVG(p.ACTUAL_COST) AS AverageCost, --Finds the average cost of prescriptions in this chapter
    MIN(p.ACTUAL_COST) AS MinimumCost, --Finds the lowest individual prescription cost within the chapter
    MAX(p.ACTUAL_COST) AS MaximumCost --Finds the highest individual prescription cost within the chapter
FROM dbo.Prescriptions p
JOIN dbo.Drugs d
    ON p.BNF_CODE = d.BNF_CODE -- Join prescriptions to drug 
GROUP BY 
    d.BNF_CHAPTER_PLUS_CODE
ORDER BY 
    d.BNF_CHAPTER_PLUS_CODE;

 --Question 6
 -- returns the most expensive prescription prescribed by each practice, sorted
--in descending order by prescription cost 
 SELECT 
    m.PRACTICE_NAME,
    MAX(p.ACTUAL_COST) AS MostExpensivePrescription  -- Finds the most expensive prescription issued by this practice
FROM Prescriptions p
JOIN Medical_Practice m -- Matches prescriptions to their corresponding medical practice
    ON p.PRACTICE_CODE = m.PRACTICE_CODE
GROUP BY m.PRACTICE_NAME
HAVING MAX(p.ACTUAL_COST) > 4000   -- Only return practices where the most expensive prescription exceeds £4000
ORDER BY MostExpensivePrescription DESC;  -- Sort practices from highest to lowest prescription cost

--Question 7 
--Practice Specialisation
-- A practice is considered "specialised" if it issues more than 600 prescriptions
--   within a single BNF_CHAPTER_PLUS_CODE category.
SELECT 
    m.PRACTICE_NAME,  -- Name of the medical practice
    d.BNF_CHAPTER_PLUS_CODE AS PracticeSpecialisation
FROM dbo.Medical_Practice m
INNER JOIN dbo.Prescriptions p
    ON m.PRACTICE_CODE = p.PRACTICE_CODE -- Mtached prescriptions to the issuing practice
INNER JOIN dbo.Drugs d
    ON p.BNF_CODE = d.BNF_CODE
GROUP BY 
    m.PRACTICE_NAME,
    d.BNF_CHAPTER_PLUS_CODE
HAVING 
    COUNT(*) > 600;

--Supports Bulk Purchasing by Medical Practice
--Returns drugs where total ITEMS prescribed across all practices > 8000
SELECT 
    m.PRACTICE_NAME, -- Practice issuing the prescriptions
    d.BNF_CODE,
    d.BNF_DESCRIPTION,
    SUM(p.ITEMS) AS TotalQuantity -- Total quantity prescribed by the practice
FROM Drugs d
INNER JOIN Prescriptions p 
    ON d.BNF_CODE = p.BNF_CODE INNER JOIN Medical_Practice m ON p.PRACTICE_CODE = m.PRACTICE_CODE
WHERE p.PRACTICE_CODE = m.PRACTICE_CODE
  AND d.BNF_CODE IN (
        SELECT BNF_CODE -- Subquery: Identify high-volume drugs across all practices
        FROM Prescriptions
        GROUP BY BNF_CODE
        HAVING SUM(ITEMS) > 8000 --Bulk purchasing threshold
    )
GROUP BY m.PRACTICE_NAME, 
         d.BNF_CODE, 
         d.BNF_DESCRIPTION
ORDER BY TotalQuantity DESC;   -- Highest prescribing practices first

--Supports Bulk practice across all the medical Practices
SELECT 
    d.BNF_CODE,
    d.BNF_DESCRIPTION,
    SUM(p.ITEMS) AS TotalQuantity
FROM Drugs d
JOIN Prescriptions p ON d.BNF_CODE = p.BNF_CODE
WHERE d.BNF_CODE IN (
    SELECT BNF_CODE
    FROM dbo.Prescriptions
    GROUP BY BNF_CODE
    HAVING SUM(ITEMS) > 8000  -- Bulk purchasing threshold
)
GROUP BY d.BNF_CODE, d.BNF_DESCRIPTION
ORDER BY TotalQuantity DESC; -- Highest-volume drugs first

--Can detect errors or unsual entries
SELECT 
    p.PRESCRIPTION_CODE,
    p.PRACTICE_CODE,  -- Practice that issued the prescription
    p.ACTUAL_COST, -- Cost of the prescription (should be >= 0)
    p.QUANTITY,  -- Quantity prescribed (should be >= 0)
    GETDATE() AS ReportGenerated  -- Timestamp for audit/reporting
FROM dbo.Prescriptions p
WHERE p.ACTUAL_COST < 0  -- Invalid negative cost
   OR p.QUANTITY < 0 -- Invalid negative quantity
   OR p.ACTUAL_COST IS NULL --Missing cost data
   OR p.BNF_CODE IS NULL; -- Missing drug reference

-- Created a temporary table to safely test 
-- to avoid modifying your real Prescriptions table.
CREATE TABLE #TestPrescriptions (
    PRESCRIPTION_CODE INT,     
    PRACTICE_CODE NVARCHAR(20), -- Practice issuing the prescription
    BNF_CODE NVARCHAR(20), -- (NULL here simulates missing data)
    QUANTITY INT, -- Quantity prescribed
    ITEMS INT,                  
    ACTUAL_COST NUMERIC -- Cost of the prescription
);
-- Insert the invalid data
INSERT INTO #TestPrescriptions VALUES
(1, 'A11111', '010101', -10, 1, 20), -- Negative quantity 
(2, 'A11111', NULL, 10, 1, 30), -- Missing BNF code 
(3, 'A11111', '010101', 10, 1, NULL); -- Missing cost
SELECT --Reran the test againt the test table
    p.PRESCRIPTION_CODE,        
    p.PRACTICE_CODE,            
    p.ACTUAL_COST,             
    p.QUANTITY,                 
    GETDATE() AS ReportGenerated 
FROM #TestPrescriptions p
WHERE p.ACTUAL_COST < 0        
   OR p.QUANTITY < 0            
   OR p.ACTUAL_COST IS NULL     
   OR p.BNF_CODE IS NULL;       

-- Created a lookup table to convert month names to numbers as the data types for REPORT_MONTH is text
WITH M AS (
    SELECT 'January' AS MName, 1 AS MNum UNION ALL
    SELECT 'February', 2 UNION ALL
    SELECT 'March', 3 UNION ALL
    SELECT 'April', 4 UNION ALL
    SELECT 'May', 5 UNION ALL
    SELECT 'June', 6 UNION ALL
    SELECT 'July', 7 UNION ALL
    SELECT 'August', 8 UNION ALL
    SELECT 'September', 9 UNION ALL
    SELECT 'October', 10 UNION ALL
    SELECT 'November', 11 UNION ALL
    SELECT 'December', 12
)
-- Compare current vs previous month
SELECT 
    curr.PRACTICE_CODE,
    curr.REPORT_MONTH AS CurrentMonth, --Current practice month
    curr.TOTAL_COST AS CurrentCost, --Current month's cost
    prev.REPORT_MONTH AS PreviousMonth, -- Previous month
    prev.TOTAL_COST AS PreviousCost -- Previous month's cost
FROM dbo.Prescription_Summary curr
LEFT JOIN dbo.Prescription_Summary prev
    ON curr.PRACTICE_CODE = prev.PRACTICE_CODE
    AND (SELECT MNum FROM M WHERE MName = prev.REPORT_MONTH)  -- Match previous month using month numbers
        =
        (SELECT MNum FROM M WHERE MName = curr.REPORT_MONTH) - 1
ORDER BY 
    curr.PRACTICE_CODE,
    (SELECT MNum FROM M WHERE MName = curr.REPORT_MONTH);