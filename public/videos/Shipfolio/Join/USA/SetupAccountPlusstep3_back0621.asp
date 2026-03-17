<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ Language="VBScript" %> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%  PageName = "Registry" %>
<!--#Include virtual="/includefiles/GlobalVariables.asp"-->
<meta http-equiv="Content-Language" content="en-us">
<title>Create Account - <%=WebSiteName %> Online Animal Marketplace</title>
<meta name="Title" content="Create Account - <%=WebSiteName %> Online Animal Marketplace">
<meta name="description" content="Create your account at <%=WebSiteName %> - Animals for Sale." >
<meta name="robots" content="index, nofollow">
<meta name="revisit-after" content="never">
<meta name="author" content="Global Grange inc.">

<% 
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
'response.write("sitePath=" & sitePath & "<br>")

sql = "select * from Country where name = '" & Region & "'"
rs.Open sql, conn, 3, 3   
if  Not rs.eof then 
LocalCurrency  = rs("Currency") 
CurrencyCode  = rs("CurrencyCode")
country_id = rs("country_id")
end if
rs.close

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
OrderTotal = rs("SubscriptionMonthlyRate") 
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
'response.redirect("SetupAccountPlusStep2.asp" & variables & "&Stepback2=True&StateIndexFound=" & StateIndexFound & "&StateIndex=" & StateIndex & "&EmailsMatch=" & EmailsMatch  & "&passwordmismatch=" & passwordmismatch & "&SpecialChecterFound=" & SpecialChecterFound & "&MissingPassword=" & MissingPassword)
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
'response.write("years = " & years)
'response.write("datenownext  = " & datenownext )
'response.write("datenownextlife  = " & datenownextlife )
'response.write("Password=" & Password & "!")

		Query =  "INSERT INTO People (AddressID, ActivationCode, country_id, ReferringPeopleID, WebsitesID, Accesslevel, custAIStartService, custAIEndService, SubscriptionLevel, Owners, BusinessID,  PeopleFirstName, PeopleLastName, PeoplePhone, Peopleemail, PeopleCell, PeopleActive,  PeoplePassword , PeopleCreationDate )" 
		Query =  Query & " Values (" &  AddressID & ","
        Query =  Query & " '" &   ActivationCode & "', "
        Query =  Query & " '" &   country_id & "', " 
        Query =  Query & "0 , " 
		Query =  Query & " " &   WebsitesID & ", " 
		Query =  Query & " -1 , " 

        Query =  Query & " ' " & cstr(FormatDateTime(datenow,2)) & " ', " 'custAIStartService
        Query =  Query & " ' " & cstr(FormatDateTime(dateadd("yyyy", 1, datenow),2)) & " ', " 'custAIEndService

       If membership = "Intro" then
        Query =  Query & " 1 , " 'SubscriptionLevel
        end if


        If membership = "Basic" then
        Query =  Query & " 2 , " 'SubscriptionLevel
        end if


        If membership = "Business" then
        Query =  Query & " 3 , " 'SubscriptionLevel
        end if

        If membership = "International" then
        Query =  Query & " 4 , " 'SubscriptionLevel
        end if

        If membership = "Global" then
        Query =  Query & " 5 , " 'SubscriptionLevel
        end if

      
		Query =  Query & " '" &   Owners & "', " 
		Query =  Query & " " &   BusinessID & ", " 
 		Query =  Query & " '" &  PeopleFirstName & "', " 
		Query =  Query & " '" &  PeopleLastName & "', " 
		Query =  Query & " '" &  left(PeoplePhone, 35) & "', " 
		Query =  Query & " '" &  Peopleemail & "', " 
		Query =  Query & " '" &  Peoplecell  & "', " 
		Query =  Query & "'-1', " 
        Query =  Query & " '" & Password   & "', " 
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

Query =  "INSERT INTO peoplewebsitesubscribe (US, PeopleID)" 
Query =  Query & " Values (1," 
Query =  Query & " '" &  PeopleID & "')" 
Conn.Execute(Query) 

end if
end if
%>
</head>
<body >



<% Current = "Home"
Current3="Register"
session("LoggedIn") = False%>
<!--#Include virtual="/Header.asp"-->

    <div class="container-fluid" style="background-color: #CC9966;" >
    <div align = "center">
     <div class = "container" >
    <div>
      <div class = "body">
       <br /><h1>Account Verification</h1>
          </div>
        </div>
    </div>
    </div>
 </div>
	<br />
