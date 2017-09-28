-- Rank 
-- Assign a rank to each customer based on the  
-- quanity of product purchased across all transactions 
SET Container=hdi; 
-- specify the storage name if you have created your own HDInsight cluster 
SET Storage=mtllab; 
-- specify the tablename 
SET Tablename=CustomerRank; 
 
DROP TABLE IF EXISTS HDILABDB.${hiveconf:Tablename}; 
CREATE TABLE HDILABDB.${hiveconf:Tablename} ROW FORMAT DELIMITED FIELDS  
TERMINATED by '\1' lines TERMINATED by '\n'  
STORED AS TEXTFILE LOCATION 
'wasb://${hiveconf:Container}@${hiveconf:Storage}.blob.core.windows.net/bookstore/HDILABDB.${hiveconf:Tablename}/' 
AS 
SELECT  customerid , 
        SUM(quantity) AS totalquantity , 
        RANK() OVER ( ORDER BY SUM(quantity) DESC ) AS RankCustomerbyQuantity 
FROM    HDILABDB.weblogs 
WHERE   purchasetype = "Purchased" 
GROUP BY customerid; 
