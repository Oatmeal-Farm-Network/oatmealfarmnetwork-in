


<table cellpadding = "0" cellspacing = "0" border = "0" width = "<%=screenwidth - 35 %>" height = "28" align = "center">
<tr><td>
<%  if Current3 = "AlpacasHome" then %>
<td class = "tabtopon" width = "12%" height = "20" align = "center" ><b><a href = "/Membersistration/Default.asp#animals" class = "menu2">List of Animals</a></b></td>
<% else %>
<td class = "tabtopoff" width = "12%" height = "20" align = "center" ><b><a href = "/Membersistration/Default.asp#animals" class = "menu">List of Animals</a></b></td>
<% end if %> 
<%  if Current3 = "AddAlpaca" then %>
<td class = "tabtopon" width = "10%" height = "20" align = "center" ><b><a href = "/Membersistration/MembersAnimalAdd1.asp" class = "menu2">Add Animal</a></b></td>
<% else %>
<td class = "tabtopoff" width = "10%" height = "20" align = "center" ><b><a href = "/Membersistration/MembersAnimalAdd1.asp" class = "menu">Add Animal</a></b></td>
<% end if %> 
<%  if Current3 = "AnimalEdit" then %>
<td class = "tabtopon" width = "10%" height = "20" align = "center" ><b><a href = "/Membersistration/editAnimal.asp?ID=<%=ID %>" class = "menu2">Edit</a></b></td>
<% else %>
<td class = "tabtopoff" width = "10%" height = "20" align = "center" ><b><a href = "/Membersistration/editAnimal.asp?ID=<%=ID %>" class = "menu">Edit</a></b></td>
<% end if %> 
<%  if Current3 = "AnimalPhotos" then %>
<td class = "tabtopon" width = "14%" height = "20" align = "center" ><b><a href = "/Membersistration/MembersPhotos.asp?ID=<%=ID %>" class = "menu2">Photos & Videos</a></b></td>
<% else %>
<td class = "tabtopoff" width = "14%" height = "20" align = "center" ><b><a href = "/Membersistration/MembersPhotos.asp?ID=<%=ID %>" class = "menu">Photos & Videos</a></b></td>
<% end if %> 
<% showPreview=false
if  showPreview= True then %>
<%  if Current3 = "Preview" then %>
<td class = "tabtopon" width = "10%" height = "20" align = "center" ><b><a href = "/Membersistration/MembersPreview.asp?ID=<%=ID %>" class = "menu2">Preview</a></b></td>
<% else %>
<td class = "tabtopoff" width = "10%" height = "20" align = "center" ><b><a href = "/Membersistration/MembersPreview.asp?ID=<%=ID %>" class = "menu">Preview</a></b></td>
<% end if %> 
<% end if %> 

<%  if Current3 = "DeleteAlpacas" then %>
<td class = "tabtopon" width = "14%" height = "20" align = "center" ><b><a href = "/Membersistration/deleteAnimal.asp" class = "menu2">Delete Animals</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "14%" height = "20" align = "center" ><b><a href = "/Membersistration/deleteAnimal.asp" class = "menu">Delete Animals</a></b></td>
<% end if %> 
   
<%  if Current3="AnimalStats" then %>
<td class = "tabtopon" width = "10%" height = "20" align = "center" ><b><a href = "/Membersistration/AnimalsStats.asp" class = "menu2">Statistics</a></b></td>
<% else %>
<td class = "tabtopoff" width = "10%" height = "20" align = "center" ><b><a href = "/Membersistration/AnimalsStats.asp" class = "menu">Statistics</a></b></td>
<% end if %>    
 <td >&nbsp;</td>
</tr>
</table>