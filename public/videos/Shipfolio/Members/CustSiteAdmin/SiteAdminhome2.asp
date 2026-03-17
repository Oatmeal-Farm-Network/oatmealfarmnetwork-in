<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<title><%=Sitenamelong %> Administration</title>
<meta name="Title" content="<%=Sitenamelong %> Administration"/>
<meta name="robots" content="nofollow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="revisit-after" content="1"/>
<meta name="Googlebot" content="nofollow"/>
<link rel="shortcut icon" href="/infinityknot.ico" /> 
<link rel="icon" href="http://www.alpacainfinity.com/infinityknot.ico" /> 
<meta name="author" content="The Andresen Group"/>
<link rel="stylesheet" type="text/css" href="/style.css" />

</HEAD>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center">
<!--#Include file="AdminGlobalVariables.asp"-->
<% Current2="AdminHome" %> 
<!--#Include file="adminHeader.asp"-->
<% If not rs.State = adStateClosed Then
rs.close
End If   	
%>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" bgcolor = "white" width = "100%"><tr><td class = "roundedtop" align = "left">
		<H1><div align = "left">Dashboard Home</div></H1>
		<% FirstTime = request.QueryString("FirstTime")
		if FirstTime = True then %>
		<H2>Welcome To <%=Sitenamelong %>!</H2>
		You can use the tabs at the top of the page to navigate to the different features that we offer. We recomend that you start by setting up the graphics for your <a href = "AdminsiteDesign.asp" class = "body">Farm Pages</a> by selecting the Farm Pages tab.<br />
		<br />And when you are ready for the world to see your pages, animals, and products come back to this page, the dashboard home, and select the Publish! button.
		<% end if %>
</td></tr>
<tr><td class = "roundedBottom" align = "center">
<% if session("FirstTime") = True then %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "950">
<tr><td class = "roundedtop" align = "left"><h2>Welcome to <%=Sitenamelong %>!</h2></td></tr>
 </td></tr>
<tr><td class = "roundedBottom body" >
 To get start we recommend that you visit some of the following pages in the Administration Dashboard:
<ul>
<li><a href = "AccountContactsEdit.asp" class = "body">Your Account</a> - take a moment and make sure that your information is complete.</li>
<li><a href = "AdminsiteDesign.asp" class = "body">Farm Pages</a> - customize your farm pages (define colors & fonts, upload graphics, enter text about your business.)</li>
<li><a href = "AdminAnimalAdd1.asp" class = "body">Add <%=AnimalsSold %></a> - use our easy Add a New Animal Wizard to start entering your <%=AnimalsSold %>.</li>
<li><a href = "PlaceClassifiedAd0.asp" class = "body">Add Products</a> - enter your products for sale.</li>
</ul>
</td></tr>
</table>
<br />
<% end if %>
<%showad = False 
if showad = true then%>
<br /><a href ="/Administration/AdminAdvertisingAdd.asp"><img src = "/uploads/addiscountBannerad775pixels.jpg" border = "0" width = "775" height = "100" Alt = "Advertise online your <%=AnimalsSold %>"/></a>
<% end if %>
<table border = "0" width = "<%=screenwidth %>"  bgcolor = "white" cellpadding=0 cellspacing=0  align = "center" >
<tr><td width = "475" valign = "top">
<% 
If Request.Querystring("SetLive" ) = "False" Then
Query =  " UPDATE people Set "
Query =  Query & " AIPublish = False"
Query =  Query & " where PeopleID = " & PeopleID & ";" 
Conn.Execute(Query) 
response.redirect("Default.asp?PeopleID=" & PeopleID & "#Status")
end if 
If Request.Querystring("SetLive" ) = "True" Then
Query =  " UPDATE people Set "
Query =  Query & " AIPublish = True"
Query =  Query & " where PeopleID = " & PeopleID & ";" 
Conn.Execute(Query) 
response.redirect("Default.asp?PeopleID=" & PeopleID & "#Status")
end if 
sql = "select AIPublish from People  where PeopleID = " & Session("PeopleID") 
rs.Open sql, conn, 3, 3   
AIPublish = rs("AIPublish")
rs.close
%>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtopandbottom" align = "left">
		<H1><div align = "left">Your Account</div></H1>
