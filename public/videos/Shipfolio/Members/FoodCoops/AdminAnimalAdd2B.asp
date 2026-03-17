<!DOCTYPE HTML >
<HTML>
<HEAD>
<link rel="stylesheet" type="text/css" href="/style.css">
</HEAD>
<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
<br /> 
<!--#Include file="AdminGlobalvariables.asp"--> 
<%
dim SpeciesRegistrationType(100)
dim RegistrationNumber(1000)

speciesID=Request.Form("speciesID")
totalregistrations = Request.form("totalregistrations")
NumberofAnimals = Request.form("NumberofAnimals")
Name=Request.Form("Name") 
if len(Name) < 1 then
Name=Request.querystring("Name") 
end if
SalePending = Request.form("SalePending")
PriceComments = Request.Form("PriceComments")
response.write("PriceComments=" & PriceComments )
Sold = Request.Form("Sold")
Foundation = Request.Form("Foundation")
Description = Request.Form("Description")
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
Height=Request.Form("Height") 
Weight=Request.Form("Weight") 
Gaited=Request.Form("Gaited") 
Warmblood=Request.Form("Warmblood") 

PercentPeruvian=Request.Form("PercentPeruvian") 
PercentChilean=Request.Form("PercentChilean") 
PercentBolivian=Request.Form("PercentBolivian") 
PercentUnknownOther=Request.Form("PercentUnknownOther") 
PercentAccoyo=Request.Form("PercentAccoyo") 
OBO=Request.Form("OBO") 
ForSale=Request.Form("ForSale") 
Price=Request.Form("Price") 
Free=Request.Form("Free") 
Temperment = Request.Form("Temperment")

Dim str1
Dim str2
str1 = Description
str2 = "'"
If InStr(str1,str2) > 0 Then
Description= Replace(str1,  str2, "''")
End If  

str1 = Description
str2 = vbCrLf
If InStr(str1,str2) > 0 Then
Description= Replace(str1, str2 , "</br>")
End If  
	


str1 = Name
str2 = "'"
If InStr(str1,str2) > 0 Then
Name= Replace(str1, "'", "''")
End If

Missing = ""
if len(Category) < 2 then
Missing = Missing & "&Missingcategory=True"
end if
if len(BreedID) >0 or len(BreedID2) >0 or len(BreedID3) >0 and len(BreedID4) > 0  then
else
Missing = Missing & "&MissingBreed=True"
end if

if len(Name) < 2 then
Missing = Missing & "&MissingName=True"
end if

if len(Missing) > 2 then
response.Redirect("AdminAnimalAdd1.asp?speciesID=" & speciesID & "&Name=" & Name & "&ARI=" & ARI  & "&Description=" & Description & "&PriceComments=" & PriceComments & "&CLAA=" & CLAA & "&DOBMonth=" & DOBMonth & "&DOBDay=" & DOBDay & "&DOBYear=" & DOBYear & "&Category=" & Category & "&BreedID=" & BreedID & "&BreedID2=" & BreedID2  & "&BreedID3=" & BreedID3  & "&BreedID4=" & BreedID4 & "&Color1=" & Color1 & "&Color2=" & Color2 & "&Color3=" & Color3 & "&Color4=" & Color4 & "&Color5=" & Color5  & "&PercentPeruvian=" & PercentPeruvian & "&PercentChilean=" & PercentChilean & "&PercentBolivian=" & PercentBolivian & "&PercentUnknownOther=" & PercentUnknownOther & "&PercentAccoyo=" & PercentAccoyo & "&Height=" & Height & "&Weight=" & Weight &  "&ForSale=" & ForSale & "&OBO=" & OBO &  "&Price=" & Price &  "&SalePending=" & SalePending &  "&Free=" & Free &  "&Sold=" & Sold & "&Foundation=" & Foundation   & "&Temperment=" & Temperment & "&Gaited=" & Gaited & "&Warmblooded=" & Warmblooded & Missing)
end if


