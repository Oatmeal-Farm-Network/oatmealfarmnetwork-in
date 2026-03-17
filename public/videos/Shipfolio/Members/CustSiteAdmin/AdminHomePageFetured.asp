<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<title>The Andresen Group Content Management System</title>
<meta name="Title" content="Alpaca Infinity Administration"/>
<meta name="robots" content="nofollow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="revisit-after" content="1"/>
<meta name="Googlebot" content="nofollow"/>
<meta name="author" content="The Andresen Group"/>
 <link rel="stylesheet" type="text/css" href="/administration/style.css">
<!--#Include file="AdminGlobalVariables.asp"-->
</HEAD>
<body >

<!--#Include file="adminHeader.asp"-->
<!--#Include file="AdminSecurityInclude.asp"-->

 <% 
   pagename = "Home Page"
   Current3 = "PageContent" %> 

<br>
<!--#Include file="AdminPagesTabsInclude.asp"-->
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
		<H1><div align = "left">Home Page</div></H1>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" width = "960">
<br />
		<a name="Top"></a>


<% 
 sql = "select * from PageLayout where PageName = 'Home Page' " 
'response.write(sql)
		
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
 Slideshow = rs("Slideshow")
	
	  PageTitle = rs("PageTitle")

	PageText1 = rs("PageText")
	PageText2 = rs("PageText2")
	PageText3 = rs("PageText3")
	PageText4 = rs("PageText4")
	PageText5 = rs("PageText5")
	PageText6 = rs("PageText6")
	PageText7 = rs("PageText7")
	PageText8 = rs("PageText8")
	Image1= rs("Image1")
	Image2= rs("Image2")
	Image3= rs("Image3")
	Image4= rs("Image4")
	Image5= rs("Image5")
	Image6= rs("Image6")
	Image7= rs("Image7")
	Image8= rs("Image8")
	ImageOrientation1= rs("ImageOrientation1")
	ImageOrientation2= rs("ImageOrientation2")
	ImageOrientation3= rs("ImageOrientation3")
	ImageOrientation4= rs("ImageOrientation4")
	ImageOrientation5= rs("ImageOrientation5")
	ImageOrientation6= rs("ImageOrientation6")
	ImageOrientation7= rs("ImageOrientation7")
	ImageOrientation8= rs("ImageOrientation8")

str1 = PageTitle
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageTitle= Replace(str1,  str2, " ")
End If 

str1 = PageTitle
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageTitle= Replace(str1,  str2, "'")
End If 

str1 = PageText1
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageText1= Replace(str1,  str2, " ")
End If 

str1 = PageText1
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageText1= Replace(str1,  str2, "'")
End If 

str1 = PageText2
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageText2= Replace(str1,  str2, " ")
End If 

str1 = PageText2
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageText2= Replace(str1,  str2, "'")
End If 


str1 = PageText3
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageText3= Replace(str1,  str2, " ")
End If 

str1 = PageText3
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageText3= Replace(str1,  str2, "'")
End If 

str1 =  PageText4
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	 PageText4= Replace(str1,  str2, " ")
End If 

str1 =  PageText4
str2 = "''"
If InStr(str1,str2) > 0 Then
	 PageText4= Replace(str1,  str2, "'")
End If 

str1 =  ImageCaption2
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	 ImageCaption2= Replace(str1,  str2, " ")
End If 

str1 =  ImageCaption2
str2 = "''"
If InStr(str1,str2) > 0 Then
	 ImageCaption2= Replace(str1,  str2, "'")
End If 

str1 =  ImageCaption3
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	 ImageCaption3= Replace(str1,  str2, " ")
End If 

str1 =  ImageCaption3
str2 = "''"
If InStr(str1,str2) > 0 Then
	 ImageCaption3= Replace(str1,  str2, "'")
End If 


str1 =  ImageCaption4
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	 ImageCaption4= Replace(str1,  str2, " ")
End If 

