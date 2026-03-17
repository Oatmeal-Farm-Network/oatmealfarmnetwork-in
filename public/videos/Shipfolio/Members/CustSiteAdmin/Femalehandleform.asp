<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4+0 Transitional//EN">
<HTML>
<HEAD>
 <title>Female Data Results Page</title>
        <link rel="stylesheet" type="text/css" href="style.css">
</HEAD>

<BODY bgcolor = "white">
<!--#Include virtual="/administration/Header.asp"--> 
<%

Dim TotalCount
dim rowcount
dim ID(300)
dim FullName(300)
dim Bred(300)
dim BredTo(300)
dim ServiceSireID(300)
dim ServiceSireLink(300)
dim RecentProgenyID(300)
dim XServiceSireID(300)
dim DueDate(300)

TotalCount= Request.Form("TotalCount")
TotalCount = CInt(TotalCount)
'rowcount = CInt(rowcount)
rowcount = 1

while (rowcount < TotalCount)
	IDcount = "ID(" & rowcount & ")"	
	FullNamecount = "FullName(" & rowcount & ")"
	Bredcount = "Bred(" & rowcount & ")"
	BredTocount = "BredTo(" & rowcount & ")"
	XServiceSireIDcount = "XServiceSireID(" & rowcount & ")"
	ServiceSireIDcount = "ServiceSireID(" & rowcount & ")"
	ServiceSireLinkcount = "ServiceSireLink(" & rowcount & ")"
	RecentProgenyIDcount = "RecentProgenyID(" & rowcount & ")"
	DueDatecount = "DueDate(" & rowcount & ")"
	
	ID(rowcount)=Request.Form(IDcount) 
	FullName(rowcount)=Request.Form(FullNamecount) 
	Bred(rowcount)=Request.Form(Bredcount )
	BredTo(rowcount)=Request.Form(BredTocount) 
	XServiceSireID(rowcount)=Request.Form(XServiceSireIDcount) 
	ServiceSireID(rowcount)=Request.Form(ServiceSireIDcount) 
	ServiceSireLink(rowcount)=Request.Form(ServiceSireLinkcount) 
	RecentProgenyID(rowcount)=Request.Form(RecentProgenyIDcount) 
	DueDate(rowcount)=Request.Form(DueDatecount)
	rowcount = rowcount +1
Wend

 rowcount =1

while (rowcount < TotalCount)



str1 = BredTo(rowcount) 
str2 = "'"
If InStr(str1,str2) > 0 Then
	BredTo(rowcount) = Replace(str1, "'", "''")
End If


str1 = ServiceSireID(rowcount) 
If  str1= " " or str1="" Then
	ServiceSireID(rowcount) = "0"
End If

str1 = XServiceSireID(rowcount) 
If  str1= " " or str1="" Then
	XServiceSireID(rowcount) = "0"
End If

str2 = RecentProgenyID(rowcount) 
If  str2= " " or str2="" Then
	RecentProgenyID(rowcount) = "0"
End If


	Query =  " UPDATE FemaleData Set Bred = " +  Bred(rowcount) + ", " 
    Query =  Query + " BredTo = '" +  BredTo(rowcount) + "'," 
    Query =  Query + " ServiceSireID = " +   ServiceSireID(rowcount) + "," 
	   Query =  Query + " ExternalStudID = " +   XServiceSireID(rowcount) + "," 
    Query =  Query + " RecentProgenyID = " +  RecentProgenyID(rowcount) + ","

	Query =  Query + " DueDate = '" +  DueDate(rowcount) + "'" 
    Query =  Query + " where ID = " + ID(rowcount) + ";" 

'response.write(Query)	

Dim DataConnection, cmdDC, RecordSet
Dim RecordToEdit, Updated
Set DataConnection = Server.CreateObject("ADODB.Connection")

DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath("../../db/AlpacaDB.mdb") & ";" 



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
			<br><a  class = "Links" href="FemaleData.asp"> Return to Female Data Page</a>
			<br>
		</td>
	</tr>
</table>
<!--#Include virtual="/administration/Footer.asp"--> </Body>
</HTML>
