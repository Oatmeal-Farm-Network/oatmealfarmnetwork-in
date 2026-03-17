<%
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

str1 = SourceProdDimensions
str2 = "'"
If InStr(str1,str2) > 0 Then
SourceProdDimensions= Replace(str1, "'", "''")
End If

If SourceSubCategoryID > 0 Then
Else
   SourceSubCategoryID = 0
 End If


Query =  "INSERT INTO sfProducts(peopleID,  prodMadeIn , prodSalePrice,  prodName, proddescription,  prodImageSmallPath, prodImageLargePath, prodForSale, prodPrice,  prodDimensions, ProdQuantityAvailable, "
if len(SourceprodFiberPercent1 ) > 0 then
Query =  Query &   " prodFiberPercent1 ,"
end if
if len(SourceprodFiberPercent2 ) > 0 then
Query =  Query &   " prodFiberPercent2 ,"
end if
if len(SourceprodFiberPercent3 ) > 0 then
Query =  Query &   " prodFiberPercent3 ,"
end if
if len(SourceprodFiberPercent4 ) > 0 then
Query =  Query &   " prodFiberPercent4 ,"
end if
if len(SourceprodFiberPercent5 ) > 0 then
Query =  Query &   " prodFiberPercent5 ,"
end if
Query =  Query & " ProdFiberType1, ProdFiberType2, ProdFiberType3, ProdFiberType4, ProdFiberType5)" 
Query =  Query & " Values (" &  session("AIID") & " ,"
Query =  Query &   " '" & sourceProdMadeIn   & "' ,"
Query =  Query &   " '" & sourceSalePrice  & "' ,"
Query =  Query &   " '" & SourceProdName   & "' ,"
Query =  Query &   " '" &  SourceProdDescription   & "' ,"
Query =  Query &   " '" & SourceprodImageSmallPath   & "' ,"
Query =  Query &   " '" & SourceprodImageLargePath   & "', "
Query =  Query &   " " & SourceProdForSale   & " ,"
Query =  Query &   " '" & SourceProdPrice  & "' ,"
Query =  Query &   " '" & SourceProdDimensions   & "' ,"

if len(SourceProdQuantityAvailable) > 0 then
else
SourceProdQuantityAvailable = 1
end if

Query =  Query &   " " & SourceProdQuantityAvailable   & " ,"
if len(SourceprodFiberPercent1 ) > 0 then
Query =  Query &   " " & SourceprodFiberPercent1   & " ,"
end if
if len(SourceprodFiberPercent2 ) > 0 then
Query =  Query &   " " & SourceprodFiberPercent2   & " ,"
end if
if len(SourceprodFiberPercent3 ) > 0 then
Query =  Query &   " " & SourceprodFiberPercent3   & " ,"
end if
if len(SourceprodFiberPercent4 ) > 0 then
Query =  Query &   " " & SourceprodFiberPercent4   & " ,"
end if
if len(SourceprodFiberPercent5 ) > 0 then
Query =  Query &   " " & SourceprodFiberPercent5   & " ,"
end if

Query =  Query &   " '" & SourceProdFiberType1  & "' ,"
Query =  Query &   " '" & SourceProdFiberType2  & "' ,"
Query =  Query &   " '" & SourceProdFiberType3  & "' ,"
Query =  Query &   " '" & SourceProdFiberType4  & "' ,"
Query =  Query &   " '" & SourceProdFiberType5  & "'  )" 
'response.write(Query)
ConnLOA.Execute(Query) 
ConnLOA.Close
Set connLOA = Nothing %>
<!--#Include virtual="/ConnLOA.asp"-->

<% sql = "select * from sfProducts where  PeopleID= " &  session("AIID") & " and (prodName = '" &   SourceprodName  & "') ;" 
'response.write(sql)
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, ConnLOA, 3, 3   
If Not rs.eof Then
SourceLOAProductID  = rs("prodID")
End if
rs.close


Query =  "INSERT INTO ProductsPhotos (ID, productImage1, productImage2, productImage3, productImage4, productImage5, productImage6, productImage7, productImage8 )" 
Query =  Query & " Values (" &  SourceLOAProductID & " ,"
Query =  Query &   " '" & SourceproductImage1 & "' ,"
Query =  Query &   " '" & SourceproductImage2 & "' ,"
Query =  Query &   " '" & SourceproductImage3 & "' ,"
Query =  Query &   " '" & SourceproductImage4 & "' ,"
Query =  Query &   " '" & SourceproductImage5 & "' ,"
Query =  Query &   " '" & SourceproductImage6 & "' ,"
Query =  Query &   " '" & SourceproductImage7 & "' ,"
Query =  Query &   " '" & SourceproductImage8  & "' )" 
'response.write(Query)
ConnLOA.Execute(Query) 

if SourceCategoryId > 0 then
else 
SourceCategoryId = 0
end if

Query= "Insert Into ProductCategoriesList (ProductID,  prodCategoryId, prodSubCategoryId)"
Query =  Query & " Values (" &  SourceLOAProductID  & " ,"
Query =  Query &   " '" & SourceCategory1Id  & "' ,"
Query =  Query &   " '" & SourceSubCategory1Id  & "' )" 
'response.write(Query)
ConnLOA.Execute(Query) 

ConnLOA.Close
Set connLOA = Nothing
Administration= True
Transfer = False
%>
<!--#Include virtual="/Conn.asp"--> 
<%
Query =  " UPDATE sfProducts Set  LOAproductID= " & SourceLOAProductID  & " "
Query =  Query & " where prodID = " & SourceProdID & ";" 
'response.write("Query=" & Query )
Conn.Execute(Query)
Conn.Close
set Conn = nothing
%>