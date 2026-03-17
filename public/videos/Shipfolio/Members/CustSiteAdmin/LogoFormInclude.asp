<table width = "720" height = "300"  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>
	<!--#Include virtual="/Administration/AdminSideMenu.html"--> 
		
<td class = "body" valign = "top">
<%
 CustID = session("CustID")

			conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
			Set rs = Server.CreateObject("ADODB.Recordset")
			
			sql = "select * from sfCustomers where CustID = " & CustID
				'response.write(sql)
				rs.Open sql, conn, 3, 3

			Logo = rs("Logo")

					
					 If Len(Logo) < 2 Then
						Logo = "ImageNotAvailable.jpg"
					End if

			'response.write(Logo)		

			str1 = Logo
			str2 = "''"
			If InStr(str1,str2) > 0 Then
				Logo= Replace(str1,  str2, "'")
			End If  	 

		
				rs.close
%>
    

	
	
		
   <table Border = "1" Bgcolor = "#dddddd" width = "630" align = "center">
		<tr>
			<td colspan = "2">
				<h1>Logo:</h1>
			</td>
		</tr>
		<tr>
			<td width = "150" align = "center">
					<img src = "../../Uploads/Logos/<%=Logo%>" height = "100">
					
			</td>
			<td class = "body">
					<form name="frmSend" method="POST" enctype="multipart/form-data" action="uploadLogohandle.asp" >
						<% If Not (Logo = "ImageNotAvailable.jpg") Then %>
									Current Logo Image Name: <b><%=Logo%></b><br>
						<% Else %>
							Current Logo Image Name: <b>Not Defined</b><br>
						<% End If %>

						
						
					
						Upload New Logo: <input name="attach1" type="file" size=35 ><br>
						<center><input  type=submit value="Upload"></center>
					</form>
<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
						<tr>
							<td bgcolor = "#abacab" height = "2" width = "700"><img src = "images/px.gif" height = "2"></td>
						</tr>
					</table>
					
<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
						<tr>
							<td bgcolor = "#abacab" height = "2" width = "700"><img src = "images/px.gif" height = "2"></td>
						</tr>
					</table>
					<form action= 'RemoveLogo.asp' method = "post">
							Would you like to remove this logo image? <br>
							<input type = "hidden" name="ImageID" value= "1" >
							<input type = "hidden" name="ID" value= "<%= ID %>" >
							<center><input type=submit value="Remove This Image"></center>
					</form>
			</td>
		</tr>
		</table>
				</td>
		</tr>
		</table>