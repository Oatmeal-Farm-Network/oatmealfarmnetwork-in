<!DOCTYPE HTML >
<HTML>
<HEAD>
       <link rel="stylesheet" type="text/css" href="/Memmbers/Membersstyle.css">
</HEAD>
<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
<br /> 
<!--#Include file="MembersGlobalvariables.asp"--> 
<%
dim SpeciesRegistrationType(100)
dim RegistrationNumber(1000)

speciesID=Request.Form("speciesID")
totalregistrations = Request.form("totalregistrations")

BusinessID=Request.querystring("BusinessID") 

Name=Request.Form("Name") 
if len(Name) < 1 then
Name=Request.querystring("Name") 
end if
if len(Name) < 1 then
NameMissing="True" 
else
NameMissing="False" 
end if


Category=Request.Form("Category")
if len(Category) < 1 then
Category=Request.querystring("Category") 
end if
if len(Category) < 1 then
CategoryMissing="True"
else
CategoryMissing="False"  
end if

BusinessID=Request.querystring("BusinessID") 

NumberofAnimals=Request.Form("NumberofAnimals") 
if len(NumberofAnimals) < 1 then
NumberofAnimals=Request.querystring("NumberofAnimals") 
end if

DOB=Request.Form("DOB") 
    response.write "DOB=" & DOB  & "<br>"
dob_parts = Split(dob, "-")
if len(DOB) > 4 then
DOBYear = dob_parts(0)
DOBMonth = dob_parts(1)
DOBDay = dob_parts(2)
end if


BreedID=Request.Form("BreedID")
BreedID2=Request.Form("BreedID2")
BreedID3=Request.Form("BreedID3")
BreedID4=Request.Form("BreedID4")
Response.Write "BreedID: " & BreedID  & "<br>"
Response.Write "BreedID: " & BreedID2 & "<br>"
Response.Write "BreedID: " & BreedID3  & "<br>"
Response.Write "BreedID: " & BreedID4  & "<br>"


Color1=Request.Form("Color1") 
Color2=Request.Form("Color2") 
Color3=Request.Form("Color3") 
Color4=Request.Form("Color4") 
Height=Request.Form("Height") 
Weight=Request.Form("Weight") 
Gaited=Request.Form("Gaited") 
Warmblood=Request.Form("Warmblood") 
PercentPeruvian=Request.Form("PercentPeruvian") 
PercentChilean=Request.Form("PercentChilean") 
PercentBolivian=Request.Form("PercentBolivian") 
PercentUnknownOther=Request.Form("PercentUnknownOther") 
PercentAccoyo=Request.Form("PercentAccoyo") 
PercentUSA=Request.Form("PercentUSA") 
PercentCanadian=Request.Form("PercentCanadian") 


'If len(Name) < 1 then
 '   response.Redirect("MembersAnimalAdd1B.asp?Duplicate=False&NameMissing=True&CategoryMissing=" & CategoryMissing & "&speciesID=" & speciesID & "&Name=" & Name & "&ARI=" & ARI & "&CLAA=" & CLAA & "&DOB=" & DOB & "&Category=" & Category & "&BreedID=" & BreedID & "&BreedID2=" & BreedID2  & "&BreedID3=" & BreedID3  & "&BreedID4=" & BreedID4 & "&Color1=" & Color1 & "&Color2=" & Color2 & "&Color3=" & Color3 & "&Color4=" & Color4 & "&Color5=" & Color5  & "&PercentUSA=" & PercentUSA &  "&PercentCanadian=" & PercentCanadian & "&PercentPeruvian=" & PercentPeruvian & "&PercentChilean=" & PercentChilean & "&PercentBolivian=" & PercentBolivian & "&PercentUnknownOther=" & PercentUnknownOther & "&PercentAccoyo=" & PercentAccoyo & "&Height=" & Height & "&Weight=" & Weight & "&Gaited=" & Gaited & "&Warmblooded=" & Warmblooded & "&NumberofAnimals=" & NumberofAnimals )
'end if

