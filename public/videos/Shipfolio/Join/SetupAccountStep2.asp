<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ Language="VBScript" %> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%  PageName = "Registry" %>
<!--#Include file="GlobalVariables.asp"-->
<meta http-equiv="Content-Language" content="en-us">
<title>Create Account - <%=WebSiteName %> Online Animal Marketplace</title>
<meta name="Title" content="Create Account - <%=WebSiteName %> Online Animal Marketplace">
<meta name="description" content="Create your account at <%=WebSiteName %> - Animals for Sale." >
<meta name="robots" content="index, nofollow">
<meta name="revisit-after" content="never">
<meta name="author" content="Livestock Of The World">
<link rel="stylesheet" type="text/css" href="Style.css">

<SCRIPT LANGUAGE="JavaScript">
<!-- Original:  Nannette Thacker -->
<!-- http://www.shiningstar.net -->
<!-- Begin
function checkNumeric(objName,minval, maxval,comma,period,hyphen)
{
	var numberfield = objName;
	if (chkNumeric(objName,minval,maxval,comma,period,hyphen) == false)
	{
		numberfield.select();
		numberfield.focus();
		return false;
	}
	else
	{
		return true;
	}
}

function chkNumeric(objName,minval,maxval,comma,period,hyphen)
{
// only allow 0-9 be entered, plus any values passed
// (can be in any order, and don't have to be comma, period, or hyphen)
// if all numbers allow commas, periods, hyphens or whatever,
// just hard code it here and take out the passed parameters
var checkOK = "0123456789"  ;
var checkStr = objName;
var allValid = true;
var decPoints = 0;
var allNum = "";

for (i = 0;  i < checkStr.value.length;  i++)
{
ch = checkStr.value.charAt(i);
for (j = 0;  j < checkOK.length;  j++)
if (ch == checkOK.charAt(j))
break;
if (j == checkOK.length)
{
allValid = false;
break;
}
if (ch != ",")
allNum += ch;
}
if (!allValid)
{	
alertsay = "Please enter only these values \""
alertsay = alertsay + checkOK + "\" in the \"" + checkStr.name + "\" field."
alert(alertsay);
return (false);
}

// set the minimum and maximum
var chkVal = allNum;
var prsVal = parseInt(allNum);
if (chkVal != "" && !(prsVal >= minval && prsVal <= maxval))
{
}
}
//  End -->
</script>

<% 
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
'response.write("Membership=" & Membership )


website = request.querystring("website") 

if len(website) > 0 then
else
website = request.form("website") 
end if

websitesignupcount = 0


if membership = "Free" then


websitesignupcount = 1

else

if (InStr(website, "Livestock Of America") > 0 or InStr(website, "LOA") > 0) and len(peopleID) > 0  Then
LOASignup = True
websitesignupcount = websitesignupcount + 1

Query =  "INSERT INTO peoplewebsitesubscribe (PeopleID, SubscribedWebsite)" 
Query =  Query & " Values (" &  PeopleID & ", "
Query =  Query &   " 'Livestock Of America'  )" 
'response.write("Query=" & Query)	
Conn.Execute(Query) 
else
LOASignup = false

if len(PeopleID) > 0 then
Query =  "Delete from peoplewebsitesubscribe where peopleID = " &  PeopleID & " and SubscribedWebsite = 'Livestock Of America' " 
'response.write("Query=" & Query)	
Conn.Execute(Query) 
end if

end if 

if InStr(website, "Livestock Of Canada") > 0 or InStr(website, "LOC") > 0 Then
LOCSignup = True
websitesignupcount = websitesignupcount + 1
Query =  "INSERT INTO peoplewebsitesubscribe (PeopleID, SubscribedWebsite)" 
Query =  Query & " Values (" &  PeopleID & ", "
Query =  Query &   " 'Livestock Of Canada'  )" 
'response.write("Query=" & Query)	
Conn.Execute(Query) 

else
LOCSignup = false
if len(Peopleid) > 0 then
Query =  "Delete from peoplewebsitesubscribe where peopleID = " &  PeopleID & " and SubscribedWebsite = 'Livestock Of Canada' " 
'response.write("Query=" & Query)	
Conn.Execute(Query) 
end if


end if 
end if

ExistingSite = False
Update = "False"
Coupon = Request.querystring("Coupon")
QuantityChange = Request.querystring("QuantityChange")
years = Request.Form("years")

animals = Request.Form("animals")
ReturnFileName = Request.querystring("ReturnFileName") 
ReturnEventID = Request.querystring("ReturnEventID") 
Update  =Request.Form("Update") 
PeopleFirstName  =Request.Form("PeopleFirstName") 
PeopleLastName  =Request.Form("PeopleLastName") 
PeopleTitleID =Request.Form("PeopleTitleID") 
PeopleWebsite =Request.Form("PeopleWebsite") 
PeopleEmail =Request.Form("PeopleEmail") 

LeftShoe =Request.Form("LeftShoe") 
RightShoe =Request.Form("RightShoe") 

ReferringPeopleID=Request.Form("ReferringPeopleID") 
Interest = Request.Form("Interest")

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



response.write("session Peopleemail=" & session("Peopleemail") )

ConfirmEmail =Request.Form("ConfirmEmail") 
confirm  =Request.Form("confirm") 
AddressStreet = Request.Form("AddressStreet") 
AddressApt = Request.Form("AddressApt") 
AddressCity  = Request.Form("AddressCity")
AddressState  = Request.Form("AddressState")
AddressCountry  = Request.Form("country")
AddressZip  = Request.Form("AddressZip")
PeoplePhone  = Request.Form("PeoplePhone")
PeopleCell  = Request.Form("PeopleCell")
PeopleFax  = Request.Form("PeopleFax")
PeopleID = Request.Form("PeopleID")
if len(PeopleID) > 0 then
else
PeopleID = Request.querystring("PeopleID")
end if 
Owners = Request.Form("Owners")



%>
</head>
<% if mobiledevice = True or is_iPad = true then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth + '&website=<%=website %>&Membership=<%=Membership %>&peopleId=<%=peopleId %>');" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<% end if%>
<% Current = "Home"
'Current3 = "JoinLOA" '
'CurrentWebsite = "LivestockofAmerica" 
session("LoggedIn") = False%>
<!--#Include virtual="/Header.asp"-->
<% if screenwidth > 700 then %>
<!--#Include virtual="/join/JoinHeader.asp"-->
<% end if %> 

<h1>Create Your Account</h1>

<%



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

discount = 30

BadCoupon = False
if len(Coupon) > 0 then
Couponcode = request.form("Couponcode")

if lcase(trim(Couponcode)) = "WFSLaunch" then
discount = 30 ' percent

else
BadCoupon = True
end if

Coupon = True
else
if QuantityChange = "True" then
else
ExistingAccount = False
sql = "select * from People  where   (Peopleemail = '" & Peopleemail & "')"

Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	If Not rs.eof Then
		ExistingAccount = True 
		PeopleID= rs("PeopleID") 
     session("PeopleID") = ""


end if
rs.close
End If 
end if

if len(Update) < 1 then
  if len(Session("Update")) > 1 then
     Update = "True"
  else
  Update = "False"
  end if
end if

if ExistingAccount =True then
session("peopleID") = ""
%>
<h2>Existing Account</h2>
There already is an account with email address <%=Peopleemail %>. To make changes to your account please <a href = "/members/" class = "body">Sign Into Your Account,</a> and make your changes there. <br><br>
<center><a href = "/members/" class = "regsubmit2">Sign Into Your Account </a></center>

<% 
else %>

<% if addresscountry = "Canada" then %><br>
<big>Since, your business is in Canada, your animals and products will appear on LivestockOfCanada.com.</big><br>
<% end if %>

<% if addresscountry = "USA" then %><br>
<big>Since, your business is in the United States, your animals and products will appear on LivestockOfAmerica.com.</big><br>
<% end if %>


<% end if

if ExistingAccount = False or Update = "True"  then
if len(PeopleID)> 0 then
sql = "select AddressID, WebsitesID, BusinessID from People where PeopleID = " & PeopleID & ""
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	ExistingEvent = False
	If Not rs.eof Then
		AddressID  =rs("AddressID") 
		WebsitesID  =rs("WebsitesID") 
		BusinessID  =rs("BusinessID") 
End If 
rs.close
else
end if

