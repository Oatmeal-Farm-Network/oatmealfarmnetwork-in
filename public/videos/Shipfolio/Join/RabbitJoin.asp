<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Join Livestock Of The World</title>
<META name="description" content="Join Livestock Of The World. Livestock Of The World is a network of online community marketplaces for horses, cattle, dogs, donkeys, goats, chickens, turkeys, emus, rabbits, llamas, alpacas, pigs, and sheep.">
<meta name="author" content="Livestock Of The World">
<link rel="stylesheet" type="text/css" href="/style.css">
<!--#Include Virtual="/GlobalVariables.asp"-->
<meta http-equiv="Content-Language" content="en-us">
<% website = request.querystring("website") %>
</head>
<% if mobiledevice = True or is_iPad = true then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth + '&website=<%=website %>');" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<% end if%>

<% Current = "WebDesign" %>

<!--#Include virtual="/Header.asp"--> 
<% Current2 = "Testimonials" 
Current3="Register" %>
<% if screenwidth > 700 then %>
<!--#Include virtual="/Join/JoinHeader.asp"--> 
<% end if %>

<table width = "<%=screenwidth%>" cellpadding = 5 cellspacing = 5>
<tr><td class = "body">
<% if screenwidth > 900 then %>
<img src = "RabbitJoin.jpg" width = 350 align = right />
<% end if %>
<H1>Sell your Rabbits and Products</h1>
 
<blockquote>
<h2>February is Rabbit Month</H2>
<big>Get a Premium Membership at a Basic Membership price this month*.</big><br /><br />
<big>The Livestock Of The World Family of Marketplace Websites currently include:</big>
   <ul>
<li><a href = "http://www.LivestockOfAmerica.com" class = "body" target = "_blank"><big>Livestock Of America</big> </a></li>
<li><a href = "http://www.LivestockOfCanada.com" class = "body" target = "_blank"><big>Livestock Of Canada</big> </a></li>
<li><a href = "http://www.LOTWHolidayBazaar.com" class = "body" target = "_blank"><big>LOTW Holiday Bazaar</big> </a></li>
</ul>
<br />
You can list your animals and products only on the marketplace website for the country you do business in (with the exception of the LOTW Holiday Bazaar, which is available to all Premium members). If we do not have a marketplace for your country yet, we are sorry. Please <a href = "/contactus.asp" class = body>Contact Us</a> and let us know where your business is and we will keep you informed on when a website for your area will be available.
<br>
</blockquote>
<br>
<small>* Offer not available with other offers or coupons.</small>
</td></tr></table>

<% showlogoadoffer = false
if showlogoadoffer =  True then %>
<table><tr><td class = "body">
<img src = "/images/FreeLogoadimage.jpg" align = "left" width = "200" hieght = "200" alt = "Free logo ad for your ranch"/>
<b>Free 6-Month Logo Ad with a Premium Membership</b><br>
<font color="black">A 200 px x 200 px ad that runs until the end of April 2017. That's up to <b>6 Months advertising worth over $200!</b> <br /><br />
The ad can be your logo or just about any other image that you want!
<br /><br />
<b>Logo ads are only available if you sign up before November 15!</b> 
<br><br></font>
</td></tr></table>
<% end if %>

<% showholidaybazaaroffer = false
if showholidaybazaaroffer  =  True then %>
<table width = "<%=screenwidth%>" cellpadding = 5 cellspacing = 5>
<tr><td align = center bgcolor = #e6e6e6 height = 1></td></tr>

<tr><td class = "body">
<img src = "/images/LOTWHolidayBazaarLogoFrench.jpg" align = "left" width = "300"  alt = "Online Holiday Bazaar"/>
<big>Sign up for a premium membership and all of your products will also be included in the 2016 Online Holiday Bazaar at <a href="http://www.LOTWHolidayBazaar.com" target= "_blank" class="body"><big>www.LOTWHolidayBazaar.com.</big></a><br /><br />
Back by popular demand we are offering the online holiday bazaar again, but this year it’s better than ever! This year the online Bazaar has its own website at <a href = 'http://www.lotwholidaybazaar.com' class = 'body' target ='_blank'>www.LOTWHolidayBazaar.com</a>. <br />


</td></tr></table>
<% end if %>



