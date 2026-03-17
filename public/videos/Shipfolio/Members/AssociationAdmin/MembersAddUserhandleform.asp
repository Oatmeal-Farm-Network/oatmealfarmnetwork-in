<!doctype html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta http-equiv="Content-Language" content="en-us">


<!--#Include virtual="/includefiles/globalvariables.asp"-->


<% 
	response.write(" AssociationID=" &  Session("AssociationID"))
termemails = Request.Form("termemails")

	if termemails = "on" then
	    termemails = 1
	else
		termemails = 0
	end if

country_id = Request.Form("country_id") 
PeoplePassword = Request.Form("PeoplePassword") 
AccessLevel = Request.Form("AccessLevel")
PeopleFirstName  =Request.Form("PeopleFirstName") 
PeopleLastName  =Request.Form("PeopleLastName") 
PeopleTitleID =Request.Form("PeopleTitleID") 
PeopleWebsite =Request.Form("PeopleWebsite") 
PeopleEmail =Request.Form("PeopleEmail") 
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

Position = Request.Form("Position")


str1 = Position 
str2 = "'"
If InStr(str1,str2) > 0 Then
	Position = Replace(str1,  str2, "''")
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
sql = "select PeopleID from People  where  Peopleemail = '" & Peopleemail & "' order by PeopleID Desc"
response.write("sql=" & sql & "<br>")
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
If Not rs.eof Then
    temppeopleid = rs("peopleid")
End If 

	ExistingMember = False
if len(temppeopleid) > 1 then

	sql = "select AssociationMemberID from associationmembers where associationID=" &  Session("AssociationID") & " and PeopleID = " & temppeopleid & ""
	response.write("sql=" & sql & "<br>")
	Set rs = Server.CreateObject("ADODB.Recordset")
	rs.Open sql, conn, 3, 3   
	If Not rs.eof Then
		ExistingMember = True
		AssociationMemberID = rs("AssociationMemberID")
	End If 

End If


'response.write("ExistingAccount=" & ExistingAccount & "<br>")

'response.write("temppeopleid=" & temppeopleid & "<br>")
	
sql = "select * from associations  where AssociationID = " & session("AssociationID") & ""
response.write("sql=" & sql & "<br>")
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
If Not rs.eof Then
	 AssociationName = rs("AssociationName")
End If 



rs.close
if len(Update) < 1 then
  if len(Session("Update")) > 1 then
     Update = "True"
  else
  Update = "False"
  end if
end if

if ExistingMember = False then
if len(PeopleID)> 0 then
sql = "select AddressID, WebsitesID, BusinessID from People where PeopleID = " & temppeopleid & ""

	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	ExistingEvent = False
	If Not rs.eof Then
		AddressID  =rs("AddressID") 
End If 
rs.close
else
end if



if ExistingMember = False then
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


	' Function to generate a random password
Function GenerateRandomPassword(length)
    Dim chars, password, i
    
    ' Define the characters to be used in the password
    chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%&*()+="
    
    ' Initialize the password variable
    password = ""
    
    ' Loop through the desired length and randomly select characters from the defined set
    For i = 1 To length
        Randomize ' Initialize the random number generator
        password = password & Mid(chars, Int((Len(chars) * Rnd) + 1), 1)
    Next
    
    ' Return the generated password
    GenerateRandomPassword = password
End Function

' Usage example
Dim passwordLength
passwordLength = 8 ' Set the desired length of the password

' Generate a random password
Dim randomPassword
randomPassword = GenerateRandomPassword(passwordLength)



'response.write("Membership=" & Membership)
if (ExistingMember = False)  then
Query =  "INSERT INTO People ("
if len(AddressID) > 0 then
Query = Query & " AddressID, "
end if

Query = Query & "AccessLevel, ResetPassword, Position, peoplepassword, PeopleFirstName, PeopleLastName, PeoplePhone, PeopleEmail, PeopleCell )" 
Query = Query & " Values (" 


if len(AddressID) > 0 then
Query = Query & " " &  AddressID & ","	
end if



if len(accesslevel) > 0 then
Query = Query & " " &   AccessLevel & ", " 	
else
Query = Query & " 1, " 	
end if

