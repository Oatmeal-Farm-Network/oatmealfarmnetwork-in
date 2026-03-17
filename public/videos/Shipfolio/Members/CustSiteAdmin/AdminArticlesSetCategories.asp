<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<link rel="stylesheet" type="text/css" href="/administration/style.css">
<!--#Include virtual="/administration/AdminGlobalVariables.asp"--> 
</head>
<% if mobiledevice = True  then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<% end if %>
<!--#Include virtual="/administration/AdminHeader.asp"--> 
<br />
<% Current3 = "GalleryCategories"  %>
<!--#Include virtual="/administration/AdmingalleryTabsInclude.asp"--> 
<% PageName="Gallery" %>
 <% TempCategoryType="For Sale" %>
 <% Dim GalleryCatID(100,100)
Dim GalleryCategoryName(100,100)
dim GalleryCategoryOrder(100,100)
dim GalleryCategoryShow(100,100)
 if mobiledevice = False  then %> 
 	<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth  %>"><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Gallery Categories</div></H2>
</td></tr>
<tr><td class = "roundedBottom" align = "center" width = "100%"  valign = "top">
 <table width = "100%">
     <tr> 

<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%" ><tr><td  align = "left" colspan = "5">
		<H2><div align = "left">Current Gallery Categories</div></H2>
</td></tr>
<tr><td class = "body" align = "left" valign = "top" colspan = "5">
To change category titles, change the title names and select the corresponding submit button.
<% Changesmade = request.querystring("ChangesMade")
if ChangesMade="True" then%>
<br><br><font color = "maroon"><b>Your Changes Have Been Made.</b></font>
<% end if  %>

 </td>
 </tr>
 <tr><td colspan = "5"><form action= 'AdminGalleryEditCategory.asp' method = "post" style="margin-bottom:0;" >
<div align = "right"><input type=submit value = "Submit"  class = "regsubmit2" ></div>
</td>
</tr>
 <tr>
 <td class = "body" align = "center" width = "50"></td>
<td class = "body" align = "center"><b>Name</b></td>
<td class = "body2" align = "center" width = "179" align = "center"><b>Display</b></td>
<td class = "body2" align = "center" width = "79" align = "center"><b>Order</b></td>
<td class = "body" align = "center"><b>Options</b></td>
</tr>
<% 
sql = "select * from GalleryCategories order by GalleryCategoryOrder " 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3 
CatCounter= 0
While Not rs.eof 
CatCounter = CatCounter + 1
GalleryCatID(CatCounter,0) = rs("GalleryCatID")
GalleryCategoryName(CatCounter,0) = rs("GalleryCategoryName")
GalleryCategoryOrder(CatCounter,0) = rs("GalleryCategoryOrder")
GalleryCategoryShow(CatCounter,0) = rs("GalleryCategoryShow")
rs.movenext
Wend
FinalCatCounter = CatCounter

CatCounter= 0
SubCatCounter2 = 0
While CatCounter < FinalCatCounter
CatCounter= CatCounter +1 %>
<tr><td class = "body" width = "100"> 
<a href = "AdminGalleryEditImages.asp?GalleryCatID=<%=GalleryCatID(CatCounter,0)%>#BasicFacts" class = "body">
Edit Gallery</a></td>
<td><input name="GalleryCategoryName(<%=CatCounter%>)" value ="<%= GalleryCategoryName(CatCounter,0) %>"  size = "40"></td>
<td class="body2" align = "center">
<% if  GalleryCategoryShow(CatCounter,0)= "Yes" Or  GalleryCategoryShow(CatCounter,0) = True Then %>
Yes<input TYPE="RADIO" name="GalleryCategoryShow(<%=CatCounter%>)" Value = "Yes" checked>
No<input TYPE="RADIO" name="GalleryCategoryShow(<%=CatCounter%>)" Value = "No" >
<% Else %>
Yes<input TYPE="RADIO" name="GalleryCategoryShow(<%=CatCounter%>)" Value = "Yes" >
No<input TYPE="RADIO" name="GalleryCategoryShow(<%=CatCounter%>)" Value = "No" checked>
<% End If %>
</td>
<td width = "100">
<select size="1" name="GalleryCategoryOrder(<%=CatCounter%>)">	
<option  value= "<%= GalleryCategoryOrder(CatCounter,0) %>" selected><%= GalleryCategoryOrder(CatCounter,0) %></option>
<%	PGCounter = 0 
While PGCounter < (FinalCatCounter ) 
PGCounter = PGCounter +1 
if PGCounter =  GalleryCategoryOrder(CatCounter,0) then
else %>
<option  value="<%= PGCounter %>"><%= PGCounter %></option>
<% 
end if
Wend %>
</select>
</td>
<td width = "30">
<input name="GalleryCatID(<%=CatCounter%>)" value ="<%=GalleryCatID(CatCounter,0)%>"  type="hidden">
<a href = "AdminGalleryEditImages.asp?GalleryCatID=<%=GalleryCatID(CatCounter,0)%>#BasicFacts" class = "body">
&nbsp;&nbsp;<img src= "images/edit.gif" alt = "edit" height ="12" border = "0"></a>
<% if not (GalleryCategoryName(CatCounter,0)  = "Home Page Slideshow" ) then %>|&nbsp;<a href = "#Delete" class = "body"><img src= "images/Delete.gif" alt = "edit" height ="14" border = "0"></a>
<% end if %>
</td>
</tr>
<% 
wend
%>
<tr><td colspan = "5">
<input name="TotalCount" value ="<%=PGCounter %>"  type="hidden">
<div align = "right"><input type=submit value = "Submit"  class = "regsubmit2" ></div>
</form>
</td>
</tr>
</table>
	
