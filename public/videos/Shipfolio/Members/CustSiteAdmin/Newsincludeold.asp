

<% 
	  
CustID = session("CustID")

conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(databasepath) & ";" & _
						"User Id=;Password=;" 


  sql = "select * from Pagelayout where PageName = 'Newsletter - Recent'"
'response.write(sql)
		
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   

	
	 PageTitle = rs("PageTitle")
     PageHeading1= rs("PageHeading1")
     PageHeading2= rs("PageHeading2")
     PageHeading3= rs("PageHeading3")
     PageHeading4= rs("PageHeading4")
	 NewsText1 = rs("PageText1")
	 NewsText2 = rs("PageText2")
	 NewsText3 = rs("NewsText3")
	 NewsText4 = rs("NewsText4")
	 Image1= rs("Image1")
	 Image2= rs("Image2")
	 Image3= rs("Image3")
	 Image4= rs("Image4")
	  Image5= rs("Image5")
	   Image6= rs("Image6")
	    Image7= rs("Image7")

	 ImageOrientation1= rs("ImageOrientation1")
	 ImageOrientation2= rs("ImageOrientation2")
	 ImageOrientation3= rs("ImageOrientation3")
	 ImageOrientation4= rs("ImageOrientation4")


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

str1 = PageHeading21
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


str1 = NewsText
str2 = "</br>"
If InStr(str1,str2) > 0 Then
	NewsText= Replace(str1, str2 , vbCrLf)
End If  

str1 =NewsText
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	NewsText= Replace(str1,  str2, " ")
End If 

str1 = NewsText
str2 = "''"
If InStr(str1,str2) > 0 Then
	NewsText= Replace(str1,  str2, "'")
End If 

str1 = NewsText1
str2 = "</br>"
If InStr(str1,str2) > 0 Then
	NewsText1= Replace(str1, str2 , vbCrLf)
End If  

str1 =NewsText1
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	NewsText1= Replace(str1,  str2, " ")
End If 

str1 = NewsText1
str2 = "''"
If InStr(str1,str2) > 0 Then
	NewsText1= Replace(str1,  str2, "'")
End If 

str1 = NewsText2
str2 = "</br>"
If InStr(str1,str2) > 0 Then
	NewsText2= Replace(str1, str2 , vbCrLf)
End If  

str1 =NewsText2
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	NewsText2= Replace(str1,  str2, " ")
End If 

str1 = NewsText2
str2 = "''"
If InStr(str1,str2) > 0 Then
	NewsText2= Replace(str1,  str2, "'")
End If 

str1 = NewsText3
str2 = "</br>"
If InStr(str1,str2) > 0 Then
	NewsText3= Replace(str1, str2 , vbCrLf)
End If  

str1 =NewsText3
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	NewsText3= Replace(str1,  str2, " ")
End If 

str1 = NewsText3
str2 = "''"
If InStr(str1,str2) > 0 Then
	NewsText3= Replace(str1,  str2, "'")
End If 

str1 = NewsText4
str2 = "</br>"
If InStr(str1,str2) > 0 Then
	NewsText4= Replace(str1, str2 , vbCrLf)
End If  

str1 =NewsText4
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	NewsText4= Replace(str1,  str2, " ")
End If 

str1 = NewsText4
str2 = "''"
If InStr(str1,str2) > 0 Then
	NewsText4= Replace(str1,  str2, "'")
End If 

%>

<a name="Top"></a>



<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "680">
	<tr>
		<td Class = "body">
			<H2>News Page Content<br>
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

<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "680">
	<tr>
		<td valign = "top">
			 <form action= 'NewsPageHandleForm.asp' method = "post">
			<input name="TextBlock"  size = "60" value = "Heading" type = "hidden">

			<table border = "0" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "580">
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
<table border = "1" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
  <tr>
    <td>
<table border= "0">
<tr>
			<td  align = "center" class = "body" valign = "top" colspan= "2" bgcolor = "bbbbbb" height = "14">
					<big><b><font color = "white">Text Block 1</font></b></big> </b>
			</td>
		</tr>
   <tr>
      <td >
