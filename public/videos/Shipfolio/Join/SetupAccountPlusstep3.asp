<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ Language="VBScript" %> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%  PageName = "Registry" %>
<!--#Include virtual="/GlobalVariables.asp"-->
<meta http-equiv="Content-Language" content="en-us">
<title>Create Account - <%=WebSiteName %> Online Animal Marketplace</title>
<meta name="Title" content="Create Account - <%=WebSiteName %> Online Animal Marketplace">
<meta name="description" content="Create your account at <%=WebSiteName %> - Animals for Sale." >
<meta name="robots" content="index, nofollow">
<meta name="revisit-after" content="never">
<meta name="author" content="Livestock Of The World">
<link rel="stylesheet" type="text/css" href="/Style.css">

<% '********************************************************************************
showcoupons = false
showyears = False
showdonation = False
donationsavailable = False

OrderTotal = "98.00"


PeopleFirstName=request.form("PeopleFirstName")
PeopleLastName=request.form("PeopleLastName")
BusinessName=request.form("BusinessName")
PeopleWebsite=request.form("PeopleWebsite")
PeopleEmail=request.form("PeopleEmail")
password=request.form("password")


Owner=request.form("Owner")
AddressStreet=request.form("AddressStreet")
AddressApt=request.form("AddressApt")
AddressCity=request.form("AddressCity")
AddressZip=request.form("AddressZip")
country=request.form("country")
state=request.form("state")
PeoplePhone=request.form("PeoplePhone")

'response.write("PeopleFirstName = " & PeopleFirstName )
'response.write("PeopleLastName = " & PeopleLastName )
'response.write("Owners = " & Owners)
'response.write("BusinessName = " & BusinessName )
'response.write("PeopleWebsite = " & PeopleWebsite )
'response.write("country = " & country )
'response.write("PeopleEmail  = " & PeopleEmail )
'response.write("password= " & password )

'response.write("Owner = " & Owner )
'response.write("AddressStreet = " & AddressStreet )
'response.write("AddressApt = " & AddressApt)
'response.write("AddressCity = " & AddressCity )
'response.write("AddressZip = " & AddressZip )
'response.write("country = " & country )
'response.write("state  = " & state )
'response.write("PeoplePhone= " & PeoplePhone )


Membership = Request.Form("Membership")
if len(Membership) > 0 then
else
Membership = Request.querystring("Membership")
end if

if len(Membership) > 0 then
else
Membership = session("Membership")
end if

if len(Membership) > 0 then
session("Membership") = Membership
end if

Membership = lcase(Membership)

website = request.querystring("website") 

if len(website) > 0 then
else
website = request.form("website") 
end if

websitesignupcount = 0


if len(Peopleemail) > 0  then
session("Peopleemail") = PeopleEmail
else
Peopleemail =Request.querystring("PeopleEmail") 
end if

if len(Peopleemail) > 0  then
session("Peopleemail") = PeopleEmail
else
Peopleemail =session("Peopleemail")
end if

For x=1 To 8 
Randomize
' select a number between 26 and 97
random_number =  Int(26 * Rnd + 97)
membership=request.form("membership")
' take the numeric and turn it into a character
random_letter = UCase(Chr(random_number))
ActivationCode = ActivationCode & random_letter

Next
ActivationCode = day(now) & month(now) & Year(now) & ActivationCode & Left(TempLastName, 1)

%>
</head>
<% if mobiledevice = True or is_iPad = true then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth + '&website=<%=website %>&Membership=<%=Membership %>&peopleId=<%=peopleId %>');" class = "body" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<% end if%>
<% Current = "Home"
Current3="Register"
'CurrentWebsite = "LivestockofAmerica" 
session("LoggedIn") = False%>
<!--#Include virtual="/Header.asp"-->
<% if screenwidth > 700 then %>
<!--#Include virtual="/join/JoinHeader.asp"-->
<% end if %> 


<table border = "0" cellspacing="0" cellpadding = "5" align = "center" width = "480" height = "100"  valign = "top" >
<tr><td class = "body" valign = top>
<h1>Create Your Account</h1>

<% 
If not session("Confirmationsent") = True then


'PeopleID = Request.querystring("PeopleID")
'if len(PeopleID) > 0 then
'else
'PeopleID = Request.form("PeopleID")
'end if 


