<!Doctype html>
<head>
<% SetLocale("en-us") 
CurrentPeopleID=Request.form("CurrentPeopleID") 
%>
<!--#Include virtual="/GlobalVariables.asp"-->
<% Set rs = Server.CreateObject("ADODB.Recordset")
sql = "select  * from People where PeopleID= " & CurrentPeopleID
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
<title>Make an OBO Package Offer</title>
<meta name="robots" content="nofollow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="revisit-after" content="1"/>
<meta name="Googlebot" content="nofollow"/>
<meta name="robots" content="none"/>
<link rel="stylesheet" type="text/css" href="/Style.css">
</head>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   >
<% PackageName=Request.Form("PackageName")
 OBOOffer=Request.Form("OBOOffer")
 AnimalID=Request.Form("AnimalID")
 ID = AnimalID
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

If Len(trim(HoneyPot)) > 0 then
	response.Redirect("PlacePackageOBObid.asp?ID=" &  AnimalID)
End If 
If not fieldX = "8" then
	response.Redirect("PlacePackageOBObid.asp?ID=" &  AnimalID)
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

smtpServer = "smtp-1.internet-host.net"
response.write("PeopleEmail=" & PeopleEmail)
strTo = PeopleEmail
strBCC = "johna@TheAndresengroup.com"
strFrom = "DoNotReply <contactus@LivestockOfAmerica.com>"
strSubject = "You Have a OBO Offer on " & PackageName
'Body Data
strBody = strBody & "You have received an OBO offer from someone viewing your Livestock Of America Pages. The offer and the potential buyers information is below. Please contact them directly and proceed to accept or reject their offer.<br><br> "
strBody = strBody & "<br>Package Name: "
strBody = strBody & PackageName
strBody = strBody & "<br>Offer: "
strBody = strBody & formatcurrency(OBOOffer,2)
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
strBody = strBody & "<br>"
strBody = strBody & "<br><br> Message: "
strBody = strBody & Comments
strBody = strBody & "<br>"

'CDONTS EMail
set objCDONTSmail = Server.CreateObject("CDONTS.NewMail")
objCDONTSmail.BodyFormat = 0
objCDONTSmail.MailFormat = 0
objCDONTSmail.From = strFrom
objCDONTSmail.To = strTo
objCDONTSmail.Subject = strSubject
objCDONTSmail.Body = strBody
objCDONTSmail.Send
set objCDONTSmail = Nothing

'response.write(strBody)


%>
<!--#Include file="RanchHeader.asp"-->
 <% Current3 = "Packages" %>
 <!--#Include file="RanchPagesTabsInclude.asp"-->
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
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