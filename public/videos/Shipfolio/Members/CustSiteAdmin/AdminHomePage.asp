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
</head>
</HEAD>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center" >
<!--#Include file="adminHeader.asp"-->
<!--#Include file="AdminSecurityInclude.asp"-->
<% pagename = "Home Page"
Current3 = "PageContent" %> 
<!--#Include file="AdminPagesTabsInclude.asp"-->
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
<H1><div align = "left">Home Page</div></H1>
</td></tr>
<tr><td class = "roundedBottom" align = "center" width = "960">
<br />
<a name="Top"></a>
<% ShowSlideshow=False
Set rsx = Server.CreateObject("ADODB.Recordset")
 sql = "select * from LayoutHomePage where HomePageDesignAspect= 'SlideShow' and HomePageDesignAspectAvailable=True"
rsx.Open sql, conn, 3, 3   
if not rsx.eof then 
    ShowSlideshow=True
end if 
rsx.close

ShowFeaturedNews=False
 sql = "select * from LayoutHomePage where HomePageDesignAspect= 'FeaturedNews' and HomePageDesignAspectAvailable=True"
rsx.Open sql, conn, 3, 3   
if not rsx.eof then 
    ShowFeaturedNews=True
end if 
rsx.close

ShowFeaturedAnimal=False
 sql = "select * from LayoutHomePage where HomePageDesignAspect= 'FeaturedAnimal' and HomePageDesignAspectAvailable=True"
rsx.Open sql, conn, 3, 3   
if not rsx.eof then 
    ShowFeaturedAnimal=True
end if 
rsx.close

ShowFeaturedStud=False
 sql = "select * from LayoutHomePage where HomePageDesignAspect= 'FeaturedStud' and HomePageDesignAspectAvailable=True"
rsx.Open sql, conn, 3, 3   
if not rsx.eof then 
    ShowFeaturedStud=True
end if 
rsx.close

ShowFeaturedProduct=False
 sql = "select * from LayoutHomePage where HomePageDesignAspect= 'FeaturedProduct' and HomePageDesignAspectAvailable=True"
rsx.Open sql, conn, 3, 3   
if not rsx.eof then 
    ShowFeaturedProduct=True
end if 
rsx.close

ShowFeaturedVideo=False
 sql = "select * from LayoutHomePage where HomePageDesignAspect= 'FeaturedVideo' and HomePageDesignAspectAvailable=True"
rsx.Open sql, conn, 3, 3   
if not rsx.eof then 
    ShowFeaturedVideo=True
end if 
rsx.close


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
PageText= Replace(str1, str2 , vbCrLf)
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
PageText1= Replace(str1, str2 , vbCrLf)
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
PageText2= Replace(str1, str2 , vbCrLf)
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
PageText3= Replace(str1, str2 , vbCrLf)
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
PageText4= Replace(str1, str2 , vbCrLf)
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

<br />
<% if ShowtextBlocks = True then %>
<a name="TextBlock1"></a>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
<H1><div align = "left">Paragraph 1</div></H1>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" width = "<%=screenwidth %>">
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
<% end if %>
<% if ShowtextBlocks = False and Slideshow = true then %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = '100%'><tr><td class = "roundedtop" align = "left">
<H1><div align = "left">Slideshow Images</div></H1>
        </td></tr>
        <tr><td class = "roundedBottom body" align = "center">
 To manage the slideshow images on your home page please select <a href = "AdminGalleryEditImages.asp?GallerycatID=3" class ='body'>Slideshow Images</a>
 </td></tr></table>
<% end if %>
<%
sql2 = "select * from People where PeopleID = 667"

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

'response.Write("FeaturedAlpaca1 = " &FeaturedAlpaca1 & "<br>")

if len(FeaturedAlpaca1) > 0 then
    sql2 = "select FullName from Animals where ID = " & FeaturedAlpaca1  
acounter = 1
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3 

if Not rs2.eof  then
FeaturedAlpacaName = rs2("FullName")
    End if
    rs2.close
end if

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

sql2 = "select prodName from sfProducts where prodID = " & FeaturedProduct & ""
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
Dim IDArrayz(10000) 
Dim alpacaNamez(100000) 


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
 <% if ShowFeaturedAnimal = True then %>
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

