<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<title>Hera Content Management System</title>
<meta name="Title" content="Alpaca Infinity Administration"/>
<meta name="robots" content="nofollow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="revisit-after" content="1"/>
<meta name="Googlebot" content="nofollow"/>
<meta name="author" content="The Andresen Group"/>
 <link rel="stylesheet" type="text/css" href="/administration/style.css">

</head>
<BODY  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  >
 
<!--#Include virtual="/administration/AdminSecurityInclude.asp"--> 
<!--#Include virtual="/administration/BlogAdmin/BlogAdminGlobalVariables.asp"--> 
<!--#Include virtual="/administration/AdminHeader.asp"--> 

  <% Current3 = "DeleteArticles" %>



<% TempCategoryType="For Sale" 
 DeleteArticleID=request.QueryString("ArticleID")
 
%>

<% if mobiledevice = False then %>
<!--#Include virtual="/administration/BlogAdmin/BlogAdminTabsInclude.asp"--> 
   	<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth - 35 %>"><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Delete an Blog Article</div></H2>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" width = "100%"  valign = "top">
 <% else %>
   	<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=pagewidth %>"><tr><td align = "left">
		<H2><div align = "left">Delete an Blog Article</div></H2>
        </td></tr>
        <tr><td align = "center" height = "300" width = "100%"  valign = "top">
 
 <% end if %>
 

<%
conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
if len(DeleteArticleID) > 0 then						
	 sql = "select * from Blog where BlogID = " &  DeleteArticleID					
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
      DeleteArticleHeadline = rs("BlogHeadline")
    rs.close
end if					
						
 sql = "select * from Blog"

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
				sql2 =  "select * from Blog"

			acounter = 1
			Set rs2 = Server.CreateObject("ADODB.Recordset")
			rs2.Open sql2, conn, 3, 3 
	
			While Not rs2.eof  
				aID(acounter) = rs2("BlogID")
				ArticleHeadline(acounter) = rs2("BlogHeadline")

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
   <font color = "brown"><b><%=Message %></b></font><br />
 <% end if %>
 
 <h2>Warning!</h2> Once you select the delete button your blog article will be gone forever!<br /><br /><br />

			<form action= 'BlogAdminDeleteHandleForm.asp' method = "post">
				<input type = "hidden" name="PhotoType" value= "ListPage">
			   <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "Left">
			   <tr>
				 <td  class ="body" width = "200">
				 <div align = "right">
					<b>Blog Article's Name: </b></div>
					</td>
				<% if mobiledevice = True then %>
				</tr>
				<tr>
				<% end if %>
					<td >
					<select size="1" name="BlogID" class = "regsubmit2 body">
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
				<% if mobiledevice = True then %>
				</tr>
				<tr>
				<% end if %>
				<td ><center><input type=submit value = "Delete" class = "regsubmit2 body" ></center>
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
   <!--#Include virtual="/administration/AdminFooter.asp"--> 
</Body>
</HTML>