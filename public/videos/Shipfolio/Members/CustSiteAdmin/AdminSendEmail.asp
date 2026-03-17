<html>

<head>
<%  PageName = "Contact Us" %>
<!--#Include file = "AdminGlobalVariables.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta http-equiv="Content-Language" content="en-us">
<title>The Andresen Group Content Management System</title>
<META name="description" content="<%= WebSiteName %>">
<META name="keywords" content="<%=State%> Alpaca Ranch, <%= WebSiteName %>, <%= Slogan %>, Alpaca web development, alpacas, alpaca">
<meta name="author" content="WebArtists.biz">
<link rel="stylesheet" type="text/css" href="<%=style%>">

</head>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
<!--#Include file="AdminContactVariablesInclude.asp"-->
<% custemail = Email %>

<!--#Include file="AdminScripts.asp"--> 

<%
UID=Request.Form("Fieldname8")
'response.write("UID=")
'response.write(UID)

Subject=request.form("Fieldname9") 
If Len(Subject) < 3 then
	Subject= Request.QueryString("Fieldname9") 
End If 

	conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
	"Data Source=" & server.mappath(databasepath) & ";" & _
	"User Id=;Password=;" 

	sql = "select * from SFCustomers;"

	'response.write(sql)
	Set rs = Server.CreateObject("ADODB.Recordset")
	 rs.Open sql, conn, 3, 3 

	custEmail = rs("custEmail")

    rs.close
	Set conn = nothing
Dim Address
Dim Name
Dim City
Dim State
Dim Zip
Dim Email
Dim Comments

LastName=Request.Form("LastName")
Name=Request.Form("Name")
City=Request.Form("Fieldname6")
State=Request.Form("Fieldname5")
Zip=Request.Form("Fieldname4")
Email=Request.Form("Fieldname2")
Comments=Request.Form("Fieldname1")
URL = Request.Form("URL")
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


If Len(LastName) < 2 then
Response.Flush

'Email Contact Information to WebArtists.biz
Dim strTo, strSubject, strBody
Dim objCDONTSmail
Dim smtpServer

smtpServer = "mail.wintercreekalpacas.com"
strTo = custemail
If Len(Email) > 1 then
strFrom = email
Else
strFrom = custemail
End if
strSubject = "Email from your contact form"

strBody = "The following message comes to you from your website:"

'Body Data
strBody = strBody & "<br>Contact Name: "
strBody = strBody & Name
strBody = strBody & "&nbsp;"
strBody = strBody & "<br> Location: "
strBody = strBody & City
strBody = strBody & ", "
strBody = strBody & State
strBody = strBody & " "
strBody = strBody & Zip
strBody = strBody & " "
strBody = strBody & strCountry
strBody = strBody & "<br>Email Address: "
strBody = strBody & Email
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

End if
%>


<body   marginheight="0" marginwidth="0" topmargin="0" leftmargin="0" ><!--#Include file="Header.asp"--><br>
<Table border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"    valign = "top" align = "center" >
			 <tr>
				<td class = "body"  valign = "top"><br>
						<h1><%=PageTitle %></h1>
				</td>
				</tr>
			<tr>
			  <td class = "body">
	Thank you for contacting us. <br>
	We will be in contact with you shortly.<br><br>
		<A href= "default.asp" class = "body"> Please click here to return to our home page.</a>


</td>
	</tr>
	<tr>
	   <td height = "150">&nbsp;
	   </td>
	  </tr>
</table>


<!--#Include file="AdminFooter.asp"-->
</body>
</html>