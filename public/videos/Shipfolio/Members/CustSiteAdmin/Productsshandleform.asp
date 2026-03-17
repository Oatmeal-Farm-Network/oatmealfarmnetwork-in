<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4+0 Transitional//EN">
<HTML>
<HEAD>
 <title>General Animal Data Results Page</title>
       <link rel="stylesheet" type="text/css" href="/administration/style.css">

</HEAD>

<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white" height = "600">

<!--#Include virtual="/Administration/Header.asp"--> 
<%

Dim TotalCount
dim	rowcount
dim	ID(40000) 
dim	Name(40000) 
dim	ARI(40000) 
dim	DOB(40000) 
dim	Color(40000) 
dim	ColorCategory(40000) 
dim	Category(40000) 
dim	Breed(40000) 
dim	GroupID(40000) 
Dim PackageID(40000)
Dim ShowQuantity(40000)

TotalCount= Request.Form("TotalCount")
TotalCount = CInt(TotalCount)
'rowcount = CInt(rowcount)
rowcount = 1

while (rowcount < TotalCount)
    IDcount = "ID(" & rowcount & ")"
	namecount = "Name(" & rowcount & ")"
	ARIcount = "ARI(" & rowcount & ")"
	DOBcount = "DOB(" & rowcount & ")"
	Colorcount = "Color(" & rowcount & ")"
	ColorCategorycount = "ColorCategory(" & rowcount & ")"
	Categorycount = "Category(" & rowcount & ")"
	Breedcount = "Breed(" & rowcount & ")"
	GroupIDcount = "GroupID(" & rowcount & ")"
	PackageIDcount = "PackageID(" & rowcount & ")"
	ShowQuantitycount = "ShowQuantity(" & rowcount & ")"

	ID(rowcount)=Request.Form(IDcount) 
	Name(rowcount)=Request.Form(namecount) 
	ARI(rowcount)=Request.Form(ARIcount) 
	DOB(rowcount)=Request.Form(DOBcount) 
	Color(rowcount)=Request.Form(Colorcount)
	ColorCategory(rowcount)=Request.Form(ColorCategorycount)
	Category(rowcount)=Request.Form(Categorycount) 
	Breed(rowcount)=Request.Form(Breedcount) 
	GroupID(rowcount)=Request.Form(GroupIDcount) 
	PackageID(rowcount)=Request.Form(PackageIDcount) 
	ShowQuantity(rowcount)=Request.Form(ShowQuantitycount) 
	rowcount = rowcount +1

Wend

 rowcount =1

while (rowcount < TotalCount)

str1 = Name(rowcount)
str2 = "'"
If InStr(str1,str2) > 0 Then
	Name(rowcount)= Replace(str1, "'", "''")
End If

if GroupID(rowcount) = "" then
	GroupID(rowcount) = "0"
end If

if PackageID(rowcount) = "" then
	PackageID(rowcount) = "0"
end if



	Query =  " UPDATE Animals Set FullName = '" +  Name(rowcount) + "', " 
    Query =  Query + " ARI = '" +  ARI(rowcount) + "'," 
    Query =  Query + " Category = '" +  Category(rowcount) + "'" 
    Query =  Query + " where ID = " + ID(rowcount) + ";" 


Dim DataConnection, cmdDC, RecordSet
Dim RecordToEdit, Updated
Set DataConnection = Server.CreateObject("ADODB.Connection")

DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 


DataConnection.Execute(Query) 

	Query =  " UPDATE Products Set ShowQuantity = " +  ShowQuantity(rowcount) + " " 
    Query =  Query + " where ProductID = " + ID(rowcount) + ";" 
'response.write(Query)		
		DataConnection.Execute(Query) 
	  rowcount= rowcount +1
	Wend


 %>
<div align = "center"><H2>
<%
     response.write("Your changes have successfully been made.")
  %></H2>

<%

 

	DataConnection.Close
	Set DataConnection = Nothing 

%>

<table width = "660" align = "center">
	<tr >
		<td align = "right">
			<br><a  class = "Links" href="ProductsGeneralData.asp"> Return to Edit General Products Data Page</a>
			<br>
		</td>
	</tr>
</table>
<!--#Include virtual="/Administration/Footer.asp"--> </Body>
</HTML>
