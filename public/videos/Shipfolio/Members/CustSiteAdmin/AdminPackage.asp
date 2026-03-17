<!DOCTYPE HTML >
<HTML>
<HEAD>
<link rel="stylesheet" type="text/css" href="style.css">
<!--#Include file="AdminGlobalVariables.asp"--> 
</HEAD>
<% if mobiledevice = True  then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
<% end if %>
<!--#Include file="AdminHeader.asp"--> 
<%
	dim ID(400) 
	dim	Name(400) 
	dim	ForSale(400) 
	dim	ARI(400) 
	dim	DOB(400) 
	dim	Color(400) 
	dim	Category(400) 
	dim	Breed(400) 
	dim	ColorCategory(400) 
	dim	GroupID(400) 
	dim GroupName(400)
	dim PackageID(200)
	dim PackageName(200)
	dim PackagePrice(200)
	dim Description(200)
	dim PackagePhoto(200)
	dim pID(200)
    dim pName(200)

 if mobiledevice = False  then %>
<form action= 'AdminPackageAdd.asp' method = "post">
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>
		<td Class = "body">
			<H2><div align = "left">Add a Package<br>
			<tr>
			    <td bgcolor="ABABAB"> <img src="images/px.gif" height=1 width=1 ></td>
			</tr>
			<tr>
			    <td> <H2><div align = "left">Enter a name of the package and press the submit button.<br><br></td>
			</tr>
		</td>
	</tr>
</table>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
	<tr >
		<th class = "body" >New Package Name</th>
		<th class = "body" >Price</th>
	</tr>
	<tr>
		<td >
			<input name="PackageName" size = "70">
		</td>
		<td >
			&nbsp; <input name="Price" size = "6">&nbsp; 
		</td>
		</tr>
			<td colspan = "2">
				<textarea name="Description" cols="63" rows="8" wrap="VIRTUAL" ></textarea>
			</td>
		</tr>
		<tr>
			<td colspan = "2" align = "center">
			&nbsp; <input type=submit value = "Submit" style="background-image: url('images/background.jpg'); border-width:1px"  Class = "menu" >
		</td>
	</tr>
</table>
</form>


<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>
		<td Class = "body">
			<H2><div align = "left">Edit an Existing Package<br>
			<tr>
			    <td bgcolor="ABABAB"> <img src="images/px.gif" height=1 width=1 ></td>
			</tr>
			<tr>
			    <td <H2><div align = "left">To make changes edit your data and press the submit button.<br><br></td>
			</tr>
		</td>
	</tr>
</table>
<%
conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
 sql = "select * from Package "

response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	rowcount = 1


Recordcount = rs.RecordCount +1
%>
<% if rs.eof  then%>
	<font class = "body"><b>Sorry, currently there are no packages that are available to be edited.</b></font>
	<br><br>
<% else %>

<form action= 'AdminPackageEditHandleForm.asp' method = "post">
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding="0" cellspacing="0">
<tr>
	<th class = "body" >Photo</th>
	<th class = "body"  >Package Name</th>
	<th class = "body"  >Price</th>
	<th class = "body" ></th>
</tr>
<%
 While  Not rs.eof     
	 PackageID(rowcount) =   rs("PackageID")
	 PackageName(rowcount) =   rs("PackageName")
	 PackagePrice(rowcount) =   rs("Price")
	 Description(rowcount) =   rs("Description")
	 PackagePhoto(rowcount) =   rs("PackagePhoto")
%>
	<tr >
	<td width = "150" align = "center">
		<% if len(PackagePhoto(rowcount))> 4 then %>
			<img src = "<%=PackagePhoto(rowcount)%>" width = "100" align = "center"><br>
			<a href = "AdminPackagePhotos.asp?PackageID=<%=PackageID(rowcount)%>" class = "body">Change Image</a>
		<% else %>
		    <img src = "/uploads/ImageNotAvailable.jpg" width = "100" align = "center"><br>
			<a href = "AdminPackagePhotos.asp?PackageID=<%=PackageID(rowcount)%>" class = "body">Change Image</a>

		<% end if %>
	</td>
	<td>
		<input type = "hidden" name="PackageID(<%=rowcount%>)" value= "<%=PackageID(rowcount)%>" >
		<input name="PackageName(<%=rowcount%>)" value= "<%= PackageName(rowcount)%>" size = "70">&nbsp;
		$ <input name="PackagePrice(<%=rowcount%>)" value= "<%= PackagePrice(rowcount)%>" size = "6">&nbsp;<br>
		<textarea name="Description(<%=rowcount%>)" cols="63" rows="8" wrap="VIRTUAL" ><%= Description(rowcount)%></textarea>
	</td>
