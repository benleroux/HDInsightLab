set hive.llap.execution.mode=all;
-- Replace yourcontainername with the container created in step n 
SET Container=hdi; 
-- specify the storage name if you have created your own HDInsight cluster 
SET Storage=mtllab; 
-- specify the tablename 
SET Tablename=MonthNameMonthlySales; 
 
-- Using C# UDF  
add file wasb:///Hiveapp.exe; 
 
DROP TABLE IF EXISTS HDILABDB.${hiveconf:Tablename}; 
CREATE TABLE HDILABDB.${hiveconf:Tablename} ROW FORMAT DELIMITED  
FIELDS TERMINATED by '\1' lines TERMINATED by '\n'  
STORED AS TEXTFILE LOCATION 
'wasb://${hiveconf:Container}@${hiveconf:Storage}.blob.core.windows.net/bookstore/HDILABDB.${hiveconf:Tablename}/' 
AS 
SELECT TRANSFORM (month, totalamount) 
USING 'Hiveapp.exe' AS 
(month int, monthname string, sales string) 
FROM HDILABDB.MonthlySales; 
