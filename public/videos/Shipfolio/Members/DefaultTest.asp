<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>

<!--#Include file="MembersGlobalVariables.asp"-->
</HEAD>
<% if mobiledevice = True or is_iPad = true then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<% end if %>
<% 
Current1 = "MembersHome"
Current2="MembersHome" %> 
<!--#Include file="MembersHeader.asp"-->
screenwidth = <%=screenwidth %>
<table border = "1" cellpadding = "0" cellspacing="0"  width = "<%=screenwidth %>">
<tr><td class = "body" valign = "Top">

</td></tr></table>

<!--#Include file="MembersFooter.asp"--> 
</body></html>