<!doctype html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta http-equiv="Content-Language" content="en-us">
<link rel="stylesheet" type="text/css" href="membersstyle.css">
</head>
<body >

<% currentpage="ungated" %>
<!--#Include virtual="/includefiles/globalvariables.asp"-->


<% Set rs2 = Server.CreateObject("ADODB.Recordset")
Email=Trim(Request.Form("Email")) 
password=Trim(Request.Form("password")) 
redirect = False
	
sql2 = "select * from People where trim(lower(Email)) = '" & trim(lcase(Email)) & "'  and Password = '" & Password & "'"
response.write("slq2=" & sql2 )
acounter = 1
rs2.Open sql2, Conn, 3, 3 

if Not rs2.eof Then
	ResetPassword = rs2("ResetPassword")
	if ResetPassword = 1 then
	   NewUser = True
	   PeopleID= rs2("PeopleID")
	   AccessLevel= rs2("AccessLevel")
	else
		Session("AccessLevel")= rs2("AccessLevel")
		Session("PeopleID")= rs2("PeopleID")
		Session("WebsiteAccess")=True
		Session.Timeout = 900
		redirect ="True"
	end if
else 
	Session("WebsiteAccess")=False
end if

rs2.close


Set conn = Nothing

if NewUser = True then
	response.Redirect("NewUser.asp?PeopleID=" & PeopleID & "&AccessLevel=" & AccessLevel )
end if

If redirect = "True" then
	response.Redirect("Definitions.asp")
else
	response.Redirect("/Default.asp?Fail=True")
End If
%>



</BODY>
</HTML>
