<!DOCTYPE HTML>
<HTML>
<HEAD>
<link rel="stylesheet" type="text/css" href="/administration/style.css">
<!--#Include file="AdminSecurityInclude.asp"-->
<!--#Include file="AdminGlobalvariables.asp"--> 
</head>
<body >

<!--#Include file="AdminHeader.asp"--> 

<%
'rowcount = CInt
rowcount = 1
Unownedanimal = request.querystring("Unownedanimal")
if Unownedanimal = "true" then
speciesid = request.Querystring("speciesid")
ID=Request.Querystring("ID")
Price=Request.Querystring("Price") 
StudFee=Request.Querystring("StudFee") 
ForSale=Request.Querystring("ForSale") 
ForStud=Request.Querystring("ForStud")
Foundation=Request.Querystring("Foundation") 
PriceComments=Request.Querystring("PriceComments") 
Discount=Request.Querystring("Discount") 
ShowOnStudPage=Request.Querystring("ShowOnStudPage") 
OBO=Request.Querystring("OBO") 
PayWhatYouCanAnimal=Request.Querystring("PayWhatYouCanAnimal") 
PayWhatYouCanStud=Request.Querystring("PayWhatYouCanStud") 
else
speciesid = request.Form("speciesid")
ID=Request.Form("ID")
Price=Request.Form("Price")
ForStud=Request.Form("ForStud")
StudFee=Request.Form("StudFee") 
ForSale=Request.Form("ForSale") 
Foundation=Request.Form("Foundation") 
PriceComments=Request.Form("PriceComments") 
Discount=Request.Form("Discount") 
ShowOnStudPage=Request.Form("ShowOnStudPage") 
OBO=Request.Form("OBO") 
PayWhatYouCanAnimal=Request.Form("PayWhatYouCanAnimal") 
PayWhatYouCanStud=Request.Form("PayWhatYouCanStud") 
end if
response.write("ForStud=" & ForStud)

CoOwnerBusiness1 = request.form("CoOwnerBusiness1")
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
CoOwnerLink1 = request.form("CoOwnerLink1")
str1 = CoOwnerLink1
str2 = "'"
If InStr(str1,str2) > 0 Then
	CoOwnerLink1= Replace(str1,  str2, "''")
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

CoOwnerLink2 = request.form("CoOwnerLink2")
str1 = CoOwnerLink2
str2 = "'"
If InStr(str1,str2) > 0 Then
	CoOwnerLink2= Replace(str1,  str2, "''")
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

CoOwnerLink3 = request.form("CoOwnerLink3")
str1 = CoOwnerLink3
str2 = "'"
If InStr(str1,str2) > 0 Then
	CoOwnerLink3= Replace(str1,  str2, "''")
End If



 rowcount =1

if ShowOnStudPage = "Yes" Then
ShowOnStudPage = True
else
	ShowOnStudPage = False
end if 

if Discount  = "" then
	Discount = "0"
end if 

if Price  = "" then
	Price = "0"
end if 


if ForStud = False then
ForStud = 0
else
ForStud = 1
end if

if ForSale = False then
ForSale = 0
else
ForSale = 1
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
	StudFee = Replace(str1, "$", "")
End If

Dim str1
Dim str2
str1 = PriceComments
str2 = "'"
If InStr(str1,str2) > 0 Then
	PriceComments= Replace(str1, "'", "''")
End If

StudFee = cDBL(StudFee)
Price = cDBL(Price)

sql2 = "select * from Pricing where ID = " &  ID & ";" 
'response.write(sql2)
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3   
If rs2.eof Then

Query =  "INSERT INTO Pricing (ID, Price, OBO, PayWhatYouCanStud, Forsale, StudFee, Foundation, Discount, PriceComments  )" 
Query =  Query & " Values (" &  ID & "," 
Query =  Query & " '" & Price & "',"
if len(OBO) > 1 then
Query =  Query & " " & OBO & ","
else
Query =  Query & "False,"
end if
if len(PayWhatYouCanStud ) > 1 then
Query =  Query & " " & PayWhatYouCanStud & ","
else
Query =  Query & " False ,"
end if
Query =  Query & " " & ForSale & ","
if len(ForStud) > 0 then
Query =  Query & " " & ForStud & ","
else
Query =  Query & " False,"
end if
Query =  Query & " " & Foundation & ","
Query =  Query & " " & Discount & ","
Query =  Query & " '" & PriceComments  & "')"
response.Write("Query=" & Query)

Conn.Execute(Query) 
	
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

Conn.Execute(Query) 
	
End if
response.Redirect("AdminAnimalEdit.asp?wizard=True&PeopleID=" & PeopleID & "&ID="  & ID & "&JustAdded=True&speciesid=" & speciesid)
%>


</Body>
</HTML>