if len(PeopleID) > 0 then
ExistingSite = True
end if
Dim str1
Dim str2
if (ExistingSite = False and Update = "False") or len(WebsitesID) < 1 then
Query =  "INSERT INTO Websites (Website)" 
Query =  Query + " Values ('" & PeopleWebsite & "')" 
Conn.Execute(Query) 
Conn.close
Set Conn = Nothing %>
<!--#Include virtual="Conn.asp"-->
<%
else
Query =  " UPDATE Websites Set Website = '" &  PeopleWebsite & "' " 
Query =  Query & " where WebsitesID = " & WebsitesID & ";" 
Conn.Execute(Query) 
Conn.close
Set Conn = Nothing %>
<!--#Include virtual="Conn.asp"-->
<%
end if 
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
Conn.close
set Conn = nothing %>
<!--#Include virtual="Conn.asp"-->
<%		
sql = "select BusinessID from Business where BusinessName = '" & BusinessName & "' order by BusinessID Desc"

		
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	ExistingEvent = False
	If Not rs.eof Then
		BusinessID = rs("BusinessID")
	End If 
rs.close
end if


if (ExistingSite = False and Update = "False") or len(BusinessID) < 1  then
		

else
	Query =  " UPDATE Business Set BusinessName = '" &  BusinessName & "' " 
	Query =  Query & " where BusinessID = " & BusinessID & ";" 

end if 


'response.write("Website query = " & Query & "<br>")	

Conn.Execute(Query) 
Conn.close
set Conn = nothing %>
<!--#Include virtual="Conn.asp"-->
<%

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
Conn.close
set Conn = nothing %>
<!--#Include virtual="Conn.asp"-->

<%
if ExistingSite = False and Update = "False" then
		Query =  "INSERT INTO Address (AddressStreet, AddressApt, AddressCity, AddressState, AddressCountry, AddressZip)" 
	    Query =  Query + " Values ('" & AddressStreet  & "'," 
	    Query =  Query & " '" &  AddressApt & "', " 
		Query =  Query & " '" &  AddressCity & "', " 
		Query =  Query & " '" &  AddressState & "', " 
        		Query =  Query & " '" &  AddressCountry & "', " 
		Query =  Query & " '" &  AddressZip & "')" 
Conn.Execute(Query) 
'response.Write("Query=" & Query )
Conn.close
set Conn = nothing %>
<!--#Include virtual="Conn.asp"-->
<%

sql = "select AddressID from Address  Order by AddressID Desc"
		
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	ExistingEvent = False
	If Not rs.eof Then
		AddressID  =rs("AddressID") 
	End If 

rs.close


else
	Query =  " UPDATE Address Set AddressStreet = '" &  AddressStreet & "', " 
	Query =  Query & " AddressApt = '" &  AddressApt & "'," 
	Query =  Query & " AddressCity = '" &  AddressCity & "'," 
      Query =  Query & " AddressState = '" &  AddressState & "'," 
      Query =  Query & " AddressCountry = '" &  AddressCountry & "'," 
      Query =  Query & " AddressZip = '" &   AddressZip & "'" & " where AddressID = " & AddressID & ";" 

Conn.Execute(Query) 
Conn.close
set Conn = nothing %>
<!--#Include virtual="Conn.asp"-->
<%

end if 
daynow= day(now)
monthnow = month(now)
yearnow = year(now)
datenow = monthnow & "/" & daynow & "/" & yearnow
if membership = "FreeTrial" then
datenownext = DateAdd("m", 6, datenow)
else
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
'response.write("datenow = " & datenow)
'response.write("datenownext  = " & datenownext )
'response.write("datenownextlife  = " & datenownextlife )

'response.write("PeopleID=" & PeopleID)
if  len(PeopleID) < 2 then
		Query =  "INSERT INTO People (AddressID, CustCountry, Custstate, ReferringPeopleID, WebsitesID, Accesslevel, custAIStartService, custAIEndService, SubscriptionLevel, MaxAnimals, maxHerdsires, MaxProducts,  FreeMassEmailsPaidFor, FreeMassEmailsUsed, HomepageadsPaidfor, HomepageadsUsed, HeaderadsPaidfor, HeaderadsUsed, FreeAnimalEntryPaidFor, FreeAnimalEntryUsed, AISubscription, AESubscription, Owners, BusinessID,  PeopleFirstName, PeopleLastName, PeoplePhone, Peopleemail, Peoplefax, PeopleCell, PeopleActive,  PeoplePassword , PeopleCreationDate )" 
		Query =  Query & " Values (" &  AddressID & ","
 Query =  Query & " '" &   AddressCountry & "', " 
 Query =  Query & " '" &   AddressState & "', " 

	
     if len(ReferringPeopleID) > 0 and not(ReferringPeopleID="notselected") then
      Query =  Query & " " &   ReferringPeopleID & ", " 
     else
        Query =  Query & "0 , " 
      end if	
		Query =  Query & " " &   WebsitesID & ", " 
		Query =  Query & " -1 , " 

if membership = "freetrial" then
Query =  Query & " ' " & cstr(FormatDateTime(datenow,2)) & " ', " 'custAIStartService
Query =  Query &  " ' " & cstr(FormatDateTime(datenownext ,2)) & "' , " 'custAIEndService
Query =  Query & " 19 , " 'SubscriptionLevel
Query =  Query & " 5, "  'MaxAnimal
Query =  Query & " 0 , " 'maxHerdsires
Query =  Query & " 0 , " 'MaxProducts
Query =  Query & " 0 , " 'FreeMassEmailsPaidFor
Query =  Query & " 0 , " 'FreeMassEmailsUsed
Query =  Query & " 0 , " 'HomepageadsPaidfor
Query =  Query & " 0 , " 'HomepageadsUsed
Query =  Query & " 0 , " 'HeaderadsPaidfor
Query =  Query & " 0 , " 'HeaderadsUsed
Query =  Query & " 0 , " 'FreeAnimalEntryPaidFor
Query =  Query & " 0 , " 'FreeAnimalEntryUsed
end if

if Membership = "student" then
Query =  Query & " ' " & cstr(FormatDateTime(datenow,2)) & " ', " 'custAIStartService
Query =  Query &  " ' " & cstr(FormatDateTime(datenownext ,2)) & "' , " 'custAIEndService
Query =  Query & " 18 , " 'SubscriptionLevel
Query =  Query & " 5, "  'MaxAnimal
Query =  Query & " 0 , " 'maxHerdsires
Query =  Query & " 0 , " 'MaxProducts
Query =  Query & " 0 , " 'FreeMassEmailsPaidFor
Query =  Query & " 0 , " 'FreeMassEmailsUsed
Query =  Query & " 0 , " 'HomepageadsPaidfor
Query =  Query & " 0 , " 'HomepageadsUsed
Query =  Query & " 0 , " 'HeaderadsPaidfor
Query =  Query & " 0 , " 'HeaderadsUsed
Query =  Query & " 0 , " 'FreeAnimalEntryPaidFor
Query =  Query & " 0 , " 'FreeAnimalEntryUsed
end if