<a name="Status"></a>
<table><tr><td class = "body2" align = "left" width = "180">
Membership level:
</td>
<td class = "body" width = "<%=screenwidth - 120 %>">
<% if SubscriptionLevel= 1 then %>
<b>Copper</b>
<% end if %>
<% if SubscriptionLevel= 2 then %>
<b>Silver</b>
<% end if %>
<% if SubscriptionLevel= 3 then %>
<b>Gold</b>
<% end if %>
<% if SubscriptionLevel= 4 then %>
<b>Platinum</b>
<% end if %>
</td>
</tr>
<% if SubscriptionLevel= 1 then %>
<td class = "body2" align = "left" colspan = "2">
<b>With a Copper Membership only 5 <%=AnimalsSold %> and 5 products may be published at a time. Use the button below to upgrade and start publishing more products and animals.</b>
</td>
</tr>
<% end if %>
<tr>
<td   colspan = '2' align = "center"><a href = "AdminRenewSubscription.asp?PeopleID=<%=peopleID %>" class = "regsubmit2"><font face="verdana" size = '2'>Renew or Upgrade Your Membership</font></a><br /><br />
</td>
</tr></table>



  <% if AIPublish = "False"  then %> 
     <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=2 cellspacing=2  width = "475" align = "center">
<tr>
	<td class = "body2" width = "350" align = "left">
		<h2><font color = 'brown'><b>Status - Un-Published</b></font></h2>
		Before your animals and information will show up on <%=Sitenamelong %>, you need to select the "Publish" button below:
		
		<td class = "body" align = "center" valign = "bottom">
   <form  name=form method="post" action="Default.asp?PeopleID=<%=PeopleID%>&SetLive=True">
		
		<center><input type="Submit"  value="Publish!"  class = "regsubmit2" ></center><br>
		
		
  		</form> 
  		</td>
  		<tr><td  class = "body"><a href = "AccountContactsEdit.asp" class = "body">Update Your Account Information</a><br />
		<a href = "AdminPasswordChange.asp" class = "body">Reset Your Password</a><br />
		</td>
		</tr>
  	</tr>
  	</table>
<% else %>
     <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=2 cellspacing=2 " width = "475" align = "center">
<tr>
		<td class = "body2" width = "300" align = "left">
		<h2>Status - Published</h2>
		Your information is published and available for people to view.
		If you wish to un-publish your information please select the button to the right. You will be able to re-publish your information later if you wish.<br /> </td>
		<td class = "body" align = "center" valign = "bottom">
		<form  name=form method="post" action="Default.asp?PeopleID=<%=PeopleID%>&SetLive=False">
		
		<input type="Submit"  value="Un-Publish!" class = "regsubmit2" ><br>
  		</form> 

   </td>
   </tr>
  </table>
  <% end if %>
   </td>
   </tr>
  </table>
<br />

<% 
showauctions = False

 if showauctions =  True then%>


<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "475"><tr><td class = "roundedtopandbottom" align = "left">
		<H1><div align = "left">Auctions</div></H1>

<% sql = "select * from AuctionDutch where PeopleId= '" & PeopleID & "' order by AuctionLevel"

'response.write (sql)

rs.Open sql, conn, 3, 3   
rowcount = 1
dim AuctionDutchID(40000) 
dim AuctionLevel(40000)
dim AuctionDutchTitle(40000) 
Recordcount = rs.RecordCount +1

%>
<a Name= "Auctions" ></a>


<table border = "0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "475">
	<tr><td class = "body" colspan = "3"><div align = "center"><a href = "AdminAdvertisingAdd.asp" class = "body"><b>Sign Up For New Auctions</b></a>&nbsp;</div><br></td></tr>
	