</td>
 </tr>
 <tr>      
 <td width = "100%" valign = "top">
 <br />
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%" class = "roundedtopandbottom"><tr><td align = "left">

		<H2><div align = "left">Add a New Category</div></H2>
</td></tr>
<tr><td class = " body" align = "center" height = "110" width = "100%"valign = "top">
 		<br>
			<form action= 'AdminGalleryAddCatHandleForm.asp' method = "post">
<table border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "left" valign ="top"width = "400">
<tr><td width = "200" class = "body2" align = "right">
New Category:
					</td>
					<td class = "body">
							<input name="NewCategory" size = "30">
							<input name="GalleryCategoryName" type = "hidden" Value = "<%=TempCategoryType%>">
					</td>
			</tr>
			<tr>
					<td  align = "center" valign = "middle" colspan = "2" >
						<center><input type=submit value = "Add Category"  size = "110" class = "regsubmit2"  ></center>
					</td>
			</tr>
			</table>
			</form>
</td>
</tr>
</table>
<br />
  <% if mobiledevice = False  then %> 
  <table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%"  ><tr><td class = "roundedtop" align = "left">
  <% else %>
  <table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%"  ><tr><td align = "left">
  
  <% end if %>
  <a name = "Delete"></a>
		<H2><div align = "left">Delete Gallery Categories</div></H2>
</td></tr>
<tr><td class = "roundedBottom body" align = "center"  valign = "top" width = "430">

<h1><center>Warning! </center></h1>
<b>When you delete a category  you will loose all Gallerys with that category! Even if you create a new category with the same name, the old Gallerys will not automatically be reassigned!</b><br><br>

<form action= 'AdminGalleryDeleteCatHandleForm.asp' method = "post">
	<input name="CategoryType" type = "hidden" Value = "<%=TempCategoryType%>">
	<input   name="DeleteCategoryType" type = "hidden" value = "Category">	
				<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "left"  valign ="top" >
				
			<tr>
					<td width = "140" class = "body2" align = "right">
							Category:
					</td>
					<td class = "body" >
							<select size="1" name="GalleryCatID">	
							<option  value= "" selected>select a category</option>
						<%	CatCounter = 0 
								While CatCounter < (FinalCatCounter ) 
								CatCounter = CatCounter +1 
						%>
								 <option  value="<%= GalleryCatID(CatCounter,0) %>"><%= GalleryCategoryName(CatCounter,0) %></option>
	
							<% 
							Wend %>
							</select>
					</td>
			</tr>
		
			<tr>
					<td  align = "center" valign = "middle" colspan = "2">
						<input type=submit value = "Delete a Category"  size = "110" class = "regsubmit2" >
					</td>
			</tr>
			</table>
			</form>

</td>
   </tr>
</table>


</td></tr></table>
  </td></tr></table>      



</td>
</tr>
</table>
  <% else %>

<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%"><tr><td align = "left">
		<H1><div align = "left">Gallery Categories</div></H1>