if Membership = "tin" then
Query =  Query & " ' " & cstr(FormatDateTime(datenow,2)) & " ', " 'custAIStartService
Query =  Query &  " ' " & cstr(FormatDateTime(datenownext ,2)) & "' , " 'custAIEndService
		Query =  Query & " 0 , " 'SubscriptionLevel
		Query =  Query & " 1, "  'MaxAnimal
		Query =  Query & " 1 , " 'maxHerdsires
		Query =  Query & " 5 , " 'MaxProducts
		Query =  Query & " 0 , " 'FreeMassEmailsPaidFor
		Query =  Query & " 0 , " 'FreeMassEmailsUsed
		Query =  Query & " 0 , " 'HomepageadsPaidfor
		Query =  Query & " 0 , " 'HomepageadsUsed
		Query =  Query & " 0 , " 'HeaderadsPaidfor
		Query =  Query & " 0 , " 'HeaderadsUsed
		Query =  Query & " 0 , " 'FreeAnimalEntryPaidFor
		Query =  Query & " 0 , " 'FreeAnimalEntryUsed
		end if
        
        	
		if Membership = "copper" then
     Query =  Query & " ' " & cstr(FormatDateTime(datenow,2)) & " ', " 'custAIStartService
    Query =  Query &  " ' " & cstr(FormatDateTime(datenownext ,2)) & "' , " 'custAIEndService
		Query =  Query & " 1 , " 'SubscriptionLevel
		Query =  Query & " 5, "  'MaxAnimal
		Query =  Query & " 1 , " 'maxHerdsires
		Query =  Query & " 5 , " 'MaxProducts
		Query =  Query & " 0 , " 'FreeMassEmailsPaidFor
		Query =  Query & " 0 , " 'FreeMassEmailsUsed
		Query =  Query & " 0 , " 'HomepageadsPaidfor
		Query =  Query & " 0 , " 'HomepageadsUsed
		Query =  Query & " 0 , " 'HeaderadsPaidfor
		Query =  Query & " 0 , " 'HeaderadsUsed
		Query =  Query & " 0 , " 'FreeAnimalEntryPaidFor
		Query =  Query & " 0 , " 'FreeAnimalEntryUsed
		end if

        if Membership = "Silk" then
     Query =  Query & " ' " & cstr(FormatDateTime(datenow,2)) & " ', " 'custAIStartService
    Query =  Query &  " ' " & cstr(FormatDateTime(datenownext ,2)) & "' , " 'custAIEndService
		Query =  Query & " 5 , " 'SubscriptionLevel
		Query =  Query & " 0, "  'MaxAnimal
		Query =  Query & " 0 , " 'maxHerdsires
		Query =  Query & " 9999 , " 'MaxProducts
		Query =  Query & " 0 , " 'FreeMassEmailsPaidFor
		Query =  Query & " 0 , " 'FreeMassEmailsUsed
		Query =  Query & " 0 , " 'HomepageadsPaidfor
		Query =  Query & " 0 , " 'HomepageadsUsed
		Query =  Query & " 0, " 'HeaderadsPaidfor
		Query =  Query & " 0 , " 'HeaderadsUsed
		Query =  Query & " 0 , " 'FreeAnimalEntryPaidFor
		Query =  Query & " 0 , " 'FreeAnimalEntryUsed
		end if
		
		if Membership = "silver" then
     Query =  Query & " ' " & cstr(FormatDateTime(datenow,2)) & " ', " 'custAIStartService
    Query =  Query &  " ' " & cstr(FormatDateTime(datenownext ,2)) & "' , " 'custAIEndService
		Query =  Query & " 2 , " 'SubscriptionLevel
		Query =  Query & " 20, "  'MaxAnimal
		Query =  Query & " 3 , " 'maxHerdsires
		Query =  Query & " 5 , " 'MaxProducts
		Query =  Query & " 0 , " 'FreeMassEmailsPaidFor
		Query =  Query & " 0 , " 'FreeMassEmailsUsed
		Query =  Query & " 0 , " 'HomepageadsPaidfor
		Query =  Query & " 0 , " 'HomepageadsUsed
		Query =  Query & " 0 , " 'HeaderadsPaidfor
		Query =  Query & " 0 , " 'HeaderadsUsed
		Query =  Query & " 20 , " 'FreeAnimalEntryPaidFor
		Query =  Query & " 0 , " 'FreeAnimalEntryUsed
		end if
		
	if Membership = "gold" or Membership = "goldfreetrial" or Membership = "basic" then
     Query =  Query & " ' " & cstr(FormatDateTime(datenow,2)) & " ', " 'custAIStartService
    Query =  Query &  " ' " & cstr(FormatDateTime(datenownext ,2)) & "' , " 'custAIEndService
		Query =  Query & " 3 , " 'SubscriptionLevel
		Query =  Query & " 9999, "  'MaxAnimal
		Query =  Query & " 9999 , " 'maxHerdsires
		Query =  Query & " 9999 , " 'MaxProducts
		Query =  Query & " 0 , " 'FreeMassEmailsPaidFor
		Query =  Query & " 0 , " 'FreeMassEmailsUsed
		Query =  Query & " 0 , " 'HomepageadsPaidfor
		Query =  Query & " 0 , " 'HomepageadsUsed
		Query =  Query & " 1 , " 'HeaderadsPaidfor
		Query =  Query & " 0 , " 'HeaderadsUsed
		Query =  Query & " 30 , " 'FreeAnimalEntryPaidFor
		Query =  Query & " 0 , " 'FreeAnimalEntryUsed
		end if


if Membership = "ruby" then
     Query =  Query & " ' " & cstr(FormatDateTime(datenow,2)) & " ', " 'custAIStartService
    Query =  Query &  " ' " & cstr(FormatDateTime(datenownext ,2)) & "' , " 'custAIEndService
		Query =  Query & " 3 , " 'SubscriptionLevel
		Query =  Query & " 9999, "  'MaxAnimal
		Query =  Query & " 9999 , " 'maxHerdsires
		Query =  Query & " 9999 , " 'MaxProducts
		Query =  Query & " 0 , " 'FreeMassEmailsPaidFor
		Query =  Query & " 0 , " 'FreeMassEmailsUsed
		Query =  Query & " 0 , " 'HomepageadsPaidfor
		Query =  Query & " 0 , " 'HomepageadsUsed
		Query =  Query & " 1 , " 'HeaderadsPaidfor
		Query =  Query & " 0 , " 'HeaderadsUsed
		Query =  Query & " 30 , " 'FreeAnimalEntryPaidFor
		Query =  Query & " 0 , " 'FreeAnimalEntryUsed
		end if

        if Membership = "emerald" then
     Query =  Query & " ' " & cstr(FormatDateTime(datenow,2)) & " ', " 'custAIStartService
    Query =  Query &  " ' " & cstr(FormatDateTime(datenownext ,2)) & "' , " 'custAIEndService
		Query =  Query & " 3 , " 'SubscriptionLevel
		Query =  Query & " 9999, "  'MaxAnimal
		Query =  Query & " 9999 , " 'maxHerdsires
		Query =  Query & " 9999 , " 'MaxProducts
		Query =  Query & " 0 , " 'FreeMassEmailsPaidFor
		Query =  Query & " 0 , " 'FreeMassEmailsUsed
		Query =  Query & " 0 , " 'HomepageadsPaidfor
		Query =  Query & " 0 , " 'HomepageadsUsed
		Query =  Query & " 1 , " 'HeaderadsPaidfor
		Query =  Query & " 0 , " 'HeaderadsUsed
		Query =  Query & " 30 , " 'FreeAnimalEntryPaidFor
		Query =  Query & " 0 , " 'FreeAnimalEntryUsed
end if

if Membership = "vendor"  then
    Query =  Query & " ' " & cstr(FormatDateTime(datenow,2)) & " ', " 'custAIStartService
    Query =  Query &  " ' " & cstr(FormatDateTime(datenownextlife ,2)) & "' , " 'custAIEndService
	Query =  Query & " 2 , " 'SubscriptionLevel
	Query =  Query & " 0, "  'MaxAnimal
	Query =  Query & " 0 , " 'maxHerdsires
	Query =  Query & " 9999 , " 'MaxProducts
	Query =  Query & " 0 , " 'FreeMassEmailsPaidFor
	Query =  Query & " 0 , " 'FreeMassEmailsUsed
	Query =  Query & " 0 , " 'HomepageadsPaidfor
	Query =  Query & " 0 , " 'HomepageadsUsed
	Query =  Query & " 0 , " 'HeaderadsPaidfor
	Query =  Query & " 0 , " 'HeaderadsUsed
	Query =  Query & " 0 , " 'FreeAnimalEntryPaidFor
	Query =  Query & " 0 , " 'FreeAnimalEntryUsed
end if

if Membership = "premium" then
    Query =  Query & " ' " & cstr(FormatDateTime(datenow,2)) & " ', " 'custAIStartService
    Query =  Query &  " ' " & cstr(FormatDateTime(datenownextlife ,2)) & "' , " 'custAIEndService
	Query =  Query & " 4 , " 'SubscriptionLevel
	Query =  Query & " 9999, "  'MaxAnimal
	Query =  Query & " 9999 , " 'maxHerdsires
	Query =  Query & " 9999 , " 'MaxProducts
	Query =  Query & " 0 , " 'FreeMassEmailsPaidFor
	Query =  Query & " 0 , " 'FreeMassEmailsUsed
	Query =  Query & " 1 , " 'HomepageadsPaidfor
	Query =  Query & " 0 , " 'HomepageadsUsed
	Query =  Query & " 2 , " 'HeaderadsPaidfor
	Query =  Query & " 0 , " 'HeaderadsUsed
	Query =  Query & " 30 , " 'FreeAnimalEntryPaidFor
	Query =  Query & " 0 , " 'FreeAnimalEntryUsed