<div class="container d-flex justify-content-center roundedtopandbottom mx-auto " style = "max-width:460px; min-height: 200px">
  <div class="row">
  <div class="col">

<div>
   <div>
      
<% if membership = "Intro" then %>


		<blockquote><h2>One last step.</h2>
			
			Please verify your email address:<br /><br />
			<center>

				<form action="SetupAccountStep4.asp?PeopleID=<%=PeopleID %>&ActivationCode=<%=ActivationCode %>&PeopleID=<%=PeopleID %>&PeopleFirstName=<%=PeopleFirstName%>&PeopleEmail=<%=PeopleEmail%>" method="POST">
				  <button type="submit" class = "btn roundedtopandbottomyellow" style="min-width:90px">Email</button>
				</form><br />

				<% showsms = false
					if showsms = True then%>
					Or<br /><br />
					<form action="SetupAccountStep4SMS.asp?PeopleID=<%=PeopleID %>" method="POST">
						<button type="submit" class ="roundedtopandbottomyellow" style="min-width:90px">Phone</button>
					</form>
				<% end if %>
			</center>

			</blockquote>


<%
'********************************Paid Memberships*******************************
 else   %>


<blockquote>
	<br />
<h2>Your Order</h2>
<center>
<table width = 280 >
<tr><td class = "body"><%=membership %> Membership<br>
Order: <%=formatcurrency(OrderTotal)%> / Month<br>
</td></tr></table>



	
	 <form action="/StripeFile/checkout-billing.asp" method="post">
     <input type="hidden" name="PeopleID" value="<%=PeopleID %>" /> 
     <input type="hidden" name="membership" value="<%=membership %>" /> 
     <input type="hidden" name="Membership_price" value="<%=OrderTotal %>" /> 
     <input type="hidden" name="price_key" value="price_1N3LtOKoUhwamYBw7Kq7GeA8" /> 

	 <input type="hidden" name="PeopleFirstName" value="<%=PeopleFirstName %>" />
	 <input type="hidden" name="PeopleLastName" value="<%=PeopleLastName %>" />
	 <input type="hidden" name="PeopleEmail" value="<%=PeopleEmail %>" />
	 <input type="hidden" name="PeoplePhone" value="<%=PeoplePhone %>"

     <div class="select"><br />
     <div> <button type="submit" class="submitbutton" name="plan_submit">Pay Now</button> </div><br />
     </div>
     </form>
















<% showpaypal = False
test = False
	if showpaypal = True then
			if test = False then %>
			<form action="https://www.paypal.com/cgi-bin/webscr" method="post" target = "_blank">
			<% else %>
			<form action="https://www.sandbox.paypal.com/cgi-bin/webscr" method="post" target = "_blank">
			<% end if %>
<br />

			<input type="hidden" name="cmd" value="_xclick-subscriptions">
			<input type = "hidden" name = "business" value = "kim@livestockoftheworld.com">
			<input type="hidden" name="lc" value="IN">
			<input type = "hidden" name = "item_name" value = "<%=Membership %> Membership">
			<input type="hidden" name="no_note" value="1">
			<input type="hidden" name="src" value="1">
			<input type="hidden" name="srt" value="12">
			<input type="hidden" name="a3" value="<%=OrderTotal%>">
			<input type="hidden" name="p3" value="1">
			<input type="hidden" name="t3" value="M">
			<input type="hidden" name="currency_code" value="<%=LocalCurrency %>">
			<input type="hidden" name="cancel_return" value="http://www.globalgrange.world/Join/USA/Default.asp?PeopleID=<%=PeopleID%>&Peopleemail=<%=Peopleemail %>">
			<input type="hidden" name="return" value="http://www.globalgrange.world/SignUpCompletionPage.asp">
			<input type="hidden" name="bn" value="PP-SubscriptionsBF:btn_subscribeCC_LG.gif:NonHostedGuest">
			<input type="hidden" name="cbt" value="Return to Global Grange inc.">
			<input type="hidden" name="notify_url" value="https://www.globalgrange.world/Join/LOTWOrderCompletion.asp">
			<input type="submit" class ="submitbutton" value ="Pay Now" height = 130px border="0" name="Pay Now" >
			</form>
			</center>
			<br /><br /><br /><br />
			</blockquote>
	 <% end if %>
<% end if %>

			
		

   </div>
</div>

<br /><br />

</div>
</div>
</div>
<br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
<!--#Include virtual="/Footer.asp"--> </body>
</HTML>