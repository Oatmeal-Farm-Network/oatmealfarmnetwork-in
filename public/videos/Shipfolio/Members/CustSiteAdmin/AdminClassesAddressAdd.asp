<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html >
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="/administration/style.css">
<!--#Include file="AdminGlobalVariables.asp"-->
 </head>
<% if mobiledevice = True  then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
<% end if  %>

<% Current = "admin" %>
<!--#Include file="AdminHeader.asp"-->
<% Current = "Classes"
Current3 = "Add Addresses" %>
<!--#Include File ="ClassesHeader.asp"--> 
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 class ="roundedtopandbottom" width = "<%=screenwidth -30%>" >
<tr><td haight = "560" valign = "top">

<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
<tr>
<td class = "body">
<a name="Add"></a>
<H2>Add a New Teaching Address<br>
</H2>
<br>
</td>
</tr>
</table>

<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
<form action= 'AdminClassesAddressAddhandleform.asp' method = "post">
<tr>
<td width = "190"  class = "body2" align = "right">
Title:
		</td>
		<td  class = "body">
			<input name="AddressTitle" size = "50">
		</td>
	</tr>
<tr>
<td  class = "body2" align = "right">
			Street Address:
		</td>
		<td>
			<input name="AddressStreet" size = "50">
		</td>
	</tr>
	<tr>
<td  class = "body2" align = "right">
			Address 2:
		</td>
		<td>
			<input name="AddressApt" size = "50">
		</td>
	</tr>
	<tr>
	<td  class = "body2" align = "right">
			City:
		</td>
		<td>
			<input name="AddressCity" size = "50">
		</td>
	</tr>
	<tr>
<td  class = "body2" align = "right">
			State:
		</td>
		<td>
			<input name="AddressState" size = "50">
		</td>
	</tr>
	<tr>
<td  class = "body2" align = "right">
			Zip:
		</td>
		<td>
			<input name="AddressZip" size = "50">
		</td>
	</tr>
<tr>
<td  class = "body2" align = "right">
			Phone:
		</td>
		<td>
			<input name="AddressPhone" size = "50" >
		</td>
	</tr>
<tr>
<td  class = "body2" align = "right">
Website:
		</td>
		<td>
			<small>http://</small><input name="AddressWebsite" size = "30">
		</td>
	</tr>
	<tr>
<td  class = "body2" align = "right" valign = "top">
Comments:
</td>
<td>
<TEXTAREA NAME="AddressComments" cols="38" rows="7"  ><%=AddressComments %></textarea>
</td>
	</tr>
	<tr>

<tr>
		<td  align = "center" valign = "middle" colspan = "2">
			<input type=submit value = "Add Address"  class = "regsubmit2" >
			</form>
</td>
</tr>
</table>
</td>
</tr>
</table>
<!--#Include file="AdminFooter.asp"--> </Body>
</HTML>