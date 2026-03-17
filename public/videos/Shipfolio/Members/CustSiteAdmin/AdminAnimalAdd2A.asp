<!DOCTYPE HTML >
<HTML>
<HEAD>
<link rel="stylesheet" type="text/css" href="/administration/style.css"><!--#Include file="AdminSecurityInclude.asp"-->
<!--#Include file="AdminGlobalvariables.asp"--> 
</HEAD>
<body >

<!--#Include file="AdminHeader.asp"--> 

<%
dim	Name
dim	ARI
dim	CLAA
dim	DOBMonth
dim	DOBDay
dim	DOBYear
dim	Category
dim	Breed
dim	Color1
dim	Color2
dim	Color3
dim	Color4
dim	Color5
dim	PercentPeruvian
dim	PercentChilean
dim	PercentBolivian
dim	PercentUnknownOther
dim	PercentAccoyo
dim	PercentUSA
dim	PercentCanadian
dim RegistrationType(100)
dim RegistrationNumber(100)
Name=Request.Form("Name" ) 
if len(Name) < 1 then
Name=Request.querystring("Name" ) 
end if
	
ARI=Request.Form("ARI" ) 
CLAA=Request.Form("CLAA" ) 
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
PercentUSA=Request.Form("PercentUSA") 
PercentCanadian=Request.Form("PercentCanadian")

SpeciesID=Request.Form("SpeciesID")
dim SpeciesRegistrationType(1000)
totalregistrations = request.Form("totalregistrations")
'sql2 = "select * from SpeciesBreedLookupTable where Breed='" & Breed & "'"
'Set rs2 = Server.CreateObject("ADODB.Recordset")
'rs2.Open sql2, conn, 3, 3
'if not rs2.eof then
'SpeciesID = rs2("SpeciesID")
'BreedLookupID = rs2("BreedLookupID")
'end if
'rs2.close
	 
str1 = Name
str2 = "'"
If InStr(str1,str2) > 0 Then
	Name= Replace(str1, "'", "''")
End If
	
	
sql2 = "select Animals.ID from Animals where FullName = '" & Name & "'" 
response.Write("sql2=" & sql2)
	Set rs2 = Server.CreateObject("ADODB.Recordset")
    rs2.Open sql2, conn, 3, 3   

   If not rs2.eof Then
   redirctstring = "AdminAnimalAdd1.asp?Duplicate=True&Name=" & Name 
   For rowcount = 1 To totalregistrations
       redirctstring = redirctstring & "&RegistrationType(" & rowcount & ")=" & RegistrationType(rowcount) 
   next
   
   redirctstring = redirctstring & "&DOBMonth=" & DOBMonth & "&DOBDay=" & DOBDay & "&DOBYear=" & DOBYear & "&Category=" & Category & "&BreedLookupID=" & BreedLookupID & "&	Color1=" & Color1 & "&Color2=" & Color2 & "&Color3=" & Color3 & "&Color4=" & Color4 & "&Color5=" & Color5 & "&PercentUSA=" & PercentUSA & "&PercentCanadian=" & PercentCanadian & "&PercentPeruvian=" & PercentPeruvian & "&PercentChilean=" & PercentChilean & "&PercentBolivian=" & PercentBolivian & "&PercentUnknownOther=" & PercentUnknownOther & "&PercentAccoyo=" & PercentAccoyo & "&speciesID=" & speciesID
		response.Redirect(redirctstring)

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

If len(PercentUSA) = 0 then
	PercentUSA = " "
End If

If len(PercentCanadian) = 0 then
	PercentCanadian = " "
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

 
if len(BreedLookupID) > 0 then
else
BreedLookupID =0
end if
   

sql2 = "select Animals.ID from Animals where FullName = '" & Name & "'" 
response.Write("sql2=" & sql2)
	Set rs2 = Server.CreateObject("ADODB.Recordset")
    rs2.Open sql2, conn, 3, 3   

   If not rs2.eof Then
		AlpacasID = rs2("ID")
		ID = rs2("ID")
	else
		Query =  "INSERT INTO Animals (FullName,  DOBMonth, DOBDay, DOBYear, Category, "
        if len(BreedID) > 0 then
        Query = Query & " BreedID, "
        end if 
        if len(BreedID2) > 0 then
        Query = Query & " BreedID2, "
        end if 
        if len(BreedID3) > 0 then
        Query = Query & " BreedID3, "
        end if 
        if len(BreedID4) > 0 then
        Query = Query & " BreedID4, "
        end if 
        Query = Query & " ShowwithDam, ShowwithSire, SpeciesID )" 
		Query =  Query + " Values ('" &  Name & "'," 
		Query =  Query & " " &  DOBMonth & "," 
		Query =  Query & " " &  DOBDay & "," 
		Query =  Query & " " &  DOBYear & "," 
		Query = Query & " '"  &  Category & "', " 

        if len(BreedID) > 0 then
        Query = Query & " "  & BreedID & ", " 
        end if 
        if len(BreedID2) > 0 then
        Query = Query & " "  & BreedID2 & ", " 
        end if 
        if len(BreedID3) > 0 then
       Query = Query & " "  & BreedID3 & ", " 
        end if 
        if len(BreedID4) > 0 then
        Query = Query & " "  & BreedID4 & ", " 
        end if 



		
