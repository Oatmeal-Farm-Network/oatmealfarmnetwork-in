<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>

<!--#Include file="MembersGlobalVariables.asp"-->
</HEAD>
<% if mobiledevice = True or is_iPad = true then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<% end if %>
<% 
Current1 = "MembersHome"
Current2 = "Advertising" %> 
<!--#Include file="MembersHeader.asp"-->
<% If not rs.State = adStateClosed Then
rs.close
End If   	

%>
<meta http-equiv="Content-Language" content="en-us">
<style type="text/css">
.blink_text {
-webkit-animation-name: blinker;
-webkit-animation-duration: 2s;
-webkit-animation-timing-function: linear;
-webkit-animation-iteration-count: infinite;

-moz-animation-name: blinker;
-moz-animation-duration: 2s;
-moz-animation-timing-function: linear;
-moz-animation-iteration-count: infinite;

 animation-name: blinker;
 animation-duration: 2s;
 animation-timing-function: linear;
 animation-iteration-count: infinite;

 color: green;
}

@-moz-keyframes blinker {  
 0% { opacity: 1.0; }
 50% { opacity: 0.2; }
 100% { opacity: 1.0; }
 }

@-webkit-keyframes blinker {  
 0% { opacity: 1.0; }
 50% { opacity: 0.2; }
 100% { opacity: 1.0; }
 }

@keyframes blinker {  
 0% { opacity: 1.0; }
 50% { opacity: 0.2; }
 100% { opacity: 1.0; }
 }
 </style>

<% if session("Goats") = True then
'response.redirect("GoatJoin.asp")
end if
sale = false
discount =0 'percent
AdDiscount = 0
Current = "Home" 
Current3 = "JoinLOA"
RPI = request.querystring("RPI") %>

<br />
<% centerwidth = screenwidth 
tablewidth = screenwidth - 320 
 Colwidth =(screenwidth -350)/2 %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth -22%>"  class = "body" >
<tr><td class = 'body' colspan = 2 valign = "top">
<a name = "advertising"></a><h1>Advertise with Livestock Of The World</h1></td></tr>
<tr><td bgcolor = "black" height = "1"></td></tr>
<tr><td class = "body2" align = center><div align = left>Reach buyers with focused advertising on Livestock Of the World's community websites.<br /><br />
<big>Call us at 541.879.1877 or email us at <a href = "mailto:Contactus@livestockoftheworld.com" class = body><big>Contactus@livestockoftheworld.com</big></a> to learn more.</big></div><br /><br />
<h2>Advertising Rates Summary</h2>
<font size = 3 color = "E0482B"><br /><br />

<table border = 0 align = "center">
<tr>
<td class= "body2" align = center width = "250"><b>Ad Type</b></td>
<td class= "body2" align = center ><b>Where Shown</b></td>
<td class= "body2" align = center colspan = 4><b>Prices Per Month per Community</b></td>
</tr>


<tr bgcolor = "#e6e6e6"><td class= "body" ><a href="#banner" class= "body">Logo Ads</a></td>
<td class= "body" ><small>Every page except ranch pages.<br />200 pixels wide x 200 pixels high.</small></td>
<td class= "body2" align = "center" ><b>$100</b></td>
</tr>


<tr height = "40" ><td class= "body" ><a href="#breed" class= "body">Breed Ads</a></td>
<td class= "body" ><small>Every page for a specific breed.
<br />200 pixels wide x 200 pixels high</small></td>
<td class= "body2" align = "center" >$50</td>
</tr>




<tr height = "40" ><td class= "body2" valign = "top" colspan = 6 align = 'center'>
<a href="/contactus.asp"><big><b>Contact Us</b></big></a><b><big> today to get started.</big></b>

</td>
</tr>
</table>
<br />


<div align = left>
<br /><b>Learn more about our advertising options below:</b><br /></div>


</td>
</tr>
<tr><td class = "body" colspan = 3>
<table cellspadding = 0 cellspacing =0 width = <%=screenwidth -40 %>>
<tr><td colspan = 3>
<h2>Banner Ads</h2></td></tr>
<tr><td bgcolor = "black" height= 1 colpsan = 3></td></tr>
<tr><td class = "body" colspan = "3">
Banner ads randomly appear at the top of almost every page.<br />
400 pixels wide x 100 pixels high - linked to any web page you wish.<br />
<br />
Example:<br />
 <img src ="/uploads/205940MayhemfarmBanner.jpg" border = "0" height = "120" width = "480" /> <br />
 <br />
 <b>Add animation to your ad for only $65 more!</b><br />
<img src = "/join/animateadsx.gif" width= 481 height = 112 /><br />
 
 <br /><br />
</td></tr>
<tr><td class = "body" colpsan = 2><a name= "breed"></a>
<h2>Breed Ads</font></h2></td></tr>
<tr><td bgcolor = "black" height= 1 colpsan = 2></td></tr>
<tr><td class = "body" colpsan = 2>

Breed ads focus your marketing towards the ranchers in your specific industry. Your ads will appear on the right side of each page that is focused on your breed. <br /><br />


200 pixels wide x 200 pixels high - linked to any web page you wish.<br />
Example:<br />
<img src ="/uploads/20726surisofthesangresad.jpg" border = "0" height = "200" width = "200" />

<br />
<big>Call us at 541.879.1877 or email us at <a href = "mailto:Contactus@livestockoftheworld.com" class = body><big>Contactus@livestockoftheworld.com</big></a> to learn more.</big>

<br /><br />







</td></tr></table>
<br />
<a name = "adexchange"></a>
<img src = "/images/Adexchange.jpg" width = 328 height = 157 align = "center" /><br>
Do you need to advertise your organization or business and you offer advertising as well? We will be happy to exchange advertising on Livestock Of America for advertising on your website or newsletter. Call us at 541.879.1877 or email us at <a href = "mailto:Contactus@livestockoftheworld.com" class = body>Contactus@livestockoftheworld.com</a> to learn more.
<br /><br /><br />
<big>Call us at 541.879.1877 or email us at <a href = "mailto:Contactus@livestockoftheworld.com" class = body><big>Contactus@livestockoftheworld.com</big></a> to learn more.</big></div><br /><br />
</td></tr></table>

<!--#Include file="membersFooter.asp"-->
</body>
</html>