end if

if Membership = "complete"  then
    Query =  Query & " ' " & cstr(FormatDateTime(datenow,2)) & " ', " 'custAIStartService
    Query =  Query &  " ' " & cstr(FormatDateTime(datenownextlife ,2)) & "' , " 'custAIEndService
	Query =  Query & " 4 , " 'SubscriptionLevel
	Query =  Query & " 9999, "  'MaxAnimal
	Query =  Query & " 9999 , " 'maxHerdsires
	Query =  Query & " 9999 , " 'MaxProducts
	Query =  Query & " 0 , " 'FreeMassEmailsPaidFor
	Query =  Query & " 0 , " 'FreeMassEmailsUsed
	Query =  Query & " 1 , " 'HomepageadsPaidfor
	Query =  Query & " 0 , " 'HomepageadsUsed
	Query =  Query & " 2 , " 'HeaderadsPaidfor
	Query =  Query & " 0 , " 'HeaderadsUsed
	Query =  Query & " 30 , " 'FreeAnimalEntryPaidFor
	Query =  Query & " 0 , " 'FreeAnimalEntryUsed
end if


		Query =  Query & " True , " 	
		Query =  Query & " True , " 
		Query =  Query & " '" &   Owners & "', " 
		Query =  Query & " " &   BusinessID & ", " 
 		Query =  Query & " '" &  PeopleFirstName & "', " 
		Query =  Query & " '" &  PeopleLastName & "', " 
		Query =  Query & " '" &  PeoplePhone & "', " 
		Query =  Query & " '" &  Peopleemail & "', " 
		Query =  Query & " '" &  Peoplefax & "', " 
		Query =  Query & " '" &  Peoplecell & "', " 
		Query =  Query & " True, " 
        Query =  Query & " '" &  LeftShoe & "', " 
		Query =  Query & " " &  FormatDateTime(Now,2) & ") "
'response.Write("Query = " & Query)
else
	Query =  " UPDATE People Set AddressID = " &  AddressID & ", " 
	Query =  Query & " WebsitesID = " &  WebsitesID & "," 
Query =  Query & " custcountry = '" &  addresscountry & "', " 
Query =  Query & " custstate = '" &  addressstate & "', " 

	Query =  Query & " AISubscription  = True ," 
	Query =  Query & " AESubscription  = True ,"
	      if len(ReferringPeopleID) > 0 and not(ReferringPeopleID="notselected") then
          	Query =  Query & " ReferringPeopleID  = " &   ReferringPeopleID & ", " 
     else
     	Query =  Query & " ReferringPeopleID  = 0 , " 
      end if	
      
	if Membership = "kids" then
     Query =  Query & " custAIStartService = ' " & cstr(FormatDateTime(datenow,2)) & " ', " 'custAIStartService
    Query =  Query &  " custAIEndService = ' " & cstr(FormatDateTime(datenownext ,2)) & "' , " 'custAIEndService
	Query =  Query & " SubscriptionLevel  = 18 ," 
	Query =  Query & " MaxAnimals  = 5 ," 
	Query =  Query & " maxHerdsires  = 0 ," 
	Query =  Query & " MaxProducts  = 0," 
	Query =  Query & " FreeMassEmailsPaidFor  = 0 ," 
	Query =  Query & " FreeMassEmailsUsed  = 0 ," 
	Query =  Query & " HomepageadsPaidfor  = 0 ," 
	Query =  Query & " HomepageadsUsed  = 0 ," 
	Query =  Query & " HeaderadsPaidfor  = 0 ," 
	Query =  Query & " HeaderadsUsed  = 0 ," 
	Query =  Query & " FreeAnimalEntryPaidFor  = 0 ," 
	Query =  Query & " FreeAnimalEntryUsed  = 0 ," 
   end if

	if Membership = "tin" then
     Query =  Query & " custAIStartService = ' " & cstr(FormatDateTime(datenow,2)) & " ', " 'custAIStartService
    Query =  Query &  " custAIEndService = ' " & cstr(FormatDateTime(datenownext ,2)) & "' , " 'custAIEndService
	Query =  Query & " SubscriptionLevel  = 1 ," 
	Query =  Query & " MaxAnimals  = 1 ," 
	Query =  Query & " maxHerdsires  = 1 ," 
	Query =  Query & " MaxProducts  = 1," 
	Query =  Query & " FreeMassEmailsPaidFor  = 0 ," 
	Query =  Query & " FreeMassEmailsUsed  = 0 ," 
	Query =  Query & " HomepageadsPaidfor  = 0 ," 
	Query =  Query & " HomepageadsUsed  = 0 ," 
	Query =  Query & " HeaderadsPaidfor  = 0 ," 
	Query =  Query & " HeaderadsUsed  = 0 ," 
	Query =  Query & " FreeAnimalEntryPaidFor  = 0 ," 
	Query =  Query & " FreeAnimalEntryUsed  = 0 ," 
   end if
	if Membership = "copper" then
     Query =  Query & " custAIStartService = ' " & cstr(FormatDateTime(datenow,2)) & " ', " 'custAIStartService
    Query =  Query &  " custAIEndService = ' " & cstr(FormatDateTime(datenownext ,2)) & "' , " 'custAIEndService
	Query =  Query & " SubscriptionLevel  = 1 ," 
	Query =  Query & " MaxAnimals  = 5 ," 
	Query =  Query & " maxHerdsires  = 1 ," 
	Query =  Query & " MaxProducts  = 5 ," 
	Query =  Query & " FreeMassEmailsPaidFor  = 0 ," 
	Query =  Query & " FreeMassEmailsUsed  = 0 ," 
	Query =  Query & " HomepageadsPaidfor  = 0 ," 
	Query =  Query & " HomepageadsUsed  = 0 ," 
	Query =  Query & " HeaderadsPaidfor  = 0 ," 
	Query =  Query & " HeaderadsUsed  = 0 ," 
	Query =  Query & " FreeAnimalEntryPaidFor  = 0 ," 
	Query =  Query & " FreeAnimalEntryUsed  = 0 ," 
   end if


   	if Membership = "silk" then
     Query =  Query & " custAIStartService = ' " & cstr(FormatDateTime(datenow,2)) & " ', " 'custAIStartService
    Query =  Query &  " custAIEndService = ' " & cstr(FormatDateTime(datenownext ,2)) & "' , " 'custAIEndService
	Query =  Query & " SubscriptionLevel  = 5 ," 
	Query =  Query & " MaxAnimals  =0 ," 
	Query =  Query & " maxHerdsires  = 0 ," 
	Query =  Query & " MaxProducts  = 99999 ," 
	Query =  Query & " FreeMassEmailsPaidFor  = 0 ," 
	Query =  Query & " FreeMassEmailsUsed  = 0 ," 
	Query =  Query & " HomepageadsPaidfor  = 1 ," 
	Query =  Query & " HomepageadsUsed  = 0 ," 
	Query =  Query & " HeaderadsPaidfor  = 0 ," 
	Query =  Query & " HeaderadsUsed  = 0 ," 
	Query =  Query & " FreeAnimalEntryPaidFor  = 0 ," 
	Query =  Query & " FreeAnimalEntryUsed  = 0 ," 
   end if



   	if Membership = "silver" then
     Query =  Query & " custAIStartService = ' " & cstr(FormatDateTime(datenow,2)) & " ', " 'custAIStartService
    Query =  Query &  " custAIEndService = ' " & cstr(FormatDateTime(datenownext ,2)) & "' , " 'custAIEndService
	Query =  Query & " SubscriptionLevel  = 2 ," 
	Query =  Query & " MaxAnimals  = 20," 
	Query =  Query & " maxHerdsires  = 3 ," 
	Query =  Query & " MaxProducts  = 5 ," 
	Query =  Query & " FreeMassEmailsPaidFor  = 0 ," 
	Query =  Query & " FreeMassEmailsUsed  = 0 ," 
	Query =  Query & " HomepageadsPaidfor  = 0 ," 
	Query =  Query & " HomepageadsUsed  = 0 ," 
	Query =  Query & " HeaderadsPaidfor  = 1," 
	Query =  Query & " HeaderadsUsed  = 0 ," 
	Query =  Query & " FreeAnimalEntryPaidFor  = 20 ," 
	Query =  Query & " FreeAnimalEntryUsed  = 0 ," 
   end if

