<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html >
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Content-Language" content="en-us">
 <title>The Andresen Group Content Management System</title>
       <link rel="stylesheet" type="text/css" href="style.css">
<!--#Include file="AdminSecurityInclude.asp"--> 
<!--#Include file="AdminGlobalVariables.asp"--> 
</HEAD>
<% if mobiledevice = True  then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
<% end if %>

<!--#Include File="AdminHeader.asp"--> 
<% Current3 = "AddArticles" 
Dim ArticleCatID(100,100)
Dim ArticleCategoryName(100,100) 
%>
<% if mobiledevice = False  then %> 
<!--#Include file="AdminArticlesTabsInclude.asp"-->
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth - 35 %>"><tr><td class = "roundedtop" align = "left">
		<H1><div align = "left">Add Articles : Enter Basic Information</div></H1>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" width = "<%=screenwidth - 35 %>">   
  <table width = "100%"  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>

<td class = "body" valign = "top">

<a name="Top"></a>
<br />

<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%" align = "center">
	<tr>
		<td valign = "top">
			 <form action= 'AdminArticleAddHeader.asp' method = "post">
			<input name="TextBlock"  size = "60" value = "Heading" type = "hidden">
		<input name="ArticleID"  size = "60" value = "<%=ArticleID%>" type = "hidden">
		<table border = "0" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%">
  		<tr>
			<td  align = "right"   class = "body">
						<div align = "right"><b>Page Heading: </b></div>
			</td>
			<td  align = "left" valign = "top" class = "body">
					<input name="Heading"  size = "60" value = "<%=PageTitle%>" Class = "regsubmit2 body">
			</td>
	 </tr>
	 <tr>
			<td  align = "right"   class = "body">
						<div align = "right"><b>Link to Author's Website: </b></div>
			</td>
			<td  align = "left" valign = "top" class = "body">
					http://<input name="AuthorLink"  size = "60" value = "<%=AuthorLink%>" Class = "regsubmit2 body">
			</td>
	 </tr>
	  <tr>
      <td class = "body" align = "right" ><div align = "right"><b>Article Category:</b></div></td>
		<td class = "body" >
	

					<% 

ArticleIDFound = False

conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(databasepath) & ";" & _
						"User Id=;Password=;" 

	
  

			 sql = "select * from ArticleCategories where not (ArticleCatID = 2) order by ArticleCategoryName " 
			'response.write(sql2)
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3 
	CatCounter= 0
	 While Not rs.eof 
		CatCounter = CatCounter + 1
		ArticleCatID(CatCounter,0) = rs("ArticleCatID")
		ArticleCategoryName(CatCounter,0) = rs("ArticleCategoryName")
		'response.write(ArticleCategoryName(CatCounter,0))
		rs.movenext
	Wend
		FinalCatCounter = CatCounter

CatCounter= 0
SubCatCounter2 = 0
 %>
   

<select size="1" name="ArticleCatID" Class = "regsubmit2 body">
					<%If ArticleIDFound = True  then%>
					<option name = "ArticleArticleCatID" value="<%=	ArticleArticleCatID%>" selected>
							<%=ArticleArticleName %>
						</option>
					<% End If %>
					<% count = 1
						While CatCounter < FinalCatCounter
						CatCounter= CatCounter +1 %>
				
						<option name = "ArticleArticleCatID" value="<%=ArticleCatID(CatCounter,0)%>">
							<%=ArticleCategoryName(CatCounter,0)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>

     </td>
  </tr>
	  <tr>
		<td  valign = "middle" colspan = "2" align = "center">
			<input type=submit value = "Submit" Class = "regsubmit2 body" ></form>
		</td>
		</tr>
		
	</table>

<br><br>

</td>
</tr>
</table>
</td>
</tr>

</table>
</td>
</tr>

</table><br>
  <% else %>

<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%"><tr><td align = "left">
		<H1><div align = "left">Add Articles : Enter Basic Information</div></H1>
        </td></tr>
        <tr><td align = "left" width = "100%" >  
<a href = "/Administration/AdminArticleMaintenance.asp?PeopleID=<%=session("PeopleID") %>#Articles" class = "body">List of Articles</a><br />
<a href = "/Administration/AdminArticleAdd.asp?PeopleID=<%=session("PeopleID") %>" class = "body">Add an Article</a><br />
<a href = "/Administration/AdminArticleDelete.asp?PeopleID=<%=session("PeopleID") %>" class = "body">Delete Articles</a><br />
<a href = "/Administration/AdminArticleCategoriesSet.asp?PeopleID=<%=session("PeopleID") %>" class = "body">Article Categories</a><br />
<table width = "100%"  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>

<td class = "body" valign = "top">

<a name="Top"></a>
<br />

<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%" align = "center">
	<tr>
		<td valign = "top">
			 <form action= 'AdminArticleAddHeader.asp' method = "post">
			<input name="TextBlock"  size = "60" value = "Heading" type = "hidden">
		<input name="ArticleID"  size = "60" value = "<%=ArticleID%>" type = "hidden">
		<table border = "0" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%">
  		<tr>
			<td  align = "right"   class = "body">
				<b>Page Heading: </b><br />
					<input name="Heading"  size = "40" value = "<%=PageTitle%>" Class = "regsubmit2 body">
			</td>
	 </tr>
	 <tr>
			<td  align = "right"   class = "body">
				<b>Link to Author's Website: </b><br />
					http://<input name="AuthorLink"  size = "20" value = "<%=AuthorLink%>" Class = "regsubmit2 body">
			</td>
	 </tr>
	  <tr>
      <td class = "body" align = "right" ><b>Article Category:</b>
      <br />
<% 

ArticleIDFound = False

conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(databasepath) & ";" & _
						"User Id=;Password=;" 
 sql = "select * from ArticleCategories where not (ArticleCatID = 2) order by ArticleCategoryName " 
			'response.write(sql2)
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3 
	CatCounter= 0
	 While Not rs.eof 
		CatCounter = CatCounter + 1
		ArticleCatID(CatCounter,0) = rs("ArticleCatID")
		ArticleCategoryName(CatCounter,0) = rs("ArticleCategoryName")
		'response.write(ArticleCategoryName(CatCounter,0))
		rs.movenext
	Wend
		FinalCatCounter = CatCounter

CatCounter= 0
SubCatCounter2 = 0
 %>
   

<select size="1" name="ArticleCatID" Class = "regsubmit2 body">
					<%If ArticleIDFound = True  then%>
					<option name = "ArticleArticleCatID" value="<%=	ArticleArticleCatID%>" selected Class = "body">
							<%=ArticleArticleName %>
						</option>
					<% End If %>
					<% count = 1
						While CatCounter < FinalCatCounter
						CatCounter= CatCounter +1 %>
				
						<option name = "ArticleArticleCatID" value="<%=ArticleCatID(CatCounter,0)%>" Class = "body">
							<%=ArticleCategoryName(CatCounter,0)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>

     </td>
  </tr>
	  <tr>
		<td  valign = "middle" colspan = "2" align = "center">
			<input type=submit value = "Submit" Class = "regsubmit2 body" ></form>
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

</table><br>
  <% end if %> 
  
  


        


<!--#Include File="AdminFooter.asp"--> 

</Body>
</HTML>