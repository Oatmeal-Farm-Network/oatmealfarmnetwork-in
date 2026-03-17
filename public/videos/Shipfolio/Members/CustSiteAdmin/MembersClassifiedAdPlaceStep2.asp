<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html >
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="/administration/style.css">
<!--#Include file="AdminGlobalVariables.asp"-->
</HEAD>
<% if mobiledevice = True or is_iPad = true then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
<% end if 
AdminHome = True %>
<!--#Include file="AdminHeader.asp"--> 
<% conn.close
set conn = nothing  %>
<!--#Include virtual="/ConnLOA.asp"--> 
<%
Dim box2ID
Dim ProdYear
Dim ProdMake
Dim ProdModel
Dim ProdPrice
Dim ProdCondition
Dim ProdColor
Dim ProdQuantityAvailable
Dim ProdDescription
Dim PeopleID
Dim AdType
Dim ProdCity
Dim ProdPartOfTown
Dim ProdZip
Dim ProdWeight
Dim ProdProductID
PeopleID=session("PeopleID" ) 
AdType=Request.Form( "AdType" ) 
ProdWeight=Request.Form( "ProdWeight" ) 
ProductID=Request.Form("ProductID") 
prodCategory1ID=Session("Category1ID")
'response.write("prodCategory1ID=" & prodCategory1ID )

prodCategory2ID=Session("Category2ID") 
prodCategory3ID=Session("Category3ID")
prodSubCategory1ID = Session("SubCategory1ID") 
prodSubCategory2ID = Session("SubCategory2ID") 
prodSubCategory3ID = Session("SubCategory3ID")


response.write("prodCategory1ID = " & prodCategory1ID )
response.write("prodCategory2ID = " & prodCategory2ID )
response.write("prodCategory3ID = " & prodCategory3ID )

response.write("prodSubCategory1ID = " & prodSubCategory1ID )
response.write("prodSubCategory2ID = " & prodSubCategory2ID )
response.write("prodSubCategory3ID = " & prodSubCategory3ID)


	box2ID=Request.Form("box2ID" ) 
	'response.write("box2ID=")
	'response.write(box2ID)
	If Len(box2ID) > 0 Then
	else
box2ID=0
	End If
variables = ""	


ProdProductID=trim(request.form("SKU")) 
prodStateTaxIsActive=Request.Form("prodStateTaxIsActive") 
response.write("prodStateTaxIsActive=" & prodStateTaxIsActive )
if len(prodStateTaxIsActive)> 0 then
else
prodStateTaxIsActive = 0
end if

variables = variables & "&prodStateTaxIsActive=" & prodStateTaxIsActive

ProdAnimalID=Request.Form("ProdAnimalID") 
prodStandardShipUs=Request.Form("prodStandardShipUs") 
prodStandardShipUsDays=Request.Form("prodStandardShipUsDays") 
prodStandardShipAnother=Request.Form("prodStandardShipAnother") 
prodStandardShipInternational=Request.Form("prodStandardShipInternational") 
prodStandardShipInternationalAnother=Request.Form("prodStandardShipInternationalAnother") 
prodStandardShpInternationalTimeNote=Request.Form("prodStandardShpInternationalTimeNote") 
prodExpeditedShipUs=Request.Form("prodExpeditedShipUs") 
prodExpeditedShipUsDays=Request.Form("prodExpeditedShipUsDays") 
prodExpeditedShipAnother=Request.Form("prodExpeditedShipAnother") 
prodExpeditedShipInternational=Request.Form("prodExpeditedShipInternational") 
prodExpeditedShipInternationalAnother=Request.Form("prodExpeditedShipInternationalAnother") 
prodExpeditedShpInternationalTimeNote=Request.Form("prodExpeditedShpInternationalTimeNote") 

