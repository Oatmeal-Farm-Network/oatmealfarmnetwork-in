

<% 

PageName=Request.Querystring("PageName" ) 
If Len(PageName) = 0 then
	PageName=Request.Form("PageName" ) 
End If
session("PageName") = PageName

CustID = session("CustID")

conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(databasepath) & ";" & _
						"User Id=;Password=;" 


  sql = "select * from Pagelayout where PageName = '" & Pagename & "'"
'response.write(sql)
		
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
'	publish= rs("publish")
PageLayoutID = rs("PageLayoutID")
	PageName = rs("PageName")
	 PageTitle = rs("PageTitle")
     PageHeading1= rs("PageHeading1")
     PageHeading2= rs("PageHeading2")
     PageHeading3= rs("PageHeading3")
     PageHeading4= rs("PageHeading4")
	 PageHeading4= rs("PageHeading4")
	 PageHeading5= rs("PageHeading5")
	PageHeading6= rs("PageHeading6")
	PageHeading7= rs("PageHeading7")
	 PageText = rs("PageText")
	 PageText2 = rs("PageText2")
	 PageText3 = rs("PageText3")
	 PageText4 = rs("PageText4")
	 PageText5 = rs("PageText5")
	 PageText6 = rs("PageText6")
	 PageText7 = rs("PageText7")
	 Image1= rs("Image1")
	 Image2= rs("Image2")
	 Image3= rs("Image3")
	 Image4= rs("Image4")
	 Image5= rs("Image5")
	 	 Image6= rs("Image6")
		 	 Image7= rs("Image7")
	 ImageCaption1= rs("ImageCaption1")
	 ImageCaption2= rs("ImageCaption2")
	 ImageCaption3= rs("ImageCaption3")
	 ImageCaption4= rs("ImageCaption4")
	  ImageCaption5= rs("ImageCaption5")
	   ImageCaption6= rs("ImageCaption6")
	    ImageCaption7= rs("ImageCaption7")
	 ImageOrientation1= rs("ImageOrientation1")
	 ImageOrientation2= rs("ImageOrientation2")
	 ImageOrientation3= rs("ImageOrientation3")
	 ImageOrientation4= rs("ImageOrientation4")
	 ImageOrientation5= rs("ImageOrientation5")
	 ImageOrientation6= rs("ImageOrientation6")
	 ImageOrientation7= rs("ImageOrientation7")
SectionTitle1= rs("SectionTitle1")
SectionTitle2= rs("SectionTitle2")
SectionTitle3= rs("SectionTitle3")
SectionTitle4= rs("SectionTitle4")
SectionTitle5= rs("SectionTitle5")
SectionTitle6= rs("SectionTitle6")
SectionTitle7= rs("SectionTitle7")
Upload2 = rs("Upload2")
UploadText2 = rs("UploadText2")
Upload2A = rs("Upload2A")

str1 = SectionTitle1
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	SectionTitle1= Replace(str1,  str2, " ")
End If 

str1 = SectionTitle1
str2 = "''"
If InStr(str1,str2) > 0 Then
	SectionTitle1= Replace(str1,  str2, "'")
End If 

str1 = SectionTitle2
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	SectionTitle2= Replace(str1,  str2, " ")
End If 

str1 = SectionTitle2
str2 = "''"
If InStr(str1,str2) > 0 Then
	SectionTitle2= Replace(str1,  str2, "'")
End If 

str1 = SectionTitle3
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	SectionTitle3= Replace(str1,  str2, " ")
End If 

str1 = SectionTitle3
str2 = "''"
If InStr(str1,str2) > 0 Then
	SectionTitle3= Replace(str1,  str2, "'")
End If 

str1 = SectionTitle4
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	SectionTitle4= Replace(str1,  str2, " ")
End If 

str1 = SectionTitle4
str2 = "''"
If InStr(str1,str2) > 0 Then
	SectionTitle4= Replace(str1,  str2, "'")
