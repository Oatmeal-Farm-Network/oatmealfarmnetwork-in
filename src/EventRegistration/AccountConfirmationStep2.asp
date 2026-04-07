<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!--#Include file="GlobalVariables.asp"-->

<meta http-equiv="Content-Language" content="en-us">
<title>Sign Up for a Free Andresen Events Subscription</title>
<link rel="shortcut icon" href="/infinityknot.ico" /> 
<link rel="icon" href="http://www.alpacainfinity.com/alpacachamps/infinityknot.ico" /> 
<META NAME="ROBOTS" CONTENT="NOODP">
<link rel="stylesheet" type="text/css" href="style.css">

<% 
Password = Trim(Request.Form("Password"))
Password2 = Trim(Request.Form("Password2"))
ActivationCode = Trim(Request.Form("ActivationCode"))

errorstring1=""
errorstring2=""
emailerror = False
Passworderror = False
Activationerror = False

sql = "select * from  People where ActivationCode = '" & ActivationCode & "'"
rs.Open sql, conn, 3, 3
If not rs.eof Then
	Activationerror = False
   PeopleID = rs("PeopleID")
  session("PeopleID") = PeopleID 
Else
	Activationerror = True
End if	
Passwordlengtherror = False
If len(Trim(Password)) < 8 Then
	Passwordlengtherror = true
End If 

If Not(Trim(Password) = Trim(Password2)) Then
	Passworderror = true
End If 

If Passworderror = False And Activationerror = False then
	
Query =  " UPDATE People Set accesslevel = -1," 
Query =  Query & " PeoplePassword = '" & Password & "'" 
Query =  Query & " where ActivationCode = '" & ActivationCode & "';" 
'response.write(Query)

Conn.close

End If 		
%>
</HEAD>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center">

<!--#Include virtual="/Header.asp"-->

<% 
   session("PeopleID") = PeopleID 
PID = request.form("PID")
session("PID") = PID
FullPrice = request.form("FullPrice")


If  Passworderror = True Or Activationerror = True Or Passwordlengtherror = True Then 
	redirectString = "AccountConfirmation.asp?Passwordlengtherror=" & Passwordlengtherror & "&Passworderror=" & Passworderror & "&Activationerror=" & Activationerror
	response.redirect(redirectString)
Else 	%>
     
   <br /><table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "900"><tr><td class = "roundedtop" align = "left">
		<H1><div align = "left">Activation Completion!</div></H1>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center">
        
        
<table  border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   width = "95%"  align = "center">
  <tr>
    <td class = "body">

<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   valign ="top"  width = "700">
	<tr>
	    <td class = "body"  height = "83" valign = "top" >
	<br /><h1>Your Account is Set Up and Activated!</h1>
	Select one of the links to proceed:<ul>
	    <li><a href = 'RegistrySearch.asp' class= "menu" >&nbsp;Register for an Event</a>.</li>
	    <li><a href = 'RegCreateType.asp' class= "menu" >&nbsp;Create an Event</a>.</li>
        <li><a href = 'Default.asp' class= "menu" >&nbsp;Go to Home Page</a>.</li>
</ul>

<br>
	<h2>Thank you for choosing <img src = "/images/AELogoSmall.jpg" align = "center" width = "265" height = "46"  alt = "Andresen Events - Alpacas for Sale"></h2><br>
<br>			
<br>	    
</td>
	</tr>
</table>	
</td>
	</tr>
</table>

</td>
	</tr>
</table>
<% End if %>							
<!--#Include virtual="/Footer.asp"-->
</body>
</html>