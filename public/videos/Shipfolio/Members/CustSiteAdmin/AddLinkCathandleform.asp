<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
<HEAD>
 <title>Edit Links</title>
       <link rel="stylesheet" type="text/css" href="/administration/style.css">
</HEAD>

<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">

<!--#Include virtual="/Administration/Header.asp"--> 
<%

Dim TempNewCategory
Dim TempCategoryType


	TempNewCategory=Request.Form("NewCategory" ) 
	TempCategoryType=Request.Form("CategoryType" ) 

'response.write("TempCategoryType=")
'response.write(TempCategoryType)


conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(databasepath) & ";" & _
"User Id=;Password=;" 

sql = "select * from LinkCategories where CategoryName = '" & TempNewCategory & "'" 
			'response.write(sql)
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3 



If rs.eof  then

str1 = TempNewCategory
str2 = "'"
If InStr(str1,str2) > 0 Then
	TempNewCategory= Replace(str1, "'", "''")
End If



		Query =  "INSERT INTO LinkCategories (CategoryName)" 
		Query =  Query & " Values ('" &  TempNewCategory  & "')"
		'response.write(Query)

		Set DataConnection = Server.CreateObject("ADODB.Connection")

		DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) 	& ";" 

		DataConnection.Execute(Query) 

		DataConnection.Close
		Set DataConnection = Nothing 

	End if
%>




	<!--#Include file="LinkCategoriesInclude.asp"-->


<!--#Include file="Footer.asp"--> </Body>
</HTML>
