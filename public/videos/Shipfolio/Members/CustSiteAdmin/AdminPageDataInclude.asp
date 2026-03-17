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
PageTitle = rs("PageTitle")
PageHeading1= rs("PageHeading1")
PageHeading2= rs("PageHeading2")
PageHeading3= rs("PageHeading3")
PageHeading4= rs("PageHeading4")
PageHeading5= rs("PageHeading5")
PageHeading6= rs("PageHeading6")
PageHeading7= rs("PageHeading7")
PageHeading8= rs("PageHeading8")
PageText = rs("PageText")
PageText2 = rs("PageText2")
PageText3 = rs("PageText3")
PageText4 = rs("PageText4")
PageText5 = rs("PageText5")
PageText6 = rs("PageText6")
PageText7 = rs("PageText7")
PageText8 = rs("PageText8")
Image1= rs("Image1")
Image2= rs("Image2")
Image3= rs("Image3")
Image4= rs("Image4")
Image5= rs("Image5")
Image6= rs("Image6")
Image7= rs("Image7")
Image8= rs("Image8")
ImageCaption1= rs("ImageCaption1")
ImageCaption2= rs("ImageCaption2")
ImageCaption3= rs("ImageCaption3")
ImageCaption4= rs("ImageCaption4")
ImageCaption5= rs("ImageCaption5")
ImageCaption6= rs("ImageCaption6")
ImageCaption7= rs("ImageCaption7")
ImageCaption8= rs("ImageCaption8")
ImageOrientation1= rs("ImageOrientation1")
ImageOrientation2= rs("ImageOrientation2")
ImageOrientation3= rs("ImageOrientation3")
ImageOrientation4= rs("ImageOrientation4")
ImageOrientation5= rs("ImageOrientation5")
ImageOrientation6= rs("ImageOrientation6")
ImageOrientation7= rs("ImageOrientation7")
ImageOrientation8= rs("ImageOrientation8")


if ImageCaption1 = "0" then
   ImageCaption1 = ""
end if


if ImageCaption2 = "0" then
   ImageCaption2 = ""
end if

if ImageCaption3 = "0" then
   ImageCaption3 = ""
end if

if ImageCaption4 = "0" then
   ImageCaption4 = ""
end if

if ImageCaption5 = "0" then
   ImageCaption5 = ""
end if

if ImageCaption6 = "0" then
   ImageCaption6 = ""
end if

if ImageCaption7 = "0" then
   ImageCaption7 = ""
end if

if ImageCaption8 = "0" then
   ImageCaption8 = ""
end if


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

str1 = PageText5
str2 = "</br>"
If InStr(str1,str2) > 0 Then
	PageText5= Replace(str1, str2 , vbCrLf)
End If  

str1 =PageText5
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageText5= Replace(str1,  str2, " ")
End If 

str1 = PageText5
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageText5= Replace(str1,  str2, "'")
End If 

str1 = PageText6
str2 = "</br>"
If InStr(str1,str2) > 0 Then
	PageText6= Replace(str1, str2 , vbCrLf)
End If  

str1 =PageText6
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageText6= Replace(str1,  str2, " ")
End If 

str1 = PageText6
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageText6= Replace(str1,  str2, "'")
End If 

str1 = PageText7
str2 = "</br>"
If InStr(str1,str2) > 0 Then
	PageText7= Replace(str1, str2 , vbCrLf)
End If  

str1 =PageText7
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageText7= Replace(str1,  str2, " ")
End If 

str1 = PageText7
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageText7= Replace(str1,  str2, "'")
End If 

str1 = PageText8
str2 = "</br>"
If InStr(str1,str2) > 0 Then
	PageText8= Replace(str1, str2 , vbCrLf)
End If  

str1 =PageText8
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageText8= Replace(str1,  str2, " ")
End If 

str1 = PageText8
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageText8= Replace(str1,  str2, "'")
End If 
%><table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "900" align = "center"  >
	<tr>
		<td Class = "body"><a name="Top"></a><H2>Page Content</h2></td>
	</tr>