associations = Request.querystring("associations")
if len(associations) > 0 then
else
associations = Request.form("associations")
end if 

if len(Update) < 1 then
  if len(Session("Update")) > 1 then
     Update = "True"
  else
  Update = "False"
  end if
end if
ExistingAccount =True
Update = "True" 
if ExistingAccount =True then

if ExistingAccount = False or Update = "True"  then
if len(PeopleID)> 0 then
sql = "select  AddressID, WebsitesID, BusinessID, PeopleFirstName, PeopleID  from People where PeopleID = " & PeopleID & ""
'response.write("sql=" & sql)
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	ExistingEvent = False
	If Not rs.eof Then
    	PeopleID  =rs("PeopleID") 
		AddressID  =rs("AddressID") 
		WebsitesID  =rs("WebsitesID") 
		BusinessID  =rs("BusinessID") 
        PeopleFirstName = rs("PeopleFirstName")
End If 
rs.close


sql = "select addresscountry from Address where AddressID = " & AddressID & " order by AddressID Desc"
 rs.Open sql, conn, 3, 3   
If Not rs.eof Then
	addresscountry = rs("addresscountry")
End If 

end if

if lcase(addresscountry) = "Canada" then %><br>
<big>Since, your business is in Canada, your animals will appear on LivestockOfCanada.com.</big><br><br>
<% end if 

if (addresscountry = "United States (USA)" or lcase(addresscountry) = "united states") then %><br>
<big>Since, your business is in the United States, your animals will appear on LivestockOfAmerica.com.</big><br><br>
<% 
addresscountry = "USA"

end if 

end if


BusinessName = Request.Form("BusinessName")

if len(trim(Owners)) > 1 then
else
Owners = PeopleFirstName  & " " & PeopleLastName
end if

str1 = BusinessName 
str2 = "'"
If InStr(str1,str2) > 0 Then
	BusinessName = Replace(str1,  str2, "''")
End If 

str1 = Owners
str2 = "'"
If InStr(str1,str2) > 0 Then
	Owners= Replace(str1,  str2, "''")
End If  

str1 = PeopleFirstName
str2 = "'"
If InStr(str1,str2) > 0 Then
	PeopleFirstName= Replace(str1,  str2, "''")
End If  

str1 = PeopleLastName
str2 = "'"
If InStr(str1,str2) > 0 Then
	PeopleLastName= Replace(str1,  str2, "''")
End If  


str1 = PeopleTitleID
str2 = "'"
If InStr(str1,str2) > 0 Then
	PeopleTitleID= Replace(str1,  str2, "''")
End If  


str1 = PeopleWebsite
str2 = "'"
If InStr(str1,str2) > 0 Then
	PeopleWebsite= Replace(str1,  str2, "''")
End If  

str1 = lcase(PeopleWebsite)
str2 = "http://"
If InStr(str1,str2) > 0 Then
	PeopleWebsite= right(PeopleWebsite, len(PeopleWebsite) - 7)
End If  


str1 = PeopleEmail
str2 = "'"
If InStr(str1,str2) > 0 Then
	PeopleEmail= Replace(str1,  str2, "''")
End If 


str1 = confirm
str2 = "'"
If InStr(str1,str2) > 0 Then
	confirm= Replace(str1,  str2, "''")
End If 

str1 = AddressStreet
str2 = "'"
If InStr(str1,str2) > 0 Then
	AddressStreet= Replace(str1,  str2, "''")
End If 

str1 = StreetApt
str2 = "'"
If InStr(str1,str2) > 0 Then
	StreetApt= Replace(str1,  str2, "''")
End If 

str1 = AddressApt 
str2 = "'"
If InStr(str1,str2) > 0 Then
	AddressApt= Replace(str1,  str2, "''")
End If

str1 = AddressCity
str2 = "'"
If InStr(str1,str2) > 0 Then
	AddressCity= Replace(str1,  str2, "''")
End If

str1 = AddressZip
str2 = "'"
If InStr(str1,str2) > 0 Then
	AddressZip= Replace(str1,  str2, "''")
End If

str1 = PeoplePhone
str2 = "'"
If InStr(str1,str2) > 0 Then
	PeoplePhone= Replace(str1,  str2, "''")
End If

str1 = PeopleCell
str2 = "'"
If InStr(str1,str2) > 0 Then
	PeopleCell= Replace(str1,  str2, "''")
