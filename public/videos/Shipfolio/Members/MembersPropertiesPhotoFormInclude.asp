<% 
if len(PropID) > 0 then
sql = "select * from Propertyphotos where PropID = " & PropID
rs.Open sql, conn, 3, 3

If rs.eof Then
	Query =  "INSERT INTO Propertyphotos (PropID)" 
	Query =  Query & " Values (" &  PropID & ")"

	'response.write(Query)
	
	
rs.close

sql = "select * from Propertyphotos where PropID = " & PropID
'response.write(sql)
rs.Open sql, conn, 3, 3

 

	If Len(Filename) > 2 Then
		File1 =Filename
	else
		File1= rs("PropImage1")
	End If
	 If Len(File1) < 2 Then
		File1 = "/uploads/ImageNotAvailable.jpg"
	End if

	If Len(Filename2) > 2 Then
		File2 =Filename2
	else
		File2= rs("PropImage2")
	End If
	 If Len(File2) < 2 Then
		File2 = "/uploads/ImageNotAvailable.jpg"
	End if

	If Len(Filename3) > 2 Then
		File3 =Filename3
	else
		File3= rs("PropImage3")
	End If
	 If Len(File3) < 2 Then
		File3 = "/uploads/ImageNotAvailable.jpg"
	End if

	If Len(Filename4) > 2 Then
		File4 =Filename4
	else
		File4= rs("PropImage4")
	End If
	 If Len(File4) < 2 Then
		File4 = "/uploads/ImageNotAvailable.jpg"
	End if

	If Len(Filename5) > 2 Then
		File5 =Filename5
	else
		File5= rs("PropImage5")
	End If
	 If Len(File5) < 2 Then
		File5 = "/uploads/ImageNotAvailable.jpg"
	End if

	If Len(Filename6) > 2 Then
		File6 =Filename6
	else
		File6= rs("PropImage6")
	End If
	 If Len(File6) < 2 Then
		File6 = "/uploads/ImageNotAvailable.jpg"
	End if

	If Len(Filename7) > 2 Then
		File7 =Filename7
	else
		File7= rs("PropImage7")
	End If
	 If Len(File7) < 2 Then
		File7 = "/uploads/ImageNotAvailable.jpg"
	End if

	If Len(Filename8) > 2 Then
		File8 =Filename8
	else
		File8= rs("PropImage8")
	End If
	 If Len(File8) < 2 Then
		File8 = "/uploads/ImageNotAvailable.jpg"
	End if

	     If len(rs("PropCaption1")) > 1 then
   PropCaption1 = rs("PropCaption1")
		End If 
		 If len(rs("PropCaption2")) > 1 then
   PropCaption2 = rs("PropCaption2")
		End If 
		 If len(rs("PropCaption3")) > 1 then
   PropCaption3 = rs("PropCaption3")
		End If 
		 If len(rs("PropCaption4")) > 1 then
   PropCaption4 = rs("PropCaption4")
		End If 
		 If len(rs("PropCaption5")) > 1 then
   PropCaption5 = rs("PropCaption5")
		End If 
		 If len(rs("PropCaption6")) > 1 then
   PropCaption6 = rs("PropCaption6")
		End If 
		 If len(rs("PropCaption7")) > 1 then
   PropCaption7 = rs("PropCaption7")
		End If 
		If len(rs("PropCaption8")) > 1 then
   PropCaption8 = rs("PropCaption8")
		End If 

'response.write(File5)
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



