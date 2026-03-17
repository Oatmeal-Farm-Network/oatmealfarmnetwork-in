<table cellpadding = "0" cellspacing = "0" border = "0" width = "900" height = "28" align = "center">
<tr><td>
<%  if Current3 = "AnimalSearch" then %>
<td class = "tabtopon" width = "120" height = "20" align = "center" ><b><a href = "SearchLivestockforSale.asp" class = "menu2"><%=PageName %> For Sale</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "120" height = "20" align = "center" ><b><a href = "SearchLivestockforSale.asp" class = "menu"><%=PageName %> For Sale</a></b></td>
<% end if %> 
<%  if Current3 = "Studsearch" then %>
<td class = "tabtopon" width = "110" height = "20" align = "center" ><b><a href = "MembersPasswordChange.asp" class = "menu2"><%=signularanimal %> Studs</a></b></td>
<% else %>
<td class = "tabtopoff" width = "110" height = "20" align = "center" ><b><a href = "MembersPasswordChange.asp" class = "menu"><%=signularanimal %> Stud</a></b></td>
<% end if %> 
<%  if Current3 = "RanchSearch" then %>
<td class = "tabtopon" width = "200" height = "20" align = "center" ><b><a href = "MembersRenewSubscription.asp" class = "menu2"><%=signularanimal %> Ranches</a></b></td>
<% else %>
<td class = "tabtopoff" width = "200" height = "20" align = "center" ><b><a href = "MembersRenewSubscription.asp" class = "menu"><%=signularanimal %> Ranches</a></b></td>
<% end if %> 
<td >&nbsp;</td>
</tr>
</table>