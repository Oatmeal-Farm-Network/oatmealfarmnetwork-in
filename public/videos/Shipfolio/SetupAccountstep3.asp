<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ Language="VBScript" %> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%  PageName = "Registry" %>
<!--#Include virtual="/Shipfolio/GlobalVariables.asp"-->
<!--#Include virtual="/stripefile/Stripe.asp"-->
<meta http-equiv="Content-Language" content="en-us">
<title>Create Account</title>
<meta name="robots" content="index, nofollow">
<meta name="revisit-after" content="never">

	</head>
<body >

<% 
file_name = "SetupAccountPlusstep3.asp"

script_name = request.servervariables("script_name")
UserName = request.form("UserName")

PeopleID = Request.querystring("PeopleID")
if len(PeopleID) > 0 then
else
PeopleID = Request.form("PeopleID")
end if 

If len(PeopleID) > 0 then
ExistingAccount = True
else
ExistingAccount = False
end if


str1 = script_name
str2 = "Join"
If InStr(str1,str2) > 0 Then
sitePath= Replace(str1,  str2, "")
End If 
str1 = sitePath
str2 = file_name
If InStr(str1,str2) > 0 Then
sitePath= Replace(str1,  str2, "")
End If 

str1 = sitePath
str2 = "/"
If InStr(str1,str2) > 0 Then
Region= Replace(str1,  str2, "")
End If 
'response.write("Status=" & Status & "<br>")
if  Status="Test" then
sql = "select * from SubscriptionLevels where SubscriptionID = 2 " 'USA Basic Account
   ' response.write("sql =" & sql  )
    rs.Open sql, conn, 3, 3  
    if  Not rs.eof then 
        BasicPriceID = rs("StripeAPIIDTest")
    end if
	'response.write("BasicsPriceID =" & BasicsPriceID  )
   rs.close

sql = "select * from SubscriptionLevels where SubscriptionID = 3 " 'USA Business Account
    'response.write("sql =" & sql  )
    rs.Open sql, conn, 3, 3  
    if  Not rs.eof then 
        BusinessPriceID = rs("StripeAPIIDTest")
    end if
   rs.close

sql = "select * from SubscriptionLevels where SubscriptionID = 5 " 'USA Global Account
  rs.Open sql, conn, 3, 3   
    if  Not rs.eof then 
        GlobalPriceID = rs("StripeAPIIDTest")
    end if
    rs.close


end if
if  Status="Live" Then
sql = "select * from SubscriptionLevels where SubscriptionID = 2 " 'USA Basic Account
   ' response.write("sql =" & sql  )
    rs.Open sql, conn, 3, 3  
    if  Not rs.eof then 
        BasicPriceID = rs("StripeAPIID")
    end if
	'response.write("BasicsPriceID =" & BasicsPriceID  )
   rs.close

sql = "select * from SubscriptionLevels where SubscriptionID = 3 " 'USA Business Account
    'response.write("sql =" & sql  )
    rs.Open sql, conn, 3, 3  
    if  Not rs.eof then 
        BusinessPriceID = rs("StripeAPIID")
    end if
   rs.close

sql = "select * from SubscriptionLevels where SubscriptionID = 5 " 'USA Global Account
  rs.Open sql, conn, 3, 3   
    if  Not rs.eof then 
        GlobalPriceID = rs("StripeAPIID")
    end if
    rs.close
End if


sql = "select * from Country where name = '" & Region & "'"
rs.Open sql, conn, 3, 3   
if  Not rs.eof then 
LocalCurrency  = rs("Currency") 
CurrencyCode  = rs("CurrencyCode")
country_id = rs("country_id")
end if
rs.close

Permission = request.form("Permission")
	If Permission = "on" then
		Permission = 1
	end if
LivestockLegalDisclaimer= request.form("LivestockLegalDisclaimer")
		If LivestockLegalDisclaimer = "on" then
		LivestockLegalDisclaimer = 1
	end if
SalesLegalDisclaimer= request.form("SalesLegalDisclaimer")
		If SalesLegalDisclaimer = "on" then
		SalesLegalDisclaimer = 1
	end if
