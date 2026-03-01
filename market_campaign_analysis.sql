create database if not exists food_market_analysis;
use food_market_analysis;
select * from marketdata;
-- Question 1: Which food categories generate the highest profit margin?
select food_category ,round(sum(`Profit(in millions)`),2) as Total_profit
,round((sum(`Profit(in millions)`)/sum(`store_sales(in millions)`)*100),2)
as profit_margin 
from marketdata 
group by food_category 
order by profit_margin desc ;
-- Insights:
-- The profit margin of meat is 60%,indicating it is highly efficient at turning sales into profit.
-- Even though bread has the highest profit (3,238 in million),its profit margin is slightly lower
-- then meat.The business should consider investing more in the Meat category to maximize
-- profitability.
-- Question no 2 :Do promotions generate positive ROI?
select promotion_name,
round(sum(`profit(in millions)`),2) as total_profit ,
round(sum(cost),2) as promotion_cost,
round((sum(`profit(in millions)`)- sum(cost) )/sum(cost),2) as Return_on_investment 
from marketdata 
group by promotion_name 
ORDER BY Return_on_investment DESC;
-- Insights :The ROI is negative,indicating that promotions cost more than the profit they made .
-- The business should re-evaluate and adjust its marketing strategy to focus on Pormotions.
-- Question no 3: Is price per unit negatively correlated with unit sales?
SELECT 
    (COUNT(*) * SUM(Price_per_unit * `unit_sales(in millions)`) - SUM(Price_per_unit) * SUM(`unit_sales(in millions)`)) /
    SQRT(
        (COUNT(*) * SUM(Price_per_unit * Price_per_unit) - SUM(Price_per_unit) * SUM(Price_per_unit)) *
        (COUNT(*) * SUM(`unit_sales(in millions)` * `unit_sales(in millions)`) - SUM(`unit_sales(in millions)`) * SUM(`unit_sales(in millions)`))
    ) AS correlation_coefficient
FROM marketdata;
-- Insight: 
-- Price per unit has virtually no effect on sales (correlation = -0.002).
-- Adjusting prices alone is unlikely to change unit sales; focus on promotions or marketing instead.
-- Question no 4 Do customers with higher membership levels generate more profit?
SELECT 
    member_card AS membership_type,
    round(SUM(`Profit(in millions)`),2) AS total_profit,
    round(AVG(`Profit(in millions)`),2) AS avg_profit,
    round(AVG(Profit_per_units),2) AS avg_profit_per_unit
FROM marketdata 
GROUP BY member_card
order by total_profit desc ;
-- Insight:
-- The bronze membership type generates the highest profit (31,841).Business 
-- should focus on this mebership typeconsider introducing special offers
-- or promotions to encourage more purchases and increase profit further.
-- Question  no 5 :Does average income influence purchasing power?
select 
case when Avg_income < 30000 then 'Low'
WHEN Avg_income BETWEEN 30000 AND 60000 THEN 'Medium'
else 'High'
end as income_group,
round(SUM(`Profit(in millions)`),2) AS total_profit,
round(AVG(`Profit(in millions)`),2) AS avg_profit
from marketdata 
group by 
case when 
Avg_income < 30000 then 'Low'
WHEN Avg_income BETWEEN 30000 AND 60000 THEN 'Medium'
else 'High'
end 
order by total_profit desc;
-- Insight 
-- The medium  Average income group generates the highest profit(29,000).
-- The business should focus on this income group and consider targeted promotions
-- or offers to encourage more purchases and increase profit further 
-- Question no 6 :Are low-fat products more profitable than regular products?
select * from marketdata;
select 
case  when low_fat = 1 then 'low_fat' 
else 'non_low_fat' 
end as low_fat,
round(sum(`Profit(in millions)`),2) as total_profit 
from marketdata 
group by low_fat;
-- Insights
-- Non-low-fat products  generates slightly  higher profit (33,260)compared to than low fats . 
-- Question no 7 :Do stores with larger grocery ratio perform better?
select store_type , round(sum(Grocery_ratio),2) as grocery_ratio
,round(sum(`Profit(in millions)`),2) as total_profit from marketdata 
group by store_type 
order  by grocery_ratio desc ;
-- Insight: 
-- Stores with a higher proportion of grocery items tend to generate greater profits. This indicates 
-- that focusing on grocery products contributes positively to overall store profitability.
-- Question no 8: Do stores offering additional services generate higher revenue per sqft?
select store_type as stores ,
(sum(`store_sales(in millions)`)/sum(store_sqft)) as revenue_per_square
from marketdata 
group by store_type 
order  by  revenue_per_square desc ;
-- Insight
--  Gourmet Supermarkets generate the highest revenue per sqft
--  followed by Supermarkets and Deluxe Supermarkets.
-- Question no 9 :Does education level influence purchasing behavior?
select education,round(sum(`store_sales(in millions)`),2)
as total_sales ,round(sum(`Profit(in millions)`),2) as total_profit 
from marketdata 
group by education 
order by total_profit desc ; 
-- Insight: 
-- Members with Partial High School education generate higher revenue (28,221) and profit (16,915).
-- The business should consider offering special deals or discounts targeted at this group to further boost sales and loyalty.
-- Question no 10 :Which media type generates the highest profit per promotion cost?
select media_type ,
round(sum(`Profit(in millions)`) / sum(cost),2) as highest_profit_per_promotion
from marketdata 
group by media_type
order by highest_profit_per_promotion desc ;
-- Insight
-- Daily paper and TV generates the highest profit per promotion cost (0.05).  
-- The business should prioritize these media channels for promotions to maximize return on investment.