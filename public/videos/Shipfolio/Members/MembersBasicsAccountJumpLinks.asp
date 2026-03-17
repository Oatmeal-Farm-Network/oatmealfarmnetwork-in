<% ID = request.QueryString("ID")
if len(ID) < 1 then
ID = Request.Form("ID")
end if
%>
<div class="nav" style ="height:65px; vertical-align: bottom">

<div >
    <a class="jumplinks" href="MembersAccountContactsEdit.asp#top"><img src= "https://www.OatmealFarmnetwork.com/icons/Account.svg" alt = "account" height ="64" border = "0"></a>
</div>



<% if Current3 = "Summary" then %>
  <div class="jumplinkscellCurrent" style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" aria-current="page" href="/members/MembersAccountContactsEdit.asp?ID=<%=ID %>"><b>Summary</b></a>
  </div>
<% else %> 
<div class="jumplinkscell" style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" aria-current="page" href="/members/MembersAccountContactsEdit.asp?ID=<%=ID %>">Summary</a>
  </div>
<%end if %>


<% if Current3 = "Password" then %>
 <div class="jumplinkscellCurrent" style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" aria-current="page" href="/members/MembersPasswordChange.asp?ID=<%=ID %>"><b>Password</b></a>
  </div>
<% else %> 
<div class="jumplinkscell" style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" aria-current="page" href="/members/MembersPasswordChange.asp?ID=<%=ID %>">Password</a>
  </div>
<%end if %>

<% 
showfavorite = false
if showfavorite = true then 
if Current3 = "Favorite" then %>
 <div class="jumplinkscellCurrent" style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" aria-current="page" href="/members/MembersAssociations.asp?ID=<%=ID %>"><b>Favorite Assoc.</b></a>
  </div>
<% else %> 
<div class="jumplinkscell" style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" aria-current="page" href="/members/MembersAssociations.asp?ID=<%=ID %>">Favorite Assoc.</a>
  </div>
<% end if %>
<% end if %>


<%
showSubscription = false
if showSubscription = true then 

if Current3 = "Subscription" then %>
 <div class="jumplinkscellCurrent" style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" aria-current="page" href="/members/MembersRenewSubscription.asp?ID=<%=ID %>"><b>Subscription</b></a>
  </div>
<% else %> 
<div class="jumplinkscell" style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" aria-current="page" href="/members/MembersRenewSubscription.asp?ID=<%=ID %>">Subscription</a>
  </div>
<% end if %>
<% end if %>
</div>
<span class="border-bottom-3"></span>
