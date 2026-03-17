<!DOCTYPE HTML>
<HTML>
<HEAD>
<title>Pricing Page</title>
<link rel="stylesheet" type="text/css" href="/style.css">
<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
<!--#Include file="MembersSecurityInclude.asp"-->
<!--#Include virtual="/Conn.asp"--> 
<% Current2="AddAlpaca" %> 
<!--#Include file="MembersHeader.asp"-->
<%
'rowcount = CInt
rowcount = 1

ID=Request.Form("ID")
if len(ID) > 0 then
else
ID = Request.querystring("ID")
end if

SpeciesID=Request.Form("SpeciesID")
if len(SpeciesID) > 0 then
else
SpeciesID= Request.querystring("SpeciesID")
end if

Price=Request.Form("Price") 
StudFee=Request.Form("StudFee") 
ForSale=Request.Form("ForSale") 
Foundation=Request.Form("Foundation") 
PriceComments=Request.Form("PriceComments") 
Discount=Request.Form("Discount") 
ShowOnStudPage=Request.Form("ShowOnStudPage") 
OBO=Request.Form("OBO") 
PayWhatYouCanAnimal=Request.Form("PayWhatYouCanAnimal") 
PayWhatYouCanStud=Request.Form("PayWhatYouCanStud") 
EmbryoPrice=Request.Form("EmbryoPrice") 
SemenPrice=Request.Form("SemenPrice") 
Donor=Request.Form("Donor") 
Free=Request.Form("Free") 
response.write("Free=" & Free)
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

Query =  "INSERT INTO Pricing (ID, "
if len(EmbryoPrice) > 0 then
Query =  Query & " EmbryoPrice, "
end if
if len(SemenPrice) > 0 then
Query =  Query & " SemenPrice, "
end if

Query =  Query & " StudFee, Price, Free, OBO, PayWhatYouCanStud, Forsale, Foundation, Discount, PriceComments  )" 
Query =  Query & " Values (" &  ID & "," 
if len(EmbryoPrice) > 0 then
Query =  Query & " '" & EmbryoPrice & "',"
end if
if len(SemenPrice) > 0 then
Query =  Query & " '" & SemenPrice & "',"
end if

Query =  Query & " '" & StudFee & "',"
Query =  Query & " '" & Price & "',"
Query =  Query & " " & Free & ","
Query =  Query & " " & OBO & ","
if len(PayWhatYouCanStud ) > 1 then
Query =  Query & " " & PayWhatYouCanStud & ","
else
Query =  Query & " False ,"
end if
Query =  Query & " " & ForSale & ","
Query =  Query & " " & Foundation & ","
Query =  Query & " " & Discount & ","
Query =  Query & " '" & PriceComments  & "')"
response.write("Query=" & query)
Conn.Execute(Query) 
Conn.close
set Conn = nothing
%><!--#Include virtual="/Conn.asp"--> 
<% Query =  " UPDATE Animals  Set CoOwnerName1 = '" & CoOwnerName1 & "', "
'	Query =  Query & " Donor= '" & Donor & "', "
	Query =  Query & " CoOwnerLink1 = '" & CoOwnerLink1 & "', "
	Query =  Query & " CoOwnerBusiness1 = '" & CoOwnerBusiness1 & "', "
	Query =  Query & " CoOwnerName2 = '" & CoOwnerName2 & "', "
	Query =  Query & " CoOwnerLink2 = '" & CoOwnerLink2 & "', "
	Query =  Query & " CoOwnerBusiness2 = '" & CoOwnerBusiness2 & "', "
	Query =  Query & " CoOwnerName3 = '" & CoOwnerName3 & "', "
	Query =  Query & " CoOwnerLink3 = '" & CoOwnerLink3 & "', "
	Query =  Query & " CoOwnerBusiness3 = '" & CoOwnerBusiness3 & "' "	
Query =  Query & " where ID = " & ID & ";" 
response.Write("Query=" & Query)
Conn.Execute(Query) 


End if



response.Redirect("EditAnimal.asp?wizard=True&PeopleID=" & PeopleID & "&ID="  & ID & "&JustAdded=True")
%>


</Body>
</HTML>
