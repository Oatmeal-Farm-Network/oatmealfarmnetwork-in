<!DOCTYPE HTML>

<HTML>
<HEAD>
<title>The Andresen Group Content Management System</title>
<link rel="stylesheet" type="text/css" href="/administration/style.css">
</head>
<BODY  border = "0" leftmargin="0" topmargin="0" marginwGalleryIDth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">

<!--#Include file="AdminSecurityInclude.asp"--> 
<!--#Include file="AdminGlobalVariables.asp"--> 
<!--#Include file="AdminHeader.asp"--> 

<%
Dim prodPurchasemethod
Dim PaypalEmail 
Dim OtherURL


'rowcount = CInt
rowcount = 1

custID=session("custID") 
prodPurchasemethod=Request.Form("prodPurchasemethod") 
PaypalEmail =Request.Form("PaypalEmail") 
OtherURL=Request.Form("OtherURL") 
TaxNexusState=Request.Form("TaxNexusState") 
TaxRate=Request.Form("TaxRate") 
TaxActive=Request.Form("TaxActive") 
if len(TaxRate) > 0 then
else
TaxRate = 0
end if

Query =  " UPDATE people Set prodPurchasemethod = '" & prodPurchasemethod & "' ,"
Query =  Query & "PaypalEmail  = '" & Trim(PaypalEmail)  & "' ,"
Query =  Query & "OtherURL = '" & Trim(OtherURL) & "' ,"
Query =  Query & "TaxRate  = " & TaxRate & " ,"
Query =  Query & "TaxNexusState  = '" & TaxNexusState  & "' "
Query =  Query & " where PeopleID = 667;" 

response.write(Query)	

Set DataConnection = Server.CreateObject("ADODB.Connection")
DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) 	& ";" 

DataConnection.Execute(Query) 

	  rowcount= rowcount +1


IF DataConnection.Errors.Count <> 0 then
     Call MyErrorHandler(oDBConn, sSQL)  ' pass database connection as param
 End If

	DataConnection.Close
	Set DataConnection = Nothing 

response.redirect("AdminStoreMaintenance.asp")
%>
<!--#Include file="AdminFooter.asp"--></Body>
</HTML>