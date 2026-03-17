<%
Set rs = Server.CreateObject("ADODB.Recordset")
sql = "select * from Photos where id = " & ID
rs.Open sql, connLOA, 3, 3
If rs.eof Then
Query =  "INSERT INTO Photos (ID)" 
Query =  Query & " Values (" &  ID & ")"
connLOA.Execute(Query) 
rs.close

sql = "select * from Photos where id = " & ID
rs.Open sql, connLOA, 3, 3
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

If Len(rs("Photo9")) > 2 Then
File9= rs("Photo9")
else
File9 = "/uploads/ImageNotAvailable.jpg"
End If
If Len(rs("Photo10")) > 2 Then
File10= rs("Photo10")
else
File10 = "/uploads/ImageNotAvailable.jpg"
End If
If Len(rs("Photo11")) > 2 Then
File11= rs("Photo11")
else
File11 = "/uploads/ImageNotAvailable.jpg"
End If
If Len(rs("Photo12")) > 2 Then
File12= rs("Photo12")
else
File12 = "/uploads/ImageNotAvailable.jpg"
End If
If Len(rs("Photo13")) > 2 Then
File13= rs("Photo13")
else
File13 = "/uploads/ImageNotAvailable.jpg"
End If
If Len(rs("Photo14")) > 2 Then
File14= rs("Photo14")
else
File14 = "/uploads/ImageNotAvailable.jpg"
End If
If Len(rs("Photo15")) > 2 Then
File15= rs("Photo15")
else
File15 = "/uploads/ImageNotAvailable.jpg"
End If
If Len(rs("Photo16")) > 2 Then
File16= rs("Photo16")
else
File16 = "/uploads/ImageNotAvailable.jpg"
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
If len(rs("PhotoCaption9")) > 1 then
PhotoCaption9 = rs("PhotoCaption9")
End If 
If len(rs("PhotoCaption10")) > 1 then
PhotoCaption10 = rs("PhotoCaption10")
End If 
If len(rs("PhotoCaption11")) > 1 then
PhotoCaption11 = rs("PhotoCaption1")
End If 
If len(rs("PhotoCaption12")) > 1 then
PhotoCaption12 = rs("PhotoCaption12")
End If 
If len(rs("PhotoCaption13")) > 1 then
PhotoCaption13 = rs("PhotoCaption13")
End If 
If len(rs("PhotoCaption14")) > 1 then
PhotoCaption14 = rs("PhotoCaption14")
End If 
If len(rs("PhotoCaption15")) > 1 then
PhotoCaption15 = rs("PhotoCaption15")
End If 
If len(rs("PhotoCaption16")) > 1 then
PhotoCaption16 = rs("PhotoCaption16")
End If 

str1 = ARI
str2 = "''"
If InStr(str1,str2) > 0 Then
ARI= Replace(str1,  str2, "'")
End If  

str1 = lcase(ARI)
str2 = "uploads"
str3 = "http://"
If  InStr(str1,str2) > 0 and Not(InStr(str1,str3) > 0) Then
ARI= "http://www.AlpacaInfinity.com/" &ARI
End If 

str1 = lcase(ARI) 
str2 = "http://www.alpacainfinity.com"
If InStr(str1,str2) > 0 Then
ARI=  Replace(str1, str2 , "http://www.livestockofamerica.com")
End If  

str1 = Histogram
str2 = "''"
If InStr(str1,str2) > 0 Then
Histogram= Replace(str1,  str2, "'")
End If  
            
str1 = lcase(Histogram)
str2 = "uploads"
str3 = "http://"
If  InStr(str1,str2) > 0 and Not(InStr(str1,str3) > 0) Then
Histogram= "http://www.livestockofamerica.com/" & Histogram
End If 
str1 = lcase(Histogram) 
str2 = "http://www.alpacainfinity.com"
If InStr(str1,str2) > 0 Then
Histogram  =  Replace(str1, str2 , "http://www.livestockofamerica.com")
End If  

