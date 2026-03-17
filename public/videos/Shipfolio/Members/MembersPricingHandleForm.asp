<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<HEAD>
<base target="_self" />
<link rel="stylesheet" type="text/css" href="/style.css">
<!--#Include file="membersglobalvariables.asp"-->
<body>


<%
rowcount = 1
animalid=Request.Form("animalid") 
SpeciesID = request.Form("SpeciesID")
category = request.QueryString("category")
response.write("SpeciesID=" & SpeciesID )
Financeterms=  request.form("Financeterms")
Price=Request.Form("Price")

Price2=Request.Form("Price2")
Price3=Request.Form("Price3")
Price4=Request.Form("Price4")
MinOrder1=Request.Form("MinOrder1") 
MinOrder2=Request.Form("MinOrder2") 
MinOrder3=Request.Form("MinOrder3") 
MinOrder4=Request.Form("MinOrder4") 
MaxOrder1=Request.Form("MaxOrder1") 
MaxOrder2=Request.Form("MaxOrder2") 
MaxOrder3=Request.Form("MaxOrder3") 
MaxOrder4=Request.Form("MaxOrder4") 
Free = Request.form("Free")
ShowPrices=Request.Form("ShowPrices")
StartingPrice=Request.Form("StartingPrice") 
StudFee=Request.Form("StudFee") 
response.write("StudFee=" & StudFee )
ForSale=Request.Form("ForSale") 
PriceComments=Request.Form("PriceComments") 
Discount=Request.Form("Discount") 
Foundation=Request.Form("Foundation") 
Sold=Request.Form("Sold") 
SalePending=Request.Form("SalePending") 
OBO=Request.Form("OBO") 
PayWhatYouCanAnimal=Request.Form("PayWhatYouCanAnimal") 
PayWhatYouCanStud=Request.Form("PayWhatYouCanStud") 
'response.write("ForSale=" & ForSale)
dim ShippingToCountry(200)
dim ShippingCost1(200)

rowcount = 0
CountryTotalCount = request.form("CountryTotalCount")
while (rowcount < (CountryTotalCount+ 1) )
ShippingToCountrycount = "ShippingToCountry(" & rowcount & ")"
ShippingToCountry(rowcount)=Request.Form(ShippingToCountrycount)

ShippingCost1count = "ShippingCost1(" & rowcount & ")"
ShippingCost1(rowcount)=Request.Form(ShippingCost1count)

if len(ShippingCost1(rowcount)) > 0 then
else
ShippingCost1(rowcount) = " NULL "
end if

if len(ShippingToCountry(rowcount)) > 0 then
response.write("ShippingToCountry=" & ShippingToCountry(rowcount) & "<br>")
response.write("ShippingCost1=" & ShippingCost1(rowcount) & "<br>")

Query =  " UPDATE sfShipping Set ShippingCost1 = " &  ShippingCost1(rowcount) & " "
Query =  Query & " where ShippingToCountry = '" & ShippingToCountry(rowcount) & "' and AnimalID = " & animalid & ";" 

response.write("Query=" & Query & "<br>")

Conn.Execute(Query) 



end if


rowcount = rowcount +1
Wend

 rowcount =1
CoOwnerBusiness1 = request.form("CoOwnerBusiness1")
CoOwnerLink1 = request.form("CoOwnerLink1")
CoOwnerLink2 = request.form("CoOwnerLink2")
CoOwnerLink3 = request.form("CoOwnerLink3")

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


str1 = CoOwnerLink1
str2 = "'"
If InStr(str1,str2) > 0 Then
	CoOwnerLink1= Replace(str1,  str2, "''")
End If

str1 = lcase(CoOwnerLink1)
str2 = "http://"
If InStr(str1,str2) > 0 Then
	CoOwnerLink1= Replace(str1,  str2, "")
End If

str1 = lcase(CoOwnerLink1)
str2 = "http:/" 
If InStr(str1,str2) > 0 Then
	CoOwnerLink1= Replace(str1,  str2, "")
End If

str1 = lcase(CoOwnerLink1)
str2 = "http:" 
If InStr(str1,str2) > 0 Then
	CoOwnerLink1= Replace(str1,  str2, "")
End If

str1 = CoOwnerLink2
str2 = "'"
If InStr(str1,str2) > 0 Then
	CoOwnerLink2= Replace(str1,  str2, "''")
End If

str1 = lcase(CoOwnerLink2)
str2 = "http://"
If InStr(str1,str2) > 0 Then
	CoOwnerLink2= Replace(str1,  str2, "")
End If

str1 = lcase(CoOwnerLink2)
str2 = "http:/" 
If InStr(str1,str2) > 0 Then
	CoOwnerLink2= Replace(str1,  str2, "")
End If

str1 = lcase(CoOwnerLink2)
str2 = "http:" 
If InStr(str1,str2) > 0 Then
	CoOwnerLink2= Replace(str1,  str2, "")
End If


str1 = CoOwnerLink3
str2 = "'"
If InStr(str1,str2) > 0 Then
	CoOwnerLink3= Replace(str1,  str2, "''")
End If

str1 = lcase(CoOwnerLink3)
str2 = "http://"
If InStr(str1,str2) > 0 Then
	CoOwnerLink3= Replace(str1,  str2, "")
End If

str1 = lcase(CoOwnerLink3)
str2 = "http:/" 
If InStr(str1,str2) > 0 Then
	CoOwnerLink3= Replace(str1,  str2, "")
End If

str1 = lcase(CoOwnerLink3)
str2 = "http:" 
If InStr(str1,str2) > 0 Then
	CoOwnerLink3= Replace(str1,  str2, "")
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



str1 = Financeterms
str2 = "'"
If InStr(str1,str2) > 0 Then
	Financeterms= Replace(str1,  str2, "''")
