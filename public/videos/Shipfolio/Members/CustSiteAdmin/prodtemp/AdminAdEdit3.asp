<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<title>Livestock Of America Administration</title>
<meta name="robots" content="nofollow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="revisit-after" content="1"/>
<meta name="Googlebot" content="nofollow"/>
<meta name="author" content="The Andresen Group"/>
<link rel="stylesheet" type="text/css" href="/style.css" />
<!--#Include file="AdminGlobalVariables.asp"-->

<SCRIPT LANGUAGE="JavaScript">
<!-- Begin
   var submitcount=0;
   function checkSubmit() {

      if (submitcount == 0)
      {
      submitcount++;
      document.Surv.submit();
      }
   }


function wordCounter(field, countfield, maxlimit) {
wordcounter=0;
for (x=0;x<field.value.length;x++) {
      if (field.value.charAt(x) == " " && field.value.charAt(x-1) != " ")  {wordcounter++}  // Counts the spaces while ignoring double spaces, usually one in between each word.
      if (wordcounter > 250) {field.value = field.value.substring(0, x);}
      else {countfield.value = maxlimit - wordcounter;}
      }
   }

function textCounter(field, countfield, maxlimit) {
  if (field.value.length > maxlimit)
      {field.value = field.value.substring(0, maxlimit);}
      else
      {countfield.value = maxlimit - field.value.length;}
  }
//  End -->
</script>

</head>
<body >

<!--#Include file="AdminHeader.asp"-->
 <!--#Include file="AdminProductsTabsInclude.asp"-->
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
		<H1><div align = "left">Edit Product</div></H1>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" width = "960">
       <table border = "0" cellspacing="0" cellpadding = "0" align = "right" ><tr><td >
<% 

Category1=Request.Form("Category1") 
Category2=Request.Form("Category2") 
Category3=Request.Form("Category3") 
ProdProductID=Request.Form("ProdProductID") 
'response.write("Category1 = " & Category1 )
'response.write("Category2 = " & Category2 )
'response.write("Category3 = " & Category3 )
	box2ID=Request.Form("box2ID" ) 
	response.write("box2ID=")
	response.write(box2ID)
	If Len(box2ID) > 0 Then
	else
		box2ID=0
	End If
missingdata = False
missingdataPrice = False
ProdName=trim(request.form("ProdName")) 
ProductID=trim(request.form("ProductID")) 
AdType=trim(request.form("AdType"))
ProdPrice =trim(request.form("ProdPrice"))
if len(ProdPrice)< 1 then
missingdata = True
missingdataPrice = True
end if
SalePrice = trim(request.Form("SalePrice"))
ProdQuantityAvailable=trim(request.form("ProdQuantityAvailable"))
ProdCity =request.form("ProdCity")
ProdState =request.form("ProdState")
ProdZip  =request.form("ProdZip")
If Len(ProdZip) < 1 Then
	ProdZip = 0
End if
ProdPartofTown =request.form("ProdPartofTown")
ProdYear  =request.form("ProdYear")
ProdMake =request.form("ProdMake")
ProdModel  =request.form("ProdModel")
ProdCondition  =request.form("ProdCondition")
ProdColor  =request.form("ProdColor")
ProdStartDate  =request.form("ProdStartDate")
ProdEndDate  =request.form("ProdEndDate")
ProdId =request.form("ProdId")
ProdForSale =request.form("ProdForSale")
ProdID =request.form("ProdID")

 ProdDescription   =trim(request.form("ProdDescription"))

ProdSellStore =trim(request.form("ProdSellStore"))
Prodsize1 =trim(request.form("Prodsize1"))
Prodsize2 =trim(request.form("Prodsize2"))
Prodsize3 =trim(request.form("Prodsize3"))
Prodsize4 =trim(request.form("Prodsize4"))
Prodsize5 =trim(request.form("Prodsize5"))
Prodsize6=trim(request.form("Prodsize6"))
Prodsize7 =trim(request.form("Prodsize7"))
Prodsize8 =trim(request.form("Prodsize8"))
Prodsize9 =trim(request.form("Prodsize9"))
Prodsize10 =trim(request.form("Prodsize10"))

