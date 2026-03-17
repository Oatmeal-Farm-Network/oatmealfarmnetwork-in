<%@ LANGUAGE="VBSCRIPT" %>
<% Response.Buffer = true %>
<html>
<head>
<title>Contest Entry Confirmation</title>
 <link rel="stylesheet" type="text/css" href="Style.css">
</head>
</HEAD>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<% PageTitle = "Contest Entry Confirmation"  %>
<!--#Include virtual="/SpecialsHeader.asp"-->


<%
Dim interested
Dim Contest
Dim strFName
Dim strLName
Dim strMName
Dim strBizName
Dim strAddress1
Dim strCity
Dim strState
Dim strZipcode
Dim strCountry
Dim strEmail
Dim strCommentText
Dim CurrentlyOwn
Dim PlanToOwn

interested=Request.Form("interested")
Contest=Request.Form("Contest")
strFName=Request.Form("FName")
strLName=Request.Form("LName")
strBizName=Request.Form("Bizname")
strAddress1=Request.Form("Address1")
strCity=Request.Form("City")
strState=Request.Form("State")
strZipcode=Request.Form("Zipcode")
strCountry=Request.Form("Country")
strEmail=Request.Form("Email")
strPhone=Request.Form("Phone")
strCommentText=Request.Form("CommentText")
CurrentlyOwn = Request.Form("CurrentlyOwn")
PlanToOwn = Request.Form("PlanToOwn")

%>



<%
Response.Flush

'Email Contact Information to Andresen Acres
Dim strTo, strSubject, strBody
Dim objCDONTSmail
Dim smtpServer

smtpServer = "mail.webartists.biz"
strTo = "renate@hughes.net"
strSubject = "Contest Entry"

strBody = "This message was sent from the Contest Entry Form"

' Body Data
strBody = strBody & "<br>First Name:"
strBody = strBody & strFName
strBody = strBody & "<br>Last Name: "
strBody = strBody & strLName
strBody = strBody & "<br> Business Name: "
strBody = strBody & strBizName
strBody = strBody & "<br>Address: "
strBody = strBody & strAddress1
strBody = strBody & "<br>City: "
strBody = strBody & strCity
strBody = strBody & "<br>State: "
strBody = strBody & strState
strBody = strBody & "<br>Zip Code:"
strBody = strBody & strZipcode
strBody = strBody & "<br>Country: "
strBody = strBody & strCountry
strBody = strBody & "<br>Email: "
strBody = strBody & strEmail
strBody = strBody & "<br>Phone: "
strBody = strBody & strPhone
strBody = strBody & "<br>Currently Own Alpacas?: "
strBody = strBody & CurrentlyOwn

strBody = strBody & "<br>If No, Plan on owning alpacas in the next 2 years?: "
strBody = strBody & PlanToOwn

strBody = strBody & "<br><br>Comments or Questions:"
strBody = strBody & strCommentText
strBody = strBody & "<br>"

'CDONTS EMail
set objCDONTSmail = Server.CreateObject("CDONTS.NewMail")
objCDONTSmail.BodyFormat = 0
objCDONTSmail.MailFormat = 0
objCDONTSmail.From = strTo
objCDONTSmail.To = strTo
objCDONTSmail.Subject = strSubject
objCDONTSmail.Body = strBody
objCDONTSmail.Send

set objCDONTSmail = Nothing


%>
<table width = "<%=bodywidth%>" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center" height = "200">
	<tr>		
		 <td   valign ="top" class = "body" align = "center">
						<br>Thank you. You have been entered into our contest. 
						<br>
						While you are here please look around our site, <br><a href = "AlpacaSale.asp" class = 
						"body">click here</a> if you wish to go to our complete sales list.<br><br>
				</td>	
			</tr>
	
</table>
				</td>	
			</tr>
	
</table>
<!--#Include virtual="/Footer.asp"--> 
</body>
</html>