<% Uploadpathwidth = len(WebLink & "/uploads/")
'response.write("URLUploadpath = " & WebLink & "/uploads/")


			conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
			Set rs = Server.CreateObject("ADODB.Recordset")
			
			sql = "select * from Photos where id = " & ID
				'response.write(sql)
				rs.Open sql, conn, 3, 3

				If rs.eof Then
					Query =  "INSERT INTO Photos (ID)" 
					Query =  Query & " Values (" &  ID & ")"

					'response.write(Query)
					
					Set DataConnection = Server.CreateObject("ADODB.Connection")

					DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 
					DataConnection.Execute(Query) 
				rs.close

				sql = "select * from Photos where id = " & ID
				
				rs.Open sql, conn, 3, 3
				
				End If 


					If Len(rs("ARI")) > 2 Then
						ARI= rs("ARI")
						'response.write(sql)
					else
						ARI = "/uploads/ImageNotAvailable.jpg"
					End If


					If Len(rs("Histogram")) > 2 Then
						Histogram= rs("Histogram")
						'response.write(sql)
					else
						Histogram = "/uploads/ImageNotAvailable.jpg"
					End If



				If Len(rs("Photo1")) > 2 Then
						File1= rs("Photo1")
						'response.write(sql)
			 
					else
						File1 = "/uploads/ImageNotAvailable.jpg"
					End If


					If Len(rs("Photo2")) > 2 Then
						File2= rs("Photo2")
						'response.write(sql)
					else
						File2 = "/uploads/ImageNotAvailable.jpg"
					End If
					
				If Len(rs("Photo3")) > 2 Then
						File3= rs("Photo3")
						'response.write(sql)
					else
						File3 = "/uploads/ImageNotAvailable.jpg"
					End If

					If Len(rs("Photo4")) > 2 Then
						File4= rs("Photo4")
						'response.write(sql)
					else
						File4 = "/uploads/ImageNotAvailable.jpg"
					End If

						If Len(rs("Photo5")) > 2 Then
						File5= rs("Photo5")
					else
						File5 = "/uploads/ImageNotAvailable.jpg"
					End If


				If Len(rs("Photo6")) > 2 Then
						File6= rs("Photo6")
					else
						File6 = "/uploads/ImageNotAvailable.jpg"
					End If

	If Len(rs("Photo7")) > 2 Then
						File7= rs("Photo7")
					else
						File7 = "/uploads/ImageNotAvailable.jpg"
					End If

						If Len(rs("Photo8")) > 2 Then
						File8= rs("Photo8")
					else
						File8 = "/uploads/ImageNotAvailable.jpg"
					End If

	     If len(rs("PhotoCaption1")) > 1 then
				   PhotoCaption1 = rs("PhotoCaption1")
		End If 
		 If len(rs("PhotoCaption2")) > 1 then
				   PhotoCaption2 = rs("PhotoCaption2")
		End If 
		 If len(rs("PhotoCaption3")) > 1 then
				   PhotoCaption3 = rs("PhotoCaption3")
		End If 
		 If len(rs("PhotoCaption4")) > 1 then
				   PhotoCaption4 = rs("PhotoCaption4")
		End If 
		 If len(rs("PhotoCaption5")) > 1 then
				   PhotoCaption5 = rs("PhotoCaption5")
		End If 
		 If len(rs("PhotoCaption6")) > 1 then
				   PhotoCaption6 = rs("PhotoCaption6")
		End If 
		 If len(rs("PhotoCaption1")) > 1 then
				   PhotoCaption1 = rs("PhotoCaption1")
		End If 
		 If len(rs("PhotoCaption7")) > 1 then
				   PhotoCaption7 = rs("PhotoCaption7")
		End If 
		If len(rs("PhotoCaption8")) > 1 then
				   PhotoCaption8 = rs("PhotoCaption8")
		End If 

