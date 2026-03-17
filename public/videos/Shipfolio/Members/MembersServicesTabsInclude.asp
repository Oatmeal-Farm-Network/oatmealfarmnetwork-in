<table cellpadding = "0" cellspacing = "0" border = "0"  height = "28" align = "center">
   <tr>
     <td>
 
<%  if Current3 = "ServicesHome" then %>
<td class = "tabtopon" width = "120" height = "20" align = "center" ><b><a href = "membersServicesHome.asp?PeopleID=<%=session("PeopleID") %>" class = "menu2">List of Services</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "120" height = "20" align = "center" ><b><a href = "membersServicesHome.asp?PeopleID=<%=session("PeopleID") %>" class = "menu">List of Services</a></b></td>
<% end if %> 
    
    
<%  if Current3 = "AddServices" then %>
<td class = "tabtopon" width = "70" height = "20" align = "center" ><b><a href = "membersServicesAdPlace.asp" class = "menu2">Add</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "70" height = "20" align = "center" ><b><a href = "membersServicesAdPlace.asp" class = "menu">Add</a></b></td>
    <% end if %> 
    
    
 <%  if Current3 = "EditServices" then %>
<td class = "tabtopon" width = "70" height = "20" align = "center" ><b><a href = "membersServicesEdit.aspp" class = "menu2">Edit</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "70" height = "20" align = "center" ><b><a href = "membersServicesEdit.asp" class = "menu">Edit</a></b></td>
    <% end if %>   
    
     
<%  if Current3 = "DeleteServices" then %>
<td class = "tabtopon" width = "90" height = "20" align = "center" ><b><a href = "membersServiceDelete.asp" class = "menu2">Delete</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "90" height = "20" align = "center" ><b><a href = "membersServiceDelete.asp" class = "menu">Delete</a></b></td>
    <% end if %> 
    
 
<%  if Current3 = "Discounts" then %>
<td class = "tabtopon" width = "130" height = "20" align = "center" ><b><a href = "membersDiscounts.asp?Tabs=Services" class = "menu2">Discounts / Coupons</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "130" height = "20" align = "center" ><b><a href = "membersDiscounts.asp?Tabs=Services" class = "menu">Discounts / Coupons</a></b></td>
    <% end if %> 

<%  if Current3 = "Payments" then %>
<td class = "tabtopon" width = "110" height = "20" align = "center" ><b><a href = "membersStoreMaintenance.asp?Tabs=Services" class = "menu2">Payment & Taxes</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "110" height = "20" align = "center" ><b><a href = "membersStoreMaintenance.asp?Tabs=Services" class = "menu">Payment & Taxes</a></b></td>
    <% end if %>  

   


			
   <td >&nbsp;</td>
</tr>
</table>




   

