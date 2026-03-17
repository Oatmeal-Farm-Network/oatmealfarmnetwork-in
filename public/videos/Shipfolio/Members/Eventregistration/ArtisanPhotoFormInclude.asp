<%

			conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
			Set rs = Server.CreateObject("ADODB.Recordset")
			
			sql = "select * from sfCustomizations where custid = " & CustID
				response.write(sql)
				rs.Open sql, conn, 3, 3

				If rs.eof Then
					Query =  "INSERT INTO sfCustomizations (CustID)" 
					Query =  Query & " Values (" &  CustID & ")"

					response.write(Query)
					
					Set DataConnection = Server.CreateObject("ADODB.Connection")

					DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 
					DataConnection.Execute(Query) 
				rs.close

							
			sql = "select * from sfCustomizations where custid = " & CustID
				'response.write(sql)
				rs.Open sql, conn, 3, 3

				End If 

					If Len(rs("AboutUsPhoto1")) > 2 Then
						File1= rs("AboutUsPhoto1")
					else
						File1 = "ImageNotAvailable.jpg"
					End if

					If Len(rs("AboutUsPhoto2")) > 2 Then
						File2= rs("AboutUsPhoto2")
					else
						File2 = "ImageNotAvailable.jpg"
					End If
					
					If Len(rs("AboutUsPhoto3")) > 2 Then
						File3= rs("AboutUsPhoto3")
					else
						File3 = "ImageNotAvailable.jpg"
					End if


					If Len(rs("AboutUsPhoto4")) > 2 Then
						File4= rs("AboutUsPhoto4")
					else
						File4 = "ImageNotAvailable.jpg"
					End if


				If Len(rs("AboutUsPhoto5")) > 2 Then
						File5= rs("AboutUsPhoto5")
					else
						File5 = "ImageNotAvailable.jpg"
					End if


					If Len(rs("AboutUsPhoto6")) > 2 Then
						File6= rs("AboutUsPhoto6")
					else
						File6 = "ImageNotAvailable.jpg"
					End if


				If Len(rs("AboutUsPhoto7")) > 2 Then
						File7= rs("AboutUsPhoto7")
					else
						File7 = "ImageNotAvailable.jpg"
					End if


				If Len(rs("AboutUsPhoto8")) > 2 Then
						File8= rs("AboutUsPhoto8")
					else
						File8 = "ImageNotAvailable.jpg"
					End if





	     If len(rs("AboutUsCaption1")) > 1 then
				   AboutUsCaption1 = rs("AboutUsCaption1")
		End If 
		 If len(rs("AboutUsCaption2")) > 1 then
				   AboutUsCaption2 = rs("AboutUsCaption2")
		End If 
		 If len(rs("AboutUsCaption3")) > 1 then
				   AboutUsCaption3 = rs("AboutUsCaption3")
		End If 
		 If len(rs("AboutUsCaption4")) > 1 then
				   AboutUsCaption4 = rs("AboutUsCaption4")
		End If 
		 If len(rs("AboutUsCaption5")) > 1 then
				   AboutUsCaption5 = rs("AboutUsCaption5")
		End If 
		 If len(rs("AboutUsCaption6")) > 1 then
				   AboutUsCaption6 = rs("AboutUsCaption6")
		End If 
		 If len(rs("AboutUsCaption1")) > 1 then
				   AboutUsCaption1 = rs("AboutUsCaption1")
		End If 
		 If len(rs("AboutUsCaption7")) > 1 then
				   AboutUsCaption7 = rs("AboutUsCaption7")
		End If 
		If len(rs("AboutUsCaption8")) > 1 then
				   AboutUsCaption8 = rs("AboutUsCaption8")
		End If 

'response.write(File5)
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



	str1 = File1
	str2 = "www"
	If Not(InStr(str1,str2) > 0) Then
	       File1 = "http://www.SOJAA.com/Uploads/Ranches/" & File1
	End If  

	str1 = File2
	str2 = "www"
	If Not(InStr(str1,str2) > 0) Then
	       File2 = "http://www.SOJAA.com/Uploads/Ranches/" & File2
	End If  


str1 = File3
	str2 = "www"
	If Not(InStr(str1,str2) > 0) Then
	       File3 = "http://www.SOJAA.com/Uploads/Ranches/" & File3
	End If  


str1 = File4
	str2 = "www"
	If Not(InStr(str1,str2) > 0) Then
	       File4 = "http://www.SOJAA.com/Uploads/Ranches/" & File4
	End If  


str1 = File5
	str2 = "www"
	If Not(InStr(str1,str2) > 0) Then
	       File5 = "http://www.SOJAA.com/Uploads/Ranches/" & File5
	End If  


str1 = File6
	str2 = "www"
	If Not(InStr(str1,str2) > 0) Then
	       File6 = "http://www.SOJAA.com/Uploads/Ranches/" & File6
	End If  


