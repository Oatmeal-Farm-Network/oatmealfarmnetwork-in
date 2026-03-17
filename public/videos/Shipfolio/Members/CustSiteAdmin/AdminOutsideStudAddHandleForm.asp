<!DOCTYPE HTML>

<HTML>
<HEAD>
<title>The Andresen Group Content Management System</title>
       <link rel="stylesheet" type="text/css" href="style.css">
</HEAD>
<BODY >
<!--#Include file="AdminGlobalVariables.asp"--> 
<%
ExternalStudName=Request.Form("ExternalStudName" ) 
ExternalStudBreed=Request.Form( "ExternalStudBreed" ) 
ExternalStudColor1=Request.Form("ExternalStudColor1")
ExternalStudColor2=Request.Form("ExternalStudColor2")
ExternalStudColor3=Request.Form("ExternalStudColor3")
ExternalStudColor4=Request.Form("ExternalStudColor4")
ExternalStudColor5=Request.Form("ExternalStudColor5")
ExternalStudARI=Request.Form("ExternalStudARI")
ExternalStudRegistrationType1=Request.Form("ExternalStudRegistrationType1")
ExternalStudOwner=Request.Form("ExternalStudOwner")
ExternalStudOwnerBusiness=Request.Form("ExternalStudOwnerBusiness")
ExternalStudLink=Request.Form("ExternalStudLink")

str1 = ExternalStudName
str2 = "'"
If InStr(str1,str2) > 0 Then
ExternalStudName= Replace(str1, "'", "''")
End If


str1 = ExternalStudLink
str2 = "'"
If InStr(str1,str2) > 0 Then
	ExternalStudLink= Replace(str1, "'", "''")
End If

str1 = ExternalStudARI
str2 = "'"
If InStr(str1,str2) > 0 Then
ExternalStudARI= Replace(str1, "'", "''")
End If


		Query =  "INSERT INTO ExternalStud ( ExternalStudName, ExternalStudOwnerLink, ExternalStudBreed, ExternalStudColor1, ExternalStudColor2, ExternalStudColor3, ExternalStudColor4, ExternalStudColor5, ExternalStudOwner, ExternalStudOwnerBusiness,"
if len( ExternalStudRegistrationID1) >0 then
 Query =  Query & " ExternalStudRegistrationID1, "
end if

Query =  Query & " ExternalStudRegistrationType1)" 
		Query =  Query & " Values ('" &ExternalStudName & "'," 
		Query =  Query & " '" &  ExternalStudLink & "'," 
		Query =  Query & " '" &  ExternalStudBreed & "'," 
		Query =  Query & " '" &  ExternalStudColor1 & "',"
Query =  Query & " '" &  ExternalStudColor2 & "',"
Query =  Query & " '" &  ExternalStudColor3 & "',"
Query =  Query & " '" &  ExternalStudColor4 & "',"
Query =  Query & " '" &  ExternalStudColor5 & "',"
Query =  Query & " '" & ExternalStudOwner & "',"
Query =  Query & " '" & ExternalStudOwnerBusiness & "',"
if len( ExternalStudRegistrationID1) >0 then
Query =  Query & " '" &  ExternalStudARI & "',"
end if
Query =  Query & " '" &  ExternalStudRegistrationType1 + "')"

response.write("Query=" & Query )
		Set DataConnection = Server.CreateObject("ADODB.Connection")

		DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) 	& ";" 
'response.write(Query)
		DataConnection.Execute(Query) 
		DataConnection.Close
		Set DataConnection = Nothing 

response.Redirect("AdminOutsideStud.asp")
%>
 </Body>
</HTML>
