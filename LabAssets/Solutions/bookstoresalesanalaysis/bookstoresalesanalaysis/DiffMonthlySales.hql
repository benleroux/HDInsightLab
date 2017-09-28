-- Replace yourcontainername with the container created in step n 
SET Container=hdi; 
-- specify the storage name if you have created your own HDInsight cluster 
SET Storage=mtllab; 
-- specify the tablename 
SET Tablename=DiffMonthlySales; 
 
-- Get difference between total sales in subsequent months 
DROP TABLE IF EXISTS HDILABDB.${hiveconf:Tablename}; 
CREATE TABLE HDILABDB.${hiveconf:Tablename} ROW FORMAT DELIMITED FIELDS  TERMINATED by '\1' lines TERMINATED by '\n'  
STORED AS TEXTFILE LOCATION 
'wasb://${hiveconf:Container}@${hiveconf:Storage}.blob.core.windows.net/bookstore/HDILABDB.${hiveconf:Tablename}/' 
AS 
SELECT Month, MonthName, Sales, 
 	   LAG(Sales) OVER(ORDER BY Month) As PreviousSales, 
       Sales - LAG(Sales) OVER(ORDER BY Month) As SalesDifference 
FROM HDILABDB.MonthNameMonthlySales 
ORDER BY Month; 
