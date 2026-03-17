<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<% Title= "Join Livestock Of The World"
Description = "Join Livestock Of The World. Livestock Of The World is a network of online community marketplaces for horses, cattle, dogs, donkeys, goats, chickens, turkeys, emus, rabbits, llamas, alpacas, pigs, and sheep."
currenturl = "http://www.LivestockOfTheWorld.com/join/"
Image = "http://www.LivestockOfTheWorld.com/Join/JoinImage.jpg"
 %>

 <title><%=Title %></title>

<META name="description" content="<%=Description %>">
<meta name="author" content="Livestock Of The World">
<link rel="stylesheet" type="text/css" href="/style.css">
<!--#Include Virtual="/GlobalVariables.asp"-->

<meta property="og:locale" content="en_US" />
<meta property="og:type" content="article" />
<meta property="og:title" content="<%=Title %>" />
<meta property="og:description" content="<%=Description %>" />
<meta property="og:url" content="<%=currenturl %>" />
<meta property="og:site_name" content="Livestock Of The World" />
<meta property="og:image" content="<%=Image %>" />
<meta property="og:image:width" content="300" />
<meta name="twitter:card" content="summary" />
<meta name="twitter:description" content="<%=description%>" />
<meta name="twitter:title" content="About <%= Title %>" />


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

<% discount = 0 %>
<table width = "<%=screenwidth%>" cellpadding = 5 cellspacing = 5>
<tr><td class = "body">
<H1>Create Your Account</h1>
<h2>Register To Sell Your Animals & Products</H2>
</td></tr></table>


<% showstarbucksoffer = False
if showstarbucksoffer =  True then %>
<table width = 100%><tr><td class = "body2" valign = bottom>
<img src = "Stabuckscup.jpg" align = "left" height = "120" alt = "Free Starbucks Gift Card"/><br><br>
<b>Free $15 Starbucks Gift Card </b><br>
<font color="black">When You Sign Up or Renew a Premium Membership!</b> <br /><br />
<br /><br />
<br><br></font>
</td></tr></table>
<% end if %>



<% showlogoadoffer = true
if showlogoadoffer =  True then %>
<table width = "<%=screenwidth - 20%>" cellpadding = 1 cellspacing = 1  border = 0>
<tr>
<% if screenwidth > 800 then %>
<td class = "body" rowspan = 2 width = 390>
<img src = "joinfreead.jpg" align = "left" width = 390 height = 296 />
</td>
<% end if %>
<td class = "body" colspan = 2>
<br /><b><h2><center>Free Online Ad with a Premium or Vendor Membership!</center></h2></b><br><br />
<font color="black" size = 3>Get a 200 px x 200 px ad that runs until the end of December 2017. That's up to <b>7 Months advertising worth over $200!</b> <br /><br />
The ad can be your logo or just about any other image that you want.
<br /><br />
The sooner you sign up the more traffic you will get.
<br><br>
</font>
</td></tr>
<% if screenwidth > 800 then %>
<td class = "body2" valign = top align = right>
<b><font color="black" size = 3>Scroll Down to Sign Up!</font></b>
</td>
<td align = left width = 230 >
<img src= "arrowdown.jpg" width = 40 />
</td>
<% else %>

<% end if %>

</tr>
</table>
<% end if %>




<% if screenwidth > 700 then %>
<table border = "0" leftmargin="0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth %>"   >
<tr bgcolor="#E8B242" height = 50 >
<td width = 5><img src = "/images/px.gif" height = 20 width = 5 alt = "Sell Horses, Goats, Sheep, Cattle"/></td>
<td class = 'body2' align='center'>

<b></b>
</td>
<td rowspan = 1 width = 5></td>
<td class = 'body2' align='center' width = 20%>
<b>Basic Membership</b>
</td>
<td rowspan = 1 width = 5></td>
<td class = 'body2' align='center' width = 20%>
<b>Vendor Membership</b>
</td>
<td rowspan = 1 width = 5></td>
<td class = 'body2' align='center' width = 20%>
<b><font size = 4>Premium Membership</font></b>
</td>
</tr>

<tr height = 40>
<td ></td>
<td class = 'body' ><br />
<font size = 3>Animals Listings will appear on the website for the country you live in (<a href="http://www.livestockofamerica.com" target = "_blank" class=body><font size = 3><b>LivestockOfAmerica.com</b></font></a> or <a href="http://www.livestockofCanada.com" target = "_blank" class=body><font size = 3><b>LivestockOfCanada.com</b></font></a>) and all products are shown on <a href="http://www.livestockofamerica.com" class=body target = "_blank"><font size = 3><b>WorldFarmStore.com</b></font></a>. </font>
</td>
<td rowspan = 13 ></td>
<td class = 'body2' align='center'>
<center>
<br /><b>$3.00 USD / Year</b><br /><br />
<form action= '/SetupAccount.asp?Membership=Basic&website=<%=website %>' method = "post"><input type=submit value = "SELECT" class = "regsubmit2" ></form></center>
</td>
<td rowspan = 13 ></td>
<td class = 'body2' align='center'>
<center>
<br /><b>$24.95 USD / Year</b><br /><br />
<form action= '/SetupAccount.asp?Membership=Vendor&website=<%=website %>' method = "post"><input type=submit value = "SELECT" class = "regsubmit2" ></form></center>
</td>
<td rowspan = 13 ></td>
<td class = 'body2' align='center'>
<center>
<br />Full Price: $54.95 USD / Year<br />
<b>Sale Price: $38.47 USD / Year</b>
<br /><br />
<form action= '/SetupAccount.asp?Membership=Premium&website=<%=website %>' method = "post"><input type=submit value = "SELECT" class = "regsubmit2" ></form></center>
</td>
</tr>


