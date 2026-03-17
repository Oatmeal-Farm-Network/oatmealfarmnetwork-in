<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4+0 Transitional//EN">
<HTML>
<HEAD>
 <title>Fiber Data Results Page</title>
       <link rel="stylesheet" type="text/css" href="style.css">
</HEAD>

<BODY bgcolor = "white">
<!--#Include virtual="/administration/Header.asp"--> 
<%

Dim TotalCount
dim rowcount

	dim Show(300)
	dim Placing(300)
	dim AClass(300)
	dim Judge(300)
	dim ClassSize(300)
	dim ShowLevel(300)
	dim ShowYear(300)
	dim AwardType(300)

TotalCount= Request.Form("TotalCount")
TotalCount = CInt(TotalCount)
'rowcount = CInt(rowcount)
rowcount = 0

	
	Showcount = "Show(" & rowcount & ")"
	Placingcount = "Placing(" & rowcount & ")"
	aClasscount = "aClass(" & rowcount & ")"
	Judgecount = "Judge(" & rowcount & ")"
	ClassSizecount = "ClassSize(" & rowcount & ")"
	ShowLevelcount = "ShowLevel(" & rowcount & ")"
	ShowYearcount = "ShowYear(" & rowcount & ")"
	AwardTypecount = "AwardType(" & rowcount & ")"
		
	ID=Request.Form("ID")
	'response.write(ID)
	Show(rowcount)=Request.Form(Showcount) 
	Placing(rowcount)=Request.Form(Placingcount )
	aClass(rowcount)=Request.Form(aClasscount) 
	Judge(rowcount)=Request.Form(Judgecount) 
	ClassSize(rowcount)=Request.Form(ClassSizecount) 


if len(ID) < 1 then
	response.write("<center>Your changes could not be made. Please select an Alpaca's Name</center>")
	
else

Query =  "INSERT INTO Awards ( ID, Show, Placing, Class, Judge, ClassSize)" 
	Query =  Query + " Values (" +  ID + " ,"
	Query =  Query +  " '" + Show(rowcount) + "', " 
	Query =  Query +  " '" + Placing(rowcount) + "', " 
    Query =  Query +  " '" + aClass(rowcount) + "'," 
    Query =  Query +  " '" + Judge(rowcount) + "'," 
    Query =  Query +  " '" + ClassSize(rowcount) + "')" 


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
end if 
%>

<table width = "660" align = "center">
	<tr >
		<td align = "right">
			<br><a  aClass = "Links" href="Awards.asp"> Return to Awards Page</a>
			<br>
		</td>
	</tr>
</table>
<!--#Include virtual="/administration/Footer.asp"--> </Body>
</HTML>
