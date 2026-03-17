<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4+0 Transitional//EN">
<HTML>
<HEAD>
 <title>Associate Photos Results Page</title>
       <link rel="stylesheet" type="text/css" href="style.css">
</HEAD>

<BODY  bgcolor = "white">
<!--#Include virtual="/administration/Header.asp"--> 
<table width = "776"  align = "center" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" border=0 	cellpadding=0 cellspacing=0 >
	<tr>
		</td>
<%

dim aID
dim Photo
dim PhotoType
dim Title

	PhotoType=Request.Form("PhotoType") 
	aID=Request.Form("AID") 
	Photo=Request.Form("Photo")
	Title=Request.Form("Title") 
	ImageDescription=Request.Form("ImageDescription") 

str1 = Photo
str2 = "'"
If InStr(str1,str2) > 0 Then
	 Photo= Replace(str1, "'", "''")
End If
str1 = Title
str2 = "'"
If InStr(str1,str2) > 0 Then
	 Title= Replace(str1, "'", "''")
End If

str1 = ImageDescription
str2 = "'"
If InStr(str1,str2) > 0 Then
	 ImageDescription= Replace(str1, "'", "''")
End If


if PhotoType = "ListPage" then
	Query =  " UPDATE Photos Set ListPageImage = '" &  Photo & "' " 
    Query =  Query & " where ID = " & aID & ";" 
end if

if PhotoType = "DetailPage" then
	Query =  " UPDATE Photos Set DetailPageImage = '" &  Photo & "' " 
    Query =  Query & " where ID = " & aID & ";" 
end if

if PhotoType = "Head" then
	Query =  " UPDATE Photos Set Image1 = '" &  Photo & "' " 
    Query =  Query & " where ID = " & aID & ";" 
end if

if PhotoType = "Bite" then
	Query =  " UPDATE Photos Set Image2 = '" &  Photo & "' " 
    Query =  Query & " where ID = " & aID & ";" 
end if

if PhotoType = "Fleece" then
	Query =  " UPDATE Photos Set Image3 = '" &  Photo & "' " 
    Query =  Query & " where ID = " & aID & ";" 
end if

if PhotoType = "Front" then
	Query =  " UPDATE Photos Set Image4 = '" &  Photo & "' " 
    Query =  Query & " where ID = " & aID & ";" 
end if

if PhotoType = "Rear" then
	Query =  " UPDATE Photos Set Image5 = '" &  Photo & "' " 
    Query =  Query & " where ID = " & aID & ";" 
end if


str1 = Title
str2 = "'"
If InStr(str1,str2) > 0 Then
	Title= Replace(str1, "'", "''")
End If

if PhotoType = "ILoveAlpacas" then
	Query =  "Insert into AdditionalPhotos (ID, Image,  ImageDescription, ImageTitle)"
	Query =  Query & " Values (2000, " 
	Query =  Query & " '" &  Photo & "'," 
	Query =  Query & " '" & ImageDescription & "'," 
	Query =  Query & " '" & Title & "')" 
end if
 

if PhotoType = "DetailPage" Then
	conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
	"Data Source=" & server.mappath("../../db/AlpacaDB.mdb") & ";" & _
						"User Id=;Password=;" '& _ 
	 sql = "select * from AdditionalPhotos where ID = " & aID
    
'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
PhotoOrder = 0
	If Not rs.eof Then
	PhotoOrder = rs.recordcount
	End if

	rs.close

	Set conn = Nothing 

	Query =  "Insert into AdditionalPhotos (ID, Image,  photoOrder, ImageDescription, ImageTitle)"
	Query =  Query & " Values (" &  aID & "," 
	Query =  Query & " '" &  Photo & "'," 
	Query =  Query & " '" &  PhotoOrder + 1 & "'," 
	Query =  Query & " '" & ImageDescription & "'," 
	Query =  Query & " '" & Title & "')" 
	
end if
'response.write(query)

Dim DataConnection, cmdDC, RecordSet
Dim RecordToEdit, Updated
Set DataConnection = Server.CreateObject("ADODB.Connection")

DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath("../../db/AlpacaDB.mdb") & ";" 

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

</td>
</tr>
	<tr >
		<td align = "right">
			<% if PhotoType = "ILoveAlpacas" Then %>
						<br><a href="AdminIloveAlpacas.asp"> Return to the I love Alpacas Page</a>	
				<%	Else
					%>
			<br><a href="PhotosData.asp"> Return to the Upload Photos Page</a>
			<%	End If
					%>
			<br>
		</td>
	</tr>
</table>
<!--#Include virtual="/administration/Footer.asp"--> </Body>
</HTML>
