<table cellpadding = "0" cellspacing = "0" border = "0" width = "<%=screenwidth - 10 %>" height = "28" align = "center">
   <tr>
   <td width = "15"></td>
     <td>
 
<%  if Current3 = "ProductsHome" then %>
<td class = "tabtopon" width = "120" height = "20" align = "center" ><b><a href = "/Administration/Default.asp#Products" class = "menu2">List of Products</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "120" height = "20" align = "center" ><b><a href = "/Administration/Default.asp#Products" class = "menu">List of Products</a></b></td>
<% end if %> 
    
    
<%  if Current3 = "AddProducts" then %>
<td class = "tabtopon" width = "80" height = "20" align = "center" ><b><a href = "/ADMINISTRATION/AdminClassifiedAdPlace.asp" class = "menu2">Add</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "80" height = "20" align = "center" ><b><a href = "/ADMINISTRATION/AdminClassifiedAdPlace.asp" class = "menu">Add</a></b></td>
    <% end if %> 
    
    
 <%  if Current3 = "EditProduct" then %>
<td class = "tabtopon" width = "80" height = "20" align = "center" ><b><a href = "/ADMINISTRATION/AdminAdEdit.asp" class = "menu2">Edit</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "80" height = "20" align = "center" ><b><a href = "/ADMINISTRATION/AdminAdEdit.asp" class = "menu">Edit</a></b></td>
    <% end if %>   
    
  <%  if Current3 = "ProductPhotos" then %>
<td class = "tabtopon" width = "90" height = "20" align = "center" ><b><a href = "/ADMINISTRATION/AdminProductPhotos.asp" class = "menu2">Photos</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "90" height = "20" align = "center" ><b><a href = "/ADMINISTRATION/AdminProductPhotos.asp" class = "menu">Photos</a></b></td>
    <% end if %> 
     
     
       <%  if Current3 = "DeleteProducts" then %>
<td class = "tabtopon" width = "90" height = "20" align = "center" ><b><a href = "/ADMINISTRATION/AdminListingDelete.asp" class = "menu2">Delete</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "90" height = "20" align = "center" ><b><a href = "/ADMINISTRATION/AdminListingDelete.asp" class = "menu">Delete</a></b></td>
    <% end if %> 
    

 <%showattributes = False
 if showattributes = True then
 
   if Current3 = "ProductAttributes" then %>
<td class = "tabtopon" width = "110" height = "20" align = "center" ><b><a href = "/ADMINISTRATION/AdminProductsAttributesSet.asp" class = "menu2">Product Attribute</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "110" height = "20" align = "center" ><b><a href = "/ADMINISTRATION/AdminProductsAttributesSet.asp" class = "menu">Product Attribute</a></b></td>
    <% end if %> 
 <% end if %> 
     
     <%  if Current3 = "Header" then %>
<td class = "tabtopon" width = "130" height = "20" align = "center" ><b><a href = "/ADMINISTRATION/AdminPageMaintenance.asp?pagelayoutId=19" class = "menu2">Header Text</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "130" height = "20" align = "center" ><b><a href = "/ADMINISTRATION/AdminPageMaintenance.asp?pagelayoutid=19" class = "menu">Header Text</a></b></td>
    <% end if %> 
    
 
<%  
showdiscounts  = false
if showdiscounts = true then

if Current3 = "Discounts" then %>
<td class = "tabtopon" width = "130" height = "20" align = "center" ><b><a href = "/ADMINISTRATION/AdminDiscounts.asp?Tabs=Services" class = "menu2">Discounts / Coupons</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "130" height = "20" align = "center" ><b><a href = "/ADMINISTRATION/AdminDiscounts.asp" class = "menu">Discounts / Coupons</a></b></td>
<% end if %> 
<% end if %> 

<% 
showpayments= false
if showpayments = True then

 if Current3 = "Payments" then %>
<td class = "tabtopon" width = "110" height = "20" align = "center" ><b><a href = "/ADMINISTRATION/AdminStoreMaintenance.asp?Tabs=Products" class = "menu2">Payment & Taxes</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "110" height = "20" align = "center" ><b><a href = "/ADMINISTRATION/AdminStoreMaintenance.asp?Tabs=Products" class = "menu">Payment & Taxes</a></b></td>
    <% end if %>  
    <% end if %>  
  <td >&nbsp;</td>
</tr>
</table>




   

