<!DOCTYPE HTML>
<HTML>
<HEAD>
<title>The Andresen Group Content Management System</title>
       <link rel="stylesheet" type="text/css" href="style.css">

</HEAD>

<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white" >

<!--#Include file="AdminSecurityInclude.asp"-->
<!--#Include file="AdminGlobalVariables.asp"-->
<!--#Include file="AdminHeader.asp"--> 

<%

	dim TempCategoryID

	TempCategoryID=Request.Form("CategoryID" ) 
	TempCategoryType=Request.Form("CategoryType" ) 
	DeleteCategoryType=Request.Form("DeleteCategoryType" ) 


	Dim DataConnection, cmdDC, RecordSet
	Dim RecordToEdit, Updated
	Set DataConnection = Server.CreateObject("ADODB.Connection")

	DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 

   If DeleteCategoryType = "Category" then

	Query =  "Delete * From SFCategories where CatID = " & TempCategoryID 
	'response.write(Query)
	DataConnection.Execute(Query) 

  End If 	

    If DeleteCategoryType = "SubCategory" then

	Query =  "Delete * From SFSubCategories where subcatId = " & TempCategoryID 
	'response.write(Query)
	DataConnection.Execute(Query) 

  End If 	

	DataConnection.Close
	Set DataConnection = Nothing 
response.redirect("AdminSetSaleCategories.asp")
%>

</Body>
</HTML>