If speciesID = 23 or speciesID = 9 or speciesID = 25 then
else
If len(BreedID) < 1 then
  '  response.Redirect("MembersAnimalAdd1B.asp?Duplicate=False&CategoryMissing=" & CategoryMissing & "&speciesID=" & speciesID & "&Name=" & Name & "&ARI=" & ARI & "&CLAA=" & CLAA & "&DOB=" & DOB & "&Category=" & Category & "&BreedID=" & BreedID & "&BreedID2=" & BreedID2  & "&BreedID3=" & BreedID3  & "&BreedID4=" & BreedID4 & "&Color1=" & Color1 & "&Color2=" & Color2 & "&Color3=" & Color3 & "&Color4=" & Color4 & "&Color5=" & Color5  & "&PercentUSA=" & PercentUSA &  "&PercentCanadian=" & PercentCanadian & "&PercentPeruvian=" & PercentPeruvian & "&PercentChilean=" & PercentChilean & "&PercentBolivian=" & PercentBolivian & "&PercentUnknownOther=" & PercentUnknownOther & "&PercentAccoyo=" & PercentAccoyo & "&Height=" & Height & "&Weight=" & Weight & "&Gaited=" & Gaited & "&Warmblooded=" & Warmblooded & "&NumberofAnimals=" & NumberofAnimals )
end if
end if

str1 = Name
str2 = "'"
If InStr(str1,str2) > 0 Then
Name= Replace(str1, "'", "''")
End If


sql2 = "select Animals.AnimalID from Animals where PeopleID = " & session("PeopleID") & " and FullName = '" & Name & "' and speciesID = " & speciesID 
response.Write("sql2=" & sql2)
Set rs2 = Server.CreateObject("ADODB.Recordset")
    rs2.Open sql2, conn, 3, 3   

   If not rs2.eof Then
'response.Redirect("MembersAnimalAdd1B.asp?Duplicate=True&speciesID=" & speciesID & "&Name=" & Name & "&ARI=" & ARI & "&CLAA=" & CLAA & "&DOBMonth=" & DOBMonth & "&DOBDay=" & DOBDay & "&DOBYear=" & DOBYear & "&Category=" & Category & "&BreedID=" & BreedID & "&BreedID2=" & BreedID2  & "&BreedID3=" & BreedID3  & "&BreedID4=" & BreedID4 & "&Color1=" & Color1 & "&Color2=" & Color2 & "&Color3=" & Color3 & "&Color4=" & Color4 & "&Color5=" & Color5 & "&PercentPeruvian=" & PercentPeruvian & "&PercentChilean=" & PercentChilean & "&PercentBolivian=" & PercentBolivian & "&PercentUnknownOther=" & PercentUnknownOther & "&PercentAccoyo=" & PercentAccoyo & "&Height=" & Height & "&Weight=" & Weight & "&Gaited=" & Gaited & "Warmblooded=" & Warmblooded )
end if 



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

If len(PercentUSA) = 0 then
PercentUSA = " "
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



sql2 = "select AnimalRegistrationID from AnimalRegistration where RegNumber = '" & ARI & "' and RegType = 'ARI' " 
Set rs2 = Server.CreateObject("ADODB.Recordset")
    rs2.Open sql2, conn, 3, 3   
   If not rs2.eof Then
    AnimalRegistrationID = rs2("AnimalRegistrationID")
   end if
   rs2.close
   

sql2 = "select Animals.AnimalID from Animals where PeopleID = " & session("PeopleID") & " and FullName = '" & Name & "'" 
response.write("sql2 =" & sql2  )


Set rs2 = Server.CreateObject("ADODB.Recordset")
    rs2.Open sql2, conn, 3, 3   

   If not rs2.eof Then
AlpacasID = rs2("AnimalID")
ID = rs2("AnimalID")
AnimalID = rs2("AnimalID")
else
Query =  "INSERT INTO Animals (FullName, NumberofAnimals,  Lastupdated, PeopleID, SpeciesID, AnimalRegistrationID , CLAA, DOBMonth, DOBDay, DOBYear,  "
if len(BreedID2) > 0 then
Query = Query & " BreedID2, "
end if
if len(BreedID3) > 0 then
Query = Query & " BreedID3, "
end if
if len(BreedID4) > 0 then
Query = Query & " BreedID4, "
end if
if len(BreedID) > 0 then
Query = Query & " BreedID, "
end if

if len(Weight) > 0 then
Query = Query & " Weight, "
end if

if len(Height) > 0 then
Query = Query & " Height, "
end if

if len(Gaited) > 0 then
Query = Query & " Gaited, "
end if

if len(Warmblood) > 0 then
Query = Query & " Warmblooded, "
end if

Query = Query & "  Category)" 

Query =  Query + " Values ('" &  Name & "'," 

Query =  Query & " '" &  NumberofAnimals & "'," 


Query =  Query & " SYSDATETIME()," 

Query =  Query & " " &  Session("PeopleID") & "," 
        Query =  Query & " '" &  SpeciesID & "'," 
