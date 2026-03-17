<!DOCTYPE HTML>

<HTML>
<HEAD>
<title>The Andresen Group Content Management System</title>
<link rel="stylesheet" type="text/css" href="/administration/style.css">
</HEAD>

<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">
<!--#Include file="AdminSecurityInclude.asp"-->
<!--#Include file="AdminGlobalVariables.asp"-->
<%

	CID=Request.Form("CID") 

	CustFirstName=Request.Form("PeopleFirstName") 
	CustLastName=Request.Form("PeopleLastName")
	custPasswd=Request.Form("pw1")
	custPasswd2=Request.Form("pw2")
	CustEmail=Request.Form("email1")
	CustEmail2=Request.Form("email2")
AccessLevel = Request.Form("AccessLevel")

'response.write("CustFirstName=" & CustFirstName)
'response.write("CustLastName=" & CustLastName)
'response.write("CustEmail=" & CustEmail)

Proceed="False"

if len(custPasswd) < 6 then
  Message=Message & "<br>Your password must be at least 6 charecters long."
end if 

response.write("custPasswd=" & custPasswd)
response.write("custPasswd2=" & custPasswd2)

if custPasswd = custPasswd2 then
 Proceed = "True"
else 
Proceed="False"
   Message= Message &  "<br>The <b>passwords</b> that you entered do not match."
end if 

'response.write("Proceed=" & Proceed)	

if Proceed="True" then

Query =  " UPDATE Users Set custPasswd = '" &  custPasswd & "' " 
Query =  Query + " where custID = " & CID & ";" 

'response.write(Query)	
Set DataConnection = Server.CreateObject("ADODB.Connection")
DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 
DataConnection.Execute(Query) 
DataConnection.close
end if
Set DataConnection = Nothing

if Proceed = "False" then
 Response.redirect("AdminResetpassword.asp?Message=" & Message & "&CID=" & CID)
else
 Response.redirect("AdminResetpassword.asp?Message2=The password was successfully changed.&CID=" & CID)
end if
%>

 </Body>
</HTML>