ExtraCost1 =trim(request.form("ExtraCost1"))
ExtraCost2 =trim(request.form("ExtraCost2"))
ExtraCost3 =trim(request.form("ExtraCost3"))
ExtraCost4 =trim(request.form("ExtraCost4"))
ExtraCost5 =trim(request.form("ExtraCost5"))
ExtraCost6=trim(request.form("ExtraCost6"))
ExtraCost7 =trim(request.form("ExtraCost7"))
ExtraCost8 =trim(request.form("ExtraCost8"))
ExtraCost9 =trim(request.form("ExtraCost9"))
ExtraCost10 =trim(request.form("ExtraCost10"))

prodStateTaxIsActive=Request.Form("prodStateTaxIsActive") 
prodStandardShipUs=Request.Form("prodStandardShipUs") 
prodStandardShipUsDays=Request.Form("prodStandardShipUsDays") 
prodStandardShipAnother=Request.Form("prodStandardShipAnother") 
prodStandardShipInternational=Request.Form("prodStandardShipInternational") 
prodStandardShipInternationalAnother=Request.Form("prodStandardShipInternationalAnother") 
prodStandardShpInternationalTimeNote=Request.Form("prodStandardShpInternationalTimeNote") 
prodExpeditedShipUs=Request.Form("prodExpeditedShipUs") 
prodExpeditedShipUsDays=Request.Form("prodCountryTaxIsActive") 
prodExpeditedShipAnother=Request.Form("prodExpeditedShipAnother") 
prodExpeditedShipInternational=Request.Form("prodExpeditedShipInternational") 
prodExpeditedShipInternationalAnother=Request.Form("prodExpeditedShipInternationalAnother") 
prodExpeditedShpInternationalTimeNote=Request.Form("prodExpeditedShpInternationalTimeNote") 
					
	Color1=trim(Request.Form( "Color1" )) 
	Color2=trim(Request.Form( "Color2" )) 
	Color3=trim(Request.Form( "Color3" )) 
	Color4=trim(Request.Form( "Color4" )) 
	Color5=trim(Request.Form( "Color5" )) 
	Color6=trim(Request.Form( "Color6" )) 
	Color7=trim(Request.Form( "Color7" )) 
	Color8=trim(Request.Form( "Color8" )) 
	Color9=trim(Request.Form( "Color9" )) 
	Color10=trim(Request.Form( "Color10") ) 
Color11=trim(Request.Form( "Color11" ) )
	Color12=trim(Request.Form( "Color12") ) 
	Color13=trim(Request.Form( "Color13" )) 
	Color14=trim(Request.Form( "Color14" )) 
	Color15=trim(Request.Form( "Color15" ) )
	Color16=trim(Request.Form( "Color16" ) )
	Color17=trim(Request.Form( "Color17" ) )
	Color18=trim(Request.Form( "Color18" ) )
	Color19=trim(Request.Form( "Color19" ) )
	Color20=trim(Request.Form( "Color20" ) )

	Color21=trim(Request.Form( "Color21" ) )
	Color22=trim(Request.Form( "Color22" ) )
	Color23=trim(Request.Form( "Color23" ) )
	Color24=trim(Request.Form( "Color24" ) )
	Color25=trim(Request.Form( "Color25" ) )
	Color26=trim(Request.Form( "Color26" ) )
	Color27=trim(Request.Form( "Color27" ) )
	Color28=trim(Request.Form( "Color28" ) )
	Color29=trim(Request.Form( "Color29" ) )
	Color30=trim(Request.Form( "Color30" ) )

	Color31=trim(Request.Form( "Color31" )) 
	Color32=trim(Request.Form( "Color32" ) )
	Color33=trim(Request.Form( "Color33" ) )
	Color34=trim(Request.Form( "Color34" ) )
	Color35=trim(Request.Form( "Color35" ) )
	Color36=trim(Request.Form( "Color36" ) )
	Color37=trim(Request.Form( "Color37" ) )
	Color38=trim(Request.Form( "Color38" ) )
	Color39=trim(Request.Form( "Color39" ) )
	Color40=trim(Request.Form( "Color40" ) )

	Color41=trim(Request.Form( "Color41" ) )
	Color42=trim(Request.Form( "Color42" ) )
	Color43=trim(Request.Form( "Color43" ) )
	Color44=trim(Request.Form( "Color44" ) )
	Color45=trim(Request.Form( "Color45" ) )
	Color46=trim(Request.Form( "Color46" ) )
	Color47=trim(Request.Form( "Color47" ) )
	Color48=trim(Request.Form( "Color48" ) )
	Color49=trim(Request.Form( "Color49" ) )
	Color50=trim(Request.Form( "Color50" ) )

	Color51=Request.Form( "Color51" ) 
	Color52=Request.Form( "Color52" ) 
	Color53=Request.Form( "Color53" ) 
	Color54=Request.Form( "Color54" ) 
	Color55=Request.Form( "Color55" ) 
	Color56=Request.Form( "Color56" ) 
	Color57=Request.Form( "Color57" ) 
	Color58=Request.Form( "Color58" ) 
	Color59=Request.Form( "Color59" ) 
	Color60=Request.Form( "Color60" ) 

