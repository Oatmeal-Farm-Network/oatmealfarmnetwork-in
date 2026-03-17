<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta http-equiv="Content-Language" content="en-us">
<%  PageName = "Registry" %>
<meta http-equiv="Content-Language" content="en-us">
<title>Create Association Account</title>
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

<!--#Include virtual="/includefiles/globalvariables.asp"-->
</head>
<BODY   >
<% Current = "Home" %>
<% CurrentWebsite = "LivestockofAmerica"
session("LoggedIn") = False %>
<!--#Include virtual="/includefiles/Header.asp"-->

<%
ExistingSite = False
Update = "False"
SpeciesID = Request.Form("SpeciesID")
PeoplePhone = Request.Form("PeoplePhone")
PeopleFirstName = Request.Form("PeopleFirstName")
PeopleLastName = Request.Form("PeopleLastName")
PeopleEmail = Request.Form("PeopleEmail")
MemberPosition = Request.Form("MemberPosition")
BusinessName = Request.Form("BusinessName")
AssociationContactPosition = Request.Form("AssociationContactPosition")
AssociationName = Request.Form("AssociationName")
Associationwebsite = Request.Form("Associationwebsite") 
AssociationEmailaddress = Request.Form("AssociationEmailaddress") 
AssociationAcronym = request.form("AssociationAcronym")
AddressStreet = Request.Form("AddressStreet") 
AddressApt = Request.Form("AddressApt") 
AddressCity  = Request.Form("AddressCity")
AddressState  = Request.Form("associationState")
AddressCountry  = Request.Form("associationCountry")
AddressZip  = Request.Form("AddressZip")
AssociationPhone  = Request.Form("AssociationPhone")
PeopleWebsite = request.form("PeopleWebsite")
AssociationStreet1 = request.form("AssociationStreet1")
AssociationStreet2 = request.form("AssociationStreet2")
AssociationCity = request.form("AssociationCity")
Associationcountry = request.form("Associationcountry")
AssociationState = request.form("AssociationState")
AssociationZip= request.form("AssociationZip")

Question = request.form("Question")
fieldX = request.form("fieldX")
Shoesize =request.form("Shoesize")
if not(fieldX = Mid(Question, 13, 1)) or len(trim(Shoesize)) > 0 or len(fieldX) < 1 then
'response.Write("Not Found")

variables ="&SpeciesID=" & SpeciesID & "&MemberFirstName=" & MemberFirstName & "&MemberLastName=" & MemberLastName & "&MemberEmail=" & MemberEmail & "&MemberPosition=" & MemberPosition & "&AssociationContactPosition=" & AssociationContactPosition & "&AssociationName=" & AssociationName & "&Associationwebsite=" & Associationwebsite & "&AssociationEmailaddress=" & AssociationEmailaddress & "&AddressStreet=" & AddressStreet & "&AddressApt=" & AddressApt & "&AddressCity=" & AddressCity & "&State=" & State & "&Country=" & Country & "&AddressZip=" & AddressZip & "&AssociationPhone=" & AssociationPhone & "&AssociationAcronym=" & AssociationAcronym
'conn.close
'set conn = nothing
'response.redirect("SetupAssociationAccount.asp?existing=True" & variables)
	Response.redirect("SetupAssociationAccount.asp?Message=Please Answer the Math Question Correctly." & variables )
end if 


str1 = MemberPosition
str2 = "'"
If InStr(str1,str2) > 0 Then
	MemberPosition= Replace(str1,  str2, "''")
End If 


str1 = AssociationEmailaddress
str2 = "'"
If InStr(str1,str2) > 0 Then
	AssociationEmailaddress= Replace(str1,  str2, "''")
End If 


str1 = AssociationAcronym
str2 = "'"
If InStr(str1,str2) > 0 Then
	AssociationAcronym = Replace(str1,  str2, "''")
End If 


str1 = AssociationName
str2 = "'"
If InStr(str1,str2) > 0 Then
	AssociationName = Replace(str1,  str2, "''")