</tr>
		
<%
		rowcount = rowcount + 1
	   rs.movenext
	Wend
TotalCount=rowcount 
%>
</tr>
			<td colspan = "2" align = "center">
			&nbsp; <input type=submit value = "Submit" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" Class = "menu" >
		</td>
	</tr>
</table>
<Input type = Hidden name='TotalCount' value = <%=TotalCount%> >
</form>
<% end if%>

<br>
<%


conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
 sql = "select * from Package "

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	pcounter = 1
	While Not rs.eof  
		pID(pcounter) = rs("PackageID")
		pName(pcounter) = rs("PackageName")
		'response.write (SSName(studcounter))

		pcounter = pcounter +1
		rs.movenext
	Wend		
%>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>		
	<tr>
		<td Class = "body">
			<H2><div align = "left">Delete a Package<br>
			<tr>
			    <td bgcolor="ABABAB"> <img src="images/px.gif" height=1 width=1 ></td>
			</tr>
			<tr>
			    <td <H2><div align = "left">To delete a package select the package and press the submit button.<br><br></tr>
		</td>
	</tr>
</table>

<% if pcounter = 1  then%>
	<font class = "body"><b>Sorry, currently there are no packages that are available to be deleted.</b></font>
	<br><br>
<% else %>



<form action= 'AdminPackageDelete.asp' method = "post">

