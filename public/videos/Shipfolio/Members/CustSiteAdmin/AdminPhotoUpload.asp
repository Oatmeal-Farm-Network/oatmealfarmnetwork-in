<!DOCTYPE HTML>
<% ' Clean directory NEA 4/2012 %>
<html>
<head>
<title>The Andresen Group Content Management System</title>
<link rel="stylesheet" type="text/css" href="/administration/style.css">
</head>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">

    <!--#Include file="AdminSecurityInclude.asp"--> 
    <!--#Include file="AdminHeader.asp"--> 

<table leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>
		<td class = "body">
			 <H2>Upload Photo
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


<!--#Include file="AdminFooter.asp"--> </Body>
</html>
