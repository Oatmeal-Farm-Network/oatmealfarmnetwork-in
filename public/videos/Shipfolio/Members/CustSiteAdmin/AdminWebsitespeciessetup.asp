<!doctype html>
<%@ Language=VBScript %>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<HEAD>
<title>The ANDRESEN GROUP Content Management System</title>
<% Page = "Editwebsite"  %>
<link rel="stylesheet" type="text/css" href="/administration/style.css">
<!--#Include file="AdminSecurityInclude.asp"--> 
<!--#Include file="AdminGlobalVariables.asp"--> 
</HEAD>
<body >
<!--#Include file="AdminHeader.asp"-->
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth %>"><tr><td class = "roundedtop" align = "left">

<% 
Species1ID = 0
Species3ID = 0
Species4ID = 0
Species5ID = 0
Species6ID = 0
Species7ID = 0
Species8ID = 0
Species9ID = 0
Species10ID = 0
Species11ID = 0
Species12ID = 0
Species13ID = 0
Species14ID = 0

Species1ID = request.Form("Species1ID")
PreferedSpecies1ID =request.Form("PreferedSpecies1ID")
Species2ID = request.Form("Species2ID")
PreferedSpecies2ID =request.Form("PreferedSpecies2ID")
Species3ID = request.Form("Species3ID")
PreferedSpecies3ID =request.Form("PreferedSpecies3ID")
Species4ID = request.Form("Species4ID")
PreferedSpecies4ID =request.Form("PreferedSpecies4ID")
Species5ID = request.Form("Species5ID")
PreferedSpecies5ID =request.Form("PreferedSpecies5ID")
Species6ID = request.Form("Species6ID")
PreferedSpecies6ID =request.Form("PreferedSpecies6ID")
Species7ID = request.Form("Species7ID")
PreferedSpecies7ID =request.Form("PreferedSpecies7ID")
Species8ID = request.Form("Species8ID")
PreferedSpecies8ID =request.Form("PreferedSpecies8ID")
Species9ID = request.Form("Species9ID")
PreferedSpecies9ID =request.Form("PreferedSpecies9ID")
Species10ID = request.Form("Species10ID")
PreferedSpecies10ID =request.Form("PreferedSpecies10ID")
Species11ID = request.Form("Species11ID")
PreferedSpecies11ID =request.Form("PreferedSpecies11ID")
Species12ID = request.Form("Species12ID")
PreferedSpecies12ID =request.Form("PreferedSpecies12ID")
Species13ID = request.Form("Species13ID")
PreferedSpecies13ID =request.Form("PreferedSpecies13ID")
Species14ID = request.Form("Species14ID")
PreferedSpecies14ID =request.Form("PreferedSpecies14ID")
PeopleID = session("PeopleID")

if len(Species2ID) > 0 then
else
Species2ID = 0
end if

if len(Species3ID) > 0 then
else
Species3ID = 0
end if

if len(Species4ID) > 0 then
else
Species4ID = 0
end if

if len(Species5ID) > 0 then
else
Species5ID = 0
end if
if len(Species6ID) > 0 then
else
Species6ID = 0
end if

if len(Species7ID) > 0 then
else
Species7ID = 0
end if

if len(Species8ID) > 0 then
else
Species8ID = 0
end if

if len(Species9ID) > 0 then
else
Species9ID = 0
end if

if len(Species10ID) > 0 then
else
Species10ID = 0
end if
if len(Species11ID) > 0 then
else
Species11ID = 0
end if

if len(Species12ID) > 0 then
else
Species12ID = 0
end if

if len(Species13ID) > 0 then
else
Species13ID = 0
end if

if len(Species14ID) > 0 then
else
Species14ID = 0
end if

if (Species1ID =0 or Species1ID ="0") and len(Species1ID) > 0 then 
ClearSpecies1ID = True
else
ClearSpecies1ID = False
end if

