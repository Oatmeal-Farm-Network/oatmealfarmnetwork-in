<!DOCTYPE html>
<html xmlns="https://www.w3.org/1999/xhtml">
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
<!-- https://www.shiningstar.net -->
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
showcoupons = True
showdonation = False

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
else
Membership ="freetrial"
end if

Membership = lcase(Membership)

'response.write("Membership1=" & Membership )
website = request.querystring("website") 

if len(website) > 0 then
else
website = request.form("website") 
end if

websitesignupcount = 0


if membership = "freetrial" then


websitesignupcount = 1

else

if (InStr(website, "Livestock Of America") > 0 or InStr(website, "LOA") > 0) and len(peopleID) > 1  Then







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

if InStr(website, "Livestock Of Canada") > 0 or InStr(website, "LOC") > 0 and len(peopleID) > 1 Then
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

'response.write("PeopleFirstName=" & PeopleFirstName )
'response.write("PeopleLastName=" & PeopleLastName )


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



'response.write("session Peopleemail=" & session("Peopleemail") )

ConfirmEmail =Request.Form("ConfirmEmail") 
confirm  =Request.Form("confirm") 
AddressStreet = Request.Form("AddressStreet") 
AddressApt = Request.Form("AddressApt") 
AddressCity  = Request.Form("AddressCity")
AddressState  = Request.Form("state")
AddressCountry  = Request.Form("country")

if AddressCountry = "United States (USA)" then
AddressCountry = "USA"
end if
'response.write("AddressCountry=" & AddressCountry )

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

<% Membership = request.querystring("Membership") 
 %>

<% Current = "Home"
Current3="Register"
'CurrentWebsite = "LivestockofAmerica" 
session("LoggedIn") = False%>
<!--#Include virtual="/Header.asp"-->
<% if screenwidth > 700 then %>
<!--#Include virtual="/join/JoinHeader.asp"-->
<% end if %> 

<h1>Create Your Account - Step 2</h1>

<% ' response.write("MembershipX=" & Membership )
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
str2 = "https://"
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

discount = 0

BadCoupon = False

Couponcode = request.form("Couponcode")
'response.write("Couponcode=" & Couponcode )
if len(Coupon) > 0 then

if Ucase(trim(Couponcode)) = "ID2017" then
discount = 20 ' percent

else
BadCoupon = True
end if

Coupon = True
else
if QuantityChange = "True" then
else
ExistingAccount = False
sql = "select * from People  where accesslevel > 0 and (Peopleemail = '" & Peopleemail & "')"
'response.write("sql=" & sql)
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
<% if screenwidth > 620 then %>
<table width = 640 align = center>
<% else %>
<table width = 320 align = center>
<% end if %>
<tr><td class = "body">
<h2>Existing Account</h2>
There already is an account with email address <b><%=Peopleemail %></b>. To make changes to your account please <a href = "/members/" class = "body">Sign Into Your Account,</a> and make your changes there. <br><br>
<center><a href = "/members/" class = "regsubmit2">Sign Into Your Account </a></center>
</td></tr></table>
<% 
else %>
<big><b>Please select from the list below any association(s) that you belong to:</b></big><br />
<% if Membership = "freetrial" then %>

<% else %>
<% if showdonation = True then %>

Note: We will donate 15% of your membership payment to your favorite livestock association. You will be able to select your favorite association on the next page.<br />
<% end if %>
<% end if %>

<% end if


'response.write("ExistingAccount=" & ExistingAccount & "<br>")
'response.write("Update=" & Update & "<br>")
'response.write("PeopleID=" & PeopleID & "<br>")

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

'response.Write("Update=" & Update )

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
'response.Write("Query=" & Query )
Conn.close
set Conn = nothing %>
<!--#Include virtual="Conn.asp"-->
<%

end if 
daynow= day(now)
monthnow = month(now)
yearnow = year(now)
datenow = monthnow & "/" & daynow & "/" & yearnow
if membership = "freetrial" then
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

		Query =  "INSERT INTO People (AddressID, ActivationCode, CustCountry, Custstate, ReferringPeopleID, WebsitesID, Accesslevel, custAIStartService, custAIEndService, custFooterStartDate, SubscriptionLevel, MaxAnimals, maxHerdsires, MaxProducts,  FreeMassEmailsPaidFor, FreeMassEmailsUsed, HomepageadsPaidfor, HomepageadsUsed, HeaderadsPaidfor, HeaderadsUsed, FreeAnimalEntryPaidFor, FreeAnimalEntryUsed, AISubscription, AESubscription, Owners, BusinessID,  PeopleFirstName, PeopleLastName, PeoplePhone, Peopleemail, Peoplefax, PeopleCell, PeopleActive,  PeoplePassword , PeopleCreationDate )" 
		Query =  Query & " Values (" &  AddressID & ","
         Query =  Query & " '" &   ActivationCode & "', " 
 Query =  Query & " '" &   AddressCountry & "', " 
 Query =  Query & " '" &   AddressState & "', " 

	
     if len(ReferringPeopleID) > 0 and not(ReferringPeopleID="notselected") then
      Query =  Query & " " &   ReferringPeopleID & ", " 
     else
        Query =  Query & "0 , " 
      end if	
		Query =  Query & " " &   WebsitesID & ", " 
		Query =  Query & " -1 , " 