End If

str1 = PeopleFax 
str2 = "'"
If InStr(str1,str2) > 0 Then
	PeopleFax= Replace(str1,  str2, "''")
End If


Dim str1
Dim str2

Query =  "INSERT INTO Websites (Website)" 
Query =  Query + " Values ('" & PeopleWebsite & "')" 
Conn.Execute(Query) 


sql = "select WebsitesID from Websites where Website = '" & PeopleWebsite & "' order by WebsitesID Desc"
'response.write(sql)
Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	ExistingEvent = False
	If Not rs.eof Then
		WebsitesID = rs("WebsitesID")
	End If 
rs.close

if len(BusinessID) < 1 then
Query =  "INSERT INTO Business (BusinessName)" 
Query =  Query & " Values ('" & BusinessName & "')" 
Conn.Execute(Query) 
	
sql = "select BusinessID from Business where BusinessName = '" & BusinessName & "' order by BusinessID Desc"

		
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	ExistingEvent = False
	If Not rs.eof Then
		BusinessID = rs("BusinessID")
	End If 
rs.close
end if





'response.write("Website query = " & Query & "<br>")	

Conn.Execute(Query) 

 sql = "select AddressID from Address where AddressStreet = '" & AddressStreet & "' and AddressCity= '" & AddressCity & "' and AddressZip = '" & AddressZip  & "' order by AddressID Desc"
'response.write(sql)
		
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	ExistingEvent = False
	If Not rs.eof Then
		AddressID = rs("AddressID")
		else 
		ExistingSite = False
		Update = "False"
	End If 
rs.close

		Query =  "INSERT INTO Address (AddressStreet, AddressApt, AddressCity, AddressState, AddressCountry, AddressZip)" 
	    Query =  Query + " Values ('" & AddressStreet  & "'," 
	    Query =  Query & " '" &  AddressApt & "', " 
		Query =  Query & " '" &  AddressCity & "', " 
		Query =  Query & " '" &  AddressState & "', " 
        Query =  Query & " '" &  AddressCountry & "', " 
		Query =  Query & " '" &  AddressZip & "')" 
Conn.Execute(Query) 
'response.Write("Query=" & Query )


sql = "select AddressID from Address  Order by AddressID Desc"
		
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	ExistingEvent = False
	If Not rs.eof Then
		AddressID  =rs("AddressID") 
	End If 

rs.close



daynow= day(now)
monthnow = month(now)
yearnow = year(now)
datenow = monthnow & "/" & daynow & "/" & yearnow
if membership = "FreeTrial" then
datenownext = DateAdd("m", 6, datenow)
else

years = request.form("years")
if len(years) > 0 then
else
years = 1
end if
if len(animals) > 0 then
else
animals = 5
end if


datenownext =  monthnow & "/" & daynow & "/" & (yearnow + years )
end if

