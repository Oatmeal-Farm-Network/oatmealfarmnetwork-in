<table align = "center" width = 100% >
	<tr><td  align = "left">
<a name="<%=currentphoto %>"></a>

<H2><div align = "left">Image </div></H2>
</td>
	</tr>
     <tr >
	    <td colspan="6" style="background-color: #abacab; min-height: 1px"></td>
      </tr>
<tr>
	<td>

<% 
if len(tempfile) = 135 then
tempfile = "http://www.globallivestocksolutions.com/images/ImageNotAvailable.jpg"
end if %>

<table width = "100%" align = "center"  >
		<tr>
			<td width = "150" align = "center" class=  "body">
file: <%=TempFile%>
<img src = "<%=TempFile%>" width="150">
<center><b><%=TempPhotoCaption%></b></center>
			</td>
			<td class = "body" align = "left">
<form name="frmSend" method="POST" enctype="multipart/form-data" action="MembersServicesImageUploadX.asp?photonum=<%=currentphoto %>&ServicesID=<%=ServicesID %>" >
	<br />

Upload Photo <input name="attach1" type="file" size=45 > <input type=submit value="Upload" class="regsubmit2">
</form>

<%if len(TempFile) > 0 and not(TempFile = "http://www.globallivestocksolutions.com/images/ImageNotAvailable.jpg")  then %>	
<form action= 'MembersServicePhotoChangeOrder1.asp?servicesID=<%=ServicesID %>' method = "post">

	
<input type = "hidden" name="CurrentPhoto" value= "<%=currentphoto %>" >
<input type = "hidden" name="ID" value= "<%= ID %>" >
Photo Order	
<select size="1" name="PhotoOrder" class = formbox>
<% If currentphoto = 1 then %>
<option value="1" selected>1</option>
<% else %>
<option value="1" >1</option>
<% end if %>
<% If currentphoto = 2 then %>
<option value="2" selected>2</option>
<% else %>
<option value="2" >2</option>
<% end if %>
<% If currentphoto = 3 then %>
<option value="3" selected>3</option>
<% else %>
<option value="3" >3</option>
<% end if %>
<% If currentphoto = 4 then %>
<option value="4" selected>4</option>
<% else %>
<option value="4" >4</option>
<% end if %>
<% If currentphoto = 5 then %>
<option value="5" selected>5</option>
<% else %>
<option value="5" >5</option>
<% end if %>
<% If currentphoto = 6 then %>
<option value="6" selected>6</option>
<% else %>
<option value="6" >6</option>
<% end if %>
<% If currentphoto = 7 then %>
<option value="7" selected>7</option>
<% else %>
<option value="7" >7</option>
<% end if %>
<% If currentphoto = 8 then %>
<option value="8" selected>8</option>
<% else %>
<option value="8" >8</option>
<% end if %>

</select>

<input type=submit value="Submit" class="regsubmit2">

</form>
<br>


<form action= 'MembersServicesCaptionAdd.asp?ServicesID=<%=ServicesID %>' method = "post">
<table WITH = 100% class = formbox><tr><td>
Caption (20 Character Max.) <input name="Caption" Value ="<%=TempPhotoCaption%>"  size = "30" maxlength = "30" class = formbox>
<input type = "hidden" name="CaptionID" value= "<%=currentphoto %>" >
<input type = "hidden" name="ID" value= "<%= ID %>" >
</td>
<td>
<input type=submit value="Submit" class="regsubmit2">
</form>
</td></tr></table>
<br />
<center>
<form action= 'MembersServicesImageRemove.asp?ServicesID=<%=ServicesID %>' method = "post" >
<input type = "hidden" name="ImageID" value= "<%=currentphoto %>" >
<input type = "hidden" name="ID" value= "<%= ID %>" >
<input type=submit value="Remove Image" class="regsubmit2">
</form>
</center>
<% end if %>
			</td>
			</tr>
		</table>