ProdCustomOrder=trim(request.form("ProdCustomOrder")) 
if len(ProdCustomOrder) > 1 then
variables = variables & "&ProdCustomOrder=" & ProdCustomOrder
end if
ProdName=trim(request.form("ProdName")) 
if len(ProdName) > 1 then
variables = variables & "&ProdName=" & ProdName
end if
ProductID=trim(request.form("ProductID")) 
if len(ProductID) > 1 then
variables = variables & "&ProductID=" & ProductID
end if
ProdPrice =trim(request.form("ProdPrice"))
if len(ProductID) > 1 then
variables = variables & "&ProdPrice=" & ProductID
end if
SalePrice = trim(request.Form("SalePrice"))
if len(SalePrice) > 1 then
variables = variables & "&SalePrice=" & SalePrice
end if
ProdQuantityAvailable=trim(request.form("ProdQuantityAvailable"))
if len(ProdQuantityAvailable) > 1 then
variables = variables & "&ProdQuantityAvailable=" & ProdQuantityAvailable
end if
ProdForSale =request.form("ProdForSale")
if len(ProdForSale) > 1 then
variables = variables & "&ProdForSale=" & ProdForSale
end if
ProdDescription =trim(request.form("ProdDescription"))
if len(ProdDescription) > 5 then
variables = variables & "&ProdDescription=" & ProdDescription
end if
ProdSellStore =trim(request.form("ProdSellStore"))
if len(ProdSellStore) > 1 then
variables = variables & "&ProdSellStore=" & ProdSellStore
end if
Prodsize1 =trim(request.form("Prodsize1"))
if len(Prodsize1) > 1 then
variables = variables & "&Prodsize1=" & Prodsize1
end if
Prodsize2 =trim(request.form("Prodsize2"))
if len(Prodsize2) > 1 then
variables = variables & "&Prodsize2=" & Prodsize2
end if
Prodsize3 =trim(request.form("Prodsize3"))
if len(Prodsize3) > 1 then
variables = variables & "&Prodsize3=" & Prodsize3
end if
Prodsize4 =trim(request.form("Prodsize4"))
if len(Prodsize4) > 1 then
variables = variables & "&Prodsize4=" & Prodsize4
end if
Prodsize5 =trim(request.form("Prodsize5"))
if len(Prodsize5) > 1 then
variables = variables & "&Prodsize5=" & Prodsize5
end if
Prodsize6=trim(request.form("Prodsize6"))
if len(Prodsize6) > 1 then
variables = variables & "&Prodsize6=" & Prodsize6
end if
Prodsize7 =trim(request.form("Prodsize7"))
if len(Prodsize7) > 1 then
variables = variables & "&Prodsize7=" & Prodsize7
end if
Prodsize8 =trim(request.form("Prodsize8"))
if len(Prodsize8) > 1 then
variables = variables & "&Prodsize8=" & Prodsize8
end if
Prodsize9 =trim(request.form("Prodsize9"))
if len(Prodsize9) > 1 then
variables = variables & "&Prodsize9=" & Prodsize9
end if
Prodsize10 =trim(request.form("Prodsize10"))
if len(Prodsize10) > 1 then
variables = variables & "&Prodsize10=" & Prodsize10
end if

ExtraCost1 =trim(request.form("ExtraCost1"))
if len(ExtraCost1) > 1 then
variables = variables & "&ExtraCost1=" & ExtraCost1
end if
ExtraCost2 =trim(request.form("ExtraCost2"))
if len(ExtraCost2) > 1 then
variables = variables & "&ExtraCost2=" & ExtraCost2
end if
ExtraCost3 =trim(request.form("ExtraCost3"))
if len(ExtraCost3) > 1 then
variables = variables & "&ExtraCost3=" & ExtraCost3
end if
ExtraCost4 =trim(request.form("ExtraCost4"))
if len(ExtraCost4) > 1 then
variables = variables & "&ExtraCost4=" & ExtraCost4
end if
ExtraCost5 =trim(request.form("ExtraCost5"))
if len(ExtraCost5) > 1 then
variables = variables & "&ExtraCost5=" & ExtraCost5
end if
ExtraCost6=trim(request.form("ExtraCost6"))
if len(ExtraCost6) > 1 then
variables = variables & "&ExtraCost6=" & ExtraCost6
end if
ExtraCost7 =trim(request.form("ExtraCost7"))
if len(ExtraCost7) > 1 then
variables = variables & "&ExtraCost7=" & ExtraCost7
end if
ExtraCost8 =trim(request.form("ExtraCost8"))
if len(ExtraCost8) > 1 then
variables = variables & "&ExtraCost8=" & ExtraCost8
end if
ExtraCost9 =trim(request.form("ExtraCost9"))
if len(ExtraCost9) > 1 then
variables = variables & "&ExtraCost9=" & ExtraCost9
end if
ExtraCost10 =trim(request.form("ExtraCost10"))
if len(ExtraCost10) > 1 then
variables = variables & "&ExtraCost10=" & ExtraCost10
end if

