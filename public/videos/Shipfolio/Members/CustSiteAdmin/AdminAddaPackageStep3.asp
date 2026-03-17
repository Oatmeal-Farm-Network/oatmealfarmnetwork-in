<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<title>The Andresen Group Content Management System</title>
<meta name="Title" content="Alpaca Infinity Administration"/>
<meta name="robots" content="nofollow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="revisit-after" content="1"/>
<meta name="Googlebot" content="nofollow"/>
<meta name="author" content="The Andresen Group"/>
 <link rel="stylesheet" type="text/css" href="/administration/style.css">
<!--#Include file="AdminGlobalVariables.asp"-->
</HEAD>
<body >

<!--#Include file="AdminHeader.asp"--> 
<!--#Include file="AdminSecurityInclude.asp"-->

<%

    Set DataConnection = Server.CreateObject("ADODB.Connection")
    DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 

Dim TotalCount
dim	rowcount
dim	ID(40000) 
Dim Checkbox(40000)
Dim StudCheckbox(40000)
Dim StudID(40000)
Dim QTYBreedings(40000)

PackageName = Request.Form("PackageName")
PackagePrice = Request.Form("Price")
PackageValue = Request.Form("Value")
Description = Request.Form("Description")
BreedType = Request.Form("BreedType")
PackageOBO = Request.Form("PackageOBO")

Dim str1
Dim str2
str1 = PackageName
str2 = "'"
If InStr(str1,str2) > 0 Then
	PackageName= Replace(str1,  str2, "''")
End If  

str1 = Description
str2 = "'"
If InStr(str1,str2) > 0 Then
	Description= Replace(str1,  str2, "''")
End If  

BreedType= Request.Form("BreedType")
PackageID= Request.Form("PackageID")
StudTotalCount= Request.Form("StudTotalCount")
TotalCount= Request.Form("TotalCount")
if len(TotalCount) > 0 then
TotalCount = CInt(TotalCount)
else
TotalCount = 0
end if
'rowcount = CInt(rowcount)
rowcount = 1

while (rowcount < TotalCount)
    IDcount = "ID(" & rowcount & ")"
	Checkboxcount = "Checkbox(" & rowcount & ")"

	ID(rowcount)=Request.Form(IDcount) 
    Checkbox(rowcount)=Request.Form(Checkboxcount) 

	rowcount = rowcount +1
response.write("StudCheckbox(rowcount)=" & StudCheckbox(rowcount) )
Wend


response.write("StudTotalCount=" & StudTotalCount )
Studrowcount =1
if len(StudTotalCount) > 0 then
while Studrowcount < CInt(StudTotalCount)
response.write("Studrowcount=" & Studrowcount )
   
	StudIDcount = "StudID(" & Studrowcount & ")"
	StudCheckboxcount = "StudCheckbox(" & Studrowcount & ")"
	QTYBreedingscount= "QTYBreedings(" & Studrowcount & ")"

	StudID(Studrowcount)=Request.Form(StudIDcount) 
    StudCheckbox(Studrowcount)=Request.Form(StudCheckboxcount) 
	QTYBreedings(Studrowcount)=Request.Form(QTYBreedingscount) 
	 Studrowcount = Studrowcount +1
response.write("StudCheckbox(Studrowcount)=" & StudCheckbox(Studrowcount) )
Wend
end if
 Studrowcount =1
 rowcount =1

while (rowcount < TotalCount)
	'Response.write("Id=" & ID(rowcount) )
	'Response.write("Checkbox=" & Checkbox(rowcount) )
If Checkbox(rowcount)  = "on" then 

 sql = "select * from Packageanimals where AnimalID = " & ID(rowcount)  & " and PackageID = " & PackageID & " and PackageType = 'ForSale' "

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	If  rs.eof then
		rs.close
		'conn.Close
		Query =  "INSERT INTO PackageAnimals (PackageID, AnimalID, PackageType)" 
		Query =  Query & " Values ('" &  PackageID & "' ,"
		Query =  Query &   " '" & ID(rowcount) & "',"
		Query =  Query &   " 'ForSale' )" 

