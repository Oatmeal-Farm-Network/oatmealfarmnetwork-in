<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4+0 Transitional//EN">
<HTML>
<HEAD>
 <title>Add External Stud Results Page</title>
        <link rel="stylesheet" type="text/css" href="style.css">
</HEAD>

<BODY bgcolor = "white">
<!--#Include virtual="/administration/Header.asp"--> 
<%



dim FullName
dim ServiceSireLink
dim Breed
dim ServiceSireColor
dim PhotoName

	FullName=Request.Form("FullName" ) 
	ServiceSireLink=Request.Form("ServiceSireLink" ) 
	Breed=Request.Form( "Breed" ) 
	ServiceSireColor=Request.Form("ServiceSireColor")
	PhotoName=Request.Form("PhotoName")

str1 = FullName
str2 = "'"
If InStr(str1,str2) > 0 Then
	FullName= Replace(str1, "'", "''")
End If

str1 = ServiceSireLink
str2 = "'"
If InStr(str1,str2) > 0 Then
	ServiceSireLink= Replace(str1, "'", "''")
End If

		Query =  "INSERT INTO ExternalStud ( AlpacaName, ServiceSireLink, Breed, ServiceSireColor, ServiceSireImage)" 
		Query =  Query + " Values ('" +  FullName + "'," 
		Query =  Query + " '" +  ServiceSireLink + "'," 
		Query =  Query + " '" +  Breed + "'," 
		Query =  Query + " '" +  ServiceSireColor + "',"
		Query =  Query + " '" +  PhotoName + "')"

		Set DataConnection = Server.CreateObject("ADODB.Connection")

		DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath("../../db/AlpacaDB.mdb") 	& ";" 
'response.write(Query)
		DataConnection.Execute(Query) 
		DataConnection.Close
		Set DataConnection = Nothing 


 %>
<div align = "center"><H2>
<%
     response.write("Your changes have successfully been made.")
  %></H2>
</div>
<%

 


%>

<table width = "660" align = "center">
	<tr >
		<td align = "right">
			<br><a  class = "Links" href="XStuds.asp"> Return to Add a new external Stud Page</a>
			<br>
		</td>
	</tr>
</table>
<!--#Include virtual="/administration/Footer.asp"--> </Body>
</HTML>
