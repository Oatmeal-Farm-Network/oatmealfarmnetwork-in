			
	<%conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
			Set rs = Server.CreateObject("ADODB.Recordset")
			
			sql = "select  SfCustomers.* from SFCustomers where SFCustomers.custID= " & session("CustID")
				'response.write(sql)
				rs.Open sql, conn, 3, 3
				If not rs.eof then
				 WebLink = rs("WebLink")
				 'response.write(WebLink)
				RanchHomeText = rs("RanchHomeText")

	PageText1 = rs("RanchHomeText")
	 PageText2 = rs("RanchHomeText2")
	 PageText3 = rs("RanchHomeText3")
	 PageText4 = rs("RanchHomeText4")
	 Image1= rs("RanchHomeImage1")
	Image2= rs("RanchHomeImage2")
	 Image3= rs("RanchHomeImage3")
	 Image4= rs("RanchHomeImage4")
	 ImageOrientation1= rs("RanchHomeImageOrientation1")
	ImageOrientation2= rs("RanchHomeImageOrientation2")
	 ImageOrientation3= rs("RanchHomeImageOrientation3")
		ImageOrientation4= rs("RanchHomeImageOrientation4")
			Aboutusheading= rs("Aboutusheading")

				   custFirstName = rs("custFirstName")
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
					Header   = rs("Header")



					str1 = WebLink
					str2 = "http://"
					If InStr(str1,str2) > 0 Then
							WebLink= Replace(str1,  str2, "")
					End If 
		str1 = Aboutusheading
		str2 = vblf
		If InStr(str1,str2) > 0 Then
			Aboutusheading= Replace(str1, str2 , "</br>")
		End If  

		str1 = Aboutusheading
		str2 = vbtab
		If InStr(str1,str2) > 0 Then
			Aboutusheading= Replace(str1, str2 , "&nbsp;&nbsp;&nbsp;&nbsp;")
			End If  
				rs.close
			End If 


			 If Not(ImageOrientation1 = "Left") then
					 ImageOrientation1 = "Right"
					
			End if
			%>


	


			
<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center"  valign ="top"   >
	<tr>
	     <td class = "PageText"  >	<br>	
		   <% If Len(Aboutusheading) > 1 Then %>
				<h1><center><%=Aboutusheading%></center></h1>
		   
		
			<% Else %>
					<h1><center>About <%=CustCompany%></center></h1>
			<% End if %>


		</td>
	</tr>
	<tr>
		<td  class = "PageText" height = "200">
				<font size = "1pt">

			<%
			TempOrientation = ImageOrientation1
			TempImage = Image1
			TempImageCaption = ImageCaption1
			TempHeading = PageHeading1
			TempPageText = PageText1
			
			%>
			
			<!--#Include file="AdminCaptionedPageTextInclude.asp"-->	
			


		<%
			TempOrientation = ImageOrientation2
			TempImage = Image2
			TempImageCaption = ImageCaption2
			TempHeading = PageHeading2
			TempPageText = PageText2
			%>
			
			<!--#Include file="AdminCaptionedPageTextInclude.asp"-->	
	

<%
			TempOrientation = ImageOrientation3
			TempImage = Image3
			TempImageCaption = ImageCaption3
			TempHeading = PageHeading3
			TempPageText = PageText3
			%>


					<!--#Include file="AdminCaptionedPageTextInclude.asp"-->	
		

<%
			TempOrientation = ImageOrientation4
			TempImage = Image4
			TempImageCaption = ImageCaption4
			TempHeading = PageHeading4
			TempPageText = PageText4
			%>		
			<!--#Include file="AdminCaptionedPageTextInclude.asp"-->	



				<br><br></font>
		</td>
	</tr>
</table>

	
