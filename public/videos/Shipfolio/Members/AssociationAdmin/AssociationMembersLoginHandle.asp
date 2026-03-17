<!doctype html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta http-equiv="Content-Language" content="en-us">
<link rel="stylesheet" type="text/css" href="membersstyle.css">
</head>
<body >

<% loginpage = True %>
<!--#Include virtual="/includefiles/globalvariables.asp"-->


<% Set rs2 = Server.CreateObject("ADODB.Recordset")
UID=Trim(Request.Form("UID")) 
password=Trim(Request.Form("password")) 
redirect = False
	
sql2 = "select * from associationmembers, People where associationmembers.peopleid = people.peopleid and trim(lower(PeopleEmail)) = '" & trim(lcase(UID)) & "'  and peoplePassword = '" & password & "' order by associationmemberid desc"
response.write("slq2=" & sql2 )
acounter = 1
rs2.Open sql2, Conn, 3, 3 

if Not rs2.eof Then
	ResetPassword = rs2("ResetPassword")
	response.write("ResetPassword=" & ResetPassword )
	if ResetPassword = True then
	   NewUser = True
	   PeopleID= rs2("PeopleID")
	   AccessLevel= rs2("AccessLevel")
	else
		Session("MemberAccessLevel")= rs2("AccessLevel")
		Session("AssociationID")= rs2("AssociationID")
		Session("PeopleID")= rs2("PeopleID")
		Session("WebsiteAccess")=True
		redirect ="True"
	end if

		

	else 
	   Session("WebsiteAccess")=False
	end if

rs2.close

if NewUser = True then
	response.Redirect("NewUser.asp?PeopleID=" & PeopleID & "&AccessLevel=" & AccessLevel )
end if
Set conn = Nothing
response.write("redirect= " & redirect)
response.write("Peopleid= " & Session("PeopleID"))

	If redirect = "True" then
	    response.write("Session(accesslevel)=" & Session("accesslevel") )
		response.Redirect("Default.asp")
    else
		response.Redirect("associationLogin.asp?AssociationError=True")
	End If
%>



</BODY>
</HTML>