End If 

str1 = SectionTitle5
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	SectionTitle5= Replace(str1,  str2, " ")
End If 

str1 = SectionTitle5
str2 = "''"
If InStr(str1,str2) > 0 Then
	SectionTitle5= Replace(str1,  str2, "'")
End If 

str1 = SectionTitle6
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	SectionTitle6= Replace(str1,  str2, " ")
End If 

str1 = SectionTitle6
str2 = "''"
If InStr(str1,str2) > 0 Then
	SectionTitle6= Replace(str1,  str2, "'")
End If 

str1 = SectionTitle7
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	SectionTitle7= Replace(str1,  str2, " ")
End If 

str1 = SectionTitle7
str2 = "''"
If InStr(str1,str2) > 0 Then
	SectionTitle7= Replace(str1,  str2, "'")
End If 


str1 = PageHeading1
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageHeading1= Replace(str1,  str2, " ")
End If 

str1 = PageHeading1
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageHeading1= Replace(str1,  str2, "'")
End If 

str1 = PageHeading2
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageHeading2= Replace(str1,  str2, " ")
End If 

str1 = PageHeading2
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageHeading2= Replace(str1,  str2, "'")
End If 

str1 = PageHeading3
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageHeading3= Replace(str1,  str2, " ")
End If 

str1 = PageHeading3
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageHeading3= Replace(str1,  str2, "'")
End If 


str1 = PageHeading4
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageHeading4= Replace(str1,  str2, " ")
End If 

str1 = PageHeading4
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageHeading4= Replace(str1,  str2, "'")
End If 

str1 =  ImageCaption1
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	 ImageCaption1= Replace(str1,  str2, " ")
End If 

str1 =  ImageCaption1
str2 = "''"
If InStr(str1,str2) > 0 Then
	 ImageCaption1= Replace(str1,  str2, "'")
End If 

str1 =  ImageCaption2
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	 ImageCaption2= Replace(str1,  str2, " ")
End If 

str1 =  ImageCaption2
str2 = "''"
If InStr(str1,str2) > 0 Then
	 ImageCaption2= Replace(str1,  str2, "'")
End If 

str1 =  ImageCaption3
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	 ImageCaption3= Replace(str1,  str2, " ")
End If 

str1 =  ImageCaption3
str2 = "''"
If InStr(str1,str2) > 0 Then
	 ImageCaption3= Replace(str1,  str2, "'")
End If 


str1 =  ImageCaption4
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	 ImageCaption4= Replace(str1,  str2, " ")
End If 

str1 =  ImageCaption4
str2 = "''"
If InStr(str1,str2) > 0 Then
	 ImageCaption4= Replace(str1,  str2, "'")
End If 







str1 = PageTitle
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageTitle= Replace(str1,  str2, " ")
End If 

str1 = PageTitle
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageTitle= Replace(str1,  str2, "'")
End If 


str1 = PageText
str2 = "</br>"
If InStr(str1,str2) > 0 Then
	PageText= Replace(str1, str2 , vbCrLf)
End If  

str1 =PageText
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageText= Replace(str1,  str2, " ")
End If 

str1 = PageText
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageText= Replace(str1,  str2, "'")
End If 

str1 = PageText
str2 = "</br>"
If InStr(str1,str2) > 0 Then
	PageText= Replace(str1, str2 , vbCrLf)
End If  

str1 =PageText
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageText= Replace(str1,  str2, " ")
End If 

str1 = PageText
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageText= Replace(str1,  str2, "'")
End If 

str1 = PageText2
str2 = "</br>"
If InStr(str1,str2) > 0 Then
	PageText2= Replace(str1, str2 , vbCrLf)
End If  

str1 =PageText2
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageText2= Replace(str1,  str2, " ")
End If 

str1 = PageText2
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageText2= Replace(str1,  str2, "'")
End If 

