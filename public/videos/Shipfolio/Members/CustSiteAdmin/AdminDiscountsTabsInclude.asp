<table cellpadding = "0" cellspacing = "0" border = "0" width = "970" height = "28" align = "center">
   <tr>
     <td>
 
<%  if Current3 = "CouponsHome" then %>
<td class = "tabtopon" width = "150" height = "20" align = "center" ><b><a href = "/Administration/AdminCouponsHome.asp?PeopleID=<%=session("PeopleID") %>" class = "menu2">List of Discounts / Coupons</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "150" height = "20" align = "center" ><b><a href = "/Administration/AdminCouponsHome.asp?PeopleID=<%=session("PeopleID") %>" class = "menu">List of Discounts / Coupons</a></b></td>
<% end if %> 
    
    
<%  if Current3 = "AddCoupons" then %>
<td class = "tabtopon" width = "80" height = "20" align = "center" ><b><a href = "/ADMINISTRATION/AdminCouponsAdd.asp" class = "menu2">Add</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "80" height = "20" align = "center" ><b><a href = "/ADMINISTRATION/AdminCouponsAdd.asp" class = "menu">Add</a></b></td>
    <% end if %> 
    
      
<%  if Current3 = "DeleteCoupons" then %>
<td class = "tabtopon" width = "90" height = "20" align = "center" ><b><a href = "/ADMINISTRATION/AdminListingDelete.asp" class = "menu2">Delete</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "90" height = "20" align = "center" ><b><a href = "/ADMINISTRATION/AdminListingDelete.asp" class = "menu">Delete</a></b></td>
    <% end if %> 
    
     
 
 

   <td >&nbsp;</td>
</tr>
</table>




   

