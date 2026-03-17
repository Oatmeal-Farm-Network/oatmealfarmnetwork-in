<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<title>The ANDRESEN GROUP Content Management System (AGCMS)</title>
<meta name="robots" content="nofollow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="revisit-after" content="1"/>
<meta name="Googlebot" content="nofollow"/>
<link rel="shortcut icon" href="/infinityknot.ico" /> 
<link rel="icon" href="http://www.alpacainfinity.com/alpacachamps/infinityknot.ico" /> 
<meta name="author" content="The Andresen Group"/>
<link rel="stylesheet" type="text/css" href="/administration/style.css">

<!--#Include file="AdminGlobalVariables.asp"-->
</HEAD>
<% if mobiledevice = True  then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
<% end if %>


    <!--#Include file="AdminHeader.asp"--> 
<!--#Include file="AdminSecurityInclude.asp"-->


  <% 
pagename = request.QueryString("pagename")
  if pagename = "Galleries" then
      Current3 = "SEOArticle" %>
    <!--#Include file="AdminGalleryTabsInclude.asp"-->
  <% end if %>
  
       <% if pagename = "About Us" or pagename= "Herdsires"  then
     Current3 = "SEOArticle" %>
<!--#Include File="AdminPagesTabsInclude.asp"--> 
  <% end if %>
  
    <% if pagename = "Articles" then
      Current3 = "SEOArticle" %>
<!--#Include File="AdminArticlesTabsInclude.asp"--> 
  <% end if %>
  
<%        
if trim(pagename) = "Alpacas For Sale" then
       Current3 = "SEOArticle" %>
<!--#Include File="AdminAnimalsTabsInclude.asp"--> 
  <% end if %>
  
    <%        
if trim(pagename) = "Blog" then
       Current3 = "SEOArticle" %>
<!--#Include virtual="/Administration/BlogAdmin/BlogAdminTabsInclude.asp"--> 
  <% end if %>
  
        <%        
if trim(pagename) = "Home Page" then
         Current3 = "SEOArticle" %>
<!--#Include File="AdminPagesTabsInclude.asp"--> 
  <% end if %>
  
<%        
if trim(pagename) = "Contact Us" then
        Current3 = "SEOArticle" %>
<!--#Include File="AdminPagesTabsInclude.asp"--> 
  <% end if %>

 <% if screenwidth < 989 then %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "left" width = "<%=screenwidth -35 %>">
<% else %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth -35 %>">
<% end if %><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">About Search Engine Optimization (SEO)</div></H2>
        </td></tr>
        <tr><td class = "roundedBottom body"  height = "300" width = "100%"  valign = "top">
<br />

How does a website move from page 1000 on Google to page 1? It’s done through years of careful work, adjusting every web page to make it attractive to search engines, getting other sites to refer users to your site, and a lot more. The process is called SEO or Search Engine Optimization and it is a complex and constantly changing endeavor.<br>
 <br>

SEO can be confusing and frustrating, but it doesn’t have to be. The purpose of this article is help clarify a few of the basic aspects of SEO and to help you understand a bit about how SEO works.<br>
 <br>

Currently there are over 232,000,000 websites in the world and that number increases daily. Search engines have to sift through that pile and give you the most relevant of those sites when you type in a search term…a daunting task to say the least. <br>
 <br>

So how do search engines prioritize all of those sites? A small number of search engines use human beings that look at every site and give it a score based upon set criteria; however most search engines use programs called "spiders." Spider programs scurry through every web page they can find and they stick every word that they find into a database. They assign a score to each word they find. Those scores are dependent upon a number of criteria. And to make things even more complicated, the criteria used by search engines frequently changes and are different with each particular search engine. In order to get great rankings, you have to understand that criteria, what is the most important right now, and how to make changes that will give you the best scores. The basic primary criteria are:<br>
 <br>
<ul>
	<li>Site Address </li>
	<li>Meta Tags  </li>
	<li>Title Field  </li>
	<li>Word Weight  </li>
	<li>Word Position  </li>
	<li>Word Placement  </li>
	<li>Links</li>
</ul>
If some or all of these criteria sound confusing to you, don’t feel bad, you aren’t alone. Below are some definitions and explanations of how they are implemented on most search engines:<br>
 <br>
<b>Site Address. </b>The address that people type in to find your site (i.e. www.mysite.com). This used to be of high importance to search engines, but with the whole world trying to grab the best address, search engines have lowered the importance of the perfect address.  <br>
 <br>
