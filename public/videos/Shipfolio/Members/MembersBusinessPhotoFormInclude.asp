<%
sql = "select * from BusinessForSale where BFSID = " & BFSID
rs.Open sql, conn, 3, 3

If rs.eof Then
Query =  "INSERT INTO BusinessForSale (BFSID)" 
Query =  Query & " Values (" &  BFSID & ")"
Set DataConnection = Server.CreateObject("ADODB.Connection")
DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 
DataConnection.Execute(Query) 
rs.close

sql = "select * from BusinessForSale where BFSID = " & BFSID
'response.write("sql=" sql)
rs.Open sql, conn, 3, 3
End If 
If Len(Filename) > 2 Then
		File1 =Filename
	else
		File1= rs("BFSImage1")
	End If
	 If Len(File1) > 2 Then
     else
		File1 = "/uploads/ImageNotAvailable.jpg"
	End if

	If Len(Filename2) > 2 Then
		File2 =Filename2
	else
		File2= rs("BFSImage2")
	End If
	 If Len(File2) > 2 Then
     else
		File2 = "/uploads/ImageNotAvailable.jpg"
	End if

	If Len(Filename3) > 2 Then
		File3 =Filename3
	else
		File3= rs("BFSImage3")
	End If
	 If Len(File3)  >  2 Then
     else
		File3 = "/uploads/ImageNotAvailable.jpg"
	End if

	If Len(Filename4) > 2 Then
		File4 =Filename4
	else
		File4= rs("BFSImage4")
	End If
	 If Len(File4) > 2 Then
     else
		File4 = "/uploads/ImageNotAvailable.jpg"
	End if

	If Len(Filename5) > 2 Then
		File5 =Filename5
	else
		File5= rs("BFSImage5")
	End If
	 If Len(File5) > 2 Then
     else
		File5 = "/uploads/ImageNotAvailable.jpg"
	End if

	If Len(Filename6) > 2 Then
		File6 =Filename6
	else
		File6= rs("BFSImage6")
	End If
	 If Len(File6) > 2 Then
     else
		File6 = "/uploads/ImageNotAvailable.jpg"
	End if

	If Len(Filename7) > 2 Then
		File7 =Filename7
	else
		File7= rs("BFSImage7")
	End If
	 If Len(File7) > 2 Then
     else
		File7 = "/uploads/ImageNotAvailable.jpg"
	End if

	If Len(Filename8) > 2 Then
		File8 =Filename8
	else
		File8= rs("BFSImage8")
	End If
	 If Len(File8) > 2 Then
     else
		File8 = "/uploads/ImageNotAvailable.jpg"
	End if

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
<td><H1>Upload Business Photos</H1>			
</td></tr></table>
<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  align = "center"><tr><td class = "body"  valign = "top">
<% sql2 = "select * from BusinessForSale where peopleID = " & Session("peopleID") & " order by BFSname ;"
'response.write(sql2)
	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	recordcount = rs2.recordcount
	While Not rs2.eof  
		BFSIDArray(acounter) = rs2("BFSID")
		BFSNameArray(acounter) = rs2("BFSName")
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
		<form  action="MembersBusinessPhotos.asp" method = "post" name = "p1">
			<h2>Upload a different business's Photos</h2>
			Select an business below and push the edit button to update a different business's photos:<br>
			  
			  <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
			   <tr>
<td colspan ="30">
	&nbsp;
</td>
 <td class = "body">
	<br>Select one of your businesses:
	<select size="1" name="BFSID">
	<option name = "AID0" value= "" selected></option>
	<% count = 1
		while count < acounter
		response.write(count)
	%>
		<option name = "AID1" value="<%=BFSIDArray(count)%>">
			<%=BFSNameArray(count)%>
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
			</td>
			<td class = "body">
	<form name="frmSend" method="POST" enctype="multipart/form-data" action="uploadBusinessPhoto.asp?BFSID=<%=BFSID %>&ID=1" >
