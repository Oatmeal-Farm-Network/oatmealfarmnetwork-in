<% 
PagelayoutID =102
if AnimalType="Alpacas" then
  SpeciesID = 2
end if
%>
<table cellpadding = "0" cellspacing = "0" border = "0" width = "<%=screenwidth - 35 %>" height = "28" align = "center">
   <tr>
     <td>
<%  if Current3 = "AlpacasHome" then %>
<td class = "tabtopon" width = "12%" height = "20" align = "center" ><b><a href = "/Administration/Default.asp#animals" class = "menu2">List of Animals</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "12%" height = "20" align = "center" ><b><a href = "/Administration/Default.asp#animals" class = "menu">List of Animals</a></b></td>
<% end if %> 
    
    
<%  if Current3 = "AddAlpaca" then %>
<td class = "tabtopon" width = "10%" height = "20" align = "center" ><b><a href = "/Administration/AdminAnimalAdd1.asp?SpeciesID=<%=SpeciesID %>" class = "menu2">Add Animal</a></b></td>
<% else %>
<td class = "tabtopoff" width = "10%" height = "20" align = "center" ><b><a href = "/Administration/AdminAnimalAdd1.asp?SpeciesID=<%=SpeciesID %>" class = "menu">Add Animal</a></b></td>
<% end if %> 
    
    
<%  if Current3 = "AlpacaEdit" then %>
<td class = "tabtopon" width = "10%" height = "20" align = "center" ><b><a href = "/Administration/AdminAnimalEdit.asp?ID=<%=ID %>" class = "menu2">Edit</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "10%" height = "20" align = "center" ><b><a href = "/Administration/AdminAnimalEdit.asp?ID=<%=ID %>" class = "menu">Edit</a></b></td>
    <% end if %> 
    
    <%  if Current3 = "AlpacaPhotos" then %>
<td class = "tabtopon" width = "10%" height = "20" align = "center" ><b><a href = "/Administration/AdminPhotos.asp?ID=<%=ID %>" class = "menu2">Photos</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "10%" height = "20" align = "center" ><b><a href = "/Administration/AdminPhotos.asp?ID=<%=ID %>" class = "menu">Photos</a></b></td>
    <% end if %> 
    
    <% showPreview=false
    if  showPreview= True then %>

       <%  if Current3 = "Preview" then %>
<td class = "tabtopon" width = "10%" height = "20" align = "center" ><b><a href = "/Administration/AdminPreview.asp?ID=<%=ID %>" class = "menu2">Preview</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "10%" height = "20" align = "center" ><b><a href = "/Administration/AdminPreview.asp?ID=<%=ID %>" class = "menu">Preview</a></b></td>
    <% end if %> 
 <% end if %> 

      
 
       <%  if Current3 = "DeleteAlpacas" then %>
<td class = "tabtopon" width = "10%" height = "20" align = "center" ><b><a href = "/Administration/AdminAnimalDelete.asp" class = "menu2">Delete</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "10%" height = "20" align = "center" ><b><a href = "/Administration/AdminAnimalDelete.asp" class = "menu">Delete</a></b></td>
    <% end if %> 
  
<%  if Current3 = "OustideAlpacaStuds" then %>
<td class = "tabtopon" width = "12%" height = "20" align = "center" ><b><a href = "/Administration/AdminOutsideStud.asp" class = "menu2">Outside Studs</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "12%" height = "20" align = "center" ><b><a href = "/Administration/AdminOutsideStud.asp" class = "menu">Outside Studs</a></b></td>
    <% end if %> 

<%  if Current3 = "BreedingRecord" then %>
<td class = "tabtopon" width = "10%" height = "20" align = "center" ><b><a href = "/Administration/AdminFemaleData.asp" class = "menu2">Breeding</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "10%" height = "20" align = "center" ><b><a href = "/Administration/AdminFemaleData.asp" class = "menu">Breeding</a></b></td>
    <% end if %> 
    
<%  if Current3 = "Heading" then %>
<td class = "tabtopon" width = "10%" height = "20" align = "center" ><b><a href = "/ADMINISTRATION/AdminPageMaintenance.asp?pagelayoutID=<%=PagelayoutID %>" class = "menu2">Heading</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "10%" height = "20" align = "center" ><b><a href = "/ADMINISTRATION/AdminPageMaintenance.asp?pagelayoutID=<%=PagelayoutID %>" class = "menu">Heading</a></b></td>
    <% end if %> 
    
 
  <%  if Current3 = "AlpacaStats" then %>
<td class = "tabtopon" width = "10%" height = "20" align = "center" ><b><a href = "/Administration/AdminalpacasStats.asp#Animals" class = "menu2">Statistics</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "10%" height = "20" align = "center" ><b><a href = "/Administration/AdminalpacasStats.asp#Animals" class = "menu">Statistics</a></b></td>
    <% end if %>    
    
    <% if screenwidth > 988 then %>
<%  if Current3 = "SEO" then %>
<td class = "tabtopon" width = "40" height = "20" align = "center" ><b><a href = "/Administration/AdminEditSEO.asp?pagelayoutID=<%=pagelayoutID %>" class = "menu2">SEO</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "40" height = "20" align = "center" ><b><a href = "/Administration/AdminEditSEO.asp?pagelayoutID=<%=pagelayoutID %>" class = "menu">SEO</a></b></td>
    <% end if %>  
    
    <% 
     if Current3 = "SEO" or Current3 = "SEOArticle" then
    
     if Current3 = "SEOArticle" then %>
<td class = "tabtopon" width = "70" height = "20" align = "center" ><b><a href = "/Administration/AdminSEOArticle.asp?pagelayoutID=<%=pagelayoutID %>" class = "menu2">About SEO</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "70" height = "20" align = "center" ><b><a href = "/Administration/AdminSEOArticle.asp?pagelayoutID=<%=pagelayoutID %>" class = "menu">About SEO</a></b></td>
    <% end if %>  
       <% end if %>  
  <% end if %>   
   <td >&nbsp;</td>
</tr>
</table>





   

