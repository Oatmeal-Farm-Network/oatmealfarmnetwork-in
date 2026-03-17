<!DOCTYPE HTML>

<HTML>
<HEAD>
<title>The Andresen Group Content Management System</title>
       <link rel="stylesheet" type="text/css" href="style.css">
</HEAD>
<body >
<% TempCategoryType="For Sale"
%>

    <!--#Include file="AdminSecurityInclude.asp"--> 
    <!--#Include file="AdminGlobalVariables.asp"--> 
    <!--#Include file="AdminHeader.asp"--> 
<%  Current3="GalleryCategories" %> 
<%
Dim GalleryCatID(100,100)
Dim GalleryCategoryName(100,100)
Dim GalleryCategoryShow(100,100)
 if mobiledevice = False  then %>

<!--#Include file="AdminGalleryTabsInclude.asp"-->
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width =<%=screenwidth - 35 %>><tr><td class = "roundedtop" align = "left">
<H2><div align = "left">Photo Galleries</div></H2>
</td></tr>
<tr><td class = "roundedBottom body" align = "center" width = "100%" valign = "top" >   
<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%"  align = "center"  valign = "top">
	<tr>
		<td width = "100%"  class = "body" valign = "top" colspan ="3">
		<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%"><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Edit Existing Galleries</div></H2>
        </td></tr>
        <tr><td class = "roundedBottom body" align = "center" width = "100%"  valign = "top" >   
        
        
		<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%">
        <tr>
        <td class = "body" align = "center"><b>Name</b></td>
         <td class = "body" align = "center"><b>Display Page</b></td>
          <td></td>
        </tr>
<% 
 sql = "select * from GalleryCategories  order by GalleryCategoryName " 
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3 
	CatCounter= 0
	 While Not rs.eof 
		CatCounter = CatCounter + 1
		GalleryCatID(CatCounter,0) = rs("GalleryCatID")
		GalleryCategoryName(CatCounter,0) = rs("GalleryCategoryName")
		GalleryCategoryShow(CatCounter,0) = rs("GalleryCategoryShow")
		'response.write(GalleryCategoryName(CatCounter,0))
		rs.movenext
	Wend
		FinalCatCounter = CatCounter

CatCounter= 0
SubCatCounter2 = 0
While CatCounter < FinalCatCounter
	CatCounter= CatCounter +1 %>
   
		<tr><td width = "140"> <form action= 'AdminGalleryEditCategory.asp' method = "post" style="margin-bottom:0;" >
			<div style="display: inline;">
			<input name="GalleryCategoryName" value ="<%= GalleryCategoryName(CatCounter,0) %>"  size = "38">
			</td>
			<td class = "body" width = "100"> 
				<% 	if not GalleryCategoryName(CatCounter,0) = "Home Page Slideshow" then
		if GalleryCategoryShow(CatCounter,0) = "Yes" Or GalleryCategoryShow(CatCounter,0) = True Then %>
			Yes<input TYPE="RADIO" name="GalleryCategoryShow" Value = "Yes" checked>
			No<input TYPE="RADIO" name="GalleryCategoryShow" Value = "No" >
		<% Else %>
			Yes<input TYPE="RADIO" name="GalleryCategoryShow" Value = "Yes" >
			No<input TYPE="RADIO" name="GalleryCategoryShow" Value = "No" checked>
		<% End If %>
			<% End If %>
			</td>
			<td>
			<input name="categorytype" value ="category"  type="hidden">
			<% 	if not GalleryCategoryName(CatCounter,0) = "Home Page Slideshow" then %>
				<input name="GalleryCatID" value ="<%=GalleryCatID(CatCounter,0)%>"  type="hidden">
			<input type=submit value = "submit"  class = "regsubmit2" ></div>
				<% End If %>
			</form>
		</td>
		</tr>

		

	<% 
	
wend


%>

		</table>
</td><tr></table></tr>
		</td>
		<td width = "5" align = "center"></td>
		<td width = "100%"   class = "body" valign = "top">
		<br />	

			<form action= 'AdminGalleryAddCatHandleForm.asp' method = "post">
				<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%"><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Add a New Gallery</div></H2>
        </td></tr>
        <tr><td class = "roundedBottom body" align = "center" width = "100%"   valign = "top" > 
        
			
			
				<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center"  valign ="top" >
						<td width = "280" class = "body"><div align = "right">
							New Gallery:</div>
					</td>
					<td class = "body">
							<input name="NewCategory" size = "30">
							<input name="CategoryType" type = "hidden" Value = "<%=TempCategoryType%>">
					</td>
			</tr>
			<tr>
					<td  align = "center" valign = "middle" colspan = "2" class = "body">
						<center><input type=submit value = "Add Category"  class = "regsubmit2"></center>
					</td>
			</tr>
			
		
</td>
</tr>
</table>
</td>
</tr>
</table>	</form>
<br />
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%"><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Delete a Gallery</div></H2>
        </td></tr>
        <tr><td class = "roundedBottom body" align = "center" width = "100%"  valign = "top" > 
        