if Membership = "gold" or Membership = "goldfreetrial" or Membership = "basic" then
     Query =  Query & " custAIStartService = ' " & cstr(FormatDateTime(datenow,2)) & " ', " 'custAIStartService
    Query =  Query &  " custAIEndService = ' " & cstr(FormatDateTime(datenownext ,2)) & "' , " 'custAIEndService
	Query =  Query & " SubscriptionLevel  = 3 ," 
	Query =  Query & " MaxAnimals  = 9999 ," 
	Query =  Query & " maxHerdsires  = 9999 ," 
	Query =  Query & " MaxProducts  = 9999 ," 
	Query =  Query & " FreeMassEmailsPaidFor  = 0 ," 
	Query =  Query & " FreeMassEmailsUsed  = 0 ," 
	Query =  Query & " HomepageadsPaidfor  = 1 ," 
	Query =  Query & " HomepageadsUsed  = 0 ," 
	Query =  Query & " HeaderadsPaidfor  = 2 ," 
	Query =  Query & " HeaderadsUsed  = 0 ," 
	Query =  Query & " FreeAnimalEntryPaidFor  = 30 ," 
	Query =  Query & " FreeAnimalEntryUsed  = 0 ," 
   end if



if Membership = "vendor" then
    Query =  Query & " custAIStartService = ' " & cstr(FormatDateTime(datenow,2)) & " ', " 'custAIStartService
    Query =  Query &  " custAIEndService = ' " & cstr(FormatDateTime(datenownextlife ,2)) & "' , " 'custAIEndService
	Query =  Query & " SubscriptionLevel  = 2 ," 
	Query =  Query & " MaxAnimals  = 0 ," 
	Query =  Query & " maxHerdsires  = 0 ," 
	Query =  Query & " MaxProducts  = 9999 ," 
	Query =  Query & " FreeMassEmailsPaidFor  = 0 ," 
	Query =  Query & " FreeMassEmailsUsed  = 0 ," 
	Query =  Query & " HomepageadsPaidfor  = 0 ," 
	Query =  Query & " HomepageadsUsed  = 0 ," 
	Query =  Query & " HeaderadsPaidfor  = 0 ," 
	Query =  Query & " HeaderadsUsed  = 0 ," 
	Query =  Query & " FreeAnimalEntryPaidFor  = 0 ," 
	Query =  Query & " FreeAnimalEntryUsed  = 0 ," 
end if



   if Membership = "platinum" or Membership = "platinumplus" or Membership = "premium" then
     Query =  Query & " custAIStartService = ' " & cstr(FormatDateTime(datenow,2)) & " ', " 'custAIStartService
    Query =  Query &  " custAIEndService = ' " & cstr(FormatDateTime(datenownextlife ,2)) & "' , " 'custAIEndService
	Query =  Query & " SubscriptionLevel  = 4 ," 
	Query =  Query & " MaxAnimals  = 9999 ," 
	Query =  Query & " maxHerdsires  = 9999 ," 
	Query =  Query & " MaxProducts  = 9999 ," 
	Query =  Query & " FreeMassEmailsPaidFor  = 0 ," 
	Query =  Query & " FreeMassEmailsUsed  = 0 ," 
	Query =  Query & " HomepageadsPaidfor  = 2 ," 
	Query =  Query & " HomepageadsUsed  = 0 ," 
	Query =  Query & " HeaderadsPaidfor  = 3 ," 
	Query =  Query & " HeaderadsUsed  = 0 ," 
	Query =  Query & " FreeAnimalEntryPaidFor  = 30 ," 
	Query =  Query & " FreeAnimalEntryUsed  = 0 ," 
   end if
   

      if Membership = "complete" then
     Query =  Query & " custAIStartService = ' " & cstr(FormatDateTime(datenow,2)) & " ', " 'custAIStartService
    Query =  Query &  " custAIEndService = ' " & cstr(FormatDateTime(datenownextlife ,2)) & "' , " 'custAIEndService
	Query =  Query & " SubscriptionLevel  = 4 ," 
	Query =  Query & " MaxAnimals  = 9999 ," 
	Query =  Query & " maxHerdsires  = 9999 ," 
	Query =  Query & " MaxProducts  = 9999 ," 
	Query =  Query & " FreeMassEmailsPaidFor  = 0 ," 
	Query =  Query & " FreeMassEmailsUsed  = 0 ," 
	Query =  Query & " HomepageadsPaidfor  = 2 ," 
	Query =  Query & " HomepageadsUsed  = 0 ," 
	Query =  Query & " HeaderadsPaidfor  = 3 ," 
	Query =  Query & " HeaderadsUsed  = 0 ," 
	Query =  Query & " FreeAnimalEntryPaidFor  = 30 ," 
	Query =  Query & " FreeAnimalEntryUsed  = 0 ," 
   end if


	Query =  Query & " Owners  = '" &  Owners & "'," 
	Query =  Query & " BusinessID  = " &  BusinessID & "," 
    Query =  Query & " PeopleFirstName = '" &  PeopleFirstName & "'," 
    Query =  Query & " PeopleLastName = '" &  PeopleLastName & "'," 
    Query =  Query & " PeoplePhone = '" &  PeoplePhone & "'," 
    Query =  Query & " Peopleemail = '" &  Peopleemail & "'," 
    Query =  Query & " Peoplefax = '" &  Peoplefax & "',"
    Query =  Query & " PeopleCell = '" &  PeopleCell & "'"
    Query =  Query & " where PeopleID = " & PeopleID & ";" 

end if 
'response.Write("Membership=" & Membership)	
'response.Write("Query=" & Query)	
if existing = false then
Conn.Execute(Query) 
end if
Conn.close
Set Conn = Nothing %>

<!--#Include virtual="Conn.asp"-->
	
<%
if existing = false then 

 sql = "select PeopleID from People where AddressID = " & AddressID  & " order by PeopleID Desc;"
Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	If Not rs.eof Then
		PeopleID = rs("PeopleID")
		session("PeopleID") = PeopleID
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
Query =  Query & " Values (True,"
Query =  Query &   " '" & FirstName & "' , " 
Query =  Query &    " '" & lastName & "',"
if  InStr(Interest, "Products") > 0  Then
Products = True
Query =  Query & " True, "
end if 
if  InStr(Interest, "Alpacas") > 0  Then
Alpacas = True
Query =  Query & " True, "
end if 

if  InStr(Interest, "Bison") > 0  Then
Bison = True
Query =  Query & " True, "
end if

if  InStr(Interest, "Cattle") > 0  Then
Cattle = True
Query =  Query & " True, "
end if 

if  InStr(Interest, "Chickens") > 0  Then
Chickens = True
Query =  Query & " True, "
end if 

if  InStr(Interest, "Dogs") > 0  Then
Dogs = True
Query =  Query & " True, "
end if 

if  InStr(Interest, "Donkeys") > 0  Then
Donkeys = True
Query =  Query & " True, "
end if 

if  InStr(Interest, "Goats") > 0  Then
Goats = True
Query =  Query & " True, "
end if 

if  InStr(Interest, "Horses") > 0  Then
Horses = True
Query =  Query & " True, "
end if

if InStr(Interest, "Llamas") > 0  Then
Llamas = True
Query =  Query & " True, "
end if 

if  InStr(Interest, "Pigs") > 0  Then
Pigs = True
Query =  Query & " True, "
end if 

if InStr(Interest, "Rabbits") > 0  Then
Rabbits = True
Query =  Query & " True, "
end if 

if  InStr(Interest, "Sheep") > 0  Then
Sheep = True
Query =  Query & " True, "
end if 

if  InStr(Interest, "Turkeys") > 0  Then
Turkeys = True
Query =  Query & " True, "
end if 
 
if  InStr(Interest, "Yaks") > 0  Then
Yaks = True
Query =  Query & " True, "
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
%>

 <% showaddress = false
 if showaddress = true then %>   
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%" >
<tr><td  valign = "top" >
    
<table border = "0" width = "100%" align = "center"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=5>
	<tr>
		<td class = "body2" colspan = "2" align = "left">
				<h1>Your Account Information</h1>
                	Please review your information below: 


