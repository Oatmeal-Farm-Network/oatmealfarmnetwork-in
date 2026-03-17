<% 
if len(ID) < 1 then
ID= Request.QueryString("ID") 
end if
If Len(ID) < 1 then
ID= Request.Form("ID") 
End If 
If Len(ID) < 1 then
ID= session("ID") 
End If 
Session("Animalid")= ID
DetailType= "Other"
Set rs = Server.CreateObject("ADODB.Recordset")
sql = "select * from SFCustomers"
rs.Open sql, conn, 3, 3
If Len(ID) > 0 then
rs.close
sql = "select * from Awards where ID=" & ID
rs.Open sql, conn, 3, 3
If rs.eof Or rs.recordcount < 21 then

counter = rs.recordcount
While counter < 21 
Query =  "INSERT INTO Awards (ID)" 
Query =  Query & " Values (" &  ID & ")"
Counter = counter + 1
Conn.Execute(Query) 
wend
End If 
rs.close
sql = "select Ancestors.*, Animals.*, Pricing.*, colors.*, Ancestrypercents.*, Awards.*  from Animals, Pricing, Ancestors, colors,  Ancestrypercents, Awards where animals.id = Ancestrypercents.id  and animals.ID = Pricing.ID and animals.ID = Awards.ID and animals.ID = Ancestors.ID and animals.ID = colors.ID and Animals.ID=" & ID
gender = "non-breeder"
rs.Open sql, conn, 3, 3
If rs.eof Then
rs.close
sql = "select * from Ancestors where ID=" & ID
rs.Open sql, conn, 3, 3
If rs.eof then
Query =  "INSERT INTO Ancestors (ID)" 
Query =  Query & " Values (" &  ID & ")"
DataConnection.Execute(Query) 
DataConnection.Close
End If 
rs.close
sql = "select * from Pricing where ID=" & ID
rs.Open sql, conn, 3, 3
If rs.eof then
Query =  "INSERT INTO Pricing (ID)" 
Query =  Query & " Values (" &  ID & ")"
DataConnection.Execute(Query) 
End If 
rs.close
sql = "select * from colors where ID=" & ID
rs.Open sql, conn, 3, 3
If rs.eof then
Query =  "INSERT INTO colors (ID)" 
Query =  Query & " Values (" &  ID & ")"
DataConnection.Execute(Query) 
End If 
rs.close
sql = "select * from Ancestrypercents where ID=" & ID
rs.Open sql, conn, 3, 3
If rs.eof then
Query =  "INSERT INTO Ancestrypercents (ID)" 
Query =  Query & " Values (" &  ID & ")"
DataConnection.Execute(Query) 
End If 
rs.close
sql = "select Ancestors.*, Animals.*, Pricing.*, colors.*,  Ancestrypercents.*, Awards.*  from animaldescriptions, Animals, Pricing, Ancestors, colors,  Ancestrypercents, Awards where animals.id = Ancestrypercents.id and animals.ID = Pricing.ID and animals.ID = Awards.ID and animals.ID = Ancestors.ID and animals.ID = AnimalDescriptions.ID and animals.ID = colors.ID and Animals.ID=" & ID
gender = "non-breeder"
rs.Open sql, conn, 3, 3
End If 
Description = rs("Description1") & rs("Description2")
StudFee = rs("StudFee")
Price = rs("Price")
if not rs.eof then 
name = trim(rs("animals.FullName"))
Session("AnimalName")= Name
Price = rs("Price")
Discount = rs("Discount")
PriceComments = rs("PriceComments")
ForSale = rs("ForSale")
Sold = rs("Sold")
DOBMonth = rs("DOBMonth")
DOBDay = rs("DOBday")
DOBYear = rs("DOBYear")
Color1 = rs("Color1") 
Color2 = rs("Color2") 
Color3 = rs("Color3") 
Color4   = rs("Color4") 
Color5   = rs("Color5") 
Category = rs("Category")
if DetailType = "Dam" then
DueDate=rs("DueDate")
ExternalStudID=rs("ExternalStudID")
ServiceSireID=rs("ServiceSireID")
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
Dam = rs("Dam")
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
DamSireCLAA= rs("DamSireCLAA")

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
DamLink = ""
else
DamLinkDescription = "Click Here"
end if 
if DamDamLink = "0"  or IsEmpty(DamDamLink) or len(DamDamLink) < 5then
 DamDamLinkDescription = "Not Available"
DamDamLink  = ""
else
DamDamLinkDescription = "Click Here"
end if 
if DamSireLink= "0" or IsEmpty(DamSireLink) or len(DamSireLink) < 5 then
 DamSireLinkDescription = "Not Available"
DamSireLink = ""
else
DamSireLinkDescription = "Click Here"
 end if 
 
 if SireLink= "0" or IsEmpty(SireLink) or len(SireLink) < 5 then
 SireLinkDescription = "Not Available"
SireLink = ""
else
SireLinkDescription = "Click Here"
 end if 

 if SiredamLink= "0" or IsEmpty(SiredamLink) or len(SiredamLink) < 5 then
 SiredamLinkDescription = "Not Available"
SiredamLink = ""
else
SiredamLinkDescription = "Click Here"
 end if 

 if SireSireLink= "0" or IsEmpty(SireSireLink) or len(SireSireLink) < 5 then
 SireSireLinkDescription = "Not Available"
SireSireLink = ""
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
End if
%>