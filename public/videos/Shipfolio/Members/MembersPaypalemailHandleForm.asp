<!DOCTYPE HTML>
<HTML>
<HEAD>
<link rel="stylesheet" type="text/css" href="/members/style.css">
</head>
<BODY  border = "0" leftmargin="0" topmargin="0" marginwGalleryIDth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">

<!--#Include file="membersGlobalVariables.asp"--> 

<%

'rowcount = CInt
rowcount = 1


PaypalEmail =Request.Form("PaypalEmail") 
ProdID = request.form("ProdID")

Query =  " UPDATE people Set PaypalEmail  = '" & Trim(PaypalEmail)  & "' "
Query =  Query & " where PeopleID = " & PeopleID & ";" 
'response.write("Query=" & Query)

Conn.Execute(Query) 
rowcount= rowcount +1
Conn.Close
Set Conn = Nothing 
response.redirect("membersAdEdit2.asp?ProdID=" & ProdID)
%>
</Body>
</HTML>