str1 = FiberAnalysis
str2 = "''"
If InStr(str1,str2) > 0 Then
FiberAnalysis= Replace(str1,  str2, "'")
End If  

str1 = lcase(FiberAnalysis) 
str2 = "http://www.alpacainfinity.com"
If InStr(str1,str2) > 0 Then
FiberAnalysis=  Replace(str1, str2 , "http://www.livestockofamerica.com")
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

str1 = File9
str2 = "''"
If InStr(str1,str2) > 0 Then
File9= Replace(str1,  str2, "'")
End If  

str1 = File10
str2 = "''"
If InStr(str1,str2) > 0 Then
File10= Replace(str1,  str2, "'")
End If  

str1 = File11
str2 = "''"
If InStr(str1,str2) > 0 Then
File11= Replace(str1,  str2, "'")
End If  

str1 = File12
str2 = "''"
If InStr(str1,str2) > 0 Then
File12= Replace(str1,  str2, "'")
End If  

str1 = File13
str2 = "''"
If InStr(str1,str2) > 0 Then
File13= Replace(str1,  str2, "'")
End If  

str1 = File14
str2 = "''"
If InStr(str1,str2) > 0 Then
File14= Replace(str1,  str2, "'")
End If  

str1 = File15
str2 = "''"
If InStr(str1,str2) > 0 Then
File15= Replace(str1,  str2, "'")
End If  

str1 = File16
str2 = "''"
If InStr(str1,str2) > 0 Then
File16= Replace(str1,  str2, "'")
End If  


str1 = lcase(File1) 
str2 = "http://www.alpacainfinity.com"
If InStr(str1,str2) > 0 Then
File1 =  Replace(str1, str2 , "http://www.livestockofamerica.com")
End If  
str1 = lcase(File2) 
str2 = "http://www.alpacainfinity.com"
If InStr(str1,str2) > 0 Then
File2 =  Replace(str1, str2 , "http://www.livestockofamerica.com")
End If  
str1 = lcase(File3) 
str2 = "http://www.alpacainfinity.com"
If InStr(str1,str2) > 0 Then
File3 =  Replace(str1, str2 , "http://www.livestockofamerica.com")
End If  
str1 = lcase(File4) 
str2 = "http://www.alpacainfinity.com"
If InStr(str1,str2) > 0 Then
File4 =  Replace(str1, str2 , "http://www.livestockofamerica.com")
End If  
str1 = lcase(File5) 
str2 = "http://www.alpacainfinity.com"
If InStr(str1,str2) > 0 Then
File5 =  Replace(str1, str2 , "http://www.livestockofamerica.com")
End If  
str1 = lcase(File6) 
str2 = "http://www.alpacainfinity.com"
If InStr(str1,str2) > 0 Then
File6 =  Replace(str1, str2 , "http://www.livestockofamerica.com")
End If  
str1 = lcase(File7) 
str2 = "http://www.alpacainfinity.com"
If InStr(str1,str2) > 0 Then
File7 =  Replace(str1, str2 , "http://www.livestockofamerica.com")
End If  
str1 = lcase(File8) 
str2 = "http://www.alpacainfinity.com"
If InStr(str1,str2) > 0 Then
File8 =  Replace(str1, str2 , "http://www.livestockofamerica.com")
End If  
rs.close
 str1 = Name
str2 = "''"
If InStr(str1,str2) > 0 Then
Name= Replace(str1,  str2, "'")
End If  
%>


	<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth-32 %>"><tr><td  align = "left">
		<H1><div align = "left">Upload Photos for <%=Name%></div></H1>
        <%  

Dim listalpacaName(100000)
Dim IDArray(100000)
	sql2 = "select * from Animals where PeopleID = " & Session("AIID") & " order by Fullname ;"
'response.write(sql2)
	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, connLOA, 3, 3 
	
	While Not rs2.eof  
		IDArray(acounter) = rs2("ID")
		listalpacaName(acounter) = rs2("FullName")
		'response.write (SSName(studcounter))

		acounter = acounter +1
		rs2.movenext
	Wend		
	