BusinessTypeID = request.form("BusinessTypeID")
PeopleFirstName=request.form("PeopleFirstName")
PeopleLastName=request.form("PeopleLastName")
BusinessName=request.form("BusinessName")
PeopleWebsite=request.form("PeopleWebsite")
PeopleEmail=request.form("PeopleEmail")

AddressStreet=request.form("AddressStreet")
variables = "?AddressStreet=" & AddressStreet
AddressApt=request.form("AddressApt")
variables = variables & "&AddressApt=" & AddressApt
AddressCity=request.form("AddressCity")
variables = variables & "&AddressCity=" & AddressCity
AddressZip=request.form("AddressZip")
variables = variables & "&AddressZip=" & AddressZip
PeoplePhone=request.form("PeoplePhone")
variables = variables & "&PeoplePhone=" & PeoplePhone
StateIndex=request.form("StateIndex")
'response.write("StateIndex=" & StateIndex )

password =Request.form("password")
confirmpassword =Request.form("confirm_password")

if password = confirmpassword then
  passwordmatch = True
else
  passwordmatch = False
end if


'response.write("password=" & password & "!")
'response.write("passwordmismatch=" & passwordmismatch & "!")


if len(Password) > 2 then
else
MissingPassword = True
MissingData = True
end if


SpecialChecterFound = False
str1 = Password
If InStr(str1,"!") > 0 or InStr(str1,"@") > 0 or InStr(str1,"#") > 0 or InStr(str1,"$") > 0 or InStr(str1,"%") > 0 or InStr(str1,"+") > 0 or InStr(str1,"-") > 0 _
 or InStr(str1,"^") > 0  or InStr(str1,"&") > 0  or InStr(str1,"*") > 0 or InStr(str1,"(") > 0 or InStr(str1,")") > 0  or InStr(str1,"_") > 0 or InStr(str1,"=") > 0 _
 or InStr(str1,"|") > 0  or InStr(str1,"\") > 0 or InStr(str1,"/") > 0 or InStr(str1,"'") > 0 or InStr(str1,":") > 0 or InStr(str1,".") > 0  _
 or InStr(str1,"{") > 0 or InStr(str1,"}") > 0 or InStr(str1,"[") > 0 or InStr(str1,"]") > 0 or InStr(str1,"~") > 0 _
 or InStr(str1,".") > 0  Then
    SpecialChecterFound = True
End If 
'response.write("Password=" & Password )
'response.write("SpecialChecterFound=" & SpecialChecterFound )


Membership = Request.Form("Membership")
if len(Membership) > 0 then
else
Membership = Request.querystring("Membership")
end if
'response.write("Membership=" & Membership )
if len(Membership) > 0 then
else
Membership = session("Membership")
end if
variables = variables & "&Membership=" & Membership




file_name = "SetupAccountPlusstep3.asp"

script_name = request.servervariables("script_name")

str1 = script_name
str2 = "Join"
If InStr(str1,str2) > 0 Then
sitePath= Replace(str1,  str2, "")
End If 
str1 = sitePath
str2 = file_name
If InStr(str1,str2) > 0 Then
sitePath= Replace(str1,  str2, "")
End If 

str1 = sitePath
str2 = "/"
If InStr(str1,str2) > 0 Then
Region= Replace(str1,  str2, "")
End If 


'response.write("Region=" & Region & "<br>")

sql = "select * from Country where name = '" & Region & "'"
rs.Open sql, conn, 3, 3   
if  Not rs.eof then 
LocalCurrency  = rs("Currency") 
CurrencyCode  = rs("CurrencyCode")
country_id = rs("country_id")
end if
rs.close

showcoupons = false
showyears = False
showdonation = False
donationsavailable = False



sql = "select distinct * from SubscriptionLevels where Region = 'USA' and SubscriptionTitle = '" & Membership & "'"
rs.Open sql, conn, 3, 3   
if  Not rs.eof then 
'OrderTotal = rs("SubscriptionMonthlyRate") 
OrderTotal =9.99
end if
rs.close



StateIndexFound = False
if len(StateIndex) > 0 then
StateIndexFound = True
end if

'response.write("MissingData=" & MissingData &"<br>")
'response.write("SpecialChecterFound=" & SpecialChecterFound  &"<br>")
'response.write("StateIndex=" & StateIndex &"<br>")
'response.write("passwordmatch=" & passwordmatch &"<br>")


if MissingData = True  or  len(StateIndex) < 1 or passwordmatch = False then
' response.redirect("SetupAccountPlusStep2.asp" & variables & "&Stepback2=True&StateIndexFound=" & StateIndexFound & "&StateIndex=" & StateIndex & "&EmailsMatch=" & EmailsMatch  & "&passwordmismatch=" & passwordmismatch & "&SpecialChecterFound=" & SpecialChecterFound & "&MissingPassword=" & MissingPassword)
end if


Owner=request.form("Owner")

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
' take the numeric and turn it into a character
random_letter = UCase(Chr(random_number))
ActivationCode = ActivationCode & random_letter

Next
ActivationCode = day(now) & month(now) & Year(now) & ActivationCode & Left(TempLastName, 1)

If not session("Confirmationsent") = True then





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





ExistingAccount = False 
if ExistingAccount =True then
'response.write("ExistingAccount3 =" & ExistingAccount  )

else
	if ExistingAccount = False  then
		'if len(PeopleID)> 0 then
		'sql = "select  AddressID, WebsitesID, BusinessID, PeopleFirstName, PeopleID, permissionCheckbox, LivestockLegalDisclaimer, SalesLegalDisclaimer from People where PeopleID = " & PeopleID & ""
		'response.write("sql=" & sql)
		'	Set rs = Server.CreateObject("ADODB.Recordset")
		'	rs.Open sql, conn, 3, 3   
		'	ExistingEvent = False
		'	If Not rs.eof Then
    	'		PeopleID  =rs("PeopleID") 
		'		AddressID  =rs("AddressID") 
		'		WebsitesID  =rs("WebsitesID") 
		'		BusinessID  =rs("BusinessID") 
		'		PeopleFirstName = rs("PeopleFirstName")
		'		permissionCheckbox = rs("permissionCheckbox")
		'		LivestockLegalDisclaimer = rs("LivestockLegalDisclaimer")
		'		SalesLegalDisclaimer  = rs("SalesLegalDisclaimer")
		'	End If 
		'	rs.close


		'	sql = "select addresscountry from Address where AddressID = " & AddressID & " order by AddressID Desc"
			
	
	
		'	rs.Open sql, conn, 3, 3   
		'	If Not rs.eof Then
		'		addresscountry = rs("addresscountry")
		'	End If 
	'
	'	end if

	end if

	
	str1 = UserName
	str2 = "'"
	If InStr(str1,str2) > 0 Then
		UserName = Replace(str1,  str2, "''")
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

		Query =  "INSERT INTO Address (AddressStreet, AddressApt, AddressCity, StateIndex, country_id, AddressZip)" 
	    Query =  Query + " Values ('" & AddressStreet  & "'," 
	    Query =  Query & " '" &  AddressApt & "', " 
		Query =  Query & " '" &  AddressCity & "', " 
		Query =  Query & " '" &  StateIndex & "', " 
        Query =  Query & " '" &  country_id & "', " 
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

'response.write("datenownext  = " & datenownext )
'response.write("datenownextlife  = " & datenownextlife )
'response.write("Password=" & Password & "!")

ExistingAccount = False
'response.write("ExistingAccount = " & ExistingAccount)

If ExistingAccount = False then
		Query =  "INSERT INTO People (AddressID, UserName, ActivationCode, country_id, WebsitesID, Accesslevel, custAIStartService, custAIEndService, PeopleFirstName, PeopleLastName, PeoplePhone, Peopleemail,  PeopleActive,  PeoplePassword, PeopleCreationDate  )" 
		Query =  Query & " Values (" &  AddressID & ","
		Query =  Query & " '" &   UserName & "', "
        Query =  Query & " '" &   ActivationCode & "', "
        Query =  Query & " '" &   country_id & "', " 
		Query =  Query & " " &   WebsitesID & ", " 
		Query =  Query & " -1 , " 

        Query =  Query & " ' " & cstr(FormatDateTime(datenow,2)) & " ', " 'custAIStartService
        Query =  Query & " ' " & cstr(FormatDateTime(dateadd("yyyy", 1, datenow),2)) & " ', " 'custAIEndService

   

      
 		Query =  Query & " '" &  PeopleFirstName & "', " 
		Query =  Query & " '" &  PeopleLastName & "', " 
		Query =  Query & " '" &  left(PeoplePhone, 35) & "', " 
		Query =  Query & " '" &  Peopleemail & "', " 
 
		Query =  Query & "'-1', " 
        Query =  Query & " '" & password   & "', " 

		Query =  Query & " CURRENT_TIMESTAMP) "
'response.Write("Query = " & Query)

Conn.Execute(Query)
end if

 sql = "select PeopleID, PeopleFirstName from People where AddressID = " & AddressID  & " order by PeopleID Desc;"
Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	If Not rs.eof Then
		PeopleID = rs("PeopleID")
		session("PeopleID") = PeopleID
        PeopleFirstName = rs("PeopleFirstName")
	End If 
rs.close
'response.write("peopleid=" & PeopleID)

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

Query =  "INSERT INTO peoplewebsitesubscribe (US, PeopleID)" 
Query =  Query & " Values (1," 
Query =  Query & " '" &  PeopleID & "')" 
Conn.Execute(Query) 

end if
end if


dim membershipStripePrice

If membership = "Basic" then
   membershipStripePriceID=    BasicPriceID
'	response.write("membershipStripePriceID=" & membershipStripePriceID )
 end if 
 If membership = "Business" then
   membershipStripePriceID=    BusinessPriceID
	'response.write("membershipStripePriceID=" & membershipStripePriceID )
 end if       

If membership = "Global" then
	membershipStripePriceID= GlobalPriceID
end if

 Current = "Home"
Current3="Register"
session("LoggedIn") = True
'response.redirect("/members/")%>
<!--#Include virtual="/Shipfolio/Header.asp"-->


  









<style>
	
	.mx-auto {
		margin-left: auto;
		margin-right: auto;
	}
	.mt-8 {
		margin-top: 2rem;
	}
	.p-6 {
		padding: 1.5rem;
	}
	.py-6 {
		padding-top: 1.5rem;
		padding-bottom: 1.5rem;
	}
	.shadow-md {
		box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
	}
	.shadow-lg {
		box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
	}
	.rounded-b-lg {
		border-bottom-left-radius: 0.5rem;
		border-bottom-right-radius: 0.5rem;
	}
	.rounded-lg {
		border-radius: 0.5rem;
	}
	.max-w-md {
		max-width: 28rem;
	}
	.text-3xl {
		font-size: 1.875rem;
		line-height: 2.25rem;
	}
	.font-bold {
		font-weight: 700;
	}
	.text-center {
		text-align: center;
	}
	.text-gray-800 {
		color: #1f2937;
	}
	.mb-4 {
		margin-bottom: 1rem;
	}
	.mb-6 {
		margin-bottom: 1.5rem;
	}
	.block {
		display: block;
	}
	.text-gray-700 {
		color: #374151;
	}
	.text-sm {
		font-size: 0.875rem;
		line-height: 1.25rem;
	}
	.shadow {
		box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1), 0 1px 2px 0 rgba(0, 0, 0, 0.06);
	}
	.appearance-none {
		-webkit-appearance: none;
		-moz-appearance: none;
		appearance: none;
	}
	.border {
		border-width: 1px;
		border-color: #d1d5db;
	}
	.rounded {
		border-radius: 0.25rem;
	}
	.w-full {
		width: 100%;
	}
	.py-2 {
		padding-top: 0.5rem;
		padding-bottom: 0.5rem;
	}
	.px-3 {
		padding-left: 0.75rem;
		padding-right: 0.75rem;
	}
	.text-gray-700 {
		color: #374151;
	}
	.leading-tight {
		line-height: 1.25;
	}
	.focus\:outline-none:focus {
		outline: 2px solid transparent;
		outline-offset: 2px;
	}
	.focus\:shadow-outline:focus {
		box-shadow: 0 0 0 3px rgba(66, 153, 225, 0.5);
	}
	.text-gray-500 {
		color: #6b7280;
	}
	.text-red-700 {
		color: #b91c1c;
	}
	.text-red-500 {
		color: #ef4444;
	}
	.text-xs {
		font-size: 0.75rem;
		line-height: 1rem;
	}
	.italic {
		font-style: italic;
	}
	.mt-1 {
		margin-top: 0.25rem;
	}
	.hidden {
		display: none;
	}
	.pr-10 {
		padding-right: 2.5rem;
	}
	.flex {
		display: flex;
	}
	.items-center {
		align-items: center;
	}
	.mb-2 {
		margin-bottom: 0.5rem;
	}
	.justify-end {
		justify-content: flex-end;
	}
	.bg-blue-500 {
		background-color: #3b82f6;
	}
	.hover\:bg-blue-700:hover {
		background-color: #1d4ed8;
	}
	.text-white {
		color: #fff;
	}
	.py-2 {
		padding-top: 0.5rem;
		padding-bottom: 0.5rem;
	}
	.px-4 {
		padding-left: 1rem;
		padding-right: 1rem;
	}
	/* Custom styles for password visibility toggle */
	.password-container {
		position: relative;
	}
	.toggle-password {
		position: absolute;
		right: 12px;
		top: 50%;
		transform: translateY(-50%);
		cursor: pointer;
		color: #6b7280;
		font-size: 1.1rem;
	}
	/* Style for the CAPTCHA text */
	.captcha-text {
		font-family: 'Courier New', Courier, monospace;
		font-size: 1.5rem;
		font-weight: bold;
		letter-spacing: 3px;
		color: #ef4444;
		background-color: #fef2f2;
		padding: 0.5rem 1rem;
		border-radius: 0.375rem;
		display: inline-block;
		user-select: none;
		border: 1px solid #fca5a5;
	}
	/* Style for refresh CAPTCHA button */
	.refresh-captcha {
		cursor: pointer;
		color: #3b82f6;
		margin-left: 0.5rem;
		font-size: 1.1rem;
	}
	/* Specific styles for the verification choice section */
	.verification-option {
		display: flex;
		align-items: center;
		margin-bottom: 1rem;
		cursor: pointer;
		padding: 0.75rem;
		border: 1px solid white;
		border-radius: 0.25rem;
		transition: background-color 0.2s ease-in-out, border-color 0.2s ease-in-out;
	}
	.verification-option:hover {
		background-color: #f9fafb;
		border-color: #9ca3af;
	}
	.verification-option input[type="radio"] {
		margin-right: 0.75rem;
		-webkit-appearance: none;
		-moz-appearance: none;
		appearance: none;
		width: 1.25rem;
		height: 1.25rem;
		border: 2px solid white;
		border-radius: 50%;
		outline: none;
		cursor: pointer;
		position: relative;
		display: flex;
		align-items: center;
		justify-content: center;
	}
	.verification-option input[type="radio"]:checked {
		border-color: #3b82f6;
	}
	.verification-option input[type="radio"]:checked::before {
		content: '';
		width: 0.75rem;
		height: 0.75rem;
		background-color: #3b82f6;
		border-radius: 50%;
		display: block;
	}
	.verification-option label {
		flex-grow: 1;
		cursor: pointer;
		font-weight: bold;
		color: #374151;
	}
	.verification-detail {
		font-size: 0.875rem;
		color: #6b7280;
		margin-left: 1.5rem; /* Indent the detail */
	}
	