str1 = File7
	str2 = "www"
	If Not(InStr(str1,str2) > 0) Then
	       File7 = "http://www.SOJAA.com/Uploads/Ranches/" & File7
	End If  


str1 = File8
	str2 = "www"
	If Not(InStr(str1,str2) > 0) Then
	       File8 = "http://www.SOJAA.com/Uploads/Ranches/" & File8
	End If  


				rs.close
%>
    <table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "800">
		<tr>
			<td class = "body">
				<H1>Upload Photos</H1>
				Below you can upload photos for the following ranch pages:
				<ul>
				<li><a href = "#AboutUs" class = "body">Contact Us Page Image</a>
					
			    <li><a href = "#AboutUs" class = "body">About Us Page Image</a>
				</ul>
			</td>
		</tr>
	</table>


	
			<%  


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
		alpacaName(acounter) = rs2("FullName")
		'response.write (SSName(studcounter))

		acounter = acounter +1
		rs2.movenext
	Wend		
	
		rs2.close
		set rs2=nothing
		set conn = nothing



%>
		

<a name = "AboutUs"><a>
   <table Border = "1" Bgcolor = "#dddddd" width = "750" align = "center">
		<tr>
			<td colspan = "2">
				<h1>About Us Page Image</h1>
			</td>
		</tr>
		<tr>
			<td width = "150" align = "center">
					<img src = "<%=File1%>" height = "100">
					<center><b><%=AboutUsCaption1%></b></center>
			</td>
			<td class = "body">
					<form name="frmSend" method="POST" enctype="multipart/form-data" action="Ranchupload.asp" >
						<% If Not (File1 = "ImageNotAvailable.jpg") Then %>
									Current Image Name: <b><%=File1%></b><br>
						<% Else %>
							Current Image Name: <b>Not Defined</b><br>
						<% End If %>
file1=<%=File1%>
						
						
					
						Upload New Photo: <input name="attach1" type="file" size=35 >
						<input  type=submit value="Upload">
					</form>