End If

if ForSale  = "" then
	ForSale  = "1"
end if 

if Discount  = "" then
	Discount = "0"
end if 


if Price  = "" then
	Price = "0"
end if 

if Price  = "" then
	Price = "0"
end if 

if StartingPrice  = "" then
	StartingPrice = "0"
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

str1 = StartingPrice
str2 = ","
If InStr(str1,str2) > 0 Then
	Price= Replace(str1, ",", "")
End If

str1 = StartingPrice
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
	StudFee= Replace(str1, "$", "")
End If

Dim str1
Dim str2
str1 = PriceComments
str2 = "'"
If InStr(str1,str2) > 0 Then
	PriceComments= Replace(str1, "'", "''")
End If

If Len(showonASZ) > 0 Then

Else
   showonASZ = "No"
End If

Query =  " UPDATE Pricing Set " 
if len(Price) > 0 then
Query =  Query & " Price = " &  Price & "," 
else
Query =  Query & " Price = NULL," 
end if

if len(Price2) > 0 then
Query =  Query & " Price2 = " &  Price2 & "," 
else
Query =  Query & " Price2 = NULL," 
end if

if len(Price3) > 0 then
Query =  Query & " Price3 = " &  Price3 & "," 
else
Query =  Query & " Price3 = NULL," 
end if

if len(Price4) > 0 then
Query =  Query & " Price4 = " &  Price4 & "," 
else
Query =  Query & " Price4 = NULL," 
end if

if len(MinOrder1) > 0 then
Query =  Query & " MinOrder1 = " &  MinOrder1 & "," 
else
Query =  Query & " MinOrder1 = NULL," 
end if

if len(MinOrder2) > 0 then
Query =  Query & " MinOrder2 = " &  MinOrder2 & "," 
else
Query =  Query & " MinOrder2 = NULL," 
end if

if len(MinOrder3) > 0 then
Query =  Query & " MinOrder3 = " &  MinOrder3 & "," 
else
Query =  Query & " MinOrder3 = NULL," 
end if

if len(MinOrder4) > 0 then
Query =  Query & " MinOrder4 = " &  MinOrder4 & "," 
else
Query =  Query & " MinOrder4 = NULL," 
end if

if len(MaxOrder1) > 0 then
Query =  Query & " MaxOrder1 = " &  MaxOrder1 & "," 
else
Query =  Query & " MaxOrder1 = NULL," 
end if

if len(MaxOrder2) > 0 then
Query =  Query & " MaxOrder2 = " &  MaxOrder2 & "," 
else
Query =  Query & " MaxOrder2 = NULL," 
end if


if len(MaxOrder3) > 0 then
Query =  Query & " MaxOrder3 = " &  MaxOrder3 & "," 
else
Query =  Query & " MaxOrder3 = NULL," 
end if


if len(MaxOrder4) > 0 then
Query =  Query & " MaxOrder4 = " &  MaxOrder4 & "," 
else
Query =  Query & " MaxOrder4 = NULL," 
end if


if len(StartingPrice) > 0 then
Query =  Query & " StartingPrice = " &  StartingPrice & "," 
else
Query =  Query & " StartingPrice = NULL," 
end if
Query =  Query & " Forsale = " &  Forsale & "," 
if len(OBO) > 0 then
Query =  Query & " OBO = " &  OBO & ","
end if
 
 Query =  Query & " Financeterms = '" &  Financeterms & "'," 

if len(PayWhatYouCanStud) > 0 then
Query =  Query & " PayWhatYouCanStud = " &  PayWhatYouCanStud & "," 
end if 
if len(showprices) > 0 then
Query =  Query & " ShowPrices = " &  ShowPrices & "," 
end if
Query =  Query & " StudFee = " &  StudFee & "," 
if len(Foundation) > 0 then
Query =  Query & " Foundation = " &  Foundation & "," 
end if

if len(Sold) > 0 then
Query =  Query & " Sold = " &  Sold & "," 
else
Query =  Query & " Sold = 0," 
end if

if len(Salepanding) > 0 then
Query =  Query & " SalePending = " &  SalePending & ","
end if
Query =  Query & " Free = " &  Free & "," 
Query =  Query & " Discount = " &  Discount & "," 
Query =  Query & " PriceComments = '" &  PriceComments & "' " 
Query =  Query & " where animalid = " & animalid & ";" 

response.write(Query)	
Conn.Execute(Query) 

Query =  " UPDATE Animals  Set CoOwnerName1 = '" & CoOwnerName1 & "', "
	Query =  Query & " CoOwnerLink1 = '" & CoOwnerLink1 & "', "
	Query =  Query & " CoOwnerBusiness1 = '" & CoOwnerBusiness1 & "', "
	Query =  Query & " CoOwnerName2 = '" & CoOwnerName2 & "', "
	Query =  Query & " CoOwnerLink2 = '" & CoOwnerLink2 & "', "
	Query =  Query & " CoOwnerBusiness2 = '" & CoOwnerBusiness2 & "', "
	Query =  Query & " CoOwnerName3 = '" & CoOwnerName3 & "', "
	Query =  Query & " CoOwnerLink3 = '" & CoOwnerLink3 & "', "
	Query =  Query & " CoOwnerBusiness3 = '" & CoOwnerBusiness3 & "', "	
    Query =  Query & " Lastupdated = getdate() " 
Query =  Query & " where animalid = " & animalid & ";" 

'response.write(Query)	
Conn.Execute(Query) 
Conn.Close
Set Conn = Nothing 
rowcount= rowcount +1
response.redirect("MembersEditAnimalPricing.asp?animalid=" & animalid & "&SpeciesID=" & SpeciesID & "&category=" & category & "&changesmade=True")
%>
</Body>
</HTML>
