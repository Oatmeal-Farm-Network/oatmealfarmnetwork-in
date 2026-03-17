<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4+0 Transitional//EN">
<HTML>
<HEAD>
 <title>Add Awards Results Page</title>
       <link rel="stylesheet" type="text/css" href="/administration/style.css">
</HEAD>

<BODY bgcolor = "white">
<!--#Include virtual="/Administration/Header.asp"--> 
<%

Dim TotalCount
dim rowcount

	dim Color(400)
	dim Placing(400)
	dim AClass(400)
	dim Judge(400)
	dim ClassSize(400)
	dim ColorLevel(400)
	dim ColorYear(400)
	dim AwardType(400)

TotalCount= Request.Form("TotalCount")
TotalCount = CInt(TotalCount)
'rowcount = CInt(rowcount)
rowcount = 0

	
	Colorcount = "Color(" & rowcount & ")"
	Placingcount = "Placing(" & rowcount & ")"
	aClasscount = "aClass(" & rowcount & ")"
	Judgecount = "Judge(" & rowcount & ")"
	ClassSizecount = "ClassSize(" & rowcount & ")"
	ColorLevelcount = "ColorLevel(" & rowcount & ")"
	ColorYearcount = "ColorYear(" & rowcount & ")"
	AwardTypecount = "AwardType(" & rowcount & ")"
		
	ProductID=Request.Form("ProductID")
	'response.write(ID)
	Color(rowcount)=Request.Form(Colorcount) 
	Placing(rowcount)=Request.Form(Placingcount )
	aClass(rowcount)=Request.Form(aClasscount) 
	Judge(rowcount)=Request.Form(Judgecount) 
	ClassSize(rowcount)=Request.Form(ClassSizecount) 
	ColorLevel(rowcount)=Request.Form(ColorLevelcount) 
	AwardType(rowcount)=Request.Form(AwardTypecount) 
	ColorYear(rowcount)=Request.Form(ColorYearcount) 

if len(ColorLevel(rowcount)) = 0 then
	ColorLevel(rowcount) = "0"
end if

if len(ProductID) < 1 then
	response.write("<center>Your changes could not be made. Please select an Products's Name</center>")
	
else

Query =  "INSERT INTO ProductColor( ProductID, Color )" 
	Query =  Query + " Values (" +  ProductID + ", "
   Query =  Query +   " '" + Color(rowcount) + "' )" 


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

<%

 End If

	DataConnection.Close
	Set DataConnection = Nothing 
end if 
%>

<table width = "660" align = "center">
	<tr >
		<td align = "right">
			<br><a  aClass = "Links" href="Colors.asp"> Return to the Product Colors Page</a>
			<br>
		</td>
	</tr>
</table>
<!--#Include virtual="/Administration/Footer.asp"--> </Body>
</HTML>
