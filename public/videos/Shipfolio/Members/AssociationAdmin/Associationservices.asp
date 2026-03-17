<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>

<!--#Include virtual="/includefiles/GlobalVariables.asp"-->


</HEAD>
<% if mobiledevice = True or is_iPad = true then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<% end if %>
<% 
Current1 = "AssociationHome"
Current2 = "AssociationServices" %> 
<!--#Include file="AssociationHeader.asp"-->


<table width = <%=screenwidth-20 %> align = center cellpadding = 0 cellspacing = 0>
<tr><td class = "body" colspan =2>
<h1>Association Services</h1>
<img src = "Associationadminheader.jpg" width = 100% /><br /><br />
Our goal is to help livestock industries suceed and working with livestock associations (Registrars and clubs) is an important part of that.<br />

<h2>Current Association Services</h2>
<blockquote><h3>Free Directory Listing</h3>
Register your association with Livestock Of the World and your organization will be included in our online directory of associations at <a href="http://www.livestockoftheworld.com/AssociationDirectory/" target = "_blank" class = body>www.LivestockOfTheWorld.com/AssociationDirectory/</a>. It is completely free and there is no 
obligation.<br /><br />



<br />
</blockquote>
<h2>Future Services</h2>
Currently, we are planning on offering in the future:
<ul><li>Free event registration.</li>
<li>Free association websites.</li>

</ul>
<br /><br />
If you are interested in any of our services for your association please <a href="/Contactus.asp" class = "body" target = "_blank">Contact Us</a>.
<br />
</td>
</tr>
</table>

<blockquote>



 <!--#Include virtual="/associationadmin/associationFooter.asp"-->
</body></html>