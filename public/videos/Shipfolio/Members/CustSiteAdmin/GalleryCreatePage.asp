<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4+0 Transitional//EN">
<HTML>
<HEAD>
 <title>Create a new Blank Gallery Page</title>
      <link rel="stylesheet" type="text/css" href="style.css">
</HEAD>

<BODY bgcolor = "white">
<!--#Include virtual="/administration/Header.asp"--> 
<%

Dim PageTitle
Dim Description

PageTitle= Request.Form("PageTitle")
Description= Request.Form("Description")


conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath("../../db/AlpacaDB.mdb") & ";" & _
						"User Id=;Password=;" 


	sql = "select Distinct PageID from GalleryPhotos"
	Set rs = Server.CreateObject("ADODB.Recordset")
	rs.Open sql, conn, 3, 3 
	
	If rs.eof then
		NewPageNumber = 1
	else
		NewPageNumber = 1
		while not rs.eof
			NewPageNumber = NewPageNumber +1
			'response.write(NewPageNumber)
			rs.movenext
		wend
	end if

		Query =  "INSERT INTO GalleryPhotos ( PageID)" 
		Query =  Query & " Values (" & NewPageNumber & ")" 
		'response.write(Query)

		Set DataConnection = Server.CreateObject("ADODB.Connection")

		DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath("../../db/AlpacaDB.mdb") 	& ";" 

		DataConnection.Execute(Query) 

		Query =  "INSERT INTO GalleryHeadings ( PageID, Title, Description)" 
		Query =  Query & " Values (" & NewPageNumber & ", "
		Query =  Query & "'" & PageTitle & "', "
		Query =  Query & "'" & Description & "'); "

		'response.write(Query)

		Set DataConnection = Server.CreateObject("ADODB.Connection")

		DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath("../../db/AlpacaDB.mdb") 	& ";" 

		DataConnection.Execute(Query) 


		DataConnection.Close
		Set DataConnection = Nothing 
%>

<table width = "660" align = "center">
	<tr >
		<td align = "right">
			<br><a  class = "Links" href="GalleryPhotos.asp"> Return to the Gallery Photos Page</a>
			<br>
		</td>
	</tr>
</table>
<!--#Include virtual="/administration/Footer.asp"--> </Body>
</HTML>