Query = Query & " Yes, " 
		Query = Query & "Yes, " 
		Query =  Query & " " & SpeciesID  & ")"
response.Write("Query=" & Query )

Conn.Execute(Query) 
sql2 = "select Animals.ID from Animals where Animals.FullName = '" & Name & "'" 
		Set rs2 = Server.CreateObject("ADODB.Recordset")
		response.write(query)
		rs2.Open sql2, conn, 3, 3   
		AlpacasID = rs2("ID")
		ID = rs2("ID")

		rs2.close

response.Write("totalregistrations=" & totalregistrations )
regcount = 0
 For regcount = 1 To totalregistrations 
	RegistrationNumbercount = "RegistrationNumber(" & regcount & ")"
	RegistrationNumber(regcount)=Request.Form(RegistrationNumbercount) 
	response.Write("RegistrationNumber(" & regcount & ")=" & RegistrationNumber(regcount) )
Next



sql2 = "select * from SpeciesRegistrationTypeLookupTable where SpeciesID=" & speciesID
response.Write("sql2=" & sql2)
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3
while not(rs2.eof)  
x = x + 1

SpeciesRegistrationType(x) =rs2("SpeciesRegistrationType")
response.write("<br />regtype" & x & "=" & SpeciesRegistrationType(x) )

 rs2.movenext
wend 
rs2.close 	



 For rowcount = 1 To totalregistrations 
 
Query =  "INSERT INTO AnimalRegistration (RegType, AnimalID, RegNumber)" 
		Query =  Query & " Values ('" & SpeciesRegistrationType(rowcount) & " '," 
		 Query =  Query & " " & ID  & " ,"
	    Query =  Query & " '" & RegistrationNumber(rowcount)   & "')"
'response.Write("Query=" & Query )

Conn.Execute(Query) 
 next	


sql2 = "select * from Ancestors where ID = " & ID & "" 
		Set rs2 = Server.CreateObject("ADODB.Recordset")
		response.write(query)
		rs2.Open sql2, conn, 3, 3   
		if not rs2.eof then
		Query =  "Delete * From Ancestors where ID = " &  ID & "" 
Conn.Execute(Query) 
		end if
		rs2.close
		
		
Query =  "INSERT INTO Ancestors (ID)" 
		Query =  Query & " Values (" &  ID & ")" 

Conn.Execute(Query) 
		
		
	Query =  "INSERT INTO AncestryPercents (ID, PercentUSA, PercentCanadian, PercentPeruvian, PercentBolivian, PercentChilean, PercentUnknownOther, PercentAccoyo)" 
		Query =  Query & " Values (" &  AlpacasID & ","
		Query =  Query & " '" &  PercentUSA & "'," 
		Query =  Query & " '" &  PercentCanadian & "',"  
		Query =  Query & " '" &  PercentPeruvian & "'," 
		Query =  Query & " '" &  PercentBolivian & "'," 
		Query =  Query & " '" & PercentChilean & "'," 
		Query = Query & " '"  &  PercentUnknownOther & "'," 
		Query =  Query & " '" & PercentAccoyo & "')"

Conn.Execute(Query) 

		Query =  "INSERT INTO Colors (ID, Color1, Color2, Color3, Color4, Color5)" 
		Query =  Query & " Values (" &  AlpacasID & "," 
		Query =  Query & " '" &  Color1 & "'," 
		Query =  Query & " '" &  Color2 & "'," 
		Query =  Query & " '" & Color3 & "'," 
		Query = Query & " '"  &  Color4 & "'," 
		Query =  Query & " '" & Color5 & "')"

Conn.Execute(Query) 

Query =  "INSERT INTO Photos (ID)" 
Query =  Query & " Values (" &  ID & ")"
response.write(query)


				If Category = "Experienced Female" Or Category = "Inexperienced Female" then
					Query =  "INSERT INTO FemaleData (ID)" 
					Query =  Query & " Values (" &  ID & ")"

Conn.Execute(Query) 
	Conn.Close
	Set Conn = Nothing 

End If 

 
 End If 
 
 response.redirect("AdminAnimalAdd2.ASP?wizard=True&ID=" & ID & "&speciesID=" & speciesID) %>
 
 </Body>
</HTML>
