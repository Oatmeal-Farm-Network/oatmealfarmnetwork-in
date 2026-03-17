<a name="TextBlock<%=textblocknum%>"></a>
<% if TempImageOrientation = "Right" or screenwidth < 800 or mobiledevice = True  then %>
<% if mobiledevice = False  then %> 
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "left" width = "<%=screenwidth -35 %>">
  <tr>
<td >
       <table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%"><tr><td class = "roundedtop" align = "left">
       		<H1><div align = "left">Text2</div></H1>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" >
        <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "550" align = "center">
<%else %>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%" align = "left">
  <tr>
<td >
       <table border = "0" cellspacing="0" cellpadding = "0" align = "left" ><tr><td  align = "left">
       		<H1><div align = "left">Text</div></H1>
        </td></tr>
        <tr><td  align = "center" width = "100%">
        <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%" align = "center">
<% end if %>



	<form action= 'AdminArticleHandleForm2.asp' method = "post">
	    <input name="ArticleID"  size = "60" value = "<%=ArticleID%>" type = "hidden">
	    <input name="TextBlock"  size = "60" value = "<%=TB%>" type = "hidden">
	    <input name="textblocknum"  size = "60" value = "<%=textblocknum%>" type = "hidden">
	<tr>
		<td  valign = "middle" colspan = "2" align = "right"></td>
	</tr>
	<tr>
		<td  align = "right"   class = "body" colspan = "2">
			<table width = "100%" border = "0">
				<tr>
					<td class = "body"  valign = "top"><b>Heading: </b>
					<% if mobiledevice = True  then %> 
					<br />
					<% end if %>
							<input name="Heading"  size = "40" value = "<%=TempPageHeading%>">
					</td>
					<tr>
					</tr>
					<td class = "body2" align = "center" >
							<center><input type=submit value = "Submit Changes" Class = "regsubmit2 body" ></center>
					</td>
				</tr>
			</table>
			<br />
        </td>
	</tr>
	<tr>
		<td  align = "left" class = "body" valign = "top" colspan = "2">
		<% if mobiledevice = False then%>
     <script language="javascript1.2" type="text/javascript">
         // attach the editor to the textarea with the identifier 'textarea1'.

         WYSIWYG.attach("ArticleText<%=textblocknum%>", mysettings);
         mysettings.Width = "670px"
         mysettings.Height = "360px"
 </script>
 <% end if %>
		</td>
	</tr>
	<tr>
		<td  align = "left" class = "body" valign = "top" colspan = "2">
		<% if mobiledevice = True  then %> 
		<TEXTAREA NAME="Text" ID="ArticleText<%=textblocknum%>" cols="30" rows="16" wrap="file"><%=TempPageText%></textarea>
		<% else %>
		<TEXTAREA NAME="Text" ID="ArticleText<%=textblocknum%>" cols="65" rows="16" wrap="file"><%=TempPageText%></textarea>
		<% end if %>
			</td>
		</tr>
		<tr>
		    <td  valign = "middle" colspan = "2" align = "center">
			    <input type=submit value = "Submit Changes" Class = "regsubmit2 body" >
		    </td>
		</tr>
	</table>

</form>
    </td>
		</tr>
	</table>
</td>
<% if mobiledevice =True or screenwidth < 800 then  %>
</tr>
<tr>
<% end if %>
<% if mobiledevice =True  then  %>
 <td valign = "top"  align = "center" >
	  <table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%" >
	  <tr><td align = "left">
		<H1><div align = "left">Image</div></H1>
        </td></tr>
        <tr><td  align = "center" width = "100%">
<% else %>
 <td valign = "top"  align = "center" >
	  <table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%" ><tr><td class = "roundedtop" align = "left">
		<H1><div align = "left">Image</div></H1>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" width = "150">


<% end if %>

			<table Border = "0"  align = "center">
			<tr>
				<td  align = "center" width = "150">
					<% If Len(TempImage) > 2 Then %>
							<img src = "<%=TempImage%>" width = "140">
					<% Else %>
							<h2>No Image</h2>
					<% End If %>
				</td>
				</tr>
				<tr>
				<td class = "body">
					<table>
					   <tr>
					     <td class = "body2">
							<form name="frmSend" method="POST" enctype="multipart/form-data" action="<%=TempArticleuploadImageFile%>" >
								Upload Photo: <br>
								<input name="attach2" type="file" size=35 >
								<center><input  type=submit value="Upload" class="regsubmit2 body"></center>
							</form>
								<% If Len(TempImage) > 2 Then %>
							<form action= 'AdminArticleRemoveImage.asp' method = "post">
								<input type = "hidden" name="ImageID" value= "<%=textblocknum%>" >
								<center><input type=submit value="Remove This Image" class="regsubmit2 body"></center>
									<% end if %>
							</form>
						<td>
						</tr>
						<tr>
							<td class = "body" valign = "top" width = "280">
								<% If Len(TempImage) > 2 Then %>
								<form method="POST" action="AdminArticleImageOrientation.asp" >
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
									<input type = "hidden" name="PageName" value= "AdminArticleHandleForm2.asp?ArticleID=<%=ArticleID %>" >
									<center><input type=submit value = "Submit" Class = "regsubmit2 body" ></center>
								</form>
				
								<form method="POST" action="AdminArticleImageCaption.asp" >
								<b>Caption: </b>
								   <% If TempImageCaption= "0" Then
											TempImageCaption = ""
										End If %>
									<input name="Caption"  size = "30" value = "<%=TempImageCaption%>">
									<input type = "hidden" name="CaptionImageID" value= "<%=textblocknum%>" >
									<input type = "hidden" name="ArticleID" value= "<%=articleID%>" >
									<center><input type=submit value = "Submit"  Class = "regsubmit2 body" ></center>
								</form>
