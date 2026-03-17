<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!--#Include virtual="/associationadmin/AssociationGlobalVariables.asp"-->
<link rel="canonical" href="<%=currenturl %>" />
<title>Join The Global Grange Community</title>
<meta name="title" content="Join The Global Grange Community<"/> 
<meta name="description" content=""/>  
<meta charset="UTF-8">
<meta name="revisit-after" content="7 Days"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<% homepage = true %>
    </head>
<body >

<% Current1 = "AssociationHome"
Current2="AssociationHome" %> 

<!--#Include virtual="/AssociationAdmin/AssociationMembersHeader.asp"-->
<% Current2 = "SiteAdmin" 
Current3 = "AddUsers" %> 

<% If not rs.State = adStateClosed Then
rs.close
End If   	
%>
<br />
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  width = "<%=screenwidth -30%>" >
<tr><td class=roundedtop><H2>Add a User Account</H2> </td></tr>
<tr><td height = "560" valign = "top" class = "roundedBottom body">
<%
ExistingSite = False
Update = "False"
CorporateAccountID = session("CorporateAccountID")

PeoplePassword = Request.Form("PeoplePassword") 
AccessLevel = Request.Form("AccessLevel")
ReturnFileName = Request.querystring("ReturnFileName") 
ReturnEventID = Request.querystring("ReturnEventID") 
Update  =Request.Form("Update") 
PeopleFirstName  =Request.Form("PeopleFirstName") 
PeopleLastName  =Request.Form("PeopleLastName") 
PeopleTitleID =Request.Form("PeopleTitleID") 
PeopleWebsite =Request.Form("PeopleWebsite") 
PeopleEmail =Request.Form("PeopleEmail") 
if len(Peopleemail)> 0  then
else
Peopleemail =Request.querystring("PeopleEmail") 
end if
ConfirmEmail =Request.Form("ConfirmEmail") 
confirm  =Request.Form("confirm") 
AddressStreet = Request.Form("AddressStreet") 
AddressApt = Request.Form("AddressApt") 
AddressCity  = Request.Form("AddressCity")
AddressState  = Request.Form("AddressState")
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

ExistingAccount = False
sql = "select * from People  where  Peopleemail = '" & Peopleemail & "'"
response.write("sql=" & sql & "<br>")
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
If Not rs.eof Then
	ExistingAccount = True
    temppeopleid = rs("peopleid")
End If 
response.write("ExistingAccount=" & ExistingAccount & "<br>")

response.write("temppeopleid=" & temppeopleid & "<br>")

rs.close
if len(Update) < 1 then
  if len(Session("Update")) > 1 then
     Update = "True"
  else
  Update = "False"
  end if
end if

if ExistingAccount = False or Update = "True"  then
if len(PeopleID)> 0 then
sql = "select AddressID, WebsitesID, BusinessID from People where PeopleID = " & temppeopleid & ""

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
conn.Execute(Query) 
else
Query =  " UPDATE Websites Set Website = '" &  PeopleWebsite & "' " 
Query =  Query & " where WebsitesID = " & WebsitesID & ";" 
Conn.Execute(Query) 


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


Conn.Execute(Query) 

if ExistingSite = False  then
		Query =  "INSERT INTO Address (AddressStreet, AddressApt, AddressCity, AddressState, AddressZip)" 
	    Query =  Query + " Values ('" & AddressStreet  & "'," 
	    Query =  Query & " '" &  AddressApt & "', " 
		Query =  Query & " '" &  AddressCity & "', " 
		Query =  Query & " '" &  AddressState & "', " 
		Query =  Query & " '" &  AddressZip & "')" 
response.write("Query=" & Query )
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
if len(addressid) > 0 then
	Query =  " UPDATE Address Set AddressStreet = '" &  AddressStreet & "', " 
	Query =  Query & " AddressApt = '" &  AddressApt & "'," 
	Query =  Query & " AddressCity = '" &  AddressCity & "'," 
    Query =  Query & " AddressState = '" &  AddressState & "'," 
    Query =  Query & " AddressZip = '" &   AddressZip & "'" & " where AddressID = " & AddressID & ";" 

Conn.Execute(Query) 
end if

