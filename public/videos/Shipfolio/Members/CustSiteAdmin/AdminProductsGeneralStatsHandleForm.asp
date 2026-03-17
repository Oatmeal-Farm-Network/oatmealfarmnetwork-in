<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>

<!--#Include file="AdminGlobalVariables.asp"-->
<% 

Category1=Request.Form("Category1") 
Category2=Request.Form("Category2") 
Category3=Request.Form("Category3") 
ProdProductID=Request.Form("ProdProductID") 
prodCustomOrder =Request("prodCustomOrder") 
SKU =Request("SKU") 
SalePrice=Request.Form("SalePrice") 
prodPrice=Request.Form("prodPrice") 
ProdQuantityAvailable=Request.Form("ProdQuantityAvailable") 
ProdForSale= Request.form("ProdForSale")

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

	ProdFiberType1=trim(Request.Form( "ProdFiberType1") )
	ProdFiberType2=trim(Request.Form( "ProdFiberType2") )
	ProdFiberType3=trim(Request.Form( "ProdFiberType3") )
	ProdFiberType4=trim(Request.Form( "ProdFiberType4") )
	ProdFiberType5=trim(Request.Form( "ProdFiberType5") )

	prodFiberPercent1=trim(Request.Form( "prodFiberPercent1")) 
	prodFiberPercent2=trim(Request.Form( "prodFiberPercent2") )
	prodFiberPercent3=trim(Request.Form( "prodFiberPercent3") )
	prodFiberPercent4=trim(Request.Form( "prodFiberPercent4") )
	prodFiberPercent5=trim(Request.Form( "prodFiberPercent5") )

prodSize1=trim(Request.Form("prodSize1")) 
prodSize2=trim(Request.Form("prodSize2")) 
prodSize3=trim(Request.Form("prodSize3")) 
prodSize4=trim(Request.Form("prodSize4")) 
prodSize5=trim(Request.Form("prodSize5")) 
prodSize6=trim(Request.Form("prodSize6")) 
prodSize7=trim(Request.Form("prodSize7")) 
prodSize8=trim(Request.Form("prodSize8")) 
prodSize9=trim(Request.Form("prodSize9")) 
prodSize10=trim(Request.Form("prodSize10")) 

Color1=trim(Request.Form("Color1")) 
Color2=trim(Request.Form("Color2")) 
Color3=trim(Request.Form("Color3")) 
Color4=trim(Request.Form("Color4")) 
Color5=trim(Request.Form("Color5")) 
Color6=trim(Request.Form("Color6")) 
Color7=trim(Request.Form("Color7")) 
Color8=trim(Request.Form("Color8")) 
Color9=trim(Request.Form("Color9")) 
Color10=trim(Request.Form("Color10")) 


str1 = prodSize1
str2 = "'"
If InStr(str1,str2) > 0 Then
	prodSize1= Replace(str1,  str2, "''")
End If 

str1 = prodSize1
str2 = "'"
If InStr(str1,str2) > 0 Then
	prodSize1= Replace(str1,  str2, "''")
End If 
str1 = prodSize2
str2 = "'"
If InStr(str1,str2) > 0 Then
	prodSize2= Replace(str1,  str2, "''")
End If 
str1 = prodSize3
str2 = "'"
If InStr(str1,str2) > 0 Then
	prodSize3= Replace(str1,  str2, "''")
End If 
str1 = prodSize4
str2 = "'"
If InStr(str1,str2) > 0 Then
	prodSize4= Replace(str1,  str2, "''")
End If 
str1 = prodSize5
str2 = "'"
If InStr(str1,str2) > 0 Then
	prodSize5= Replace(str1,  str2, "''")
End If 
str1 = prodSize6
str2 = "'"
If InStr(str1,str2) > 0 Then
	prodSize6= Replace(str1,  str2, "''")
End If 
str1 = prodSize7
str2 = "'"
If InStr(str1,str2) > 0 Then
	prodSize7= Replace(str1,  str2, "''")
End If 
str1 = prodSize8
str2 = "'"
If InStr(str1,str2) > 0 Then
	prodSize8= Replace(str1,  str2, "''")
End If 
str1 = prodSize9
str2 = "'"
If InStr(str1,str2) > 0 Then
	prodSize9= Replace(str1,  str2, "''")
End If 

str1 = prodSize10
str2 = "'"
If InStr(str1,str2) > 0 Then
	prodSize10= Replace(str1,  str2, "''")
End If 




str1 = Color1
str2 = "'"
If InStr(str1,str2) > 0 Then
	Color1= Replace(str1,  str2, "''")
End If 

str1 = Color2
str2 = "'"
If InStr(str1,str2) > 0 Then
	Color2= Replace(str1,  str2, "''")
End If 


str1 = Color3
str2 = "'"
If InStr(str1,str2) > 0 Then
	Color3= Replace(str1,  str2, "''")
End If 

str1 = Color4
str2 = "'"
If InStr(str1,str2) > 0 Then
	Color4= Replace(str1,  str2, "''")
End If 

str1 = Color5
str2 = "'"
If InStr(str1,str2) > 0 Then
	Color5= Replace(str1,  str2, "''")
End If 

str1 = Color6
str2 = "'"
If InStr(str1,str2) > 0 Then
	Color6= Replace(str1,  str2, "''")
End If 

str1 = Color7
str2 = "'"
If InStr(str1,str2) > 0 Then
	Color7= Replace(str1,  str2, "''")
End If 


str1 = Color8
str2 = "'"
If InStr(str1,str2) > 0 Then
	Color8= Replace(str1,  str2, "''")
End If 

