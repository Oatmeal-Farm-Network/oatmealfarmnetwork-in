<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html >
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Content-Language" content="en-us">
<link rel="stylesheet" type="text/css" href="/administration/style.css">
<!--#Include file="AdminMobileWidthInclude.asp"-->
<!--#Include virtual="/Conn.asp"-->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<meta http-equiv="Content-Language" content="en-us">
<%Set rs2 = Server.CreateObject("ADODB.Recordset")

sql2 = "select * from SiteDesign where PeopleId = 667;" 
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3   
If Not rs2.eof Then
WebSiteName = rs2("WebSiteName")
Slogan = rs2("Slogan")
WebLink= rs2("WebLink")
Customerlogo = rs2("Logo")
AdministrationID  = rs2("AdministrationID")
End If 
rs2.close


sqlA= "select * from Administration where AdministrationID = " & AdministrationID 
rs2.Open sqlA, conn, 3, 3   
If Not rs2.eof Then
AdminHeaderImage = rs2("AdminHeaderImage")
AdminAuthor = rs2("AdminAuthor")
AdminTitle= rs2("AdminTitle")
Admincurrency= rs2("Admincurrency")
Admindateformat= rs2("Admindateformat")
Copyrightname= rs2("Copyrightname")
CopyrightLink= rs2("CopyrightLink")
Currencycode=rs2("AdminCurrencyCode")
PaypalCurrencyCode = rs2("PaypalCurrencyCode")
SetLocale(rs2("LocalCode"))
End If 
rs2.close%>
</head>
<% if mobiledevice = True or is_iPad = true then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
<% end if %>
<% loginpage = True %>
<table width = "<%=screenwidth %>" bgcolor = "white" border="0" cellspacing="0" cellpadding="0" align = "center">
<tr><td><table width = "100%" align = "center" border="0" cellspacing="0" cellpadding="0" >
<tr><td width = 20></td><td class = "body" height = "80">
<% if len(Customerlogo) > 4 then %>
<% if mobiledevice = True and SmallMobile = False then %>
<a href = "default.asp"><center><img src =  "<%=Customerlogo %>" alt = "Content Management System" height = "129" border = "0"></center></a><br />
This Content Managment System is presented by <a href ="<%=CopyrightLink%>" class = "body"><%=AdminAuthor%></a>.
<% else %>
<a href = "default.asp"><img src =  "<%=Customerlogo %>" alt = "Content Management System" height = "129" border = "0"></a><br />
This Content Managment System is presented by <a href ="<%=CopyrightLink%>" class = "body"><%=AdminAuthor%></a>.
<% end if %>

<% else %>
<% if mobiledevice = True and SmallMobile = False then %>
<a href = "default.asp"><center><img src =  "<%=AdminHeaderImage %>" alt = "Content Management System" height = "129" width = "324"  border = "0"></center></a>
<% else %>
<a href = "default.asp"><img src =  "<%=AdminHeaderImage %>" alt = "Content Management System" height = "129" width = "324" border = "0"></a>
<% end if %>
<% end if %>
<td>
</tr>
</table>
</td></tr>

<% if mobiledevice = False  then %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth - 35 %>" >
<tr><td class = "roundedtop" align = "left">
<H1>Sign In</H1></td></tr>
<tr><td class = "roundedBottom" align = "center" >
<% else %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%" >
<tr><td  align = "center" >
<% end if %>



<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center"  valign ="top"  width = "100%"  bgcolor = "white">

	<tr>
	    <td class = "body"   valign = "top" align = "center">
		<% if Error="True" then %>	<b><font color = "red">Your username or password do not match our records. Please try again.</font></b><% end if %><br>

<!--#Include file="AdminLoginInclude.asp"-->
<br /><br />
		</td>
	</tr>
</table>
		</td>
	</tr>
</table>
</BODY>
</HTML>