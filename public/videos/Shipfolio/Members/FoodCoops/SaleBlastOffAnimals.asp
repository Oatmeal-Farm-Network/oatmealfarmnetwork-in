<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Alpacas for Sale</title>
<meta name="description" content="Alpacas for Sale with the Livestock Of America Blast off Sale." >
<meta name="robots" content="index,follow">
<meta name="rating" content="Safe for kids">
<meta name="revisit-after" content="1">
<meta name="Googlebot" content="index,follow">
<meta name="robots" content="All">
<meta name="subject" content="Alpacas for Sale" >
<link rel="stylesheet" type="text/css" href="/style.css">


<!--#Include virtual="/GlobalVariables.asp"-->
<%
response.redirect("http://www.ibelieveinalpacas.com/SaleBlastOffAnimals.asp")
 SetLocale("en-us") 
CurrentPeopleID=1016

Logo = ""
Header = ""
MenuBackgroundColor = ""
MenuColor =""
MenuFontMouseOverColor = ""
TitleColor ="Maroon"
PageBackgroundColor = ""
PageTextColor = ""
LayoutStyle = ""

%>
<style>

H2 {font: 20pt arial; color: <%=TitleColor %>}
H3 {font: 12pt arial; color: <%=PageTextColor %>}
.Body {font: 10pt arial; color: <%=PageTextColor %>}
A.Body {font: 10pt arial; color: <%=PageTextColor %>}
A.Body:hover { color: <%=PageTextMouseOverColor%>}
.Heading {font: 10pt arial; color: <%=MenuColor %>}
A.Heading {font: 10pt arial; color: <%=MenuFontMouseOverColor %>}
</style>
<%
SortOrder = request.form("SortOrder")
Sortby = "Price Asc"
if SortOrder = "Name" or len(SortOrder) < 3 then Sortby = "FullName Asc"
if SortOrder = "Price - Ascending" or len(SortOrder) < 3 then Sortby = "Price Asc"
if SortOrder = "Price - Descending" or len(SortOrder) < 3 then Sortby = "Price Desc"
if SortOrder = "Color" or len(SortOrder) < 3 then Sortby = "Color1"
if SortOrder = "DOB" or len(SortOrder) < 3 then Sortby = "DOBYear Desc, DOBMonth Desc, DOBYear Desc"
Current3 = "AnimalsForSale" 
 Current2 = "FFAA"%>
</head>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center">
<!--#Include file="RanchHeader.asp"-->
<!--#Include virtual="AnimalsTabsIncludeBottom.asp"--> 
<% screenwidth = screenwidth - 50%>
<table width = "100%" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center" class = "roundedtopandbottom"><tr><td  align = "left" ><H1><font size = 9 color = "maroon"><center><i>Fiber Fantastic Alpaca Auction</i></center></font></H1>
<font size = 4><center><b>Dec. 7 - Jan 10</b><br></font></center>
Each week the animals that have not been sold will be marked down 10%. The longer you wait, the better the deal, but the longer you wait the more likely someone else will grab the alpacas that you want!<br><br />

<b>To buy an animal,</b> select the <i>learn more</i> link then contact the animal’s owner.<br><br />

The Fiber Fantastic Alpaca Auction is exclusive to our brokering customers. <a href = "/Brokering/AlpacaBrokering/" class = 'body'><b>Click here</b></a> to learn more about our brokering services, or <a href = "/Join/" class = 'body'><b>click here</b></a> to sign up.

<% auctionstart = false
if auctionstart = True then %>
<table width = "<%=screenwidth -30%>" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center">
<tr><td align = "left" valign = "top">
<!--#Include virtual="/Conn.asp"-->
<% 
if rs.state = 0 then
else
rs.close
end if

CurrentspeciesId = 2


sql = "select saleblastoff.peopleId, saleblastoff.animalID, saleblastoff.startingprice, Price, Photo1, Photo2, Photo3, Photo4,  Photo5, Photo6, Photo7, Photo8, category, FullName, Sold, salepending from saleblastoff, Pricing, Photos, Animals where saleblastoff.animalID = Pricing.ID and saleblastoff.AnimalID = Photos.ID and Animals.ID = saleblastoff.AnimalID and (category = 'Experienced Male'  or category = 'Experienced Males' or category = 'Proven Male' )"