Upload New Photo: <input name="attach1" type="file" size=35 >
		<input  type=submit value="Upload">
	</form>
	<form action= 'RemoveBusinessImage.asp' method = "post">
			Would you like to remove this image? 
			<input type = "hidden" name="ImageID" value= "1" >
			<input type = "hidden" name="BFSID" value= "<%= BFSID %>" >
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
	<center><b><%=BFSCaption2%></b></center>
			</td>
			<td class = "body">
	<form name="frmSend" method="POST" enctype="multipart/form-data" action="uploadBusinessPhoto.asp?BFSID=<%=BFSID %>&ID=2" >
		Upload New Photo: <input name="attach1" type="file" size=35 >
		<input  type=submit value="Upload">
	</form>

	<form action= 'RemoveBusinessImage.asp' method = "post">
			Would you like to remove this image? 
			<input type = "hidden" name="ImageID" value= "2" >
			<input type = "hidden" name="BFSID" value= "<%= BFSID %>" >
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
	<center><b><%=BFSCaption3%></b></center>
			</td>
			<td class = "body">
	<form name="frmSend" method="POST" enctype="multipart/form-data" action="uploadBusinessPhoto.asp?BFSID=<%=BFSID %>&ID=3" >
		Upload New Photo: <input name="attach1" type="file" size=35 >
		<input  type=submit value="Upload">
	</form>
	<form action= 'RemoveBusinessImage.asp' method = "post">
			Would you like to remove this image? 
			<input type = "hidden" name="ImageID" value= "3" >
			<input type = "hidden" name="BFSID" value= "<%= BFSID %>" >
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
	<center><b><%=BFSCaption4%></b></center>
			</td>
			<td class = "body">
	<form name="frmSend" method="POST" enctype="multipart/form-data" action="uploadBusinessPhoto.asp?BFSID=<%=BFSID %>&ID=4" >
		Upload New Photo: <input name="attach1" type="file" size=35 >
		<input  type=submit value="Upload">
	</form>
	<form action= 'RemoveBusinessImage.asp' method = "post">
			Would you like to remove this image? 
			<input type = "hidden" name="ImageID" value= "4" >
			<input type = "hidden" name="BFSID" value= "<%= BFSID %>" >
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
	<center><b><%=BFSCaption5%></b></center>
			</td>
			<td class = "body">
	<form name="frmSend" method="POST" enctype="multipart/form-data" action="uploadBusinessPhoto.asp?BFSID=<%=BFSID %>&ID=5" >
		Upload New Photo: <input name="attach1" type="file" size=35 >
		<input  type=submit value="Upload">
	</form>
	<form action= 'RemoveBusinessImage.asp' method = "post">
			Would you like to remove this image? 
			<input type = "hidden" name="ImageID" value= "5" >
			<input type = "hidden" name="BFSID" value= "<%= BFSID %>" >
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
	<center><b><%=BFSCaption6%></b></center>
			</td>
			<td class = "body">
	<form name="frmSend" method="POST" enctype="multipart/form-data" action="uploadBusinessPhoto.asp?BFSID=<%=BFSID %>&ID=6" >
		Upload New Photo: <input name="attach1" type="file" size=35 >
		<input  type=submit value="Upload">
	</form>
	<form action= 'RemoveBusinessImage.asp' method = "post">
			Would you like to remove this image? 
			<input type = "hidden" name="ImageID" value= "6" >
			<input type = "hidden" name="BFSID" value= "<%= BFSID %>" >
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
	<center><b><%=BFSCaption7%></b></center>
			</td>
			<td class = "body">
	<form name="frmSend" method="POST" enctype="multipart/form-data" action="uploadBusinessPhoto.asp?BFSID=<%=BFSID %>&ID=7" >
		Upload New Photo: <input name="attach1" type="file" size=35 >
		<input  type=submit value="Upload">
	</form>
	<form action= 'RemoveBusinessImage.asp' method = "post">
			Would you like to remove this image? 
			<input type = "hidden" name="ImageID" value= "7" >
			<input type = "hidden" name="BFSID" value= "<%= BFSID %>" >
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
	<center><b><%=BFSCaption8%></b></center>
			</td>
			<td class = "body">
	<form name="frmSend" method="POST" enctype="multipart/form-data" action="uploadBusinessPhoto.asp?BFSID=<%=BFSID %>&ID=8" >
		Upload New Photo: <input name="attach1" type="file" size=35 >
		<input  type=submit value="Upload">
	</form>
	<form action= 'RemoveBusinessImage.asp' method = "post">
			Would you like to remove this image? 
			<input type = "hidden" name="ImageID" value= "8" >
			<input type = "hidden" name="BFSID" value= "<%= BFSID %>" >
			<input type=submit value="Remove This Image">
	</form>
			</td>
		</table>
<br> 