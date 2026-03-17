<% if TempImageOrientation= "Right" then %>
<tr>
	<td class = "body2"  valign = "top" align = "left">
	<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%">
<tr><td>
	<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Text</div></H2>
        </td></tr>
        <tr><td class = "roundedBottom body" align = "center" valign = "top" width = "640" >
	

	<a name="TextBlock<%=textblocknum%>"></a>
<form method="POST" action="BlogAdminHandleForm2.asp" >
 <input name="BlogID"  size = "60" value = "<%=BlogID%>" type = "hidden">
<input name="TextBlock"  size = "60" value = "<%=TB%>" type = "hidden">
<input name="textblocknum"  size = "60" value = "<%=textblocknum%>" type = "hidden">

 <script language="javascript1.2" type="text/javascript">
         // attach the editor to the textarea with the identifier 'textarea1'.

         WYSIWYG.attach("ArticleText<%=textblocknum%>", mysettings);
         mysettings.Width = "470px"
         mysettings.Height = "360px"
 </script>

<% if mobiledevice = True  then %> 
		<TEXTAREA NAME="Text" ID="ArticleText<%=textblocknum%>" cols="30" rows="16" wrap="file"><%=TempPageText%></textarea>
		<% else %>
		<TEXTAREA NAME="Text" ID="ArticleText<%=textblocknum%>" cols="65" rows="16" wrap="file"><%=TempPageText%></textarea>
		<% end if %>
		
<br>
<center><input type=submit value = "Submit"  Class = "regsubmit2 body" ></center>
</form>
</td></tr></table>
</td>
<td class = "body" valign = "top">	
	<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Text</div></H2>
        </td></tr>
        <tr><td class = "roundedBottom body" align = "center" valign = "top" >
					<% If Len(TempImage) > 2 Then %>
							<img src = "<%=TempImage%>" width = "140"><br />
					<% Else %>
							<h2>No Image</h2>
					<% End If %>
				   		<form name="frmSend" method="POST" enctype="multipart/form-data" action="BlogAdminUploadImage1.asp?pagenum=<%=textblocknum%>" >
							Upload Photo: <br>
								<input name="attach2" type="file" size=35 >
								<center><input  type=submit value="Submit" Class = "regsubmit2 body"></center>
						</form>
						<form action= 'BlogAdminImageRemove.asp' method = "post">
								<input type = "hidden" name="ImageID" value= "<%=textblocknum%>" >
								<center><input type=submit value="Remove This Image" class = "regsubmit2"></center>
						</form>
								<form method="POST" action="BlogAdminImageOrientation.asp" >
								<b>Orientation: </b>
								   <% If TempImageCaption= "0" Then
											TempImageCaption = ""
										End If %>

										<select size="1" name="Orientation" Class = "regsubmit2 body">
										<option value="<%=TempImageOrientation%>" selected><%=TempImageOrientation%></option>
										<option value="Left">Left</option>
										<option  value="Right">Right</option>
										</select>
								
									<input type = "hidden" name="OrientationImageID" value= "<%=textblocknum%>" >
									<input type = "hidden" name="PageName" value= "BlogAdminHandleForm2.asp?BlogID=<%=BlogID %>" >
									<center><input type=submit value = "Submit" Class = "regsubmit2 body" ></center>
								</form>
<form method="POST" action="BlogAdminImageCaption.asp" >
<% If TempImageCaption= "0" Then
		TempImageCaption = ""
End If %>
<b>Caption</b> (20 Character Max.):<br /><input name="Caption" Value ="<%=tempImageCaption%>"  size = "40" maxlength = "80"><br>
<input type = "hidden" name="CaptionImageID" value= "<%=textblocknum%>" >
<input type = "hidden" name="BlogID" value= "<%=BlogID%>" >
<center><input type=submit value = "Submit" Class = "regsubmit2 body" ></center><br>
</form>
</td></tr></table>
</td></tr></table>
</td>
</tr>

