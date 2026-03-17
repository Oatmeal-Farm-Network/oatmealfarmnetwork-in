<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
<HEAD>
 <title>Store Account Settings</title>
       <link rel="stylesheet" type="text/css" href="/administration/style.css">


<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">

		<!--#Include virtual="/Administration/Dimensions.asp"-->
		<!--#Include virtual="/Administration/Header.asp"--> 
		<!--#Include virtual="/administration/adminDetailDBInclude.asp"--> 



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



Query =  " UPDATE SFCustomers Set prodPurchasemethod = '" & prodPurchasemethod & "' ,"
	Query =  Query & "PaypalEmail  = '" & Trim(PaypalEmail)  & "' ,"
	Query =  Query & "OtherURL = '" & Trim(OtherURL) & "' "
	 Query =  Query & " where custID = " & custID & ";" 


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

response.redirect("StoreMaintenance.asp")
%>




		<!--#Include virtual="/administration/Footer.asp"--></Body>
</HTML>

 </Body>
</HTML>
