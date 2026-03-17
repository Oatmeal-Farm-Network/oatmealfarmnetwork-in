<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
</HEAD>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center" >
<!--#Include file="MembersGlobalVariables.asp"-->
 <% Current2="Packages"
 Current3="PackageAdLayout" %> 
 <!--#Include file="MembersHeader.asp"-->
<br>
<!--#Include file="MembersPackagesTabsInclude.asp"-->
	<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth %>"><tr><td class = "roundedtop" align = "left">
		<H1><div align = "left">Edit a  Package Layout</div></H1>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center">
<br />
<% 
packageID = request.Form("PackageID")
If Len(packageID) > 0 Then 
Else
packageID = request.querystring("PackageID")
End If 

%>
<br>
<% If Len(packageID) > 0 Then %>
<iframe src ="PackagesEditFrame.asp?packageid=<%=packageID%>" width = "920" height = "500" scrolling="no" frameborder = "0" allowTransparency="true" background = "images/loading.jpg"> <br />     
<p>Your browser does not support iframes.</p>
</iframe>


<% Else
	'response.redirect("EditPackageLayout")
End If %>

</td>
</tr>
</table>
<!-- #include virtual="Footer.asp" -->
</body>
</html>