if Membership = "student" then
Query =  Query & " ' " & cstr(FormatDateTime(datenow,2)) & " ', " 'custAIStartService
Query =  Query & " ' " & cstr(dateadd("yyyy", 1, FormatDateTime(datenow,2))) & " ', " 'custAIEndService
Query =  Query & " ' " & cstr(FormatDateTime(datenow,2)) & " ', " 'custAIStartService
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
Query =  Query & " ' " & cstr(dateadd("yyyy", 1, FormatDateTime(datenow,2))) & " ', " 'custAIEndService
Query =  Query & " ' " & cstr(FormatDateTime(datenow,2)) & " ', " 'custAIStartService
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
     Query =  Query & " ' " & cstr(dateadd("yyyy", 1, FormatDateTime(datenow,2))) & " ', " 'custAIEndService
     Query =  Query & " ' " & cstr(FormatDateTime(datenow,2)) & " ', " 'custAIStartService
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
     Query =  Query & " ' " & cstr(dateadd("yyyy", 1, FormatDateTime(datenow,2))) & " ', " 'custAIEndService
     Query =  Query & " ' " & cstr(FormatDateTime(datenow,2)) & " ', " 'custAIStartService
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
     Query =  Query & " ' " & cstr(dateadd("yyyy", 1, FormatDateTime(datenow,2))) & " ', " 'custAIEndService
     Query =  Query & " ' " & cstr(FormatDateTime(datenow,2)) & " ', " 'custAIStartService
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
		
	if trim(lcase(Membership)) = "freetrial" or trim(lcase(Membership)) = "FreeTrial" or len(Membership) = 0 then
     Query =  Query & " ' " & cstr(FormatDateTime(datenow,2)) & " ', " 'custAIStartService
     Query =  Query & " ' " & cstr(dateadd("yyyy", 1, FormatDateTime(datenow,2))) & " ', " 'custAIEndService
     Query =  Query & " ' " & cstr(FormatDateTime(datenow,2)) & " ', " 'custAIStartService
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
     Query =  Query & " ' " & cstr(dateadd("yyyy", 1, FormatDateTime(datenow,2))) & " ', " 'custAIEndService
     Query =  Query & " ' " & cstr(FormatDateTime(datenow,2)) & " ', " 'custAIStartService
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
     Query =  Query & " ' " & cstr(dateadd("yyyy", 1, FormatDateTime(datenow,2))) & " ', " 'custAIEndService
     Query =  Query & " ' " & cstr(FormatDateTime(datenow,2)) & " ', " 'custAIStartService
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

if lcase(trim(Membership)) = "vendor"  then
    Query =  Query & " ' " & cstr(FormatDateTime(datenow,2)) & " ', " 'custAIStartService
    Query =  Query & " ' " & cstr(dateadd("yyyy", 1, FormatDateTime(datenow,2))) & " ', " 'custAIEndService
    Query =  Query & " ' " & cstr(FormatDateTime(datenow,2)) & " ', " 'custAIStartService
	Query =  Query & " 5 , " 'SubscriptionLevel
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

if lcase(trim(Membership)) = "premium" or Membership = "premiummonth" then
    Query =  Query & " ' " & cstr(FormatDateTime(datenow,2)) & " ', " 'custAIStartService
    Query =  Query & " ' " & cstr(dateadd("yyyy", 1, FormatDateTime(datenow,2))) & " ', " 'custAIEndService
    Query =  Query & " ' " & cstr(FormatDateTime(datenow,2)) & " ', " 'custAIStartService
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

if trim(lcase(Membership)) = "complete"  then
    Query =  Query & " ' " & cstr(FormatDateTime(datenow,2)) & " ', " 'custAIStartService
    Query =  Query & " ' " & cstr(dateadd("yyyy", 1, FormatDateTime(datenow,2))) & " ', " 'custAIEndService
    Query =  Query & " ' " & cstr(FormatDateTime(datenow,2)) & " ', " 'custAIStartService
	Query =  Query & " 8 , " 'SubscriptionLevel
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
		Query =  Query & " 1, " 
           Query =  Query & " '" &  LeftShoe & "', " 
		Query =  Query & " GETDATE() ) "
'response.Write("Query = " & Query)
else
	Query =  " UPDATE People Set AddressID = " &  AddressID & ", " 
	Query =  Query & " WebsitesID = " &  WebsitesID & "," 
Query =  Query & " custcountry = '" &  addresscountry & "', " 
Query =  Query & " custstate = '" &  addressstate & "', " 

	Query =  Query & " AISubscription  = 1 ," 
	Query =  Query & " AESubscription  = 1 ,"
	      if len(ReferringPeopleID) > 0 and not(ReferringPeopleID="notselected") then
          	Query =  Query & " ReferringPeopleID  = " &   ReferringPeopleID & ", " 
     else
     	Query =  Query & " ReferringPeopleID  = 0 , " 
      end if	
      
	if Membership = "copper" then
     Query =  Query & " custAIStartService = ' " & cstr(FormatDateTime(datenow,2)) & " ', " 'custAIStartService
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

if trim(lcase(Membership)) = "freetrial" then
     Query =  Query & " custAIStartService = ' " & cstr(FormatDateTime(datenow,2)) & " ', " 'custAIStartService
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
	Query =  Query & " SubscriptionLevel  = 5 ," 
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



   if Membership = "platinum" or Membership = "premiummonth" or Membership = "premium" then
     Query =  Query & " custAIStartService = ' " & cstr(FormatDateTime(datenow,2)) & " ', " 'custAIStartService
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
   

if lcase(trim(Membership)) = "complete" then
    Query =  Query & " custAIStartService = ' " & cstr(FormatDateTime(datenow,2)) & " ', " 'custAIStartService
	Query =  Query & " SubscriptionLevel  = 8 ," 
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
'response.Write("Membership2=" & Membership & "<br>")	
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
%>



<% end if %>
<% end if %>


<% if lcase(trim(addresscountry)) = "united states" then 

Query =  "INSERT INTO peoplewebsitesubscribe (PeopleID, SubscribedWebsite)" 
Query =  Query & " Values (" & PeopleID & ", 'Livestock Of America')"

Conn.Execute(Query) 
end if

if lcase(trim(addresscountry)) = "canada" then 

Query =  "INSERT INTO peoplewebsitesubscribe (PeopleID, SubscribedWebsite)" 
Query =  Query & " Values (" & PeopleID & ", 'Livestock Of Canada')"

Conn.Execute(Query) 
end if

%>


<form  name=form method="post" action="SetupAccountStepAssociations2.asp?PeopleID=<%=PeopleID %>">
<table width = 100% border = 0 cellpadding = 0 cellspacing = 0>


<% '**************************************************************************************************
   ' ALPACA ASSOCIATIONS 
   '**************************************************************************************************%>
 
