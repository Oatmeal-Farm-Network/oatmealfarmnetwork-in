<!DOCTYPE HTML>

<HTML>
<HEAD>
<title>The Andresen Group Content Management System</title>
       <link rel="stylesheet" type="text/css" href="style.css">
    <!--#Include File="AdminSecurityInclude.asp"--> 
    <!--#Include File="AdminGlobalVariables.asp"--> 
</HEAD>
<% if mobiledevice = True  then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
<% end if %>


    <!--#Include File="AdminHeader.asp"--> 
    <% Current3 = "ArticlesHome" %>
    
<% if mobiledevice = True  then %> 

<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%"><tr><td align = "left">
		<H1><div align = "left">Articles</div></H1>
        </td></tr>
        <tr><td align = "left" width = "100%" class = "body">  
<a href = "/Administration/AdminArticleMaintenance.asp?PeopleID=<%=session("PeopleID") %>#Articles" class = "body">List of Articles</a><br />
<a href = "/Administration/AdminArticleAdd.asp?PeopleID=<%=session("PeopleID") %>" class = "body">Add an Article</a><br />
<a href = "/Administration/AdminArticleDelete.asp?PeopleID=<%=session("PeopleID") %>" class = "body">Delete Articles</a><br />
<a href = "/Administration/AdminArticleCategoriesSet.asp?PeopleID=<%=session("PeopleID") %>" class = "body">Article Categories</a><br />
<% else %>  
  <!--#Include file="AdminArticlesTabsInclude.asp"-->
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth - 35 %>"><tr><td class = "roundedtop" align = "left">
		<H1><div align = "left">List of Articles</div></H1>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" width = "100%">  
<table  width = "100%" align = "center"  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >

  <% end if %> 

			<%  
				dim aID(4000)
				dim aArticleHeadline(4000)
				dim aArticle(4000)
				Dim ArticleCategoryName(4000)
				Dim ArticleCatID(4000) 

				'conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
				'"Data Source=" & server.mappath(DatabasePath) & ";" & _
				'		"User Id=;Password=;" 
				sqlx =  "select * from Articles , Articlecategories where Articles.ArticleCatID = Articlecategories.ArticleCatID order by Articles.ArticleCatID ASC, ArticleHeadline ASC"
			
			Set rsx = Server.CreateObject("ADODB.Recordset")
			rsx.Open sqlx, conn, 3, 3 
			catcounter = 0
			if Not rsx.eof  then %>
<tr>
<% if mobiledevice = True   then %> 
<td class = "body2" width = "100%" align = "center"><a name="Articles"></a><b>Article</b></td>
<% else %>
            <td class = "body2" width = "<%=screenwidth - 200 %>" align = "center"><a name="Articles"></a><b>Article</b></td>
			<td class = "body2" width = "120" align = "center"><b>Category</b></td>
			<td class = "body2" align = "center" width = "80"><b>Options</b></td></tr>
<% end if %>

    	<% 
    	order = "odd" 
    	
While Not rsx.eof  	
if order = "even" then
	order = "odd" 
 if mobiledevice = False  then 
	lineheight = "25"
 else
	 lineheight = "55"
 end if %>
	  	<tr bgcolor = "#e6e6e6" height = "<%=  lineheight %>">
	  	
	 <% else
	     order = "even" %>
	 	<tr bgcolor = "White" height = "<%=  lineheight %>">    
	<% end if %>    
<td class= "body" >
<a href = "AdminArticleMaintenance2.asp?ArticleID=<%= rsx("ArticleID") %>#BasicFacts" class = "body"><%=rsx("ArticleHeadline")%></a>
</td>

<% if mobiledevice = False then%>
<td class= "body" >
<%= rsx("ArticleCategoryName") %>
</td>
<td class= "body2" align = "center" >
<a href = "AdminArticleMaintenance2.asp?ArticleID=<%= rsx("ArticleID") %>#BasicFacts" class = "body">&nbsp;&nbsp;<img src= "images/edit.gif" alt = "edit" height ="12" border = "0"></a>|&nbsp;<a href = "AdminArticleDelete.asp?ArticleID=<%= rsx("ArticleID") %>" class = "body"><img src= "images/Delete.gif" alt = "edit" height ="14" border = "0"></a>
</td><% end if %>

</tr>
		<%		catcounter  = catcounter  +1
				rsx.movenext
			Wend		
			FinalCatCounter = catcounter 
			rsx.close

				sql2 =  "select * from Articles"

			acounter = 1
			Set rs2 = Server.CreateObject("ADODB.Recordset")
			rs2.Open sql2, conn, 3, 3 
	
			While Not rs2.eof  
				aID(acounter) = rs2("ArticleID")
				aArticleHeadline(acounter) = rs2("ArticleHeadline")

		acounter = acounter +1
		rs2.movenext
	Wend %>
</table>
	<% end if	%><br><br>
</td>
</tr>
</table>
</td>
</tr>
</table><br><br>
  <!--#Include File="AdminFooter.asp"-->
</Body>
  </HTML>