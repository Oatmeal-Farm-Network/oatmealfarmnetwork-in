<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="author" content="John Andresen">
    <meta name="generator" content="Oatmeal Farm Network Inc.">
    <title>Harvest Hub</title>
<!--#Include file="MembersGlobalVariables.asp"-->

<body >
<%
dim AnimalIDArray(100000)
dim AnimalNameArray(100000)
	
Current1="Animals"
Current2 = "EditAnimals"
Current3 = "Transfer"  %> 
<!--#Include file="MembersHeader.asp"-->

<div class ="container roundedtopandbottom">
<!--#Include file="MembersJumpLinks.asp"-->

<H1>Transfer Animal to Another Ranch</H1>

 <div class ="container"   >
    
<% 

	TransferRanchID = Request.form("TransferRanchID")
    SearchAnimalID = Request.form("SearchAnimalID")

	'response.write("TransferRanchID=" & TransferRanchID )
	'response.write("SearchAnimalID=" & SearchAnimalID )

	sql2 = "Update Animals set PeopleID = " & TransferRanchID & " where ID=" & SearchAnimalID
	'conn.Execute sql2


	  sql_query = "select * from animals, Photos where animals.AnimalID = Photos.AnimalID and animals.AnimalID=" & SearchAnimalID
       'response.write("sql_query=" & sql_query )
        Set rs = conn.Execute(sql_query)
        if not rs.eof then
            FullName = rs("FullName")
            Photo1= rs("Photo1")
        end if

    
sql_query = "SELECT PeopleID, PeopleEmail, peoplelastname, peopleFirstname, Businessname FROM people INNER JOIN business ON people.BusinessID = business.BusinessID WHERE People.PeopleID=" & session("PeopleID")
    'response.write("sql_query=" & sql_query )
    ' Execute the SQL query
    Set rs = conn.Execute(sql_query)
     if not rs.eof then
        OldOwnerID = rs("PeopleID")
        Oldranch_name = rs("Businessname")
         Oldpeoplelastname = rs("peoplelastname")
        OldpeopleFirstname = rs("peopleFirstname") 
         OldpeopleEmail = rs("PeopleEmail") 
      end if





 sql_query = "SELECT PeopleID, peoplelastname,peopleemail, peopleFirstname, Businessname FROM people INNER JOIN business ON people.BusinessID = business.BusinessID WHERE People.PeopleID=" & TransferRanchID
    'response.write("sql_query=" & sql_query )
    ' Execute the SQL query
    Set rs = conn.Execute(sql_query)
     if not rs.eof then
        NewOwnerID = rs("PeopleID")
        Newranch_name = rs("Businessname")
        Newpeoplelastname = rs("peoplelastname")
        NewpeopleFirstname = rs("peopleFirstname") 
        NewpeopleEmail = rs("PeopleEmail") 
	%>
		You have successfully transferred ownership of:<br />

		&nbsp;&nbsp;<b><%=FullName%></b><br><br />
		To: <br>
        &nbsp;&nbsp;<b><%=Newranch_name %></b><br />
        &nbsp;&nbsp; <%=NewpeopleFirstname %> &nbsp;<%=NewpeopleLastname %><br /><br />
	This transfer of ownership only applies to records associated with Oatmeal Farm Network inc. and does not represent a legal change. Furthermore, it does not impact any registration ownership(s).
     <% end if %>




	</div>
<br />
</div>

<%
Dim strTo, strSubject, strBody
Dim objCDONTSmail
Dim smtpServer

smtpServer = "mail.livestockofamerica.com"
strTo = "contactus@livestockofamerica.com"
strFrom = "contactus@livestockofamerica.comm"
strSubject = "You Transfered Ownership of " & FullName


 'Email to old owner:*******************************
strBody = "<html>"
strBody = strBody & "<head>"
strBody = strBody & "<style>"
strBody = strBody & "body { font-family: Arial, sans-serif; }"
strBody = strBody & "#header-bar { background-color: #B2D6D1; text-align: center; }"
strBody = strBody & "#header-img { max-width: 340px; height: auto; }"
strBody = strBody & "</style>"
strBody = strBody & "</head>"
strBody = strBody & "<body>"


