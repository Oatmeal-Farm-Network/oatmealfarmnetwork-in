<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<!--#Include file="MembersGlobalVariables.asp"-->
</HEAD>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center" >
 <% 
   Current2="Packages"
   Current3="PackageDelete" %> 
<!--#Include file="MembersHeader.asp"-->
<%
dim PackageID
PackageID=Request.Form("PackageID" ) 
If Len(PackageID)> 0 then 	
	Query =  "Delete  From Package where PackageID = " &  PackageID & "" 
  	Conn.Execute(Query) 

	Query =  "Delete  From PackageAnimals where PackageID = " &  PackageID & "" 
%>
<br>
<!--#Include file="MembersPackagesTabsInclude.asp"-->
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth %>"><tr><td class = "roundedtop" align = "left">
		<H1><div align = "left">Delete a Package</div></H1>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center">
<table width = "660" align = "center">
	<tr >
		<td align = "right">

<div align = "center"><H2>
<%
     response.write("Your package has successfully been deleted.")
  %></H2>
</div>
<%
Conn.Close
Set Conn = Nothing 
%>
<br><a  class = "body" href="PackagesDelete.asp" align = "left">Click here to delete another package.</a>
			<br><a  class = "body" href="EditPackage1.asp">Click here to edit a package.</a>
			<br>
		</td>
	</tr>
</table>


<% Else 
	'response.redirect("PackagesDelete.asp")
End If %>


<br><br>	</td>
	</tr>
</table><br><br>
<!--#Include virtual="/Footer.asp"--> 
</BODY>
</HTML>
