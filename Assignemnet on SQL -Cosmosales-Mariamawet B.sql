--Total Rows/Records in the Table is 345,000

select * from Cosmosales

---2 rows with UnitPrce lesser than 15
select * from Cosmosales
where UnitPrice < 15

---55,000 rows with Quantity lesser than zero
select * from Cosmosales
where Quantity < 0

--22,000 ROWS WITHOUT CustomerID
--323,000 rows are with CustomerID
--select * from Cosmosales
--where CustomerID is not null

select * from Cosmosales
where Quantity > 0 and UnitPrice > 15 and  CustomerID > 0

---Puting the query in a Common Table Expression(CTE) and naming it as First_Cleaning
with CTE_FirstCleaning as
(
	select * from Cosmosales
	where Quantity > 0 and UnitPrice > 15 and  CustomerID > 0
)
,  Duplicate_check as
(
	select * , ROW_NUMBER() Over (Partition by InvoiceNo, StockCode, Quantity order by InvoiceDate) AS Duplicate_read
	FROM CTE_FirstCleaning
)
select * 
into #Clean_Data
from Duplicate_check
where Duplicate_read = 1

select * FROM  #Clean_Data

select * , Quantity * UnitPrice as Revenue
into #Final_cleanData   --Final data as a temporary table
FROM  #Clean_Data


select * From #Final_cleanData




---0 rows are duplicates
---323,000 rows are without duplicates

--use the select into to add a temporay table
--select *
--into #Clean_Online Retail
--from Duplicate_check
--where Duplicate_read > 1






---Row Number function:
--It doesnt accept anything in the bracket, it is used with "Over"keyword.
---It returns the sequential number of a row starting at 1
--order by clause is required
--partition by clause is optional, but when set, row number is reset to 1 when the partition changes.
--ROW_NUMBER() OVER (ORDER BY Col1, Col2)


--select * from person.person

--select FirstName, LastName, PersonType,
--ROW_NUMBER() OVER (ORDER BY PersonType) AS RowNumber
--from [Person].[Person]

--select FirstName, LastName, PersonType,
--ROW_NUMBER() OVER (PARTITION BY PersonType ORDER BY PersonType) AS RowNumber
--from [Person].[Person]