Shipping=trim(request.form("Shipping"))
if len(Shipping) > 1 then
variables = variables & "&Shipping=" & Shipping
end if
ShippingAnother=trim(request.form("ShippingAnother"))
if len(ShippingAnother) > 1 then
variables = variables & "&ShippingAnother=" & ShippingAnother
end if
ShippingInternational=trim(request.form("ShippingInternational"))
if len(ShippingInternational) > 1 then
variables = variables & "&ShippingInternational=" & ShippingInternational
end if
ShippingInternationalAnother=trim(request.form("ShippingInternationalAnother"))
if len(ShippingInternationalAnother) > 1 then
variables = variables & "&ShippingInternationalAnother=" & ShippingInternationalAnother
end if
	
	
    
ProdMadeIn=trim(Request.Form( "ProdMadeIn"))
if len(ProdMadeIn) > 1 then
variables = variables & "&ProdMadeIn=" & ProdMadeIn
end if


Missing = "?Missing=True"

ProdDimensions =request.form("ProdDimensions")
'if len(Category1ID) > 1 then
'else
'    if len(Category2ID) > 1 then
'     Category1ID = Category2ID
'     Category2ID = ""
'     else
'         if len(Category3ID) > 1 then
'            Category1ID = Category3ID
'            Category2ID = ""
'            Category3ID = ""
'     end if
'    end if
'end if 


'if len(session("Category1ID")) > 1 then
'else
'  Missing = Missing & "&Missingcategory=True"
'end if
if len(ProdCategory1ID) > 1 then
	variables = variables & "&Category1ID=" & ProdCategory1ID
end if
if len(ProdCategory2ID) > 1 then
	variables = variables & "&Category2ID=" & ProdCategory2ID
end if
if len(ProdCategory3ID) > 1 then
	variables = variables & "&Category3ID=" & ProdCategory3ID
end if
if len(ProdSubCategory1ID) > 1 then
	variables = variables & "&SubCategory1ID=" & ProdSubCategory1ID
end if
if len(ProdSubCategory2ID) > 1 then
	variables = variables & "&SubCategory2ID=" & ProdSubCategory2ID
    end if
if len(ProdSubCategory3ID) > 1 then
	variables = variables & "&SubCategory3ID=" & ProdSubCategory3ID
end if
	
if len(ProdSubCategory3ID) > 1 then
	variables = variables & "&SKU=" & ProdProductID
end if

   ' ProdSubCategory1ID = Session("SubCategory1ID") 

if len(ProdSubCategory1ID) > 1 then
else
    Missing = Missing & "&MissingSubCategory=True"
 end if
 
 str1 = ProdName
