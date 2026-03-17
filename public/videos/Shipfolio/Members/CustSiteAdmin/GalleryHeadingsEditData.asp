<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4+0 Transitional//EN">
<HTML>
<HEAD>
 <title>Galery Headings Edit Results Page</title>
      <link rel="stylesheet" type="text/css" href="style.css">
</HEAD>

<BODY bgcolor = "white">
<!--#Include virtual="/administration/Header.asp"--> 
<%
dim GalleryHeading(100)
dim PageID(100)
dim Title(100)
dim	Description(100)

Dim TotalCount


TotalCount= Request.Form("TotalCount")
TotalCount = CInt(TotalCount)
'rowcount = CInt(rowcount)
rowcount = 1

while (rowcount < TotalCount)
    GalleryHeadingcount = "GalleryHeading(" & rowcount & ")"
	PageIDcount = "PageID(" & rowcount & ")"
	Titlecount = "Title(" & rowcount & ")"
	Descriptioncount = "Description(" & rowcount & ")"

	GalleryHeading(rowcount)=Request.Form(GalleryHeadingcount) 
	PageID(rowcount)=Request.Form(PageIDcount) 
	Title(rowcount)=Request.Form(Titlecount) 
	Description(rowcount)=Request.Form(Descriptioncount) 

	rowcount = rowcount +1

Wend

 rowcount =1

while (rowcount < TotalCount)

str1 = Title(rowcount)
str2 = "'"
If InStr(str1,str2) > 0 Then
	Title(rowcount)= Replace(str1, "'", "''")
End If

str1 = Description(rowcount)
str2 = "'"
If InStr(str1,str2) > 0 Then
	Description(rowcount)= Replace(str1, "'", "''")
End If


	Query =  " UPDATE GalleryHeadings Set PageID = " +  PageID(rowcount) + ", " 
    Query =  Query + " Title = '"  +  Title(rowcount) + "'," 
    Query =  Query + " Description = '" +  Description(rowcount) + "'" 
    Query =  Query + " where GalleryHeadingID = " + GalleryHeading(rowcount) + ";" 

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
