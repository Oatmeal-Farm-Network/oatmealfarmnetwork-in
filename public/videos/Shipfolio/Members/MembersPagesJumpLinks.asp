<table cellpadding = "0" cellspacing = "0" border = "0" width = "<%=screenwidth -25 %>" height = "28" align = "center">
   <tr>
     <td>
     <% if Current3 = "ListOfPages" then %>
<td class = "tabtopon" width = "160" height = "20" align = "center" ><b><a href = "/Administration/Default.asp#pages" class = "menu2">List of Pages / AGCMS Home</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "160" height = "20" align = "center" ><b><a href = "/Administration/Default.asp#pages" class = "menu">List of Pages / AGCMS Home</a></b></td>
<% end if %> 

<% if AddPages = "Yes" Or AddPages = True Then %>
<% if Current3 = "AddaPage" then %>
<td class = "tabtopon" width = "140" height = "20" align = "center" ><b><a href = "/Administration/AdminPageAdd.asp" class = "menu2">Add a Page</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "140" height = "20" align = "center" ><b><a href = "/Administration/AdminPageAdd.asp" class = "menu">Add a Page</a></b></td>
<% end if %> 


<%  if Current3 = "DeletePage" then %>
<td class = "tabtopon" width = "70" height = "20" align = "center" ><b><a href = "/ADMINISTRATION/AdminpageDeleteList.asp" class = "menu2">Delete</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "70" height = "20" align = "center" ><b><a href = "/ADMINISTRATION/AdminpageDeleteList.asp" class = "menu">Delete</a></b></td>
    <% end if %> 
        <% end if %> 
 <% if AddPages = True then %> 
    <% if Current3 = "PageGroups" then %>
<td class = "tabtopon" width = "110" height = "20" align = "center" ><b><a href = "/Administration/AdminPageGroups.asp" class = "menu2">Page Groups</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "110" height = "20" align = "center" ><b><a href = "/Administration/AdminPageGroups.asp" class = "menu">Page Groups</a></b></td>
<% end if %> 
<% end if %> 


<% if pagename = "Home Page2" then
if Current3 = "FeaturedListings" then %>
<td class = "tabtopon" width = "120" height = "20" align = "center" ><b><a href = "/Administration/ AdminHomePageFetured.asp" class = "menu2">Featured Listings</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "120" height = "20" align = "center" ><b><a href = "/Administration/ AdminHomePageFetured.asp" class = "menu">Featured Listings</a></b></td>
<% end if %> 
<% end if %> 

<% if pagename = "Home Page" then
 if Current3 = "HomePageSlideshow" then %>
<td class = "tabtopon" width = "120" height = "20" align = "center" ><b><a href = "/Administration/AdminGalleryEditImages.asp?GalleryCatID=3" class = "menu2">Slideshow Images</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "120" height = "20" align = "center" ><b><a href = "/Administration/AdminGalleryEditImages.asp?GalleryCatID=3" class = "menu">Slideshow Images</a></b></td>
<% end if %> 
<% end if %> 

  
<% 
Showdiscounts = false
if Showdiscounts = true then
if not pagename = "Home Page"  then%>        
<% if (EcommerceAvailable   = True or ServicesAvailable = True) and not pagename = "Home Page"  then%>       
<%  if Current3 = "Discounts" then %>
<td class = "tabtopon" width = "130" height = "20" align = "center" ><b><a href = "/ADMINISTRATION/AdminDiscounts.asp" class = "menu2">Discounts / Coupons</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "130" height = "20" align = "center" ><b><a href = "/ADMINISTRATION/AdminDiscounts.asp" class = "menu">Discounts / Coupons</a></b></td>
    <% end if %> 

<%  if Current3 = "Payments" then %>
<td class = "tabtopon" width = "110" height = "20" align = "center" ><b><a href = "/ADMINISTRATION/AdminStoreMaintenance.asp" class = "menu2">Payment & Taxes</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "110" height = "20" align = "center" ><b><a href = "/ADMINISTRATION/AdminStoreMaintenance.asp" class = "menu">Payment & Taxes</a></b></td>
    <% end if %>  
<% end if %>  
<% end if %> 
<% end if %> 
<%  
show = false
if show = true then
if Current3 = "Shipping" then %>
<td class = "tabtopon" width = "90" height = "20" align = "center" ><b><a href = "/ADMINISTRATION/AdminPageMaintenance.asp?pagename=Farm Store" class = "menu2">Header</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "90" height = "20" align = "center" ><b><a href = "/ADMINISTRATION/AdminPageMaintenance.asp?pagename=Farm Store" class = "menu">Header</a></b></td>
    <% end if
    end if %> 

<%  if pagename = "FAQ" or Pagelayoutid = 40 then %>
<%  if Current3 = "Heading" then %>
<td class = "tabtopon" width = "10%" height = "20" align = "center" ><b><a href = "/ADMINISTRATION/AdminPageMaintenance.asp?pagelayoutID=<%=PagelayoutID %>" class = "menu2">Heading</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "10%" height = "20" align = "center" ><b><a href = "/ADMINISTRATION/AdminPageMaintenance.asp?pagelayoutID=<%=PagelayoutID %>" class = "menu">Heading</a></b></td>
    <% end if %> 
  <% end if %>   

  <%
  if len(pagename) > 2 then
    showSEO = True
   if showSEO = True and len(session("PageName"))> 0 then 
      if Current3 = "SEO" then %>
<td class = "tabtopon" width = "60" height = "20" align = "center" ><b><a href = "/Administration/AdminEditSEO.asp?PageLayoutID=<%=PageLayoutID%>" class = "menu2">SEO</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "60" height = "20" align = "center" ><b><a href = "/Administration/AdminEditSEO.asp?PageLayoutID=<%=PageLayoutID %>" class = "menu">SEO</a></b></td>
    <% end if %>  
    
    <% showSEOArticle = False
     if (Current3 = "SEO" or Current3 = "SEOArticle") and showSEOArticle = True then
    
     if Current3 = "SEOArticle" then %>
<td class = "tabtopon" width = "110" height = "20" align = "center" ><b><a href = "/Administration/AdminSEOArticle.asp?PageLayoutID=<%=PageLayoutID %>" class = "menu2">About SEO</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "110" height = "20" align = "center" ><b><a href = "/Administration/AdminSEOArticle.asp?PageLayoutID=<%=PageLayoutID %>" class = "menu">About SEO</a></b></td>
    <% end if %>  
       <% end if %>  
    
        <% end if %>  
    <% end if %>       			
   <td >&nbsp;</td>      
</tr>
</table>