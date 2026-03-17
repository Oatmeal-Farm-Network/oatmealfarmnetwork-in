<% ID = request.QueryString("ID")
if len(ID) < 1 then
ID = Request.Form("ID")
end if
%>
<br />
<div class="nav" style ="height:65px; vertical-align: bottom">

<div >
    <a class="jumplinks" href="BusinessAccountSummary.asp#top"><img src= "https://www.GlobalLivestockSolutions.com/icons/Contact-us.png" alt = "account" height ="64" border = "0"></a>
</div>



<% if Current3 = "Summary" then %>
  <div class="jumplinkscellCurrent" style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" aria-current="page" href="/members/BusinessAccountSummary.asp?BusinessID=<%=BusinessID %>"><b>Summary</b></a>
  </div>
<% else %> 
<div class="jumplinkscell" style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" aria-current="page" href="/members/BusinessAccountSummary.asp?BusinessID=<%=BusinessID %>">Summary</a>
  </div>
<%end if %>
<% if Current3 = "Logo" then %>
 <div class="jumplinkscellCurrent" style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" aria-current="page" href="/members/MembersEditLogo.asp?BusinessID=<%=BusinessID %>"><b>Logo</b></a>
  </div>
<% else %> 
<div class="jumplinkscell" style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" aria-current="page" href="/members/MembersEditLogo.asp?BusinessID=<%=BusinessID %>">Logo</a>
  </div>
<%end if %>

<% if Current3 = "Description" then %>
 <div class="jumplinkscellCurrent" style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" aria-current="page" href="/members/MembersEditListingDescription.asp?BusinessID=<%=BusinessID %>"><b>Description</b></a>
  </div>
<% else %> 
<div class="jumplinkscell" style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" aria-current="page" href="/members/MembersEditListingDescription.asp?BusinessID=<%=BusinessID %>">Description</a>
  </div>
<%end if %>



 <% if Current3 = "Subscriptions" then %>
 <div class="jumplinkscellCurrent" style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" aria-current="page" href="/members/MembersRenewSubscription.asp?BusinessID=<%=BusinessID %>"><b>Subscription</b></a>
  </div>
<% else %> 
<div class="jumplinkscell" style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" aria-current="page" href="/members/MembersRenewSubscription.asp?BusinessID=<%=BusinessID %>">Subscription</a>
  </div>
<%end if %>

    
    <% if Current3 = "Favorite" then %>
 <div class="jumplinkscellCurrent" style="vertical-align:bottom; min-height:58px; min-width: 150px" ><br />
    <a class="jumplinks" aria-current="page" href="/Members/MembersAssociations.asp?BusinessID=<%=BusinessID %>"><b>Favorite Association</b></a>
  </div>
<% else %> 
<div class="jumplinkscell" style="vertical-align:bottom; min-height:58px; min-width: 150px" ><br />
    <a class="jumplinks" aria-current="page" href="/Members/MembersAssociations.asp?BusinessID=<%=BusinessID %>">Favorite Association</a>
  </div>
<%end if %>

    




</div>
<span class="border-bottom-3"></span>