str1 = PageText3
str2 = "</br>"
If InStr(str1,str2) > 0 Then
	PageText3= Replace(str1, str2 , vbCrLf)
End If  

str1 =PageText3
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageText3= Replace(str1,  str2, " ")
End If 

str1 = PageText3
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageText3= Replace(str1,  str2, "'")
End If 

str1 = PageText4
str2 = "</br>"
If InStr(str1,str2) > 0 Then
	PageText4= Replace(str1, str2 , vbCrLf)
End If  

str1 =PageText4
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageText4= Replace(str1,  str2, " ")
End If 

str1 = PageText4
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageText4= Replace(str1,  str2, "'")
End If 

%>

<a name="Top"></a>



<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "680">
	<tr>
		<td Class = "body">
			<H2><%=PageName %> Page Content<br>
			<img src = "images/underline.jpg" width = "600"></H2>
			<br><br>
		</td>
	</tr>
</table>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "680">
	<tr>
	    <td class = "body">
             Your page is built from multiple "Text Blocks". Each Text Block is comprised of:
				<ul>
					<li>Text
					<li>An Image with a caption
				</ul>
              Select the links below to go directly to:
			      <ul>
				  	<li><a href = "#TextBlock1" class ="body">Text Block 1</a>
				  	<li><a href = "#TextBlock2" class ="body">Text Block 2</a>
				  	<li><a href = "#TextBlock3" class ="body">Text Block 3</a>
				  	<li><a href = "#TextBlock4" class ="body">Text Block 4</a>
				</ul><a name="Heading"></a>
				<br>
		</td>
		<td Class = "body">
			
			<img src = "images/TextBlocks.jpg" height = "250"></H2>
		</td>
	</tr>
</table>
<table border= "0">
<tr>
			<td  align = "center" class = "body" valign = "top" colspan= "2" bgcolor = "bbbbbb" height = "14" width = "800">
					<big><b><font color = "white">Page Heading</font></b></big> </b>

					
			</td>
		</tr>
   <tr>
</table>

<% showhedeading = True
If showhedeading = True then
%>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "680">
	<tr>
		<td valign = "top">
			 <form action= 'PageDataPageHandleForm.asp' method = "post">
			<input name="TextBlock"  size = "60" value = "Heading" type = "hidden">
			<input name="PageLayoutID"  size = "60" value = "<%=PageLayoutID%>" type = "hidden">

			<table border = "0" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "580" align = "center">

			<tr>
				<td  align = "left"   class = "body">
						<b>Page Heading: </b><br>
					<input name="Text"  size = "60" value = "<%=PageTitle%>">
				</td>
			</tr>




			


		<tr>
		<td  valign = "middle" colspan = "2" align = "center">
			<input type=submit value = "Submit Changes" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" Class = "body" >
		</td>
		</tr>
		</table>

</form>
<% End If %>

<a name="TextBlock1"></a>
<table border = "1" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
  <tr>
    <td>
<table border= "0">

   <tr>
      <td >
<table border = "0" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
		
		<form action= 'PageDataPageHandleForm.asp' method = "post">
			<input name="TextBlock"  size = "60" value = "TB1" type = "hidden">
	
	<tr>
			<td  align = "left"   class = "body" colspan = "2">
					<b>Heading: </b><br>
					<input name="Heading"  size = "65" value = "<%=PageHeading1%>">
			</td>
		</tr>
		<tr>
			<td  align = "right" class = "body" valign = "top">
					<b>Text: </b>
			</td>
			<td  align = "left" valign = "top" class = "body">
					<TEXTAREA NAME="Text" cols="44" rows="16" wrap="file"><%=PageText%></textarea>
			</td>
		</tr>
		<tr>
		<td  valign = "middle" colspan = "2" align = "center">
			<input type=submit value = "Submit Changes" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" Class = "body" >
		</td>
		</tr>
		</table>

