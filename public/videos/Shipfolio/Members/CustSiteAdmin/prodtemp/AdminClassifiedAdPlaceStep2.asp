<!doctype html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta http-equiv="Content-Language" content="en-us">
<title>The ANDRESEN GROUP Content Management System (AGCMS)</title>
<meta name="author" content="The Andresen Group">
<link rel="stylesheet" type="text/css" href="style.css">
<HTML>
<HEAD>
 <title>Hera Content Management System - Presented by The Andresen Group</title>
<link rel="stylesheet" type="text/css" href="style.css">	  
</HEAD>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center">
<!--#Include file="AdminGlobalVariables.asp"-->
<% Current2="AdminHome" %> 
<!--#Include file="adminHeader.asp"-->
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

PeopleID=session("PeopleID" ) 
AdType=Request.Form( "AdType" ) 
ProdWeight=Request.Form( "ProdWeight" ) 

prodCategory1ID=Session("Category1ID")
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


ProductID=trim(request.form("ProductID")) 
variables = variables & "&ProductID=" & ProductID
prodStateTaxIsActive=Request.Form("prodStateTaxIsActive") 
variables = variables & "&prodStateTaxIsActive=" & prodStateTaxIsActive
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

ProdName=trim(request.form("ProdName")) 
variables = variables & "&ProdName=" & ProdName
ProdPrice =trim(request.form("ProdPrice"))
variables = variables & "&ProdPrice=" & ProdPrice
SalePrice = trim(request.Form("SalePrice"))
variables = variables & "&SalePrice=" & SalePrice
ProdQuantityAvailable=trim(request.form("ProdQuantityAvailable"))
variables = variables & "&ProdQuantityAvailable=" & ProdQuantityAvailable
ProdForSale =request.form("ProdForSale")
variables = variables & "&ProdForSale=" & ProdForSale
ProdDescription   =trim(request.form("ProdDescription"))
variables = variables & "&ProdDescription=" & ProdDescription
ProdSellStore =trim(request.form("ProdSellStore"))
variables = variables & "&ProdSellStore=" & ProdSellStore
Prodsize1 =trim(request.form("Prodsize1"))
variables = variables & "&Prodsize1=" & Prodsize1
Prodsize2 =trim(request.form("Prodsize2"))
variables = variables & "&Prodsize2=" & Prodsize2
Prodsize3 =trim(request.form("Prodsize3"))
variables = variables & "&Prodsize3=" & Prodsize3
Prodsize4 =trim(request.form("Prodsize4"))
variables = variables & "&Prodsize4=" & Prodsize4
Prodsize5 =trim(request.form("Prodsize5"))
variables = variables & "&Prodsize5=" & Prodsize5
Prodsize6=trim(request.form("Prodsize6"))
variables = variables & "&Prodsize6=" & Prodsize6
Prodsize7 =trim(request.form("Prodsize7"))
variables = variables & "&Prodsize7=" & Prodsize7
Prodsize8 =trim(request.form("Prodsize8"))
variables = variables & "&Prodsize8=" & Prodsize8
Prodsize9 =trim(request.form("Prodsize9"))
variables = variables & "&Prodsize9=" & Prodsize9
Prodsize10 =trim(request.form("Prodsize10"))
variables = variables & "&Prodsize10=" & Prodsize10

ExtraCost1 =trim(request.form("ExtraCost1"))
variables = variables & "&ExtraCost1=" & ExtraCost1
ExtraCost2 =trim(request.form("ExtraCost2"))
variables = variables & "&ExtraCost2=" & ExtraCost2
ExtraCost3 =trim(request.form("ExtraCost3"))
variables = variables & "&ExtraCost3=" & ExtraCost3
ExtraCost4 =trim(request.form("ExtraCost4"))
variables = variables & "&ExtraCost4=" & ExtraCost4
ExtraCost5 =trim(request.form("ExtraCost5"))
variables = variables & "&ExtraCost5=" & ExtraCost5
ExtraCost6=trim(request.form("ExtraCost6"))
variables = variables & "&ExtraCost6=" & ExtraCost6
ExtraCost7 =trim(request.form("ExtraCost7"))
variables = variables & "&ExtraCost7=" & ExtraCost7
ExtraCost8 =trim(request.form("ExtraCost8"))
variables = variables & "&ExtraCost8=" & ExtraCost8
ExtraCost9 =trim(request.form("ExtraCost9"))
variables = variables & "&ExtraCost9=" & ExtraCost9
ExtraCost10 =trim(request.form("ExtraCost10"))
variables = variables & "&ExtraCost10=" & ExtraCost10

