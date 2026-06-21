Problem Statement  
Understanding how pricing and discount strategies influence customer behaviour

Project Overview
This project explores an Amazon product dataset to understand pricing behaviour, discount patterns, and category performance.
The goal is to demonstrate strong skills in data cleaning, Excel analysis, and insight communication.
Retailers often run discounts, but not all discounts are equal. Some categories consistently offer deeper reductions, while others maintain higher prices
This project aims to answer:
  - Which product categories have the highest discounts?
  - What is the average price vs discounted price across categories?
  - Which categories generate the most reviews?
  - Are there patterns in rating quality across categories?
Understanding these patterns helps businesses optimise pricing strategies and identify high‑performing product groups.

Dataset Description
product_id - Product ID
product_name - Name of the Product
category - Category of the Product
discounted_price - Discounted Price of the Product
actual_price - Actual Price of the Product
discount_percentage - Percentage of Discount for the Product
rating - Rating of the Product
rating_count - Number of people who voted for the Amazon rating
about_product - Description about the Product
user_id - ID of the user who wrote review for the Product
user_name - Name of the user who wrote review for the Product
review_id - ID of the user review
review_title - Short review
review_content - Long review
img_link - Image Link of the Product
product_link - Official Website Link of the Product

Data Cleaning Steps
- Removed duplicate product entries
- Standardised category names
- Converted price columns to numeric format
- Created a Discount % column
- Fixed missing values in rating and review columns
- Ensured consistent data types across all fields
- Loaded cleaned data into Excel for analysis

Analysis & Insights
- Pricing & Discounts
Categories such as Electronics and Home Appliances showed the highest average discount percentages.
Some categories had high actual prices but minimal discounts, indicating premium positioning.
- Rating Behaviour
Categories with the highest discounts did not always have the highest ratings.
Products with more reviews tended to have more stable rating averages.
- Category Performance
A small number of categories contributed to the majority of total reviews, showing strong customer engagement.
Certain categories consistently ranked high in both price and review volume, indicating strong demand.

Visuals & Dashboard
Screenshots included in this folder:
PivotTable summary
Final dashboard layout

Average Discount %
Top Category by Reviews
Top Product by Sales
Average disount %
% of Products Rated 4★ and Above
Top Continent by Sales
Each KPI is dynamically linked using GETPIVOTDATA for interactivity.

Tools & Techniques Used
Excel formulas (AVERAGE, SUMIF, COUNTIF)
Power Query for data cleaning
PivotTables & PivotCharts
GETPIVOTDATA for KPI cards
Conditional formatting

Key Takeaways
- Improved ability to clean and transform messy retail data
- Built dynamic KPIs using PivotTables and GETPIVOTDATA
- Strengthened dashboard design and storytelling skills
- Demonstrated end‑to‑end analytical workflow suitable for real business use
