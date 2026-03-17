<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4+0 Transitional//EN">
<HTML>
<HEAD>
<!--#Include file="GlobalVariables.asp"--> 
 <title>Add a Listing</title>
                          <link rel="stylesheet" type="text/css" href="style.css">


						  
</HEAD>

<body>
<!--#Include virtual="/Administration/Header.asp"--> 
<table  height = "300"  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>




<%
		


		'If Session("PhotoPageCount") = 0 then
		'  Session("PhotoPageCount") = 1
		Dim box1
		Dim box2ID

		Dim ProdYear
		Dim ProdMake
		Dim ProdModel
		Dim ProdPrice
		Dim ProdCondition
		Dim ProdColor
		Dim ProdQuantityAvailable
		Dim ProdDescription
		Dim CustID
		Dim AdType
		Dim ProdCity
		Dim ProdPartOfTown
		Dim ProdZip


	CustID=session("CustID" ) 
	ProdId=Request.Form( "ProdId" ) 
	
	box1=Request.Form("box1" ) 
	box2ID=Request.Form("box2ID" ) 
	'response.write("box2ID=")
	'response.write(box2ID)
	If Len(box2ID) > 0 Then
	else
		box2ID=0
	End if
	ProdName=Request.Form("ProdName" ) 
	ProdPrice=Request.Form( "Price" ) 
	ProdQuantityAvailable=Request.Form( "Quantity" ) 
	ProdDescription=Request.Form( "ProdDescription" ) 
	ProdYear=Request.Form( "ProdYear" ) 
	ProdMake=Request.Form( "ProdMake" ) 
	ProdModel=Request.Form( "ProdModel" ) 
	ProdCondition=Request.Form( "ProdCondition" ) 
	ProdWeight=Request.Form( "ProdWeight" ) 


'response.write("ProdCondition=")
'response.write(ProdCondition)

	ProdColor=Request.Form( "ProdColor" ) 
	ProdCity=Request.Form( "ProdCity" ) 
	ProdState=Request.Form( "ProdState" ) 
	ProdPartOfTown=Request.Form( "ProdPartOfTown" ) 
	ProdZip=Request.Form( "ProdZip" ) 
	ProdSize=Request.Form( "ProdSize" ) 
	ProdSellStore=Request.Form( "ProdSellStore" ) 
	ProdForSale=Request.Form( "ProdForSale" ) 
	ProdDimensions=Request.Form( "ProdDimensions" ) 
	ProdSize1=Request.Form( "ProdSize1" ) 
	ProdSize2=Request.Form( "ProdSize2" ) 
	ProdSize3=Request.Form( "ProdSize3" ) 
	ProdSize4=Request.Form( "ProdSize4" ) 
	ProdSize5=Request.Form( "ProdSize5" ) 
	ProdSize6=Request.Form( "ProdSize6" ) 
	ProdSize7=Request.Form( "ProdSize7" ) 
	ProdSize8=Request.Form( "ProdSize8" ) 
		ProdSize9=Request.Form( "ProdSize9" ) 
			ProdSize10=Request.Form( "ProdSize10" ) 
	Color1=Request.Form( "Color1" ) 
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

	Color61=Request.Form( "Color71" ) 
	Color62=Request.Form( "Color72" ) 
	Color63=Request.Form( "Color73" ) 
	Color64=Request.Form( "Color74" ) 
	Color65=Request.Form( "Color75" ) 
	Color66=Request.Form( "Color76" ) 
	Color67=Request.Form( "Color77" ) 
	Color68=Request.Form( "Color78" ) 
	Color69=Request.Form( "Color79" ) 
	Color70=Request.Form( "Color80" ) 

	prodMadeIn=Request.Form( "prodMadeIn" ) 
	ProdFiberType1=Request.Form("ProdFiberType1") 
	ProdFiberType2=Request.Form("ProdFiberType2") 
	ProdFiberType3=Request.Form("ProdFiberType3") 
	ProdFiberType4=Request.Form("ProdFiberType4") 
	ProdFiberType5=Request.Form("ProdFiberType5") 

	prodFiberPercent1=Request.Form("prodFiberPercent1") 
	prodFiberPercent2=Request.Form("prodFiberPercent2") 
	prodFiberPercent3=Request.Form("prodFiberPercent3") 
	prodFiberPercent4=Request.Form("prodFiberPercent4") 
	prodFiberPercent5=Request.Form("prodFiberPercent5") 

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