</form>
	  </td>
	  <td valign = "top"  bgcolor = "bbbbbb">
			<table Border = "0" width = "150" align = "center">
			<tr>
				<td >
					<h2>Image</h2>
				</td>
			</tr>
			<tr>
				<td width = "100" align = "center">
					<% If Len(Image1) > 2 Then %>
							<img src = "<%=Image1%>" height = "100">
					<% Else %>
							<h2>No Image</h2>
					<% End If %>
				</td>
			</tr>
			
			<tr>
				<td class = "body">
					<table>
					   <tr>
					     <td class = "body">
							<form name="frmSend" method="POST" enctype="multipart/form-data" action="PageDatauploadPageImage.asp" >
								

								Upload Photo: <br>
								<input name="attach1" type="file" size=35 >
								<input  type=submit value="Upload">
							</form>
						<td>
						</tr>
					
						<tr>
							<td>
								<form method="POST" action="PageDataImageOrientation.asp" >
								<b>Orientation: </b>
								   <% If ImageCaption1= "0" Then
											ImageCaption1 = ""
										End If %>

										<select size="1" name="Orientation">
										<option value="<%=ImageOrientation1%>" selected><%=ImageOrientation1%></option>
										<option value="Left">Left</option>
										<option  value="Right">Right</option>
										</select>
								
									<input type = "hidden" name="OrientationImageID" value= "1" >
									<input type=submit value = "Submit" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" Class = "body" >
								</form>
							</td>
						</tr>
						<tr>
					    <td class = "body">
							<form action= 'RemovePageDataImage.asp' method = "post">
								<input type = "hidden" name="ImageID" value= "1" >
								<input type=submit value="Remove This Image">
							</form>
					</td>
				</tr>
				</table>
	   <td>
	 </tr>
</table>
  <td>
	 </tr>
</table>

</td>
</tr>
</table>

<%
 Block = 2
	 ImageLink = ImageLink2
	 	 Textblock =  2
	  TempPageLayout2ID = 2
	 PageHeading =PageHeading2
	  PageText = PageText2
	 BlockImage = Image2
	 ImageCaption = ImageCaption2
	 ImageOrientation = ImageOrientation2
	 filename = "Fleece.asp"
	 Upload = Upload2
	  Upload2A = Upload2A
	 UploadText = UploadText2
	 UploadFile = "PageDatauploadPageImage.asp"
	 If BlockImageCaption= "0" Then
		BlockImageCaption = ""
	End If

 if PageName = "Fleece" then 
 response.write("PageName2 = " & PageName )
 PageName =Session("PageName")
 %>

	<!--#Include virtual="/Administration/PageBlockInclude2.asp"--> 
	
	
<% else %>

<a name="TextBlock2"></a>
<table border = "1" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
  <tr>
    <td>
<table border= "0">

   <tr>
      <td >
<table border = "0" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
		
		<form action= 'PageDataPageHandleForm.asp' method = "post">
			<input name="TextBlock"  size = "60" value = "TB2" type = "hidden">
		
	<tr>
			<td  align = "left"   class = "body" colspan = "2">
					<b>Heading: </b><br>
					<input name="Heading"  size = "65" value = "<%=PageHeading2%>">
			</td>
		</tr>
		<tr>
			<td  align = "right" class = "body" valign = "top">
					<b>Text: </b>
			</td>
			<td  align = "left" valign = "top" class = "body">
					<TEXTAREA NAME="Text" cols="44" rows="16" wrap="file"><%=PageText2%></textarea>
			</td>
		</tr>
		<tr>
		<td  valign = "middle" colspan = "2" align = "center">
			<input type=submit value = "Submit Changes" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" Class = "body" >
		</td>
		</tr>
		</table>

