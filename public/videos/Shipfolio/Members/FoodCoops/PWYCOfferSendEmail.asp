<!DOCTYPE html >
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<% 	  OBOOffer= Request.form("OBOOffer") %>
 <!--#Include virtual="/GlobalVariables.asp"-->
 <!--#Include file="DetailDBInclude.asp"--> 
<title>Make an OBO Offer</title>
<meta name="robots" content="nofollow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="revisit-after" content="1"/>
<meta name="Googlebot" content="nofollow"/>
<meta name="robots" content="none"/>
<link rel="shortcut icon" href="/infinityknot.ico" /> 
<link rel="icon" href="http://www.AlpacaChamps.com/infinityknot.ico" /> 
<meta name="author" content="The Andresen Group"/>
<link rel="stylesheet" type="text/css" href="/Style.css" />
<% SetLocale("en-us") 
CurrentPeopleID=Request.form("CurrentPeopleID") 
%>
 <!--#Include virtual="/GlobalVariables.asp"-->
 <% Set rs = Server.CreateObject("ADODB.Recordset")
sql = "select  * from People where PeopleID= " & CurrentPeopleID
rs.Open sql, conn, 3, 3
If not rs.eof then
WebLink = rs("WebLink")
 'response.write(WebLink)
PeopleEmail   = rs("PeopleEmail")
str1 = WebLink
str2 = "http://"
If InStr(str1,str2) > 0 Then
WebLink= Replace(str1,  str2, "")
End If 
rs.close
End If 
%>
</head>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   >
<% AnimalName=Request.Form("AnimalName")
 PWYCOffer=Request.Form("PWYCOffer")
 AnimalID=Request.querystring("ID")
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
Question= request.Form("Question")
PeopleID = CurrentPeopleID
'response.Write("fieldX=" &  fieldX )
'response.Write("Question=" & Question )
if not(fieldX = Mid(Question, 13, 1)) or len(trim(Shoesize)) > 0 or len(fieldX) < 1 then
'	response.Redirect("PlacePWYCbid.asp?ID=" &  AnimalID  & "&PeopleID=" & CurrentPeopleID)
end if 
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

smtpServer = "smtp-1.internet-host.net"
strTo = PeopleEmail
strCC = "john@andresengroup.com"
strFrom = "DoNotReply <contactus@livestockofamerica.com>"
strSubject = "You Have a Pay What You Can Stud Breeding Offer on " & AnimalName

'Body Data
strBody = strBody & "<font face='arial'>You have received an Pay What You Can Stud Breeding Offer from someone viewing your Livestock of America Pages. The breeding offer and the potential purchaser information is below. Please contact them directly, with the email address listed below, and proceed to accept or reject their offer. <br><br>"
strBody = strBody & "<br>Alpaca: "
strBody = strBody & AnimalName
strBody = strBody & "<br>Breeding Offer Amount: "
strBody = strBody & formatcurrency(PWYCOffer,2)
strBody = strBody & "<br>Contact Name: "
strBody = strBody & FirstName & LastName
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
strBody = strBody & "<br><br> Message: "
strBody = strBody & Comments
strBody = strBody & "<br></font>"

'CDONTS EMail
set objCDONTSmail = Server.CreateObject("CDONTS.NewMail")
objCDONTSmail.BodyFormat = 0
objCDONTSmail.MailFormat = 0
objCDONTSmail.From = strFrom
objCDONTSmail.To = strTo
objCDONTSmail.BCC = strCC
objCDONTSmail.Subject = strSubject
objCDONTSmail.Body = strBody
objCDONTSmail.Send
set objCDONTSmail = Nothing
%>
<!--#Include file="RanchHeader.asp"-->
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth %>"><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Offer Sent</div></H2>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center">
<br />
<Table border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center" width = "700" height = "175">
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