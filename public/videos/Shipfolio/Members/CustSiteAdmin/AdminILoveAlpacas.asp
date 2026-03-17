<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
<HEAD>
 <title>Upload & Associate I Love Alpacas Photos</title>
             <link rel="stylesheet" type="text/css" href="style.css">


</HEAD>

<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  background = "images/background.jpg">

<!--#Include virtual="/Administration/Header.asp"--> 


<table leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>
<td width = "4000" align = "center">

		<H3><b>Upload Image</b> (Same as the Detail Page Images)</H3>
			<p><font face="Verdana, Arial, Helvetica, sans-serif" size="2"></font></p>
			<p><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2" color="#FF0000">only gif and jpg formats</font><br>
			</p>
			</center>
			
			<form ENCTYPE="multipart/form-data" ACTION="<%=WebSiteAddress%>/cgi-bin/uploadDetail.cgi" METHOD="POST"><center>
<input TYPE="FILE" NAME="file-to-upload-01" SIZE="35">
<p>
<input TYPE="SUBMIT" VALUE="Upload Now!">
    <p> <font size="1" face="Verdana, Arial, Helvetica, sans-serif">After clicking 
      &quot;Upload Now&quot; it may take a short while to send your image.</font><br>
</center>
</form>
			
			
			
			
			
		</td>
		
	</tr>
</table>
<table leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>
		<td class = "body">
			 <a name="Associate"></a><H2>Associate Images
			<img src = "images/underline.jpg"></H2>

		</td>
	</tr>
</table>

<%  
dim aID(40000)
dim aName(40000)
Dim acounter
	conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" 
	sql2 = "select Animals.ID, Animals.FullName from Animals order by Animals.FullName" 


	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	

	While Not rs2.eof  
		aID(acounter) = rs2("ID")
		aName(acounter) = rs2("FullName")
		'response.write (SSName(studcounter))

		acounter = acounter +1
		rs2.movenext
	Wend		
	
		rs2.close
		set rs2=nothing
		set conn = nothing



%>




<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
<tr>
		<td>
			<H3>Images (Large) </H3>
			<%
			Dim DFileName(40000)

			set fs=Server.CreateObject("Scripting.FileSystemObject")
			set fo=fs.GetFolder(PhysicalPath & "\\Uploads\\DetailPage"  )
			pcount = 1
			for each x in fo.files
			  DFileName(pcount) = x.Name
			  ' Response.write(DFileName(pcount) & "<br />")
			pcount = pcount + 1
			next
			set fo=nothing
			set fs=nothing
			%>

			<form action= 'AddPhotoshandleform.asp' method = "post">
				<input type = "hidden" name="PhotoType" value= "ILoveAlpacas">
			   <table border = "1" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
			   <tr>
				 <td valign = "top">
					<input  type = "hidden"name = "AID" value="2000">


					<b>Photo</b><br>
					<select size="1" name="Photo">
					<option name = "PhotoName" value= "" selected></option>
					<% count = 1
						while count < pcount
						response.write(count)
					%>
						<option name = "PhotoName" value="<%=DFileName(count)%>">
							<%=DFileName(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
				</td>
				<td valign = "top">	<b>Image Title</b><br>
						<input  name="Title" value= "" >
				</td>
				<td valign = "top"><b>Image Description</b><br>
						<textarea name="ImageDescription" cols="33" rows="4" wrap="VIRTUAL" ></textarea>
				</td>
				</tr>
				<tr>
				<td align = "center">
						<input type=Submit value = "Submit Changes" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" class = "menu" >
				</td>
			  </tr>
		    </table>
		  </form>
		</td>
	</tr>
	

<%	

dim dID(40000)
dim dName(40000)
dim dPhotoID(40000)
dim	dImage(40000)
dim	dImageOrder(40000)
dim	dImageTitle(40000)


conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" 
	sqld = "select * from AdditionalPhotos where ID = 2000 ORDER by Image ASC"

	dcounter = 1
	Set rsd = Server.CreateObject("ADODB.Recordset")
	rsd.Open sqld, conn, 3, 3 
	While Not rsd.eof  
		dID(dcounter) = rsd("ID")
		dPhotoID(dcounter) = rsd("PhotoID")
		dImage(dcounter) = rsd("Image")
		dImageOrder(dcounter) = rsd("PhotoOrder")
		dImageTitle(dcounter) = rsd("ImageTitle")
		'response.write (rsd("AdditionalPhotos.ID"))

		dcounter = dcounter +1
		rsd.movenext
	Wend		
	
		rsd.close
		set rsd=nothing
		set conn = nothing



%>


	<tr>
		<td nowrap class = "body">
			<H3>Current Photos</H3>
			<form action= 'kimPhotoOrder.asp' method = "post">	
				<table border = "1">
				<tr>
						   <td class = "body" align = "center">
							<b>PhotoID</b>
							</td>
							<td class = "body" align = "center">
								<b>Image</b>
							</td>
							<td class = "body" align = "center">
								<b>Order</b>
							</td>
						</tr>
					<% count = 1
						while count < dcounter  %>
						<tr>
							<td class = "body">
								<input name="PID(<%=count%>)" value= "<%= dPhotoID(count)%>" type = "hidden"><big><%=dPhotoID(count)%></big>
							</td>
							<td class = "body">
							<%=dImage(count)%>
							</td>
							<td class = "body">
							<select size="1" name="Order(<%=count%>)">
								<option name = "Order1" value= "<% = dImageOrder(count)%>" selected><% =  dImageOrder(count)%></option>
								<% i = 0
								While i <  dcounter 
								   I = I +1 %>
								<option name = "<%=i%>" value="<%=i%>"><%=i%></option>
								
							<% Wend %>
					</select>
							</td>
						</tr>
					<% 	count = count + 1
					wend %>
					<input name="TotalCount" value= "<%= count%>" type = "hidden">
			<tr>
		<td colspan = "4" align = "center" valign = "middle">
			
			<Input type = Hidden name='TotalCount' value = <%=TotalCount%> >
			<input type=submit value = "Submit Changes" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" class = "menu" >
			</form>
		</td>
</tr>
</table>
						
<H3>Unassociate Detail Page Photos</H3>
			<form action= 'DeleteKimAdditionalPhotos.asp' method = "post">
				<input type = "hidden" name="PhotoType" value= "AdditionalPhotos">
			   <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
			   <tr>
				 <td nowrap class = "body">
					<b>PhotoID</b><br>
					<select size="1" name="PhotoID">
					<option name = "PhotoID0" value= "" selected></option>
					<% count = 1
						while count < dcounter
						response.write(count)
					%>
						<option name = "PhotoID1" value="<%=dPhotoID(count)%>">
							<%=dPhotoID(count)%> - <%=dName(count)%> - <%=dImage(count)%>
							</option>
					<% 	count = count + 1
					wend %>
					</select>
				</td>
							
				<td nowrap class = "body">
					<br>
					<input type=submit value = "Un-Associate" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" class = "menu" >
				</td>
			  </tr>
		    </table>
		  </form>
		</td>
	</tr>
</table>
<br><br>
</BODY>
</HTML>