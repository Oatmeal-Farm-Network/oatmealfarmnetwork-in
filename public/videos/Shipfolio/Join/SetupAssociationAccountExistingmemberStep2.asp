<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!--#Include virtual="/includefiles/globalvariables.asp"-->
<title>Create an Association Account</title>

<meta charset="UTF-8">
<meta name="revisit-after" content="7 Days"/>
<link rel="stylesheet" type="text/css" href="style.css" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta http-equiv="Content-Language" content="en-us">
<% 
Region = Request.form("Region")
if len(Region) < 3 then
    Region = Request.querystring("Region")
end if 

sql = "select * from Country where name = '" & Region & "'"
rs.Open sql, conn, 3, 3   
if  Not rs.eof then 
LocalCurrency  = rs("Currency") 
CurrencyCode  = rs("CurrencyCode")
country_id = rs("country_id")
AssociationCountry = rs("name")
end if
rs.close


%>

</head>
<body >
<!--#Include virtual="/Header.asp"-->

<% Set rs4 = Server.CreateObject("ADODB.Recordset")
Set rs5 = Server.CreateObject("ADODB.Recordset")
%>

<% session("LoggedIn") = False

ExistingSite = False
Update = "False"
PeopleID = Request.Form("PeopleID")
'response.write("PeopleID=" & PeopleID)

SpeciesID = Request.Form("SpeciesID")
PeopleFirstName = Request.Form("PeopleFirstName")
PeopleLastName = Request.Form("PeopleLastName")
PeopleEmail = Request.Form("PeopleEmail")
PeoplePassword = Request.Form("PeoplePassword")
MemberPosition = Request.Form("MemberPosition")
AssociationContactPosition = Request.Form("AssociationContactPosition")
AssociationName = Request.Form("AssociationName")
Associationwebsite = Request.Form("Associationwebsite") 
AssociationEmailaddress = Request.Form("AssociationEmailaddress") 
AssociationAcronym = request.form("AssociationAcronym")



AssociationStreet1 = Request.Form("AssociationStreet1") 
AssociationStreet2 = Request.Form("AssociationStreet2") 
AssociationCity  = Request.Form("AssociationCity")
AssociationState  = Request.Form("State")
'country_id  = Request.Form("country_id")
AssociationZip  = Request.Form("AssociationZip")
AssociationPhone  = Request.Form("AssociationPhone")
StateIndex = Request.Form("StateIndex")

variables ="?Region=" & Region & "&AssociationName=" & AssociationName & "&AssociationAcronym=" & AssociationAcronym & "&MemberPosition=" & MemberPosition & "&Associationwebsite=" & Associationwebsite & "&AssociationEmailaddress=" & AssociationEmailaddress & "&AssociationPhone=" & AssociationPhone 

Question = request.form("Question")
fieldX = request.form("fieldX")
Shoesize =request.form("Shoesize")
if not(fieldX = Mid(Question, 13, 1)) or len(trim(Shoesize)) > 0 or len(fieldX) < 1 then
'response.Write("Not Found")

'conn.close
'set conn = nothing
	'Response.redirect("SetupAssociationAccountExistingmember.asp?PeopleEmail=" & PeopleEmail & "&PeoplePassword=" & PeoplePassword & "&Message=Please Answer the Math Question Correctly." & variables )
end if 

if len(AssociationName) < 2 then
    Response.redirect("SetupAssociationAccountExistingmember.asp" & variables & "&Message=Please enter your associations name." )
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


str1 = AssociationStreet1
str2 = "'"
If InStr(str1,str2) > 0 Then
	AssociationStreet1= Replace(str1,  str2, "''")
End If 

str1 = AssociationStreet2
str2 = "'"
If InStr(str1,str2) > 0 Then
	AssociationStreet2= Replace(str1,  str2, "''")
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





if ExistingSite = False and Update = "False" then
		Query =  "INSERT INTO Address ( AddressStreet, AddressApt, AddressCity, StateIndex, addresszip, country_id )" 
	    Query =  Query + " Values ('" &  AssociationStreet1 & "', '" &  AssociationStreet2 & "', '" & AssociationCity & "'," & StateIndex & ", '" & AssociationZip & "'," & country_id & " )" 


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
	Query =  " UPDATE Address Set AddressCountry = '" &  AddressCountry &  "'" & " where AddressID = " & AddressID & ";" 


