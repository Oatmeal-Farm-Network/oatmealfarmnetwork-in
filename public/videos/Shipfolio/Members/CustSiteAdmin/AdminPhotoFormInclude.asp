<% sql2 = "select * from SiteDesign"

	'response.write(sql2)
	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	
	if Not rs2.eof then 
		AutoTransfer= rs2("AutoTransfer")

end if
			
		rs2.close

if AutoTransfer = True then %>
<!--#Include virtual="/Administration/Transfers/adminDetailDBInclude.asp"--> 
<!--#Include virtual="/Administration/Transfers/Dimensions.asp"-->
<% 
If Len(ID) > 0 then
 %>
	<!--#Include virtual="/Administration/Transfers/GatherAnimalData.asp"-->
	<!--#Include virtual="/Administration/Transfers/TransferMovedata.asp"-->
    <!--#Include virtual="/Conn.asp"-->
<%
	dim 	alpacaName(99999)

			 sql2 = "select * from Photos where ID = " &  ID & ";" 
			'response.write(sql2)
			Set rs2 = Server.CreateObject("ADODB.Recordset")
			rs2.Open sql2, conn, 3, 3   
			 If rs2.eof Then

					Query =  "INSERT INTO Photos (ID)" 
					Query =  Query & " Values (" &  ID & ")"

					'response.write(Query)
Conn.Execute(Query) 
Conn.Close
Set Conn = Nothing 
	End If 
End if

'dim IDArray(2000)

	sql2 = "select Animals.ID, Animals.FullName from Animals order by Fullname"
	
	'response.write(sql2)
	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	
	While Not rs2.eof  
		IDArray(acounter) = rs2("ID")
		alpacaName(acounter) = rs2("FullName")
		'response.write (SSName(studcounter))

		acounter = acounter +1
		rs2.movenext
	Wend		
	
		rs2.close

end if ' end transfer %>
<!--#Include file="adminConn.asp"-->
<%

Uploadpathlength = len(LongWeblink)  + 9 
			Set rs = Server.CreateObject("ADODB.Recordset")
			
			sql = "select * from Photos where id = " & ID
				rs.Open sql, conn, 3, 3

				If rs.eof Then
					Query =  "INSERT INTO Photos (ID)" 
					Query =  Query & " Values (" &  ID & ")"

Conn.Execute(Query) 
Conn.Close
Set Conn = Nothing 
				rs.close

				sql = "select * from Photos where id = " & ID
				
				rs.Open sql, conn, 3, 3
				
				End If 
