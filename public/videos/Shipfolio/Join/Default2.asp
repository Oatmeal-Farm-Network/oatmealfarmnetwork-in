<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<% Title= "Join Livestock Of The World"
Description = "Join Livestock Of The World. Livestock Of The World is a network of online community marketplaces for horses, cattle, dogs, donkeys, goats, chickens, turkeys, emus, rabbits, llamas, alpacas, pigs, and sheep."
currenturl = "https://www.LivestockOfTheWorld.com/join/"
Image = "https://www.livestockoftheworld.com/images/Facebookfreemassemail.jpg"
 %>

<title><%=Title %></title>
<META name="description" content="<%=Description %>">
<meta name="author" content="Livestock Of The World">
<link rel="stylesheet" type="text/css" href="/style.css">
<!--#Include Virtual="/GlobalVariables.asp"-->

<meta property="og:locale" content="en_US" />
<meta property="og:type" content="article" />
<meta property="og:title" content="oin Livestock Of The World. ." />
<meta property="og:description" content="Join Livestock Of The World. Livestock Of The World is a network of online community marketplaces for horses, cattle, dogs, donkeys, goats, chickens, turkeys, emus, rabbits, llamas, alpacas, pigs, and sheep." />
<meta property="og:url" content="<%=currenturl %>" />
<meta property="og:site_name" content="Livestock Of The World" />
<meta property="og:image" content="<%=Image %>" />
<meta property="og:image:width" content="550" />
<meta name="twitter:card" content="summary" />
<meta name="twitter:description" content="Join Livestock Of The World. Livestock Of The World is a network of online community marketplaces for horses, cattle, dogs, donkeys, goats, chickens, turkeys, emus, rabbits, llamas, alpacas, pigs, and sheep." />
<meta name="twitter:title" content="Livestock Of The World" />


<link rel="canonical" href="<%=currenturl %>" />


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



<% discount = 0 
showcomplete =False
showvendor= False
showlogoadoffer = False

%>





<a name = "Top"></a>
<table width = "<%=screenwidth%>" cellpadding = 0 cellspacing = 0>
<tr><td class = "body">
<H1>Create Your Account</h1>
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



<% 
if showlogoadoffer =  True then %>
<table width = "<%=screenwidth - 20%>" cellpadding = 1 cellspacing = 1  border = 0 background = "lightbluebackground.jpg">
<tr>
<% if screenwidth > 800 then %>
<td class = "body" rowspan = 2 width = 220>
<img src = "MassEmailsLogo2.jpg" align = "left"  height = 180 />
</td>
<% end if %>
<td class = "body" colspan = 2 >
<% if screenwidth < 801 then %>
<center><img src = "MassEmailsLogo2.jpg" align = "center"  height = 180 /></center>
<% end if %>
<b><h2><center>Free Mass Email!</center></h2></b>
<font color="black" size = 3>Get a free mass email to over 20,000 livestock ranches when you sign up or renew a paid (Vendor, Premium, or Complete) membership.</font><br /><br />
<font color="black" size = 3>To get started, select membership option below:
<br><br>

</td></tr>
</table>
<% if screenwidth > 800 then %>
<table width = "<%=screenwidth - 20%>" cellpadding = 1 cellspacing = 1  border = 0 >
<tr>
<td class = "body2" valign = top align = right>
<b><font color="black" size = 3>Scroll Down to Sign Up!</font></b>
</td>
<td align = left width = 140 >
<img src= "arrowdown.jpg" width = 40 />
</td>
</tr>
</table>
<% else %>

<% end if %>


<% end if %>


<a name="MembershipOptions"></a>

<% if screenwidth > 700 then %>
<table border = "0" leftmargin="0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth %>"   >
<tr bgcolor="#E8B242" height = 50 >
<td width = 5><img src = "/images/px.gif" height = 20 width = 5 alt = "Sell Horses, Goats, Sheep, Cattle"/></td>
<td class = 'body2' align='center'>
<b>Membership Options</b>
<b></b>
</td>
<td rowspan = 1 width = 5></td>
<td class = 'body2' align='center' width = 15%>
<b>Basic</b>
</td>