<% if rs.eof Then %>
<tr>
   <td class = "body" align = "left">Currently you do not have any auctions listed. To sign up for auctions please select <a href = "AdminAdvertisingAdd.asp" class = "body"><b>Additional Services</b></a>
</td>
</tr>
<% Else %>
<tr>
<td class = "body2" align = "left" ><b>ID</b></td>
<td class = "body2" align = "left" ><b>Name</b></td>
<td class = "body2" align = "left"   ><b>Level</b></td>
</tr>
<% End If 
row = "odd"
While  Not rs.eof  
If row = "even" Then
ow = "odd"
Else
row = "even"
End if
AuctionDutchID(rowcount) =   rs("AuctionDutchID")
AuctionDutchTitle(rowcount) =   rs("AuctionDutchTitle")
AuctionLevel(rowcount) =   rs("AuctionLevel")

 auctionstartdate = rs("AuctionStartDateMonth") & "/" & rs("AuctionStartDateDay") & "/" & rs("AuctionStartDateYear")
 'response.Write("auctionstartdate=" & auctionstartdate )
if len(auctionstartdate) > 2 then
     TimePast = DateDiff("s", auctionstartdate, now)
		TotalAuctionSeconds=3628800 
		secondsRemaining =  TotalAuctionSeconds - TimePast 
		Daysremaining = round(secondsRemaining / 86400,0)
		MinutesRemainder = round((secondsRemaining - (Daysremaining * 86400)) / 60, 0) 
end if
if secondsRemaining > 0 or len(auctionstartdate) < 3 then	
If row = "even" Then %>
   <tr>
 <% Else %>
	<tr>
 
<%	End If %>
	<td  class = "body"  width = "250" height = "20" align = "left"><a href = "EditDutchAuction.asp?AuctionDutchID=<%= AuctionDutchID( rowcount)%>" class = "body"><%= AuctionDutchID( rowcount)%></a></td>
	<td  class = "body"  width = "250" height = "20" align = "left"><a href = "EditDutchAuction.asp?AuctionDutchID=<%= AuctionDutchID( rowcount)%>" class = "body"><% if len(AuctionDutchTitle(rowcount)) > 0 then%>
	<%= AuctionDutchTitle(rowcount)%>
	<% else %>
	       Not Set Yet 
	<% end if %></a></td>
		<td  class = "body"  width = "250" height = "20" align = "left"><a href = "EditDutchAuction.asp?AuctionDutchID=<%= AuctionDutchID( rowcount)%>" class = "body"><%=AuctionLevel( rowcount)%></a></td>

	<td class = "body" align = "center" ><a href = "EditDutchAuction.asp?AuctionDutchID=<%= AuctionDutchID( rowcount)%>" class = "body">&nbsp;&nbsp;<img src= "images/edit.gif" alt = "edit" height ="18" border = "0"></a>
		</td>
</tr>
<%
end if

 rowcount = rowcount + 1
	   rs.movenext
	Wend
TotalCount=rowcount 
	rs.close
 %>
</table>
</td>
</tr>
</table>
<br />
<% end if %>