<% if screenwidth > 1000 then %>
<tr><td class = body colspan = 6 ><br /><h3><img src ="https://www.livestockoftheworld.com/icons/alpacaicongrey.png" width = 25 />Associations & Clubs</h3></td></tr>
<tr><td bgcolor = black height = 1 colspan = 6></td></tr>
<% end if%>
<% if screenwidth > 640 and screenwidth < 1001 then %>
<tr><td class = body colspan = 4 ><br /><h3><img src ="https://www.livestockoftheworld.com/icons/alpacaicongrey.png" width = 25 />Alpaca Associations & Clubs</h3></td></tr>
<tr><td bgcolor = black height = 1 colspan = 4></td></tr>
<% end if %>
<% if screenwidth < 641 then %>
<tr><td class = body colspan = 2 ><br /><h3><img src ="https://www.livestockoftheworld.com/icons/alpacaicongrey.png" width = 25 />Alpaca Associations & Clubs</h3></td></tr>
<tr><td bgcolor = black height = 1 colspan = 2></td></tr>
<% end if %>



<%
 Query =  "Select distinct Associations.* from Associations where speciesID = 2 ORDER BY AssociationName" 
rs.Open Query, conn, 3, 3
colnum = 1
while not rs.eof %>


<% if cint(screenwidth) > 1000 then 
 if colnum = 1 then %>
<tr>
<% end if %>
<% end if %>

<% if screenwidth > 640 and screenwidth < 1001 then 
 if colnum = 1 then %>
<tr>
<% end if %>
<% end if %>


<% if screenwidth < 641 then %>
<tr>
<%end if %>


<td class = body width = 10><input id="Checkbox2" type="checkbox" name = "associations" value = "<%=rs("AssociationID") %>"></td>
<td class = "body"><%=rs("AssociationName") %> </td>

<% if cint(screenwidth) > 1000 then
 if colnum = 1 or colnum = 2 then 
  colnum = colnum + 1 %>
<% else
colnum = 1 %>
</tr>
<% end if %>
<% end if %>

<% if screenwidth > 640 and screenwidth < 1001 then
 if colnum = 1 then 
  colnum = 2%>
<% else
colnum = 1 %>
</tr>
<% end if %>
<% end if %>

<% if screenwidth < 641 then %>
</tr>
<%end if %>

<% rs.movenext 
wend
rs.close
%>


<% '**************************************************************************************************
   ' BISON ASSOCIATIONS 
   '**************************************************************************************************%>
 
<% if screenwidth > 1000 then %>
<tr><td class = body colspan = 6 ><br /><h3><img src ="https://www.livestockoftheworld.com/icons/buffaloicongrey.png" width = 25 />Bison Associations & Clubs</h3></td></tr>
<tr><td bgcolor = black height = 1 colspan = 6></td></tr>
<% end if%>
<% if screenwidth > 640 and screenwidth < 1001 then %>
<tr><td class = body colspan = 4 ><br /><h3><img src ="https://www.livestockoftheworld.com/icons/buffaloicongrey.png" width = 25 />Bison Associations & Clubs</h3></td></tr>
<tr><td bgcolor = black height = 1 colspan = 4></td></tr>
<% end if %>
<% if screenwidth < 641 then %>
<tr><td class = body colspan = 2 ><br /><h3><img src ="https://www.livestockoftheworld.com/icons/buffaloicongrey.png" width = 25 />Bison Associations & Clubs</h3></td></tr>
<tr><td bgcolor = black height = 1 colspan = 2></td></tr>
<% end if %>



<%
 Query =  "Select distinct Associations.* from Associations where speciesID = 9 ORDER BY AssociationName" 
rs.Open Query, conn, 3, 3
colnum = 1
while not rs.eof %>


<% if cint(screenwidth) > 1000 then 
 if colnum = 1 then %>
<tr>
<% end if %>
<% end if %>

<% if screenwidth > 640 and screenwidth < 1001 then 
 if colnum = 1 then %>
<tr>
<% end if %>
<% end if %>


<% if screenwidth < 641 then %>
<tr>
<%end if %>


<td class = body width = 10><input id="Checkbox1" type="checkbox" name = "associations" value = "<%=rs("AssociationID") %>"></td>
<td class = "body"><%=rs("AssociationName") %> </td>

<% if cint(screenwidth) > 1000 then
 if colnum = 1 or colnum = 2 then 
  colnum = colnum + 1 %>
<% else
colnum = 1 %>
</tr>
<% end if %>
<% end if %>

<% if screenwidth > 640 and screenwidth < 1001 then
 if colnum = 1 then 
  colnum = 2%>
<% else
colnum = 1 %>
</tr>
<% end if %>
<% end if %>

<% if screenwidth < 641 then %>
</tr>
<%end if %>

<% rs.movenext 
wend
rs.close
%>



<% '**************************************************************************************************
   ' CATTLE ASSOCIATIONS 
   '**************************************************************************************************%>
 
<% if screenwidth > 1000 then %>
<tr><td class = body colspan = 6 ><br /><h3><img src ="https://www.livestockoftheworld.com/icons/cattleicongrey.png" width = 25 />Cattle Associations & Clubs</h3></td></tr>
<tr><td bgcolor = black height = 1 colspan = 6></td></tr>
<% end if%>
<% if screenwidth > 640 and screenwidth < 1001 then %>
<tr><td class = body colspan = 4 ><br /><h3><img src ="https://www.livestockoftheworld.com/icons/cattleicongrey.png" width = 25 />Cattle Associations & Clubs</h3></td></tr>
<tr><td bgcolor = black height = 1 colspan = 4></td></tr>
<% end if %>
<% if screenwidth < 641 then %>
<tr><td class = body colspan = 2 ><br /><h3><img src ="https://www.livestockoftheworld.com/icons/cattleicongrey.png" width = 25 />Cattle Associations & Clubs</h3></td></tr>
<tr><td bgcolor = black height = 1 colspan = 2></td></tr>
<% end if %>



<%
 Query =  "Select distinct Associations.* from Associations where speciesID = 8 ORDER BY AssociationName" 
rs.Open Query, conn, 3, 3
colnum = 1
while not rs.eof %>


<% if cint(screenwidth) > 1000 then 
 if colnum = 1 then %>
<tr>
<% end if %>
<% end if %>

<% if screenwidth > 640 and screenwidth < 1001 then 
 if colnum = 1 then %>
<tr>
<% end if %>
<% end if %>