str1 = Color9
str2 = "'"
If InStr(str1,str2) > 0 Then
	Color9= Replace(str1,  str2, "''")
End If 

str1 = Color10
str2 = "'"
If InStr(str1,str2) > 0 Then
	Color10= Replace(str1,  str2, "''")
End If 






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
	rs.Open sql, conn, 3, 3 
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
if len(SKU) > 0 then
 Query = Query  & " ProdProductID= '" & SKU & "' , "
 end if

if len(ProdAnimalID)> 0 then
Query = Query  & " ProdAnimalID= " & ProdAnimalID & " , "  
else
Query = Query  & " ProdAnimalID= 0 , "  
end if  
  
if len(ProdAnimalID2)> 0 then
Query = Query  & " ProdAnimalID2= " & ProdAnimalID2 & " , "  
else
Query = Query  & " ProdAnimalID2= 0 , "  
end if

if len(ProdAnimalID3)> 0 then
Query = Query  & " ProdAnimalID3= " & ProdAnimalID3 & " , "  
else
Query = Query  & " ProdAnimalID3= 0 , "  
end if

 Query =  Query & "  ProdForSale= " &   ProdForSale & ", "
 if len(SalePrice) > 0 then
Query =  Query & " SalePrice= '" &  SalePrice & "', "
else
Query =  Query & " SalePrice= '0', "
end if
Query =  Query & " prodPrice= '" &  prodPrice & "', "
Query =  Query & " ProdQuantityAvailable=" &  ProdQuantityAvailable & ", "


Query =  Query & "ProdMadeIn= '" &  ProdMadeIn & "', "

Query =  Query & "Color1= '" &  Color1 & "', "
Query =  Query & "Color2= '" &  Color2 & "', "
Query =  Query & "Color3= '" &  Color3 & "', "
Query =  Query & "Color4= '" &  Color4 & "', "
Query =  Query & "Color5= '" &  Color5 & "', "
Query =  Query & "Color6= '" &  Color6 & "', "
Query =  Query & "Color7= '" &  Color7 & "', "
Query =  Query & "Color8= '" &  Color8 & "', "
Query =  Query & "Color9= '" &  Color9 & "', "
Query =  Query & "Color10= '" &  Color10 & "', "

Query =  Query & "prodSize1= '" &  prodSize1 & "', "
Query =  Query & "prodSize2= '" &  prodSize2 & "', "
Query =  Query & "prodSize3= '" &  prodSize3 & "', "
Query =  Query & "prodSize4= '" &  prodSize4 & "', "
Query =  Query & "prodSize5= '" &  prodSize5 & "', "
Query =  Query & "prodSize6= '" &  prodSize6 & "', "
Query =  Query & "prodSize7= '" &  prodSize7 & "', "
Query =  Query & "prodSize8= '" &  prodSize8 & "', "
Query =  Query & "prodSize9= '" &  prodSize9 & "', "
Query =  Query & "prodSize10= '" &  prodSize10 & "', "


Query =  Query & "ProdFiberType1= '" &  ProdFiberType1 & "', "
Query =  Query & "ProdFiberType2=  '" &  ProdFiberType2 & "', "
Query =  Query & "ProdFiberType3=  '" &  ProdFiberType3 & "', "
Query =  Query & "ProdFiberType4=  '" &  ProdFiberType4 & "', "
Query =  Query & "ProdFiberType5=  '" &  ProdFiberType5 & "', "
Query =  Query & "prodFiberPercent1= " &  prodFiberPercent1 & ", " 
Query =  Query & "prodFiberPercent2=  " &  prodFiberPercent2 & ", " 
Query =  Query & "prodFiberPercent3=  " &  prodFiberPercent3 & ", " 
Query =  Query & "prodFiberPercent4=  " &  prodFiberPercent4 & ", " 
Query =  Query & "prodFiberPercent5=  " &  prodFiberPercent5 & ", " 
Query = Query  & " ProdDimensions= '" & ProdDimensions & "' ,"
Query = Query  & " ProdWeight= " & ProdWeight & " "
Query =  Query & " where prodID = " & ProdID & ";" 

response.write(Query)
Conn.Execute(Query) 


   Query =  " Delete * from productCategoriesList where productID = " & ProdID & ";" 
Conn.Execute(Query) 


  
 if len(session("Category1ID")) > 0 then
  Query =  " Insert into productCategoriesList (ProductID, prodCategoryId, prodSubCategoryId)"
  Query =  Query & " Values ('" &  ProdID  & "'," & session("Category1ID") & "," & session("SubCategory1ID") & ")"
  
Conn.Execute(Query) 

  end if 
  
 if len(session("Category2ID")) > 0 and session("SubCategory2ID") > 0 then
  Query =  " Insert into productCategoriesList (ProductID, prodCategoryId, prodSubCategoryId)"
  Query =  Query & " Values (" &  ProdID  & "," & session("Category2ID") & "," & session("SubCategory2ID") & ")"
Conn.Execute(Query) 

  end if 
  
   if len(session("Category3ID")) > 0 and len(session("SubCategory3ID")) > 0 then
  Query =  " Insert into productCategoriesList (ProductID, prodCategoryId, prodSubCategoryId)"
  Query =  Query & " Values ('" &  ProdID  & "'," & session("Category3ID") & "," & session("SubCategory3ID") & ")"
Conn.Execute(Query) 

end if 

Conn.close
set conn=nothing %>

</head>
<body >
<% response.redirect("AdminProductGeneralStatsFrame.asp?ProdID=" & prodID & "&changesmade=True" ) %>


 </Body>
</HTML>