datenownextlife =  monthnow & "/" & daynow & "/" & (yearnow + 20 )
'response.write("years = " & years)
'response.write("datenownext  = " & datenownext )
'response.write("datenownextlife  = " & datenownextlife )


		Query =  "INSERT INTO People (AddressID, ActivationCode, CustCountry, Custstate, ReferringPeopleID, WebsitesID, Accesslevel, custAIStartService, custAIEndService, SubscriptionLevel, MaxAnimals, maxHerdsires, MaxProducts,  FreeMassEmailsPaidFor, FreeMassEmailsUsed, HomepageadsPaidfor, HomepageadsUsed, HeaderadsPaidfor, HeaderadsUsed, FreeAnimalEntryPaidFor, FreeAnimalEntryUsed, AISubscription, AESubscription, Owners, BusinessID,  PeopleFirstName, PeopleLastName, PeoplePhone, Peopleemail, Peoplefax, PeopleCell, PeopleActive,  PeoplePassword , PeopleCreationDate )" 
		Query =  Query & " Values (" &  AddressID & ","
        Query =  Query & " '" &   ActivationCode & "', "
        Query =  Query & " '" &   country & "', " 
        Query =  Query & " '" &   state & "', " 
        Query =  Query & "0 , " 
		Query =  Query & " " &   WebsitesID & ", " 
		Query =  Query & " -1 , " 

        Query =  Query & " ' " & cstr(FormatDateTime(datenow,2)) & " ', " 'custAIStartService
        Query =  Query & " ' " & cstr(FormatDateTime(dateadd("yyyy", 1, datenow),2)) & " ', " 'custAIEndService
        Query =  Query & " 4 , " 'SubscriptionLevel
        Query =  Query & " 500, "  'MaxAnimal
        Query =  Query & " 500 , " 'maxHerdsires
        Query =  Query & " 500 , " 'MaxProducts
        Query =  Query & " 0 , " 'FreeMassEmailsPaidFor
        Query =  Query & " 0 , " 'FreeMassEmailsUsed
        Query =  Query & " 0 , " 'HomepageadsPaidfor
        Query =  Query & " 0 , " 'HomepageadsUsed
        Query =  Query & " 0 , " 'HeaderadsPaidfor
        Query =  Query & " 0 , " 'HeaderadsUsed
        Query =  Query & " 0 , " 'FreeAnimalEntryPaidFor
        Query =  Query & " 0 , " 'FreeAnimalEntryUsed
		Query =  Query & " 1 , " 	
		Query =  Query & " 1 , " 
		Query =  Query & " '" &   Owners & "', " 
		Query =  Query & " " &   BusinessID & ", " 
 		Query =  Query & " '" &  PeopleFirstName & "', " 
		Query =  Query & " '" &  PeopleLastName & "', " 
		Query =  Query & " '" &  PeoplePhone & "', " 
		Query =  Query & " '" &  Peopleemail & "', " 
		Query =  Query & " '" &  Peoplefax & "', " 
		Query =  Query & " '" &  Peoplecell & "', " 
		Query =  Query & "'-1', " 
        Query =  Query & " '" &  password & "', " 
		Query =  Query & " CURRENT_TIMESTAMP) "
'response.Write("Query = " & Query)

Conn.Execute(Query)


 sql = "select PeopleID, PeopleFirstName from People where AddressID = " & AddressID  & " order by PeopleID Desc;"
Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	If Not rs.eof Then
		PeopleID = rs("PeopleID")
		session("PeopleID") = PeopleID
        PeopleFirstName = rs("PeopleFirstName")
	End If 
rs.close


   if len(PeopleTitleID) > 0 then 
	sql = "select PeopleTitle from PeopleTitleLookup where PeopleTitleID = " & PeopleTitleID & ""
    'response.write(sql)
		
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	ExistingEvent = False
	If Not rs.eof Then
        PeopleTitle = rs("PeopleTitle")
    end if 
end if


Session("LoggedIn") = False
Response.Cookies("LoggedIn")= False
Response.Cookies("PeopleFirstName")= PeopleFirstName
Session("Update") = true
 
' response.write("Membership=" & Membership )
if len(PeopleID) > 0 then
'response.write("PeopleID=" & PeopleID)	
'response.write("AddressID=" & AddressID)	
else
sql = "select PeopleID from People where AddressID = " & AddressID  & " order by PeopleID Desc;"
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	If Not rs.eof Then
		PeopleID = rs("PeopleID")
		session("PeopleID") = PeopleID
		Response.Cookies("PeopleID")= PeopleID
	End If 
rs.close

end if
 
'
'Remove second single quote before displaying data
'
str1 = PeopleFirstName
str2 = "''"
If InStr(str1,str2) > 0 Then
	PeopleFirstName= Replace(str1,  str2, "'")
End If  

str1 = Owners
str2 = "''"
If InStr(str1,str2) > 0 Then
	Owners= Replace(str1,  str2, "'")
End If 

str1 = BusinessName
str2 = "''"
If InStr(str1,str2) > 0 Then
	BusinessName= Replace(str1,  str2, "'")
End If 

str1 = PeopleFirstName
str2 = "''"
If InStr(str1,str2) > 0 Then
	PeopleFirstName= Replace(str1,  str2, "'")
End If 

str1 = PeopleLastName
str2 = "''"
If InStr(str1,str2) > 0 Then
	PeopleLastName= Replace(str1,  str2, "'")
End If  

str1 = PeopleTitleID
str2 = "''"
If InStr(str1,str2) > 0 Then
	PeopleTitleID= Replace(str1,  str2, "'")
End If  

str1 = PeopleWebsite
str2 = "''"
If InStr(str1,str2) > 0 Then
	PeopleWebsite= Replace(str1,  str2, "'")
