<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us">
<title>Sign Up for a Free Alpaca Infinity Subscription</title>
<link rel="shortcut icon" href="/infinityknot.ico" /> 
<link rel="icon" href="http://www.alpacainfinity.com/alpacachamps/infinityknot.ico" /> 
<META NAME="ROBOTS" CONTENT="NOODP">
<link rel="stylesheet" type="text/css" href="style.css">
<!--#Include file="GlobalVariables.asp"-->

</HEAD>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center">
<% Current = "Home" %>
<!--#Include virtual="/conn.asp"-->
<!--#Include virtual="/Header.asp"-->
<!--#Include virtual="HomeHeader.asp"--> 

<% PID = request.form("PID")
session("PID") = PID
FullPrice = request.form("FullPrice")


'response.write("PeopleID=" & session("OrderPeopleID"))
If  Passworderror = True Or Activationerror = True Or Passwordlengtherror = True Then 
	redirectString = "AccountConfirmation.asp?Passwordlengtherror=" & Passwordlengtherror & "&Passworderror=" & Passworderror & "&Activationerror=" & Activationerror
	response.redirect(redirectString)
Else 	%>
  
  

  <table width = "987"  border = "0" cellpadding = "0" cellspacing = "0" style="background-color: #CC9966;" align = "left">
  <tr>
  <td >
     <table border = "0" cellspacing="0" cellpadding = "0" align = "center" height = "520" >
	<tr>
	<td  align = "center" valign = "top">
	<br /><table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "700"><tr><td class = "roundedtop" align = "left">
		<H1><div align = "left">Activation Completion!</div></H1>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center">
        
        
<table  border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   width = "95%"  align = "center">
  <tr>
    <td class = "body">

<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   valign ="top"  width = "780" height = "420">
	<tr>
	    <td class = "body"  height = "83" valign = "top" align = "Left">
	<br /><h1>Your Account is Set Up and Activated!</h1>
<br>
	<h2>Thank you for choosing <img src = "/images/AILogo.jpg" align = "center" width = "225"  alt = "Alpaca Infinity - Alpacas for Sale"></h2><br>
<br>			

<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
		<H1>Additional Services</H1>

        </td></tr>
        <tr><td class = "roundedBottom" align = "center">
<br /><div align = "left">Below are additional services that will further help you sell your products and services:</div>
  <%showad = False 
        if showad = true then%>
<center><img src = "/uploads/addiscountBannerad775pixels.jpg" border = "0" width = "775" height = "100" Alt = "Advertise online your alpacas" align = "center"/></center>
<% end if %>
<iframe src="/administration/AdminAdvertisingAddFrameSignup.asp?PeopleID=<%=PeopleID%>" frameborder =0 width = "920" height = "400" scrolling = "no" bgcolor ="#FDF4DD" align = "center" name="navigate"></iframe> 
<div align = "right"><a href = "/administration/"><img src = 'images/SkipAdditionalServicesArrow.jpg' border = "0" /></a></div>



</td></tr></table>
<br>	    
</td>
	</tr>
</table>	
</td>
	</tr>
</table>


<% End if %>
		
  </td></tr></table>
  </td></tr>
  <tr><td colspan = "2"><table width = "980" border = "0" cellpadding = "0" cellspacing = "0">
  <tr>
  <td width = "180" >   
      <iframe src="logoAdFrame.asp" frameborder =0 width = "180" height = "50" scrolling = "no"  align = "center" name="navigate"></iframe>
      <iframe src="logoAdFrame.asp" frameborder =0 width = "180" height = "50" scrolling = "no"  align = "center" name="navigate"></iframe>
    </td>
    <td width = "400" >   
      <iframe src="BannerAdFrame.asp" frameborder =0 width = "400" height = "100" scrolling = "no"  align = "center" name="navigate"></iframe>
    </td>
  <td width = "400" >   
      <iframe src="BannerAdFrame.asp" frameborder =0 width = "400" height = "100" scrolling = "no"  align = "center" name="navigate"></iframe>
    </td>
    </tr>
    <tr><td height = "18" colspan = "2">&nbsp;</td></tr>
    </table>  
     
       </td>
    </tr>
</table>  
  
  						
<!--#Include virtual="/Footer.asp"-->
</body>
</html>