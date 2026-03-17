<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Associations & Clubs | Create Account</title>
<meta name="author" content="Livestock Of The World">
<!--#Include Virtual="/includefiles/GlobalVariables.asp"-->



<% Set rs4 = Server.CreateObject("ADODB.Recordset")
Set rs5 = Server.CreateObject("ADODB.Recordset")
%>

</head>
<body >

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

AssociationTypeID = Request.Form("AssociationTypeID")
	response.write("AssociationTypeID=" & AssociationTypeID )
Associationwebsite = Request.Form("Associationwebsite") 
AssociationEmailaddress= Request.Form("AssociationEmailaddress") 
AssociationAcronym = request.form("AssociationAcronym")
AssociationStreet = Request.Form("AssociationStreet1") 
AssociationApt = Request.Form("AssociationStreet2") 
AssociationCity  = Request.Form("AssociationCity")
AssociationstateIndex = Request.Form("AssociationstateIndex")
Associationcountry_id  = Request.Form("Associationcountry_id")
AssociationZip  = Request.Form("AssociationZip")
AssociationPhone  = Request.Form("AssociationPhone")
PeopleWebsite = request.form("PeopleWebsite")
Registry = request.form("Registry")
FoodHub = request.form("FoodHub")
CSA = request.form("CSA") 
Livestock = request.form("Livestock")
FarmAg= request.form("FarmAg")
FarmersMarket = request.form("FarmersMarket")
AssociationFacebook= request.form("AssociationFacebook")
AssociationX= request.form("AssociationX")
AssociationInstagram= request.form("AssociationInstagram")
AssociationPinterest= request.form("AssociationPinterest")
AssociationTruthSocial= request.form("AssociationTruthSocial")
AssociationBlog= request.form("AssociationBlog")
AssociationYouTube= request.form("ssociationYouTube")
AssociationOtherSocial1= request.form("AssociationOtherSocial1")
AssociationOtherSocial2= request.form("AssociationOtherSocial2")


Query =  "INSERT INTO Address (AddressStreet, AddressApt, AddressCity, AddressZip,"
If len(AssociationstateIndex) > 0 then	
Query =  Query &  " country_id, "
end if
Query =  Query &  "	StateIndex )" 
Query =  Query & " Values ('" & AssociationStreet  & "'," 
Query =  Query & " '" &  AssociationApt & "', " 
Query =  Query & " '" &  AssociationCity & "', " 
Query =  Query & " '" &  AssociationZip & "', " 
If len(AssociationstateIndex) > 0 then
Query =  Query & " " &  AssociationstateIndex & " ," 
end if
Query =  Query & " " &  Associationcountry_id  & " ) " 

response.Write("Query=" & Query )
Conn.Execute(Query) 

	
sql = "select AddressID from Address where AddressStreet = '" & AddressStreet & "' order by AddressID Desc"
		
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	If Not rs.eof Then
		AddressID = rs("AddressID")
	End If 
rs.close
response.write("AddressID=" & AddressID )



variables ="&AssociationTypeID=" & AssociationTypeID &" &SpeciesID=" & SpeciesID & "&Associationcountry_id =" & Associationcountry_id  & "&PeopleFirstName=" & PeopleFirstName & "&PeopleLastName=" & PeopleLastName & "&AssociationContactPosition=" & AssociationContactPosition & "&AssociationName=" & AssociationName & "&Associationwebsite=" & Associationwebsite & "&AssociationEmailaddress=" & AssociationEmailaddress & "&AddressStreet=" & AddressStreet & "&AssociationApt=" & AssociationApt & "&AssociationCity=" & AssociationCity & "&State=" & State & "&AddressZip=" & AddressZip & "&AssociationPhone=" & AssociationPhone & "&AssociationAcronym=" & AssociationAcronym & "&Registry=" & Registry  & "&FoodHub=" & FoodHub & "&CSA=" & CSA & "&Livestock=" & Livestock & "&FarmAg=" & FarmAg  & "&FarmersMarket=" & FarmersMarket  & "&AssociationFacebook=" & AssociationFacebook & "&AssociationX=" & AssociationX & "&AssociationInstagram=" & AssociationInstagram & "&AssociationPinterest=" & AssociationPinterest & "&AssociationTruthSocial=" & AssociationTruthSocial & "&AssociationBlog=" & AssociationBlog & "&AssociationYouTube=" & AssociationYouTube  & "&AssociationOtherSocial1=" & AssociationOtherSocial1  & "&AssociationOtherSocial2=" & AssociationOtherSocial2


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
   'Response.redirect("SetupAssociationAccountExistingmember.asp?PeopleEmail=" & PeopleEmail & "&PeoplePassword=" & PeoplePassword & variables & "&Message=Please enter your associations name." )
