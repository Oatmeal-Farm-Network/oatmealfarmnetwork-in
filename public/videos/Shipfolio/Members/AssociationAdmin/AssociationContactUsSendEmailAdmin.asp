<!Doctype html>

<head>

<% SetLocale("en-us") 

CurrentAssociationID=Request.form("CurrentAssociationID") 
BusinessName=Request.form("AssociationName") 
%>

<!--#Include file="AssociationGlobalVariables.asp"-->

<% Set rs = Server.CreateObject("ADODB.Recordset")
			
	sql = "select  * from Associations where AssociationID= " & CurrentAssociationID
			rs.Open sql, conn, 3, 3
				If not rs.eof then
				 'response.write(WebLink)
				
				AssociationContactEmail  = rs("AssociationContactEmail")
                AssociationEmailaddress = rs("AssociationContactEmail")

				rs.close
			End If 
			%>
<title>Association Contact From</title>



</head>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   >
<% AnimalName=Request.Form("AnimalName")
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
AssociationEmailaddress= request.Form("AssociationEmailaddress") 
Question = request.form("Question")
fieldX = request.form("fieldX")
Shoesize =request.form("Shoesize")
if not(fieldX = Mid(Question, 13, 1)) or len(trim(Shoesize)) > 0 or len(fieldX) < 1 then
'response.Write("Not Found")
	Response.redirect("/associationContactUs.asp?AssociationID=" & CurrentAssociationID & "&Message=Please Answer the Math Question Correctly.")
end if 
Subject=request.form("Fieldname9") 
If Len(Subject) < 3 then
	Subject= Request.QueryString("Fieldname9") 
End If 
	

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
strBody = strBody & "<font face='Arial' size = '2'>This email comes from your association contact us form on LivestockOfTheWorld.com. Please use the email address below to respond - <b>do not reply directly to this email-  the sending email address is not monitored.</b><br>"
strBody = strBody & "<br>Contact Name: "
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

if len(AssociationContactEmail) > 3 then
strTo = AssociationContactEmail
else
strTo = AssociationEmailaddress
end if

strTo = AssociationEmailaddress
response.write("strTo=" & strTo )


strTo = "john@theandresengroup.com"
strFrom = "DoNotReply <pacamail@theandresengroup.com>"
strSubject = "Contact From Your Livestock Of The World Association Contact Page"

if len(Email) > 4 then
 ObjSendMail.ReplyTo =Email
end if
ObjSendMail.to =strTo
ObjSendMail.BCC =  "Contactus@livestockoftheworld.com"
ObjSendMail.Subject = strSubject
ObjSendMail.From = strFrom
     
' we are sending a text email.. simply switch the comments around to send an html email instead

ObjSendMail.HTMLBody = strBody
'ObjSendMail.TextBody = strBody
'response.Write(strBody)  
ObjSendMail.Send
     
Set ObjSendMail = Nothing 

'response.write(strBody)
%>
		
		


</HEAD>
<% if mobiledevice = True or is_iPad = true then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<% end if %>

<% Current = "CreateAccount"
Current3="Directory"
CurrentWebsite = "LivestockofTheWorld" 
session("LoggedIn") = False%>
<% 
Current1 = "AssociationHome"
Current2="AssociationHome" %> 
<!--#Include file="AssociationHeader.asp"-->
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%"><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Email Sent</div></H2>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center">
<br />
<Table border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center" width = "700" height = "175">
	<tr>
		<td class = "body" valign = "top"><center><big><b>Thank You</b><br>

        <% if len(AssociationName) > 2 then %>
        Your Email has been sent to <%=AssociationName %>. 
        <% else %>
	Your Email has been sent. 
    <% end if %> <br>
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