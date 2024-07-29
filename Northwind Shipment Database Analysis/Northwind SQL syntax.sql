/* Question Set1 -  Easy */
/* Q1: Show the category_name and description from the categories table sorted by category_name.  */

SELECT category_name, description
FROM categories
ORDER BY category_name


/* Question Set2 -  Easy */
/* Q2: Show all the contact_name, address, city of all customers which are not from 'Germany', 'Mexico', 'Spain'  */

SELECT DISTINCT contact_name, address, city
FROM customers
WHERE country NOT IN ('Germany','Mexico','Spain')


/* Question Set3 -  Easy */
/* Q3: Show order_date, shipped_date, customer_id, Freight of all orders placed on 2018 Feb 26  */

  SELECT order_date, shipped_date, customer_id, freight
FROM orders
WHERE order_date IS '2018-02-26'


/* Question Set4 -  Easy */
/* Q4: Show the employee_id, order_id, customer_id, required_date, shipped_date from all orders shipped later than the required date  */

SELECT employee_id, order_id, customer_id, required_date, shipped_date
FROM orders
WHERE shipped_date > required_date


/* Question Set5 -  Easy */
/* Q5: Show all the even numbered Order_id from the orders table.  */

SELECT order_id
FROM orders
WHERE order_id%2 IS 0


/* Question Set6 -  Easy */
/* Q6: Show the city, company_name, contact_name of all customers from cities which contains the letter 'L' in the city name, sorted by contact_name  */

SELECT city, company_name, contact_name
FROM customers
WHERE city LIKE '%L%'
ORDER BY contact_name


/* Question Set7 -  Easy */
/* Q7: Show the company_name, contact_name, fax number of all customers that has a fax number. (not null)  */

SELECT company_name, contact_name, fax
FROM customers
WHERE fax IS NOT null


/* Question Set8 -  Easy */
/* Q8: Show the first_name, last_name, hire_date of the most recently hired employee.  */

SELECT first_name,last_name, hire_date 
FROM employees
order by hire_date desc
LIMIT 1


/* Question Set9 -  Easy */
/* Q9: Show the average unit price rounded to 2 decimal places, the total units in stock, total discontinued products from the products table.  */

SELECT 
	ROUND(AVG(unit_price),2) AS avg_unitprice, 
    SUM(units_in_stock) AS total_units_instock, 
    SUM(discontinued) AS total_discontinued
FROM products


/* Question Set10 -  Medium */
/* Q10: Show the ProductName, CompanyName, CategoryName from the products, suppliers, and categories table  */

SELECT product_name, s.company_name,
	(SELECT category_name
   FROM categories
   WHERE categories.category_id=p.category_id) AS CategoryName
FROM products AS p 
LEFT JOIN suppliers AS s 
USING (supplier_id)


/* Question Set11 -  Medium */
/* Q11: Show the category_name and the average product unit price for each category rounded to 2 decimal places.  */

SELECT category_name,
	(SELECT ROUND(AVG(unit_price),2) 
     FROM products
     WHERE products.category_id=categories.category_id) AS avg_prod_unitprice
FROM categories


/* Question Set12 -  Medium */
/* Q12: Show the city, company_name, contact_name from the customers and suppliers table merged together. Create a column which contains 'customers' or 'suppliers' depending on the table it came from.  */

SELECT City, company_name, contact_name, 'customers' AS relationship 
FROM customers
UNION
SELECT city, company_name, contact_name, 'suppliers'
FROM suppliers


/* Question Set13 -  Hard */
/* Q14: Show the employee's first_name and last_name, a "Num_Orders" column with a count of the orders taken, and a column called "Shipped" that displays "On Time" if the order shipped on time and "Late" if the order shipped late. Group records by employee first_name and last_name and then by the "Shipped" status. Order by employee lastname, then by firstname, and then descending by number of orders.  */

SELECT 
	e.first_name, 
    e.last_name, 
    COUNT(o.order_id) AS num_orders, 
    (CASE WHEN o.shipped_date <= o.required_date THEN 'On Time'
    											ELSE 'Late'
                                                END) AS shipped 
FROM orders AS o
LEFT JOIN employees AS e 
ON e.employee_id = o.employee_id
GROUP BY e.first_name, e.last_name, shipped 
ORDER BY e.last_name, e.first_name, shipped DESC


/* Question Set14 -  Hard */
/* Q15: Show how much money the company lost due to giving discounts each year, order the years from most recent to least recent. Round to 2 decimal places  */

SELECT 
    (SELECT YEAR(order_date)
     FROM orders AS o 
     WHERE o.order_id=od.order_id) AS order_year,
     ROUND(SUM(od.quantity*(od.discount)*p.unit_price),2) AS discount_amount
FROM order_details AS od
LEFT JOIN products AS p 
ON p.product_id = od.product_id
GROUP BY order_year
ORDER BY order_year DESC