End If  

str1 = PeopleEmail
str2 = "''"
If InStr(str1,str2) > 0 Then
	PeopleEmail= Replace(str1,  str2, "'")
End If 


str1 = confirm
str2 = "''"
If InStr(str1,str2) > 0 Then
	confirm= Replace(str1,  str2, "'")
End If 

str1 = AddressStreet
str2 = "''"
If InStr(str1,str2) > 0 Then
	AddressStreet= Replace(str1,  str2, "'")
End If 

str1 = StreetApt
str2 = "''"
If InStr(str1,str2) > 0 Then
	StreetApt= Replace(str1,  str2, "'")
End If 

str1 = AddressApt 
str2 = "''"
If InStr(str1,str2) > 0 Then
	AddressApt= Replace(str1,  str2, "'")
End If

str1 = AddressCity
str2 = "''"
If InStr(str1,str2) > 0 Then
	AddressCity= Replace(str1,  str2, "'")
End If

str1 = AddressZip
str2 = "''"
If InStr(str1,str2) > 0 Then
	AddressZip= Replace(str1,  str2, "'")
End If

str1 = PeoplePhone
str2 = "''"
If InStr(str1,str2) > 0 Then
	PeoplePhone= Replace(str1,  str2, "'")
End If

str1 = PeopleCell
str2 = "''"
If InStr(str1,str2) > 0 Then
	PeopleCell= Replace(str1,  str2, "'")
End If

str1 = PeopleFax 
str2 = "''"
If InStr(str1,str2) > 0 Then
	PeopleFax= Replace(str1,  str2, "'")
End If





If ExistingAccount = False Then
Query =  "INSERT INTO emaillist (ReceiveEmails, EmailFirstName, EmailLastName, "

if  InStr(Interest, "Products") > 0  Then
Query =  Query & " Products, "
end if 

if  InStr(Interest, "Alpacas") > 0  Then
Query =  Query & " Alpacas, "
end if

if  InStr(Interest, "Bison") > 0  Then
Query =  Query & " Bison, "
end if 

if  InStr(Interest, "Cattle") > 0  Then
Query =  Query & " Cattle, "
end if 

if  InStr(Interest, "Chickens") > 0  Then
Query =  Query & " Chickens, "
end if 

if  InStr(Interest, "Dogs") > 0  Then
Query =  Query & " Dogs, "
end if 

if  InStr(Interest, "Donkeys") > 0  Then
Query =  Query & " Donkeys, "
end if 

if  InStr(Interest, "Goats") > 0  Then
Query =  Query & " Goats, "
end if 
if  InStr(Interest, "Horses") > 0  Then
Query =  Query & " Horses, "
end if 

if  InStr(Interest, "Llamas") > 0  Then
Query =  Query & " Llamas, "
end if 

if  InStr(Interest, "Pigs") > 0  Then
Query =  Query & " Pigs, "
end if 

if  InStr(Interest, "Rabbits") > 0  Then
Query =  Query & " Rabbits, "
end if 

if  InStr(Interest, "Sheep") > 0  Then
Query =  Query & " Sheep, "
end if 
 
if  InStr(Interest, "Turkeys") > 0  Then
Query =  Query & " Turkeys, "
end if 

if  InStr(Interest, "Yaks") > 0  Then
Query =  Query & " Yaks, "
end if 


 Query =  Query & " Address)" 
Query =  Query & " Values (1,"
Query =  Query &   " '" & FirstName & "' , " 
Query =  Query &    " '" & lastName & "',"
if  InStr(Interest, "Products") > 0  Then
Products = True
Query =  Query & " 1, "
end if 
if  InStr(Interest, "Alpacas") > 0  Then
Alpacas = True
Query =  Query & " 1, "
end if 

if  InStr(Interest, "Bison") > 0  Then
Bison = True
Query =  Query & " 1, "
end if

if  InStr(Interest, "Cattle") > 0  Then
Cattle = True
Query =  Query & " 1, "
end if 

if  InStr(Interest, "Chickens") > 0  Then
Chickens = True
Query =  Query & " 1, "
end if 

if  InStr(Interest, "Dogs") > 0  Then
Dogs = True
Query =  Query & " 1, "
end if 

