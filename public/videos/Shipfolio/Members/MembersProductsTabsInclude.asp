<table cellpadding = "0" cellspacing = "0" border = "0" width = "900" height = "28" align = "center">
<tr><td>
<%  if Current3 = "ProductsHome" then %>
<td class = "tabtopon" width = "170" height = "20" align = "center" ><b><a href = "/Administration/Productshome.asp" class = "menu2">List of Products</a></b></td>
<% else %>
<td class = "tabtopoff" width = "170" height = "20" align = "center" ><b><a href = "/Administration/Productshome.asp" class = "menu">List of Products</a></b></td>
<% end if %> 
<%  if Current3 = "AddProduct" then %>
<td class = "tabtopon" width = "100" height = "20" align = "center" ><b><a href = "/Administration/AdminClassifiedAdPlace.asp" class = "menu2">Add Products</a></b></td>
<% else %>
<td class = "tabtopoff" width = "100" height = "20" align = "center" ><b><a href = "/Administration/AdminClassifiedAdPlace.asp" class = "menu">Add Products</a></b></td>
<% end if %> 
<%  if Current3 = "ProductEdit" then %>
<td class = "tabtopon" width = "100" height = "20" align = "center" ><b><a href = "/Administration/EditAd.asp?ProductID=<%=ProductID %>" class = "menu2">Edit Products</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "100" height = "20" align = "center" ><b><a href = "/Administration/EditAd.asp?ProductID=<%=ProductID %>" class = "menu">Edit Products</a></b></td>
<% end if %> 
<%  if Current3 = "ProductPhotos" then %>
<td class = "tabtopon" width = "90" height = "20" align = "center" ><b><a href = "/Administration/AdminProductPhotos.asp?ID=<%=ProductID %>" class = "menu2">Photos</a></b></td>
<% else %>
<td class = "tabtopoff" width = "90" height = "20" align = "center" ><b><a href = "/Administration/AdminProductPhotos.asp?ID=<%=ProductID %>" class = "menu">Photos</a></b></td>
<% end if %> 
<%  if Current3 = "ProductDelete" then %>
<td class = "tabtopon" width = "80" height = "20" align = "center" ><b><a href = "/Administration/DeleteListing.asp?ProductID=<%=ProductID %>" class = "menu2">Delete</a></b></td>
<% else %>
<td class = "tabtopoff" width = "80" height = "20" align = "center" ><b><a href = "/Administration/DeleteListing.asp?ProductID=<%=ProductID %>" class = "menu">Delete</a></b></td>
<% end if %> 
<%  if Current3 = "ProductCategories" then %>
<td class = "tabtopon" width = "120" height = "20" align = "center" ><b><a href = "/Administration/PlaceClassifiedAd0.asp" class = "menu2">Suggest Categories</a></b></td>
<% else %>
<td class = "tabtopoff" width = "120" height = "20" align = "center" ><b><a href = "/Administration/PlaceClassifiedAd0.asp" class = "menu">Suggest Categories</a></b></td>
<% end if %> 
<%  if Current3="ProductStats" then %>
<td class = "tabtopon" width = "90" height = "20" align = "center" ><b><a href = "/Administration/ProductStats.asp#Products" class = "menu2">Statistics</a></b></td>
<% else %>
<td class = "tabtopoff" width = "90" height = "20" align = "center" ><b><a href = "/Administration/ProductStats.asp#Products" class = "menu">Statistics</a></b></td>
<% end if %> 
<%  if Current3 = "StoreSettings" then %>
<td class = "tabtopon" width = "100" height = "20" align = "center" ><b><a href = "/Administration/AdminStoreMaintenance.asp" class = "menu2">Store Settings</a></b></td>
<% else %>
<td class = "tabtopoff" width = "100" height = "20" align = "center" ><b><a href = "/Administration/AdminStoreMaintenance.asp" class = "menu">Store Settings</a></b></td>
<% end if %> 
<td >&nbsp;</td>
</tr>
</table>