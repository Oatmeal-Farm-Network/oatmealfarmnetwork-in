<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!--#Include file="AdminGlobalVariables.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<meta name="robots" content="nofollow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="revisit-after" content="never"/>
<meta name="Googlebot" content="nofollow"/>
<meta name="author" content="The Andresen Group"/>
<link rel="stylesheet" type="text/css" href="/style.css" />
</head>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center" >
<% Discount = 50'Percent
Current2="Account"
Current3 = "webdesign" %> 
<!--#Include file="adminHeader.asp"-->
<br>
<!--#Include file="AdminAccountTabsInclude.asp"-->
<% If not rs.State = adStateClosed Then
rs.close
End If   	
%>
<%
sale = True
discount =50 'percent
RPI = request.querystring("RPI") %>
<% centerwidth = screenwidth 
tablewidth = screenwidth - 320 
 Colwidth =(screenwidth -350)/2 %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth %>" >
<tr>
<td width = "<%=centerwidth %>"  class = "body roundedtopandbottom" valign = "top"><br>
<H1><div align = "left">Exclusive Web Design & Brokering Offers</div></H1>
We offer the following website design and brokering options only to our existing members.<br>
<br />
 <h2>Custom Orders Don't Upset Us!</h2>
  If none of the options below are exactly what you need, <a href = "/marketing/Contactus.asp" class = "body"><b>contact us</b></a> and we will put together a custom offer just for you.<br><br />
<br>
<table width = "430"><tr><td><a name="websites"></a>
<center><img src = 'http://www.livestockofamerica.com/massemails/Responsivedesign.jpg' align = center width = 385 height = 241></center>
<h1>Custom Website Design</h1>
<center><b>Save 30% on Custom Website Design Packages!</b><br />
Sale Ends July 1<sup>st</sup><br /></center><br />
If your website is an ugly template or a page on someone else's website, then customers know that you are not a serious business; however, if potential customers see a beautifully-designed full-featured website then they will spend time on your website and that leads to more sales.<br /><br />
<a href = "/marketing/Examples.asp" class = "body">Click here to view examples of our work.</a>

<table border="0" cellspacing="0" cellpadding="0" align = "center" width="<%=screenwidth-90%>" class = "roundedtopandbottom">
<tr bgcolor = "green" height = "30">
<th align="left" ></th>
<th width = "24%" class = "body2" align = "center"><big><font color="white">Ruby</font></big></th>
<th width = "24%" class = "body2" align = "center"><big><font color="white">Emerald</font></big></th>
<th width = "24%" class = "body2" align = "center"><big><font color="white">Diamond</font></big></th>
</tr>

<tr height = "40" bgcolor = "#dddfdd">
<th align="right" class = "body" >

<a class="tooltip" href="#"><b><font color='maroon'>Setup Fee</font></b><span class="custom info"><em>Setup Fee</em>We charge a one-time fee to design and build your website</li></ul></span></a>
</th>
<th class = "body2" align = "center"><strike>$540</strike><br>$378</th>
<th class = "body2" align = "center"><strike>$650</strike><br>$455</th>
<th class = "body2" align = "center"><strike>$760</strike><br>$532</th>
</tr>

<tr height = "40">
<th class = "body" align = "right" >

<a class="tooltip" href="#"><b><font color='maroon'>Yearly Fee</font></b><span class="custom info"><em>Yearly Fee</em>We change a yearly fee for:<ul>
<li>Website maintenance.</li>
<li>Technical support.</li>
<li>Domain registration.</li>
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
<input type="hidden" name="amount" value="540">
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
<input type="hidden" name="amount" value="650">
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
<input type="hidden" name="amount" value="760">
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
<td class = "body" height = "40">Individual Animal Pages</td>
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
<input type="hidden" name="amount" value="540">
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
<input type="hidden" name="amount" value="650">
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
<input type="hidden" name="amount" value="760">
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


<tr><td colspan = '8'  bgcolor = "green" height = "30" class = "body2" align = "center"><font color = "white"><b >Suggested Add-On</b></font></td></tr>
<tr><td Class = "body2" colspan = "4"><br /><a href="/marketing/Logos.asp" class = "body"><b>Logo Design</b></a>  - Save 50% on logo design when you order a new website.</td></tr>
<tr><td class = "body" colspan = 7><br />
 <h2>Custom Orders Don't Upset Us!</h2>
  If none of the options above are exactly what you need, <a href = "/marketing/Contactus.asp" class = "body">contact us</a> and we will put together a custom option that has exactly what you want.<br></td></tr>
 </table></center>
</td></tr>
</table>
</td></tr>
</table>






</td>
</tr>
</table>
<br>
    <!--#Include virtual="/Footer.asp"--> 
 </BODY>
</HTML>