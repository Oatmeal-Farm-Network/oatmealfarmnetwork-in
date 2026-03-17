<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center"  valign ="top"  width = "100%" >
<tr>
	<td class = "body"  valign = "top" align = "center" width = "50%">
			<%
				live = True
			If live = True Then 
			if SmallMobile = True then
			fieldlength = 22
			else
			fieldlength = 30
			end if
			%>
		
			<form action= 'AdminLoginHandle.asp' method = "post">
				<table width = "300" align = "center">
					<tr>
						<td align = "right">
							Email:
						</td>
						<td align = "left">	
							<input type=text  name=UID value= "" SIZE = "<%=fieldlength %>" class = "regsubmit2 body" width = 280 style="width: 280px">
						</td>
					</tr>
					<tr>
						<td align = "right">
							Password:
						</td>
						<td align = "left">	
							<input type= password name=password value= "" SIZE = "12" class = "regsubmit2 body" width = 280 style="width: 280px">
						</td>
					</tr>
				</table>

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
	   	 <% End If %>
			<%
	
			If live = False Then %>
	   <center>
	   <H2>Temporarily Unavailable</h2>Currently we are improving the website. The administration area will be available soon. We are sorry for any inconvenience.</center>

	      <% End if%>
		</td>
		<% if mobiledevice = False  then %>
		<td width = "5"><img src = "images/px.gif" height="0" width = "0"></td>
		<td width = "1" bgcolor = "black"><img src = "images/px.gif" height="0" width = "0"></td>
		<td width = "5"><img src = "images/px.gif" height="0" width = "0"></td>
		<% else %>
		</tr>
		<tr>
		<% end if %>

		<TD class = "body2" width = "50%" valign = "top" align = "center">	
		<br />
<h2><center>Forgot Your Password?</center></H2>
			
			<a href = "AdminSendPassword.asp" class = "body">Click Here</a> to have your password<br />emailed to you.
			
	  </TD>
	</tr>
</table>	

