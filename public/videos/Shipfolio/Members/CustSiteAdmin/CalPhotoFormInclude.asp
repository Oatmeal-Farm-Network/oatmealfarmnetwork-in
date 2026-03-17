<!--#Include file="LinksHeader.asp"--> 

<%

			conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
			Set rs = Server.CreateObject("ADODB.Recordset")
			
			sql = "select * from Links where Linkid = " & LinkID
				'response.write(sql)
				rs.Open sql, conn, 3, 3

				If rs.eof Then
					Query =  "INSERT INTO Links (ID)" 
					Query =  Query & " Values (" &  LinkID & ")"

					'response.write(Query)
					
					Set DataConnection = Server.CreateObject("ADODB.Connection")

					DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 
					DataConnection.Execute(Query) 
				rs.close

				sql = "select * from Links where LinkID = " & LinkID
				'response.write(sql)
				rs.Open sql, conn, 3, 3
				
				End If 

					If Len(rs("LinkImage")) > 2 Then
							File1= rs("LinkImage")
				else
						File1 = "ImageNotAvailable.jpg"
					End if

				

			str1 = File1
			str2 = "''"
			If InStr(str1,str2) > 0 Then
				File1= Replace(str1,  str2, "'")
			End If  	 

			TempLinkText = rs("LinkText")

	rs.close
			
%>
    <table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "800">
		<tr>
			<td class = "body">
				<H1>Upload Image for <%=TempLinkText %></H1>			
			</td>
		</tr>
	</table>


	
			<%  
Dim LinkImage(1000)
Dim LinkText(1000)
Dim LinkIDArray(1000)

	conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
	"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" 
	sql2 = "select * from Links order by LinkText ;"
'response.write(sql2)
	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	
	While Not rs2.eof  
		LinkIDArray(acounter) = rs2("LinkID")
		LinkText(acounter) = rs2("Linktext")
		LinkImage(acounter) = rs2("LinkImage")
		'response.write (SSName(studcounter))

		acounter = acounter +1
		rs2.movenext
	Wend		
	
		rs2.close
		set rs2=nothing
		set conn = nothing



%>
		<font class = "body">
		<form  action="adminlinkphotos.asp" method = "post">
			<h2>Select Another Link</h2>
			Select a link below and push the edit button to update an link:<br>
			  
			  <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
			   <tr>
				<td colspan ="30">
					&nbsp;
				</td>
				 <td class = "body">
					<br>Select one of your links:
					<select size="1" name="LinkID">
					<option name = "ALinkID0" value= "" selected></option>
					<% count = 1
						while count < acounter
						response.write(count)
					%>
						<option name = "ALinkID1" value="<%=LinkIDArray(count)%>">
							<%=Linktext(count)%>
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
			<td colspan = "2">
				<h1>Link Image</h1>
			</td>
		</tr>
		<tr>
			<td width = "150" align = "center">
					<img src = "../../Uploads/Calendars/<%=File1%>" width = "100">
					
			</td>
			<td class = "body">
					<form name="frmSend" method="POST" enctype="multipart/form-data" action="uploadLinkImage.asp" >
						<% If Not (File1 = "ImageNotAvailable.jpg") Then %>
									Current Image Name: <b><%=File1%></b><br>
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
					<form action= 'LogoRemoveImage.asp' method = "post">
							Would you like to remove this image? 
							<input type = "hidden" name="ImageID" value= "1" >
							<input type = "hidden" name="LinkID" value= "<%= LinkID %>" >
							<input type=submit value="Remove This Image">
					</form>
			</td>
		</table>

		
  
    <br> 