</table>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "900" align = "center" >
	<tr>
	    <td class = "body">
             Your page is built from multiple "Text Blocks". Each Text Block is comprised of:
				<ul>
					<li>A Heading</li>
					<li>Text
					<li>An Image with a caption
				</ul>
              Select the links below to go directly to:
			      <ul>
					<li><a href = "#Heading" class ="body">The page heading</a>
				  	<li><a href = "#TextBlock1" class ="body">Text Block 1</a>
				  	<li><a href = "#TextBlock2" class ="body">Text Block 2</a>
				  	<li><a href = "#TextBlock3" class ="body">Text Block 3</a>
				  	<li><a href = "#TextBlock4" class ="body">Text Block 4</a>
					<li><a href = "#TextBlock5" class ="body">Text Block 5</a>
					<li><a href = "#TextBlock6" class ="body">Text Block 6</a>
					<li><a href = "#TextBlock7" class ="body">Text Block 7</a>
				<li><a href = "#TextBlock8" class ="body">Text Block 8</a>
				</ul><a name="Heading"></a>
				<br>
		</td>
		<td Class = "body">
			
			<img src = "images/TextBlocks.jpg" height = "250"></H2>
		</td>
	</tr>
</table>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "900" align = "center" bgcolor = "eeeeee">
<tr>
			<td  align = "center" class = "body" valign = "top" colspan= "2"  height = "14" width = "900" align = "center">
					<big><b><font color = "black">Page Heading</font></b></big> </b>
			</td>
		</tr>
   <tr>
</table>

<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "900" align = "center" >
	<tr>
		<td valign = "top">
			 <form action= 'AdminPageDataHandleForm.asp' method = "post">
			<input name="TextBlock"  size = "60" value = "Heading" type = "hidden">

			<table border = "0" bordercolor = "eeeeee" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "580">
  			<tr>
				<td  align = "right"   class = "body">
						<b>Page Heading: </b>
				</td>
				<td  align = "left" valign = "top" class = "body">
					<input name="Text"  size = "60" value = "<%=PageTitle%>">
				</td>
			</tr>
	<tr>
		<td  valign = "middle" colspan = "2" align = "center">
			<input type=submit value = "Submit Changes" size = "110" Class = "body" >
		</td>
		</tr>
		</table>

</form>


<a name="TextBlock1"></a>
<table border = "0" bordercolor = "eeeeee" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
  <tr>
    <td>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "900" align = "center" >
<tr>
			<td  align = "center" class = "body" colspan= "2" bgcolor = "eeeeee" height = "24">
					<big><b><font color = "black">Text Block 1</font></b></big> </b>
			</td>
		</tr>
   <tr>
      <td >
<table border = "0" bordercolor = "eeeeee" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
		
		<form action= 'AdminPageDataHandleForm.asp' method = "post">
			<input name="TextBlock"  size = "60" value = "TB1" type = "hidden">
	
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
			<input type=submit value = "Submit Changes"  size = "110" Class = "body" >
		</td>
		</tr>
		</table>

</form>
	  </td>
	  <td valign = "top"  bgcolor = "eeeeee">
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
							<form name="frmSend" method="POST" enctype="multipart/form-data" action="AdminPageDataUploadPageImage.asp" >
								Upload Photo: <br>
								<input name="attach1" type="file" size=35 >
								<input  type=submit value="Upload">
							</form>
						<td>
						</tr>
					
						<tr>
							<td>
								<form method="POST" action="AdminPageDataImageOrientation.asp" >
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
									<input type=submit value = "Submit"  size = "110" Class = "body" >
								</form>
							</td>
						</tr>
							<tr>
						   <td class = "body">
							<form action= 'AdminPageAddCaption.asp' method = "post">
								Current Caption: <b><%=ImageCaption1%></b><br>
								New Caption (20 Character Max.): <input name="Caption" Value ="<%=ImageCaption1%>"  size = "40" maxlength = "80"><br>
								<input type = "hidden" name="CaptionID" value= "1" >
								<input type = "hidden" name="PageName" value= "<%= PageName %>" >
											<input type = "hidden" name="Redirectpage" value= "AdminPageData.asp?PageName=<%= PageName %>" >
								<input type=submit value="Submit">
								</form>
						   </td>
						 </tr>
						<tr>
					    <td class = "body">
							<form action= 'AdminPageDataRemoveImage.asp' method = "post">
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


<a name="TextBlock2"></a>
<table border = "0" bordercolor = "eeeeee" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
  <tr>
    <td>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "900" align = "center" >
