<!DOCTYPE HTML>

<HTML>
<HEAD>
<title>The Andresen Group Content Management System</title>
<link rel="stylesheet" type="text/css" href="style.css">
</HEAD>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">

    <!--#Include File="AdminSecurityInclude.asp"--> 
    <!--#Include File="AdminGlobalVariables.asp"--> 
    <!--#Include File="AdminHeader.asp"--> 
    <% Current3 = "ListOfPages" %>
<!--#Include file="AdminPagesTabsInclude.asp"-->
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth %>"><tr><td class = "roundedtop" align = "left">
		<H1><div align = "left">List of Pages</div></H1>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" >
       <table border = "0" cellspacing="0" cellpadding = "0" align = "right" ><tr><td >


<table border = "0" cellspacing="0" cellpadding = "0" align = "right" width = "160"><tr><td class = "roundedtop" align = "left">
		<H3><div align = "left">Key</div></H3>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center">
<table border = "0" cellpadding = "0" cellspacing="0"  align = "right" width = "100%">
 <tr>
 
  <td class = "body" width = "30" align = "right"><img src= "images/edit.gif" alt = "edit" height = "18"  border = "0"></td>
 <td class = "body" width=  "35">Edit</td>
 
   <td class = "body" width = "30" align = "right"><img src = "images/Photo.gif" height = "18" border = "0" alt = "Upload Photos"></td>
 <td class = "body" width=  "40" align = "left">Photos</td>
   
    <td></td>
    
    </tr>
</table>
</td>
    
    </tr>
</table>
</td></tr>
<tr>
<td height ="10">
</td></tr>
<tr>
<td> 
          
<%  
row = "even"

conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" 
	sql2 = "select * from PageLayout  order by PageName "

	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	PageGroupID = rs2("PageGroupID")
	recordcount = rs2.recordcount
	if not  rs2.eof then
	  PageLayoutID = rs2("PageLayoutID") 
	    sql = "select * from PageGroups where PageGroupID = " & PageGroupID & ""
	  ' response.Write(sql) 
	    Set rs = Server.CreateObject("ADODB.Recordset")
	    rs.Open sql, conn, 3, 3
	    if not  rs.eof then
	    PageGroupTitle = PageGroupTitle
end if
	%>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" >
			<tr><td class = "roundedtop" align = "left">
	 
			<table><tr><td class = "body" width = "450"><b>Name</b></td>
			<td class = "body" width = "350"><b>Page Group</b></td>
			<td class = "body" width = "100"><b>Options</b></td></tr></table>
	</td></tr>
     <tr><td class = "roundedBottom" align = "center" width = "960"> 
<%	While Not rs2.eof  
	  PageLayoutID = rs2("PageLayoutID") 
	    sql = "select * from PageLayout, Pagegroups where PageLayout.PageGroupID =  Pagegroups.PageGroupID "
	 ' response.Write(sql) 
	   catName1 = ""
	    Set rs = Server.CreateObject("ADODB.Recordset")
	    rs.Open sql, conn, 3, 3
	   
 If row = "even" Then 
 row = "odd"
 %>
		<table border = "0" cellpadding=0 cellspacing=0  width = "100%" align = "center" >
<% Else 
row = "even"%>

<table border = "0" cellpadding=0 cellspacing=0  width = "100%" align = "center" bgcolor = "#e6e6e6">
<%	End If %>


		<tr><td class= "body" width = "450">
	<% if rs2("PageName")  = "Home Page" then %>
	<a href = "AdminHomePage.asp" class = "body">Home Page</a>
	<% else %>
<a href = "AdminPagedata.asp?PageLayoutID=<%= rs2("PageLayoutID") %>#BasicFacts" class = "body"><%=rs2("PageName")%></a>
<% end if %>
</td>
<td class= "body" width = "350">
<%= PageGroupTitle %> 
</td>
<td class= "body" width = "100">
<% if rs2("PageName")  = "Home Page" then %>
<a href = "AdminHomePage.asp" class = "body">&nbsp;&nbsp;<img src= "images/edit.gif" alt = "edit" height ="12" border = "0"></a>
 <% if SlideshowAvailable = True then %>
|&nbsp;<a href = "/Administration/AdminGalleryEditImages.asp?GalleryCatID=3" ><img src = "images/Photo.gif" height = "18" border = "0" alt = "Slideshow Photos"></a>
<% end if %>



<% else %>
<a href = "AdminPagedata.asp?PageLayoutID=<%= rs2("PageLayoutID") %>#BasicFacts" class = "body">&nbsp;&nbsp;<img src= "images/edit.gif" alt = "edit" height ="12" border = "0"></a>|&nbsp;<a href = "AdminPageDelete.asp?PageLayoutID=<%= rs2("PageLayoutID") %>" class = "body"><img src= "images/Delete.gif" alt = "edit" height ="14" border = "0"></a>

|&nbsp;<a href = "AdminProductPhotos.asp?PageLayoutID=<%= rs2("PageLayoutID") %>" class = "body"><img src = "images/Photo.gif" height = "18" border = "0" alt = "Upload Photos"></a>
<% end if %>
</td>
</tr>
</table>
		<%		catcounter  = catcounter  +1
				rs2.movenext
			Wend		
			FinalCatCounter = catcounter 
end if
			rs2.close%>
</td>
</tr>
</table><br />
</td>
</tr>
</table>
</td>
</tr>
</table>
<br />
  <!--#Include File="AdminFooter.asp"-->
</Body>
  </HTML>