<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
						<tr>
							<td bgcolor = "#abacab" height = "2" width = "700"><img src = "images/px.gif" height = "2"></td>
						</tr>
					</table>
					 <form action= 'Addcaption.asp' method = "post">
							Current Caption: <b><%=AboutUsCaption1%></b><br>
							New Caption (11 Character Max.): <input name="Caption" Value =""  size = "10" maxlength = "11">
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

		 <table Border = "1" Bgcolor = "#dddddd" width = "750" align = "center">
		<tr>
			<td colspan = "2">
				<h1>Image 2</h1>
			</td>
		</tr>
		<tr>
			<td width = "150" align = "center" class = "body">
					<img src = "<%=File2%>" height = "100">
					<center><b><%=AboutUsCaption2%></b></center>
			</td>
			<td class = "body">
					<form name="frmSend" method="POST" enctype="multipart/form-data" action="Ranchupload2.asp" onSubmit="return onSubmitForm();">
						<% If Not (File2 = "ImageNotAvailable.jpg") Then %>
									Current Image Name: <b><%=File2%></b><br>
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
					 <form action= 'Addcaption.asp' method = "post" >
							Current Caption: <b><%=AboutUsCaption2%></b><br>
							New Caption (11 Character Max.): <input name="Caption" Value =""  size = "10" maxlength = "11">
							<input type = "hidden" name="ID" value= "<%= ID %>" >
									<input type = "hidden" name="CaptionID" value= "2" >
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
  
   <table Border = "1" Bgcolor = "#dddddd" width = "750" align = "center">
		<tr>
			<td colspan = "2">
				<h1>Image 3</h1>
			</td>
		</tr>
		<tr>
			<td width = "150" align = "center" class = "body">
					<img src = "<%=File3%>" height = "100">
					<center><b><%=AboutUsCaption3%></b></center>
			</td>
			<td class = "body">
					<form name="frmSend" method="POST" enctype="multipart/form-data" action="Ranchupload3.asp" onSubmit="return onSubmitForm();">
						<% If Not (File3 = "ImageNotAvailable.jpg") Then %>
									Current Image Name: <b><%=File3%></b><br>
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
					 <form action= 'Addcaption.asp' method = "post">
							Current Caption: <b><%=AboutUsCaption3%></b><br>
							New Caption (11 Character Max.): <input name="Caption" Value =""  size = "10" maxlength = "11">
							<input type = "hidden" name="ID" value= "<%= ID %>" >
								<input type = "hidden" name="CaptionID" value= "3" >
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
  
   <table Border = "1" Bgcolor = "#dddddd" width = "750" align = "center">
		<tr>
			<td colspan = "2">
				<h1>Image 4</h1>
			</td>
		</tr>
		<tr>
			<td width = "150" align = "center" class = "body">
					<img src = "<%=File4%>" height = "100">
					<center><b><%=AboutUsCaption4%></b></center>
			</td>
			<td class = "body">
					<form name="frmSend" method="POST" enctype="multipart/form-data" action="Ranchupload4.asp" onSubmit="return onSubmitForm();">
					<% If Not (File4 = "ImageNotAvailable.jpg") Then %>
									Current Image Name: <b><%=File4%></b><br>
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
					 <form action= 'Addcaption.asp' method = "post">
							Current Caption: <b><%=AboutUsCaption4%></b><br>
							New Caption (11 Character Max.): <input name="Caption" Value =""  size = "10" maxlength = "11">
							<input type = "hidden" name="ID" value= "<%= ID %>" >
								<input type = "hidden" name="CaptionID" value= "4" >
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
  
   <table Border = "1" Bgcolor = "#dddddd" width = "750" align = "center">
		<tr>
			<td colspan = "2">
				<h1>Image 5</h1>
			</td>
		</tr>
		<tr>
			<td width = "150" align = "center" class = "body">
					<img src = "<%=File5%>" height = "100">
					<center><b><%=AboutUsCaption5%></b></center>
			</td>
			<td class = "body">
					<form name="frmSend" method="POST" enctype="multipart/form-data" action="Ranchupload5.asp" onSubmit="return onSubmitForm();">
						<% If Not (File5 = "ImageNotAvailable.jpg") Then %>
									Current Image Name: <b><%=File5%></b><br>
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
					 <form action= 'Addcaption.asp' method = "post">
							Current Caption: <b><%=AboutUsCaption5%></b><br>
							New Caption (11 Character Max.): <input name="Caption" Value =""  size = "10" maxlength = "11">
							<input type = "hidden" name="ID" value= "<%= ID %>" >
								<input type = "hidden" name="CaptionID" value= "5" >
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
  
   <table Border = "1" Bgcolor = "#dddddd" width = "750" align = "center">
		<tr>
			<td colspan = "2">
				<h1>Image 6</h1>
			</td>
		</tr>
		<tr>
			<td width = "150" align = "center" class = "body">
					<img src = "<%=File6%>" height = "100">
					<center><b><%=AboutUsCaption6%></b></center>
			</td>
			<td class = "body">
					<form name="frmSend" method="POST" enctype="multipart/form-data" action="Ranchupload6.asp" onSubmit="return onSubmitForm();">
						<% If Not (File6 = "ImageNotAvailable.jpg") Then %>
									Current Image Name: <b><%=File6%></b><br>
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
					 <form action= 'Addcaption.asp' method = "post">
							Current Caption: <b><%=AboutUsCaption6%></b><br>
							New Caption (11 Character Max.): <input name="Caption" Value =""  size = "10" maxlength = "11">
							<input type = "hidden" name="ID" value= "<%= ID %>" >
								<input type = "hidden" name="CaptionID" value= "6" >
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
  
   <table Border = "1" Bgcolor = "#dddddd" width = "750" align = "center">
		<tr>
			<td colspan = "2">
				<h1>Image 7</h1>
			</td>
		</tr>
		<tr>
			<td width = "150" align = "center" class = "body">
					<img src = "<%=File7%>" height = "100">
					<center><b><%=AboutUsCaption7%></b></center>
			</td>
			<td class = "body">
					<form name="frmSend" method="POST" enctype="multipart/form-data" action="Ranchupload7.asp" onSubmit="return onSubmitForm();">
						<% If Not (File7 = "ImageNotAvailable.jpg") Then %>
									Current Image Name: <b><%=File7%></b><br>
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
					 <form action= 'Addcaption.asp' method = "post">
							Current Caption: <b><%=AboutUsCaption7%></b><br>
							New Caption (11 Character Max.): <input name="Caption" Value =""  size = "10" maxlength = "11">
							<input type = "hidden" name="ID" value= "<%= ID %>" >
								<input type = "hidden" name="CaptionID" value= "7" >
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
  
   <table Border = "1" Bgcolor = "#dddddd" width = "750" align = "center">
		<tr>
			<td colspan = "2">
				<h1>Image 8</h1>
			</td>
		</tr>
		<tr>
			<td width = "150" align = "center" class = "body">
					<img src = "<%=File8%>" height = "100">
					<center><b><%=AboutUsCaption8%></b></center>
			</td>
			<td class = "body">
					<form name="frmSend" method="POST" enctype="multipart/form-data" action="Ranchupload8.asp" onSubmit="return onSubmitForm();">
						<% If Not (File8 = "ImageNotAvailable.jpg") Then %>
									Current Image Name: <b><%=File8%></b><br>
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
					 <form action= 'Addcaption.asp' method = "post">
							Current Caption: <b><%=AboutUsCaption8%></b><br>
						New Caption (11 Character Max.): <input name="Caption" Value =""  size = "10" maxlength = "11">
							<input type = "hidden" name="ID" value= "<%= ID %>" >
							<input type = "hidden" name="CaptionID" value= "8" >
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
  
    <br> 