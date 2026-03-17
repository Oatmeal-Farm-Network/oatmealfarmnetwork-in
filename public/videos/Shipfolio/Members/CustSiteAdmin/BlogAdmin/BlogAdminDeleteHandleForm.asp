<!DOCTYPE HTML>

<HTML>
<HEAD>
 <title>Delete Blog</title>

</head>

<BODY bgcolor = "white">

<!--#Include File="BlogAdminGlobalVariables.asp"--> 
<!--#Include File="BlogAdminSecurityInclude.asp"--> 
<!--#Include File="BlogAdminHeader.asp"-->

<%

dim TempBlogID

	TempBlogID=Request.querystring("BlogID" ) 
	
	if len(TempBlogID) < 1 then
		TempBlogID=Request.Form("BlogID" ) 
	end if
	
	Query =  "Delete * From Blog where BlogID = " &  TempBlogID & "" 

	Set DataConnection = Server.CreateObject("ADODB.Connection")

		DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(databasepath) 	& ";" 

		DataConnection.Execute(Query) 

		DataConnection.Close
		Set DataConnection = Nothing 
 

response.redirect("BlogAdminArticleDelete.asp?Message=Your Blog Article Has Been Deleted.")
%>
<!-- #include File="BlogAdminFooter.asp" -->
 </Body>
</HTML>
