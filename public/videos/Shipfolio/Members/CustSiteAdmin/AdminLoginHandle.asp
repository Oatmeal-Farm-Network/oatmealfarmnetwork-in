<!doctype html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta http-equiv="Content-Language" content="en-us">
<link rel="stylesheet" type="text/css" href="style.css">
</head>
<% if mobiledevice = True  then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
<% end if %>
<% loginpage = True %>

<!--#Include file="AdminConn.asp"-->

<%Set rs2 = Server.CreateObject("ADODB.Recordset")
UID=Trim(Request.Form("UID")) 
password=Trim(Request.Form("password")) 
Question = request.form("Question")
fieldX = request.form("fieldX")
Shoesize = request.form("Shoesize")

response.write("password=" & password & "<br>" )

if not(fieldX = Mid(Question, 13, 1)) or len(trim(Shoesize)) > 0 or len(fieldX) < 1 then
response.Redirect("AdminLogin.asp?Mathquestionerror=True")
end if 


sql2 = "select * from People where PeopleEmail = '" & UID & "' and peoplepassword = '" & password & "' "
'response.write("slq2!=" & sql2 & "<br>" )
acounter = 1
rs2.Open sql2, Conn, 3, 3 
if Not rs2.eof Then
	
	response.write("peopleemail=" & rs2("peopleemail") & " ")
	response.write("PeoplePassword=" & rs2("PeoplePassword"))
Session("accesslevel")= rs2("accesslevel")
		Session("PeopleID")= rs2("PeopleID")
		Session("PeopleEmail")= rs2("PeopleEmail")
		Session("PeopleID")= rs2("PeopleID")
Session("AIID")= rs2("AIID")
		Session("WebsiteAccess")=True
		redirect ="True"

	else 
    	response.write("epic fail")
	   Session("WebsiteAccess")=False
	end if

rs2.close

	sql2 = "select * from sfCustomers where CustID = 66"
	'response.write("slq2=" & sql2 )
	acounter = 1
	rs2.Open sql2, Conn, 3, 3 


	if Not rs2.eof Then
	session("AIID") = rs2("AIID")
	end if
	rs2.close
Set conn = Nothing
 response.write("redirect= " & redirect)
	If redirect = "True" then
	  
	' response.write("Session(accesslevel)=" & Session("accesslevel") )
	response.Redirect("Default.asp")
    else
    response.Redirect("AdminLogin.asp?Error=True")
	End If
%>



</BODY>
</HTML>