<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "475"><tr><td class = "roundedtopandbottom" align = "left">
<H1><div align = "left">Animals</div></H1>
<% sql = "select distinct animals.ID, animals.speciesID, FullName, Category, Breed, PublishForSale, Pricing.*, ShowOnOurHerdPage from Animals, Pricing  where Animals.ID = Pricing.ID and PeopleID = " & Session("PeopleID") & " order by SpeciesID, Breed, FullName"
rs.Open sql, conn, 3, 3   
rowcount = 1
dim ID(40000) 
dim CurrentPrice(40000)
dim	Name(40000) 
dim	ForSale(40000) 
dim	Category(40000) 
dim	Breed(40000) 
dim Price(40000)
dim	Discount(40000)
dim DiscountPrice(40000)
Dim ShowOnABH(40000)
Dim	ShowOnAC(40000)
Dim	ShowOnASZ(40000)
Dim	ShowOnAP(40000)
Dim	ShowOnAIA(40000)
Dim ShowOnWebsite(40000)
Dim ShowOnOurHerdPage(40000)
Dim PublishForSale(40000)
Dim SpeciesID(40000)
Recordcount = rs.RecordCount +1
%>
<a Name= "<%=AnimalsSold %>" ></a>
<table border = "0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "475">
<tr><td class = "body" colspan = "3"><div align = "center"><a href = "AdminAnimalAdd1.asp" class = "body"><b>Add an Animal</b></a>&nbsp;| &nbsp;<a href = "<%=AnimalsSold %>Stats.asp" class = "body"><b>View Statistics</b></a></div><br></td></tr>
<% if rs.eof Then %>
<tr><td class = "body" align = "left">Currently you do not have any <%=AnimalsSold %> listed. To add animals please us the <a href = "AdminAnimalAdd1.asp" class = "body"><b>Add An Animal wizard.</b></a>
</td></tr>
<% Else %>
<tr>
<td class = "body2" align = "center" ><b>Name</b></td>
<td class = "body2" align = "center" width= "80" ><b>Species</b></td>
<td class = "body2" align = "center" with = "170"><b>Published</b></td>
<td class = "body2" align = "center" width = "50"><b>Price</b></td>
<td class = "body2" align = "center" width = "50"><b>Options</b></td>
</tr>
<% End If 
row = "odd"
While  Not rs.eof  
SpeciesName = ""
SpeciesID(rowcount) = rs("SpeciesID")
if SpeciesID(rowcount) = 2 then
SpeciesName="Alpaca" 
end if 
if SpeciesID(rowcount) = 3 then
SpeciesName="Dog"
end if 
if SpeciesID(rowcount) = 4 then
SpeciesName="Llama"
end if 
if SpeciesID(rowcount) = 5 then
SpeciesName="Horse"
end if 
if SpeciesID(rowcount) = 6 then
SpeciesName="Goat"
end if 
if SpeciesID(rowcount) = 7 then
SpeciesName="Donkey"
end if 
if SpeciesID(rowcount) = 8 then
SpeciesName="Cattle"
end if 
if SpeciesID(rowcount) = 9 then
SpeciesName="Bison"
end if 
if SpeciesID(rowcount) = 10 then
SpeciesName="Sheep"
end if 
if SpeciesID(rowcount) = 11 then
SpeciesName="Rabbit"
end if 
if SpeciesID(rowcount) = 12 then
SpeciesName="Pig"
end if 
if SpeciesID(rowcount) = 13 then
SpeciesName="Chicken"
end if 
if SpeciesID(rowcount) = 14 then
SpeciesName="Turkey"
end if 
if SpeciesID(rowcount) = 15 then
SpeciesName="Duck"
end if 
if  SpeciesID(rowcount) = 16 then
SpeciesName="Cat"
end if 
ID(rowcount) =   rs("ID")
Name(rowcount) =   rs("FullName")
Category(rowcount) =   rs("Category")
Breed(rowcount)=   rs("Breed")
Price(rowcount)=   rs("Price")
CurrentPrice(rowcount) = Price(rowcount) 
ForSale(rowcount)=   rs("ForSale")
Discount(rowcount)=   rs("Discount")
DiscountPrice(rowcount) = Price(rowcount) - (Price(rowcount) * (Discount(rowcount)/100))
if len(DiscountPrice(rowcount)) > 0 then
    CurrentPrice(rowcount) = DiscountPrice(rowcount) 
end if
ForSale(rowcount) = rs("ForSale")
ShowOnAC(rowcount)= rs("showonAC")
ShowOnASZ(rowcount)= rs("showonASZ")
ShowOnAP(rowcount)= rs("showonAP")
ShowOnAIA(rowcount)= rs("showonAIA")
ShowOnWebsite(rowcount) = rs("ShowOnWebsite")
ShowOnOurHerdPage(rowcount)= rs("ShowOnOurHerdPage")
PublishForSale(rowcount)= rs("PublishForSale")
If row = "even" Then 
row = "odd" %>
<tr bgcolor = "#F7E4D9">
<% Else 
 row = "even"%>
