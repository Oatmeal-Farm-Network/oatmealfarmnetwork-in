<!DOCTYPE HTML>
<HTML>
<HEAD>

<title>The Andresen Group Content Management System</title>
                          <link rel="stylesheet" type="text/css" href="style.css">
</HEAD>

<BODY bgcolor = "white">
    <!--#Include file="AdminSecurityInclude.asp"--> 
    <!--#Include file="AdminGlobalVariables.asp"--> 
    <!--#Include file="AdminHeader.asp"--> 
<%

   Dim NewSubCategory
   Dim TempCategoryID

	NewSubCategory=Request.Form("NewSubCategory" ) 
	TempCategoryID=Request.Form("CategoryID" ) 
	TempCategoryType=Request.Form("CategoryType" ) 

'response.write(databasepath)
conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(databasepath) & ";" & _
"User Id=;Password=;" 

sql = "select * from SFSubCategories where SubCategoryName = """ & NewSubCategory & """ and SubCatID = " & TempCategoryID
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

	Set DataConnection = Server.CreateObject("ADODB.Connection")

	DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) 	& ";" 

	DataConnection.Execute(Query) 

	DataConnection.Close
	Set DataConnection = Nothing 

End if
	
%>

<!--#Include file="AdminCategoriesForSaleInclude.asp"-->
<!--#Include file="AdminFooter.asp"--> </Body>
</HTML>