</form>
	  </td>
	  <td valign = "top"  bgcolor = "bbbbbb">
			<table Border = "0" width = "150" align = "center">
			<tr>
				<td >
					<h2>Image</h2>
				</td>
			</tr>
			<tr>
				<td width = "100" align = "center">
					<% If Len(Image2) > 2 Then %>
							<img src = "<%=Image2%>" height = "100">
					<% Else %>
							<h2>No Image</h2>
					<% End If %>
				</td>
			</tr>
			
			<tr>
				<td class = "body">
					<table>
					   <tr>
					     <td class = "body">
							<form name="frmSend" method="POST" enctype="multipart/form-data" action="PageDatauploadPageImage2.asp" >
								

								Upload Photo: <br>
								<input name="attach2" type="file" size=35 >
								<input  type=submit value="Upload">
							</form>
						<td>
						</tr>
						<tr>
							<td>
								<form method="POST" action="PageDataImageOrientation.asp" >
								<b>Orientation: </b>
						

										<select size="1" name="Orientation">
										<option value="<%=ImageOrientation2%>" selected><%=ImageOrientation2%></option>
										<option value="Left">Left</option>
										<option  value="Right">Right</option>
									</select>
								
									<input type = "hidden" name="OrientationImageID" value= "2" >
									<input type=submit value = "Submit" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" Class = "body" >
								</form>
							</td>
						</tr>
						
						<tr>
					    <td class = "body">
							<form action= 'RemovePageDataImage.asp' method = "post">
								<input type = "hidden" name="ImageID" value= "2" >
								<input type=submit value="Remove This Image">
							</form>
					</td>
				</tr>
				</table>
	   <td>
	 </tr>
</table>
  <td>
	 </tr>
</table>


</td>
</tr>
</table>



<% end if %>








<a name="TextBlock3"></a>
<table border = "1" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
  <tr>
    <td>
<table border= "0">

   <tr>
      <td >
<table border = "0" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
		
		<form action= 'PageDataPageHandleForm.asp' method = "post">
			<input name="TextBlock"  size = "60" value = "TB3" type = "hidden">
		
	<tr>
			<td  align = "left"   class = "body" colspan = "2">
					<b>Heading: </b><br>
					<input name="Heading"  size = "65" value = "<%=PageHeading3%>">
			</td>
		</tr>
		<tr>
			<td  align = "right" class = "body" valign = "top">
					<b>Text: </b>
			</td>
			<td  align = "left" valign = "top" class = "body">
					<TEXTAREA NAME="Text" cols="44" rows="16" wrap="file"><%=PageText3%></textarea>
			</td>
		</tr>
		<tr>
		<td  valign = "middle" colspan = "2" align = "center">
			<input type=submit value = "Submit Changes" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" Class = "body" >
		</td>
		</tr>
		</table>

</form>
	  </td>
	  <td valign = "top"  bgcolor = "bbbbbb">
			<table Border = "0" width = "150" align = "center">
			<tr>
				<td >
					<h2>Image</h2>
				</td>
			</tr>
			<tr>
				<td width = "100" align = "center">
					<% If Len(Image3) > 2 Then %>
							<img src = "<%=Image3%>" height = "100">
					<% Else %>
							<h2>No Image</h2>
					<% End If %>
				</td>
			</tr>
			
			<tr>
				<td class = "body">
					<table>
					   <tr>
					     <td class = "body">
							<form name="frmSend" method="POST" enctype="multipart/form-data" action="PageDatauploadPageImage3.asp" >
								

								Upload Photo: <br>
								<input name="attach2" type="file" size=35 >
								<input  type=submit value="Upload">
							</form>
						<td>
						</tr>
						<tr>
							<td>
								<form method="POST" action="PageDataImageOrientation.asp" >
								<b>Orientation: </b>
		
										<select size="1" name="Orientation">
										<option value="<%=ImageOrientation3%>" selected><%=ImageOrientation3%></option>
										<option value="Left">Left</option>
										<option  value="Right">Right</option>
									</select>
								
									<input type = "hidden" name="OrientationImageID" value= "3" >
									<input type=submit value = "Submit" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" Class = "body" >
								</form>
							</td>
						</tr>
						
						<tr>
					    <td class = "body">
							<form action= 'RemovePageDataImage.asp' method = "post">
								<input type = "hidden" name="ImageID" value= "3" >
								<input type=submit value="Remove This Image">
							</form>
					</td>
				</tr>
				</table>
	   <td>
	 </tr>