<tr>
<%	End If %>
<td  class = "body"  height = "20" align = "left"><a href = "EditAnimal.asp?ID=<%= ID( rowcount)%>#BasicFacts" class = "body"><%= Name( rowcount)%></a></td>
<td class = "body2" align = "center">
<% =SpeciesName %>
</td>
<td class = "body2" align = "center">
<% if PublishForSale(rowcount) = True then%>&#10003;<% end if %>
</td>

<td class = "body" align = "right"  width = "90">
<div align = "right"><% If  CurrentPrice(rowcount) > 0 Then %>
<%= FormatCurrency(CurrentPrice(rowcount) ,00)%><img src = "images/px.gif" width = "30" height = "1" />
<% Else %>
N/A<img src = "images/px.gif" width = "30" height = "1" />
<% End If %></div>
</td>
<td class = "body" align = "center" ><a href = "EditAnimal.asp?ID=<%= ID( rowcount)%>#BasicFacts" class = "body">&nbsp;&nbsp;<img src= "images/edit.gif" alt = "edit" height ="18" border = "0"></a>|&nbsp;<a href = "AdminPhotos.asp?ID=<%= ID( rowcount)%>" class = "body"><img src= "images/Photo.gif" alt = "edit" height ="18" border = "0"></a><br></td></tr>
<% rowcount = rowcount + 1
rs.movenext
Wend
TotalCount=rowcount 
rs.close
set rs=nothing
%>
</table>
</td>
</tr>
</table>
</td>
<td width = "5"><img src = "images/px.gif" height = "1" width = "1" /></td>
<td valign = "top">

  <% ' Good: MSIE, Chrome, America Online
	   ' Mozilla, Safari bad 
	   If InStr(1, Request.ServerVariables("HTTP_USER_AGENT"), "Opera") then %>
	   
	   <table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "425"><tr><td class = "roundedtopandbottom" align = "left">
		<H1><div align = "left">Browser Compatibility</div></H1>
<br />
	   
  <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=2 cellspacing=2  width = "425" align = "center">
<tr>
		<td class = "body" >

		<font color = "brown"><b>Warning!</b></font> This website was not built to be compatible with the browser that you are using, which means that some features may not be available to you. We recommend that you use  <a href = "http://windows.microsoft.com/en-US/internet-explorer/downloads/ie" target = "blank" class = "body">Internet Explorer</a>, <a href = "https://www.google.com/intl/en/chrome/browser/" target = "blank" class = "body">Chrome</a>, or <a href = "http://www.mozilla.org/en-US/firefox/new/" target = "blank" class = "body">Mozilla</a> to view this website.<br /></blockquote>
</td>
	    </tr>
	   </table>
</td>
	    </tr>
	   </table>
	   <br />
<% End If %> 

  <table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "445"><tr><td class = "roundedtopandbottom" align = "left">
		<H1><div align = "left">Key</div></H1>
<br />


<table border = "0" cellpadding = "0" cellspacing="0"  align = "center">
 <tr>
 <td class = "body" width = "30" align = "right"><img src = "images/preview_on.gif" height = "18" border = "0" alt = "View Registration"></td>
 <td class = "body" width=  "35">View</td>
  <td class = "body" width = "30" align = "right"><img src= "images/edit.gif" alt = "edit" height = "18"  border = "0"></td>
 <td class = "body" width=  "35">Edit</td>
  <td class = "body" width = "30" align = "right"><img src = "images/delete.jpg" height = "18"" border = "0" alt = "Delete Registration"></td>
 <td class = "body" width=  "35" >delete</td>
   <td class = "body" width = "30" align = "right"><img src = "images/Photo.gif" height = "18" border = "0" alt = "Upload Photos"></td>
 <td class = "body" width=  "40" align = "left">Photos</td>
    <td class = "body" width = "30" align = "right"><img src= "images/Layout.gif"  height = "18" border = "0" alt = "Upload Photos"></td><td class = "body" align = "left">Layout Design</td>
    <td></td>
    
    </tr>
