# Aurora Bank Analysis 
![1000191964](https://github.com/user-attachments/assets/fe9e2d3d-9fc0-4e27-a5c3-79c35025b5f9)
## Table of Content
- [Overview](#overview)
- [Project Objectives](#project-objectives)
- [Data Cleaning](#data-cleaning)
- [Exploratory Data Analysis](#exploratory-data-analysis)
- [Key Findings](#key-findings)
- [Recommendations](#recommendations)

## Overview 
This PowerBI dashboard project provide a comprehensive analysis of Aurora Bank customer base, transaction behaviour and card operations. Designed for actionable insight to help visualize trends to make decisions.
## Project Objectives
The primary ojectives of the project is to:
- Understand customer demographics and financial profile
- Monitor spending trends, transaction errors and customer at risk based on credit score and debt
- Assess card owned by customer and usage

## Data Cleaning 
- Rename table and columns
```
- Rename table name-
exec sp_rename '[dbo].[user$]','customer';
exec sp_rename '[dbo].[Transaction Data]','customertransaction';
exec sp_rename '[dbo].[Card]','Card_data';
 exec sp_rename '[dbo].[mcc_codes$]','mcc'

- Rename column name
    exec sp_rename '[dbo].[user$].id','Client id';
	exec sp_rename 'customertransaction.client_id','Client id';
	exec sp_rename'card_data.date','card_date'
exec sp_rename 'mcc.mcc_id','merchant_id'
```
- Add New Column Retirement status 
```
-- Create Retirement status column
alter table customer
add retirement_status varchar(50)
update customer
set Retirement_Status =
case
when current_age > retirement_age then'Retired'
else 'Not Retired'
end
```
- Add New Column Credit score rating
```
---- create credit score rating-
alter table customer
add [Credit score rating]varchar(100)
update customer
set[Credit score rating]=
case
when credit_score between 800 and 850 then 'Excellent'
when credit_score between 740 and 799 then 'Very Good'
when credit_score between 670 and 739 then 'Good'
when credit_score between 580 and 699 then 'Fair'
when credit_score between 300 and 579 then 'poor'
else 'unknown'
end
```
- Add New column Risk Levels
```
--- Customer risk column
alter table customer
add [Risk level] varchar(100)
update customer
set [Risk level] =
case 
when credit_score >=740 
then 'Low Risk'
when credit_score between 670 and 739 then 'Middle Risk'
when credit_score <670 then 'High Risk'
end
```
## Exploratory Data Analysis 
- Customer
1. What is the Total number of customers and thier gender distribution
2. What is the total debt by customer
3. What is the Total debt based on gender and identify to the gender with the highest debt
4. How many customer fall into each credit score rating category 
5. How many customers are classified under each risk level based on thier credit score

- Transactions
1. What is the total transaction amount across all customer
2. What are the most common transactions error during transactions
3. Which month and year has the highest transaction amount
4. which card brand recorded the highest transaction volume

- Card Analysis
1. What is the total number of card issued to customer by card type and brand between 2020 and 2024
2. How many card has EMV Chips
3. what is the total number of customers having different card brands

 ## Key Findings
1.**Customer Demographics and Financial Profile**
- A total of 2000 customers (1,016 Females and 984 males)
- A total of $127.42M debt as female has the highest debt
- 81 customers have poor credit score <579 and 166 have excellent credit score >800
- A total of 640 customer at low risk and 429 are high risk based on their credit score rating 

2. **Card Distribution**
- 7,566 card was issued to customers between 2020 and 2024
- 3,209(52%)of the customer use mastercard and majority make use of debit card
- 5,500(89%) of card has EMV chips ensuring higher security during transactions

3. **Transaction Analysis**
- The most frequent transaction error is insufficient balance
- The highest number of transaction was recoreded in july 2023
- Mastercard has the highest transaction volume  in 2022

## Recommendations
- Tailor loan offering based on credit score and risk level of customers
- Enhance fraud detection measures to monitor transaction of card without EMV chips
- Educate customers on security advantages of EMV technology through emails
  
