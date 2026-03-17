
<table cellpadding = "0" cellspacing = "0" border = "0" width = "900" height = "28" align = "center">
   <tr>
     <td>
     <%  if Current3 = "AccountHome" then %>
<td class = "tabtopon" width = "120" height = "20" align = "center" ><b><a href = "/Membersistration/SiteMembersAssociationsAdd.asp?AssociationId=<%=associationID %>" class = "menu2">Edit Association</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "120" height = "20" align = "center" ><b><a href = "/Membersistration/SiteMembersAssociationsAdd.asp?AssociationId=<%=associationID %>" class = "menu">Edit Association</a></b></td>
<% end if %> 
    


<%  if Current3 = "AccountHome" then %>
<td class = "tabtopon" width = "120" height = "20" align = "center" ><b><a href = "/Membersistration/AssociationEditMembers.asp?AssociationId=<%=associationID %>" class = "menu2">List of Members</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "120" height = "20" align = "center" ><b><a href = "/Membersistration/AssociationEditMembers.asp?AssociationId=<%=associationID %>" class = "menu">List of Members</a></b></td>
<% end if %> 
    
    
<%  if Current3 = "AddMembers" then %>
<td class = "tabtopon" width = "110" height = "20" align = "center" ><b><a href = "/Membersistration/AddMembers.asp?AssociationId=<%=associationID %>" class = "menu2">Add Members</a></b></td>
<% else %>
<td class = "tabtopoff" width = "110" height = "20" align = "center" ><b><a href = "/Membersistration/AddMembers.asp?AssociationId=<%=associationID %>" class = "menu">Add Members</a></b></td>
<% end if %> 
    
<% if Current3 = "DeleteMembers" then %>
<td class = "tabtopon" width = "200" height = "20" align = "center" ><b><a href = "/Membersistration/DeleteUser.asp?AssociationId=<%=associationID %>" class = "menu2">Delete Member</a></b></td>
<% else %>
<td class = "tabtopoff" width = "200" height = "20" align = "center" ><b><a href = "/Membersistration/DeleteUser.asp?AssociationId=<%=associationID %>" class = "menu">Delete Member</a></b></td>
<% end if %> 

   <td >&nbsp;</td>
</tr>
</table>




   

