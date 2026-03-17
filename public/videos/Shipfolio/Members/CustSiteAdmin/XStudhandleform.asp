<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4+0 Transitional//EN">
<HTML>
<HEAD>
 <title>Outside Stud Data Results Page</title>
          <link rel="stylesheet" type="text/css" href="style.css">
</HEAD>

<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">

<!--#Include virtual="/administration/Header.asp"--> 
<%
	Dim ExternalStudID(300)
	dim FullName(300)
	dim ServiceSireLink(300)
	dim Breed(300)
	dim ServiceSireImage(300)
	dim ServiceSireColor(300)
	dim TotalCount
	dim rowcount

TotalCount= Request.Form("TotalCount")
TotalCount = CInt(TotalCount)
'rowcount = CInt(rowcount)
rowcount = 1

while (rowcount < TotalCount)
	ExternalStudIDcount = "ExternalStudID(" & rowcount & ")"	
	FullNamecount = "FullName(" & rowcount & ")"
	ServiceSireLinkcount = "ServiceSireLink(" & rowcount & ")"
	Breedcount = "Breed(" & rowcount & ")"
	ServiceSireImagecount = "ServiceSireImage(" & rowcount & ")"
	ServiceSireColorcount = "ServiceSireColor(" & rowcount & ")"
	DamSireNamecount = "DamSireName(" & rowcount & ")"
	DamSireColorcount = "DamSireColor(" & rowcount & ")"
		
	ExternalStudID(rowcount)=Request.Form(ExternalStudIDcount) 
	FullName(rowcount)=Request.Form(FullNamecount) 
	ServiceSireLink(rowcount)=Request.Form(ServiceSireLinkcount)
	Breed(rowcount)=Request.Form(Breedcount) 
	ServiceSireImage(rowcount)=Request.Form(ServiceSireImagecount) 
	ServiceSireColor(rowcount)=Request.Form(ServiceSireColorcount) 
	rowcount = rowcount +1
Wend

 rowcount =1

while (rowcount < TotalCount)

str1 = FullName(rowcount)
str2 = "'"
If InStr(str1,str2) > 0 Then
	FullName(rowcount)= Replace(str1, "'", "''")
End If

	Query =  " UPDATE ExternalStud Set AlpacaName = '" +  FullName(rowcount) + "', " 
    Query =  Query + " Breed = '" +   Breed(rowcount) + "'," 
	Query =  Query + " ServiceSireLink = '" +  ServiceSireLink(rowcount) + "'," 
    Query =  Query + " ServiceSireImage = '" +  ServiceSireImage(rowcount) + "'," 
    Query =  Query + " ServiceSireColor = '"  +  ServiceSireColor(rowcount) + "'" 
    Query =  Query + " where ExternalStudID = " + ExternalStudID(rowcount) + ";" 
'response.write(Query)

Dim DataConnection, cmdDC, RecordSet
Dim RecordToEdit, Updated
Set DataConnection = Server.CreateObject("ADODB.Connection")

DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath("../../db/AlpacaDB.mdb")& ";" 



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
			<br><a  class = "Links" href="Xstuds.asp"> Return to Outside Stud Data Page</a>
			<br>
		</td>
	</tr>
</table>
<!--#Include virtual="/administration/Footer.asp"--> </Body>
</HTML>
