# Aurora Bank Analysis 
![1000191964](https://github.com/user-attachments/assets/fe9e2d3d-9fc0-4e27-a5c3-79c35025b5f9)
## Table of Content
- [Overview](#overview)
- [Project Objectives](#project-objectives)
- [Data Cleaning](#data-cleaning)
- [Dashboard](#dashboard)
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
3. What is the Total debt based on gender and identity to the gender with the highest debt
4. What is the total number of customers by their credit score
5. How many customers are at low and High risk level
 ## Dashboard 

- ![dashboard 1](https://github.com/user-attachments/assets/c6ff2281-68c7-491b-9c09-4b084984b337)

-  ![Screenshot 2025-05-16 133547](https://github.com/user-attachments/assets/5bac681f-51e5-44e8-be9f-a8e478db6fce)
![Screenshot 2025-05-16 133940](https://github.com/user-attachments/assets/ca1e23ac-a254-464a-a504-029880543eed)

## Key Findings
1.**Customer Demographics and Financial Profile**
- A total of 2000 customers (1,016 Females and 984 males)
- The age range of 46-64 are where the majority of customer belongs to
- A total of $127.42M debt as female has the highest debt
- Over 70% of customers are low income earners
- 81 customers have poor credit score <579 and 166 have excellent credit score >800

2. **Card Distribution**
- A total of 9,238 card was issued to customers
- 52% of the customer use mastercard and majority make use of debit card
- 89% of card has EMV chips ensuring higher security during transactions

3. **Transaction Analysis**
- The most frequent transaction error is insufficient balance
- The highest number of transaction was recoreded in july 2023
- Customer mostly spend money on Money Transfer and Grocery store and supermarket
- Mastercard has the highest transaction volume (18k) in 2024

 Explore the interactive dashboard here
 https://app.powerbi.com/view?r=eyJrIjoiODU5ODhhZTctMDc3ZS00OGZjLWE5ZmEtYmM4YTMxNDk1NWY5IiwidCI6IjUzYjJmMWM0LWNiNjItNDc2MC04OTgyLWU4NGJmMDMwNmM4MiJ9

## Recommendations
- Tailor loan offering based on credit score and risk level of customers
- Enhance fraud detection measures to monitor transaction of card without EMV chips
- Educate customers on security advantages of EMV technology through emails
  
