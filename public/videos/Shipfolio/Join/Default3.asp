<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Join Livestock Of America</title>
<META name="description" content="Join Livestock Of America. Livestock Of America is an online marketplace for horses, cattle, dogs, donkeys, goats, chickens, turkeys, rabbits, llamas, alpacas, pigs, and sheep.">
<meta name="author" content="Livestock of America">
<link rel="stylesheet" type="text/css" href="/style.css">
<!--#Include Virtual="/GlobalVariables.asp"-->
<meta http-equiv="Content-Language" content="en-us">
</head>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   >
<% if session("Goats") = True then
response.redirect("GoatJoin.asp")
end if
sale = True
discount =20 'percent

Current = "Home" 
Current3 = "JoinLOA"
RPI = request.querystring("RPI") %>
<!--#Include virtual="/Header.asp"--> 
<!--#Include virtual="/AnimalsHeader.asp"-->
<!--#Include virtual="/AboutusTabsInclude.asp"-->
<% centerwidth = screenwidth 
tablewidth = screenwidth - 320 
 Colwidth =(screenwidth -350)/2 %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth %>"  class = "body roundedtopandbottom" >
<tr><td class = 'body' colspan = 2 valign = "top">
<img src = "/images/MemorialDaySalejoinPageAd.jpg" width = "980' height = "129" align = "center"/>
<br /><br />
</td></tr>
<tr><td align = "left" valign = "top" colspan = "2">
<a href = "#memberships" class = "body">Livetock Of America Memberships</a>|<a href = "#advertising" class = "body">Custom Website Design</a>|<a href = "#websites" class = "body">Advertising</a>

<table border = "0" cellspacing="0" cellpadding = "0" align = "left" width = "480" >
<td width = "<%=centerwidth %>"  class = "body roundedtopandbottom" valign = "top"><br><a name = "memberships"></a>
<H1><div align = "left">Livestock Of America Memberships</div></H1>
We offer a wide range of memberships. Please look through the many choices below and select a membership that works best for you:<br>
<br>
<table border="0" cellspacing="0" cellpadding="0" align = "center" class = "roundedtopandbottom">
<tr bgcolor = "green" height = "40">
<th align="left" width = "270"></th>
<th width="90" class = "body2" align = "center"><big><font color="white">Gold</font></big></th>
<th width="140" class = "body2" align = "center"><big><font color="white">Platinum</font></big></th>
</tr>
<tr height = "40" bgcolor = "#dddfdd">
<th align="right" class = "body2" >
<b>Price</b>
</th>
<th class = "body2" align = "center">Free</th>
<th class = "body2" align = "center"><strike>$98</strike><big>$78.40</big></th>
</tr>

<tr height = "40" ><td></td>
<td class = 'body2' align = "center"><form action= '/setupaccount.asp?Membership=gold&RPI=<%=RPI %>' method = "post"><input type=submit value = " Join Now " class = "regsubmit2" ></form></td>
<td class = 'body2' align = "center"><form action= '/setupaccount.asp?Membership=platinum&RPI=<%=RPI %>' method = "post"><input type=submit value = " Join Now " class = "regsubmit2" ></form></td>
</tr>

<tr height = "40" bgcolor = "#dddfdd">
<th  class = "body" ><a class="tooltip" href="#"><b><font color='maroon'>Animal Listings</font></b><span class="custom info"><em># Animal Listings</em>Animal listing come with:<ul>
<li>Up to 8 photos.</li>
<li>Basic information (Name, Breed, Species, etc.)</li>
<li>Description.</li>
<li>Awards.</li>
<li>Much more!</li></ul></span></a></th>
<th  class = "body2" align = "center">Unlimited</th>
<th  class = "body2" align = "center">Unlimited</th>
</tr>
<tr  height = "40">
<th class = "body" >
<a class="tooltip" href="#"><b><font color='maroon'>Member Ranch Pages</font></b><span class="custom info"><em>Member Ranch Pages</em>A mini-website for your ranch with:<ul>
<li>Home page</li>
<li>Animals for sale</li>
<li>Stud services</li>
<li>Products for sale</li>
<li>About us page</li>
<li>Contact us with map</li>
<li>Much more!</li></ul></span></a>
</th>
<th class = "body2" align = "center">Yes</th>
<th class = "body2" align = "center">Yes</th>
</tr>
<tr height = "40" bgcolor = "#dddfdd">
<th class = "body" >
<a class="tooltip" href="#"><b><font color='maroon'>Stud Listings</font></b><span class="custom info"><em>Stud Listings</em>Show off your studs! Stud listings includes:<ul>
<li>Stud fee.</li>
<li>Up to 8 photos.</li>
<li>Basic information (Name, Breed, Species, etc.)</li>
<li>Description.</li>
<li>Awards.</li>
<li>Much more!</li></ul></span></a>
</th>
<th class = "body2" align = "center">Unlimited</th>
<th class = "body2" align = "center">Unlimited</th>
</tr>
<tr  height = "40">
<th  class = "body" >

