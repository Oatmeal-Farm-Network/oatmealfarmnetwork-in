<!DOCTYPE html>
<html>
<head>
<!--#Include file="AssociationGlobalVariables.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta http-equiv="Content-Language" content="en-us">
<meta name="author" content="AndresenEvents.com">
<link rel="stylesheet" type="text/css" href="/Style.css">
</head>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   >
<%
ReturnPage = Request.form("ReturnPage")
AddressID = Request.Form("AddressID")  
AssociationName = Request.Form("AssociationName")
AssociationAcronym = Request.Form("AssociationAcronym")
Associationwebsite = Request.Form("Associationwebsite")
AssociationEmailaddress = Request.Form("AssociationEmailaddress")
AssociationStreet1 = Request.Form("AssociationStreet1")
AssociationStreet2= Request.Form("AssociationStreet2")
AssociationCity = Request.Form("AssociationCity")
AssociationState = Request.Form("AssociationState")
AssociationZip = Request.Form("AssociationZip")
AssociationCountry = Request.Form("AssociationCountry")
AssociationPhone = Request.Form("AssociationPhone")
AssociationDescription= Request.Form("AssociationDescription")
AssociationPassword= Request.Form("AssociationPassword")
AssociationContactPosition= Request.Form("AssociationContactPosition")
AssociationContactEmail= Request.Form("AssociationContactEmail")
AssociationContactName= Request.Form("AssociationContactName")
AssociationShowaddress = Request.Form("AssociationShowaddress")
Registry = request.form("Registry")
FoodHub = request.form("FoodHub")
CSA = request.form("CSA") 
Livestock = request.form("Livestock")
FarmAg= request.form("FarmAg")
FarmersMarket = request.form("FarmersMarket")


str1 = AssociationAcronym
str2 = "'"
If InStr(str1,str2) > 0 Then
	AssociationAcronym= Replace(str1,  str2, "''")
End If 


str1 = AssociationContactPosition
str2 = "'"
If InStr(str1,str2) > 0 Then
	AssociationContactPosition= Replace(str1,  str2, "''")
End If 


str1 = AssociationContactPosition
str2 = "'"
If InStr(str1,str2) > 0 Then
	AssociationContactPosition= Replace(str1,  str2, "''")
End If  


str1 = Associationwebsite
str2 = "'"
If InStr(str1,str2) > 0 Then
	Associationwebsite= Replace(str1,  str2, "''")
End If  

str1 = lcase(Associationwebsite)
str2 = "http://"
If InStr(str1,str2) > 0 Then
	Associationwebsite= right(Associationwebsite, len(Associationwebsite) - 7)
End If  


str1 = AssociationEmailaddress
str2 = "'"
If InStr(str1,str2) > 0 Then
	AssociationEmailaddress= Replace(str1,  str2, "''")
End If 

str1 = AssociationPassword
str2 = "'"
If InStr(str1,str2) > 0 Then
	AssociationPassword= Replace(str1,  str2, "''")
End If 

str1 = AssociationStreet1
str2 = "'"
If InStr(str1,str2) > 0 Then
	AssociationStreet1= Replace(str1,  str2, "''")
End If 

str1 = AssociationStreet2
str2 = "'"
If InStr(str1,str2) > 0 Then
	AssociationStreet2= Replace(str1,  str2, "''")
End If 

str1 = AssociationCity
str2 = "'"
If InStr(str1,str2) > 0 Then
	AssociationCity= Replace(str1,  str2, "''")
End If

str1 = AssociationState
str2 = "'"
If InStr(str1,str2) > 0 Then
	AssociationState= Replace(str1,  str2, "''")
End If

str1 = AssociationZip
str2 = "'"
If InStr(str1,str2) > 0 Then
	AssociationZip= Replace(str1,  str2, "''")
End If

str1 = AssociationPhone
str2 = "'"
If InStr(str1,str2) > 0 Then
	AssociationPhone= Replace(str1,  str2, "''")
