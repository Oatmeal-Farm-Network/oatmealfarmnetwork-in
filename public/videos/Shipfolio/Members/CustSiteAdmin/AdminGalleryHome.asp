<!DOCTYPE HTML>

<HTML>
<HEAD>
<title>The Andresen Group Content Management System</title>
       <link rel="stylesheet" type="text/css" href="style.css">

</HEAD>
<body >

    <!--#Include File="AdminSecurityInclude.asp"--> 
    <!--#Include File="AdminGlobalVariables.asp"--> 
    <!--#Include File="AdminHeader.asp"--> 
    <% Current3 = "GalleryHome" %>
    <% if mobiledevice = False  then %>
<!--#Include file="AdminGalleryTabsInclude.asp"-->
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth %>" ><tr><td class = "roundedtop" align = "left">
		<H1><div align = "left">List of Photo Galleries</div></H1>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" width = "100%">  
<table  width = "100%" align = "center" height = "200"  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
	<tr>
<td class = "body" valign = "top">
<br />
<%  
dim GalleryCatID(4000)

sqlx =  "select * from Gallerycategories  order by GalleryCatID"
			
Set rsx = Server.CreateObject("ADODB.Recordset")
rsx.Open sqlx, conn, 3, 3 
catcounter = 0
if Not rsx.eof  then %>


<table  width = "100%" align = "center"  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
	<tr><td class = "body2" width = "850" align = "left"><b>Category</b></td>
			<td class = "body2" width = "100" align = "center"><b>Options</b></td>
</tr>
	</tr>
<% row = "odd"
While Not rsx.eof
GalleryCategoryName = rsx("GalleryCategoryName")  
 If row = "even" Then 
    row = "odd" %>
		<tr bgcolor = "white">
<% Else 
row = "even"%>
<tr bgcolor = "#e6e6e6">
<%	End If %>
<td class= "body" height = "30">
<a href = "AdminGalleryEditImages.asp?GalleryCatID=<%= rsx("GalleryCatID") %>#BasicFacts" class = "body"><b><%= GalleryCategoryName %></b></a>
</td>
<td class= "body" >
<a href = "AdminGalleryEditImages.asp?GalleryCatID=<%= rsx("GalleryCatID") %>#BasicFacts" class = "body">

&nbsp;&nbsp;<img src= "images/edit.gif" alt = "edit" height ="12" border = "0"></a>
<% if not (GalleryCategoryName = "Home Page Slideshow" ) then %>|&nbsp;<a href = "AdminGallerySetCategories.asp?GalleryID=<%= rsx("GalleryCatID") %>" class = "body"><img src= "images/Delete.gif" alt = "edit" height ="14" border = "0"></a>
<% end if %>
</td>
</tr>

		<%		catcounter  = catcounter  +1
				rsx.movenext
			Wend		
			rsx.close
			%>
			</table>
</td>
</tr>
</table>
	<% end if	%>



</td>
</tr>
</table>
<% else %>

<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%>" >
<tr><td  class = "body" >
<center><a href = "/Administration/AdminGalleryAddImage1.asp" class = "body"><b>Add Images</b></a><img src = "images/px.gif" height = "1" width = "20%" />
<a href = "/Administration/AdminGallerySetCategories.asp" class = "body"><b>Gallery Categories</b></a></center><br /><br />

		<H1><div align = "left">List of Photo Galleries</div></H1>
  </td></tr>     
<%  
sqlx =  "select * from Gallerycategories  order by GalleryCatID"
			
Set rsx = Server.CreateObject("ADODB.Recordset")
rsx.Open sqlx, conn, 3, 3 
catcounter = 0
if Not rsx.eof  then %>




<% row = "odd"
While Not rsx.eof  
 If row = "even" Then 
    row = "odd" %>
		<tr bgcolor = "white">
<% Else 
row = "even"%>
<tr bgcolor = "#e6e6e6">
<%	End If %>
<td class= "body2" align = "center" height = "40"><br>
<a href = "AdminGalleryEditImages.asp?GalleryCatID=<%= rsx("GalleryCatID") %>#BasicFacts" class = "body"><b><%= rsx("GalleryCategoryName") %></b></a><br>
</td>

<td class = "body2" width = "30" align = "right"><img src= "images/edit.gif" alt = "edit" height = "18"  border = "0">Edit</td>
</tr>

		<%		catcounter  = catcounter  +1
				rsx.movenext
			Wend		
			rsx.close
			%>
			</table>

	<% end if	%>



<% end if %>
<br>
  <!--#Include File="AdminFooter.asp"-->
</Body>
  </HTML>