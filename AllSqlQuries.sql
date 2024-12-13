use laptopprice;
select * from laptopdeviceprice;


 -- How would you insert a new laptop's data into the laptopdeviceprice table?
INSERT INTO laptopprice.laptopdeviceprice
(laptop_ID, Company, Product, TypeName, Inches, ScreenResolution, Cpu, Ram, Memory, Gpu, OpSys, Weight, Price_euros)
VALUES(1321, 'Lenovo', 'idealpad', 'working', 15, 'Full HD ', 'intel i7 ', '16 GB', '512 ssd', 'intel Hd', 'windows 11', '1 kg', 600000);

-- Write a query to retrieve all records from the laptopdeviceprice table.

select * from laptopdeviceprice;

-- 3.	How would you fetch only the Company, Product, and Price_euros fields for all records?
 SELECT laptop_ID, Company, Product,Price_euros
FROM laptopdeviceprice;

-- 4.	Write a query to find laptops with a Price_euros greater than 1000.

SELECT * 
FROM laptopdeviceprice 
WHERE Price_euros < 1000;

-- 5.	How would you fetch all laptops where the Company is "Dell"?

select * from laptopdeviceprice 
where Company ="Dell";


-- 6.	Write a query to retrieve laptops with a ScreenResolution containing "1920x1080".
select * from laptopdeviceprice 
where ScreenResolution ="Full HD 1920x1080";


-- 7.	How would you delete a laptop from the table using its laptop_ID?
 
 DELETE FROM laptopdeviceprice 
WHERE laptop_ID = 1320;


-- 8.	Write a query to update the Price_euros for a specific laptop_ID.
update  laptopdeviceprice
set Price_euros=600 where laptop_ID=1321;


-- 9.	How would you count the total number of laptops in the table?
SELECT COUNT(*) AS total_laptops
FROM laptopdeviceprice;

-- 10.	Write a query to fetch all laptops sorted by Price_euros in descending order.
  
SELECT * 
FROM laptopdeviceprice
ORDER BY Price_euros DESC;


-- 12.	How would you retrieve laptops that weight less than "2 kg"?

select * from laptopdeviceprice 
where Weight <2;


-- 13.	Write a query to find all unique Ram sizes in the table.
SELECT DISTINCT Ram
FROM laptopdeviceprice;


-- 14.	How would you fetch all records where the OpSys is either "Windows" or "MacOS"?

select  * from laptopdeviceprice l 
where OpSys ="Windows" or OpSys="MacOS";


-- or 
SELECT * 
FROM laptopdeviceprice
WHERE OpSys IN ('Windows', 'MacOS');

-- 15.	Write a query to calculate the average Price_euros of all laptops.

SELECT AVG(Price_euros) AS avg_price
FROM laptopdeviceprice;


-- 16.	How would you retrieve the maximum Price_euros in the table?
select Max(Price_euros) as Maximum
from laptopdeviceprice l ;


-- 17.	Write a query to find the top 5 most expensive laptops.
SELECT * 
FROM laptopdeviceprice
ORDER BY Price_euros DESC
LIMIT 5;


-- 18.	How would you group the laptops by Company and calculate the average price for each company?
select avg(Price_euros) ,Company 
from laptopdeviceprice l 
group by Company ;

-- 19.	Write a query to fetch laptops with Inches greater than or equal to 15 and Price_euros less than 500.
SELECT * 
FROM laptopdeviceprice
WHERE Inches >= 15
  AND Price_euros < 500;


-- 20.	How would you fetch all laptops where Memory contains "1TB"?
 SELECT * 
FROM laptopdeviceprice
WHERE Memory LIKE '%1TB%';


-- 21.	Write a query to find laptops that do not have a Gpu
SELECT * 
FROM laptopdeviceprice
WHERE Gpu IS NULL OR Gpu = '';

-- 23.	How would you calculate the total price of all laptops for a specific company?
SELECT SUM(Price_euros) AS total_price
FROM laptopdeviceprice
WHERE Company = 'Dell';


-- 24.	Write a query to fetch the Company and the number of laptops they produce in the table.
SELECT Company, COUNT(*) AS num_laptops
FROM laptopdeviceprice
GROUP BY Company;

-- 25.	How would you fetch laptops with Price_euros within a specific range, such as 500 to 1500?
SELECT * 
FROM laptopdeviceprice
WHERE Price_euros BETWEEN 500 AND 1500;


-- 26.	Write a query to find laptops where Cpu contains "i7" but the Price_euros is below 1000.
SELECT * 
FROM laptopdeviceprice
WHERE Cpu LIKE '%i7%' 
  AND Price_euros < 1000;


