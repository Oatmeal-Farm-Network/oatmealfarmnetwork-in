<% 	ID= Request.QueryString("ID") 
If Len(ID) < 2 then
ID= Request.Form("ID") 
End If 
Session("Animalid")= ID
DetailType= "Other"
'response.write("DetailType=")
'response.write(DetailType)
'response.write("ID=")
'response.write(ID)
If Len(ID) > 0 then
sql = "select awards.placing from Awards where  (placing = 'Reserve Champion' or placing = 'Res. Color Champion'  or placing = 'Res. Champion' or placing = 'Color Reserve Champion' or placing = 'Color Champion') and  ID=" & ID
rs.Open sql, conn, 3, 3
If Not rs.eof  then
champ = True
Else
champ = false
End If
rs.close
sql = "select Count(*) as count from Awards where ID=" & ID
rs.Open sql, conn, 3, 3
filledawardscount = rs("count")
rs.close
sql = "select Count(*) as count from Awards where ( length(AwardYear) > 1 or length(Placing) > 1 or length(AwardComments) > 1) and ID=" & ID
rs.Open sql, conn, 3, 3
skip = false
if skip = false then
if clng(filledawardscount) = clng(rs("count")) then
Query =  "INSERT INTO Awards (ID)" 
Query =  Query & " Values (" &  ID & ")"
conn.Execute(Query) 
end if 
If rs.eof Or (clng(rs("count")) < 11) then
counter = clng(filledawardscount)
While clng(counter) < 11
Query =  "INSERT INTO Awards (ID)" 
Query =  Query & " Values (" &  ID & ")"
Counter = counter + 1
conn.Execute(Query) 
wend
End If 
end if
rs.close
'sql = "select AnimalRegistrationID from Animals where ID=" & ID	
'rs.Open sql, conn, 3, 3
'AnimalRegistrationID = rs("AnimalRegistrationID")
'rs.close	
'AnimalRegistrationIDFound =False
'sql = "select AnimalRegistrationID from AnimalRegistration where AnimalRegistrationID=" & AnimalRegistrationID	
'rs.Open sql, conn, 3, 3
'if not rs.eof then
'AnimalRegistrationIDFound = True
'end if 
'rs.close
'if AnimalRegistrationIDFound =False then
'Query =  "INSERT INTO AnimalRegistration (AnimalRegistrationID, RegType)" 
'Query =  Query & " Values (" &  AnimalRegistrationID & ", 'ARI')"
'Conn.Execute(Query) 
'end if
sql = "select Ancestors.*, Animals.*, Pricing.*, colors.*, Ancestrypercents.*, Awards.*, AnimalRegistration.*  from AnimalRegistration,  Animals, Pricing, Ancestors, colors,  Ancestrypercents, Awards where animals.AnimalRegistrationID = AnimalRegistration.AnimalRegistrationID and animals.id = Ancestrypercents.id and animals.ID = Pricing.ID and animals.ID = Awards.ID and animals.ID = Ancestors.ID and animals.ID = colors.ID and Animals.ID=" & ID
gender = "non-breeder"
rs.Open sql, conn, 3, 3
If rs.eof Then
rs.close	
sql = "select * from Ancestors where ID=" & ID
rs.Open sql, conn, 3, 3
If rs.eof then
Query =  "INSERT INTO Ancestors (ID)" 
Query =  Query & " Values (" &  ID & ")"
Conn.Execute(Query) 
End If 
rs.close	
sql = "select * from Pricing where ID=" & ID
rs.Open sql, conn, 3, 3
If rs.eof then
Query =  "INSERT INTO Pricing (ID)" 
Query =  Query & " Values (" &  ID & ")"
Conn.Execute(Query) 
End If 
rs.close	
sql = "select * from colors where ID=" & ID
rs.Open sql, conn, 3, 3
if rs.eof then
Query =  "INSERT INTO colors (ID)" 
Query =  Query & " Values (" &  ID & ")"
Conn.Execute(Query) 
End If 
rs.close	
sql = "select * from Ancestrypercents where ID=" & ID
rs.Open sql, conn, 3, 3
If rs.eof then
Query =  "INSERT INTO Ancestrypercents (ID)" 
Query =  Query & " Values (" &  ID & ")"
Conn.Execute(Query) 
End If 
rs.close
sql = "select Ancestors.*, Animals.*, Pricing.*, colors.*,  Ancestrypercents.*, Awards.*  from  Animals, Pricing, Ancestors, colors,  Ancestrypercents, Awards where animals.id = Ancestrypercents.id and animals.ID = Pricing.ID and animals.ID = Awards.ID and animals.ID = Ancestors.ID and animals.ID = colors.ID and Animals.ID=" & ID
gender = "non-breeder"
rs.Open sql, conn, 3, 3
End If 
Dim Description
Donor  = rs("Donor") 
EmbryoPrice  = rs("EmbryoPrice") 
SemenPrice  = rs("SemenPrice") 
SpeciesID   = rs("SpeciesID") 
Height = rs("Height") 
Weight = rs("Weight") 
Gaited= rs("Gaited")   
Temperment = rs("Temperment")
NumberofAnimals = rs("NumberofAnimals")
WarmBlooded = rs("WarmBlooded") 
BreedlookupID  = rs("BreedID") 
BreedlookupID2  = rs("BreedID2")
BreedlookupID3  = rs("BreedID3")  
BreedlookupID4  = rs("BreedID4") 
Description   = rs("Description") 
StudDescription   = rs("StudDescription") 
WhyOnABH   = rs("WhyOnABH") 
ShowOnABH = rs("ShowOnABH")
showonAC = rs("showonAC") 
showonASZ = rs("showonASZ")
showonAP = rs("showonAP") 
showonAIA = rs("showonAIA") 
showonAIA2 = rs("showonAIA2") 
ShowOnWebsite = rs("ShowOnWebsite")
ShowOnOurHerdPage= rs("ShowOnOurHerdPage")
if SpeciesID = 2 then
SpeciesName="Alpaca" 
end if 
if SpeciesID = 3 then
SpeciesName="Dog"
end if 
if SpeciesID = 4 then
SpeciesName="Llama"
end if 
if SpeciesID = 5 then
SpeciesName="Horse"
end if 
if SpeciesID = 6 then
SpeciesName="Goat"
end if 
if SpeciesID = 7 then
SpeciesName="Donkey"
end if 
if SpeciesID = 8 then
SpeciesName="Cattle"
end if 
if SpeciesID = 9 then
SpeciesName="Bison"
end if 
if SpeciesID = 10 then
SpeciesName="Sheep"
end if 
if SpeciesID = 11 then
SpeciesName="Rabbit"
end if 
if SpeciesID = 12 then
SpeciesName="Pig"
end if 
if  SpeciesID = 13 then
SpeciesName="Chicken"
end if 
if SpeciesID = 14 then
SpeciesName="Turkey"
end if 
if SpeciesID = 15 then
SpeciesName="Duck"
end if 
if  SpeciesID = 16 then
SpeciesName="Cat"
end if 
StudFee	= rs("StudFee")
SalePending = rs("SalePending")
Price = rs("Price")
Free= rs("Free")