</table>
  <td>
	 </tr>
</table>


</td>
</tr>
</table>






<a name="TextBlock4"></a>
<table border = "1" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
  <tr>
    <td>
<table border= "0">

   <tr>
      <td >
<table border = "0" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
		
		<form action= 'PageDataPageHandleForm.asp' method = "post">
			<input name="TextBlock"  size = "60" value = "TB4" type = "hidden">
		
	<tr>
			<td  align = "left"   class = "body" colspan = "2">
					<b>Heading: </b><br>
					<input name="Heading"  size = "65" value = "<%=PageHeading4%>">
			</td>
		</tr>
		<tr>
			<td  align = "right" class = "body" valign = "top">
					<b>Text: </b>
			</td>
			<td  align = "left" valign = "top" class = "body">
					<TEXTAREA NAME="Text" cols="44" rows="16" wrap="file"><%=PageText4%></textarea>
			</td>
		</tr>
		<tr>
		<td  valign = "middle" colspan = "2" align = "center">
			<input type=submit value = "Submit Changes" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" Class = "body" >
		</td>
		</tr>
		</table>

</form>
	  </td>
	  <td valign = "top"  bgcolor = "bbbbbb">
			<table Border = "0" width = "150" align = "center">
			<tr>
				<td >
					<h2>Image</h2>
				</td>
			</tr>
			<tr>
				<td width = "100" align = "center">
					<% If Len(Image4) > 2 Then %>
							<img src = "<%=Image4%>" height = "100">
					<% Else %>
							<h2>No Image</h2>
					<% End If %>
				</td>
			</tr>
			
			<tr>
				<td class = "body">
					<table>
					   <tr>
					     <td class = "body">
							<form name="frmSend" method="POST" enctype="multipart/form-data" action="PageDatauploadPageImage4.asp" >
								

								Upload Photo: <br>
								<input name="attach2" type="file" size=35 >
								<input  type=submit value="Upload">
							</form>
						<td>
						</tr>
						<tr>
							<td>
								<form method="POST" action="PageDataImageOrientation.asp" >
								<b>Orientation: </b>
								   <% If ImageCaption1= "0" Then
											ImageCaption1 = ""
										End If %>

										<select size="1" name="Orientation">
										<option value="<%=ImageOrientation4%>" selected><%=ImageOrientation4%></option>
										<option value="Left">Left</option>
										<option  value="Right">Right</option>
										</select>
								
									<input type = "hidden" name="OrientationImageID" value= "4" >
									<input type=submit value = "Submit" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" Class = "body" >
								</form>
							</td>
						</tr>
					
						<tr>
					    <td class = "body">
							<form action= 'RemovePageDataImage.asp' method = "post">
								<input type = "hidden" name="ImageID" value= "4" >
								<input type=submit value="Remove This Image">
							</form>
					</td>
				</tr>
				</table>
	   <td>
	 </tr>
</table>
  <td>
	 </tr>
</table>


</td>
</tr>
</table>











<a name="TextBlock5"></a>
<table border = "1" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
  <tr>
    <td>
<table border= "0">

   <tr>
      <td >
<table border = "0" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
		
		<form action= 'PageDataPageHandleForm.asp' method = "post">
			<input name="TextBlock"  size = "60" value = "TB5" type = "hidden">
		
	<tr>
			<td  align = "left"   class = "body" colspan = "2">
					<b>Heading: </b><br>
					<input name="Heading"  size = "65" value = "<%=PageHeading5%>">
			</td>
		</tr>
		<tr>
			<td  align = "right" class = "body" valign = "top">
					<b>Text: </b>
			</td>
			<td  align = "left" valign = "top" class = "body">
					<TEXTAREA NAME="Text" cols="44" rows="16" wrap="file"><%=PageText5%></textarea>
			</td>
		</tr>
		<tr>
		<td  valign = "middle" colspan = "2" align = "center">
			<input type=submit value = "Submit Changes" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" Class = "body" >
		</td>
		</tr>
		</table>

