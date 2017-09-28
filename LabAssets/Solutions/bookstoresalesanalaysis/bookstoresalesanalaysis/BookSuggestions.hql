-- Customers who browsed x book also browsed n other books 
-- Replace yourcontainername with the container created in step n 
SET Container=hdi; 
-- specify the storage name if you have created your own HDInsight cluster 
SET Storage=mtllab; 
-- specify the tablename 
SET Tablename=BookSuggestions; 
 
DROP TABLE IF EXISTS HDILABDB.${hiveconf:Tablename}; 
CREATE TABLE HDILABDB.${hiveconf:Tablename} ROW FORMAT DELIMITED  
FIELDS TERMINATED by '\1' lines TERMINATED by '\n'  
STORED AS TEXTFILE LOCATION 
'wasb://${hiveconf:Container}@${hiveconf:Storage}.blob.core.windows.net/bookstore/HDILABDB${hiveconf:Tablename}/' 
AS  
With Customerwhobrowsedbookx as 
( 
 	SELECT distinct customerid   	from HDILABDB.weblogs 
 	WHERE PurchaseType="Browsed"  	and BookName="THE BOOK OF WITNESSES" 
) 
SELECT w.BookName,count(*) as cnt from HDILABDB.weblogs w  
JOIN Customerwhobrowsedbookx cte on w.CustomerId=cte.CustomerId  WHERE w.PurchaseType="Browsed" 
AND w.BookName Not in ("THE BOOK OF WITNESSES") group by w.bookname having count(*)>10 order by cnt desc 
LIMIT 3; 
