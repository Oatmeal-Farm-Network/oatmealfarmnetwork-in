<% 
Dim IDArray(20000)
Dim prodNameArray(20000)
conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
			"Data Source=" & server.mappath(DatabasePath) & ";" & _
			"User Id=;Password=;" '& _ 
Set rs = Server.CreateObject("ADODB.Recordset")

sql2 = "select ProdID, ProdName from sfProducts  where PeopleID = " & session("PeopleID") & " order by Prodname"
'response.write(sql2)
	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	
	While Not rs2.eof  
		IDArray(acounter) = rs2("ProdID")
		prodNameArray(acounter) = rs2("ProdName")
		'response.write (SSName(studcounter))
		acounter = acounter +1
		rs2.movenext
Wend		
	
rs2.close
set rs2=nothing
redirect = false
			
sql = "select * from ProductsPhotos where id = " & prodID
rs.Open sql, conn, 3, 3

If rs.eof Then
	redirect =true
	Query =  "INSERT INTO ProductsPhotos (ID)" 
	Query =  Query & " Values (" &  prodID & ")"
Set DataConnection = Server.CreateObject("ADODB.Connection")
DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 
DataConnection.Execute(Query) 
			
End If 
rs.close

sql = "select * from sfProducts where prodid = " & prodID & ""
rs.Open sql, conn, 3, 3
If rs.eof Then
	redirect =true
	Query =  "INSERT INTO sfProducts (prodID)" 
	Query =  Query & " Values (" &  prodID & ")"

Set DataConnection = Server.CreateObject("ADODB.Connection")
DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 
DataConnection.Execute(Query) 
			
End If 
rs.close

If  redirect =True then
	response.redirect("AdminProductsPhotosUpload.asp?prodid="&prodID)
End if
sql = "select * from sfProducts, ProductsPhotos where cint(sfProducts.prodid) = ProductsPhotos.ID and ProductsPhotos.ID = " & prodID
				'response.write(sql)
				rs.Open sql, conn, 3, 3
				If Not rs.eof Then
						'response.write("prodname = " & rs("prodName"))
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
	<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Upload Product Photos for <%=ProdName2%></div></H2>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" width = "960"  height = "200" valign = "top">
        
        
<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "910" align = "center">
		<tr>
			<td class = "body" >

<%  	conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" 
	sql2 = "select * from sfProducts order by Prodname ;"
'response.write(sql2)
	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	
	While Not rs2.eof  
		IDArray(acounter) = rs2("prodID")
		prodNameArray(acounter) = rs2("prodName")
		'response.write (SSName(studcounter))

		acounter = acounter +1
		rs2.movenext
	Wend		
	
		rs2.close
		set rs2=nothing
		set conn = nothing
%>
		<font class = "body">
		<form  action="AdminProductPhotos.asp" method = "post">
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
<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "870" align = "center">
  <tr><td>
	<div align = "right"><!--#Include file="AdminProductsPhotoJumpLinks.asp"--> </div>

</td>
</tr>
</table>
	 <table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "910" align = "center">
		<tr>
			<td class = "body" >
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Photo 1</div></H2>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center">
   <table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "900" align = "center">
		<tr>
			<td width = "150" align = "center">
					<img src = "<%=File1%>" height = "100">
					<center><b><%=PhotoCaption1%></b></center>
			</td>
			<td class = "body">
					<form name="frmSend" method="POST" enctype="multipart/form-data" action="AdminProductUploadPhoto.asp?ProdID=<%=ProdID %>&ImageNum=1" >
						Upload Photo: <input name="attach1" type="file" size=55 class = "regsubmit2">
						<input  type=submit value="Upload" class = "regsubmit2">
					</form>
					<% if len(File1) > 4 and not File1="/uploads/ImageNotAvailable.jpg" then%>
						<form action= 'AdminProductsRemoveImage.asp' method = "post">
							<input type = "hidden" name="ImageID" value= "1" >
							<input type = "hidden" name="ProdID" value= "<%= ProdID %>" >
							<input type=submit value="Remove This Photo" class = "regsubmit2">
					</form>
					<% end if %>

                    <%if len(File1) > 0 and not(File1 = "/uploads/ImageNotAvailable.jpg") then %>
<form action= 'AdminProductsPhotoChangeOrder1.asp' method = "post">
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

