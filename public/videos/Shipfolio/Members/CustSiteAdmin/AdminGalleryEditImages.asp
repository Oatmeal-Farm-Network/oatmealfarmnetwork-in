<!DOCTYPE HTML>
<HTML>
<HEAD>
<title>The Andresen Group Content Management System</title>
<link rel="stylesheet" type="text/css" href="/administration/style.css">
<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">
<!--#Include file="AdminSecurityInclude.asp"-->
<!--#Include file="AdminGlobalVariables.asp"--> 
<!--#Include file="AdminHeader.asp"--> 
<% sql = "select * from LayoutHomePage where HomePageDesignAspect= 'SlideShow' and HomePageDesignAspectAvailable=True"
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
if not rs.eof then
  HomePageSlideshowDimensions = rs("HomePageDesignAspectTitle")
end if
rs.close
GalleryCatID= Request.Form("GalleryCatID")
if len(GalleryCatID) > 0 then
else
	GalleryCatID= Request.querystring("GalleryCatID")
End If
Set rsh = Server.CreateObject("ADODB.Recordset")
Set rs = Server.CreateObject("ADODB.Recordset")	
Set rs3 = Server.CreateObject("ADODB.Recordset")	
if len(GalleryCatID) > 0 then
sql =  "select gallerycategoryname, GalleryCatID from GalleryCategories where GalleryCatID = " & GalleryCatID
'response.write("sql=" & sql)
rsh.Open sql, conn, 3, 3 
if Not rsh.eof then
   gallerycategoryname = rsh("gallerycategoryname")
   GalleryCatID = rsh("GalleryCatID")
end if	
rsh.close
end if
'response.write("GalleryCatID=" & GalleryCatID)
%>
<% if mobiledevice = False  then %>
   <%
   if GalleryCatID = 30000 then
    Pagename = "Home Page"
    Current3 = "HomePageSlideshow" %>
<!--#Include File="AdminPagesTabsInclude.asp"--> 

<%  else
  Current3="EditImages" %> 

<!--#Include file="AdminGalleryTabsInclude.asp"-->
<% end if %>

<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth  %>"><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Edit <%= gallerycategoryname%> Gallery Images</div></H2>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center"  valign = "top">

<% else %>

<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%" >
<tr><td  class = "body" >
<center>

<a href = "/Administration/AdminGalleryHome.asp" class = "body"><b>Galleries</b></a><img src = "images/px.gif" height = "1" width = "6%" />
<a href = "/Administration/AdminGalleryAddImage1.asp" class = "body"><b>Add Images</b></a><img src = "images/px.gif" height = "1" width = "6%" />
<a href = "/Administration/AdminGallerySetCategories.asp" class = "body"><b>Gallery Categories</b></a></center><br /><br />

		<H1><div align = "left">Edit <%= gallerycategoryname%> Gallery</div></H1>
  </td></tr>  


<% end if %>

<% if mobiledevice = False  then %>
<form  action="AdminGalleryEditImages.asp" method = "post">
			  <table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "<%=screenwidth - 100 %>"  align = "center"  valign = "top">
			   <tr>
				<td colspan ="30">
					&nbsp;
				</td>
				 <td class = "body">
				 <br>Select another photo gallery:
				 <% sql =  "select * from GalleryCategories order by gallerycategoryname "
						'response.write("sql=" & sql)
				%>
					<select size="1" name="GalleryCatID">
					<option name = "AID0" value= "" selected></option>
					
					<% 
						
						rs.Open sql, conn, 3, 3 
						While Not rs.eof 					%>
						<option name = "AID1" value="<%=rs("GalleryCatID")%>">
							<%=rs("GalleryCategoryName")%></option>
					<% 	rs.movenext
Wend 
 %>
					</select>
					
					<input type=submit value = "Edit"  class = "regsubmit2" >
				</td>
			  </tr>
		    </table>
		  </form>
<% 
rs.close %>

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
	'response.write(sql)
	rs.Open sql, conn, 3, 3
	
imagecount = 0	
if rs.eof then %>
<tr><td class = "body" colspan = "4"><b>Currently this gallery has no images associated with it.</b><br /><br /></td></tr>
<% end if %>
<tr><td colspan = "4">
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth -35  %>"><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Add a Gallery Image</div></H2>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" height = "30" valign = "top">
      
     <% if gallerycategoryname = "Home Page Slideshow" and len(HomePageSlideshowDimensions)> 0 then %>
	  <div align = 'left'><b>Home page slideshow images will be resized to <%=HomePageSlideshowDimensions %>. We recomend that you crop and resize your home page images to that size, otherwise they will look distorted and load slowly.</b><br /><br /></div>
	<% end if %>
	<form name="frmSend" method="POST" enctype="multipart/form-data" action="AdminGalleryImage2.asp?GalleryCatID=<%=GalleryCatID %>" >
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
	 <!-- #include file="AdminGalleryImageUpdateInclude.asp" -->
	
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
    <!--#Include file="AdminFooter.asp" -->
    
 </Body>
</HTML>
