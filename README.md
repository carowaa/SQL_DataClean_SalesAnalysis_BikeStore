## Bike Sales Analysis using SQL
  
### Purpose

This project is part of my GitHub Portfolio where I present the skill sets acquired througout the Codecademy Data Science Analystics Career Path Course. The main purpose of this particular project is to work with and clean an untidy dataset. I have also used this data set to run basic analysis. 
### Dataset 

The data has been taken from Kaggle. 

Here is the link to the data set:

https://www.kaggle.com/datasets/ratnarohith/uncleaned-bike-sales-data

*Dataset conversion*

The original dataset comes as Excel(xlsx) file. It needs to be converted to load into a SQL database. The Excel(xlsx) file was saved as a CSV file. Afterwards, the data was loaded via DB Browser for SQLite into a new database called BikeSales.db with a table named BikeSales.
### Tools 

1) Microsoft Excel
2) SQLite 
3) DB Browser for SQLite 
4) Visual Studio Code
5) Tableau 
6) Obsidian for documentation

### Code Structure

1) Data Inspection & Cleaning
2) Data Insights 
3) Data Analysis 

### Data Cleaning

On Kaggle, the dataset description indicated that the original data has missing values, dublicate rows and inconsistent data types. All of this aspects will be adressed to start with.

When tidying the data following issues have been found and fixed:

1) deleting one duplicate row and one row with a duplicate ID value
2) replacing four NULL values 
3) replacing four 0 values 
4) renaming the 'Sales_Order#' Column to 'sales_id'

### Data Insights 

Running basic queries to gain further insights and uncover more inconsistent data which required cleaning. 

1) typing mistake in the month column
2) inconsistent data description in the state & country column
3) set up new column 'age' to replace customer_age column 

*New 'age' column* 

I have decided to split of the customer age column because the 'age_group' column is not balanced well. The range for the first two groups 'Youth' and 'Young Adult' are ten years each, whereas the last group 'Adult' includes the range of thirty years. This might skew the data during analysis. The new column 'age' includes five bins, each ten years, from the youngest customer age of 17 up to the oldest customer age.

### Data Analysis 

To start with, I compiled some basic aggregative analysis to gain basic understanding of the data. However, most important I run queries to gain insights into business metrics relevant for the Sales Department: profits and order values as well as customer segments for the month of December. 
Even though profit and order value bring in similar value to the analysis, I looked at them individually, because it will gain understand about how many mountain bikes orders the store can expect in the future (which will help for stocking the right models)

I have therefore run queries to answer following questions: 

Q1: How much revenue and profit did the Bike Store generate in December?

Q2: How many orders where placed in total?

Q3: How did the numbers of orders and the profit distribute during the month?

Q4: What was the average profit per day?

Q5: Which product bike model generated the largest profit?

Q6: Which product bike model was bought the most?

Q7: Which age group was the most profitable?

Q8: Which country/gender customer segment was the most profitable?

Q9: Which was the largest customer segment?

### Tableau Dashboard

I used Tableau to create a dashboard that highlights the most important findings. Here is the link to the dashboard as well as a screenshot of the dashboard for reference:

[Tableau Dashboard](https://public.tableau.com/views/BikeSalesData_17241743948190/SalesAnalysisBikeStore?:language=de-DE&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)

![Bildschirmfoto 2024-08-22 um 14 54 35](https://github.com/user-attachments/assets/50f002d3-452c-420b-8936-09b46176dfdd)