<% end if %>

            </td>
           </tr>
	</table>
    <i>Note: This photo will randomly be used on product category and subcategory pages, as well on your product page.</i>
	</td>
           </tr>
	</table>
	
	
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Photo 2</div></H2>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center">
<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "900" align = "center">

		<tr>
			<td width = "150" align = "center">
					<img src = "<%=File2%>" height = "100">
					<center><b><%=PhotoCaption2%></b></center>
			</td>
			<td class = "body">
					<form name="frmSend" method="POST" enctype="multipart/form-data" action="AdminProductUploadPhoto.asp?ProdID=<%=ProdID %>&ImageNum=2" >
						Upload Photo: <input name="attach2" type="file" size=55 class = "regsubmit2">
						<input  type=submit value="Upload" class = "regsubmit2">
					</form>
					<% if len(File2) > 4 and not File2="/uploads/ImageNotAvailable.jpg" then%>
						<form action= 'AdminProductsRemoveImage.asp' method = "post">
							<input type = "hidden" name="ImageID" value= "2" >
							<input type = "hidden" name="ProdID" value= "<%= ProdID %>" >
							<input type=submit value="Remove This Photo" class = "regsubmit2">
					</form>
					<% end if %>
                    

<%
acounter = 2
tempfilename = File2
imagenum= acounter
ID = ProdID


if len(tempfilename) > 0 and not(tempfilename = "/uploads/ImageNotAvailable.jpg") then %>
<form action= 'AdminProductsPhotoChangeOrder1.asp' method = "post">
<input type = "hidden" name="CurrentPhoto" value= "<%=imagenum %>" >
<input type = "hidden" name="ID" value= "<%= ID %>" >
Photo Order:	
<select size="1" name="PhotoOrder">
<option value="<%=imagenum %>" selected><%=imagenum %></option>
<% for porder = 1 to 8 %> 
<% if not(porder = imagenum) then %>
<option  value="<%=porder%> "><%=porder%></option>
<% end if %>
<% next %>
</select>
<input type=submit value="Submit" class="regsubmit2">
</form>


<% end if %>

            </td>
           </tr>
	</table>

	</td>
           </tr>
	</table>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Photo 3</div></H2>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center">
<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "900" align = "center">
		<tr>
			<td width = "150" align = "center">
					<img src = "<%=File3%>" height = "100">
					<center><b><%=PhotoCaption3%></b></center>
			</td>
			<td class = "body">
					<form name="frmSend" method="POST" enctype="multipart/form-data" action="AdminProductUploadPhoto.asp?ProdID=<%=ProdID %>&ImageNum=3" >
						Upload Photo: <input name="attach3" type="file" size=55 class = "regsubmit2">
						<input  type=submit value="Upload" class = "regsubmit2">
					</form>
					<% if len(File3) > 4 and not File3="/uploads/ImageNotAvailable.jpg" then%>
						<form action= 'AdminProductsRemoveImage.asp' method = "post">
							<input type = "hidden" name="ImageID" value= "3" >
							<input type = "hidden" name="ProdID" value= "<%= ProdID %>" >
							<input type=submit value="Remove This Photo" class = "regsubmit2">
					</form>
					<% end if %>


<%
acounter = 3
tempfilename = File3
imagenum= acounter
ID = ProdID


if len(tempfilename) > 0 and not(tempfilename = "/uploads/ImageNotAvailable.jpg") then %>
<form action= 'AdminProductsPhotoChangeOrder1.asp' method = "post">
<input type = "hidden" name="CurrentPhoto" value= "<%=imagenum %>" >
<input type = "hidden" name="ID" value= "<%= ID %>" >
Photo Order:	
<select size="1" name="PhotoOrder">
<option value="<%=imagenum %>" selected><%=imagenum %></option>
<% for porder = 1 to 8 %> 
<% if not(porder = imagenum) then %>
<option  value="<%=porder%> "><%=porder%></option>
<% end if %>
<% next %>
</select>
<input type=submit value="Submit" class="regsubmit2">
</form>


<% end if %>
            </td>
           </tr>
	</table>
	</td>
           </tr>
	</table>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Photo 4</div></H2>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center">
<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "900" align = "center">

		<tr>
			<td width = "150" align = "center">
					<img src = "<%=File4%>" height = "100">
					<center><b><%=PhotoCaption4%></b></center>
			</td>
			<td class = "body">
					<form name="frmSend" method="POST" enctype="multipart/form-data" action="AdminProductUploadPhoto.asp?ProdID=<%=ProdID %>&ImageNum=4" >
						Upload Photo: <input name="attach4" type="file" size=55 class = "regsubmit2">
						<input  type=submit value="Upload" class = "regsubmit2">
					</form>
					<% if len(File4) > 4 and not File4="/uploads/ImageNotAvailable.jpg" then%>
						<form action= 'AdminProductsRemoveImage.asp' method = "post">
							<input type = "hidden" name="ImageID" value= "4" >
							<input type = "hidden" name="ProdID" value= "<%= ProdID %>" >
							<input type=submit value="Remove This Photo" class = "regsubmit2">
					</form>
					<% end if %>

                    
