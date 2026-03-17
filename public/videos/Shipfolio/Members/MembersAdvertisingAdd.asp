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
     <% 
   Current2="Advertising"
   Current3="AddAdvertising" %> 
<!--#Include file="MembersGlobalvariables.asp"-->
<% Current2 = "SiteMembers" 
Current3 = "SiteMembersHome" %> 
<!--#Include file="MembersHeader.asp"-->
<% If not rs.State = adStateClosed Then
rs.close
End If   	
%>
<!--#Include file="SiteMembersTabsInclude.asp"-->
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
		<H1><div align = "left">Add Additional Services</div></H1>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center">
<br />
  <% showad = False 
if showad = true then%>
<center><img src = "/uploads/addiscountBannerad775pixels.jpg" border = "0" width = "775" height = "100" Alt = "Advertise online your alpacas" align = "center"/></center>
<% end if %>
<iframe src="/Membersistration/MembersAdvertisingAddFrame.asp?PeopleID=<%=PeopleID%>" frameborder =0 width = "920" height = "820" scrolling = "no" bgcolor ="#FDF4DD" align = "center" name="navigate"></iframe> 
<% if Session("firstTime") = True then %>
<div align = "right"><a href = "/Membersistration/"><img src = '/images/SkipAdditionalServicesArrow.jpg' border = "0" /></a></div>
<% end if %>

</td></tr></table>

 <!--#Include virtual="/Footer.asp"--> 

</BODY>
</HTML>