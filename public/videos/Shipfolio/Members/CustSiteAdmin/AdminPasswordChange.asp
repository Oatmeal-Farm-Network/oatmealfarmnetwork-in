<!DOCTYPE HTML>

<HTML>
<HEAD>
<title>The Andresen Group Content Management System</title>
<link rel="stylesheet" type="text/css" href="style.css"> 
  <!--#Include file="AdminSecurityInclude.asp"--> 
    <!--#Include file="AdminGlobalVariables.asp"--> 
</HEAD>
<body >
    <!--#Include File="AdminHeader.asp"-->

<% message = Request.Querystring("message")

 %>
     <%    Current3="Password" %> 
  <% if mobiledevice = False  then %>   
<!--#Include file="AdminAccountTabsInclude.asp"-->
   <table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
		<H1><div align = "left">Change Your Password</div></H1>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" width = "980"> 
<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "900" align = "center" >
		<tr>
		<td class = "body" >
				<% if len(Message)> 2 then %><br>
	<b><big><font color = "brown"><%=Message %></font></b></big><br><br>
	<% end if %>
			To change your password please enter your new password below twice:<br>
      </td>
	</tr>
	
</table>
<table width = "900" height = "100"  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "center">
	<tr>
	
		
<td class = "body" valign = "top">
	
	
<form action= 'AdminPasswordUpdate.asp' method = "post">
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 bordercolor = "" align = "center" width = "500">
	<tr >
		<td  align = "right" class = "body" width= "140">
			New Password:
		</td>
		<td  class = "body">
			<input name="Password" type = "password" size = "20" value=""> (6 or more characters)
		</td>
	</tr>
	<tr >
		<td  align = "right" class = "body" width= "140">
			Reenter Password:
		</td>
		<td  class = "body">
			<input name="Password2" type = "password" size = "20" value=""> (6 or more characters)
		</td>
</tr>
<tr>
		<td  valign = "middle" colspan = "2" class = "body">
			
			<div align = "center">
			<Input type = Hidden name='CustID' value = <%=session("CustID")%> >
			<input type=submit value = "Submit Changes"  size = "110" class = "regsubmit2" >
</td></tr></table>
</form>
		</td>
</tr>
</table>
<br><br></td>
</tr>
</table>
<% else %>


   <table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=pagewidth %>"><tr><td  class = "body">
		<a href = "AdminAccountMaintenance.asp" class = "body"><b>Edit Contact Info</b></a><br /><br />
		
		<H1><div align = "left">Change Your Password</div></H1>
		
        </td></tr>
        <tr><td  align = "center" width = "100%"> 
<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  width = "100%" align = "center" >
		<tr>
		<td class = "body" >
				<% if len(Message)> 2 then %><br>
	<b><big><font color = "brown"><%=Message %></font></b></big><br><br>
	<% end if %>
			Please enter your new password below twice:<br>
      </td>
	</tr>
	
<form action= 'AdminPasswordUpdate.asp' method = "post">
	<tr >
		<td  align = "right" class = "body" width= "140">
			<b>New Password:</b><br />
			<input name="Password" type = "password" size = "20" class = "regsubmit2 body" value=""><br />
			<b>Reenter Password:</b><br />
			<input name="Password2" type = "password" size = "20" class = "regsubmit2 body" value="">
				<div align = "center">
			<Input type = Hidden name='CustID' value = <%=session("CustID")%> >
			<input type=submit value = "Submit Changes"  class = "regsubmit2 body" >
</td></tr></table>
</form>
		</td>
</tr>
</table>
<br><br>

<% end if %>
<br><br>
<!--#Include File="AdminFooter.asp"-->
</Body>
</HTML>