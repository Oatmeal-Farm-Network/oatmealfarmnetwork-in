<%@ Language="VBScript" %> 
<!DOCTYPE HTML>
<HTML>
<HEAD>
<link rel="stylesheet" type="text/css" href="style.css">
<!--#Include File="AdminGlobalVariables.asp"--> 
</HEAD>
<% if mobiledevice = True or is_iPad = true then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
<% end if %>
 <!--#Include File="AdminHeader.asp"--> 
 <% Current3 = "ArticleCategories"  %>
 <% TempCategoryType="For Sale" %>
 <%
Dim ArticleCatID(100,100)
Dim ArticleCategoryName(100,100)
dim ArticleCategoryOrder(100,100)
 if mobiledevice = False  then %> 
<!--#Include file="AdminArticlesTabsInclude.asp"-->
 	<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth - 35 %>"><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Article Categories</div></H2>
</td></tr>
<tr><td class = "roundedBottom" align = "center" height = "300" width = "100%"  valign = "top">
 <table width = "100%">
     <tr> 
     <% if screenwidth < 1000 then %>
<td width = "450" valign = "top" align = "left">
      <% else %>
   <td width = "100%" valign = "top" align = "left">
      <% end if %>

<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%" class = "roundedtopandbottom"><tr><td  align = "left">
		<H2><div align = "left">Current Article Categories</div></H2>
</td></tr>
<tr><td class = "body" align = "left" valign = "top" colspan = "2">
To change category titles, change the title names and select the corresponding submit button.
<% Changesmade = request.querystring("ChangesMade")
if ChangesMade="True" then%>
<br><br><font color = "maroon"><b>Your Changes Have Been Made.</b></font>
<% end if  %>

 </td>
 </tr>
 <tr><td colspan = "2">
<div align = "right"><input type=submit value = "Submit"  class = "regsubmit2" ></div>
</td>
</tr>
 <tr>
<td class = "body" align = "center"><b>Name</b></td>
<td class = "body" align = "center" width = "79" align = "center"><b>Order</b></td>
</tr>
<% 
sql = "select * from ArticleCategories where  not (articlecatid = 2 ) order by ArticleCategoryOrder " 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3 
CatCounter= 0
While Not rs.eof 
CatCounter = CatCounter + 1
ArticleCatID(CatCounter,0) = rs("ArticleCatID")
ArticleCategoryName(CatCounter,0) = rs("ArticleCategoryName")
ArticleCategoryOrder(CatCounter,0) = rs("ArticleCategoryOrder")
rs.movenext
Wend
FinalCatCounter = CatCounter

CatCounter= 0
SubCatCounter2 = 0
While CatCounter < FinalCatCounter
	CatCounter= CatCounter +1 %>
<tr><td> <form action= 'AdminArticleCategoryEdit.asp' method = "post" style="margin-bottom:0;" >
<div style="display: inline;" align = "left">
<input name="ArticleCategoryName(<%=CatCounter%>)" value ="<%= ArticleCategoryName(CatCounter,0) %>"  size = "40">
</td>
<td>
<select size="1" name="ArticleCategoryOrder(<%=CatCounter%>)">	
<option  value= "<%= CatCounter %>" selected><%= CatCounter %></option>
<%	PGCounter = 0 
While PGCounter < (FinalCatCounter ) 
PGCounter = PGCounter +1 
if PGCounter =  ArticleCategoryOrder(CatCounter,0) then
else %>
<option  value="<%= PGCounter %>"><%= PGCounter %></option>
<% 
end if
Wend %>
		</select>
   </td>
  <td>
<input name="ArticleCatID(<%=CatCounter%>)" value ="<%=ArticleCatID(CatCounter,0)%>"  type="hidden">

  </td>
</tr>
<% 
wend
%>
<tr><td colspan = "2">
<input name="TotalCount" value ="<%=PGCounter %>"  type="hidden">

	<div align = "right"><input type=submit value = "Submit"  class = "regsubmit2" ></div>
</form>
</td>
</tr>
</table>
		
</td>
<%if screenwidth < 1000 then %>
 </tr>
 <tr>      
<% end if %>
<% if mobiledevice = False then %> 
<%if screenwidth < 1000 then %>
  <td width = "100%" valign = "top" >
  <% else %>
   <td width = "450" valign = "top">
  <% end if %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%" ><tr><td class = "roundedtop" align = "left">
<% else %>
 <td width = "100%" valign = "top">
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%"><tr><td align = "left">

<% end if %>

		<H2><div align = "left">Add a New Category</div></H2>
</td></tr>
<tr><td class = "roundedBottom body" align = "center" height = "110" width = "430"valign = "top">
 		<br>
			<form action= 'AdminArticleCatAddHandleform.asp' method = "post">
				<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "left"  valign ="top" >
				<tr>
						<td width = "200" class = "body2" align = "left">
							New Category:<br />
							<input name="NewCategory" size = "50">
							<input name="ArticleCategoryName" type = "hidden" Value = "<%=TempCategoryType%>">
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

		<H2><div align = "left">Delete Article Categories</div></H2>