End If 

str1 = MemberFirstName 
str2 = "'"
If InStr(str1,str2) > 0 Then
	MemberFirstName = Replace(str1,  str2, "''")
End If  

str1 = MemberLastName 
str2 = "'"
If InStr(str1,str2) > 0 Then
	MemberLastName = Replace(str1,  str2, "''")
End If  


str1 = AssociationContactPosition
str2 = "'"
If InStr(str1,str2) > 0 Then
	AssociationContactPosition= Replace(str1,  str2, "''")
End If  


str1 = PeopleWebsite
str2 = "'"
If InStr(str1,str2) > 0 Then
	PeopleWebsite= Replace(str1,  str2, "''")
End If  

str1 = lcase(Associationwebsite)
str2 = "https://"
If InStr(str1,str2) > 0 Then
	Associationwebsite= right(Associationwebsite, len(Associationwebsite) - 8)
End If  

str1 = lcase(Associationwebsite)
str2 = "http://"
If InStr(str1,str2) > 0 Then
	Associationwebsite= right(Associationwebsite, len(Associationwebsite) - 7)
End If  

str1 = Associationwebsite
str2 = "'"
If InStr(str1,str2) > 0 Then
	Associationwebsite= Replace(str1,  str2, "''")
End If  

 
str1 = AssociationStreet
str2 = "'"
If InStr(str1,str2) > 0 Then
	AssociationStreet= Replace(str1,  str2, "''")
End If  

str1 = AssociationApt 
str2 = "'"
If InStr(str1,str2) > 0 Then
	AssociationApt = Replace(str1,  str2, "''")
End If  

str1 = AssociationCity 
str2 = "'"
If InStr(str1,str2) > 0 Then
	AssociationCity = Replace(str1,  str2, "''")
End If  
 
str1 = Associationcountry
str2 = "'"
If InStr(str1,str2) > 0 Then
	Associationcountry= Replace(str1,  str2, "''")
End If  
 
str1 = AssociationState
str2 = "'"
If InStr(str1,str2) > 0 Then
	AssociationState= Replace(str1,  str2, "''")
End If  

str1 = AssociationZip
str2 = "'"
If InStr(str1,str2) > 0 Then
	AssociationZip= Replace(str1,  str2, "''")
End If  


str1 = MemberEmail
str2 = "'"
If InStr(str1,str2) > 0 Then
	MemberEmail= Replace(str1,  str2, "''")
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

str1 = AddressState 
str2 = "'"
If InStr(str1,str2) > 0 Then
	AddressState= Replace(str1,  str2, "''")
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

str1 = AssociationPhone
str2 = "'"
If InStr(str1,str2) > 0 Then
	AssociationPhone= Replace(str1,  str2, "''")
End If


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
if len(Coupon) > 0 then
Couponcode = request.form("Couponcode")

if lcase(trim(Couponcode)) = "black2015" then
discount = 50 ' percent

else
BadCoupon = True
end if

Coupon = True
else
if QuantityChange = "True" then
else
ExistingAccount = False
sql = "select * from People where (Peopleemail = '" & Peopleemail & "')"
response.write("sql=" & sql & "<br>")
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



ExistingAccount = False
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


response.write("ExistingSite=" & ExistingSite )

if (ExistingSite = False and Update = "False") or len(WebsitesID) < 1 then
Query =  "INSERT INTO Websites (Website)" 
Query =  Query & " Values ('" & PeopleWebsite & "')" 
response.write("Query=" & Query )


Conn.Execute(Query) 

else
Query =  " UPDATE Websites Set Website = '" &  PeopleWebsite & "' " 
Query =  Query & " where WebsitesID = " & WebsitesID & ";" 
Conn.Execute(Query) 


sql = "select WebsitesID from Websites where Website = '" & PeopleWebsite & "' order by WebsitesID Desc"
response.write(sql)
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

end if



