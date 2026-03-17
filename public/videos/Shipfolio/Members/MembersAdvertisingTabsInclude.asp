
<table cellpadding = "0" cellspacing = "0" border = "0" width = "920" height = "28" align = "center">
   <tr>
     <td>
<%  if Current3 = "AdvertisingHome" then %>
<td class = "tabtopon" width = "136" height = "20" align = "center" ><b><a href = "/Membersistration/Advertisinghome.asp" class = "menu2">Your Advertisements</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "136" height = "20" align = "center" ><b><a href = "/Membersistration/Advertisinghome.asp" class = "menu">Your Advertisements</a></b></td>
<% end if %> 
    
    
<%  if Current3 = "AddAdvertising" then %>
<td class = "tabtopon" width = "110" height = "20" align = "center" ><b><a href = "/Membersistration/MembersAdvertisingAdd.asp" class = "menu2">Add Advertising</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "110" height = "20" align = "center" ><b><a href = "/Membersistration/MembersAdvertisingAdd.asp" class = "menu">Add Advertising</a></b></td>
    <% end if %> 
    
    <%  if Current3 = "AdvertisingRates" then %>
<td class = "tabtopon" width = "110" height = "20" align = "center" ><b><a href = "/Membersistration/MembersAdvertisingRates.asp" class = "menu2">Rates</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "110" height = "20" align = "center" ><b><a href = "/Membersistration/MembersAdvertisingRates.asp" class = "menu">Rates</a></b></td>
    <% end if %> 
    
<%
  ShowStats = False     
 if ShowStats = True then      
if Current3 = "AdvertisingStats" then %>
<td class = "tabtopon" width = "90" height = "20" align = "center" ><b><a href = "/Membersistration/AdvertisingStats.asp#Advertising" class = "menu2">Statistics</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "90" height = "20" align = "center" ><b><a href = "/Membersistration/AdvertisingStats.asp#Advertising" class = "menu">Statistics</a></b></td>
    <% end if %> 
      <% end if %>      

   <td >&nbsp;</td>
</tr>
</table>




   