</td></tr>
<tr><td class = "roundedBottom body" align = "center"  valign = "top" width = "430">

<h1><center>Warning! </center></h1>
<b>When you delete a category  you will loose all Articles with that category! Even if you create a new category with the same name, the old Articles will not automatically be reassigned!</b><br><br>

<form action= 'AdminArticleCatDeleteHandleform.asp' method = "post">
	<input name="CategoryType" type = "hidden" Value = "<%=TempCategoryType%>">
	<input   name="DeleteCategoryType" type = "hidden" value = "Category">	
				<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "left"  valign ="top" >
				
			<tr>
					<td width = "140" class = "body2" align = "right">
							Category:
					</td>
					<td class = "body" >
							<select size="1" name="ArticleCatID">	
							<option  value= "" selected>select a category</option>
						<%	CatCounter = 0 
								While CatCounter < (FinalCatCounter ) 
								CatCounter = CatCounter +1 
						%>
								 <option  value="<%= ArticleCatID(CatCounter,0) %>"><%= ArticleCategoryName(CatCounter,0) %></option>
	
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
		<H1><div align = "left">Article Categories</div></H1>
</td></tr>
<tr><td align = "left" width = "100%" class = "body">  
<a href = "/Administration/AdminArticleMaintenance.asp?PeopleID=<%=session("PeopleID") %>#Articles" class = "body">List of Articles</a><br />
<a href = "/Administration/AdminArticleAdd.asp?PeopleID=<%=session("PeopleID") %>" class = "body">Add an Article</a><br />
<a href = "/Administration/AdminArticleDelete.asp?PeopleID=<%=session("PeopleID") %>" class = "body">Delete Articles</a><br />
<a href = "/Administration/AdminArticleCategoriesSet.asp?PeopleID=<%=session("PeopleID") %>" class = "body">Article Categories</a>
</td>
</tr>

<Tr><td>
<H2><div align = "left">Edit Categories</div></H2> <form action= 'AdminArticleCategoryEdit.asp' method = "post" style="margin-bottom:0;" >


</td></Tr>


<% 



conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(databasepath) & ";" & _
						"User Id=;Password=;" 

			 sql = "select * from ArticleCategories where  not (articlecatid = 2 ) order by ArticleCategoryName " 
		
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3 
	CatCounter= 0
	 While Not rs.eof 
		CatCounter = CatCounter + 1
		ArticleCatID(CatCounter,0) = rs("ArticleCatID")
		ArticleCategoryName(CatCounter,0) = rs("ArticleCategoryName")
		
		rs.movenext
	Wend
		FinalCatCounter = CatCounter

CatCounter= 0
SubCatCounter2 = 0
While CatCounter < FinalCatCounter
	CatCounter= CatCounter +1 %>
   
<tr><td>

			<input name="ArticleCategoryName" value ="<%= ArticleCategoryName(CatCounter,0) %>"  size = "30" class = "regsubmit2 body" >
			<input name="categorytype" value ="category"  type="hidden">
			
				<input name="ArticleCatID" value ="<%=ArticleCatID(CatCounter,0)%>"  type="hidden">
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
			<form action= 'AdminArticleCatAddHandleform.asp' method = "post">
				<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center"  valign ="top" width = "100%">
				<tr>
						<td  class = "body">
							New Category:<br />
	
							<input name="NewCategory" size = "30" class = "regsubmit2 body" >
							<input name="ArticleCategoryName" type = "hidden" Value = "<%=TempCategoryType%>">
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

		<H2><div align = "left">Delete Article Categories</div></H2>
</td></tr>
<tr><td class = "body" align = "left"  valign = "top" width = "430">

<h1><center>Warnings! </center></h1>
<b>When you delete a category  you will loose all Articles with that category!</b><br><br>
<form action= 'AdminArticleCatDeleteHandleform.asp' method = "post">
	<input name="CategoryType" type = "hidden" Value = "<%=TempCategoryType%>">
	<input   name="DeleteCategoryType" type = "hidden" value = "Category">	
			
			<tr>
					<td class = "body" align = "right" width = '100'>
							Category:</td>
						<td class = "body" align = "left">
							<select size="1" name="ArticleCatID"  class = "regsubmit2 body">	
							<option  value= "" selected>select a category</option>
						<%	CatCounter = 0 
								While CatCounter < (FinalCatCounter ) 
								CatCounter = CatCounter +1 
						%>
								 <option  value="<%= ArticleCatID(CatCounter,0) %>"><%= ArticleCategoryName(CatCounter,0) %></option>
	
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
<!--#Include file="AdminFooter.asp"--> 
</Body>
</HTML>