Color61=Request.Form( "Color61" ) 
	Color62=Request.Form( "Color62" ) 
	Color63=Request.Form( "Color63" ) 
	Color64=Request.Form( "Color64" ) 
	Color65=Request.Form( "Color65" ) 
	Color66=Request.Form( "Color66" ) 
	Color67=Request.Form( "Color67" ) 
	Color68=Request.Form( "Color68" ) 
	Color69=Request.Form( "Color69" ) 
	Color70=Request.Form( "Color70" ) 

	Color71=Request.Form( "Color71" ) 
	Color72=Request.Form( "Color72" ) 
	Color73=Request.Form( "Color73" ) 
	Color74=Request.Form( "Color74" ) 
	Color75=Request.Form( "Color75" ) 


ProdMadeIn=trim(Request.Form( "ProdMadeIn"))

	ProdFiberType1=trim(Request.Form( "ProdFiberType1") )
	ProdFiberType2=trim(Request.Form( "ProdFiberType2") )
	ProdFiberType3=trim(Request.Form( "ProdFiberType3") )
	ProdFiberType4=trim(Request.Form( "ProdFiberType4") )
	ProdFiberType5=trim(Request.Form( "ProdFiberType5") )

	prodFiberPercent1=trim(Request.Form( "prodFiberPercent1")) 
	prodFiberPercent2=trim(Request.Form( "prodFiberPercent2") )
	prodFiberPercent3=trim(Request.Form( "prodFiberPercent3") )
	prodFiberPercent4=trim(Request.Form( "prodFiberPercent4") )
	prodFiberPercent5=trim(Request.Form( "prodFiberPercent5") )



ProdDimensions =request.form("ProdDimensions")

str1 = ProdDimensions
str2 = "'"
If InStr(str1,str2) > 0 Then
	ProdDimensions= Replace(str1,  str2, "''")
End If 


ProdWeight =request.form("ProdWeight")
If Len(ProdWeight) < 1 Then
	ProdWeight = 0
End if

str1 = ProdDescription
str2 = "'"
If InStr(str1,str2) > 0 Then
	ProdDescription= Replace(str1,  str2, "''")
End If 

str1 = ProdName
str2 = "'"
If InStr(str1,str2) > 0 Then
	ProdName= Replace(str1,  str2, "''")
End If 

str1 = ProductID
str2 = "'"
If InStr(str1,str2) > 0 Then
	ProductID= Replace(str1,  str2, "''")
End If 

str1 = prodMadeIn
	str2 = "'"
	If InStr(str1,str2) > 0 Then
		prodMadeIn= Replace(str1, "'", "''")
	End If


	str1 = ProdFiberType1
	str2 = "'"
	If InStr(str1,str2) > 0 Then
		ProdFiberType1= Replace(str1, "'", "''")
	End If

	str1 = ProdFiberType2
	str2 = "'"
	If InStr(str1,str2) > 0 Then
		ProdFiberType2= Replace(str1, "'", "''")
	End If


	str1 = ProdFiberType3
	str2 = "'"
	If InStr(str1,str2) > 0 Then
		ProdFiberType3= Replace(str1, "'", "''")
	End If


	str1 = ProdFiberType4
	str2 = "'"
	If InStr(str1,str2) > 0 Then
		ProdFiberType4= Replace(str1, "'", "''")
	End If

	str1 = ProdFiberType5
	str2 = "'"
	If InStr(str1,str2) > 0 Then
		ProdFiberType5= Replace(str1, "'", "''")
	End If

If Len(prodweight) > 0  Then
Else
  prodweight = "0"
 End If
 
If  ProdWeight = " " Then
  ProdWeight = "0"
 End If


 If Len(prodFiberPercent1) > 0 Then
Else
  prodFiberPercent1 = "0"
 End If
 

 If Len(prodFiberPercent2) > 0 Then
Else
  prodFiberPercent2 = "0"
 End If
 
 If Len(prodFiberPercent3) > 0 Then
