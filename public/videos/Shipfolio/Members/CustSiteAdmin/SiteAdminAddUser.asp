<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<title><%=Sitenamelong %> Administration</title>
<meta name="Title" content="<%=Sitenamelong %> Administration"/>
<meta name="robots" content="nofollow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="revisit-after" content="1"/>
<meta name="Googlebot" content="nofollow"/>
<meta name="author" content="The Andresen Group"/>
<link rel="stylesheet" type="text/css" href="/style.css" />
<!--#Include file="AdminGlobalVariables.asp"-->
<% Current2 = "SiteAdmin" 
Current3 = "AddUsers" %> 
<!--#Include file="adminHeader.asp"-->
<% If not rs.State = adStateClosed Then
rs.close
End If   	
%>
<!--#Include file="SiteAdminTabsInclude.asp"-->
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 class ="roundedtopandbottom" width = "<%=screenwidth -30%>" >
<tr><td haight = "560" valign = "top">

<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>
		<td class = "body">
			<a name="Add"></a>
			<H2>Add a New User<br>
			</H2>
			<br>
		</td>
	</tr>
</table>

<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
		
	<form action= 'SiteAdminAddUserhandleform.asp' method = "post">
	<tr>
		<td width = "190"  class = "body2" align = "right">
			First Name:
		</td>
		<td  class = "body">
			<input name="PeopleFirstName" size = "50">
		</td>
	</tr>
    	<tr>
		<td  class = "body2" align = "right">
			Last Name:
		</td>
		<td  class = "body">
			<input name="PeopleLastName" size = "50">
		</td>
	</tr>
	<tr>
        	<tr>
		<td  class = "body2" align = "right">
			Owners:
		</td>
		<td  class = "body">
			<input name="Owners" size = "50">
		</td>
	</tr>
	<tr>
<td  class = "body2" align = "right">
			Ranch Name:
		</td>
		<td>
			<input name="BusinessName" size = "50">
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
			<input name="PeoplePhone" size = "50" >
		</td>
	</tr>
<tr>
<td  class = "body2" align = "right">
			Cell:
		</td>
		<td>
			<input name="PeopleCell" size = "50">
		</td>
	</tr>
	<tr>
<td  class = "body2" align = "right">
			FAX:
		</td>
		<td>
			<input name="PeopleFAX" size = "50">
		</td>
	</tr>
	<tr>
<td  class = "body2" align = "right">
			Email:
		</td>
		<td>
			<input name="PeopleEmail" size = "50">
		</td>
	</tr>
	<tr>
<td  class = "body2" align = "right">
			Password:
		</td>
		<td>
			<input name="PeoplePassword" size = "50">
		</td>
	</tr>
	<tr>
<td  class = "body2" align = "right">
			Website Address:
		</td>
		<td>
			<input name="PeopleWebsite" size = "50">
		</td>
</tr>
<tr>
		<td  align = "center" valign = "middle" colspan = "2">
			<input type=submit value = "Add user"  class = "regsubmit2" >
			</form>
		</td>
</tr>
</table>

<!--#Include virtual="/Footer.asp"--> </Body>
</HTML>