<% if screenwidth < 641 then %>
<tr>
<%end if %>


<td class = body width = 10><input id="Checkbox3" type="checkbox" name = "associations" value = "<%=rs("AssociationID") %>"></td>
<td class = "body"><%=rs("AssociationName") %> </td>

<% if cint(screenwidth) > 1000 then
 if colnum = 1 or colnum = 2 then 
  colnum = colnum + 1 %>
<% else
colnum = 1 %>
</tr>
<% end if %>
<% end if %>

<% if screenwidth > 640 and screenwidth < 1001 then
 if colnum = 1 then 
  colnum = 2%>
<% else
colnum = 1 %>
</tr>
<% end if %>
<% end if %>

<% if screenwidth < 641 then %>
</tr>
<%end if %>

<% rs.movenext 
wend
rs.close
%>



<% '**************************************************************************************************
   ' CHICKEN ASSOCIATIONS 
   '**************************************************************************************************%>
 
<% if screenwidth > 1000 then %>
<tr><td class = body colspan = 6 ><br /><h3><img src ="https://www.livestockoftheworld.com/icons/chickenicongrey.png" width = 25 />Chicken Associations & Clubs</h3></td></tr>
<tr><td bgcolor = black height = 1 colspan = 6></td></tr>
<% end if%>
<% if screenwidth > 640 and screenwidth < 1001 then %>
<tr><td class = body colspan = 4 ><br /><h3><img src ="https://www.livestockoftheworld.com/icons/chickenicongrey.png" width = 25 />Chicken Associations & Clubs</h3></td></tr>
<tr><td bgcolor = black height = 1 colspan = 4></td></tr>
<% end if %>
<% if screenwidth < 641 then %>
<tr><td class = body colspan = 2 ><br /><h3><img src ="https://www.livestockoftheworld.com/icons/chickenicongrey.png" width = 25 />Chicken Associations & Clubs</h3></td></tr>
<tr><td bgcolor = black height = 1 colspan = 2></td></tr>
<% end if %>



<%
 Query =  "Select distinct Associations.* from Associations where speciesID = 13 ORDER BY AssociationName" 
rs.Open Query, conn, 3, 3
colnum = 1
while not rs.eof %>


<% if cint(screenwidth) > 1000 then 
 if colnum = 1 then %>
<tr>
<% end if %>
<% end if %>

<% if screenwidth > 640 and screenwidth < 1001 then 
 if colnum = 1 then %>
<tr>
<% end if %>
<% end if %>


<% if screenwidth < 641 then %>
<tr>
<%end if %>


<td class = body width = 10><input id="Checkbox4" type="checkbox" name = "associations" value = "<%=rs("AssociationID") %>"></td>
<td class = "body"><%=rs("AssociationName") %> </td>

<% if cint(screenwidth) > 1000 then
 if colnum = 1 or colnum = 2 then 
  colnum = colnum + 1 %>
<% else
colnum = 1 %>
</tr>
<% end if %>
<% end if %>

<% if screenwidth > 640 and screenwidth < 1001 then
 if colnum = 1 then 
  colnum = 2%>
<% else
colnum = 1 %>
</tr>
<% end if %>
<% end if %>

<% if screenwidth < 641 then %>
</tr>
<%end if %>

<% rs.movenext 
wend
rs.close
%>




<% '**************************************************************************************************
   ' DOG ASSOCIATIONS 
   '**************************************************************************************************%>
 
<% if screenwidth > 1000 then %>
<tr><td class = body colspan = 6 ><br /><h3><img src ="https://www.livestockoftheworld.com/icons/dogsicongrey.png" width = 25 />Dog Associations & Clubs</h3></td></tr>
<tr><td bgcolor = black height = 1 colspan = 6></td></tr>
<% end if%>
<% if screenwidth > 640 and screenwidth < 1001 then %>
<tr><td class = body colspan = 4 ><br /><h3><img src ="https://www.livestockoftheworld.com/icons/dogsicongrey.png" width = 25 />Dog Associations & Clubs</h3></td></tr>
<tr><td bgcolor = black height = 1 colspan = 4></td></tr>
<% end if %>
<% if screenwidth < 641 then %>
<tr><td class = body colspan = 2 ><br /><h3><img src ="https://www.livestockoftheworld.com/icons/dogsicongrey.png" width = 25 />Dog Associations & Clubs</h3></td></tr>
<tr><td bgcolor = black height = 1 colspan = 2></td></tr>
<% end if %>



<%
 Query =  "Select distinct Associations.* from Associations where speciesID = 3 ORDER BY AssociationName" 
rs.Open Query, conn, 3, 3
colnum = 1
while not rs.eof %>


<% if cint(screenwidth) > 1000 then 
 if colnum = 1 then %>
<tr>
<% end if %>
<% end if %>

<% if screenwidth > 640 and screenwidth < 1001 then 
 if colnum = 1 then %>
<tr>
<% end if %>
<% end if %>


<% if screenwidth < 641 then %>
<tr>
<%end if %>


<td class = body width = 10><input id="Checkbox5" type="checkbox" name = "associations" value = "<%=rs("AssociationID") %>"></td>
<td class = "body"><%=rs("AssociationName") %> </td>

<% if cint(screenwidth) > 1000 then
 if colnum = 1 or colnum = 2 then 
  colnum = colnum + 1 %>
<% else
colnum = 1 %>
</tr>
<% end if %>
<% end if %>

<% if screenwidth > 640 and screenwidth < 1001 then
 if colnum = 1 then 
  colnum = 2%>
<% else
colnum = 1 %>
</tr>
<% end if %>
<% end if %>

<% if screenwidth < 641 then %>
</tr>
<%end if %>

<% rs.movenext 
wend
rs.close
%>



<% '**************************************************************************************************
   ' DONKEY ASSOCIATIONS 
   '**************************************************************************************************%>
 
