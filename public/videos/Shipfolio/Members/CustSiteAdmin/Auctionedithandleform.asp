<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4+0 Transitional//EN">
<HTML>
<HEAD>
 <title>Alpacas At Lone Ranch Administration</title>
            <link rel="stylesheet" type="text/css" href="style.css">



</HEAD>

<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 background = "images/background.jpg">

<!--#Include virtual="/Administration/Header.asp"--> 
<%

	dim ID(200)
	dim AuctionID(200)
	dim Startingprice(200)
	dim BuyNowPrice(200)
	dim Reserve(200)
	dim Startdate(200)
	dim Enddate(200)
	dim Sold(200)
	dim Salepending(200)
		dim AuctionOrder(200)



TotalCount= Request.Form("TotalCount")
TotalCount = CInt(TotalCount)
rowcount = 1

while (rowcount < TotalCount)
	IDcount = "ID(" & rowcount & ")"	
	AuctionIDcount = "AuctionID(" & rowcount & ")"	
	Startingpricecount = "Startingprice(" & rowcount & ")"
	BuyNowPricecount = "BuyNowPrice(" & rowcount & ")"
	Reservecount = "Reserve(" & rowcount & ")"
	Startdatecount = "Startdate(" & rowcount & ")"
	Enddatecount = "Enddate(" & rowcount & ")"
	Soldcount = "Sold(" & rowcount & ")"
	Salependingcount = "Salepending(" & rowcount & ")"
	AuctionOrdercount = "AuctionOrder(" & rowcount & ")"
	
	ID(rowcount)=Request.Form(IDcount) 
	AuctionID(rowcount)=Request.Form(AuctionIDcount) 
	Startingprice(rowcount)=Request.Form(Startingpricecount) 
	BuyNowPrice(rowcount)=Request.Form(BuyNowPricecount )
	Reserve(rowcount)=Request.Form(Reservecount) 
	Startdate(rowcount)=Request.Form(Startdatecount) 
	Enddate(rowcount)=Request.Form(Enddatecount) 
	Sold(rowcount)=Request.Form(Soldcount) 
	Salepending(rowcount)=Request.Form(SalePendingcount)
	AuctionOrder(rowcount)=Request.Form(AuctionOrdercount) 
	rowcount = rowcount +1
Wend

 rowcount =1

while (rowcount < TotalCount)


	Query =  " UPDATE Auction Set Startingprice = '" &  Startingprice(rowcount) & "', " 
	Query =  Query + " BuyNowPrice = '" &  BuyNowPrice(rowcount) & "'," 
    Query =  Query & " Reserve = '" &   Reserve(rowcount) & "',"   
	Query =  Query & " Startdate =' " &   Startdate(rowcount) & "'," 
    Query =  Query & " Enddate = '" &   Enddate(rowcount) & "'," 
	Query =  Query & " SalePending =" &   SalePending(rowcount) & "," 
    Query =  Query & " AuctionOrder = '" &  AuctionOrder(rowcount) & "'," 
	    Query =  Query & " Sold = " &   Sold(rowcount) & "" 
	Query =  Query & " where AuctionID = " & AuctionID(rowcount) & ";" 

'response.write(Query)	

Dim DataConnection, cmdDC, RecordSet
Dim RecordToEdit, Updated
Set DataConnection = Server.CreateObject("ADODB.Connection")

DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath("../../db/AlpacaDB.mdb") & ";" 



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
</div>
<%

 End If

	DataConnection.Close
	Set DataConnection = Nothing 

%>

<table width = "660" align = "center">
	<tr >
		<td align = "right">
			<br><a  Class = "Links" href="Auctions.asp"> Return to Auction Page</a>
			<br>
		</td>
	</tr>
</table>
</BODY>
</HTML>
