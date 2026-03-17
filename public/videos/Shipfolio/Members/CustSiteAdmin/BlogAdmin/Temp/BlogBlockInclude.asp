

<table border = "1" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "800" >
  <tr>
    <td><a name="TextBlock<%=textblocknum%>"></a>
<table border= "0" width = "800">
<tr>
			<td  align = "center" class = "body"  colspan= "2" bgcolor = "burlywood" height = "24">
					<big><b>Text Block <%=textblocknum%></b></big> 
			</td>
		</tr>
		  <tr>
	  <td valign = "top"  bgcolor = "antiquewhite" align = "center">
	  <h2><center>Image</center></h2>
			<table Border = "0"  align = "center">
			<tr>
				<td  align = "center" width = "150">
					<% If Len(TempImage) > 2 Then %>
							<img src = "<%=TempImage%>" width = "140">
					<% Else %>
							<h2>No Image</h2>
					<% End If %>
				</td>
				<td class = "body">
					<table>
					   <tr>
					     <td class = "body">
							<form name="frmSend" method="POST" enctype="multipart/form-data" action="<%=TempBloguploadImageFile%>" >
						

								Upload Photo: <br>
								<input name="attach2" type="file" size=35 >
								<input  type=submit value="Upload">
							</form>
							<form action= 'RemoveBlogImage.asp' method = "post">
								<input type = "hidden" name="ImageID" value= "<%=textblocknum%>" >
								<input type=submit value="Remove This Image">
							</form>
						<td>
							<td class = "body" valign = "top" width = "280">
								<form method="POST" action="BlogImageOrientation.asp" >
								<b>Orientation: </b>
								   <% If TempImageCaption= "0" Then
											TempImageCaption = ""
										End If %>

										<select size="1" name="Orientation">
										<option value="<%=TempImageOrientation%>" selected><%=TempImageOrientation%></option>
										<option value="Left">Left</option>
															<option value="Center">Center</option>
										<option  value="Right">Right</option>
										</select>
								
									<input type = "hidden" name="OrientationImageID" value= "<%=textblocknum%>" >
									<input type = "hidden" name="PageName" value= "BlogHandleForm2.asp?BlogID=<%=BlogID %>" >
									<input type=submit value = "Submit" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" Class = "body" >
								</form>
				
								<form method="POST" action="BlogImageCaption.asp" >
								<b>Caption: </b>
								   <% If TempImageCaption= "0" Then
											TempImageCaption = ""
										End If %>
										
										<TEXTAREA NAME="Caption" cols="35" rows="7" wrap="file" class = "body"><%=TempImageCaption%></textarea><br>


									<input type = "hidden" name="CaptionImageID" value= "<%=textblocknum%>" >
									<input type = "hidden" name="BlogID" value= "<%=BlogID%>" >
									<input type=submit value = "Submit" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" Class = "body" >
								</form>

							
					</td>
				</tr>
				</table>
					</td>
				</tr>
				</table>
	   <td>
	 </tr>
   <tr>
      <td >
<table border = "0" bordercolor = "antiquewhite" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "800">
		
		<form action= 'BlogHandleForm2.asp' method = "post">
				<input name="BlogID"  size = "60" value = "<%=BlogID%>" type = "hidden">
			<input name="TextBlock"  size = "60" value = "<%=TB%>" type = "hidden">
						<input name="textblocknum"  size = "60" value = "<%=textblocknum%>" type = "hidden">
				<tr>
		<td  valign = "middle" colspan = "2" align = "right">
			
		</td>
		</tr>
		<tr>
			<td  align = "right"   class = "body" colspan = "2">
				<table width = "100%">
					<tr>
						<td class = "body">
						<b>Heading: </b>
					</td>
					<td  align = "left" valign = "top" class = "body">
							<input name="Heading"  size = "60" value = "<%=TempPageHeading%>">
					</td>
					<td class = "body" align = "right">
							<input type=submit value = "Submit Changes" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" Class = "body" >
					</td>
				</tr>
				</table>

           </td>
		</tr>
			<tr>
			<td  align = "left" class = "body" valign = "top" colspan = "2">
					<b>Text: </b>
			</td>
		</tr>
		<tr>
			<td  align = "left" class = "body" valign = "top" colspan = "2">
					<TEXTAREA NAME="Text" cols="120" rows="12" wrap="file" class = "body"><%=TempPageText%></textarea>
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
	  </tr>
	
</table>
</td>
</tr>
</table>