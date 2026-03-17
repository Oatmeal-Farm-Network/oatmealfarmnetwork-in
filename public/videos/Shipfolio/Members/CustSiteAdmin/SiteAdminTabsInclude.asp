<table cellpadding = "0" cellspacing = "0" border = "0" width = "<%=screenwidth %>" height = "28" align = "left" bgcolor = "<%=PrimaryColor%>">
<tr><td width = "30"></td>
<% show = False
if show = True then %>
<%  if Current3 = "AnimalsHome" then %>
<td class = "tabtopon" width = "100" height = "20" align = "center" ><b><a href = "/Administration/Default.asp#animals" class = "menu2">List of Animals</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "100" height = "20" align = "center" ><b><a href = "/Administration//Default.asp#animals" class = "menu">List of Animals</a></b></td>
<% end if %> 
<%  if Current3 = "AddAnimal" then %>
<td class = "tabtopon" width = "90" height = "20" align = "center" ><b><a href = "/Administration/AdminAnimalAdd1.asp" class = "menu2">Add Animal</a></b></td>
<% else %>
<td class = "tabtopoff" width = "90" height = "20" align = "center" ><b><a href = "/Administration/AdminAnimalAdd1.asp" class = "menu">Add Animal</a></b></td>
 <% end if %> 
  <%  if Current3 = "AnimalEdit" then %>
<td class = "tabtopon" width = "90" height = "20" align = "center" ><b><a href = "/Administration/EditAnimal.asp?ID=<%=ID %>" class = "menu2">Edit Animals</a></b></td>
<% else %>
<td class = "tabtopoff" width = "90" height = "20" align = "center" ><b><a href = "/Administration/EditAnimal.asp?ID=<%=ID %>" class = "menu">Edit Animals</a></b></td>
 <% end if %> 
<%  if Current3 = "Photos" then %>
<td class = "tabtopon" width = "90" height = "20" align = "center" ><b><a href = "/Administration/AdminPhotos.asp?ID=<%=ID %>" class = "menu2">Photos</a></b></td>
<% else %>
<td class = "tabtopoff" width = "90" height = "20" align = "center" ><b><a href = "/Administration/AdminPhotos.asp?ID=<%=ID %>" class = "menu">Photos</a></b></td>
<% end if %> 
<% showPreview=false
 if  showPreview= True then %>
  <%  if Current3 = "Preview" then %>
<td class = "tabtopon" width = "90" height = "20" align = "center" ><b><a href = "/Administration/Preview.asp?ID=<%=ID %>" class = "menu2">Preview</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "90" height = "20" align = "center" ><b><a href = "/Administration/Preview.asp?ID=<%=ID %>" class = "menu">Preview</a></b></td>
    <% end if %> 
 <% end if %> 

       <%  if Current3 = "AnimalStats" then %>
<td class = "tabtopon" width = "90" height = "20" align = "center" ><b><a href = "/Administration/AnimalsStats.asp#Animals" class = "menu2">Statistics</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "90" height = "20" align = "center" ><b><a href = "/Administration/AnimalsStats.asp#Animals" class = "menu">Statistics</a></b></td>
    <% end if %> 
<% showtransfer = false 
if showtransfer = True then
if Current3 = "TransferOwnership" then %>
<td class = "tabtopon" width = "100" height = "20" align = "center" ><b><a href = "/Administration/TransferAnimal.asp" class = "menu2">Transfer</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "100" height = "20" align = "center" ><b><a href = "/Administration/TransferAnimal.asp" class = "menu">Transfer</a></b></td>
    <% end if %> 
       <%  if Current3 = "DeleteAnimals" then %>
<td class = "tabtopon" width = "90" height = "20" align = "center" ><b><a href = "/Administration/deleteAnimal.asp" class = "menu2">Delete</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "90" height = "20" align = "center" ><b><a href = "/Administration/deleteAnimal.asp" class = "menu">Delete</a></b></td>
<% end if %> 
<% end if %>  

<% 
if Current3 = "Categories" then %>
<td class = "tabtopon" width = "90" height = "20" align = "center" ><b><a href = "/Administration/SiteAdminSetForSaleCategories.asp" class = "menu2">Product Categories</a></b></td>
<% else %>
<td class = "tabtopoff" width = "90" height = "20" align = "center" ><b><a href = "/Administration/SiteAdminSetForSaleCategories.asp" class = "menu">Product Categories</a></b></td>
<% end if %> 

<%  if Current3 = "AddAnimal" then %>
<td class = "tabtopon" width = "90" height = "20" align = "center" ><b><a href = "/Administration/SiteAdminLivestocktypes.asp" class = "menu2">Livestock Types</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "90" height = "20" align = "center" ><b><a href = "/Administration/SiteAdminLivestocktypes.asp" class = "menu">Livestock Types</a></b></td>
    <% end if %> 
 <% end if %>  
 
 l,asadjksadjsa
<%  if Current3 = "SiteAdminHome" then %>
<td class = "tabtopon" width = "130" height = "20" align = "center" ><b><a href = "/Administration/Siteadminhome.asp" class = "menu2">Site Admin Home</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "130" height = "20" align = "center" ><b><a href = "/Administration/Siteadminhome.asp" class = "menu">Site Admin Home</a></b></td>
    <% end if %>   
     <%  if Current3 = "AddUsers" then %>
<td class = "tabtopon" width = "130" height = "20" align = "center" ><b><a href = "/Administration/SiteAdminAdduser.asp" class = "menu2">Add Members</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "130" height = "20" align = "center" ><b><a href = "/Administration/SiteAdminAddUser.asp" class = "menu">Add Members</a></b></td>
    <% end if %>   
    <%  if Current3 = "EditUsers" then %>
<td class = "tabtopon" width = "130" height = "20" align = "center" ><b><a href = "/Administration/SiteAdminEdituser.asp" class = "menu2">Edit Members</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "130" height = "20" align = "center" ><b><a href = "/Administration/SiteAdminEditUser.asp" class = "menu">Edit Members</a></b></td>
    <% end if %> 
        <%  if Current3 = "DeleteUsers" then %>
<td class = "tabtopon" width = "130" height = "20" align = "center" ><b><a href = "/Administration/SiteAdminDeleteuser.asp" class = "menu2">Delete Members</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "130" height = "20" align = "center" ><b><a href = "/Administration/SiteAdminDeleteUser.asp" class = "menu">Delete Members</a></b></td>
    <% end if %> 
 <%  if Current3 = "Accesslog" then %>
<td class = "tabtopon" width = "130" height = "20" align = "center" ><b><a href = "/Administration/SiteAdminAccesslog.asp" class = "menu2">Access Log</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "130" height = "20" align = "center" ><b><a href = "/Administration/SiteAdminAccesslog.asp" class = "menu">Access Log</a></b></td>
    <% end if %> 


    
   <td >&nbsp;</td>
</tr>
</table>




   