rs2.close
set rs2=nothing
set connLOA = nothing
%>
		
<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%" align = "center"  ">
<tr>
<td><img src = "images/Photos.jpg" align = "left" /></td>
<td class = "body" align = "left"><blockquote><h2>Be Kind, Resize</h2>
Large images slow down your pages, so please resize your images before you upload them. We recommend that you resize your images to 300 pixels width. <b>Any images larger then 1MB will be rejected.</b><br /><br />
<h2>Upload Formats</h2>
All photos must be JPG, JPEG, or PNG formats
<% if SpeciesID = 22 or SpeciesID = 19 or SpeciesID = 15 or SpeciesID = 14 or SpeciesID = 13 then %>
.
<% else %>
; however, Registration certificates, Fiber Analyses, and Histograms may be in PDF format.
<% end if %>

</blockquote>
</td>
	</tr>
	<tr>
		<td  height = "10" ></td>
	</tr>
</table>
<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%" align = "center"  >
<tr><td class = "body" align = "left">

	<font class = "body">
		<form  action="membersPhotos.asp" method = "post">
			  
			  <table border = "0" width = "400" align = "left" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
			   <tr>
				 <td class = "body" align = "left">
<b>Edit Another Animal's Photos</b><br />
<select size="1" name="ID" onchange="submit();" class = "formbox">
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

<% if SpeciesID = 22 or SpeciesID = 19 or SpeciesID = 15 or SpeciesID = 14 or SpeciesID = 13 then 
else %>

<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%" align = "center">
  <tr><td>
	<div align = "right"><!--#Include file="membersPhotoJumpLinks.asp"--> </div>
</td>
</tr>
</table>

<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = <%=screenwidth-32 %> class = "roundedtopandbottom"><tr><td  align = "left">
<a name='Registration'></a>		<H2><div align = "left">Registration Certificate</div></H2>
<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%" align = "center" >
		<tr>
	<td class = "body" align = "center" width = "140">
	<% if len(ARI) > 1 then %>
	<a href = "<%=ARI %>" target = "blank"><img src="images/ARIThumb.jpg" width = "104" width = "82" border = "0"/></a><br />
	<a href = "<%=ARI %>" target = "blank" class = "body">Click to View Registration Cert</a>
	<% end if %>
	</td>
	<td class = "body" align = "left">	
	<form name="frmSend" method="POST" enctype="multipart/form-data" action="membersARIUpload.asp" >
	Upload Certificate <input name="attach1" type="file" class="formbox" size=45 >
<center><br /><input  type=submit value="UPLOAD" class="regsubmit2"></center>
    <br>

	</form>
<% if len(ARI) > 1 then %>
<form action= 'membersARIRemove.asp' method = "post">
<input type = "hidden" name="ID" value= "<%= ID %>" >
<center><input type=submit value="REMOVE CERTIFICATE" class="regsubmit2"></center>
</form>
<% End If %>
</td></tr>
</table>
</td></tr></table>

<% if speciesID = 2 or speciesID = 4 or speciesID = 6 or speciesID = 10 or speciesID = 11 then %>
		<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%" align = "center">
  <tr><td>
	<div align = "right"><!--#Include file="membersPhotoJumpLinks.asp"--> </div>
</td>
</tr>
</table>
<a name = "Histogram"></a>
	<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = <%=screenwidth-32 %> class = "roundedtopandbottom"><tr><td align = "left">
		<H2><div align = "left">Histogram</div></H2>

<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%" align = "center" >
		<tr>
			<td class = "body" align = "center" width = "140">
	<% if len(Histogram) > 1 then %>
	<a href = "<%=Histogram %>" target = "blank"><img src="images/HistogramThumb.jpg" width = "104" width = "82" border = "0"/></a><br />
	<a href = "<%=Histogram %>" target = "blank" class = "body">Click to View Histogram</a>
	<% end if %>
	</td>
			<td class = "body" align = "left">
