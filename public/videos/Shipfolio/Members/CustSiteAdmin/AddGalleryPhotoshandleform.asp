<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4+0 Transitional//EN">
<HTML>
<HEAD>
 <title>Associate Gallery Photos Results Page</title>
       <link rel="stylesheet" type="text/css" href="style.css">
</HEAD>

<BODY  bgcolor = "white">
<!--#Include virtual="/administration/Header.asp"--> 
<table width = "776"  align = "center" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" border=0 	cellpadding=0 cellspacing=0 >
	<tr>
		</td>
<%

dim PageID
dim Photo
dim Title

	pageID=Request.Form("PageID") 
	PhotoLocation=Request.Form("PhotoLocation")
	Photo=Request.Form("Photo")
	PhotoL=Request.Form("PhotoL")
	Title=Request.Form("Title") 
	Shape=Request.Form("Shape") 
	ImageDescription=Request.Form("ImageDescription") 


conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
		"Data Source=" & server.mappath("../../db/AlpacaDB.mdb") & ";" & _
						"User Id=;Password=;" 
	sql2 = "select * from GalleryPhotos where PageID  = " & pageID

	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	tempphoto = rs2("Photo") & " "

	if rs2.recordcount = 1 and len(tempphoto) < 3 then
		PageCount = 1 
	end if
		rs2.close
		set rs2=nothing
		set conn = nothing




str1 = Photo
str2 = "'"
If InStr(str1,str2) > 0 Then
	 Photo= Replace(str1, "'", "''")
End If



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

 If PageCount = 1 then
	Query =  "Update GalleryPhotos Set Location =  " &  PhotoLocation & "," 
	Query =  Query + "Photo =  '" &  Photo & "'," 
	Query =  Query + "PhotoL =  '" &  PhotoL & "'," 
	Query =  Query + "Shape =  '" &  Shape & "'," 
	Query =  Query + "Caption =  '" & Title & "'" 
	 Query =  Query + " where PageID = " &  PageID &  ";" 
 else
	Query =  "Insert into GalleryPhotos (PageID, Location, Shape, Photo, photoL, Caption)"
	Query =  Query + " Values (" +  PageID + "," 
	Query =  Query + " '" +  PhotoLocation + "'," 
	Query =  Query + " '" +  Shape + "'," 
	Query =  Query + " '" +  PhotoL + "'," 
	Query =  Query + " '" +  Photo + "'," 
	Query =  Query + " '" + Title + "')" 
end if

'response.write(Query)

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
			<br><a href="GalleryPhotos.asp"> Return to the Gallery Photos Page</a>
			<br>
		</td>
	</tr>
</table>
<!--#Include virtual="/administration/Footer.asp"--> </Body>
</HTML>