str1 = lcase(File1)
str2 = "uploads"
str3 = "http://"
If Not(InStr(str1,str2) > 0) and Not(InStr(str1,str3) > 0) Then
File1= "http://www.AlpacaInfinity.com/Uploads/" & File1
End If 
str1 = lcase(File2)
str2 = "uploads"
str3 = "http://"
If Not(InStr(str1,str2) > 0) and Not(InStr(str1,str3) > 0) Then
File1= "http://www.AlpacaInfinity.com/Uploads/" & File2
End If 
str1 = lcase(File3)
str2 = "uploads"
str3 = "http://"
If Not(InStr(str1,str2) > 0) and Not(InStr(str1,str3) > 0) Then
File1= "http://www.AlpacaInfinity.com/Uploads/" & File3
End If 
str1 = lcase(File4)
str2 = "uploads"
str3 = "http://"
If Not(InStr(str1,str2) > 0) and Not(InStr(str1,str3) > 0) Then
File1= "http://www.AlpacaInfinity.com/Uploads/" & File4
End If 
str1 = lcase(File5)
str2 = "uploads"
str3 = "http://"
If Not(InStr(str1,str2) > 0) and Not(InStr(str1,str3) > 0) Then
File1= "http://www.AlpacaInfinity.com/Uploads/" & File5
End If 
str1 = lcase(File6)
str2 = "uploads"
str3 = "http://"
If Not(InStr(str1,str2) > 0) and Not(InStr(str1,str3) > 0) Then
File1= "http://www.AlpacaInfinity.com/Uploads/" & File6
End If 
str1 = lcase(File7)
str2 = "uploads"
str3 = "http://"
If Not(InStr(str1,str2) > 0) and Not(InStr(str1,str3) > 0) Then
File1= "http://www.AlpacaInfinity.com/Uploads/" & File7
End If 
str1 = lcase(File8)
str2 = "uploads"
str3 = "http://"
If Not(InStr(str1,str2) > 0) and Not(InStr(str1,str3) > 0) Then
File1= "http://www.AlpacaInfinity.com/Uploads/" & File8
End If 
rs.close
%>
 <table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "<%=screenwidth -20%>" >
<tr><td class = "body" align = "right">
</td>
</td>
<td><H1>Upload Property Photos</H1>			
</td></tr></table>
<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  align = "center"><tr><td class = "body"  valign = "top">
<% sql2 = "select * from Properties where peopleID = " & Session("peopleID") & " order by Propname ;"
'response.write(sql2)
	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	recordcount = rs2.recordcount
	While Not rs2.eof  
		PropIDArray(acounter) = rs2("PropID")
		PropNameArray(acounter) = rs2("PropName")
		'response.write (SSName(studcounter))

		acounter = acounter +1
		rs2.movenext
	Wend		
	
		rs2.close
		set rs2=nothing
		set conn = nothing
If recordcount > 1 then
%>
		<font class = "body">
		<form  action="PropertyPhotos.asp" method = "post" name = "p1">
			<h2>Upload a different Property's Photos</h2>
			Select an animal below and push the edit button to update a different animal's photos:<br>
			  
			  <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
			   <tr>
<td colspan ="30">
	&nbsp;
</td>
 <td class = "body">
	<br>Select one of your Properties:
	<select size="1" name="PropID">
	<option name = "AID0" value= "" selected></option>
	<% count = 1
		while count < acounter
		response.write(count)
	%>
		<option name = "AID1" value="<%=PropIDArray(count)%>">
			<%=PropNameArray(count)%>
		</option>
	<% 	count = count + 1
	wend %>
	</select>
		<div valign = "bottom" align = "center">	
			<a href="javascript:document.p1.submit()" 
onmouseover="document.p1.sub_but.src='images/Editon.jpg'" 
onmouseout="document.p1.sub_but.src='images/Editoff.jpg'" 
onclick="return val_form_this_page()"><img src="images/Editoff.jpg" 
border="0" alt="Submit this form" 
name="sub_but" /></a></div>
</td>
			  </tr>
		    </table>
	 </form>
	 </font>
	<% end if %>
  </td>
		   </tr>
	</table>
 <table Border = "0"  align = "center"  width = "<%=screenwidth - 30 %>" class = "roundedtopandbottom">
		<tr>
			<td colspan = "2">
<h1>Main Image</h1>
			</td>
		</tr>
		<tr>
			<td width = "150" align = "center">
	<img src = "<%=File1%>" height = "100">
	<center><b><%=PropCaption1%></b></center>
			</td>
			<td class = "body">
	<form name="frmSend" method="POST" enctype="multipart/form-data" action="uploadPropPhoto.asp?PropID=<%=PropID %>" >
Upload New Photo: <input name="attach1" type="file" size=35 >
		<input  type=submit value="Upload">
	</form>
