<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
<HEAD>
 <title>Change Password</title>
       <link rel="stylesheet" type="text/css" href="/Administration/style.css">

</HEAD>

<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  >



<!--#Include virtual="/Administration/Header.asp"--> 
<img src = "images/Passwordheader.jpg">
<table width = "720" height = "300"  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>

		
<td class = "body" valign = "top">

<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 bordercolor = "" align = "center" width = "300">
	<tr>
		<td class = "body" bgcolor ="cccccc">
			<a name="Ancestry"></a>
			<h2><center><b>Change Password</b></center> </h2>
      </td>
	</tr>
	
<form action= 'Adminupdatepassword.asp' method = "post">
	<tr >
		<td  align = "center" class = "body">
			New Password: <input name="Password" type = "password" size = "12" value="">
		</td>
	</tr>
<tr>
		<td  valign = "middle" class = "body">
			<img src = "images/underline.jpg" width = "300">
			<div align = "center">
			<Input type = Hidden name='CustID' value = <%=session("CustID")%> >
			<input type=submit value = "Submit Changes" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" class = "menu" >
			</form>
		</td>

</tr>
</table>
		</td>

</tr>
</table>


</Body>
</HTML>