FiberAnalysis = rs("FiberAnalysis")
Histogram= rs("Histogram")
ARI = rs("ARI")
AnimalVideo = rs("AnimalVideo")

				If Len(rs("Photo1")) > 2 Then
						File1= rs("Photo1")

					else
						File1 = "/uploads/ImageNotAvailable.jpg"
					End If


					If Len(rs("Photo2")) > 2 Then
						File2= rs("Photo2")
					else
						File2 = "/uploads/ImageNotAvailable.jpg"
					End If
					
				If Len(rs("Photo3")) > 2 Then
						File3= rs("Photo3")
					else
						File3 = "/uploads/ImageNotAvailable.jpg"
					End If

					If Len(rs("Photo4")) > 2 Then
						File4= rs("Photo4")
					else
						File4 = "/uploads/ImageNotAvailable.jpg"
					End If

						If Len(rs("Photo5")) > 2 Then
						File5= rs("Photo5")
					else
						File5 = "/uploads/ImageNotAvailable.jpg"
					End If


				If Len(rs("Photo6")) > 2 Then
						File6= rs("Photo6")
					else
						File6 = "/uploads/ImageNotAvailable.jpg"
					End If

	If Len(rs("Photo7")) > 2 Then
						File7= rs("Photo7")
					else
						File7 = "/uploads/ImageNotAvailable.jpg"
					End If

						If Len(rs("Photo8")) > 2 Then
						File8= rs("Photo8")
					else
						File8 = "/uploads/ImageNotAvailable.jpg"
					End If

	     If len(rs("PhotoCaption1")) > 1 then
				   PhotoCaption1 = rs("PhotoCaption1")
		End If 
		 If len(rs("PhotoCaption2")) > 1 then
				   PhotoCaption2 = rs("PhotoCaption2")
		End If 
		 If len(rs("PhotoCaption3")) > 1 then
				   PhotoCaption3 = rs("PhotoCaption3")
		End If 
		 If len(rs("PhotoCaption4")) > 1 then
				   PhotoCaption4 = rs("PhotoCaption4")
		End If 
		 If len(rs("PhotoCaption5")) > 1 then
				   PhotoCaption5 = rs("PhotoCaption5")
		End If 
		 If len(rs("PhotoCaption6")) > 1 then
				   PhotoCaption6 = rs("PhotoCaption6")
		End If 
		 If len(rs("PhotoCaption1")) > 1 then
				   PhotoCaption1 = rs("PhotoCaption1")
		End If 
		 If len(rs("PhotoCaption7")) > 1 then
				   PhotoCaption7 = rs("PhotoCaption7")
		End If 
		If len(rs("PhotoCaption8")) > 1 then
				   PhotoCaption8 = rs("PhotoCaption8")
		End If 

			str1 = ARI
			str2 = "''"
			If InStr(str1,str2) > 0 Then
				ARI= Replace(str1,  str2, "'")
			End If  
			
			str1 = Histogram
			str2 = "''"
			If InStr(str1,str2) > 0 Then
				Histogram= Replace(str1,  str2, "'")
			End If  

		str1 = FiberAnalysis
			str2 = "''"
			If InStr(str1,str2) > 0 Then
				FiberAnalysis= Replace(str1,  str2, "'")
			End If  

			str1 = File1
			str2 = "''"
			If InStr(str1,str2) > 0 Then
				File1= Replace(str1,  str2, "'")
			End If  	 

			str1 = File2
			str2 = "''"
			If InStr(str1,str2) > 0 Then
				File2= Replace(str1,  str2, "'")
			End If  	
			
			
			str1 = File3
			str2 = "''"
			If InStr(str1,str2) > 0 Then
				File3= Replace(str1,  str2, "'")
			End If  	 
			
			str1 = File4
			str2 = "''"
			If InStr(str1,str2) > 0 Then
				File4= Replace(str1,  str2, "'")
			End If  	 
			
			str1 = File5
			str2 = "''"
			If InStr(str1,str2) > 0 Then
				File5= Replace(str1,  str2, "'")
			End If  	 
			
			str1 = File6
			str2 = "''"
			If InStr(str1,str2) > 0 Then
				File6= Replace(str1,  str2, "'")
			End If  	
			
			str1 = File7
			str2 = "''"
			If InStr(str1,str2) > 0 Then
				File7= Replace(str1,  str2, "'")
			End If  
			
			str1 = File8
			str2 = "''"
			If InStr(str1,str2) > 0 Then
				File8= Replace(str1,  str2, "'")
			End If  


				rs.close
%>
	<% if screenwidth < 989 then %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "left" width = "<%=screenwidth %>">
<% else %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth %>">
<% end if %><tr><td class = "roundedtop" align = "left">
		<H1><div align = "left">Upload Photos for <%=animalname%></div></H1>
</td></tr>
<tr><td class = "roundedBottom" align = "center" >
<%  
'dim listalpacaName(2000)

	sql2 = "select * from Animals order by Fullname ;"
'response.write(sql2)
	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	
	While Not rs2.eof  
		IDArray(acounter) = rs2("ID")
		listalpacaName(acounter) = rs2("FullName")
		'response.write (SSName(studcounter))

		acounter = acounter +1
		rs2.movenext
	Wend		
	
		rs2.close
		set rs2=nothing
		set conn = nothing
%>
		
 <table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%" align = "center"  ">
			<tr>
					<td class = "body" align = "left"><blockquote><h2>Be Kind, Resize</h2>
Large images slow down your website, so please resize your images before you upload them. We recommend that you resize your images to 300 pixels width. <b>Any images larger then 1MB will be rejected.</b><br /><br />
<h2>Upload Formats</h2>
All photos must be JPG, JPEG, or PNG formats; however, the registration certificates<% if speciesid = 2 then %>, Fiber Analyses, and Histograms<% end if %> may be in PDF format.</blockquote>
</td>
	</tr>
	<tr>
		<td  height = "10" ></td>
	</tr>