Else
  prodFiberPercent3 = "0"
 End If
 
 If Len(prodFiberPercent4) > 0 Then
Else
  prodFiberPercent4 = "0"
 End If
 
 If Len(prodFiberPercent5) > 0 Then
Else
  prodFiberPercent5 = "0"
 End If


str1 = ProdPrice
str2 = "'"
If InStr(str1,str2) > 0 Then
	ProdPrice= Replace(str1,  str2, "")
End If 

str1 = ProdPrice
str2 = ","
If InStr(str1,str2) > 0 Then
	ProdPrice= Replace(str1,  str2, "")
End If 


str1 = SalePrice
str2 = "'"
If InStr(str1,str2) > 0 Then
	SalePrice= Replace(str1,  str2, "")
End If 

str1 = SalePrice
str2 = ","
If InStr(str1,str2) > 0 Then
	SalePrice= Replace(str1,  str2, "")
End If 


str1 = ProdSize
str2 = "'"
If InStr(str1,str2) > 0 Then
	ProdSize= Replace(str1,  str2, "''")
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



str1 = prodStandardShpInternationalTimeNote
str2 = "'"
If InStr(str1,str2) > 0 Then
	prodStandardShpInternationalTimeNote= Replace(str1, "'", "''")
End If

str1 = prodExpeditedShpInternationalTimeNote
str2 = "'"
If InStr(str1,str2) > 0 Then
	prodExpeditedShpInternationalTimeNote= Replace(str1, "'", "''")
End If



CategoryID=Request.Form("box1") 
	SubCategoryIDCount=Request.Form("box2ID" ) 
	
If SubCategoryIDCount > 0 Then
Else
SubCategoryID = 0 
End If 

If Len(ProdQuantityAvailable) > 0 Then
Else
	ProdQuantityAvailable = 0
End If 
	


If SubCategoryIDCount > 0 then

	sql = "select * from SFSubCategories where CategoryID = '" &  CategoryID & "' Order by SubcategoryName"
	Set rs = Server.CreateObject("ADODB.Recordset")
	'Response.write(sql)
	rs.Open sql, conn, 3, 3 
	CatCounter= 0
	For CatCounter = 0 To (SubCategoryIDCount -1 )
		If Not( rs. eof )Then
		SubCategoryID = rs("subcatId")
		'Response.write("SubCategoryID=")
		'Response.write(SubCategoryID)
		
			rs.movenext
		End If
	Next
	rs.MovePrevious
		SubCategoryID = rs("subcatId")
		'Response.write("SubCategoryID=")
		'Response.write(SubCategoryID)



	
