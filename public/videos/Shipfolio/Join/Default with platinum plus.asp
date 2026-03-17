<!DOCTYPE HTML>
<html>
<head>
<%  PageLayoutId = 38 %>
<!--#Include virtual="/GlobalVariables.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta http-equiv="Content-Language" content="en-us">
<title><%= SEOTitle %> </title>
<META name="description" content="<%= SEODescription %> ">
<meta name="robots" content="index,follow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="revisit-after" content="1"/>
<meta name="Googlebot" content="index,follow"/>
<meta name="robots" content="All"/>
<link rel="stylesheet" type="text/css" href="/style.css" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
</head>
<% if mobiledevice = True  then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<% end if %>
 <% Current = "Subscribe" %>
<% CurrentWebsite = "Camelid Quarterly" %>
<!--#Include virtual = "/Header.asp"-->
<!--#Include virtual = "/AnimalsHeader.asp"-->

<% 
sale = false
discount =75 'percent
AdDiscount = 0
Current3 = "JoinLOA"
RPI = request.querystring("RPI") %>

<br />
<% showWebsite = True %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth-30%>" >
<tr><td valign = "top" align = "center">
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth-30%>"  class = "body2" >
<tr><td class = 'body' colspan = 2 valign = "top">

<a name = "memberships"></a>
<img src="JoinpageImage.jpg" width = '288' height = "288" align = "right" /><H1><div align = "left">Subscribe to CQ Online</div></H1>

We’re more than just another pretty face!<br /><br />

<font color = "E04A2B"><b>CQ</b></font> has over 475 contributing authors, including scientists, researchers, veterinarians and breeders, who consistently provide our readers with informative and timely editorial.<br /><br />

<font color = "E04A2B"><b>CQ</b></font> has published over 1,500 articles since its premier issue in March 2002 – all available to subscribers 24/7 in our on-line Library.<br /><br />

<font color = "E04A2B"><b>CQ</b></font> editorial subject matter covers the entire camelid spectrum, with emphasis on alpacas and llamas. Approximately 75% of the total editorial content is of interest to all camelid breeders.<br /><br />

<font color = "E04A2B"><b>CQ</b></font> has subscribers in over 35 countries world-wide with an expanding readership unparalleled in the industry.<br /><br />

<font color = "E04A2B"><b>CQ</b></font> is THE Magazine for the Serious Camelid Breeder and has been rated as the Best Camelid Specific Magazine of its kind!<br /><br />

<br />


<center><form action= '/join/setupaccount.asp?Membership=Online' method = "post"><input type=submit value = " Subscribe Online - Only $25/Year! " class = "regsubmit2" style="font-size : 19px; "></form></center>
<br />
<b><big>Already a Subscriber?</big></b><br />
<a href = "/Members/MembersLogin.asp" class = "body"><b><big>Sign into your account</a> to review, renew, or upgrade.</big></b><br /><br />

<b>Notice to all subscribers: the print version (hard copy) of CQ will only be available up to and including the December 2016 issue.<br /> To order copies, please <a href = "/ContactUs.asp" class = "body"><b>contact us</b></a> or call 902-832-6131. Quantities are limited.</b>
<br /><br />





<br />
<center>To learn more about Camelid Quarterly call us or use our <a href = "/ContactUs.asp" class = "body"><b>contact page</b></a>.<br />
U.S: 541.879.1877<br />
Canada: 1-902-832-6131<br /><br />
</center>




</td>
</tr>
</table>
</td>
</tr>
</table>

<!--#Include virtual="/Footer.asp"-->