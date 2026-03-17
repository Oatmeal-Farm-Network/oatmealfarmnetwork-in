 <% conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
			Set rs = Server.CreateObject("ADODB.Recordset")
			
			sql = "select  SfCustomers.* from SFCustomers where SFCustomers.custID= " & CustID
				'response.write(sql)
				rs.Open sql, conn, 3, 3
				If not rs.eof then
				 WebLink = rs("WebLink")
				 'response.write(WebLink)
				
					ArtistHomeImage1 = rs("ArtistHomeImage1")
					ArtistHomeImage2 = rs("ArtistHomeImage2")
					ArtistHomeImage3 = rs("ArtistHomeImage3")
					ArtistHomeImage4 = rs("ArtistHomeImage4")
					ArtistHomeImage5 = rs("ArtistHomeImage5")
					ArtistHomeImage6 = rs("ArtistHomeImage6")
					ArtistHomeImage7 = rs("ArtistHomeImage7")
					ArtisanHomeHeading = rs("ArtisanHomeHeading")
					ArtisanHomeHeading2 = rs("ArtisanHomeHeading2")
					ArtisanHomeHeading3 = rs("ArtisanHomeHeading3")
					ArtisanHomeHeading4 = rs("ArtisanHomeHeading4")
					ArtisanHomeHeading5 = rs("ArtisanHomeHeading5")
					ArtisanHomeHeading6 = rs("ArtisanHomeHeading6")
					ArtisanHomeHeading7 = rs("ArtisanHomeHeading7")
					ArtisanHomeImageOrientation1= rs("ArtisanHomeImageOrientation1")
					ArtisanHomeImageOrientation2= rs("ArtisanHomeImageOrientation2")
					ArtisanHomeImageOrientation3= rs("ArtisanHomeImageOrientation3")
					ArtisanHomeImageOrientation4= rs("ArtisanHomeImageOrientation4")
					ArtisanHomeImageOrientation5= rs("ArtisanHomeImageOrientation5")
					ArtisanHomeImageOrientation6= rs("ArtisanHomeImageOrientation6")
					ArtisanHomeImageOrientation7= rs("ArtisanHomeImageOrientation7")
					If Len(ArtisanHomeImageOrientation1) > 2 Then
					else
						ArtisanHomeImageOrientation1 = "Right"
					End If 

					If Len(ArtisanHomeImageOrientation2) > 2 Then
					else
						ArtisanHomeImageOrientation2 = "Left"
					End If 

					If Len(ArtisanHomeImageOrientation3) > 2 Then
					else
						ArtisanHomeImageOrientation3 = "Right"
					End If 

						If Len(ArtisanHomeImageOrientation2) > 2 Then
					else
						ArtisanHomeImageOrientation2 = "Left"
					End If 
					ArtisanHomeText   = rs("ArtisanHomeText")
					ArtisanHomeText2   = rs("ArtisanHomeText2")
					ArtisanHomeText3   = rs("ArtisanHomeText3")
					ArtisanHomeText4   = rs("ArtisanHomeText4")
					ArtisanHomeText5   = rs("ArtisanHomeText5")
					ArtisanHomeText6   = rs("ArtisanHomeText6")
					ArtisanHomeText7  = rs("ArtisanHomeText7")

		
					str1 = ArtisanHomeText
					str2 = vblf
					If InStr(str1,str2) > 0 Then
						ArtisanHomeText= Replace(str1, str2 , "</br>")
					End If  

					str1 = ArtisanHomeText
					str2 = vbtab
					If InStr(str1,str2) > 0 Then
						ArtisanHomeText= Replace(str1, str2 , "&nbsp;&nbsp;&nbsp;&nbsp;")
					End If  

					str1 = ArtisanHomeText2
					str2 = vblf
					If InStr(str1,str2) > 0 Then
						ArtisanHomeText2= Replace(str1, str2 , "</br>")
					End If  

					str1 = ArtisanHomeText2
					str2 = vbtab
					If InStr(str1,str2) > 0 Then
						ArtisanHomeText2= Replace(str1, str2 , "&nbsp;&nbsp;&nbsp;&nbsp;")
					End If  



				   custFirstName = rs("custFirstName")
				    custSlogan = rs("custSlogan")
				   custMiddleInitial  = rs("custMiddleInitial")
					custLastName  = rs("custLastName")
					custCompany   = rs("custCompany")
					custAddr1  = rs("custAddr1")
					custAddr2  = rs("custAddr2")
					custCity  = rs("custCity")
					custState   = rs("custState")
					custZip   = rs("custZip")
					custCountry   = rs("custCountry")
					custPhone   = rs("custPhone")
					custPhone2   = rs("custPhone2")
					custFAX   = rs("custFAX")
					Logo   = rs("Logo")
					'Header   = rs("Header")
				    



					str1 = WebLink
					str2 = "http://"
					If InStr(str1,str2) > 0 Then
							WebLink= Replace(str1,  str2, "")
					End If 

				rs.close
			End If 
			%>
<br>
<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center"  valign ="top"   width = "780">
	<tr>
	     <td class = "body"  align = "left" valign = "top" width = "120">
		 <% If Len(Logo) > 3 Then %> 
					<img src = "/Uploads/<%=Logo%>" width = "100">
				<% End If %>
					
				<% If Len(Logo) < 3 Then %> 
						<h1><%=CustCompany%></h1>
				<% End If %>
				Artisan Pages:<br>
				<table>
				   <tr>
						<td height = "12"><a href = "OurGallery.asp?CustID=<%=CustID%>" class = "body">Home Page</a></td>
					</tr>
					<tr>
						<td height = "12"><a href = "ArtistSales.asp?CustID=<%=CustID%>" class = "body">Art for Sale</a></td>
					</tr>
					<tr>
						<td height = "12">
							<a href = "ArtistContactUs.asp?CustID=<%=CustID%>" class = "body">Contact Me</a></td>
					</tr>
                 </table>
		 </td>
		 <td bgcolor = "#620000" width = "1"><img src = "images/px.gif" width = "0" height = "0"></td>

  	 <td >

	