<% if screenwidth > 1000 then %>
<tr><td class = body colspan = 6 ><br /><h3><img src ="https://www.livestockoftheworld.com/icons/donkeyicongrey.png" width = 25 />Donkey Associations & Clubs</h3></td></tr>
<tr><td bgcolor = black height = 1 colspan = 6></td></tr>
<% end if%>
<% if screenwidth > 640 and screenwidth < 1001 then %>
<tr><td class = body colspan = 4 ><br /><h3><img src ="https://www.livestockoftheworld.com/icons/donkeyicongrey.png" width = 25 />Donkey Associations & Clubs</h3></td></tr>
<tr><td bgcolor = black height = 1 colspan = 4></td></tr>
<% end if %>
<% if screenwidth < 641 then %>
<tr><td class = body colspan = 2 ><br /><h3><img src ="https://www.livestockoftheworld.com/icons/donkeyicongrey.png" width = 25 />Donkey Associations & Clubs</h3></td></tr>
<tr><td bgcolor = black height = 1 colspan = 2></td></tr>
<% end if %>



<%
 Query =  "Select distinct Associations.* from Associations where speciesID = 7 ORDER BY AssociationName" 
rs.Open Query, conn, 3, 3
colnum = 1
while not rs.eof %>


<% if cint(screenwidth) > 1000 then 
 if colnum = 1 then %>
<tr>
<% end if %>
<% end if %>

<% if screenwidth > 640 and screenwidth < 1001 then 
 if colnum = 1 then %>
<tr>
<% end if %>
<% end if %>


<% if screenwidth < 641 then %>
<tr>
<%end if %>


<td class = body width = 10><input id="Checkbox6" type="checkbox" name = "associations" value = "<%=rs("AssociationID") %>"></td>
<td class = "body"><%=rs("AssociationName") %> </td>

<% if cint(screenwidth) > 1000 then
 if colnum = 1 or colnum = 2 then 
  colnum = colnum + 1 %>
<% else
colnum = 1 %>
</tr>
<% end if %>
<% end if %>

<% if screenwidth > 640 and screenwidth < 1001 then
 if colnum = 1 then 
  colnum = 2%>
<% else
colnum = 1 %>
</tr>
<% end if %>
<% end if %>

<% if screenwidth < 641 then %>
</tr>
<%end if %>

<% rs.movenext 
wend
rs.close
%>



<% '**************************************************************************************************
   ' EMUS ASSOCIATIONS 
   '**************************************************************************************************%>
 
<% if screenwidth > 1000 then %>
<tr><td class = body colspan = 6 ><br /><h3><img src ="https://www.livestockoftheworld.com/icons/emuicongrey.jpg" width = 25 />Emu Associations & Clubs</h3></td></tr>
<tr><td bgcolor = black height = 1 colspan = 6></td></tr>
<% end if%>
<% if screenwidth > 640 and screenwidth < 1001 then %>
<tr><td class = body colspan = 4 ><br /><h3><img src ="https://www.livestockoftheworld.com/icons/emuicongrey.jpg" width = 25 />Emu Associations & Clubs</h3></td></tr>
<tr><td bgcolor = black height = 1 colspan = 4></td></tr>
<% end if %>
<% if screenwidth < 641 then %>
<tr><td class = body colspan = 2 ><br /><h3><img src ="https://www.livestockoftheworld.com/icons/emuicongrey.jpg" width = 25 />Emu Associations & Clubs</h3></td></tr>
<tr><td bgcolor = black height = 1 colspan = 2></td></tr>
<% end if %>



<%
 Query =  "Select distinct Associations.* from Associations where speciesID = 19 ORDER BY AssociationName" 
rs.Open Query, conn, 3, 3
colnum = 1
while not rs.eof %>


<% if cint(screenwidth) > 1000 then 
 if colnum = 1 then %>
<tr>
<% end if %>
<% end if %>

<% if screenwidth > 640 and screenwidth < 1001 then 
 if colnum = 1 then %>
<tr>
<% end if %>
<% end if %>


<% if screenwidth < 641 then %>
<tr>
<%end if %>


<td class = body width = 10><input id="Checkbox7" type="checkbox" name = "associations" value = "<%=rs("AssociationID") %>"></td>
<td class = "body"><%=rs("AssociationName") %> </td>

<% if cint(screenwidth) > 1000 then
 if colnum = 1 or colnum = 2 then 
  colnum = colnum + 1 %>
<% else
colnum = 1 %>
</tr>
<% end if %>
<% end if %>

<% if screenwidth > 640 and screenwidth < 1001 then
 if colnum = 1 then 
  colnum = 2%>
<% else
colnum = 1 %>
</tr>
<% end if %>
<% end if %>

<% if screenwidth < 641 then %>
</tr>
<%end if %>

<% rs.movenext 
wend
rs.close
%>



<% '**************************************************************************************************
   ' GOAT ASSOCIATIONS 
   '**************************************************************************************************%>
 
<% if screenwidth > 1000 then %>
<tr><td class = body colspan = 6 ><br /><h3><img src ="https://www.livestockoftheworld.com/icons/goaticongrey.png" width = 25 />Goat Associations & Clubs</h3></td></tr>
<tr><td bgcolor = black height = 1 colspan = 6></td></tr>
<% end if%>
<% if screenwidth > 640 and screenwidth < 1001 then %>
<tr><td class = body colspan = 4 ><br /><h3><img src ="https://www.livestockoftheworld.com/icons/goaticongrey.png" width = 25 />Goat Associations & Clubs</h3></td></tr>
<tr><td bgcolor = black height = 1 colspan = 4></td></tr>
<% end if %>
<% if screenwidth < 641 then %>
<tr><td class = body colspan = 2 ><br /><h3><img src ="https://www.livestockoftheworld.com/icons/goaticongrey.png" width = 25 />Goat Associations & Clubs</h3></td></tr>
<tr><td bgcolor = black height = 1 colspan = 2></td></tr>
<% end if %>



<%
 Query =  "Select distinct Associations.* from Associations where speciesID = 6 ORDER BY AssociationName" 
rs.Open Query, conn, 3, 3
colnum = 1
while not rs.eof %>


<% if cint(screenwidth) > 1000 then 
 if colnum = 1 then %>
<tr>
<% end if %>
<% end if %>

<% if screenwidth > 640 and screenwidth < 1001 then 
 if colnum = 1 then %>
<tr>
<% end if %>
<% end if %>


<% if screenwidth < 641 then %>
<tr>
<%end if %>


