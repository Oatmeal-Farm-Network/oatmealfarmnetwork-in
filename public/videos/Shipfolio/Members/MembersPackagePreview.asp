<% SetLocale("en-us") %>
<html>

<head>
<!--#Include file="GlobalVariables.asp"-->

<title>Package Preview</title>

<meta name="author" content="WebArtists.biz">
<link rel="stylesheet" type="text/css" href="style.css">


</head>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   >

<!--#Include file="Header.asp"-->
<!--#Include file="PackagesHeader.asp"-->

<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center"  width = "600" valign ="top">
	<tr>		
		 <td  align = "center" valign ="top">
<%

conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(databasepath) & ";" & _
						"User Id=;Password=;" '& _ 
	' Get marketing text for the top of the page:
     conn2 = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(databasepath) & ";" & _
						"User Id=;Password=;" '& _ 
	' Get marketing text for the top of the page:
     

	sql = "SELECT  * from Package, sfcustomers where len(package.custid) > 0 and cint(package.custid) = cint(sfcustomers.custid) order by PackagePrice Desc" 
	'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
 
	While Not rs.eof %>
		<!--#Include file="PackageListInclude.asp"--> 
		
<%
rs.movenext
Wend %>


<div><a href = "#top" class ="body">&nbsp;Return to the top of this page</a></div><br><br>
			</td>
		</tr>
</table>


 <!--#Include file="Footer.asp"--> 
</body>
</html>