<tr>
			<td  align = "center" class = "body" colspan= "2" bgcolor = "eeeeee" height = "24">
					<big><b><font color = "black">Text Block 2</font></b></big> </b>
			</td>
		</tr>
   <tr>
      <td >
<table border = "0" bordercolor = "eeeeee" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
		
		<form action= 'AdminPageDataHandleForm.asp' method = "post">
			<input name="TextBlock"  size = "60" value = "TB2" type = "hidden">
		
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
			<input type=submit value = "Submit Changes"  size = "110" Class = "body" >
		</td>
		</tr>
		</table>

</form>
	  </td>
	  <td valign = "top"  bgcolor = "eeeeee">
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
							<form name="frmSend" method="POST" enctype="multipart/form-data" action="AdminPageDataUploadPageImage2.asp" >
								

								Upload Photo: <br>
								<input name="attach2" type="file" size=35 >
								<input  type=submit value="Upload">
							</form>
						<td>
						</tr>
						<tr>
							<td>
								<form method="POST" action="AdminPageDataImageOrientation.asp" >
								<b>Orientation: </b>
						

										<select size="1" name="Orientation">
										<option value="<%=ImageOrientation2%>" selected><%=ImageOrientation2%></option>
										<option value="Left">Left</option>
										<option  value="Right">Right</option>
									</select>
								
									<input type = "hidden" name="OrientationImageID" value= "2" >
									<input type=submit value = "Submit"  size = "110" Class = "body" >
								</form>
							</td>
						</tr>
						<tr>
						   <td class = "body">
							<form action= 'AdminPageAddCaption.asp' method = "post">
								Current Caption: <b><%=ImageCaption2%></b><br>
								New Caption (20 Character Max.): <input name="Caption" Value ="<%=ImageCaption2%>"  size = "40" maxlength = "80"><br>
								<input type = "hidden" name="CaptionID" value= "2" >
								<input type = "hidden" name="PageName" value= "<%= PageName %>" >
											<input type = "hidden" name="Redirectpage" value= "AdminPageData.asp?PageName=<%= PageName %>" >
								<input type=submit value="Submit">
								</form>
						   </td>
						 </tr>
						<tr>
					    <td class = "body">
							<form action= 'AdminPageDataRemoveImage.asp' method = "post">
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












<a name="TextBlock3"></a>
<table border = "0" bordercolor = "eeeeee" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
  <tr>
    <td>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "900" align = "center" >
<tr>
			<td  align = "center" class = "body" colspan= "2" bgcolor = "eeeeee" height = "24">
					<big><b><font color = "black">Text Block 3</font></b></big> </b>
			</td>
		</tr>
   <tr>
      <td >
<table border = "0" bordercolor = "eeeeee" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
		
		<form action= 'AdminPageDataHandleForm.asp' method = "post">
			<input name="TextBlock"  size = "60" value = "TB3" type = "hidden">
		
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
			<input type=submit value = "Submit Changes"  size = "110" Class = "body" >
		</td>
		</tr>
		</table>

</form>
	  </td>
	  <td valign = "top"  bgcolor = "eeeeee">
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
							<form name="frmSend" method="POST" enctype="multipart/form-data" action="AdminPageDataUploadPageImage3.asp" >
								

								Upload Photo: <br>
								<input name="attach2" type="file" size=35 >
								<input  type=submit value="Upload">
							</form>
						<td>
						</tr>
						<tr>
							<td>
								<form method="POST" action="AdminPageDataImageOrientation.asp" >
								<b>Orientation: </b>
		
										<select size="1" name="Orientation">
										<option value="<%=ImageOrientation3%>" selected><%=ImageOrientation3%></option>
										<option value="Left">Left</option>
										<option  value="Right">Right</option>
									</select>
								
									<input type = "hidden" name="OrientationImageID" value= "3" >
									<input type=submit value = "Submit"  size = "110" Class = "body" >
								</form>
							</td>
						</tr>
						<tr>
						   <td class = "body">
							<form action= 'AdminPageAddCaption.asp' method = "post">
								Current Caption: <b><%=ImageCaption3%></b><br>
								New Caption (20 Character Max.): <input name="Caption" Value ="<%=ImageCaption3%>"  size = "40" maxlength = "80"><br>
								<input type = "hidden" name="CaptionID" value= "3" >
								<input type = "hidden" name="PageName" value= "<%= PageName %>" >
											<input type = "hidden" name="Redirectpage" value= "AdminPageData.asp?PageName=<%= PageName %>" >
								<input type=submit value="Submit">
								</form>
						   </td>
						 </tr>
						<tr>
					    <td class = "body">
							<form action= 'AdminPageDataRemoveImage.asp' method = "post">
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
<table border = "0" bordercolor = "eeeeee" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
  <tr>
    <td>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "900" align = "center" >
