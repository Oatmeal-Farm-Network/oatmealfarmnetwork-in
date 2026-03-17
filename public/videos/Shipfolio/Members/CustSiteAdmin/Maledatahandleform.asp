<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4+0 Transitional//EN">
<HTML>
<HEAD>
 <title>Male Data Results Page</title>
              <link rel="stylesheet" type="text/css" href="style.css">
</HEAD>

<BODY background = "images/background.jpg">
<!--#Include virtual="/administration/Header.asp"--> 
<%

Dim TotalCount
dim rowcount
dim ID(300)
dim FullName(300)
dim Category(300)
dim StudFee(300)
dim StudComments(300)

TotalCount= Request.Form("TotalCount")
TotalCount = CInt(TotalCount)
'rowcount = CInt(rowcount)
rowcount = 1

while (rowcount < TotalCount)
	IDcount = "ID(" & rowcount & ")"	
	FullNamecount = "Name(" & rowcount & ")"
	Categorycount = "Category(" & rowcount & ")"
	StudFeecount = "StudFee(" & rowcount & ")"
	StudCommentscount = "StudComments(" & rowcount & ")"
	
	ID(rowcount)=Request.Form(IDcount) 
	FullName(rowcount)=Request.Form(FullNamecount) 
	Category(rowcount)=Request.Form(Categorycount) 
	StudFee(rowcount)=Request.Form(StudFeecount)
	StudComments(rowcount)=Request.Form(StudCommentscount) 
	
response.write(FullName(rowcount))
	rowcount = rowcount +1
Wend

 rowcount =1

while (rowcount < TotalCount)

if len(StudFee(rowcount) ) < 2 then
	StudFee(rowcount) ="0"
end if

str1 = StudComments(rowcount)
str2 = "'"
If InStr(str1,str2) > 0 Then
	StudComments(rowcount)= Replace(str1, "'", "''")
End If

	Query =  " UPDATE MaleData Set StudFee = '" +  StudFee(rowcount) + "' " 
    Query =  Query + " where ID = " + ID(rowcount) + ";" 

Dim DataConnection, cmdDC, RecordSet
Dim RecordToEdit, Updated
Set DataConnection = Server.CreateObject("ADODB.Connection")

DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath("../../db/AlpacaDB.mdb") & ";" 

'response.write(Query)

DataConnection.Execute(Query) 

	Query =  " UPDATE Animals Set Category = '" +  Category(rowcount) + "'" 
    Query =  Query + " where ID = " + ID(rowcount) + ";" 
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
			<br><a  class = "Links" href="MaleData.asp"> Return to Male Data Page</a>
			<br>
		</td>
	</tr>
</table>
<!--#Include virtual="/administration/Footer.asp"--> 
</BODY>
</HTML>