</form>
	  </td>
	  <td valign = "top"  bgcolor = "bbbbbb">
			<table Border = "0" width = "150" align = "center">
			<tr>
				<td >
					<h2>Image</h2>
				</td>
			</tr>
			<tr>
				<td width = "100" align = "center">
					<% If Len(Image5) > 2 Then %>
							<img src = "<%=Image5%>" height = "100">
					<% Else %>
							<h2>No Image</h2>
					<% End If %>
				</td>
			</tr>
			
			<tr>
				<td class = "body">
					<table>
					   <tr>
					     <td class = "body">
							<form name="frmSend" method="POST" enctype="multipart/form-data" action="PageDatauploadPageImage5.asp" >
								

								Upload Photo: <br>
								<input name="attach2" type="file" size=35 >
								<input  type=submit value="Upload">
							</form>
						<td>
						</tr>
						<tr>
							<td>
								<form method="POST" action="PageDataImageOrientation.asp" >
								<b>Orientation: </b>
		
										<select size="1" name="Orientation">
										<option value="<%=ImageOrientation5%>" selected><%=ImageOrientation5%></option>
										<option value="Left">Left</option>
										<option  value="Right">Right</option>
									</select>
								
									<input type = "hidden" name="OrientationImageID" value= "5" >
									<input type=submit value = "Submit" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" Class = "body" >
								</form>
							</td>
						</tr>
						
						<tr>
					    <td class = "body">
							<form action= 'RemovePageDataImage.asp' method = "post">
								<input type = "hidden" name="ImageID" value= "5" >
								<input type=submit value="Remove This Image">
							</form>
					</td>
				</tr>
				</table>
	   <td>
	 </tr>
</table>
  <td>
	 </tr>
</table>
 <td>
	 </tr>
</table>






<a name="TextBlock6"></a>
<table border = "1" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
  <tr>
    <td>
<table border= "0">

   <tr>
      <td >
<table border = "0" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
		
		<form action= 'PageDataPageHandleForm.asp' method = "post">
			<input name="TextBlock"  size = "60" value = "TB6" type = "hidden">
		
	<tr>
			<td  align = "left"   class = "body" colspan = "2">
					<b>Heading: </b><br>
					<input name="Heading"  size = "65" value = "<%=PageHeading6%>">
			</td>
		</tr>
		<tr>
			<td  align = "right" class = "body" valign = "top">
					<b>Text: </b>
			</td>
			<td  align = "left" valign = "top" class = "body">
					<TEXTAREA NAME="Text" cols="44" rows="16" wrap="file"><%=PageText6%></textarea>
			</td>
		</tr>
		<tr>
		<td  valign = "middle" colspan = "2" align = "center">
			<input type=submit value = "Submit Changes" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" Class = "body" >
		</td>
		</tr>
		</table>

