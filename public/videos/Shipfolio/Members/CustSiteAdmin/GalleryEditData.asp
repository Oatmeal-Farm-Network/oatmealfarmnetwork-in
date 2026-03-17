<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4+0 Transitional//EN">
<HTML>
<HEAD>
 <title>Galery Edit Results Page</title>
      <link rel="stylesheet" type="text/css" href="style.css">
</HEAD>

<BODY bgcolor = "white">
<!--#Include virtual="/administration/Header.asp"--> 
<%
dim pPhotoID(100)
dim pPageID(100)
dim pLocation(100)
dim	PhotoL(100)
dim	Photo(100)
dim	Shape(100)
dim	pCaption(100)

Dim TotalCount


TotalCount= Request.Form("TotalCount")
TotalCount = CInt(TotalCount)
'rowcount = CInt(rowcount)
rowcount = 1

while (rowcount < TotalCount)
    pPhotoIDcount = "pPhotoID(" & rowcount & ")"
	pPageIDcount = "pPageID(" & rowcount & ")"
	pLocationcount = "pLocation(" & rowcount & ")"
	PhotoLcount = "PhotoL(" & rowcount & ")"
	Photocount = "Photo(" & rowcount & ")"
	Shapecount = "Shape(" & rowcount & ")"
	pCaptioncount = "pCaption(" & rowcount & ")"

	pPhotoID(rowcount)=Request.Form(pPhotoIDcount) 
	pPageID(rowcount)=Request.Form(pPageIDcount) 
	pLocation(rowcount)=Request.Form(pLocationcount) 
	PhotoL(rowcount)=Request.Form(PhotoLcount) 
	Photo(rowcount)=Request.Form(Photocount) 
	Shape(rowcount)=Request.Form(Shapecount) 
	pCaption(rowcount)=Request.Form(pCaptioncount)

	rowcount = rowcount +1

Wend

 rowcount =1

while (rowcount < TotalCount)

str1 = pCaption(rowcount)
str2 = "'"
If InStr(str1,str2) > 0 Then
	pCaption(rowcount)= Replace(str1, "'", "''")
End If

if pLocation(rowcount) = "" then
	pLocation(rowcount) = "0"
end if


	Query =  " UPDATE GalleryPhotos Set PageID = " +  pPageID(rowcount) + ", " 
    Query =  Query + " Location = " +  pLocation(rowcount) + "," 
    Query =  Query + " PhotoL = '"  +  PhotoL(rowcount) + "'," 
	Query =  Query + " Photo = '"  +  Photo(rowcount) + "'," 
	Query =  Query + " Shape = '"  +  Shape(rowcount) + "'," 
    Query =  Query + " Caption = '" +  pCaption(rowcount) + "'" 
    Query =  Query + " where GalleryPhotoID = " + pPhotoID(rowcount) + ";" 

'response.write(Query)
Dim DataConnection, cmdDC, RecordSet
Dim RecordToEdit, Updated
Set DataConnection = Server.CreateObject("ADODB.Connection")

DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath("../../db/AlpacaDB.mdb") & ";" 


DataConnection.Execute(Query) 


		
		DataConnection.Execute(Query) 
	  rowcount= rowcount +1
	Wend

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
			<br><a  class = "Links" href="GalleryPhotos.asp"> Return to the Gallery Edit Data Page</a>
			<br>
		</td>
	</tr>
</table>
<!--#Include virtual="/administration/Footer.asp"--> </Body>
</HTML>