<tr>
			<td  align = "center" class = "body" colspan= "2" bgcolor = "eeeeee" height = "24">
					<big><b><font color = "black">Text Block 4</font></b></big> </b>
			</td>
		</tr>
   <tr>
      <td >
<table border = "0" bordercolor = "eeeeee" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
		
		<form action= 'AdminPageDataHandleForm.asp' method = "post">
			<input name="TextBlock"  size = "60" value = "TB4" type = "hidden">
		
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
			<input type=submit value = "Submit Changes"  size = "110" Class = "body" >
		</td>
		</tr>
		</table>

</form>
	  </td>
	  <td valign = "top"  bgcolor = "eeeeee">
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
							<form name="frmSend" method="POST" enctype="multipart/form-data" action="AdminPageDataUploadPageImage4.asp" >
								

								Upload Photo: <br>
								<input name="attach2" type="file" size=35 >
								<input  type=submit value="Upload">
							</form>
						<td>
						</tr>
						<tr>
							<td>
								<form method="POST" action="AdminPageDataImageOrientation.asp" >
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
									<input type=submit value = "Submit"  size = "110" Class = "body" >
								</form>
							</td>
						</tr>
					<tr>
						   <td class = "body">
							<form action= 'AdminPageAddCaption.asp' method = "post">
								Current Caption: <b><%=ImageCaption4%></b><br>
								New Caption (20 Character Max.): <input name="Caption" Value ="<%=ImageCaption4%>"  size = "40" maxlength = "80"><br>
								<input type = "hidden" name="CaptionID" value= "4" >
								<input type = "hidden" name="PageName" value= "<%= PageName %>" >
											<input type = "hidden" name="Redirectpage" value= "AdminPageData.asp?PageName=<%= PageName %>" >
								<input type=submit value="Submit">
								</form>
						   </td>
						 </tr>
						<tr>
					    <td class = "body">
							<form action= 'AdminPageDataRemoveImage.asp' method = "post">
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
<table border = "0" bordercolor = "eeeeee" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
  <tr>
    <td>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "900" align = "center" >
<tr>
			<td  align = "center" class = "body" colspan= "2" bgcolor = "eeeeee" height = "24">
					<big><b><font color = "black">Text Block 5</font></b></big> </b>
			</td>
		</tr>
   <tr>
      <td >
<table border = "0" bordercolor = "eeeeee" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
		
		<form action= 'AdminPageDataHandleForm.asp' method = "post">
			<input name="TextBlock"  size = "60" value = "TB5" type = "hidden">
		
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
			<input type=submit value = "Submit Changes"  size = "110" Class = "body" >
		</td>
		</tr>
		</table>

</form>
	  </td>
	  <td valign = "top"  bgcolor = "eeeeee">
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
							<form name="frmSend" method="POST" enctype="multipart/form-data" action="AdminPageDataUploadPageImage5.asp" >
								

								Upload Photo: <br>
								<input name="attach2" type="file" size=35 >
								<input  type=submit value="Upload">
							</form>
						<td>
						</tr>
						<tr>
							<td>
								<form method="POST" action="AdminPageDataImageOrientation.asp" >
								<b>Orientation: </b>
								   <% If ImageCaption1= "0" Then
											ImageCaption1 = ""
										End If %>

										<select size="1" name="Orientation">
										<option value="<%=ImageOrientation5%>" selected><%=ImageOrientation5%></option>
										<option value="Left">Left</option>
										<option  value="Right">Right</option>
										</select>
								
									<input type = "hidden" name="OrientationImageID" value= "5" >
									<input type=submit value = "Submit"  size = "110" Class = "body" >
								</form>
							</td>
						</tr>
					<tr>
						   <td class = "body">
							<form action= 'AdminPageAddCaption.asp' method = "post">
								Current Caption: <b><%=ImageCaption5%></b><br>
								New Caption (20 Character Max.): <input name="Caption" Value ="<%=ImageCaption5%>"  size = "40" maxlength = "80"><br>
								<input type = "hidden" name="CaptionID" value= "5" >
								<input type = "hidden" name="PageName" value= "<%= PageName %>" >
											<input type = "hidden" name="Redirectpage" value= "AdminPageData.asp?PageName=<%= PageName %>" >
								<input type=submit value="Submit">
								</form>
						   </td>
						 </tr>
						<tr>
					    <td class = "body">
							<form action= 'AdminPageDataRemoveImage.asp' method = "post">
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

