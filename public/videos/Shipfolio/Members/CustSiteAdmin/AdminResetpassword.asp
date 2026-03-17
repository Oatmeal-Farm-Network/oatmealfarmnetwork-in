<!DOCTYPE HTML>

<HTML>
<HEAD>
<title>The Andresen Group Content Management System</title>
<link rel="stylesheet" type="text/css" href="/administration/style.css">
<!--#Include file="AdminSecurityInclude.asp"-->
<!--#Include file="AdminGlobalVariables.asp"-->
</HEAD>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">

<!--#Include file="AdminHeader.asp"-->

<table border = "0" bordercolor = "bbbbbb" cellpadding=0 cellspacing=0 width = "980" align = "center">
 <tr>
		<td colspan = "9" align = "center" class = "body">

<% 

CID= Request.querystring("CID")
sql = "select * from Users where CustID = " & CID

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   

PeopleFirstName = rs("custFirstName")
PeopleLastName = rs("custLastName")
email = rs("custEmail")
custPasswd = rs("custPasswd")
Message = request.querystring("Message") 
   
    
    Message2 = request.querystring("Message2") 
    AccessLevel = request.querystring("AccessLevel")
if len(Message) > 2 then 
%>
 <table border = "0" bordercolor = "bbbbbb"  cellpadding=0 cellspacing=0 width = "900" >
 <tr>
	<td  Class = "body">
		<font color = "brown"><b>Please correct the following issue(s):<blockquote><%=Message %></blockquote></b></font>
   </td>
  </tr>
 </table>
<% end if 

if len(Message2) > 5 then 
%>
 <table border = "0" bordercolor = "bbbbbb"  cellpadding=0 cellspacing=0 width = "900" >
 <tr>
	<td  Class = "body">
		<font color = "brown"><b><%=Message2%></b></font>
   </td>
  </tr>
 </table>
<% end if %>


<form name=myForm onSubmit="return validatePwd()" action= 'AdminResetpasswordhandleform.asp' method = "post">
<table border = "0" bordercolor = "bbbbbb"  cellpadding=0 cellspacing=0 width = "900"  >
 <tr>
		<td Class = "body">
			<h1>Reset a User's Password</h1>
			Please enter a new password twice. It needs to be at least 6 charecters long and free of spaces.
		</td>
	</tr>
</table>
<table border = "0" bordercolor = "bbbbbb" cellpadding=0 cellspacing=0 width = "900" bgcolor = "#CEBD99">
  <tr>
		<td  colspan = "4" align = "right" class = "body">&nbsp;</td>
	</tr>
	<tr>
	<td  align = "right" class = "body">
			Name:&nbsp;
		</td>
		<td  align = "left" class = "body">
					<%=PeopleFirstName%> &nbsp;<%=PeopleLastName%>
		</td>
	</tr>
	<tr>
		<td  align = "right" class = "body">
			Email:&nbsp;
		</td>
		<td  align = "left" class = "body">
			<%=email%>
		</td>
		<td  align = "right" class = "body">
			
		</td>
		<td  align = "left" class = "body">
			
		</td>
	</tr>
	<tr>
		<td  align = "right" class = "body">
			Password:&nbsp;
		</td>
		<td  align = "left" class = "body">
			<input name="pw1" value= "<%=custPasswd%>" type = "password" size = "30">
		</td>
		<td  align = "right" class = "body">
			Confirm Password:&nbsp;
		</td>
	<td  align = "left" class = "body">
				<input name="pw2" type = "password" value= "<%=custPasswd%>" size = "30">
		</td>
	</tr>
	<tr>
		<td  align = "right" class = "body"></td>
		<td colspan = "3" class = "body">
			<b><i>Password must be at least 6 charecters long, 12 charecters maximum, and have no spaces.</i></b><br><br>
		</td>
	</tr>
<tr>
		<td colspan = "4" valign = "middle" align = "center">
		<input name="CID" type = "hidden" value= "<%=CID%>" size = "30">

			<input type=submit value="Reset Password" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" Class = "menu" ><br>
<br>

	</td>
</tr>
</table>
</form>


</td>
</tr>
</table>
<!--#Include file="AdminFooter.asp"--> 

</Body>
</HTML>