</table></td></tr></table>
<br />
<% showadditionalservices = false 
if showadditionalservices = true then %>

<!--#Include virtual="/conn.asp"-->
  <table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "445"><tr><td class = "roundedtopandbottom" align = "left">
		<H1><div align = "left">Additional Services</div></H1>
<% Query =  "Select Account From People where PeopleID=" & PeopleID 
rs.Open Query, conn, 3, 3
	if not rs.eof then 
	  CurrentAccount = rs("Account")
	end if
rs.close %>
<% if CurrentAccount > 0 then %>
<a class="tooltip" href="#"><b>Your Advertising Account Funds Available:</b><span class="custom info"><img src="/images/logoTip.png" alt="<%=Sitenamelong %> Screen Tip" height="48" width="48" /><em>Advertising Account</em>Sometimes you may receive credit (as a result of an <%=Sitenamelong %> promotion) that can be used for advertising with <%=Sitenamelong %>. This credit goes into your advertising account. Funds in your Advertising Account may only be used for advertising with <%=Sitenamelong %> and may not be withdrawn. Advertising Account funds are non transferable.</span></a>  <%=formatcurrency(CurrentAccount,2) %><br><% end if %>
<a href = "AdminAdvertisingAdd.asp" class = "body"><b>Sign up for Advertising and other additional services!</b></a><br>
<a href = "Advertisinghome.asp" class = "body">Manage Your Advertisements.</a><br>
</td></tr></table>

<br />

  <table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "445"><tr><td class = "roundedtopandbottom" align = "left">
		<H1><div align = "left">Farm Pages</div></H1>
<a href = "AdminsiteDesign.asp" class = "body">Farm Pages Design (colors, fonts, ect.)</a><br />
<a href = "Ranchhomeadmin.asp?PeopleID=<%=PeopleID %>" class = "body">Home Page</a><br />
<a href = "PageData2.asp?pagename=About Us&PeopleID=<%=PeopleID %>" class = "body">About Us Page</a><br />
</td></tr></table>

<br />
<% end if %>

<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "425"><tr><td class = "roundedtopandbottom" align = "left">
		<H1><div align = "left">Packages</div></H1>
	<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding="0" cellspacing="0" width = "425">
	<tr><td class = "body" colspan = "3"><div align = "center"><a href = "PackagesAdd.asp" class = "body"><b>Add a Package</b></a>&nbsp;| &nbsp;<a href = "PackageStats.asp" class = "body"><b>Package Statistics</b></a></div>
	<br />
	</td></tr>
<%

 sql = "select * from Package where PeopleID =  " & session("PeopleID") & ""

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	rowcount = 1
	dim PackageID(200)
	dim PackagePrice(200)
	dim Value(200)
	dim PackageName(200)
	dim Description(200)
	Dim MADLotID(200)

Recordcount = rs.RecordCount +1

if rs.eof  then%>
<tr>
   <td class = "body" align = "left"><b>Currently you do not have any packages. To create a package please <a href= "packagesadd.asp" class = "body"><b>click here</b></a>.
	</td>
</tr>
<% else %>
<tr>
		<td class = "body" align = "center" width = "265"><b>Name</b></td>
		<td class = "body" align = "center" width = "100"><b>Price</b></td>
		<td class = "body" width = "100" align = "center"><b>Options</b></td>
 </tr>
<%
even = True
rowcount = 1
 While  Not rs.eof     
	 PackageID(rowcount) =   rs("PackageID")
	 PackageName(rowcount) =   rs("PackageName")
	 PackagePrice(rowcount) =   rs("PackagePrice")
	  Value(rowcount) =   rs("PackageValue")
	 Description(rowcount) =   rs("Description")

If even = True then
	even = False
Else
	even = True
End If 

If even = True then
%>
   <tr>