end if

str1 = AssociationFacebook
str2 = "'"
If InStr(str1,str2) > 0 Then
	AssociationFacebook= Replace(str1,  str2, "''")
End If  

str1 = lcase(AssociationFacebook)
str2 = "http://"
If InStr(str1,str2) > 0 Then
	AssociationFacebook= right(AssociationFacebook, len(AssociationFacebook) - 7)
End If 




	str1 = AssociationX
str2 = "'"
If InStr(str1,str2) > 0 Then
	AssociationX= Replace(str1,  str2, "''")
End If  

str1 = lcase(AssociationX)
str2 = "http://"
If InStr(str1,str2) > 0 Then
	AssociationX= right(AssociationX, len(AssociationX) - 7)
End If 



	str1 =AssociationInstagram
str2 = "'"
If InStr(str1,str2) > 0 Then
	AssociationInstagram= Replace(str1,  str2, "''")
End If  

str1 = lcase(AssociationInstagram)
str2 = "http://"
If InStr(str1,str2) > 0 Then
	AssociationInstagram= right(AssociationInstagram, len(AssociationInstagram) - 7)
End If 


	str1 = AssociationPinterest
str2 = "'"
If InStr(str1,str2) > 0 Then
	AssociationPinterest= Replace(str1,  str2, "''")
End If  

str1 = lcase(AssociationPinterest)
str2 = "http://"
If InStr(str1,str2) > 0 Then
	AssociationPinterest= right(AssociationPinterest, len(AssociationPinterest) - 7)
End If 



	str1 = AssociationTruthSocial
str2 = "'"
If InStr(str1,str2) > 0 Then
	AssociationTruthSocial= Replace(str1,  str2, "''")
End If  

str1 = lcase(AssociationTruthSocial)
str2 = "http://"
If InStr(str1,str2) > 0 Then
	AssociationTruthSocial= right(AssociationTruthSocial, len(AssociationTruthSocial) - 7)
End If 



	str1 = AssociationBlog
str2 = "'"
If InStr(str1,str2) > 0 Then
	AssociationBlog= Replace(str1,  str2, "''")
End If  

str1 = lcase(AssociationBlog)
str2 = "http://"
If InStr(str1,str2) > 0 Then
	AssociationBlog= right(AssociationBlog, len(AssociationBlog) - 7)
End If 


str1 = AssociationYouTube
str2 = "'"
If InStr(str1,str2) > 0 Then
	AssociationYouTube= Replace(str1,  str2, "''")
End If  

str1 = lcase(AssociationYouTube)
str2 = "http://"
If InStr(str1,str2) > 0 Then
	AssociationYouTube= right(AssociationYouTube, len(AssociationYouTube) - 7)
End If 


str1 = AssociationOtherSocial1
str2 = "'"
If InStr(str1,str2) > 0 Then
	AssociationOtherSocial1= Replace(str1,  str2, "''")
End If  

str1 = lcase(AssociationOtherSocial1)
str2 = "http://"
If InStr(str1,str2) > 0 Then
	AssociationOtherSocial1= right(AssociationOtherSocial1, len(AssociationOtherSocial1) - 7)
End If 

str1 = AssociationOtherSocial2
str2 = "'"
If InStr(str1,str2) > 0 Then
	AssociationOtherSocial2= Replace(str1,  str2, "''")
End If  

str1 = lcase(AssociationOtherSocial2)
str2 = "http://"
If InStr(str1,str2) > 0 Then
	AssociationOtherSocial2= right(AssociationOtherSocial2, len(AssociationOtherSocial2) - 7)
End If 

str1 = AssociationContactPosition
str2 = "'"
If InStr(str1,str2) > 0 Then
	AssociationContactPosition= Replace(str1,  str2, "''")
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










