Problem Statement  
Modern organisations generate large datasets that cannot be processed efficiently using traditional tools. This project uses Databricks and PySpark to clean, transform, and analyse a large dataset, and to build a scalable machine‑learning model using distributed computing. The goal is to demonstrate the ability to work with big data, perform advanced transformations, and train models using Databricks’ collaborative and high‑performance environment.

Project Overview
- This project demonstrates how Databricks can be used to:
- Load and explore large datasets using PySpark
- Clean and transform data using Spark DataFrames and Spark SQL
- Perform exploratory data analysis (EDA)
- Build a recommender system using ALS
- Track experiments using MLflow
- Organise code into clear, modular notebook cells
The goal was to simulate a real‑world workflow where data is processed at scale and machine learning models are trained efficiently in a distributed environment.

Dataset Description
- The dataset was provided as part of the assignment and loaded directly into Databricks.
It contains:
- User information
- Item/product information
- Ratings or interactions
The dataset was loaded into a Spark DataFrame for distributed processing.

Data Loading & Cleaning
- Data Loading
The dataset was loaded into a Spark DataFrame using:
spark.read.csv()
spark.read.format("csv").options(...).load()
Cleaning Steps
Removec missing values
Converting columns to the correct data types
Removed duplicates
Extractied relevant columns
Filtered invalid or unrealistic values
- Exploratory Analysis
I checked:
Value counts
Useful statistics
Distribution of key variables
Trends and patterns
Correlations
This helped me understand the dataset before modelling.

Machine Learning Model
Model Used: ALS (Alternating Least Squares)
I built a recommender system using PySpark’s ALS algorithm.
Key steps:
Split data into train/test
Configured ALS hyperparameters
Handled cold‑start strategy
Trained the model
Generated predictions
Evaluated the RMSE
Used MLflow to track:
Parameters
Metrics
Model versions
Experiment runs
This allowed me to compare model performance across multiple runs.

Key Insights after Analysis
Data required cleaning before modelling
User behaviour patterns were visible in the EDA
ALS performed well after tuning
MLflow helped track and compare experiments
Databricks made it easy to scale transformations
