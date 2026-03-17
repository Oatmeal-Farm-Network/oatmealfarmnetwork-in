<!DOCTYPE HTML>

<HTML>
<HEAD>
<title>The Andresen Group Content Management System</title>
<link rel="stylesheet" type="text/css" href="/administration/style.css"> 
   <!--#Include file="AdminSecurityInclude.asp"-->
    <!--#Include file="AdminGlobalVariables.asp"--> 
</head>
<body >
<!--#Include file="AdminHeader.asp"--> 
<% Current3 = "DeleteServices" %> 
<!--#Include virtual="/Administration/AdminServicesTabsInclude.asp"-->
 	<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Delete a Service</div></H2>
        </td></tr>
        <tr><td class = "roundedBottom body" align = "center" width = "960"  height = "200" valign = "top" >
     <div align = "left">
			To delete an service simply select it below and push the button.<br> <b>But careful. Once a service is deleted from your database, it's gone!</b></div><br><br>
		

<%  
dim ServicesID(40000)
dim ServiceTitle(40000)
dim aAdType(40000)

	conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" 
	sql2 = "select * from Services order by ServiceTitle "

	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	recordcount = rs2.recordcount
	While Not rs2.eof  
		ServicesID(acounter) = rs2("ServicesID")
		ServiceTitle(acounter) = rs2("ServiceTitle")

		'response.write (SSName(studcounter))

		acounter = acounter +1
		rs2.movenext
	Wend		
	
		rs2.close
		set rs2=nothing
		set conn = nothing
%>

<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 valign = "top" width = "900" height = "300" align = "center">
	<tr>
	<td width = "10">&nbsp;</td>
		<td class = "body" valign = "top" >
	
			<%If recordcount = 0 then %>		
					<h1>You do not currently have any services listed to delete.</h1>
			<% Else %>
			<form action= 'AdminServiceDeleteHandleForm.asp' method = "post">
				<input type = "hidden" name="PhotoType" value= "ListPage">
			   <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
			   <tr>
				 <td align = "center">
					<b>Service</b><br>
					<select size="1" name="ServiceTitle">
					<option  value= "" selected></option>
					<% count = 1
						while count < acounter
						response.write(count)
					%>
						<option  value="<%=ServiceTitle(count)%>">
							<%=ServiceTitle(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
				</td>
				<td>
					<br>
					<input type=submit value = "Delete Service"  class = "regsubmit2" >
				</td>
			  </tr>
			  <tr>
			     <td height = "200">&nbsp;
				 </td>
				</tr>
		    </table>
		  </form>
		  <% End If %>
		</td>
	</tr>
</table>
	</td>
	</tr>
</table>
<br />
<!--#Include file="AdminFooter.asp"--> </Body>
</HTML>