<table border = "0" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
		
		<form action= 'NewsPageHandleForm.asp' method = "post">
			<input name="TextBlock"  size = "60" value = "TB1" type = "hidden">
		<tr>
			<td  align = "right"   class = "body">
					<b>Heading: </b>
			</td>
			<td  align = "left" valign = "top" class = "body">
					<input name="Heading"  size = "60" value = "<%=PageHeading1%>">
			</td>
		</tr>
		<tr>
			<td  align = "right" class = "body" valign = "top">
					<b>Text: </b>
			</td>
			<td  align = "left" valign = "top" class = "body">
					<TEXTAREA NAME="Text" cols="44" rows="16" wrap="file"><%=NewsText1%></textarea>
			</td>
		</tr>
		<tr>
		<td  valign = "middle" colspan = "2" align = "center">
			<input type=submit value = "Submit Changes" size = "110" Class = "body" >
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
							<form name="frmSend" method="POST" enctype="multipart/form-data" action="NewsuploadPageImage.asp" >
								

								Upload Photo: <br>
								<input name="attach1" type="file" size=35 >
								<input  type=submit value="Upload">
							</form>
						<td>
						</tr>
							<tr>
							<td>
								<form method="POST" action="NewsImageOrientation.asp" >
								<b>Orientation: </b>
						

										<select size="1" name="Orientation">
										<option value="<%=ImageOrientation1%>" selected><%=ImageOrientation1%></option>
										<option value="Left">Left</option>
										<option  value="Right">Right</option>
									</select>
								
									<input type = "hidden" name="OrientationImageID" value= "1" >
									<input type=submit value = "Submit" size = "110" Class = "body" >
								</form>
							</td>
						</tr>
						<tr>
					    <td class = "body">
							<form action= 'RemoveNewsImage.asp' method = "post">
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


<a name="TextBlock2"></a>
<table border = "1" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
  <tr>
    <td>
<table border= "0">
<tr>
			<td  align = "center" class = "body" valign = "top" colspan= "2" bgcolor = "bbbbbb" height = "14">
					<big><b><font color = "white">Text Block 2</font></b></big> </b>
			</td>
		</tr>
   <tr>
      <td >
<table border = "0" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
		
		<form action= 'NewsPageHandleForm.asp' method = "post">
			<input name="TextBlock"  size = "60" value = "TB2" type = "hidden">
		<tr>
			<td  align = "right"   class = "body">
					<b>Heading: </b>
			</td>
			<td  align = "left" valign = "top" class = "body">
					<input name="Heading"  size = "60" value = "<%=PageHeading2%>">
			</td>
		</tr>
		<tr>
			<td  align = "right" class = "body" valign = "top">
					<b>Text: </b>
			</td>
			<td  align = "left" valign = "top" class = "body">
					<TEXTAREA NAME="Text" cols="44" rows="16" wrap="file"><%=NewsText2%></textarea>
			</td>
		</tr>
		<tr>
		<td  valign = "middle" colspan = "2" align = "center">
			<input type=submit value = "Submit Changes" size = "110" Class = "body" >
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
							<form name="frmSend" method="POST" enctype="multipart/form-data" action="NewsuploadPageImage2.asp" >
								

								Upload Photo: <br>
								<input name="attach2" type="file" size=35 >
								<input  type=submit value="Upload">
							</form>
						<td>
						</tr>
						<tr>
							<td>
								<form method="POST" action="NewsImageOrientation.asp" >
								<b>Orientation: </b>
						

										<select size="1" name="Orientation">
										<option value="<%=ImageOrientation2%>" selected><%=ImageOrientation2%></option>
										<option value="Left">Left</option>
										<option  value="Right">Right</option>
									</select>
								
									<input type = "hidden" name="OrientationImageID" value= "2" >
									<input type=submit value = "Submit" size = "110" Class = "body" >
								</form>
							</td>
						</tr>
						<tr>
					    <td class = "body">
							<form action= 'RemoveNewsImage.asp' method = "post">
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


</td>
</tr>
</table>












<a name="TextBlock3"></a>
<table border = "1" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
  <tr>
    <td>
<table border= "0">
<tr>
			<td  align = "center" class = "body" valign = "top" colspan= "2" bgcolor = "bbbbbb" height = "14">
					<big><b><font color = "white">Text Block 3</font></b></big> </b>
			</td>
		</tr>
   <tr>
      <td >
