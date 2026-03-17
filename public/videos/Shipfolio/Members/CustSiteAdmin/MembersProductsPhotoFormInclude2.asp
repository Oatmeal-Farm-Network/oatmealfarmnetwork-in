
<% 
Dim prodNameArray(20000)
sql2 = "select ProdID, ProdName from sfProducts  where PeopleID = " & session("PeopleID") & " order by Prodname"
'response.write(sql2)
	acounter = 1
Set rs2 = Server.CreateObject("ADODB.Recordset")
Set rs = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, connloa, 3, 3 
	
	While Not rs2.eof  
		IDArray(acounter) = rs2("ProdID")
		prodNameArray(acounter) = rs2("ProdName")
		'response.write (SSName(studcounter))
		acounter = acounter +1
		rs2.movenext
Wend		
	
rs2.close
set rs2=nothing%>
<!--#Include virtual="/connloa.asp"-->
<%
redirect = false
			
sql = "select * from ProductsPhotos where id = " & prodID
'response.write("sql=" & sql )
rs.Open sql, connloa, 3, 3

If rs.eof Then
	redirect =true
	Query =  "INSERT INTO ProductsPhotos (ID)" 
	Query =  Query & " Values (" &  prodID & ")"

connloa.Execute(Query) 
connloa.close
set connloa=nothing 
%>
<!--#Include virtual="/connloa.asp"-->
<%
			
End If 
if rs.state = 0 then
else
rs.close
end if 

sql = "select * from sfProducts where prodid = " & prodID & ""
rs.Open sql, connloa, 3, 3
If rs.eof Then
	redirect =true
	Query =  "INSERT INTO sfProducts (prodID)" 
	Query =  Query & " Values (" &  prodID & ")"

connloa.Execute(Query) 
connloa.close
set connloa=nothing 
%>
<!--#Include virtual="/connloa.asp"-->
<%
			
End If 
rs.close

If  redirect =True then
	response.redirect("membersProductPhotos.asp?prodid="&prodID)
End if
sql = "select * from sfProducts, ProductsPhotos where sfProducts.prodid = ProductsPhotos.ID and ProductsPhotos.ID = " & prodID
rs.Open sql, connloa, 3, 3
If Not rs.eof Then
ProdName2 = rs("prodName")
End If

If Len(rs("ProductImage1")) > 2 Then
File1= rs("ProductImage1")
'response.write(sql)
else
File1 = "/uploads/ImageNotAvailable.jpg"
End If

If Len(rs("ProductImage2")) > 2 Then
File2= rs("ProductImage2")
else
File2 = "/uploads/ImageNotAvailable.jpg"
End If

If Len(rs("ProductImage3")) > 2 Then
File3= rs("ProductImage3")

else
File3 = "/uploads/ImageNotAvailable.jpg"
End If

If Len(rs("ProductImage4")) > 2 Then
File4= rs("ProductImage4")

else
File4 = "/uploads/ImageNotAvailable.jpg"
End If

If Len(rs("ProductImage5")) > 2 Then
File5= rs("ProductImage5")

else
File5 = "/uploads/ImageNotAvailable.jpg"
End If


If Len(rs("ProductImage6")) > 2 Then
File6= rs("ProductImage6")

else
File6 = "/uploads/ImageNotAvailable.jpg"
End If

	If Len(rs("ProductImage7")) > 2 Then
File7= rs("ProductImage7")

else
File7 = "/uploads/ImageNotAvailable.jpg"
End If

If Len(rs("ProductImage8")) > 2 Then
File8= rs("ProductImage8")
	
else
File8 = "/uploads/ImageNotAvailable.jpg"
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
rs.close
%>
	<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = <%=screenwidth - 42 %>><tr><td  align = "left" class = roundedtopandbottom>
		<H1>Upload Product Photos for <%=ProdName2%></H1>