<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
		<tr>
			<td  height = "2" width = "700"><img src = "images/px.gif" height = "2"></td>
		</tr>
	</table>
	 <form action= 'AddPropCaption.asp' method = "post">
			Current Caption: <b><%=PropCaption1%></b><br>
			New Caption (11 Character Max.): <input name="Caption" Value =""  size = "10" maxlength = "13">
			<input type = "hidden" name="CaptionID" value= "1" >
			<input type = "hidden" name="PropID" value= "<%= PropID %>" >
			<input type=submit value="Submit">
	</form>
<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
		<tr>
			<td  height = "2" width = "700"><img src = "images/px.gif" height = "2"></td>
		</tr>
	</table>
	<form action= 'RemovePropImage.asp' method = "post">
			Would you like to remove this image? 
			<input type = "hidden" name="ImageID" value= "1" >
			<input type = "hidden" name="PropID" value= "<%= PropID %>" >
			<input type=submit value="Remove This Image">
	</form>
			</td>
		</table>

   <table Border = "0"  align = "center"  width = "<%=screenwidth - 30 %>" class = "roundedtopandbottom">
		<tr>
			<td colspan = "2">
<h1>Image 2</h1>
			</td>
		</tr>
		<tr>
			<td width = "150" align = "center" class = "body">
	<img src = "<%=File2%>" height = "100">
	<center><b><%=PropCaption2%></b></center>
			</td>
			<td class = "body">
	<form name="frmSend" method="POST" enctype="multipart/form-data" action="uploadPropPhoto2.asp?PropID=<%=PropID %>" >
		Upload New Photo: <input name="attach1" type="file" size=35 >
		<input  type=submit value="Upload">
	</form>
	<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
		<tr>
			<td  height = "2" width = "700"><img src = "images/px.gif" height = "2"></td>
		</tr>
	</table>
	 <form action= 'AddPropCaption.asp' method = "post" >
			Current Caption: <b><%=PropCaption2%></b><br>
			New Caption (11 Character Max.): <input name="Caption" Value =""  size = "10" maxlength = "13">
			<input type = "hidden" name="PropID" value= "<%= PropID %>" >
	<input type = "hidden" name="CaptionID" value= "2" >
			<input type=submit value="Submit">
	</form>
		
	<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
		<tr>
			<td  height = "2" width = "700"><img src = "images/px.gif" height = "2"></td>
		</tr>
	</table>
	<form action= 'RemovePropImage.asp' method = "post">
			Would you like to remove this image? 
			<input type = "hidden" name="ImageID" value= "2" >
			<input type = "hidden" name="PropID" value= "<%= PropID %>" >
			<input type=submit value="Remove This Image">
	</form>
			</td>
		</table>
  
   <table Border = "0"  align = "center"  width = "<%=screenwidth - 30 %>" class = "roundedtopandbottom">
		<tr>
			<td colspan = "2">
<h1>Image 3</h1>
			</td>
		</tr>
		<tr>
			<td width = "150" align = "center" class = "body">
	<img src = "<%=File3%>" height = "100">
	<center><b><%=PropCaption3%></b></center>
			</td>
			<td class = "body">
	<form name="frmSend" method="POST" enctype="multipart/form-data" action="uploadPropPhoto3.asp?PropID=<%=PropID %>" >
		Upload New Photo: <input name="attach1" type="file" size=35 >
		<input  type=submit value="Upload">
	</form>
<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
		<tr>
			<td  height = "2" width = "700"><img src = "images/px.gif" height = "2"></td>
		</tr>
	</table>
	 <form action= 'AddPropCaption.asp' method = "post">
			Current Caption: <b><%=PropCaption3%></b><br>
			New Caption (11 Character Max.): <input name="Caption" Value =""  size = "10" maxlength = "13">
			<input type = "hidden" name="PropID" value= "<%= PropID %>" >
<input type = "hidden" name="CaptionID" value= "3" >
			<input type=submit value="Submit">
	</form>
	<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
		<tr>
			<td  height = "2" width = "700"><img src = "images/px.gif" height = "2"></td>
		</tr>
	</table>
	<form action= 'RemovePropImage.asp' method = "post">
			Would you like to remove this image? 
			<input type = "hidden" name="ImageID" value= "3" >
			<input type = "hidden" name="PropID" value= "<%= PropID %>" >
			<input type=submit value="Remove This Image">
	</form>
			</td>
		</table>
  
   <table Border = "0"  align = "center"  width = "<%=screenwidth - 30 %>" class = "roundedtopandbottom">
		<tr>
			<td colspan = "2">
