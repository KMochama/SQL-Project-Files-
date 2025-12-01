
-- MAXIMIZING PROFITABILITY THROUGH CUSTOMER SEGMENTATION AND PRODUCT STRATEGY: AN IN-DEPTH ANALYSIS

-- CASE STUDY
-- USING ADVENTUREWORKS2022 Dataset

-- SLOW DECLINE IN NET PROFIT MARGIN 
-- OVER THE PAST 2 YEARS

-- IDENTIFY THE MOST AND LEAST PROFITABLE CUSTOMER SEGMENTS AND PRODUCTS, 
-- EVALUATE SALES TRENDS AND RECOMMEND TARGETED STRATEGIES TO IMPROVE PROFIT MARGINS
-- BY AT LEAST 10% IN THE NEXT FISCAL YEAR


-- 1. SEGEMENT CUSTOMERS BY GEOGRAPHY, PURCHASING BEHAVIOUR, AND DEMOGRAPHICS
-- 2. ANALYZE PROFITABILTY PER PRODUCT CATEGORY AND INDIVIDUAL PRODUCTS
-- 3. INVESTAGE SEASONAL TRENDS AND ORDER PATTERSN
-- 4. EVELUATE SALES REPS PERFORMANCE
-- 5. ACCESS INVENTORY TURNOVER AND FLAG SLOW MOVING PRODUCTS
-- 6. RECOMMEND MARKETING AND PRODUCT BUNDLING STRATGEIES


-- CUSTOMER SEGMENTATION
-- UNDERSTAND WHICH CUSTOMER SEGMENTS DRIVE THE MOST REVENUE AND PROFIT

-- RFM ANALYSIS -- RECENCY, FREQUENCY AND MONETARY ANALYSIS
-- IDENTIFY HIGH VALUE CUSTOMERS AND ONE TIME BUYERS

-- Q1.
-- WHO ARE OUR TOP 10 CUSTOMERS BY TOTAL SALES REVENUE?
-- IDENTIY HIGH VALUE CUSTOMERS FOR LOYALTY AND TARGETED PROMOTIONS

-- Customers
-- Sales

-- Sales.Customer


SELECT 
	TOP 10
	c.CustomerID,
	SUM(soh.totaldue) AS TotalSales
FROM Sales.Customer c
JOIN Sales.SalesOrderHeader soh ON c.CustomerID = soh.CustomerID
GROUP BY c.CustomerID
ORDER BY TotalSales DESC;

SELECT 
	TOP 10
	c.CustomerID,
	p.FirstName + ' ' + p.LastName AS FullName,
	SUM(soh.totaldue) AS TotalSales
FROM Sales.Customer c
JOIN Sales.SalesOrderHeader soh ON c.CustomerID = soh.CustomerID
JOIN Person.Person p ON c.PersonID = p.BusinessEntityID
GROUP BY c.CustomerID, p.FirstName, p.LastName
ORDER BY TotalSales DESC;


-- WHAT ARE THE TOTAL NUMBER OF UCTOMERS IN EACH COUNTRY/REGION
-- SEGMENT CUTSOMERS GEOGRAPHICALLY

-- CUSTOMERS
-- SALES ORDER HEADER
-- 


SELECT
	CR.Name,
	COUNT(DISTINCT C.CustomerID) AS CustomerCount
FROM Sales.Customer C
JOIN Sales.SalesOrderHeader SOH ON C.CustomerID = SOH.CustomerID
JOIN Person.Address A on soh.BillToAddressID = a.AddressID
JOIN Person.StateProvince SP ON a.StateProvinceID = SP.StateProvinceID
JOIN Person.CountryRegion CR ON SP.CountryRegionCode = cr.CountryRegionCode
GROUP BY CR.Name
ORDER BY CustomerCount DESC;



 



WITH BaseRFM AS (
	SELECT
		C.CustomerID,
		MAX(SOH.OrderDate) AS LastOrderDate,
		COUNT(SOH.SalesOrderID) AS Frequency,
		SUM(SOH.TotalDue) AS Monetary
	FROM Sales.Customer C
	JOIN Sales.SalesOrderHeader SOH ON C.CustomerID = SOH.CustomerID
	GROUP BY C.CustomerID
),
RecencyCalc AS (
	SELECT *,
		DATEDIFF(DAY, LastOrderDate, '2014-06-30') AS Recency
	FROM BaseRFM
),
ScoredRFM AS (
	SELECT *,
		NTILE(4) OVER (ORDER BY Recency DESC) AS R_Score, -- LOWER DAYS = BETTER
		NTILE(4) OVER (ORDER BY Frequency) AS F_Score, -- Higher score = better
		NTILE(4) OVER (ORDER BY Monetary) AS M_Score -- higher amount = BETTER
	FROM RecencyCalc
),
Segmented AS (
	SELECT *,
		CAST(R_Score AS VARCHAR) + CAST(F_Score AS VARCHAR) + CAST(M_Score AS VARCHAR) AS RFM
	FROM ScoredRFM
)
SELECT
	CustomerID,
	Recency,
	Frequency,
	CAST(Monetary AS DECIMAL(18,2)) AS Monetary,
	R_Score,
	F_Score,
	M_Score,
	RFM,
	CASE
		WHEN RFM = '444' THEN 'Best Customers'
		WHEN R_Score = 4 AND F_Score >=3 THEN  'Loyal Customers'
		WHEN R_Score = 4 AND M_Score >=3 THEN 'Big Spenders'
		WHEN R_Score <=2 AND F_Score <= 2 AND M_Score <= 2 THEN 'At Risk Customers'
		WHEN F_Score = 4 AND M_Score = 4 THEN 'Frequent High Spenders'
		ELSE 'Others'
	END AS Segment_Description
