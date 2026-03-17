<!DOCTYPE HTML>
<HTML>
<HEAD>
<link rel="stylesheet" type="text/css" href="style.css">
</HEAD>
<% if mobiledevice = True  then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
<% end if %>

<!--#Include virtual="/Administration/Header.asp"--> 
<%

Dim TotalCount
dim	rowcount
dim	ID(400) 
Dim PackageID1(400)
Dim PackageID2(400)
Dim PackageID3(400)
Dim PackageID4(400)

TotalCount= Request.Form("TotalCount")
TotalCount = CInt(TotalCount)
'rowcount = CInt(rowcount)
rowcount = 1
	page=Request.Form("page") 	
	'response.write(page)
while (rowcount < TotalCount)
    IDcount = "ID(" & rowcount & ")"
	PackageID1count = "PackageID1(" & rowcount & ")"
	PackageID2count = "PackageID2(" & rowcount & ")"
	PackageID3count = "PackageID3(" & rowcount & ")"
	PackageID4count = "PackageID4(" & rowcount & ")"


	ID(rowcount)=Request.Form(IDcount) 
	PackageID1(rowcount)=Request.Form(PackageID1count) 
	PackageID2(rowcount)=Request.Form(PackageID2count) 
	PackageID3(rowcount)=Request.Form(PackageID3count) 
	PackageID4(rowcount)=Request.Form(PackageID4count) 

	rowcount = rowcount +1

Wend

 rowcount =1

while (rowcount < TotalCount)

if PackageID1(rowcount) = "" then
	PackageID1(rowcount) = "0"
end If

if PackageID2(rowcount) = "" then
	PackageID2(rowcount) = "0"
end If

if PackageID3(rowcount) = "" then
	PackageID3(rowcount) = "0"
end If

if PackageID4(rowcount) = "" then
	PackageID4(rowcount) = "0"
end if

	Query =  " UPDATE Animals Set PackageID = " +  PackageID1(rowcount) + "," 
	Query =  Query + " PackageID2 = " +  PackageID2(rowcount) + "," 
	Query =  Query + " PackageID3 = " +  PackageID3(rowcount) + "," 
	Query =  Query + " PackageID4 = " +  PackageID4(rowcount) + "" 
    Query =  Query + " where ID = " + ID(rowcount) + ";" 



'response.write(Query)
Dim DataConnection, cmdDC, RecordSet
Dim RecordToEdit, Updated
Set DataConnection = Server.CreateObject("ADODB.Connection")




Conn.Execute(Query) 


		
		Conn.Execute(Query) 
	  rowcount= rowcount +1
	Wend


 %>
<div align = "center"><H2>
<%
     response.write("Your changes have successfully been made.")
  %></H2>

<%

 

	Conn.Close
	Set Conn = Nothing %>


<table width = "660" align = "center">
	<tr >
		<td align = "right">
			<br><a  class = "Links" href="packages.asp"> Return to the edit packages page</a>
			<br>
		</td>
	</tr>
</table>






<!--#Include virtual="/Administration/Footer.asp"--> </Body>
</HTML>