Query = Query & " 1, " 
Query = Query & " '" &  Position & "', " 
Query = Query & " '" &  randomPassword & "', " 
Query = Query & " '" &  PeopleFirstName & "', " 
Query = Query & " '" &  PeopleLastName & "', " 
Query = Query & " '" &  PeoplePhone & "', " 
Query = Query & " '" &  Peopleemail & "', " 
Query = Query & " '" &  Peoplecell & "' ) " 
else
Query =  " UPDATE People Set AddressID = " &  AddressID & ", " 
Query =  Query & " AccessLevel  = " &  AccessLevel & "," 
Query =  Query & " FirstName = '" &  PeopleFirstName & "'," 
Query =  Query & " LastName = '" &  PeopleLastName & "'," 
Query =  Query & " Phone = '" &  PeoplePhone & "'," 
Query =  Query & " email = '" &  email & "'," 
Query =  Query & " Cell = '" &  PeopleCell & "'"
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

if (ExistingMember = False )  then
Query = "INSERT INTO associationmembers (PeopleID, AssociationID, MemberPosition, AccessLevel)" 
	    Query =  Query + " Values ('" & PeopleID  & "'," 
	    Query =  Query & " '" &  session("AssociationID") & "', " 
	   Query =  Query & " '" &  Position & "', " 
		Query =  Query & " '" &  AccessLevel & "')" 
response.write("Query=" & Query )
Conn.Execute(Query) 
end if

 
conn.close
set conn = nothing
end if

if (ExistingMember = False )  then
	Dim strTo, strSubject, strBody
Dim objCDONTSmail
Dim smtpServer

smtpServer = "mail.livestockofamerica.com"
strTo = "contactus@livestockofamerica.com"
strFrom = "contactus@livestockofamerica.comm"
strSubject = "You Have Been Added"


strBody = "<html>"
strBody = strBody & "<head>"
strBody = strBody & "<style>"
strBody = strBody & "body { font-family: Arial, sans-serif; }"
strBody = strBody & "#header-bar { background-color: #B2D6D1; text-align: center; }"
strBody = strBody & "#header-img { max-width: 340px; height: auto; }"
strBody = strBody & "</style>"
strBody = strBody & "</head>"
strBody = strBody & "<body>"


strBody = strBody & "<table width = 340>"
    
strBody = strBody & "<tr><td colspan = 2><img src='https://GlobalLivestockSolutions.com/Logos/AAWLogo.png' alt='Header Image' id='header-img' width=340px style='max-width:340px'><td></tr>"
strBody = strBody & "<tr><td colspan = 2><br><b>Your new " & AssociationName & " Account</b><td></tr>"
strBody = strBody & "<tr><td colspan = 2><br>Dear " & PeopleFirstName & "&nbsp;" & PeopleLastName & ",<br>"
strBody = strBody & "You have been given access to the " & AssociationName & " account with Agricultures Associations Of The World.<br><br>"
strBody = strBody & "To log in, visit <a href='https://www.harvesthub.world/associationadmin/associationLogin.asp'class = body>www.HarvestHub.World/AssociationAdmin/AssociationLogin.asp</a>"
strBody = strBody & " and enter your email address along with the following temporary password.<br><br>"
strBody = strBody & "<b>Temporary Password: &nbsp;" & randomPassword & "</b><br><br>"
strBody = strBody & "Once logged in, you will be prompted to set a new password for your account.<br><td></table>"
strBody = strBody & "</body>"
strBody = strBody & "</html>"



response.write("strBody=" & strBody )

Set oMail = Server.CreateObject("CDO.Message")
Set iConf = Server.CreateObject("CDO.Configuration")
Set Flds = iConf.Fields
iConf.Fields.Item("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2
iConf.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpserver") = "smtp.sendgrid.net"
iConf.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout") = 60
iConf.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 465
iConf.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate") = 1 'basic (clear-text) authentication
iConf.Fields.item("http://schemas.microsoft.com/cdo/configuration/smtpusessl") = True

iConf.Fields.Item("http://schemas.microsoft.com/cdo/configuration/sendusername") = "apikey"
iConf.Fields.Item("http://schemas.microsoft.com/cdo/configuration/sendpassword") = "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"
iConf.Fields.Update
Set oMail.Configuration = iConf
oMail.To = "contactus@livestockoftheworld.com"



oMail.From = AssociationName & "<livestockoftheworld@gmail.com>"
oMail.Replyto = "contactUs@GlobalGrange.world"
oMail.Subject = "Your new " & AssociationName & " Account" 
oMail.HTMLBody  = strBody
oMail.TextBody = strBody
PeopleEmail = "john@globalgrange.world"
response.write("email=" & PeopleEmail )
oMail.To = PeopleEmail
oMail.Send

Set iConf = Nothing
Set Flds = Nothing
set omail=nothing
end if

response.redirect("AssociationAddMembers.asp?country_id=" & country_id & "&UserAdded=True&ExistingMember=" & ExistingMember )
%>


	</Body>
</html>
