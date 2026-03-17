<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<meta name="robots" content="nofollow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="revisit-after" content="1"/>
<meta name="Googlebot" content="nofollow"/>
<meta name="author" content="The Andresen Group"/>
<!--#Include virtual="/members/MembersGlobalVariables.asp"-->
</head>
<body >
<% Current1="Account"
Current2 = "AccountInfo" %>
<!--#Include file="AssociationHeader.asp"--> 
<% If not rs.State = adStateClosed Then
rs.close
End If   	
%>
<br />
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  width = "<%=screenwidth -30%>" >
<tr><td ><H2>Add a User Account</H2> </td></tr>
<tr><td height = "560" valign = "top" class = "body">
<%
ExistingSite = False
Update = "False"
AssociationMembers = session("AssociationMembers")
MemberPassword = Request.Form("MemberPassword") 
AccessLevel = Request.Form("AccessLevel")
MemberFirstName  =Request.Form("MemberFirstName") 
MemberLastName  =Request.Form("MemberLastName") 
PeoplePosition =Request.Form("PeoplePosition") 
MemberEmail =Request.Form("MemberEmail") 
if len(MemberEmail)> 0  then
else
MemberEmail =Request.querystring("MemberEmail") 
end if
ConfirmEmail =Request.Form("ConfirmEmail") 
confirm  =Request.Form("confirm") 
AddressStreet = Request.Form("AddressStreet") 
AddressApt = Request.Form("AddressApt") 
AddressCity  = Request.Form("AddressCity")
AddressState  = Request.Form("AddressState")
AddressZip  = Request.Form("AddressZip")
MemberPhone  = Request.Form("MemberPhone")
PeopleCell  = Request.Form("PeopleCell")
PeopleFax  = Request.Form("PeopleFax")
AssociationMemberID = Request.Form("AssociationMemberID")
if len(AssociationMemberID) > 0 then
else
AssociationMemberID = Request.querystring("AssociationMemberID")
end if 
Owners = Request.Form("Owners")
Membership = Request.Form("Membership")
BusinessName = Request.Form("BusinessName")


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

str1 = MemberFirstName
str2 = "'"
If InStr(str1,str2) > 0 Then
	MemberFirstName= Replace(str1,  str2, "''")
End If  

str1 = MemberLastName
str2 = "'"
If InStr(str1,str2) > 0 Then
	MemberLastName= Replace(str1,  str2, "''")
End If  


str1 = PeoplePosition
str2 = "'"
If InStr(str1,str2) > 0 Then
	PeoplePosition= Replace(str1,  str2, "''")
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


str1 = MemberEmail
str2 = "'"
If InStr(str1,str2) > 0 Then
	MemberEmail= Replace(str1,  str2, "''")
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

str1 = MemberPhone
str2 = "'"
If InStr(str1,str2) > 0 Then
	MemberPhone= Replace(str1,  str2, "''")
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

ExistingAccount = False
sql = "select * from People  where  PeopleEmail = '" & MemberEmail & "'"
response.write("sql=" & sql & "<br>")
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
If Not rs.eof Then
	ExistingAccount = True
End If 
response.write("ExistingAccount=" & ExistingAccount & "<br>")






ExistingMemberAccount = False
sql = "select * from associationmembers  where  MemberEmail = '" & MemberEmail & "'"
response.write("sql=" & sql & "<br>")
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
If Not rs.eof Then
	ExistingMemberAccount = True
    tempAssociationMemberID = rs("AssociationMemberID")
End If 
response.write("ExistingMemberAccount=" & ExistingMemberAccount & "<br>")



rs.close
if len(Update) < 1 then
  if len(Session("Update")) > 1 then
     Update = "True"
  else
  Update = "False"
  end if
end if
'response.write("ExistingMemberAccount=" & ExistingMemberAccount)



daynow= day(now)
monthnow = month(now)
yearnow = year(now)
datenow = monthnow & "/" & daynow & "/" & yearnow
datenownext =  monthnow & "/" & daynow & "/" & (yearnow +1 )
datenownextlife =  monthnow & "/" & daynow & "/" & (yearnow + 20 )
'response.write("datenow = " & datenow)
'response.write("datenownext  = " & datenownext )
'response.write("datenownextlife  = " & datenownextlife )


if ExistingMemberAccount = False then
Query =  "INSERT INTO AssociationMembers ( AccessLevel, MemberPassword, MemberFirstName, MemberLastName, MemberPhone, MemberEmail )" 
Query = Query & " Values (" 

if len(accesslevel) > 0 then
Query = Query & " " &   AccessLevel & ", " 	
else
Query = Query & " 1, " 	
end if
Query = Query & " '" &   MemberPassword & "', " 
Query = Query & " '" &  MemberFirstName & "', " 
Query = Query & " '" &  MemberLastName & "', " 
Query = Query & " '" &  MemberPhone & "', " 
Query = Query & " '" &  MemberEmail &  ") " 
else
Query =  " UPDATE AssociationMembers Set AccessLevel  = " &  AccessLevel & "," 
Query =  Query & " MemberFirstName = '" &  MemberFirstName & "'," 
Query =  Query & " MemberLastName = '" &  MemberLastName & "'," 
Query =  Query & " MemberPhone = '" &  MemberPhone & "'," 
Query =  Query & " MemberEmail = '" &  MemberEmail & "'" 
Query =  Query & " where AssociationMemberID = " & tempAssociationMemberID & ";" 

end if 
'response.write("Query!!! =" & Query  )
Conn.Execute(Query) 



Session("LoggedIn") = true
 Response.Cookies("LoggedIn")= true
Response.Cookies("MemberFirstName")= MemberFirstName
Session("Update") = true
 
 
conn.close
set conn = nothing


%>

<div align = "center" class = "body"><H2>
<% 'response.redirect("MemberseditUser.asp?UserID=" & AssociationMemberID)
     response.write("Your changes have successfully been made.")
  %></H2>
</div>

<table width = "660" align = "center">
<tr >
<td align = "right" class = "body" valign = "top" height = "300">
<br>To add another user select the <a  class = "Links" href="AssociationAddUser.asp">Add User</a> tab.
<br>
</td></tr></table>
</td></tr></table>
<!--#Include file="associationFooter.asp"--> </Body>
</HTML>
