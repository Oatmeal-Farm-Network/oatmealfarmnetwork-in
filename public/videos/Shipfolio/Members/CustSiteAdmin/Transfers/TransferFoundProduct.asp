<%


if SourceProdForSale = "True" then
SourceProdForSale = 1
else
SourceProdForSale = 0
end if

str1 = SourceprodName
str2 = "'"
If InStr(str1,str2) > 0 Then
	prodName= Replace(str1, "'", "''")
End If

str1 = SourceProdDescription
str2 = "'"
If InStr(str1,str2) > 0 Then
	SourceProdDescription= Replace(str1, "'", "''")
End If

Query =  "Delete From  ProductCategoriesList where productID = " & prodlID & ";" 
ConnLOA.Execute(Query) 

if len(SourceCategory1ID) > 0 and len(SourceSubCategory1Id) > 0 then
 Query= "Insert Into ProductCategoriesList (ProductID,  prodCategoryId, prodSubCategoryId)"
Query =  Query & " Values (" &  SourceLOAProductID & " ,"
Query =  Query &   " " & SourceCategory1Id  & " ,"
Query =  Query &   " '" & SourceSubCategory1Id  & "' )" 
ConnLOA.Execute(Query) 
end if

if len(SourceCategory2ID) > 0 and len(SourceSubCategory2Id) > 0 then
 Query= "Insert Into ProductCategoriesList (ProductID,  prodCategoryId, prodSubCategoryId)"
Query =  Query & " Values (" &  SourceLOAProductID & " ,"
Query =  Query &   " " & SourceCategory2Id  & " ,"
Query =  Query &   " " & SourceSubCategory2Id  & " )" 
'response.write("Query=" & Query)
ConnLOA.Execute(Query) 
end if

if len(SourceCategory3ID) > 0 and len(SourceSubCategory3Id) > 0 then
 Query= "Insert Into ProductCategoriesList (ProductID,  prodCategoryId, prodSubCategoryId)"
Query =  Query & " Values (" &  SourceLOAProductID & " ,"
Query =  Query &   " " & SourceCategory3Id  & " ,"
Query =  Query &   " " & SourceSubCategory3Id  & " )" 
ConnLOA.Execute(Query) 
end if

if len(SourceProdQuantityAvailable) > 0 then
else
SourceProdQuantityAvailable = 1
end if


Query =  " UPDATE sfproducts Set ProdMadeIn  = '" &  ProdMadeIn     & "' ,"
if len(SourceCategory1ID) > 0 then
Query =  Query & " ProdCategoryID= '" &  SourceCategory1ID  & "' ,"
end if


if len(SourceProductID) > 0 then
Query =  Query & " ProdProductID= '" &  SourceProductID   & "' ,"
end if


if len( SourceSubCategory1ID) > 0 then
Query =  Query & " prodSubCategoryId= " &  SourceSubCategory1ID   & " ,"
end if
Query =  Query & " prodName = '" &   SourceProdName   & "' ,"
Query =  Query & " prodDescription = '" &  SourceProdDescription   & "' ,"
Query =  Query & " prodImageSmallPath = '" &  SourceprodImageLargePath   & "' ,"
Query =  Query & " prodImageLargePath = '" &  SourceprodImageLargePath   & "', "
Query =  Query & " prodForSale = " &   SourceProdForSale   & " ,"
Query =  Query & " prodPrice = " & SourceProdPrice  & " ,"
if len(SourceSalePrice) > 0 then
Query =  Query & " prodSalePrice = '" & sourceSalePrice & "' ,"
end if
Query =  Query & " prodDimensions = '" &  SourceProdDimensions   & "' ,"
Query =  Query & " ProdQuantityAvailable = " &  SourceProdQuantityAvailable   & " ,"

 if len(SourceprodFiberPercent1 ) > 0 then
Query =  Query & " prodFiberPercent1= '" &  SourceprodFiberPercent1  & "' ,"
end if
 if len(SourceprodFiberPercent2 ) > 0 then
