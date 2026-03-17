<!DOCTYPE HTML >
<HTML>
<HEAD>
 <title>Ancestry Page</title>
       <link rel="stylesheet" type="text/css" href="/style.css">

<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">

<!--#Include file="MembersGlobalVariables.asp"-->
<!--#Include virtual="/Conn.asp"-->
<%

Dim TotalCount
dim rowcount
dim ID(99999) 
dim Name(99999)  
dim Price(99999) 
dim StudFee(99999) 
dim ForSale(99999) 
dim ShowOnWebsite(99999) 
dim Discount(99999)
dim PublishForSale(99999) 
dim PublishStud(99999)
dim AGBrokeredHerdsire(99999)

TotalCount= Request.Form("TotalCount")
TotalCount = CInt(TotalCount)
'rowcount = CInt(rowcount)
rowcount = 1

while (rowcount < TotalCount)
	IDcount = "ID(" & rowcount & ")"	
	Namecount = "Name(" & rowcount & ")"
	AGBrokeredHerdsirecount = "AGBrokeredHerdsire(" & rowcount & ")"
	
	ID(rowcount)=Request.Form(IDcount) 
	Name(rowcount)=Request.Form(Namecount) 
	AGBrokeredHerdsire(rowcount)=Request.Form(AGBrokeredHerdsirecount)
	rowcount = rowcount +1
Wend

 rowcount =1

while (rowcount < TotalCount)

	Query =  " UPDATE Animals Set Brokered = " &  AGBrokeredHerdsire(rowcount) & " " 
    Query =  Query & " where ID = " & ID(rowcount) & ";" 

	'response.write(Query)


Conn.Execute(Query)


	  rowcount= rowcount +1
	Wend


response.Redirect("alpacashomeHerdsireBrokering.asp")

%>

</Body>
</HTML>
