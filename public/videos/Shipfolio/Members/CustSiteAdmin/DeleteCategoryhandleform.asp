<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4+0 Transitional//EN">
<HTML>
<HEAD>
 <title>Delete Category Results Page</title>
       <link rel="stylesheet" type="text/css" href="/administration/style.css">

</HEAD>

<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white" >

<!--#Include virtual="/Administration/Header.asp"--> 

<table height = "300" align = "center">
	<tr>
		<td class = "body" align = "center" valign = "top">
        <br><br><br>
<%

	dim TempCategoryID

	TempCategoryID=Request.Form("CategoryID" ) 
	TempCategoryType=Request.Form("CategoryType" ) 

	Dim DataConnection, cmdDC, RecordSet
	Dim RecordToEdit, Updated
	Set DataConnection = Server.CreateObject("ADODB.Connection")

	DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 



	Query =  "Delete * From ProductCategories where CategoryID = " & TempCategoryID 
	'response.write(Query)
	DataConnection.Execute(Query) 

	

	DataConnection.Close
	Set DataConnection = Nothing 

%>
<!--#Include virtual="/Administration/ForSaleCategoriesInclude.asp"-->

<!--#Include virtual="/Administration/Footer.asp"--> </Body>
</HTML>