<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center"  valign ="top" width = "100%">
<tr><td class = "body">
<h32><center>Warning! </center></h2>
When you delete a Gallery you will loose all Images with that Gallery! Even if you create a new Gallery with the same name, the old images will <b>not</b> automatically be reassigned!<br><br>

			
<form action= 'AdminGalleryDeleteCatHandleForm.asp' method = "post">
	<input name="CategoryType" type = "hidden" Value = "<%=TempCategoryType%>">
	<input   name="DeleteCategoryType" type = "hidden" value = "Category">	
				<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center"  valign ="top" >
				
			<tr>
					<td width = "140" class = "body"><div align = "right">
							Gallery:</div>
					</td>
					<td class = "body" >
							<select size="1" name="GalleryCatID">	
							<option  value= "" selected>select a Gallery</option>
						<%	CatCounter = 0 
								While CatCounter < (FinalCatCounter) 
								CatCounter = CatCounter +1 
                                if not GalleryCatID(CatCounter,0) = 3 then
						%>
								 <option  value="<%= GalleryCatID(CatCounter,0) %>"><%= GalleryCategoryName(CatCounter,0) %></option>
	
							<% end if
							Wend %>
							</select>
					</td>
			</tr>
		
			<tr>
					<td  align = "center" valign = "middle" colspan = "2">
						<input type=submit value = "Delete a Gallery" class = "regsubmit2" >
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
	
   </td>
   </tr>
</table>    

   </td>
   </tr>
</table>    <br /><br />

<% else %>



<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%= screenwidth %>">
        <tr><td class = "body" align = "center"  colspan = "2" valign = "top" >   
        <a href = "/Administration/AdminGalleryHome.asp" class = "body"><b>Galleries</b></a><img src = "images/px.gif" height = "1" width = "6%" />
<a href = "/Administration/AdminGalleryAddImage1.asp" class = "body"><b>Add Images</b></a><img src = "images/px.gif" height = "1" width = "6%" /></center><br /><br />


        
		<H2><div align = "left">Edit Existing Gallery Categories</div></H2><br />
        </td></tr>
        <tr><td class = "body" align = "center" width = "100%"   valign = "top" >   
        
        
		<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%">
        
<% 
conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(databasepath) & ";" & _
						"User Id=;Password=;" 

			 sql = "select * from GalleryCategories  order by GalleryCategoryName " 
			'response.write(sql2)
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3 
	CatCounter= 0
	 While Not rs.eof 
		CatCounter = CatCounter + 1
		GalleryCatID(CatCounter,0) = rs("GalleryCatID")
		GalleryCategoryName(CatCounter,0) = rs("GalleryCategoryName")
		GalleryCategoryShow(CatCounter,0) = rs("GalleryCategoryShow")
		'response.write(GalleryCategoryName(CatCounter,0))
		rs.movenext
	Wend
		FinalCatCounter = CatCounter

CatCounter= 0
SubCatCounter2 = 0
While CatCounter < FinalCatCounter
	CatCounter= CatCounter +1 %>
   
		<tr><td class = "body"> 
		
			<% 	if not GalleryCategoryName(CatCounter,0) = "Home Page Slideshow" then %>
			<form action= 'AdminGalleryEditCategory.asp' method = "post" style="margin-bottom:0;" >
			<input name="GalleryCategoryName" value ="<%= GalleryCategoryName(CatCounter,0) %>"  size = "30" class = "regsubmit2 body"><br />

				<input name="GalleryCatID" value ="<%=GalleryCatID(CatCounter,0)%>"  type="hidden">
			<center><input type=submit value = "submit"  class = "regsubmit2" ></center>
				</form>
				<% End If %>
		
		</td>
		</tr>
	<% 
	
wend


%>

<tr><td class = "body">
	<form action= 'AdminGalleryAddCatHandleForm.asp' method = "post">

       <b>Add a New Category:</b><br />
		<input name="NewCategory" size = "30" class = "regsubmit2 body">
		<input name="CategoryType" type = "hidden" Value = "<%=TempCategoryType%>"><br />
        <center><input type=submit value = "Add Category"  class = "regsubmit2"></center>
        </form>
	
<form action= 'AdminGalleryDeleteCatHandleForm.asp' method = "post">
	<input name="CategoryType" type = "hidden" Value = "<%=TempCategoryType%>">
	<input   name="DeleteCategoryType" type = "hidden" value = "Category">	
<b>Delete a Category:</b><br>
<select size="1" name="GalleryCatID" class = "regsubmit2 body">	
<option  value= "" selected>Select a Gallery</option>
<%	CatCounter = 0 
While CatCounter < (FinalCatCounter) 
CatCounter = CatCounter +1 
%>
<option  value="<%= GalleryCatID(CatCounter,0) %>"><%= GalleryCategoryName(CatCounter,0) %></option>
<% Wend %>
</select>
<center><input type=submit value = "Delete a Category" class = "regsubmit2" ></center>
</form>
</td>
</tr>
</table>
</td>
</tr>
</table>

<% end if %>
<br>
<!--#Include file="AdminFooter.asp"--> </Body>
</HTML>