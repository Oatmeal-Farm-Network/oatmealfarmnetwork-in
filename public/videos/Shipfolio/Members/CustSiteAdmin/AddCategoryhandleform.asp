<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4+0 Transitional//EN">
<HTML>
<HEAD>

 <title>Add a New Category</title>
                          <link rel="stylesheet" type="text/css" href="style.css">
</HEAD>

<BODY bgcolor = "white">
<!--#Include virtual="/administration/Header.asp"--> 
<%

Dim TempNewCategory
Dim TempCategoryType


	TempNewCategory=Request.Form("NewCategory" ) 
	TempCategoryType=Request.Form("CategoryType" ) 


'response.write(TempNewCategory)
conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(databasepath) & ";" & _
"User Id=;Password=;" 

sql = "select * from ProductCategories where CategoryName = '" & TempNewCategory & "';"

			'response.write(sql)
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3 



If rs.eof  then

str1 = NewCategory
str2 = "'"
If InStr(str1,str2) > 0 Then
	NewCategory= Replace(str1, "'", "''")
End If



		Query =  "INSERT INTO ProductCategories (CategoryName)" 
		Query =  Query & " Values ('" &  TempNewCategory & "')"
		

		Set DataConnection = Server.CreateObject("ADODB.Connection")

		DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) 	& ";" 

		DataConnection.Execute(Query) 

		DataConnection.Close
		Set DataConnection = Nothing 

	End if
%>


<!--#Include virtual="/Administration/ForSaleCategoriesInclude.asp"-->
<!--#Include virtual="/Administration/Footer.asp"--> </Body>
</HTML>
