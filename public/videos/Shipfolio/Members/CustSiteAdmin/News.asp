<html>

<head>
<!--#Include virtual="/GlobalVariables.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta http-equiv="Content-Language" content="en-us">
<title><%= WebSiteName %> News</title>
<META name="description" content="<%= WebSiteName %> News">
<META name="keywords" content="<%=State%> Alpaca Ranch, <%= WebSiteName %>, <%= Slogan %>, <%= Breed %>Alpacas for sale, alpacas, alpaca,  female alpacas, male alpacas">
<meta name="author" content="WebArtists.biz">
<link rel="stylesheet" type="text/css" href="style.css">

</head>


<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<% PageTitle = "News" %>
<!--#Include virtual="/NewsHeader.asp"-->

<table width = "<%=bodywidth%>" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "Left" >
       <tr>
	<td valign = "top">


<%

conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(databasepath) & ";" & _
						"User Id=;Password=;" '& _ 

Issue=request.form("Issue") 
found = false
If Len(Issue) > 0 then
	 sql = "select * from Blog where Page = 'News' and Issue = " &  Issue
		Set rs = Server.CreateObject("ADODB.Recordset")
		 rs.Open sql, conn, 3, 3   
		IssueTitle = rs("IssueTitle")
		CurrentIssue = Issue
		'response.write(IssueTitle )
		found = true
End If
'response.write(Issue)
  sql = "select * from Blog where Page = 'News' order by IssueDate Desc" 
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   

If rs.eof Then %>
	<table  width = "600"  align = "center" 
	leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" border=0 
	cellpadding=0 cellspacing=0 >
 <tr>
		<td class = 'body' align = "center" colspan = "5" align = "center">
			Sorry, we do not currently have any News. 
		</td>
</tr>
</table>

<% else
	If rs.recordcount > 1 then
%>

<table width = " "<%=bodywidth%>""  align = "center" 	leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" border=0 cellpadding=0 cellspacing=0 >
 <tr>
		<td class = 'body' align = "center" colspan = "5" align = "center">
										
		 <div align ="left">
			<form action= 'News.asp' method = "post">
				  	<b>Select an Article:</b>
					<select  name="Issue">
					  <% If found = True Then %>
									<small><option name = "<%=Issue%>" value= "<%= Issue%>" size = "30" selected><%= IssueTitle %></option></small>
									
									<%While Not rs.eof 
												
													newIssue = rs("Issue")
													response.write(newIssue)
												If CInt(newIssue) = CInt(CurrentIssue) Then
												else
												%>
													<small><option name = "<%= rs("Issue")%>" value= "<%= rs("Issue")%>" size = "30"><%= rs("IssueTitle")%></option></small>
										<%   End if 
										rs.movenext
										Wend
										 rs.movefirst %>
						 <%else %>
									<%While Not rs.eof %>
										<small><option name = "<%= rs("Issue")%>" value= "<%= rs("Issue")%>" size = "30"><%= rs("IssueTitle")%></option></small>
									<%  rs.movenext
											Wend
										 rs.movefirst %>
						<% End if%>



					
					<input type=submit value = "View" style="background-image: url('/images/ButtonBackground.jpg'); border-style: solid; border-color: #404040; border-width: 1; height = '22' "  class = "body" ></form>
		  </div>
		</td>
	</tr>
</table>

<%
End if
rs.close

if Issue = "" then
	 sql = "select * from Blog where Page = 'News' order by IssueDate desc" 
else
	 sql = "select * from Blog where  Issue = " & Issue 
End If
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
%>




<table  width = "<%=bodywidth%>"  border="0" cellpadding="0" cellspacing="0" align = "center">
	<tr>
		<td  valign = "top" height = "24" colspan = "2" valign = "top" background = "images/HeadingBackground.jpg">
		<h2><div align = "left"><%=rs("IssueTitle")%>: <%=rs("Headline")%></div></h2>
		</td>
	</tr>
	<tr>
		  <td class = "body"  width = "530" valign = "top">
		  <blockquote class = "body"><%=rs("ArticleText")%></blockquote>
		 </td>
		 <td valign = "top">
			<% if len(rs("Image1")) > 3 Then %>
			
			<img src = "/uploads/Blog/<%=rs("Image1")%>"  width = "200"><br><br>

			<% End if%>
	
				<% if len(rs("Image2")) > 3 Then %>
			
			<img src = "/uploads/Blog/<%=rs("Image2")%>"  width = "200"><br><br>

			<% End if%>

			<% if len(rs("Image3")) > 3 Then %>
			
			<img src = "/uploads/Blog/<%=rs("Image3")%>"  width = "200"><br><br>

			<% End if%>

			<% if len(rs("Image4")) > 3 Then %>
			
			<img src = "/uploads/Blog/<%=rs("Image4")%>"  width = "200"><br><br>

			<% End if%>

			<% if len(rs("Image5")) > 3 Then %>
			
			<img src = "/uploads/Blog/<%=rs("Image5")%>"  width = "200"><br>

			<% End if%>


		</td>
	</tr>
</table>
</td>
	</tr>
</table>
<%
 set rs=nothing
set conn = nothing
%>

<% End if%>
<!--#Include virtual="/Footer.asp"-->
</body>
</html>