Shipping=trim(request.form("Shipping"))
variables = variables & "&Shipping=" & Shipping
ShippingAnother=trim(request.form("ShippingAnother"))
variables = variables & "&ShippingAnother=" & ShippingAnother
ShippingInternational=trim(request.form("ShippingInternational"))
variables = variables & "&ShippingInternational=" & ShippingInternational
ShippingInternationalAnother=trim(request.form("ShippingInternationalAnother"))
variables = variables & "&ShippingInternationalAnother=" & ShippingInternationalAnother
	
	Color1=trim(Request.Form( "Color1" ))
	variables = variables & "&Color1=" & Color1
	Color2=trim(Request.Form( "Color2" )) 
variables = variables & "&Color2=" & Color2
	Color3=trim(Request.Form( "Color3" )) 
variables = variables & "&Color3=" & Color3
	Color4=trim(Request.Form( "Color4" )) 
variables = variables & "&Color4=" & Color4
	Color5=trim(Request.Form( "Color5" )) 
variables = variables & "&Color5=" & Color5
	Color6=trim(Request.Form( "Color6" )) 
variables = variables & "&Color6=" & Color6
	Color7=trim(Request.Form( "Color7" )) 
variables = variables & "&Color7=" & Color7
	Color8=trim(Request.Form( "Color8" )) 
variables = variables & "&Color8=" & Color8
	Color9=trim(Request.Form( "Color9" )) 
variables = variables & "&Color9=" & Color9
	Color10=trim(Request.Form( "Color10") ) 
variables = variables & "&Color10=" & Color10
Color11=trim(Request.Form( "Color11" ) )	
variables = variables & "&Color11=" & Color11
	Color12=trim(Request.Form( "Color12") ) 
variables = variables & "&Color12=" & Color12
	Color13=trim(Request.Form( "Color13" )) 
variables = variables & "&Color13=" & Color13
	Color14=trim(Request.Form( "Color14" )) 
variables = variables & "&Color14=" & Color14
	Color15=trim(Request.Form( "Color15" ) )
variables = variables & "&Color15=" & Color15
	Color16=trim(Request.Form( "Color16" ) )
variables = variables & "&Color16=" & Color16
	Color17=trim(Request.Form( "Color17" ) )
variables = variables & "&Color17=" & Color17
	Color18=trim(Request.Form( "Color18" ) )
variables = variables & "&Color18=" & Color18
	Color19=trim(Request.Form( "Color19" ) )
variables = variables & "&Color19=" & Color19
	Color20=trim(Request.Form( "Color20" ) )
variables = variables & "&Color20=" & Color20

	Color21=trim(Request.Form( "Color21" ) )
variables = variables & "&Color21=" & Color21
	Color22=trim(Request.Form( "Color22" ) )
variables = variables & "&Color22=" & Color22
	Color23=trim(Request.Form( "Color23" ) )
variables = variables & "&Color23=" & Color23
	Color24=trim(Request.Form( "Color24" ) )
variables = variables & "&Color24=" & Color24
	Color25=trim(Request.Form( "Color25" ) )
variables = variables & "&Color25=" & Color25
	Color26=trim(Request.Form( "Color26" ) )
variables = variables & "&Color26=" & Color26
	Color27=trim(Request.Form( "Color27" ) )
variables = variables & "&Color27=" & Color27
	Color28=trim(Request.Form( "Color28" ) )
variables = variables & "&Color28=" & Color28
	Color29=trim(Request.Form( "Color29" ) )
variables = variables & "&Color29=" & Color29
	Color30=trim(Request.Form( "Color30" ) )
