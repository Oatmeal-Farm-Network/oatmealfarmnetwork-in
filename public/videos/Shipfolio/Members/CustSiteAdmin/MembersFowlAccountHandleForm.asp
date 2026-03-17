<!DOCTYPE HTML>
<HTML>
<HEAD>
</head>
<BODY  border = "0" leftmargin="0" topmargin="0" marginwGalleryIDth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">
<!--#Include file="MembersGlobalVariables.asp"--> 
<%
Dim prodPurchasemethod
Dim PaypalEmail 
Dim OtherURL
rowcount = 1
ID = request.querystring("ID")
custID=session("custID") 
PaymentMethodFowl=Request.Form("PaymentMethodFowl") 
PaypalEmail =Request.Form("PaypalEmail") 
OtherURL=Request.Form("OtherURL") 
TaxNexusState=Request.Form("TaxNexusState") 
TaxRate=Request.Form("TaxRate") 
TaxActive=Request.Form("TaxActive") 
if len(TaxRate) > 0 then
else
TaxRate = 0
end if
Query =  " UPDATE people Set PaymentMethodFowl = '" & PaymentMethodFowl & "' ,"

Query =  Query & "PaypalEmail  = '" & Trim(PaypalEmail)  & "' "
Query =  Query & " where PeopleID = " & session("PeopleID") & ";" 

connLOA.Execute(Query) 
connLOA.close
set connLOA=nothing 
response.redirect("membersEditAnimal.asp?ID=" & ID & "&ScreenWidth=" & screenwidth & "#top")
%>
</Body>
</HTML>