<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
<title>Upload Photos</title>
 <link rel="stylesheet" type="text/css" href="core-styles.css">
</head>

<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">

<!--#Include virtual="/Administration/Header.asp"--> 

<table leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>
		<td class = "body">
			 <H2>Upload a new image
			<img src = "images/underline.jpg"></H2>
			Before you can associate an image with an image with an animal you have to copy it up to the server first. There are five types of images on your site, you can upload all of them using the tools below.<br><br>
		</td>
	</tr>
</table>
<table leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>
		<td width = "400" align = "center">
			<H3>Large Images</H3>
			These are the images that you will want to use on detail pages, cria images, or additional photos.
			<form action="http://www.blondevelvet.com/administration/Lgupload.cgi" method="post" enctype="multipart/form-data"> 

			<input type="File" name="FILE1">
			<p>
			<input type="Submit" value="submit">

			</form> 
		</td>
		<td width = "400" align = "center">
			<H3>Small Images</H3>
			These are the small images that you will want to use on your list pages: alpaca for sale, Herdsires, Coiming Attractions.  
			<form action="http://www.blondevelvet.com/administration/Smupload.cgi" method="post" enctype="multipart/form-data"> 

			<input type="File" name="FILE1">
			<p>
			<input type="Submit" value="submit">

			</form> 
		</td>
	</tr>
</table>

<table leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>
		<td width = "266" align = "center">
			<H3>ARI Images</H3>
			Images of your ARI registrations.
			<form action="http://www.blondevelvet.com/administration/ARIupload.cgi" method="post" enctype="multipart/form-data"> 

			<input type="File" name="FILE1">
			<p>
			<input type="Submit" value="submit">

			</form> 
		</td>
		<td width = "266" align = "center">
			<H3>Small Histograms</H3>
			These are the small histogram images that are used on your detail pages. 
			<form action="http://www.blondevelvet.com/administration/SHupload.cgi" method="post" enctype="multipart/form-data"> 

			<input type="File" name="FILE1">
			<p>
			<input type="Submit" value="submit">
			</form> 
		</td>
		<td width = "266" align = "center">
			<H3>Large Histograms</H3>
			These are the images that you will want to people to see when the click on the small histogram images. 
			<form action="http://www.blondevelvet.com/administration/LHupload.cgi" method="post" enctype="multipart/form-data"> 

			<input type="File" name="FILE1">
			<p>
			<input type="Submit" value="submit">
			</form> 
		</td>
	</tr>
</table>






<%  
dim aID(300)
dim aName(300)

	conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath("/AlpacaData.mdb") & ";" & _
						"User Id=;Password=;" 
	sql2 = "select Animals.ID, Animals.FullName from Animals"

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

<table leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>
		<td class = "body">
			 <H2>Associate images
			<img src = "images/underline.jpg"></H2>
			To make changes to your data, make your changes in the table below then select the "Submit Changes" button at the bottom of the page.<br><br>
		</td>
	</tr>
</table>


<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
		
	<form action= 'AddAlpacashandleform.asp' method = "post">
	<tr>
		<td>
				<select size="1" name="FullName">
				<option name = "ID" value= "" selected></option>
				<% count = 1
					while count < acounter
					response.write(count)
					%>
					<option name = "AID" value="<%=aID(count)%>" ><%=aID(count)%><%=aName(count)%></option>
					<% 	count = count + 1
					wend %>
		</select>
		</td>
	</tr>
</table>

<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
<tr>
		<td  align = "center" valign = "middle">
			<img src = "images/underline.jpg"><br>
			<input type=submit value = "Submit Changes" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" class = "menu" >
			</form>
		</td>
</tr>
</table>
<!--#Include virtual="/administration/Footer.asp"--> </Body>
</html>
