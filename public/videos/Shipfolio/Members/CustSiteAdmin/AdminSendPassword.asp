<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta http-equiv="Content-Language" content="en-us">
<title>Content Management System</title>
<link rel="stylesheet" type="text/css" href="/administration/style.css">

<!--#Include file="AdminMobileWidthInclude.asp"-->
</head>
<% if mobiledevice = True  then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
<% end if %>
<% loginpage = True %>
<table width = "<%=Screenwidth -35 %>" bgcolor = "white" border="0" cellspacing="0" cellpadding="0" align = "center">
<tr><td><table width = "100%" align = "center" border="0" cellspacing="0" cellpadding="0" >
<tr><td class = "body" height = "80">
<% if mobiledevice = True and SmallMobile = False then %>
<a href = "default.asp"><center><img src =  "/administration/images/HeraCMSLogo.jpg" alt = "Content Management System" height = "211" width = "423" border = "0"></center></a>
<% else %>
<a href = "default.asp"><img src =  "/administration/images/LOACMSLogo.jpg" alt = "Content Management System" width = "282" border = "0"></a>
<% end if %>
<td>
</tr>
</table></td></tr>
	<form action= 'AdminSendpassword2.asp' method = "post"><tr>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=Screenwidth -35 %>" >
<tr><td class = "roundedtop" align = "left"><H1>Send Password</H1>
        </td></tr>
        <tr><td class = "roundedBottom body" align = "center" width = "100%">  
<% Message = request.querystring("Message")
if len(Message) > 1 then%>
<font color = "red"><b><%=Message %></b></font>
<% else %>
<br />
		Please enter the email address associated with your account and we will email you your password.<br><br>
<% end if 
    if mobiledevice = True then
			fieldlength = 22
			else
			fieldlength = 45
			end if
			%>
	<table border = "0" cellpadding = "0" cellspacing = "0" align = "center" width = "100%">
	<tr >
		<td  align = "center" class = "body" colspan = "2">
			Email Address: <input name="Email" size = "<%=fieldlength %>" maxlength =  "70" class = "regsubmit2 body">
		</td>
	</tr>
	<tr>
     <td class = "body2" colspan = "2" align = "left">
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
            	  <b>Math Question</b>
            	  Please answer the simple question below so we know that you are a human.</td>
            	</tr> 
				<tr> 
                	<td height="20" class = "body" align = "left">
                	<table><tr>
                	<td>
                	<% if mobiledevice = True  then %>
                	<img src = "<%=MIMage %>" width = "160" height = "48">
                	<% else %>
                	<img src = "<%=MIMage %>" width = "80" height = "24">
                	<% end if %>
                	</td>
                	<td  height="20" class = "body" align = "left"> 
                	<INPUT TYPE="hidden" NAME="Question" Value="<%=MIMage %>">
	                 		<INPUT TYPE="TEXT" NAME="fieldX" size="3" class = "regsubmit2 body">*
	     
                    </td>
            	</tr>
            	</table>
            		</td>
</tr>
<tr>  
		<td  valign = "middle" class = "body">
			
			<div align = "center"><br />
			<input type=submit value = "Send Password" class = "regsubmit2 body">
			</form><br /><br /><br />
		</td>
</tr>
</table>
	</td>
</tr>
</table>

</Body>
</HTML>