variables = variables & "&Color30=" & Color30

	Color31=trim(Request.Form( "Color31" )) 
variables = variables & "&Color31=" & Color31
	Color32=trim(Request.Form( "Color32" ) )
variables = variables & "&Color32=" & Color32
	Color33=trim(Request.Form( "Color33" ) )
variables = variables & "&Color33=" & Color33
	Color34=trim(Request.Form( "Color34" ) )
variables = variables & "&Color34=" & Color34
	Color35=trim(Request.Form( "Color35" ) )
variables = variables & "&Color35=" & Color35
	Color36=trim(Request.Form( "Color36" ) )
variables = variables & "&Color36=" & Color36
	Color37=trim(Request.Form( "Color37" ) )
variables = variables & "&Color37=" & Color37
	Color38=trim(Request.Form( "Color38" ) )
variables = variables & "&Color38=" & Color38
	Color39=trim(Request.Form( "Color39" ) )
variables = variables & "&Color39=" & Color39
	Color40=trim(Request.Form( "Color40" ) )
variables = variables & "&Color40=" & Color40

	Color41=trim(Request.Form( "Color41" ) )
variables = variables & "&Color41=" & Color41
	Color42=trim(Request.Form( "Color42" ) )
variables = variables & "&Color42=" & Color42
	Color43=trim(Request.Form( "Color43" ) )
variables = variables & "&Color43=" & Color43
	Color44=trim(Request.Form( "Color44" ) )
variables = variables & "&Color44=" & Color44
	Color45=trim(Request.Form( "Color45" ) )
variables = variables & "&Color45=" & Color45
	Color46=trim(Request.Form( "Color46" ) )
variables = variables & "&Color46=" & Color46
	Color47=trim(Request.Form( "Color47" ) )
variables = variables & "&Color47=" & Color47
	Color48=trim(Request.Form( "Color48" ) )
variables = variables & "&Color48=" & Color48
	Color49=trim(Request.Form( "Color49" ) )
variables = variables & "&Color49=" & Color49
	Color50=trim(Request.Form( "Color50" ) )
variables = variables & "&Color50=" & Color50


ProdMadeIn=trim(Request.Form( "ProdMadeIn"))
	variables = variables & "&ProdMadeIn=" & ProdMadeIn
	ProdFiberType1=trim(Request.Form( "ProdFiberType1") )
	variables = variables & "&ProdFiberType1=" & ProdFiberType1
	ProdFiberType2=trim(Request.Form( "ProdFiberType2") )
	variables = variables & "&ProdFiberType2=" & ProdFiberType2
	ProdFiberType3=trim(Request.Form( "ProdFiberType3") )
	variables = variables & "&ProdFiberType3=" & ProdFiberType3
	ProdFiberType4=trim(Request.Form( "ProdFiberType4") )
	variables = variables & "&ProdFiberType4=" & ProdFiberType4
	ProdFiberType5=trim(Request.Form( "ProdFiberType5") )
	variables = variables & "&ProdFiberType5=" & ProdFiberType5

	prodFiberPercent1=trim(Request.Form( "prodFiberPercent1")) 
variables = variables & "&prodFiberPercent1=" & prodFiberPercent1
	prodFiberPercent2=trim(Request.Form( "prodFiberPercent2") )
variables = variables & "&prodFiberPercent2=" & prodFiberPercent2
	prodFiberPercent3=trim(Request.Form( "prodFiberPercent3") )
variables = variables & "&prodFiberPercent3=" & prodFiberPercent3
	prodFiberPercent4=trim(Request.Form( "prodFiberPercent4") )
variables = variables & "&prodFiberPercent4=" & prodFiberPercent4
	prodFiberPercent5=trim(Request.Form( "prodFiberPercent5") )
variables = variables & "&prodFiberPercent5=" & prodFiberPercent5

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

	variables = variables & "&Category1ID=" & Category1ID
	variables = variables & "&Category2ID=" & Category2ID
	variables = variables & "&Category3ID=" & Category3ID
	variables = variables & "&SubCategory1ID=" & SubCategory1ID
	variables = variables & "&SubCategory2ID=" & SubCategory2ID
	variables = variables & "&SubCategory3ID=" & SubCategory3ID
	

    SubCategory1ID = Session("SubCategory1ID") 