'response.write("sql=" & sql)
rs.Open sql, conn, 3, 3 %>
<h2>Alpaca Herdsires for Sale</h2>
<% DetailType = "Sire" %>
  
<!--#Include file="SalesBlastOffListDetails.asp"--> 
<br /><br> 
</td></tr>
<tr><td>

<%
rs.close
 sql = "select saleblastoff.peopleId, saleblastoff.animalID, saleblastoff.startingprice, Price, Photo1, Photo2, Photo3, Photo4,  Photo5, Photo6, Photo7, Photo8, category, FullName, Sold, salepending from saleblastoff, Pricing, Photos, Animals where saleblastoff.animalID = Pricing.ID and saleblastoff.AnimalID = Photos.ID and Animals.ID = saleblastoff.AnimalID and (category = 'Inexperienced Male' or category = 'Unproven Male' )"

'response.write("sql=" & sql)
rs.Open sql, conn, 3, 3 %>
<h2>Jr. Herdsires Alpacas for Sale</h2>
<% DetailType = "Sire" %>


<!--#Include file="SalesBlastOffListDetails.asp"--> 
<br /><br>   
</td></tr>
<tr><td>





<%
rs.close
 sql = "select saleblastoff.peopleId, saleblastoff.animalID, saleblastoff.startingprice, Price, Photo1, Photo2, Photo3, Photo4,  Photo5, Photo6, Photo7, Photo8, category, FullName, Sold, salepending from saleblastoff, Pricing, Photos, Animals where saleblastoff.animalID = Pricing.ID and saleblastoff.AnimalID = Photos.ID and Animals.ID = saleblastoff.AnimalID and (category = 'Experienced Female' or category = 'Proven Female' )"

'response.write("sql=" & sql)
rs.Open sql, conn, 3, 3 %>
<h2>Alpaca Dams for Sale</h2>
<% DetailType = "Sire" %>
   
   
  <!--#Include file="SalesBlastOffListDetails.asp"--> 
 <br /><br> 
</td></tr>
<tr><td>
<%
rs.close
 sql = "select saleblastoff.peopleId, saleblastoff.animalID, saleblastoff.startingprice, Price, Photo1, Photo2, Photo3, Photo4,  Photo5, Photo6, Photo7, Photo8, category, FullName, Sold, salepending from saleblastoff, Pricing, Photos, Animals where saleblastoff.animalID = Pricing.ID and saleblastoff.AnimalID = Photos.ID and Animals.ID = saleblastoff.AnimalID and (category = 'Inexperienced Female' or category = 'Unproven Female' )"

'response.write("sql=" & sql)
rs.Open sql, conn, 3, 3 %>
<h2>Alpaca Maidens for Sale</h2>
<% DetailType = "Sire" %>
   

<!--#Include file="SalesBlastOffListDetails.asp"--> 
<br /><br>
</td></tr>
<tr><td>

<%
rs.close
 sql = "select saleblastoff.peopleId, saleblastoff.animalID, saleblastoff.startingprice, Price, Photo1, Photo2, Photo3, Photo4,  Photo5, Photo6, Photo7, Photo8, category, FullName, Sold, salepending from saleblastoff, Pricing, Photos, Animals where saleblastoff.animalID = Pricing.ID and saleblastoff.AnimalID = Photos.ID and Animals.ID = saleblastoff.AnimalID and (category = 'Non-Breeder' or category = 'Non-Breeders') "

'response.write("sql=" & sql)
rs.Open sql, conn, 3, 3 %>
<h2>Fiber / Pet Quality Alpacas for Sale</h2>
<% DetailType = "Sire" %>
<!--#Include file="SalesBlastOffListDetails.asp"-->    
  <br /><br>   

  
</td></tr></table>
<% end if %>
</td></tr></table>
<!--#Include virtual="/Footer.asp"--> 
</body>
</html>