sql2 = "select Animals.ID from Animals where PeopleID = " & session("PeopleID") & " and FullName = '" & Name & "' and speciesID = " & speciesID 
response.Write("sql2=" & sql2)
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3   
If not rs2.eof Then
response.Redirect("AdminAnimalAdd1.asp?Duplicate=True&speciesID=" & speciesID & "&Name=" & Name & "&ARI=" & ARI  & "&Description=" & Description & "&PriceComments=" & PriceComments & "&CLAA=" & CLAA & "&DOBMonth=" & DOBMonth & "&DOBDay=" & DOBDay & "&DOBYear=" & DOBYear & "&Category=" & Category & "&BreedID=" & BreedID & "&BreedID2=" & BreedID2  & "&BreedID3=" & BreedID3  & "&BreedID4=" & BreedID4 & "&Color1=" & Color1 & "&Color2=" & Color2 & "&Color3=" & Color3 & "&Color4=" & Color4 & "&Color5=" & Color5  & "&PercentPeruvian=" & PercentPeruvian & "&PercentChilean=" & PercentChilean & "&PercentBolivian=" & PercentBolivian & "&PercentUnknownOther=" & PercentUnknownOther & "&PercentAccoyo=" & PercentAccoyo & "&Height=" & Height & "&Weight=" & Weight &  "&ForSale=" & SorSale & "&OBO=" & OBO &  "&Price=" & Price &  "&SalePending=" & SalePending &  "&Free=" & Free &  "&Sold=" & Sold & "&Foundation=" & Foundation  & "&Temperment=" & Temperment & "&Gaited=" & Gaited & "&Warmblooded=" & Warmblooded & Missing )
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
   

sql2 = "select Animals.ID from Animals where PeopleID = " & session("PeopleID") & " and FullName = '" & Name & "'" 
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3   
 If not rs2.eof Then
AlpacasID = rs2("ID")
ID = rs2("ID")
else
Query =  "INSERT INTO Animals (FullName, PeopleID, NumberofAnimals, SpeciesID, AnimalRegistrationID , CLAA, DOBMonth, DOBDay, DOBYear,  "
if len(Description) > 0 then
Query = Query & " Description, "
end if
if len(Temperment) > 0 then
Query = Query & " Temperment, "
end if
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
Query =  Query & " Values ('" &  Name & "'," 
Query =  Query & " " &  Session("PeopleID") & "," 
Query =  Query & " '" &   NumberofAnimals & "'," 
Query =  Query & " '" &  SpeciesID & "'," 
Query =  Query & " '" &  AnimalRegistrationID & "'," 
Query =  Query & " '" &  CLAA & "'," 
Query =  Query & " " &  DOBMonth & "," 
Query =  Query & " " &  DOBDay & "," 
Query =  Query & " " &  DOBYear & "," 
if len(Description) > 0 then
Query =  Query & " '" & Description & "', " 
end if
if len(Temperment) > 0 then
Query =  Query & " " & Temperment  & ", " 
end if
if len(BreedID) > 0 then
Query =  Query & " " & BreedID  & ", " 
end if
if len(BreedID2) > 0 then
Query =  Query & " " & BreedID2  & ", " 
end if
if len(BreedID3) > 0 then
Query =  Query & " " & BreedID3  & ", " 
end if
if len(BreedID4) > 0 then
Query =  Query & " " & BreedID4  & ", " 
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
'response.write("Query=" & Query)

Conn.Execute(Query) 

sql2 = "select Animals.ID from Animals where Animals.FullName = '" & Name & "'" 
Set rs2 = Server.CreateObject("ADODB.Recordset")
response.write(query)
rs2.Open sql2, conn, 3, 3   
AlpacasID = rs2("ID")
ID = rs2("ID")
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
response.write(Query)
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
response.write(Query)
Conn.Execute(Query) 


