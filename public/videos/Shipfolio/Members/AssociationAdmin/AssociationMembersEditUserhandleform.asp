<!DOCTYPE html>
<html>
<head>
<!--#Include file="AssociationGlobalVariables.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta http-equiv="Content-Language" content="en-us">
</head>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   >
<%
PeopleID = Request.QueryString("PeopleID")

ExistingSite = False

AccessLevel = request.form("AccessLevel")
Preferedspecies = Request.form("Preferedspecies") 
PreferedBreed = Request.form("PreferedBreed") 
EventID = Request.form("EventID") 
ReturnPage= Request.form("ReturnPage") 
PeopleID = Request.form("PeopleID") 
PeopleFirstName  =Request.Form("PeopleFirstName") 
PeopleLastName  =Request.Form("PeopleLastName") 
PeopleTitleID =Request.Form("PeopleTitleID") 
PeopleWebsite =Request.Form("PeopleWebsite") 
PeopleEmail =Request.Form("PeopleEmail") 
password =Request.Form("PeoplePassword")
Response.write("password=" & password )
MemberPosition =Request.Form("MemberPosition") 
confirm  =Request.Form("ConfirmPassword") 
AddressStreet = Request.Form("AddressStreet") 
AddressApt = Request.Form("AddressApt") 
AddressCity  = Request.Form("AddressCity")
AddressState  = Request.Form("AddressState")
AddressZip  = Request.Form("AddressZip")
PeoplePhone  = Request.Form("PeoplePhone")
PeopleCell  = Request.Form("PeopleCell")
PeopleFax  = Request.Form("PeopleFax")
BusinessName  = Request.Form("BusinessName")
AddressCountry  = Request.Form("AddressCountry")
Owners  = Request.Form("Owners")
response.Write("BusinessName=" & BusinessName )

if password = confirm then
else
   response.redirect("AssociationMembersEditUser.asp?UserID=" & PeopleID & "Message=Your Passwords do not match" )
end if




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



str1 = MemberPosition
str2 = "'"
If InStr(str1,str2) > 0 Then
	MemberPosition= Replace(str1,  str2, "''")
End If 

str1 = BusinessName
str2 = "'"
If InStr(str1,str2) > 0 Then
	BusinessName= Replace(str1,  str2, "''")
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

str1 = password
str2 = "'"
If InStr(str1,str2) > 0 Then
	password= Replace(str1,  str2, "''")
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

	Query =  " UPDATE Address Set AddressStreet = '" &  AddressStreet & "', " 
	Query =  Query & " AddressApt = '" &  AddressApt & "'," 
	Query =  Query & " AddressCity = '" &  AddressCity & "'," 
    Query =  Query & " AddressState = '" &  AddressState & "'," 
    Query =  Query & " AddressCountry = '" &  AddressCountry & "'," 
     Query =  Query & " AddressZip = '" &   AddressZip & "'" & " where AddressID = " & AddressID & ";" 


response.Write("query=" & Query)

Conn.Execute(Query) 
 if len(WebsitesID) > 0 then
	Query =  " UPDATE Websites Set Website = '" &  PeopleWebsite & "' " 
	Query =  Query & " where WebsitesID = " & WebsitesID & ";" 
response.write("Website query = " & Query & "<br>")	

Conn.Execute(Query) 

else
Query =  "INSERT INTO Websites (Website)" 
 Query =  Query & " Values ('" & PeopleWebsite  & "')" 

Conn.Execute(Query) 


end if 


 sql = "select AddressID from Address where AddressStreet = '" & AddressStreet & "' and AddressCity= '" & AddressCity & "' and AddressZip = '" & AddressZip  & "' order by AddressID Desc"
'response.write(sql)
		
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	ExistingEvent = False
	If Not rs.eof Then
		AddressID = rs("AddressID")
	End If 
rs.close

sql = "select WebsitesID from Websites where Website = '" & PeopleWebsite & "' Order by WebsitesID Desc "
'response.write(sql)
		
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	ExistingEvent = False
	If Not rs.eof Then
		WebsitesID = rs("WebsitesID")
	End If 
rs.close

Query =  " UPDATE AssociationMembers Set AccessLevel = " &  AccessLevel & " , MemberPosition= '" & MemberPosition & "'"
Query =  Query & " where PeopleID = " & PeopleID & ";" 
		response.write(Query)
Conn.Execute(Query) 


if len(BusinessID) > 0 then
        Query =  " UPDATE Business Set BusinessName = '" &  BusinessName & "' " 
        Query =  Query & " where BusinessID = " & BusinessID & ";" 
		response.write(Query)
Conn.Execute(Query) 

else


Query =  "INSERT INTO Business (BusinessName)" 
 Query =  Query & " Values ('" & BusinessName   & "')" 

Conn.Execute(Query)


 sql = "select BusinessID from Business where BusinessName = '" & BusinessName & "'"
'response.write(sql)
		
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	ExistingEvent = False
	If Not rs.eof Then
		BusinessID = rs("BusinessID")
	End If 
rs.close

end if

	Query =  " UPDATE People Set AddressID = " &  AddressID & ", " 
    if len(Preferedspecies) > 0 then
    Query =  Query & " Preferedspecies = " &  Preferedspecies & "," 
    end if
     if len(Preferedbreed) > 0 then
Query =  Query & " PreferedBreed = " &  PreferedBreed & "," 
end if
	Query =  Query & " WebsitesID = " &  WebsitesID & "," 
	Query =  Query & " BusinessID = '" &  BusinessID & "'," 
    Query =  Query & " PeopleFirstName = '" &  PeopleFirstName & "'," 
    Query =  Query & " PeopleLastName = '" &  PeopleLastName & "',"
    Query =  Query & " Owners = '" &  Owners & "',"  
    Query =  Query & " PeoplePhone = '" &  PeoplePhone & "'," 
    Query =  Query & " Peopleemail = '" &  Peopleemail & "'," 
    Query =  Query & " Peoplefax = '" &  Peoplefax & "',"
    Query =  Query & " custCountry = '" &  addresscountry & "',"
    Query =  Query & " PeopleCell = '" &  PeopleCell & "',"
   Query =  Query & " PeoplePassword = '" &  Password & "'"
    Query =  Query & " where PeopleID = " & PeopleID & ";" 


response.write("Query="	& Query )
Conn.Execute(Query) 
Conn.close

 if len(PeopleTitleID) > 0 then 
	sql = "select PeopleTitle from PeopleTitleLookup where PeopleTitleID = " & PeopleTitleID & ""
response.write(sql)
		
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	ExistingEvent = False
	If Not rs.eof Then
PeopleTitle = rs("PeopleTitle")


  end if 
end if

response.redirect("AssociationMembersEditUser.asp?Updated=True&UserID=" & PeopleID )
 
 %>
<br><br><br>
</Body>
</HTML>