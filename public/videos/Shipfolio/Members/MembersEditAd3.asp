<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<!--#Include file="MembersGlobalvariables.asp"--> 
<title>Livestock Of America Membersistration</title>
<meta name="robots" content="nofollow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="revisit-after" content="1"/>
<meta name="Googlebot" content="nofollow"/>
<meta name="author" content="The Andresen Group"/>
<link rel="stylesheet" type="text/css" href="/style.css" />


</HEAD>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center" >

<% 

box1=Request.Form("box1" ) 
	box2ID=Request.Form("box2ID" ) 
	response.write("box2ID=")
	response.write(box2ID)
	If Len(box2ID) > 0 Then
	else
		box2ID=0
	End If
	
ProdName=request.form("ProdName") 
		AdType=request.form("AdType")
ProdName=request.form("ProdName")
ProdPrice =request.form("ProdPrice")
ProdQuantityAvailable=request.form("ProdQuantityAvailable")
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

 ProdDescription   =request.form("ProdDescription")

ProdSellStore =request.form("ProdSellStore")
Prodsize1 =request.form("Prodsize1")
Prodsize2 =request.form("Prodsize2")
Prodsize3 =request.form("Prodsize3")
Prodsize4 =request.form("Prodsize4")
Prodsize5 =request.form("Prodsize5")
Prodsize6=request.form("Prodsize6")
Prodsize7 =request.form("Prodsize7")
Prodsize8 =request.form("Prodsize8")
Prodsize9 =request.form("Prodsize9")
Prodsize10 =request.form("Prodsize10")


	Color1=Request.Form( "Color1" ) 
	response.write("Color1=" & Color1)
	Color2=Request.Form( "Color2" ) 
	Color3=Request.Form( "Color3" ) 
	Color4=Request.Form( "Color4" ) 
	Color5=Request.Form( "Color5" ) 
	Color6=Request.Form( "Color6" ) 
	Color7=Request.Form( "Color7" ) 
	Color8=Request.Form( "Color8" ) 
	Color9=Request.Form( "Color9" ) 
	Color10=Request.Form( "Color10" ) 
Color11=Request.Form( "Color11" ) 
	Color12=Request.Form( "Color12" ) 
	Color13=Request.Form( "Color13" ) 
	Color14=Request.Form( "Color14" ) 
	Color15=Request.Form( "Color15" ) 
	Color16=Request.Form( "Color16" ) 
	Color17=Request.Form( "Color17" ) 
	Color18=Request.Form( "Color18" ) 
	Color19=Request.Form( "Color19" ) 
	Color20=Request.Form( "Color20" ) 

	Color21=Request.Form( "Color21" ) 
	Color22=Request.Form( "Color22" ) 
	Color23=Request.Form( "Color23" ) 
	Color24=Request.Form( "Color24" ) 
	Color25=Request.Form( "Color25" ) 
	Color26=Request.Form( "Color26" ) 
	Color27=Request.Form( "Color27" ) 
	Color28=Request.Form( "Color28" ) 
	Color29=Request.Form( "Color29" ) 
	Color30=Request.Form( "Color30" ) 

	Color31=Request.Form( "Color31" ) 
	Color32=Request.Form( "Color32" ) 
	Color33=Request.Form( "Color33" ) 
	Color34=Request.Form( "Color34" ) 
	Color35=Request.Form( "Color35" ) 
	Color36=Request.Form( "Color36" ) 
	Color37=Request.Form( "Color37" ) 
	Color38=Request.Form( "Color38" ) 
	Color39=Request.Form( "Color39" ) 
	Color40=Request.Form( "Color40" ) 

	Color41=Request.Form( "Color41" ) 
	Color42=Request.Form( "Color42" ) 
	Color43=Request.Form( "Color43" ) 
	Color44=Request.Form( "Color44" ) 
	Color45=Request.Form( "Color45" ) 
	Color46=Request.Form( "Color46" ) 
	Color47=Request.Form( "Color47" ) 
	Color48=Request.Form( "Color48" ) 
	Color49=Request.Form( "Color49" ) 
	Color50=Request.Form( "Color50" ) 

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