End If

str1 = PeopleCell
str2 = "'"
If InStr(str1,str2) > 0 Then
	PeopleCell= Replace(str1,  str2, "''")
End If

str1 = PeopleFax 
str2 = "'"
If InStr(str1,str2) > 0 Then
	PeopleFax= Replace(str1,  str2, "''")
End If

str1 = AssociationDescription 
str2 = "'"
If InStr(str1,str2) > 0 Then
	AssociationDescription= Replace(str1,  str2, "''")
End If


Query =  " UPDATE Associations Set AssociationName = '" &  AssociationName & "'," 
Query =  Query & " Registry = '" &  Registry & "'," 
Query =  Query & " AssociationAcronym = '" &  AssociationAcronym & "'," 
Query =  Query & " Associationwebsite = '" &  Associationwebsite & "'," 
Query =  Query & " AssociationEmailaddress = '" &  AssociationEmailaddress & "'," 
Query =  Query & " AssociationStreet1 = '" &  AssociationStreet1 & "',"
Query =  Query & " AssociationStreet2 = '" &  AssociationStreet2 & "',"  
Query =  Query & " AssociationCity = '" &  AssociationCity & "'," 
Query =  Query & " AssociationState = '" &  AssociationState & "'," 
Query =  Query & " AssociationZip = '" &  AssociationZip & "',"
Query =  Query & " AssociationCountry = '" &  AssociationCountry & "',"
Query =  Query & " AssociationPhone = '" &  AssociationPhone & "',"
Query =  Query & " AssociationContactPosition = '" &  AssociationContactPosition & "',"
Query =  Query & " AssociationContactEmail = '" &  AssociationContactEmail & "',"



if FarmersMarket = 1 then
Query =  Query & " FarmersMarket = 1,"
else
Query =  Query & " FarmersMarket = 0,"
end if

if FarmAg = 1 then
Query =  Query & " FarmAg = 1,"
else
Query =  Query & " FarmAg = 0,"
end if

if AssociationShowaddress = 1 then
Query =  Query & " AssociationShowaddress = 1,"
else
Query =  Query & " AssociationShowaddress = 0,"
end if

if Livestock = 1 then
Query =  Query & " Livestock = 1,"
else
Query =  Query & " Livestock = 0,"
end if

if CSA = 1 then
Query =  Query & " CSA = 1,"
else
Query =  Query & " CSA = 0,"
end if

if FoodHub = 1 then
Query =  Query & " FoodHub = 1"
else
Query =  Query & " FoodHub = 0"
end if

Query =  Query & " where AssociationID = " & session("AssociationID") & ";" 


response.write("Query="	& Query )
Conn.Execute(Query) 


Query =  "Delete From AssociationBreedTable where associationID=" & session("associationID") 
Conn.Execute(Query) 


if Huacayas = "Yes" Then
Query =  "INSERT INTO AssociationBreedTable (AssociationID, BreedID, SpeciesID)" 
Query =  Query & " Values (" &  AssociationID & " ,"
Query =  Query &   " 2 ,"
Query =  Query &   " 2 )" 

Conn.Execute(Query) 
end if

if Suris = "Yes" Then
Query =  "INSERT INTO AssociationBreedTable (AssociationID, BreedID, SpeciesID)" 
Query =  Query & " Values (" &  AssociationID & " ,"
Query =  Query &   " 2 ,"
Query =  Query &   " 1 )" 

Conn.Execute(Query) 
end if


Conn.close
Set Conn = Nothing %>
<!--#Include virtual="/includefiles/Conn.asp"-->
<%

response.write("ReturnPage=" & ReturnPage )
if len(ReturnPage) > 1 then
	response.redirect(ReturnPage)
else
	response.redirect("AssociationListingEdit.asp?AssociationID=" & AssociationID )
end if 
 %>
<br><br><br>

</Body>
</HTML>