end if 

Query =  "INSERT INTO Associations (AssociationName, AssociationPhone, AddressID, AssociationAcronym, AssociationContactName, AssociationContactPosition, AssociationContactEmail,  Associationwebsite, AssociationEmailaddress, associationCountry )" 
Query =  Query & " Values ('" & AssociationName & "', " 
Query =  Query & " '" &  AssociationPhone & "', " 
Query =  Query & " " &  AddressID & ", " 
Query =  Query & " '" & AssociationAcronym & "' , " 
Query =  Query & " '" &  AssociationContactName & "', " 
Query =  Query & " '" &  AssociationContactPosition & "', " 
Query =  Query & " '" &  AssociationContactEmail & "', " 
Query =  Query & " '" &  Associationwebsite & "', " 
Query =  Query & " '" &  AssociationEmailaddress  & "', " 

Query =  Query & " '" &  AssociationCountry & "')" 
'response.write("Query=" & Query )

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
'response.Write("Query=" & Query )
Conn.Execute(Query) 

datenownext =  monthnow & "/" & daynow & "/" & (yearnow + years )
Session("MemberAccessLevel")= 3
Session("AssociationID")= AssociationID
Session("PeopleID")= PeopleID
Session("WebsiteAccess")=True

 Current = "CreateAccount"
Current3 = "JoinLOA" 
CurrentWebsite = "LivestockofAmerica" 
session("LoggedIn") = False%>

<% Set rs2 = Server.CreateObject("ADODB.Recordset")

peopleid = request.form("peopleid")


If fail ="True" then
'response.Redirect("SetupAssociationAccountExistingmember.asp?AssociationError=True")
End If
 %>

<% 
'existing = request.querystring("existing")
'SpeciesID = Request.querystring("SpeciesID")

'PeopleFirstName = Request.querystring("PeopleFirstName")
'PeopleLastName = Request.querystring("PeopleLastName")
'PeopleEmail = Request.querystring("PeopleEmail")
'MemberPosition = Request.querystring("MemberPosition")
'ConfirmEmail = Request.querystring("PeopleEmail")

'AssociationContactPosition = Request.querystring("AssociationContactPosition")
'AssociationName = Request.querystring("AssociationName")
'Associationwebsite = Request.querystring("Associationwebsite") 
'AssociationEmailaddress = Request.querystring("AssociationEmailaddress") 
'AssociationAcronym= request.querystring("AssociationAcronym")
'AddressStreet = Request.querystring("AddressStreet") 
'AddressApt = Request.querystring("AddressApt") 
'AddressCity  = Request.querystring("AddressCity")
'State  = Request.querystring("State")
'Country  = Request.querystring("Country")
'AddressZip  = Request.querystring("AddressZip")
'AssociationPhone  = Request.querystring("AssociationPhone")


if existing = "True" then
%>
<h2><center><font color = maroon>Account Already Exists</font></center></h2><center><font color = maroon>An association account with the email address <b><%=PeopleEmail  %></b> already exists. Please select</font> <a href = "/memberlogin.asp" class = "body"><b>sign in</b></a><font color = maroon> to log into your account.</font><br><br /></center>
<% end if %>


 <div class="container-fluid" style="max-width: 600px" >
<h1>Your Association Account Has Been Created!</h1>
   <div class="row">
    <div class="col" style="background-color:eee0c4">
    You are done! Now, just select the button below to proceed to <a href='https://www.livestockassociations.com/associationadmin/associationLogin.asp' target='_blank' class = 'body'>www.LivestockAssociations.com</a> and sign into your association's account:
    
   <form action= 'https://www.livestockassociations.com/associationadmin/associationLogin.asp' method = "post">
   <br />
<center><input type=submit value = "Proceed"  class = "regsubmit2" ></center>
</form>

    
<br>

</div>
</div>
</div>
<br /><br />

<!--#Include virtual="/Footer.asp"-->
 </body>
</HTML>