End If 

  Query =  " UPDATE sfProducts Set "
  if len(ProdName) >  0 then
  Query = Query  & " ProdName= '" & ProdName & "' ,"
  end if
  if len(ProdPrice) > 0 then  
  if ProdPrice > 0 then  
  Query = Query  & " ProdPrice= '" & ProdPrice & "' ,"
  end if
  else
    Query = Query  & " ProdPrice= 0 ,"
  end if
  if len(SalePrice) > 0 then
 Query = Query  & " prodSalePrice= '" & SalePrice & "' ,"
 end if
   if len(ProductID) > 0 then
 Query = Query  & " ProductID= '" & ProductID & "' ,"
 end if
  Query = Query  & "  ProdProductID= '" &  ProdProductID & "' ,"

  Query = Query  & " ProdQuantityAvailable= " & ProdQuantityAvailable & " ,"
  Query = Query  & " Prodsize1= '" & Prodsize1 & "' ,"
  Query = Query  & " Prodsize2= '" & Prodsize2 & "' ,"
  Query = Query  & " Prodsize3= '" & Prodsize3 & "' ,"
  Query = Query  & " Prodsize4= '" & Prodsize4 & "' ,"
  Query = Query  & " Prodsize5= '" & Prodsize5 & "' ,"
  Query = Query  & " Prodsize6= '" & Prodsize6 & "' ,"
  Query = Query  & " Prodsize7= '" & Prodsize7 & "' ,"
  Query = Query  & " Prodsize8= '" & Prodsize8 & "' ,"
  Query = Query  & " Prodsize9= '" & Prodsize9 & "' ,"
  Query = Query  & " Prodsize10= '" & Prodsize10 & "' ,"
  if len(ExtraCost1)> 0 then
  Query = Query  & " ExtraCost1= '" & ExtraCost1 & "' ,"
  else
   Query = Query  & " ExtraCost1= '0' ,"
  end if
    if len(ExtraCost2)> 0 then
   Query = Query  & " ExtraCost2= '" & ExtraCost2 & "' ,"
    else
   Query = Query  & " ExtraCost2= '0' ,"
     end if
    if len(ExtraCost3)> 0 then
   Query = Query  & " ExtraCost3= '" & ExtraCost3 & "' ,"
    else
   Query = Query  & " ExtraCost3= '0' ,"
     end if
    if len(ExtraCost4)> 0 then
   Query = Query  & " ExtraCost4= '" & ExtraCost4 & "' ,"
    else
   Query = Query  & " ExtraCost4= '0' ,"
     end if
    if len(ExtraCost5)> 0 then
   Query = Query  & " ExtraCost5= '" & ExtraCost5 & "' ,"
    else
   Query = Query  & " ExtraCost5= '0' ,"
     end if
    if len(ExtraCost6)> 0 then
   Query = Query  & " ExtraCost6= '" & ExtraCost6 & "' ,"
    else
   Query = Query  & " ExtraCost6= '0' ,"
     end if
    if len(ExtraCost7)> 0 then
   Query = Query  & " ExtraCost7= '" & ExtraCost7 & "' ,"
    else
   Query = Query  & " ExtraCost7= '0' ,"
     end if
    if len(ExtraCost8)> 0 then
   Query = Query  & " ExtraCost8= '" & ExtraCost8 & "' ,"
    else
   Query = Query  & " ExtraCost8= '0' ,"
     end if
    if len(ExtraCost9)> 0 then
   Query = Query  & " ExtraCost9= '" & ExtraCost9 & "' ,"
    else
   Query = Query  & " ExtraCost9= '0' ,"
     end if
    if len(ExtraCost10)> 0 then
   Query = Query  & " ExtraCost10= '" & ExtraCost10 & "' ,"   
    else
   Query = Query  & " ExtraCost10= '10' ," 
   end if         
  if len(Shipping)> 0 then
   Query = Query  & " prodShipUs= " & Shipping & " ,"    
   end if  
   
  if len(ShippingAnother)> 0 then
   Query = Query  & " prodShipAnother= " & ShippingAnother & " ,"    
   end if  
  if len(ShippingInternational)> 0 then
   Query = Query  & " prodShipInternational= " & ShippingInternational & " ,"    
   end if  
  if len(ShippingInternationalAnother)> 0 then
   Query = Query  & " prodShipInternationalAnother= " & ShippingInternationalAnother & " ,"    
   end if  



  
   Query =  Query & "Color1= '" &  Color1 & "',"
    Query =  Query & "Color2= '" &  Color2 & "',"
	Query =  Query & "Color3= '" &  Color3 & "',"
	Query =  Query & "Color4= '" &  Color4 & "',"
	Query =  Query & "Color5= '" &  Color5 & "',"
	Query =  Query & "Color6= '" &  Color6 & "',"
		Query =  Query & "Color7= '" &  Color7 & "',"
		Query =  Query & "Color8= '" & Color8 & "',"
		Query =  Query & "Color9= '" & Color9 & "',"
		Query =  Query & "Color10= '" & Color10 & "',"
		Query =  Query & "Color11= '" &  Color11 & "',"
		Query =  Query & "Color12= '" &  Color12 & "',"
		Query =  Query & "Color13= '" &  Color13 & "',"
		Query =  Query & "Color14= '" &  Color14 & "',"
		Query =  Query & "Color15= '" & Color15 & "',"
		Query =  Query & "Color16= '" &  Color16 & "',"
		Query =  Query & "Color17= '" &  Color17 & "',"
		Query =  Query & "Color18= '" &  Color18 & "',"
		Query =  Query & "Color19= '" & Color19 & "',"
		Query =  Query & "Color20= '" &  Color20 & "',"
		Query =  Query & "Color21= '" & Color21 & "',"
		Query =  Query & "Color22= '" &  Color22 & "',"
		Query =  Query & "Color23= '" & Color23 & "',"
		Query =  Query & "Color24= '" &  Color24 & "',"
		Query =  Query & "Color25= '" &  Color25 & "',"
		Query =  Query & "Color26= '" & Color26 & "',"
		Query =  Query & "Color27= '" &  Color27 & "',"
		Query =  Query & "Color28= '" & Color28 & "',"
		Query =  Query & "Color29= '" & Color29 & "',"
		Query =  Query & "Color30= '" &  Color30 & "',"
		Query =  Query & "Color31= '" &  Color31 & "',"
		Query =  Query & "Color32= '" & Color32 & "',"
		Query =  Query & "Color33= '" &  Color33 & "',"
		Query =  Query & "Color34= '" &  Color34 & "',"
		Query =  Query & "Color35= '" &  Color35 & "',"
		Query =  Query & "Color36= '" & Color36 & "',"
		Query =  Query & "Color37= '" &  Color37 & "',"
		Query =  Query & "Color38= '" & Color38 & "',"
		Query =  Query & "Color39= '" & Color39 & "',"
		Query =  Query & "Color40= '" &  Color40 & "',"
		Query =  Query & "Color41= '" &  Color41 & "',"
		Query =  Query & "Color42= '" & Color42 & "',"
		Query =  Query & "Color43= '" & Color43 & "',"
		Query =  Query & "Color44= '" & Color44 & "',"
		Query =  Query & "Color45= '" & Color45 & "',"
		Query =  Query & "Color46= '" &  Color46 & "',"
		Query =  Query & "Color47= '" & Color47 & "',"
		Query =  Query & "Color48= '" &  Color48 & "',"
		Query =  Query & "Color49= '" &  Color49 & "',"
		Query =  Query & "Color50= '" &  Color50 & "',"
		Query =  Query & "Color51= '" &  Color51 & "',"
		Query =  Query & "Color52= '" &  Color52 & "',"
		Query =  Query & "Color53= '" & Color53 & "',"
		Query =  Query & "Color54= '" & Color54 & "',"
		Query =  Query & "Color55= '" &  Color55 & "',"
		Query =  Query & "Color56= '" & Color56 & "',"
		Query =  Query & "Color57= '" &  Color57 & "',"
		Query =  Query & "Color58= '" &  Color58 & "',"
		Query =  Query & "Color59= '" &  Color59 & "',"
		Query =  Query & "Color60= '" &  Color60 & "',"
		Query =  Query & "Color61= '" &  Color61 & "',"
		Query =  Query & "Color62= '" & Color62 & "',"
		Query =  Query & "Color63= '" & Color63 & "',"
		Query =  Query & "Color64= '" & Color64 & "',"
		Query =  Query & "Color65= '" &  Color65 & "',"
		Query =  Query & "Color66= '" &  Color66 & "',"
		Query =  Query & "Color67= '" &  Color67 & "',"
		Query =  Query & "Color68= '" & Color68 & "',"
		Query =  Query & "Color69= '" & Color69 & "',"
		Query =  Query & "Color70= '" &  Color70 & "',"
		Query =  Query & "Color71= '" &  Color71 & "',"
		Query =  Query & "Color72= '" &  Color72 & "',"
		Query =  Query & "Color73= '" &  Color73 & "',"
		Query =  Query & "Color74= '" &  Color74 & "',"
		Query =  Query & "Color75= '" &  Color75 & "',"
		Query =  Query & "ProdMadeIn= '" &  ProdMadeIn & "',"
		Query =  Query & "ProdFiberType1= '" &  ProdFiberType1 & "',"
		Query =  Query & "ProdFiberType2=  '" &  ProdFiberType2 & "',"
		Query =  Query & "ProdFiberType3=  '" &  ProdFiberType3 & "',"
		Query =  Query & "ProdFiberType4=  '" &  ProdFiberType4 & "',"
		Query =  Query & "ProdFiberType5=  '" &  ProdFiberType5 & "',"
		Query =  Query & "prodFiberPercent1= " &  prodFiberPercent1 & "," 
		Query =  Query & "prodFiberPercent2=  " &  prodFiberPercent2 & "," 
		Query =  Query & "prodFiberPercent3=  " &  prodFiberPercent3 & "," 
		Query =  Query & "prodFiberPercent4=  " &  prodFiberPercent4 & "," 
	    Query =  Query & "prodFiberPercent5=  " &  prodFiberPercent5 & "," 
        if len(prodStateTaxIsActive) > 0 then
	        Query =  Query & " prodStateTaxIsActive=  " &  prodStateTaxIsActive & "," 
	    end if
	     if len(prodStandardShipUs) > 0 then
	    Query =  Query & " prodStandardShipUs=  " &  prodStandardShipUs & "," 
	    end if
	    if len(prodStandardShipUsDays) > 0 then
	    Query =  Query & " prodStandardShipUsDays=  " &  prodStandardShipUsDays & "," 
	    end if
	    if len(prodStandardShipAnother) > 0 then
	    Query =  Query & " prodStandardShipAnother=  " &  prodStandardShipAnother & "," 
	    end if
	   if len(prodStandardShipInternational) > 0 then
	    Query =  Query & " prodStandardShipInternational=  " &  prodStandardShipInternational & "," 
	   end if 
	    if len(prodStandardShipInternationalAnother) > 0 then
	    Query =  Query & " prodStandardShipInternationalAnother=  " &  prodStandardShipInternationalAnother & "," 
	    end if
	       if len(prodStandardShpInternationalTimeNote) > 0 then
	    Query =  Query & " prodStandardShpInternationalTimeNote=  '" &  prodStandardShpInternationalTimeNote & "'," 
	    end if
	     if len(prodExpeditedShipUs) > 0 then
	    Query =  Query & " prodExpeditedShipUs=  " &  prodExpeditedShipUs & "," 
	    end if
	     if len(prodExpeditedShipUsDays) > 0 then
	    Query =  Query & " prodExpeditedShipUsDays=  " &  prodExpeditedShipUsDays & "," 
	    end if
	     if len(prodExpeditedShipAnother) > 0 then
	    Query =  Query & " prodExpeditedShipAnother=  " &  prodExpeditedShipAnother & "," 
	    end if
	  if len(prodExpeditedShipInternational) > 0 then
	    Query =  Query & " prodExpeditedShipInternational=  " &  prodExpeditedShipInternational & "," 
	    end if
	     if len(prodExpeditedShipInternationalAnother) > 0 then
	    Query =  Query & " prodExpeditedShipInternationalAnother=  " &  prodExpeditedShipInternationalAnother & "," 
	    end if
	     if len(prodExpeditedShpInternationalTimeNote) > 0 then
	    Query =  Query & " prodExpeditedShpInternationalTimeNote=  '" &  prodExpeditedShpInternationalTimeNote & "'," 
        end if
		Query = Query  & " ProdDimensions= '" & ProdDimensions & "' ,"
		Query = Query  & " ProdDescription= '" & ProdDescription & "', "
		Query = Query  & " ProdForSale= " & ProdForSale & ", "
		Query = Query  & " ProdWeight= " & ProdWeight & " "
		Query =  Query & " where prodID = " & ProdID & ";" 