ProdMadeIn=Request.Form( "ProdMadeIn")

	ProdFiberType1=Request.Form( "ProdFiberType1") 
	ProdFiberType2=Request.Form( "ProdFiberType2") 
	ProdFiberType3=Request.Form( "ProdFiberType3") 
	ProdFiberType4=Request.Form( "ProdFiberType4") 
	ProdFiberType5=Request.Form( "ProdFiberType5") 

	prodFiberPercent1=Request.Form( "prodFiberPercent1") 
	prodFiberPercent2=Request.Form( "prodFiberPercent2") 
	prodFiberPercent3=Request.Form( "prodFiberPercent3") 
	prodFiberPercent4=Request.Form( "prodFiberPercent4") 
	prodFiberPercent5=Request.Form( "prodFiberPercent5") 

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

str1 = ProdSize
str2 = "'"
If InStr(str1,str2) > 0 Then
	ProdSize= Replace(str1,  str2, "''")
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

 sql = "select * from SFCategories where CatID = " & CategoryID & ";"
'response.write(sql)
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3 
	
	If Not rs.eof Then
		CategoryName = rs("CatName")
	End if
	


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

  Query =  " UPDATE sfProducts Set ProdPrice= '" & ProdPrice & "' ,"
  Query = Query  & "  ProdName= '" & ProdName & "' ,"
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

Query =  Query & "prodStateTaxIsActive=  '" &  prodStateTaxIsActive & "'," 
Query =  Query & "prodStandardShipUs=  '" &  prodStandardShipUs & "'," 
Query =  Query & "prodStandardShipUsDays=  '" &  prodStandardShipUsDays & "'," 
Query =  Query & "prodStandardShipAnother=  '" &  prodStandardShipAnother & "'," 
Query =  Query & "prodStandardShipInternational= '" &  prodStandardShipInternational & "'," 
Query =  Query & "prodStandardShipInternationalAnother=  '" &  prodStandardShipInternationalAnother & "'," 
	  ' Query =  Query & "prodStandardShpInternationalTimeNote=  '" &  prodStandardShpInternationalTimeNote & "'," 
	  ' Query =  Query & "prodExpeditedShipUs=  '" &  prodExpeditedShipUs & "'," 
	  ' Query =  Query & "prodExpeditedShipUsDays=  '" &  prodCountryTaxIsActive & "'," 
	  ' Query =  Query & "prodExpeditedShipAnother=  '" &  prodExpeditedShipAnother & "'," 
	  ' Query =  Query & "prodExpeditedShipInternational=  '" &  prodExpeditedShipInternational & "'," 
	  ' Query =  Query & "prodExpeditedShipInternationalAnother=  '" &  prodExpeditedShipInternationalAnother & "'," 
	  ' Query =  Query & "prodExpeditedShpInternationalTimeNote=  '" &  prodExpeditedShpInternationalTimeNote & "'," 


		Query = Query  & " ProdDimensions= '" & ProdDimensions & "' ,"
		Query = Query  & " ProdDescription= '" & ProdDescription & "', "
		Query = Query  & " ProdForSale= " & ProdForSale & ", "
		Query = Query  & " ProdWeight= " & ProdWeight & ", "
	    Query = Query  & " prodCategoryId= " & CategoryID & ", "
		Query = Query  & " prodSubCategoryId= " & SubCategoryID & " "
		Query =  Query & " where prodID = " & ProdID & ";" 

response.write(Query)
Conn.Execute(Query) 
 
'response.Redirect("MembersAdEdit2.asp?prodId=" & prodID )
%>



<table width = "600" align = "center">
	<tr>
		<td>

		
<form action= 'MembersClassifiedAdPlace.asp' method = "post">


			<input type=submit value = "Add a Listing -->" size = "310" class = "body" >
			</form>
		<form action= 'MembersProductsUploadPhotos.asp' method = "post">
<input name="ProdID" type = "hidden" value = "<%=ProdID %>">

			<input type=submit value = "Upload Photos -->" size = "310" class = "body" >
			</form>
   </td>
    </tr>
</table>

 </Body>
</HTML>