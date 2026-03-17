<!DOCTYPE HTML>
<HTML>
<HEAD>
<Link rel="stylesheet" type="text/css" href="style.css">
<!--#Include virtual="/administration/BlogAdmin/BlogAdminGlobalVariables.asp"--> 
<%
dim TempCategoryID
TempCategoryID=Request.Form("BlogCatID" ) 
TempCategoryType=Request.Form("CategoryType" ) 
DeleteCategoryType=Request.Form("DeleteCategoryType" ) 

If DeleteCategoryType = "Category" then
Query =  "Delete * From BlogCategories where BlogCatID = " & TempCategoryID 
Conn.Execute(Query) 

Query =  " UPDATE Blog Set BlogCatID = 2 where BlogcatID = " & TempCategoryID  & ";" 
Conn.Execute(Query) 

End If 	

If DeleteCategoryType = "SubCategory" then
Query =  "Delete * From SubCategories where SubCategoryID = " & TempCategoryID 
	'response.write(Query)
Conn.Execute(Query) 
End If 	

Conn.Close
Set Conn= Nothing 
response.Redirect("BlogAdminCategories.asp")
%>
</Body>
</HTML>