if  InStr(Interest, "Donkeys") > 0  Then
Donkeys = True
Query =  Query & " 1, "
end if 

if  InStr(Interest, "Goats") > 0  Then
Goats = True
Query =  Query & " 1, "
end if 

if  InStr(Interest, "Horses") > 0  Then
Horses = True
Query =  Query & " 1, "
end if

if InStr(Interest, "Llamas") > 0  Then
Llamas = True
Query =  Query & " 1, "
end if 

if  InStr(Interest, "Pigs") > 0  Then
Pigs = True
Query =  Query & " 1, "
end if 

if InStr(Interest, "Rabbits") > 0  Then
Rabbits = True
Query =  Query & " 1, "
end if 

if  InStr(Interest, "Sheep") > 0  Then
Sheep = True
Query =  Query & " 1, "
end if 

if  InStr(Interest, "Turkeys") > 0  Then
Turkeys = True
Query =  Query & " 1, "
end if 
 
if  InStr(Interest, "Yaks") > 0  Then
Yaks = True
Query =  Query & " 1, "
end if 

Query =  Query &   " '" & Email  & "' )" 
'response.write("Query=" & Query )
conn.Execute(Query) 


Products = False
Alpacas = False
Bison = False
Cattle = False
Chickens = False
Dogs = False
Donkeys = False
Goats = False
Horses = False
Llamas = False
Pigs = False
Rabbits = False
Sheep = False
Turkeys = False
Yaks = False

if  InStr(Raise, "Alpacas") > 0  Then
Alpacas = True
end if 

if  InStr(Raise, "Bison") > 0  Then
Bison = True
end if

if  InStr(Raise, "Cattle") > 0  Then
Cattle = True
end if 

if  InStr(Raise, "Chickens") > 0  Then
Chickens = True
end if 

if  InStr(Raise, "Dogs") > 0  Then
Dogs = True
end if 

if  InStr(Raise, "Donkeys") > 0  Then
Donkeys = True
end if 

if  InStr(Raise, "Goats") > 0  Then
Goats = True
end if 

if  InStr(Raise, "Horses") > 0  Then
Horses = True
end if

if InStr(Raise, "Llamas") > 0  Then
Llamas = True
end if 

if  InStr(Raise, "Pigs") > 0  Then
Pigs = True
end if 

if InStr(Raise, "Rabbits") > 0  Then
Rabbits = True
end if 

if  InStr(Raise, "Sheep") > 0  Then
Sheep = True
end if 

if  InStr(Raise, "Turkeys") > 0  Then
Turkeys = True
end if 
 
if  InStr(Raise, "Yaks") > 0  Then
Yaks = True
end if 

if  InStr(Raise, "Other") > 0  Then
Other = True
end if 



If Alpacas = True then
Query =  "INSERT INTO Ranchspecieslookuptable (PeopleID, SpeciesID) "
Query =  Query & " Values (" & PeopleID & " , 2)"
conn.Execute(Query) 
end if

If Bison = True then
Query =  "INSERT INTO Ranchspecieslookuptable (PeopleID, SpeciesID) "
Query =  Query & " Values (" & PeopleID & " , 9)"
conn.Execute(Query) 
end if

If Cattle = True then
Query =  "INSERT INTO Ranchspecieslookuptable (PeopleID, SpeciesID) "
Query =  Query & " Values (" & PeopleID & " , 8)"
conn.Execute(Query) 
end if

If Chickens = True then
Query =  "INSERT INTO Ranchspecieslookuptable (PeopleID, SpeciesID) "
Query =  Query & " Values (" & PeopleID & " , 13)"
conn.Execute(Query) 
end if

If Dogs = True then
Query =  "INSERT INTO Ranchspecieslookuptable (PeopleID, SpeciesID) "
Query =  Query & " Values (" & PeopleID & " , 3)"
conn.Execute(Query) 
end if

If Donkeys = True then
Query =  "INSERT INTO Ranchspecieslookuptable (PeopleID, SpeciesID) "
Query =  Query & " Values (" & PeopleID & " , 7)"
conn.Execute(Query) 
end if

If Goats = True then
Query =  "INSERT INTO Ranchspecieslookuptable (PeopleID, SpeciesID) "
Query =  Query & " Values (" & PeopleID & " , 6)"
conn.Execute(Query) 
end if