</style>
</head>
<body class="bg-gray-100 font-sans antialiased">


<div class="container mx-auto mt-8 p-6 shadow-lg rounded-lg max-w-md">
	<h1 >Account Verification</h1>
	<!-- ASP logic for variables and database interactions -->
	<% 
	Peopleid=session("PeopleID")
	'response.write("peopleid=" & session("PeopleID"))
	' ASP variables from the original code
	Dim PeopleID, PeopleEmail, PeoplePhone, ActivationCode, PeopleFirstName
	'PeopleID = Request.QueryString("PeopleID")
	If Len(PeopleID) = 0 Then PeopleID = Request.Form("PeopleID")

	PeopleEmail = Request.Form("PeopleEmail") ' Assuming email is passed from previous form
	If Len(PeopleEmail) = 0 Then PeopleEmail = Request.QueryString("PeopleEmail")
	If Len(PeopleEmail) = 0 Then PeopleEmail = Session("PeopleEmail")

	PeoplePhone = Request.Form("PeoplePhone") ' Assuming phone is passed from previous form

	PeopleFirstName = Request.Form("PeopleFirstName") ' Assuming first name is passed from previous form
	If Len(PeopleFirstName) = 0 Then PeopleFirstName = Request.QueryString("PeopleFirstName")

	' Generate ActivationCode (simplified for HTML, actual ASP logic is more complex)
	' For demonstration, a simple placeholder. In real ASP, this would be generated once and stored.
	If Len(ActivationCode) = 0 Then
		For x=1 To 8 
			Randomize
			random_number = Int(26 * Rnd + 97)
			random_letter = UCase(Chr(random_number))
			ActivationCode = ActivationCode & random_letter
		Next
		ActivationCode = Day(Now) & Month(Now) & Year(Now) & ActivationCode & Left(PeopleFirstName, 1) ' Using PeopleFirstName for example
	End If
	
	' This section assumes 'membership = "Intro"' from the original ASP logic
	' If 'membership' is not "Intro", it would proceed to the "Paid Memberships" section
	' For this HTML, we are focusing on the "Intro" (verification) path.
	Dim membership
	membership = "Intro" ' Hardcoding for this specific page's context
	%>

	<% If membership = "Intro" Then %>
		<div class="text-center">
			<blockquote>
				<h2>One last step</h2>
				<p class="mb-6">
					To confirm your account, please choose how you'd like to receive your confirmation code.
				</p>

				<form id="verificationForm" method="POST">
					<input type="hidden" name="PeopleID" value="<%=PeopleID %>">
					<input type="hidden" name="ActivationCode" value="<%=ActivationCode %>">
					<input type="hidden" name="PeopleFirstName" value="<%=PeopleFirstName%>">
					<input type="hidden" name="PeopleEmail" value="<%=PeopleEmail%>">
					<input type="hidden" name="PeoplePhone" value="<%=PeoplePhone%>">
					
					<div class="mb-4 text-left">
						<div class="verification-option" onclick="document.getElementById('send_email').checked = true; updateFormAction();">
							<input type="radio" id="send_email" name="send_method" value="email" checked>
							<label for="send_email">Send via Email</label>
							<span class="body"><%=PeopleEmail%></span>
						</div>
					</div>

					<div class="mb-12  justify-end">
 					   <button type="submit" class="regsubmit2">Send</button>
					</div>
				</form>
			</blockquote>
		</div>
	<% Else %>
		<!-- Original "Paid Memberships" section (unmodified) -->
		<div class="container-fluid">
			<div align="center">
				<div class="container">
					<div>
						<div class="body">
						</div>
					</div>
				</div>
			</div>
		</div>
		<br />
		<div class="container d-flex justify-content-center roundedtopandbottom mx-auto" style="max-width:560px; min-height: 200px">
			<div class="row">
				<div class="col">
					<div>
						<div>
							<blockquote>
								<br />
								<h2>Your Order</h2>
								<center>
									<table width="280">
										<tr>
											<td class="body">
												<%=membership %> Membership<br>
												Order: <%=formatcurrency(OrderTotal)%> / Month<br>
											</td>
										</tr>
									</table>
									<form action="/StripeFile/checkout-billing.asp" method="post">
										<input type="hidden" name="PeopleID" value="<%=PeopleID %>" />
										<input type="hidden" name="membership" value="<%=membership %>" />
										<input type="hidden" name="Membership_price" value="<%=OrderTotal %>" />
										<input type="hidden" name="membershipStripePriceID" value="<%=membershipStripePriceID %>" />
										<input type="hidden" name="PeopleFirstName" value="<%=PeopleFirstName %>" />
										<input type="hidden" name="PeopleLastName" value="<%=PeopleLastName %>" />
										<input type="hidden" name="PeopleEmail" value="<%=PeopleEmail %>" />
										<input type="hidden" name="PeoplePhone" value="<%=PeoplePhone %>" />
										<div class="select"><br />
											<div> <button type="submit" class="regsubmit2" name="plan_submit">Pay Now</button> </div><br />
										</div>
									</form>
									<% showpaypal = False
									test = False
									if showpaypal = True then
										if test = False then %>
										<form action="https://www.paypal.com/cgi-bin/webscr" method="post" target="_blank">
										<% else %>
										<form action="https://www.sandbox.paypal.com/cgi-bin/webscr" method="post" target="_blank">
										<% end if %>
											<br />
											<input type="hidden" name="cmd" value="_xclick-subscriptions">
											<input type="hidden" name="business" value="kim@livestockoftheworld.com">
											<input type="hidden" name="lc" value="IN">
											<input type="hidden" name="item_name" value="<%=Membership %> Membership">
											<input type="hidden" name="no_note" value="1">
											<input type="hidden" name="src" value="1">
											<input type="hidden" name="srt" value="12">
											<input type="hidden" name="a3" value="<%=OrderTotal%>">
											<input type="hidden" name="p3" value="1">
											<input type="hidden" name="t3" value="M">
											<input type="hidden" name="currency_code" value="<%=LocalCurrency %>">
											<input type="hidden" name="cancel_return" value="https://www.OatmealfarmNetwork.com/Join/USA/Default.asp?PeopleID=<%=PeopleID%>&Peopleemail=<%=Peopleemail %>">
											<input type="hidden" name="return" value="https://www.OatmealfarmNetwork.com/SignUpCompletionPage.asp">
											<input type="hidden" name="bn" value="PP-SubscriptionsBF:btn_subscribeCC_LG.gif:NonHostedGuest">
											<input type="hidden" name="cbt" value="Return to Global Grange inc.">
											<input type="hidden" name="notify_url" value="https://www.globalgrange.world/Join/LOTWOrderCompletion.asp">
											<input type="submit" class="submitbutton" value="Pay Now" height="130px" border="0" name="Pay Now">
										</form>
										</center>
										<br /><br /><br /><br />
									</blockquote>
									<% end if %>
								</div>
							</div>
							<br /><br />
						</div>
					</div>
				</div>
				<br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
			</div>
		</div>
	<% End If %>

