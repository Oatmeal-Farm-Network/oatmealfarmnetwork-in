<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<HEAD>
 <base target="AdminProductsAttributeValuesFrame.asp" />
<link rel="stylesheet" type="text/css" href="/style.css">
<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  >
<!--#Include virtual="/Conn.asp"-->
<%

ProdID=Request.Form("ProdID") 
PrimaryAttribute= Request.Form("PrimaryAttribute")
Screenwidth= Request.Form("Screenwidth")

Query =  " UPDATE SFAttributePrimary Set PrimaryAttribute = '" &  PrimaryAttribute & "' " 
Query =  Query & " where ProdID = " & ProdID & ";" 
response.write("Query=" & Query )
Conn.Execute(Query) 


Conn.Close
Set Conn = Nothing  
response.redirect("AdminProductsAttributeValuesFrame.asp?ProdID=" & ProdID & "&screenwidth=" & Screenwidth & "&changesmade=True/_parent")
%>
 </Body>
</HTML>