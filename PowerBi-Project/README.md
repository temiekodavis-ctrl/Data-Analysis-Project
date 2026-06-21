Problem Statement
Hospitals generate large volumes of patient, billing, and clinical data, but this information is often scattered across multiple systems, making it difficult to monitor performance and identify operational issues. This project aims to analyse patient demographics, billing patterns, diagnosis trends, wait times

Project Overview
A full Power BI project analysing hospital performance, patient demographics, billing patterns, diagnosis trends, and operational efficiency using a structured healthcare dataset.
This dashboard provides insights into:
- Patient demographics
- Billing and cost patterns
- Diagnosis distribution
- Hospital performance
- Appointment wait times
- Age vs Billing relationships
- Top hospitals by billing

Dataset Description
- The dataset includes:
- PatientID
- Age
- Gender
- Hospital
- Diagnosis
- BillingAmount
- BloodTest Results
- AdmissionDate
- DischargeDate
- Average Length of Stay (ALOS)

Data Cleaning & Preparation
- used Power Query to cleann the data:
- Removed duplicates/Blank spaces
- Checked data types
- Replaced titles e.e(Mr, Dr, Miss) with " "
- Standardised Patient/Doctor names (Split names into First name and Last Name)
- Converted BillingAmount to currency
- Created ALOS Measure
- Created a Cost Per Patient Measure

Insights From the Dataset
- The hospital with the highest billing amount is clearly identifiable from the dataset.
- Older patients tend to have higher billing amounts (seen in your scatter plot).
- Some hospitals show significantly longer wait times (Could be due to staff shortages).
- Billing amounts are skewed by a few high‑cost patients.
- A few doctors are mannaging a lot more patients than their peers.

Tools & Techniques Used
- Power Query
- DAX
- Data Modelling
- KPI Design
- Healthcare analytics
- Dashboard UX
- Time Intelligenc