-- 27.	How would you retrieve the laptops that have the lightest weight?
 SELECT * 
FROM laptopdeviceprice
WHERE Weight = (SELECT MIN(Weight) FROM laptopdeviceprice);

-- 28.	Write a query to find laptops with both "SSD" and "HDD" in their Memory.
SELECT * 
FROM laptopdeviceprice
WHERE Memory LIKE '%SSD%' 
  AND Memory LIKE '%HDD%';

 -- 29.	How would you add a new column Discount to the table with a default value of 0?
 ALTER TABLE laptopdeviceprice
ADD COLUMN Discount DECIMAL(10, 2) DEFAULT 0;


ALTER TABLE laptopdeviceprice
DROP COLUMN Discount;

-- 30.	Write a query to update the Discount column for all laptops priced above 1500.
UPDATE laptopdeviceprice
SET Discount = 10
WHERE Price_euros > 1500;

-- 31.	How would you remove all records where the Price_euros is null?
DELETE FROM laptopdeviceprice
WHERE Price_euros IS NULL;

-- 32.	Write a query to find laptops where the TypeName is "Ultrabook" and they have at least 16GB of RAM.

SELECT *
FROM laptopdeviceprice
WHERE TypeName = 'Ultrabook'
  AND RAM >= '16GB';

 -- 34.	How would you normalize the Company column to another table and use foreign key constraints?
 -- step 1
 CREATE TABLE companies (
    CompanyID INT  PRIMARY KEY,
    CompanyName VARCHAR(255) NOT NULL UNIQUE
);

-- step 2 
ALTER TABLE laptopdeviceprice
ADD COLUMN CompanyID INT;

ALTER TABLE laptopdeviceprice
DROP COLUMN Company;

-- step 3
UPDATE laptopdeviceprice l
JOIN companies c ON l.Company = c.CompanyName
SET l.CompanyID = c.CompanyID;

-- step 4
ALTER TABLE laptopdeviceprice
ADD CONSTRAINT fk_company
FOREIGN KEY (CompanyID) REFERENCES companies(CompanyID);

-- 35.	Write a query to fetch laptops where Inches is greater than the average Inches of all laptops.
SELECT * 
FROM laptopdeviceprice
WHERE Inches > (SELECT AVG(Inches) FROM laptopdeviceprice);


-- 36.	How would you write a stored procedure to update the Price_euros for a given laptop_ID based on a discount percentage?
DELIMITER $$

CREATE PROCEDURE UpdateLaptopPrice(
    IN laptop_ID INT,
    IN discount_percentage DECIMAL(5, 2)
)
BEGIN
    DECLARE current_price DECIMAL(10, 2);
    DECLARE discounted_price DECIMAL(10, 2);

    -- Get the current price of the laptop
    SELECT Price_euros
    INTO current_price
    FROM laptopdeviceprice
    WHERE Laptop_ID = laptop_ID;
    
    -- Calculate the discounted price
    SET discounted_price = current_price * (1 - discount_percentage / 100);

    -- Update the price in the table
    UPDATE laptopdeviceprice
    SET Price_euros = discounted_price
    WHERE Laptop_ID = laptop_ID;
END $$

DELIMITER ;


-- 35.	Write a query to fetch laptops where Inches is greater than the average Inches of all laptops.  

SELECT * 
FROM laptopdeviceprice
WHERE Inches > (SELECT AVG(Inches) FROM laptopdeviceprice);

-- 36.	How would you write a stored procedure to update the Price_euros for a given laptop_ID based on a discount percentage?
DELIMITER $$

CREATE PROCEDURE UpdateLaptopPrice(
    IN laptop_ID INT,
    IN discount_percentage DECIMAL(5, 2)
)
BEGIN
    DECLARE current_price DECIMAL(10, 2);
    DECLARE discounted_price DECIMAL(10, 2);

    -- Retrieve the current price of the laptop
    SELECT Price_euros
    INTO current_price
    FROM laptopdeviceprice
    WHERE Laptop_ID = laptop_ID;

    -- Check if laptop exists
    IF current_price IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Laptop not found!';
    END IF;

    -- Calculate the discounted price
    SET discounted_price = current_price * (1 - discount_percentage / 100);

    -- Update the price in the table
    UPDATE laptopdeviceprice
    SET Price_euros = discounted_price
    WHERE Laptop_ID = laptop_ID;
    
END $$

DELIMITER ;

CALL UpdateLaptopPrice(101, 10);

