<a name = "Video">
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%"><tr><td class = "roundedtop" align = "left">
<H2><div align = "left">Video</div></H2>
</td></tr>
<tr><td class = "roundedBottom" align = "center">
<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%" align = "center"  >
<tr><td width = "150" align = "center" class = "body">
<embed src="<%=Animalvideo%>" autostart="true" height="200" width="300" />


<center><img src = "<%=Animalvideo%>" height = "100"></center><br />
<center><b><%=tempVideoCaption%></b></center>
</td>
<% if screenwidth < 730 then %>
</tr><tr>
<% end if %>
<td class = "body"  align = "left">
<form name="frmSend" method="POST" enctype="multipart/form-data" action="AdminVideoUpload.asp" onSubmit="return onSubmitForm();">
<br />
Upload Video: <input name="attach1" type="file" class="regsubmit2" size=45 >
<input  type=submit value="Upload" class="regsubmit2">
</form>

<form action= 'AdminCaptionAdd.asp' method = "post">
Caption (60 Character Max.): <input name="Caption" Value ="<%=tempVideoCaption%>"  size = "60" maxlength = "60">
<input type = "hidden" name="ID" value= "<%= ID %>" >
<input type=submit value="Submit" class="regsubmit2">
</form>
<form action= 'AdminVideoRemove.asp' method = "post">
Would you like to remove this image? 
<input type = "hidden" name="ID" value= "<%= ID %>" >
<input type=submit value="Remove This Video" class="regsubmit2">
</form>
</td></tr></table>
</td></tr></table>