<td class = body width = 10><input id="Checkbox8" type="checkbox" name = "associations" value = "<%=rs("AssociationID") %>"></td>
<td class = "body"><%=rs("AssociationName") %> </td>

<% if cint(screenwidth) > 1000 then
 if colnum = 1 or colnum = 2 then 
  colnum = colnum + 1 %>
<% else
colnum = 1 %>
</tr>
<% end if %>
<% end if %>

<% if screenwidth > 640 and screenwidth < 1001 then
 if colnum = 1 then 
  colnum = 2%>
<% else
colnum = 1 %>
</tr>
<% end if %>
<% end if %>

<% if screenwidth < 641 then %>
</tr>
<%end if %>

<% rs.movenext 
wend
rs.close
%>





<% '**************************************************************************************************
   ' HORSE ASSOCIATIONS 
   '**************************************************************************************************%>
 
<% if screenwidth > 1000 then %>
<tr><td class = body colspan = 6 ><br /><h3><img src ="https://www.livestockoftheworld.com/icons/horseicongrey.png" width = 25 />Horse Associations & Clubs</h3></td></tr>
<tr><td bgcolor = black height = 1 colspan = 6></td></tr>
<% end if%>
<% if screenwidth > 640 and screenwidth < 1001 then %>
<tr><td class = body colspan = 4 ><br /><h3><img src ="https://www.livestockoftheworld.com/icons/horseicongrey.png" width = 25 />Horse Associations & Clubs</h3></td></tr>
<tr><td bgcolor = black height = 1 colspan = 4></td></tr>
<% end if %>
<% if screenwidth < 641 then %>
<tr><td class = body colspan = 2 ><br /><h3><img src ="https://www.livestockoftheworld.com/icons/horseicongrey.png" width = 25 />Horse Associations & Clubs</h3></td></tr>
<tr><td bgcolor = black height = 1 colspan = 2></td></tr>
<% end if %>



<%
 Query =  "Select distinct Associations.* from Associations where speciesID = 5 ORDER BY AssociationName" 
rs.Open Query, conn, 3, 3
colnum = 1
while not rs.eof %>


<% if cint(screenwidth) > 1000 then 
 if colnum = 1 then %>
<tr>
<% end if %>
<% end if %>

<% if screenwidth > 640 and screenwidth < 1001 then 
 if colnum = 1 then %>
<tr>
<% end if %>
<% end if %>


<% if screenwidth < 641 then %>
<tr>
<%end if %>


<td class = body width = 10><input id="Checkbox9" type="checkbox" name = "associations" value = "<%=rs("AssociationID") %>"></td>
<td class = "body"><%=rs("AssociationName") %> </td>

<% if cint(screenwidth) > 1000 then
 if colnum = 1 or colnum = 2 then 
  colnum = colnum + 1 %>
<% else
colnum = 1 %>
</tr>
<% end if %>
<% end if %>

<% if screenwidth > 640 and screenwidth < 1001 then
 if colnum = 1 then 
  colnum = 2%>
<% else
colnum = 1 %>
</tr>
<% end if %>
<% end if %>

<% if screenwidth < 641 then %>
</tr>
<%end if %>

<% rs.movenext 
wend
rs.close
%>


<% '**************************************************************************************************
   ' LLAMA ASSOCIATIONS 
   '**************************************************************************************************%>
 
<% if screenwidth > 1000 then %>
<tr><td class = body colspan = 6 ><br /><h3><img src ="https://www.livestockoftheworld.com/icons/llamaicongrey.png" width = 25 />Llama Associations & Clubs</h3></td></tr>
<tr><td bgcolor = black height = 1 colspan = 6></td></tr>
<% end if%>
<% if screenwidth > 640 and screenwidth < 1001 then %>
<tr><td class = body colspan = 4 ><br /><h3><img src ="https://www.livestockoftheworld.com/icons/llamaicongrey.png" width = 25 />Llama Associations & Clubs</h3></td></tr>
<tr><td bgcolor = black height = 1 colspan = 4></td></tr>
<% end if %>
<% if screenwidth < 641 then %>
<tr><td class = body colspan = 2 ><br /><h3><img src ="https://www.livestockoftheworld.com/icons/llamaicongrey.png" width = 25 />Llama Associations & Clubs</h3></td></tr>
<tr><td bgcolor = black height = 1 colspan = 2></td></tr>
<% end if %>



<%
 Query =  "Select distinct Associations.* from Associations where speciesID = 4 ORDER BY AssociationName" 
rs.Open Query, conn, 3, 3
colnum = 1
while not rs.eof %>


<% if cint(screenwidth) > 1000 then 
 if colnum = 1 then %>
<tr>
<% end if %>
<% end if %>

<% if screenwidth > 640 and screenwidth < 1001 then 
 if colnum = 1 then %>
<tr>
<% end if %>
<% end if %>


<% if screenwidth < 641 then %>
<tr>
<%end if %>


<td class = body width = 10><input id="Checkbox10" type="checkbox" name = "associations" value = "<%=rs("AssociationID") %>"></td>
<td class = "body"><%=rs("AssociationName") %> </td>

<% if cint(screenwidth) > 1000 then
 if colnum = 1 or colnum = 2 then 
  colnum = colnum + 1 %>
<% else
colnum = 1 %>
</tr>
<% end if %>
<% end if %>

<% if screenwidth > 640 and screenwidth < 1001 then
 if colnum = 1 then 
  colnum = 2%>
<% else
colnum = 1 %>
</tr>
<% end if %>
<% end if %>

<% if screenwidth < 641 then %>
</tr>
<%end if %>

<% rs.movenext 
wend
rs.close
%>




<% '**************************************************************************************************
   ' PIG ASSOCIATIONS 
   '**************************************************************************************************%>
 