StartingPrice = rs("StartingPrice")
if not rs.eof then 
name = trim(rs("FullName"))
Session("AnimalName")= Name
Price = rs("Price")
Free = rs("Free")
OBO = rs("OBO")
Foundation = rs("Foundation")
PayWhatYouCanAnimal = rs("PayWhatYouCanAnimal")
PayWhatYouCanStud = rs("PayWhatYouCanStud")
Discount = rs("Discount")
PriceComments = rs("PriceComments")
ForSale = rs("ForSale")
Sold = rs("Sold")
CoOwnerName1 = rs("CoOwnerName1")
CoOwnerLink1 = rs("CoOwnerLink1")
CoOwnerBusiness1 = rs("CoOwnerBusiness1")
CoOwnerName2 = rs("CoOwnerName2")
CoOwnerLink2 = rs("CoOwnerLink2")
CoOwnerBusiness2 = rs("CoOwnerBusiness2")
CoOwnerName3 = rs("CoOwnerName3")
CoOwnerLink3 = rs("CoOwnerLink3")
CoOwnerBusiness3= rs("CoOwnerBusiness3")
DOBMonth = rs("DOBMonth")
DOBDay = rs("DOBday")
DOBYear	= rs("DOBYear")
Color1 = rs("Color1") 
Color2 = rs("Color2") 
Color3 = rs("Color3") 
Color4 = rs("Color4") 
Color5 = rs("Color5") 
Category = rs("Category")
if DetailType = "Dam" then
DueDate	=rs("DueDate")
ExternalStudID	=rs("ExternalStudID")
ServiceSireID	=rs("ServiceSireID")
end if
if not(detailtype = "Other" Or detailtype = "other") then
CF = rs("CF")
Curve = rs("Curve")
AFDFiberDiameter = rs("Average")
StandardDeviation = rs("StandardDev")
CoefficientOfVariation = rs("COV")
FiberGreaterThan30 = rs("GreaterThan30")
SampleDate = rs("SampleDate")
end if
Dam	= rs("Dam")
DamColor = rs("DamColor")
DamLink = rs("DamLink")
DamARI = rs("DamARI")
DamCLAA = rs("DamCLAA")
DamDam = rs("DamDam")
DamDamColor = rs("DamDamColor")
DamDamLink = rs("DamDamLink")
DamDamARI = rs("DamDamARI")
DamDamCLAA = rs("DamDamCLAA")
DamDamDam = rs("DamDamDam")
DamDamDamColor = rs("DamDamDamColor")
DamDamDamLink = rs("DamDamDamLink")
DamDamDamARI = rs("DamDamDamARI")
DamDamDamCLAA = rs("DamDamDamCLAA")
DamDamSire = rs("DamDamSire")
DamDamSireColor = rs("DamDamSireColor")
DamDamSireLink = rs("DamDamSireLink")
DamDamSireARI = rs("DamDamSireARI")
DamDamSireCLAA = rs("DamDamSireCLAA")
DamSire = rs("DamSire")
DamSireColor = rs("DamSireColor")
DamSireLink = rs("DamSireLink")
DamSireARI = rs("DamSireARI")
DamSireCLAA	= rs("DamSireCLAA")
DamSireDam = rs("DamSireDam")
DamSireDamColor = rs("DamSireDamColor")
DamSireDamLink = rs("DamSireDamLink")
DamSireDamARI = rs("DamSireDamARI")
DamSireDamCLAA = rs("DamSireDamCLAA")
DamSireSire = rs("DamSireSire")
DamSireSireColor = rs("DamSireSireColor")
DamSireSireLink = rs("DamSireSireLink")
DamSireSireARI = rs("DamSireSireARI")
DamSireSireCLAA = rs("DamSireSireCLAA")
Sire = rs("Sire")
SireColor = rs("SireColor")
SireLink = rs("SireLink")
SireARI = rs("SireARI")
SireCLAA = rs("SireCLAA")
SireDam = rs("SireDam")
SireDamColor = rs("SireDamColor")
SireDamLink = rs("SireDamLink")
SireDamARI = rs("SireDamARI")
SireDamCLAA = rs("SireDamCLAA")
SireDamDam = rs("SireDamDam")
SireDamDamColor = rs("SireDamDamColor")
SireDamDamLink = rs("SireDamDamLink")
SireDamDamARI = rs("SireDamDamARI")
SireDamDamCLAA = rs("SireDamDamCLAA")
SireDamSire = rs("SireDamSire")
SireDamSireColor = rs("SireDamSireColor")
SireDamSireLink = rs("SireDamSireLink")
SireDamSireARI = rs("SireDamSireARI")
SireDamSireCLAA = rs("SireDamSireCLAA")
SireSire = rs("SireSire")
SireSireColor = rs("SireSireColor")
SireSireLink = rs("SireSireLink")
SireSireARI = rs("SireSireARI")
SireSireCLAA = rs("SireSireCLAA")
SireSireDam = rs("SireSireDam")
SireSireDamColor = rs("SireSireDamColor")
SireSireDamLink = rs("SireSireDamLink")
SireSireDamARI = rs("SireSireDamARI")
SireSireDamCLAA = rs("SireSireDamCLAA")
SireSireSire = rs("SireSireSire")
SireSireSireColor = rs("SireSireSireColor")
SireSireSireLink = rs("SireSireSireLink")
SireSireSireARI = rs("SireSireSireARI")
SireSireSireCLAA = rs("SireSireSireCLAA")
if DamLink= "0" or IsEmpty(DamLink) or len(DamLink) < 5 then
DamLinkDescription = "Not Available"
DamLink = "NoLink.asp"
else
DamLinkDescription = "Click Here"
end if 
if DamDamLink = "0"  or IsEmpty(DamDamLink) or len(DamDamLink) < 5then
DamDamLinkDescription = "Not Available"
DamDamLink  = "NoLink.asp"
else
DamDamLinkDescription = "Click Here"
end if 
if DamSireLink= "0" or IsEmpty(DamSireLink) or len(DamSireLink) < 5 then
DamSireLinkDescription = "Not Available"
DamSireLink = "NoLink.asp"
else
DamSireLinkDescription = "Click Here"
end if 
if SireLink= "0" or IsEmpty(SireLink) or len(SireLink) < 5 then
SireLinkDescription = "Not Available"
SireLink = "NoLink.asp"
else
SireLinkDescription = "Click Here"
end if 
if SiredamLink= "0" or IsEmpty(SiredamLink) or len(SiredamLink) < 5 then
SiredamLinkDescription = "Not Available"
SiredamLink = "NoLink.asp"
else
SiredamLinkDescription = "Click Here"
end if 
if SireSireLink= "0" or IsEmpty(SireSireLink) or len(SireSireLink) < 5 then
SireSireLinkDescription = "Not Available"
SireSireLink = "NoLink.asp"
else
SireSireLinkDescription = "Click Here"
end if 
if SireColor= "0" or IsEmpty(SireColor) or len(SireColor) < 2 then
SireColor ="Not Available"
end if
if SiredamColor= "0" or IsEmpty(SiredamColor) or len(SiredamColor) < 2 then
SiredamColor ="Not Available"
end if
if SireSireColor= "0" or IsEmpty(SireSireColor) or len(SireSireColor) < 2 then
SireSireColor ="Not Available"
end if
if DamColor= "0" or IsEmpty(DamColor) or len(DamColor) < 2 then
DamColor ="Not Available"
end if
if DamDamColor= "0" or IsEmpty(DamDamColor) or len(DamDamColor) < 2 then
DamDamColor ="Not Available"
end if
if DamSireColor= "0" or IsEmpty(DamSireColor) or len(DamSireColor) < 2 then
DamSireColor ="Not Available"
end If
end If
End if %>	