-- 37.	Write a query to find laptops where the Weight is below the median weight.
SELECT *
FROM laptopdeviceprice
WHERE Weight < (
    SELECT AVG(Weight) 
    FROM (
        SELECT Weight
        FROM laptopdeviceprice
        ORDER BY Weight
        LIMIT 2 - (SELECT COUNT(*) FROM laptopdeviceprice) % 2  -- Handles even/odd number of rows
        OFFSET (SELECT (COUNT(*) - 1) / 2 FROM laptopdeviceprice)  -- Finds the middle element
    ) AS median_subquery
);


-- 38.	How would you fetch the top 3 laptops by price for each company?
WITH RankedLaptops AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY CompanyID ORDER BY Price_euros DESC) AS rank
    FROM laptopdeviceprice
)
SELECT *
FROM RankedLaptops
WHERE rank <= 3;


-- 39.	Write a query to check for duplicate entries in the Product column.
SELECT Product, COUNT(*) AS count
FROM laptopdeviceprice
GROUP BY Product
HAVING COUNT(*) > 1;


-- 40.	How would you partition the table by Company and rank laptops based on their Price_euros within each partition?
SELECT *,
       ROW_NUMBER() OVER (PARTITION BY Company ORDER BY Price_euros DESC) AS rank
FROM laptopdeviceprice;


-- 41.	Write a query to find laptops with the most common ScreenResolution.
SELECT ScreenResolution, COUNT(*) AS count
FROM laptopdeviceprice
GROUP BY ScreenResolution
ORDER BY count DESC
LIMIT 1;

-- 42.	How would you index the Price_euros column to optimize queries?
CREATE INDEX idx_price_euros ON laptopdeviceprice (Price_euros);

-- 43.	Write a query to identify laptops that are likely mispriced (e.g., Price_euros less than 50).

SELECT *
FROM laptopdeviceprice
WHERE Price_euros < 50;

-- 44.	How would you calculate the ratio of laptops with "i5" CPUs to those with "i7" CPUs?
   SELECT 
    (SELECT COUNT(*) FROM laptopdeviceprice WHERE Cpu LIKE '%i5%') /
    (SELECT COUNT(*) FROM laptopdeviceprice WHERE Cpu LIKE '%i7%') AS i5_to_i7_ratio;

-- 45.	Write a query to list all laptops where the price is above the company's average price.
   
   SELECT l.*
FROM laptopdeviceprice l
JOIN (
    SELECT Company, AVG(Price_euros) AS avg_price
    FROM laptopdeviceprice
    GROUP BY Company
) avg_prices ON l.Company = avg_prices.Company
WHERE l.Price_euros > avg_prices.avg_price;

   
-- 46.	How would you detect if any laptops have invalid Weight values, such as non-numeric values?

SELECT *
FROM laptopdeviceprice
WHERE Weight NOT REGEXP '^[0-9]+(\.[0-9]+)?$';


-- 47.	Write a query to retrieve laptops that have an unusual combination of Gpu and Cpu (e.g., high-end GPU with low-end CPU).

SELECT *
FROM laptopdeviceprice
WHERE (Cpu LIKE '%i3%' OR Cpu LIKE '%i5%') AND Gpu LIKE '%GTX%';


-- 48.	How would you ensure that laptop_ID is always unique and cannot be null?
ALTER TABLE laptopdeviceprice
MODIFY COLUMN Laptop_ID INT NOT NULL,
ADD PRIMARY KEY (Laptop_ID);


-- 49.	Write a trigger to automatically set Discount to 10% if Price_euros is above 2000.

CREATE TRIGGER set_discount_after_insert
BEFORE INSERT ON laptopdeviceprice
FOR EACH ROW
BEGIN
    IF NEW.Price_euros > 2000 THEN
        SET NEW.Discount = 10;
    END IF;
END;


-- 50.	How would you write a query to check if any rows violate specific business rules (e.g., Ram should always contain "GB")?

SELECT *
FROM laptopdeviceprice
WHERE Ram NOT LIKE '%GB%';


-- 51.	Write a query to identify the company with the highest average laptop price.


SELECT Company, AVG(Price_euros) AS avg_price
FROM laptopdeviceprice
GROUP BY Company
ORDER BY avg_price DESC
LIMIT 1;



-- 52.	How would you export the data in this table to a CSV file?

SELECT * 
FROM laptopdeviceprice
INTO OUTFILE '/path/to/your/file.csv'
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n';


-- 53.	Write a query to identify potential outliers in the Price_euros column using statistical methods like standard deviation.

SELECT *
FROM laptopdeviceprice
WHERE Price_euros > (SELECT AVG(Price_euros) + 2 * STDDEV(Price_euros) FROM laptopdeviceprice)
   OR Price_euros < (SELECT AVG(Price_euros) - 2 * STDDEV(Price_euros) FROM laptopdeviceprice);






















































