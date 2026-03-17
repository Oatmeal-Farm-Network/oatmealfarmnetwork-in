<!Doctype html>

<head>

<% SetLocale("en-us") 

CurrentAssociationID=Request.form("CurrentAssociationID") 
BusinessName=Request.form("AssociationName") 
%>

<!--#Include virtual="/includefiles/globalvariables.asp"-->

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
<link rel="stylesheet" type="text/css" href="/Style.css">



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
if not(fieldX = Mid(Question, 53, 1)) or len(trim(Shoesize)) > 0 or len(fieldX) < 1 then
'response.Write("Not Found")
	Response.redirect("/associationdirectory/associationContactUs.asp?AssociationID=" & CurrentAssociationID & "&Message=Please Answer the Math Question Correctly.")
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
strBody = strBody & "<font face='Arial' size = '2'>This email comes from your association contact us form on www.AgricultureAssociations.world. Please use the email address below to respond - <b>do not reply directly to this email-  the sending email address is not monitored.</b><br>"
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



if len(AssociationContactEmail) > 3 then
strTo = AssociationContactEmail
else
strTo = AssociationEmailaddress
end if

strTo = AssociationEmailaddress
'response.write("strTo=" & strTo )


'strTo = "contactus@globalgrange.world"
strFrom = Email
strSubject = "Contact From Your Livestock Associations Of The World Contact Page"

   


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

if len(Email) > 4 then
 oMail.ReplyTo =Email
end if
oMail.To = strTo

oMail.From = sitename & "<livestockoftheworld@gmail.com>"
oMail.Subject = strSubject
oMail.BCC =  "contactus@globalgrange.world"
oMail.HTMLBody  = strBody
oMail.TextBody = strBody
oMail.Send
Set iConf = Nothing
Set Flds = Nothing
set omail=nothing
  
%>
		
		


</HEAD>

<body >


<% Current = "CreateAccount"
Current3="Directory"
CurrentWebsite = "LivestockofTheWorld" 
session("LoggedIn") = False%>
<!--#Include virtual="Header.asp"-->

<div class="container-fluid" align = center style="max-width: 1000px; min-height: 67px; ">
      <div class = "row">
        <div class = "col body">
  	<H2><div align = "left">Email Sent</div></H2>
  
  
<center><big><b>Thank You</b><br>

        <% if len(AssociationName) > 2 then %>
        Your Email has been sent to <%=AssociationName %>. 
        <% else %>
	Your Email has been sent. 
    <% end if %> <br>
	<br>
		</big></center>

</div>
</div>
</div>
<%    
	Set conn = nothing %>
<!--#Include virtual="Footer.asp"-->
</body>
</html>