<% if showvendor= True then%>
<td rowspan = 1 width = 5></td>
<td class = 'body2' align='center' width = 15%>
<b>Vendor</b>
</td>
<% end if %>
<td rowspan = 1 width = 5></td>
<td class = 'body2' align='center' width = 15%>
<b>Premium</b>
</td>
<% if showcomplete = True then %>
<td rowspan = 1 width = 5></td>
<td class = 'body2' align='center' width = 15%>
<b><font size = 4>Complete</font></b>
</td>
<% end if %>
</tr>

<tr height = 40>
<td ></td>
<td class = 'body' ><br />
<font size = 3>Animals Listings will appear on the website for the country you live in (<a href="https://www.livestockofamerica.com" target = "_blank" class=body><font size = 3><b>LivestockOfAmerica.com</b></font></a> or <a href="https://www.livestockofCanada.com" target = "_blank" class=body><font size = 3><b>LivestockOfCanada.com</b></font></a>). </font>
</td>
<% if showcomplete = True then 
  currentrowspan = 15 
  else
  currentrowspan = 13
  end if
  %>
<td rowspan = <%=currentrowspan %> ></td>
<td class = 'body2' align='center'>
<center>
<br /><b>FREE</b><br /><br />
<form action= '/join/SetupAccountfree.asp?Membership=FreeTrial&website=<%=website %>' method = "post"><input type=submit value = "SELECT" class = "regsubmit2" ></form></center>
</td>
<% if showvendor= True then%>
<td rowspan = <%=currentrowspan %> ></td>
<td class = 'body2' align='center'>
<center>
<br /><b>$24 USD / Year</b><br /><br />
<form action= '/join/SetupAccount.asp?Membership=Vendor&website=<%=website %>' method = "post"><input type=submit value = "SELECT" class = "regsubmit2" ></form></center>
</td>
<% end if %>
<td rowspan = <%=currentrowspan %> ></td>
<td class = 'body2' align='center'>
<center>
<br /><b>$98 USD / Year</b><br /><br />
<form action= '/join/SetupAccountPremium.asp?Membership=Premium&website=<%=website %>' method = "post"><input type=submit value = "SELECT" class = "regsubmit2" ></form></center>
</td>
<% if showcomplete = True then %>
<td rowspan = <%=currentrowspan %> ></td>
<td class = 'body2' align='center'>
<center>
<br /><b>$349 USD / Year</b><br /><br />
<form action= '/join/SetupAccount.asp?Membership=Complete&website=<%=website %>' method = "post"><input type=submit value = "SELECT" class = "regsubmit2" ></form></center>
</td>
<% end if %>
</tr>


<tr height = 40>
<td ></td>
<td class = 'body' >

</td>
<td class = 'body' valign ="top"><blockquote><font color="#343434">
A fine plan if you are a student or you just want to give us a try.</font></blockquote>
</td>
<% if showvendor= True then%>
<td class = 'body' valign ="top"><blockquote><font color="#343434">
If you just want to offer products for sale then this is the option for you.</font></blockquote>
</td>
<% end if %>
<td class = 'body' valign ="top"><blockquote><font color="#303030">
A good plan if you want consistent exposure for your animals and products.</font></blockquote>
</td>
<%  if showcomplete = True then %>
<td class = 'body' valign ="top"><blockquote><font color="#303030">
An outstanding option for a serious farm business, if you want the most exposure.</font></blockquote>
</td>
<% end if %>
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
<% if showvendor= True then%>
<td class = 'body2' align='center'>
0
</td>
<% end if %>
<td class = 'body2' align='center'>
Unlimited
</td>
<%  if showcomplete = True then %>
<td class = 'body2' align='center'>
<b>Unlimited</b>
<% end if %>
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
<% if showvendor= True then%>
<td class = 'body2' align='center'>
N/A
</td>
<% end if %>
<td class = 'body2' align='center'>
16
</td>
<%  if showcomplete = True then %>
<td class = 'body2' align='center'>
<b>16</b>
</td>
<% end if %>
</tr>



<tr height = 40 bgcolor = "#EBEBEB">
<td ></td>
<td class = 'body' >
<b>Animal Mega-Classified Video Upload</b>
</td>
<td class = 'body2' align='center'>
No
</td>
<% if showvendor= True then%>
<td class = 'body2' align='center'>
N/A
</td>
<% end if %>
<td class = 'body2' align='center'>
Yes
</td>
<%  if showcomplete = True then %>
<td class = 'body2' align='center'>
<b>Yes</b>
</td>
<% end if %>
</tr>