If Len(prodweight) > 0 Then
Else
  prodweight = "0"
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
	ProdSize7= Replace(str1, "'", "''")
End If

%>

<% TempVar = Color1 %>
<!--#Include file="CheckApostropheInclude.asp"--> 
<% TempVar = Color2 %>
<!--#Include file="CheckApostropheInclude.asp"--> 
<% TempVar = Color3 %>
<!--#Include file="CheckApostropheInclude.asp"--> 
<% TempVar = Color4 %>
<!--#Include file="CheckApostropheInclude.asp"--> 
<% TempVar = Color5 %>
<!--#Include file="CheckApostropheInclude.asp"--> 
<% TempVar = Color6 %>
<!--#Include file="CheckApostropheInclude.asp"--> 
<% TempVar = Color7 %>
<!--#Include file="CheckApostropheInclude.asp"--> 
<% TempVar = Color8 %>
<!--#Include file="CheckApostropheInclude.asp"--> 
<% TempVar = Color9 %>
<!--#Include file="CheckApostropheInclude.asp"--> 
<% TempVar = Color10 %>
<!--#Include file="CheckApostropheInclude.asp"--> 
<% TempVar = Color11 %>
<!--#Include file="CheckApostropheInclude.asp"--> 
<% TempVar = Color12 %>
<!--#Include file="CheckApostropheInclude.asp"--> 
<% TempVar = Color13 %>
<!--#Include file="CheckApostropheInclude.asp"--> 
<% TempVar = Color14 %>
<!--#Include file="CheckApostropheInclude.asp"--> 
<% TempVar = Color15 %>
<!--#Include file="CheckApostropheInclude.asp"--> 
<% TempVar = Color16 %>
<!--#Include file="CheckApostropheInclude.asp"--> 
<% TempVar = Color17 %>
<!--#Include file="CheckApostropheInclude.asp"--> 
<% TempVar = Color18 %>
<!--#Include file="CheckApostropheInclude.asp"--> 
<% TempVar = Color19 %>
<!--#Include file="CheckApostropheInclude.asp"--> 
<% TempVar = Color20 %>
<!--#Include file="CheckApostropheInclude.asp"--> 
<% TempVar = Color21 %>
<!--#Include file="CheckApostropheInclude.asp"--> 
<% TempVar = Color22 %>
<!--#Include file="CheckApostropheInclude.asp"--> 
<% TempVar = Color23 %>
<!--#Include file="CheckApostropheInclude.asp"--> 
<% TempVar = Color24 %>
<!--#Include file="CheckApostropheInclude.asp"--> 
<% TempVar = Color25 %>
<!--#Include file="CheckApostropheInclude.asp"--> 
<% TempVar = Color26 %>
<!--#Include file="CheckApostropheInclude.asp"--> 
<% TempVar = Color27 %>
<!--#Include file="CheckApostropheInclude.asp"--> 
<% TempVar = Color28 %>
<!--#Include file="CheckApostropheInclude.asp"--> 
<% TempVar = Color29 %>
<!--#Include file="CheckApostropheInclude.asp"--> 
<% TempVar = Color30 %>
<!--#Include file="CheckApostropheInclude.asp"--> 
<% TempVar = Color31 %>
<!--#Include file="CheckApostropheInclude.asp"--> 
<% TempVar = Color32 %>
<!--#Include file="CheckApostropheInclude.asp"--> 
<% TempVar = Color33 %>
<!--#Include file="CheckApostropheInclude.asp"--> 
<% TempVar = Color34 %>
<!--#Include file="CheckApostropheInclude.asp"--> 
<% TempVar = Color35 %>
<!--#Include file="CheckApostropheInclude.asp"--> 
<% TempVar = Color36 %>
<!--#Include file="CheckApostropheInclude.asp"--> 
<% TempVar = Color37 %>
<!--#Include file="CheckApostropheInclude.asp"--> 
<% TempVar = Color38 %>
<!--#Include file="CheckApostropheInclude.asp"--> 
<% TempVar = Color39 %>
<!--#Include file="CheckApostropheInclude.asp"--> 
<% TempVar = Color40 %>
<!--#Include file="CheckApostropheInclude.asp"--> 
<% TempVar = Color41 %>
<!--#Include file="CheckApostropheInclude.asp"--> 
<% TempVar = Color42 %>
<!--#Include file="CheckApostropheInclude.asp"--> 
<% TempVar = Color43 %>
<!--#Include file="CheckApostropheInclude.asp"--> 
<% TempVar = Color44 %>
<!--#Include file="CheckApostropheInclude.asp"--> 
<% TempVar = Color45 %>
<!--#Include file="CheckApostropheInclude.asp"--> 
<% TempVar = Color46 %>
<!--#Include file="CheckApostropheInclude.asp"--> 
<% TempVar = Color47 %>
<!--#Include file="CheckApostropheInclude.asp"--> 
<% TempVar = Color48 %>
<!--#Include file="CheckApostropheInclude.asp"--> 
<% TempVar = Color49 %>
<!--#Include file="CheckApostropheInclude.asp"--> 
<% TempVar = Color50 %>
<!--#Include file="CheckApostropheInclude.asp"--> 
<% TempVar = Color51 %>
<!--#Include file="CheckApostropheInclude.asp"--> 
<% TempVar = Color52 %>
<!--#Include file="CheckApostropheInclude.asp"--> 
<% TempVar = Color53 %>
<!--#Include file="CheckApostropheInclude.asp"--> 
<% TempVar = Color54 %>
<!--#Include file="CheckApostropheInclude.asp"--> 
<% TempVar = Color55 %>
<!--#Include file="CheckApostropheInclude.asp"--> 
<% TempVar = Color56 %>
<!--#Include file="CheckApostropheInclude.asp"--> 
<% TempVar = Color57 %>
<!--#Include file="CheckApostropheInclude.asp"--> 
<% TempVar = Color58 %>
<!--#Include file="CheckApostropheInclude.asp"--> 
<% TempVar = Color59 %>
<!--#Include file="CheckApostropheInclude.asp"--> 