Query =  Query & " prodFiberPercent2= '" &  SourceprodFiberPercent2  & "' ,"
end if
 if len(SourceprodFiberPercent3 ) > 0 then
Query =  Query & " prodFiberPercent3= '" &  SourceprodFiberPercent3  & "' ,"
end if
 if len(SourceprodFiberPercent4 ) > 0 then
Query =  Query & " prodFiberPercent4= '" &  SourceprodFiberPercent4  & "' ,"
end if
 if len(SourceprodFiberPercent5 ) > 0 then
Query =  Query & " prodFiberPercent5= '" &  SourceprodFiberPercent5  & "' ,"
end if
Query =  Query & " ProdFiberType1= '" &   ProdFiberType1  & "' ,"
 Query =  Query & " ProdFiberType2= '" &   ProdFiberType2  & "' ,"
Query =  Query & " ProdFiberType3= '" &   ProdFiberType3  & "' ,"
Query =  Query & " ProdFiberType4= '" &   ProdFiberType4  & "' ,"
Query =  Query & " ProdFiberType5= '" &   ProdFiberType5  & "' "

Query =  Query & " where prodID = " & prodlID & ";" 
'response.write(Query)	
ConnLOA.Execute(Query) 

on error resume next
	Query =  " UPDATE ProductsPhotos Set productImage1 = '" &  SourceProductImage1   & "' "
	Query =  Query & " where ID = " & prodlID & ";" 
	
ConnLOA.Execute(Query) 

	Query =  " UPDATE ProductsPhotos Set productImage2 = '" &  SourceProductImage2   & "' "
	Query =  Query & " where ID = " & prodlID & ";" 



	Query =  " UPDATE ProductsPhotos Set productImage3 = '" &  SourceProductImage3   & "' "
	Query =  Query & " where ID = " & prodlID & ";" 

ConnLOA.Execute(Query) 


	Query =  " UPDATE ProductsPhotos Set productImage4 = '" &  SourceProductImage4   & "' "
	Query =  Query & " where ID = " & prodlID & ";" 
ConnLOA.Execute(Query) 


	Query =  " UPDATE ProductsPhotos Set productImage5 = '" &  SourceProductImage5   & "' "
	Query =  Query & " where ID = " & prodlID & ";" 

ConnLOA.Execute(Query) 


	Query =  " UPDATE ProductsPhotos Set productImage6 = '" &  SourceProductImage6   & "' "
	Query =  Query & " where ID = " & prodlID & ";" 
	
ConnLOA.Execute(Query) 


	Query =  " UPDATE ProductsPhotos Set productImage7 = '" &  SourceProductImage7   & "' "
	Query =  Query & " where ID = " & prodlID & ";" 
	
ConnLOA.Execute(Query) 

	Query =  " UPDATE ProductsPhotos Set productImage8 = '" &  SourceProductImage8   & "' "
	Query =  Query & " where ID = " & prodlID & ";" 
	
ConnLOA.Execute(Query) 

'For x = 0 to shippingtotal
'if len(ShippingCost1Array(x)) > 0 or len(ShippingCost2Array(x)) > 0 or len(ShippingToCountryArray(x)) > 0 then
'Query =  " UPDATE sfShipping Set  "
'if len(ShippingCost1Array(x)) > 0 then
'Query =  Query & " ShippingCost1 = " &  ShippingCost1Array(x)  & ", "
'end if
'if len(ShippingCost2Array(x)) > 0 then
'Query =  Query & " ShippingCost2 = " &  ShippingCost2Array(x)  & ", "
'end if
'Query =  Query & " ShippingToCountry = '" &  ShippingToCountryArray(x) & "' "
'Query =  Query & " where ProdID = " & prodlID & ";" 
'response.write("Query=" & Query )
'ConnLOA.Execute(Query) 
'end if
'next

ConnLOA.Close
%>