<tr height = 40 >
<td ></td>
<td class = 'body' >
<b>Product Mega-Classifieds.</b> List your products for sale with photos, descriptions, pricing, and more.
</td>
<td class = 'body2' align='center'>
3
</td>
<% if showvendor= True then%>
<td class = 'body2' align='center'>
Unlimited
</td>
<% end if %>
<td class = 'body2' align='center'>
Unlimited
</td>
<%  if showcomplete = True then %>
<td class = 'body2' align='center'>
<b>Unlimited</b>
</td>
<% end if %>
</tr>

<tr  height = 40 bgcolor = "#EBEBEB">
<td ></td>
<td class = 'body' >
<b>Photos per Product Mega-Classified</b>
</td>
<td class = 'body2' align='center'>
8
</td>
<% if showvendor= True then%>
<td class = 'body2' align='center'>
8
</td>
<% end if %>
<td class = 'body2' align='center'>
8
</td>
<%  if showcomplete = True then %>
<td class = 'body2' align='center'>
<b>8</b>
</td>
<% end if %>
</tr>

<tr height = 40 >
<td ></td>
<td class = 'body' >
<b>List Your Services</b><br>
</td>
<td class = 'body2' align='center'>
Yes
</td>
<% if showvendor= True then%>
<td class = 'body2' align='center'>
Yes
</td>
<% end if %>
<td class = 'body2' align='center'>
Yes
</td>
<%  if showcomplete = True then %>
<td class = 'body2' align='center'>
<b>Yes</b>
</td>
<% end if %>
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
<% if showvendor= True then%>
<td class = 'body2' align='center'>
Yes
</td>
<% end if %>
<td class = 'body2' align='center'>
Yes
</td>
<%  if showcomplete = True then %>
<td class = 'body2' align='center'>
<b>Yes</b>
</td>
<% end if %>
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
<% if showvendor= True then%>
<td class = 'body2' align='center'>
Yes
</td>
<% end if %>
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
<font color="black">A 200 px x 200 px ad that randomly appear on many pages throughout the community site(s).<br />
<br />
</td>
<td class = 'body2' align='center'>
No
</td>
<td class = 'body2' align='center'>
Yes
</td>
<% if showvendor= True then%>
<td class = 'body2' align='center'>
Yes
</td>
<% end if %>
<%  if showcomplete = True then %>
<td class = 'body2' align='center'>
<b>Yes</b>
</td>
<% end if %>
</tr>
<% end if %>


<%  if showcomplete = True then %>
<tr height = 40 >
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
<% if showvendor= True then%>
<td class = 'body2' align='center'>
Yes
</td>
<% end if %>
<%  if showcomplete = True then %>
<td class = 'body2' align='center'>
<b>Yes</b>
</td>
<% end if %>
</tr>
<% end if %>




<% if showlogoadoffer = True then %>
<tr height = 40 bgcolor = "#EBEBEB">
<td ></td>
<td class = 'body' >
<b>Free Mass email</b><br>
A professionally design Mass email created and sent to our list of over 20,000 ranches (includes an hour of graphic design time). <b>Worth over $300!</b>
<br /><a href="CustomWebsite.asp" class = body><div align = right>Learn More...<img src= "/images/px.gif"  height = 1 width = 10/></div></a><br />
</td>
<td class = 'body2' align='center'>
No
</td>
<% if showvendor= True then%>
<td class = 'body2' align='center'>
Yes
</td>
<% end if %>
<td class = 'body2' align='center'>
Yes
</td>
<td class = 'body2' align='center'>
<b>Yes</b>
</td>
</tr>

<% end if %>


<%  if showcomplete = True then %>
<tr height = 40  >
<td ></td>
<td class = 'body' >
<b>Custom-Built Website</b><br>
We will create for you a professionally-built custom website that is responsive and search-engine friendly. Website design, hosting, and email are included.
<br /><a href="CustomWebsite.asp" class = body><div align = right>Learn More...<img src= "/images/px.gif"  height = 1 width = 10/></div></a><br />
</td>
<td class = 'body2' align='center'>
No
</td>
<% if showvendor= True then%>
<td class = 'body2' align='center'>
No
</td>
<% end if %>
<td class = 'body2' align='center'>
No
</td>
<td class = 'body2' align='center'>
<b>Yes</b>
</td>
</tr>



