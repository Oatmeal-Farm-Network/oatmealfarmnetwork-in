<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<!--#Include virtual="/members/MembersGlobalVariables.asp"-->
</head>
<body border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center">
<% Current2="Business" 
Current3 = "DeleteBusiness" %> 
<!--#Include virtual="/members/MembersHeader.asp"-->
<% If not rs.State = adStateClosed Then
  rs.close
End If   	
%>
<!--#Include file="MembersPropertiesTabsInclude.asp"-->
<table width = "<%=screenwidth %>" height = "300"  class = "roundedtopandbottom" border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
<tr>
<td class = "body" valign = "top" width = "600" align = "left" height = "300" valign = "top" >
<table width = "600" border = "0" leftmargin="2" topmargin="2" marginwidth="2" marginheight="2"  cellpadding=2 cellspacing=2 align = "left">
<tr><td class = "body" valign = "top">
			 <br><H1>Delete a Property<br></H1>
			To delete an property listing simply select it below and push the button.<br> <b>But careful. Once a listing is deleted from your database, it's gone!</b><br><br>
</td></tr>
<tr><td>
<!--#Include file="DeletePropertyInclude.asp"--> 
</td></tr></table>
</td></tr></table>
<!--#Include virtual="/Footer.asp"-->
</body>
</HTML>