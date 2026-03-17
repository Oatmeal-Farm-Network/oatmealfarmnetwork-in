<!Doctype html>
<head>
<% SetLocale("en-us") 
CurrentPeopleID=Request.form("CurrentPeopleID") 
%>
<!--#Include virtual="/GlobalVariables.asp"-->
<% Set rs = Server.CreateObject("ADODB.Recordset")
sql = "select  * from People where PeopleID= " & CurrentPeopleID
'response.write(sql)
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
End If %>
<title>Contact From Contact Form</title>
<meta name="robots" content="nofollow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="revisit-after" content="1"/>
<meta name="Googlebot" content="nofollow"/>
<meta name="robots" content="none"/>
<link rel="stylesheet" type="text/css" href="/Style.css">
</head>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   >
<% Product=Request.Form("Product")
 OBOOffer=Request.Form("OBOOffer")
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

Question = request.form("Question")
fieldX = request.form("fieldX")
Shoesize =request.form("Shoesize")
if not(fieldX = Mid(Question, 13, 1)) or len(trim(Shoesize)) > 0 or len(fieldX) < 1 then
'response.Write("Not Found")
	Response.redirect("http://www.livestockofamerica.com/Ranches/RanchContactUs.asp?CurrentPeopleID=" & CurrentPeopleID & "&Message=Please Answer the Math Question Correctly.")
end if 
Subject=request.form("Fieldname9") 
If Len(Subject) < 3 then
	Subject= Request.QueryString("Fieldname9") 
End If 
	
	sql = "select * from People where PeopleID = " & CurrentPeopleID & ";"


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
	'response.write("PeopleEmail =" & PeopleEmail)

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

'Body Data
strBody = strBody & "<font face='Arial' size = '2'>This email comes from the contact us form on your Livestock Of America Farm Page. Please use the email address below to respond - <b>do not reply directly to this email-  the sending email address is not monitored.</b><br>"
strBody = strBody & "<br>Product: "
strBody = strBody & Product & "<br>"
strBody = strBody & "<br>Buyer's Name: "
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
strBody = strBody & "<br><br>Comments: "
strBody = strBody & Comments
strBody = strBody & "<br></font>"



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
     
'End remote SMTP server configuration section==
strTo = PeopleEmail
'strTo = "john@theandresengroup.com"
strFrom = "DoNotReply <pacamail@theandresengroup.com>"
strSubject = "Contact From Your Livestock Of America Product Form"

 'ObjSendMail.to =strTo
 ObjSendMail.To =  "john@TheAndresenGroup.com"
ObjSendMail.Subject = "LOA: Someone wants to buy one of your " & Product 
ObjSendMail.From = strFrom
     
' we are sending a text email.. simply switch the comments around to send an html email instead

ObjSendMail.HTMLBody = strBody
'ObjSendMail.TextBody = strBody
'response.Write(strBody)  
ObjSendMail.Send
     
Set ObjSendMail = Nothing 

'response.write(strBody)
sql = "select * from RanchSiteDesign where PeopleID= " & CurrentPeopleID
	rs.Open sql, conn, 3, 3
	If not rs.eof Then

		MenuBackgroundColor = rs("MenuBackgroundColor")
		MenuColor = rs("MenuColor")
		MenuFontMouseOverColor = rs("MenuFontMouseOverColor")
		TitleColor = rs("TitleColor")
		PageBackgroundColor = rs("PageBackgroundColor")
		PageTextColor = rs("PageTextColor")
		LayoutStyle = rs("LayoutStyle")
		PageTextMouseOverColor = rs("PageTextMouseOverColor")
		
	End If
rs.close 

if PageBackgroundColor= "Black" Then
			TitleColor = "white"
			PageTextColor = "white"
		end if 
		
		%>
		
		
<style>
		H1 {font: 24pt arial; color: <%=TitleColor %>}
		H2 {font: 20pt arial; color: <%=TitleColor %>}
		H3 {font: 12pt arial; color: <%=TitleColor %>}
		.Body {font: 10pt arial; color: <%=PageTextColor %>}
		A.Body {font: 10pt arial; color: <%=PageTextColor %>}
		A.Body:hover { color: <%=PageTextMouseOverColor%>}
			.Heading {font: 10pt arial; color: <%=MenuColor %>}
		A.Heading {font: 10pt arial; color: <%=MenuFontMouseOverColor %>}
</style>
<!--#Include file="RanchHeader.asp"-->
<% Current3 = "Contact Us" %>
<!--#Include file="RanchPagesTabsInclude.asp"-->
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%"><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Email Sent</div></H2>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center">
<br />
<table border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center" width = "<%=screenwidth %>" height = "300">
	<tr>
		<td class = "body" valign = "top"><center><big><b>Thank You</b><br>
	Your Email with sent to <%=BusinessName %>.
    <br />It is now up to them to respond back to you. <br>
	<br>
		</big></center>
</td></tr></table>
</td>
	</tr>
</table>
<%    
	Set conn = nothing %>
<!--#Include virtual="/Footer.asp"-->
</body>
</html>