<tr height = 40>
<td ></td>
<td class = 'body' >

</td>
<td class = 'body' valign ="top"><blockquote><font color="#343434">
This is a fine plan if you are a student or you just want to give a Livestock Of the World website a try.</font></blockquote>
</td>
<td class = 'body' valign ="top"><blockquote><font color="#343434">
If you just want to offer products for sale then this is the option for you.</font></blockquote>
</td>
<td class = 'body' valign ="top"><blockquote><font color="#303030">
This is a great plan if you have a serious farm business and you want the most exposure for all of your animals and products.</font></blockquote>
</td>
</tr>

<tr bgcolor = "#EBEBEB">
<td ></td>
<td class = 'body'  height = 40 >
<b>Number of Animal Mega-Classifieds</b><br />
Listing your animals for sale and / or for stud. Include photos, a description, pricing, ancestry, breeding information, and much more.<br /><br />
</td>
<td class = 'body2' align='center'>
3
</td>
<td class = 'body2' align='center'>
0
</td>
<td class = 'body2' align='center'>
<b>Unlimited</b>
</td>
</tr>


<tr  height = 40>
<td ></td>
<td class = 'body' >
<b>Photos per Animal Mega-Classified</b>
</td>
<td class = 'body2' align='center'>
1
</td>
<td class = 'body2' align='center'>
N/A
</td>
<td class = 'body2' align='center'>
<b>16</b>
</td>
</tr>



<tr height = 40 bgcolor = "#EBEBEB">
<td ></td>
<td class = 'body' >
<b>Animal Mega-Classified Video Upload</b>
</td>
<td class = 'body2' align='center'>
No
</td>
<td class = 'body2' align='center'>
N/A
</td>
<td class = 'body2' align='center'>
<b>Yes</b>
</td>
</tr>

<tr height = 40 >
<td ></td>
<td class = 'body' >
<b>Product Mega-Classified (on <a href="http://www.worldfarmstore.com" class = "body" target = "blank">WorldFarmStore.com</a>)</b><br />
List your products for sale with photos, descriptions, pricing, and more.
</td>
<td class = 'body2' align='center'>
3
</td>
<td class = 'body2' align='center'>
Unlimited
</td>
<td class = 'body2' align='center'>
<b>Unlimited</b>
</td>
</tr>

<tr  height = 40 bgcolor = "#EBEBEB">
<td ></td>
<td class = 'body' >
<b>Photos per Product Mega-Classified</b>
</td>
<td class = 'body2' align='center'>
8
</td>
<td class = 'body2' align='center'>
8
</td>
<td class = 'body2' align='center'>
<b>8</b>
</td>
</tr>

<tr height = 40 >
<td ></td>
<td class = 'body' >
<b>List Your Services</b><br>
</td>
<td class = 'body2' align='center'>
Yes
</td>
<td class = 'body2' align='center'>
Yes
</td>
<td class = 'body2' align='center'>
<b>Yes</b>
</td>
</tr>


<tr height = 40 bgcolor = "#EBEBEB">
<td ></td>
<td class = 'body' >
<b>Ranch Profile</b><br>
Includes home page, animals for sale, stud listings, products for sale, about us, & contact us pages.<br><br>
</td>
<td class = 'body2' align='center'>
Yes
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
<tr height = 40 >
<td ></td>
<td class = 'body' >
<b>Free Logo Ad</b><br>
<font color="black">A 200 px x 200 px ad that randomly appear on many pages throughout the community site(s) that you are a member of, until the end of December 2017.<br />
<br />
</td>
<td class = 'body2' align='center'>
No
</td>
<td class = 'body2' align='center'>
Yes
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
No
</td>
<td class = 'body2' align='center'>
N/A
</td>
<td class = 'body2' align='center'>
<b>Yes</b>
</td>
</tr>


<% freedataentry = false 
if freedataentry = true then %>
<tr height = 40 >
<td ></td>
<td class = 'body' >
<b>We Will Enter Your Information for You!</b><br>
We will provide assistance migrating your existing content, includes up to 20 animals/products from available sales information listed on another website. One-time upload (does not include ongoing updates).
<br /><br />
</td>
<td class = 'body2' align='center'>
No
</td>
<td class = 'body2' align='center'>
Yes
</td>
<td class = 'body2' align='center'>
<b>Yes</b>
</td>
</tr>
<tr height = 40 bgcolor = "#EBEBEB" >
<% else %>
<tr height = 40  >

