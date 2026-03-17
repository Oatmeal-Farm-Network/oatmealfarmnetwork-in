<!doctype html>
<html>
<head>
<!--#Include virtual="/conn.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta http-equiv="Content-Language" content="en-us">
<link rel="stylesheet" type="text/css" href="membersstyle.css">
</head>
<% if mobiledevice = True  then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
<% end if %>
<% loginpage = True %>
 


<%Set rs2 = Server.CreateObject("ADODB.Recordset")
UID=Trim(Request.Form("UID")) 
password=Trim(Request.Form("password")) 

sql2 = "select * from associationmembers, People where associationmembers.peopleid = people.peopleid and trim(lcase(PeopleEmail)) = '" & trim(lcase(UID)) & "'  and peoplePassword = '" & password & "'"
response.write("slq2=" & sql2 )
acounter = 1
rs2.Open sql2, Conn, 3, 3 

if Not rs2.eof Then
	
	'	response.write("custemail=" & rs2("Email") & " ")
	'response.write("custPasswd=" & rs2("Password"))
Session("MemberAccessLevel")= rs2("AccessLevel")
Session("AssociationID")= rs2("AssociationID")
Session("PeopleID")= rs2("PeopleID")
Session("WebsiteAccess")=True
redirect ="True"

	else 
	   Session("WebsiteAccess")=False
	end if

rs2.close

Set conn = Nothing
 response.write("redirect= " & redirect)
If redirect = "True" then'response.write("Session(accesslevel)=" & Session("accesslevel") )
'response.Redirect("Default.asp")
else
'response.Redirect("AssociationLogin.asp?Error=True")
End If
%>



</BODY>
</HTML>