if (Species2ID =0 or Species2ID ="0") and len(Species2ID) > 0 then 
ClearSpecies2ID = True
else
ClearSpecies2ID = False
end if
if (Species3ID =0 or Species3ID ="0") and len(Species3ID) > 0 then 
ClearSpecies3ID = True
else
ClearSpecies3ID = False
end if
if (Species4ID =0 or Species4ID ="0") and len(Species4ID) > 0 then 
ClearSpecies4ID = True
else
ClearSpecies4ID = False
end if
if (Species5ID =0 or Species5ID ="0") and len(Species5ID) > 0 then 
ClearSpecies5ID = True
else
ClearSpecies5ID = False
end if
if (Species6ID =0 or Species6ID ="0") and len(Species6ID) > 0 then 
ClearSpecies6ID = True
else
ClearSpecies6ID = False
end if
if (Species7ID =0 or Species7ID ="0") and len(Species7ID) > 0 then 
ClearSpecies7ID = True
else
ClearSpecies7ID = False
end if
if (Species8ID =0 or Species8ID ="0") and len(Species8ID) > 0 then 
ClearSpecies8ID = True
else
ClearSpecies8ID = False
end if
if (Species9ID =0 or Species9ID ="0") and len(Species9ID) > 0 then 
ClearSpecies9ID = True
else
ClearSpecies9ID = False
end if

if (Species10ID =0 or Species10ID ="0") and len(Species10ID) > 0 then 
ClearSpecies10ID = True
else
ClearSpecies10ID = False
end if
if (Species11ID =0 or Species11ID ="0") and len(Species11ID) > 0 then 
ClearSpecies11ID = True
else
ClearSpecies11ID = False
end if
if (Species12ID =0 or Species12ID ="0") and len(Species12ID) > 0 then 
ClearSpecies12ID = True
else
ClearSpecies12ID = False
end if
if (Species13ID =0 or Species13ID ="0") and len(Species13ID) > 0 then 
ClearSpecies13ID = True
else
ClearSpecies13ID = False
end if
if (Species14ID =0 or Species14ID ="0") and len(Species14ID) > 0 then 
ClearSpecies14ID = True
else
ClearSpecies14ID = False
end if


Dim DataConnection, cmdDC, RecordSet
Dim RecordToEdit, Updated
Set DataConnection = Server.CreateObject("ADODB.Connection")



if Species1ID > 0 then 
Query =  " UPDATE SpeciesAvailable Set SpeciesAvailableonSite = True,"

if len(Preferedspecies1ID) > 0 then
Query =  Query & " PreferedspeciesID= " & PreferedSpecies1ID & " ,"
else
Query =  Query & " PreferedspeciesID= 0 ,"
end if
Query =  Query & " SpeciesPriority = 1 "
Query =  Query & " where SpeciesID = " & Species1ID
DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 
DataConnection.Execute(Query) 
DataConnection.Close
else
'ClearSpecies1ID = True
end if 


if Species2ID> 0 then
Query =  " UPDATE SpeciesAvailable Set SpeciesAvailableonSite = True,"

if len(Preferedspecies2ID) > 0 then
Query =  Query & " PreferedspeciesID= " & PreferedSpecies2ID & " ,"
else
Query =  Query & " PreferedspeciesID= 0 ,"
end if
Query =  Query & " SpeciesPriority = 2 "
Query =  Query & " where SpeciesID = " & Species2ID
DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 
DataConnection.Execute(Query) 
DataConnection.Close
else
'ClearSpecies2ID = True
end if 

if Species3ID> 0 then
Query =  " UPDATE SpeciesAvailable Set SpeciesAvailableonSite = True,"

if len(Preferedspecies3ID) > 0 then
Query =  Query & " PreferedspeciesID= " & PreferedSpecies3ID & " ,"
else
Query =  Query & " PreferedspeciesID= 0 ,"
end if
Query =  Query & " SpeciesPriority = 3 "
Query =  Query & " where SpeciesID = " & Species3ID
DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 
DataConnection.Execute(Query) 
DataConnection.Close
else
'ClearSpecies3ID = True
end if 

if Species4ID> 0 then
Query =  " UPDATE SpeciesAvailable Set SpeciesAvailableonSite = True,"