<% if screenwidth > 700 then %>
<table border = "0" leftmargin="0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth %>"   >
<tr bgcolor="#E8B242" height = 50 >
<td width = 5><img src = "/images/px.gif" height = 20 width = 5 alt = "Sell Horses, Goats, sheep, cattle"/></td>
<td class = 'body2' align='center'>

<b></b>
</td>
<td rowspan = 1 width = 5></td>
<td class = 'body2' align='center' width = 30%>
<b>Basic Membership</b>
</td>
<td rowspan = 1 width = 5></td>
<td class = 'body2' align='center' width = 30%>
<b>Premium Membership</b>
</td>
</tr>

<tr height = 40>
<td ></td>
<td class = 'body' >

</td>
<td rowspan = 11 ></td>
<td class = 'body2' align='center'>
<center>
<br /><b>$3.00 USD / Year</b><br /><br />
<form action= '/SetupAccount.asp?Membership=Basic&website=<%=website %>' method = "post"><input type=submit value = "SELECT" class = "regsubmit2" ></form></center>
</td>

<td rowspan = 11 ></td>
<td class = 'body2' align='center'>
<center>
<br />Full Price: $48.95 USD / Year<br />
<b>Discount Price: $3.00 USD / Year</b>
<br /><br />
<form action= '/SetupAccount.asp?Membership=PremiumMonth&website=<%=website %>' method = "post"><input type=submit value = "SELECT" class = "regsubmit2" ></form></center>
</td>
</tr>


<tr height = 40>
<td ></td>
<td class = 'body' >

</td>
<td class = 'body' valign ="top"><blockquote><font color="#343434">
This is a fine plan if you are a student or you just want to give a Livestock Of the World website a try.</font></blockquote>
</td>

<td class = 'body' valign ="top"><blockquote><font color="#303030">
This is a great plan if you have a serious farm business and you want the most exposure for all of your animals and products.</font></blockquote>
</td>
</tr>

<tr >
<td ></td>
<td class = 'body' height = 40 >
<b>Number of Animal Listings</b><br />
For sale and / or for stud.
</td>
<td class = 'body2' align='center'>
3
</td>
<td class = 'body2' align='center'>
<b>Unlimited</b>
</td>
</tr>


<tr bgcolor = "#EBEBEB" height = 40>
<td ></td>
<td class = 'body' >
<b>Photos per Animal Listing</b>
</td>
<td class = 'body2' align='center'>
1
</td>
<td class = 'body2' align='center'>
<b>16</b>
</td>
</tr>

<tr height = 40>
<td ></td>
<td class = 'body' >
<b>Animal Listing Video Upload</b>
</td>
<td class = 'body2' align='center'>

</td>
<td class = 'body2' align='center'>
<b>Yes</b>
</td>
</tr>

<tr bgcolor = "#EBEBEB" height = 40>
<td ></td>
<td class = 'body' >
<b>Product Listing</b><br />
</td>
<td class = 'body2' align='center'>
3
</td>
<td class = 'body2' align='center'>
<b>Unlimited</b>
</td>
</tr>


<tr  height = 40>
<td ></td>
<td class = 'body' >
<b>Farm Directory Listing</b><br>
Includes home page, animals for sale, stud listings, products for sale, about us, & contact us pages.<br><br>
</td>
<td class = 'body2' align='center'>
Yes
</td>
<td class = 'body2' align='center'>
<b>Yes</b>
</td>
</tr>

<% showweeklyemails = false
if showweeklyemails = true then %>
<tr bgcolor = "#EBEBEB" height = 40>
<td ></td>
<td class = 'body' >
<b>Included in Weekly Email</b><br>
Take advantage of outstanding sales lead generation with our weekly emails. They go to over 16,000 addresses and that number is growing all the time!<br><br>
</td>
<td class = 'body2' align='center'>

</td>
<td class = 'body2' align='center'>
<b>Yes</b>
</td>
</tr>
<% end if %>

<% if showlogoadoffer = true then %>
<tr height = 40>
<td ></td>
<td class = 'body' >
<b>Free Logo Ad</b><br>
<font color="black">A 200 px x 200 px ad that randomly appear on many pages throughout the community site(s) that you are a member of, until the end of 2016. 
</td>
<td class = 'body2' align='center'>

</td>
<td class = 'body2' align='center'>
<b>Yes</b>
</td>
</tr>
<% end if %>