<form name="frmSend" method="POST" enctype="multipart/form-data" action="membersHistogramUpload.asp" >
Upload Histogram <input name="attach1" type="file" class="formbox" size=45 >
<center><br /><input type=submit value="UPLOAD" class="regsubmit2"></center>
</form>
<% if len(Histogram) > 1 then %>
<form action= 'membersHistogramRemove.asp' method = "post">
<br />
<center><input type = "hidden" name="ID" value= "<%= ID %>" >
	<input type=submit value="REMOVE HISTOGRAM" class="regsubmit2"></center>
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
	<div align = "right"><!--#Include file="membersPhotoJumpLinks.asp"--> </div>
</td>
</tr>
</table>
<a name = "FiberAnalysis"></a>

	<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = <%=screenwidth-32 %> class = "roundedtopandbottom"><tr><td align = "left">
		<H2><div align = "left">Fiber Analysis - from a Certified Sorter</div></H2>

<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%" align = "center" >
		<tr>
			<td class = "body" align = "center" width = "140">
	<% if len(FiberAnalysis) > 1 then %>
	<a href = "<%=FiberAnalysis %>" target = "blank"><img src="/images/FiberAnalysisThumb.jpg" width = "104" width = "82" border = "0"/></a><br />
	<a href = "<%=FiberAnalysis %>" target = "blank" class = "body">Click to View Fiber Analysis</a>
	<% end if %>
	</td>
		<% if screenwidth < 730 then %>
	</tr><tr>
	<% end if %>
			<td class = "body" align = "left">
<form name="frmSend" method="POST" enctype="multipart/form-data" action="membersFiberAnalysisUpload.asp" >

Upload Fiber Analysis <input name="attach1" type="file" class="formbox" size=45 >
<center><br /><input  type=submit value="UPLOAD" class="regsubmit2"></center>
<center><img src = "images/Important_Triangle.png" height = "20"/><b>PDF or JPF Format Only.</b></center>
<br />

</form>
<% if len(FiberAnalysis) > 1 then %>
<form action= 'membersFiberAnaylsisRemove.asp' method = "post">
<input type = "hidden" name="ID" value= "<%= ID %>" >
<center><input type=submit value="REMOVE FIBER ANALYSIS" class="regsubmit2"></center>
</form>
<% end if %>
			</td>
			</tr>
		</table>
	</td>
			</tr>
		</table>


<% end if %>
<% end if %>

<br />
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth - 32 %>" class = 'roundedtopandbottom">
  <tr><td>
	<div align = "right"><!--#Include file="membersPhotoJumpLinks.asp"--> </div>
</td>
</tr>
<tr><td align = "left" class = "roundedtopandbottom">
<a name="Video"></a><H2><div align = "left">ADD A VIDEO</div></H2>

<% if SubscriptionLevel > 3 then 

str1 = AnimalVideo
str2 = "width"
If InStr(str1,str2) > 0 Then
AnimalVideo= Replace(str1, "width", "width = 300 widthx")
End If
%>

<form  method="POST" action="membersAnimalVideoupload.asp" >
<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%"  align = "center"  valign = "top">
<tr><td class = "body2" width = "530" >
Copy and paste your code from YouTube, to learn more <a href = "https://support.google.com/youtube/answer/171780?hl=en" target = "blank" class = "body"><b>click here</b></a>.
<input name="ID" value = "<%= ID %>" type = "hidden">
<input name="PeopleID"  size = "60" value = "<%=PeopleID%>" type = "hidden">
<input type = "hidden" name="ImageID" value= "<%=textblocknum%>" ><br />
Embed Video: <br>
<TEXTAREA NAME="TempVideo" cols="80" rows="4" class = "body" ><%=AnimalVideo%></textarea><br>
<center><br /><input type=submit value="SUBMIT" class = "regsubmit2"></center>
 <br></form>
