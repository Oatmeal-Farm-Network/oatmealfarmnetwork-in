<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<HEAD>
<!--#Include file="Membersglobalvariables.asp"-->
<base target="_self" />
</HEAD>
<BODY>
<% dim SpeciesRegistrationType(100)
dim RegistrationNumber(1000)

ID=Request.Form("ID" ) 
Vaccinations = Request.form("Vaccinations")
response.write("Vaccinations=" & Vaccinations )
Horns = request.form("Horns")
SpeciesID=Request.Form("SpeciesID") 
response.write("SpeciesID=" & SpeciesID )
Name=Request.Form("Name" ) 
DOBMonth=Request.Form( "DOBMonth" ) 
DOBDay=Request.Form( "DOBDay" ) 
DOBYear=Request.Form( "DOBYear" ) 
Category=Request.Form("Category")
BreedID=Request.Form("BreedID")
BreedID2=Request.Form("BreedID2")
BreedID3=Request.Form("BreedID3")
BreedID4=Request.Form("BreedID4")
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
TotalRegistrations =Request.Form("TotalRegistrations") 
Weight =Request.Form("Weight") 
Height =Request.Form("Height") 
Gaited =Request.Form("Gaited") 
Warmblooded =Request.Form("Warmblooded") 
Temperment =Request.Form("Temperment") 
NumberofAnimals = Request.Form("NumberofAnimals")

str1 = Name
str2 = "'"
If InStr(str1,str2) > 0 Then
	Name= Replace(str1, "'", "''")
End If


str1 = Vaccinations
str2 = "'"
If InStr(str1,str2) > 0 Then
	Vaccinations= Replace(str1, "'", "''")
End If


If len(ARI) = 0 then
ARI = "0"
End If
If len(CLAA) = 0 then
CLAA = "0"
End if
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
sql2 = "select Animals.ID from Animals where PeopleID = " & session("AIID") & " and id = " & id & "" 
Set rs2 = Server.CreateObject("ADODB.Recordset")
response.write("sql2=" & sql2)
rs2.Open sql2, connLOA, 3, 3   


Query =  " UPDATE Animals  Set FullName = '" &  Name & "', "
Query =  Query & " PeopleID = " &  Session("AIID") & ", " 
if category = "Inexperienced Female" or  category = "Experienced Female" or  category = "Non-Breeder"  then
Query =  Query & " PublishStud= False, "
end if
if len(SpeciesID) > 0 then
Query =  Query & " SpeciesID= " & SpeciesID & ", "
end if

Query =  Query & " Vaccinations = '" &  Vaccinations & "', " 
Query =  Query & " Horns = '" &  Horns & "', " 
Query =  Query & " DOBMonth = '" &  DOBMonth & "', " 
Query =  Query & " DOBDay = '" &  DOBDay & "', " 
Query =  Query & " DOBYear = '" &  DOBYear & "', " 

Query =  Query & " NumberofAnimals = '" &  NumberofAnimals & "', " 


if len(Temperment) > 0 then
Query =  Query & " Temperment = " & Temperment & " , " 
else
Query =  Query & " Temperment = 0 , " 
end if


Query =  Query & " Weight = '" & Weight & "' , " 
Query =  Query & " Height = '" & Height & "' , " 

Query =  Query & " Gaited= '" & Gaited & "' , " 
Query =  Query & " Warmblooded= '" & Warmblooded & "' , " 


if len(BreedID) > 0 then
Query =  Query & " BreedID = " &  BreedID & " , " 
end if
if len(BreedID2) > 0 then
Query =  Query & " BreedID2 = " &  BreedID2 & " ," 
end if
if len(BreedID3) > 0 then
Query =  Query & " BreedID3 = " &  BreedID3 & " ," 
end if
if len(BreedID4) > 0 then
Query =  Query & " BreedID4 = " &  BreedID4 & ", " 
end if
Query =  Query & " Category = '" &  Category & "' ," 
Query =  Query & " Lastupdated = getdate() " 


Query =  Query & " where ID = " & ID & ";" 
response.write("Query =" & Query )
connLOA.Execute(Query) 

sql2 = "select Animals.ID from Animals where Animals.FullName = '" & Name & "'" 
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, connLOA, 3, 3   
AlpacasID = rs2("ID")
ID = rs2("ID")
rs2.close
set rs2=nothing
Query =  " UPDATE AncestryPercents Set PercentPeruvian = '" &  PercentPeruvian & "', "
Query =  Query & " PercentBolivian = '" &  PercentBolivian & "', " 
Query =  Query & " PercentChilean = '" &  PercentChilean & "', " 
Query =  Query & " PercentUnknownOther = '" &  PercentUnknownOther & "', " 
Query =  Query & " PercentAccoyo = '" &  PercentAccoyo & "' " 
Query =  Query & " where ID = " & AlpacasID & ";" 
connLOA.Execute(Query) 
For rowcount = 1 To TotalRegistrations 
SpeciesRegistrationTypecount = "SpeciesRegistrationType(" & rowcount & ")"
RegistrationNumbercount = "RegistrationNumber(" & rowcount & ")"



SpeciesRegistrationType(rowcount)=Request.Form(SpeciesRegistrationTypecount) 
RegistrationNumber(rowcount)=Request.Form(RegistrationNumbercount )
str1 = RegistrationNumber(rowcount)
str2 = "'"
If InStr(str1,str2) > 0 Then
	RegistrationNumber(rowcount)= Replace(str1, "'", "''")
End If


Query =  " UPDATE AnimalRegistration Set RegNumber = '" &  RegistrationNumber(rowcount)  & "' "
Query =  Query & " where AnimalID = " & AlpacasID & " and RegType = '" & SpeciesRegistrationType(rowcount) & "';" 
'response.write(query)
connLOA.Execute(Query) 
next
connLOA.Execute(Query) 
Query =  " UPDATE Colors Set Color1 = '" &  Color1 & "', "
Query =  Query & " Color2 = '" &  Color2 & "', " 
Query =  Query & " Color3 = '" &  Color3 & "', " 
Query =  Query & " Color4 = '" &  Color4 & "', " 
Query =  Query & " Color5 = '" &  Color5 & "' " 
Query =  Query & " where ID = " & AlpacasID & ";" 
connLOA.Execute(Query) 
connLOA.close
set connLOA = nothing 
'response.redirect("MembersGeneralStatsFrame.asp?ID=" & AlpacasID & "&changesmade=True")
 %>
</body>
</html>