</td></tr>
<tr><td align = "left" width = "100%" class = "body">  
<a href = "/Administration/AdminGalleryMaintenance.asp?PeopleID=<%=session("PeopleID") %>#Gallerys" class = "body">List of Gallerys</a><br />
<a href = "/Administration/AdminGalleryAdd.asp?PeopleID=<%=session("PeopleID") %>" class = "body">Add an Gallery</a><br />
<a href = "/Administration/AdminGalleryDelete.asp?PeopleID=<%=session("PeopleID") %>" class = "body">Delete Gallerys</a><br />
<a href = "/Administration/AdminGalleryCategoriesSet.asp?PeopleID=<%=session("PeopleID") %>" class = "body">Gallery Categories</a>
</td>
</tr>

<Tr><td>
<H2><div align = "left">Edit Categories</div></H2> <form action= 'AdminGalleryCategoryEdit.asp' method = "post" style="margin-bottom:0;" >


</td></Tr>


<% 



conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(databasepath) & ";" & _
						"User Id=;Password=;" 

			 sql = "select * from GalleryCategories where  not (Gallerycatid = 2 ) order by GalleryCategoryName " 
		
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3 
	CatCounter= 0
	 While Not rs.eof 
		CatCounter = CatCounter + 1
		GalleryCatID(CatCounter,0) = rs("GalleryCatID")
		GalleryCategoryName(CatCounter,0) = rs("GalleryCategoryName")
		
		rs.movenext
	Wend
		FinalCatCounter = CatCounter

CatCounter= 0
SubCatCounter2 = 0
While CatCounter < FinalCatCounter
	CatCounter= CatCounter +1 %>
   
<tr><td>

			<input name="GalleryCategoryName" value ="<%= GalleryCategoryName(CatCounter,0) %>"  size = "30" class = "regsubmit2 body" >
			<input name="categorytype" value ="category"  type="hidden">
			
				<input name="GalleryCatID" value ="<%=GalleryCatID(CatCounter,0)%>"  type="hidden">
			<input type=submit value = "Edit"  class = "regsubmit2 body" >
			</form>
		</td>
		</tr>
<% 
wend
%>
<tr><td align = "left"><br />
		<H2><div align = "left">Add a New Category</div></H2>
</td></tr>
<tr><td class = "body" align = "center" width = "100%" valign = "top">
 		<br>
			<form action= 'AdminGalleryCatAddHandleform.asp' method = "post">
				<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center"  valign ="top" width = "100%">
				<tr>
						<td  class = "body">
							New Category:<br />
	
							<input name="NewCategory" size = "30" class = "regsubmit2 body" >
							<input name="GalleryCategoryName" type = "hidden" Value = "<%=TempCategoryType%>">
					</td>
			</tr>
			<tr>
					<td  align = "center" valign = "middle" colspan = "2" class = "body">
						<center><input type=submit value = "Add Category" class = "regsubmit2 body" ></center>
					</td>
			</tr>
			</table>
			</form>
</td>
</tr>
<tr><td align = "left">
<br />

		<H2><div align = "left">Delete Gallery Categories</div></H2>
</td></tr>
<tr><td class = "body" align = "left"  valign = "top" width = "430">

<h1><center>Warnings! </center></h1>
<b>When you delete a category  you will loose all Gallerys with that category!</b><br><br>
<form action= 'AdminGalleryCatDeleteHandleform.asp' method = "post">
	<input name="CategoryType" type = "hidden" Value = "<%=TempCategoryType%>">
	<input   name="DeleteCategoryType" type = "hidden" value = "Category">	
			
			<tr>
					<td class = "body" align = "right" width = '100'>
							Category:</td>
						<td class = "body" align = "left">
							<select size="1" name="GalleryCatID"  class = "regsubmit2 body">	
							<option  value= "" selected>select a category</option>
						<%	CatCounter = 0 
								While CatCounter < (FinalCatCounter ) 
								CatCounter = CatCounter +1 
						%>
								 <option  value="<%= GalleryCatID(CatCounter,0) %>"><%= GalleryCategoryName(CatCounter,0) %></option>
	
							<% 
							Wend %>
							</select>
					</td>
			</tr>
		
			<tr>
					<td  align = "center" valign = "middle" colspan = "2">
						<input type=submit value = "Delete a Category" class = "regsubmit2 body" >
					</td>
			</tr>
			</table>
			</form>
</td>
   </tr>
</table><br>
  <% end if %> 
  <br><br>
<br>
<!--#Include virtual="/administration/AdminFooter.asp"--> 
</Body>
</HTML>