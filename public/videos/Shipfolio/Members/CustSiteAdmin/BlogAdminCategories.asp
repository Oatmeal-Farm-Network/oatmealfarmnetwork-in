<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<!--#Include virtual="/administration/BlogAdmin/BlogAdminGlobalVariables.asp"--> 
<link rel="stylesheet" type="text/css" href="/administration/style.css">
</head>
<% if mobiledevice = True  then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<% end if %>

<!--#Include virtual="/administration/AdminHeader.asp"--> 
<% Current3 = "BlogCategories"  %>
<!--#Include virtual="/administration/BlogAdmin/BlogAdminTabsInclude.asp"--> 
<% PageName="Blog" %>
 <% TempCategoryType="For Sale" %>
 <% Dim BlogCatID(100,100)
Dim BlogCategoryName(100,100)
dim BlogCategoryOrder(100,100)
dim BlogCategoryDisplay(100,100)
 if mobiledevice = False  then %> 
 	<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth  %>"><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Blog Categories</div></H2>
</td></tr>
<tr><td class = "roundedBottom" align = "center" height = "300" width = "100%"  valign = "top">
 <table width = "100%">
     <tr> 
     <% if screenwidth < 700 then %>
<td width = "50%" valign = "top" align = "left">
      <% else %>
   <td width = "100%" valign = "top" align = "left">
      <% end if %>

<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%" class = "roundedtopandbottom"><tr><td  align = "left">
		<H2><div align = "left">Current Blog Categories</div></H2>
</td></tr>
<tr><td class = "body" align = "left" valign = "top" colspan = "2">
To change category titles, change the title names and select the corresponding submit button.
<% Changesmade = request.querystring("ChangesMade")
if ChangesMade="True" then%>
<br><br><font color = "maroon"><b>Your Changes Have Been Made.</b></font>
<% end if  %>

 </td>
 </tr>
 <tr><td colspan = "3"><form action= 'BlogAdminCategoryEdit.asp' method = "post" style="margin-bottom:0;" >
<div align = "right"><input type=submit value = "Submit"  class = "regsubmit2" ></div>
</td>
</tr>
 <tr>
<td class = "body" align = "center"><b>Name</b></td>
<td class = "body2" align = "center" width = "179" align = "center"><b>Display</b></td>
<td class = "body2" align = "center" width = "79" align = "center"><b>Order</b></td>
</tr>
<% 
sql = "select * from BlogCategories order by BlogCategoryOrder " 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3 
CatCounter= 0
While Not rs.eof 
CatCounter = CatCounter + 1
BlogCatID(CatCounter,0) = rs("BlogCatID")
BlogCategoryName(CatCounter,0) = rs("BlogCategoryName")
BlogCategoryOrder(CatCounter,0) = rs("BlogCategoryOrder")
BlogCategoryDisplay(CatCounter,0) = rs("BlogCategoryDisplay")
rs.movenext
Wend
FinalCatCounter = CatCounter

CatCounter= 0
SubCatCounter2 = 0
While CatCounter < FinalCatCounter
CatCounter= CatCounter +1 %>
<tr><td> 
<div style="display: inline;" align = "left">
<input name="BlogCategoryName(<%=CatCounter%>)" value ="<%= BlogCategoryName(CatCounter,0) %>"  size = "40">
</td>
<td class="body2" align = "center">
<% if  BlogCategoryDisplay(CatCounter,0)= "Yes" Or  BlogCategoryDisplay(CatCounter,0) = True Then %>
Yes<input TYPE="RADIO" name="BlogCategoryDisplay(<%=CatCounter%>)" Value = "Yes" checked>
No<input TYPE="RADIO" name="BlogCategoryDisplay(<%=CatCounter%>)" Value = "No" >
<% Else %>
Yes<input TYPE="RADIO" name="BlogCategoryDisplay(<%=CatCounter%>)" Value = "Yes" >
No<input TYPE="RADIO" name="BlogCategoryDisplay(<%=CatCounter%>)" Value = "No" checked>
<% End If %>
   
 </td>
<td>
<select size="1" name="BlogCategoryOrder(<%=CatCounter%>)">	
<option  value= "<%= BlogCategoryOrder(CatCounter,0) %>" selected><%= BlogCategoryOrder(CatCounter,0) %></option>
<%	PGCounter = 0 
While PGCounter < (FinalCatCounter ) 
PGCounter = PGCounter +1 
if PGCounter =  BlogCategoryOrder(CatCounter,0) then
else %>
<option  value="<%= PGCounter %>"><%= PGCounter %></option>
<% 
end if
Wend %>
		</select>
</td>

  <td>
<input name="BlogCatID(<%=CatCounter%>)" value ="<%=BlogCatID(CatCounter,0)%>"  type="hidden">

  </td>
</tr>
<% 
wend
%>
<tr><td colspan = "3">
<input name="TotalCount" value ="<%=PGCounter %>"  type="hidden">
<div align = "right"><input type=submit value = "Submit"  class = "regsubmit2" ></div>
</form>
</td>
</tr>
</table>
		
</td>
<%if screenwidth < 700 then %>
 </tr>
 <tr>      
<% end if %>
<% if mobiledevice = False then %> 
<%if screenwidth < 700 then %>
  <td width = "100%" valign = "top" >
  <% else %>
   <td width = "50%" valign = "top">
  <% end if %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%" ><tr><td class = "roundedtop" align = "left">