<a name="TextBlock6"></a>
<table border = "0" bordercolor = "eeeeee" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
  <tr>
    <td>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "900" align = "center" >
<tr>
			<td  align = "center" class = "body" colspan= "2" bgcolor = "eeeeee" height = "24">
					<big><b><font color = "black">Text Block 6</font></b></big> </b>
			</td>
		</tr>
   <tr>
      <td >
<table border = "0" bordercolor = "eeeeee" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
		
		<form action= 'AdminPageDataHandleForm.asp' method = "post">
			<input name="TextBlock"  size = "60" value = "TB6" type = "hidden">
		
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
			<input type=submit value = "Submit Changes"  size = "110" Class = "body" >
		</td>
		</tr>
		</table>

</form>
	  </td>
	  <td valign = "top"  bgcolor = "eeeeee">
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
							<form name="frmSend" method="POST" enctype="multipart/form-data" action="AdminPageDataUploadPageImage6.asp" >
								

								Upload Photo: <br>
								<input name="attach2" type="file" size=35 >
								<input  type=submit value="Upload">
							</form>
						<td>
						</tr>
						<tr>
							<td>
								<form method="POST" action="AdminPageDataImageOrientation.asp" >
								<b>Orientation: </b>
								   <% If ImageCaption1= "0" Then
											ImageCaption1 = ""
										End If %>

										<select size="1" name="Orientation">
										<option value="<%=ImageOrientation6%>" selected><%=ImageOrientation6%></option>
										<option value="Left">Left</option>
										<option  value="Right">Right</option>
										</select>
								
									<input type = "hidden" name="OrientationImageID" value= "6" >
									<input type=submit value = "Submit"  size = "110" Class = "body" >
								</form>
							</td>
						</tr>
					<tr>
						   <td class = "body">
							<form action= 'AdminPageAddCaption.asp' method = "post">
								Current Caption: <b><%=ImageCaption6%></b><br>
								New Caption (20 Character Max.): <input name="Caption" Value ="<%=ImageCaption6%>"  size = "40" maxlength = "80"><br>
								<input type = "hidden" name="CaptionID" value= "6" >
								<input type = "hidden" name="PageName" value= "<%= PageName %>" >
											<input type = "hidden" name="Redirectpage" value= "AdminPageData.asp?PageName=<%= PageName %>" >
								<input type=submit value="Submit">
								</form>
						   </td>
						 </tr>
						<tr>
					    <td class = "body">
							<form action= 'AdminPageDataRemoveImage.asp' method = "post">
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

<a name="TextBlock7"></a>
<table border = "0" bordercolor = "eeeeee" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
  <tr>
    <td>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "900" align = "center" >
<tr>
			<td  align = "center" class = "body" colspan= "2" bgcolor = "eeeeee" height = "24">
					<big><b><font color = "black">Text Block 7</font></b></big> </b>
			</td>
		</tr>
   <tr>
      <td >
<table border = "0" bordercolor = "eeeeee" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
		
		<form action= 'AdminPageDataHandleForm.asp' method = "post">
			<input name="TextBlock"  size = "60" value = "TB7" type = "hidden">
		
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
			<input type=submit value = "Submit Changes"  size = "110" Class = "body" >
		</td>
		</tr>
		</table>