str1 =  ImageCaption4
str2 = "''"
If InStr(str1,str2) > 0 Then
	 ImageCaption4= Replace(str1,  str2, "'")
End If 


str1 = PageTitle
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageTitle= Replace(str1,  str2, " ")
End If 

str1 = PageTitle
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageTitle= Replace(str1,  str2, "'")
End If 


str1 = PageText
str2 = "</br>"
If InStr(str1,str2) > 0 Then
	'PageText= Replace(str1, str2 , vbCrLf)
End If  

str1 =PageText
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageText= Replace(str1,  str2, " ")
End If 

str1 = PageText
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageText= Replace(str1,  str2, "'")
End If 

str1 = PageText1
str2 = "</br>"
If InStr(str1,str2) > 0 Then
	'PageText1= Replace(str1, str2 , vbCrLf)
End If  

str1 =PageText1
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageText1= Replace(str1,  str2, " ")
End If 

str1 = PageText1
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageText1= Replace(str1,  str2, "'")
End If 

str1 = PageText2
str2 = "</br>"
If InStr(str1,str2) > 0 Then
	'PageText2= Replace(str1, str2 , vbCrLf)
End If  

str1 =PageText2
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageText2= Replace(str1,  str2, " ")
End If 

str1 = PageText2
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageText2= Replace(str1,  str2, "'")
End If 

str1 = PageText3
str2 = "</br>"
If InStr(str1,str2) > 0 Then
	'PageText3= Replace(str1, str2 , vbCrLf)
End If  

str1 =PageText3
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageText3= Replace(str1,  str2, " ")
End If 

str1 = PageText3
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageText3= Replace(str1,  str2, "'")
End If 

str1 = PageText4
str2 = "</br>"
If InStr(str1,str2) > 0 Then
	'PageText4= Replace(str1, str2 , vbCrLf)
End If  

str1 =PageText4
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageText4= Replace(str1,  str2, " ")
End If 

str1 = PageText4
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageText4= Replace(str1,  str2, "'")
End If 

%>

<a name="Top"></a>

<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
		<H1><div align = "left">Page Heading</div></H1>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center">
<br />

<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "910">
	<tr>
		<td valign = "top">
			 <form action= 'AdminHomePageHandleForm.asp' method = "post">
			<input name="TextBlock"  size = "60" value = "Heading" type = "hidden">

			<table border = "0" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "580">
  			<tr>
				<td  align = "center" valign = "top" class = "body">
					<input name="Text"  size = "60" value = '<%=PageTitle%>'>
			<input type=submit value = "Submit Changes" class = "regsubmit2" size = "110" >
		</td>
		</tr>
		</table>

</form>

		</td>
		</tr>
		</table>
		</td>
		</tr>
		</table>
		<br />
<a name="TextBlock1"></a>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
		<H1><div align = "left">Paragraph 1</div></H1>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" width = "910">