Query =  "INSERT INTO AncestryPercents (ID, PercentPeruvian, PercentBolivian, PercentChilean, PercentUnknownOther, PercentAccoyo)" 
Query =  Query & " Values (" &  AlpacasID & "," 
Query =  Query & " '" &  PercentPeruvian & "'," 
Query =  Query & " '" &  PercentBolivian & "'," 
Query =  Query & " '" & PercentChilean & "'," 
Query = Query & " '"  &  PercentUnknownOther & "'," 
Query =  Query & " '" & PercentAccoyo & "')"
response.write(query)

Conn.Execute(Query) 

Query =  "INSERT INTO Colors (ID, Color1, Color2, Color3, Color4, Color5)" 
Query =  Query & " Values (" &  AlpacasID & "," 
Query =  Query & " '" &  Color1 & "'," 
Query =  Query & " '" &  Color2 & "'," 
Query =  Query & " '" & Color3 & "'," 
Query = Query & " '"  &  Color4 & "'," 
Query =  Query & " '" & Color5 & "')"
response.write("query=" & query)

Conn.Execute(Query) 


Query =  "INSERT INTO Photos (ID)" 
Query =  Query & " Values (" &  ID & ")"
response.write(query)
Conn.Execute(Query) 

If Category = "Experienced Female" Or Category = "Inexperienced Female" then
Query =  "INSERT INTO FemaleData (ID)" 
Query =  Query & " Values (" &  ID & ")"
Conn.Execute(Query) 
End If 

For rowcount = 1 To 10
Query =  "INSERT INTO Fiber ( ID)" 
Query =  Query & " Values (" &  ID & ")" 
Conn.Execute(Query) 
next


while (rowcount < 14)
Query =  "INSERT INTO Awards ( ID)" 
Query =  Query & " Values (" &  ID & " )" 
response.write("Query=")	
response.write(Query)	
Conn.Execute(Query) 
rowcount = rowcount +1

wend

Price=Request.Form("Price") 
SalePending=Request.Form("SalePending") 
Sold=Request.Form("Sold") 
StudFee=Request.Form("StudFee") 
ForSale=Request.Form("ForSale") 
Foundation=Request.Form("Foundation") 
PriceComments=Request.Form("PriceComments") 
response.write("PriceComments=" & PriceComments )
Discount=Request.Form("Discount") 
ShowOnStudPage=Request.Form("ShowOnStudPage") 
OBO=Request.Form("OBO") 
PayWhatYouCanAnimal=Request.Form("PayWhatYouCanAnimal") 
PayWhatYouCanStud=Request.Form("PayWhatYouCanStud") 
EmbryoPrice=Request.Form("EmbryoPrice") 
SemenPrice=Request.Form("SemenPrice") 
Donor=Request.Form("Donor") 
Free=Request.Form("Free") 
response.write("Free=" & Free)
CoOwnerBusiness1 = request.form("CoOwnerBusiness1")
str1 = CoOwnerBusiness1
str2 = "'"
If InStr(str1,str2) > 0 Then
	CoOwnerBusiness1= Replace(str1,  str2, "''")
End If 

CoOwnerName1 = request.form("CoOwnerName1")
str1 = CoOwnerName1
str2 = "'"
If InStr(str1,str2) > 0 Then
	CoOwnerName1= Replace(str1,  str2, "''")
End If 
CoOwnerLink1 = request.form("CoOwnerLink1")
str1 = CoOwnerLink1
str2 = "'"
If InStr(str1,str2) > 0 Then
	CoOwnerLink1= Replace(str1,  str2, "''")
End If
CoOwnerBusiness2 = request.form("CoOwnerBusiness2")
str1 = CoOwnerBusiness2
str2 = "'"
If InStr(str1,str2) > 0 Then
	CoOwnerBusiness2= Replace(str1,  str2, "''")
End If
CoOwnerName2 = request.form("CoOwnerName2")
str1 = CoOwnerName2
str2 = "'"
If InStr(str1,str2) > 0 Then
	CoOwnerName2= Replace(str1,  str2, "''")
End If

