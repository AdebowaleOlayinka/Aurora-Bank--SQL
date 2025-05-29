---Rename table name-
exec sp_rename '[dbo].[user$]','customer';
exec sp_rename '[dbo].[Transaction Data]','customertransaction';
exec sp_rename '[dbo].[Card]','Card_data';
 exec sp_rename '[dbo].[mcc_codes$]','mcc'

 --- Rename column name
    exec sp_rename '[dbo].[user$].id','Client id';
	exec sp_rename 'customertransaction.client_id','Client id';
	exec sp_rename'card_data.date','card_date'
    exec sp_rename 'mcc.mcc_id','merchant_id'
select * from customer
select * from customertransaction
select * from card_data
select * from mcc

---- Create Retirement status column
alter table customer
add retirement_status varchar(50)
update customer
set Retirement_Status =
case
when current_age > retirement_age then'Retired'
else 'Not Retired'
end

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

--- Customer risk column
alter table customer
add [Risk level] varchar(100)
update customer
set [Risk level] =
case 
when credit_score >=740 then 'Low Risk'
when credit_score between 670 and 739 then 'Middle Risk'
when credit_score <670 then 'High Risk'
end



---CUSTOMER ANALYSIS

--1. what is the total number of customers and gender distribution--
  select gender,count(distinct[client id]) as [total customer] from customer
  group by gender

--2. Total debt by customer-
select sum(Total_debt) as [Total Debt] from Customer

--3. Which gender has the highest total debt -
select gender, sum(Total_debt) as [Total Debt] from customer
group by gender
order by [Total Debt] desc

--4.--TOtal customer by their credit score
select[credit score rating], count(*)as [Total customer] from customer
group by [credit score rating]
order by [Total customer]desc

--5. total customer at risk based on thier credit score
select [risk level] ,count([client id]) as total_customer from customer
group by [risk level]


----Card Analysis--
--1.Total card type and card brand issued to customer between 2020 and 2024
select card_type,card_brand,year (card_date)as year, sum( num_cards_issued) as [total Card] from card_data
where year( card_date) between 2020 and 2024
group by card_type, card_brand,year(card_date)

--2.Total card issued between 2020 and 2024
 select year(card_date)as year, sum( num_cards_issued) as [total Card] from card_data
 where year(card_date)between 2020 and 2024
 group by year(card_date)
order by [total card]asc

---3. What is the total numbers of card with emv chips
 select has_chip, count(has_chip) as[Card with chip] from card_data
 group by has_chip


 --4. what is the total number of customer with different card brand
 select card_brand, count(client_id) as TOtal_customer from Card_data
 group by card_brand


 --- transaction analysis
 --1.  what is the total transaction amount
 select sum (amount) as total_transaction_amount from customertransaction

 --2. what are the most common transaction errors
 select top 5 errors,count(errors) as total_errors from customertransaction
 group by errors
 order by total_errors desc


 --3. which month and year has the highest transaction amount 
 select top 1 month([date]) as month,year([date])as year, sum (amount)as [TOtal transaction amount]from customertransaction
 group by month([date]) ,year([date])
 order by [TOtal transaction amount]desc

 --4. which card brand has the highest transaction volume
 select year([date])as year,Card_data.card_brand, count(customertransaction.id) as total_transaction from customertransaction
 join  card_data on customertransaction.[client id]=card_data.[client_id]
 group by card_data.card_brand,year([date])
 order by total_transaction desc ,year([date])


 