<br />

	<table border = "0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "910">
		<tr>
		    <td class = "body" align = "left" width= "600">
				<form action= 'AdminHomePageHandleForm.asp' method = "post">
					<input name="TextBlock"  size = "60" value = "TB1" type = "hidden">
					
			<script type="text/javascript" src="/openwysiwyg/scripts/wysiwyg.js"></script>
		<script type="text/javascript" src="/openwysiwyg/scripts/wysiwyg-settings.js"></script>
		<script language="javascript1.2">
  		// attach the editor to the textarea with the identifier 'textarea1'.
  	var mysettings = new WYSIWYG.Settings();
    mysettings.Width = "500px";
    mysettings.Height = "255px";
    WYSIWYG.attach('Text', mysettings);
  		
		</script> 
					
					<TEXTAREA NAME="Text" ID="Text" cols="48" rows="16" wrap="file"><%=PageText1%></textarea>
					<center><input type=submit value = "Submit Changes"   class = "regsubmit2" ></center>
			</form>
		</td>
	  <td valign = "top" class = "body" >
	  <% Slideshow = false
	 	  if  Slideshow = false then %>
			<table Border = "0" width = "100" align = "center">
			<tr>
				<td width = "100" align = "center">
					<% If Len(trim(Image1)) > 2 Then %>
							<img src = "<%=Image1%>" height = "100">
					<% Else %>
							<h2>No Image</h2>
					<% End If %>
				</td>
			</tr>
			<tr>
				<td class = "body">
								<form name="frmSend" method="POST" enctype="multipart/form-data" action="AdminHomePageUploadPageImage.asp?TextBlock=1"  class = "regsubmit2">
								Upload Photo: <br>
								<input name="attach1" type="file" size=35 >
								<input  type=submit value="Upload"  class = "regsubmit2">
							</form>
						<td>
						</tr>
					
						<tr>
					    <td class = "body">
							<form action= 'RemoveRanchHomeImage.asp' method = "post">
								<input type = "hidden" name="ImageID" value= "1" >
								<center><input type=submit value="Remove This Image" class = "regsubmit2"></center>
							</form>
					</td>
				</tr>
				</table>
	<% else %>
	<h3>Slideshow Images</h3>
	 To manage the slideshow images on your home page please select <a href = "AdminGalleryEditImages.asp?GallerycatID=3" class ='body'>Slideshow Images</a>
	<% end if %>
	   <td>
	 </tr>
</table>

   <td>
	 </tr>
</table>
<br />
<a name="TextBlock2"></a>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
		<H1><div align = "left">Paragraph 2</div></H1>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center">
<br />
		<table border = "0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "910">
		<tr>
		    <td class = "body" align = "left" width= "810">
				<form action= 'AdminHomePageHandleForm.asp' method = "post">
					<input name="TextBlock"  size = "60" value = "TB2" type = "hidden">
					<script language="javascript1.2">
  		// attach the editor to the textarea with the identifier 'textarea1'.
  	var mysettings = new WYSIWYG.Settings();
    mysettings.Width = "500px";
    mysettings.Height = "255px";
    WYSIWYG.attach('NewsText', mysettings);
  		
		</script> 
					
					
					<TEXTAREA NAME="NewsText" ID="NewsText"  cols="48" rows="16" wrap="file"><%=PageText2%></textarea>
					<center><input type=submit value = "Submit Changes" class = "regsubmit2" ></center>
			</form>
		</td>
	  <td valign = "top"  >
			<table Border = "0" width = "150" align = "center">
			<tr>
				<td width = "100" align = "center">
					<% If Len(Image2) > 2 Then %>
							<img src = "<%=Image2%>" height = "100">
					<% Else %>
							<h2>No Image</h2>
					<% End If %>
				</td>
			</tr>
			<tr>
				<td class = "body">
							<form name="frmSend" method="POST" enctype="multipart/form-data" action="AdminHomePageUploadPageImage.asp?TextBlock=2"  class = "regsubmit2">
								Upload Photo: <br>
								<input name="attach2" type="file" size=35 >
								<input  type=submit value="Upload" class = "regsubmit2">
							</form>
						<td>
						</tr>
						
						<tr>
					    <td class = "body">
							<form action= 'RemoveRanchHomeImage.asp' method = "post">
								<input type = "hidden" name="ImageID" value= "2" >
								<center><input type=submit value="Remove This Image" class = "regsubmit2"></center>
							</form>
					</td>
				</tr>
				</table>
	   <td>
	 </tr>
</table>
	   <td>
	 </tr>
</table>
<%
sql2 = "select * from People where PeopleID = 695"
	
	'response.write(sql2)
	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	
	if Not rs2.eof  then
		FeaturedAlpaca1 = rs2("FeaturedAlpaca1")
		FeaturedHerdsire = rs2("FeaturedHerdsire")
		FeaturedProduct = rs2("FeaturedProduct")
End if
 
rs2.close
		
'response.Write("FeaturedAlpaca1 = " &	FeaturedAlpaca1 & "<br>")	
		
