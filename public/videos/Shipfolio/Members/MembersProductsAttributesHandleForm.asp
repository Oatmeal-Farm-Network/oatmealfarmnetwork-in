<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<HEAD>
 <base target="_self" />
<link rel="stylesheet" type="text/css" href="/style.css">
<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  >
<!--#Include file="membersglobalvariables.asp"-->
<%

ProdID=Request.Form("ProdID") 
prodPurchasemethod = request.querystring("prodPurchasemethod")
PrimaryAttribute=Request.Form("PrimaryAttribute")
DimensionTitle=Request.Form("DimensionTitle")
ProdPrice =trim(request.form("ProdPrice"))
ProdSalePrice = trim(request.Form("ProdSalePrice"))

ProdForSaleY =request.form("ProdForSalex")
ProdSellStore =trim(request.form("ProdSellStore"))
ProdQuantityAvailable =trim(request.form("ProdQuantityAvailable"))
prodCustomOrder = request.form("prodCustomOrder")

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

  Query =  " UPDATE sfProducts Set "
  if len(ProdPrice) > 0 then  
  Query = Query  & " ProdPrice= '" & ProdPrice & "', "
  else
    Query = Query  & " ProdPrice= NULL , "
  end if

  if len(prodSalePrice) > 0 then
 Query = Query  & " prodSalePrice= '" & prodSalePrice & "' , "
 else
  Query = Query  & " prodSalePrice= '' , "
 end if




if len(ProdQuantityAvailable) > 0 then
Query = Query  & " ProdQuantityAvailable= " & ProdQuantityAvailable & " ,"
else
Query = Query  & " ProdQuantityAvailable= 1 ,"
end if
if len(prodCustomOrder) > 0 then
Query = Query  & " prodCustomOrder= " &   prodCustomOrder & " "
else
Query = Query  & " prodCustomOrder= 0 "
end if
Query =  Query & " where prodID = " & ProdID & ";" 

response.write(Query)
Conn.Execute(Query) 



TotalCount= Request.Form("TotalCount")
TotalCount = CInt(TotalCount) + 1
rowcount = 1

dim attrID(1000)
dim Color(1000)
dim AttrpriceChange(1000)
dim AttrQuantityAvailable(1000)
dim Dimension(1000)


while (rowcount < TotalCount )
attrIDcount = "attrID(" & rowcount & ")"
attrID(rowcount)=Request.Form(attrIDcount)

Colorcount = "Color(" & rowcount & ")"
Color(rowcount)=Request.Form(Colorcount)

AttrpriceChangecount = "AttrpriceChange(" & rowcount & ")"
AttrpriceChange(rowcount)=Request.Form(AttrpriceChangecount)

AttrQuantityAvailablecount = "AttrQuantityAvailable(" & rowcount & ")"
AttrQuantityAvailable(rowcount)=Request.Form(AttrQuantityAvailablecount)

Dimensioncount = "Dimension(" & rowcount & ")"
Dimension(rowcount)=Request.Form(Dimensioncount)



rowcount = rowcount +1
Wend

 rowcount =1




sql = "select count(*) as recordcount from SFAttributePrimary where ProdId = " & ProdId 

rs.Open sql, conn, 3, 3
if rs.eof then
   PrimaryFound = false
else
primaryrecordcount = rs("recordcount")
response.write("primaryrecordcount=" & primaryrecordcount )
if clng(primaryrecordcount) > 0 then
PrimaryFound = True
else
PrimaryFound = False
end if

end if
rs.close

response.write("PrimaryFound=" & PrimaryFound )
if PrimaryFound = True then
Query =  " UPDATE SFAttributePrimary Set PrimaryAttribute = '" &  PrimaryAttribute & "' " 
Query =  Query & " where ProdID = " & ProdID & ";" 
response.write("Query=" & Query )
Conn.Execute(Query) 
else
Query =  "Insert into SFAttributePrimary (ProdId, PrimaryAttribute)  " 
Query =  Query & " Values ( " & ProdId & ", '" & PrimaryAttribute & "')"
Conn.Execute(Query) 
response.write("Query=" & Query )
end if





