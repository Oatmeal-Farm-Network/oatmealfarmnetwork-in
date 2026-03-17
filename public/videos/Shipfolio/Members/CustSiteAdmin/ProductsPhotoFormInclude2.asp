<% 
Dim prodNameArray(20000)


			conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
			Set rs = Server.CreateObject("ADODB.Recordset")

	

			sql2 = "select ProdID, ProdName from sfProducts  where custID = " & session("custid") & " order by Prodname"
'response.write(sql2)
	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	
	While Not rs2.eof  
		IDArray(acounter) = rs2("ProdID")
		prodNameArray(acounter) = rs2("ProdName")
		'response.write (SSName(studcounter))

		acounter = acounter +1
		rs2.movenext
	Wend		
	
		rs2.close
		set rs2=nothing
		redirect = false
			
			sql = "select * from ProductsPhotos where id = " & prodID
				'response.write(sql)
				rs.Open sql, conn, 3, 3

				If rs.eof Then
				   redirect =true
					Query =  "INSERT INTO ProductsPhotos (ID)" 
					Query =  Query & " Values (" &  prodID & ")"

					'response.write(Query)
					
					Set DataConnection = Server.CreateObject("ADODB.Connection")

					DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 
					DataConnection.Execute(Query) 
			

			
				End If 
					rs.close


					sql = "select * from sfProducts where prodid = " & prodID & ""
				'response.write(sql)
				rs.Open sql, conn, 3, 3

				If rs.eof Then
				    redirect =true
					Query =  "INSERT INTO sfProducts (prodID)" 
					Query =  Query & " Values (" &  prodID & ")"

					'response.write(Query)
					
					Set DataConnection = Server.CreateObject("ADODB.Connection")

					DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 
					DataConnection.Execute(Query) 
			

			
				End If 
					rs.close

			If  redirect =True then
				response.redirect("ProductsUploadPhotos.asp?prodid="&prodID)
			End if
				sql = "select * from sfProducts, ProductsPhotos where cint(sfProducts.prodid) = ProductsPhotos.ID and ProductsPhotos.ID = " & prodID
				'response.write(sql)
				rs.Open sql, conn, 3, 3
				If Not rs.eof Then
						'response.write("prodname = " & rs("prodName"))
						ProdName2 = rs("prodName")




				End If
				


				If Len(rs("ProductImage1")) > 2 Then
						File1= rs("ProductImage1")
						'response.write(sql)
					str1 = File1
					str2 = "www"
					If Not(InStr(str1,str2) > 0) Then
				       File1 = LongWeblink & "/Uploads/" & File1
					End If  
					else
						File1 = "/uploads/ImageNotAvailable.jpg"
					End If


					If Len(rs("ProductImage2")) > 2 Then
						File2= rs("ProductImage2")
						'response.write(sql)
					str1 = File2
					str2 = "www"
					If Not(InStr(str1,str2) > 0) Then
				       File2 = LongWeblink & "/Uploads/" & File2
					End If  
					else
						File2 = "/uploads/ImageNotAvailable.jpg"
					End If
					
				If Len(rs("ProductImage3")) > 2 Then
						File3= rs("ProductImage3")
						'response.write(sql)
					str1 = File3
					str2 = "www"
					If Not(InStr(str1,str2) > 0) Then
				       File3 = LongWeblink & "/Uploads/" & File3
					End If  
					else
						File3 = "/uploads/ImageNotAvailable.jpg"
					End If

					If Len(rs("ProductImage4")) > 2 Then
						File4= rs("ProductImage4")
						'response.write(sql)
					str1 = File4
					str2 = "www"
					If Not(InStr(str1,str2) > 0) Then
				       File4 = LongWeblink & "/Uploads/" & File4
					End If  
					else
						File4 = "/uploads/ImageNotAvailable.jpg"
					End If

						If Len(rs("ProductImage5")) > 2 Then
						File5= rs("ProductImage5")
						'response.write(sql)
					str1 = File5
					str2 = "www"
					If Not(InStr(str1,str2) > 0) Then
				       File5 = LongWeblink & "/Uploads/" & File5
					End If  
					else
						File5 = "/uploads/ImageNotAvailable.jpg"
					End If


				If Len(rs("ProductImage6")) > 2 Then
						File6= rs("ProductImage6")
						'response.write(sql)
					str1 = File6
					str2 = "www"
					If Not(InStr(str1,str2) > 0) Then
				       File6 = LongWeblink & "/Uploads/" & File6
					End If  
					else
						File6 = "/uploads/ImageNotAvailable.jpg"
					End If

	If Len(rs("ProductImage7")) > 2 Then
						File7= rs("ProductImage7")
						'response.write(sql)
					str1 = File7
					str2 = "www"
					If Not(InStr(str1,str2) > 0) Then
				       File7 = LongWeblink & "/Uploads/" & File7
					End If  
					else
						File7 = "/uploads/ImageNotAvailable.jpg"
					End If

						If Len(rs("ProductImage8")) > 2 Then
						File8= rs("ProductImage8")
						'response.write(sql)
					str1 = File8
					str2 = "www"
					If Not(InStr(str1,str2) > 0) Then
				       File8 = LongWeblink & "/Uploads/" & File8
					End If  
					else
						File8 = "/uploads/ImageNotAvailable.jpg"
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

						

				rs.close