<a class="tooltip" href="#"><b><font color='maroon'>Product Listings</font></b><span class="custom info"><em>Product Listings</em>List your products for sale. Each listing includes:<ul>
<li>Up to 8 photos.</li>
<li>Basic information (Title, Price, etc.)</li>
<li>Description.</li>
<li>Paypal checkout.</li>
<li>Much more!</li></ul></span></a>

</th>
<th class = "body2" align = "center">Unlimited</th>
<th class = "body2" align = "center">Unlimited</th>
</tr>
<tr height = "40" bgcolor = "#dddfdd">
<th  class = "body" >

<a class="tooltip" href="#"><b><font color='maroon'>Property Listings</font></b><span class="custom info"><em>Property Listings</em>Have one or more properties for sale? List them with:<ul>
<li>Up to 8 photos.</li>
<li>Basic information (Title, Price, MLS #, etc.)</li>
<li>Description.</li>
<li>Much more!</li></ul></span></a>


</th>
<th class = "body2" align = "center"></th>
<th class = "body2" align = "center">Unlimited</th>
</tr>
<tr  height = "40">
<th class = "body" >
<a class="tooltip" href="#"><b><font color='maroon'>Business Listings</font></b><span class="custom info"><em>Business Listings</em>Need to sell your business? List it with:<ul>
<li>Up to 8 photos.</li>
<li>Basic information (Title, Price, etc.)</li>
<li>Description.</li>
<li>Much more!</li></ul></span></a>

</th>
<th class = "body2" align = "center"></th>
<th class = "body2" align = "center">Unlimited</th>
</tr>

<tr height = "40" bgcolor = "#dddfdd">
<th class = "body" >
<a class="tooltip" href="#"><b><font color='maroon'>Auctions at a Time</font></b><span class="custom info"><em>Auction Listings</em>Get outstanding exposure! Our auctions are:<ul>
<li>Are easy & effective.</li>
<li>Run any time you like.</li>
<li>Have no fees or commissions.</li>
<li>Come with most memberships and extra auctions are available for purchase.</li></ul></span></a>

</th>
<th class = "body2" align = "center">Unlimited</th>
<th class = "body2" align = "center">Unlimited</th>
</tr>

<tr height = "40">
<th class = "body" >

<a class="tooltip" href="#"><b><font color='maroon'>Featured Auctions at a Time</font></b><span class="custom info"><em>Highlight Your Auctions!</em>Our featured auctions include:<ul>
<li>Inclusion in weekly email (sent to thousands of livestock owners).</li>
<li>LOA home page listing (random from group of 16).</li>
<li>Select your animals and we do the rest!</li>
<li>Weekly featured auctions are limited to 16 per week.</li>
<li>Extra featured auctions available at $45/week.</li></ul></span></a>
</th>
<th class = "body2" align = "center"></th>
<th class = "body2" align = "center">4</th>
</tr>

<tr height = "40" bgcolor = "#dddfdd">
<td  class = "body"><a class="tooltip" href="#"><b><font color='maroon'>Search Classifieds</font></b><span class="custom info"><em>Search Classifieds</em>Exclusive to only Platinum members! Search classifieds display your animal’s right where you want them to be seen. As buyers search for the type of animal that you are selling, your animal’s classified ad will appear and make your animal stand out! For instance if you have a black suri alpaca for sale and a buyer searches for black suri alpacas your classified will be displayed prominently with a photo, name, price, stud fee (if appropriate), category, and a link to your animal. This is a great way to make your specific animals stand out right where you want them to.</ul></span></a>

</td>
<td class = 'body2' align = "center"></td>
<td class = 'body2' align = "center">Unlimited</td>
</tr>
<tr  height = "40">
<td  class = "body"><a class="tooltip" href="#"><b><font color='maroon'>Free Breed Ads</font></b><span class="custom info"><em>Breed Ads</em>Breed ads focus your marketing towards the ranchers in your specific industry. Your ads will appear on the right side of each page that is focused on your breed. For instance if you want to promote your horses for sale, your ad will show up randomly on the horse search, horse stud search, horse ranches, horse breeds, horse colors, and about horses pages! Breed ads are 200 pixels x 200 pixels and can be linked to your LOA listings or any website that you want!</ul></span></a>

</td>
<td class = 'body2' align = "center"></td>
<td class = 'body2' align = "center">3 months</td>
</tr>

<tr height = "40" bgcolor = "#dddfdd">
<td  class = "body"><a class="tooltip" href="#"><b><font color='maroon'>Free Header Ads</font></b><span class="custom info"><em>Header Ads</em>Thousands of people view Livestock of America every week, and they could be seeing your ads! Our header ads are 400 pixels x 75 pixels and can be linked to your LOA listings or any website that you want!</ul></span></a>

</td>
<td class = 'body2' align = "center"></td>
<td class = 'body2' align = "center">1 months</td>
</tr>
<tr><td></td>


<td class = 'body2' align = "center"><form action= '/setupaccount.asp?Membership=gold&RPI=<%=RPI %>' method = "post"><input type=submit value = " Join Now " class = "regsubmit2" ></form></td>
<td class = 'body2' align = "center"><form action= '/setupaccount.asp?Membership=Platinum&RPI=<%=RPI %>' method = "post"><input type=submit value = " Join Now " class = "regsubmit2" ></form></td>
</tr>
</table></center>
<big><br>Call us at 541.831.0103 or email us at <a href = "mailto:Contactus@LivestockOfAmerica.com" class = body><big>Contactus@LivestockOfAmerica.com</big></a> to learn more.</big>
</td>
</tr>
</table>
<br />
<table cellpadding = 0 border = 0 cellspacing = 0 width = "480">
<tr><td class = "body" valign = "top"><br /><br /><a name = "advertising"></a>
<h1>Advertising</h1>
Reach buyers with focused advertising on Livestock Of America. <big>Call us at 541.831.0103 or email us at <a href = "mailto:Contactus@LivestockOfAmerica.com" class = body><big>Contactus@LivestockOfAmerica.com</big></a> to learn more.</big><br />
<br />
</td></tr>
<tr><td class = "body">
<font size = 3 weight= 100>Reach Everyone with Banner Ads</font></td></tr>
<tr><td bgcolor = "black" height= 1></td></tr>
<tr><td class = "body">
Banner ads randomly appear at the top of every page, except ranch pages.<br />
<% if Discount > 0 then %>
Full Price: <strike>$65 / month</strike><br>
<b>Discount Price <%=formatcurrency(75 - 75*Discount/100) %> / month</b><br>
<% else %>
<b>$65 / month</b><br>
<% end if %>
A 400 pixel x 75 pixel header ad. (pool of 30).<br />
<br />
Example:<br />
 <img src ="/uploads/205940MayhemfarmBanner.jpg" border = "0" height = "120" width = "480" /> <br /><br /><br />
</td></tr>
<tr><td class = "body">
<font size = 3 weight= 100>Reach Your Target Audience with Our Breed Ads</font></td></tr>
<tr><td bgcolor = "black" height= 1></td></tr>
<tr><td class = "body">
<table width = "210" align = "right" border = "0"><tr><td class = 'body'>Example:<br />
<img src ="/uploads/20726surisofthesangresad.jpg" border = "0" height = "200" width = "200" /></td></tr></table>


Breed ads focus your marketing towards the ranchers in your specific industry. Your ads will appear on the right side of each page that is focused on your breed. For instance if you want to promote your horses for sale, your ad will show up randomly on the horse search, horse stud search, horse ranches, horse breeds, horse colors, and about horses pages! Breed ads are 200 pixels x 200 pixels and can be linked to your LOA listings or any website that you want!<br />
<br />
<% if Discount > 0 then %>
Full Price: <strike>$65 / month</strike><br>
<b>Discount Price <%=formatcurrency(75 - 75*Discount/100) %> / month</b><br>
<% else %>
<b>$65 / month</b><br>
<% end if %>
A 200 pixel x 200 pixel header ad. (pool of 30).<br />
<br />

<big>Call us at 541.831.0103 or email us at <a href = "mailto:Contactus@LivestockOfAmerica.com" class = body><big>Contactus@LivestockOfAmerica.com</big></a> to learn more.</big>

</td></tr></table>


</td>
<td valign = "top" class = "body2 roundedtopandbottom" width =  "430" align = "right">
<table width = "430"><tr><td><a name="websites"></a>
<h1>Custom Website Design</h1>
If your website is an ugly template or a page on someone else's website, then customers know that you are not a serious business; however, if potential customers see a beautifully-designed full-featured website then they will spend time on your website and that leads to more sales.<br /><br />
<a href = "/marketing/Examples.asp" class = "body">Click here to view examples of our work.</a>

<table border="0" cellspacing="0" cellpadding="0" align = "center" class = "roundedtopandbottom">
<tr bgcolor = "green" height = "30">
<th align="left" ></th>
<th width="70" class = "body2" align = "center"><big><font color="white">Ruby</font></big></th>
<th width="80" class = "body2" align = "center"><big><font color="white">Emerald</font></big></th>
<th width="70" class = "body2" align = "center"><big><font color="white">Diamond</font></big></th>
</tr>

<tr height = "40" bgcolor = "#dddfdd">
<th align="right" class = "body" >

<a class="tooltip" href="#"><b><font color='maroon'>First Year</font></b><span class="custom info"><em>Setup Fee</em>We charge a one-time fee to design and build your website</li></ul></span></a>
</th>
<th class = "body2" align = "center"><strike>$540</strike><br /><big>$432</big></th>
<th class = "body2" align = "center"><strike>$650</strike><br /><big>$520</big></th>
<th class = "body2" align = "center"><strike>$760</strike><br /><big>$608</big></th>
</tr>

<tr height = "40">
<th class = "body" align = "right" >

<a class="tooltip" href="#"><b><font color='maroon'>Yearly Fee</font></b><span class="custom info"><em>Yearly Fee</em>We change a yearly fee for:<ul>
<li>Website maintenance.</li>
<li>Technical support.</li>
<li>Doain registration.</li>
<li>Hosting.</li></ul>
We will first charge you this fee when it's time to setup your hosting.</span></a>

</th>
<th class = "body2" align = "center">$280</th>
<th class = "body2" align = "center">$280</th>
<th class = "body2" align = "center">$280</th>
</tr>

<tr height = "40" bgcolor = "#dddfdd">
<td></td>
<td class = 'body2' align = "center"><form action="https://www.paypal.com/cgi-bin/webscr" method="post" target = "blank">
<input type="hidden" name="cmd" value="_xclick">
<input type="hidden" name="page_style" value="LivewstockOfAmerica">
<input type="hidden" name="business" value="ContactUs@Livestockofamerica.com">
<input type="hidden" name="item_name" value="Ruby Website Package">
<input type="hidden" name="amount" value="432">
<input type="hidden" name="shipping" value="0.00">
<input type="hidden" name="no_shipping" value="0">
<input type="hidden" name="return" value="http://www.LivestockOfAmerica.com/join/">
<input type="hidden" name="cancel_return" value="http://www.LivestockOfAmerica.com/join/">
<input type="hidden" name="no_note" value="1">
<input type="hidden" name="currency_code" value="USD">
<input type="hidden" name="lc" value="US">
<input type="hidden" name="bn" value="PP-BuyNowBF">
<input type="submit" class = "regsubmit2" border="0" Value="Order" >
</form></td>
<td class = 'body2' align = "center"><form action="https://www.paypal.com/cgi-bin/webscr" method="post" target = "blank">
<input type="hidden" name="cmd" value="_xclick">
<input type="hidden" name="page_style" value="LivewstockOfAmerica">
<input type="hidden" name="business" value="ContactUs@Livestockofamerica.com">
<input type="hidden" name="item_name" value="Emerald Website Package">
<input type="hidden" name="amount" value="520">
<input type="hidden" name="shipping" value="0.00">
<input type="hidden" name="no_shipping" value="0">
<input type="hidden" name="return" value="http://www.LivestockOfAmerica.com/join/">
<input type="hidden" name="cancel_return" value="http://www.LivestockOfAmerica.com/join/">
<input type="hidden" name="no_note" value="1">
<input type="hidden" name="currency_code" value="USD">
<input type="hidden" name="lc" value="US">
<input type="hidden" name="bn" value="PP-BuyNowBF">
<input type="submit" class = "regsubmit2" border="0" Value="Order" >
</form></td>
<td class = 'body2' align = "center"><form action="https://www.paypal.com/cgi-bin/webscr" method="post" target = "blank">
<input type="hidden" name="cmd" value="_xclick">
<input type="hidden" name="page_style" value="LivewstockOfAmerica">
<input type="hidden" name="business" value="ContactUs@Livestockofamerica.com">
<input type="hidden" name="item_name" value="Diamond Website Package">
<input type="hidden" name="amount" value="608">
<input type="hidden" name="shipping" value="0.00">
<input type="hidden" name="no_shipping" value="0">
<input type="hidden" name="return" value="http://www.LivestockOfAmerica.com/join/">
<input type="hidden" name="cancel_return" value="http://www.LivestockOfAmerica.com/join/">
<input type="hidden" name="no_note" value="1">
<input type="hidden" name="currency_code" value="USD">
<input type="hidden" name="lc" value="US">
<input type="hidden" name="bn" value="PP-BuyNowBF">
<input type="submit" class = "regsubmit2" border="0" Value="Order" >
</form></td>
</tr>



<tr height = "40" >
<td  class = "body"align = "right" height = "40">
<a class="tooltip" href="#"><b><font color='maroon'>You Own It</font></b><span class="custom info"><em>You Own Your Website</em>The website belongs to you, if you want to move it to new hosting, or another developer, you can. Note however that the automatic update to Livestock Of America will no longer work if you move your website. </span></a>
</td>
<td class = 'body2' align = "center">Yes</td>
<td class = 'body2' align = "center">Yes</td>
<td class = 'body2' align = "center">Yes</td>
</tr>



<tr height = "40" bgcolor = "#dddfdd">
<td class = "body" align = "right" height = "40">
<a class="tooltip" href="#"><b><font color='maroon'>Graphic Design</font></b><span class="custom info"><em>Professional Website Graphic Design</em>All of your marketing -- your business cards, flyers, commercials, press releases, everything - should point to your website. Beyond your logo, your website is the most important piece of marketing collateral that a business has. And it needs to be just right.</span></a>

</td>
<td class = 'body2' align = "center">4 hours
</td>
<td class = 'body2' align = "center">4 hours</td>
<td class = 'body2' align = "center">6 hours</td>
</tr>

<tr  height = "40">
<td  class = "body"><a class="tooltip" href="#"><b><font color='maroon'>Content Management</font></b><span class="custom info"><em>Content Management System (CMS)</em>Your website will come with a complete CMS that allows you to maintain the information on your website.</span></a>
</td>
<td class = 'body2' align = "center">Yes</td>
<td class = 'body2' align = "center">Yes</td>
<td class = 'body2' align = "center">Yes</td>
</tr>
<tr bgcolor = "#dddfdd" height = "40">
<td  class = "body" >

<a class="tooltip" href="#"><b><font color='maroon'>Automatic LOA Upload</font></b><span class="custom info"><em>Automatic Animal & Product LOA Upload</em>When you make changes to your animals and products on your website it will automatically update your livestock of America account. It’s your website and you own it. You shouldn’t have to go someone else’s website to maintain it.<br /><br /><img src="/images/Websitedata.jpg" width = 200 align = right></span></a>


</td>
<td class = 'body2' align = "center">Yes</td>
<td class = 'body2' align = "center">Yes</td>
<td class = 'body2' align = "center">Yes</td>
</tr>
<tr  height = "40">
<td class = "body">
<a class="tooltip" href="#"><b><font color='maroon'>Responsive Design</font></b><span class="custom info"><em>Responsive Design</em>Your website will react and look great on the wide range of desktop, laptop, and mobile devices on the market today – all the way from a big-screen TV to a smart phone.</ul></span></a>

</td>
<td class = 'body2' align = "center">Yes</td>
<td class = 'body2' align = "center">Yes</td>
 <td class = 'body2' align = "center">Yes</td>
</tr>

<tr bgcolor = "#dddfdd" height = "40">
<td class = "body">
<a class="tooltip" href="#"><b><font color='maroon'>SEO Friendly</font></b><span class="custom info"><em>SEO Friendly</em>Search engines like websites designed with clean simple code. That’s one of the big advantages of a custom website vs a template website and that is the main reason that we only offer custom-built websites.</span></a>


</td>
<td class = 'body2' align = "center">Yes</td>
<td class = 'body2' align = "center">Yes</td>
<td class = 'body2' align = "center">Yes</td>
</tr>

<tr  height = "40">
<td  class = "body">Home Page</td>
<td class = 'body2' align = "center">Yes</td>
<td class = 'body2' align = "center">Yes</td>
<td class = 'body2' align = "center">Yes</td>
</tr>
<tr bgcolor = "#dddfdd" height = "40">
<td  class = "body"  >
<a class="tooltip" href="#"><b><font color='maroon'>Livestock Sales Pages</font></b><span class="custom info"><em>Livestock Sales Pages</em> List your animals for sale in multiple ways:<ul>
<li>Sales pages per breed.</li>
<li>Females for sale page.</li>
<li>Males for sale page.</li>
<li>Whole herd page.</li>
<li>Whatever you need to make it easy for customers to find the animals that they want.</li></ul></span></a>
</td>
<td class = 'body2' align = "center">Yes</td>
<td class = 'body2' align = "center">Yes</td>
<td class = 'body2' align = "center">Yes</td>
</tr>
<tr >
<td class = "body2"align = "right" height = "30">Individual Animal Pages</td>
<td class = 'body2' align = "center">Yes</td>
<td class = 'body2' align = "center">Yes</td>
<td class = 'body2' align = "center">Yes</td>
</tr>
<tr bgcolor = "#dddfdd" height = "40">
<td  class = "body">Stud Services Page</td>
<td class = 'body2' align = "center">Yes</td>
<td class = 'body2' align = "center">Yes</td>
<td class = 'body2' align = "center">Yes</td>
</tr>

<tr  height = "40">
<td  class = "body">Contact Page</td>
<td class = 'body2' align = "center">Yes</td>
<td class = 'body2' align = "center">Yes</td>
<td class = 'body2' align = "center">Yes</td>
</tr>
<tr bgcolor = "#dddfdd" height = "40">
<td  class = "body">Product For Sale Pages</td>
<td class = 'body2' align = "center">Yes</td>
<td class = 'body2' align = "center">Yes</td>
<td class = 'body2' align = "center">Yes</td>
</tr>
<tr height = "40">
<td  class = "body">Individual Product Pages</td>
<td class = 'body2' align = "center">Yes</td>
<td class = 'body2' align = "center">Yes</td>
<td class = 'body2' align = "center">Yes</td>
</tr>
<tr height = "40" bgcolor = "#dddfdd">
<td  class = "body">Shopping Cart</td>
<td class = 'body2' align = "center">Yes</td>
<td class = 'body2' align = "center">Yes</td>
<td class = 'body2' align = "center">Yes</td>
</tr>

<tr height = "40">
<td  class = "body">Services Pages</td>
<td class = 'body2' align = "center"></td>
<td class = 'body2' align = "center">Yes</td>
<td class = 'body2' align = "center">Yes</td>
</tr>
   
<tr height = "40" bgcolor = "#dddfdd">
<td  class = "body">Blog</td>
<td class = 'body2' align = "center"></td>
<td class = 'body2' align = "center">Yes</td>
<td class = 'body2' align = "center">Yes</td>
</tr>
<tr height = "40">
<td  class = "body2" >Photo Gallery</td>
<td class = 'body2' align = "center"></td>
<td class = 'body2' align = "center">Yes</td>
<td class = 'body2' align = "center">Yes</td>
</tr>

<tr bgcolor = "#dddfdd">
<td  class = "body" height = "40">
<a class="tooltip" href="#"><b><font color='maroon'>Additional Pages</font></b><span class="custom info"><em>AdditionalPages</em>Need more content? No problem! We can provide a wide range of extra types of pages to fit your every need.</span></a>


</td>
<td class = 'body2' align = "center"></td>
<td class = 'body2' align = "center"><strong>5</strong></td>
<td class = 'body2' align = "center"><strong>Unlimited</strong></td>
</tr>


<tr height = "40">
<td  class = "body" >Training</td>
<td class = 'body2' align = "center">Yes</td>
<td class = 'body2' align = "center">Yes</td>
<td class = 'body2' align = "center">Yes</td>
 </tr>
<tr bgcolor = "#dddfdd" height = "40">
<td  class = "body">Technical Support</td>
<td class = 'body2' align = "center">Yes</td>
<td class = 'body2' align = "center">Yes</td>
<td class = 'body2' align = "center">Yes</td>
 </tr>
<tr height = "40">
<td  class = "body">Website Hosting</td>
<td class = 'body2' align = "center">Yes</td>
<td class = 'body2' align = "center">Yes</td>
<td class = 'body2' align = "center">Yes</td>
 </tr>
<tr bgcolor = "#dddfdd" height = "40">
<td  class = "body">Domain Registration</td>
<td class = "body2" align = "center">Included</td>
<td class = "body2" align = "center">Included</td>
<td class = "body2" align = "center">Included</td>
</tr>

<tr><td></td>
<td class = 'body2' align = "center"><form action="https://www.paypal.com/cgi-bin/webscr" method="post" target = "blank">
<input type="hidden" name="cmd" value="_xclick">
<input type="hidden" name="page_style" value="LivewstockOfAmerica">
<input type="hidden" name="business" value="ContactUs@Livestockofamerica.com">
<input type="hidden" name="item_name" value="Ruby Website Package">
<input type="hidden" name="amount" value="432">
<input type="hidden" name="shipping" value="0.00">
<input type="hidden" name="no_shipping" value="0">
<input type="hidden" name="return" value="http://www.LivestockOfAmerica.com/join/">
<input type="hidden" name="cancel_return" value="http://www.LivestockOfAmerica.com/join/">
<input type="hidden" name="no_note" value="1">
<input type="hidden" name="currency_code" value="USD">
<input type="hidden" name="lc" value="US">
<input type="hidden" name="bn" value="PP-BuyNowBF">
<input type="submit" class = "regsubmit2" border="0" Value="Order" >
</form></td>
<td class = 'body2' align = "center"><form action="https://www.paypal.com/cgi-bin/webscr" method="post" target = "blank">
<input type="hidden" name="cmd" value="_xclick">
<input type="hidden" name="page_style" value="LivewstockOfAmerica">
<input type="hidden" name="business" value="ContactUs@Livestockofamerica.com">
<input type="hidden" name="item_name" value="Emerald Website Package">
<input type="hidden" name="amount" value="520">
<input type="hidden" name="shipping" value="0.00">
<input type="hidden" name="no_shipping" value="0">
<input type="hidden" name="return" value="http://www.LivestockOfAmerica.com/join/">
<input type="hidden" name="cancel_return" value="http://www.LivestockOfAmerica.com/join/">
<input type="hidden" name="no_note" value="1">
<input type="hidden" name="currency_code" value="USD">
<input type="hidden" name="lc" value="US">
<input type="hidden" name="bn" value="PP-BuyNowBF">
<input type="submit" class = "regsubmit2" border="0" Value="Order" >
</form></td>
<td class = 'body2' align = "center"><form action="https://www.paypal.com/cgi-bin/webscr" method="post" target = "blank">
<input type="hidden" name="cmd" value="_xclick">
<input type="hidden" name="page_style" value="LivewstockOfAmerica">
<input type="hidden" name="business" value="ContactUs@Livestockofamerica.com">
<input type="hidden" name="item_name" value="Diamond Website Package">
<input type="hidden" name="amount" value="608">
<input type="hidden" name="shipping" value="0.00">
<input type="hidden" name="no_shipping" value="0">
<input type="hidden" name="return" value="http://www.LivestockOfAmerica.com/join/">
<input type="hidden" name="cancel_return" value="http://www.LivestockOfAmerica.com/join/">
<input type="hidden" name="no_note" value="1">
<input type="hidden" name="currency_code" value="USD">
<input type="hidden" name="lc" value="US">
<input type="hidden" name="bn" value="PP-BuyNowBF">
<input type="submit" class = "regsubmit2" border="0" Value="Order" >
</form></td>
</tr>


<tr><td colspan = '8'  bgcolor = "green" height = "30" class = "body2" align = "center"><font color = "white"><b >Suggested Add-Ons</b></font></td></tr>
<tr><td Class = "body2" colspan = "4"><br /><a href="/marketing/Logos.asp" class = "body"><b>Logo Design</b></a></td></tr>
<tr><td Class = "body2" colspan = "4"><br /><a href="/marketing/SEO.asp" class = "body"><b>Search Engine Optimizations (SEO)</b></a></td></tr>
<tr><td class = "body" colspan = 7><br />
 <h2>Custom Orders Don't Upset Us!</h2>
  If none of the options above are exactly what you need, <a href = "/marketing/Contactus.asp" class = "body">contact us</a> and we will put together a custom option that has exactly what you want.<br><br />
  </td></tr>

</table></center>




</td></tr>

</table>





</td>
</tr>

<tr><td class = "body" colspan = 2><br />
<table width = 100% cellspacing = 0 cellspacing=0 border = 0>
<tr><td class = "body">
<font size = 3 weight= 100>Pinpoint Your Marketing to Your Target Audience with Search Classified Ads</font></td></tr>
<tr><td bgcolor = "black" height= 1></td></tr>
<tr><td class = "body">
<table width = "210" align = "right" border = "0"><tr><td class = 'body'>Example:<br />

<% sql = "Select TOP 1 animals.ID, People.PeopleID, Photo1, category, FullName, Pricing.Price, Pricing.SalePrice, Pricing.Studfee, SpeciesBreedLookupTable.Breed from animals, people, Photos, SpeciesBreedLookupTable, pricing  where pricing.ID = animals.ID  and photos.ID = animals.ID  and animals.BreedID = SpeciesBreedLookupTable.BreedLookupID and len(Photo1) > 6 and animals.peopleID = People.peopleID and People.Subscriptionlevel = 4 and animals.peopleID = People.peopleID And pricing.id=Animals.id and People.AccessLevel  > 0 and People.AIPublish = True and PublishForSale = true ORDER BY rnd(INT(NOW*animals.ID)-NOW*animals.ID);"
rs.Open sql, conn, 3, 3   

if not rs.eof then

OldCurrentID = animalID

TempPeopleID = rs("PeopleID")

Photo1 = rs("Photo1")
FullName = rs("FullName")
Breed = rs("Breed")
Price= rs("Price")
SalePrice= rs("salePrice")
StudFee= rs("StudFee")
category = rs("category")
link = "/Ranches/Details.asp?ID=" & animalID & "&CurrentPeopleID=" & TempPeopleID
%>
<table cellspacing = 0 cellpadding = 0>
<tr bgcolor = "#dfdfdf">
<td colspan = "2">
<small><a href="<%=link%>" class = "body"><b><%=FullName %></b></a></small>
</td></tr>
<tr bgcolor = "#dfdfdf">
<td class = "body" valign = "top" width = "249">
<small><%=Breed %><br>
<%=category %><br>
<% if len(Price) > 1 then %>
Price: <%=formatcurrency(Price,2)%><br />
<% else %>
Call For Price<br />
<% end if %>
<% if len(SalePrice) > 1 then %>
Sale Price: <%=formatcurrency(SalePrice,2)%><br />
<% end if %>
<% if len(StudFee) > 1 then %>
Stud Fee: <%=formatcurrency(StudFee,2)%><br />
<% end if %>
<a href="<%=link%>" class = "body">Learn More</a><br /><br />
</small>
</td>
<td width = 101>
<% if Photo1 = "http://www.livestockofamerica.com/uploads/" then
Photo1 = "http://www.livestockofamerica.com/uploads/ImageNotAvailable.jpg" 
end if%>
<a href="<%=link%>"><img src = "<%=Photo1%>" width = "100" border = "0" /></a>
</td>
</tr></table>
<% end if %>


</td></tr></table>

<b>Exclusive to Our Platinum Members Only!</b><br /><br />
Search classifieds display your animal’s right where you want them to be seen. As buyers search for the type of animal that you are selling, your animal’s classified ad will appear and make your animal stand out! For instance if you have a black suri alpaca for sale and a buyer searches for black suri alpacas your classified will be displayed prominently with a photo, name, price, stud fee (if appropriate), category, and a link to your animal. This is a great way to make your specific animals stand out right where you want them to<br />
<br />

<br />



</td></tr>


<tr><td><font size = 3 weight= 100>Make a Big Impact with our Home Page Ad</font></td></tr>
<tr><td bgcolor = "black" height= 1 colspan = 2></td></tr>
<tr><td class = "body" colspan = 2>
Our big home page ads are hard to miss at 700 pixels wide by 269 pixels high - limited to a pool of 6!

<% if Discount > 0 then %>
Full Price <strike>$125 / month</strike><br>
<b>Discount Price <%=formatcurrency(125 - 125*Discount/100) %> / month</b><br>
<% else %>
<b>$125 / month</b><br>
<% end if %>

<br />
Example:<br>
<img src="/massemails/CQhomepagead.jpg" alt="Camelid Quartly Magazine" width = "700" height = "269" border = "0"/>
<br>
<br />We are committed to creating a successful online advertising program for your business. <big>Call us at 541.831.0103 or email us at <a href = "mailto:Contactus@LivestockOfAmerica.com" class = body><big>Contactus@LivestockOfAmerica.com</big></a> to learn more.</big>
<br /><br />



</td></tr></table>
</td></tr>
</table>

<!--#Include virtual="/Footer.asp"-->