<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "<%=screenwidth - 42 %>" align = "center">
<tr><td class = "body" >
<%  sql2 = "select ProdID, ProdName from sfProducts where PeopleID = " & session("AIID") & "  order by Prodname"
'response.write(sql2)
	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, connloa, 3, 3 
	
	While Not rs2.eof  
		IDArray(acounter) = rs2("prodID")
		prodNameArray(acounter) = rs2("prodName")
		'response.write (SSName(studcounter))

		acounter = acounter +1
		rs2.movenext
	Wend		
	
		rs2.close
		set rs2=nothing
		set connloa = nothing
%>
		<font class = "body">
		<form  action="membersProductPhotos.asp" method = "post">
			<h2>Select Another Product</h2>
			Select an product below and push the edit button to update an product's photos:<br>
			  
			  <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
			   <tr>
<td colspan ="30">
&nbsp;
</td>
 <td class = "body">
<br>Select one of your Products:
<select size="1" name="ID">
<option name = "AID0" value= "" selected></option>
<% count = 1
while count < acounter
'response.write(count)
%>
<option name = "AID1" value="<%=IDArray(count)%>">
	<%=prodNameArray(count)%>
</option>
<% 	count = count + 1
wend %>
</select>
<input type=submit value = "Edit"  class = "regsubmit2" >
</td>
			  </tr>
		    </table>
	 </form>
	 </font>
	 		</td>
	  </tr>
 </table>
<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "<%=screenwidth - 42 %>" align = "center">
  <tr><td>
	<div align = "right"><!--#Include file="MembersProductsPhotoJumpLinks.asp"--> </div>
</td>
</tr>
</table>
<a name="1"></a>
<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "<%=screenwidth - 42 %>" align = "center">
		<tr>
			<td class = "body" >
<table border = "0" cellspacing="0" cellpadding = "0" align = "center"  class = roundedtopandbottom ><tr><td  align = "left">
		<H2><div align = "left">Main Image</div></H2>
   <table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "<%=screenwidth - 42 %>" align = "center">
		<tr>
			<td width = "150" align = "center">
<img src = "<%=File1%>" height = "100">
<center><b><%=PhotoCaption1%></b></center>
			</td>
			<td class = "body">
<form name="frmSend" method="POST" enctype="multipart/form-data" action="membersProductUploadPhoto.asp?ProdID=<%=ProdID %>&ImageNum=1" >
<b>Upload Photo</b><br />
<input name="attach1" type="file" size=55 class = "formbox">
<input  type=submit value="Upload" class = "regsubmit2">
</form>
<% if len(File1) > 4 and not File1="/uploads/ImageNotAvailable.jpg" then%>
<center><br><form action= 'membersProductsRemoveImage.asp' method = "post">
	<input type = "hidden" name="ImageID" value= "1" >
	<input type = "hidden" name="ProdID" value= "<%= ProdID %>" >
	<input type=submit value="Remove This Image" class = "regsubmit2"></center>
</form>
<% end if %>
            </td>
           </tr>
	</table>

	</td>
           </tr>
	</table>
<a name="2"></a>	
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" class = roundedtopandbottom><tr><td " align = "left">
		<H2><div align = "left">Image 2</div></H2>
<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "<%=screenwidth - 42 %>" align = "center" >

		<tr>
			<td width = "150" align = "center">
<img src = "<%=File2%>" height = "100">
<center><b><%=PhotoCaption2%></b></center>
			</td>
			<td class = "body">
<form name="frmSend" method="POST" enctype="multipart/form-data" action="membersProductUploadPhoto.asp?ProdID=<%=ProdID %>&ImageNum=2" >
<b>Upload Photo</b><br />
<input name="attach2" type="file" size=55 class = "formbox">
<input  type=submit value="Upload" class = "regsubmit2">
</form>
<% if len(File2) > 4 and not File2="/uploads/ImageNotAvailable.jpg" then%>
<center><br><form action= 'membersProductsRemoveImage.asp' method = "post">
	<input type = "hidden" name="ImageID" value= "2" >
	<input type = "hidden" name="ProdID" value= "<%= ProdID %>" >
	<input type=submit value="Remove This Image" class = "regsubmit2"></center>