Query =  Query & " " &  AssociationX & ", " 
Query =  "INSERT INTO Associations (AssociationName, AssociationTypeID, FarmersMarket, FarmAg, AssociationShowaddress, Livestock, CSA, FoodHub,AssociationFacebook, AssociationX, AssociationInstagram, AssociationPinterest, AssociationTruthSocial, AssociationBlog, AssociationYouTube, AssociationOtherSocial1, AssociationOtherSocial2, AddressID, AssociationAcronym, AssociationContactName, AssociationContactPosition, AssociationContactEmail,  Associationwebsite, AssociationEmailaddress, country_id  )" 
Query =  Query & " Values ('" & AssociationName & "', " 
	Query =  Query &  AssociationTypeID & ", "

	if FarmersMarket = 1 then
		Query =  Query & " 1,"
	else
		Query =  Query & " 0,"
	end if

if FarmAg = 1 then
		Query =  Query & " 1,"
	else
		Query =  Query & " 0,"
	end if

if AssociationShowaddress = 1 then
		Query =  Query & " 1,"
	else
		Query =  Query & " 0,"
	end if

if Livestock = 1 then
		Query =  Query & " 1,"
	else
		Query =  Query & " 0,"
	end if

if CSA = 1 then
		Query =  Query & " 1,"
	else
		Query =  Query & " 0,"
	end if

if FoodHub = 1 then
		Query =  Query & " 1,"
	else
		Query =  Query & " 0,"
	end if

Query =  Query & " '" &  AssociationFacebook & "', " 
Query =  Query & " '" &  AssociationX & "', " 
Query =  Query & " '" &  AssociationInstagram & "', " 
Query =  Query & " '" &  AssociationPinterest & "', " 
Query =  Query & " '" &  AssociationTruthSocial & "', " 
Query =  Query & " '" &  AssociationBlog & "', " 
Query =  Query & " '" &  AssociationYouTube & "', " 
Query =  Query & " '" &  AssociationOtherSocial1 & "', " 
Query =  Query & " '" &  AssociationOtherSocial2 & "', " 

Query =  Query & " " &  AddressID & ", " 
Query =  Query & " '" & AssociationAcronym & "' , " 
Query =  Query & " '" &  AssociationContactName & "', " 
Query =  Query & " '" &  AssociationContactPosition & "', " 
Query =  Query & " '" &  AssociationEmailaddress & "', " 
Query =  Query & " '" &  Associationwebsite & "', " 
Query =  Query & " '" &  AssociationEmailaddress  & "', " 
Query =  Query & " " &  Associationcountry_id  & ")" 
response.write("Query=" & Query )

Conn.Execute(Query) 
	
sql = "select AssociationID from Associations where AssociationContactEmail = '" & AssociationEmailaddress & "' order by AssociationID Desc"
		
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

%>





<% Current = "CreateAccount"
Current3 = "JoinLOA" 
CurrentWebsite = "LivestockofAmerica" 
session("LoggedIn") = False%>
<!--#Include Virtual="/includefiles/Header.asp"-->

<% Set rs2 = Server.CreateObject("ADODB.Recordset")

peopleid = request.form("peopleid")


'if len(PeoplID) > 0 then
'else
'PeopleID = session("peopleID")
'end if
'response.write("Peopleid=" & session("peopleID"))

'if len(peopleid) > 0 then
'else
Email=Trim(Request.Form("Email")) 
password=Trim(Request.Form("password")) 
if len(Email) < 5 or len(password) < 8 then
  fail = "True"
 ' response.Redirect("SetupAssociationAccountExistingmember.asp?AssociationError=True")
else
  fail = "False"
end if 

	
sql2 = "select * from  People where people.accesslevel > 0 and trim(lower(PeopleEmail)) = '" & trim(lcase(PeopleEmail)) & "'  and peoplePassword = '" & PeopleEmail & "'"
'response.write("slq2=" & sql2 )
acounter = 1
rs2.Open sql2, Conn, 3, 3 

if rs2.eof Then
	
   Session("WebsiteAccess")=False
fail ="True"
	else 

	'	response.write("custemail=" & rs2("Email") & " ")
	'response.write("custPasswd=" & rs2("Password"))
PeopleID = rs2("PeopleID")
Session("PeopleID")= rs2("PeopleID")
Session("WebsiteAccess")=True

'end if

rs2.close

'response.write("fail=" & fail )

end if
response.redirect("AssociationHome.asp?AssociationID=" & AssociationID )

 %>



<br /><br />

<!--#Include virtual ="/Members/MembersFooter.asp"-->  </body>
</HTML>