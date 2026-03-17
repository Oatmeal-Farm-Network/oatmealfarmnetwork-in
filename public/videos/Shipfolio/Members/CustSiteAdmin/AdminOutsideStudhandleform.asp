<!DOCTYPE HTML>

<HTML>
<HEAD>
<title>The Andresen Group Content Management System</title>
       <link rel="stylesheet" type="text/css" href="style.css">
</HEAD>

<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">

    <!--#Include file="AdminSecurityInclude.asp"--> 
    <!--#Include file="AdminGlobalVariables.asp"--> 

<%
ExternalStudID=Request.Form("ExternalStudID") 
ExternalStudName=Request.Form("ExternalStudName") 
ExternalStudColor1=Request.Form("ExternalStudColor1") 
ExternalStudColor2=Request.Form("ExternalStudColor2") 
ExternalStudColor3=Request.Form("ExternalStudColor3") 
ExternalStudColor4=Request.Form("ExternalStudColor4") 
ExternalStudColor5=Request.Form("ExternalStudColor5") 
ExternalStudOwnerLink=Request.Form("ExternalStudOwnerLink")
ExternalStudOwner=Request.Form("ExternalStudOwner")
ExternalStudOwnerBusiness=Request.Form("ExternalStudOwnerBusiness")

str1 = ExternalStudName
str2 = "'"
If InStr(str1,str2) > 0 Then
	ExternalStudName= Replace(str1, "'", "''")
End If

str1 = ExternalStudOwnerLink
str2 = "'"
If InStr(str1,str2) > 0 Then
	ExternalStudOwnerLink= Replace(str1, "'", "''")
End If

Query =  " UPDATE ExternalStud Set ExternalStudName = '" &  ExternalStudName & "', " 
Query =  Query & " ExternalStudColor1 = '"  &   ExternalStudColor1 & "'," 
Query =  Query & " ExternalStudColor2 = '"  &   ExternalStudColor2 & "'," 
Query =  Query & " ExternalStudColor3 = '"  &   ExternalStudColor3 & "'," 
Query =  Query & " ExternalStudColor4 = '"  &   ExternalStudColor4 & "'," 
Query =  Query & " ExternalStudColor5 = '"  &   ExternalStudColor5 & "'," 
Query =  Query & " ExternalStudOwner = '"  &   ExternalStudOwner & "'," 
Query =  Query & " ExternalStudOwnerBusiness = '"  &   ExternalStudOwner & "'," 
Query =  Query & " ExternalStudOwnerLink = '" &  ExternalStudOwnerLink & "' " 
Query =  Query & " where ExternalStudID = " & ExternalStudID & ";" 
response.write(Query)

Dim DataConnection, cmdDC, RecordSet
Dim RecordToEdit, Updated
Set DataConnection = Server.CreateObject("ADODB.Connection")
DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath)& ";" 
DataConnection.Execute(Query) 
DataConnection.Close
Set DataConnection = Nothing 
response.Redirect("AdminOutsideStud.asp")
%>
</Body>
</HTML>
