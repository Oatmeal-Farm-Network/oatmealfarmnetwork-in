<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
<HEAD>
 <title>Maintain Vet Page Articles</title>
       <link rel="stylesheet" type="text/css" href="/Administration/style.css">

</HEAD>

<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  background = "images/background.jpg">



<!--#Include virtual="/Administration/Header.asp"--> 

<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "799">
	<tr>
		<td Class = "body">
			<H2>Upload an Article Image<br>
			<img src = "images/underline.jpg"></H2>
		</td>
	</tr>
</table>

<form action="Vetupload.cgi" method="post" enctype="multipart/form-data"> 

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
			<H2>Add a New Vet Article<br>
			<img src = "images/underline.jpg"></H2>
		</td>
	</tr>
</table>

<table>
	<tr>
		<td valign = "top">
			 <form action= 'AddArticle.asp' method = "post">
			 <Input type = "Hidden" name='Page' value = "Vet" >
<table border = "1" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
  	<tr>
			<td  align = "center" valign = "top" width = "250">
					<b>Date</b> (needed to list articles in order.)
					<input name="IssueDate"  size = "10" value = "<%=Date%>">
				</td>
				<td  align = "center" valign = "top">
					<b>Article Title</b> (such as "November 2006", etc.)
					<input name="IssueTitle"  size = "25">
				</td>
				<td  align = "center" valign = "top">
					<b>Headline</b> (such as "The Truth About BVD" )
					<input name="Headline"  size = "25">
				</td>
				</tr>
				<tr>
				<td  colspan = "3" valign = "top">
					<b>Article Text</b> (Note: it's often best to write your text in a word processor and then copy and paste it here.)
					<textarea name="Text" cols="90" rows="8" wrap="VIRTUAL" ></textarea>
				</td>
		</tr>
		<tr>
				<td  colspan = "3" valign = "top">
					Select Image:<select size="1" name="ArticleImage">
					<option name = "ArticleImage" value= "" selected></option>
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
			<input type=submit value = "Submit Article" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" Class = "menu" >
		</td>
		</tr>
		</table></form>



<table border = "0" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "600">
	<tr>
		<td class = "body">
			<H2>Edit a Vet Article<br>
			<img src = "images/underline.jpg"></H2>
			
			<form action= 'EditVetPage.asp' method = "post">
			Select an article below and push the edit button to edit a specific article:<br>

	<%	
	conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(databasepath) & ";" & _
						"User Id=;Password=;" 

			  sql = "select * from Blog where Page = 'Vet' order by IssueDate Desc" 
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   

%>




<table  width = "700"  align = "center" 
	leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" border=0 
	cellpadding=0 cellspacing=0 style="border-style: solid; border-color: black; border-width: 0, 0, 1,0">
 <tr>
		<td class = 'body' colspan = "5" align = "center">
			<form action= 'EditVet.asp' method = "post">
				  	<b>Select a  Vet Article:</b>
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
			<H2>DELETE AN VET ARTICLE<br>
			<img src = "images/underline.jpg"></H2>
			
			<form action= 'DeleteVet.asp' method = "post">
			Select an article below and push the DELETE button to delete a specific blog article. Remember once it's gone, it's gone!:<br>

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
			<form action= 'DeleteVet.asp' method = "post">
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