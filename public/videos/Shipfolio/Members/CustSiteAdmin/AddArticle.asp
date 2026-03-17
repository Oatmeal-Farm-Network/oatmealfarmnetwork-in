<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4+0 Transitional//EN">
<HTML>
<HEAD>
 <title>Add an Article</title>
     <link rel="stylesheet" type="text/css" href="/Administration/style.css">
</HEAD>

<BODY background = "images/background.jpg">
<!--#Include virtual="/Administration/Header.asp"--> 
<%

Dim IssueDate
Dim IssueTitle
Dim Headline
Dim Text
Dim ArticleImage
Dim Page


Page =Request.Form("Page" ) 
IssueDate =Request.Form("IssueDate" ) 
IssueTitle =Request.Form("IssueTitle" ) 
Headline =Request.Form("Headline" ) 
Text =Request.Form("Text" ) 
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

str1 = Text
str2 = "'"
If InStr(str1,str2) > 0 Then
	Text= Replace(str1, "'", "''")
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


		Query =  "INSERT INTO Blog ( IssueDate, Page, IssueTitle, Headline, ArticleText, Image1, image2, image3, image4, image5)" 
		Query =  Query + " Values ('" &  IssueDate & "'," 
		Query =  Query + " '" & Page & "'," 
		Query =  Query + " '" &  IssueTitle & "'," 
		Query =  Query + " '" &  Headline & "'," 
		Query =  Query + " '" &  Text  & "'," 
		Query =  Query + " '" &  ArticleImage1  & "',"
		Query =  Query + " '" &  ArticleImage2  & "',"
		Query =  Query + " '" &  ArticleImage3  & "',"
		Query =  Query + " '" &  ArticleImage4  & "',"
		Query =  Query + " '" &  ArticleImage5 & "')"
		
		'response.write(Query)

		Set DataConnection = Server.CreateObject("ADODB.Connection")

		DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(databasepath) 	& ";" 

		DataConnection.Execute(Query) 

		DataConnection.Close
		Set DataConnection = Nothing 

		

 %>
<div align = "center"><H2>
<%
     response.write("Your changes have successfully been made.")
  %></H2>
</div>


<% If page = "News" Then %>
<table width = "660" align = "center">
	<tr >
		<td align = "right">
			<br><a  class = "Links" href="MaintainNews.asp"> Return to Maintain News Page</a>
			<br>
		</td>
	</tr>
</table>
<% Else %>
<table width = "660" align = "center">
	<tr >
		<td align = "right">
			<br><a  class = "Links" href="MaintainVet.asp"> Return to Maintain Vet Articles Page</a>
			<br>
		</td>
	</tr>
</table>




<% End if %>
</BODY>
</HTML>
