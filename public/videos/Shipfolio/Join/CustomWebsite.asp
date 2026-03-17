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
Current3 = "Website" %>
<% if screenwidth > 700 then %>
<!--#Include virtual="/Join/JoinHeader.asp"--> 
<% end if %>



<table width = <%=screenwidth %> cellpadding = 5 cellspacing = 5 border = 0>
<tr><td class = "body">
<h1>Your Own Custom Website</h1>


<% if screenwidth > 900 then %>
<img src = "Customwebsiteexample.jpg" border = 0 align = "right" width = 616 height = 351 />
<% end if %>

<% if screenwidth < 901 and screenwidth > 640 then %>
<img src = "Customwebsiteexample.jpg" border = 0 align = "right" width = 50% />
<% end if %>

<a href = "/Join/?Screenwidth=<%=screenwidth %>" class = "body"><img src = "/Join/SignUp.jpg" height = 30 border = 0/></a><a href = "/Join/?Screenwidth=<%=screenwidth %>" class = "body"><b>Sign Up For a Custom Website (Comes with the Complete Membership).</b></a>
<h2>What You Get</h2>

Your website will come with:

<ul><li>3 custom website graphic designs.</li>
<li>Home page.</li>
<li>Animals for sale pages.</li>
<li>Animal stud pages.</li>
<li>Online store.</li>
<li>Photo gallery.</li>
<li>Article pages.</li>
<li>Blog.</li>
<li>About us page.</li>
<li>Contact us page with contact form and map.</li>
<li>Free technical support.</li>
<li>Website hosting.</li>
<li>Email.</li>
</ul>
<br />
If you need extra graphic designs or website functionality we charge an hourly rate of $100/hour. We can also help with logo design.<br /><br />




<h2>Responsive Website Design</h2>
Your website  will adapt to any device that it is viewed on. That means that your website will look great on a phone, a big screen TV, and everything in between.


<h2>Putting Control in Your Hands</h2>
Your websites will come with our <a href = "http://www.Livestockwebsitedesign.com/LivestockCMS/?Screenwidth=<%=screenwidth %>" class = "body">Artemis Livestock Content Management System (CMS)</a> that allows you to maintain the content on your website - images, text, products, animals, etc. This means that you have control of your content and don't have to wait for someone else to make updates for you. <br /><br />

<h2>Linked to Your Livestock Of The World Account</h2>
<img src = "CMSTransferSquare.jpg" border = 0 align = "left" width = 219 alt = "automagic update" />
When you make changes to your animal or product information in your website’s Content Management System, your changes will not just update your website but it will also automagically update the information on your Livestock of The World account. 

<h2>Your Website - The Cornerstone of Your Marketing</h2>
All of your marketing -- your business cards, flyers, commercials, press releases, everything - should point to your website. Beyond your logo, a website is the most important piece of marketing collateral that a business has. And it needs to be just right. <br /><br />

If your website is a ugly template or a page on someone else's website, then customers know that you are not a serious business; however, if potential customers see a beautifully-designed full-featured website then they will spend time on your website and that leads to more sales.<br /><br />

<h2>Livestock Of The World + Your Own Website = A Great Combination</h2>
Livestock Of the World websites are online marketplaces that generate much more site traffic than an individual ranch website. So they are a great way to get nationwide exposure for your ranch and animals. However, sending your customers to your own website will give them a more personal, branded experience, making them more likely to do regular business with you and less likely to click away to a competitor’s site.<br /><br />

Being on Livestock Of The World websites and having your own ranch website is the perfect combination of nationwide exposure, and a unique destination to send your customers to, all for one great price!


<br /><br />

<h2>Learn More</h2>
<table cellspacing = 3 cellpadding = 3 border = 0>


<tr><td class = "body"><a href = "/website-design/Examples.asp?Screenwidth=<%=screenwidth %>" class = "body"><img src = "/images/PortfolioIcon.png" height = 30 border = 0/></a></td><td class = "body"><a href = "/website-design/Examples.asp?Screenwidth=<%=screenwidth %>" class = "body"><b>Our Portfolio</b></a></td></tr>

<tr><td class = "body"><a href = "/LivestockCMS/?Screenwidth=<%=screenwidth %>" class = "body"><img src = "/images/ArtemisCMSIcon.png" height = 30 border = 0/></a></td><td class = "body"><a href = "/LivestockCMS/?Screenwidth=<%=screenwidth %>" class = "body"><b>
<% if screenwidth > 640 then %>
Artemis Livestock Content Management System (CMS)
<% else %>
Artemis CMS
<% end if %></b></a></td></tr>

<tr><td class = "body"><a href = "/Join/?Screenwidth=<%=screenwidth %>" class = "body"><img src = "/Join/SignUp.jpg" height = 30 border = 0/></a></td><td class = "body"><a href = "/Join/?Screenwidth=<%=screenwidth %>" class = "body"><b>Sign Up</b></a></td></tr>


</table>

<br /><br />

</td></tr></table>


<!--#Include virtual="/Footer.asp"-->