<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=5 cellspacing=0   height = "180">
<tr>
		<td class ="body2" valign = "top" colspan = "2" >
			<br>
		</td>
	</tr>
     
<tr>
	<td class = "body2" align = "right" width = "220">
		Membership: &nbsp;
	</td>
	<td class = "body2" align = "left" width = "350">
		<%=Membership%>
	</td>
</tr>

<tr>
	<td class = "body2" align = "right" width = "220">
		First Name: &nbsp;
	</td>
	<td class = "body2" align = "left" width = "350">
		<%=PeopleFirstName%>
	</td>
</tr>
<tr>
	<td class = "body2" align = "right">
		Last Name: &nbsp;
	</td>
	<td class = "body2" align = "left">
		<%=PeopleLastName%>
	</td>
</tr><tr>
	<td  class = "body2" align = "right">
		Owners: &nbsp;
	</td>
	<td class = "body2" align = "left" >
			<%=Owners %>
    	</td>
	</tr>
    <% if not (lcase(Membership)="kids") then %>
<tr>
	<td  class = "body2" align = "right">
		Business Name:*
	</td>
	<td class = "body2"  align = "left" >
			<%=BusinessName %>
    	</td>
	</tr>
	
<tr>
	<td class = "body2" align = "right">
			Your Website: &nbsp;
		</td>
		<td class = "body2" align = "left">
			http://<%=PeopleWebsite%>
		</td>
	</tr>
    <% end if %>
	<tr>
		<td   class = "body2" align = "right">
			Email: &nbsp;
		</td>
		<td  align = "left" valign = "top" class = "body2" align = "left">
			<%=PeopleEmail%>
		</td>
	</tr>
    <% if not (lcase(Membership)="kids")  and not (lcase(Membership)="goldfreetrial")  then %>
	<tr>
		<td class ="body2"  height = "30" align = "right">
			I was referred by:
		</td>
        <td class ="body2"  height = "30" >
        <% if len(ReferringPeopleID) > 0 and not (ReferringPeopleID = "notselected") then 
        sql = "SELECT People.PeopleId, Business.BusinessName from People, Business where People.BusinessID = Business.BusinessID and people.PeopleiD = " & ReferringPeopleID 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, Conn, 3, 3 %>
<% = rs("BusinessName") %>
<% rs.close 
else%>
N/A
<% end if %>
		</td>
	</tr>
    <% end if %>
</table>

</td>
<td width = "50%" valign = "Top" align = "left">
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=5 cellspacing=0  width = "100%" height = "180">
<tr>
		<td class ="body2" valign = "top" colspan = "2" height = "75" >
			<br>
		</td>
	</tr>
<tr>
<td   class = "body2" align = "right" width = "140">
Mailing Address: &nbsp;
</td>
<td  align = "left" valign = "top" class = "body2" align = "left"><%=AddressStreet%></td></tr>
<tr><td   class = "body2"  align = "right">Apartment/Suite:&nbsp;</td>
<td  valign = "top" class = "body2" align = "left"><%=AddressApt%></td></tr>
<tr><td   class = "body2" align = "right">
City: &nbsp;</td>
<td  valign = "top" class = "body2" align = "left">
<%=AddressCity%>
</td></tr>
<tr><td  align = "right" class = "body2">
State/ Provence:&nbsp;
</td>
<td  align = "left" valign = "top" class = "body2">
<%=AddressState%>&nbsp;
</td>
</tr>
<tr><td  align = "right" class = "body2">
Country:&nbsp;
</td>
<td  align = "left" valign = "top" class = "body2">
<%=AddressCountry%>&nbsp;
</td>
</tr>
<tr>
<td   class = "body2" align = "right">
Postal Code: &nbsp;
</td>
<td  align = "left" valign = "top" class = "body2">
<%=AddressZip%>
</td></tr>
<tr><td   class = "body2" align = "right">
Phone: &nbsp;
</td>
<td  align = "left" valign = "top" class = "body2">
<%=PeoplePhone%>
</td></tr>
<tr><td   class = "body2" align = "right">
Cell: &nbsp;
</td>
<td  align = "left" valign = "top" class = "body2">
<%=PeopleCell%>
</td></tr>
<tr><td   class = "body2" align = "right">
Fax: &nbsp;
</td>
<td  align = "left" valign = "top" class = "body2">
<%=PeopleFax%>
</td></tr>
<tr><td class ="body2" valign = "top" colspan = "2" >
<br>
</td></tr></table>
</td></tr></table>
<% end if %>



<table width = "<%=screenwidth %>" align = "center"  border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<tr><td class ="body" valign = "top" ><br />


<% if BadCoupon = True and len(Couponcode) > 1 then
Couponcode = "" %>
<font color = "mariooon"><b>Invalid Coupon. Please try again.</b></font>
<% end if %>
<% showcoupons = true
if showcoupons = true then %>
<form  name=form method="post" action="/SetupAccountStep2.asp?Membership=<%=Membership %>&PeopleID=<%=PeopleID%>&ReturnFileName=<%=ReturnFileName%>&ExistingAccount=True&ReferringPeopleID=<%=ReferringPeopleID %>&Update=True&coupon=True">
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  align = "center"><tr><td colspan="4"   class = "body" > 
Coupon Code:<INPUT TYPE="TEXT" NAME="Couponcode" size="15" value="<%=Couponcode%>"><input type=submit value="Apply Code" class = "regsubmit2">
<INPUT TYPE="hidden" NAME="Years" value="<%=Years %>">
<INPUT TYPE="hidden" NAME="PeopleFirstName" value="<%=PeopleFirstName %>">
<INPUT TYPE="hidden" NAME="PeopleLastName" value="<%=PeopleLastName %>">
<INPUT TYPE="hidden" NAME="PeopleTitleID" value="<%=PeopleTitleID %>">
<INPUT TYPE="hidden" NAME="PeopleWebsite" value="<%=PeopleWebsite %>">
<INPUT TYPE="hidden" NAME="PeopleEmail" value="<%=PeopleEmail %>">
<INPUT TYPE="hidden" NAME="ReferringPeopleID" value="<%=ReferringPeopleID %>">
<INPUT TYPE="hidden" NAME="AddressStreet" value="<%=AddressStreet %>">
<INPUT TYPE="hidden" NAME="AddressApt" value="<%=AddressApt %>">
<INPUT TYPE="hidden" NAME="AddressCity" value="<%=AddressCity %>">
<INPUT TYPE="hidden" NAME="AddressState" value="<%=AddressState %>">
<INPUT TYPE="hidden" NAME="AddressCountry" value="<%=AddressCountry %>">
<INPUT TYPE="hidden" NAME="AddressZip" value="<%=AddressZip %>">
<INPUT TYPE="hidden" NAME="PeoplePhone" value="<%=PeoplePhone %>">
<INPUT TYPE="hidden" NAME="PeopleCell" value="<%=PeopleCell %>">
<INPUT TYPE="hidden" NAME="PeopleFax" value="<%=PeopleFax %>">
<INPUT TYPE="hidden" NAME="Owners" value="<%=Owners %>">
<INPUT TYPE="hidden" NAME="BusinessName" value="<%=BusinessName%>">


</form>

<br>
<% 
if showcoupons = True then %>
Available Coupons:
<ul><li>50% Off Platinum or Platinum Plus Website (Enter Code: Black2015)</li></ul>
</td></tr></table>
<% end if %>
<% end if %>

<br><br>
<br><br>
</td>
<td class ="body2" valign = "top"  align = "center">
<% if membership = "tin" or membership = "kids" or membership = "gold" or membership = "student" or membership = "FreeTrial" or membership = "goldfreetrial" then
else %>

<form  name=form method="post" action="/SetupAccountStep2.asp?Membership=<%=Membership %>&PeopleID=<%=PeopleID%>&ReturnFileName=<%=ReturnFileName%>&ExistingAccount=True&ReferringPeopleID=<%=ReferringPeopleID %>&Update=True&coupon=<%=coupon %>&QuantityChange=True">
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  align = "center"><tr><td colspan="4"   class = "body" > 

<% 
brokeringmembership = False
if brokeringmembership = True then
if membership = "platinumplus" then %>



Number of Animals: 

<input type=text onBlur="checkNumeric(this,-5,5000,',','.','-');" name='animals' size=10 maxlength=10 Value= "<%=animals %>"><b><i>(Must be a number.)</i></b><br>



<% else %>



I want my animals and products to show up on:

