<!DOCTYPE HTML>
<HTML>
<HEAD>
<title>The Andresen Group Content Management System</title>
<link rel="stylesheet" type="text/css" href="style.css">
</HEAD>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
<!--#Include File="AdminSecurityInclude.asp"--> 
<!--#Include File="AdminGlobalVariables.asp"--> 
<!--#Include File="AdminHeader.asp"--> 
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth %>">
<tr><td Class = "body roundedtopandbottom" height = "600" valign = "top">
<%

Dim TotalCount
dim rowcount
dim ID(400)
dim GodfatherID(400)
dim SalesText(400)
dim EndDate(400)
dim Pending(400)


TotalCount= Request.Form("TotalCount")
TotalCount = CInt(TotalCount)
rowcount = 1

while (rowcount < TotalCount)
	IDcount = "ID(" & rowcount & ")"	
	GodfatherIDcount = "GodfatherID(" & rowcount & ")"	
	SalesTextcount = "SalesText(" & rowcount & ")"
	EndDatecount = "EndDate(" & rowcount & ")"
	Pendingcount = "Pending(" & rowcount & ")"

	
	ID(rowcount)=Request.Form(IDcount) 
	GodfatherID(rowcount)=Request.Form(GodfatherIDcount) 
	SalesText(rowcount)=Request.Form(SalesTextcount) 
	EndDate(rowcount)=Request.Form(EndDatecount )
	Pending(rowcount)=Request.Form(Pendingcount) 
	rowcount = rowcount +1
Wend

 rowcount =1

while (rowcount < TotalCount)

str1 = SalesText(rowcount) 
str2 = "'"
If InStr(str1,str2) > 0 Then
	SalesText(rowcount) = Replace(str1, "'", "''")
End If


	Query =  " UPDATE Godfather Set EndDate = '" +  EndDate(rowcount) + "', " 
    Query =  Query + " SalePending = " +   Pending(rowcount) + "," 
	Query =  Query + " SalesText = '" +   SalesText(rowcount) + "'," 
    Query =  Query + "  ID = " + ID(rowcount) + "" 
	Query =  Query + " where SpecialID = " + GodfatherID(rowcount) + ";" 

'response.write(Query)	

Dim DataConnection, cmdDC, RecordSet
Dim RecordToEdit, Updated
Set DataConnection = Server.CreateObject("ADODB.Connection")

DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 



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

<%

 End If

	DataConnection.Close
	Set DataConnection = Nothing 

%>

<table width = "660" align = "center">
	<tr >
		<td align = "right">
			<br><a  Class = "Links" href="Godfather.asp"> Return to Godfather Page</a>
			<br>
		</td>
	</tr>
</table>
  <!--#Include File="AdminFooter.asp"--></Body>
</HTML>
