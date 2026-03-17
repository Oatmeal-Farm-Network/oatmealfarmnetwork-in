<!doctype html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<HEAD>
<title>The ANDRESEN GROUP Content Management System (AGCMS)</title>
<link rel="stylesheet" type="text/css" href="/style.css">
<!--#Include file="AdminGlobalVariables.asp"-->
</HEAD>
<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
<%
dim RegistrationType(100) 
dim RegNumber(100)
dim AnimalRegistrationID(100)
ID=Request.Form("ID" ) 
Name=Request.Form("Name" ) 
ARI=Request.Form("ARI" ) 
DOBMonth=Request.Form( "DOBMonth" ) 
DOBDay=Request.Form( "DOBDay" ) 
DOBYear=Request.Form( "DOBYear" ) 
Category=Request.Form("Category")
Breed=Request.Form("Breed")
Color1=Request.Form("Color1") 
Color2=Request.Form("Color2") 
Color3=Request.Form("Color3") 
Color4=Request.Form("Color4") 
Color5=Request.Form("Color5") 
PercentPeruvian=Request.Form("PercentPeruvian") 
PercentChilean=Request.Form("PercentChilean") 
PercentBolivian=Request.Form("PercentBolivian") 
PercentUnknownOther=Request.Form("PercentUnknownOther") 
PercentAccoyo=Request.Form("PercentAccoyo") 
PercentUSA=Request.Form("PercentUSA") 
PercentCanadian=Request.Form("PercentCanadian") 
sql2 = "select * from SpeciesBreedLookupTable where Breed='" & Breed & "'"
response.Write("sql2=" & sql2)
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3
if not rs2.eof then
BreedLookupID = rs2("BreedLookupID")
SpeciesID = rs2("SpeciesID")
end if
rs2.close
str1 = Name
str2 = "'"
If InStr(str1,str2) > 0 Then
Name= Replace(str1, "'", "''")
End If
If len(color1) = 0 then
color1 = " "
End If
If len(color2) = 0 then
color2 = " "
End If
If len(color3) = 0 then
color3 = " "
End If
If len(color4) = 0 then
color4 = " "
End If
If len(color5) = 0 then
color5 = " "
End If
If len(PercentPeruvian) = 0 then
PercentPeruvian = " "
End If
If len(Percentbolivian) = 0 then
Percentbolivian = " "
End If
If len(Percentbolivian) = 0 then
Percentbolivian = " "
End If
If len(PercentUnknownOther) = 0 then
PercentUnknownOther = " "
End If
If len(PercentAccoyo) = 0 then
PercentAccoyo = " "
End If
If len(DOBMonth) = 0 then
DOBMonth = "0"
End If
If len(DOBDay) = 0 then
DOBDay = "0"
End If
If len(DOBYear) = 0 then
DOBYear = "0"
End If
sql2 = "select Animals.ID from Animals where id = " & id & "" 
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3   
Query =  " UPDATE Animals  Set FullName = '" &  Name & "', "

if category = "Inexperienced Female" or  category = "Experienced Female" or  category = "Non-Breeder"  then
Query =  Query & " PublishStud= False, "
end if
Query =  Query & " DOBMonth = " &  DOBMonth & ", " 
Query =  Query & " DOBDay = " &  DOBDay & ", " 
Query =  Query & " DOBYear = " &  DOBYear & ", " 
Query =  Query & " Category = '" &  Category & "', " 
Query =  Query & " BreedLookupID = '" &  BreedLookupID & "' " 
Query =  Query & " where ID = " & ID & ";" 

Conn.Execute(Query) 

sql2 = "select Animals.ID from Animals where Animals.FullName = '" & Name & "'" 
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3   
AlpacasID = rs2("ID")
ID = rs2("ID")
rs2.close
set rs2=nothing
Query =  " UPDATE AncestryPercents Set PercentPeruvian = '" &  PercentPeruvian & "', "
Query =  Query & " PercentUSA = '" &  PercentUSA & "', " 
Query =  Query & " PercentCanadian = '" &  PercentCanadian & "', " 
Query =  Query & " PercentBolivian = '" &  PercentBolivian & "', " 
Query =  Query & " PercentChilean = '" &  PercentChilean & "', " 
Query =  Query & " PercentUnknownOther = '" &  PercentUnknownOther & "', " 
Query =  Query & " PercentAccoyo = '" &  PercentAccoyo & "' " 
Query =  Query & " where ID = " & AlpacasID & ";" 
Conn.Execute(Query) 
totalregistrations = Request.Form("totalregistrations")
regcount = 0
For regcount = 1 To totalregistrations 
RegNumbercount = "RegNumber(" & regcount & ")"
RegNumber(regcount)=Request.Form(RegNumbercount) 
AnimalRegistrationIDcount = "AnimalRegistrationID(" & regcount & ")"
AnimalRegistrationID(regcount)=Request.Form(AnimalRegistrationIDcount) 
RegistrationTypecount = "RegistrationType(" & regcount & ")"
RegistrationType(regcount)=Request.Form(RegistrationTypecount) 
Next
For rowcount = 1 To  totalregistrations
Query =  "Update AnimalRegistration Set  RegNumber = '" & RegNumber(rowcount) & "' " 
Query =  Query & " where AnimalRegistrationID = " & AnimalRegistrationID(rowcount)  & ";" 
response.Write("Query=" & Query )
Set DataConnection = Server.CreateObject("ADODB.Connection")

Conn.Execute(Query) 
next
Query =  " UPDATE Colors Set Color1 = '" &  Color1 & "', "
Query =  Query & " Color2 = '" &  Color2 & "', " 
Query =  Query & " Color3 = '" &  Color3 & "', " 
Query =  Query & " Color4 = '" &  Color4 & "', " 
Query =  Query & " Color5 = '" &  Color5 & "' " 
Query =  Query & " where ID = " & AlpacasID & ";" 
Set DataConnection = Server.CreateObject("ADODB.Connection")
Conn.Execute(Query) 
Query =  " UPDATE Animals Set DOBMonth = " &  DOBMonth & ", " 
Query =  Query & " DOBDay = " &  DOBDay & ", " 
Query =  Query & " DOBYear = " &  DOBYear & ", " 
Query =  Query & " Category = '" &  Category & "', " 
Query =  Query & " BreedLookupID = " &   BreedLookupID & ", " 
Query =  Query & " SpeciesID = " &   SpeciesID & " " 
Query =  Query & " where ID = " & ID & ";" 
Set DataConnection = Server.CreateObject("ADODB.Connection")

Conn.Execute(Query) 
Conn.Close
Set Conn = Nothing  
response.redirect("AdminAnimalEdit.asp?ID=" & AlpacasID & "#BasicFacts")
 %>
</body>
</html>