end if 
daynow= day(now)
monthnow = month(now)
yearnow = year(now)
datenow = monthnow & "/" & daynow & "/" & yearnow
datenownext =  monthnow & "/" & daynow & "/" & (yearnow +1 )
datenownextlife =  monthnow & "/" & daynow & "/" & (yearnow + 20 )
'response.write("datenow = " & datenow)
'response.write("datenownext  = " & datenownext )
'response.write("datenownextlife  = " & datenownextlife )

'response.write("Membership=" & Membership)
if (ExistingSite = False and Update = "False") or len(PeopleID) < 1 then
Query =  "INSERT INTO People ("
if len(AddressID) > 0 then
Query = Query & " AddressID, "
end if

Query = Query & "AccessLevel, PeoplePassword, WebsitesID, BusinessID,  PeopleFirstName, PeopleLastName, PeoplePhone, Peopleemail, Peoplefax, PeopleCell, PeopleActive, CorporateAccountID )" 
Query = Query & " Values (" 


if len(AddressID) > 0 then
Query = Query & " " &  AddressID & ","	
end if



if len(accesslevel) > 0 then
Query = Query & " " &   AccessLevel & ", " 	
else
Query = Query & " 1, " 	
end if
Query = Query & " '" &   PeoplePassword & "', " 
Query = Query & " " &   WebsitesID & ", " 
Query = Query & " " &   BusinessID & ", " 
Query = Query & " '" &  PeopleFirstName & "', " 
Query = Query & " '" &  PeopleLastName & "', " 
Query = Query & " '" &  PeoplePhone & "', " 
Query = Query & " '" &  Peopleemail & "', " 
Query = Query & " '" &  Peoplefax & "', " 
Query = Query & " '" &  Peoplecell & "', " 
Query = Query & " 1 , "
Query = Query & " " &  CorporateAccountID & ") " 
else
Query =  " UPDATE People Set AddressID = " &  AddressID & ", " 
Query =  Query & " WebsitesID = " &  WebsitesID & "," 
Query =  Query & " AccessLevel  = '" &  AccessLevel & "'," 
Query =  Query & " AccessLevel  = " &  AccessLevel & "," 
Query =  Query & " BusinessID  = " &  BusinessID & "," 
Query =  Query & " PeopleFirstName = '" &  PeopleFirstName & "'," 
Query =  Query & " PeopleLastName = '" &  PeopleLastName & "'," 
Query =  Query & " PeoplePhone = '" &  PeoplePhone & "'," 
Query =  Query & " Peopleemail = '" &  Peopleemail & "'," 
Query =  Query & " Peoplefax = '" &  Peoplefax & "',"
Query =  Query & " CorporateAccountID = " &  CorporateAccountID & ","
Query =  Query & " PeopleCell = '" &  PeopleCell & "'"
Query =  Query & " where PeopleID = " & PeopleID & ";" 

end if 
response.write("Query =" & Query  )
Conn.Execute(Query) 

if len(addressid) > 0 then 
 sql = "select PeopleID from People where AddressID = " & AddressID  & " order by PeopleID Desc;"

		
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	If Not rs.eof Then
		PeopleID = rs("PeopleID")
	End If 
rs.close

end if

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


Session("LoggedIn") = true
 Response.Cookies("LoggedIn")= true
Response.Cookies("PeopleFirstName")= PeopleFirstName
Session("Update") = true
 
if len(PeopleID) > 0 then
'response.write("PeopleID=" & PeopleID)	
'response.write("AddressID=" & AddressID)	
else
sql = "select PeopleID from People where AddressID = " & AddressID  & " order by PeopleID Desc;"

'response.write("sql=" & sql)	
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	If Not rs.eof Then
		PeopleID = rs("PeopleID")
	End If 
rs.close

end if
 
conn.close
set conn = nothing


%>

<div align = "center" class = "body"><H2>
<%response.redirect("MemberseditUser.asp?UserID=" & PeopleID)
     response.write("Your changes have successfully been made.")
  %></H2>
</div>
<%
Else
response.write("This user is already in the system.")
End if
%>
<table width = "660" align = "center">
<tr >
<td align = "right" class = "body" valign = "top" height = "300">
<br>To add another user select the <a  class = "Links" href="SiteAdminAddUser.asp">Add Users</a> tab.
<br>
</td></tr></table>
</td></tr></table>
<!--#Include virtual="/associationadmin/associationFooter.asp"-->
	</Body>
</html>