<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<td class = "body">
		  <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding="0" cellspacing="0">
	<tr>
		<td class = "body">Package Name</td>
					<th></th>
			   </tr>
			    <tr>
				 <td>
					<select size="1" name="PackageID">
					<option name = "AID0" value= "" selected></option>
					<% count = 1
						while count < pcounter
						response.write(count)
					%>
						<option name = "AID1" value="<%=pID(count)%>">
							<%=pName(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
				</td>
				<td>
					<br>
					<input type=submit value = "Delete" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" class = "menu" >
				</td>
			  </tr>
		    </table>
		  </form>
		</td>
	</tr>
</table>

<% end if 
	   rs.close
	   set rs=nothing
	   set conn = nothing%>




<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>
		<td Class = "body">
			<H2><div align = "left">Adding Animals to a Package<br>
			<tr>
			    <td bgcolor="ABABAB"> <img src="images/px.gif" height=1 width=1 ></td>
			</tr>
				
<%
conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
 sql = "select * from Animals  order by Animals.FullName"

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	rowcount = 1
	



Recordcount = rs.RecordCount +1
%>

<table border = "1" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>
		<th >Full Name</th>
		<th >Package</th>
	
	</tr>
	
<%
 While  Not rs.eof 
	ID(rowcount) =   rs("ID")
	 Name(rowcount) =   rs("FullName")
	 PackageID(rowcount)=   rs("PackageID")
	  
%>

	<form action= 'AdminPackageHandleform.asp' method = "post">
	<tr  >
		
		<td >
			<input type = "hidden" name="ID(<%=rowcount%>)" value= "<%=  ID( rowcount)%>">
		
		    <input name="Name(<%=rowcount%>)" value= "<%= Name( rowcount)%>" size = "30"></td>
			
	<td>

			<% 	rowcount2 = 1

			if rs("PackageID") = 0  then
				tempPackageName = "none"
				tempPackageID =0
			else
			  'response.write(rs("PackageID"))
				sql2 = "select * from Package where PackageID = " & rs("PackageID")
				Set rs2 = Server.CreateObject("ADODB.Recordset")
				rs2.Open sql2, conn, 3, 3   
				if not rs2.eof then
					tempPackageName = rs2("PackageName")
					tempPackageID =rs("PackageID")
				else
					tempPackageName = "none"
					tempPackageID =0
				end if
			end if

			sql2 = "select * from Package order by PackageName"
			Set rs2 = Server.CreateObject("ADODB.Recordset")
			rs2.Open sql2, conn, 3, 3   
	
			While  Not rs2.eof 
				PackageID(rowcount2) =   rs2("PackageID")
				PackageName(rowcount2) =   rs2("PackageName")
				rowcount2 = rowcount2 + 1
				rs2.movenext
			Wend
			TotalCount2=rowcount2 
			%>

				<select size="1" name="PackageID(<%=rowcount%>)" size = "20">
					<option name = "PackageID0" value= "<%=tempPackageID%>" selected size = "20"><%=tempPackageName%></option>
					<option name = "PackageID1" value="0" size = "20">none</option>
					<% count = 1
						while count < TotalCount2
						'response.write(TotalCount2)
					%>
						<option name = "PackageID2" value="<%=PackageID(count)%>" size = "20">
							<%=PackageName(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
			</td>
		</tr>
<%
		rowcount = rowcount + 1
	   rs.movenext
	Wend
TotalCount=rowcount 
	rs.close
  set rs=nothing
  set conn = nothing
%>

<tr>
		<td colspan = "16" align = "center" valign = "middle">
			<Input type = Hidden name='TotalCount' value = <%=TotalCount%> >
			<Input type = Hidden name='Page' value = "Packages" >
			<input type=submit value = "Submit Changes" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" class = "menu" >
			</form>
		</td>
</tr>
</table>
			<br><br>
		</td>
	</tr>
</table>
<% else %>
<form action= 'AdminPackageAdd.asp' method = "post">
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>
		<td Class = "body">
			<H2><div align = "left">Add a Package<br>
			<tr>
			    <td bgcolor="ABABAB"> <img src="images/px.gif" height=1 width=1 ></td>
			</tr>
			<tr>
			    <td <H2><div align = "left">Enter a name of the package and press the submit button.<br><br></td>
			</tr>
		</td>
	</tr>
</table>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
	<tr >
		<th class = "body" >New Package Name</th>
		<th class = "body" >Price</th>
	</tr>
	<tr>
		<td >
			<input name="PackageName" size = "70">
		</td>
		<td >
			&nbsp; <input name="Price" size = "6">&nbsp; 
		</td>
		</tr>
			<td colspan = "2">
				<textarea name="Description" cols="63" rows="8" wrap="VIRTUAL" ></textarea>
			</td>
		</tr>
		<tr>
			<td colspan = "2" align = "center">
			&nbsp; <input type=submit value = "Submit" style="background-image: url('images/background.jpg'); border-width:1px"  Class = "menu" >
		</td>
	</tr>
</table>
</form>


<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>
		<td Class = "body">
			<H2><div align = "left">Edit an Existing Package<br>
			<tr>
			    <td bgcolor="ABABAB"> <img src="images/px.gif" height=1 width=1 ></td>
			</tr>
			<tr>
			    <td <H2><div align = "left">To make changes edit your data and press the submit button.<br><br></td>
			</tr>
		</td>
	</tr>
</table>
<%
conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
 sql = "select * from Package "

response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	rowcount = 1


Recordcount = rs.RecordCount +1
%>
<% if rs.eof  then%>
	<font class = "body"><b>Sorry, currently there are no packages that are available to be edited.</b></font>
	<br><br>
<% else %>






<form action= 'AdminPackageEditHandleForm.asp' method = "post">
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding="0" cellspacing="0"  width = "100%">
	<tr >
	<td width = "100%" >
<%
 While  Not rs.eof     
	 PackageID(rowcount) =   rs("PackageID")
	 PackageName(rowcount) =   rs("PackageName")
	 PackagePrice(rowcount) =   rs("Price")
	 Description(rowcount) =   rs("Description")
	 PackagePhoto(rowcount) =   rs("PackagePhoto")
%>

		<% if len(PackagePhoto(rowcount))> 4 then %>
			<img src = "<%=PackagePhoto(rowcount)%>" width = "100" align = "center"><br>
			<a href = "AdminPackagePhotos.asp?PackageID=<%=PackageID(rowcount)%>" class = "body">Change Image</a>
		<% else %>
		    <img src = "/uploads/ImageNotAvailable.jpg" width = "100" align = "center"><br>
			<a href = "AdminPackagePhotos.asp?PackageID=<%=PackageID(rowcount)%>" class = "body">Change Image</a>

		<% end if %>

		<input type = "hidden" name="PackageID(<%=rowcount%>)" value= "<%=PackageID(rowcount)%>" >
		<input name="PackageName(<%=rowcount%>)" value= "<%= PackageName(rowcount)%>" size = "70">&nbsp;
		$ <input name="PackagePrice(<%=rowcount%>)" value= "<%= PackagePrice(rowcount)%>" size = "6">&nbsp;<br>
		<textarea name="Description(<%=rowcount%>)" cols="63" rows="8" wrap="VIRTUAL" ><%= Description(rowcount)%></textarea>

<%
		rowcount = rowcount + 1
	   rs.movenext
	Wend
TotalCount=rowcount 
%>

			&nbsp; <input type=submit value = "Submit" Class = "regsubmit2 body" >

<Input type = Hidden name='TotalCount' value = <%=TotalCount%> >
</form><br>
<% end if%>


<%


conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
 sql = "select * from Package "

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	pcounter = 1
	While Not rs.eof  
		pID(pcounter) = rs("PackageID")
		pName(pcounter) = rs("PackageName")
		'response.write (SSName(studcounter))

		pcounter = pcounter +1
		rs.movenext
	Wend		
%>

			<H2><div align = "left">Delete a Package<br>
			

<% if pcounter = 1  then%>
	<font class = "body"><b>Sorry, currently there are no packages that are available to be deleted.</b></font>
	<br><br>
<% else %>

<form action= 'AdminPackageDelete.asp' method = "post">

Package Name<br>
					<select size="1" name="PackageID" class = "regsubmit2 class">
					<option name = "AID0" value= "" selected></option>
					<% count = 1
						while count < pcounter
						response.write(count)
					%>
						<option name = "AID1" value="<%=pID(count)%>">
							<%=pName(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
					<br>
					<input type=submit value = "Delete" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" class = "menu" >
</form>


<% end if 
	   rs.close
	   set rs=nothing
	   set conn = nothing%>

<H2><div align = "left">Adding Animals to a Package<br>
				
<%
conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
 sql = "select * from Animals  order by Animals.FullName"

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	rowcount = 1

Recordcount = rs.RecordCount +1

 While  Not rs.eof 
	ID(rowcount) =   rs("ID")
	 Name(rowcount) =   rs("FullName")
	 PackageID(rowcount)=   rs("PackageID")
	  
%>

	<form action= 'AdminPackageHandleform.asp' method = "post">
			<input type = "hidden" name="ID(<%=rowcount%>)" value= "<%=  ID( rowcount)%>">
		
		    <input name="Name(<%=rowcount%>)" value= "<%= Name( rowcount)%>" size = "30">

			<% 	rowcount2 = 1

			if rs("PackageID") = 0  then
				tempPackageName = "none"
				tempPackageID =0
			else
			  'response.write(rs("PackageID"))
				sql2 = "select * from Package where PackageID = " & rs("PackageID")
				Set rs2 = Server.CreateObject("ADODB.Recordset")
				rs2.Open sql2, conn, 3, 3   
				if not rs2.eof then
					tempPackageName = rs2("PackageName")
					tempPackageID =rs("PackageID")
				else
					tempPackageName = "none"
					tempPackageID =0
				end if
			end if

			sql2 = "select * from Package order by PackageName"
			Set rs2 = Server.CreateObject("ADODB.Recordset")
			rs2.Open sql2, conn, 3, 3   
	
			While  Not rs2.eof 
				PackageID(rowcount2) =   rs2("PackageID")
				PackageName(rowcount2) =   rs2("PackageName")
				rowcount2 = rowcount2 + 1
				rs2.movenext
			Wend
			TotalCount2=rowcount2 
			%>

				<select size="1" name="PackageID(<%=rowcount%>)" size = "20" class = "regsubmit2 body">
					<option name = "PackageID0" value= "<%=tempPackageID%>" selected size = "20"><%=tempPackageName%></option>
					<option name = "PackageID1" value="0" size = "20">none</option>
					<% count = 1
						while count < TotalCount2
						'response.write(TotalCount2)
					%>
						<option name = "PackageID2" value="<%=PackageID(count)%>" size = "20">
							<%=PackageName(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>

<%
		rowcount = rowcount + 1
	   rs.movenext
	Wend
TotalCount=rowcount 
	rs.close
  set rs=nothing
  set conn = nothing
%>

			<Input type = Hidden name='TotalCount' value = <%=TotalCount%> >
			<Input type = Hidden name='Page' value = "Packages" >
			<input type=submit value = "Submit Changes" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" class = "menu" >
			</form>

			<br><br>
		</td>
	</tr>
</table>



<% end if %>
</BODY>
</HTML>