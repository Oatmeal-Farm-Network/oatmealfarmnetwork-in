<a name = "<%=imagenum%>">
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%"><tr><td class = "roundedtop" align = "left">
<H2><div align = "left">Image <%=imagenum %></div></H2>
</td></tr>
<tr><td class = "roundedBottom" align = "center">
<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%" align = "center"  >
<tr><td width = "150" align = "center" class = "body">
<center><img src = "<%=tempfilename%>" height = "100"></center><br />
<center><b><%=tempPhotoCaption%></b></center>
</td>
<% if screenwidth < 730 then %>
</tr><tr>
<% end if %>
<td class = "body"  align = "left">
<form name="frmSend" method="POST" enctype="multipart/form-data" action="AdminImageUpload.asp?imagenum=<%=imagenum%>" onSubmit="return onSubmitForm();">
<br />
Upload Photo: <input name="attach1" type="file" class="regsubmit2" size=45 >
<input  type=submit value="Upload" class="regsubmit2">
</form>
<%if len(tempfilename) > 0 and not(tempfilename = "/uploads/ImageNotAvailable.jpg") then %>
<form action= 'AdminPhotoChangeOrder1.asp' method = "post">
<input type = "hidden" name="CurrentPhoto" value= "<%=imagenum %>" >
<input type = "hidden" name="ID" value= "<%= ID %>" >
Photo Order:	
<select size="1" name="PhotoOrder">
<option value="<%=imagenum %>" selected><%=imagenum %></option>
<% for porder = 1 to 8 %> 
<% if not(porder = imagenum) then %>
<option  value="<%=porder%> "><%=porder%></option>
<% end if %>
<% next %>
</select>
<input type=submit value="Submit" class="regsubmit2">
</form>
<form action= 'AdminCaptionAdd.asp' method = "post">
Caption (60 Character Max.): <input name="Caption" Value ="<%=tempPhotoCaption%>"  size = "60" maxlength = "60">
<input type = "hidden" name="CaptionID" value= "<%=imagenum %>" >
<input type = "hidden" name="ID" value= "<%= ID %>" >
<input type=submit value="Submit" class="regsubmit2">
</form>
<form action= 'AdminImageRemove.asp' method = "post">
Would you like to remove this image? 
<input type = "hidden" name="ImageID" value= "<%=imagenum %>" >
<input type = "hidden" name="ID" value= "<%= ID %>" >
<input type=submit value="Remove This Image" class="regsubmit2">
</form>
<% end if %>
</td></tr></table>
</td></tr></table>