</table>
<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%" align = "center"  >
<tr><td class = "body" align = "left">

	<font class = "body">
		<form  action="AdminPhotos.asp" method = "post">
			  
			  <table border = "0" width = "400" align = "left" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
			   <tr>
				 <td class = "body" align = "left">
					<b>Edit another animal's photos:</b>
					<select size="1" name="ID" onchange="submit();">
					<option name = "AID0" value= "" selected></option>
					<% count = 1
						while count < acounter
						response.write(count)
					%>
						<option name = "AID1" value="<%=IDArray(count)%>">
							<%=listalpacaName(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
				</td>
			  </tr>
		    </table>
			 </form>
	 </font>
			
</td>
</tr>
</table>

<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%" align = "center">
  <tr><td>
  <a name='ARI'></a>
	<div align = "right"><!--#Include file="AdminPhotoJumpLinks.asp"--> </div>
</td>
</tr>
</table>

	<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%"><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Registration Certificate</div></H2>
</td></tr>
<tr><td class = "roundedBottom" align = "center">
<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%" align = "center" >
		<tr>
	<td class = "body" align = "center" width = "140">
	<% if len(ARI) > 1 then %>
	<a href = "<%=ARI %>" target = "blank"><img src="/images/ARIThumb.jpg" width = "104" width = "82" border = "0"/></a><br />
	<a href = "<%=ARI %>" target = "blank" class = "body">Click to View Registration Cert</a>
	<% end if %>
	</td>
	<% if screenwidth < 730 then %>
	</tr><tr>
	<% end if %>
	<td class = "body" align = "left">	
					<form name="frmSend" method="POST" enctype="multipart/form-data" action="AdminARIUpload.asp?ID=<%=ID%>" >
						Upload Certificate: <input name="attach1" type="file" class="regsubmit2" size=45 >
						<input  type=submit value="Upload" class="regsubmit2" <%=Disablebutton %>>
					</form>
						<% if len(ARI) > 1 then %>
					<form action= 'AdminARIRemove.asp' method = "post">
							Would you like to remove this Certificate? 
								<input type = "hidden" name="ID" value= "<%= ID %>" >
							<input type=submit value="Remove This Certificate" class="regsubmit2" <%=Disablebutton %>>
					</form>
					<% End If %>
			</td>
			</tr>
		</table>
		</td>
			</tr>
		</table>

<% If speciesID = 2 then  %>
		<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%" align = "center">
  <tr><td>
	<div align = "right"><!--#Include file="AdminPhotoJumpLinks.asp"--> </div>
</td>
</tr>
</table>
<a name = "Histogram"></a>
	<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%"><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Histogram</div></H2>
</td></tr>
<tr><td class = "roundedBottom" align = "center">

<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%" align = "center" >
		<tr>
			<td class = "body" align = "center" width = "140">
	<% if len(Histogram) > 1 then %>
	<a href = "<%=Histogram %>" target = "blank"><img src="/images/HistogramThumb.jpg" width = "104" width = "82" border = "0"/></a><br />
	<a href = "<%=Histogram %>" target = "blank" class = "body">Click to View Histogram</a>
	<% end if %>
	</td>
		<% if screenwidth < 730 then %>
	</tr><tr>
	<% end if %>
			<td class = "body" align = "left">
					<form name="frmSend" method="POST" enctype="multipart/form-data" action="AdminHistogramUpload.asp" >

						Upload New Histogram: <input name="attach1" type="file" class="regsubmit2" size=45 >
						<input  type=submit value="Upload" class="regsubmit2" <%=Disablebutton %>>
					</form>
						<% if len(Histogram) > 1 then %>
					<form action= 'AdminHistogramRemove.asp' method = "post">
							Would you like to remove this Histogram? 
								<input type = "hidden" name="ID" value= "<%= ID %>" >
							<input type=submit value="Remove This Histogram" class="regsubmit2" <%=Disablebutton %>>
					</form>
					<% end if %>
			</td>
			</tr>
		</table>
	</td>
			</tr>
		</table>



<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%" align = "center">
  <tr><td>
	<div align = "right"><!--#Include file="AdminPhotoJumpLinks.asp"--> </div>
</td>
</tr>
</table>
<a name = "FiberAnalysis"></a>
	<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%"><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left"><% If AdministrationID  = 2 then %>
Fibre 
<% else %>
Fiber 
<% end if %> Analysis - from a Certified Sorter</div></H2>
</td></tr>
<tr><td class = "roundedBottom" align = "center">

<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%" align = "center" >
		<tr>
			<td class = "body" align = "center" width = "140">
	<% if len(FiberAnalysis) > 1 then %>
	<a href = "<%=FiberAnalysis %>" target = "blank">
    <% If AdministrationID  = 2 then %>
<img src="/images/FibreAnalysisThumb.jpg" width = "104" width = "82" border = "0"/>
<% else %>
<img src="/images/FiberAnalysisThumb.jpg" width = "104" width = "82" border = "0"/>
<% end if %> 
</a><br />
	<a href = "<%=FiberAnalysis %>" target = "blank" class = "body">Click to View <% If AdministrationID  = 2 then %>
Fibre 
<% else %>
Fiber 
<% end if %> Analysis</a>
	<% end if %>
	</td>
		<% if screenwidth < 730 then %>
	</tr><tr>
	<% end if %>
			<td class = "body" align = "left">
					<form name="frmSend" method="POST" enctype="multipart/form-data" action="AdminFiberAnalysisUpload.asp" >

						Upload <% If AdministrationID  = 2 then %>
Fibre 
<% else %>
Fiber 
<% end if %> Analysis: <input name="attach1" type="file" class="regsubmit2" size=45 >
						<input  type=submit value="Upload" class="regsubmit2" <%=Disablebutton %>><br />
						<center><img src = "/images/Important_Triangle.png" height = "20"/><b>PDF or JPG Format Only.</b></center>
					</form>
						<% if len(FiberAnalysis) > 1 then %>
					<form action= 'AdminFiberAnaylsisRemove.asp' method = "post">
							Would you like to remove this <% If AdministrationID  = 2 then %>
Fibre 
<% else %>
Fiber 
<% end if %> Analysis? 
								<input type = "hidden" name="ID" value= "<%= ID %>" >
							<input type=submit value="Remove" class="regsubmit2" <%=Disablebutton %>>
					</form>
					<% end if %>
			</td>
			</tr>
		</table>
	</td>
			</tr>
		</table>
		
<% end if %>	

<br />
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%">
  <tr><td>
	<div align = "right"><!--#Include file="AdminPhotoJumpLinks.asp"--> </div>
</td>
</tr>
<tr><td class = "roundedtop" align = "left">
<a name="Video"></a><H2><div align = "left">Add a Video</div></H2>
</td></tr>
<tr><td class = "roundedBottom" align = "center" height = "30" valign = "top">
<% str1 = AnimalVideo
str2 = "width"
If InStr(str1,str2) > 0 Then
AnimalVideo= Replace(str1, "width", "width = 300 widthx")
End If
%>

<form  method="POST" action="AdminAnimalVideoupload.asp" >
<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%"  align = "center"  valign = "top">
<tr><td class = "body2" width = "530" >
Copy and paste your code from YouTube, to learn more <a href = "https://support.google.com/youtube/answer/171780?hl=en" target = "blank" class = "body">click here</a>.
<input name="ID"  value = "<%= ID %>" type = "hidden">
<input name="PeopleID"  size = "60" value = "<%=PeopleID%>" type = "hidden">
<input type = "hidden" name="ImageID" value= "<%=textblocknum%>" ><br />
Embed Video: <br>
<TEXTAREA NAME="TempVideo" cols="80" rows="4" class = "body" ><%=AnimalVideo%></textarea><br>
<center><input  type=submit value="Submit" class = "regsubmit2"  <%=Disablebutton %>></center>
 <br></form>
<% if len(AnimalVideo) > 4 then%>
<center><form action= 'AdminVideoRemove.asp' method = "post">
<input type = "hidden" name="ID" value= "<%= ID %>" >
<input type=submit value="Remove Video" class="regsubmit2" <%=Disablebutton %>>
</form></center>
 <br> <br>

To learn about keeping your video file sizes small <a href = "https://support.google.com/youtube/answer/1722171?hl=en" class = "body" target ="blank"> click here.</a>

<% end if %>


</td>
<td width = 300>
<%=AnimalVideo%>
</td>
</tr>
</table>
</td>
</tr>
</table>



<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%" align = "center">
  <tr><td>
	<div align = "right"><!--#Include file="AdminPhotoJumpLinks.asp"--> </div>
</td>
</tr>
</table>
<a name = "Photos"></a>
	<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%"><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Main Image
	
		
		</div></H2>
</td></tr>
<tr><td class = "roundedBottom" align = "center">

<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%" align = "center"  >
		<tr>
			<td width = "150" align = "center" class = "body2">
					<img src = "<%=File1%>" height = "100">
					<center><b><%=PhotoCaption1%></b></center>
			</td>
<% if screenwidth < 730 then %>
	</tr><tr>
	<% end if %>
			<td class = "body" align = "left">
					<form name="frmSend" method="POST" enctype="multipart/form-data" action="AdminImageUpload.asp?imagenum=1" >
	<br />Upload Photo: <input name="attach1" type="file" class="regsubmit2" size=45 class="regsubmit2" >
						<input  type=submit value="Upload" class="regsubmit2" <%=Disablebutton %>>
					</form>
					
<%if len(File1) > 0 and not(File1 = "/uploads/ImageNotAvailable.jpg") then %>
<form action= 'AdminPhotoChangeOrder1.asp' method = "post">
<input type = "hidden" name="CurrentPhoto" value= "1" >
<input type = "hidden" name="ID" value= "<%= ID %>" >
Photo Order: <select size="1" name="PhotoOrder">
<option value="1" selected>1</option>
<option  value="2">2</option>
<option  value="3">3</option>
<option  value="4">4</option>
<option  value="5">5</option>
<option  value="6">6</option>
<option  value="7">7</option>
<option  value="8">8</option>
</select>
<input type=submit value="Submit" class="regsubmit2" <%=Disablebutton %>>
</form>
<form action= 'AdminCaptionAdd.asp' method = "post">
Caption (60 Character Max.): <input name="Caption" Value ="<%=PhotoCaption1%>"  size = "60" maxlength = "60">
<input type = "hidden" name="CaptionID" value= "1" >
<input type = "hidden" name="ID" value= "<%= ID %>" >
<input type=submit value="Submit" class="regsubmit2" <%=Disablebutton %>>
</form>
<form action= 'AdminImageRemove.asp' method = "post">
Would you like to remove this image? 
<input type = "hidden" name="ImageID" value= "1" >
<input type = "hidden" name="ID" value= "<%= ID %>" >
<input type=submit value="Remove This Image" class="regsubmit2" <%=Disablebutton %>>
</form>
<% end if %>
</td></tr></table>
</td>
</tr>
</table>
<% imagenum = 2 
tempfilename = File2
tempPhotoCaption   =PhotoCaption2
%>
<!--#Include file="AdminPhotosUploadsInclude.asp"-->
<% imagenum = 3 
tempfilename = File3
tempPhotoCaption   =PhotoCaption3
%>
<!--#Include file="AdminPhotosUploadsInclude.asp"-->
<% imagenum = 4 
tempfilename = File4
tempPhotoCaption   =PhotoCaption4
%>
<!--#Include file="AdminPhotosUploadsInclude.asp"-->
<% imagenum = 5 
tempfilename = File5
tempPhotoCaption   =PhotoCaption5
%>
<!--#Include file="AdminPhotosUploadsInclude.asp"-->
<% imagenum = 6 
tempfilename = File6
tempPhotoCaption   =PhotoCaption6
%>
<!--#Include file="AdminPhotosUploadsInclude.asp"-->
<% imagenum = 7 
tempfilename = File7
tempPhotoCaption   =PhotoCaption7
%>
<!--#Include file="AdminPhotosUploadsInclude.asp"-->
<% imagenum = 8 
tempfilename = File8
tempPhotoCaption   =PhotoCaption8
%>
<!--#Include file="AdminPhotosUploadsInclude.asp"-->