<script>
	/**
	 * Dynamically updates the form's action based on the selected radio button.
	 */
	function updateFormAction() {
		const form = document.getElementById('verificationForm');
		const peopleId = form.querySelector('input[name="PeopleID"]').value;
		const activationCode = form.querySelector('input[name="ActivationCode"]').value;
		const peopleFirstName = form.querySelector('input[name="PeopleFirstName"]').value;
		const peopleEmail = form.querySelector('input[name="PeopleEmail"]').value;
		const peoplePhone = form.querySelector('input[name="PeoplePhone"]').value; // Get phone number

		const emailAction = `SetupAccountStep4.asp?PeopleID=${peopleId}&ActivationCode=${activationCode}&PeopleFirstName=${peopleFirstName}&PeopleEmail=${peopleEmail}`;
		const smsAction = `SetupAccountStep4SMS.asp?PeopleID=${peopleId}&ActivationCode=${activationCode}&PeoplePhone=${peoplePhone}`; // Pass phone for SMS

		if (document.getElementById('send_email').checked) {
			form.action = emailAction;
		} else if (document.getElementById('send_sms') && document.getElementById('send_sms').checked) {
			form.action = smsAction;
		}
	}

	// Set initial form action on page load
	document.addEventListener('DOMContentLoaded', function() {
		updateFormAction(); // Set initial action based on default checked radio
		// Add event listeners to radio buttons to update form action on change
		document.querySelectorAll('input[name="send_method"]').forEach(radio => {
			radio.addEventListener('change', updateFormAction);
		});
	});
</script>


<!--#Include virtual="/Shipfolio/Footer.asp"--> </body>
</HTML>