' Initialize the email body
strBody = "<html><body>"
strBody = strBody & "<table width='340'>"
strBody = strBody & "<tr><td colspan='2'><img src='https://GlobalLivestockSolutions.com/Logos/Harvest-Hub-logo.png' alt='Header Image' id='header-img' width='340px' style='max-width:340px'></td></tr>"
strBody = strBody & "<tr><td colspan='2'><br><b>Transfer of Ownership</b></td></tr>"
strBody = strBody & "<tr><td colspan='2'><br>Dear " & OldPeopleFirstName & "&nbsp;" & OldPeopleLastName & ",<br>"
strBody = strBody & "You have transferred ownership of " & FullName & " to " & NewpeopleFirstname & "&nbsp;" & NewpeopleLastname & ".<br><br>"
strBody = strBody & "This transfer of ownership only applies to records associated with Oatmeal Farm Network Inc. and does not represent a legal change. Furthermore, it does not impact any registration ownership(s).<br><br>"
strBody = strBody & "If you did not initiate this transfer, please contact us at <a href='mailto:ContactUs@OatmealFarmNetwork.com'>ContactUs@OatmealFarmNetwork.com</a>.<br></td></tr>"
strBody = strBody & "</table>"
strBody = strBody & "</body>"
strBody = strBody & "</html>"



'response.write("strBody=" & strBody )

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
oMail.To = "livestockoftheworld@gmail.com"
'oMail.To = OldpeopleEmail
oMail.From = sitename & "<contactus@oatmeal-ai.com>"
oMail.Subject = "Animals Transfer " 
oMail.HTMLBody  = strBody
oMail.TextBody = strBody
oMail.Send
Set iConf = Nothing
Set Flds = Nothing
set omail=nothing


 'Email to old owner:*******************************
strBody = "<html>"
strBody = strBody & "<head>"
strBody = strBody & "<style>"
strBody = strBody & "body { font-family: Arial, sans-serif; }"
strBody = strBody & "#header-bar { background-color: #B2D6D1; text-align: center; }"
strBody = strBody & "#header-img { max-width: 340px; height: auto; }"
strBody = strBody & "</style>"
strBody = strBody & "</head>"
strBody = strBody & "<body>"


' Initialize the email body
strBody = "<html><body>"
strBody = strBody & "<table width='340'>"
strBody = strBody & "<tr><td colspan='2'><br><b>Transfer of Ownership</b></td></tr>"
strBody = strBody & "<tr><td colspan='2'><br>Dear " & NewPeopleFirstName & "&nbsp;" & NewPeopleLastName & ",<br>"
strBody = strBody & "Ownership of " & FullName & " has been transferred to you.<br><br>"
strBody = strBody & "This transfer of ownership only applies to records associated with Oatmeal Farm Network  and does not represent a legal change. Furthermore, it does not impact any registration ownership(s).<br><br>"
strBody = strBody & "If you did not initiate this transfer, please contact us at <a href='mailto:ContactUs@OatmealFarmNetwork.com'>ContactUs@OatmealFarmNetwork.com</a>.<br></td></tr>"
strBody = strBody & "</table>"
strBody = strBody & "</body>"
strBody = strBody & "</html>"

on error resume next

'response.write("strBody=" & strBody )

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



oMail.From =  "Oatmeal Farm Network <livestockoftheworld@gmail.com>"
oMail.Replyto = "contactUs@OatmealFarmNetwork.com"
oMail.Subject = "Transfer of Animal Ownership" 
oMail.HTMLBody  = strBody
oMail.TextBody = strBody
PeopleEmail = NewpeopleEmail
'response.write("email=" & PeopleEmail )
oMail.To = PeopleEmail
oMail.Send

Set iConf = Nothing
Set Flds = Nothing
set omail=nothing
 %>

<!--#Include file="membersFooter.asp"-->

 </Body>
</HTML>