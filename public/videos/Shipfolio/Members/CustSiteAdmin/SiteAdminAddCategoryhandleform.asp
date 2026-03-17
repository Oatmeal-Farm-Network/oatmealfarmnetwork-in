<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4+0 Transitional//EN">
<HTML>
<HEAD>
<!--#Include file="AdminGlobalVariables.asp"-->
</HEAD>
<BODY bgcolor = "white">
<% Dim TempNewCategory
Dim TempCategoryType


	TempNewCategory=Request.Form("NewCategory" ) 
	TempCategoryType=Request.Form("CategoryType" ) 

'response.write("TempCategoryType=")
'response.write(TempCategoryType)

	Set rs = Server.CreateObject("ADODB.Recordset")
'sql = "select * from SFCategories  order by Catname " 
sql = "select * from SFCategories where catName = '" & TempNewCategory & "'"
		response.write(sql)
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3 



If rs.eof  then

str1 = TempNewCategory
str2 = "'"
If InStr(str1,str2) > 0 Then
	TempNewCategory= Replace(str1, "'", "''")
End If



		Query =  "INSERT INTO SFCategories (CatName)" 
		Query =  Query & " Values ('" &  TempNewCategory & "')"
		'response.write(Query)

Conn.Execute(Query) 


	End if
	response.redirect("SiteAdminSetforsalecategories.asp")
%>

</Body>
</HTML>
