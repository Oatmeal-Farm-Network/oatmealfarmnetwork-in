<!DOCTYPE HTML>
<HTML>
<HEAD>
<link rel="stylesheet" type="text/css" href="/administration/style.css">
</head>
<BODY  border = "0" leftmargin="0" topmargin="0" marginwGalleryIDth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">

<!--#Include file="AdminGlobalVariables.asp"--> 

<%

'rowcount = CInt
rowcount = 1


PaypalEmail =Request.Form("PaypalEmail") 
ProdID = request.form("ProdID")

Query =  " UPDATE people Set PaypalEmail  = '" & Trim(PaypalEmail)  & "' "
Query =  Query & " where PeopleID = 667;" 
'response.write("Query=" & Query)

Conn.Execute(Query) 
rowcount= rowcount +1
Conn.Close
Set Conn = Nothing 
response.redirect("AdminAdEdit2.asp?ProdID=" & ProdID)
%>
<!--#Include file="AdminFooter.asp"--></Body>
</HTML>