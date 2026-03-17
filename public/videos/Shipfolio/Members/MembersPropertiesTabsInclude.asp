<br />
<table cellpadding = "0" cellspacing = "0" border = "0" width = "<%=screenwidth %>" height = "28" align = "center">
<tr><td width = 10></td>
<td>
<%  if Current3 = "PropertyHome" then %>
<td class = "tabtopon" width = "120" height = "20" align = "center" ><b><a href = "/Members/PropertiesHome.asp" class = "menu2">List of Properties</a></b></td>
<% else %>
<td class = "tabtopoff" width = "120" height = "20" align = "center" ><b><a href = "/Members/PropertiesHome.asp" class = "menu">List of Properties</a></b></td>
<% end if %> 
<%  if Current3 = "AddProperty" then %>
<td class = "tabtopon" width = "120" height = "20" align = "center" ><b><a href = "/Members/AddaProperty.asp" class = "menu2">Add a Property</a></b></td>
<% else %>
<td class = "tabtopoff" width = "120" height = "20" align = "center" ><b><a href = "/Members/AddaProperty.asp" class = "menu">Add a Property</a></b></td>
 <% end if %> 
 <%  if Current3 = "PropertyEdit" then %>
<td class = "tabtopon" width = "120" height = "20" align = "center" ><b><a href = "/Members/EditProperty0.asp?PropID=<%=PropID %>" class = "menu2">Edit Properties</a></b></td>
<% else %>
<td class = "tabtopoff" width = "120" height = "20" align = "center" ><b><a href = "/Members/EditProperty0.asp?PropID=<%=PropID %>" class = "menu">Edit Properties</a></b></td>
<% end if %> 
<%  if Current3 = "Photos" then %>
<td class = "tabtopon" width = "120" height = "20" align = "center" ><b><a href = "/Members/PropertyPhotos.asp?PropID=<%=PropID %>" class = "menu2">Property Photos</a></b></td>
<% else %>
<td class = "tabtopoff" width = "120" height = "20" align = "center" ><b><a href = "/Members/PropertyPhotos.asp?PropID=<%=PropID %>" class = "menu">Property Photos</a></b></td>
<% end if %> 
<%  if Current3 = "DeleteProperty" then %>
<td class = "tabtopon" width = "90" height = "20" align = "center" ><b><a href = "/Members/DeleteProperty.asp" class = "menu2">Delete</a></b></td>
<% else %>
<td class = "tabtopoff" width = "90" height = "20" align = "center" ><b><a href = "/Members/DeleteProperty.asp" class = "menu">Delete</a></b></td>
<% end if %> 
<% showPreview=false
if  showPreview= True then %>
<%  if Current3 = "Preview" then %>
<td class = "tabtopon" width = "90" height = "20" align = "center" ><b><a href = "/Members/Preview.asp?PropID=<%=PropID %>" class = "menu2">Preview</a></b></td>
<% else %>
<td class = "tabtopoff" width = "90" height = "20" align = "center" ><b><a href = "/Members/Preview.asp?PropID=<%=PropID %>" class = "menu">Preview</a></b></td>
<% end if %> 
 <%  if Current3 = "PropertyStats" then %>
<td class = "tabtopon" width = "90" height = "20" align = "center" ><b><a href = "/Members/PropertyStats.asp" class = "menu2">Statistics</a></b></td>
<% else %>
<td class = "tabtopoff" width = "90" height = "20" align = "center" ><b><a href = "/Members/PropertyStats.asp" class = "menu">Statistics</a></b></td>
<% end if %> 
<% end if %> 
<td >&nbsp;</td>
</tr>
</table>