<% TempVar = Color60 %>
<!--#Include file="CheckApostropheInclude.asp"--> 
<% TempVar = Color61 %>
<!--#Include file="CheckApostropheInclude.asp"--> 
<% TempVar = Color62 %>
<!--#Include file="CheckApostropheInclude.asp"--> 
<% TempVar = Color63 %>
<!--#Include file="CheckApostropheInclude.asp"--> 
<% TempVar = Color64 %>
<!--#Include file="CheckApostropheInclude.asp"--> 
<% TempVar = Color65 %>
<!--#Include file="CheckApostropheInclude.asp"--> 
<% TempVar = Color66 %>
<!--#Include file="CheckApostropheInclude.asp"--> 
<% TempVar = Color67 %>
<!--#Include file="CheckApostropheInclude.asp"--> 
<% TempVar = Color68 %>
<!--#Include file="CheckApostropheInclude.asp"--> 
<% TempVar = Color69 %>
<!--#Include file="CheckApostropheInclude.asp"--> 

<% TempVar = Color70 %>
<!--#Include file="CheckApostropheInclude.asp"--> 
<% TempVar = Color71 %>
<!--#Include file="CheckApostropheInclude.asp"--> 
<% TempVar = Color72 %>
<!--#Include file="CheckApostropheInclude.asp"--> 
<% TempVar = Color73 %>
<!--#Include file="CheckApostropheInclude.asp"--> 
<% TempVar = Color74 %>
<!--#Include file="CheckApostropheInclude.asp"--> 
<% TempVar = Color75 %>
<!--#Include file="CheckApostropheInclude.asp"--> 
<% TempVar = Color76 %>
<!--#Include file="CheckApostropheInclude.asp"--> 
<% TempVar = Color77 %>
<!--#Include file="CheckApostropheInclude.asp"--> 
<% TempVar = Color78 %>
<!--#Include file="CheckApostropheInclude.asp"--> 
<% TempVar = Color79 %>
<!--#Include file="CheckApostropheInclude.asp"--> 
<% TempVar = Color80 %>
<!--#Include file="CheckApostropheInclude.asp"--> 










