<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4+0 Transitional//EN">
<HTML>
<HEAD>
 <title>Add Auction Results Page</title>
       <link rel="stylesheet" type="text/css" href="style.css">
</HEAD>

<BODY bgcolor = "white">
<!--#Include virtual="/administration/Header.asp"--> 
<%

Dim TotalCount
dim rowcount
dim ID
dim FullName
dim StartingPrice
dim BuyNowPrice
dim ReservePrice
dim Startdate
dim Enddate



		
	ID=Request.Form("ID")
	BuyNowPrice= Request.Form("BuyNowPrice")
	StartingPrice=Request.Form("StartingPrice")
	ReservePrice=Request.Form("ReservePrice")
	Startdate=Request.Form("Startdate")
	Enddate=Request.Form("Enddate")

'response.write("ReservePrice=")
'response.write(ReservePrice)

If Len(ReservePrice) < 2 Then
	ReservePrice = "0"
End If 

If Len(StartingPrice) < 2 Then
	Startingprice = "0"
End If 

If Len(BuyNowPrice) <2 Or BuyNowPrice = Null Then
	BuyNowPrice = "0"
End If 
'rowcount = CInt(rowcount)
rowcount = 0



	BuyNowPrice= FormatCurrency(BuyNowPrice,0)
	StartingPrice=FormatCurrency(StartingPrice,0)
	Reserve=Reserve
	Startdate=Startdate
	Enddate=Enddate




	
if len(ID) < 1 then
	response.write("<center>Your changes could not be made. Please select an Alpaca's Name</center>")
	
else

	Query =  "INSERT INTO BreedingAuction ( AnimalID, Startdate, Enddate, BuyNowPrice)" 
	Query =  Query + " Values (" +  ID + " ,"
	Query =  Query +  " '" + Startdate + "', " 
	Query =  Query +  " '" + Enddate + "', " 
    Query =  Query +   " '" + BuyNowPrice + "' )" 


'response.write(Query)	

Dim DataConnection, cmdDC, RecordSet
Dim RecordToEdit, Updated
Set DataConnection = Server.CreateObject("ADODB.Connection")

DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath("../../db/AlpacaDB.mdb") & ";" 



DataConnection.Execute(Query) 



IF DataConnection.Errors.Count <> 0 then
     Call MyErrorHandler(oDBConn, sSQL)  ' pass database connection as param
 Else
 %>
<div align = "center"><H2>
<%
     response.write("Your changes have successfully been made.")
  %></H2>
</div>
<%

 End If

	DataConnection.Close
	Set DataConnection = Nothing 
end if 
%>

<table width = "660" align = "center">
	<tr >
		<td align = "right">
			<br><a  Class = "Links" href="Auctions.asp"> Return to Auction Page</a>
			<br>
		</td>
	</tr>
</table>
<!--#Include virtual="/administration/Footer.asp"--> </Body>
</HTML>