CoOwnerLink2 = request.form("CoOwnerLink2")
str1 = CoOwnerLink2
str2 = "'"
If InStr(str1,str2) > 0 Then
	CoOwnerLink2= Replace(str1,  str2, "''")
End If

CoOwnerBusiness3 = request.form("CoOwnerBusiness3")
str1 = CoOwnerBusiness3
str2 = "'"
If InStr(str1,str2) > 0 Then
	CoOwnerBusiness3= Replace(str1,  str2, "''")
End If

CoOwnerName3 = request.form("CoOwnerName3")
str1 = CoOwnerName3
str2 = "'"
If InStr(str1,str2) > 0 Then
	CoOwnerName3= Replace(str1,  str2, "''")
End If

CoOwnerLink3 = request.form("CoOwnerLink3")
str1 = CoOwnerLink3
str2 = "'"
If InStr(str1,str2) > 0 Then
	CoOwnerLink3= Replace(str1,  str2, "''")
End If



 rowcount =1

if ShowOnStudPage = "Yes" Then
ShowOnStudPage = True
else
	ShowOnStudPage = False
end if 

if Discount  = "" then
	Discount = "0"
end if 

if Price  = "" then
	Price = "0"
end if 

str1 = Price
str2 = ","
If InStr(str1,str2) > 0 Then
	Price= Replace(str1, ",", "")
End If

str1 = Price
str2 = "$"
If InStr(str1,str2) > 0 Then
	Price= Replace(str1, "$", "")
End If

if StudFee  = "" then
	StudFee = "0"
end if 

str1 = StudFee
str2 = ","
If InStr(str1,str2) > 0 Then
	StudFee= Replace(str1, ",", "")
End If

str1 = StudFee
str2 = "$"
If InStr(str1,str2) > 0 Then
	StudFee = Replace(str1, "$", "")
End If
str1 = PriceComments
str2 = "'"
If InStr(str1,str2) > 0 Then
PriceComments= Replace(str1, "'", "''")
End If
If IsNumeric(StudFee) Then
StudFee = cDBL(StudFee)
else
StudFee = ""
end if
If IsNumeric(Price) Then
Price = cDBL(Price)
else
Price = ""
end if

sql2 = "select * from Pricing where ID = " &  ID & ";" 
'response.write(sql2)
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3   
If rs2.eof Then

Query =  "INSERT INTO Pricing (ID, "
if len(EmbryoPrice) > 0 then
Query =  Query & " EmbryoPrice, "
end if
if len(SemenPrice) > 0 then
Query =  Query & " SemenPrice, "
end if

Query =  Query & " StudFee, Price, Free, Foundation ,OBO, SalePending, Sold, PayWhatYouCanStud, Forsale, Discount, PriceComments  )" 
Query =  Query & " Values (" &  ID & "," 
if len(EmbryoPrice) > 0 then
Query =  Query & " '" & EmbryoPrice & "',"
end if
if len(SemenPrice) > 0 then
Query =  Query & " '" & SemenPrice & "',"
end if

Query =  Query & " '" & StudFee & "',"
Query =  Query & " '" & Price & "',"
Query =  Query & " " & Free & ","
Query =  Query & " " & Foundation  & ","
Query =  Query & " " & OBO & ","
Query =  Query & " " & SalePending & ","
Query =  Query & " " & Sold & ","
if len(PayWhatYouCanStud ) > 1 then
Query =  Query & " " & PayWhatYouCanStud & ","
else
Query =  Query & " False ,"
end if
Query =  Query & " " & ForSale & ","
Query =  Query & " " & Discount & ","
Query =  Query & " '" & PriceComments  & "')"
response.write("Query=" & query)
Conn.Execute(Query) 
End if
Conn.Close
Set Conn = Nothing 
End If 
response.redirect("EditAnimal.asp?FirstTime=True&PeopleID=" & PeopleID & "&SpeciesID=" & SpeciesID & "&ID=" & ID ) %>
 </Body>
</HTML>