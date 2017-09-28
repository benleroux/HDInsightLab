-- Row_Number 
-- The query PARTITIONS the weblogs table by categoryname.  
-- The ORDER BY clause in OVER clause orders the records by sum(paymentamount) in each partition 
-- The Row_Number assigns a number to each row in the partition  
SET Container=hdi; 
-- specify the storage name if you have created your own HDInsight cluster 
SET Storage=mtllab;
-- specify the tablename 
SET Tablename=monthly_category_sales; 
 
DROP TABLE IF EXISTS HDILABDB.${hiveconf:Tablename}; 
CREATE TABLE HDILABDB.${hiveconf:Tablename} ROW FORMAT DELIMITED FIELDS  TERMINATED by '\1' lines TERMINATED by '\n'  
STORED AS TEXTFILE LOCATION 
'wasb://${hiveconf:Container}@${hiveconf:Storage}.blob.core.windows.net/bookstore/HDILABDB.${hiveconf:Tablename}/' AS 
SELECT  ROW_NUMBER() OVER ( PARTITION BY categoryname ORDER BY SUM(paymentamount) ) AS rn , 
        MONTH(transactiondate) AS month , 
        categoryname, 
        SUM(paymentamount) AS totalsales 
FROM    HDILABDB.weblogs 
WHERE   purchasetype = "Purchased" 
GROUP BY MONTH(transactiondate), categoryname; 
