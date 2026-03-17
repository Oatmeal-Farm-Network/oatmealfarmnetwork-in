<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ Language=VBScript %>

<HTML>
<HEAD>
 <title>Shipping Rates</title>
       <link rel="stylesheet" type="text/css" href="/administration/style.css">
		


</HEAD>

</head>
<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">


		<!--#Include virtual="/Administration/Header.asp"--> 
		<!--#Include file="storeHeader.asp"--> 
		<!--#Include virtual="/administration/adminDetailDBInclude.asp"--> 
		<H1>Shipping Rates</h1>

	

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



	<form action= 'ShippingHandleForm.asp' method = "post">
	<table width = "500" align = "center">
	<tr  >
		<td  width = "300"  class = "body" align = "right">
			Default Shipping Rate:<br>
			(Used if no shipping is defined)
		</td>
		<td width = "200" class = "body">
				$<input name="valdefaultRate" value= "<%=rs("valdefaultRate")%>" size = "10">
	   </td>
	 </tr>
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
			<img src = "images/underline.jpg" width = "400"><br>
			<Input type = Hidden name='TotalCount' value = <%=TotalCount%> >
			<input type=submit value = "Submit Changes" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" class = "menu" >
			</form>
		</td>
</tr>
</table>


 
<!--#Include file="Footer.asp"--> </Body>
</HTML>