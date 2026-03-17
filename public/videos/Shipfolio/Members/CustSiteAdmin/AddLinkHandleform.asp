<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
<HEAD>
 <title>Add Link Handle Page</title>
       <link rel="stylesheet" type="text/css" href="/administration/style.css">
</HEAD>

<BODY bgcolor = "white">
<!--#Include virtual="/Administration/Header.asp"--> 
<%


dim LinkText1
dim Link1
dim LinkDescription1
dim CatID1

	LinkText1=Request.Form("LinkText" ) 
	Link1=Request.Form("Link" ) 
	LinkDescription1=Request.Form( "LinkDescription" ) 
	CatID1=Request.Form( "CatID" ) 

str1 = LinkText1
str2 = "'"
If InStr(str1,str2) > 0 Then
	LinkText1= Replace(str1, "'", "''")
End If

str1 = LinkDecription
str2 = "'"
If InStr(str1,str2) > 0 Then
	LinkDecription= Replace(str1, "'", "''")
End If

		Query =  "INSERT INTO Links ( LinkText, Link, CatID, LinkDescription)" 
		Query =  Query + " Values ('" &  LinkText1 & "'," 
		Query =  Query & " '" &  Link1 & "'," 
		Query =  Query & " " &  CatID1 & "," 
		Query =  Query & " '" &  LinkDescription1  & "')"

		Set DataConnection = Server.CreateObject("ADODB.Connection")

		DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) 	& ";" 
'response.write(Query)
		DataConnection.Execute(Query) 
		DataConnection.Close
		Set DataConnection = Nothing 


 %>
<div align = "center"><H2>Your changes have successfully been made.</H2><br><br>

<%

		Response.Redirect("/Administration/LinkMaintenance.asp")


%>

<!--#Include file="LinkMaintenanceInclude.asp"-->
<!--#Include virtual="/Administration/Footer.asp"--> </Body>
</HTML>
