<%conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
		"Data Source=" & server.mappath(DatabasePath) & ";" & _
		"User Id=;Password=;" '& _ 
Set rs = Server.CreateObject("ADODB.Recordset")
			
sql = "select  * from PageLayout where PageName = 'About Us'" 
'response.write(sql)
rs.Open sql, conn, 3, 3
If not rs.eof then
PageTitle = rs("PageTitle")
PageText = rs("PageText")		
PageText2 = rs("PageText2")		
PageText3 = rs("PageText3")	
PageText4 = rs("PageText4")	
PageText5 = rs("PageText5")	
PageText6 = rs("PageText6")
PageText7 = rs("PageText7")
PageText8 = rs("PageText8")
PageText9 = rs("PageText9")
PageText10 = rs("PageText10")					
PageHeading1= rs("PageHeading1")	
PageHeading2= rs("PageHeading2")
PageHeading3= rs("PageHeading3")
PageHeading4= rs("PageHeading4")
PageHeading5= rs("PageHeading5")
PageHeading6= rs("PageHeading6")
PageHeading7= rs("PageHeading7")
PageHeading8= rs("PageHeading8")
PageHeading9= rs("PageHeading9")
PageHeading10= rs("PageHeading10")
Image1= rs("Image1")
Image2= rs("Image2")
Image3= rs("Image3")
Image4= rs("Image4")
Image5= rs("Image5")
Image6= rs("Image6")
Image7= rs("Image7")
Image8= rs("Image8")
Image9= rs("Image9")
Image10= rs("Image10")
ImageCaption1 = rs("ImageCaption1")
ImageCaption2 = rs("ImageCaption2")
ImageCaption3 = rs("ImageCaption3")
ImageCaption4 = rs("ImageCaption4")
ImageCaption5 = rs("ImageCaption5")
ImageCaption6 = rs("ImageCaption6")
ImageCaption7 = rs("ImageCaption7")
ImageCaption8 = rs("ImageCaption8")
ImageCaption9 = rs("ImageCaption9")
ImageCaption10 = rs("ImageCaption10")
ImageOrientation1 = rs("ImageOrientation1")
ImageOrientation2 = rs("ImageOrientation2")
ImageOrientation3 = rs("ImageOrientation3")
ImageOrientation4 = rs("ImageOrientation4")
ImageOrientation5 = rs("ImageOrientation5")
ImageOrientation6 = rs("ImageOrientation6")
ImageOrientation7 = rs("ImageOrientation7")
ImageOrientation8 = rs("ImageOrientation8")
ImageOrientation9 = rs("ImageOrientation9")
ImageOrientation10 = rs("ImageOrientation10")



end if	
	
rs.close	
sql = "select  SfCustomers.* from SFCustomers where SFCustomers.custID= 66" 
				'response.write(sql)
				rs.Open sql, conn, 3, 3
				If not rs.eof then

				 'response.write(WebLink)

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
end if
rs.close


sql = "select  * from sitedesign " 
'response.write(sql)
rs.Open sql, conn, 3, 3
If not rs.eof then
	Logo   = rs("Logo")
	Header   = rs("Header")
end if
rs.close


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
		<td  class = "PageText" height = "200" class = "body">
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

<%
			TempOrientation = ImageOrientation5
			TempImage = Image5
			TempImageCaption = ImageCaption5
			TempHeading = PageHeading5
			TempPageText = PageText5
			%>		
			<!--#Include file="AdminCaptionedPageTextInclude.asp"-->	

<%
			TempOrientation = ImageOrientation6
			TempImage = Image6
			TempImageCaption = ImageCaption6
			TempHeading = PageHeading6
			TempPageText = PageText6
			%>		
			<!--#Include file="AdminCaptionedPageTextInclude.asp"-->	


<%
			TempOrientation = ImageOrientation7
			TempImage = Image7
			TempImageCaption = ImageCaption7
			TempHeading = PageHeading7
			TempPageText = PageText7
			%>		
			<!--#Include file="AdminCaptionedPageTextInclude.asp"-->	


<%
			TempOrientation = ImageOrientation8
			TempImage = Image8
			TempImageCaption = ImageCaption8
			TempHeading = PageHeading8
			TempPageText = PageText8
			%>		
			<!--#Include file="AdminCaptionedPageTextInclude.asp"-->	


<%
			TempOrientation = ImageOrientation9
			TempImage = Image9
			TempImageCaption = ImageCaption9
			TempHeading = PageHeading9
			TempPageText = PageText9
			%>		
			<!--#Include file="AdminCaptionedPageTextInclude.asp"-->	

<%
			TempOrientation = ImageOrientation10
			TempImage = Image10
			TempImageCaption = ImageCaption10
			TempHeading = PageHeading10
			TempPageText = PageText10
			%>		
			<!--#Include file="AdminCaptionedPageTextInclude.asp"-->	


				<br><br></font>
		</td>
	</tr>
</table>

	