if len(FeaturedAlpaca1) > 0 then
    sql2 = "select FullName from Animals where ID = " & FeaturedAlpaca1  
	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	
	if Not rs2.eof  then
		FeaturedAlpacaName = rs2("FullName")
    End if
'response.Write("FeaturedAlpacaName= " &	FeaturedAlpacaName & "<br>")	
    rs2.close
end if

response.Write("FeaturedHerdSire = " &	FeaturedHerdSire & "<br>")	
if len(FeaturedHerdsire) > 0 then
    sql2 = "select FullName from Animals where animals.ID = " & FeaturedHerdsire
	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	
	if Not rs2.eof  then
		FeaturedHerdsireName = rs2("FullName")
	End if
rs2.close
end if

if len(FeaturedProduct) > 0 then
	
sql2 = "select prodName from sfProducts where prodID = '" & FeaturedProduct & "'"
	'response.write(sql2)
	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	
	if Not rs2.eof  then
		FeaturedProductName = rs2("prodName")
	End if
rs2.close
end if		
		
		
		set rs2=nothing

%>

<% 
Dim	IDArrayz(10000) 
Dim	alpacaNamez(100000) 


	sql2 = "select Animals.ID, Animals.FullName from Animals order by Fullname"
	
	'response.write(sql2)
	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	
	While Not rs2.eof  
		IDArrayz(acounter) = rs2("ID")
		alpacaNamez(acounter) = rs2("FullName")
		'response.write (SSName(studcounter))

		acounter = acounter +1
		rs2.movenext
	Wend		
	
	rs2.close
	set rs2=nothing
 %>
 <a name="TextBlock3"></a><br />
 <table width ="900" cellpadding = "0" cellspacing = "0">
 <tr>
 <td width = "448" valign = "top">
 <table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
		<H1><div align = "left">Featured Alpaca</div></H1>
        </td></tr>
        <tr><td class = "roundedBottom body" align = "center" height = "200" valign = "top">