<%

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
str1 = ProdPrice
str2 = "$"
If InStr(str1,str2) > 0 Then
	ProdPrice= Replace(str1, "$", "")
End If

If len(ProdPrice) = 0 then
	ProdPrice = "0"
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

str1 = ProdSize
str2 = "'"
If InStr(str1,str2) > 0 Then
	ProdSize = Replace(str1, "'", "''")
End If

str1 = ProdZip 
str2 = "'"
If InStr(str1,str2) > 0 Then
	ProdZip = Replace(str1, "'", "''")
End If

If len(ProdZip) = 0 then
	ProdZip  = "0"
End If
'response.write("Session(Step2)=" & Session("Step2") )
Session("Step2") = false
If 	Session("Step2") = false then
			
	ProdNameFound = False

	If ProdNameFound = False then
	sql2 = "select * from sfProducts  order by ProdID"

conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(databasepath) & ";" & _
						"User Id=;Password= ;" 
'response.write("sql=" & sql2)
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	If Not rs2.eof then

		ProdID = rs2.recordcount + 1
		rs2.close
   End If 



		sql2 = "select * from sfProducts where ProdID  = " & ProdID & ""

		'response.write(sql2)
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

	
	




	sql2 = "select * from sfProducts  where custID = " & session("custid") & " and  ProdName = '" & ProdName & "';"

'response.write(sql2)
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	
 session("ID") = ProdID
  session("ProdID") = ProdID

	Query =  "INSERT INTO SFProducts (CustID, ProdID,   ProdName,  "
	For x= 1 To 10
		Query =  Query & " ProdSize" & x & ", "
	next
	For x= 1 To 10
		Query =  Query & " Color" & x & ", "
	Next
	Query =  Query & "  ProdDimensions, prodCategoryId, prodSubCategoryId, ProdPrice,  ProdDescription, ProdForSale, prodweight, ProdQuantityAvailable)" 
		Query =  Query & " Values (" &  CustID & "," 
		Query =  Query & " '" &  ProdID & "'," 
		Query =  Query & " '" &  ProdName & "'," 
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
		Query =  Query & " '" &  ProdDimensions & "'," 
		Query =  Query & " " &  box1 & "," 
		Query =  Query & " "  &  box2ID & "," 
		Query = Query & " '"  &  ProdPrice & "'," 
		Query =  Query & " '" &  ProdDescription & "'," 
		Query =  Query & " "  & ProdForSale & "," 
		Query =  Query & " "  & ProdWeight & "," 
		Query =  Query & " '" &  ProdQuantityAvailable  & "')"
		

'response.write(Query)	


Set DataConnection = Server.CreateObject("ADODB.Connection")
DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(databasepath) 	& ";" 
DataConnection.Execute(Query) 


DataConnection.Close
Set DataConnection = Nothing


Session("Step2") = True


End if


End if


'End if

%>

<!--#Include file="ClassifiedStep2Include.asp"-->



<!--#Include file="Footer.asp"--> </Body>
</HTML>
