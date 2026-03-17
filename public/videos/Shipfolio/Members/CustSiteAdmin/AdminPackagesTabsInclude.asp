<% if screenwidth < 989 then %>
<table cellpadding = "0" cellspacing = "0" border = "0" width = "<%=screenwidth-40 %>" height = "28" align = "left">
<% else %>
<table cellpadding = "0" cellspacing = "0" border = "0" width = "<%=screenwidth-40 %>" height = "28" align = "center">
<% end if %>
   <tr>
     <td>
<%  if Current3 = "PackagesHome" then %>
<td class = "tabtopon" width = "120" height = "20" align = "center" ><b><a href = "/Administration/AdminPackageshome.asp" class = "menu2">List of Packages</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "120" height = "20" align = "center" ><b><a href = "/Administration/AdminPackageshome.asp" class = "menu">List of Packages</a></b></td>
<% end if %> 
    
    
<%  if Current3 = "AddPackage" then %>
<td class = "tabtopon" width = "90" height = "20" align = "center" ><b><a href = "/Administration/AdminPackagesAdd.asp" class = "menu2">Add Package</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "90" height = "20" align = "center" ><b><a href = "/Administration/AdminPackagesAdd.asp" class = "menu">Add Package</a></b></td>
    <% end if %> 
    
    
 <%  if Current3 = "PackageEdit" then %>
<td class = "tabtopon" width = "90" height = "20" align = "center" ><b><a href = "/Administration/AdminEditPackage1.asp?PackageID=<%=ID %>" class = "menu2">Edit</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "90" height = "20" align = "center" ><b><a href = "/Administration/AdminEditPackage1.asp?PackageID=<%=ID %>" class = "menu">Edit</a></b></td>
    <% end if %> 
    
   
    <%  if Current3 = "PackageDelete" then %>
<td class = "tabtopon" width = "90" height = "20" align = "center" ><b><a href = "/Administration/AdminPackagesDelete.asp?ID=<%=ID %>" class = "menu2">Delete</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "90" height = "20" align = "center" ><b><a href = "/Administration/AdminPackagesDelete.asp?ID=<%=ID %>" class = "menu">Delete</a></b></td>
    <% end if %> 

    <%  if Current3 = "Heading" then %>
<td class = "tabtopon" width = "10%" height = "20" align = "center" ><b><a href = "/ADMINISTRATION/AdminPageMaintenance.asp?pagelayoutID=32" class = "menu2">Heading</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "10%" height = "20" align = "center" ><b><a href = "/ADMINISTRATION/AdminPageMaintenance.asp?pagelayoutID=32" class = "menu">Heading</a></b></td>
    <% end if %> 

<% showpackagestate = false
if showpackagestate = True then
        if Current3 = "PackagesStats" then %>
<td class = "tabtopon" width = "90" height = "20" align = "center" ><b><a href = "/Administration/AdminPackageStats.asp#packages" class = "menu2">Statistics</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "90" height = "20" align = "center" ><b><a href = "/Administration/AdminPackageStats.asp#packages" class = "menu">Statistics</a></b></td>
    <% end if %> 
<% end if %>    

   <td >&nbsp;</td>
</tr>
</table>




   

