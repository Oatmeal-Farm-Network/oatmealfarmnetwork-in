<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4+0 Transitional//EN">
<HTML>
<HEAD>
<!--#Include file="AdminGlobalVariables.asp"-->

 <title>Add a New Category</title>
<link rel="stylesheet" type="text/css" href="style.css">
</HEAD>

<BODY bgcolor = "white">
<!--#Include file="siteadminHeader.asp"-->
<%

   Dim NewSubCategory
   Dim TempCategoryID

	NewSubCategory=Request.Form("NewSubCategory" ) 
	TempCategoryID=Request.Form("CategoryID" ) 
	TempCategoryType=Request.Form("CategoryType" ) 


sql = "select * from SFSubCategories where SubCategoryName = '" & NewSubCategory & "' and SubCatID = " & TempCategoryID
		'	response.write(sql)
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3 



If rs.eof  then
	

	str1 = NewSubCategory
	str2 = "'"
	If InStr(str1,str2) > 0 Then
		NewSubCategory= Replace(str1, "'", "''")
	End If


	Query =  "INSERT INTO SFSubCategories (SubCategoryName,  CategoryID)" 
	Query =  Query & " Values ('" &  NewSubCategory & "'," 
	Query =  Query & " '" &  tempCategoryID  & "')"

	'response.write(Query)
Conn.Execute(Query) 

	Conn.Close
	Set Connn = Nothing 

End if

	response.redirect("SiteAdminSetforsalecategories.asp")
	
%>

</Body>
</HTML>