<% if screenwidth > 1000 then %>
<tr><td class = body colspan = 6 ><br /><h3><img src ="https://www.livestockoftheworld.com/icons/PigsIconGrey.png" width = 25 />Pig Associations & Clubs</h3></td></tr>
<tr><td bgcolor = black height = 1 colspan = 6></td></tr>
<% end if%>
<% if screenwidth > 640 and screenwidth < 1001 then %>
<tr><td class = body colspan = 4 ><br /><h3><img src ="https://www.livestockoftheworld.com/icons/PigsIconGrey.png" width = 25 />Pig Associations & Clubs</h3></td></tr>
<tr><td bgcolor = black height = 1 colspan = 4></td></tr>
<% end if %>
<% if screenwidth < 641 then %>
<tr><td class = body colspan = 2 ><br /><h3><img src ="https://www.livestockoftheworld.com/icons/PigsIconGrey.png" width = 25 />Pig Associations & Clubs</h3></td></tr>
<tr><td bgcolor = black height = 1 colspan = 2></td></tr>
<% end if %>



<%
 Query =  "Select distinct Associations.* from Associations where speciesID = 12 ORDER BY AssociationName" 
rs.Open Query, conn, 3, 3
colnum = 1
while not rs.eof %>


<% if cint(screenwidth) > 1000 then 
 if colnum = 1 then %>
<tr>
<% end if %>
<% end if %>

<% if screenwidth > 640 and screenwidth < 1001 then 
 if colnum = 1 then %>
<tr>
<% end if %>
<% end if %>


<% if screenwidth < 641 then %>
<tr>
<%end if %>


<td class = body width = 10><input id="Checkbox11" type="checkbox" name = "associations" value = "<%=rs("AssociationID") %>"></td>
<td class = "body"><%=rs("AssociationName") %> </td>

<% if cint(screenwidth) > 1000 then
 if colnum = 1 or colnum = 2 then 
  colnum = colnum + 1 %>
<% else
colnum = 1 %>
</tr>
<% end if %>
<% end if %>

<% if screenwidth > 640 and screenwidth < 1001 then
 if colnum = 1 then 
  colnum = 2%>
<% else
colnum = 1 %>
</tr>
<% end if %>
<% end if %>

<% if screenwidth < 641 then %>
</tr>
<%end if %>

<% rs.movenext 
wend
rs.close
%>



<% '**************************************************************************************************
   ' Rabbit ASSOCIATIONS 
   '**************************************************************************************************%>
 
<% if screenwidth > 1000 then %>
<tr><td class = body colspan = 6 ><br /><h3><img src ="https://www.livestockoftheworld.com/icons/rabbiticongrey.png" width = 25 />Rabbit Associations & Clubs</h3></td></tr>
<tr><td bgcolor = black height = 1 colspan = 6></td></tr>
<% end if%>
<% if screenwidth > 640 and screenwidth < 1001 then %>
<tr><td class = body colspan = 4 ><br /><h3><img src ="https://www.livestockoftheworld.com/icons/rabbiticongrey.png" width = 25 />Rabbit Associations & Clubs</h3></td></tr>
<tr><td bgcolor = black height = 1 colspan = 4></td></tr>
<% end if %>
<% if screenwidth < 641 then %>
<tr><td class = body colspan = 2 ><br /><h3><img src ="https://www.livestockoftheworld.com/icons/rabbiticongrey.png" width = 25 />Rabbit Associations & Clubs</h3></td></tr>
<tr><td bgcolor = black height = 1 colspan = 2></td></tr>
<% end if %>



<%
 Query =  "Select distinct Associations.* from Associations where speciesID = 11 ORDER BY AssociationName" 
rs.Open Query, conn, 3, 3
colnum = 1
while not rs.eof %>


<% if cint(screenwidth) > 1000 then 
 if colnum = 1 then %>
<tr>
<% end if %>
<% end if %>

<% if screenwidth > 640 and screenwidth < 1001 then 
 if colnum = 1 then %>
<tr>
<% end if %>
<% end if %>


<% if screenwidth < 641 then %>
<tr>
<%end if %>


<td class = body width = 10><input id="Checkbox12" type="checkbox" name = "associations" value = "<%=rs("AssociationID") %>"></td>
<td class = "body"><%=rs("AssociationName") %> </td>

<% if cint(screenwidth) > 1000 then
 if colnum = 1 or colnum = 2 then 
  colnum = colnum + 1 %>
<% else
colnum = 1 %>
</tr>
<% end if %>
<% end if %>

<% if screenwidth > 640 and screenwidth < 1001 then
 if colnum = 1 then 
  colnum = 2%>
<% else
colnum = 1 %>
</tr>
<% end if %>
<% end if %>

<% if screenwidth < 641 then %>
</tr>
<%end if %>

<% rs.movenext 
wend
rs.close
%>






<% '**************************************************************************************************
   ' SHEEP ASSOCIATIONS 
   '**************************************************************************************************%>
 
<% if screenwidth > 1000 then %>
<tr><td class = body colspan = 6 ><br /><h3><img src ="https://www.livestockoftheworld.com/icons/sheepicongrey.png" width = 25 />Sheep Associations & Clubs</h3></td></tr>
<tr><td bgcolor = black height = 1 colspan = 6></td></tr>
<% end if%>
<% if screenwidth > 640 and screenwidth < 1001 then %>
<tr><td class = body colspan = 4 ><br /><h3><img src ="https://www.livestockoftheworld.com/icons/sheepicongrey.png" width = 25 />Sheep Associations & Clubs</h3></td></tr>
<tr><td bgcolor = black height = 1 colspan = 4></td></tr>
<% end if %>
<% if screenwidth < 641 then %>
<tr><td class = body colspan = 2 ><br /><h3><img src ="https://www.livestockoftheworld.com/icons/sheepicongrey.png" width = 25 />Sheep Associations & Clubs</h3></td></tr>
<tr><td bgcolor = black height = 1 colspan = 2></td></tr>
<% end if %>



<%
 Query =  "Select distinct Associations.* from Associations where speciesID = 10 ORDER BY AssociationName" 
rs.Open Query, conn, 3, 3
colnum = 1
while not rs.eof %>


<% if cint(screenwidth) > 1000 then 
 if colnum = 1 then %>
<tr>
<% end if %>
<% end if %>

<% if screenwidth > 640 and screenwidth < 1001 then 
 if colnum = 1 then %>
<tr>
<% end if %>
<% end if %>


<% if screenwidth < 641 then %>
<tr>
<%end if %>