<h1>Image 4</h1>
			</td>
		</tr>
		<tr>
			<td width = "150" align = "center" class = "body">
	<img src = "<%=File4%>" height = "100">
	<center><b><%=PropCaption4%></b></center>
			</td>
			<td class = "body">
	<form name="frmSend" method="POST" enctype="multipart/form-data" action="uploadPropPhoto4.asp?PropID=<%=PropID %>" >
		Upload New Photo: <input name="attach1" type="file" size=35 >
		<input  type=submit value="Upload">
	</form>
<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
		<tr>
			<td  height = "2" width = "700"><img src = "images/px.gif" height = "2"></td>
		</tr>
	</table>
	 <form action= 'AddPropCaption.asp' method = "post">
			Current Caption: <b><%=PropCaption4%></b><br>
			New Caption (11 Character Max.): <input name="Caption" Value =""  size = "10" maxlength = "13">
			<input type = "hidden" name="PropID" value= "<%= PropID %>" >
<input type = "hidden" name="CaptionID" value= "4" >
			<input type=submit value="Submit">
	</form>
	<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
		<tr>
			<td  height = "2" width = "700"><img src = "images/px.gif" height = "2"></td>
		</tr>
	</table>
	<form action= 'RemovePropImage.asp' method = "post">
			Would you like to remove this image? 
			<input type = "hidden" name="ImageID" value= "4" >
			<input type = "hidden" name="PropID" value= "<%= PropID %>" >
			<input type=submit value="Remove This Image">
	</form>
			</td>
		</table>
  
    <table Border = "0"  align = "center"  width = "<%=screenwidth - 30 %>" class = "roundedtopandbottom">
		<tr>
			<td colspan = "2">
<h1>Image 5</h1>
			</td>
		</tr>
		<tr>
			<td width = "150" align = "center" class = "body">
	<img src = "<%=File5%>" height = "100">
	<center><b><%=PropCaption5%></b></center>
			</td>
			<td class = "body">
	<form name="frmSend" method="POST" enctype="multipart/form-data" action="uploadPropPhoto5.asp?PropID=<%=PropID %>" >
		Upload New Photo: <input name="attach1" type="file" size=35 >
		<input  type=submit value="Upload">
	</form>
<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
		<tr>
			<td  height = "2" width = "700"><img src = "images/px.gif" height = "2"></td>
		</tr>
	</table>
	 <form action= 'AddPropCaption.asp' method = "post">
			Current Caption: <b><%=PropCaption5%></b><br>
			New Caption (11 Character Max.): <input name="Caption" Value =""  size = "10" maxlength = "13">
			<input type = "hidden" name="PropID" value= "<%= PropID %>" >
<input type = "hidden" name="CaptionID" value= "5" >
			<input type=submit value="Submit">
	</form>
	<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
		<tr>
			<td  height = "2" width = "700"><img src = "images/px.gif" height = "2"></td>
		</tr>
	</table>
	<form action= 'RemovePropImage.asp' method = "post">
			Would you like to remove this image? 
			<input type = "hidden" name="ImageID" value= "5" >
			<input type = "hidden" name="PropID" value= "<%= PropID %>" >
			<input type=submit value="Remove This Image">
	</form>
			</td>
		</table>
  
   <table Border = "0"  align = "center"  width = "<%=screenwidth - 30 %>" class = "roundedtopandbottom">
		<tr>
			<td colspan = "2">
<h1>Image 6</h1>
			</td>
		</tr>
		<tr>
			<td width = "150" align = "center" class = "body">
	<img src = "<%=File6%>" height = "100">
	<center><b><%=PropCaption6%></b></center>
			</td>
			<td class = "body">
	<form name="frmSend" method="POST" enctype="multipart/form-data" action="uploadPropPhoto6.asp?PropID=<%=PropID %>" >
		Upload New Photo: <input name="attach1" type="file" size=35 >
		<input  type=submit value="Upload">
	</form>