if (ExistingSite = False and Update = "False") or len(BusinessID) < 1  then
		

else
	Query =  " UPDATE Business Set BusinessName = '" &  BusinessName & "' " 
	Query =  Query & " where BusinessID = " & BusinessID & ";" 
Conn.Execute(Query) 
end if 


'response.write("Website query = " & Query & "<br>")	


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


if ExistingSite = False and Update = "False" then
		Query =  "INSERT INTO Address (AddressStreet, AddressApt, AddressCity, AddressState, AddressCountry, AddressZip)" 
	    Query =  Query & " Values ('" & AddressStreet  & "'," 
	    Query =  Query & " '" &  AddressApt & "', " 
		Query =  Query & " '" &  AddressCity & "', " 
		Query =  Query & " '" &  AddressState & "', " 
        Query =  Query & " '" &  AddressCountry & "', " 
		Query =  Query & " '" &  AddressZip & "')" 

response.Write("Query=" & Query )
Conn.Execute(Query) 

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

end if 


daynow= day(now)
monthnow = month(now)
yearnow = year(now)
datenow = monthnow & "/" & daynow & "/" & yearnow
membership = "basic"


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
		Query =  "INSERT INTO People (AddressID, CustCountry, Custstate, ReferringPeopleID, WebsitesID, Accesslevel, custAIStartService, custAIEndService, custFooterStartDate, SubscriptionLevel, MaxAnimals, maxHerdsires, MaxProducts,  FreeMassEmailsPaidFor, FreeMassEmailsUsed, HomepageadsPaidfor, HomepageadsUsed, HeaderadsPaidfor, HeaderadsUsed, FreeAnimalEntryPaidFor, FreeAnimalEntryUsed, AISubscription, AESubscription, Owners, BusinessID,  PeopleFirstName, PeopleLastName, PeoplePhone, Peopleemail, Peoplefax, PeopleCell, PeopleActive,  PeopleCreationDate )" 
		Query =  Query & " Values (" &  AddressID & ","
 Query =  Query & " '" &   AddressCountry & "', " 
 Query =  Query & " '" &   AddressState & "', " 

	
     if len(ReferringPeopleID) > 0 and not(ReferringPeopleID="notselected") then
      Query =  Query & " " &   ReferringPeopleID & ", " 
     else
        Query =  Query & "0 , " 
      end if	
		Query =  Query & " " &   WebsitesID & ", " 
		Query =  Query & " 1 , " 


		

     Query =  Query & " ' " & datenow & " ', " 'custAIStartService
    Query =  Query &  " ' " & datenownext  & "' , " 'custAIEndService
     Query =  Query & " ' " & datenow & " ', " 'Receive Weekly Emails
		Query =  Query & " 3 , " 'SubscriptionLevel
		Query =  Query & " 0, "  'MaxAnimal
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
		Query =  Query & " '" &  Now & "') "
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
'response.Write("Query!=" & Query)	
if existing = false then
Conn.Execute(Query) 
end if
 %>

<% sql = "select * from People  where   (Peopleemail = '" & Peopleemail & "')"
'response.write("sql!!!!=" & sql & "<br>")
Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	If Not rs.eof Then
		ExistingAccount = True 
		PeopleID= rs("PeopleID") 
     session("PeopleID") = ""


end if
rs.close
 %>
 
<%
if len(PeopleID) > 0 then
sql = "select * from associationmembers where Peopleid = " & Peopleid & " "
'response.write("sql=" & sql)
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
If Not rs.eof Then
	 %>
<table width = "<%= screenwidth%>" border = "0"><tr><td class = "body2 roundedtopandbottom" align = "center" valign = "top" ><h1><center>Account Already Exists</center></h1>An association account with the email address <%=AssociationEmailaddress  %> already exists.<br><br />Please select <a href = "/memberlogin.asp" class = "body"><b>sign in</b></a> to log into your account.</td></tr></table> 
<% 
end if
rs.close
end if


