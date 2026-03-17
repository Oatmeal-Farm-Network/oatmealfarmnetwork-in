<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html >
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="/administration/style.css">
<!--#Include file="AdminGlobalVariables.asp"-->

<% 
addressID =Request.Form("addressID") 
AddressTitle  =Request.Form("AddressTitle") 
AddressWebsite  =Request.Form("AddressWebsite") 
AddressComments =Request.Form("AddressComments") 
AddressStreet = Request.Form("AddressStreet") 
AddressApt = Request.Form("AddressApt") 
AddressCity  = Request.Form("AddressCity")
AddressState  = Request.Form("AddressState")
AddressZip  = Request.Form("AddressZip")
AddressPhone  = Request.Form("AddressPhone")

str1 = AddressTitle 
str2 = "'"
If InStr(str1,str2) > 0 Then
	AddressTitle = Replace(str1,  str2, "''")
End If 

str1 = AddressComments
str2 = "'"
If InStr(str1,str2) > 0 Then
	AddressComments= Replace(str1,  str2, "''")
End If  


str1 = AddressWebsite
str2 = "'"
If InStr(str1,str2) > 0 Then
AddressWebsite= Replace(str1,  str2, "''")
End If  

str1 = lcase(AddressWebsite)
str2 = "http://"
If InStr(str1,str2) > 0 Then
AddressWebsite= right(AddressWebsite, len(AddressWebsite) - 7)
End If  


str1 = AddressStreet
str2 = "'"
If InStr(str1,str2) > 0 Then
	AddressStreet= Replace(str1,  str2, "''")
End If 

str1 = StreetApt
str2 = "'"
If InStr(str1,str2) > 0 Then
	StreetApt= Replace(str1,  str2, "''")
End If 

str1 = AddressApt 
str2 = "'"
If InStr(str1,str2) > 0 Then
	AddressApt= Replace(str1,  str2, "''")
End If

str1 = AddressCity
str2 = "'"
If InStr(str1,str2) > 0 Then
	AddressCity= Replace(str1,  str2, "''")
End If

str1 = AddressZip
str2 = "'"
If InStr(str1,str2) > 0 Then
	AddressZip= Replace(str1,  str2, "''")
End If

str1 = AddressPhone
str2 = "'"
If InStr(str1,str2) > 0 Then
AddressPhone= Replace(str1,  str2, "''")
End If


Query =  " UPDATE Address Set AddressStreet = '" & AddressStreet & "'," 
Query =  Query & " AddressTitle = '" &  AddressTitle & "'," 
Query =  Query & " AddressComments = '" &  AddressComments & "'," 
Query =  Query & " AddressPhone = '" &  AddressPhone & "'," 
Query =  Query & " AddressApt = '" &  AddressApt & "'," 
Query =  Query & " AddressCity = '" &  AddressCity & "'," 
Query =  Query & " AddressState = '" &  AddressState & "'," 
Query =  Query & " AddressZip = '" &  AddressZip & "'," 
Query =  Query & " AddressCountry = '" &  AddressCountry & "'" 
Query =  Query & " where AddressID = " & AddressID & ";" 
Set DataConnection = Server.CreateObject("ADODB.Connection")
DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 
DataConnection.Execute(Query) 
DataConnection.close
set DataConnection = Nothing


response.Redirect("AdminClassesAddressEdit.asp?AddressID=" & AddressID)
 %>
 </Body>
</HTML>