%>
    <table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "800">
		<tr>
			<td class = "body"><br>
				<H1>Upload Product Photos for <%=ProdName2%></H1>			
			</td>
		</tr>
	</table>


	
			<%  


	conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" 
	sql2 = "select * from sfProducts where CustID = " & Session("custID") & " order by Prodname ;"
'response.write(sql2)
	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	
	While Not rs2.eof  
		IDArray(acounter) = rs2("prodID")
		prodNameArray(acounter) = rs2("prodName")
		'response.write (SSName(studcounter))

		acounter = acounter +1
		rs2.movenext
	Wend		
	
		rs2.close
		set rs2=nothing
		set conn = nothing



%>
		<font class = "body">
		<form  action="ProductsUploadPhotos.asp" method = "post">
			<h2>Select Another Product</h2>
			Select an product below and push the edit button to update an product's photos:<br>
			  
			  <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
			   <tr>
				<td colspan ="30">
					&nbsp;
				</td>
				 <td class = "body">
					<br>Select one of your Products:
					<select size="1" name="ProdID">
					<option name = "AID0" value= "" selected></option>
					<% count = 1
						while count < acounter
						'response.write(count)
					%>
						<option name = "AID1" value="<%=IDArray(count)%>">
							<%=prodNameArray(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
					<input type=submit value = "Edit" style="background-image: url('images/background.jpg'); border-width:1px" size = "210" class = "body" >
				</td>
			  </tr>
		    </table>
	 </form>
	 </font>
   <table Border = "1" Bgcolor = "#dddddd" width = "750" align = "center">
		<tr>
			<td colspan = "2"> 
				<h1>Main Image</h1>
			</td>
		</tr>
		<tr>
			<td width = "150" align = "center">
					<img src = "<%=File1%>" height = "100">
					<center><b><%=PhotoCaption1%></b></center>
			</td>
			<td class = "body">
					<form name="frmSend" method="POST" enctype="multipart/form-data" action="UploadProductImage.asp" >
						<% If Not (File1 = "/uploads/ImageNotAvailable.jpg") Then %>
									Current Image Name: 
									<% If Len(file1)> 38 Then %>
											<b><%=right(File1, Len(File1) -39)%></b>
									<% Else %>
											<b><%=File1 %></b>
									<% End If %>
											<br>
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
					<form action= 'ProductsRemoveImage.asp' method = "post">
							Would you like to remove this image? 
							<input type = "hidden" name="ImageID" value= "1" >
							<input type = "hidden" name="ProdID" value= "<%= ProdID %>" >
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
					<center><b><%=PhotoCaption2%></b></center>
			</td>
			<td class = "body">
					<form name="frmSend" method="POST" enctype="multipart/form-data" action="UploadProductImage2.asp" onSubmit="return onSubmitForm();">
						<% If Not (File2 = "/uploads/ImageNotAvailable.jpg") Then %>
									Current Image Name: 
									<% If Len(file2)> 39 Then %>
											<b><%=right(File2, Len(File2) -39)%></b>
									<% Else %>
											<b><%=File2 %></b>
									<% End If %>
											<br>
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
					<form action= 'ProductsRemoveImage.asp' method = "post">
							Would you like to remove this image? 
							<input type = "hidden" name="ImageID" value= "2" >
							<input type = "hidden" name="ProdID" value= "<%= ProdID %>" >
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
					<center><b><%=PhotoCaption3%></b></center>
			</td>
			<td class = "body">
					<form name="frmSend" method="POST" enctype="multipart/form-data" action="UploadProductImage3.asp" onSubmit="return onSubmitForm();">
						<% If Not (File3 = "/uploads/ImageNotAvailable.jpg") Then %>
									Current Image Name: 
									<% If Len(file3)> 39 Then %>
											<b><%=right(File3, Len(File3) -39)%></b>
									<% Else %>
											<b><%=File3 %></b>
									<% End If %>
											<br>
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
					<form action= 'ProductsRemoveImage.asp' method = "post">
							Would you like to remove this image? 
							<input type = "hidden" name="ImageID" value= "3" >
							<input type = "hidden" name="ProdID" value= "<%= ProdID %>" >
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
					<center><b><%=PhotoCaption4%></b></center>
			</td>
			<td class = "body">
					<form name="frmSend" method="POST" enctype="multipart/form-data" action="UploadProductImage4.asp" onSubmit="return onSubmitForm();">
					<% If Not (File4 = "/uploads/ImageNotAvailable.jpg") Then %>
									Current Image Name: 
									<% If Len(file4)> 39 Then %>
											<b><%=right(File4, Len(File4) -39)%></b>
									<% Else %>
											<b><%=File4 %></b>
									<% End If %>
											<br>
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
					<form action= 'ProductsRemoveImage.asp' method = "post">
							Would you like to remove this image? 
							<input type = "hidden" name="ImageID" value= "4" >
							<input type = "hidden" name="ProdID" value= "<%= ProdID %>" >
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
					<center><b><%=PhotoCaption5%></b></center>
			</td>
			<td class = "body">
					<form name="frmSend" method="POST" enctype="multipart/form-data" action="UploadProductImage5.asp" onSubmit="return onSubmitForm();">
						<% If Not (File5 = "/uploads/ImageNotAvailable.jpg") Then %>
									Current Image Name: 
									<% If Len(file5)> 39 Then %>
											<b><%=right(File5, Len(File5) -39)%></b>
									<% Else %>
											<b><%=File5 %></b>
									<% End If %>
											<br>
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
					<form action= 'ProductsRemoveImage.asp' method = "post">
							Would you like to remove this image? 
							<input type = "hidden" name="ImageID" value= "5" >
							<input type = "hidden" name="ProdID" value= "<%= ProdID %>" >
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
					<center><b><%=PhotoCaption6%></b></center>
			</td>
			<td class = "body">
					<form name="frmSend" method="POST" enctype="multipart/form-data" action="UploadProductImage6.asp" onSubmit="return onSubmitForm();">
						<% If Not (File6 = "/uploads/ImageNotAvailable.jpg") Then %>
									Current Image Name: 
									<% If Len(file6)> 39 Then %>
											<b><%=right(File6, Len(File6) -39)%></b>
									<% Else %>
											<b><%=File6 %></b>
									<% End If %>
											<br>
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
					<form action= 'ProductsRemoveImage.asp' method = "post">
							Would you like to remove this image? 
							<input type = "hidden" name="ImageID" value= "6" >
							<input type = "hidden" name="ProdID" value= "<%= ProdID %>" >
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
					<center><b><%=PhotoCaption7%></b></center>
			</td>
			<td class = "body">
					<form name="frmSend" method="POST" enctype="multipart/form-data" action="UploadProductImage7.asp" onSubmit="return onSubmitForm();">
						<% If Not (File7 = "/uploads/ImageNotAvailable.jpg") Then %>
									Current Image Name: 
									<% If Len(file7)> 39 Then %>
											<b><%=right(File7, Len(File7) -39)%></b>
									<% Else %>
											<b><%=File7 %></b>
									<% End If %>
											<br>
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
					<form action= 'ProductsRemoveImage.asp' method = "post">
							Would you like to remove this image? 
							<input type = "hidden" name="ImageID" value= "7" >
							<input type = "hidden" name="ProdID" value= "<%= ProdID %>" >
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
					<center><b><%=PhotoCaption8%></b></center>
			</td>
			<td class = "body">
					<form name="frmSend" method="POST" enctype="multipart/form-data" action="UploadProductImage8.asp" onSubmit="return onSubmitForm();">
						<% If Not (File8 = "/uploads/ImageNotAvailable.jpg") Then %>
									Current Image Name: 
									<% If Len(file8)> 39 Then %>
											<b><%=right(File8, Len(File8) -39)%></b>
									<% Else %>
											<b><%=File8 %></b>
									<% End If %>
											<br>
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
					
					<form action= 'ProductsRemoveImage.asp' method = "post">
							Would you like to remove this image? 
							<input type = "hidden" name="ImageID" value= "8" >
							<input type = "hidden" name="ProdID" value= "<%= ProdID %>" >
							<input type=submit value="Remove This Image">
					</form>
			</td>
		</table>
  
    <br> 