<%
acounter = 4
tempfilename = File4
imagenum= acounter
ID = ProdID


if len(tempfilename) > 0 and not(tempfilename = "/uploads/ImageNotAvailable.jpg") then %>
<form action= 'AdminProductsPhotoChangeOrder1.asp' method = "post">
<input type = "hidden" name="CurrentPhoto" value= "<%=imagenum %>" >
<input type = "hidden" name="ID" value= "<%= ID %>" >
Photo Order:	
<select size="1" name="PhotoOrder">
<option value="<%=imagenum %>" selected><%=imagenum %></option>
<% for porder = 1 to 8 %> 
<% if not(porder = imagenum) then %>
<option  value="<%=porder%> "><%=porder%></option>
<% end if %>
<% next %>
</select>
<input type=submit value="Submit" class="regsubmit2">
</form>


<% end if %>


            </td>
           </tr>
	</table>
</td><tr></table>

<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Photo 5</div></H2>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center">
<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "900" align = "center">
	<tr>
			<td width = "150" align = "center">
					<img src = "<%=File5%>" height = "100">
					<center><b><%=PhotoCaption5%></b></center>
			</td>
			<td class = "body">
				<form name="frmSend" method="POST" enctype="multipart/form-data" action="AdminProductUploadPhoto.asp?ProdID=<%=ProdID %>&ImageNum=5" >
						Upload Photo: <input name="attach5" type="file" size=55 class = "regsubmit2">
						<input  type=submit value="Upload" class = "regsubmit2">
					</form>
					<% if len(File5) > 4 and not File5="/uploads/ImageNotAvailable.jpg" then%>
						<form action= 'AdminProductsRemoveImage.asp' method = "post">
							<input type = "hidden" name="ImageID" value= "5" >
							<input type = "hidden" name="ProdID" value= "<%= ProdID %>" >
							<input type=submit value="Remove This Photo" class = "regsubmit2">
					</form>
					<% end if %>

                    
<%
acounter = 5
tempfilename = File5
imagenum= acounter
ID = ProdID


if len(tempfilename) > 0 and not(tempfilename = "/uploads/ImageNotAvailable.jpg") then %>
<form action= 'AdminProductsPhotoChangeOrder1.asp' method = "post">
<input type = "hidden" name="CurrentPhoto" value= "<%=imagenum %>" >
<input type = "hidden" name="ID" value= "<%= ID %>" >
Photo Order:	
<select size="1" name="PhotoOrder">
<option value="<%=imagenum %>" selected><%=imagenum %></option>
<% for porder = 1 to 8 %> 
<% if not(porder = imagenum) then %>
<option  value="<%=porder%> "><%=porder%></option>
<% end if %>
<% next %>
</select>
<input type=submit value="Submit" class="regsubmit2">
</form>

<% end if %>
            </td>
           </tr>
	</table>
 </td>
           </tr>
	</table>


<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Photo 6</div></H2>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center">
<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "900" align = "center">
		<tr>
			<td width = "150" align = "center">
					<img src = "<%=File6%>" height = "100">
					<center><b><%=PhotoCaption6%></b></center>
			</td>
			<td class = "body">
					<form name="frmSend" method="POST" enctype="multipart/form-data" action="AdminProductUploadPhoto.asp?ProdID=<%=ProdID %>&ImageNum=6" >
						Upload Photo: <input name="attach6" type="file" size=55 class = "regsubmit2">
						<input  type=submit value="Upload" class = "regsubmit2">
					</form>
					<% if len(File6) > 4 and not File6="/uploads/ImageNotAvailable.jpg" then%>
						<form action= 'AdminProductsRemoveImage.asp' method = "post">
							<input type = "hidden" name="ImageID" value= "6" >
							<input type = "hidden" name="ProdID" value= "<%= ProdID %>" >
							<input type=submit value="Remove This Photo" class = "regsubmit2">
					</form>
					<% end if %>

                    
<%
acounter = 6
tempfilename = File6
imagenum= acounter
ID = ProdID


