<table cellpadding = "0" cellspacing = "0" border = "0" width = "<%=screenwidth-35 %>" height = "28" align = "left">
   <tr>
   <td width = "5">&nbsp;</td>
<%  if Current3 = "LinksHome" then %>
<td class = "tabtopon" width = "170" height = "20" align = "center" ><b><a href = "/Administration/AdminLinksHome.asp" class = "menu2">List of Links</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "170" height = "20" align = "center" ><b><a href = "/Administration/AdminLinksHome.asp" class = "menu">List of Links</a></b></td>
<% end if %> 
    
   
<%  if Current3="LinkCategories" then %>
<td class = "tabtopon" width = "170" height = "20" align = "center" ><b><a href = "/Administration/AdminLinkCategoriesSet.asp" class = "menu2">Link Categories</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "170" height = "20" align = "center" ><b><a href = "/Administration/AdminLinkCategoriesSet.asp" class = "menu">Link Categories</a></b></td>
    <% end if %> 
    
    
 
       <%  if Current3 = "LinkHeading" then %>
<td class = "tabtopon" width = "170" height = "20" align = "center" ><b><a href = "/Administration/AdminPageMaintenance.asp?pagename=Links" class = "menu2">Links Page Heading</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "170" height = "20" align = "center" ><b><a href = "/Administration/AdminPageMaintenance.asp?pagename=Links" class = "menu">Links Page Heading</a></b></td>
    <% end if %> 
  
    
        <%  if Current3 = "SEO" then %>
<td class = "tabtopon" width = "150" height = "20" align = "center" ><b><a href = "/Administration/AdminEditSEO.asp?pagename=Links" class = "menu2">SEO</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "150" height = "20" align = "center" ><b><a href = "/Administration/AdminEditSEO.asp?pagename=Links" class = "menu">SEO</a></b></td>
    <% end if %>  
    
   
   <td >&nbsp;</td>
</tr>
</table>





   