if ExistingAccount = True then
variables ="&SpeciesID=" & SpeciesID & "&MemberFirstName=" & MemberFirstName & "&MemberLastName=" & MemberLastName & "&MemberEmail=" & MemberEmail & "&MemberPosition=" & MemberPosition & "&AssociationContactPosition=" & AssociationContactPosition & "&AssociationName=" & AssociationName & "&Associationwebsite=" & Associationwebsite & "&AssociationEmailaddress=" & AssociationEmailaddress & "&AddressStreet=" & AddressStreet & "&AddressApt=" & AddressApt & "&AddressCity=" & AddressCity & "&State=" & State & "&Country=" & Country & "&AddressZip=" & AddressZip & "&AssociationPhone=" & AssociationPhone & "&AssociationAcronym=" & AssociationAcronym
'conn.close
'set conn = nothing
'response.redirect("SetupAssociationAccount.asp?existing=True" & variables)
end if


if len(Update) < 1 then
  if len(Session("Update")) > 1 then
     Update = "True"
  else
  Update = "False"
  end if
end if


 
Query =  "INSERT INTO Address (AddressStreet, AddressApt, AddressCity, AddressState, AddressCountry, AddressZip)" 
Query =  Query & " Values ('" & AssociationStreet  & "'," 
Query =  Query & " '" &  AssociationApt & "', " 
Query =  Query & " '" &  AssociationCity & "', " 
Query =  Query & " '" &  AssociationState & "', " 
Query =  Query & " '" &  Associationcountry & "', " 
Query =  Query & " '" &  AssociationZip & "')" 
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


rs.close



Query =  "INSERT INTO Associations (AssociationName, AddressID, AssociationAcronym, AssociationContactName, AssociationContactPosition, AssociationContactEmail,  Associationwebsite, AssociationEmailaddress, AssociationStreet1, AssociationStreet2, AssociationCity, Associationcountry, AssociationState, AssociationZip, AssociationPhone )" 
Query =  Query & " Values ('" & AssociationName & "', " 
Query =  Query & " " &  AddressID & ", " 
Query =  Query & " '" & AssociationAcronym & "' , " 
Query =  Query & " '" &  AssociationContactName & "', " 
Query =  Query & " '" &  AssociationContactPosition & "', " 
Query =  Query & " '" &  AssociationContactEmail & "', " 
Query =  Query & " '" &  Associationwebsite & "', " 
Query =  Query & " '" &  AssociationEmailaddress  & "', " 
Query =  Query & " '" &  AssociationStreet1  & "', " 
Query =  Query & " '" &  AssociationStreet2  & "', " 
Query =  Query & " '" &  AssociationCity  & "', " 
Query =  Query & " '" &  Associationcountry  & "', " 
Query =  Query & " '" &  AssociationState  & "', " 
Query =  Query & " '" &  AssociationZip & "', " 
Query =  Query & " '" &  AssociationPhone & "')" 
'response.write("Query=" & Query )

Conn.Execute(Query) 
Conn.close
set Conn = nothing %>
<!--#Include virtual="Conn.asp"-->
<%		
sql = "select AssociationID from Associations where AssociationContactEmail = '" & AssociationContactEmail & "' order by AssociationID Desc"
		
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	ExistingEvent = False
	If Not rs.eof Then
		AssociationID = rs("AssociationID")
	End If 
rs.close





Query =  "INSERT INTO Associationmembers (AssociationID, PeopleID, MemberPosition, AccessLevel )" 
Query =  Query & " Values ('" & AssociationID  & "'," 
Query =  Query & " '" &  PeopleID & "', " 
Query =  Query & " '" &  MemberPosition & "', " 
Query =  Query & " '3')" 
'response.Write("Query=" & Query )
Conn.Execute(Query) 

Conn.close
set Conn = nothing %>


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

response.redirect("AssociationAccountConfirmation.asp?AssociationID=" & associationID & "&PeopleID=" & PeopleID)
end if
end if

%>



</Body>
</HTML>