if len(SubCategory1ID) > 1 then
else
    Missing = Missing & "&MissingSubCategory=True"
 end if
 
 	
if len(ProdName) > 1 then
else
    Missing = Missing & "&MissingProdName=True"
 end if
 

 if len(Missing) > 13 then
  response.Redirect("AdminClassifiedAdPlace.asp" & Missing & variables)
end if

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

str1 = ProductID
str2 = "'"
If InStr(str1,str2) > 0 Then
	ProductID = Replace(str1, "'", "''")
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
sql2 = "select * from sfProducts where ProdName = '" & ProdName & "' and prodPrice =" & prodPrice & "  order by ProdID"

'response.write(sql2)
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	if  Not rs2.eof then
ProdNameFound = True
prodID = rs2("ProdID")
session("ID") = rs2("ProdID")
session("ProdID") = rs2("ProdID")
	
	End if
rs2.close
	

	If ProdNameFound = False then
	sql2 = "select ProdID from sfProducts  order by ProdID desc"

'response.write(sql2)
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
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
rs2.Open sql2, conn, 3, 3 
If Not rs2.eof Then
    notfound=true
While notfound=true
sql2 = "select * from sfProducts where ProdID  = " & ProdID & ""

	'response.write(sql2)
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
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
ProdForSale = False
End if



	sql2 = "select * from sfProducts  where  ProdName = '" & ProdName & "';"

response.write(sql2)
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	
 session("ID") = ProdID
  session("ProdID") = ProdID
Query =  "INSERT INTO SFProducts ( PeopleID, ProdID,  ProdName, ProdMadeIn, ProdSize1, ProdSize2, ProdSize3,  ProdSize4, ProdSize5, ProdSize6, ProdSize7, ProdSize8, ProdSize9, ProdSize10, prodCountryTaxIsActive, "

if len(prodCategoryId) > 0 then 	
Query =  Query & " prodCategoryId,"
end if

if len(prodSubCategoryId) > 0 then 	
Query =  Query & " prodSubCategoryId,"
end if


if len(prodStandardShipUsDays) > 0 then 	
	Query =  Query & " prodStandardShipUs, "
	end if

if len(prodStandardShipUsDays) > 0 then 
	Query =  Query & " prodStandardShipUsDays,"
end if	
if len(prodStandardShipAnother) > 0 then 
	Query =  Query & " prodStandardShipAnother,"
end if	

if len(prodStandardShipInternational) > 0 then 
	Query =  Query & " prodStandardShipInternational,"
end if	

if len(prodStandardShipInternationalAnother) > 0 then 
	Query =  Query & " prodStandardShipInternationalAnother,"
end if	

if len(prodStandardShpInternationalTimeNote) > 0 then 
	Query =  Query & " prodStandardShpInternationalTimeNote,"
end if	

if len(prodExpeditedShipUs) > 0 then 
	Query =  Query & " prodExpeditedShipUs,"
end if	

if len(prodExpeditedShipUsDays) > 0 then 
	Query =  Query & " prodExpeditedShipUsDays,"
end if

if len(prodExpeditedShipAnother) > 0 then 
	Query =  Query & " prodExpeditedShipAnother,"
end if

if len(prodExpeditedShipInternational) > 0 then 
	Query =  Query & " prodExpeditedShipInternational,"
end if

if len(prodExpeditedShipInternationalAnother) > 0 then 
	Query =  Query & " prodExpeditedShipInternationalAnother,"
end if

if len(prodExpeditedShpInternationalTimeNote) > 0 then 
	Query =  Query & " prodExpeditedShpInternationalTimeNote,"
end if

if len(ExtraCost1) > 0 then
	Query =  Query & " ExtraCost1,"
end if

if len(ExtraCost2) > 0 then
	Query =  Query & " ExtraCost2,"
end if
if len(ExtraCost3) > 0 then
	Query =  Query & " ExtraCost3,"
end if

if len(ExtraCost4) > 0 then
	Query =  Query & " ExtraCost4,"
end if

