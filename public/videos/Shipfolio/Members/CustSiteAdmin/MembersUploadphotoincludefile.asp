<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = <%=screenwidth - 32 %> ><tr><td class = "roundedtopandbottom" align = "left">
<a name="<%=currentphoto %>"></a>
<% if SubscriptionLevel > 3 then  %>
<H2><div align = "left">Image <%=currentphoto%></div></H2>
<% else %>
<H2><div align = "left">Image</div></H2>
Basic memberships only allow 1 image per listing. <a href = "MembersRenewSubscription.asp?PeopleID=<%=PeopleID%>" class = body><b>Click here</b></a> to upgrade your membership to a premium membership (with 18 images per listing).
<% end if %>

<% if len(tempfile) = 135 then
tempfile = "http://www.worldlivestock.com/images/ImageNotAvailable.jpg"
end if %>

<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%" align = "center"  >
		<tr>
			<td width = "150" align = "center" class=  "body">
<img src = "<%=TempFile%>" height = "100">
<center><b><%=TempPhotoCaption%></b></center>
			</td>
			<td class = "body" align = "left">
<form name="frmSend" method="POST" enctype="multipart/form-data" action="MembersImageUploadX.asp?photonum=<%=currentphoto %>" >
	<br />

Upload Photo <input name="attach1" type="file" class="formbox" size=45 >
<center><br /><input  type=submit value="UPLOAD" class="regsubmit2"></center>
</form>

<%if len(TempFile) > 0 and not(TempFile = "/uploads/ImageNotAvailable.jpg") and subscriptionlevel > 3 then %>	
<form action= 'MembersPhotoChangeOrder1.asp' method = "post">
<table WITH = 100% class = formbox><tr><td>
	
<input type = "hidden" name="CurrentPhoto" value= "<%=currentphoto %>" >
<input type = "hidden" name="ID" value= "<%= ID %>" >
Photo Order	
<select size="1" name="PhotoOrder">
<% If currentphoto = 1 then %>
<option value="1" selected>1</option>

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
<% if subscriptionlevel = 4 then %>
<% If currentphoto = 9 then %>
<option value="9" selected>9</option>
<% else %>
<option value="9" >9</option>
<% end if %>
<% If currentphoto = 10 then %>
<option value="10" selected>10</option>
<% else %>
<option value="10" >10</option>
<% end if %>
<% If currentphoto = 11 then %>
<option value="11" selected>11</option>
<% else %>
<option value="11" >11</option>
<% end if %>
<% If currentphoto = 12 then %>
<option value="12" selected>12</option>
<% else %>
<option value="12" >12</option>
<% end if %>
<% If currentphoto = 13 then %>
<option value="13" selected>13</option>
<% else %>
<option value="13" >13</option>
<% end if %>
<% If currentphoto = 14 then %>
<option value="14" selected>14</option>
<% else %>
<option value="14" >14</option>
<% end if %>
<% If currentphoto = 15 then %>
<option value="15" selected>15</option>
<% else %>
<option value="15" >15</option>
<% end if %>
<% If currentphoto = 16 then %>
<option value="16" selected>16</option>
<% else %>
<option value="16" >16</option>
<% end if %>
<% end if %>
</select>
</td>
<td>
<input type=submit value="SUBMIT" class="regsubmit2">
</td></tr></table>
</form>
<br>


<form action= 'MembersCaptionAdd.asp' method = "post">
<table WITH = 100% class = formbox><tr><td>
Caption (20 Character Max.): <input name="Caption" Value ="<%=TempPhotoCaption%>"  size = "30" maxlength = "30">
<input type = "hidden" name="CaptionID" value= "<%=currentphoto %>" >
<input type = "hidden" name="ID" value= "<%= ID %>" >
</td>
<td>
<input type=submit value="SUBMIT" class="regsubmit2">
</form>
</td></tr></table>
<br />
<center>
<form action= 'MembersImageRemove.asp' method = "post">
<input type = "hidden" name="ImageID" value= "<%=currentphoto %>" >
<input type = "hidden" name="ID" value= "<%= ID %>" >
<input type=submit value="REMOVE IMAGE" class="regsubmit2">
</form>
</center>
<% end if %>
			</td>
			</tr>
		</table>
</td>
</tr>
</table>
