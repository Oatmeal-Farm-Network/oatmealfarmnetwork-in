<%
			conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
			Set rs = Server.CreateObject("ADODB.Recordset")
			
	  sql = "select * from Pagelayout where PageName = 'About Us'"
				'response.write(sql)
				rs.Open sql, conn, 3, 3

				Filename = rs("image1")
					If Len(Filename) > 2 Then
						File1 =Filename
				else
						File1 = "ImageNotAvailable.jpg"
					End if

				


'response.write(File5)
			str1 = File1
			str2 = "''"
			If InStr(str1,str2) > 0 Then
				File1= Replace(str1,  str2, "'")
			End If  	 

		



	str1 = File1
	str2 = "www"
	If Not(InStr(str1,str2) > 0) Then
	       File1 = "http://www.SOJAA.com/Uploads/Ranches/" & File1
	End If  

	

				rs.close
%>
   


	
			
		


   <table Border = "1" Bgcolor = "#c9c9a6" width = "650" align = "center">
		<tr>
			<td colspan = "2">
				<h1>Page Image</h1>
			</td>
		</tr>
		<tr>
			<td width = "150" align = "center">
					<img src = "<%=File1%>" height = "100">
					
			</td>
			<td class = "body">
					<form name="frmSend" method="POST" enctype="multipart/form-data" action="AboutUsuploadPageImage.asp" >
						<% If Not (File1 = "ImageNotAvailable.jpg") Then %>
									Current Image Name: <b><%=right(File1, Len(File1) - 37)%></b><br>
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
					<form action= 'RemoveRanchPageImage.asp' method = "post">
							Would you like to remove this image? 
							<input type = "hidden" name="ImageID" value= "AboutUsPageImage" >
							<input type=submit value="Remove This Image">
					</form>
			</td>
		</table>

		
  
    <br> 