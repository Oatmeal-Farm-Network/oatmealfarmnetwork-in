<!DOCTYPE HTML>
<HTML>
<HEAD>
<link rel="stylesheet" type="text/css" href="/administration/style.css">
</head>
<BODY  border = "0" leftmargin="0" topmargin="0" marginwGalleryIDth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">
<!--#Include virtual="/connloa.asp"--> 
<%
Dim prodPurchasemethod
Dim PaypalEmail 
Dim OtherURL
rowcount = 1
ProdID = request.querystring("ProdID")
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
if len(OtherURL) > 0 then
Query =  Query & "OtherURL = '" & Trim(OtherURL) & "' ,"
end if
if len(TaxRate) > 0 then
Query =  Query & "TaxRate  = " & TaxRate & " ,"
end if
if len(trim(TaxNexusState)) > 0 then
Query =  Query & "TaxNexusState  = '" & trim(TaxNexusState)  & "', "
end if

Query =  Query & "PaypalEmail  = '" & Trim(PaypalEmail)  & "' "
Query =  Query & " where PeopleID = " & session("PeopleID") & ";" 
response.write("Query=" & Query )
connloa.Execute(Query) 
connloa.close
set connloa=nothing 
response.redirect("MembersAdEdit2.asp?ScreenWidth=" & screenwidth & "&ProdID=" & ProdID)
%>
</Body>
</HTML>