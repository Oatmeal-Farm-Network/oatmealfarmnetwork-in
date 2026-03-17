<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<title><%=Sitenamelong %> Administration</title>
<meta name="Title" content="<%=Sitenamelong %> Administration"/>
<meta name="robots" content="nofollow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="revisit-after" content="1"/>
<meta name="Googlebot" content="nofollow"/>
<meta name="author" content="The Andresen Group"/>
<link rel="stylesheet" type="text/css" href="/style.css" />
<!--#Include file="AdminGlobalVariables.asp"-->
<% Current2 = "SiteAdmin" 
Current3 = "AddUsers" %> 
<% If not rs.State = adStateClosed Then
rs.close
End If   	

ExistingSite = False
Update = "False"

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

Query =  "INSERT INTO Address (AddressStreet, AddressTitle, AddressWebsite, AddressComments, AddressPhone, AddressApt, AddressCity, AddressState, AddressZip)" 
Query = Query + " Values ('" & AddressStreet  & "'," 
Query = Query & " '" &  AddressTitle & "', " 
Query = Query & " '" &  AddressWebsite & "', " 
Query = Query & " '" &  AddressComments & "', " 
Query = Query & " '" &  AddressPhone & "', " 
Query = Query & " '" &  AddressApt & "', " 
Query = Query & " '" &  AddressCity & "', " 
Query = Query & " '" &  AddressState & "', " 
Query = Query & " '" &  AddressZip & "')" 
Conn.Execute(Query) 

sql = "select AddressID from Address Order by AddressID Desc"
rs.Open sql, conn, 3, 3   
If Not rs.eof Then
AddressID  =rs("AddressID") 
End If 
rs.close

Conn.close
set Conn = Nothing

response.redirect("AdminClassesAddressEdit.asp?AddressID=" & AddressID )
%>
</Body>
</HTML>
