<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<HEAD>
<base target="_self" />
<link rel="stylesheet" type="text/css" href="/style.css">
<!--#Include file="adminglobalvariables.asp"-->
<% if mobiledevice = True or is_iPad = true then %>
<body>
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
<% end if %>

<%
rowcount = 1
ID=Request.Form("ID") 
Price=Request.Form("Price")
StartingPrice=Request.Form("StartingPrice") 
StudFee=Request.Form("StudFee") 
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

If Sold = "No" Then
   Sold = 0
End If
If Sold = "Yes" Then
   Sold = 1
End If

If Forsale = "No" Then
   Forsale = 0
End If
If Forsale = "Yes" Then
   Forsale = 1
End If

Query =  " UPDATE Pricing Set Price = " &  Price & ", " 
Query =  Query & " StartingPrice = " &  StartingPrice & "," 
Query =  Query & " Forsale = " &  Forsale & "," 
Query =  Query & " OBO = " &  OBO & "," 
if len(PayWhatYouCanStud) > 0 then
Query =  Query & " PayWhatYouCanStud = " &  PayWhatYouCanStud & "," 
end if 
Query =  Query & " StudFee = " &  StudFee & "," 
Query =  Query & " Foundation = " &  Foundation & "," 
Query =  Query & " Sold = " &  Sold & "," 
Query =  Query & " SalePending = " &  SalePending & ","
Query =  Query & " Discount = " &  Discount & "," 
Query =  Query & " PriceComments = '" &  PriceComments & "'" 
Query =  Query & " where ID = " & ID & ";" 

response.write(Query)	

Set DataConnection = Server.CreateObject("ADODB.Connection")
DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) 	& ";" 
DataConnection.Execute(Query) 
	DataConnection.Close
	Set DataConnection = Nothing 

Query =  " UPDATE Animals  Set CoOwnerName1 = '" & CoOwnerName1 & "', "
	Query =  Query & " CoOwnerLink1 = '" & CoOwnerLink1 & "', "
	Query =  Query & " CoOwnerBusiness1 = '" & CoOwnerBusiness1 & "', "
	Query =  Query & " CoOwnerName2 = '" & CoOwnerName2 & "', "
	Query =  Query & " CoOwnerLink2 = '" & CoOwnerLink2 & "', "
	Query =  Query & " CoOwnerBusiness2 = '" & CoOwnerBusiness2 & "', "
	Query =  Query & " CoOwnerName3 = '" & CoOwnerName3 & "', "
	Query =  Query & " CoOwnerLink3 = '" & CoOwnerLink3 & "', "
	Query =  Query & " CoOwnerBusiness3 = '" & CoOwnerBusiness3 & "' "	
Query =  Query & " where ID = " & ID & ";" 

'response.write(Query)	
Set DataConnection = Server.CreateObject("ADODB.Connection")
DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) 	& ";" 
DataConnection.Execute(Query) 
	DataConnection.Close
	Set DataConnection = Nothing 
	  rowcount= rowcount +1
response.redirect("AdminPricingFrame.asp?ID=" & ID & "&changesmade=True")
%>
</Body>
</HTML>
