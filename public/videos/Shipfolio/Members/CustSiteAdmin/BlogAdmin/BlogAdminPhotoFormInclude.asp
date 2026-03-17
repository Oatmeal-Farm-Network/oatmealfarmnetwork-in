 <!-- #include file="BlogAdminHeader.asp" -->


<%

			conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
	"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" 
			    Set rs = Server.CreateObject("ADODB.Recordset")
			sql = "select * from Blog where BlogID = " & BlogID
				'response.write(sql)
				rs.Open sql, conn, 3, 3

				If Len(rs("BlogImage")) > 1 then
						File1= rs("BlogImage")
				else
						File1 = "ImageNotAvailable.jpg"
			    End if

			
'response.write(File5)
			str1 = File1
			str2 = "''"
			If InStr(str1,str2) > 0 Then
				File1= Replace(str1,  str2, "'")
			End If  	 

		


%>
    <table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "800">
		<tr>
			<td class = "body">
				<H1>Upload Photo for <%=rs("BlogHeadline") %></H1>			
			</td>
		</tr>
	</table>


	
	
   <table Border = "1" Bgcolor = "#dddddd" width = "750" align = "center">
		<tr>
			<td colspan = "2">
				<h1>Main Image</h1>
			</td>
		</tr>
		<tr>
			<td width = "150" align = "center">
					<img src = "../../Uploads/<%=File1%>" height = "100">
					<center><b><%=PhotoCaption1%></b></center>
			</td>
			<td class = "body">
					<form name="frmSend" method="POST" enctype="multipart/form-data" action="BlogAdminUpLoadImage.asp" >
						<% If Not (File1 = "ImageNotAvailable.jpg") Then %>
									Current Image Name: <b><%=File1%></b><br>
						<% Else %>
							Current Image Name: <b>Not Defined</b><br>
						<% End If %>

						
						
					
						Upload New Photo: <input name="attach1" type="file" size=35 >
						<input  type=submit value="Submit">
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
					<form action= 'BlogAdminRemoveImage.asp' method = "post">
							Would you like to remove this image? 
							<input type = "hidden" name="ImageBlogID" value= "1" >
							<input type = "hidden" name="BlogID" value= "<%= BlogID %>" >
							<input type=submit value="Remove This Image">
					</form>
			</td>
		</table>

		
		<%	rs.close %>