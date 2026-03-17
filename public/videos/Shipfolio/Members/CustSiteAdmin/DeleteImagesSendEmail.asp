<%@ LANGUAGE="VBSCRIPT" %>
<% Response.Buffer = true %>
<html>
<head>
<title>Delete Images Email Confirmation</title>
       <link rel="stylesheet" type="text/css" href="style.css">
</head>
</HEAD>
<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 background = "images/background.jpg">
<!--#Include virtual="/Administration/Header.asp"--> 
	
<%
Dim FileType
Dim TotalCount
Dim Filename(400)
Dim DeleteImage(400)
Dim FilesToDelete(400)

FileType=Request.Form("FileType")

TotalCount= Request.Form("TotalCount")
TotalCount = CInt(TotalCount)

'rowcount = CInt(rowcount)
rowcount = 1
dcount = 1
while (rowcount < TotalCount)
	Filenamecount = "Filename(" & rowcount & ")"
	Filename(rowcount)=Request.Form(Filenamecount) 

	DeleteImagecount = "DeleteImage(" & rowcount & ")"
	DeleteImage(rowcount)=Request.Form(DeleteImagecount) 

   If DeleteImage(rowcount)  = "on" Then
	 FilesToDelete(dcount) = Filename(rowcount)
	 dcount = dcount +1
   End If 

	
	rowcount = rowcount +1

Wend

TotaldCount = dcount
%>





<%
Response.Flush

'Email Contact Information to WebArtists.biz
Dim strTo, strSubject, strBody
Dim objCDONTSmail
Dim smtpServer

smtpServer = "mail.webartists.biz"
strTo = "johna@webartists.biz"
strSubject = WebSiteName & " Delete Images Form"

strBody = "<br>This message was sent from the Alpacas At Lone Ranch Delete Images Form" & "<br>"

' Body Data
strBody = strBody & "Website: "
strBody = strBody &  "Alpacas At Lone Ranch <br>"
strBody = strBody & "File Type: "
strBody = strBody & FileType & "<br>"
strBody = strBody & "Images to delete: "
dcount = 1
while (dcount < TotaldCount)
	strBody = strBody & FilesToDelete(dcount) & "<br>"
	dcount = dcount +1
Wend


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

'response.write(strBody)
%>
<div align = "center">
		<br><br><br>Thank You<br>
		Your list of images to delete has been sent to WebArtists.biz.<br>
		<A href= "DeleteImages.asp" class = "body"> Please click here to return to your Delete Images page.</a>
	</div>	

	

			
<!--#Include virtual="/administration/Footer.asp"--> 
</body>
</html>
