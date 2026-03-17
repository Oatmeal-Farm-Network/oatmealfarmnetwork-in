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

<!--#Include virtual="/includefiles/GlobalVariables.asp"-->
</head>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   >

<% session("LoggedIn") = False

ExistingSite = False
Update = "False"
PeopleID = Request.Form("PeopleID")
response.write("PeopleID=" & PeopleID)

SpeciesID = Request.Form("SpeciesID")
PeopleFirstName = Request.Form("PeopleFirstName")
PeopleLastName = Request.Form("PeopleLastName")
PeopleEmail = Request.Form("PeopleEmail")
MemberPosition = Request.Form("MemberPosition")

AssociationContactPosition = Request.Form("AssociationContactPosition")
if len(AssociationContactPosition) < 1 then
AssociationContactPosition = Request.querystring("AssociationContactPosition")
end if

AssociationName = Request.Form("AssociationName")
if len(AssociationName) < 1 then
AssociationName = Request.querystring("AssociationName")
end if

Associationwebsite = Request.Form("Associationwebsite") 
if len(Associationwebsite) < 1 then
Associationwebsite = Request.querystring("Associationwebsite")
end if

AssociationEmailaddress = Request.Form("AssociationEmailaddress")
if len(AssociationEmailaddress) < 1 then
AssociationEmailaddress = Request.querystring("AssociationEmailaddress")
end if
 
AssociationAcronym = request.form("AssociationAcronym")
if len(AssociationAcronym) < 1 then
AssociationAcronym = Request.querystring("AssociationAcronym")
end if

AssociationStreet = Request.Form("AssociationStreet")
if len(AssociationStreet) < 1 then
AssociationStreet = Request.querystring("AssociationStreet")
end if
 
AssociationApt = Request.Form("AssociationApt")
if len(AssociationApt) < 1 then
AssociationApt = Request.querystring("AssociationApt")
end if
 
AssociationCity  = Request.Form("AssociationCity")
if len(AssociationCity) < 1 then
AssociationCity = Request.querystring("AssociationCity")
end if

AssociationState  = Request.Form("StateIndex")
if len(AssociationState) < 1 then
AssociationState = Request.querystring("AssociationState")
end if

AssociationCountry  = Request.Form("Country")
if len(AssociationCountry) < 1 then
AssociationCountry = Request.querystring("AssociationCountry")
end if

AddressZip  = Request.Form("AddressZip")
if len(AddressZip) < 1 then
AddressZip = Request.querystring("AddressZip")
end if

AssociationPhone  = Request.Form("AssociationPhone")
if len(AssociationPhone) < 1 then
AssociationPhone = Request.querystring("AssociationPhone")
end if

PeopleWebsite = request.form("PeopleWebsite")
if len(PeopleWebsite) < 1 then
PeopleWebsite = Request.querystring("PeopleWebsite")
end if


Question = request.form("Question")
fieldX = request.form("fieldX")
Shoesize =request.form("Shoesize")
if not(fieldX = Mid(Question, 13, 1)) or len(trim(Shoesize)) > 0 or len(fieldX) < 1 then
'response.Write("Not Found")

variables ="&SpeciesID=" & SpeciesID & "&MemberFirstName=" & MemberFirstName & "&MemberLastName=" & MemberLastName & "&MemberEmail=" & MemberEmail & "&MemberPosition=" & MemberPosition & "&AssociationContactPosition=" & AssociationContactPosition & "&AssociationName=" & AssociationName & "&Associationwebsite=" & Associationwebsite & "&AssociationEmailaddress=" & AssociationEmailaddress & "&AddressStreet=" & AddressStreet & "&AssociationApt=" & AssociationApt & "&AssociationCity=" & AssociationCity & "&State=" & State & "&Country=" & Country & "&AddressZip=" & AddressZip & "&AssociationPhone=" & AssociationPhone & "&AssociationAcronym=" & AssociationAcronym
'conn.close
'set conn = nothing
'response.redirect("SetupAssociationAccount.asp?existing=True" & variables)
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

str1 = MemberEmail
str2 = "'"
If InStr(str1,str2) > 0 Then
	MemberEmail= Replace(str1,  str2, "''")
End If 