while (rowcount < TotalCount )
'response.write("AttrQuantityAvailable(rowcount)=" & AttrQuantityAvailable(rowcount))

'If Len(AttrQuantityAvailable(rowcount)) < 2 Then
'	AttrQuantityAvailable(rowcount) = 0
'End if


str1 = Color(rowcount)
str2 = "'"
If InStr(str1,str2) > 0 Then
	Color(rowcount)= Replace(str1, "'", "''")
End If

str1 = Color(rowcount)
str2 = """"
If InStr(str1,str2) > 0 Then
Color(rowcount)= Replace(str1, """", "''''")
End If


str1 = Dimension(rowcount)
str2 = "'"
If InStr(str1,str2) > 0 Then
Dimension(rowcount)= Replace(str1, "'", "''")
End If


str1 = Dimension(rowcount)
str2 = """"
If InStr(str1,str2) > 0 Then
Dimension(rowcount)= Replace(str1, """", "''''")
End If










sql = "select count(*) as recordcount from SFAttributeTitles where ProdId = " & ProdId 
rs.Open sql, conn, 3, 3   
TotalAttributeTitles = clng(rs("RecordCount"))
rs.close


'response.write("TotalAttributeTitles=" & TotalAttributeTitles )
if TotalAttributeTitles > 0 then
Query =  " UPDATE SFAttributeTitles Set DimensionTitle = '" &  DimensionTitle & "' " 
Query =  Query & " where ProdID = " & ProdID & ";" 
'response.write("Query=" & Query )
Conn.Execute(Query) 
else
Query =  "Insert into SFAttributeTitles (ProdId, DimensionTitle)  " 
Query =  Query & " Values ( " & ProdId & ", '" & DimensionTitle & "')"
Conn.Execute(Query) 
'response.write("Query=" & Query )
end if

if len(attrID(rowcount)) > 0 then
Query =  " UPDATE SFAttributes Set Color = '" &  Color(rowcount) & "', " 
if len(trim(AttrpriceChange(rowcount))) > 0 then
Query =  Query & " AttrpriceChange = " &  AttrpriceChange(rowcount) & "," 
else
Query =  Query & " AttrpriceChange = NULL," 
end if
if len(AttrQuantityAvailable(rowcount))> 0 then
Query =  Query & " AttrQuantityAvailable = " & AttrQuantityAvailable(rowcount) & "," 
else
Query =  Query & " AttrQuantityAvailable =NULL ," 
end if
Query =  Query & " Dimension = '" & Dimension(rowcount) & "'," 
Query =  Query & " ProdID = " & ProdID & "" 
Query =  Query & " where attrID = " & attrID(rowcount) & ";" 
'response.write("Query=" & Query )
Conn.Execute(Query) 
end if

rowcount= rowcount +1
Wend


sql = "select count(*) as recordcount from sfattributes where ProdId = '" & ProdId & "' "
rs.Open sql, conn, 3, 3   
TotalRecordcount = clng(rs("RecordCount"))
rs.close

sql = "select count(*) as RecordCount from sfattributes where ProdId = '" & ProdId & "' and (len(Color)> 0 or len(AttrpriceChange) > 0 or  len(Dimension) > 0 ) "
response.write("sql=" & sql )
rs.Open sql, conn, 3, 3   
filledRecordcount = clng(rs("RecordCount"))

rs.close

'response.write("filledRecordcount =" & filledRecordcount  )
'response.write("TotalRecordcount =" & TotalRecordcount  )

if filledRecordcount > (TotalRecordcount - 7) then

Query =  "Insert into sfattributes (ProdId)  " 
Query =  Query & " Values ( " & ProdId & ")"
Conn.Execute(Query) 
Conn.Execute(Query) 

end if


Conn.Close
Set Conn = Nothing  

'response.write("prodPurchasemethod=" & prodPurchasemethod )

response.redirect("membersProductsAttributeValuesFrame.asp?ProdID=" & ProdID & "&prodPurchasemethod=" & prodPurchasemethod & "&PrimaryAttribute=" & PrimaryAttribute & "&DimensionTitle=" & DimensionTitle & "&screenwidth=" & Screenwidth -250 & "&changesmade=True")
%>
 </Body>
</HTML>