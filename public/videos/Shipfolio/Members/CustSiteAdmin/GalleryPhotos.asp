<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
<HEAD>
 <title>Gallery Photos Page</title>
       <link rel="stylesheet" type="text/css" href="/administration/style.css">

<script>
var bResize	= false;
var cResize	= false;
function Clear() {
	try {
		document.selection.empty();
	} catch(err) {}
}

function Resize() {
	try{
		oObj	= document.getElementById(cell)
		oObjT	= document.all(cell+"T")
		if (event.button != 1) {bResize=false; cell=''; return;}
		if (bResize) {
			Clear();
			for(var i=0; i<oObjT.length; i++){
				oObjT(i).style.width=event.clientX-oObj.offsetLeft+document.body.scrollLeft-4;
			}
		}
	} catch(err) {}
	event.returnValue	= false;
}

function doFocus(obj) {
	obj.className	= 'inputfocus';
	obj.	= false;
	if (obj.createTextRange) {
		var v = obj.value;
		var r = obj.createTextRange();
		r.moveStart('character', v.length);
		r.select();
	}
}

function doBlur(obj) {
	obj.className	= 'inputblur';
	obj.	= true;
}

document.onmousemove	= Resize;
</script>

</HEAD>

<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">

<!--#Include virtual="/administration/Header.asp"--> 


<table leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>
		<td class = "body">
			 <H2>Step 1: Create a Gallery Page
			<img src = "images/underline.jpg"></H2>
			Enter a page title, description, and then select the button below to create a new blank Gallery Page . <br><br>



<form action= 'GalleryCreatePage.asp' method = "post">
			   <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
			   <tr>
				<td nowrap class = "body" valign = "top">
					<b>Page Title</b><br>
					<input name="PageTitle" size = "45">
				</td>
					<td nowrap class = "body">
					<b>Descriptive Text</b><br>
					<textarea name="Description" cols="60" rows="8" wrap="VIRTUAL" ></textarea>
				</td>
			</tr>
			<tr>
				<td nowrap class = "body" colspan = "2">
					<center>
				<input TYPE="SUBMIT" VALUE="A a new Gallery Page">
   
				</center>
				</td>
			  </tr>
		    </table>
		  </form>
		</td>
	</tr>
</table>
<table leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
<tr>
		<td nowrap class = "body">
			<H3>Current Pages </H3>
				
				<table border = "0">
				<tr>
						   <td class = "body" align = "center">
							<b>Page</b>
							</td>
							<td align = "center" class = "body">
							<b>Title</b>
							</td>
							<td class = "body" align = "center">
								<b>Description</b>
							</td>
						</tr>
						<form action= 'GalleryHeadingsEditData.asp' method = "post">
					<% conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
							"Data Source=" & server.mappath("../../db/AlpacaDB.mdb") & ";" & _
								"User Id=;Password=;" 
								sqlH = "select * from GalleryHeadings  ORDER by PageID"

								Set rsH = Server.CreateObject("ADODB.Recordset")
								rsH.Open sqlH, conn, 3, 3 
								counter = 1
								While Not rsH.eof  
									 %>
						<tr>
								<input name="GalleryHeading(<%=counter%>)" value= "<%=rsH("GalleryHeadingID")%>" type = "hidden">
						<td class = "body" valign = "top">
								<input name="PageID(<%=counter%>)" value= "<%=rsH("PageID")%>" size = "4">
						</td>
						<td class = "body" valign = "top">
								<input name="Title(<%=counter%>)" value= "<%=rsH("Title")%>" size = "4">
							</td>
							<td class = "body" valign = "top">
								<textarea name="Description(<%=counter%>)" cols="70" rows="5" wrap="VIRTUAL"><%=rsH("Description")%></textarea>
							</td>
						</tr>
					<% 	
					counter = counter +1
					rsH.movenext
					wend 
					rsH.close
					set rsH=nothing
					TotalCount = counter

				%>
<tr>
		<td colspan = "16" align = "center" valign = "middle">
			<img src = "images/underline.jpg"><br>
			<Input type = Hidden name='TotalCount' value = <%=TotalCount%> >
			<input type=submit value = "Submit Changes" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" class = "menu" >
			</form>
		</td>
</tr>
</table>


