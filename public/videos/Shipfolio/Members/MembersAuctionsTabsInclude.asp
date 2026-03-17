<table cellpadding = "0" cellspacing = "0" border = "0" width = "<%=screenwidth %>" height = "28" align = "center">
<tr><td><%  if Current3 = "AuctionsHome" then %>
<td class = "tabtopon" width = "120" height = "20" align = "center" ><b><a href = "/Membersistration/Auctionshome.asp" class = "menu2">List of Auctions</a></b></td>
<% else %>
<td class = "tabtopoff" width = "120" height = "20" align = "center" ><b><a href = "/Membersistration/Auctionshome.asp" class = "menu">List of Auctions</a></b></td>
<% end if 
showaddauctions = True
if    showaddauctions = True then
     if Current3 = "AuctionAdd" then %>
<td class = "tabtopon" width = "90" height = "20" align = "center" ><b><a href = "/Membersistration/MembersAuctionAdd.asp?AuctionID=<%=AuctionID %>" class = "menu2">Add Auctions</a></b></td>
<% else %>
<td class = "tabtopoff" width = "90" height = "20" align = "center" ><b><a href = "/Membersistration/MembersAuctionAdd.asp?AuctionID=<%=AuctionID %>" class = "menu">Add Auctions</a></b></td>
<% end if 
 end if 
    show = false
    if show = true then
     if Current3 = "AuctionDelete" then %>
<td class = "tabtopon" width = "90" height = "20" align = "center" ><b><a href = "/Membersistration/AuctionsDelete.asp?ID=<%=ID %>" class = "menu2">Delete</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "90" height = "20" align = "center" ><b><a href = "/Membersistration/AuctionsDelete.asp?ID=<%=ID %>" class = "menu">Delete</a></b></td>
<% end if 
     end if 
  if show = true then
        if Current3 = "AuctionsStats" then %>
<td class = "tabtopon" width = "90" height = "20" align = "center" ><b><a href = "/Membersistration/AuctionStats.asp#Auctions" class = "menu2">Statistics</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "90" height = "20" align = "center" ><b><a href = "/Membersistration/AuctionStats.asp#Auctions" class = "menu">Statistics</a></b></td>
    <% end if %> 
       <% end if %> 

   <td >&nbsp;</td>
</tr>
</table>
