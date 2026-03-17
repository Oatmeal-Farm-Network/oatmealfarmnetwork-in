<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!--#Include file="MembersGlobalVariables.asp"-->

<% title= "Global Grange Newsletter"
Description = "Sign Up to be included the Global Grane Newsletter"
image = "https://www.livestockofAmerica.com/images/LivestockofAmericaTall.png"
Author = "Global Grange Inc." %>

<Title><%=Title %></Title>
<meta name="title" content="<%=Title %>" />

<meta name="description" content="<%=Description %>" />
<meta name="robots" content="follow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="Googlebot" content="follow"/>
<meta name="author" content="<%=Author %>"/>
<link rel="canonical" href="<%=currenturl %>" />
<meta property="og:url" content="<%=currenturl %>" />
<meta name="Title" content="<%=Title %>"/>
<meta name="Author" content="<%=Author %> - Global Grange Inc."/>
<meta property="og:locale" content="en_US" />
<meta property="og:type" content="article" />
<meta property="og:title" content="<%=Title %>" />
<meta property="og:site_name" content="<%=Website %>" />
<meta property="og:image" content="<%=image %>" />
<meta property="og:image:width" content="854" />
<meta property="og:image:height" content="447" />
<meta property="og:description" content="<%=Title %>" />

<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="format-detection" content="telephone=no">
<meta name="theme-color" content="#ffffff">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">
<meta name="mobile-web-app-capable" content="yes">
<link rel="manifest" href="/manifest.json">
<meta name="msapplication-TileColor" content="#ffffff">
<meta name="theme-color" content="#ffffff">
<meta name="robots" content="index, follow">

<% If not rs.State = adStateClosed Then
  rs.close
End If   	
%>

</head>
<body>

<link rel="stylesheet" href="https://www.livestockoftheworld.com/members/Membersstyle.css">
</head>
<body >
<% Current1="Animals"
Current2 = "EditAnimals" 
Current3 = "Pricing" %> 
<!--#Include file="MembersHeader.asp"-->






<div class="container-fluid d-none d-lg-block" id="grad1" align = "center" style=" min-height: 70px" >
    <div class = "row" align = "center" >
        <div class = "col body" >
            <h1>Our Newsletter</h1>
        </div>
</div>
</div>

<div class="container">
    <div class="row">
        <div class ="col-md-4">
				<img src="https://www.LivestockOfAmerica.com/images/SignupForNewsletter.jpg" align ="left" alt="Sign up for Our Newsletter" margin="10px" width ="250"/>
	    </div>
	<div class="col-md-8">


       <iframe src="https://cdn.forms-content.sg-form.com/4af3eea7-fdde-11ee-84df-4ebfffaa867f" width="100%" height="600px" style="padding: 20px; border: 1px solid #ddd;"></iframe>


            &nbsp;&nbsp;
            <a href="https://www.linkedin.com/company/90532165/admin/feed/posts/" target="_blank" class="body"><img src="https://www.GlobalLivestocksolutions.com/icons/LinkedIcon.png" height=" 20" /></a>&nbsp;
             <a href="https://gust.com/companies/GlobalGrange/" target="_blank" class="body"><img src="https://www.GlobalLivestocksolutions.com/icons/GustIcon.jpg" height=" 20" /></a>&nbsp;
            <a href="https://www.facebook.com/GlobalGrangeInc/" target="_blank" class="body"><img src="https://www.GlobalLivestocksolutions.com/icons/facebook.png" height=" 20" /></a>&nbsp;
            <a href="https://twitter.com/GlobalGrange" target="_blank" class="body"><img src="https://www.GlobalLivestocksolutions.com/icons/TwitterX.png" height=" 20" /></a>&nbsp;
             <a href="https://www.instagram.com/GlobalGrange" target="_blank" class="body"><img src="https://www.GlobalLivestocksolutions.com/icons/instagramicon.png" height=" 20" /></a>&nbsp;
            <a href="https://truthsocial.com/" target="_blank" class="body"><img src="https://www.GlobalLivestocksolutions.com/icons/Truthsocial.png" height=" 20" /></a>&nbsp;
            <a href="https://www.youtube.com/@GlobalGrange" target="_blank" class="body"><img src="https://www.GlobalLivestocksolutions.com/icons/YouTube.jpg" height=" 20" /></a>&nbsp;
            <a href="https://discord.com/channels/globalgrange" target="_blank" class="body"><img src="https://www.GlobalLivestocksolutions.com/icons/discordIcon.png" height=" 20" /></a>&nbsp;
<br /><br /><br /><br /><br />

		</div>
	</div>
</div>

<!--#Include virtual="/Footer.asp"-->
</body></html>