<tr height = 40  bgcolor = "#EBEBEB" >
<td ></td>
<td class = 'body' >
<b>We Will Enter Your Information for You!</b><br>
We will provide assistance migrating your existing content, includes up to 50 animals/products from available sales information listed on another website. One-time upload (does not include ongoing updates).
</td>
<td class = 'body2' align='center'>
<center>
<br />No<br /><br>
</td>
<% if showvendor= True then%>
<td class = 'body2' align='center'>
<center>
<br />No<br /><br>

</td>
<% end if %>
<td class = 'body2' align='center'>
<center>
<br />No<br /><br>

</td>
<td class = 'body2' align='center'>
<center>
<br /><b>Yes</b><br /><br>

</td>
</tr>
<% end if %>






<tr height = 40  >
<td ></td>
<td class = 'body' >
</td>
<td class = 'body2' align='center'>
<center>
<br><b>FREE</b><br><br />
<form action= '/SetupAccount.asp?Membership=FreeTrial&website=<%=website %>' method = "post"><input type=submit value = "SELECT" class = "regsubmit2" ></form></center>
</td>
<% if showvendor= True then%>
<td class = 'body2' align='center'>
<center>
<br><b>$24 USD / Year</b><br><br />
<form action= '/SetupAccount.asp?Membership=Vendor&website=<%=website %>' method = "post"><input type=submit value = "SELECT" class = "regsubmit2" ></form></center>
</td>
<% end if %>
<td class = 'body2' align='center'>
<center>
<br /><b>$98 USD / Year</b><br /><br>
<form action= '/SetupAccount.asp?Membership=Premium&website=<%=website %>' method = "post"><input type=submit value = "SELECT" class = "regsubmit2" ></form></center>
</td>
<% if showcomplete = True then %>
<td class = 'body2' align='center'>
<center>
<br /><b>$349 USD / Year</b><br /><br>
<form action= '/SetupAccount.asp?Membership=Complete&website=<%=website %>' method = "post"><input type=submit value = "SELECT" class = "regsubmit2" ></form></center>
</td>
</tr>
<% end if %>
<tr>
<td ></td>
<td colspan = 9 class = body bgcolor = "#EBEBEB">
<br />
<% if discount > 0 then %>
<h3>Save 20% with Coupon Code "ID2017"</h3>
<b>You will have the chance to enter a coupon code later through the signup process.</b>
<br /><br />
<% end if %>


<% if showlogoadoffer =  True then %>
<table width = "<%=screenwidth - 20%>" cellpadding = 1 cellspacing = 1  border = 0>
<tr>
<% if screenwidth > 800 then %>
<td class = "body" rowspan = 2 width = 220>
<img src = "LOTWGiveLogo.jpg" align = "left"  height = 180 />
</td>
<% end if %>
<td class = "body" colspan = 2>
<% if screenwidth < 801 then %>
<center><img src = "LOTWGiveLogo.jpg" align = "center"  height = 180 /></center>
<% end if %>
<b><h2><center>LOTW Supports Livestock Associations</center></h2></b>
<font color="black" size = 3>We will donate 15% of your membership payment to the livestock association of your choice. It costs you (and the association) nothing extra, but you get to do a world of good. </font><a href = "/Associations/" class = "body"><font size = 3>Click here learn more.</font></a><br /><br />
<font color="black" size = 3>To get started, select membership option below:
<br><br>

</td></tr>


</tr>
</table>
<% end if %>


<h2>The Low Annual Price Covers It All</h2>
There are no time limitations on how long animal and product listings run. There are no hidden costs and no commissions on sales. You can add, change, or eliminate information on your listings at any time. <br><br />
</td></tr>
<% if showcomplete = True then %>
<tr><td colspan = 9>
<table>
<tr>
<% if screenwidth > 800 then %>
<td class = "body" rowspan = 2 width = 390>
<img src = "WebsiteSquare.jpg" align = "left" width = 390 height = 296 />
</td>
<% end if %>
<td class = "body" colspan = 2>
<% if screenwidth < 801 then %>
<img src = "WebsiteSquare.jpg" align = "center" width = 390 height = 296 />
<% end if %>
<a name="Customwebsite"></a>
<b><h2><center>Get a Custom-Built Website with a Complete Membership!</center></h2></b>
<font color="black" size = 3>Get a complete and profession website presence with a custom-build website designed to fit your needs with your Livestock of The World Complete membership.
<ul>
<li>Custom graphic design.</li>
<li>Online store with cart and PayPal checkout.</li>
<li>Optimized for search engines.</li>
<li>Use your own domain.</li>
<li>Updates automatically to your Livestock Of the World account.</li>
<li>Hosting & email included.</li>
</ul>
<a href="CustomWebsite.asp"><div align = right>Learn More...<img src= "/images/px.gif"  height = 1 width = 100/></div></a>
<br><br>
</font>
</td></tr>
<% end if %>
</table>

