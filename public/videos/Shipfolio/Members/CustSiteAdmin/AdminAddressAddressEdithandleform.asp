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

<% SubscriptionLevel = Request.Form("SubscriptionLevel")
accesslevel = Request.Form("accesslevel")
PeopleFirstName = Request.Form("PeopleFirstName") 
PeopleLastName = Request.Form("PeopleLastName") 
BusinessName= Request.Form("BusinessName") 
PeoplePhone= Request.Form("PeoplePhone") 
PeopleCell= Request.Form("PeopleCell") 
PeopleFax= Request.Form("PeopleFax") 
PeopleEmail= Request.Form("PeopleEmail") 
PeoplePassword= Request.Form("PeoplePassword") 
WebsitesID= Request.Form("WebsitesID") 
AddressID= Request.Form("AddressID") 
Owners = Request.Form("Owners") 
Account = Request.Form("Account") 
AddressID = Request.Form("AddressID") 
AddressStreet = Request.Form("AddressStreet") 
AddressApt= Request.Form("AddressApt") 
AddressCity= Request.Form("AddressCity") 
AddressState= Request.Form("AddressState") 
AddressZip= Request.Form("AddressZip") 
AddressCountry= Request.Form("AddressCountry") 
Website= Request.Form("Website") 
PeopleID = Request.Form("PeopleID" ) 
BusinessID = Request.Form("BusinessID")
custAIStartService=Request.Form("custAIStartService")
custAIEndService=Request.Form("custAIEndService")
MaxAnimals = Request.Form("MaxAnimals")
maxHerdsires = Request.Form("maxHerdsires")
MaxProducts  = Request.Form("MaxProducts")
FreeMassEmailsPaidFor = Request.Form("FreeMassEmailsPaidFor")
FreeMassEmailsUsed  = Request.Form("FreeMassEmailsUsed")
HomepageadsPaidfor = Request.Form("HomepageadsPaidfor")
HomepageadsUsed  = Request.Form("HomepageadsUsed")
HeaderadsPaidfor = Request.Form("HeaderadsPaidfor")
HeaderadsUsed = Request.Form("HeaderadsUsed")
FreeAnimalEntryPaidFor  = Request.Form("FreeAnimalEntryPaidFor")
FreeAnimalEntryUsed  = Request.Form("FreeAnimalEntryUsed")
custFooterEndDate= Request.Form("custFooterEndDate")
custFooterStartDate= Request.Form("custFooterStartDate")
ReceiveStatusEmails= Request.Form("ReceiveStatusEmails")
if len(HeaderadsPaidfor) > 0 then
else
HeaderadsPaidfor=0
end if

if len(FreeAnimalEntryPaidFor) > 0 then
else
FreeAnimalEntryPaidFor=0
end if



str1 = Businessname
str2 = "'"
If InStr(str1,str2) > 0 Then
	Businessname= Replace(str1, "'", "''")
End If

str1 = PeopleFirstName 
str2 = "'"
If InStr(str1,str2) > 0 Then
	PeopleFirstName = Replace(str1, "'", "''")
End If

str1 = PeopleLastName 
str2 = "'"
If InStr(str1,str2) > 0 Then
	PeopleLastName = Replace(str1, "'", "''")
End If


str1 = Owners  
str2 = "'"
If InStr(str1,str2) > 0 Then
	Owners  = Replace(str1, "'", "''")
End If

str1 = AddressStreet 
str2 = "'"
If InStr(str1,str2) > 0 Then
	AddressStreet = Replace(str1, "'", "''")
End If

str1 = AddressApt 
str2 = "'"
If InStr(str1,str2) > 0 Then
	AddressApt = Replace(str1, "'", "''")
End If

str1 = AddressCity 
str2 = "'"
If InStr(str1,str2) > 0 Then
	Addresscity = Replace(str1, "'", "''")
End If


Query =  " UPDATE Business Set BusinessName = '" & BusinessName & "'" 
Query =  Query & " where BusinessID = " & BusinessID & ";" 

Dim DataConnection, cmdDC, RecordSet
Dim RecordToEdit, Updated
Set DataConnection = Server.CreateObject("ADODB.Connection")

DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 
DataConnection.Execute(Query) 
DataConnection.close
set DataConnection = Nothing

Query =  " UPDATE People Set PeopleFirstName = '" & PeopleFirstName & "'," 
Query =  Query & " PeopleLastName = '" &  PeopleLastName & "'," 
Query =  Query & " accesslevel = " &  accesslevel & "," 
Query =  Query & " PeoplePhone = '" &  PeoplePhone & "'," 
Query =  Query & " PeopleCell = '" &  PeopleCell & "'," 
Query =  Query & " PeopleFax = '" &  PeopleFax & "'," 
Query =  Query & " PeopleEmail = '" &  PeopleEmail & "'," 
Query =  Query & " PeoplePassword = '" &  PeoplePassword & "'," 
Query =  Query & " WebsitesID = " &  WebsitesID & "," 
Query =  Query & " AddressID = " &  AddressID & "," 
Query =  Query & " BusinessID = " &  BusinessID & ", " 
Query =  Query & " Owners = '" &  Owners & "' " 
Query =  Query & " where PeopleID = " & PeopleID & ";" 
response.Write("Query=" & Query )
Set DataConnection = Server.CreateObject("ADODB.Connection")

DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 
DataConnection.Execute(Query) 
DataConnection.close
set DataConnection = Nothing

Query =  " UPDATE Address Set AddressStreet = '" & AddressStreet & "'," 
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


Query =  " UPDATE Websites Set Website = '" & Website & "'" 
Query =  Query & " where WebsitesID = " & WebsitesID & ";" 
Set DataConnection = Server.CreateObject("ADODB.Connection")

DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 
DataConnection.Execute(Query) 
DataConnection.close
set DataConnection = Nothing
response.Redirect("SiteAdmineditUser.asp?UserID=" & PeopleID)
 %>
 </Body>
</HTML>
