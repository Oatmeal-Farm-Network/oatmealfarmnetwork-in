<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<link rel="stylesheet" type="text/css" href="/style.css" />
<!--#Include file="AdminGlobalVariables.asp"-->
</HEAD>
<% if mobiledevice = True  then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
<% end if %>
<!--#Include virtual="/Header.asp"--> 

    <% 
   Current2="AlpacasHome"
   Current3="Reports" %> 

   <!--#Include virtual="/adminHeader.asp"-->
<br />
<!--#Include file="AdminAnimalsTabsInclude.asp"-->
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
		<H1><div align = "left">Reports</div></H1>
        </td></tr>
        <tr><td class = "roundedBottom body" align = "center" width = "920" valign = "top" height = "300">
<table align = "left"><tr><td class = "body" align = "left">
Select the links below to create printable reports:
<br>
<a href = "ReportSaleList.asp" class= "body" target = "blank" >Printable Sales List</a><br />
<a href = "ReportAnimalSalesPage.asp" class= "body" >Printable Individual Sales Page</a>
</td></tr></table>
 <!--#Include virtual="/Footer.asp"-->  </Body>
</HTML>