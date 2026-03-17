<% ID = request.QueryString("ID")
if len(ID) < 1 then
ID = Request.Form("ID")
end if


%>


 
 

<a href = "#Top" class = "body"></a>
<h1>Account</h1>
<div class="nav">

<% if Current3 = "Summary" then %>
 <div class="jumplinkscellCurrent">
    <a class="jumplinks" aria-current="page" href="/members/MembersAccountContactsEdit.asp?ID=<%=ID %>"><b>Summary</b></a>
  </div>
<% else %> 
<div class="jumplinkscell  ">
    <a class="jumplinks" aria-current="page" href="/members/MembersAccountContactsEdit.asp?ID=<%=ID %>">Summary</a>
  </div>
<%end if %>

<% if Current3 = "Logo" then %>
 <div class="jumplinkscellCurrent">
    <a class="jumplinks" aria-current="page" href="/members/MembersEditLogo.asp?ID=<%=ID %>"><b>Logo</b></a>
  </div>
<% else %> 
<div class="jumplinkscell  ">
    <a class="jumplinks" aria-current="page" href="/members/MembersEditLogo.asp?ID=<%=ID %>">Logo</a>
  </div>
<%end if %>



<% if Current3 = "Password" then %>
 <div class="jumplinkscellCurrent">
    <a class="jumplinks" aria-current="page" href="/members/MembersPasswordChange.asp?ID=<%=ID %>"><b>Password</b></a>
  </div>
<% else %> 
<div class="jumplinkscell  ">
    <a class="jumplinks" aria-current="page" href="/members/MembersPasswordChange.asp?ID=<%=ID %>">Password</a>
  </div>
<%end if %>


<% if Current3 = "Associations" then %>
 <div class="jumplinkscellCurrent">
    <a class="jumplinks" aria-current="page" href="/members/MembersAssociations.asp?ID=<%=ID %>"><b>Associations</b></a>
  </div>
<% else %> 
<div class="jumplinkscell  ">
    <a class="jumplinks" aria-current="page" href="/members/MembersAssociations.asp?ID=<%=ID %>">Associations</a>
  </div>
<%end if %>


    <% if Current3 = "Subscriptions" then %>
 <div class="jumplinkscellCurrent">
    <a class="jumplinks" aria-current="page" href="/members/MembersRenewSubscription.asp?ID=<%=ID %>"><b>Subscriptions</b></a>
  </div>
<% else %> 
<div class="jumplinkscell  ">
    <a class="jumplinks" aria-current="page" href="/members/MembersRenewSubscription.asp?ID=<%=ID %>">Subscriptions</a>
  </div>
<%end if %>

</div>
<span class="border-bottom-3"></span>
