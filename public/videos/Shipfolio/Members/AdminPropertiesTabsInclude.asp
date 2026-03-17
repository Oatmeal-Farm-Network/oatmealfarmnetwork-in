<a href = "#Top" class = "body"></a>
<H1>Products</H1>
<div class="nav">
<% if Current3 = "Add" then %>
 <div class="jumplinkscellCurrent">
    <a class="jumplinks" href="/members/AddaProperty.asp.asp#top"><b>ADD</b></a>
  </div>
<% else %> 
<div class="jumplinkscell">
    <a class="jumplinks" href="/members/AddaProperty.asp#top">ADD</a>
  </div>
<%end if %>

<% if Current3 = "Summary" then %>
 <div class="jumplinkscellCurrent ">
    <a class="jumplinks" href="/members/PropertiesHome.asp"><b>Summary</b></a>
  </div>
<% else %> 
<div class="jumplinkscell  ">
    <a class="jumplinks" aria-current="page" href="/members/PropertiesHome.asp">Summary</a>
  </div>
<%end if %>

<% if Current3 = "Basics" then %>
 <div class="jumplinkscellCurrent ">
    <a class="jumplinks" href="/members/EditProperty0.asp?PropID=<%=PropID %>"><b>Basics</b></a>
  </div>
<% else %> 
<div class="jumplinkscell  ">
    <a class="jumplinks" href="/members/EditProperty0.asp?PropID=<%=PropID %>">Basics</a>
  </div>
<%end if %>

<% if Current3 = "Photos" then %>
 <div class="jumplinkscellCurrent ">
    <a class="jumplinks" href="/members/PropertyPhotos.asp?PropID=<%=PropID %>"><b>Photos</b></a>
  </div>
<% else %> 
<div class="jumplinkscell  ">
    <a class="jumplinks" href="/members/PropertyPhotos.asp?PropID=<%=PropID %>">Photos</a>
  </div>
<%end if %>


<% if Current3 = "Delete" then %>
 <div class="jumplinkscellCurrent ">
    <a class="jumplinks" href="/members/DeleteProperty.asp"><b>Delete</b></a>
  </div>
<% else %> 
<div class="jumplinkscell  ">
    <a class="jumplinks" href="/members/DeleteProperty.asp">Delete</a>
  </div>
<%end if %>



<% if Current3 = "Preview" then %>
 <div class="jumplinkscellCurrent ">
    <a class="jumplinks" href="/members/Preview.asp?PropID=<%=PropID %>" class = "menu2"><b>Preview</b></a>
  </div>
<% else %> 
<div class="jumplinkscell  ">
    <a class="jumplinks" href="/members/Preview.asp?PropID=<%=PropID %>" class = "menu2"><b>Preview</b></a>
  </div>
<%end if %>

    
<% if Current3 = "Preview" then %>
 <div class="jumplinkscellCurrent ">
    <a class="jumplinks" href="/members/PropertyStats.asp" class = "menu2"><b>Statistics</a></b></td>
  </div>
<% else %> 
<div class="jumplinkscell">
    <a class="jumplinks" href="/members/PropertyStats.asp" class = "menu2">Statistics</a></td>
  </div>
<%end if %>



</div>
