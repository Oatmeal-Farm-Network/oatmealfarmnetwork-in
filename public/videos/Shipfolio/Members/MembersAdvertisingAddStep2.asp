<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<title>Alpaca Infinity Advertising Membersistration</title>

<meta name="robots" content="nofollow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="revisit-after" content="1"/>
<meta name="Googlebot" content="nofollow"/>






</HEAD>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center" >
<!--#Include file="MembersGlobalVariables.asp"-->
<!--#Include virtual="/Header.asp"--> 
<!--#Include file="MembersSecurityInclude.asp"-->
    <% 
   Current2="Advertising"
   Current3="AlpacasHome" %> 

   <!--#Include file="MembersHeader.asp"-->
   <br /> 


 <!--#Include file="MembersAdvertisingTabsInclude.asp"-->
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
		<H1><div align = "left">Add Advertising</div></H1>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center">
<br />
<%
dim LogoAdCheck(25)

monthcounter =1
while Monthcounter < 13

	LogoAdCheckcount = "LogoAdCheck(" & monthcounter & ")"
	LogoAdCheck(monthcounter)=Request.Form(LogoAdCheckcount )
'response.Write("LogoAdCheck(" & monthcounter & ")=" & LogoAdCheck(monthcounter) & "<br>")
	Monthcounter = Monthcounter +1
Wend

monthcounter =1
while Monthcounter < 13
if LogoAdCheck(monthcounter) = "on" then %>

<%=Month(dateadd("m", monthcounter, now ))  %><%=Year(dateadd("m", monthcounter, now ))  %><br />

<% end if 
		Monthcounter = Monthcounter +1
Wend

%>

 <!--#Include virtual="/Footer.asp"--> 

</BODY>
</HTML>