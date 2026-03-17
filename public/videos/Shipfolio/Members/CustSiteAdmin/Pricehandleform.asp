<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
<HEAD>
 <title>Pricing Page</title>
       <link rel="stylesheet" type="text/css" href="/administration/style.css">


<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">



<!--#Include virtual="/Administration/Header.asp"--> 


<%

Dim TotalCount
dim rowcount
dim ID(400)
dim FullName(400)
dim Price(400)
dim CPrice(400)
dim Pricing(400)
dim ForSale(400)
dim Foundation(400)
dim PriceComments(400)

TotalCount= Request.Form("TotalCount")
TotalCount = CInt(TotalCount)
'rowcount = CInt(rowcount)
rowcount = 1

while (rowcount < TotalCount)
	IDcount = "ID(" & rowcount & ")"	
	FullNamecount = "Name(" & rowcount & ")"
	Pricecount = "Price(" & rowcount & ")"
	Pricingcount = "Pricing(" & rowcount & ")"
	ForSalecount = "ForSale(" & rowcount & ")"
	Foundationcount = "Foundation(" & rowcount & ")"
	PriceCommentscount = "PriceComments(" & rowcount & ")"

	
	ID(rowcount)=Request.Form(IDcount) 
	FullName(rowcount)=Request.Form(FullNamecount) 
	Price(rowcount)=Request.Form(Pricecount )
	Pricing(rowcount)=Request.Form(Pricingcount )
	ForSale(rowcount)=Request.Form(ForSalecount )
	Foundation(rowcount)=Request.Form(Foundationcount )
	PriceComments(rowcount)=Request.Form(PriceCommentscount) 

	rowcount = rowcount +1
Wend

 rowcount =1

while (rowcount < TotalCount)
CPrice(rowcount) = Price(rowcount)

if CPrice(rowcount) = "" then
	CPrice(rowcount) = "123"
end if 
'response.write(CPrice(rowcount))
if Trim(UCase(CPrice(rowcount)))  = "SOLD!" Or Trim(UCase(CPrice(rowcount)))  = "SOLD" Or Trim(UCase(CPrice(rowcount)))  = "RETIRED" then
	CPrice(rowcount) = "1234567"
end if 


if Trim(UCase(CPrice(rowcount)))  = "NOT FOR SALE"  then
	CPrice(rowcount) = "123"
end if 


Dim str1
Dim str2
str1 = PriceComments(rowcount)
str2 = "'"
If InStr(str1,str2) > 0 Then
	PriceComments(rowcount)= Replace(str1, "'", "''")
End If

	Query =  " UPDATE Pricing Set AValue = '" +  Price(rowcount) + "', " 
	Query =  Query + " Price = '" + CPrice(rowcount) + "', " 
	Query =  Query + " Forsale = " +  ForSale(rowcount) + ","
	Query =  Query + " PriceComments = '" +  PriceComments(rowcount) + "'"
    Query =  Query + " where ID = " + ID(rowcount) + ";" 

'response.write(Query)	

Dim DataConnection, cmdDC, RecordSet
Dim RecordToEdit, Updated
Set DataConnection = Server.CreateObject("ADODB.Connection")

DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) 	& ";" 


DataConnection.Execute(Query) 

	  rowcount= rowcount +1
	Wend

IF DataConnection.Errors.Count <> 0 then
     Call MyErrorHandler(oDBConn, sSQL)  ' pass database connection as param
 Else
 %>
<div align = "center"><H2>
<%
     response.write("Your changes have successfully been made.")
  %></H2>

<%

 End If

	DataConnection.Close
	Set DataConnection = Nothing 

%>

<table width = "660" align = "center">
	<tr >
		<td align = "right">
			<br><a  class = "Links" href="PricingData.asp"> Return to Pricing Data Page</a>
			<br>
		</td>
	</tr>
</table>
<!--#Include virtual="/Administration/Footer.asp"--> </Body>
</HTML>
