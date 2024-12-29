select *
FROM df_orders

--1. find top 10 highest revenue generation products
SELECT TOP 10 product_id, sum(sale_price) as sales
FROM df_orders
GROUP by product_id
ORDER BY sales desc

/*explanation:
1.1 selecting the name of product_id so we know the product
also select the sum of sale price each product so we now the revenue and alias it for shorten
1.2 grouping it by product_id so we know the difference between them
1.3 order it by descending so we know the highest sales
1.4 top 10 to limit the top 10 highest 
*/

--2. Find top 5 highest selling products in each region
with cte as ( --using cte because we need to select EACH region
	SELECT region, product_id, sum(sale_price) as sales
	FROM df_orders
	GROUP BY region, product_id) --grouping every region and every product_id
SELECT *
FROM (
	SELECT *, ROW_NUMBER() --using row number to rank them
	over(
	partition by region --partitioning / grouping by region
	order by sales desc --ordering by sales
	) as ranking --making the new column, using alias ranking
	FROM cte
	) A --an alias named A because we need to make the alias for its select
where ranking <= 5; --just the TOP 5

/* that 2nd one is more complex than the 1st, i already put the explanation above */

--3. Show month over month growth comparison for year 2022 and 2023 sales. eg: feb 2022 vs feb 2023
with cte as( --we using this again
	SELECT
	year(order_date) as order_year, --showing years 
	month(order_date) as order_month, --showing months
	sum(sale_price) as sales --telling the sales
	FROM df_orders
	GROUP BY year(order_date), month(order_date) --group by both
	)
SELECT order_month, --to show the order each month
sum(case when order_year = 2022 then sales else 0 end) as sales_2022, --sum all order in 2022 each month
sum(case when order_year = 2023 then sales else 0 end) as sales_2023 --sum all order in 2023 each month
FROM cte
GROUP BY order_month;

/*For number 3, we also use CTE for simple aggregation & writing. We also use it to select sales each month and year,
then, we show a total of 12 months (a year) for every sales in 2022 and 2023*/

--4. Which month had highest sales in each category
with cte as(
	SELECT category, 
	format(order_date, 'yyyyMM') as order_year_month, --make a new column to show the specific month
	sum(sale_price) as sales
	FROM df_orders
	GROUP BY category, format(order_date, 'yyyyMM')
  --ORDER BY category, format(order_date, 'yyyyMM') --we dont need this anymore because we are currently using cte
	)
SELECT * --selecting all because we need to show all
FROM (
	SELECT *, --select all and rank them all by sales and group by category
	ROW_NUMBER()over(
	partition by category
	order by sales desc) as ranking
	from cte
	)x
WHERE ranking = 1

/*Explanation: One new thing in No. 4 is we created a new column for showing the order year and month because we have to,
then we select the category and its sales and we rank them from highest and limit it to only one*/

--5. Which sub category had highest absolute growth by profit in 2023 compared to 2022
with cte as( --we using this again
	SELECT
	sub_category,
	year(order_date) as order_year, --showing years 
	sum(sale_price) as sales --telling the sales
	FROM df_orders
	GROUP BY sub_category, year(order_date)
	),
	cte2 as (
	SELECT sub_category, --to show the order each month
	sum(case when order_year = 2022 then sales else 0 end) as sales_2022, --sum all order in 2022 each month
	sum(case when order_year = 2023 then sales else 0 end) as sales_2023 --sum all order in 2023 each month
	FROM cte
	GROUP BY sub_category
	)
SELECT TOP 1 *, -- select the top one
(sales_2023 - sales_2022) --equation for absolute growth, change it to (2023/2022)/2022*100% for relative growth
FROM cte2
ORDER BY (sales_2023 - sales_2022) DESC --showing the highest growth

/*explanation: maybe this is the most complex one, because we use 2 cte. 1st cte is for showing
the difference each sub_category and every years, while the 2nd is for selecting its sub_category and showing its growth*/