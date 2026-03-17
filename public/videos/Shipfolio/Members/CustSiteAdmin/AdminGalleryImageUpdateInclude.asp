<% if mobiledevice = False  then
if pagewidth > 768 then %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "90%" >
<tr><td class = "roundedtopandbottom" align = "center" width = "100%" height = "400"> 
<% else %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "90%" >
<tr><td class = "roundedtopandbottom" align = "center" width = "100%" height = "350"> 
<% end if %>
<% else %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%" >
<tr><td class = "roundedtopandbottom" align = "center" width = "100%">
<% end if %>
<img src = "<%=GalleryImage%>" width = "100%">
<form action= 'AdminGalleryEditCaption.asp' method = "post">
Caption:<br>
<textarea name="Caption" cols="30" rows="4" wrap="VIRTUAL" class = "body"><%=GalleryCaption%></textarea><br>
(80 Character Max.)<br>
Link:<br />
<textarea name="GalleryImageLink" cols="30" rows="2" wrap="VIRTUAL" class = "body"><%=GalleryImageLink%></textarea><br>
<input type = "hidden" name="GalleryCatID" value= "<%=GalleryCatID %>" >
<input type = "hidden" name="GalleryID" value= "<%= GalleryID %>" ><br>
Order:
<select size="1" name="ImageOrder" class = "regsubmit2 body">
<option  value= "<%=ImageOrder%>" selected><%=ImageOrder%></option>
<%	
   for x = 1 to totalcount 
      if not x = ImageOrder then %>
	<option  value= "<%=x%>" ><%=x%></option>
 <% end if
 Next %>
 </select>
<center><input type=submit value="Submit" class = "regsubmit2 body"></center><br>
</form>
<form action= 'AdminGalleryRemoveImage.asp' method = "post">
<center><input type = "hidden" name="ImageID" value= "1" >
<input type = "hidden" name="GalleryCatID" value= "<%=GalleryCatID %>" >
<input type = "hidden" name="GalleryID" value= "<%= GalleryID %>" >
<input type=submit value="Remove" class = "regsubmit2 body"></center><br>
</form>
</td>
</tr>
</table><br />