</form>
	  </td>
	  <td valign = "top"  bgcolor = "eeeeee">
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
							<form name="frmSend" method="POST" enctype="multipart/form-data" action="AdminPageDataUploadPageImage7.asp" >
								

								Upload Photo: <br>
								<input name="attach2" type="file" size=35 >
								<input  type=submit value="Upload">
							</form>
						<td>
						</tr>
						<tr>
							<td>
								<form method="POST" action="AdminPageDataImageOrientation.asp" >
								<b>Orientation: </b>
								   <% If ImageCaption1= "0" Then
											ImageCaption1 = ""
										End If %>

										<select size="1" name="Orientation">
										<option value="<%=ImageOrientation7%>" selected><%=ImageOrientation7%></option>
										<option value="Left">Left</option>
										<option  value="Right">Right</option>
										</select>
								
									<input type = "hidden" name="OrientationImageID" value= "7" >
									<input type=submit value = "Submit"  size = "110" Class = "body" >
								</form>
							</td>
						</tr>
					<tr>
						   <td class = "body">
							<form action= 'AdminPageAddCaption.asp' method = "post">
								Current Caption: <b><%=ImageCaption7%></b><br>
								New Caption (20 Character Max.): <input name="Caption" Value ="<%=ImageCaption7%>"  size = "40" maxlength = "80"><br>
								<input type = "hidden" name="CaptionID" value= "7" >
								<input type = "hidden" name="PageName" value= "<%= PageName %>" >
											<input type = "hidden" name="Redirectpage" value= "AdminPageData.asp?PageName=<%= PageName %>" >
								<input type=submit value="Submit">
								</form>
						   </td>
						 </tr>
						<tr>
					    <td class = "body">
							<form action= 'AdminPageDataRemoveImage.asp' method = "post">
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
<a name="TextBlock8"></a>
<table border = "0" bordercolor = "eeeeee" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
  <tr>
    <td>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "900" align = "center" >
<tr>
			<td  align = "center" class = "body" colspan= "2" bgcolor = "eeeeee" height = "24">
					<big><b><font color = "black">Text Block 8</font></b></big> </b>
			</td>
		</tr>
   <tr>
      <td >
<table border = "0" bordercolor = "eeeeee" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
		
		<form action= 'AdminPageDataHandleForm.asp' method = "post">
			<input name="TextBlock"  size = "60" value = "TB8" type = "hidden">
		
		<tr>
			<td  align = "right" class = "body" valign = "top">
					<b>Text: </b>
			</td>
			<td  align = "left" valign = "top" class = "body">
					<TEXTAREA NAME="Text" cols="44" rows="16" wrap="file"><%=PageText8%></textarea>
			</td>
		</tr>
		<tr>
		<td  valign = "middle" colspan = "2" align = "center">
			<input type=submit value = "Submit Changes"  size = "110" Class = "body" >
		</td>
		</tr>
		</table>

</form>
	  </td>
	  <td valign = "top"  bgcolor = "eeeeee">
			<table Border = "0" width = "150" align = "center">
			<tr>
				<td >
					<h2>Image</h2>
				</td>
			</tr>
			<tr>
				<td width = "100" align = "center">
					<% If Len(Image8) > 2 Then %>
							<img src = "<%=Image8%>" height = "100">
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
							<form name="frmSend" method="POST" enctype="multipart/form-data" action="AdminPageDataUploadPageImage8.asp" >
								

								Upload Photo: <br>
								<input name="attach2" type="file" size=35 >
								<input  type=submit value="Upload">
							</form>
						<td>
						</tr>
						<tr>
							<td>
								<form method="POST" action="AdminPageDataImageOrientation.asp" >
								<b>Orientation: </b>
								   <% If ImageCaption1= "0" Then
											ImageCaption1 = ""
										End If %>

										<select size="1" name="Orientation">
										<option value="<%=ImageOrientation8%>" selected><%=ImageOrientation8%></option>
										<option value="Left">Left</option>
										<option  value="Right">Right</option>
										</select>
								
									<input type = "hidden" name="OrientationImageID" value= "8" >
									<input type=submit value = "Submit"  size = "110" Class = "body" >
								</form>
							</td>
						</tr>
					<tr>
						   <td class = "body">
							<form action= 'AdminPageAddCaption.asp' method = "post">
								Current Caption: <b><%=ImageCaption8%></b><br>
								New Caption (20 Character Max.): <input name="Caption" Value ="<%=ImageCaption8%>"  size = "40" maxlength = "80"><br>
								<input type = "hidden" name="CaptionID" value= "8" >
								<input type = "hidden" name="PageName" value= "<%= PageName %>" >
											<input type = "hidden" name="Redirectpage" value= "AdminPageData.asp?PageName=<%= PageName %>" >
								<input type=submit value="Submit">
								</form>
						   </td>
						 </tr>
						<tr>
					    <td class = "body">
							<form action= 'AdminPageDataRemoveImage.asp' method = "post">
								<input type = "hidden" name="ImageID" value= "8" >
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