<% else %>
<tr>
<td class = "body" valign = "top">
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%">
<tr><td valign = "top">
	<table border = "0" cellspacing="0" cellpadding = "0" align = "center" >
	<tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Text</div></H2>
        </td></tr>
        <tr><td class = "roundedBottom body" align = "center" valign = "top" >
					<% If Len(TempImage) > 2 Then %>
							<img src = "<%=TempImage%>" width = "140"><br />
					<% Else %>
							<h2>No Image</h2>
					<% End If %>
				   		<form name="frmSend" method="POST" enctype="multipart/form-data" action="BlogAdminUploadImage1.asp?pagenum=<%=textblocknum%>" >
							Upload Photo: <br>
								<input name="attach2" type="file" size=35 >
								<center><input  type=submit value="Submit" Class = "regsubmit2 body"></center>
						</form>
						<form action= 'BlogAdminImageRemove.asp' method = "post">
								<input type = "hidden" name="ImageID" value= "<%=textblocknum%>" >
								<center><input type=submit value="Remove This Image" class = "regsubmit2"></center>
						</form>
								<form method="POST" action="BlogAdminImageOrientation.asp" >
								<b>Orientation: </b>
								   <% If TempImageCaption= "0" Then
											TempImageCaption = ""
										End If %>

										<select size="1" name="Orientation" Class = "regsubmit2 body">
										<option value="<%=TempImageOrientation%>" selected><%=TempImageOrientation%></option>
										<option value="Left">Left</option>
										<option  value="Right">Right</option>
										</select>
								
									<input type = "hidden" name="OrientationImageID" value= "<%=textblocknum%>" >
									<input type = "hidden" name="PageName" value= "BlogAdminHandleForm2.asp?BlogID=<%=BlogID %>" >
									<center><input type=submit value = "Submit" Class = "regsubmit2 body" ></center>
								</form>
<form method="POST" action="BlogAdminImageCaption.asp" >
<% If TempImageCaption= "0" Then
		TempImageCaption = ""
End If %>
<b>Caption</b> (20 Character Max.):<br /><input name="Caption" Value ="<%=tempImageCaption%>"  size = "40" maxlength = "80"><br>
<input type = "hidden" name="CaptionImageID" value= "<%=textblocknum%>" >
<input type = "hidden" name="BlogID" value= "<%=BlogID%>" >
<center><input type=submit value = "Submit" Class = "regsubmit2 body" ></center><br>
</form>
</td></tr></table>
</td>
<td class = "body2"  valign = "top" align = "left">
	<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Text</div></H2>
        </td></tr>
        <tr><td class = "roundedBottom body" align = "center" valign = "top" width = "640" >
	

	<a name="TextBlock<%=textblocknum%>"></a>
<form method="POST" action="BlogAdminHandleForm2.asp" >
 <input name="BlogID"  size = "60" value = "<%=BlogID%>" type = "hidden">
<input name="TextBlock"  size = "60" value = "<%=TB%>" type = "hidden">
<input name="textblocknum"  size = "60" value = "<%=textblocknum%>" type = "hidden">

 <script language="javascript1.2" type="text/javascript">
     // attach the editor to the textarea with the identifier 'textarea1'.

     WYSIWYG.attach("ArticleText<%=textblocknum%>", mysettings);
     mysettings.Width = "470px"
     mysettings.Height = "360px"
 </script>

<% if mobiledevice = True  then %> 
		<TEXTAREA NAME="Text" ID="ArticleText<%=textblocknum%>" cols="30" rows="16" wrap="file"><%=TempPageText%></textarea>
		<% else %>
		<TEXTAREA NAME="Text" ID="ArticleText<%=textblocknum%>" cols="65" rows="16" wrap="file"><%=TempPageText%></textarea>
		<% end if %>
		
<br>
<center><input type=submit value = "Submit"  Class = "regsubmit2 body" ></center>
</form>
</td></tr></table>
</td></tr></table>
</td>
</tr>

<% end if %>