-- Replace yourcontainername with the container created in step n 
SET Container=hdi; 
-- specify the storage name if you have created your own HDInsight cluster 
SET Storage=mtllab; 
-- specify the tablename 
SET Tablename=ntile; 
 
-- Ntile 
-- Divide categories into four different groups numbered 1-4 based on total sales made under each category. 
-- With 1 being the group with categories having highest sales and 4 being the group with categories having lowest sales 
DROP TABLE IF EXISTS HDILABDB.${hiveconf:Tablename}; 
CREATE TABLE HDILABDB.${hiveconf:Tablename} ROW FORMAT DELIMITED FIELDS  
TERMINATED by '\1' lines TERMINATED by '\n'  
STORED AS TEXTFILE LOCATION 
'wasb://${hiveconf:Container}@${hiveconf:Storage}.blob.core.windows.net/bookstore/HDILABDB.${hiveconf:Tablename}/' 
AS 
SELECT  NTILE(4) OVER (ORDER BY SUM(PaymentAmount) DESC) AS Quartile , 
        CategoryName, 
        SUM(PaymentAmount) AS TotalSales 
FROM    HDILABDB.weblogs 
WHERE   PurchaseType = "Purchased" 
GROUP BY CategoryName ORDER BY Quartile; 
