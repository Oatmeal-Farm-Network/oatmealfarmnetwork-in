<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<HEAD>
 <base target="_self" />
<link rel="stylesheet" type="text/css" href="/style.css">
<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  >
<!--#Include virtual="/Conn.asp"-->
<table width = 80%>
<tr><td class = "body">

<%

ProdID=Request.Form("ProdID") 
DimensionTitle= Request.Form("DimensionTitle")
Screenwidth= Request.Form("Screenwidth")

Query =  " UPDATE SFAttributeTitles Set DimensionTitle = '" &  DimensionTitle & "' " 
Query =  Query & " where ProdID = " & ProdID & ";" 
'response.write("Query=" & Query )
Conn.Execute(Query) 


Conn.Close
Set Conn = Nothing  
response.redirect("AdminProductDimensionTitleFrame.asp?ProdID=" & ProdID & "&screenwidth=" & screenwidth & "&changesmade=True")
%>
</td></tr></table>

 </Body>
</HTML>