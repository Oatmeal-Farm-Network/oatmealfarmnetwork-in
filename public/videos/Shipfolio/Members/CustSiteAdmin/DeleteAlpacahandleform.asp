<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4+0 Transitional//EN">
<HTML>
<HEAD>
 <title>General Animal Data Results Page</title>
       <link rel="stylesheet" type="text/css" href="style.css">
</HEAD>

<BODY bgcolor = "white">
<!--#Include virtual="/administration/Header.asp"--> 
<%

dim ID

	ID=Request.Form("ID" ) 
	
	
    
	Dim DataConnection, cmdDC, RecordSet
	Dim RecordToEdit, Updated
	Set DataConnection = Server.CreateObject("ADODB.Connection")

	DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath("../../db/AlpacaDB.mdb") & ";" 





	Query =  "Delete * From AdditionalPhotos where ID = " +  ID + "" 
	DataConnection.Execute(Query) 

	Query =  "Delete * From Ancestors where ID = " +  ID + "" 
	DataConnection.Execute(Query) 

	Query =  "Delete * From Animals where ID = " +  ID + "" 
	DataConnection.Execute(Query) 

	Query =  "Delete * From Awards where ID = " +  ID + "" 
	DataConnection.Execute(Query) 


	Query =  "Delete * From FemaleData where ID = " +  ID + "" 
	DataConnection.Execute(Query) 

	Query =  "Delete * From Fiber where ID = " +  ID + "" 
	DataConnection.Execute(Query) 

	Query =  "Delete * From GodFather where ID = " +  ID + "" 
	DataConnection.Execute(Query) 

	Query =  "Delete * From MaleData where ID = " +  ID + "" 
	DataConnection.Execute(Query) 

	Query =  "Delete * From PackageAnimals where AnimalID = " +  ID + "" 
	DataConnection.Execute(Query) 

	Query =  "Delete * From Photos where ID = " +  ID + "" 
	DataConnection.Execute(Query) 
	
	Query =  "Delete * From Pricing where ID = " +  ID + "" 
	DataConnection.Execute(Query) 

	Query =  "Delete * From Specials where ID = " +  ID + "" 
	DataConnection.Execute(Query) 

IF DataConnection.Errors.Count <> 0 then
     Call MyErrorHandler(oDBConn, sSQL)  ' pass database connection as param
 Else
 %>
<div align = "center"><H2>
<%
     response.write("Your alpaca has successfully been deleted.")
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
			<br><a  class = "Links" href="AddAlpaca.asp"> Return to the add or delete an alpaca page</a>
			<br>
		</td>
	</tr>
</table>
<!--#Include virtual="/administration/Footer.asp"--> </Body>
</HTML>