Query =  Query & " '" &  AnimalRegistrationID & "'," 
Query =  Query & " '" &  CLAA & "'," 
Query =  Query & " " &  DOBMonth & "," 
Query =  Query & " " &  DOBDay & "," 
Query =  Query & " " &  DOBYear & "," 
if len(BreedID2) > 0 then
Query =  Query & " " & BreedID2  & ", " 
end if
if len(BreedID3) > 0 then
Query =  Query & " " & BreedID3  & ", " 
end if
if len(BreedID4) > 0 then
Query =  Query & " " & BreedID4  & ", " 
end if
if len(BreedID) > 0 then
Query =  Query & " " & BreedID  & ", " 
end if

if len(Height) > 0 then
Query =  Query & " '" & Height  & "', " 
end if
if len(Weight) > 0 then
Query =  Query & " '" & Weight  & "', " 
end if
if len(Gaited) > 0 then
Query =  Query & " " & Gaited  & ", " 
end if
if len(Warmblood) > 0 then
Query =  Query & " " & Warmblood  & ", " 
end if

Query = Query & " '"  &  Category &  "')"
response.write("Query=" & Query)

Conn.Execute(Query) 

sql2 = "select Animals.AnimalID from Animals where Animals.FullName = '" & Name & "'" 
Set rs2 = Server.CreateObject("ADODB.Recordset")
response.write(query)
rs2.Open sql2, conn, 3, 3   
AnimalID = rs2("AnimalID")
ID = rs2("AnimalID")
rs2.close

For rowcount = 1 To TotalRegistrations 
SpeciesRegistrationTypecount = "SpeciesRegistrationType(" & rowcount & ")"
RegistrationNumbercount = "RegistrationNumber(" & rowcount & ")"
SpeciesRegistrationType(rowcount)=Request.Form(SpeciesRegistrationTypecount) 
RegistrationNumber(rowcount)=Request.Form(RegistrationNumbercount )
Query =  "INSERT INTO AnimalRegistration ( RegType, AnimalID, RegNumber)" 
Query =  Query & " Values ('" & SpeciesRegistrationType(rowcount) & "'," 
Query =  Query & " " &  ID & "," 
Query =  Query & " '" & RegistrationNumber(rowcount)  & "')"
response.write(query)
Conn.Execute(Query) 
next


sql2 = "select * from Ancestors where AnimalID = " & AnimalID & "" 
Set rs2 = Server.CreateObject("ADODB.Recordset")
response.write(query)
rs2.Open sql2, conn, 3, 3   
if not rs2.eof then
Query =  "Delete From Ancestors where AnimalID = " &  AnimalID & "" 
response.write("Query = " & Query )
Conn.Execute(Query) 
end if
rs2.close


Query =  "INSERT INTO Ancestors (AnimalID)" 
Query =  Query & " Values (" &  AnimalID & ")" 
response.write(Query)
Conn.Execute(Query) 


'Query =  "INSERT INTO AncestryPercents (AnimalID, PercentPeruvian, PercentBolivian, PercentChilean, PercentUnknownOther, PercentAccoyo)" 
'Query =  Query & " Values (" &  AlpacasID & "," 
'Query =  Query & " '" &  PercentPeruvian & "'," 
'Query =  Query & " '" &  PercentBolivian & "'," 
'Query =  Query & " '" & PercentChilean & "'," 
'Query = Query & " '"  &  PercentUnknownOther & "'," 
'Query =  Query & " '" & PercentAccoyo & "')"
'response.write(query)

Conn.Execute(Query) 

Query =  "INSERT INTO Colors (AnimalID, Color1, Color2, Color3, Color4, Color5)" 
Query =  Query & " Values (" &  AnimalID & "," 
Query =  Query & " '" &  Color1 & "'," 
Query =  Query & " '" &  Color2 & "'," 
Query =  Query & " '" & Color3 & "'," 
Query = Query & " '"  &  Color4 & "'," 
Query =  Query & " '" & Color5 & "')"


Conn.Execute(Query) 


Query =  "INSERT INTO Photos (AnimalID)" 
Query =  Query & " Values (" &  AnimalID & ")"
response.write(query)
Conn.Execute(Query) 

If Category = "Experienced Female" Or Category = "Inexperienced Female" then
Query =  "INSERT INTO FemaleData (AnimalID)" 
Query =  Query & " Values (" & AnimalID & ")"

Conn.Execute(Query) 

End If 

Conn.Close
Set Conn = Nothing 
 
 End If 
 
 response.redirect("MembersAnimalAdd2.ASP?NumberofAnimals=" & NumberofAnimals & "&BusinessID=" & BusinessID  &  "&SpeciesID=" & SpeciesID & "&AnimalID=" & ID & "&Name=" & Name) %>
 
 </Body>
</HTML>