str1 = AssociationStreet
str2 = "'"
If InStr(str1,str2) > 0 Then
	AssociationStreet= Replace(str1,  str2, "''")
End If 

str1 = StreetApt
str2 = "'"
If InStr(str1,str2) > 0 Then
	StreetApt= Replace(str1,  str2, "''")
End If 

str1 = AssociationApt 
str2 = "'"
If InStr(str1,str2) > 0 Then
	AssociationApt= Replace(str1,  str2, "''")
End If

str1 = AssociationCity
str2 = "'"
If InStr(str1,str2) > 0 Then
	AssociationCity= Replace(str1,  str2, "''")
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

str1 = AssociationStreet
str2 = "'"
If InStr(str1,str2) > 0 Then
	AssociationStreet= Replace(str1,  str2, "''")
End If 



str1 = AssociationApt 
str2 = "'"
If InStr(str1,str2) > 0 Then
	AssociationApt= Replace(str1,  str2, "''")
End If

str1 = AssociationCity
str2 = "'"
If InStr(str1,str2) > 0 Then
	AssociationCity= Replace(str1,  str2, "''")
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



if len(Update) < 1 then
  if len(Session("Update")) > 1 then
     Update = "True"
  else
  Update = "False"
  end if
end if





 sql = "select AddressID from Address where AddressStreet = '" & AssociationStreet & "' and AddressCity= '" & AssociationCity & "' and AddressZip = '" & AddressZip  & "' order by AddressID Desc"
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
	    Query =  Query + " Values ('" & AssociationStreet  & "'," 
	    Query =  Query & " '" &  AssociationApt & "', " 
		Query =  Query & " '" &  AssociationCity & "', " 
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


else
	Query =  " UPDATE Address Set AddressStreet = '" &  AssociationStreet & "', " 
	Query =  Query & " AddressApt = '" &  AssociationApt & "'," 
	Query =  Query & " AddressCity = '" &  AssociationCity & "'," 
      Query =  Query & " AddressState = '" &  AddressState & "'," 
      Query =  Query & " AddressCountry = '" &  AddressCountry & "'," 
      Query =  Query & " AddressZip = '" &   AddressZip & "'" & " where AddressID = " & AddressID & ";" 


end if 




Query =  "INSERT INTO Associations (AssociationName, AddressID, AssociationAcronym, AssociationContactName, AssociationContactPosition, AssociationContactEmail,  Associationwebsite, AssociationEmailaddress, associationstreet1, associationstreet2, associationcity, associationState, associationCountry, associationZip, AssociationPhone )" 
Query =  Query & " Values ('" & AssociationName & "', " 
Query =  Query & " " &  AddressID & ", " 
Query =  Query & " '" & AssociationAcronym & "' , " 
Query =  Query & " '" &  AssociationContactName & "', " 
Query =  Query & " '" &  AssociationContactPosition & "', " 
Query =  Query & " '" &  AssociationContactEmail & "', " 
Query =  Query & " '" &  Associationwebsite & "', " 
Query =  Query & " '" &  AssociationEmailaddress  & "', " 
Query =  Query & " '" &  AssociationStreet  & "', " 
Query =  Query & " '" &  AssociationApt  & "', " 
Query =  Query & " '" &  AssociationCity  & "', " 
Query =  Query & " '" &  AssociationState  & "', " 
Query =  Query & " '" &  AssociationCountry  & "', " 
Query =  Query & " '" &  AddressZip  & "', " 
Query =  Query & " '" &  AssociationPhone & "')" 
response.write("Query=" & Query )

Conn.Execute(Query) 
	
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
Query =  Query & " " &  PeopleID & ", " 
Query =  Query & " '" &  MemberPosition & "', " 
Query =  Query & " '3')" 
response.Write("Query=" & Query )
Conn.Execute(Query) 

datenownext =  monthnow & "/" & daynow & "/" & (yearnow + years )
Session("MemberAccessLevel")= 3
Session("AssociationID")= AssociationID
Session("PeopleID")= PeopleID
Session("WebsiteAccess")=True
response.redirect("default.asp?Welcome=True&AssociationID=" & associationID & "&PeopleID=" & PeopleID)

%>


</Body>
</HTML>

