<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
 <base target="_self" />
<!--#Include virtual="/connloa.asp"-->
<% 

Category1=Request.Form("Category1") 
Category2=Request.Form("Category2") 
Category3=Request.Form("Category3") 
ProdProductID=Request.Form("ProdProductID") 
prodCustomOrder =Request("prodCustomOrder") 
SKU =Request("SKU") 

box2ID=Request.Form("box2ID" ) 
	If Len(box2ID) > 0 Then
	else
		box2ID=0
	End If
missingdata = False
missingdataPrice = False
ProdName=trim(request.form("ProdName")) 
response.write("ProdName = " & ProdName )

ProdID=trim(request.form("ProdID")) 
response.write("ProdID= " & ProdID )

str1 = SKU
str2 = "'"
If InStr(str1,str2) > 0 Then
	SKU= Replace(str1,  str2, "''")
End If 

AdType=trim(request.form("AdType"))
ProdPrice =trim(request.form("ProdPrice"))
if len(ProdPrice)< 1 then
missingdata = True
missingdataPrice = True
end if
ProdAnimalID = request.form("ProdAnimalID")
ProdAnimalID2 = request.form("ProdAnimalID2")
ProdAnimalID3 = request.form("ProdAnimalID3")
SalePrice = trim(request.Form("SalePrice"))
ProdQuantityAvailable=trim(request.form("ProdQuantityAvailable"))

ProdColor  =request.form("ProdColor")
ProdStartDate  =request.form("ProdStartDate")
ProdEndDate  =request.form("ProdEndDate")
ProdForSaleY =request.form("ProdForSalex")
response.write("ProdForSaleY = " & ProdForSaleY )
ProdSellStore =trim(request.form("ProdSellStore"))


ProdMadeIn=trim(Request.Form( "ProdMadeIn"))

ProdFiberType1=trim(Request.Form("ProdFiberType1"))
ProdFiberType2=trim(Request.Form("ProdFiberType2"))
ProdFiberType3=trim(Request.Form("ProdFiberType3"))
ProdFiberType4=trim(Request.Form("ProdFiberType4"))
ProdFiberType5=trim(Request.Form("ProdFiberType5"))
ProdFiberType6=trim(Request.Form("ProdFiberType6"))
ProdFiberType7=trim(Request.Form("ProdFiberType7"))
ProdFiberType8=trim(Request.Form("ProdFiberType8"))
ProdFiberType9=trim(Request.Form("ProdFiberType9"))
ProdFiberType10=trim(Request.Form("ProdFiberType10"))
ProdFiberType11=trim(Request.Form("ProdFiberType11"))
ProdFiberType12=trim(Request.Form("ProdFiberType12"))
ProdFiberType13=trim(Request.Form("ProdFiberType13"))
ProdFiberType14=trim(Request.Form("ProdFiberType14"))
ProdFiberType15=trim(Request.Form("ProdFiberType15"))

prodFiberPercent1=trim(Request.Form("prodFiberPercent1")) 
prodFiberPercent2=trim(Request.Form("prodFiberPercent2"))
prodFiberPercent3=trim(Request.Form("prodFiberPercent3"))
prodFiberPercent4=trim(Request.Form("prodFiberPercent4"))
prodFiberPercent5=trim(Request.Form("prodFiberPercent5"))
prodFiberPercent6=trim(Request.Form("prodFiberPercent6")) 
prodFiberPercent7=trim(Request.Form("prodFiberPercent7"))
prodFiberPercent8=trim(Request.Form("prodFiberPercent8"))
prodFiberPercent9=trim(Request.Form("prodFiberPercent9"))
prodFiberPercent10=trim(Request.Form("prodFiberPercent10"))
prodFiberPercent11=trim(Request.Form("prodFiberPercent11"))
prodFiberPercent12=trim(Request.Form("prodFiberPercent12"))
prodFiberPercent13=trim(Request.Form("prodFiberPercent13"))
prodFiberPercent14=trim(Request.Form("prodFiberPercent14"))
prodFiberPercent15=trim(Request.Form("prodFiberPercent15"))