if len(ExtraCost5) > 0 then
	Query =  Query & " ExtraCost5,"
end if

if len(ExtraCost6) > 0 then
	Query =  Query & " ExtraCost6,"
end if

if len(ExtraCost7) > 0 then
	Query =  Query & " ExtraCost7,"
end if

if len(ExtraCost8) > 0 then
	Query =  Query & " ExtraCost8,"
end if

if len(ExtraCost9) > 0 then
	Query =  Query & " ExtraCost9,"
end if

if len(ExtraCost10) > 0 then
	Query =  Query & " ExtraCost10,"
end if

Query =  Query & " ProdFiberType1, ProdFiberType2, ProdFiberType3, ProdFiberType4, ProdFiberType5, "


if len(prodFiberPercent1) > 0 then
Query =  Query & " prodFiberPercent1,"
end if

if len(prodFiberPercent2) > 0 then
Query =  Query & " prodFiberPercent2,"
end if

if len(prodFiberPercent3) > 0 then
Query =  Query & " prodFiberPercent3,"
end if

if len(prodFiberPercent4) > 0 then
Query =  Query & " prodFiberPercent4,"
end if

if len(prodFiberPercent5) > 0 then
Query =  Query & " prodFiberPercent5,"
end if

i = 0
while i < 50
i = i + 1
Query =  Query & " Color" &  i & ","
wend

if len(ProdPrice) > 0 then
Query =  Query & "  ProdPrice, "
end if

if len(SalePrice) > 0 then
Query =  Query & "  SalePrice,  "
end if

if len(ProdPrice) > 0 then
Query =  Query & " ProdDescription, ProdForSale, "
end if

if len(ProdWeight) > 0 then
Query =  Query & " ProdWeight ," 
end if
Query =  Query & " ProdQuantityAvailable)" 
Query =  Query & " Values (" &  PeopleID & "," 
Query =  Query & " " &  ProdID & "," 
Query =  Query & " '" &  ProdName & "',"
Query =  Query & " '" &  ProdMadeIn & "',"	
Query =  Query & " '" &  ProdSize1 & "'," 
Query =  Query & " '" &  ProdSize2 & "'," 
Query =  Query & " '" &  ProdSize3 & "'," 
Query =  Query & " '" &  ProdSize4 & "'," 
Query =  Query & " '" &  ProdSize5 & "'," 
Query =  Query & " '" &  ProdSize6 & "'," 
Query =  Query & " '" &  ProdSize7 & "'," 
Query =  Query & " '" &  ProdSize8 & "'," 
Query =  Query & " '" &  ProdSize9 & "'," 
Query =  Query & " '" &  ProdSize10 & "',"
if len(prodStateTaxIsActive) > 0 then
Query =  Query & " " & prodStateTaxIsActive & "," 
else
Query =  Query & " False," 
end if
if len(prodCategoryId) > 0 then 	
Query =  Query & " " & prodCategoryId & "," 
end if

if len(prodsubCategoryId) > 0 then
Query =  Query & " " & prodsubCategoryId & ","  	
end if

if len(prodStandardShipUs) > 0 then 
Query =  Query & " " & prodStandardShipUs & ","
end if
if len(prodStandardShipUsDays) > 0 then 
Query =  Query & " " & prodStandardShipUsDays & ","
end if
if len(prodStandardShipAnother) > 0 then 
Query =  Query & " " & prodStandardShipAnother & ","
end if
if len(prodStandardShipInternational) > 0 then 
Query =  Query & " " & prodStandardShipInternational & ","
end if
if len(prodStandardShipInternationalAnother) > 0 then 
Query =  Query & " " & prodStandardShipInternationalAnother & ","
end if
if len(prodStandardShpInternationalTimeNote) > 0 then 
Query =  Query & " '" & prodStandardShpInternationalTimeNote & "',"
end if
if len(prodExpeditedShipUs) > 0 then 
Query =  Query & " " & prodExpeditedShipUs & ","
end if
if len(prodExpeditedShipUsDays) > 0 then 
Query =  Query & " " & prodExpeditedShipUsDays & ","
end if
if len(prodExpeditedShipAnother) > 0 then 
Query =  Query & " " & prodExpeditedShipAnother & ","
end if
if len(prodExpeditedShipInternational) > 0 then 
Query =  Query & " " & prodExpeditedShipInternational & ","
end if
if len(prodExpeditedShipInternationalAnother) > 0 then 
Query =  Query & " " & prodExpeditedShipInternationalAnother & ","
end if
if len(prodExpeditedShpInternationalTimeNote) > 0 then 
Query =  Query & " '" & prodExpeditedShpInternationalTimeNote & "',"
end if
if len(ExtraCost1) > 0 then 
Query =  Query & " '" &  ExtraCost1 & "'," 
end if
	if len(ExtraCost2) > 0 then