<% Else %>
<tr>
<% End If %>
	
		<td class = "body"  align = "left">
		<b><a href = "AddaPackageStep4.asp?PackageID=<%= PackageID(rowcount)%>" class = "body"><%= PackageName(rowcount)%></a></b> 
		</td>
		<td class = "body"  align = "right" >
		<% if len(PackagePrice(rowcount)) > 1 Then %>
			<%= formatcurrency(PackagePrice(rowcount), 2) %>
		<% Else %>
		Not Assigned
		<% end if %>

		</td>
		<td  align = "right">
	<a href = "AddaPackageStep4.asp?PackageID=<%= PackageID(rowcount)  %>" class = "body"><img src= "images/edit.gif" alt = "edit" height ="18" border = "0"></a> |
<a href = "EditPackageLayout2.asp?PackageID=<%= PackageID(rowcount)  %>" class = "body"><img src= "images/Layout.gif" alt = "edit" height ="18" border = "0"></a>

		</td>
		</tr>
		
<%
		rowcount = rowcount + 1
	   rs.movenext
	Wend
TotalCount=rowcount 

 end if%>
<tr><td></td></tr>
</table>

</td></tr>
</table>
<br />
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "425"><tr><td class = "roundedtopandbottom" align = "left">
		<H1><div align = "left">Products & Fleece</div></H1>
	<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding="0" cellspacing="0" width = "425">
	<tr><td class = "body" colspan = "3"><div align = "center"><a href = "PlaceClassifiedAd0.asp" class = "body"><b>Add a Product</b></a>&nbsp;| &nbsp;<a href = "ProductStats.asp" class = "body"><b>Product Statistics</b></a></div>
	<br />
	</td></tr>
	
	
	
	
<%  dim prodID(99999) 
dim prodName(99999)  
dim prodPrice(99999) 
dim ProdForSale(99999) 
dim ProdQuantityAvailable(99999)
dim catName(99999)
dim subcategoryName(99999)
sql = "select * from sfProducts, sfcategories where sfProducts.prodcategoryID = sfcategories.catID and PeopleID = " & session("PeopleID") & " order by catName, Prodname"



    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3 
    if not rs.eof then  
	rowcount = 1


%><br>



<table width = "424"   border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>
<td class = "body" align = "center" ><b>Item</b></td>
<td class = "body" align = "center" width = "50" ><b>QTY</b></td>
<td class = "body" align = "center" width = "50" ><b>For Sale</b></td>
<td class = "body" align = "center"width = "29" ><b>Price </b></td>
<td class = "body" align = "center" ><b>Options</b></td>
</tr>
<% row = "odd"
While  Not rs.eof  
If row = "even" Then
row = "odd"
Else
row = "even"
End if
prodID(rowcount) =   rs("prodID")
prodName(rowcount) =   rs("prodName")
prodPrice(rowcount) =   rs("prodPrice")
ProdForSale(rowcount) =   rs("ProdForSale")
ProdQuantityAvailable(rowcount)  =   rs("ProdQuantityAvailable")
catName(rowcount)  =   rs("catName")
showstats = True
 If row = "even" Then %>
<tr>
<% Else %>
<tr bgcolor = "#F7E4D9" >
<%	End If %>
</td>
<td class = "body" width = "250" align = "left">
<a href = "EditAd2.asp?prodID=<%= prodID( rowcount)%>#BasicFacts" class = "body"><%= prodName( rowcount)%></a>
</td>
<td class = "body" align = "center" >
<%=ProdQuantityAvailable(rowcount) %>
</td>
<td class = "body" align = "center" >
<%=ProdForSale(rowcount) %>
</td>
<td class = "body" width = "29" align = "right">
<% if len(prodPrice(rowcount)) > 0 then%>
<%=  formatcurrency(prodPrice(rowcount)) %>
<% else %>    
$0
<% end if %>
</td>
<td class = "body" align = "center" ><a href = "EditAd2.asp?prodID=<%= prodID( rowcount)%>#BasicFacts" class = "body">&nbsp;&nbsp;<img src= "images/edit.gif" alt = "edit" height ="12" border = "0"></a>|&nbsp;<a href = "ProductsUploadPhotos.asp?prodID=<%=prodid( rowcount)%>" class = "body"><img src= "images/Photo.gif" alt = "edit" height ="14" border = "0"></a><br>
		</td>
		</tr>
