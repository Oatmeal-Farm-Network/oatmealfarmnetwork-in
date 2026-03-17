<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4+0 Transitional//EN">
<HTML>
<HEAD>
 <title>Delete Article Category Results Page</title>
       <link rel="stylesheet" type="text/css" href="style.css">

</HEAD>

<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  >
<!--#Include file="GlobalVariables.asp"-->
<!--#Include file="Header.asp"--> 


<%

	dim TempCategoryID

	TempCategoryID=Request.Form("ArticleCatID" ) 
	TempCategoryType=Request.Form("CategoryType" ) 
	DeleteCategoryType=Request.Form("DeleteCategoryType" ) 


	Dim DataConnection, cmdDC, RecordSet
	Dim RecordToEdit, Updated
	Set DataConnection = Server.CreateObject("ADODB.Connection")

	DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 

   If DeleteCategoryType = "Category" then

	Query =  "Delete * From ArticleCategories where ArticleCatID = " & TempCategoryID 
	'response.write(Query)
	DataConnection.Execute(Query) 

  End If 	

    If DeleteCategoryType = "SubCategory" then

	Query =  "Delete * From SubCategories where SubCategoryID = " & TempCategoryID 
	'response.write(Query)
	DataConnection.Execute(Query) 

  End If 	

	DataConnection.Close
	Set DataConnection = Nothing 

%>
	<!--#Include file="ArticleCategoriesInclude.asp"-->

<!--#Include file="Footer.asp"--> </Body>
</HTML>