Query =  Query & " '" &  ExtraCost2 & "',"
end if
if len(ExtraCost3) > 0 then 
Query =  Query & " '" &  ExtraCost3 & "'," 
end if
if len(ExtraCost4) > 0 then
Query =  Query & " '" &  ExtraCost4 & "'," 
end if
if len(ExtraCost5) > 0 then
Query =  Query & " '" &  ExtraCost5 & "'," 
end if
if len(ExtraCost6) > 0 then
Query =  Query & " '" &  ExtraCost6 & "',"
end if 
if len(ExtraCost7) > 0 then
Query =  Query & " '" &  ExtraCost7 & "'," 
end if
if len(ExtraCost8) > 0 then
Query =  Query & " '" &  ExtraCost8 & "'," 
end if
if len(ExtraCost9) > 0 then
Query =  Query & " '" &  ExtraCost9 & "'," 
end if
if len(ExtraCost10) > 0 then
Query =  Query & " '" &  ExtraCost10 & "'," 
end if
Query =  Query & " '" &  ProdFiberType1 & "',"
Query =  Query & " '" &  ProdFiberType2 & "',"
Query =  Query & " '" &  ProdFiberType3 & "',"
Query =  Query & " '" &  ProdFiberType4 & "',"
Query =  Query & " '" &  ProdFiberType5 & "',"
if len(prodFiberPercent1) > 0 then
Query =  Query & " " &  prodFiberPercent1 & ","
end if
if len(prodFiberPercent2) > 0 then
Query =  Query & " " &  prodFiberPercent2 & ","
end if
if len(prodFiberPercent3) > 0 then
Query =  Query & " " &  prodFiberPercent3 & ","
end if
if len(prodFiberPercent4) > 0 then
Query =  Query & " " &  prodFiberPercent4 & ","
end if
if len(prodFiberPercent5) > 0 then
Query =  Query & " " &  prodFiberPercent5 & ","
end if
	
Query =  Query & " '" &  Color1 & "'," 
Query =  Query & " '" &  Color2 & "',"
Query =  Query & " '" &  Color3 & "',"
Query =  Query & " '" &  Color4 & "',"
Query =  Query & " '" &  Color5 & "',"
Query =  Query & " '" &  Color6 & "',"
Query =  Query & " '" &  Color7 & "',"
Query =  Query & " '" &  Color8 & "',"
Query =  Query & " '" &  Color9 & "',"
Query =  Query & " '" &  Color10 & "',"
Query =  Query & " '" &  Color11 & "'," 
Query =  Query & " '" &  Color12 & "'," 
Query =  Query & " '" &  Color13 & "'," 
Query =  Query & " '" &  Color14 & "'," 
Query =  Query & " '" &  Color15 & "'," 
Query =  Query & " '" &  Color16 & "'," 
Query =  Query & " '" &  Color17 & "'," 
Query =  Query & " '" &  Color18 & "'," 
Query =  Query & " '" &  Color19 & "'," 
Query =  Query & " '" &  Color20 & "'," 
Query =  Query & " '" &  Color21 & "'," 
Query =  Query & " '" &  Color22 & "'," 
Query =  Query & " '" &  Color23 & "'," 
Query =  Query & " '" &  Color24 & "'," 
Query =  Query & " '" &  Color25 & "'," 
Query =  Query & " '" &  Color26 & "'," 
Query =  Query & " '" &  Color27 & "'," 
Query =  Query & " '" &  Color28 & "'," 
Query =  Query & " '" &  Color29 & "'," 
Query =  Query & " '" &  Color30 & "'," 
Query =  Query & " '" &  Color31 & "'," 
Query =  Query & " '" &  Color32 & "'," 
Query =  Query & " '" &  Color33 & "'," 
Query =  Query & " '" &  Color34 & "'," 
Query =  Query & " '" &  Color35 & "'," 
Query =  Query & " '" &  Color36 & "'," 
Query =  Query & " '" &  Color37 & "'," 
Query =  Query & " '" &  Color38 & "'," 
Query =  Query & " '" &  Color39 & "'," 
Query =  Query & " '" &  Color40 & "'," 
Query =  Query & " '" &  Color41 & "'," 
Query =  Query & " '" &  Color42 & "'," 
Query =  Query & " '" &  Color43 & "'," 
Query =  Query & " '" &  Color44 & "'," 
Query =  Query & " '" &  Color45 & "'," 
Query =  Query & " '" &  Color46 & "'," 
Query =  Query & " '" &  Color47 & "'," 
Query =  Query & " '" &  Color48 & "'," 
Query =  Query & " '" &  Color49 & "'," 
Query =  Query & " '" &  Color50 & "'," 

