<!DOCTYPE html>
<html>
<head>    <% MasterDashboard= True %>
    <!--#Include virtual="/Members/Membersglobalvariables.asp"-->

<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta http-equiv="Content-Language" content="en-us">
</head>
<BODY  >
<%

PeopleID = Request.QueryString("PeopleID")
ReturnPage= Request.form("ReturnPage") 
UserName  =Request.Form("UserName") 
PeopleFirstName  =Request.Form("PeopleFirstName") 
PeopleLastName  =Request.Form("PeopleLastName") 
PeopleTitleID =Request.Form("PeopleTitleID") 
PeopleWebsite =Request.Form("PeopleWebsite") 
PeopleEmail =Request.Form("PeopleEmail") 
StateIndex = Request.Form("StateIndex") 
AddressApt = Request.Form("AddressApt") 
AddressCity  = Request.Form("AddressCity")
AddressState  = Request.Form("AddressState")
AddressZip  = Request.Form("AddressZip")
PeoplePhone  = Request.Form("PeoplePhone")
PeopleCell  = Request.Form("PeopleCell")
PeopleFax  = Request.Form("PeopleFax")
AddressCountry  = Request.Form("AddressCountry")
Owners  = Request.Form("Owners")
country_id = Request.Form("country_id")
AddressStreet = Request.Form("AddressStreet")
AddressApt = Request.Form("AddressApt")






sql = "select AddressID from People where PeopleID = " & PeopleID & ""
		
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	EBusinessXistingEvent = False
	If Not rs.eof Then
		AddressID  =rs("AddressID") 

End If 

rs.close

str1 = UserName
str2 = "'"
If InStr(str1,str2) > 0 Then
	UserName= Replace(str1,  str2, "''")
End If  

str1 = BusinessName
str2 = "'"
If InStr(str1,str2) > 0 Then
	BusinessName= Replace(str1,  str2, "''")
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



str1 = PeopleEmail
str2 = "'"
If InStr(str1,str2) > 0 Then
	PeopleEmail= Replace(str1,  str2, "''")
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



	Query =  " UPDATE Address Set AddressStreet = '" &  AddressStreet & "', " 
	Query =  Query & " AddressApt = '" &  AddressApt & "'," 
	Query =  Query & " AddressCity = '" &  AddressCity & "'," 
    Query =  Query & " StateIndex = '" &  StateIndex & "'," 
    Query =  Query & " country_id = '" &  country_id & "'," 
     Query =  Query & " AddressZip = '" &   AddressZip & "'" & " where AddressID = " & AddressID & ";" 


response.Write("query=" & Query)

Conn.Execute(Query) 



 sql = "select AddressID from Address where AddressStreet = '" & AddressStreet & "' and AddressCity= '" & AddressCity & "' and AddressZip = '" & AddressZip  & "' order by AddressID Desc"
'response.write(sql)
		
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	ExistingEvent = False
	If Not rs.eof Then
		AddressID = rs("AddressID")
	End If 
rs.close







	Query =  " UPDATE People Set AddressID = " &  AddressID & ", " 
    Query =  Query & "UserName = '" &  UserName & "'," 
    Query =  Query & " PeopleFirstName = '" &  PeopleFirstName & "'," 
    Query =  Query & " PeopleLastName = '" &  PeopleLastName & "',"
    Query =  Query & " Owners = '" &  Owners & "',"  
    Query =  Query & " PeoplePhone = '" &  PeoplePhone & "'," 
    Query =  Query & " Peopleemail = '" &  Peopleemail & "'," 
    Query =  Query & " Peoplefax = '" &  Peoplefax & "',"
      Query =  Query & " custCountry = '" &  addresscountry & "',"
    Query =  Query & " PeopleCell = '" &  PeopleCell & "'"
    Query =  Query & " where PeopleID = " & PeopleID & ";" 


'response.write("Query="	& Query )
Conn.Execute(Query) 
Conn.close



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
'if len(ReturnPage) > 1 then
'response.redirect(ReturnPage)
'else
response.redirect("MembersAccountContactsEdit.asp?PeopleID=" & PeopleID & "&changesmade=True")
'end if 
 %>
<br><br><br>
</Body>
</HTML>