<% if len(AnimalVideo) > 4 then%>
<center><form action= 'membersVideoRemove.asp' method = "post">
<input type = "hidden" name="ID" value= "<%= ID %>" >
<input type=submit value="REMOVE VIDEO" class="regsubmit2">
</form></center>
 <br> <br>
<% end if %>

To learn about keeping your video file sizes small <a href = "https://support.google.com/youtube/answer/1722171?hl=en" class = "body" target ="blank"> click here.</a>




</td>
<td width = 300>
<%=AnimalVideo%>
</td>
</tr>
		</table>
<% else %>
<div class = "body">You membership does not include animal videos. To upgrade your membership please <a href = "membersRenewSubscription.asp?peopleID=<%=PeopleID %>" class = "body">click here.</a> </div>
	<% end if %>	
</td>
			</tr>
		</table>


<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "<%=screenwidth %>" align = "center">
  <tr><td>
	<div align = "right"><!--#Include file="membersPhotoJumpLinks.asp"--> </div>
</td>
</tr>
</table>
<a name = "Photos"></a>
<% currentphoto = 1
TempFile = File1
TempPhotoCaption = PhotoCaption1
 %>
<!--#Include file="membersUploadphotoincludefile.asp"-->


<% if SubscriptionLevel > 3 then %>

<% currentphoto = 2
TempFile = File2
TempPhotoCaption = PhotoCaption2
%>
<!--#Include file="membersUploadphotoincludefile.asp"-->

<% currentphoto = 3
TempFile = File3
TempPhotoCaption = PhotoCaption3
%>
<!--#Include file="membersUploadphotoincludefile.asp"-->

<% currentphoto = 4
TempFile = File4
TempPhotoCaption = PhotoCaption4
%>
<!--#Include file="membersUploadphotoincludefile.asp"-->


<% currentphoto = 5
TempFile = File5
TempPhotoCaption = PhotoCaption5
%>
<!--#Include file="membersUploadphotoincludefile.asp"-->

<% currentphoto = 6
TempFile = File6
TempPhotoCaption = PhotoCaption6
%>
<!--#Include file="membersUploadphotoincludefile.asp"-->

<% currentphoto = 7
TempFile = File7
TempPhotoCaption = PhotoCaption7
%>
<!--#Include file="membersUploadphotoincludefile.asp"-->

<% currentphoto = 8
TempFile = File8
TempPhotoCaption = PhotoCaption8
%>
<!--#Include file="membersUploadphotoincludefile.asp"-->


<% end if %>

<% if SubscriptionLevel = 4 then %>

<% currentphoto = 9
TempFile = File9
TempPhotoCaption = PhotoCaption9
%>
<!--#Include file="membersUploadphotoincludefile.asp"-->

<% currentphoto = 10
TempFile = File10
TempPhotoCaption = PhotoCaption10
%>
<!--#Include file="membersUploadphotoincludefile.asp"-->


<% currentphoto = 11
TempFile = File11
TempPhotoCaption = PhotoCaption11
%>
<!--#Include file="membersUploadphotoincludefile.asp"-->

<% currentphoto = 12
TempFile = File12
TempPhotoCaption = PhotoCaption12
%>
<!--#Include file="membersUploadphotoincludefile.asp"-->

<% currentphoto = 13
TempFile = File13
TempPhotoCaption = PhotoCaption13
%>
<!--#Include file="membersUploadphotoincludefile.asp"-->

<% currentphoto = 14
TempFile = File14
TempPhotoCaption = PhotoCaption14
%>
<!--#Include file="membersUploadphotoincludefile.asp"-->

<% currentphoto = 15
TempFile = File15
TempPhotoCaption = PhotoCaption15
%>
<!--#Include file="membersUploadphotoincludefile.asp"-->

<% currentphoto = 16
TempFile = File16
TempPhotoCaption = PhotoCaption16
%>
<!--#Include file="membersUploadphotoincludefile.asp"-->

</td></tr></table>

</td></tr></table>



<% end if %>