
<table cellpadding = "0" cellspacing = "0" border = "0" width = "920" height = "28" align = "center">
   <tr>
     <td>
<%  if Current3 = "PackagesHome" then %>
<td class = "tabtopon" width = "120" height = "20" align = "center" ><b><a href = "/Administration/Packageshome.asp" class = "menu2">List of Packages</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "120" height = "20" align = "center" ><b><a href = "/Administration/Packageshome.asp" class = "menu">List of Packages</a></b></td>
<% end if %> 
    
    
<%  if Current3 = "AddPackage" then %>
<td class = "tabtopon" width = "90" height = "20" align = "center" ><b><a href = "/Administration/PackagesAdd.asp" class = "menu2">Add Package</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "90" height = "20" align = "center" ><b><a href = "/Administration/PackagesAdd.asp" class = "menu">Add Package</a></b></td>
    <% end if %> 
    
    
<%  if Current3 = "PackageAdLayout" then %>
<td class = "tabtopon" width = "90" height = "20" align = "center" ><b><a href = "/Administration/EditPackageLayout.asp" class = "menu2">Ad Layout</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "90" height = "20" align = "center" ><b><a href = "/Administration//EditPackageLayout.asp" class = "menu">Ad Layout</a></b></td>
    <% end if %> 
    
    <%  if Current3 = "PackageDelete" then %>
<td class = "tabtopon" width = "90" height = "20" align = "center" ><b><a href = "/Administration/PackagesDelete.asp?ID=<%=ID %>" class = "menu2">Delete</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "90" height = "20" align = "center" ><b><a href = "/Administration/PackagesDelete.asp?ID=<%=ID %>" class = "menu">Delete</a></b></td>
    <% end if %> 



       <%  if Current3 = "PackagesStats" then %>
<td class = "tabtopon" width = "90" height = "20" align = "center" ><b><a href = "/Administration/PackageStats.asp#packages" class = "menu2">Statistics</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "90" height = "20" align = "center" ><b><a href = "/Administration/PackageStats.asp#packages" class = "menu">Statistics</a></b></td>
    <% end if %> 
   

   <td >&nbsp;</td>
</tr>
</table>




   