</form>
<% end if %>
            </td>
           </tr>
	</table>
</td></tr></table>
<a name="3"></a>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" class = roundedtopandbottom ><tr><td align = "left">
		<H2><div align = "left">Image 3</div></H2>

<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "<%=screenwidth - 42 %>" align = "center">
		<tr>
			<td width = "150" align = "center">
<img src = "<%=File3%>" height = "100">
<center><b><%=PhotoCaption3%></b></center>
			</td>
			<td class = "body">
<form name="frmSend" method="POST" enctype="multipart/form-data" action="membersProductUploadPhoto.asp?ProdID=<%=ProdID %>&ImageNum=3" >
<b>Upload Photo</b><br />
<input name="attach3" type="file" size=55 class = "formbox">
<input  type=submit value="Upload" class = "regsubmit2">
</form>
<% if len(File3) > 4 and not File3="/uploads/ImageNotAvailable.jpg" then%>
<center><br><form action= 'membersProductsRemoveImage.asp' method = "post">
	<input type = "hidden" name="ImageID" value= "3" >
	<input type = "hidden" name="ProdID" value= "<%= ProdID %>" >
	<input type=submit value="Remove This Image" class = "regsubmit2"></center>
</form>
<% end if %>
            </td>
           </tr>
	</table>
	</td>
           </tr>
	</table>
<a name="4"></a>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" class = roundedtopandbottom><tr><td align = "left">
		<H2><div align = "left">Image 4</div></H2>
<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "<%=screenwidth - 42 %>" align = "center">

		<tr>
			<td width = "150" align = "center">
<img src = "<%=File4%>" height = "100">
<center><b><%=PhotoCaption4%></b></center>
			</td>
			<td class = "body">
<form name="frmSend" method="POST" enctype="multipart/form-data" action="membersProductUploadPhoto.asp?ProdID=<%=ProdID %>&ImageNum=4" >
<b>Upload Photo</b><br />
<input name="attach4" type="file" size=55 class = "formbox">
<input  type=submit value="Upload" class = "regsubmit2">
</form>
<% if len(File4) > 4 and not File4="/uploads/ImageNotAvailable.jpg" then%>
<center><br><form action= 'membersProductsRemoveImage.asp' method = "post">
	<input type = "hidden" name="ImageID" value= "4" >
	<input type = "hidden" name="ProdID" value= "<%= ProdID %>" >
	<input type=submit value="Remove This Image" class = "regsubmit2"></center>
</form>
<% end if %>
            </td>
           </tr>
	</table>
</td><tr></table>
<a name="5"></a>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" class = roundedtopandbottom><tr><td align = "left">
		<H2><div align = "left">Image 5</div></H2>
<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "<%=screenwidth - 42 %>" align = "center">
	<tr>
			<td width = "150" align = "center">
<img src = "<%=File5%>" height = "100">
<center><b><%=PhotoCaption5%></b></center>
			</td>
			<td class = "body">
<form name="frmSend" method="POST" enctype="multipart/form-data" action="membersProductUploadPhoto.asp?ProdID=<%=ProdID %>&ImageNum=5" >
<b>Upload Photo</b><br />
<input name="attach5" type="file" size=55 class = "formbox">
<input  type=submit value="Upload" class = "regsubmit2">
</form>
<% if len(File5) > 4 and not File5="/uploads/ImageNotAvailable.jpg" then%>
<center><br><form action= 'membersProductsRemoveImage.asp' method = "post">
	<input type = "hidden" name="ImageID" value= "5" >
	<input type = "hidden" name="ProdID" value= "<%= ProdID %>" >
	<input type=submit value="Remove This Image" class = "regsubmit2"></center>