if len(Preferedspecies4ID) > 0 then
Query =  Query & " PreferedspeciesID= " & PreferedSpecies4ID & " ,"
else
Query =  Query & " PreferedspeciesID= 0 ,"
end if
Query =  Query & " SpeciesPriority = 4 "
Query =  Query & " where SpeciesID = " & Species4ID
DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 
DataConnection.Execute(Query) 
DataConnection.Close
else
'ClearSpecies4ID = True
end if 

if Species5ID > 0 then
Query =  " UPDATE SpeciesAvailable Set SpeciesAvailableonSite = True,"

if len(Preferedspecies5ID) > 0 then
Query =  Query & " PreferedspeciesID= " & PreferedSpecies5ID & " ,"
else
Query =  Query & " PreferedspeciesID= 0 ,"
end if
Query =  Query & " SpeciesPriority = 5 "
Query =  Query & " where SpeciesID = " & Species5ID
DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 
DataConnection.Execute(Query) 
DataConnection.Close
else
'ClearSpecies5ID = True
end if 

if Species6ID> 0 then
Query =  " UPDATE SpeciesAvailable Set SpeciesAvailableonSite = True,"

if len(Preferedspecies6ID) > 0 then
Query =  Query & " PreferedspeciesID= " & PreferedSpecies6ID & " ,"
else
Query =  Query & " PreferedspeciesID= 0 ,"
end if
Query =  Query & " SpeciesPriority = 6 "
Query =  Query & " where SpeciesID = " & Species6ID
DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 
DataConnection.Execute(Query) 
DataConnection.Close
else
'ClearSpecies6ID = True
end if 

if Species7ID> 0 then
Query =  " UPDATE SpeciesAvailable Set SpeciesAvailableonSite = True,"

if len(Preferedspecies7ID) > 0 then
Query =  Query & " PreferedspeciesID= " & PreferedSpecies7ID & " ,"
else
Query =  Query & " PreferedspeciesID= 0 ,"
end if
Query =  Query & " SpeciesPriority = 7 "
Query =  Query & " where SpeciesID = " & Species7ID
DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 
DataConnection.Execute(Query) 
DataConnection.Close
else
'ClearSpecies7ID = True
end if 

if Species8ID > 0 then
Query =  " UPDATE SpeciesAvailable Set SpeciesAvailableonSite = True,"

if len(Preferedspecies8ID) > 0 then
Query =  Query & " PreferedspeciesID= " & PreferedSpecies8ID & " ,"
else
Query =  Query & " PreferedspeciesID= 0 ,"
end if
Query =  Query & " SpeciesPriority = 8 "
Query =  Query & " where SpeciesID = " & Species8ID
DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 
DataConnection.Execute(Query) 
DataConnection.Close
else
'ClearSpecies8ID = True
end if 
 
 
if Species9ID > 0 then
Query =  " UPDATE SpeciesAvailable Set SpeciesAvailableonSite = True,"

if len(Preferedspecies9ID) > 0 then
Query =  Query & " PreferedspeciesID= " & PreferedSpecies9ID & " ,"
else
Query =  Query & " PreferedspeciesID= 0 ,"
end if
Query =  Query & " SpeciesPriority = 9 "
Query =  Query & " where SpeciesID = " & Species9ID  
DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 
DataConnection.Execute(Query) 
DataConnection.Close
else
'ClearSpecies9ID = True
end if 


if Species10ID> 0 then
Query =  " UPDATE SpeciesAvailable Set SpeciesAvailableonSite = True,"

if len(Preferedspecies10ID) > 0 then
Query =  Query & " PreferedspeciesID= " & PreferedSpecies10ID & " ,"
else
Query =  Query & " PreferedspeciesID= 0 ,"
end if
Query =  Query & " SpeciesPriority = 10 "
Query =  Query & " where SpeciesID = " & Species10ID
DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 
DataConnection.Execute(Query) 
DataConnection.Close
else
'ClearSpecies10ID = True
end if 

if Species11ID> 0 then
Query =  " UPDATE SpeciesAvailable Set SpeciesAvailableonSite = True,"