<% end if %>
					</td>
				</tr>
				</table>
					</td>
				</tr>
				</table>
				</td>
				</tr>
				</table>
	   <td >&nbsp;</td>
</tr>
</table>



<% else %>
<% if mobiledevice = False  then %> 
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%" align = "center">
  <tr>
	  <td valign = "top"  align = "center" >
	  <table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
	  		<H1><div align = "left">Image</div></H1>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" width = "150">
<% else %>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%" align = "left">
  <tr>
	  <td valign = "top"  align = "center" >
	  <table border = "0" cellspacing="0" cellpadding = "0" align = "left" ><tr><td align = "left">
	  		<H1><div align = "left">Image</div></H1>
        </td></tr>
        <tr><td align = "center" width = "150">
<% end if %>


			<table Border = "0"  align = "center">
			<tr>
				<td  align = "center" width = "150">
					<% If Len(TempImage) > 2 Then %>
							<img src = "<%=TempImage%>" width = "140">
					<% Else %>
							<h2>No Image</h2>
					<% End If %>
				</td>
				</tr>
				<tr>
				<td class = "body">
					<table>
					   <tr>
					     <td class = "body2">
							<form name="frmSend" method="POST" enctype="multipart/form-data" action="<%=TempArticleuploadImageFile%>" >
								Upload Photo: <br>
								<input name="attach2" type="file" size=35 >
								<center><input  type=submit value="Upload" class="regsubmit2 body"></center>
							</form>
								<% If Len(TempImage) > 2 Then %>
							<form action= 'AdminArticleRemoveImage.asp' method = "post">
								<input type = "hidden" name="ImageID" value= "<%=textblocknum%>" >
								<center><input type=submit value="Remove This Image" class="regsubmit2 body"></center>
									<% end if %>
							</form>
						<td>
						</tr>
						<tr>
							<td class = "body" valign = "top" width = "280">
								<% If Len(TempImage) > 2 Then %>
								<form method="POST" action="AdminArticleImageOrientation.asp" >
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
									<input type = "hidden" name="PageName" value= "AdminArticleHandleForm2.asp?ArticleID=<%=ArticleID %>" >
									<center><input type=submit value = "Submit" Class = "regsubmit2 body" ></center>
								</form>
				
								<form method="POST" action="AdminArticleImageCaption.asp" >
								<b>Caption: </b>
								   <% If TempImageCaption= "0" Then
											TempImageCaption = ""
										End If %>
									<input name="Caption"  size = "30" value = "<%=TempImageCaption%>">
									<input type = "hidden" name="CaptionImageID" value= "<%=textblocknum%>" >
									<input type = "hidden" name="ArticleID" value= "<%=articleID%>" >
									<center><input type=submit value = "Submit"  Class = "regsubmit2 body" ></center>
								</form>
                            <% end if %>
					</td>
				</tr>
				</table>
					</td>
				</tr>
				</table>
				</td>
				</tr>
				</table>
	   <td >&nbsp;</td>
      <td >
      
<% if mobiledevice = False  then %> 
       <table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%"><tr><td class = "roundedtop" align = "left">
		<H1><div align = "left">Text</div></H1>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" >
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "550" align = "center">
<% else %>
       <table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td  align = "left">
		<H1><div align = "left">Text</div></H1>
        </td></tr>
        <tr><td  align = "center" width = "100%">
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%" align = "center">
<% end if %>
	<form action= 'AdminArticleHandleForm2.asp' method = "post">
	    <input name="ArticleID"  size = "60" value = "<%=ArticleID%>" type = "hidden">
	    <input name="TextBlock"  size = "60" value = "<%=TB%>" type = "hidden">
	    <input name="textblocknum"  size = "60" value = "<%=textblocknum%>" type = "hidden">
	<tr>
		<td  valign = "middle" colspan = "2" align = "right"></td>
	</tr>
	<tr>
		<td  align = "right"   class = "body" colspan = "2">
			<table width = "550" border = "0">
				<tr>
					<td class = "body" valign = "top"><b>Heading: </b>
						<% if mobiledevice = True  then %> 
					<br />
					<% end if %>
							<input name="Heading"  size = "60" value = "<%=TempPageHeading%>">
					</td>
					<tr>
					</tr>
					<td class = "body2" align = "center" colspan = "2">
							<input type=submit value = "Submit Changes" Class = "regsubmit2 body" >
					</td>
				</tr>
			</table>
			<br />
        </td>
	</tr>
	<tr>
		<td  align = "left" class = "body" valign = "top" colspan = "2">
		<% if mobiledevice = False then%>
     <script language="javascript1.2" type="text/javascript">
         // attach the editor to the textarea with the identifier 'textarea1'.

         WYSIWYG.attach("ArticleText<%=textblocknum%>", mysettings);
         mysettings.Width = "470px"
         mysettings.Height = "360px"
 </script>
 <% end if  %>
		</td>
	</tr>
	<tr>
		<td  align = "left" class = "body" valign = "top" colspan = "2">
		<% if mobiledevice = True  then %> 
		<TEXTAREA NAME="Text" ID="ArticleText<%=textblocknum%>" cols="30" rows="16" wrap="file"><%=TempPageText%></textarea>
		<% else %>
		<TEXTAREA NAME="Text" ID="ArticleText<%=textblocknum%>" cols="65" rows="16" wrap="file"><%=TempPageText%></textarea>
		<% end if %>

			</td>
		</tr>
		<tr>
		    <td  valign = "middle" colspan = "2" align = "center">
			    <input type=submit value = "Submit Changes" Class = "regsubmit2 body" >
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



<% end if %>

<br>