<% else %>
 <td width = "100%" valign = "top">
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%"><tr><td align = "left">

<% end if %>

		<H2><div align = "left">Add a New Category</div></H2>
</td></tr>
<tr><td class = "roundedBottom body" align = "center" height = "110" width = "100%"valign = "top">
 		<br>
			<form action= 'BlogAdminAddcatHandleform.asp' method = "post">
<table border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "left" valign ="top"width = "400">
<tr><td width = "200" class = "body2" align = "right">
New Category:
					</td>
					<td class = "body">
							<input name="NewCategory" size = "30">
							<input name="BlogCategoryName" type = "hidden" Value = "<%=TempCategoryType%>">
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

		<H2><div align = "left">Delete Blog Categories</div></H2>
</td></tr>
<tr><td class = "roundedBottom body" align = "center"  valign = "top" width = "430">

<h1><center>Warning! </center></h1>
<b>When you delete a category  you will loose all Blogs with that category! Even if you create a new category with the same name, the old Blogs will not automatically be reassigned!</b><br><br>

<form action= 'AdminBlogCatDeleteHandleform.asp' method = "post">
	<input name="CategoryType" type = "hidden" Value = "<%=TempCategoryType%>">
	<input   name="DeleteCategoryType" type = "hidden" value = "Category">	
				<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "left"  valign ="top" >
				
			<tr>
					<td width = "140" class = "body2" align = "right">
							Category:
					</td>
					<td class = "body" >
							<select size="1" name="BlogCatID">	
							<option  value= "" selected>select a category</option>
						<%	CatCounter = 0 
								While CatCounter < (FinalCatCounter ) 
								CatCounter = CatCounter +1 
						%>
								 <option  value="<%= BlogCatID(CatCounter,0) %>"><%= BlogCategoryName(CatCounter,0) %></option>
	
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
		<H1><div align = "left">Blog Categories</div></H1>
</td></tr>
<tr><td align = "left" width = "100%" class = "body">  
<a href = "/Administration/AdminBlogMaintenance.asp?PeopleID=<%=session("PeopleID") %>#Blogs" class = "body">List of Blogs</a><br />
<a href = "/Administration/AdminBlogAdd.asp?PeopleID=<%=session("PeopleID") %>" class = "body">Add an Blog</a><br />
<a href = "/Administration/AdminBlogDelete.asp?PeopleID=<%=session("PeopleID") %>" class = "body">Delete Blogs</a><br />
<a href = "/Administration/AdminBlogCategoriesSet.asp?PeopleID=<%=session("PeopleID") %>" class = "body">Blog Categories</a>
</td>
</tr>

<Tr><td>
<H2><div align = "left">Edit Categories</div></H2> <form action= 'AdminBlogCategoryEdit.asp' method = "post" style="margin-bottom:0;" >


</td></Tr>


<% 



conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(databasepath) & ";" & _
						"User Id=;Password=;" 

			 sql = "select * from BlogCategories where  not (Blogcatid = 2 ) order by BlogCategoryName " 
		
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3 
	CatCounter= 0
	 While Not rs.eof 
		CatCounter = CatCounter + 1
		BlogCatID(CatCounter,0) = rs("BlogCatID")
		BlogCategoryName(CatCounter,0) = rs("BlogCategoryName")
		
		rs.movenext
	Wend
		FinalCatCounter = CatCounter

CatCounter= 0
SubCatCounter2 = 0
While CatCounter < FinalCatCounter
	CatCounter= CatCounter +1 %>
   
<tr><td>

			<input name="BlogCategoryName" value ="<%= BlogCategoryName(CatCounter,0) %>"  size = "30" class = "regsubmit2 body" >
			<input name="categorytype" value ="category"  type="hidden">
			
				<input name="BlogCatID" value ="<%=BlogCatID(CatCounter,0)%>"  type="hidden">
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
			<form action= 'AdminBlogCatAddHandleform.asp' method = "post">
				<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center"  valign ="top" width = "100%">
				<tr>
						<td  class = "body">
							New Category:<br />
	
							<input name="NewCategory" size = "30" class = "regsubmit2 body" >
							<input name="BlogCategoryName" type = "hidden" Value = "<%=TempCategoryType%>">
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

		<H2><div align = "left">Delete Blog Categories</div></H2>
</td></tr>
<tr><td class = "body" align = "left"  valign = "top" width = "430">

<h1><center>Warnings! </center></h1>
<b>When you delete a category  you will loose all Blogs with that category!</b><br><br>
<form action= 'AdminBlogCatDeleteHandleform.asp' method = "post">
	<input name="CategoryType" type = "hidden" Value = "<%=TempCategoryType%>">
	<input   name="DeleteCategoryType" type = "hidden" value = "Category">	
			
			<tr>
					<td class = "body" align = "right" width = '100'>
							Category:</td>
						<td class = "body" align = "left">
							<select size="1" name="BlogCatID"  class = "regsubmit2 body">	
							<option  value= "" selected>select a category</option>
						<%	CatCounter = 0 
								While CatCounter < (FinalCatCounter ) 
								CatCounter = CatCounter +1 
						%>
								 <option  value="<%= BlogCatID(CatCounter,0) %>"><%= BlogCategoryName(CatCounter,0) %></option>
	
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