response.write(Query)

Conn.Execute(Query) 
Conn.close
set conn=nothing 
%>
<!--#Include virtual="/Conn.asp"-->
<%
   Query =  " Delete * from productCategoriesList where productID = " & ProdID & ";" 
Conn.Execute(Query) 
Conn.close
set conn=nothing 
%>
<!--#Include virtual="/Conn.asp"-->
<%
  
 if len(session("Category1ID")) > 0 then
  Query =  " Insert into productCategoriesList (ProductID, prodCategoryId, prodSubCategoryId)"
  Query =  Query & " Values ('" &  ProdID  & "'," & session("Category1ID") & "," & session("SubCategory1ID") & ")"
  
Conn.Execute(Query) 
Conn.close
set conn=nothing 
%>
<!--#Include virtual="/Conn.asp"-->
<%
  end if 
  
 if len(session("Category2ID")) > 0 and session("SubCategory2ID") > 0 then
  Query =  " Insert into productCategoriesList (ProductID, prodCategoryId, prodSubCategoryId)"
  Query =  Query & " Values (" &  ProdID  & "," & session("Category2ID") & "," & session("SubCategory2ID") & ")"
Conn.Execute(Query) 
Conn.close
set conn=nothing 
%>
<!--#Include virtual="/Conn.asp"-->
<%
  end if 
  
   if len(session("Category3ID")) > 0 and len(session("SubCategory3ID")) > 0 then
  Query =  " Insert into productCategoriesList (ProductID, prodCategoryId, prodSubCategoryId)"
  Query =  Query & " Values ('" &  ProdID  & "'," & session("Category3ID") & "," & session("SubCategory3ID") & ")"
Conn.Execute(Query) 
Conn.close
set conn=nothing 
%>
<!--#Include virtual="/Conn.asp"-->
<%

  end if 


response.redirect("AdminAdEdit2.asp?ProdID=" & prodID ) %>


 </Body>
</HTML>