<% if LOASignup = True then %>
&nbsp; <input type="checkbox" name="Website" value="Livestock Of America" class = "formbox" checked>&nbsp;<big>Livestock Of America</big><br>
<% else %>
&nbsp; <input type="checkbox" name="Website" value="Livestock Of America" class = "formbox" >&nbsp;<big>Livestock Of America</big><br>
<% end if %>
<br>
<% if LOCSignup = True then %>
&nbsp; <input type="checkbox" name="website" value="Livestock Of Canada" class = "formbox" checked>&nbsp;<big>Livestock Of Canada</big><br>
<% else %>
&nbsp; <input type="checkbox" name="website" value="Livestock Of Canada" class = "formbox">&nbsp;<big>Livestock Of Canada</big><br>
<% end if %>



Number of Years<br>
<select size="1" name="years">
<% If Len(years) > 0 then%>
<option value="<%=years%>" selected><%=years%></option>
<% End If %>
<option value="1">1</option>
<option  value="2">2</option>
<option  value="3">3</option>
<option  value="4">4</option>
<option  value="5">5</option>
<option  value="6">6</option>
<option  value="7">7</option>
</select>

<% end if %>
<% end if %>



<% if ExistingAccount = False  then %>
ExistingAccount = <%=ExistingAccount %>

<% if (Membership ="platinum" or Membership ="premium" or Membership ="vendor" or membership = "basic") and ExistingAccount = false  then %>

<form  name=form method="post" action="/SetupAccountStep2.asp?Membership=<%=Membership %>&PeopleID=<%=PeopleID%>&ReturnFileName=<%=ReturnFileName%>&ExistingAccount=True&ReferringPeopleID=<%=ReferringPeopleID %>&Update=True&coupon=<%=coupon %>&QuantityChange=True">


Number of Years:
 <select size="1" name="years" onchange="this.form.submit()" class = "formbox">
<% If Len(years) > 0 then%>
<option value="<%=years%>" selected><%=years%></option>
<% End If %>
<option value="1">1</option>
<option value="2">2</option>
<option value="3">3</option>
<option  value="4">4</option>
<option  value="5">5</option>
<option  value="6">6</option>
<option  value="7">7</option>
</select>
<% end if %>



<INPUT TYPE="hidden" NAME="PeopleFirstName" value="<%=PeopleFirstName %>">
<INPUT TYPE="hidden" NAME="PeopleLastName" value="<%=PeopleLastName %>">
<INPUT TYPE="hidden" NAME="PeopleTitleID" value="<%=PeopleTitleID %>">
<INPUT TYPE="hidden" NAME="PeopleWebsite" value="<%=PeopleWebsite %>">
<INPUT TYPE="hidden" NAME="PeopleEmail" value="<%=PeopleEmail %>">
<INPUT TYPE="hidden" NAME="ReferringPeopleID" value="<%=ReferringPeopleID %>">
<INPUT TYPE="hidden" NAME="AddressStreet" value="<%=AddressStreet %>">
<INPUT TYPE="hidden" NAME="AddressApt" value="<%=AddressApt %>">
<INPUT TYPE="hidden" NAME="AddressCity" value="<%=AddressCity %>">
<INPUT TYPE="hidden" NAME="AddressState" value="<%=AddressState %>">
<INPUT TYPE="hidden" NAME="AddressCountry" value="<%=AddressCountry %>">
<INPUT TYPE="hidden" NAME="AddressZip" value="<%=AddressZip %>">
<INPUT TYPE="hidden" NAME="PeoplePhone" value="<%=PeoplePhone  %>">
<INPUT TYPE="hidden" NAME="PeopleCell" value="<%=PeopleCell %>">
<INPUT TYPE="hidden" NAME="PeopleFax" value="<%=PeopleFax %>">
<INPUT TYPE="hidden" NAME="Owners" value="<%=Owners %>">
<INPUT TYPE="hidden" NAME="BusinessName" value="<%=BusinessName%>">
<INPUT TYPE="hidden" NAME="Couponcode" value="<%=Couponcode %>">
<% if brokeringmembership = True then %>
<center><input type=submit value="Submit Change" class = "regsubmit2"></center>
<% end if %>
</form>
<% end if %>


<% if membership = "tin" or membership = "kids" or membership = "student" or membership = "FreeTrial" or membership = "goldfreetrial" or membership = "gold"  then %>


<% else %>


<% if existingaccount = False then %>






<%

' discount = 0
  returnaddress = "http://www.LivestockOfAmerica.com/SignUpCompletion.asp?PeopleID=" & PeopleID
  If membership = "student" then
  Rate = 0.00
  returnaddress = "http://www.LivestockOfAmerica.com/SignUpCompletion.asp?PeopleID=" & PeopleID
 end if
If membership = "tin" then
  Rate = 0.00
  returnaddress = "http://www.LivestockOfAmerica.com/SignUpCompletion.asp?PeopleID=" & PeopleID
 end if

 If membership = "basic" then
  Rate = 3.00
  returnaddress = "http://www.LivestockOfAmerica.com/SignUpCompletion.asp?PeopleID=" & PeopleID
 end if

  If membership = "copper" then
  if discount > 0 then
DiscountRate = 19.95* (100- discount)/100 
end if
  Rate = 19.95
 returnaddress = "http://www.LivestockOfAmerica.com/SignUpCompletionnoemail.asp?PeopleID=" & PeopleID
 end if

If membership = "vendor" then
  if discount > 0 then
DiscountRate = 24.95 * (100- discount)/100 
   end if
   Rate = 24.95
 
    returnaddress = "http://www.LivestockOfAmerica.com/SignUpCompletionnoemail.asp?PeopleID=" & PeopleID
 end if



 If membership = "Silk" then
  Rate = 48
    returnaddress = "http://www.LivestockOfAmerica.com/SignUpCompletionnoemail.asp?PeopleID=" & PeopleID
 end if
 
  If lcase(membership) = "platinumplus" then
  if discount > 0 then
DiscountRate = 1050
end if
  Rate = 145

   returnaddress = "http://www.LivestockOfAmerica.com/SignUpCompletionnoemail.asp?PeopleID=" & PeopleID
 end if


  If lcase(membership) = "platinum" then
  if discount > 0 then
DiscountRate = 85 * (100- discount)/100 
end if
  Rate = 85

   returnaddress = "http://www.LivestockOfAmerica.com/SignUpCompletionnoemail.asp?PeopleID=" & PeopleID
 end if

   If lcase(membership) = "premium" then
  if discount > 0 then
DiscountRate = 48.95 * (100- discount)/100 
end if
  Rate = 48.95

   returnaddress = "http://www.LivestockOfAmerica.com/SignUpCompletionnoemail.asp?PeopleID=" & PeopleID
 end if



   If lcase(membership) = "complete" then
  if discount > 0 then
DiscountRate = 115 * (100- discount)/100 
end if
  Rate = 115

   returnaddress = "http://www.LivestockOfAmerica.com/SignUpCompletionnoemail.asp?PeopleID=" & PeopleID
 end if



  If lcase(membership) = "sapphire" then
   Rate = 349
   returnaddress = "http://www.LivestockOfAmerica.com/SignUpCompletionnoemail.asp?PeopleID=" & PeopleID
 end if
   If lcase(trim(membership)) = "ruby" then
   Rate = 489
   returnaddress = "http://www.LivestockOfAmerica.com/SignUpCompletionnoemail.asp?PeopleID=" & PeopleID
 end if

    If lcase(membership) = "emerald" then
   Rate = 629
   returnaddress = "http://www.LivestockOfAmerica.com/SignUpCompletionnoemail.asp?PeopleID=" & PeopleID
 end if
     If lcase(membership) = "diamond" then
   Rate = 899
   returnaddress = "http://www.LivestockOfAmerica.com/SignUpCompletionnoemail.asp?PeopleID=" & PeopleID
 end if
 OrderTotal = Rate * years 

   '	TempMinusAccount
if membership="platinumplus" then
OrderTotal = 1050
Rate = 1050
end if

if discount > 0 then
DiscountRate = rate * (discount/100)
else
DiscountRate = Rate
end if
   OrderTotal = DiscountRate * years 
 %>
 <table width = "320" border = 0 cellpadding = 3 cellspacing = 3><tr>
<% if discount > 0 then %>
 <td class = "body2" align = "right">Full Price: <br />
 Discount Price:<br />
