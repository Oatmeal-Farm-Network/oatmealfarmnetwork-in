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
 

  <% Current3 = "DeleteArticles" %>


<% TempCategoryType="For Sale" 
 DeleteArticleID=request.QueryString("ArticleID")
 
%>
<% if mobiledevice = False  then %> 
<!--#Include file="AdminArticlesTabsInclude.asp"-->
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth - 35 %>"><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Delete an Article</div></H2>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" height = "300" width = "100%"  valign = "top">
  <% else %>

<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%"><tr><td align = "left">
		<H1><div align = "left">Delete an Article</div></H1>
        </td></tr>
        <tr><td align = "left" width = "100%" class = "body">  
<a href = "/Administration/AdminArticleMaintenance.asp?PeopleID=<%=session("PeopleID") %>#Articles" class = "body">List of Articles</a><br />
<a href = "/Administration/AdminArticleAdd.asp?PeopleID=<%=session("PeopleID") %>" class = "body">Add an Article</a><br />
<a href = "/Administration/AdminArticleDelete.asp?PeopleID=<%=session("PeopleID") %>" class = "body">Delete Articles</a><br />
<a href = "/Administration/AdminArticleCategoriesSet.asp?PeopleID=<%=session("PeopleID") %>" class = "body">Article Categories</a><br />

  <% end if 
conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
if len(DeleteArticleID) > 0 then						
	 sql = "select * from Articles where ArticleID = " &  DeleteArticleID					
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
      DeleteArticleHeadline = rs("ArticleHeadline")
    rs.close
end if					
						
 sql = "select * from Articles"

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	rowcount = 1
	dim ArticleID(40000)
	dim ArticleText(40000)
	dim Article(40000)
	dim Articledescription(40000)

	
Recordcount = rs.RecordCount +1
%>

<table border = "0" align = "left">
<tr>
  <td colspan = "2" align = "left">

<%  
				dim aID(40000)
				dim ArticleHeadline(40000)
				dim aArticle(40000)

				conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
				"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" 
				sql2 =  "select * from Articles"

			acounter = 1
			Set rs2 = Server.CreateObject("ADODB.Recordset")
			rs2.Open sql2, conn, 3, 3 
	
			While Not rs2.eof  
				aID(acounter) = rs2("ArticleID")
				ArticleHeadline(acounter) = rs2("ArticleHeadline")

		acounter = acounter +1
		rs2.movenext
	Wend		
	
		rs2.close
		set rs2=nothing
		set conn = nothing



%>

<table border = "0" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "left">
	<tr>
		<td valign = "top" align = "Left" class = "body">
<br /><br />
<% Message=request.QueryString("Message")
if len(Message) > 0 then
 %>
   <font color = "brown"><b><%=Message %></b></font><br /><br />
 <% end if %>
			<form action= 'AdminArticleDeleteHandleForm.asp' method = "post">
				<input type = "hidden" name="PhotoType" value= "ListPage">
			   <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "Left">
			   <tr>
				 <td  class ="body">
				 <div align = "left">
					<b>Article's Name: </b></div>
					</td>
					<% if mobiledevice =True  then %> 
					</tr>
					<tr>
					<% end if %>
					<td >
					<select size="1" name="ArticleID" class = "regsubmit2 body" >
					<%  if len(DeleteArticleID) > 0 then %>
						<option name = "AID0" value= "<%=DeleteArticleID %>" selected><%=DeleteArticleHeadline %></option>
					<% else %>
						<option name = "AID0" value= "" selected></option>
					<% end if %>
					
				
					<% count = 1
						while count < acounter
						response.write(count)
					%>
						<option name = "AID1" value="<%=aID(count)%>">
							<%=ArticleHeadline(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
				</td>
				<% if mobiledevice = True  then %> 
					</tr>
					<tr>
					<% end if %>
				<td valign = "top">
					<center><input type=submit value = "Delete" class = "regsubmit2 body" ></center>
				</td>
			  </tr>
		    </table>
		  </form>
		</td>
	</tr>
</table>
<br><br><br>
<br><br>

</td>
</tr>
</table></td>
</tr>
</table><br><br>
   <!--#Include File="AdminFooter.asp"--> 
</Body>
</HTML>