<% 

		rowcount = rowcount + 1
	   rs.movenext

	Wend
TotalCount=rowcount 
	rs.close
  set rs=nothing
end if
 %>


</table>
	
		
	
<tr><td></td></tr>
</table>

<% showpages = false

if showpages = true then %>
<br />	
	
	   <table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "425"><tr><td class = "roundedtopandbottom" align = "left">
		<H1><div align = "left">Ranch Pages</div></H1>
<br />

<% 
If Request.Querystring("UpdatePages" ) = "True" Then
ShowSitePages = request.Form("ShowSitePages")
  		sqlp = "select * from RanchpageLayout where PeopleID = " & PeopleID
			Set rsp = Server.CreateObject("ADODB.Recordset")
			rsp.Open sqlp, conn, 3, 3
			if not rsp.eof then 
			 while Not rsp.eof 
			 PageName = rsp("PageName")
			str1 = ShowSitePages 
			str2 = PageName
			If InStr(str1, str2) > 0 Then
				Query =  " UPDATE RanchpageLayout Set "
Query =  Query & " ShowPage = True"
Query =  Query & " where PeopleID = " & PeopleID & " and PageName = '" & PageName & "' ;" 
    Conn.Execute(Query) 

			
	else
				Query =  " UPDATE RanchpageLayout Set "
Query =  Query & " ShowPage = False"
Query =  Query & " where PeopleID = " & PeopleID & " and PageName = '" & PageName & "' ;" 

       Conn.Execute(Query) 
  
			End If  
			
			 rsp.movenext
			wend 
		 end if 
end if
	' End Update Pages %>
 
<form  name=UpdatePagesform method="post" action="Default.asp?PeopleID=<%=PeopleID%>&UpdatePages=True#pages">

	<table border = "0"  width = "425" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "center">
	<tr bgcolor = "#eeeeee">
	<td class = "body" align = "center" width = "100" height = "25"><a name="pages"></a><b>Page</b></td>
	<td class = "body" align = "center" width = "200"><b>Include on Ranchsite</b></td>
	<td class = "body"  align = "center" ><b>Actions</b></td>
	</tr>

	
	
	
		
<% 
order = "odd"	
sql2 = "select * from RanchPageLayout where PeopleID = " & PeopleID & " order by LinkOrder"	
	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	
	While Not rs2.eof 
	ShowPage = rs2("ShowPage")
	
	 if order = "even" then
	  	order = "odd" %>
	  	<tr bgcolor = "#eeeeee">
	  	
	 <% else
	     order = "even" %>
	 	<tr bgcolor = "white">    
	<% end if %> 
 
 	 <td class = "body">&nbsp;<a href = "<%=rs2("EditLink")%>" class= "body" ><%=rs2("PageName")%></a></td>
 	 	<td class = "body" align = "center" width = "80">
 	 	<% if rs2("PageName") ="Home" then %>
 	 	Always
 	 	    <% else %>   
 	 	<% if ShowPage  = True then %>
 	 	    <input type="checkbox" name="ShowSitePages" value="<%=rs2("PageName") %>" checked>Yes
 	 	<% else %>
 	 	    <input type="checkbox" name="ShowSitePages" value="<%=rs2("PageName") %>" >No
 	 	<% end if %>
 	 	<% end if %>
 	 	</td>
	 </tr>
 <% 
	rs2.movenext
 Wend %>

		<tr>
	<td class = "body" colspan = "3" align = "center">
	<input type="submit"  value="Submit" class = "Regsubmit2" ><br>

	</td>
	</tr>

</form>
</table>


</td>
</tr>
</table>
<% end if %>
</td>
</tr>
</table>

	</td>
</tr>
</table>

</td>
</tr>
</table>
</td>
</tr>
</table>
      <!--#Include virtual="/Footer.asp"--> 
</body></html>