<b>Meta Tags. </b>There is certain information that be can added to web pages that is not seen by users but can be seen by search engines. That information is stored in what are called Meta Tags. Meta Tags can serve a number of functions, such as to indicate who created a web page, what program was used, when the page was created, etc. Meta Tags used to be heavily used by search engines, however they have become overused and are now a bit out of date.<br>
 <br>
<b>Title Field. </b>The page title or title field is what appears at the very top of your browser (Internet Explorer, Netscape, etc.) when you are looking at a specific web page. This is one of the most important fields used for SEO and probably one of the least utilized. <br>
 <br>
<b>Word Weight. </b>Word weight is the number of times a word is used on a page compared to the total number of words on that page. For instance, if your page has ten words and five of them are the word Suri; then that word would get a high score or weight. But if the page had 100 words and used the word Suri only five times, then Suri would get a low weight. The higher the word weight, the better score the spider, or human reviewer, will give your page for that word. <br>
 <br>
<b>Word Position. </b>The closer to the top of the page that a word appears on the page, the higher its score will be. <br>
 <br>
<b>Word Placement. </b>Words in titles or links get higher rankings. This formatting shows the importance to the viewer, and so it is considered important to the search engines. <br>
 <br>
<b>Links. </b>Hyperlinks, which general are just called Links, are connections between one web page and another and they fall into the following three categories: <br>
 <br>
 <p> 1. Internal Links. Internal links are links from one web page to another web page in the same website. Other than to show importance like all links they have no special importance for SEO. <br>
 <br>
 
 &nbsp; 2.  Inbound Links. Inbound links have become very popular with the search engines lately, and many SEO companies would say that there is nothing more important than these when trying to achieve the best rankings. <br>
 <br>
 
Most search engines look at two things when they evaluate the importance of inbound links to your site: 1) how often they are used and 2) how many other links the referring page has. <br>
 <br>
 
If every month thousands of people use a particular inbound link to your site, the search engines know and they increase your rating accordingly. On the other hand, an inbound link that is only used once a month will not help you very much. In reaction to this, some people have started "link farms" which are sites with nothing but links. The purpose of link farms is to artificially bump up search engine rankings.<br>
 <br>
 
In reaction to link farms, search engines now also give greater importance to the number of links the referring page has. For instance, an inbound link from a page with 50 links on it will be much more valuable than a page with 5,000 links. They figure the page with 50 links most likely will have 50 relevant links, but the page with thousands of links will include links to irrelevant links.<br>
 <br>
 
So how do you get other people to link to your site? If your site is a valuable source of information or products, others will link to it to be helpful to their users. And, if you are a member of any organization you should make sure that you get a link on their site. However, the main way to get inbound links is to ask other people, organizations, or farms to add a link from their site to your site, and in exchange you will do the same for them. These links are called reciprocal links.<br>
 <br>
 
People generally offer reciprocal links to customers and vendors that they trust and would be happy to recommend. Often, businesses will include links to competitors as well. This may seem a bit odd but it makes perfect sense if your competitor offers a slightly different service than you or if you use them for work overflow. The alpaca industry is a bit odd since other alpaca ranches are both customers and competitors. <br>
 <br>
 
But ask yourself, if someone was looking for a black Suri and you only had white Huacayas, would you tell them about the guy down the road that had black Suris, or would you tell them that you couldn’t help them at all? If both you and the guy down the road would send business to each other verbally - why not do the same on your website by adding links to each other's sites’? <br>
 <br>
 
3. Outbound Links. Outbound links are links from your site to someone else’s site. Other than to show importance like all links they have no special importance for SEO. However, they are most often used to make a website a more valuable resource by referring people to other informative sites.They are also necessary in getting other people to give you reciprocal links.<br>
 <br>
Search engine optimization can seem confusing and time consuming but it doesn’t have to be. Getting your site listed with search engines is good, but achieving rankings on the first page or two of results is what really makes the difference. Making your site work for you through SEO can be a very valuable way to generate qualified leads for your small business or farm.  <br>
 <br>
 
The challenge of course, can be figuring out exactly how to achieve such high rankings. My best advice is to keep in mind the word weight when writing the text for your web pages and to look for all the opportunities to get reciprocal links.  <br>
 <br>
 

<br>
 <br>

 

	    </td>
		</tr>
</table>
	    </td>
	    
</table>

 </td>
 </tr>
 </table>

</td>
</tr>
</table>
</td>
</tr>
</table><br />
 <!--#Include file="adminFooter.asp"--> 
</BODY>
</HTML>