if len(ProdPrice) > 0 then
Query = Query & " "  &  ProdPrice & "," 
end if
if len(SalePrice) > 0 then
Query = Query & " "  &  SalePrice & "," 
end if
Query =  Query & " '" &  ProdDescription & "'," 
Query =  Query & " "  & ProdForSale & "," 
if len(ProdWeight) > 0 then
Query =  Query & " "  & ProdWeight & "," 
end if
Query =  Query & " '" &  ProdQuantityAvailable  & "')"
response.write(Query)	
Conn.Execute(Query) 
Conn.close
set conn=nothing 
%>
<!--#Include virtual="/Conn.asp"-->
<%

Query =  "INSERT INTO ProductsPhotos (ID)" 
Query =  Query & " Values (" &  prodID & ")"

Conn.Execute(Query) 
Conn.close
set conn=nothing 
if len(Category1ID) > 0 then
%>
<!--#Include virtual="/Conn.asp"-->
<%
Query =  "INSERT INTO ProductCategoriesList (ProductID, prodCategoryId)"  
Query =  Query & " Values (" &  prodID & ", " &  Category1ID   & ")"

response.write(Query & "<br>")	
Conn.Execute(Query) 
Conn.close
set conn=nothing 
%>
<!--#Include virtual="/Conn.asp"-->
<%
end if

if len(Category2ID) > 0 then
Query =  "INSERT INTO ProductCategoriesList (ProductID, prodCategoryId)"  
Query =  Query & " Values (" &  prodID & ", " &  Category2ID  & ")"

response.write(Query & "<br>")	
Conn.Execute(Query) 
Conn.close
set conn=nothing 
%>
<!--#Include virtual="/Conn.asp"-->
<%
end if

if len(Category3ID) > 0 then
Query =  "INSERT INTO ProductCategoriesList (ProductID, prodCategoryId)"  
Query =  Query & " Values (" &  prodID & ", " &  Category3ID  & ")"

Conn.Execute(Query) 
Conn.close
set conn=nothing 
end if
%>
<!--#Include virtual="/Conn.asp"-->
<%
Query =  "INSERT INTO sfshipping (ProdID)"  
Query =  Query & " Values (" &  prodID & ")"

Conn.Execute(Query) 
Conn.close
set conn=nothing 
Session("Step2") = True
End if
End if

'End if

response.Redirect("AdminAdEdit2.asp?prodId=" & prodID & "&prodCategory1ID=" & Session("Category1ID") & "&prodCategory2ID=" & Session("Category2ID") & "&prodCategory3ID=" & Session("Category3ID") & "&prodSubCategory1ID=" &  Session("SubCategory1ID") & "&prodSubCategory2ID=" & Session("SubCategory2ID") & "&prodSubCategory3ID=" & Session("SubCategory2ID") )
%>
</Body>
</HTML>
