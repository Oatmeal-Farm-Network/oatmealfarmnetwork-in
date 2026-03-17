<!DOCTYPE HTML>
<HTML>
<HEAD>
<!--#Include file="membersGlobalvariables.asp"--> 
</HEAD>
<% if mobiledevice = True  then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
<% end if %>
<!--#Include file="membersHeader.asp"--> 
<%
Dim TotalCount
dim	rowcount


	 Dim ID(10000) 
	Dim ProdName(10000)
	 Dim AdType(10000)
		 Dim CategoryID(10000)
	 Dim ProdPrice(10000) 
	 Dim ProdQuantityAvailable(10000)
	 Dim ProdCity(10000) 
	 Dim ProdState(10000)
	 Dim ProdZip(10000) 
	 Dim ProdPartofTown(10000)
	 Dim ProdYear(10000) 
	 Dim ProdMake(10000) 
	 Dim ProdModel(10000) 
	 Dim ProdCondition(10000) 
	 Dim ProdColor(10000)  
	 Dim ProdStartDate(10000)  
	 Dim ProdEndDate(10000)  
	 	 Dim ProdWeight(10000)  





TotalCount= Request.Form("TotalCount")
TotalCount = CInt(TotalCount)
'rowcount = CInt(rowcount)
rowcount = 1

while (rowcount < TotalCount)
    IDcount = "ID(" & rowcount & ")"
	ProdNamecount = "ProdName(" & rowcount & ")"
	CategoryIDcount = "CategoryID(" & rowcount & ")"
	AdTypecount = "AdType(" & rowcount & ")"
	ProdPricecount = "ProdPrice(" & rowcount & ")"
	ProdQuantityAvailablecount = "ProdQuantityAvailable(" & rowcount & ")"
	
	ProdColorcount = "ProdColor(" & rowcount & ")"
	Prodweightcount = "Prodweight(" & rowcount & ")"

	ID(rowcount)=Request.Form(IDcount) 
	ProdName(rowcount)=Request.Form(ProdNamecount) 
	CategoryID(rowcount)=Request.Form(CategoryIDcount) 
	AdType(rowcount)=Request.Form(AdTypecount) 
	ProdPrice(rowcount)=Request.Form(ProdPricecount) 
	ProdColor(rowcount)=Request.Form(ProdColorcount)
	ProdWeight(rowcount)=Request.Form(ProdWeightcount)
ProdQuantityAvailable(rowcount)=Request.Form(ProdQuantityAvailablecount)
	rowcount = rowcount +1

Wend

 rowcount =1

while (rowcount < TotalCount)

str1 = ProdName(rowcount)
str2 = "'"
If InStr(str1,str2) > 0 Then
	ProdName(rowcount)= Replace(str1, "'", "''")
End If

str1 = ProdColor(rowcount)
str2 = "'"
If InStr(str1,str2) > 0 Then
	ProdColor(rowcount)= Replace(str1, "'", "''")
End If

str1 = ProdCondition(rowcount)
str2 = "'"
If InStr(str1,str2) > 0 Then
	ProdCondition(rowcount)= Replace(str1, "'", "''")
End If

str1 = ProdQuantityAvailable(rowcount)
str2 = "'"
If InStr(str1,str2) > 0 Then
	ProdQuantityAvailable(rowcount)= Replace(str1, "'", "''")
End If

str1 = ProdZip(rowcount)
str2 = "'"
If InStr(str1,str2) > 0 Then
	ProdZip(rowcount)= Replace(str1, "'", "''")
End If

str1 = ProdPartofTown (rowcount)
str2 = "'"
If InStr(str1,str2) > 0 Then
	ProdPartofTown (rowcount)= Replace(str1, "'", "''")
End If

str1 = ProdCity (rowcount)
str2 = "'"
If InStr(str1,str2) > 0 Then
	ProdCity (rowcount)= Replace(str1, "'", "''")
End If

if ProdZip(rowcount) = "" then
	ProdZip(rowcount) = "0"
end If

if ProdPartofTown(rowcount) = "" then
	ProdPartofTown(rowcount) = "0"
end if
If Len(ProdQuantityAvailable(rowcount)) < 1 Then
	ProdQuantityAvailable(rowcount) = 0
End if

If Len( Prodweight(rowcount))< 1 Then
   Prodweight(rowcount) = 0
End If

Query =  " UPDATE sfProducts Set ProdName = '" &  ProdName(rowcount) & "', " 



Query =  Query & " ProdPrice = " &  ProdPrice(rowcount) & "," 
Query =  Query & " Prodweight = " &  Prodweight(rowcount) & "," 
Query =  Query & " ProdQuantityAvailable = "  &  ProdQuantityAvailable(rowcount) & "" 
    Query =  Query & " where ProdID = '" & ID(rowcount) & "';" 


response.write(Query)
Dim DataConnection, cmdDC, RecordSet
Dim RecordToEdit, Updated
Set DataConnection = Server.CreateObject("ADODB.Connection")




Conn.Execute(Query) 

  rowcount= rowcount +1
	Wend

Conn.Close
	Set Conn = Nothing 
'Response.Redirect("MembersAdEdit2.asp")
%>

</Body>
</HTML>