</form>
	  </td>
	  <td valign = "top"  bgcolor = "bbbbbb">
			<table Border = "0" width = "150" align = "center">
			<tr>
				<td >
					<h2>Image</h2>
				</td>
			</tr>
			<tr>
				<td width = "100" align = "center">
					<% If Len(Image6) > 2 Then %>
							<img src = "<%=Image6%>" height = "100">
					<% Else %>
							<h2>No Image</h2>
					<% End If %>
				</td>
			</tr>
			
			<tr>
				<td class = "body">
					<table>
					   <tr>
					     <td class = "body">
							<form name="frmSend" method="POST" enctype="multipart/form-data" action="PageDatauploadPageImage6.asp" >
								

								Upload Photo: <br>
								<input name="attach2" type="file" size=35 >
								<input  type=submit value="Upload">
							</form>
						<td>
						</tr>
						<tr>
							<td>
								<form method="POST" action="PageDataImageOrientation.asp" >
								<b>Orientation: </b>
		
										<select size="1" name="Orientation">
										<option value="<%=ImageOrientation6%>" selected><%=ImageOrientation6%></option>
										<option value="Left">Left</option>
										<option  value="Right">Right</option>
									</select>
								
									<input type = "hidden" name="OrientationImageID" value= "6" >
									<input type=submit value = "Submit" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" Class = "body" >
								</form>
							</td>
						</tr>
						
						<tr>
					    <td class = "body">
							<form action= 'RemovePageDataImage.asp' method = "post">
								<input type = "hidden" name="ImageID" value= "6" >
								<input type=submit value="Remove This Image">
							</form>
					</td>
				</tr>
				</table>
	   <td>
	 </tr>
</table>
  <td>
	 </tr>
</table>
 <td>
	 </tr>
</table>







<a name="TextBlock7"></a>
<table border = "1" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
  <tr>
    <td>
<table border= "0">

   <tr>
      <td >
<table border = "0" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
		
		<form action= 'PageDataPageHandleForm.asp' method = "post">
			<input name="TextBlock"  size = "60" value = "TB7" type = "hidden">
	
	<tr>
			<td  align = "left"   class = "body" colspan = "2">
					<b>Heading: </b><br>
					<input name="Heading"  size = "65" value = "<%=PageHeading7%>">
			</td>
		</tr>
		<tr>
			<td  align = "right" class = "body" valign = "top">
					<b>Text: </b>
			</td>
			<td  align = "left" valign = "top" class = "body">
					<TEXTAREA NAME="Text" cols="44" rows="16" wrap="file"><%=PageText7%></textarea>
			</td>
		</tr>
		<tr>
		<td  valign = "middle" colspan = "2" align = "center">
			<input type=submit value = "Submit Changes" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" Class = "body" >
		</td>
		</tr>
		</table>

</form>
	  </td>
	  <td valign = "top"  bgcolor = "bbbbbb">
			<table Border = "0" width = "150" align = "center">
			<tr>
				<td >
					<h2>Image</h2>
				</td>
			</tr>
			<tr>
				<td width = "100" align = "center">
					<% If Len(Image7) > 2 Then %>
							<img src = "<%=Image7%>" height = "100">
					<% Else %>
							<h2>No Image</h2>
					<% End If %>
				</td>
			</tr>
			
			<tr>
				<td class = "body">
					<table>
					   <tr>
					     <td class = "body">
							<form name="frmSend" method="POST" enctype="multipart/form-data" action="PageDatauploadPageImage7.asp" >
								

								Upload Photo: <br>
								<input name="attach2" type="file" size=35 >
								<input  type=submit value="Upload">
							</form>
						<td>
						</tr>
						<tr>
							<td>
								<form method="POST" action="PageDataImageOrientation.asp" >
								<b>Orientation: </b>
		
										<select size="1" name="Orientation">
										<option value="<%=ImageOrientation7%>" selected><%=ImageOrientation7%></option>
										<option value="Left">Left</option>
										<option  value="Right">Right</option>
									</select>
								
									<input type = "hidden" name="OrientationImageID" value= "7" >
									<input type=submit value = "Submit" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" Class = "body" >
								</form>
							</td>
						</tr>
						
						<tr>
					    <td class = "body">
							<form action= 'RemovePageDataImage.asp' method = "post">
								<input type = "hidden" name="ImageID" value= "7" >
								<input type=submit value="Remove This Image">
							</form>
					</td>
				</tr>
				</table>
	   <td>
	 </tr>
</table>
  <td>
	 </tr>
</table>


</td>
</tr>
</table>
<br><br><br>
<div align = "center"><a href = "#Top" class ="body">Click here to go to the top of the page.</a></center>