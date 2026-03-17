<% Showpagegroups = False %>



<br /><br />
<a href = "#Top" class = "body"></a>
<div class="nav " style ="min-height: 40px">

   <div >
    <a class="jumplinks" href="MembersAnimalshome.asp?ID=<%=AnimalID %>#top"><img src= "https://www.GlobalLivestockSolutions.com/icons/website.svg" alt = "website" height ="64" border = "0"></a>
  </div>
    <% if Current3 = "ListOfPages" then %>
 <div class="jumplinkscellCurrent" style="vertical-align:bottom; min-height:58px;" >
    <a class="jumplinks" href="/Members/CustSiteAdmin/Default.asp#top"><b>List</b></a><br />
  </div>
<% else %> 
<div class="jumplinkscell" style="vertical-align:bottom; min-height:58px;" >
    <a class="jumplinks" href="/Members/CustSiteAdmin/Default.asp#top">List</a><br />
  </div>
<%end if %>

        <% if Current3 = "AddaPage" then %>
 <div class="jumplinkscellCurrent" style="vertical-align:bottom; min-height:58px;" >
    <a class="jumplinks" href="/Members/CustSiteAdmin/AdminPageAdd.asp#top"><b>Add A page</b></a><br />
  </div>
<% else %> 
<div class="jumplinkscell" style="vertical-align:bottom; min-height:58px;" >
    <a class="jumplinks" href="/Members/CustSiteAdmin/AdminPageAdd.asp#top">Add A page</a><br />
  </div>
<%end if %>


 <% if Current3 = "DeletePage" then %>
 <div class="jumplinkscellCurrent" style="vertical-align:bottom; min-height:58px;" >
    <a class="jumplinks" href="/Members/CustSiteAdmin/AdminpageDeleteList.asp#top"><b>Delete</b></a><br />
  </div>
<% else %> 
<div class="jumplinkscell" style="vertical-align:bottom; min-height:58px;" >
    <a class="jumplinks" href="/Members/CustSiteAdmin/AdminpageDeleteList.asp#top">Delete</a><br />
  </div>
<%end if %>

 <% if Current3 = "Home Page2" then %>
 <div class="jumplinkscellCurrent" style="vertical-align:bottom; min-height:58px;" >
    <a class="jumplinks" href="/Members/CustSiteAdmin/AdminHomePageFetured.asp#top"><b>Featured</b></a><br />
  </div>
<% else %> 
<div class="jumplinkscell" style="vertical-align:bottom; min-height:58px;" >
    <a class="jumplinks" href="/Members/CustSiteAdmin/AdminHomePageFetured.asp#top">Featured</a><br />
  </div>
<%end if %>

 <% if Current3 = "HomePageSlideshow" then %>
 <div class="jumplinkscellCurrent" style="vertical-align:bottom; min-height:58px;" >
    <a class="jumplinks" href="/Members/CustSiteAdmin/AdminGalleryEditImages.asp?GalleryCatID=3#top"><b>Slideshow Images</b></a><br />
  </div>
<% else %> 
<div class="jumplinkscell" style="vertical-align:bottom; min-height:58px;" >
    <a class="jumplinks" href="/Members/CustSiteAdmin/AdminGalleryEditImages.asp?GalleryCatID=3#top">Slideshow Images</a><br />
  </div>
<%end if %>


 <% if Current3 = "Discounts" then %>
 <div class="jumplinkscellCurrent" style="vertical-align:bottom; min-height:58px;" >
    <a class="jumplinks" href="/Members/CustSiteAdmin/AdminDiscounts.asp"><b>Discounts / Coupons</b></a><br />
  </div>
<% else %> 
<div class="jumplinkscell" style="vertical-align:bottom; min-height:58px;" >
    <a class="jumplinks" href="/Members/CustSiteAdmin/AdminDiscounts.asp">Discounts / Coupons</a><br />
  </div>
<%end if %>

 <% if Current3 = "Payments" then %>
 <div class="jumplinkscellCurrent" style="vertical-align:bottom; min-height:58px;" >
    <a class="jumplinks" href="/Members/CustSiteAdmin/AdminStoreMaintenance.asp"><b>Payment & Taxes</b></a><br />
  </div>
<% else %> 
<div class="jumplinkscell" style="vertical-align:bottom; min-height:58px;" >
    <a class="jumplinks" href="/Members/CustSiteAdmin/AdminStoreMaintenance.asp">Payment & Taxes</a><br />
  </div>
<%end if %>



 <% if Current3 = "Header" then %>
 <div class="jumplinkscellCurrent" style="vertical-align:bottom; min-height:58px;" >
    <a class="jumplinks" href="/Members/CustSiteAdmin/AdminPageMaintenance.asp?pagename=Farm Store"><b>Header</b></a><br />
  </div>
<% else %> 
<div class="jumplinkscell" style="vertical-align:bottom; min-height:58px;" >
    <a class="jumplinks" href="/Members/CustSiteAdmin/AdminPageMaintenance.asp?pagename=Farm Store">Header</a><br />
  </div>
<%end if %>

 <% if Current3 = "SEO" then %>
 <div class="jumplinkscellCurrent" style="vertical-align:bottom; min-height:58px;" >
    <a class="jumplinks" href="/Members/CustSiteAdmin/AdminEditSEO.asp?PageLayoutID=<%=PageLayoutID%>"><b>SEO</b></a><br />
  </div>
<% else %> 
<div class="jumplinkscell" style="vertical-align:bottom; min-height:58px;" >
    <a class="jumplinks" href="/Members/CustSiteAdmin/AdminEditSEO.asp?PageLayoutID=<%=PageLayoutID%>">SEO</a><br />
  </div>
<%end if %>


</div>


<span class="border-bottom-3"></span>