<br />	
<div align = "left">
Note: If you do not have featured alpacas selected, animals will be randomly selected each time a user comes to your home page.<br></div>
<table border = "0"  leftmargin="5" topmargin="5" marginwidth="5" marginheight="5"  cellpadding=5 cellspacing=5  width = "420">
	<tr>
		<td class = "body" >
			<form  action="AdminHomePageFeaturedAlpaca1.asp" method = "post" name = "edit1">
			  <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
			   <tr>
				<td colspan ="30">
					&nbsp;
				</td>
				 <td class = "body">
					<br>Select a New Featured Alpaca 1:
					<select size="1" name="ID">
					<% If Len(FeaturedAlpaca1) > 0 Then %>
						<option name = "AID0" value= "<%=FeaturedAlpaca1%>" selected><%=FeaturedAlpacaName%></option>
					<% End If %>
					<option name = "AID0" value= "0" >Random</option>
					
					<% count = 2
						while count < acounter 
						response.write(count)
					%>
						<option name = "AID1" value="<%=IDArrayz(count)%>">
							<%=alpacaNamez(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
			<center><input type=submit value="Select" class = "regsubmit2"></center>
				</td>
			  </tr>
		    </table>
		  </form>


		  	</td>
	
			  </tr>
		    </table>
		  </form>
		</tr>
   <tr>
</table>


 </td>
  <td width = "6"></td>
  <td width = "420" valign = "top">
  
  <% 

	sql2 = "select Animals.ID, Animals.FullName from Animals where (Category = 'Experienced Male' or  Category = 'Inexperienced Male' ) order by Fullname"
	
	'response.write(sql2)
	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	
	While Not rs2.eof  
		IDArrayz(acounter) = rs2("ID")
		alpacaNamez(acounter) = rs2("FullName")
		'response.write (SSName(studcounter))

		acounter = acounter +1
		rs2.movenext
	Wend		
	studcount = acounter
		rs2.close
		set rs2=nothing


 %>

 <a name="TextBlock4"></a>
  		<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
		<H1><div align = "left">Featured Herdsire</div></H1>
        </td></tr>
        <tr><td class = "roundedBottom body" align = "center" height = "200" valign = "top">
<br />
<div align = "left">Note: If you do not have a featured Herdsire selected, a herdsire will be randomly selected each time a user comes to your home page.<br>
<table border = "0"  leftmargin="5" topmargin="5" marginwidth="5" marginheight="5"  cellpadding=5 cellspacing=5  width = "420" >
	<tr>
		<td class = "body" >
			<form  action="AdminHomePageFeaturedHerdsire.asp" method = "post" name = "edit1">
			  <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
			   <tr>
				<td colspan ="30">
					&nbsp;
				</td>
				 <td class = "body">
				 <% response.write("Featured Herdsire = " & FeaturedHerdsire & " <br>")%>

					<br>Select a New Featured Herdsire:
					<select size="1" name="ID">
					<% If Len(FeaturedHerdsire) > 0 Then %>
						<option name = "AID0" value= "<%=FeaturedHerdsire%>" selected><%=FeaturedHerdsireName%></option>
					<% End If %>
					<option name = "AID0" value= "0" >Random</option>
					
					<% count = 1
						while count < studcount 
						response.write(count)
					%>
						<option name = "AID1" value="<%=IDArrayz(count)%>">
							<%=alpacaNamez(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
			<center><input type=submit value="Select" class = "regsubmit2"></center>
				</td>
			  </tr>
		    </table>
		  </form></div>
		  	</td>
			  </tr>
		    </table>
		    
		    
 </td>
 </tr>
 <tr>
  <td colspan = "3" valign = "top">
  
  <% 
	
	sql2 = "select prodID, prodName from sfproducts  order by prodName"
	
	'response.write(sql2)
	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	
	While Not rs2.eof  
		IDArrayz(acounter) = rs2("prodID")
		alpacaNamez(acounter) = rs2("prodName")
		'response.write (SSName(studcounter))

		acounter = acounter +1
		rs2.movenext
	Wend		
	studcount = acounter
		rs2.close
		set rs2=nothing


 %>

 <a name="TextBlock4"></a>
  		<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
		<H1><div align = "left">Featured Product</div></H1>
        </td></tr>
        <tr><td class = "roundedBottom body" align = "center" height = "200" valign = "top">
<br />
<div align = "left">Note: If you do not have a featured product selected, a product will be randomly selected each time a user comes to your home page.<br>
<table border = "0"  leftmargin="5" topmargin="5" marginwidth="5" marginheight="5"  cellpadding=5 cellspacing=5  width = "420" >
	<tr>
		<td class = "body" >

			<form  action="AdminHomePageFeaturedProduct.asp" method = "post" name = "edit1">
			  <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
			   <tr>
				<td colspan ="30">
					&nbsp;
				</td>
				 <td class = "body">
					<br>Select a New Featured Product:
					<select size="1" name="ID">
					<% If Len(FeaturedProduct) > 0 Then %>
						<option name = "AID0" value= "<%=FeaturedProduct%>" selected><%=FeaturedProductName%></option>
					<% End If %>
					<option name = "AID0" value= "0" >Random</option>
					
					<% count = 1
						while count < studcount 
						response.write(count)
					%>
						<option name = "AID1" value="<%=IDArrayz(count)%>">
							<%=alpacaNamez(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
			<center><input type=submit value="Select" class = "regsubmit2"></center>
				</td>
			  </tr>
		    </table>
		  </form></div>
		  	</td>
			  </tr>
		    </table>
		    
		    
 </td>
 
 </tr>
 </table>
 
 
 
 		
		</tr>
   <tr>
</table>

<br><br>
<div align = "center"><a href = "#Top" class ="body">Click here to go to the top of the page.</a></center>
	  	</td>
			  </tr>
		    </table>
<br><br>
	  </td>
	 </tr>
</table>
<br /><br />
<!-- #include file="AdminFooter.asp" -->
 </Body>
</HTML>
