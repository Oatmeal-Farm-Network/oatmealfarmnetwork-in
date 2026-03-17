<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4+0 Transitional//EN">
<HTML>
<HEAD>
 <title>Add Package Name Results Page</title>
     <link rel="stylesheet" type="text/css" href="style.css">



</HEAD>

<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 background = "images/background.jpg">

<!--#Include virtual="/Administration/Header.asp"--> 
<%

Dim Title
dim Photo
dim Text


	Title=Request.Form("Title")
	Photo=Request.Form("Photo")
	Text=Request.Form("Text")
	ContestAnimalID=Request.Form("ContestAnimalID")
'response.write(ContestAnimalID)
str1 = Text
str2 = "'"
If InStr(str1,str2) > 0 Then
	Text= Replace(str1, "'", "''")
End If

str1 = Title
str2 = "'"
If InStr(str1,str2) > 0 Then
	Title= Replace(str1, "'", "''")
End If

str1 = Photo
str2 = "'"
If InStr(str1,str2) > 0 Then
	Text= Replace(str1, "'", "''")
End If


Query =  " UPDATE SpecialsHeader Set FieldContent = '" +  Title + "' " 
	Query =  Query + " where FieldID = 1;" 
'response.write(Query)	
	
Dim DataConnection, cmdDC, RecordSet
Dim RecordToEdit, Updated
Set DataConnection = Server.CreateObject("ADODB.Connection")

DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath("../../db/AlpacaDB.mdb") & ";" 

DataConnection.Execute(Query) 

Query =  " UPDATE SpecialsHeader Set FieldContent = '" +  Text + "' " 
	Query =  Query + " where FieldID = 0;" 
'response.write(Query)	
DataConnection.Execute(Query) 

	Query =  " UPDATE SpecialsHeader Set FieldContent = '" +  ContestAnimalID + "' " 
	Query =  Query + " where FieldID = 3;" 
'response.write(Query)	
DataConnection.Execute(Query) 




IF DataConnection.Errors.Count <> 0 then
     Call MyErrorHandler(oDBConn, sSQL)  ' pass database connection as param
 Else
 %>
<div align = "center"><H2>
<%
     response.write("Your changes have successfully been made.")
  %></H2>
</div>
<%

 End If

	DataConnection.Close
	Set DataConnection = Nothing 

%>

<table width = "660" align = "center">
	<tr >
		<td align = "right">
			<br><a  Class = "Links" href="specials.asp"> Return to Edit GyuroStyle Auctions Page</a>
			<br>
		</td>
	</tr>
</table>
</BODY>
</HTML>