response.write(Query)

    DataConnection.Execute(Query) 
Else
rs.close
 %>

<%
End If 
Else

	 sql = "select * from Packageanimals where AnimalID = " & ID(rowcount)  & " and PackageID = " & PackageID & " and PackageType = 'ForSale'"

response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	If not rs.eof then
		rs.close

Query =  "Delete * From PackageAnimals where AnimalID = " &  ID(rowcount) & " and PackageType = 'ForSale'" 
DataConnection.Execute(Query) 


  
Else
rs.close

End If 
End if

rowcount = rowcount + 1
wend
	
	Studrowcount = 1
	if len(StudTotalCount) > 0 Then
while Studrowcount < CInt(StudTotalCount)

	Response.write("QTYBreedings(Studrowcount) =" & QTYBreedings(Studrowcount) & "<br>" )
	'Response.write("Studrowcount =" & Studrowcount  )
	If Len(QTYBreedings(Studrowcount)) > 0 then 
if QTYBreedings(Studrowcount) = 0 then
  QTYBreedings(Studrowcount) = ""
end if
end if
If Len(QTYBreedings(Studrowcount)) > 0 then 

 sql = "select * from Packageanimals where AnimalID = " & StudID(Studrowcount)  & " and PackageID = " & PackageID & " and PackageType = 'Stud'"

response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	If  rs.eof then
		rs.close
	'	conn.Close
	
		Query =  "INSERT INTO PackageAnimals (PackageID, QTYBreedings, AnimalID, PackageType)" 
		Query =  Query & " Values ('" &  PackageID & "' ,"
		Query =  Query &   " '" & QTYBreedings(Studrowcount) & "',"
		Query =  Query &   " '" & StudID(Studrowcount) & "',"
		Query =  Query &   " 'Stud' )" 

	DataConnection.Execute(Query) 
response.write(Query)

Else
rs.close
	Query =  " UPDATE PackageAnimals Set PackageID = '" &  PackageID & "', " 
    Query =  Query & " QTYBreedings = " &  QTYBreedings(Studrowcount) & "," 
    Query =  Query & "  AnimalID = '" & StudID(Studrowcount) & "'" 
	Query =  Query & " where PackageType = 'Stud' ;" 

    'DataConnection.Execute(Query) 
    response.write(Query)

End If 
Else

	 sql = "select * from Packageanimals where AnimalID = " & StudID(Studrowcount)  & " and PackageID = " & PackageID & " and PackageType = 'Stud'"

response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	If not rs.eof then
		rs.close
	'	conn.Close

    Query =  "Delete * From PackageAnimals where AnimalID = " &  StudID(Studrowcount) & " and PackageType = 'Stud'" 
	DataConnection.Execute(Query) 

Else
rs.close

End If 
End if

Studrowcount = Studrowcount + 1
Wend
end if

If Len(PackageName) > 0 then

    Query =  " UPDATE Package Set PackageName = '" &  PackageName & "', " 
    if isNumeric(PackagePrice) = True then
	    Query =  Query & " PackagePrice = " &  PackagePrice & "," 
    end if
    if isNumeric(PackageValue) = True then
        Query =  Query & " PackageValue = " &  PackageValue & ","
    end if 
    Query =  Query & " BreedType = '" &  BreedType & "'," 
    Query =  Query & " PackageOBO = " & PackageOBO & "," 
    Query =  Query & "  Description = '" & Description & "'" 
	Query =  Query & " where PackageID = " & PackageID & ";" 


    response.write(query)
	DataConnection.Execute(Query) 

 End If

    DataConnection.Close
    Set DataConnection = Nothing 
response.redirect("AdminaddaPackageStep4.asp?PackageID="& PackageID)
 %>

 </Body>
</HTML>