</form>
<% end if %>
            </td>
           </tr>
	</table>
 </td>
           </tr>
	</table>
<a name="6"></a>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" class = roundedtopandbottom><tr><td align = "left">
		<H2><div align = "left">Image 6</div></H2>
<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "<%=screenwidth - 42 %>" align = "center">
		<tr>
			<td width = "150" align = "center">
<img src = "<%=File6%>" height = "100">
<center><b><%=PhotoCaption6%></b></center>
			</td>
			<td class = "body">
<form name="frmSend" method="POST" enctype="multipart/form-data" action="membersProductUploadPhoto.asp?ProdID=<%=ProdID %>&ImageNum=6" >
<b>Upload Photo</b><br />
<input name="attach6" type="file" size=55 class = "formbox">
<input  type=submit value="Upload" class = "regsubmit2">
</form>
<% if len(File6) > 4 and not File6="/uploads/ImageNotAvailable.jpg" then%>
<center><br><form action= 'membersProductsRemoveImage.asp' method = "post">
	<input type = "hidden" name="ImageID" value= "6" >
	<input type = "hidden" name="ProdID" value= "<%= ProdID %>" >
	<input type=submit value="Remove This Image" class = "regsubmit2"></center>
</form>
<% end if %>
            </td>
           </tr>
	</table>

    	</td>
			</tr>
		</table> 
<a name="7"></a>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" class = roundedtopandbottom><tr><td align = "left">
		<H2><div align = "left">Image 7</div></H2>
<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "<%=screenwidth - 42 %>" align = "center">
		<tr>
			<td width = "150" align = "center">
<img src = "<%=File7%>" height = "100">
<center><b><%=PhotoCaption7%></b></center>
			</td>
			<td class = "body">
<form name="frmSend" method="POST" enctype="multipart/form-data" action="membersProductUploadPhoto.asp?ProdID=<%=ProdID %>&ImageNum=7" >
<b>Upload Photo</b><br />
<input name="attach7" type="file" size=55 class = "formbox">
<input  type=submit value="Upload" class = "regsubmit2">
</form>
<% if len(File7) > 4 and not File7="/uploads/ImageNotAvailable.jpg" then%>
<center><br><form action= 'membersProductsRemoveImage.asp' method = "post">
	<input type = "hidden" name="ImageID" value= "7" >
	<input type = "hidden" name="ProdID" value= "<%= ProdID %>" >
	<input type=submit value="Remove This Image" class = "regsubmit2"></center>
</form>
<% end if %>
            </td>
           </tr>
	</table>
 </td></tr></table>
<a name="8"></a>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" class = roundedtopandbottom><tr><td align = "left">
		<H2><div align = "left">Image 8</div></H2>
<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "<%=screenwidth - 42 %>" align = "center">
		<tr>
			<td width = "150" align = "center">
<img src = "<%=File8%>" height = "100">
<center><b><%=PhotoCaption8%></b></center>
			</td>
			<td class = "body">
<form name="frmSend" method="POST" enctype="multipart/form-data" action="membersProductUploadPhoto.asp?ProdID=<%=ProdID %>&ImageNum=8" >
<b>Upload Photo</b><br />
<input name="attach8" type="file" size=55 class = "formbox">
<input  type=submit value="Upload" class = "regsubmit2">
</form>
<% if len(File8) > 4 and not File8="/uploads/ImageNotAvailable.jpg" then%>
<center><br><form action= 'membersProductsRemoveImage.asp' method = "post">
	<input type = "hidden" name="ImageID" value= "8" >
	<input type = "hidden" name="ProdID" value= "<%= ProdID %>" >
	<input type=submit value="Remove This Image" class = "regsubmit2"></center>
</form>
<% end if %>
            </td>
           </tr>
	</table>
  	 <br>
    <br>
</td></tr></table>