ProdDimensions =request.form("ProdDimensions")

str1 = ProdDimensions
str2 = "'"
If InStr(str1,str2) > 0 Then
	ProdDimensions= Replace(str1,  str2, "''")
End If 


ProdWeight =request.form("ProdWeight")
If Len(ProdWeight) < 1 Then
	ProdWeight = 0
End if


str1 = ProdName
str2 = """"
If InStr(str1,str2) > 0 Then
	ProdName= Replace(str1,  str2, "''")
End If 

str1 = ProdName
str2 = "'"
If InStr(str1,str2) > 0 Then
	ProdName= Replace(str1,  str2, "''")
End If 

str1 = ProductID
str2 = "'"
If InStr(str1,str2) > 0 Then
	ProductID= Replace(str1,  str2, "''")
End If 

str1 = prodMadeIn
	str2 = "'"
	If InStr(str1,str2) > 0 Then
		prodMadeIn= Replace(str1, "'", "''")
	End If


	str1 = ProdFiberType1
	str2 = "'"
	If InStr(str1,str2) > 0 Then
		ProdFiberType1= Replace(str1, "'", "''")
	End If

	str1 = ProdFiberType2
	str2 = "'"
	If InStr(str1,str2) > 0 Then
		ProdFiberType2= Replace(str1, "'", "''")
	End If


	str1 = ProdFiberType3
	str2 = "'"
	If InStr(str1,str2) > 0 Then
		ProdFiberType3= Replace(str1, "'", "''")
	End If


	str1 = ProdFiberType4
	str2 = "'"
	If InStr(str1,str2) > 0 Then
		ProdFiberType4= Replace(str1, "'", "''")
	End If

	str1 = ProdFiberType5
	str2 = "'"
	If InStr(str1,str2) > 0 Then
		ProdFiberType5= Replace(str1, "'", "''")
	End If

If Len(prodweight) > 0  Then
Else
  prodweight = "0"
 End If
 
If  ProdWeight = " " Then
  ProdWeight = "0"
 End If


 If Len(prodFiberPercent1) > 0 Then
Else
  prodFiberPercent1 = "0"
 End If
 

 If Len(prodFiberPercent2) > 0 Then
Else
  prodFiberPercent2 = "0"
 End If
 
 If Len(prodFiberPercent3) > 0 Then
Else
  prodFiberPercent3 = "0"
 End If
 
 If Len(prodFiberPercent4) > 0 Then
Else
  prodFiberPercent4 = "0"
 End If
 
 If Len(prodFiberPercent5) > 0 Then
Else
  prodFiberPercent5 = "0"
 End If


str1 = ProdPrice
str2 = "'"
If InStr(str1,str2) > 0 Then
	ProdPrice= Replace(str1,  str2, "")
End If 

str1 = ProdPrice
str2 = ","
If InStr(str1,str2) > 0 Then
	ProdPrice= Replace(str1,  str2, "")
End If 


str1 = SalePrice
str2 = "'"
If InStr(str1,str2) > 0 Then
	SalePrice= Replace(str1,  str2, "")
End If 

str1 = SalePrice
str2 = ","
If InStr(str1,str2) > 0 Then
	SalePrice= Replace(str1,  str2, "")
End If 


CategoryID=Request.Form("box1") 
	SubCategoryIDCount=Request.Form("box2ID" ) 
	
If SubCategoryIDCount > 0 Then
Else
SubCategoryID = 0 
End If 

If Len(ProdQuantityAvailable) > 0 Then
Else
	ProdQuantityAvailable = 0
End If 
	


If SubCategoryIDCount > 0 then

	sql = "select * from SFSubCategories where CategoryID = '" &  CategoryID & "' Order by SubcategoryName"
	Set rs = Server.CreateObject("ADODB.Recordset")
	'Response.write(sql)
	rs.Open sql, connloa, 3, 3 
	CatCounter= 0
	For CatCounter = 0 To (SubCategoryIDCount -1 )
		If Not( rs. eof )Then
		SubCategoryID = rs("subcatId")
		'Response.write("SubCategoryID=")
		'Response.write(SubCategoryID)
		
			rs.movenext
		End If
	Next
	rs.MovePrevious
		SubCategoryID = rs("subcatId")
		'Response.write("SubCategoryID=")
		'Response.write(SubCategoryID)

	
End If 

Query =  " UPDATE sfProducts Set "
if len(ProdName) >  0 then
  Query = Query  & " ProdName= '" & ProdName & "', "
end if

 Query = Query  & " ProdProductID= '" & SKU & "' , "


if len(ProdAnimalID)> 0 then
Query = Query  & " ProdAnimalID= " & ProdAnimalID & " , "  
else
Query = Query  & " ProdAnimalID= 0 , "  
end if  
  
 

Query =  Query & "ProdFiberType1= '" &  ProdFiberType1 & "',"
Query =  Query & "ProdFiberType2=  '" &  ProdFiberType2 & "',"
Query =  Query & "ProdFiberType3=  '" &  ProdFiberType3 & "',"
Query =  Query & "ProdFiberType4=  '" &  ProdFiberType4 & "',"
Query =  Query & "ProdFiberType5=  '" &  ProdFiberType5 & "',"

if len(prodFiberPercent1) > 0 then
Query =  Query & "prodFiberPercent1= " &  prodFiberPercent1 & "," 
end if
if len(prodFiberPercent2) > 0 then
Query =  Query & "prodFiberPercent2=  " &  prodFiberPercent2 & "," 
end if
if len(prodFiberPercent3) > 0 then
Query =  Query & "prodFiberPercent3=  " &  prodFiberPercent3 & "," 
end if
if len(prodFiberPercent4) > 0 then
Query =  Query & "prodFiberPercent4=  " &  prodFiberPercent4 & "," 
end if

if len(prodFiberPercent5) > 0 then
Query =  Query & "prodFiberPercent5=  " &  prodFiberPercent5 & "," 
end if


'Query = Query  & " ProdDimensions= '" & ProdDimensions & "' ,"
'Query = Query  & " ProdWeight= " & ProdWeight & " "

Query =  Query & "ProdMadeIn= '" &  ProdMadeIn & "' "

Query =  Query & " where prodID = " & ProdID & " and peopleid = " & session("AIID") & " ;" 

response.write(Query)
connloa.Execute(Query) 


   Query =  " Delete from productCategoriesList where productID = " & ProdID & ";" 
connloa.Execute(Query) 

   if len(session("Category3ID")) > 0 and len(session("SubCategory3ID")) > 0 then
  Query =  " Insert into productCategoriesList (ProductID, prodCategoryId, prodSubCategoryId)"
  Query =  Query & " Values ('" &  ProdID  & "'," & session("Category3ID") & "," & session("SubCategory3ID") & ")"
connloa.Execute(Query) 

end if 

 if len(session("Category2ID")) > 0 and session("SubCategory2ID") > 0 then
  Query =  " Insert into productCategoriesList (ProductID, prodCategoryId, prodSubCategoryId)"
  Query =  Query & " Values (" &  ProdID  & "," & session("Category2ID") & "," & session("SubCategory2ID") & ")"
connloa.Execute(Query) 

  end if 
  
 if len(session("Category1ID")) > 0 then
  Query =  " Insert into productCategoriesList (ProductID, prodCategoryId, prodSubCategoryId)"
  Query =  Query & " Values ('" &  ProdID  & "'," & session("Category1ID") & "," & session("SubCategory1ID") & ")"
  
connloa.Execute(Query) 

  end if 
  

  


connloa.close
set connloa=nothing %>

</head>
<body >
<% response.redirect("MembersProductGeneralStatsFrame.asp?ProdID=" & prodID & "&changesmade=True" ) %>


 </Body>
</HTML>