If Horses = True then
Query =  "INSERT INTO Ranchspecieslookuptable (PeopleID, SpeciesID) "
Query =  Query & " Values (" & PeopleID & " , 5)"
conn.Execute(Query) 
end if

If Llamas = True then
Query =  "INSERT INTO Ranchspecieslookuptable (PeopleID, SpeciesID) "
Query =  Query & " Values (" & PeopleID & " , 4)"
conn.Execute(Query) 
end if

If Pigs = True then
Query =  "INSERT INTO Ranchspecieslookuptable (PeopleID, SpeciesID) "
Query =  Query & " Values (" & PeopleID & " , 12)"
conn.Execute(Query) 
end if

If Rabbits = True then
Query =  "INSERT INTO Ranchspecieslookuptable (PeopleID, SpeciesID) "
Query =  Query & " Values (" & PeopleID & " , 11)"
conn.Execute(Query) 
end if

If Sheep = True then
Query =  "INSERT INTO Ranchspecieslookuptable (PeopleID, SpeciesID) "
Query =  Query & " Values (" & PeopleID & " , 10)"
conn.Execute(Query) 
end if

If Turkeys = True then
Query =  "INSERT INTO Ranchspecieslookuptable (PeopleID, SpeciesID) "
Query =  Query & " Values (" & PeopleID & " , 14)"
conn.Execute(Query) 
end if

If Yaks = True then
Query =  "INSERT INTO Ranchspecieslookuptable (PeopleID, SpeciesID) "
Query =  Query & " Values (" & PeopleID & " , 17)"
conn.Execute(Query) 
end if

End If 

smtpServer = "mail.LivestockOfAmerica.com"
'strTO = "johna@webartists.biz"
strTo = PeopleEmail & ", john@andresengroup.com"
strFrom = "SignUp@livestockofamerica.com"
strSubject = "Your Livestock Of The World Subscription Has Been Created"
strBody = "<font face='arial'>Dear " & PeopleFirstName & ",<br>" & vbCrLf
strBody  = strBody &  "This email has been sent to you from https://www.LivestockOfTheWorld.com." & vbCrLf
strBody = strBody & "<br>Your new account with Livestock Of the World marketplaces has been successfully created.<br>" & vbCrLf
strBody = strBody & "<br>------------------------------------------------<br>" & vbCrLf
strBody = strBody & "Account Confirmation<br>------------------------------------------------<br>" & vbCrLf
strBody = strBody & "Thank you for registering with us." & vbCrLf
strBody = strBody & "We require that you validate your registration to ensure that the email address you entered was correct.<br> This protects against unwanted spam and malicious abuse.<br><br>To activate your account, simply click on the following link:" & vbCrLf
strBody = strBody & "<a href = 'https://www.LivestockOfTheWorld.com/AccountConfirmation.asp'> http://www.LivestockOfTheWorld.com/AccountConfirmation.asp</a><br><br>" & vbCrLf
strBody = strBody & "(If the link does not work then copy and paste the link into your web browser).<br><br>" & vbCrLf

strBody = strBody & "Once on the Account Confirmation page you will need to enter your activation code.<br>" & vbCrLf
strBody = strBody & "<br>Your activation code is:<br>" & vbCrLf
strBody = strBody & "&nbsp;&nbsp;&nbsp;&nbsp;<b>" &  ActivationCode & "</b><br><br>" & vbCrLf
strBody = strBody & "If you have any questions, please <a href = 'https://www.LivestockOfTheWorld.com/ContactUs.asp' >contact us </a> and let us know.<br>" & vbCrLf
strBody = strBody & "Thank you for registering with Livestock Of The World! </font>" & vbCrLf

'response.write("strBody=" & strBody)


Dim iMsg1  
Dim iConf1  
Dim Flds1
Dim strHTML1 
dim sch1 : sch1 = "http://schemas.microsoft.com/cdo/configuration/"  
Dim iBP1 
set iMsg1 = CreateObject("CDO.Message")  
set iConf1 = CreateObject("CDO.Configuration")  
Set Flds1 = iConf1.Fields   
'Const cdoSendUsingPickup = 1
'Const cdoSendUsingPort = 2
'Const cdoAnonymous = 0 
'Const cdoBasic = 1 
'Const cdoNTLM = 2  
With Flds1  
 .Item(sch1 & "sendusing") = 2
  .Item(sch1 & "smtpserver") = "smtp.sendgrid.net"
  '.Item(sch & "smtphost") = "smtp.sendgrid.net"
 .Item(sch1 & "smtpserverport") =465
 .Item(sch1 & "smtpconnectiontimeout") = 30
 .item(sch1 & "smtpauthenticate") = 1 'basic auth
 .item(sch1 & "smtpusessl") = True
 .item(sch1 & "sendusername") = "apikey"
 .item(sch1 & "sendpassword") = "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"


 .Update
