<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<%  PageName = "Home Page" %>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta http-equiv="Content-Language" content="en-us">
<title>Member Area</title>
<link rel="stylesheet" type="text/css" href="/style.css">

<!--#Include virtual="/includefiles/GlobalVariables.asp"-->
</head>

<body >


<% session("LoggedIn") = False%>
<!--#Include virtual="/includefiles/Header.asp"-->


<div class="container-fluid" style="max-width: 460px;" >
   <div>
     <div>
     <h1>Send Ranch Account Password</h1>

<form action= 'AssociationSendpassword2.asp' method = "post">

<% Message = request.querystring("Message")
if len(Message) > 1 then%>
<font color = "maroon"><b><%=Message %></b></font><br />
<% else %>
<br>
<% end if 
    if mobiledevice = True then
			fieldlength = 22
			else
			fieldlength = 45
			end if
			%>
			<b>Email</b><br />
            <input name="Email" size = "<%=fieldlength %>" maxlength =  "70" class = "formbox">
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

%><br>
    	  <b>Math Question</b>
    	  Please answer the simple question below so we know that you are a human.<br>


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
	 		<INPUT TYPE="TEXT" NAME="fieldX" size="3" class = "formbox">*
    </td></tr></table>

	<div align = "center"><br />
	<input type=submit value = "SEND PASSWORD" class = "regsubmit2">
	</form><br /><br /><br />

     </div>
    </div>
</div>
<!--#Include virtual="/includefiles/Footer.asp"-->
</Body>
</HTML>