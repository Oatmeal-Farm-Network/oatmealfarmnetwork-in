
<table cellpadding = "0" cellspacing = "0" border = "0" width = "900" height = "28" align = "center">
   <tr>
     <td>
<%  if Current3 = "AccountHome" then %>
<td class = "tabtopon" width = "120" height = "20" align = "center" ><b><a href = "/Membersistration/AccountContactsEdit.asp" class = "menu2">Account Info</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "120" height = "20" align = "center" ><b><a href = "/Membersistration/AccountContactsEdit.asp" class = "menu">Account Info</a></b></td>
<% end if %> 
    
    
<%  if Current3 = "Password" then %>
<td class = "tabtopon" width = "110" height = "20" align = "center" ><b><a href = "/Membersistration/MembersPasswordChange.asp" class = "menu2">Reset Password</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "110" height = "20" align = "center" ><b><a href = "/Membersistration/MembersPasswordChange.asp" class = "menu">Reset Password</a></b></td>
    <% end if %> 
    
    <%  if Current3 = "Membership" then %>
<td class = "tabtopon" width = "220" height = "20" align = "center" ><b><a href = "/Membersistration/MembersRenewSubscription.asp" class = "menu2">Renew or Upgrade Membership</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "220" height = "20" align = "center" ><b><a href = "/Membersistration/MembersRenewSubscription.asp" class = "menu">Renew or Upgrade Membership</a></b></td>
    <% end if %> 
 <%  
 showoffers = false
 if showoffers = True then
 
 if Current3 = "webdesign" then %>
<td class = "tabtopon" width = "340" height = "20" align = "center" ><b><a href = "/Membersistration/Memberswebsiteandbrokering.asp" class = "menu2">Exclusive Web Design & Brokering Offers</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "340" height = "20" align = "center" ><b><a href = "/Membersistration/Memberswebsiteandbrokering.asp" class = "menu">Exclusive Web Design & Brokering Offers</a></b></td>
    <% end if %> 
  <% end if %> 
   <td >&nbsp;</td>
</tr>
</table>




   