'response.write(File5)

			str1 = ARI
			str2 = "''"
			If InStr(str1,str2) > 0 Then
				ARI= Replace(str1,  str2, "'")
			End If  
			
			str1 = Histogram
			str2 = "''"
			If InStr(str1,str2) > 0 Then
				Histogram= Replace(str1,  str2, "'")
			End If  


			str1 = File1
			str2 = "''"
			If InStr(str1,str2) > 0 Then
				File1= Replace(str1,  str2, "'")
			End If  	 

			str1 = File2
			str2 = "''"
			If InStr(str1,str2) > 0 Then
				File2= Replace(str1,  str2, "'")
			End If  	
			
			
			str1 = File3
			str2 = "''"
			If InStr(str1,str2) > 0 Then
				File3= Replace(str1,  str2, "'")
			End If  	 
			
			str1 = File4
			str2 = "''"
			If InStr(str1,str2) > 0 Then
				File4= Replace(str1,  str2, "'")
			End If  	 
			
			str1 = File5
			str2 = "''"
			If InStr(str1,str2) > 0 Then
				File5= Replace(str1,  str2, "'")
			End If  	 
			
			str1 = File6
			str2 = "''"
			If InStr(str1,str2) > 0 Then
				File6= Replace(str1,  str2, "'")
			End If  	
			
			str1 = File7
			str2 = "''"
			If InStr(str1,str2) > 0 Then
				File7= Replace(str1,  str2, "'")
			End If  
			
			str1 = File8
			str2 = "''"
			If InStr(str1,str2) > 0 Then
				File8= Replace(str1,  str2, "'")
			End If  


				rs.close
%>
 <table  border = "1" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "800"  bgcolor = "#FFCB5E">
		<tr>
			<td colspan = "2"><H1>Upload Photos for <%=Name%></H1></td>
		</tr>
</table>
<table  border = "1" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "800"  bgcolor = "antiquewhite">
<tr><td class = "body">

	
			<%  

Dim listalpacaName(100000)
	conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" 
	sql2 = "select * from Animals where CustID = " & Session("custID") & " order by Fullname ;"
'response.write(sql2)
	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	
	While Not rs2.eof  
		IDArray(acounter) = rs2("ID")
		listalpacaName(acounter) = rs2("FullName")
		'response.write (SSName(studcounter))

		acounter = acounter +1
		rs2.movenext
	Wend		
	
		rs2.close
		set rs2=nothing
		set conn = nothing



