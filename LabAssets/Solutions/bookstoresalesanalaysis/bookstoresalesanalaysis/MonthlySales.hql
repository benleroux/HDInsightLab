SET Container=hdi; 
-- specify the storage name if you have created your own HDInsight cluster 
SET Storage=mtllab; 
-- specify the tablename 
SET Tablename=MonthlySales; 
 
DROP TABLE IF EXISTS HDILABDB.${hiveconf:Tablename}; 

CREATE TABLE HDILABDB.${hiveconf:Tablename} ROW FORMAT DELIMITED FIELDS  TERMINATED by '\1' lines TERMINATED by '\n'  
STORED AS TEXTFILE LOCATION 
'wasb://${hiveconf:Container}@${hiveconf:Storage}.blob.core.windows.net/bookstore/HDILABDB.${hiveconf:Tablename}/' AS 
SELECT  MONTH(transactiondate) AS month , 
        SUM(paymentamount) AS totalsales 
FROM    HDILABDB.weblogs 
WHERE   purchasetype = "Purchased" 
GROUP BY MONTH(transactiondate)
ORDER BY month;
