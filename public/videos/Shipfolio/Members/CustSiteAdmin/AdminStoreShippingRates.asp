<!DOCTYPE HTML>

<HTML>
<HEAD>
<title>The Andresen Group Content Management System</title>
<link rel="stylesheet" type="text/css" href="/administration/style.css"> 
  <!--#Include file="AdminSecurityInclude.asp"-->
<!--#Include file="AdminGlobalVariables.asp"--> 
</head>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">

<!--#Include file="AdminHeader.asp"--> 
 <%  Tabs = request.QueryString("Tabs")
Current3 = "Shipping"   
If Tabs = "Services" then
%> 
<!--#Include virtual="/Administration/AdminServicesTabsInclude.asp"-->
<% else %>
<!--#Include virtual="/Administration/AdminProductsTabsInclude.asp"-->
<% end if %>
 	<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Shipping Rates</div></H2>
        </td></tr>
        <tr><td class = "roundedBottom body" align = "center" width = "960"  height = "200" valign = "top" >   

<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center"  valign ="top"    width = "900">

	<tr><td>
	 

<%
conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
 sql = "select * from sfStandardShipping where  valID = 1"

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	rowcount = 1


Recordcount = rs.RecordCount +1
%>



	<form action= 'AdminStoreShippingHandleForm.asp' method = "post">
	<table width = "500" align = "center">
	<tr><td colspan = "2">
	<h2>Flat-Rate Shipping</h2>
	</td></tr>
	<tr  >
		<td  width = "300"  class = "body" align = "right">
			Rate Per Product:<br>
			</td>
		<td width = "200" class = "body">
				$<input name="valdefaultRate" value= "<%=rs("valdefaultRate")%>" size = "10">
	   </td>
	 </tr>
	 	<tr><td colspan = "2"><br />
	<h2>Weight-Based Shipping</h2>
	</td></tr>
	 <tr  >
		<td    class = "body" align = "right">
			Base Rate:<br>
			(Minimum Shipping Cost)
		</td>
		<td width = "200" class = "body">
				$<input name="valBaseRate" value= "<%=rs("valBaseRate")%>" size = "10">
	   </td>
	 </tr>
	  <tr  >
		<td    class = "body" align = "right">
			Added Rate:<br>
			(Added Shipping Cost / LBS)
		</td>
		<td width = "200" class = "body">
				$<input name="valAddedRate" value= "<%=rs("valAddedRate")%>" size = "10">/LBS
	   </td>
	 </tr>



<tr>
		<td colspan = "16" align = "center" valign = "middle">
			<Input type = Hidden name='TotalCount' value = <%=TotalCount%> >
			<input type=submit value = "Submit Changes"  class = "regsubmit2" >
			</form>
		</td>
</tr>
</table>
		</td>
</tr>
</table>

 </td>
</tr>
</table><br />
<!--#Include file="AdminFooter.asp"--> </Body>
</HTML>