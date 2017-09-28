set hive.execution.engine=mr; 
SELECT  categoryname , 
        SUM(Quantity) AS quantitysold 
FROM    HDILABDB.weblogs 
WHERE   PurchaseType = "Purchased" 
GROUP BY categoryname 
ORDER BY quantitysold DESC; 