<tr height = 40 bgcolor = "#EBEBEB">
<td ></td>
<td class = 'body' >
<b>Animals Featured On Home Page</b><br>
Your animals will be randomly featured on the website home page.
<br /><br />
</td>
<td class = 'body2' align='center'>

</td>
<td class = 'body2' align='center'>
<b>Yes</b>
</td>
</tr>





<% if showholidaybazaaroffer = true then %>
<tr height = 40>
<td ></td>
<td class = 'body' >
<b>Included in The Online Holiday Bazaar</b><br>

You receive:
<ul><li>All of your products listed at <a href='http://www.LOTWHolidayBazaar.com' class = 'body' target = '_blank'>www.LOTWHolidayBazaar.com</a>.</li>
<li>Inclusion in weekly mass emails randomly highlighting products.</li>
<li>Free online ads on <a href='http://www.livestockofamerica.com' class = 'body' target = _blank>LivestockOfAmerica.com</a> or <a href='http://www.livestockofamerica.com' class = 'body' target = _blank>LivestockOfCanada.com</a> until the end of the year.</li>
</ul>

</td>
<td class = 'body2' align='center'>

</td>
<td class = 'body2' align='center'>
<b>Yes</b>
</td>
</tr>
<% end if %>


<tr height = 40 bgcolor = "#EBEBEB">
<td ></td>
<td class = 'body' >

</td>
<td class = 'body2' align='center'>
<center>
<br><b>$3.00 USD / Year</b><br><br />
<form action= '/SetupAccount.asp?Membership=Basic&website=<%=website %>' method = "post"><input type=submit value = "SELECT" class = "regsubmit2" ></form></center>
</td>
<td class = 'body2' align='center'>
<center>
<br />Full Price: $48.95 USD / Year<br />
<b>Discount Price: $3.00 USD / Year</b><br />
<form action= '/SetupAccount.asp?Membership=PremiumMonth&website=<%=website %>' method = "post"><input type=submit value = "SELECT" class = "regsubmit2" ></form></center>
</td>
</tr>
<tr>
<td ></td>
<td colspan = 7 class = body>
<br />

<h2>The Low Annual Price Covers It All</h2>
There are no time limitations on how long animal and product listings run.  There are no hidden costs and no commissions on sales. You can add, change, or eliminate information on your listings at any time. <br><br />
</td></tr>
</table>
<% else %>
<table cellpadding = 3 cellspacing = 3 border = 0 width = <%=screenwidth - 20 %>>
<tr>
<td class = "body">

<h2><center>Basic Membership<center></h2>
<center><b>$3.00 USD / Year</b></center>
3 animal listings with 1 photo each, 3 product listings, and ranch site.<br />
<form action= '/SetupAccount.asp?Membership=Basic&website=<%=website %>&Screenwidth=<%=Screenwidth %>' method = "post"><center><input type=submit value = "SELECT" class = "regsubmit2" ></center></form>
<br><br>

<% if showstandard = true then %>
<h2><center>Standard Membership</center></h2>
<b><center>$48.95 USD / Year</b></center>
25 animal listings with 8 photos each, 25 product listings, and ranch site.<br />
<form action= '/SetupAccount.asp?Membership=Standard&website=<%=website %>&Screenwidth=<%=Screenwidth %>' method = "post"><center><input type=submit value = "SELECT" class = "regsubmit2" ></center></form></center>

<br><br>
<% end if %>
<h2><center>Premium Membership</center></h2>
<center><br />Full Price: $48.95 USD / Year<br />
<b>Discount Price: $3.00 USD / Year</b><br /></center>
Unlimited animal listings with 16 photos each, unlimited product listings, a ranch site, inclusion to weekly emails to thousands of livestock ranches.<br />
<form action= '/SetupAccount.asp?Membership=PremiumMonth&website=<%=website %>&Screenwidth=<%=Screenwidth %>' method = "post"><center><input type=submit value = "SELECT" class = "regsubmit2" ></center></form>
<br><br />

<h2>The Low Annual Price Covers It All</h2>
There are no time limitations on how long animal and product listings run. There are no hidden costs and no commissions on sales. You can add, change, or eliminate information on your listings at any time. <br><br />
</td></tr>
</table>
<% end if %>
<!--#Include virtual="/Footer.asp"-->