 
-- ---------------------------------
-- Data Inspection & Cleaning
-- ---------------------------------

-- inspecting the data set 

SELECT * FROM BikeSales;

-- inspecting the datatypes

PRAGMA table_info(BikeSales);

-- rename the column Sales_order # to sales_id

ALTER TABLE BikeSales
RENAME COLUMN 'Sales_Order#' TO 'sales_id';

-- looking for duplicates in sales_id column

SELECT sales_id, COUNT(sales_id)
FROM BikeSales
GROUP BY sales_id
HAVING COUNT(sales_id) > 1;

-- remove duplicate row 

DELETE FROM BikeSales
WHERE rowid NOT IN (
SELECT MIN(rowid)
FROM BikeSales
GROUP BY sales_id, Customer_Age
);

-- replace the duplicated ID value, which is not a duplicate row

UPDATE BikeSales
SET sales_id = '261694'
WHERE sales_id = '261695' AND Customer_Age = '39';

-- looking for duplicates rows in the other columns

SELECT Day, Customer_Age, Customer_Gender, Country, Product_Description, COUNT(*)
FROM BikeSales
GROUP BY Day, Customer_Age, Customer_Gender, Country, Product_Description
HAVING COUNT(*) > 1;

-- looking for null values

SELECT * FROM BikeSales
WHERE Day IS NULL
OR Month IS NULL
OR Year Is Null
OR Customer_Age Is Null
OR Age_Group Is Null
OR Customer_Gender is NULL
OR Country is NULL
OR State is NULL
OR Product_Description is NULL
OR Sub_Category is NULL
OR Product_Category is NULL
OR Order_Quantity is NULL;

-- replace NULL Values
-- since there are only a few NULL value per column, we can use SET to replace them individually

UPDATE BikeSales
SET Day = 5
WHERE sales_id = '261704';

UPDATE BikeSales
SET Age_Group = 'Adults (35-64)'
WHERE sales_id = '261709';

UPDATE BikeSales
SET Product_Description = 'Mountain-200 Black, 38'
WHERE sales_id = '261715';

UPDATE BikeSales
SET Order_Quantity = 1
WHERE sales_id = '261716';

-- looking for 0 values in the last columns

SELECT * FROM BikeSales
WHERE Unit_Cost = '0'
OR Unit_Price = '0'
OR Profit = '0'
OR Cost = '0'
OR Revenue = '0';

-- replace 0 values

UPDATE BikeSales
SET Unit_Cost = '1252', Cost = '1252'
WHERE sales_id = '261699';

UPDATE BikeSales
SET Unit_Price = '769', Revenue = '3076'
WHERE sales_id = '261702';

UPDATE BikeSales
SET Cost = '295', Revenue = '540'
WHERE sales_id = '261716';

-- -------------------------------------
-- Data Insights & additional Data Cleaning
-- -------------------------------------

-- date distribution 

SELECT Date, Count (*)
FROM BikeSales
GROUP BY Date;

-- day distribution

SELECT Day, Count(*)
FROM BikeSales
GROUP BY Day;

-- month distribution

SELECT Month, Count(*)
FROM BikeSales
GROUP BY Month;

-- there is a typo for 'December' which needs to be changed

UPDATE BikeSales
SET Month = 'December'
WHERE Month = 'Decmber';

-- year distribution

SELECT Year, Count(*)
FROM BikeSales
GROUP BY Year;

-- age distribution

SELECT Customer_Age, Count(*)
FROM BikeSales
GROUP BY Customer_Age;

-- age group distribution

SELECT Age_Group, COUNT(*)
FROM BikeSales
GROUP BY Age_Group;

-- the age group need redefining

-- average customer age

SELECT AVG(Customer_Age)
FROM BikeSales;

-- maximum and minumum customer age

SELECT MAX(Customer_Age), MIN(Customer_Age)
FROM BikeSales;

ALTER TABLE BikeSales
ADD age INTEGER;

