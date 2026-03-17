<!DOCTYPE HTML>
<HTML>
<HEAD>
<!--#Include file="AdminGlobalVariables.asp"--> 
<link rel="stylesheet" type="text/css" href="style.css">
</HEAD>
<BODY bgcolor = "white">
<!--#Include file="AdminHeader.asp"--> 
<%
Dim TempNewCategory
Dim TempCategoryType

TempNewCategory=Request.Form("NewCategory" ) 
TempCategoryType=Request.Form("CategoryType" ) 
response.write("TempCategoryType=")
response.write(TempCategoryType)


conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(databasepath) & ";" & _
"User Id=;Password=;" 

sql = "select * from SFCategories where CatName = """ & TempNewCategory & """"
			'response.write(sql)
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3 



If rs.eof  then

str1 = TempNewCategory
str2 = "'"
If InStr(str1,str2) > 0 Then
	TempNewCategory= Replace(str1, "'", "''")
End If



		Query =  "INSERT INTO ServicesCategories (ServicesCategoryName)" 
		Query =  Query & " Values ('" &  TempNewCategory & "')"
		response.write(Query)

		Set DataConnection = Server.CreateObject("ADODB.Connection")

		DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) 	& ";" 

		Conn.Execute(Query) 

		Conn.Close
		Set Conn = Nothing 

	End if
response.redirect("AdminServicesCategories.asp")
%>



</Body>
</HTML>