End With 
' Build HTML for message body.  
  
  if test = true then
  strTo = "Contactus@livestockoftheworld.com"
  end if

  
'response.write("strTo=" & strTo ) 
With iMsg1  
 Set .Configuration = iConf1
 .To = strTo
 .Bcc = "Contactus@livestockoftheworld.com"
 .From = "Livestock Of America <contactus@livestockoftheworld.com>"
 'ObjSendMail.To = "andresengroup@yahoo.com"
 .Subject =  strSubject
 .HTMLBody = strBody
 '.Send
End With

' Clean up variables.  
Set iBP1 = Nothing  
Set iMsg1 = Nothing  
Set iConf1 = Nothing  
Set Flds1 = Nothing  

end if 
%>
<%
end if 'If Confirmationsent = True
%>
<% session("Confirmationsent") = True %>

<h2>Your Order</h2>
<center>
<table width = 300>
<tr><td class = "body">Livestock Of The World Plus Membership<br>
Order: <%=formatcurrency(OrderTotal)%><br>
</td></tr></table>
<%
test = False

if test = True then %>
<form action="https://www.sandbox.paypal.com/cgi-bin/webscr" method="post" target = "_blank">
<% else %>
<form action="https://www.paypal.com/cgi-bin/webscr" method="post" target = "_blank">
<% end if %>
    <input type="hidden" name="cmd" value="_cart">
    <input type="hidden" name="upload" value="1"><br />
    <input type="hidden" name="business" value="kim@livestockoftheworld.com">
    <input type="hidden" name="item_name" value="Livestock Of The World">
    <input type="hidden" name="item_number" value="Plus Membership">
    <input type="hidden" name="amount" value="<%=OrderTotal%>">
    <input type="hidden" name="currency_code" value="USD">
    <input type="hidden" name="image_url" value="https://www.LivestockofTheWorld.com/images/LOTWLogo.jpg">


    <input type="hidden" name="lc" value="US">
    <input type="hidden" name="bn" value="PP-BuyNowBF">
    <INPUT TYPE="hidden" NAME="first_Name" value="<%=PeopleFirstName %>">
    <INPUT TYPE="hidden" NAME="last_Name" value="<%=PeopleLastName %>">
    <INPUT TYPE="hidden" NAME="address1" value="<%=AddressStreet %>">
    <INPUT TYPE="hidden" NAME="AddressApt" value="<%=AddressApt %>">
    <INPUT TYPE="hidden" NAME="city" value="<%=AddressCity %>">
    <INPUT TYPE="hidden" NAME="state" value="<%=state %>">
    <INPUT TYPE="hidden" NAME="country" value="<%=country %>">
    <INPUT TYPE="hidden" NAME="zip" value="<%=AddressZip %>">
    <input type="hidden" name="custom" value="<%=PeopleID %>">
    <input type="hidden" name="cbt" value="Return to Livestock Of The World">
    <input type="hidden" name="rm" value="2">
    <input type="hidden" name="notify_url" value="https://www.LivestockOfTheWorld.com/Join/LOTWOrderCompletion.asp">
    <input type="hidden" name="return" value="http://www.LivestockOfTheWorld.com/SignUpCompletionPage.asp">
    <input type="hidden" name="cancel_return" value="http://www.LivestockOfTheWorld.com/SetupAccountStep2.asp?PeopleID=<%=PeopleID%>&Peopleemail=<%=Peopleemail %>">
    <input type="hidden" name="add" value="1">



    <input type="image" src="/administration/images/paynow.jpg" border="0" name="submit" >
</form>
</center>
</td></tr></table>
<img src = "/images/px.gif" width = 1 height = 350 border= 0 />
</td></tr></table>



<!--#Include virtual="/Footer.asp"-->
</Body>
</html>