<br>Select a New Featured Alpaca:
<select size="1" name="ID">
<% If Len(FeaturedAlpaca1) > 0 Then %>
<option name = "AID0" value= "<%=FeaturedAlpaca1%>" selected><%=FeaturedAlpacaName%></option>
<option name = "AID0" value= "0" >Random</option>
<% End If %>
 <% If FeaturedAlpaca1 = 0 Then %>
<option name = "AID0" value= "0" Selected>Random</option>
<% End If %>


<% count = 2
while count < acounter 
response.write(count)
%>
<option name = "AID1" value="<%=IDArrayz(count)%>">
<%=alpacaNamez(count)%>
</option>
<% count = count + 1
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

<% end if %>
 </td>
  <td width = "6"></td>
  <td width = "420" valign = "top">
<% if  ShowFeaturedStud = True then
sql2 = "select Animals.ID, Animals.FullName from Animals where (Category = 'Experienced Male' or  Category = 'Inexperienced Male' ) order by Fullname"
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

<br>Select a New Featured Herdsire:
<select size="1" name="ID">
<% If Len(FeaturedHerdsire) > 0 Then %>
<option name = "AID0" value= "<%=FeaturedHerdsire%>" selected><%=FeaturedHerdsireName%></option>
                        <option name = "AID0" value= "0" >Random</option>

<% End If %>
                    <% If FeaturedHerdsire = 0 Then %>
<option name = "AID0" value= "0" selected>Random</option>

<% End If %>

<% count = 1
while count < studcount 
response.write(count)
%>
<option name = "AID1" value="<%=IDArrayz(count)%>">
<%=alpacaNamez(count)%>
</option>
<% count = count + 1
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
    
<% end if %>    
 </td>
 </tr>
 <tr>
  <td colspan = "3" valign = "top">
<% if ShowFeaturedProduct = True then
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
                        <option name = "AID0" value= "0" >Random</option>
<% End If %>

<% If FeaturedProduct = 0 Then %>
                        <option name = "AID0" value= "0" selected>Random</option>
<% End If %>
<% count = 1
while count < studcount 
response.write(count)
%>
<option name = "AID1" value="<%=IDArrayz(count)%>">
<%=alpacaNamez(count)%>
</option>
<% count = count + 1
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
 
 <% end if %>
 
 
</tr>
   <tr>
</table>

<br><br>

  </td>
  </tr>
    </table>
<br><br>


<% 
gallerycategoryname = "Home Page Slideshow"
   GalleryCatID = 3
sql = "select * from LayoutHomePage where HomePageDesignAspect= 'SlideShow' and HomePageDesignAspectAvailable=True"

Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
if not rs.eof then
  HomePageSlideshowDimensions = rs("HomePageDesignAspectTitle")

end if
rs.close
Set rsh = Server.CreateObject("ADODB.Recordset")
Set rs = Server.CreateObject("ADODB.Recordset")	
Set rs3 = Server.CreateObject("ADODB.Recordset")	
if len(GalleryCatID) > 0 then
sql =  "select gallerycategoryname, GalleryCatID from GalleryCategories where GalleryCatID = " & GalleryCatID
rsh.Open sql, conn, 3, 3 
if Not rsh.eof then
   gallerycategoryname = rsh("gallerycategoryname")
   GalleryCatID = rsh("GalleryCatID")
end if	
rsh.close
end if

if mobiledevice = False  then %>
   <%

   if GalleryCatID = 3 then
    Pagename = "Home Page"
    Current3 = "HomePageSlideshow"
     end if %>

<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth  %>"><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Edit <%= gallerycategoryname%> Slideshow Images</div></H2>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center"  valign = "top">
<% end if %>
<%	if len(GalleryCatID) > 0 then 
sql3 =  "select * from Gallery Where GalleryCatID = " & GalleryCatID
rs3.Open sql3, conn, 3, 3 
if not rs3.eof then
totalcount = rs3.recordcount
end if
%>
<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "<%=screenwidth -100 %>"  align = "center"  valign = "top">	
<%	sql = "select * from Gallery where len(GalleryImage) > 1 and GalleryCatID = " & GalleryCatID & " order by ImageOrder"
rs.Open sql, conn, 3, 3
imagecount = 0	
if rs.eof then %>
<tr><td class = "body" colspan = "4"><b>Currently this gallery has no images associated with it.</b><br /><br /></td></tr>
<% end if %>
<tr><td colspan = "4">
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth -35  %>"><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Add a Slideshow Images</div></H2>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" height = "30" valign = "top">
      
     <% if gallerycategoryname = "Home Page Slideshow" and len(HomePageSlideshowDimensions)> 0 then %>
	  <div align = 'left'><b>Home page slideshow images will be resized to <%=HomePageSlideshowDimensions %>. We recomend that you crop and resize your home page images to that size, otherwise they will look distorted and load slowly.</b><br /><br /></div>
	<% end if %>
	<form name="frmSend" method="POST" enctype="multipart/form-data" action="AdminGalleryImageHomePage.asp?GalleryCatID=<%=GalleryCatID %>" >