if len(Preferedspecies11ID) > 0 then
Query =  Query & " PreferedspeciesID= " & PreferedSpecies11ID & " ,"
else
Query =  Query & " PreferedspeciesID= 0 ,"
end if
Query =  Query & " SpeciesPriority = 11 "
Query =  Query & " where SpeciesID = " & Species11ID
DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 
DataConnection.Execute(Query) 
DataConnection.Close
else
'ClearSpecies11ID = True
end if 

if Species12ID> 0 then
Query =  " UPDATE SpeciesAvailable Set SpeciesAvailableonSite = True,"

if len(Preferedspecies12ID) > 0 then
Query =  Query & " PreferedspeciesID= " & PreferedSpecies12ID & " ,"
else
Query =  Query & " PreferedspeciesID= 0 ,"
end if
Query =  Query & " SpeciesPriority = 12 "
Query =  Query & " where SpeciesID = " & Species12ID
DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 
DataConnection.Execute(Query) 
DataConnection.Close
else
'ClearSpecies12ID = True
end if 

if Species13ID> 0 then
Query =  " UPDATE SpeciesAvailable Set SpeciesAvailableonSite = True,"

if len(Preferedspecies13ID) > 0 then
Query =  Query & " PreferedspeciesID= " & PreferedSpecies13ID & " ,"
else
Query =  Query & " PreferedspeciesID= 0 ,"
end if
Query =  Query & " SpeciesPriority = 13 "
Query =  Query & " where SpeciesID = " & Species13ID
DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 
DataConnection.Execute(Query) 
DataConnection.Close
else
'ClearSpecies13ID = True
end if 

if Species14ID> 0 then
Query =  " UPDATE SpeciesAvailable Set SpeciesAvailableonSite = True,"

if len(Preferedspecies14ID) > 0 then
Query =  Query & " PreferedspeciesID= " & PreferedSpecies14ID & " ,"
else
Query =  Query & " PreferedspeciesID= 0 ,"
end if
Query =  Query & " SpeciesPriority = 14 "
Query =  Query & " where SpeciesID = " & Species14ID
DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 
DataConnection.Execute(Query) 
DataConnection.Close
else
'ClearSpecies14ID = True
end if 



 sql = "select * from SpeciesAvailable where SpeciesAvailableonSite = True Order by SpeciesPriority "
		
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof	 then
Species1ID = rs("SpeciesID")
if ClearSpecies1ID = True then
Query =  " UPDATE SpeciesAvailable Set SpeciesAvailableonSite = False,"
Query =  Query & " SpeciesPriority = 0 "
Query =  Query & " where SpeciesID = " & Species1ID
DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 
DataConnection.Execute(Query) 
DataConnection.Close
end if
if rs.recordcount > 1 then
rs.movenext
Species2ID = rs("SpeciesID")

if ClearSpecies2ID = True then
Query =  " UPDATE SpeciesAvailable Set SpeciesAvailableonSite = False,"
Query =  Query & " SpeciesPriority = 0 "
Query =  Query & " where SpeciesID = " & Species2ID
DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 
DataConnection.Execute(Query) 
DataConnection.Close
end if
end if

if rs.recordcount > 2 then
rs.movenext
Species3ID = rs("SpeciesID")
if ClearSpecies3ID = True then
Query =  " UPDATE SpeciesAvailable Set SpeciesAvailableonSite = False,"
Query =  Query & " SpeciesPriority = 0 "
Query =  Query & " where SpeciesID = " & Species3ID
DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 
DataConnection.Execute(Query) 
DataConnection.Close
end if
end if

if rs.recordcount > 3 then
rs.movenext
Species4ID = rs("SpeciesID")
if ClearSpecies4ID = True then
Query =  " UPDATE SpeciesAvailable Set SpeciesAvailableonSite = False,"
Query =  Query & " SpeciesPriority = 0 "
Query =  Query & " where SpeciesID = " & Species4ID
DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 
DataConnection.Execute(Query) 
DataConnection.Close
end if
end if


if rs.recordcount > 4 then
rs.movenext
Species5ID = rs("SpeciesID")
if ClearSpecies5ID = True then
Query =  " UPDATE SpeciesAvailable Set SpeciesAvailableonSite = False,"
Query =  Query & " SpeciesPriority = 0 "
Query =  Query & " where SpeciesID = " & Species5ID
DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 
DataConnection.Execute(Query) 
DataConnection.Close
end if
end if

