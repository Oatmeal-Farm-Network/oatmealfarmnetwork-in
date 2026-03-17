<br />
<table cellpadding = "0" cellspacing = "0" border = "0" width = "<%=screenwidth %>" height = "28" align = "center">
   <tr><td width = 10></td>
     <td>
<%  if Current3 = "BusinessHome" then %>
<td class = "tabtopon" width = "120" height = "20" align = "center" ><b><a href = "/Membersistration/MembersBusinessHome.asp" class = "menu2">List of Businesses</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "120" height = "20" align = "center" ><b><a href = "/Membersistration/MembersBusinessHome.asp" class = "menu">List of Businesses</a></b></td>
<% end if %> 
<%  if Current3 = "AddBusiness" then %>
<td class = "tabtopon" width = "120" height = "20" align = "center" ><b><a href = "/Membersistration/AddaBusiness.asp" class = "menu2">Add a Business</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "120" height = "20" align = "center" ><b><a href = "/Membersistration/AddaBusiness.asp" class = "menu">Add a Business</a></b></td>
    <% end if %> 
 <%  if Current3 = "BusinessEdit" then %>
<td class = "tabtopon" width = "120" height = "20" align = "center" ><b><a href = "/Membersistration/EditBusinessForSale0.asp?ID=<%=ID %>" class = "menu2">Edit Businesses</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "120" height = "20" align = "center" ><b><a href = "/Membersistration/EditBusinessForSale0.asp?ID=<%=ID %>" class = "menu">Edit Businesses</a></b></td>
    <% end if %> 
    
    <%  if Current3 = "Photos" then %>
<td class = "tabtopon" width = "130" height = "20" align = "center" ><b><a href = "/Membersistration/MembersBusinessPhotos.asp?ID=<%=ID %>" class = "menu2">Business Photos</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "130" height = "20" align = "center" ><b><a href = "/Membersistration/MembersBusinessPhotos.asp?ID=<%=ID %>" class = "menu">Business Photos</a></b></td>
    <% end if %> 
 
 <%  if Current3 = "DeleteBusiness" then %>
<td class = "tabtopon" width = "120" height = "20" align = "center" ><b><a href = "/Membersistration/MembersDeleteBusiness.asp" class = "menu2">Delete Business</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "120" height = "20" align = "center" ><b><a href = "/Membersistration/MembersDeleteBusiness.asp" class = "menu">Delete Business</a></b></td>
<% end if %> 
  <% showPreview=false
    if  showPreview= True then %>

       <%  if Current3 = "Preview" then %>
<td class = "tabtopon" width = "90" height = "20" align = "center" ><b><a href = "/Membersistration/Preview.asp?ID=<%=ID %>" class = "menu2">Preview</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "90" height = "20" align = "center" ><b><a href = "/Membersistration/Preview.asp?ID=<%=ID %>" class = "menu">Preview</a></b></td>
    <% end if %> 


       <%  if Current3 = "BusinessStats" then %>
<td class = "tabtopon" width = "90" height = "20" align = "center" ><b><a href = "/Membersistration/BusinessStats.asp" class = "menu2">Statistics</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "90" height = "20" align = "center" ><b><a href = "/Membersistration/BusinessStats.asp" class = "menu">Statistics</a></b></td>
    <% end if %> 
     <% end if %> 
   <td >&nbsp;</td>
</tr>
</table>




   

