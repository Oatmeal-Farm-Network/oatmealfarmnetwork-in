<table border = "0" cellpadding = "0" cellspacing = "0" width = "100%" bgcolor = "white"><tr>
<% if Current2 = "AdminHome"  then %>
<td  height = "20" width = "115" align = "center"  class = "tabBottomOn" align = "center"><b><a href = "/Administration/Default.asp" class = "menu2">Dashboard Home</a></b></td>
<% else %> 
<td  height = "20" width = "115" align = "center"  class = "tabBottomOff" align = "center"><b><a href = "/Administration/Default.asp" class = "menu">Dashboard Home</a></b></td>
<% end if %>
<%

 if peopleID = "1016" then
 if Current2 = "Advertising" then %>
		 <td  height = "20" width = "120" align = "center"  class = "tabBottomOn" align = "center"><b><a href = "/Administration/AdminAdvertisingAdd.asp" class = "menu2">Additional Services</a></b></td>
	   <% else %>
<td  height = "20" width = "120" align = "center"  class = "tabBottomOff" align = "center"><b><a href = "/Administration/AdminAdvertisingAdd.asp" class = "menu">Additional Services</a></b></td>
	   <% end if %>
 <% end if %>	   
<% if Current2 = "AnimalsHome" or Current2 = "AlpacasHome" then %>
		 <td  height = "20" width = "90" align = "center"  class = "tabBottomOn" align = "center"><b><a href = "/Administration/AnimalsHome.asp" class = "menu2">Animals</a></b></td>
	   <% else %>
<td  height = "20" width = "90" align = "center"  class = "tabBottomOff" align = "center"><b><a href = "/Administration/AnimalsHome.asp" class = "menu">Animals</a></b></td>
<% end if %>



<%
showauctions = false
if showauctions = true then

if Current2 = "Auctions" then %>
<td  height = "20" width = "90" align = "center"  class = "tabBottomOn" align = "center"><b><a href = "/Administration/AuctionsHome.asp" class = "menu2">Auctions</a></b></td>
<% else %>
<td height = "20" width = "90" align = "center"  class = "tabBottomOff" align = "center"><b><a href = "/Administration/AuctionsHome.asp" class = "menu">Auctions</a></b></td>
<% end if %>
<% end if %>

<% showpackages = True
if showpackages = true then
 if cint(numAlpacas) > 0 and not SubscriptionLevel= 18 then %>
<% if Current2 = "Packages" then %>
<td  height = "20" width = "90" align = "center"  class = "tabBottomOn" align = "center"><b><a href = "/Administration/PackagesHome.asp" class = "menu2">Packages</a></b></td>
<% else %>
<td  height = "20" width = "90" align = "center"  class = "tabBottomOff" align = "center"><b><a href = "/Administration/PackagesHome.asp" class = "menu">Packages</a></b></td>
<% end if %>
<% end if %>
<% end if %>
<% if not SubscriptionLevel= 18 then %>
<% if Current2 = "Products" then %>
<td  height = "20" width = "120" align = "center"  class = "tabBottomOn" align = "center"><b><a href = "/Administration/ProductsHome.asp" class = "menu2">Products</a></b></td>
<% else %>
<td  height = "20" width = "120" align = "center"  class = "tabBottomOff" align = "center"><b><a href = "/Administration/ProductsHome.asp" class = "menu">Products</a></b></td>
<% end if %>
<% if Current2 = "Properties" then %>
<td  height = "20" width = "100" align = "center"  class = "tabBottomOn" align = "center"><b><a href = "/Administration/PropertiesHome.asp" class = "menu2">Properties</a></b></td>
<% else %>
<td  height = "20" width = "100" align = "center"  class = "tabBottomOff" align = "center"><b><a href = "/Administration/PropertiesHome.asp" class = "menu">Properties</a></b></td>
<% end if %>
<% if Current2 = "Business" then %>
<td  height = "20" width = "100" align = "center"  class = "tabBottomOn" align = "center"><b><a href = "/Administration/AdminBusinessHome.asp" class = "menu2">Businesses</a></b></td>
<% else %>
<td  height = "20" width = "100" align = "center"  class = "tabBottomOff" align = "center"><b><a href = "/Administration/AdminBusinessHome.asp" class = "menu">Businesses</a></b></td>
<% end if %>
<% end if %>
<% ShowServices = False
if ShowServices = True then  
if Current2 = "Services" then %>
<td  height = "20" width = "90" align = "center"  class = "tabBottomOn" align = "center"><b><a href = "/Administration/ServicesHome.asp" class = "menu2">Services</a></b></td>
<% else %>
<td  height = "20" width = "90" align = "center"  class = "tabBottomOff" align = "center"><b><a href = "/Administration/ServicesHome.asp" class = "menu">Services</a></b></td>
<% end if
end if 

if Current2 = "Design" then %>
<td  height = "20" width = "90" align = "center"  class = "tabBottomOn" align = "center"><b><a href = "/Administration/AdminsiteDesign.asp" class = "menu2">Ranch Pages</a></b></td>
<% else %>
<td  height = "20" width = "90" align = "center"  class = "tabBottomOff" align = "center"><b><a href = "/Administration/AdminsiteDesign.asp" class = "menu">Ranch Pages</a></b></td>
<% end if
if Current2 = "Account" then %>
<td  height = "20" width = "90" align = "center"  class = "tabBottomOn" align = "center"><b><a href = "/Administration/AccountContactsEdit.asp" class = "menu2">Your Account</a></b></td>
<% else %>
<td  height = "20" width = "90" align = "center"  class = "tabBottomOff" align = "center"><b><a href = "/Administration/AccountContactsEdit.asp" class = "menu">Your Account</a></b></td>
<% end if %>

<% showreferrals = false
if showreferrals = True then
if Current2 = "Referral Program" then %>
<td  height = "20" width = "120" align = "center"  class = "tabBottomOn" align = "center"><b><a href = "/Administration/ReferaFriend.asp" class = "menu2">Referral Program</a></b></td>
<% else %>
<td  height = "20" width = "120" align = "center"  class = "tabBottomOff" align = "center"><b><a href = "/Administration/ReferaFriend.asp" class = "menu">Referral Program</a></b></td>
<% end if %>
<% end if %>
<% 
'Session("Accesslevel") = 3
if Session("Accesslevel") = 4 then 
if Current2 = "SiteAdmin" then %>
<td  height = "20" width = "90" align = "center"  class = "tabBottomOn" align = "center"><b><a href = "/Administration/Siteadminhome.asp" class = "menu2">Site Admin</a></b></td>
<% else %>
<td  height = "20" width = "90" align = "center"  class = "tabBottomOff" align = "center"><b><a href = "/Administration/Siteadminhome.asp" class = "menu">Site Admin</a></b></td>
<% end if %>
<% end if %>
<td >&nbsp;</td></tr></table><br />