if rs.recordcount > 5 then
rs.movenext
Species6ID = rs("SpeciesID")
if ClearSpecies6ID = True then
Query =  " UPDATE SpeciesAvailable Set SpeciesAvailableonSite = False,"
Query =  Query & " SpeciesPriority = 0 "
Query =  Query & " where SpeciesID = " & Species6ID
DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 
DataConnection.Execute(Query) 
DataConnection.Close
end if
end if


if rs.recordcount > 6 then
rs.movenext
Species7ID = rs("SpeciesID")
if ClearSpecies7ID = True then
Query =  " UPDATE SpeciesAvailable Set SpeciesAvailableonSite = False,"
Query =  Query & " SpeciesPriority = 0 "
Query =  Query & " where SpeciesID = " & Species7ID
DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 
DataConnection.Execute(Query) 
DataConnection.Close
end if
end if


if rs.recordcount > 7 then
rs.movenext
Species8ID = rs("SpeciesID")
if ClearSpecies8ID = True then
Query =  " UPDATE SpeciesAvailable Set SpeciesAvailableonSite = False,"
Query =  Query & " SpeciesPriority = 0 "
Query =  Query & " where SpeciesID = " & Species8ID
DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 
DataConnection.Execute(Query) 
DataConnection.Close
end if
end if


if rs.recordcount > 8 then
rs.movenext
Species9ID = rs("SpeciesID")
if ClearSpecies9ID = True then
Query =  " UPDATE SpeciesAvailable Set SpeciesAvailableonSite = False,"
Query =  Query & " SpeciesPriority = 0 "
Query =  Query & " where SpeciesID = " & Species9ID
DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 
DataConnection.Execute(Query) 
DataConnection.Close
end if
end if

if rs.recordcount > 9 then
rs.movenext
Species10ID = rs("SpeciesID")
if ClearSpecies10ID = True then
Query =  " UPDATE SpeciesAvailable Set SpeciesAvailableonSite = False,"
Query =  Query & " SpeciesPriority = 0 "
Query =  Query & " where SpeciesID = " & Species10ID
DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 
DataConnection.Execute(Query) 
DataConnection.Close
end if
end if


if rs.recordcount > 10 then
rs.movenext
Species11ID = rs("SpeciesID")
if ClearSpecies11ID = True then
Query =  " UPDATE SpeciesAvailable Set SpeciesAvailableonSite = False,"
Query =  Query & " SpeciesPriority = 0 "
Query =  Query & " where SpeciesID = " & Species11ID
DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 
DataConnection.Execute(Query) 
DataConnection.Close
end if
end if



if rs.recordcount > 11 then
rs.movenext
Species12ID = rs("SpeciesID")
if ClearSpecies12ID = True then
Query =  " UPDATE SpeciesAvailable Set SpeciesAvailableonSite = False,"
Query =  Query & " SpeciesPriority = 0 "
Query =  Query & " where SpeciesID = " & Species12ID
DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 
DataConnection.Execute(Query) 
DataConnection.Close
end if
end if

if rs.recordcount > 12 then
rs.movenext
Species13ID = rs("SpeciesID")
if ClearSpecies13ID = True then
Query =  " UPDATE SpeciesAvailable Set SpeciesAvailableonSite = False,"
Query =  Query & " SpeciesPriority = 0 "
Query =  Query & " where SpeciesID = " & Species13ID
DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 
DataConnection.Execute(Query) 
DataConnection.Close
end if
end if


if rs.recordcount > 13 then
rs.movenext
Species14ID = rs("SpeciesID")
if ClearSpecies14ID = True then
Query =  " UPDATE SpeciesAvailable Set SpeciesAvailableonSite = False,"
Query =  Query & " SpeciesPriority = 0 "
Query =  Query & " where SpeciesID = " & Species14ID
DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 
DataConnection.Execute(Query) 
DataConnection.Close
end if
end if
end if
rs.close


response.redirect("AdminWebsitesetup.asp")
%>

 </Body>
</HTML>
