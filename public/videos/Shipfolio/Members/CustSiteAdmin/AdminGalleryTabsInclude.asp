
<table cellpadding = "0" cellspacing = "0" border = "0" width = "<%=screenwidth -35 %>" height = "28" align = "center">
   <tr>
     <td>
  
<%  if Current3 = "GalleryHome" then %>
<td class = "tabtopon" width = "16%" height = "20" align = "center" ><b><a href = "/Administration/AdminGalleryHome.asp" class = "menu2">List of Galleries</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "16%" height = "20" align = "center" ><b><a href = "/Administration/AdminGalleryHome.asp" class = "menu">List of Galleries</a></b></td>
<% end if %> 
    
    
   <%  if Current3 = "EditImages" then %>
<td class = "tabtopon" width = "16%" height = "20" align = "center" ><b><a href = "/Administration/AdminGalleryEditImages.asp" class = "menu2">Edit Images</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "16%" height = "20" align = "center" ><b><a href = "/Administration/AdminGalleryEditImages.asp" class = "menu">Edit Images</a></b></td>
    <% end if %> 

    
    
<%  if Current3 = "GalleryCategories" then %>
<td class = "tabtopon" width = "16%" height = "20" align = "center" ><b><a href = "/Administration/AdminGallerySetCategories.asp" class = "menu2">Add & Delete Galleries</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "16%" height = "20" align = "center" ><b><a href = "/Administration/AdminGallerySetCategories.asp" class = "menu">Add & Delete Galleries</a></b></td>
    <% end if %>    
    
    
        <%  if Current3 = "GalleryHeading" then %>
<td class = "tabtopon" width = "16%" height = "20" align = "center" ><b><a href = "/Administration/AdminPageMaintenance.asp?pagename=Galleries" class = "menu2">Heading</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "16%" height = "20" align = "center" ><b><a href = "/Administration/AdminPageMaintenance.asp?pagename=Galleries" class = "menu">Heading</a></b></td>
    <% end if %>  
    
     <%  if Current3 = "SEO" then %>
<td class = "tabtopon" width = "16%" height = "20" align = "center" ><b><a href = "/Administration/AdminEditSEO.asp?pagename=Galleries" class = "menu2">SEO</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "16%" height = "20" align = "center" ><b><a href = "/Administration/AdminEditSEO.asp?pagename=Galleries" class = "menu">SEO</a></b></td>
    <% end if %>  
    
    <% 
     if Current3 = "SEO" or Current3 = "SEOArticle" then
    
     if Current3 = "SEOArticle" then %>
<td class = "tabtopon" width = "16%" height = "20" align = "center" ><b><a href = "/Administration/AdminSEOArticle.asp?pagename=Galleries" class = "menu2">About SEO</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "16%" height = "20" align = "center" ><b><a href = "/Administration/AdminSEOArticle.asp?pagename=Galleries" class = "menu">About SEO</a></b></td>
    <% end if %>  
       <% end if %>  
    
    

   <td >&nbsp;</td>
</tr>
</table>




   