FROM Segmented
ORDER BY RFM;


WITH BaseRFM AS (
	SELECT
		C.CustomerID,
		MAX(SOH.OrderDate) AS LastOrderDate,
		COUNT(SOH.SalesOrderID) AS Frequency,
		SUM(SOH.TotalDue) AS Monetary
	FROM Sales.Customer C
	JOIN Sales.SalesOrderHeader SOH ON C.CustomerID = SOH.CustomerID
	GROUP BY C.CustomerID
),
RecencyCalc AS (
	SELECT *,
		DATEDIFF(DAY, LastOrderDate, '2014-06-30') AS Recency
	FROM BaseRFM
),
ScoredRFM AS (
	SELECT *,
		NTILE(4) OVER (ORDER BY Recency DESC) AS R_Score, -- LOWER DAYS = BETTER
		NTILE(4) OVER (ORDER BY Frequency) AS F_Score, -- Higher score = better
		NTILE(4) OVER (ORDER BY Monetary) AS M_Score -- higher amount = BETTER
	FROM RecencyCalc
),
Segmented AS (
	SELECT *,
		CAST(R_Score AS VARCHAR) + CAST(F_Score AS VARCHAR) + CAST(M_Score AS VARCHAR) AS RFM
	FROM ScoredRFM
)
SELECT
	CASE
		WHEN RFM = '444' THEN 'Best Customers'
		WHEN R_Score = 4 AND F_Score >=3 THEN  'Loyal Customers'
		WHEN R_Score = 4 AND M_Score >=3 THEN 'Big Spenders'
		WHEN R_Score <=2 AND F_Score <= 2 AND M_Score <= 2 THEN 'At Risk Customers'
		WHEN F_Score = 4 AND M_Score = 4 THEN 'Frequent High Spenders'
		ELSE 'Others'
	END AS Segment_Description,
	COUNT(*) AS Total_Customers
FROM Segmented
GROUP BY CASE
		WHEN RFM = '444' THEN 'Best Customers'
		WHEN R_Score = 4 AND F_Score >=3 THEN  'Loyal Customers'
		WHEN R_Score = 4 AND M_Score >=3 THEN 'Big Spenders'
		WHEN R_Score <=2 AND F_Score <= 2 AND M_Score <= 2 THEN 'At Risk Customers'
		WHEN F_Score = 4 AND M_Score = 4 THEN 'Frequent High Spenders'
		ELSE 'Others'
	END
order by Total_Customers DESC;


-- PRODUCT PROFITABILTY ANALYSIS
-- WHICH PRODUCTS GENERATED THE HIGHEST AND LOWEST TOTAL PROFITS
-- PROFIT DRIVERS AND LOSS MAKERS

-- LINE TOTAL
-- ORDERQTY * COST

SELECT
	P.Name AS ProductName,
	SUM(SOD.LineTotal - (SOD.OrderQty * P.StandardCost)) AS TotalProfit
FROM Sales.SalesOrderDetail SOD
JOIN Production.Product P ON SOD.ProductID = P.ProductID
GROUP BY P.Name
order by TotalProfit DESC; --USE ASC FOR LOWEST PROFITS

SELECT
	P.Name AS ProductName,
	SUM(SOD.LineTotal - (SOD.OrderQty * P.StandardCost)) AS TotalProfit
FROM Sales.SalesOrderDetail SOD
JOIN Production.Product P ON SOD.ProductID = P.ProductID
GROUP BY P.Name
order by TotalProfit ASC; --USE ASC FOR LOWEST PROFITS


SELECT
	pc.Name AS CtaegoryName,
	SUM(SOD.LineTotal - (SOD.OrderQty * P.StandardCost)) AS TotalProfit,
	SUM(SOD.Linetotal) AS TotalRevenue,
	ROUND(SUM(SOD.LineTotal - (SOD.OrderQty * P.StandardCost)) * 100.0/ SUM(SOD.LineTotal),2) AS PFPercentage
FROM Sales.SalesOrderDetail SOD
JOIN Production.Product P ON SOD.ProductID = P.ProductID
JOIN Production.ProductSubcategory PSC ON P.ProductSubcategoryID = psc.ProductSubcategoryID
JOIN Production.ProductCategory pc on PSC.ProductCategoryID = pc.ProductCategoryID
GROUP BY PC.Name
ORDER BY PFPercentage DESC;

-- SALES TREND AND SEASONALITY ANALYSIS
-- WHAT ARE THE MONTLY SALES TREND FOR THE PAST 2 YEARS
-- IN WHICH MONTHS DO SALES PEAK?


-- SALES REP AND REGIONAL PERFORMANCE
-- WHAT ARE THE TOATL SALES BY SALES REP
-- WHICH REGIONS HAVE THE HIGHEST SALES AND PROFIT

-- INVENTORY EFFICIENCY ANALYSIS
-- WHAT PRODUCTS ARE SLOW-MOVING(IN INVENTORY BUT HAVE LOW SALES)
