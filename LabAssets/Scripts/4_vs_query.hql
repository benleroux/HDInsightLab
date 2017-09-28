Select categoryname,Sum(Quantity) As quantitysold FROM HDILABDB.weblogs 
WHERE PurchaseType="Purchased" GROUP BY categoryname ORDER BY quantitysold Desc;