<table border = "0" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
		
		<form action= 'NewsPageHandleForm.asp' method = "post">
			<input name="TextBlock"  size = "60" value = "TB3" type = "hidden">
		<tr>
			<td  align = "right"   class = "body">
					<b>Heading: </b>
			</td>
			<td  align = "left" valign = "top" class = "body">
					<input name="Heading"  size = "60" value = "<%=PageHeading3%>">
			</td>
		</tr>
		<tr>
			<td  align = "right" class = "body" valign = "top">
					<b>Text: </b>
			</td>
			<td  align = "left" valign = "top" class = "body">
					<TEXTAREA NAME="Text" cols="44" rows="16" wrap="file"><%=NewsText3%></textarea>
			</td>
		</tr>
		<tr>
		<td  valign = "middle" colspan = "2" align = "center">
			<input type=submit value = "Submit Changes" size = "110" Class = "body" >
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
							<form name="frmSend" method="POST" enctype="multipart/form-data" action="NewsuploadPageImage3.asp" >
								

								Upload Photo: <br>
								<input name="attach2" type="file" size=35 >
								<input  type=submit value="Upload">
							</form>
						<td>
						</tr>
						<tr>
							<td>
								<form method="POST" action="NewsImageOrientation.asp" >
								<b>Orientation: </b>
		
										<select size="1" name="Orientation">
										<option value="<%=ImageOrientation3%>" selected><%=ImageOrientation3%></option>
										<option value="Left">Left</option>
										<option  value="Right">Right</option>
									</select>
								
									<input type = "hidden" name="OrientationImageID" value= "3" >
									<input type=submit value = "Submit" size = "110" Class = "body" >
								</form>
							</td>
						</tr>
						
						<tr>
					    <td class = "body">
							<form action= 'RemoveNewsImage.asp' method = "post">
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


</td>
</tr>
</table>






<a name="TextBlock4"></a>
<table border = "1" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
  <tr>
    <td>
<table border= "0">
<tr>
			<td  align = "center" class = "body" valign = "top" colspan= "2" bgcolor = "bbbbbb" height = "14">
					<big><b><font color = "white">Text Block 4</font></b></big> </b>
			</td>
		</tr>
   <tr>
      <td >
<table border = "0" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
		
		<form action= 'NewsPageHandleForm.asp' method = "post">
			<input name="TextBlock"  size = "60" value = "TB4" type = "hidden">
		<tr>
			<td  align = "right"   class = "body">
					<b>Heading: </b>
			</td>
			<td  align = "left" valign = "top" class = "body">
					<input name="Heading"  size = "60" value = "<%=PageHeading4%>">
			</td>
		</tr>
		<tr>
			<td  align = "right" class = "body" valign = "top">
					<b>Text: </b>
			</td>
			<td  align = "left" valign = "top" class = "body">
					<TEXTAREA NAME="Text" cols="44" rows="16" wrap="file"><%=NewsText4%></textarea>
			</td>
		</tr>
		<tr>
		<td  valign = "middle" colspan = "2" align = "center">
			<input type=submit value = "Submit Changes" size = "110" Class = "body" >
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
							<form name="frmSend" method="POST" enctype="multipart/form-data" action="NewsuploadPageImage4.asp" >
								

								Upload Photo: <br>
								<input name="attach2" type="file" size=35 >
								<input  type=submit value="Upload">
							</form>
						<td>
						</tr>
						<tr>
							<td>
								<form method="POST" action="NewsImageOrientation.asp" >
								<b>Orientation: </b>
								 
										<select size="1" name="Orientation">
										<option value="<%=ImageOrientation4%>" selected><%=ImageOrientation4%></option>
										<option value="Left">Left</option>
										<option  value="Right">Right</option>
										</select>
								
									<input type = "hidden" name="OrientationImageID" value= "4" >
									<input type=submit value = "Submit" size = "110" Class = "body" >
								</form>
							</td>
						</tr>
						
						<tr>
					    <td class = "body">
							<form action= 'RemoveNewsImage.asp' method = "post">
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
</td>
</tr>
</table>
<br><br><br>
<div align = "center"><a href = "#Top" class ="body">Click here to go to the top of the page.</a></center>