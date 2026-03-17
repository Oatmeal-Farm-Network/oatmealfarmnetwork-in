

<!--#Include file="BlogHeader.asp"--> 



<%
conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
 sql = "select * from Blog"

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	rowcount = 1
	dim BlogID(40000)
	dim BlogText(40000)
	dim Blog(40000)
	dim Blogdescription(40000)

	
Recordcount = rs.RecordCount +1
%>

	<form action= 'AddBloghandleform.asp' method = "post">


<table border = "0"  bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "700" align = "left">
    <tr>
		<td class = "body" colspan = "2">
		<H2>Add a New Blog<br>
			<img src = "images/underline.jpg" width = "700" height = "2"></H2>
		</td>
	</tr>
	<tr>
		<td width = "80" class = "body" align = "right">
			Title:
		</td>
		<td>
			<input name="BlogHeading" class = "body" size = "80">
		</td>
	</tr>
	<tr>
		<td class = "body" align = "right">
			Author:
		</td>
		<td class = "body">
			<input name="BlogAuthor" size = "72">
		</td>
	</tr>
	<tr>
		<td class = "body" align = "right">
			Link:
		</td>
		<td class = "body">
			Http://<input name="BlogLink" size = "72">
		</td>
	</tr>
  <tr>
      <td class = "body" align = "left" colspan = "2">
	    Blog Category:
	

					<% 
Dim BlogCatID(100,100)
Dim BlogCategoryName(100,100)


conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(databasepath) & ";" & _
						"User Id=;Password=;" 

			 sql = "select * from BlogCategories where not (BlogCatID = 2) order by BlogCategoryName " 
			'response.write(sql2)
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3 
	CatCounter= 0
	 While Not rs.eof 
		CatCounter = CatCounter + 1
		BlogCatID(CatCounter,0) = rs("BlogCatID")
		BlogCategoryName(CatCounter,0) = rs("BlogCategoryName")
		'response.write(BlogCategoryName(CatCounter,0))
		rs.movenext
	Wend
		FinalCatCounter = CatCounter

CatCounter= 0
SubCatCounter2 = 0
 %>
   

<select size="1" name="BlogCatID">
					<option name = "BlogID0" value= "" selected></option>
					<% count = 1
						While CatCounter < FinalCatCounter
						CatCounter= CatCounter +1
					%>
						<option name = "BlogBlogCatID" value="<%=BlogCatID(CatCounter,0)%>">
							<%=BlogCategoryName(CatCounter,0)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>

     </td>
  </tr>
	<tr>
		<td class = "body" align = "right" valign = "top">
			Blog Text:
		</td>
		<td>
			<textarea name="BlogText"  cols="80" rows="40"   class = "body"  ></textarea>
		</td>
	</tr>
	
	<tr>
		<td  align = "center" valign = "middle" colspan = "2">
			<input type=submit value = "Add Blog" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" class = "menu" >
			</form>
		</td>
</tr>
</table>

 
<br><br><br><br>
<br><br><br><br>