<% else %>
<table cellpadding = 0 cellspacing = 0 border = 0 width = <%=screenwidth - 20 %>>
<tr><td height = 1 bgcolor = black></td></tr>
<tr>
<td class = body><br />
<font size = 3>Animals Listings will appear on the website for the country you live in (<a href="https://www.livestockofamerica.com" target = "_blank" class=body><font size = 3><b>LivestockOfAmerica.com</b></font></a> or <a href="https://www.livestockofCanada.com" target = "_blank" class=body><font size = 3><b>LivestockOfCanada.com</b></font></a>)</font></a>. </font>
<br /><br />
</td>
</tr>
<tr><td height = 1 bgcolor = black></td></tr>
<tr>
<td class = "body">
<br />
<h2><center>Basic Membership<center></h2>
<center><b>FREE</b></center>
3 animal listings with 1 photo each, 3 product listings, and ranch site.<br />
<form action= '/SetupAccount.asp?Membership=FreeTrial&website=<%=website %>&Screenwidth=<%=Screenwidth %>' method = "post"><center><input type=submit value = "SELECT" class = "regsubmit2" ></center></form>
<br><br>


<h2><center>Vendor Membership</center></h2>
<b><center>$24 USD / Year</b></center>
Unlimited product listings, and ranch site.<br />
<form action= '/SetupAccount.asp?Membership=Vendor&website=<%=website %>&Screenwidth=<%=Screenwidth %>' method = "post"><center><input type=submit value = "SELECT" class = "regsubmit2" ></center></form></center>

<br><br>

<h2><center>Premium Membership</center></h2>
<center><br /><b>$98 USD / Year</b><br /></center>
Get a 200 px x 200 px ad that runs until the end of December 2017. Unlimited animal listings with 16 photos each, unlimited product listings, a ranch profile, and your animamls featured on our home page.
<br /><br />

<form action= '/SetupAccount.asp?Membership=Premium&website=<%=website %>&Screenwidth=<%=Screenwidth %>' method = "post"><center><input type=submit value = "SELECT" class = "regsubmit2" ></center></form>
<br><br />
<% if showcomplete = True then %>
<h2><center>Complete Membership</center></h2>
<center><br /><b>$349 USD / Year</b><br /></center>
We will create for you a professionally-built custom website that is responsive and search-engine friendly. Website design, hosting, and email are included. <a href="CustomWebsite.asp" class = "body">Learn More...</a><br /><br />

Plus, get a 200 px x 200 px ad that runs for 12 months. Unlimited animal listings with 16 photos each, unlimited product listings, a ranch profile, and your animamls featured on our home page.<br /><br />

<b>We Will Enter Your Information for You!</b><br>
We will provide assistance migrating your existing content, includes up to 50 animals/products from available sales information listed on another website. One-time upload (does not include ongoing updates)

<form action= '/SetupAccount.asp?Membership=Premium&website=<%=website %>&Screenwidth=<%=Screenwidth %>' method = "post"><center><input type=submit value = "SELECT" class = "regsubmit2" ></center></form>
<br><br />
<% end if %>



<big>The Livestock Of The World Family of Marketplace Websites currently includes:</big>
   <ul>
<li><a href = "https://www.LivestockOfAmerica.com" class = "body" target = "_blank"><big>Livestock Of America</big> </a></li>
<li><a href = "https://www.LivestockOfCanada.com" class = "body" target = "_blank"><big>Livestock Of Canada</big> </a></li>

</ul>
<big>You can list your animals only on the marketplace website for the country you do business in</big>. If we do not have a marketplace for your country yet, we are sorry. Please <a href = "/contactus.asp" class = body>Contact Us</a> and let us know where your business is and we will keep you informed on when a website for your area will be available.
<br>

<h2>The Low Annual Price Covers It All</h2>
There are no time limitations on how long animal and product listings run. There are no hidden costs and no commissions on sales. You can add, change, or eliminate information on your listings at any time. <br><br />




</td></tr>
</table>
<% end if %>
<!--#Include virtual="/Footer.asp"-->