<!Doctype html>
<head>

<% SetLocale("en-us") 

CurrentPeopleID=Request.form("CurrentPeopleID")
TempCurrentPeopleID=CurrentPeopleID
'response.Write("CurrentPeopleID=" & CurrentPeopleID )
%>

 <!--#Include virtual="/GlobalVariables.asp"-->

<% Set rs = Server.CreateObject("ADODB.Recordset")
sql = "select  * from People where PeopleID= " & TempCurrentPeopleID & ""
rs.Open sql, conn, 3, 3
If not rs.eof then
WebLink = rs("WebLink")
PeopleEmail   = rs("PeopleEmail")
str1 = WebLink
str2 = "http://"
If InStr(str1,str2) > 0 Then
WebLink= Replace(str1,  str2, "")
End If 
rs.close
End If 
%>
<title>Make an Dutch Auction Offer</title>
<meta name="robots" content="nofollow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="revisit-after" content="1"/>
<meta name="Googlebot" content="nofollow"/>
<meta name="robots" content="none"/>
<link rel="stylesheet" type="text/css" href="/Style.css">

</head>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   >

<% AnimalName=Request.Form("AnimalName")
 DutchAuctionOffer=Request.Form("DutchAuctionOffer")
 AnimalID=Request.Form("AnimalID")
CurrentPeopleID=Request.Form("CurrentPeopleID")
FirstName= request.Form("FirstName")	
LastName= request.Form("LastName")	
City= request.Form("Fieldname6") 
State= request.Form("Fieldname5")  
Zip= request.Form("Fieldname4")   
Email= request.Form("Fieldname2")          
Phone= request.Form("Fieldname0")
Comments= request.Form("Fieldname1")
fieldX= request.Form("fieldX")
HoneyPot= request.Form("EMail")
PeopleID = CurrentPeopleID
%>

<%
If Len(HoneyPot) > 0 then
	'response.Redirect("PlaceDutchAuctionbid.asp?ID=" &  AnimalID)
End If 
If not fieldX = "13" then
	'response.Redirect("PlaceDutchAuctionbid.asp?ID=" &  AnimalID)
End If 
	
	sql = "select * from People where PeopleID = " & CurrentPeopleID & ";"

	'response.write(sql)
	Set rs = Server.CreateObject("ADODB.Recordset")
	 rs.Open sql, conn, 3, 3 

	PeopleEmail = rs("PeopleEmail")
 rs.close

Dim Address
Dim Name
Dim City
Dim State
Dim Zip
Dim Email
Dim Comments


str1 = Comments
		str2 = vblfvblf
		If InStr(str1,str2) > 0 Then
			Comments= Replace(str1, str2 , "</br>")
		End If  


		str1 = Comments
		str2 = vblf
		If InStr(str1,str2) > 0 Then
			Comments= Replace(str1, str2 , "</br>")
		End If  

		str1 = Comments
		str2 = vbtab
		If InStr(str1,str2) > 0 Then
			Comments= Replace(str1, str2 , "&nbsp;&nbsp;&nbsp;&nbsp;")
		End If  


Response.Flush

'Email Contact Information to WebArtists.biz
Dim strTo, strSubject, strBody
Dim objCDONTSmail
Dim smtpServer



'Body Data
strBody = strBody & "You have received an Dutch Auction offer from someone viewing your Livestock Of America pages. The offer and the potential buyers information is below. Please contact them directly and proceed to accept or reject their offer. "
strBody = strBody & "<br>Animal: "
strBody = strBody & AnimalName
strBody = strBody & "<br>Offer: "
strBody = strBody & formatcurrency(DutchAuctionOffer,2)
strBody = strBody & "<br>Name: "
strBody = strBody & FirstName & " " & LastName
strBody = strBody & "&nbsp;"
strBody = strBody & "<br>Email: "
strBody = strBody & Email
strBody = strBody & "<br>Phone: "
strBody = strBody & Phone
strBody = strBody & "<br>Location: "
strBody = strBody & City
strBody = strBody & ", "
strBody = strBody & State
strBody = strBody & " "
strBody = strBody & Zip
strBody = strBody & "<br>"
strBody = strBody & "<br><br> Message: "
strBody = strBody & Comments
strBody = strBody & "<br>"


Set ObjSendMail = CreateObject("CDO.Message") 
     
'This section provides the configuration information for the remote SMTP server.
     
     
ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2 'Send the message using the network (SMTP over the network).
ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpserver") ="mail.theandresengroup.com" 'your mail server
ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 25 
ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpusessl") = False 'Use SSL for the connection (True or False)
ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout") = 60
     
' If your server requires outgoing authentication uncomment the lines below and use a valid email address and password.
ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate") = 1 'basic (clear-text) authentication
ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/sendusername") ="pacamail@theandresengroup.com"
ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/sendpassword") ="Jackson5"
     
ObjSendMail.Configuration.Fields.Update
     
'End remote SMTP server configuration section=
  strSubject = "You Have a Dutch Auction Offer on " & AnimalName
  response.write("PeopleEmail=" & PeopleEmail)   
ObjSendMail.To = PeopleEmail
ObjSendMail.Bcc= "john@theandresengroup.com"
'ObjSendMail.bcc = "andresengroup@yahoo.com"
'ObjSendMail.To =  "webartistsbiz@gmail.com"
ObjSendMail.Subject = strSubject
ObjSendMail.From =  "Livestock Of America <AuctionOffer@TheAndresenGroup.com>"
  
     
' we are sending a text email.. simply switch the comments around to send an html email instead

ObjSendMail.HTMLBody = strBody
'ObjSendMail.TextBody = strBody
'response.Write(strBody)  
ObjSendMail.Send
     
Set ObjSendMail = Nothing 


%>
 <% Current = "Ranches"
 Current3 = "FarmHome" %>
 <!--#Include file="RanchHeader.asp"-->
 <!--#Include file="RanchPagesTabsInclude.asp"-->
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth %>"><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Offer Sent</div></H2>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center">
<br />
<Table border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center" width = "<%=screenwidth %>" height = "175">
	<tr>
		<td class = "body" valign = "top"><center><big><b>Thank You</b><br>
	An E-mail with your offer has been sent to the owner. It is now up to them to respond back to you. <br>
	<br>
		</big></center>


</td>
	</tr>
</table>
</td>
	</tr>
</table>
<%    
	Set conn = nothing %>
<!--#Include virtual="/Footer.asp"-->
</body>
</html>