<% end if %>



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
<br><b>$24.95 USD / Year</b><br><br />
<form action= '/SetupAccount.asp?Membership=Vendor&website=<%=website %>' method = "post"><input type=submit value = "SELECT" class = "regsubmit2" ></form></center>
</td>
<td class = 'body2' align='center'>
<center>
<br><br />Full Price: $54.95 USD / Year<br />
<b>Sale Price: $38.47 USD / Year</b><br />
<form action= '/SetupAccount.asp?Membership=Premium&website=<%=website %>' method = "post"><input type=submit value = "SELECT" class = "regsubmit2" ></form></center>
</td>
</tr>
<tr bgcolor = "#EBEBEB">
<td ></td>
<td colspan = 7 class = body>
<br />
<% if discount > 0 then %>
<h3>Save 20% with Coupon Code "ID2017"</h3>
<b>You will have the chance to enter a coupon code later through the signup process.</b>
<br /><br />
<% end if %>

<h2>The Low Annual Price Covers It All</h2>
There are no time limitations on how long animal and product listings run. There are no hidden costs and no commissions on sales. You can add, change, or eliminate information on your listings at any time. <br><br />
</td></tr>
</table>
<% else %>
<table cellpadding = 0 cellspacing = 0 border = 0 width = <%=screenwidth - 20 %>>
<tr><td height = 1 bgcolor = black></td></tr>
<tr>
<td class = body><br />
<font size = 3>Animals Listings will appear on the website for the country you live in (<a href="http://www.livestockofamerica.com" target = "_blank" class=body><font size = 3><b>LivestockOfAmerica.com</b></font></a> or <a href="http://www.livestockofCanada.com" target = "_blank" class=body><font size = 3><b>LivestockOfCanada.com</b></font></a>) and all products are shown on <a href="http://www.livestockofamerica.com" class=body target = "_blank"><font size = 3><b>WorldFarmStore.com</b></font></a>. </font>
<br /><br />
</td>
</tr>
<tr><td height = 1 bgcolor = black></td></tr>
<tr>
<td class = "body">
<br />
<h2><center>Basic Membership<center></h2>
<center><b>$3.00 USD / Year</b></center>
3 animal listings with 1 photo each, 3 product listings, and ranch site.<br />
<form action= '/SetupAccount.asp?Membership=Basic&website=<%=website %>&Screenwidth=<%=Screenwidth %>' method = "post"><center><input type=submit value = "SELECT" class = "regsubmit2" ></center></form>
<br><br>


<h2><center>Vendor Membership</center></h2>
<b><center>$24.95 USD / Year</b></center>
Unlimited product listings, and ranch site.<br />
<form action= '/SetupAccount.asp?Membership=Vendor&website=<%=website %>&Screenwidth=<%=Screenwidth %>' method = "post"><center><input type=submit value = "SELECT" class = "regsubmit2" ></center></form></center>

<br><br>

<h2><center>Premium Membership</center></h2>
<center><br />Full Price: $54.95 USD / Year<br />
<b>Sale Price: $38.47 USD / Year</b></center>
Unlimited animal listings with 16 photos each, unlimited product listings, a ranch website, and we Will Enter Your Information for You!
We will provide assistance migrating your existing content, includes up to 20 animals/products from available sales information listed on another website. One-time upload (does not include ongoing updates).<br />


<form action= '/SetupAccount.asp?Membership=Premium&website=<%=website %>&Screenwidth=<%=Screenwidth %>' method = "post"><center><input type=submit value = "SELECT" class = "regsubmit2" ></center></form>
<br><br />

<big>The Livestock Of The World Family of Marketplace Websites currently includes:</big>
   <ul>
<li><a href = "http://www.LivestockOfAmerica.com" class = "body" target = "_blank"><big>Livestock Of America</big> </a></li>
<li><a href = "http://www.LivestockOfCanada.com" class = "body" target = "_blank"><big>Livestock Of Canada</big> </a></li>
<li><a href = "http://www.WorldFarmStore.com" class = "body" target = "_blank"><big>World Farm Storer</big> </a></li>
</ul>
<big>You can list your animals only on the marketplace website for the country you do business in</big> (with the exception of the World farm Store, which includes products for sale from ranches across the globe). If we do not have a marketplace for your country yet, we are sorry. Please <a href = "/contactus.asp" class = body>Contact Us</a> and let us know where your business is and we will keep you informed on when a website for your area will be available.
<br>

<h2>The Low Annual Price Covers It All</h2>
There are no time limitations on how long animal and product listings run. There are no hidden costs and no commissions on sales. You can add, change, or eliminate information on your listings at any time. <br><br />



</td></tr>
</table>
<% end if %>
<!--#Include virtual="/Footer.asp"-->