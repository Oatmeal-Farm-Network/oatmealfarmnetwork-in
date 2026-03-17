<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html >
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Content-Language" content="en-us">
<link rel="stylesheet" type="text/css" href="/administration/style.css">
<!--#Include file="AdminMobileWidthInclude.asp"-->
<!--#Include file="AdminConn.asp"-->
</head>
<% if mobiledevice = True  then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
<% end if %>
<% loginpage = True 

Set rsA = Server.CreateObject("ADODB.Recordset")
sqlA= "select * from Administration where AdministrationID = 1;" 
rsA.Open sqlA, conn, 3, 3   
If Not rsA.eof Then
AdminHeaderImage = rsA("AdminHeaderImage")
AdminAuthor = rsA("AdminAuthor")
AdminTitle= rsA("AdminTitle")
Admincurrency= rsA("Admincurrency")
Admindateformat= rsA("Admindateformat")
Copyrightname= rsA("Copyrightname")
CopyrightLink= rsA("CopyrightLink")
End If 
rsA.close


%>


<table width = "<%=screenwidth-35 %>" bgcolor = "white" border="0" cellspacing="0" cellpadding="0" align = "center">
<tr><td><table width = "<%=screenwidth-35 %>" align = "left" border="0" cellspacing="0" cellpadding="0" >
<tr><td class = "body" height = "80">
<% if mobiledevice = True and SmallMobile = False then %>
<a href = "default.asp"><center><img src =  "<%=AdminHeaderImage %>" alt = "Content Management System" height = "129" width = "324"  border = "0"></center></a>
<% else %>
<a href = "default.asp"><img src =  "<%=AdminHeaderImage %>" alt = "Content Management System" height = "129" width = "324" border = "0"></a>
<% end if %>
<td></tr></table>
</td></tr>

<% loginpage = True %>
<%
Session.Abandon
%> 
<% if mobiledevice = False  then %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth - 35 %>" >
<tr><td class = "roundedtop" align = "left">
<H1>Sign Out</H1></td></tr>
<tr><td class = "roundedBottom" align = "center" >
<% else %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%" >
<tr><td  align = "center" >
<% end if %>


       
<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center"  valign ="top"  width = "100%"  bgcolor = "white">
	<tr>
	    <td class = "body"   valign = "top" align = "center">
	    <% if mobiledevice = False  then %>
	    <br /><br />
	    <% end if %>
			<center>You have signed out of the AGCMS.<br>
			Feel free to use the form below to log back in:</center>
			<form action= 'AdminLoginHandle.asp' method = "post">
				<table align = "center">
					<tr>
						<td class = "body">
							<div align = "right">Email:</div></td>
							<td>	
							<input type=text  name=UID value= "" SIZE = "32" class = "regsubmit2 body" width = 280 style="width: 280px">
						</td>
					</tr>
					<tr><td class = "body">
							<div align = "right">Password:<br></div>
						</td>
						<td>	
							<input type= password name=password value= "" SIZE = "10" class = "regsubmit2 body" width = 280 style="width: 280px">
						</td>
					</tr>
				</table>
<div align = "center">
<table>
<tr><td class = "body" colspan="3"><br />
<% 
' begin random function
randomize

' random numbers is the varible that will contain a numeriv value
' between one and nine
random_number=int(rnd*10)
Select Case random_number
Case 0
 MIMage = "/images/X987045.jpg"
Case 1 
 MIMage = "/images/X583198.jpg"
 Case 2 
 MIMage = "/images/X949256.jpg"
 Case 3 
 MIMage = "/images/X096367.jpg"
 Case 4 
 MIMage = "/images/X583198.jpg"
 Case 5 
 MIMage = "/images/X912578.jpg"
Case 6 
 MIMage = "/images/X234697.jpg"
Case 7 
 MIMage = "/images/X781736.jpg"
Case 8 
 MIMage = "/images/X987834.jpg"
Case 9 
 MIMage = "/images/X983999.jpg"
End Select

' write the random number out to the browser
%>



<table border = 0 align = center>
<tr><td colspan = 3 class = "body2" align = "center"><center>&nbsp;&nbsp;&nbsp;
<% 

if Mathquestionerror = "True" then%>
<font color = red>
<% end if %>
<b>Are You A Human?</b>
<% if Mathquestionerror = "True" then%>
</font>
<% end if %>
</center></td></tr>
<tr>
    <td align = "right" valign = "bottom" width = "110"><img src = "<%=MIMage %>" alt = "Contact Us" valign = "bottom"></td>
    <td><INPUT TYPE="TEXT" NAME="fieldX" size="3"><font color=red>*</font></td>
    <td valign = "top"><INPUT TYPE="hidden" NAME="Question" Value="<%=MIMage %>" valign = "top">
    </td></tr>
    <tr><td colspan = 3>
    <br />
			<center><input type=submit value = "Login"  class = "regsubmit2 body" ></center>
			</form>
</td></tr></table>
</table>	
	</td>
	</tr>
</table>
<br />	
<% if mobiledevice = False  then %>
<!--#Include file="AdminFooter.asp"-->
<% end if %>
</body>
</html>