<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4+0 Transitional//EN">
<HTML>
<HEAD>
 <title>Edit Home Page Handle Form</title>
     <link rel="stylesheet" type="text/css" href="/Administration/style.css">
</HEAD>

<BODY background = "images/background.jpg">
<!--#Include virtual="/Administration/Header.asp"--> 
<%

Dim Title
Dim Text
Dim Image
Dim Page
dim aID
dim aName

Title =Request.Form("Title" ) 
Text =Request.Form("Text" ) 
Image =Request.Form("Image" ) 
Page =Request.Form("Page" ) 
aID =Request.Form("ID" )  
aName =Request.Form("aName" ) 



If Len(aID) < 1 Then
   aID = 0
End if

str1 = Title
str2 = "'"
If InStr(str1,str2) > 0 Then
	Title= Replace(str1, "'", "''")
End If


str1 = Text
str2 = "'"
If InStr(str1,str2) > 0 Then
	Text= Replace(str1, "'", "''")
End If

str1 = Image
str2 = "'"
If InStr(str1,str2) > 0 Then
	Image= Replace(str1, "'", "''")
End If



	Query =  " UPDATE Pages Set HPText = '" &  Text & "'," 
	Query =  Query & " AID = " &  aID & "," 
	Query =  Query & " AName = '" &  aname & "'" 
    Query =  Query & " where PageID = '" & Page & "';" 


	
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

<table width = "660" align = "center">
	<tr >
		<td align = "right">
			<br><a  class = "Links" href="MaintainHP.asp"> Return to the Edit Home Page  Page</a>
			<br>
		</td>
	</tr>
</table>
<!--#Include virtual="/Administration/Footer.asp"--> </Body>
</HTML>

