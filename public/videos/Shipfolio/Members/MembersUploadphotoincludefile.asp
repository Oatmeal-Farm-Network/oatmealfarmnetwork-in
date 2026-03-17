<% 
if len(tempfile) = 135 then
tempfile = "http://www.globallivestocksolutions.com/images/ImageNotAvailable.jpg"
end if 
if TempFile = "/uploads/ImageNotAvailable.jpg" then
	tempfile = "http://www.globallivestocksolutions.com/images/ImageNotAvailable.jpg"
end if	%>


<div class ="row">
	<div class ="col">
	<a name="<%=currentphoto %>"></a>
	<% if SubscriptionLevel > 1 then  %>
		<H3><div align = "left">Image <%=currentphoto%></div></H3>
	<% else %>
		<H3><div align = "left">Image</div></H3>
	<% end if %>
	</div>
</div>
<div>
    <div style="background-color: #abacab; min-height: 1px"></div>
</div>
<div>
    <div >
		<% if SubscriptionLevel > 1 then  
		else %>
		Basic memberships only allow 1 image per listing. <a href = "MembersRenewSubscription.asp?PeopleID=<%=PeopleID%>" class ="body"><b>Click here</b></a> to upgrade your membership.
		<% end if %>
    </div>
</div>
<div class ="row">
	<div class ="col-3">
		<img src = "<%=TempFile%>" width = "100%">
		<center><b><%=TempPhotoCaption%></b></center>

		<%if len(TempFile) > 0 and not(TempFile = "http://www.globallivestocksolutions.com/images/ImageNotAvailable.jpg") then %>	
			<form action= 'MembersImageRemove.asp' method = "post">
			<input type = "hidden" name="ImageID" value= "<%=currentphoto %>" >
			<input type = "hidden" name="ID" value= "<%= ID %>" >
			<input type=submit value="Remove" class="regsubmit2" style ="min-width:120px">
		</form><br /><br />
		<% end if %>
	</div>
	<div class = "col-9" align = "left" >
	  <div class ="container" width = 100% >
			<div class ="row">
				<div class ="col">
					<br />
					Upload 
    				<form name="frmSend" method="POST" enctype="multipart/form-data" action="MembersImageUploadX.asp?photonum=<%=currentphoto %>&ID=<%=ID %>" >
						<input name="attach1" type="file" size=25 >
						<input type=submit value="Upload" class="regsubmit2" style =" text-align: center">
					</form>
				<br />
		 	</div>
          </div>


		<%if len(TempFile) > 0 and not(TempFile = "http://www.globallivestocksolutions.com/images/ImageNotAvailable.jpg") then %>	
		  <div class ="row">
			<div class ="col">
			<form action= 'MembersPhotoChangeOrder1.asp' method = "post">
					<input type = "hidden" name="CurrentPhoto" value= "<%=currentphoto %>" >
					<input type = "hidden" name="ID" value= "<%= ID %>" >
					<% if subscriptionlevel > 1 then %>
						Photo Order	
					<select size="1" name="PhotoOrder" class ="formbox">
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
					</select>

				<input type=submit value="Submit" class="regsubmit2">
				</form>
		 </div>
		</div>
	<% end if %>
	<% end if %>
	    <div>
			<div>
				<br />Caption <br />
				<form action= 'MembersCaptionAdd.asp' method = "post">
				<input name="Caption" Value ="<%=TempPhotoCaption%>" class ="formbox"  size = "30" maxlength = "30">
				<input type = "hidden" name="CaptionID" value= "<%=currentphoto %>" >
				<input type = "hidden" name="ID" value= "<%= ID %>" >
				<input type=submit value="Submit" class="regsubmit2">
				</form>
				<center><small>20 Character Max.</small></center>
			<br />
			</div>
	</div>
	</div>

	
</div>
</div>


