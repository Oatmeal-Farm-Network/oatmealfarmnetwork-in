<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
<HEAD>
 <title>Edit a Blog</title>
       <link rel="stylesheet" type="text/css" href="/Administration/style.css">

</HEAD>

<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  background = "images/background.jpg">



<!--#Include virtual="/Administration/Header.asp"--> 

<% 
Issue =Request.Form("Issue" ) 
'response.write (Issue)

conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(databasepath) & ";" & _
						"User Id=;Password=;" 

			  sql = "select * from Blog where Issue=" & Issue 
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	
	%>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "799">
	<tr>
		<td Class = "body">
			<H2>Upload an Article Image<br>
			<img src = "images/underline.jpg"></H2>
		</td>
	</tr>
</table>

<form action="Blogupload.cgi" method="post" enctype="multipart/form-data"> 

			<input type="File" name="FILE1">
			<p>
			<input type="Submit" value="submit">

			</form> 
<%
			dim fs,fo,x, count
			dim FileName(200)
			set fs=Server.CreateObject("Scripting.FileSystemObject")
			set fo=fs.GetFolder("E:\\Inetpub\\wwwroot\\virtual\\juanita\\disappearingcreek.com\\www\\uploads\\Blog")
			pcount = 1
			for each x in fo.files
			  FileName(pcount) = x.Name
			  ' Response.write(FileName(pcount) & "<br />")
			pcount = pcount + 1
			next
			set fo=nothing
			set fs=nothing
			%>

			
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "799">
	<tr>
		<td Class = "body">
			<H2>Edit Article<br>
			<img src = "images/underline.jpg"></H2>
		</td>
	</tr>
</table>

<table>
	<tr>
		<td valign = "top">
			 <form action= 'EditEventsHandleForm.asp' method = "post">
			 <input type = "Hidden" name="Issue"   value = "<%=rs("Issue")%>">
<table border = "1" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
  	<tr>
			<td  align = "center" valign = "top" width = "250">
					<b>Date</b>
					<input name="IssueDate"  size = "10" value = "<%=rs("IssueDate")%>">
				</td>
				<td  align = "center" valign = "top">
					<b>Article Title</b>
					<input name="IssueTitle"  size = "25" value = "<%=rs("IssueTitle")%>">
				</td>
				<td  align = "center" valign = "top">
					<b>Headline</b>
					<input name="Headline"  size = "25" value = "<%=rs("Headline")%>">
				</td>
				</tr>
				<tr>
				<td  colspan = "3" valign = "top">
					<b>Article Text</b>
					<textarea name="ArticleText" cols="90" rows="8" wrap="VIRTUAL" ><%=rs("ArticleText")%></textarea>
				</td>
		</tr>
		<tr>
				<td  colspan = "3" valign = "top">
					Select Image:<select size="1" name="ArticleImage" >
					<option name = "ArticleImage" value= "<%=rs("Image")%>" selected><%=rs("Image")%></option>
					<% count = 1
						while count < pcount
					%>
						<option name = "ArticleImage" value="<%=FileName(count)%>">
							<%=FileName(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
				</td>
		</tr>
		<tr>
		<td  valign = "middle" colspan = "3" align = "center">
			<Input type = Hidden name='TotalCount' value = <%=TotalCount%> >
			<input type=submit value = "Submit Changes" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" Class = "menu" >
		</td>
		</tr>
		</table></form>



<table border = "0" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "600">
	<tr>
		<td class = "body">
			<H2>Edit Another Article<br>
			<img src = "images/underline.jpg"></H2>
			
			<form action= 'EditEventsPage.asp' method = "post">
			Select an article below and push the edit button to edit a specific events article:<br>

	<%	
rs.close
	 sql = "select * from Blog order by IssueDate Desc" 
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   

%>




<table  width = "700"  align = "center" 
	leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" border=0 
	cellpadding=0 cellspacing=0 style="border-style: solid; border-color: black; border-width: 0, 0, 1,0">
 <tr>
		<td class = 'body' colspan = "5" align = "center">
			<form action= 'EditEventsPage.asp' method = "post">
				  	<b>Select an  Articles:</b>
					<select  name="Issue">
					<% While Not rs.eof %>
							<small><option name = "Issue" value= "<%= rs("Issue")%>" size = "30"><%= rs("IssueTitle")%></option></small>
					<%  rs.movenext
						Wend
						 rs.movefirst %>
					</select>
					<input type=submit value = "Edit" style="background-image: url('/images/ButtonBackground.jpg'); border-style: solid; border-color: #404040; border-width: 1; height = '22' "  class = "Menu" ></form>
		</td>
	</tr>
</table>

<%
rs.close
 set rs=nothing
set conn = nothing
%>
		</td>
	</tr>
</table>

<table border = "0" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "600">
	<tr>
		<td class = "body"><br>
		<br>
			<H2>DELETE AN ARTICLE<br>
			<img src = "images/underline.jpg"></H2>
			
			<form action= 'DeleteEvents.asp' method = "post">
			Select an article below and push the DELETE button to delete a specific events article. Remember once it's gone, it's gone!:<br>

	<%	
	conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(databasepath) & ";" & _
						"User Id=;Password=;" 

			  sql = "select * from Blog order by IssueDate Desc" 
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   

%>

<table  width = "700"  align = "center" 
	leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" border=0 
	cellpadding=0 cellspacing=0 style="border-style: solid; border-color: black; border-width: 0, 0, 1,0">
 <tr>
		<td class = 'body' colspan = "5" align = "center">
			<form action= 'EditBlog.asp' method = "post">
				  	<b>SELECT AN ARTICLE TO DELETE: </b>
					<select  name="Issue">
					<% While Not rs.eof %>
							<small><option name = "Issue" value= "<%= rs("Issue")%>" size = "30"><%= rs("IssueTitle")%></option></small>
					<%  rs.movenext
						Wend
						 rs.movefirst %>
					</select>
					<input type=submit value = "Delete" style="background-image: url('/images/ButtonBackground.jpg'); border-style: solid; border-color: #404040; border-width: 1; height = '22' "  class = "Menu" ></form>
		</td>
	</tr>
</table>
</Body>
</HTML>