<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%"  align = "center"  valign = "top">
		<tr>
			<td class = "body2" width = "530" >Upload Image: <input name="attach1" type="file" size=55 class = "Submit">
			</td>
			<td class = "body2" align = 'left' valign = "bottom"><input  type=submit value="Upload" class = "regsubmit2 body2"></center>
					
			</td>
			</tr>
		</table>
		</form>
</td>
			</tr>
		</table>
        <br /><br />
</td></tr>
<tr><td class = "roundedtop body"> 
<H2><div align = "left">Edit Gallery Images</div></H2>
</td></tr>
<tr><td class = "roundedBottom"> 
<table>
<%While Not rs.eof
	GalleryImage= rs("GalleryImage")
	ImageOrder= rs("ImageOrder")
	GalleryCaption = rs("GalleryCaption")
    GalleryImageLink = rs("GalleryImageLink")
	GalleryID = rs("GalleryID")
	
if imagecount = 0 or mobiledevice = True then
%>
<tr>
<% end if %>
<% if mobiledevice = False  then %>
<td width = "200" align = "center" class = "body" >
<% else %>
<td width = "100%" align = "center" class = "body">
<% end if %>










<% if mobiledevice = False  then
if pagewidth > 768 then %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "90%" >
<tr><td class = "roundedtopandbottom" align = "center" width = "100%" height = "400"> 
<% else %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "90%" >
<tr><td class = "roundedtopandbottom" align = "center" width = "100%" height = "350"> 
<% end if %>
<% else %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%" >
<tr><td class = "roundedtopandbottom" align = "center" width = "100%">
<% end if %>
<img src = "<%=GalleryImage%>" width = "100%">
<form action= 'AdminHomePageGalleryEditCaption.asp' method = "post">
Caption:<br>
<textarea name="Caption" cols="30" rows="4" wrap="VIRTUAL" class = "body"><%=GalleryCaption%></textarea><br>
(80 Character Max.)<br>
Link:<br />
<textarea name="GalleryImageLink" cols="30" rows="2" wrap="VIRTUAL" class = "body"><%=GalleryImageLink%></textarea><br>
<input type = "hidden" name="GalleryCatID" value= "<%=GalleryCatID %>" >
<input type = "hidden" name="GalleryID" value= "<%= GalleryID %>" ><br>
Order:
<select size="1" name="ImageOrder" class = "regsubmit2 body">
<option  value= "<%=ImageOrder%>" selected><%=ImageOrder%></option>
<%	
   for x = 1 to totalcount 
      if not x = ImageOrder then %>
	<option  value= "<%=x%>" ><%=x%></option>
 <% end if
 Next %>
 </select>
<center><input type=submit value="Submit" class = "regsubmit2 body"></center><br>
</form>
<form action= 'AdminHomePageGalleryRemoveImage.asp' method = "post">
<center><input type = "hidden" name="ImageID" value= "1" >
<input type = "hidden" name="GalleryCatID" value= "<%=GalleryCatID %>" >
<input type = "hidden" name="GalleryID" value= "<%= GalleryID %>" >
<input type=submit value="Remove" class = "regsubmit2 body"></center><br>
</form>
</td>
</tr>
</table><br />
	
</td>

<% rs.movenext
imagecount = imagecount + 1	
if imagecount = 4 or mobiledevice = True or rs.eof then 
	imagecount = 0%>
<tr>
<% end if 
Wend
rs.close %>
</table>		
<% end if %>
</td></tr></table>
</td></tr></table>
<br /><br />

<center><a href = "#Top" class ="body">Click here to go to the top of the page.</a></center>
<br /><br />
<!-- #include file="AdminFooter.asp" -->
 </Body>
</HTML>