<table leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>
		<td class = "body">
			 <H2>Step 2: Upload Gallery Photos
			<img src = "images/underline.jpg"></H2>
			Before you can associate an image with a gallery page you have to copy it up to the server first. <br><br>
			Two important things to remember about photos:
				1. Their names cannot have spaces in them (i.e. Alpacasinthemist.jpg is fine but Alpacas in the mist.jpg is not.)
				2. Always compress your photos otherwise they will slow your site down.
		</td>
	</tr>
</table>
<table leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>
		<td width = "400" align = "center" valign = "top">
		<H3>Small Gallery Images</H3>
		These images hould be one of the three:<br>
				1. 251 pixels X 163 pixels<br>
				2. 163 pixels X 251 pixels<br>
				3. 251 pixels X 251 pixels<br>
		
			<p><font face="Verdana, Arial, Helvetica, sans-serif" size="2"></font></p>
			<p><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2" color="#FF0000">only gif and jpg formats</font><br>
			</p>
			</center>
			
			<form ENCTYPE="multipart/form-data" ACTION="http://www.swallowridgealpacas.com/cgi-bin/uploadGalleryL.cgi" METHOD="POST"><center>
<input TYPE="FILE" NAME="file-to-upload-01" SIZE="35">
<p>
<input TYPE="SUBMIT" VALUE="Upload Now!">
    <p> <font size="1" face="Verdana, Arial, Helvetica, sans-serif">After clicking 
      &quot;Upload Now&quot; it may take a short while to send your image.</font><br>
</center>
</form>

		</td>
		<td width = "400" align = "center" valign = "top">
		<H3>Large Gallery Images</H3>
			These images can be any size you like but I recomend that the width be less than 700 pixels.

			<p><font face="Verdana, Arial, Helvetica, sans-serif" size="2"></font></p>
			<p><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2" color="#FF0000">only gif and jpg formats</font><br>
			</p>
			</center>
			
			<form ENCTYPE="multipart/form-data" ACTION="http://www.swallowridgealpacas.com/cgi-bin/uploadGallery.cgi" METHOD="POST"><center>
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
			 <H2>Step 3: Associate Photos
			<img src = "images/underline.jpg"></H2>
			After your images have been uploaded to your server they need to be associate with your Gallery Pages. Use the tools below to associate images & text with the gallery pages on your site.<br>
		</td>
	</tr>
</table>

<% 

Dim PageID(40)

conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
		"Data Source=" & server.mappath("../../db/AlpacaDB.mdb") & ";" & _
						"User Id=;Password=;" 
	sql2 = "select Distinct PageID from GalleryPhotos order by PageID"

	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	
	While Not rs2.eof  
		PageID(acounter) = rs2("PageID")
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
		<td nowrap class = "body">
			
			<%
			dim AFileName(200)
			set fs=Server.CreateObject("Scripting.FileSystemObject")
			set fo=fs.GetFolder("E:\\Inetpub\\wwwroot\\virtual\\ruckliss\\swallowridgealpacas.com\\www\\uploads\\GalleryPages")
			pcount = 1
			for each x in fo.files
			  AFileName(pcount) = x.Name
			  ' Response.write(AFileName(pcount) & "<br />")
			pcount = pcount + 1
			next
			set fo=nothing
			set fs=nothing


			dim AFileNameL(200)
			set fs=Server.CreateObject("Scripting.FileSystemObject")
			set fo=fs.GetFolder("E:\\Inetpub\\wwwroot\\virtual\\ruckliss\\swallowridgealpacas.com\\www\\uploads\\GalleryPagesL")
			pcount = 1
			for each x in fo.files
			  AFileNameL(pcount) = x.Name
			  ' Response.write(AFileName(pcount) & "<br />")
			pcount = pcount + 1
			next
			set fo=nothing
			set fs=nothing

			%>

			<form action= 'AddGalleryPhotoshandleform.asp' method = "post">
				<input type = "hidden" name="PhotoType" value= "AdditionalPhotos">
			   <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
			   <tr>
				 <td nowrap class = "body"  align = "center">
					<b>Page</b><br>
					<select size="1" name="PageID">
					<option name = "PageID0" value= "" selected></option>
					<% count = 1
						while count < acounter
						response.write(count)
					%>
						<option name = "AID1" value="<%=PageID(count)%>">
							<%=PageID(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
				</td>
				 <td nowrap class = "body" align = "center">
					<b>Location</b><br>
					<select size="1" name="PhotoLocation">
					<option name = "PhotoLocation1" value= "0" ></option>
					<option name = "PhotoLocation2" value= "1" >1</option>
					<option name = "PhotoLocation3" value= "2" >2</option>
					<option name = "PhotoLocation4" value= "3" >3</option>
					<option name = "PhotoLocation5" value= "4" >4</option>
					<option name = "PhotoLocation6" value= "5" >5</option>
					</select>
				</td>
				
				<td nowrap class = "body">
					<b>Small Photo</b><br>
					<select size="1" name="PhotoL">
					<option name = "PhotoNameL" value= "" selected></option>
					<% count = 1
						while count < pcount
						response.write(count)
					%>
						<option name = "PhotoName" value="<%=AFileNameL(count)%>">
							<%=AFileNameL(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
				</td>
				<td nowrap class = "body">
					<b>Large Photo</b><br>
					<select size="1" name="Photo">
					<option name = "PhotoName" value= "" selected></option>
					<% count = 1
						while count < pcount
						response.write(count)
					%>
						<option name = "PhotoName" value="<%=AFileName(count)%>">
							<%=AFileName(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
				</td>
				<td nowrap class = "body" width = "120" align = "center">
					<b>Shape</b><br>
					<select size="1" name="Shape">
					<option name = "Shape1" value= "Square" ></option>
					<option name = "Shape2" value= "Landscape Oval" >Landscape Oval</option>
					<option name = "Shape3" value= "Portrait Oval" >Portrait Oval</option>
					<option name = "Shape4" value= "Circle" >Circle</option>
					<option name = "Shape5" value= "Rectangle" >Rectangle</option>
					</select>
				</td>
				<td nowrap class = "body">
					<b>Caption</b><br>
					<input name="Title" size = "45">
				</td>
			</tr>
			<tr>
				<td nowrap class = "body" colspan = "5" align = "center">
					<br>
					<input type=submit value = "Submit Changes" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" class = "menu" >
				</td>
			  </tr>
		    </table>
		  </form>
		  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src = "images/Locations.jpg"><br><br>
		</td>
		
<%	
dim pPhotoID(100)
dim pPageID(100)
dim pLocation(100)
dim	pPhoto(100)
dim	pPhotoL(100)
dim	Shape(100)
dim	pCaption(100)

conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath("../../db/AlpacaDB.mdb") & ";" & _
						"User Id=;Password=;" 
	sqld = "select * from GalleryPhotos  ORDER by PageID"

	dcounter = 1
	Set rsd = Server.CreateObject("ADODB.Recordset")
	rsd.Open sqld, conn, 3, 3 
	While Not rsd.eof  
		pPhotoID(dcounter) = rsd("GalleryPhotoID")
		pPageID(dcounter) = rsd("PageID")
		pLocation(dcounter) = rsd("Location")
		pPhoto(dcounter) = rsd("Photo")
		pPhotoL(dcounter) = rsd("PhotoL")
		Shape(dcounter) = rsd("Shape")
		pCaption(dcounter) = rsd("Caption")

		dcounter = dcounter +1
		rsd.movenext
	Wend		
	
		rsd.close
		set rsd=nothing
		set conn = nothing



%></tr>
</table>
<table leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>
		<td class = "body">
			 <H2>Step 4: Maintenance
			<img src = "images/underline.jpg"></H2>
			Below you can review all of your photos, delete photos, and even delete whole pages.<br>
		</td>
	</tr>
</table>


	<tr>
		<td nowrap class = "body">
			<H3>Current Gallery Photos </H3>
				
				<table border = "0">
				<tr>
							<td class = "body" align = "center" width = "5">
							<b>Photo</b>
							</td>
						   <td class = "body" align = "center">
							<b>PageID</b>
							</td>
							<td align = "center" class = "body">
							<b>Location</b>
							</td>
							<td class = "body" align = "center">
								<b>Small Photo</b>
							</td>
							<td class = "body" align = "center">
								<b>Large Photo</b>
							</td>
							<td class = "body" align = "center">
								<b>Shape</b>
							</td>
							<td class = "body" align = "center">
								<b>Caption</b>
							</td>
						</tr>
						<form action= 'GalleryEditData.asp' method = "post">
					<% count = 1
						while count < dcounter  %>
						<tr>
						<td class = "body">
								<input name="pPhotoID(<%=count %>)" value= "<%=pPhotoID(count)%>" type = "hidden"><%=pPhotoID(count)%>
						</td>
						<td class = "body">
								<input name="pPageID(<%=count %>)" value= "<%=pPageID(count)%>" size = "4">
						</td>
						<td class = "body">
									<select size="1" name="pLocation(<%=count %>)">
					<option name = "PhotoLocation1" value= "<%=pLocation(count)%>" ><%=pLocation(count)%></option>
					<option name = "PhotoLocation2" value= "1" >1</option>
					<option name = "PhotoLocation3" value= "2" >2</option>
					<option name = "PhotoLocation4" value= "3" >3</option>
					<option name = "PhotoLocation5" value= "4" >4</option>
					<option name = "PhotoLocation6" value= "5" >5</option>
					</select>



							</td>
							<td nowrap class = "body">
					<select size="1" name="PhotoL(<%=count %>)">
					<option name = "PhotoNameL" value= "<%=pPhotoL(count)%>" selected><%=pPhotoL(count)%></option>
					<% count2 = 1
						while count2 < pcount
					%>
						<option name = "PhotoNameL" value="<%=AFileNameL(count2)%>">
							<%=AFileNameL(count2)%>
						</option>
					<% 	count2 = count2 + 1
					wend %>
					</select>
				</td>
				<td nowrap class = "body">
					<select size="1" name="Photo(<%=count %>)">
					<option name = "PhotoName" value= "<%=pPhoto(count)%>" selected><%=pPhoto(count)%></option>
					<% count2 = 1
						while count2 < pcount
					%>
						<option name = "PhotoName" value="<%=AFileName(count2)%>">
							<%=AFileName(count2)%>
						</option>
					<% 	count2 = count2 + 1
					wend %>
					</select>
				</td>
							<td class = "body">
								<select size="1" name="Shape(<%=count %>)">
								<option name = "Shape1" value= "<%=Shape(count)%>" ><%=Shape(count)%></option>
								<option name = "Shape3" value= "Landscape Oval" >Landscape Oval</option>
								<option name = "Shape4" value= "Portrait Oval" >Portrait Oval</option>
								<option name = "Shape5" value= "Circle" >Circle</option>
								<option name = "Shape6" value= "Rectangle" >Rectangle</option>
					</select>
							</td>
							<td class = "body">
								<input name="PCaption(<%=count %>)" value= "<%=PCaption(count)%>">
							</td>
						</tr>
					<% 	count = count + 1
					wend 
					TotalCount = count%>
<tr>
		<td colspan = "16" align = "center" valign = "middle">
			<img src = "images/underline.jpg"><br>
			<Input type = Hidden name='TotalCount' value = <%=TotalCount%> >
			<input type=submit value = "Submit Changes" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" class = "menu" >
			</form>
		</td>
</tr>

			</table>
				<H3>Delete Photos </H3>		

			<form action= 'DeleteGalleryPhotos.asp' method = "post">
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
						<option name = "PhotoID1" value="<%=pPhotoID(count)%>">
							<%=pPhotoID(count)%>
							</option>
					<% 	count = count + 1
					wend %>
					</select>
				</td>
							
				<td nowrap class = "body">
					<br>
					<input type=submit value = "Delete" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" class = "menu" >
				</td>
			  </tr>
		    </table>
		  </form>


<form action= 'DeleteGalleryPages.asp' method = "post">
			   <font color = "red"><H3>Delete Pages </H3>	- Make sure you want to delete the WHOLE page!</font>	<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
			   <tr>
				 <td nowrap class = "body">
					<b>Page</b><br>
					<select size="1" name="GalleryPageID">
					<option name = "PageID0" value= "" selected></option>
					<% count = 1
						CurrentPage = 0
						while count < dcounter
							if CurrentPage <> pPageID(count) then
					%>
						<option name = "PageID1" value="<%=pPageID(count)%>">
							<%=pPageID(count)%>
							</option>
					<% 	CurrentPage = pPageID(count)
							end if
							count = count + 1
					wend %>
					</select>
				</td>
							
				<td nowrap class = "body">
					<br>
					<input type=submit value = "Delete" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" class = "menu" >
				</td>
			  </tr>
		    </table>
		  </form>


<br><br>


<!--#Include virtual="/administration/Footer.asp"--> </Body>
</HTML>