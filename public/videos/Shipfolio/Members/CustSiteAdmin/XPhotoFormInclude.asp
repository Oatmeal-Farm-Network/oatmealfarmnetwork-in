
<%

			conn2 = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
			Set rs3 = Server.CreateObject("ADODB.Recordset")
			
			sql3 = "select * from ExternalStud where ExternalStudID = " & ID
				'response.write(sql)
				rs3.Open sql3, conn2, 3, 3
	
					ServiceSireImage = rs3("ServiceSireImage")
					If Len(ServiceSireImage) > 2 Then
						File1 =ServiceSireImage
					else
						File1= rs3("ServiceSireImage")
					End If
					 If Len(ServiceSireImage) < 2 Then
						File1 = "ImageNotAvailable.jpg"
					End if

'response.write(File5)
			str1 = ServiceSireImage
			str2 = "''"
			If InStr(str1,str2) > 0 Then
				ServiceSireImage= Replace(str1,  str2, "'")
			End If  	 

			



%>
    <table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "775">
		<tr>
			<td class = "body">
				<H1>Upload Photos for <%=rs3("AlpacaName")%></H1>			
			</td>
		</tr>
	</table>


	
			<%  

				rs3.close
		conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
	sql4 = "select * from ExternalStud order by Alpacaname"
'response.write(sql2)
	acounter = 1
	Set rs4 = Server.CreateObject("ADODB.Recordset")
	rs4.Open sql4, conn, 3, 3 
	
	While Not rs4.eof  
		IDArray(acounter) = rs4("ExternalStudID")
		alpacaName(acounter) = rs4("AlpacaName")
		'response.write (SSName(studcounter))

		acounter = acounter +1
		rs4.movenext
	Wend		
	
		rs4.close
		set rs4=nothing
		set conn = nothing



%>
		<font class = "body">
		<form  action="XAdminPhotos.asp" method = "post">
			<h2>Select Another Outside Stud</h2>
			Select an animal below and push the edit button to update an animal's photos:<br>
			  
			  <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
			   <tr>
				<td colspan ="30">
					&nbsp;
				</td>
				 <td class = "body">
					<br>Select one of listed outside studs:
					<select size="1" name="ID">
					<option name = "AID0" value= "" selected></option>
					<% count = 1
						while count < acounter
						'response.write(count)
					%>
						<option name = "AID1" value="<%=IDArray(count)%>">
							<%=alpacaName(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
					<input type=submit value = "Edit" style="background-image: url('images/background.jpg'); border-width:1px" size = "210" class = "menu" >
				</td>
			  </tr>
		    </table>
	 </form>
	 </font>
   <table Border = "1" Bgcolor = "#dddddd" width = "750" align = "center">
	
		<tr>
			<td width = "150" align = "center">
					<img src = "../../Uploads/<%=File1%>" height = "100">
					
			</td>
			<td class = "body">
					<form name="frmSend" method="POST" enctype="multipart/form-data" action="uploadxStud.asp" >
						<% If Not (File1 = "ImageNotAvailable.jpg") Then %>
									Current Image Name: <b><%=ServiceSireImage%></b><br>
						<% Else %>
							Current Image Name: <b>Not Defined</b><br>
						<% End If %>

						
						
					
						Upload New Photo: <input name="attach1" type="file" size=35 >
						<input  type=submit value="Upload">
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
					<form action= 'XRemoveImage.asp' method = "post">
							Would you like to remove this image? 
							<input type = "hidden" name="ImageID" value= "1" >
							<input type = "hidden" name="ID" value= "<%= ID %>" >
							<input type=submit value="Remove This Image">
					</form>
			</td>
		</table>

		
    <br> 