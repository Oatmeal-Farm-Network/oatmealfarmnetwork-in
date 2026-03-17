<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4+0 Transitional//EN">
<HTML>
<HEAD>
 <title>Associate Photos Results Page</title>
             <link rel="stylesheet" type="text/css" href="style.css">


</HEAD>

<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  background = "images/background.jpg">

<!--#Include virtual="/Administration/Header.asp"--> 
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

str1 = ImageDescription
str2 = "'"
If InStr(str1,str2) > 0 Then
	ImageDescription = Replace(str1, "'", "''")
End If

str1 = Title
str2 = "'"
If InStr(str1,str2) > 0 Then
	Title= Replace(str1, "'", "''")
End If

 
str1 = Photo
str2 = "'"
If InStr(str1,str2) > 0 Then
	Photo= Replace(str1, "'", "''")
End If




	conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
	"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" 
	sql2 = "select * from ProductsAdditionalPhotos where ID = " &  aID
'response.write(sql2)
	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	'response.write(rs2.recordcount)
	if  rs2.recordcount = 1 And Len(image) < 3  then
		Query =  " UPDATE ProductsAdditionalPhotos Set Image = '" & Photo & "' " 
		Query =  Query + " where ID = " & aID & ";" 
    else 

	if  rs2.recordcount < 1  then
		Query =  " Insert  ProductsAdditionalPhotos Set Image = '" &  Photo & "' " 
		Query =  "Insert into ProductsAdditionalPhotos (ID, Image,  PhotoOrder)"
		Query =  Query & " Values (" &  aID & "," 
		Query =  Query & " '" &  Photo & "'," 
		Query =  Query & " 1 )" 
	else
		Query =  " Insert  ProductsAdditionalPhotos Set Image = '" &  Photo & "' " 
		Query =  "Insert into ProductsAdditionalPhotos (ID, Image,  PhotoOrder)"
		Query =  Query & " Values (" &  aID & "," 
		Query =  Query & " '" &  Photo & "'," 
		Query =  Query & (rs2.recordcount +1)  & " )" 
	end if
 End if
'response.write(Query)




Dim DataConnection, cmdDC, RecordSet
Dim RecordToEdit, Updated
Set DataConnection = Server.CreateObject("ADODB.Connection")

DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 

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
			<br><a  class = "body" href="ProductPhotos.asp"> Return to the Associate Images Page</a>
			<br>
		</td>
	</tr>
</table>
</BODY>
</HTML>
