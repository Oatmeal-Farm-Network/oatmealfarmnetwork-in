<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<title>Alpaca Infinity Membersistration</title>
<meta name="Title" content="Alpaca Infinity Membersistration"/>
<meta name="robots" content="nofollow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="revisit-after" content="1"/>
<meta name="Googlebot" content="nofollow"/>
<link rel="shortcut icon" href="/infinityknot.ico" /> 
<link rel="icon" href="http://www.alpacainfinity.com/alpacachamps/infinityknot.ico" /> 
<meta name="author" content="The Andresen Group"/>
<link rel="stylesheet" type="text/css" href="/style.css" />

</HEAD>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center" >
<!--#Include file="MembersGlobalVariables.asp"-->
<!--#Include file="MembersSecurityInclude.asp"-->
    <% 
   Current2="Products"
   Current3="AddProduct" %> 

   <!--#Include file="MembersHeader.asp"-->

<br>
<!--#Include file="MembersProductsTabsInclude.asp"-->

     <table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth %>" class = "roundedtopandbottom" ><tr><td align = "left"><br />
     <table  height = "300"  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>
<td valign = "top">
<%
		
			Dim ColorArray(100)

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
		Dim PeopleID
		Dim AdType
		Dim ProdCity
		Dim ProdPartOfTown
		Dim ProdZip


	PeopleID=session("PeopleID" ) 
	ProdId=Request.Form( "ProdId" ) 
	'response.Write("ProdID=" & ProdID )
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
	
	For x = 1 To 80
		ColorArray(x)=Request.Form( "Color" & x ) 
	next
	

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


For x = 1 To 80
		 TempVar = ColorArray(x) %>
		<!--#Include file="CheckApostropheInclude.asp"--> 
	<% 
	ColorArray(x) = TempVar
	
	Next %>



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


str1 = ProdDimensions
str2 = "'"
If InStr(str1,str2) > 0 Then
	ProdDimensions = Replace(str1, "'", "''")
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

If 	Session("Step2") = false then
			
	ProdNameFound = False
 


	If ProdNameFound = False then
	sql2 = "select * from sfProducts  order by ProdID"

'response.write(sql2)
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

	sql2 = "select * from sfProducts  where PeopleID = " & session("PeopleID") & " and  ProdName = '" & ProdName & "';"

'response.write(sql2)
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	if rs2.eof then
 session("ID") = ProdID
session("ProdID") = ProdID

	Query =  "INSERT INTO SFProducts (PeopleID,  ProdName,  "
	For x= 1 To 10
		Query =  Query & " ProdSize" & x & ", "
	next
	For x= 1 To 80
		Query =  Query & " Color" & x & ", "
	Next
	Query =  Query & " ProdMadeIn , ProdFiberType1, ProdFiberType2, ProdFiberType3, ProdFiberType4, ProdFiberType5, prodFiberPercent1, prodFiberPercent2, prodFiberPercent3, prodFiberPercent4, prodFiberPercent5, ProdDimensions, prodCategoryId, prodSubCategoryId, ProdPrice,  ProdDescription, ProdForSale, prodweight, ProdQuantityAvailable)" 
		Query =  Query & " Values (" &  PeopleID & "," 
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
		
		For x = 1 To 80
			Query =  Query & " '" &  ColorArray(x)  & "',"
		Next 
		

		Query =  Query & " '" &  ProdMadeIn & "',"
		Query =  Query & " '" &  ProdFiberType1 & "',"
		Query =  Query & " '" &  ProdFiberType2 & "',"
		Query =  Query & " '" &  ProdFiberType3 & "',"
		Query =  Query & " '" &  ProdFiberType4 & "',"
		Query =  Query & " '" &  ProdFiberType5 & "',"
		Query =  Query & " " &  prodFiberPercent1 & "," 
		Query =  Query & " " &  prodFiberPercent2 & "," 
		Query =  Query & " " &  prodFiberPercent3 & "," 
		Query =  Query & " " &  prodFiberPercent4 & "," 
	    Query =  Query & " " &  prodFiberPercent5 & "," 

		Query =  Query & " '" &  ProdDimensions & "'," 
		Query =  Query & " " &  box1 & "," 
		Query =  Query & " "  &  box2ID & "," 
		Query = Query & " '"  &  ProdPrice & "'," 
		Query =  Query & " '" &  ProdDescription & "'," 
		Query =  Query & " "  & ProdForSale & "," 
		Query =  Query & " "  & ProdWeight & "," 
		Query =  Query & " '" &  ProdQuantityAvailable  & "')"
Conn.Execute(Query) 
Conn.close
Set Conn = Nothing
%>
<!--#Include virtual="/Conn.asp"-->

<% 
sql3 = "select ProdID from sfProducts  where PeopleID = " & session("PeopleID") & " and  ProdName = '" & ProdName & "' order by ProdID Desc;"
'response.write("sql3=" & sql3)
	Set rs3 = Server.CreateObject("ADODB.Recordset")
	rs3.Open sql3, conn, 3, 3 
	if not rs3.eof then
	    ProdID = rs3("ProdID")
	    session("ProdID") = ProdID
	end if
	   rs3.Close
Conn.close
Set Conn = Nothing
'response.write("ProdID=" & ProdID)
%>
<!--#Include virtual="/Conn.asp"-->

<% 	
Query =  "INSERT INTO ProductsPhotos (ID)" 
Query =  Query & " Values (" &  prodID & ")"
Conn.Execute(Query) 
			
Conn.Close
Set Conn = Nothing
end if
Session("Step2") = True

End if
End if

'End if

%>

<!--#Include file="ClassifiedStep2Include.asp"-->
</td>
</tr>
</table>


<!--#Include virtual="/Footer.asp"--> </Body>
</HTML>