%>
		<font class = "body">
		<form  action="AdminPhotos.asp" method = "post">
			<h2>Select Another Alpaca</h2>
			Select an animal below and push the edit button to update an animal's photos:<br>
			  
			  <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
			   <tr>
				<td colspan ="30">
					&nbsp;
				</td>
				 <td class = "body">
					<br>Select one of your alpacas:
					<select size="1" name="ID">
					<option name = "AID0" value= "" selected></option>
					<% count = 1
						while count < acounter
						response.write(count)
					%>
						<option name = "AID1" value="<%=IDArray(count)%>">
							<%=listalpacaName(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
					<input type=submit value = "Select" size = "210" class = "menu" >
				</td>
			  </tr>
		    </table>
	 </form>
	 </font>
</td>
</tr>
</table>

<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "800">
  <tr><td>
	<div align = "right"><!--#Include file="Photosjumplinks.asp"--> </div>
</td>
</tr>
</table><table  border = "1" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "800"  bgcolor = "#FFCB5E">
		<tr>
			<td colspan = "2"><a name = "ARI"></a>	<h2>ARI Certificate</h2></td>
		</tr>
</table>
<table  border = "1" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "800"  bgcolor = "antiquewhite">
		<tr>
	
			<td class = "body">
					<form name="frmSend" method="POST" enctype="multipart/form-data" action="uploadARI.asp" >
						<% If Not (ARI = "/uploads/ImageNotAvailable.jpg") Then %>
									Current Image Name: 
									<% If Len(ARI)> Uploadpathwidth Then %>
											<b><%=right(ARI, Len(ARI) - Uploadpathwidth )%></b>
									<% Else %>
											<b><%=ARI %></b>
									<% End If %>
											<br>
						<% Else %>
							Current Certificate: <b>Not Defined</b><br>
						<% End If %>

						Upload New Certificate: <input name="attach1" type="file" size=45 >
						<input  type=submit value="Upload">
					</form>
					<form action= 'RemoveARI.asp' method = "post">
							Would you like to remove this Certificate? 
								<input type = "hidden" name="ID" value= "<%= ID %>" >
							<input type=submit value="Remove This Certificate">
					</form>
			</td>
		</table>
		<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "800">
  <tr><td>
	<div align = "right"><!--#Include file="Photosjumplinks.asp"--> </div>
</td>
</tr>
</table>
<a name = "Histogram"></a>
<table  border = "1" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "800"  bgcolor = "#FFCB5E">
		<tr>
			<td colspan = "2"><h2>Histogram</h2></td>
		</tr>
</table>
<table  border = "1" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "800"  bgcolor = "antiquewhite">
		<tr>
			<td class = "body">
					<form name="frmSend" method="POST" enctype="multipart/form-data" action="uploadHistogram.asp" >
						<% If Not (Histogram = "/uploads/ImageNotAvailable.jpg") Then %>
									Current Histogram: 
									<% If Len(Histogram)> Uploadpathwidth Then %>
											<b><%=right(Histogram, Len(Histogram) - Uploadpathwidth )%></b>
									<% Else %>
											<b><%=Histogram %></b>
									<% End If %>
											<br>
						<% Else %>
							Current Image Name: <b>Not Defined</b><br>
						<% End If %>
						Upload New Histogram: <input name="attach1" type="file" size=45 >
						<input  type=submit value="Upload">
					</form>
					<form action= 'RemoveHistogram.asp' method = "post">
							Would you like to remove this Histogram? 
								<input type = "hidden" name="ID" value= "<%= ID %>" >
							<input type=submit value="Remove This Histogram">
					</form>
			</td>
		</table>


<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "800">
  <tr><td>
	<div align = "right"><!--#Include file="Photosjumplinks.asp"--> </div>
</td>
</tr>
</table>
<a name = "Photos"></a>
<table  border = "1" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "800"  bgcolor = "#FFCB5E">
		<tr>
			<td colspan = "2"><h2>Main Image</h2></td>
		</tr>
</table>
<table  border = "1" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "800"  bgcolor = "antiquewhite">
		<tr>
			<td width = "150" align = "center">
					<img src = "<%=File1%>" height = "100">
					<center><b><%=PhotoCaption1%></b></center>
			</td>
			<td class = "body">
					<form name="frmSend" method="POST" enctype="multipart/form-data" action="uploadTester.asp" >
						<% If Not (File1 = "/uploads/ImageNotAvailable.jpg") Then %>
									Current Image Name: 
									<% If Len(file1)> Uploadpathwidth Then %>
											<b><%=right(File1, Len(File1) - Uploadpathwidth)%></b>
									<% Else %>
											<b><%=File1 %></b>
									<% End If %>
											<br>
						<% Else %>
							Current Image Name: <b>Not Defined</b><br>
						<% End If %>

						
						
					
						Upload New Photo: <input name="attach1" type="file" size=45 >
						<input  type=submit value="Upload">
					</form>
<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
						<tr>
							<td bgcolor = "#abacab" height = "2" width = "700"><img src = "images/px.gif" height = "2"></td>
						</tr>
					</table>
					<form action= 'AdminPhotoChangeOrder1.asp' method = "post">
						
					<input type = "hidden" name="CurrentPhoto" value= "1" >
					<input type = "hidden" name="ID" value= "<%= ID %>" >
					Photo Order:	<select size="1" name="PhotoOrder">
					<option value="1" selected>1</option>
					<option  value="2">2</option>
					<option  value="3">3</option>
					<option  value="4">4</option>
					<option  value="5">5</option>
					<option  value="6">6</option>
					<option  value="7">7</option>
					<option  value="8">8</option>
				</select>
							<input type=submit value="Submit">
					</form>

					
					 <form action= 'Addcaption.asp' method = "post">
						Caption (20 Character Max.): <input name="Caption" Value ="<%=PhotoCaption1%>"  size = "30" maxlength = "30">
							<input type = "hidden" name="CaptionID" value= "1" >
							<input type = "hidden" name="ID" value= "<%= ID %>" >
							<input type=submit value="Submit">
					</form>
<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
						<tr>
							<td bgcolor = "#abacab" height = "2" width = "700"><img src = "images/px.gif" height = "2"></td>
						</tr>
					</table>
					<form action= 'RemoveImage.asp' method = "post">
							Would you like to remove this image? 
							<input type = "hidden" name="ImageID" value= "1" >
							<input type = "hidden" name="ID" value= "<%= ID %>" >
							<input type=submit value="Remove This Image">
					</form>
			</td>
		</table>

<table  border = "1" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "800"  bgcolor = "#FFCB5E">
		<tr>
			<td colspan = "2"><h2>Image 2</h2></td>
		</tr>
</table>
<table  border = "1" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "800"  bgcolor = "antiquewhite">
		<tr>
			<td width = "150" align = "center" class = "body">
					<img src = "<%=File2%>" height = "100">
					<center><b><%=PhotoCaption2%></b></center>
			</td>
			<td class = "body">
					<form name="frmSend" method="POST" enctype="multipart/form-data" action="uploadTester2.asp" onSubmit="return onSubmitForm();">
						<% If Not (File2 = "/uploads/ImageNotAvailable.jpg") Then %>
									Current Image Name: 
									<% If Len(file2)> Uploadpathwidth Then %>
											<b><%=right(File2, Len(File2) - Uploadpathwidth)%></b>
									<% Else %>
											<b><%=File2 %></b>
									<% End If %>
											<br>
						<% Else %>
							Current Image Name: <b>Not Defined</b><br>
						<% End If %>

						Upload New Photo: <input name="attach1" type="file" size=45 >
						<input  type=submit value="Upload">
					</form>
					<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
						<tr>
							<td bgcolor = "#abacab" height = "2" width = "700"><img src = "images/px.gif" height = "2"></td>
						</tr>
					</table>
					<form action= 'AdminPhotoChangeOrder1.asp' method = "post">
						
					<input type = "hidden" name="CurrentPhoto" value= "2" >
					<input type = "hidden" name="ID" value= "<%= ID %>" >
					Photo Order:	<select size="1" name="PhotoOrder">
					<option value="2" selected>2</option>
					<option  value="1">1</option>
					<option  value="3">3</option>
					<option  value="4">4</option>
					<option  value="5">5</option>
					<option  value="6">6</option>
					<option  value="7">7</option>
					<option  value="8">8</option>
				</select>
							<input type=submit value="Submit">
					</form>


					  <form action= 'Addcaption.asp' method = "post">
						Caption (20 Character Max.): <input name="Caption" Value ="<%=PhotoCaption2%>"  size = "30" maxlength = "30">
							<input type = "hidden" name="CaptionID" value= "2" >
							<input type = "hidden" name="ID" value= "<%= ID %>" >
							<input type=submit value="Submit">
					</form>
						
					<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
						<tr>
							<td bgcolor = "#abacab" height = "2" width = "700"><img src = "images/px.gif" height = "2"></td>
						</tr>
					</table>
					<form action= 'RemoveImage.asp' method = "post">
							Would you like to remove this image? 
							<input type = "hidden" name="ImageID" value= "2" >
							<input type = "hidden" name="ID" value= "<%= ID %>" >
							<input type=submit value="Remove This Image">
					</form>
			</td>
		</table>
  
 <table  border = "1" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "800"  bgcolor = "#FFCB5E">
		<tr>
			<td colspan = "2"><h2>Image3</h2></td>
		</tr>
</table>
<table  border = "1" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "800"  bgcolor = "antiquewhite">
		<tr>
			<td width = "150" align = "center" class = "body">
					<img src = "<%=File3%>" height = "100">
					<center><b><%=PhotoCaption3%></b></center>
			</td>
			<td class = "body">
					<form name="frmSend" method="POST" enctype="multipart/form-data" action="uploadTester3.asp" onSubmit="return onSubmitForm();">
						<% If Not (File3 = "/uploads/ImageNotAvailable.jpg") Then %>
									Current Image Name: 
									<% If Len(file3)> Uploadpathwidth Then %>
											<b><%=right(File3, Len(File3) -Uploadpathwidth)%></b>
									<% Else %>
											<b><%=File3 %></b>
									<% End If %>
											<br>
						<% Else %>
							Current Image Name: <b>Not Defined</b><br>
						<% End If %>
						Upload New Photo: <input name="attach1" type="file" size=45 >
						<input  type=submit value="Upload">
					</form>
<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
						<tr>
							<td bgcolor = "#abacab" height = "2" width = "700"><img src = "images/px.gif" height = "2"></td>
						</tr>
					</table>
					
					<form action= 'AdminPhotoChangeOrder1.asp' method = "post">
						
					<input type = "hidden" name="CurrentPhoto" value= "3" >
					<input type = "hidden" name="ID" value= "<%= ID %>" >
					Photo Order:	<select size="1" name="PhotoOrder">
					<option value="3" selected>3</option>
					<option  value="1">1</option>
					<option  value="2">2</option>
					<option  value="4">4</option>
					<option  value="5">5</option>
					<option  value="6">6</option>
					<option  value="7">7</option>
					<option  value="8">8</option>
				</select>
							<input type=submit value="Submit">
					</form>


 <form action= 'Addcaption.asp' method = "post">
						Caption (20 Character Max.): <input name="Caption" Value ="<%=PhotoCaption3%>"  size = "30" maxlength = "30">
							<input type = "hidden" name="CaptionID" value= "3" >
							<input type = "hidden" name="ID" value= "<%= ID %>" >
							<input type=submit value="Submit">
					</form>
					<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
						<tr>
							<td bgcolor = "#abacab" height = "2" width = "700"><img src = "images/px.gif" height = "2"></td>
						</tr>
					</table>
					<form action= 'RemoveImage.asp' method = "post">
							Would you like to remove this image? 
							<input type = "hidden" name="ImageID" value= "3" >
							<input type = "hidden" name="ID" value= "<%= ID %>" >
							<input type=submit value="Remove This Image">
					</form>
			</td>
		</table>
  
   <table  border = "1" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "800"  bgcolor = "#FFCB5E">
		<tr>
			<td colspan = "2"><h2>Image 4</h2></td>
		</tr>
</table>
<table  border = "1" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "800"  bgcolor = "antiquewhite">
		<tr>
			<td width = "150" align = "center" class = "body">
					<img src = "<%=File4%>" height = "100">
					<center><b><%=PhotoCaption4%></b></center>
			</td>
			<td class = "body">
					<form name="frmSend" method="POST" enctype="multipart/form-data" action="uploadTester4.asp" onSubmit="return onSubmitForm();">
					<% If Not (File4 = "/uploads/ImageNotAvailable.jpg") Then %>
									Current Image Name: 
									<% If Len(file4)> Uploadpathwidth Then %>
											<b><%=right(File4, Len(File4) -Uploadpathwidth)%></b>
									<% Else %>
											<b><%=File4 %></b>
									<% End If %>
											<br>
						<% Else %>
							Current Image Name: <b>Not Defined</b><br>
						<% End If %>
						Upload New Photo: <input name="attach1" type="file" size=45 >
						<input  type=submit value="Upload">
					</form>
<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
						<tr>
							<td bgcolor = "#abacab" height = "2" width = "700"><img src = "images/px.gif" height = "2"></td>
						</tr>
					</table>
						<form action= 'AdminPhotoChangeOrder1.asp' method = "post">
						
					<input type = "hidden" name="CurrentPhoto" value= "4" >
					<input type = "hidden" name="ID" value= "<%= ID %>" >
					Photo Order:	<select size="1" name="PhotoOrder">
					<option value="4" selected>4</option>
					<option  value="1">1</option>
					<option  value="2">2</option>
					<option  value="3">3</option>
					<option  value="5">5</option>
					<option  value="6">6</option>
					<option  value="7">7</option>
					<option  value="8">8</option>
				</select>
							<input type=submit value="Submit">
					</form>


				 <form action= 'Addcaption.asp' method = "post">
						Caption (20 Character Max.): <input name="Caption" Value ="<%=PhotoCaption4%>"  size = "30" maxlength = "30">
							<input type = "hidden" name="CaptionID" value= "4" >
							<input type = "hidden" name="ID" value= "<%= ID %>" >
							<input type=submit value="Submit">
					</form>
					<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
						<tr>
							<td bgcolor = "#abacab" height = "2" width = "700"><img src = "images/px.gif" height = "2"></td>
						</tr>
					</table>
					<form action= 'RemoveImage.asp' method = "post">
							Would you like to remove this image? 
							<input type = "hidden" name="ImageID" value= "4" >
							<input type = "hidden" name="ID" value= "<%= ID %>" >
							<input type=submit value="Remove This Image">
					</form>
			</td>
		</table>
  
 <table  border = "1" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "800"  bgcolor = "#FFCB5E">
		<tr>
			<td colspan = "2"><h2>Image5</h2></td>
		</tr>
</table>
<table  border = "1" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "800"  bgcolor = "antiquewhite">
		<tr>
			<td width = "150" align = "center" class = "body">
					<img src = "<%=File5%>" height = "100">
					<center><b><%=PhotoCaption5%></b></center>
			</td>
			<td class = "body">
					<form name="frmSend" method="POST" enctype="multipart/form-data" action="uploadTester5.asp" onSubmit="return onSubmitForm();">
						<% If Not (File5 = "/uploads/ImageNotAvailable.jpg") Then %>
									Current Image Name: 
									<% If Len(file5)> Uploadpathwidth Then %>
											<b><%=right(File5, Len(File5) -Uploadpathwidth)%></b>
									<% Else %>
											<b><%=File5 %></b>
									<% End If %>
											<br>
						<% Else %>
							Current Image Name: <b>Not Defined</b><br>
						<% End If %>
						Upload New Photo: <input name="attach1" type="file" size=45 >
						<input  type=submit value="Upload">
					</form>
<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
						<tr>
							<td bgcolor = "#abacab" height = "2" width = "700"><img src = "images/px.gif" height = "2"></td>
						</tr>
					</table>
						<form action= 'AdminPhotoChangeOrder1.asp' method = "post">
						
					<input type = "hidden" name="CurrentPhoto" value= "5" >
					<input type = "hidden" name="ID" value= "<%= ID %>" >
					Photo Order:	<select size="1" name="PhotoOrder">
					<option value="5" selected>5</option>
					<option  value="1">1</option>
					<option  value="2">2</option>
					<option  value="3">3</option>
					<option  value="4">4</option>
					<option  value="6">6</option>
					<option  value="7">7</option>
					<option  value="8">8</option>
				</select>
							<input type=submit value="Submit">
					</form>

				 <form action= 'Addcaption.asp' method = "post">
						Caption (20 Character Max.): <input name="Caption" Value ="<%=PhotoCaption5%>"  size = "30" maxlength = "30">
							<input type = "hidden" name="CaptionID" value= "5" >
							<input type = "hidden" name="ID" value= "<%= ID %>" >
							<input type=submit value="Submit">
					</form>
					<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
						<tr>
							<td bgcolor = "#abacab" height = "2" width = "700"><img src = "images/px.gif" height = "2"></td>
						</tr>
					</table>
					<form action= 'RemoveImage.asp' method = "post">
							Would you like to remove this image? 
							<input type = "hidden" name="ImageID" value= "5" >
							<input type = "hidden" name="ID" value= "<%= ID %>" >
							<input type=submit value="Remove This Image">
					</form>
			</td>
		</table>
  
 <table  border = "1" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "800"  bgcolor = "#FFCB5E">
		<tr>
			<td colspan = "2"><h2>Image 6</h2></td>
		</tr>
</table>
<table  border = "1" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "800"  bgcolor = "antiquewhite">
		<tr>
			<td width = "150" align = "center" class = "body">
					<img src = "<%=File6%>" height = "100">
					<center><b><%=PhotoCaption6%></b></center>
			</td>
			<td class = "body">
					<form name="frmSend" method="POST" enctype="multipart/form-data" action="uploadTester6.asp" onSubmit="return onSubmitForm();">
						<% If Not (File6 = "/uploads/ImageNotAvailable.jpg") Then %>
									Current Image Name: 
									<% If Len(file6)> Uploadpathwidth Then %>
											<b><%=right(File6, Len(File6) -Uploadpathwidth)%></b>
									<% Else %>
											<b><%=File6 %></b>
									<% End If %>
											<br>
						<% Else %>
							Current Image Name: <b>Not Defined</b><br>
						<% End If %>
						Upload New Photo: <input name="attach1" type="file" size=45 >
						<input  type=submit value="Upload">
					</form>
<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
						<tr>
							<td bgcolor = "#abacab" height = "2" width = "700"><img src = "images/px.gif" height = "2"></td>
						</tr>
					</table>
					<form action= 'AdminPhotoChangeOrder1.asp' method = "post">
					<input type = "hidden" name="CurrentPhoto" value= "6" >
					<input type = "hidden" name="ID" value= "<%= ID %>" >
					Photo Order:	<select size="1" name="PhotoOrder">
					<option value="6" selected>6</option>
					<option  value="1">1</option>
					<option  value="2">2</option>
					<option  value="3">3</option>
					<option  value="4">4</option>
					<option  value="5">5</option>
					<option  value="7">7</option>
					<option  value="8">8</option>
				</select>
							<input type=submit value="Submit">
					</form>


					 <form action= 'Addcaption.asp' method = "post">
						Caption (20 Character Max.): <input name="Caption" Value ="<%=PhotoCaption6%>"  size = "30" maxlength = "30">
							<input type = "hidden" name="CaptionID" value= "6" >
							<input type = "hidden" name="ID" value= "<%= ID %>" >
							<input type=submit value="Submit">
					</form>
					<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
						<tr>
							<td bgcolor = "#abacab" height = "2" width = "700"><img src = "images/px.gif" height = "2"></td>
						</tr>
					</table>
					<form action= 'RemoveImage.asp' method = "post">
							Would you like to remove this image? 
							<input type = "hidden" name="ImageID" value= "6" >
							<input type = "hidden" name="ID" value= "<%= ID %>" >
							<input type=submit value="Remove This Image">
					</form>
			</td>
		</table>
  
 <table  border = "1" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "800"  bgcolor = "#FFCB5E">
		<tr>
			<td colspan = "2"><h2>Image 7</h2></td>
		</tr>
</table>
<table  border = "1" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "800"  bgcolor = "antiquewhite">
		<tr>
			<td width = "150" align = "center" class = "body">
					<img src = "<%=File7%>" height = "100">
					<center><b><%=PhotoCaption7%></b></center>
			</td>
			<td class = "body">
					<form name="frmSend" method="POST" enctype="multipart/form-data" action="uploadTester7.asp" onSubmit="return onSubmitForm();">
						<% If Not (File7 = "/uploads/ImageNotAvailable.jpg") Then %>
									Current Image Name: 
									<% If Len(file7)> Uploadpathwidth Then %>
											<b><%=right(File7, Len(File7) -Uploadpathwidth)%></b>
									<% Else %>
											<b><%=File7 %></b>
									<% End If %>
											<br>
						<% Else %>
							Current Image Name: <b>Not Defined</b><br>
						<% End If %>
						Upload New Photo: <input name="attach1" type="file" size=45 >
						<input  type=submit value="Upload">
					</form>
<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
						<tr>
							<td bgcolor = "#abacab" height = "2" width = "700"><img src = "images/px.gif" height = "2"></td>
						</tr>
					</table>
					
							<form action= 'AdminPhotoChangeOrder1.asp' method = "post">
					<input type = "hidden" name="CurrentPhoto" value= "7" >
					<input type = "hidden" name="ID" value= "<%= ID %>" >
					Photo Order:	<select size="1" name="PhotoOrder">
					<option value="7" selected>7</option>
					<option  value="1">1</option>
					<option  value="2">2</option>
					<option  value="3">3</option>
					<option  value="4">4</option>
					<option  value="5">5</option>
					<option  value="6">6</option>
					<option  value="8">8</option>
				</select>
							<input type=submit value="Submit">
					</form>



				 <form action= 'Addcaption.asp' method = "post">
						Caption (20 Character Max.): <input name="Caption" Value ="<%=PhotoCaption7%>"  size = "30" maxlength = "30">
							<input type = "hidden" name="CaptionID" value= "7" >
							<input type = "hidden" name="ID" value= "<%= ID %>" >
							<input type=submit value="Submit">
					</form>
<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
						<tr>
							<td bgcolor = "#abacab" height = "2" width = "700"><img src = "images/px.gif" height = "2"></td>
						</tr>
					</table>
					<form action= 'RemoveImage.asp' method = "post">
							Would you like to remove this image? 
							<input type = "hidden" name="ImageID" value= "7" >
							<input type = "hidden" name="ID" value= "<%= ID %>" >
							<input type=submit value="Remove This Image">
					</form>
					
			</td>
		</table>
  
 <table  border = "1" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "800"  bgcolor = "#FFCB5E">
		<tr>
			<td colspan = "2"><h2>Image 8</h2></td>
		</tr>
</table>
<table  border = "1" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "800"  bgcolor = "antiquewhite">
		<tr>
			<td width = "150" align = "center" class = "body">
					<img src = "<%=File8%>" height = "100">
					<center><b><%=PhotoCaption8%></b></center>
			</td>
			<td class = "body">
					<form name="frmSend" method="POST" enctype="multipart/form-data" action="uploadTester8.asp" onSubmit="return onSubmitForm();">
						<% If Not (File8 = "/uploads/ImageNotAvailable.jpg") Then %>
									Current Image Name: 
									<% If Len(file8)> Uploadpathwidth Then %>
											<b><%=right(File8, Len(File8) - Uploadpathwidth)%></b>
									<% Else %>
											<b><%=File8 %></b>
									<% End If %>
											<br>
						<% Else %>
							Current Image Name: <b>Not Defined</b><br>
						<% End If %>
						Upload New Photo: <input name="attach1" type="file" size=45 >
						<input  type=submit value="Upload">
					</form>
<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
						<tr>
							<td bgcolor = "#abacab" height = "2" width = "700"><img src = "images/px.gif" height = "2"></td>
						</tr>
					</table>
				<form action= 'AdminPhotoChangeOrder1.asp' method = "post">
					<input type = "hidden" name="CurrentPhoto" value= "8" >
					<input type = "hidden" name="ID" value= "<%= ID %>" >
					Photo Order:	<select size="1" name="PhotoOrder">
					<option value="8" selected>8</option>
					<option  value="1">1</option>
					<option  value="2">2</option>
					<option  value="3">3</option>
					<option  value="4">4</option>
					<option  value="5">5</option>
					<option  value="6">6</option>
					<option  value="7">7</option>
				</select>
							<input type=submit value="Submit">
					</form>


					 <form action= 'Addcaption.asp' method = "post">
						Caption (20 Character Max.): <input name="Caption" Value ="<%=PhotoCaption8%>"  size = "30" maxlength = "30">
							<input type = "hidden" name="CaptionID" value= "8" >
							<input type = "hidden" name="ID" value= "<%= ID %>" >
							<input type=submit value="Submit">
					</form>
<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
						<tr>
							<td bgcolor = "#abacab" height = "2" width = "700"><img src = "images/px.gif" height = "2"></td>
						</tr>
					</table>
					
					<form action= 'RemoveImage.asp' method = "post">
							Would you like to remove this image? 
							<input type = "hidden" name="ImageID" value= "8" >
							<input type = "hidden" name="ID" value= "<%= ID %>" >
							<input type=submit value="Remove This Image">
					</form>
			</td>
		</table>
		
		<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "800">
  <tr><td>
	<div align = "right"><!--#Include file="Photosjumplinks.asp"--> </div>
</td>
</tr>
</table>