<td class = body width = 10><input id="Checkbox13" type="checkbox" name = "associations" value = "<%=rs("AssociationID") %>"></td>
<td class = "body"><%=rs("AssociationName") %> </td>

<% if cint(screenwidth) > 1000 then
 if colnum = 1 or colnum = 2 then 
  colnum = colnum + 1 %>
<% else
colnum = 1 %>
</tr>
<% end if %>
<% end if %>

<% if screenwidth > 640 and screenwidth < 1001 then
 if colnum = 1 then 
  colnum = 2%>
<% else
colnum = 1 %>
</tr>
<% end if %>
<% end if %>

<% if screenwidth < 641 then %>
</tr>
<%end if %>

<% rs.movenext 
wend
rs.close
%>




<% '**************************************************************************************************
   ' Turkey ASSOCIATIONS 
   '**************************************************************************************************%>
 
<% if screenwidth > 1000 then %>
<tr><td class = body colspan = 6 ><br /><h3><img src ="https://www.livestockoftheworld.com/icons/turkeyicongrey.png" width = 25 />Turkey Associations & Clubs</h3></td></tr>
<tr><td bgcolor = black height = 1 colspan = 6></td></tr>
<% end if%>
<% if screenwidth > 640 and screenwidth < 1001 then %>
<tr><td class = body colspan = 4 ><br /><h3><img src ="https://www.livestockoftheworld.com/icons/turkeyicongrey.png" width = 25 />Turkey Associations & Clubs</h3></td></tr>
<tr><td bgcolor = black height = 1 colspan = 4></td></tr>
<% end if %>
<% if screenwidth < 641 then %>
<tr><td class = body colspan = 2 ><br /><h3><img src ="https://www.livestockoftheworld.com/icons/turkeyicongrey.png" width = 25 />Turkey Associations & Clubs</h3></td></tr>
<tr><td bgcolor = black height = 1 colspan = 2></td></tr>
<% end if %>



<%
 Query =  "Select distinct Associations.* from Associations where speciesID = 14 ORDER BY AssociationName" 
rs.Open Query, conn, 3, 3
colnum = 1
while not rs.eof %>


<% if cint(screenwidth) > 1000 then 
 if colnum = 1 then %>
<tr>
<% end if %>
<% end if %>

<% if screenwidth > 640 and screenwidth < 1001 then 
 if colnum = 1 then %>
<tr>
<% end if %>
<% end if %>


<% if screenwidth < 641 then %>
<tr>
<%end if %>


<td class = body width = 10><input id="Checkbox14" type="checkbox" name = "associations" value = "<%=rs("AssociationID") %>"></td>
<td class = "body"><%=rs("AssociationName") %> </td>

<% if cint(screenwidth) > 1000 then
 if colnum = 1 or colnum = 2 then 
  colnum = colnum + 1 %>
<% else
colnum = 1 %>
</tr>
<% end if %>
<% end if %>

<% if screenwidth > 640 and screenwidth < 1001 then
 if colnum = 1 then 
  colnum = 2%>
<% else
colnum = 1 %>
</tr>
<% end if %>
<% end if %>

<% if screenwidth < 641 then %>
</tr>
<%end if %>

<% rs.movenext 
wend
rs.close
%>





<% '**************************************************************************************************
   ' YAK ASSOCIATIONS 
   '**************************************************************************************************%>
 
<% if screenwidth > 1000 then %>
<tr><td class = body colspan = 6 ><br /><h3><img src ="https://www.livestockoftheworld.com/icons/yakicongrey.png" width = 25 />Yak Associations & Clubs</h3></td></tr>
<tr><td bgcolor = black height = 1 colspan = 6></td></tr>
<% end if%>
<% if screenwidth > 640 and screenwidth < 1001 then %>
<tr><td class = body colspan = 4 ><br /><h3><img src ="https://www.livestockoftheworld.com/icons/yakicongrey.png" width = 25 />Yak Associations & Clubs</h3></td></tr>
<tr><td bgcolor = black height = 1 colspan = 4></td></tr>
<% end if %>
<% if screenwidth < 641 then %>
<tr><td class = body colspan = 2 ><br /><h3><img src ="https://www.livestockoftheworld.com/icons/yakicongrey.png" width = 25 />Yak Associations & Clubs</h3></td></tr>
<tr><td bgcolor = black height = 1 colspan = 2></td></tr>
<% end if %>



<%
 Query =  "Select distinct Associations.* from Associations where speciesID = 14 ORDER BY AssociationName" 
rs.Open Query, conn, 3, 3
colnum = 1
while not rs.eof %>


<% if cint(screenwidth) > 1000 then 
 if colnum = 1 then %>
<tr>
<% end if %>
<% end if %>

<% if screenwidth > 640 and screenwidth < 1001 then 
 if colnum = 1 then %>
<tr>
<% end if %>
<% end if %>


<% if screenwidth < 641 then %>
<tr>
<%end if %>


<td class = body width = 10><input id="Checkbox15" type="checkbox" name = "associations" value = "<%=rs("AssociationID") %>"></td>
<td class = "body"><%=rs("AssociationName") %> </td>

<% if cint(screenwidth) > 1000 then
 if colnum = 1 or colnum = 2 then 
  colnum = colnum + 1 %>
<% else
colnum = 1 %>
</tr>
<% end if %>
<% end if %>

<% if screenwidth > 640 and screenwidth < 1001 then
 if colnum = 1 then 
  colnum = 2%>
<% else
colnum = 1 %>
</tr>
<% end if %>
<% end if %>

<% if screenwidth < 641 then %>
</tr>
<%end if %>

<% rs.movenext 
wend
rs.close
%>



</table>
<input  type="hidden" name = "activationcode" value = "<%=activationcode %>">
	<div align = right><input type=submit value="GO TO THE NEXT STEP ->"  class = "regsubmit2"></div>
    </form>
</td></tr></table>
  </td></tr></table>
<% 

Conn.close
set Conn = nothing
%>
<br /><br />If your favorite association is not listed on our website please email us a <a href="ContactUs@LivestockOfTheWorld.com" target = "_blank" class = "body">ContactUs@LivestockOfTheWorld.com</a> and let us know.<br /><br />

<!--#Include Virtual="/Footer.asp"-->
</Body>
</HTML>