UPDATE BikeSales
SET age = CASE
    WHEN customer_age >= 17 AND customer_age <= 25 THEN 'Youth'
    WHEN Customer_Age >= 26 AND Customer_Age <= 35 THEN 'Young Adult'
    WHEN Customer_Age >= 36 AND Customer_Age <= 45 THEN 'Adult'
    WHEN Customer_Age >= 46 AND Customer_Age <= 55 THEN 'Senior Adult'
    WHEN Customer_Age >= 56 THEN 'Senior'
END;

-- new 'age' column distribution

SELECT age, Count (*)
FROM BikeSales
GROUP BY age;

-- gender distribution

SELECT Customer_Gender, Count(*)
FROM BikeSales
GROUP BY Customer_Gender;

-- country distribution

SELECT Country, COUNT (*)
FROM BikeSales
GROUP BY Country;

-- there is one row with a typo for the country name leading to a duplicate output, this needs to be corrected

UPDATE BikeSales
SET Country = 'United States'
WHERE Country = 'United  States';

-- state distribution

SELECT State, Count (*)
FROM BikeSales
GROUP BY State;

-- the data input is not consistent for the state 'Paris', therefore the data needs to be changed

UPDATE BikeSales
SET State = 'Paris'
WHERE State = 'Seine (Paris)';

UPDATE BikeSales
SET State = 'Paris'
WHERE State = 'Seine Saint Denis';

-- understanding if 'Nord' has been mispelled/wrongly inputed:

SELECT Country FROM BikeSales
WHERE State = 'Nord';

-- 'Nord' seems to be a department of France rather than a mispelling

-- product_category distribtution

SELECT Product_Category, Count (*)
FROM BikeSales
GROUP BY Product_Category;

-- sub category distrubtion

SELECT Sub_Category, Count (*)
FROM BikeSales
GROUP BY Sub_Category;

-- product sales distribution

SELECT Product_Description, COUNT (*)
FROM BikeSales
GROUP BY Product_Description
ORDER BY Count(*) DESC;

-- -----------------------------------
-- Bike Sales Analysis
-- -----------------------------------

-- Q1: How much revenue and profit did the Bike Store generate in December?

SELECT SUM(Revenue), SUM(Profit)
FROM BikeSales;

-- Q2: How many orders where placed in total?

SELECT sum(Order_Quantity)
FROM BikeSales;

-- Q3: How did the numbers of orders and the profit distribute during the month?

SELECT
Date,
sum(Profit) OVER(
PARTITION BY Date
)
as 'profit_dist'
FROM BikeSales;

SELECT 
Date,
sum(Order_Quantity) OVER(
PARTITION BY Date
)
as 'order_dist'
FROM BikeSales;

-- Q4: What was the average profit per day?

SELECT
Date,
AVG(profit) OVER (
PARTITION BY Date
)
as 'avg_dayprofit'
FROM BikeSales;

-- Q5: Which bike model generated the largest profit

SELECT
Product_Description,
sum(Profit) OVER(
PARTITION BY Product_Description
)
as 'profitable_product'
FROM BikeSales;

-- Q6: Which bike model was bought the most?

SELECT
Product_Description,
sum(Order_Quantity) OVER (
PARTITION BY Product_Description
)
as 'order_quantity'
FROM BikeSales;

-- Q7: Which age group was the most profitable?

SELECT
age,
sum(Profit)
OVER (
PARTITION BY age
)
as 'total_profit_per_age'
FROM BikeSales;

-- Q8: Which country/gender was the most profitable?

SELECT
Customer_Gender,
Country,
sum(Profit)
OVER (
PARTITION BY Customer_Gender, Country
)
as 'profit_per_gender'
FROM BikeSales;

-- Q9: Which was the largest customer segment?

SELECT
sales_id,
age,
Customer_Gender,
Country,
count(sales_id)
OVER (
PARTITION BY Customer_Gender, age, Country
)
as 'gender_per_age_group'
FROM BikeSales;

-- Q10: Which location contributed the most orders ?

SELECT
Country,
State,
sum(Profit)
OVER (
PARTITION BY Country, State)
as 'profit_per_location'
FROM BikeSales;


