<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4+0 Transitional//EN">
<HTML>
<HEAD>
 <title>Edit Article Handle Form</title>
     <link rel="stylesheet" type="text/css" href="/Administration/style.css">
</HEAD>

<BODY background = "images/background.jpg">
<!--#Include virtual="/Administration/Header.asp"--> 
<%
Dim Issue
Dim IssueDate
Dim IssueTitle
Dim Headline
Dim Text
Dim ArticleImage

Issue =Request.Form("Issue" ) 
IssueDate =Request.Form("IssueDate" ) 
IssueTitle =Request.Form("IssueTitle" ) 
Headline =Request.Form("Headline" ) 
ArticleText =Request.Form("ArticleText" ) 
ArticleImage =Request.Form("ArticleImage" ) 
	

str1 = IssueDate
str2 = "'"
If InStr(str1,str2) > 0 Then
	IssueDate= Replace(str1, "'", "''")
End If

str1 = IssueTitle
str2 = "'"
If InStr(str1,str2) > 0 Then
	IssueTitle= Replace(str1, "'", "''")
End If

str1 = Headline
str2 = "'"
If InStr(str1,str2) > 0 Then
	Headline= Replace(str1, "'", "''")
End If

str1 = ArticleText
str2 = "'"
If InStr(str1,str2) > 0 Then
	ArticleText= Replace(str1, "'", "''")
End If

str1 = ArticleImage
str2 = "'"
If InStr(str1,str2) > 0 Then
	ArticleImage= Replace(str1, "'", "''")
End If


if len(DOB) < 3 then
	DOB = Date
end if

	Query =  " UPDATE Blog Set IssueDate = '" +  IssueDate + "', " 
    Query =  Query + "  IssueTitle = '" + IssueTitle + "'," 
	Query =  Query + "  Headline= '" +  Headline + "'," 
	Query =  Query + "  ArticleText = '" +  ArticleText + "'," 
	Query =  Query + "  Image = '" +  ArticleImage + "'" 
    Query =  Query + " where Issue = " + Issue + ";" 


	
		'response.write(Query)

		Set DataConnection = Server.CreateObject("ADODB.Connection")

		DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(databasepath) 	& ";" 

		DataConnection.Execute(Query) 



		

 %>
<div align = "center"><H2>
<%
     response.write("Your changes have successfully been made.")
  %></H2>
</div>

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
			<form action= 'EditVetPage.asp' method = "post">
				  	<b>Select Another Article to Edit:</b>
					<select  name="Issue">
					<% While Not rs.eof %>
							<small><option name = "<%= rs("Issue")%>" value= "<%= rs("Issue")%>" size = "30"><%= rs("IssueTitle")%></option></small>
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
set conn = Nothing

%>
</BODY>
</HTML>