<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
		<tr>
			<td  height = "2" width = "700"><img src = "images/px.gif" height = "2"></td>
		</tr>
	</table>
	 <form action= 'AddPropCaption.asp' method = "post">
			Current Caption: <b><%=PropCaption6%></b><br>
			New Caption (11 Character Max.): <input name="Caption" Value =""  size = "10" maxlength = "13">
			<input type = "hidden" name="PropID" value= "<%= PropID %>" >
<input type = "hidden" name="CaptionID" value= "6" >
			<input type=submit value="Submit">
	</form>
	<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
		<tr>
			<td  height = "2" width = "700"><img src = "images/px.gif" height = "2"></td>
		</tr>
	</table>
	<form action= 'RemovePropImage.asp' method = "post">
			Would you like to remove this image? 
			<input type = "hidden" name="ImageID" value= "6" >
			<input type = "hidden" name="PropID" value= "<%= PropID %>" >
			<input type=submit value="Remove This Image">
	</form>
			</td>
		</table>
  
   <table Border = "0"  align = "center"  width = "<%=screenwidth - 30 %>" class = "roundedtopandbottom">
		<tr>
			<td colspan = "2">
<h1>Image 7</h1>
			</td>
		</tr>
		<tr>
			<td width = "150" align = "center" class = "body">
	<img src = "<%=File7%>" height = "100">
	<center><b><%=PropCaption7%></b></center>
			</td>
			<td class = "body">
	<form name="frmSend" method="POST" enctype="multipart/form-data" action="uploadPropPhoto7.asp?PropID=<%=PropID %>" >
		Upload New Photo: <input name="attach1" type="file" size=35 >
		<input  type=submit value="Upload">
	</form>
<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
		<tr>
			<td  height = "2" width = "700"><img src = "images/px.gif" height = "2"></td>
		</tr>
	</table>
	 <form action= 'AddPropCaption.asp' method = "post">
			Current Caption: <b><%=PropCaption7%></b><br>
			New Caption (11 Character Max.): <input name="Caption" Value =""  size = "10" maxlength = "13">
			<input type = "hidden" name="PropID" value= "<%= PropID %>" >
<input type = "hidden" name="CaptionID" value= "7" >
			<input type=submit value="Submit">
	</form>
<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
		<tr>
			<td  height = "2" width = "700"><img src = "images/px.gif" height = "2"></td>
		</tr>
	</table>
	<form action= 'RemovePropImage.asp' method = "post">
			Would you like to remove this image? 
			<input type = "hidden" name="ImageID" value= "7" >
			<input type = "hidden" name="PropID" value= "<%= PropID %>" >
			<input type=submit value="Remove This Image">
	</form>
	
			</td>
		</table>
  
   <table Border = "0"  align = "center"  width = "<%=screenwidth - 30 %>" class = "roundedtopandbottom">
		<tr>
			<td colspan = "2">
<h1>Image 8</h1>
			</td>
		</tr>
		<tr>
			<td width = "150" align = "center" class = "body">
	<img src = "<%=File8%>" height = "100">
	<center><b><%=PropCaption8%></b></center>
			</td>
			<td class = "body">
	<form name="frmSend" method="POST" enctype="multipart/form-data" action="uploadPropPhoto8.asp?PropID=<%=PropID %>" >
		Upload New Photo: <input name="attach1" type="file" size=35 >
		<input  type=submit value="Upload">
	</form>
<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
		<tr>
			<td  height = "2" width = "700"><img src = "images/px.gif" height = "2"></td>
		</tr>
	</table>
	 <form action= 'AddPropCaption.asp' method = "post">
			Current Caption: <b><%=PropCaption8%></b><br>
		New Caption (11 Character Max.): <input name="Caption" Value =""  size = "10" maxlength = "13">
			<input type = "hidden" name="PropID" value= "<%= PropID %>" >
			<input type = "hidden" name="CaptionID" value= "8" >
			<input type=submit value="Submit">
	</form>
<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
		<tr>
			<td  height = "2" width = "700"><img src = "images/px.gif" height = "2"></td>
		</tr>
	</table>
	
	<form action= 'RemovePropImage.asp' method = "post">
			Would you like to remove this image? 
			<input type = "hidden" name="ImageID" value= "8" >
			<input type = "hidden" name="PropID" value= "<%= PropID %>" >
			<input type=submit value="Remove This Image">
	</form>
			</td>
		</table>
<br> 
<% end if 
End If
%>