if len(tempfilename) > 0 and not(tempfilename = "/uploads/ImageNotAvailable.jpg") then %>
<form action= 'AdminProductsPhotoChangeOrder1.asp' method = "post">
<input type = "hidden" name="CurrentPhoto" value= "<%=imagenum %>" >
<input type = "hidden" name="ID" value= "<%= ID %>" >
Photo Order:	
<select size="1" name="PhotoOrder">
<option value="<%=imagenum %>" selected><%=imagenum %></option>
<% for porder = 1 to 8 %> 
<% if not(porder = imagenum) then %>
<option  value="<%=porder%> "><%=porder%></option>
<% end if %>
<% next %>
</select>
<input type=submit value="Submit" class="regsubmit2">
</form>

<% end if %>
            </td>
           </tr>
	</table>

  		</td>
			</tr>
		</table>  </td>
			</tr>
		</table>
       
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Photo 7</div></H2>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center">
<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "900" align = "center">
		<tr>
			<td width = "150" align = "center">
					<img src = "<%=File7%>" height = "100">
					<center><b><%=PhotoCaption7%></b></center>
			</td>
			<td class = "body">
					<form name="frmSend" method="POST" enctype="multipart/form-data" action="AdminProductUploadPhoto.asp?ProdID=<%=ProdID %>&ImageNum=7" >
						Upload Photo: <input name="attach6" type="file" size=55 class = "regsubmit2">
						<input  type=submit value="Upload" class = "regsubmit2">
					</form>
					<% if len(File7) > 4 and not File7="/uploads/ImageNotAvailable.jpg" then%>
						<form action= 'AdminProductsRemoveImage.asp' method = "post">
							<input type = "hidden" name="ImageID" value= "7" >
							<input type = "hidden" name="ProdID" value= "<%= ProdID %>" >
							<input type=submit value="Remove This Photo" class = "regsubmit2">
					</form>
					<% end if %>

                    
<%
acounter = 7
tempfilename = File7
imagenum= acounter
ID = ProdID


if len(tempfilename) > 0 and not(tempfilename = "/uploads/ImageNotAvailable.jpg") then %>
<form action= 'AdminProductsPhotoChangeOrder1.asp' method = "post">
<input type = "hidden" name="CurrentPhoto" value= "<%=imagenum %>" >
<input type = "hidden" name="ID" value= "<%= ID %>" >
Photo Order:	
<select size="1" name="PhotoOrder">
<option value="<%=imagenum %>" selected><%=imagenum %></option>
<% for porder = 1 to 8 %> 
<% if not(porder = imagenum) then %>
<option  value="<%=porder%> "><%=porder%></option>
<% end if %>
<% next %>
</select>
<input type=submit value="Submit" class="regsubmit2">
</form>

<% end if %>
            </td>
           </tr>
	</table>

  		</td>
			</tr>
		</table> 
        
           
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Photo 8</div></H2>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center">
<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "900" align = "center">
		<tr>
			<td width = "150" align = "center">
					<img src = "<%=File8%>" height = "100">
					<center><b><%=PhotoCaption8%></b></center>
			</td>
			<td class = "body">
					<form name="frmSend" method="POST" enctype="multipart/form-data" action="AdminProductUploadPhoto.asp?ProdID=<%=ProdID %>&ImageNum=8" >
						Upload Photo: <input name="attach8" type="file" size=55 class = "regsubmit2">
						<input  type=submit value="Upload" class = "regsubmit2">
					</form>
					<% if len(File8) > 4 and not File8="/uploads/ImageNotAvailable.jpg" then%>
						<form action= 'AdminProductsRemoveImage.asp' method = "post">
							<input type = "hidden" name="ImageID" value= "8" >
							<input type = "hidden" name="ProdID" value= "<%= ProdID %>" >
							<input type=submit value="Remove This Photo" class = "regsubmit2">
					</form>
					<% end if %>

                    
<%
acounter = 8
tempfilename = File8
imagenum= acounter
ID = ProdID


if len(tempfilename) > 0 and not(tempfilename = "/uploads/ImageNotAvailable.jpg") then %>
<form action= 'AdminProductsPhotoChangeOrder1.asp' method = "post">
<input type = "hidden" name="CurrentPhoto" value= "<%=imagenum %>" >
<input type = "hidden" name="ID" value= "<%= ID %>" >
Photo Order:	
<select size="1" name="PhotoOrder">
<option value="<%=imagenum %>" selected><%=imagenum %></option>
<% for porder = 1 to 8 %> 
<% if not(porder = imagenum) then %>
<option  value="<%=porder%> "><%=porder%></option>
<% end if %>
<% next %>
</select>
<input type=submit value="Submit" class="regsubmit2">
</form>


<% end if %>
            </td>
           </tr>
	</table>

  		</td>
			</tr>
		</table> 
 </td>
			</tr>
		</table>
