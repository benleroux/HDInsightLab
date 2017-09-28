-- Customers who browsed x book also browsed n other books 
-- Replace yourcontainername with the container created in step n 
SET Container=hdi; 
-- specify the storage name if you have created your own HDInsight cluster 
SET Storage=mtllab; 
-- specify the tablename 
SET Tablename=SalesbyBooks; 
 
-- Top Selling Books 
DROP TABLE IF EXISTS HDILABDB.${hiveconf:Tablename}; 
CREATE TABLE HDILABDB.${hiveconf:Tablename} ROW FORMAT DELIMITED FIELDS  
TERMINATED by '\1' lines TERMINATED by '\n'  
STORED AS TEXTFILE LOCATION 
'wasb://${hiveconf:Container}@${hiveconf:Storage}.blob.core.windows.net/bookstore/HDILABDB.${hiveconf:Tablename}/' 
AS 
Select  
       BookName, 
       Sum(Quantity) As QuantitySold, 
       Sum(PaymentAmount) As TotalAmount 
FROM HDILABDB.weblogs  
WHERE PurchaseType='Purchased'  
GROUP BY BookName  
ORDER BY QuantitySold Desc; 