<b> Order Total:</b> <br />
 </td>
<td class = "body2" align= "right">
<% if membership="platinumplus" then%>
<%=formatcurrency(Rate) %> <br />
<%=formatcurrency(DiscountRate) %><br />
<b><%=formatcurrency(OrderTotal) %></b><img src = "/images/px.gif" height = "1" width = "43" /><br />
<% else %>
<%=formatcurrency(Rate) %> / year<br />
<%=formatcurrency(DiscountRate) %> / year<br />
<b><%=formatcurrency(OrderTotal) %></b><img src = "/images/px.gif" height = "1" width = "43" /><br />
<% end if %>
</td>
<% else %>

<% if membership="platinumplus" then
OrderTotal = 1050
'multiple animal discount
'multipleanimldiscount = False
'if multipleanimldiscount = True then

'if animals > 5 and animals < 8 then
'OrderTotal = Rate *5
'end if

'if animals > 7 and animals < 11 then
'OrderTotal = Rate * (animals-2)
'end if


'if animals > 10 and animals < 21 then
'OrderTotal = Rate * (animals-4)
'end if

'if animals > 20 and animals < 31 then
'OrderTotal = Rate * (animals-6)
'end if

'if animals > 30 and animals < 41 then
'OrderTotal = Rate * (animals-8)
'end if

'if animals > 40 and animals < 51 then
'OrderTotal = Rate * (animals-10)
'end if

'if animals > 50 and animals < 61 then
'OrderTotal = Rate * (animals-12)
'end if

'if animals > 60 and animals < 71 then
'OrderTotal = Rate * (animals-14)
'end if

'if animals > 70 and animals < 81 then
'OrderTotal = Rate * (animals-16)
'end if

'if animals > 80 and animals < 91 then
'OrderTotal = Rate * (animals-18)
'end if

'if animals > 90 and animals < 101 then
'OrderTotal = Rate * (animals-20)
'end if

'if animals > 100 and animals < 111 then
'OrderTotal = Rate * (animals-22)
'end if

'if len(OrderTotal) > 2 then
'else
'OrderTotal = Rate * animals
'end if

'end if

'OrderTotal = Rate * animals
%>



<td class = "body2" align = "right">
<% if brokeringmembership = True then %>
Price:<br />
<% end if %>
<b> Order Total:</b> <br /></td>

<td class = "body2" order = "right">
<% if brokeringmembership = True then %>
<%=formatcurrency(Rate) %> / animal<br />
<% end if %>
<b><%=formatcurrency(OrderTotal) %></b></td>


<% else %>


<td class = "body2" align = "right">Price:<br />
<b> Order Total:</b> <br /></td>
<td class = "body2" order = "right"><%=formatcurrency(Rate) %> per year per website<br />
 <b><%=formatcurrency(OrderTotal) %></b></td>
 <% end if %>
<% end if %>
</tr></table>
  
<% test = False
if membership = "platinumplus" then %>


<% if test = True then %>
<center>
<form action="https://www.sandbox.paypal.com/cgi-bin/webscr" method="post" target = "_blank">
<% else %>
<form action="https://www.paypal.com/cgi-bin/webscr" method="post" target = "_blank">
<% end if %>
<input type="hidden" name="cmd" value="_cart">
<input type="hidden" name="upload" value="1">
<input type="hidden" name="business" value="ContactUs@LivestockOfAmerica.com">   
<input type="hidden" name="page_style" value="LivestockOfTheWorld">
<input type="hidden" name="currency_code" value="US">
<% if test = True then %>
<input type="hidden" name="notify_url" value="http://www.LivestockOfAmerica.com/LOAOrderCompletion.asp">  
<% else %>
<input type="hidden" name="notify_url" value="http://www.LivestockOfAmerica.com/LOAOrderCompletion.asp">  
<% end if %>
<input type="hidden" name="item_name_1" value="Custom Website + Platinum Membership">
<% if brokeringmembership = True then %>
<input type="hidden" name="amount_1" value="<%=DiscountRate%>">
<input type="hidden" name="quantity_1" value="<%=Animals%>">
<% else %>
<input type="hidden" name="amount_1" value="<%=OrderTotal%>">
<% end if %>

<INPUT TYPE="hidden" NAME="first_Name" value="<%=PeopleFirstName %>">
<INPUT TYPE="hidden" NAME="last_Name" value="<%=PeopleLastName %>">
<INPUT TYPE="hidden" NAME="address1" value="<%=AddressStreet %>">
<INPUT TYPE="hidden" NAME="AddressApt" value="<%=AddressApt %>">
<INPUT TYPE="hidden" NAME="city" value="<%=AddressCity %>">
<INPUT TYPE="hidden" NAME="state" value="<%=AddressState %>">
<INPUT TYPE="hidden" NAME="country" value="<%=AddressCountry %>">
<INPUT TYPE="hidden" NAME="zip" value="<%=AddressZip %>">
<input name="custom" type="hidden" id="custom" value="<%=PeopleID %>"> 
<input type="hidden" name="cbt" value="Return to Livestock Of The World">
<input type="hidden" name="return" value="http://www.LivestockOfAmerica.com/SignUpCompletionPage.asp">
<input type="hidden" name="rm" value="2">
<input type="hidden" name="cancel_return" value="http://www.LivestockOfTheWorld.com/SetupAccountStep2.asp?PeopleID=<%=PeopleID%>&Peopleemail=<%=Peopleemail %>">
 
<center><input type="image" src="/administration/images/paynow.jpg" border="0" name="submit" ></center>
</form>
</center>





<% else 
if OrderTotal > 0 then

if test = True then %>
<center>
<form action="https://www.sandbox.paypal.com/cgi-bin/webscr" method="post" target = "_blank">
<% else %>
<form action="https://www.paypal.com/cgi-bin/webscr" method="post" target = "_blank">
<% end if %>
<input type="hidden" name="cmd" value="_cart">
<input type="hidden" name="upload" value="1">
<input type="hidden" name="business" value="ContactUs@LivestockOfAmerica.com">   
<input type="hidden" name="page_style" value="LivestockOfTheWorld">
<input type="hidden" name="currency_code" value="US">
<% if test = True then %>
<input type="hidden" name="notify_url" value="http://www.LivestockOfAmerica.com/LOAOrderCompletion.asp">  
<% else %>
<input type="hidden" name="notify_url" value="http://www.LivestockOfAmerica.com/LOAOrderCompletion.asp">  
<% end if %>
<input type="hidden" name="item_name_1" value="Livestock Of The World <%=membership %> Membership">
<input type="hidden" name="amount_1" value="<%=Ordertotal%>">
<input type="hidden" name="quantity" value="<%=years%>">
<INPUT TYPE="hidden" NAME="first_Name" value="<%=PeopleFirstName %>">
<INPUT TYPE="hidden" NAME="last_Name" value="<%=PeopleLastName %>">
<INPUT TYPE="hidden" NAME="address1" value="<%=AddressStreet %>">
<INPUT TYPE="hidden" NAME="AddressApt" value="<%=AddressApt %>">
<INPUT TYPE="hidden" NAME="city" value="<%=AddressCity %>">
<INPUT TYPE="hidden" NAME="state" value="<%=AddressState %>">
<INPUT TYPE="hidden" NAME="country" value="<%=AddressCountry %>">
<INPUT TYPE="hidden" NAME="zip" value="<%=AddressZip %>">
<input name="custom" type="hidden" id="custom" value="<%=PeopleID %>"> 
<input type="hidden" name="cbt" value="Return to Livestock Of The World">
<input type="hidden" name="return" value="http://www.LivestockOfAmerica.com/SignUpCompletionPage.asp">
<input type="hidden" name="rm" value="2">
<input type="hidden" name="cancel_return" value="http://www.LivestockOfTheWorld.com/SetupAccountStep2.asp?PeopleID=<%=PeopleID%>&Peopleemail=<%=Peopleemail %>">
 
<center><input type="image" src="/administration/images/paynow.jpg" border="0" name="submit" ></center>
</form>
</center>
<% end if %>
<% end if %>
<% end if %>
</td></tr></table>
</td></tr></table>
<%end if %>
<%end if %>	
</td></tr></table>
  </td></tr></table>
<% end if %>
<% end if %>
<!--#Include Virtual="/Footer.asp"-->
</Body>
</HTML>

