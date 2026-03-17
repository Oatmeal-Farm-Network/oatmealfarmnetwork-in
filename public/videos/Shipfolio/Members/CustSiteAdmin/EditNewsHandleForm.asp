<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4+0 Transitional//EN">
<HTML>
<HEAD>
 <title>Edit News Article Handle Form</title>
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
ArticleImage1 =Request.Form("ArticleImage1" ) 
ArticleImage2 =Request.Form("ArticleImage2" ) 
ArticleImage3 =Request.Form("ArticleImage3" ) 
ArticleImage4 =Request.Form("ArticleImage4" ) 
ArticleImage5 =Request.Form("ArticleImage5" ) 
	

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

str1 = ArticleImage1
str2 = "'"
If InStr(str1,str2) > 0 Then
	ArticleImage1= Replace(str1, "'", "''")
End If

str1 = ArticleImage2
str2 = "'"
If InStr(str1,str2) > 0 Then
	ArticleImage2= Replace(str1, "'", "''")
End If

str1 = ArticleImage3
str2 = "'"
If InStr(str1,str2) > 0 Then
	ArticleImage3= Replace(str1, "'", "''")
End If

str1 = ArticleImage4
str2 = "'"
If InStr(str1,str2) > 0 Then
	ArticleImage4= Replace(str1, "'", "''")
End If

str1 = ArticleImage5
str2 = "'"
If InStr(str1,str2) > 0 Then
	ArticleImage5= Replace(str1, "'", "''")
End If

if len(DOB) < 3 then
	DOB = Date
end if

	Query =  " UPDATE Blog Set IssueDate = '" +  IssueDate + "', " 
    Query =  Query + "  IssueTitle = '" + IssueTitle + "'," 
	Query =  Query + "  Headline= '" +  Headline + "'," 
	Query =  Query + "  ArticleText = '" +  ArticleText + "'," 
	Query =  Query + "  Image1 = '" +  ArticleImage1 + "'," 
	Query =  Query + "  Image2 = '" +  ArticleImage2 + "'," 
	Query =  Query + "  Image3 = '" +  ArticleImage3 + "'," 
	Query =  Query + "  Image4 = '" +  ArticleImage4 + "'," 
	Query =  Query + "  Image5 = '" +  ArticleImage5 + "'" 
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
			<form action= 'EditNewsPage.asp' method = "post">
				  	<b>Select Anouther NewsArticle to Edit:</b>
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