str2 = """"
If InStr(str1,str2) > 0 Then
	ProdName= Replace(str1,  str2, "''")
End If 	
if len(ProdName) > 1 then
else
    Missing = Missing & "&MissingProdName=True"
 end if
 


 str1 = prodProductID
str2 = "'"
If InStr(str1,str2) > 0 Then
prodProductID= Replace(str1, "'", "''")
End If


str1 = ProductID
str2 = "'"
If InStr(str1,str2) > 0 Then
ProductID= Replace(str1, "'", "''")
End If


str1 = ProdMadeIn
str2 = "'"
If InStr(str1,str2) > 0 Then
	ProdMadeIn= Replace(str1, "'", "''")
End If


str1 = ProdDimensions
str2 = "'"
If InStr(str1,str2) > 0 Then
	ProdDimensions= Replace(str1, "'", "''")
End If

str1 = ProdSize1
str2 = "'"
If InStr(str1,str2) > 0 Then
	ProdSize1= Replace(str1, "'", "''")
End If


str1 = ProdSize2
str2 = "'"
If InStr(str1,str2) > 0 Then
	ProdSize2= Replace(str1, "'", "''")
End If

str1 = ProdSize3
str2 = "'"
If InStr(str1,str2) > 0 Then
	ProdSize3= Replace(str1, "'", "''")
End If


str1 = ProdSize4
str2 = "'"
If InStr(str1,str2) > 0 Then
	ProdSize4= Replace(str1, "'", "''")
End If

str1 = ProdSize5
str2 = "'"
If InStr(str1,str2) > 0 Then
	ProdSize5= Replace(str1, "'", "''")
End If


str1 = ProdSize6
str2 = "'"
If InStr(str1,str2) > 0 Then
	ProdSize6= Replace(str1, "'", "''")
End If


str1 = ProdSize7
str2 = "'"
If InStr(str1,str2) > 0 Then
	ProdSize7= Replace(str1, "'", "''")
End If

str1 = ProdSize8
str2 = "'"
If InStr(str1,str2) > 0 Then
	ProdSize8= Replace(str1, "'", "''")
End If


str1 = ProdSize9
str2 = "'"
If InStr(str1,str2) > 0 Then
	ProdSize9= Replace(str1, "'", "''")
End If

str1 = ProdSize10
str2 = "'"
If InStr(str1,str2) > 0 Then
	ProdSize10= Replace(str1, "'", "''")
End If


str1 = Color1
str2 = "'"
If InStr(str1,str2) > 0 Then
	Color1= Replace(str1, "'", "''")
End If

str1 = Color2
str2 = "'"
If InStr(str1,str2) > 0 Then
	Color2= Replace(str1, "'", "''")
End If

str1 = Color3
str2 = "'"
If InStr(str1,str2) > 0 Then
	Color3= Replace(str1, "'", "''")
End If

str1 = Color4
str2 = "'"
If InStr(str1,str2) > 0 Then
	Color4= Replace(str1, "'", "''")
End If

str1 = Color5
str2 = "'"
If InStr(str1,str2) > 0 Then
	Color5= Replace(str1, "'", "''")
End If

str1 = Color6
str2 = "'"
If InStr(str1,str2) > 0 Then
	Color6= Replace(str1, "'", "''")
End If

str1 = Color7
str2 = "'"
If InStr(str1,str2) > 0 Then
	Color7= Replace(str1, "'", "''")
End If

str1 = Color8
str2 = "'"
If InStr(str1,str2) > 0 Then
	Color8= Replace(str1, "'", "''")
End If

str1 = Color9
str2 = "'"
If InStr(str1,str2) > 0 Then
	Color9= Replace(str1, "'", "''")
End If

str1 = Color10
str2 = "'"
If InStr(str1,str2) > 0 Then
	Color10= Replace(str1, "'", "''")
End If

str1 = Color11
str2 = "'"
If InStr(str1,str2) > 0 Then
	Color11= Replace(str1, "'", "''")
End If

str1 = Color12
str2 = "'"
If InStr(str1,str2) > 0 Then
	Color12= Replace(str1, "'", "''")
End If

str1 = Color13
str2 = "'"
If InStr(str1,str2) > 0 Then
	Color13= Replace(str1, "'", "''")
End If

str1 = Color14
str2 = "'"
If InStr(str1,str2) > 0 Then
	Color14= Replace(str1, "'", "''")
End If

str1 = Color15
str2 = "'"
If InStr(str1,str2) > 0 Then
	Color15= Replace(str1, "'", "''")
End if

str1 = Color16
str2 = "'"
If InStr(str1,str2) > 0 Then
	Color16= Replace(str1, "'", "''")
End If

str1 = Color17
str2 = "'"
If InStr(str1,str2) > 0 Then
	Color17= Replace(str1, "'", "''")
End If

str1 = Color18
str2 = "'"
If InStr(str1,str2) > 0 Then
	Color18= Replace(str1, "'", "''")
End If

str1 = Color19
str2 = "'"
If InStr(str1,str2) > 0 Then
	Color19= Replace(str1, "'", "''")
End If

str1 = Color20
str2 = "'"
If InStr(str1,str2) > 0 Then
	Color20= Replace(str1, "'", "''")
End If

str1 = Color21
str2 = "'"
If InStr(str1,str2) > 0 Then
	Color21= Replace(str1, "'", "''")
End If

str1 = Color22
str2 = "'"
If InStr(str1,str2) > 0 Then
	Color22= Replace(str1, "'", "''")
End If


str1 = Color23
str2 = "'"
If InStr(str1,str2) > 0 Then
	Color23= Replace(str1, "'", "''")
End If


str1 = Color24
str2 = "'"
If InStr(str1,str2) > 0 Then
	Color24= Replace(str1, "'", "''")
End If

str1 = Color25
str2 = "'"
If InStr(str1,str2) > 0 Then
	Color25= Replace(str1, "'", "''")
End If

str1 = Color26
str2 = "'"
If InStr(str1,str2) > 0 Then
	Color26= Replace(str1, "'", "''")
End If

str1 = Color27
str2 = "'"
If InStr(str1,str2) > 0 Then
	Color27= Replace(str1, "'", "''")
End If

str1 = Color28
str2 = "'"
If InStr(str1,str2) > 0 Then
	Color28= Replace(str1, "'", "''")
End If

str1 = Color29
str2 = "'"
If InStr(str1,str2) > 0 Then
	Color29= Replace(str1, "'", "''")
End If

str1 = Color30
str2 = "'"
If InStr(str1,str2) > 0 Then
	Color30= Replace(str1, "'", "''")
End If

str1 = Color31
str2 = "'"
If InStr(str1,str2) > 0 Then
	Color31= Replace(str1, "'", "''")
End If

str1 = Color32
str2 = "'"
If InStr(str1,str2) > 0 Then
	Color32= Replace(str1, "'", "''")
End If

str1 = Color33
str2 = "'"
If InStr(str1,str2) > 0 Then
	Color33= Replace(str1, "'", "''")
End If

str1 = Color34
str2 = "'"
If InStr(str1,str2) > 0 Then
	Color34= Replace(str1, "'", "''")
End If

str1 = Color35
str2 = "'"
If InStr(str1,str2) > 0 Then
	Color35= Replace(str1, "'", "''")
End If

str1 = Color36
str2 = "'"
If InStr(str1,str2) > 0 Then
	Color36= Replace(str1, "'", "''")
End If

str1 = Color37
str2 = "'"
If InStr(str1,str2) > 0 Then
	Color37= Replace(str1, "'", "''")
End If

str1 = Color38
str2 = "'"
If InStr(str1,str2) > 0 Then
	Color38= Replace(str1, "'", "''")
End If

str1 = Color39
str2 = "'"
If InStr(str1,str2) > 0 Then
	Color39= Replace(str1, "'", "''")
End If

str1 = Color40
str2 = "'"
If InStr(str1,str2) > 0 Then
	Color40= Replace(str1, "'", "''")
End If

str1 = Color41
str2 = "'"
If InStr(str1,str2) > 0 Then
	Color41= Replace(str1, "'", "''")
End If

str1 = Color42
str2 = "'"
If InStr(str1,str2) > 0 Then
	Color42= Replace(str1, "'", "''")
End If

str1 = Color43
str2 = "'"
If InStr(str1,str2) > 0 Then
	Color43= Replace(str1, "'", "''")
End If

str1 = Color44
str2 = "'"
If InStr(str1,str2) > 0 Then
	Color44= Replace(str1, "'", "''")
End If

str1 = Color45
str2 = "'"
If InStr(str1,str2) > 0 Then
	Color45= Replace(str1, "'", "''")
End If

str1 = Color46
str2 = "'"
If InStr(str1,str2) > 0 Then
	Color46= Replace(str1, "'", "''")
End If

str1 = Color47
str2 = "'"
If InStr(str1,str2) > 0 Then
	Color47= Replace(str1, "'", "''")
End If

str1 = Color48
str2 = "'"
If InStr(str1,str2) > 0 Then
	Color48= Replace(str1, "'", "''")
End If

str1 = Color49
str2 = "'"
If InStr(str1,str2) > 0 Then
	Color49= Replace(str1, "'", "''")
End If

str1 = Color50
str2 = "'"
If InStr(str1,str2) > 0 Then
	Color50= Replace(str1, "'", "''")
End If

str1 = Color51
str2 = "'"
If InStr(str1,str2) > 0 Then
	Color51= Replace(str1, "'", "''")
End If

str1 = Color52
str2 = "'"
If InStr(str1,str2) > 0 Then
	Color52= Replace(str1, "'", "''")
End If

str1 = Color53
str2 = "'"
If InStr(str1,str2) > 0 Then
	Color53= Replace(str1, "'", "''")
End If

str1 = Color54
str2 = "'"
If InStr(str1,str2) > 0 Then
	Color54= Replace(str1, "'", "''")
End If

str1 = Color55
str2 = "'"
If InStr(str1,str2) > 0 Then
	Color55= Replace(str1, "'", "''")
End If

str1 = Color56
str2 = "'"
If InStr(str1,str2) > 0 Then
	Color56= Replace(str1, "'", "''")
End If
str1 = Color57
str2 = "'"
If InStr(str1,str2) > 0 Then
	Color57= Replace(str1, "'", "''")
End If
str1 = Color58
str2 = "'"
If InStr(str1,str2) > 0 Then
	Color58= Replace(str1, "'", "''")
End If

str1 = Color59
str2 = "'"
If InStr(str1,str2) > 0 Then
	Color59= Replace(str1, "'", "''")
End If

str1 = Color60
str2 = "'"
If InStr(str1,str2) > 0 Then
	Color60= Replace(str1, "'", "''")
End If

str1 = Color61
str2 = "'"
If InStr(str1,str2) > 0 Then
	Color61= Replace(str1, "'", "''")
End If

str1 = Color62
str2 = "'"
If InStr(str1,str2) > 0 Then
	Color62= Replace(str1, "'", "''")
End If

str1 = Color63
str2 = "'"
If InStr(str1,str2) > 0 Then
	Color63= Replace(str1, "'", "''")
End If

str1 = Color64
str2 = "'"
If InStr(str1,str2) > 0 Then
	Color64= Replace(str1, "'", "''")
End If

str1 = Color65
str2 = "'"
If InStr(str1,str2) > 0 Then
	Color65= Replace(str1, "'", "''")
End If

str1 = Color66
str2 = "'"
If InStr(str1,str2) > 0 Then
	Color66= Replace(str1, "'", "''")
End If

str1 = Color67
str2 = "'"
If InStr(str1,str2) > 0 Then
	Color67= Replace(str1, "'", "''")
End If

str1 = Color68
str2 = "'"
If InStr(str1,str2) > 0 Then
	Color68= Replace(str1, "'", "''")
End If

str1 = Color69
str2 = "'"
If InStr(str1,str2) > 0 Then
	Color69= Replace(str1, "'", "''")
End If

str1 = Color70
str2 = "'"
If InStr(str1,str2) > 0 Then
	Color70= Replace(str1, "'", "''")
End If

str1 = Color71
str2 = "'"
If InStr(str1,str2) > 0 Then
	Color71= Replace(str1, "'", "''")
End If

str1 = Color72
str2 = "'"
If InStr(str1,str2) > 0 Then
	Color72= Replace(str1, "'", "''")
End If

str1 = Color73
str2 = "'"
If InStr(str1,str2) > 0 Then
	Color73= Replace(str1, "'", "''")
End If

str1 = Color74
str2 = "'"
If InStr(str1,str2) > 0 Then
	Color74= Replace(str1, "'", "''")
End If

str1 = Color75
str2 = "'"
If InStr(str1,str2) > 0 Then
	Color75= Replace(str1, "'", "''")
End If

str1 = ProdName
str2 = "'"
If InStr(str1,str2) > 0 Then
	ProdName= Replace(str1, "'", "''")
End If

str1 = ProdState
str2 = "'"
If InStr(str1,str2) > 0 Then
	ProdState= Replace(str1, "'", "''")
End If

str1 = ProdPrice
str2 = "'"
If InStr(str1,str2) > 0 Then
	ProdPrice= Replace(str1, "'", "''")
End If


str1 = SalePrice
str2 = "'"
If InStr(str1,str2) > 0 Then
	SalePrice= Replace(str1, "'", "''")
End If

If len(ProdQuantityAvailable) = 0 then
	ProdQuantityAvailable = "1"
End If

str1 = ProdQuantityAvailable
str2 = "'"
If InStr(str1,str2) > 0 Then
	ProdQuantityAvailable= Replace(str1, "'", "''")
End If

str1 = ProdDescription
str2 = "'"
If InStr(str1,str2) > 0 Then
	ProdDescription= Replace(str1, "'", "''")
End If

str1 = ProdYear
str2 = "'"
If InStr(str1,str2) > 0 Then
	ProdYear= Replace(str1, "'", "''")
End If

If len(ProdYear) = 0 then
	ProdYear = "0"
End If


str1 = ProdMake
str2 = "'"
If InStr(str1,str2) > 0 Then
	ProdMake= Replace(str1, "'", "''")
End If

If len(ProdMake) = 0 then
	ProdMake = "0"
End If

str1 = ProdModel
str2 = "'"
If InStr(str1,str2) > 0 Then
	ProdModel= Replace(str1, "'", "''")
End If

If len(ProdModel) = 0 then
	ProdModel = "0"
End If

str1 = ProdCondition
str2 = "'"
If InStr(str1,str2) > 0 Then
	ProdCondition= Replace(str1, "'", "''")
End If

If len(ProdCondition) = 0 then
	ProdCondition = "0"
End If

str1 = ProdColor
str2 = "'"
If InStr(str1,str2) > 0 Then
	ProdColor= Replace(str1, "'", "''")
End If

If len(ProdColor) = 0 then
	ProdColor = "0"
End If

	
str1 = ProdCity 
str2 = "'"
If InStr(str1,str2) > 0 Then
	ProdCity = Replace(str1, "'", "''")
End If

If len(ProdCity ) = 0 then
	ProdCity  = "0"
End If


str1 = ProdPartOfTown
str2 = "'"
If InStr(str1,str2) > 0 Then
	ProdPartOfTown = Replace(str1, "'", "''")
End If

If len(ProdPartOfTown) = 0 then
	ProdPartOfTown  = "0"
End If


str1 = ProdFiberType1 
str2 = "'"
If InStr(str1,str2) > 0 Then
	ProdFiberType1 = Replace(str1, "'", "''")
End If

str1 = ProdFiberType2 
str2 = "'"
If InStr(str1,str2) > 0 Then
	ProdFiberType2 = Replace(str1, "'", "''")
End If

str1 = ProdFiberType3 
str2 = "'"
If InStr(str1,str2) > 0 Then
	ProdFiberType3 = Replace(str1, "'", "''")
End If

str1 = ProdFiberType4 
str2 = "'"
If InStr(str1,str2) > 0 Then
	ProdFiberType4 = Replace(str1, "'", "''")
End If

str1 = ProdFiberType5 
str2 = "'"
If InStr(str1,str2) > 0 Then
	ProdFiberType5 = Replace(str1, "'", "''")
End If

str1 = ProdZip 
str2 = "'"
If InStr(str1,str2) > 0 Then
	ProdZip = Replace(str1, "'", "''")
End If

If len(ProdZip) = 0 then
	ProdZip  = "0"
End If

Session("Step2") = false
If 	Session("Step2") = false then
	
	ProdNameFound = False

if len(prodPrice) < 1 then
 prodPrice = 0
end if
sql2 = "select * from sfProducts where ProdName = '" & ProdName & "' and peopleid=" & session("AIID") & " order by ProdID"
response.write(sql2)
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, connloa, 3, 3 
If  Not rs2.eof then
ProdNameFound = True
prodID = rs2("ProdID")
session("ID") = rs2("ProdID")
session("ProdID") = rs2("ProdID")
	
	End if
rs2.close


if ProdNameFound = True then
 response.Redirect("membersClassifiedAdPlace.asp" & Missing & "&ProdNameFound=true" & variables)
end if
 if len(Missing) > 13 then
 response.Redirect("membersClassifiedAdPlace.asp" & Missing & variables)
end if

	

	If ProdNameFound = False then
	sql2 = "select ProdID from sfProducts  order by ProdID desc"

'response.write(sql2)
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, connloa, 3, 3 
	If Not rs2.eof then
lastProdID = rs2("ProdID")
ProdID = lastProdID  + 1
session("ID") = ProdID
session("ProdID") = ProdID
rs2.close
   End If 

If prodid > 0 Then
Else
	ProdID = 1
session("ID") = ProdID
session("ProdID") = ProdID
End If

sql2 = "select * from sfProducts where prodID  = " & ProdID & ""

	response.write(sql2)
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, connloa, 3, 3 
If Not rs2.eof Then
    notfound=true
While notfound=true
sql2 = "select * from sfProducts where ProdID  = " & ProdID & ""

	'response.write(sql2)
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, connloa, 3, 3 
	If Not rs2.eof Then
ProdID = ProdID+ 1
notfound=True
	Else
	    notfound=false
	End If
	rs2.close
wend	
End If

	
	
If Len(ProdForSale) > 1 Then
Else
ProdForSale = 0
End if



	sql2 = "select * from sfProducts  where  ProdName = '" & ProdName & "';"

response.write(sql2)
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, connloa, 3, 3 
	
 session("ID") = ProdID
  session("ProdID") = ProdID
Query =  "INSERT INTO SFProducts ( PeopleID, ProductID, prodProductID, ProdName, ProdMadeIn, ProdCustomOrder ,  ProdQuantityAvailable , "



if len(ProdAnimalID) > 0 then 	
Query =  Query & " ProdAnimalID,"
end if

if len(prodCategoryId) > 0 then 	
Query =  Query & " prodCategoryId,"
end if

if len(prodSubCategoryId) > 0 then 	
Query =  Query & " prodSubCategoryId,"
end if


if len(ProdPrice) > 0 then
Query =  Query & "  ProdPrice, "
end if

if len(SalePrice) > 0 then
Query =  Query & "  SalePrice,  "
end if
if len(ProdWeight) > 0 then
Query =  Query & " ProdWeight ," 
end if

Query =  Query & " ProdDescription, ProdForSale) "


Query =  Query & " Values (" &  session("AIID") & "," 
Query =  Query & " '" &  ProductID & "'," 
Query =  Query & " '" &  prodProductID & "'," 
Query =  Query & " '" &  ProdName & "',"
Query =  Query & " '" &  ProdMadeIn & "',"	
if len(ProdCustomOrder) > 1 then
Query =  Query & " " &  ProdCustomOrder & ","
else
Query =  Query & " 0,"
end if

Query =  Query & " " & ProdQuantityAvailable & "," 


if len(ProdAnimalID) > 0 then 	
Query =  Query & " " & ProdAnimalID & "," 
end if

if len(prodCategoryId) > 0 then 	
Query =  Query & " " & prodCategoryId & "," 
end if

if len(prodsubCategoryId) > 0 then
Query =  Query & " " & prodsubCategoryId & ","  	
end if



if len(ProdPrice) > 0 then
Query = Query & " "  &  ProdPrice & "," 
end if
if len(SalePrice) > 0 then
Query = Query & " "  &  SalePrice & "," 
end if
if len(ProdWeight) > 0 then
Query =  Query & " "  & ProdWeight & "," 
end if
Query =  Query & " '" &  ProdDescription & "'," 
Query =  Query & " "  & ProdForSale & ")"
response.write("Query=" & Query )
connloa.Execute(Query) 



Query =  "INSERT INTO ProductsPhotos (ID)" 
Query =  Query & " Values (" &  prodID & ")"

connloa.Execute(Query) 

if len(session("Category3ID")) > 0 and len(session("SubCategory3ID")) > 0 then
Query =  " Insert into productCategoriesList (ProductID, prodCategoryId, prodSubCategoryId)"
Query =  Query & " Values ('" &  ProdID  & "'," & session("Category3ID") & "," & session("SubCategory3ID") & ")"
connloa.Execute(Query) 
end if 

if len(session("Category2ID")) > 0 and session("SubCategory2ID") > 0 then
Query =  " Insert into productCategoriesList (ProductID, prodCategoryId, prodSubCategoryId)"
Query =  Query & " Values (" &  ProdID  & "," & session("Category2ID") & "," & session("SubCategory2ID") & ")"
connloa.Execute(Query) 
end if 

if len(session("Category1ID")) > 0 then
Query =  " Insert into productCategoriesList (ProductID, prodCategoryId, prodSubCategoryId)"
Query =  Query & " Values ('" &  ProdID  & "'," & session("Category1ID") & "," & session("SubCategory1ID") & ")"
connloa.Execute(Query) 
end if 
  

  


End if

End if
sql2 = "select * from sfProducts where ProdName = '" & ProdName & "'  order by ProdID"
response.write(sql2)
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, connloa, 3, 3 
	if  Not rs2.eof then
prodID = rs2("ProdID")
session("ID") = rs2("ProdID")
session("ProdID") = rs2("ProdID")
	
	End if
rs2.close

connloa.close

response.Redirect("membersAdEdit2.asp?prodId=" & prodID & "&prodCategory1ID=" & prodCategory1ID & "&prodCategory2ID=" & prodCategory2ID & "&prodCategory3ID=" & prodCategory3ID & "&prodSubCategory1ID=" &  prodSubCategory1ID & "&prodSubCategory2ID=" & prodSubCategory2ID & "&prodSubCategory3ID=" & prodSubCategory3ID )
%>
</Body>
</HTML>
