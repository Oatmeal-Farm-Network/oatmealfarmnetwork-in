<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
<title>Upload Photos</title>
 <link rel="stylesheet" type="text/css" href="style.css">
</head>

<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">

<!--#Include virtual="/Administration/Header.asp"--> 

<table leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>
		<td class = "body">
			 <H2>Upload Photos
			<img src = "images/underline.jpg"></H2>
			Before you can associate an image with an animal you have to copy it up to the server first. There are five types of images on your site, you can upload all of them using the tools below.<br><br>
		</td>
	</tr>
</table>
<table leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>
		<td width = "400" align = "center">
			<H3>Large Images</H3>
			These are the images that you will want to use on<br>
			your detail pages.
			<form action="Lgupload.cgi" method="post" enctype="multipart/form-data"> 

			<input type="File" name="FILE1">
			<p>
			<input type="Submit" value="submit">

			</form> 
		</td>
		<td width = "400" align = "center">
			<H3>Small Images</H3>
			These are the small images that you will want to use on<br> your alpacas for sale and expecting cria list pages:
			.  
			<form action="Smupload.cgi" method="post" enctype="multipart/form-data"> 

			<input type="File" name="FILE1">
			<p>
			<input type="Submit" value="submit">

			</form> 
		</td>
	</tr>
</table>






<!--#Include virtual="/Administration/Footer.asp"--> </Body>
</html>
