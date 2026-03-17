
<table cellpadding = "0" cellspacing = "0" border = "0" width = "<%=screenwidth -10%>" height = "28" align = "center">
   <tr>
   <td width = "1"></td>
     <td>
<%  if Current3 = "DesignHome" then %>
<td class = "tabtopon" width = "90" height = "20" align = "center" ><b><a href = "/Administration/AdminsiteDesign.asp" class = "menu2">Site Design</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "90" height = "20" align = "center" ><b><a href = "/Administration/AdminsiteDesign.asp" class = "menu">Site Design</a></b></td>
<% end if %> 
    
  
<%  if Current3 = "FarmHome" then %>
<td class = "tabtopon" width = "90" height = "20" align = "center" ><b><a href = "/Administration/Ranchhomeadmin.asp?PeopleID=<%=PeopleID %>" class = "menu2">Home Page</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "90" height = "20" align = "center" ><b><a href = "/Administration/Ranchhomeadmin.asp?PeopleID=<%=PeopleID %>" class = "menu">Home Page</a></b></td>
    <% end if %> 
     
<%  if Current3 = "About Us" then %>
<td class = "tabtopon" width = "90" height = "20" align = "center" ><b><a href = "/Administration/PageData2.asp?pagename=About Us&PeopleID=<%=PeopleID %>" class = "menu2">About Us</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "90" height = "20" align = "center" ><b><a href = "/Administration/PageData2.asp?pagename=About Us&PeopleID=<%=PeopleID %>" class = "menu">About Us</a></b></td>
    <% end if %> 
    
    <% ShowGallery = False 
    if ShowGallery = True then %>
         <%  if Current3 = "PhotoGallery" then %>
<td class = "tabtopon" width = "90" height = "20" align = "center" ><b><a href = "/Administration/AdminGallery.asp?PeopleID=<%=PeopleID %>" class = "menu2">Photo Gallery</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "90" height = "20" align = "center" ><b><a href = "/Administration/AdminGallery.asp?PeopleID=<%=PeopleID %>" class = "menu">Photo Gallery</a></b></td>
    <% end if %> 
    <% end if %> 
     
         <% ShowBlog = False 
    if Showblog= True then %>
      
           <%  if Current3 = "Blog" then %>
<td class = "tabtopon" width = "90" height = "20" align = "center" ><b><a href = "/Administration/AdminBloghome.asp" class = "menu2">Blog</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "90" height = "20" align = "center" ><b><a href = "/Administration/AdminBloghome.asp" class = "menu2">Blog</a></b></td>
    <% end if %> 
      <% end if %> 
      
       
         <% ShowLinks = False 
    if ShowLinks= True then %>    
    <%  if Current3 = "Links" then %>
<td class = "tabtopon" width = "90" height = "20" align = "center" ><b><a href = "/Administration/AdminLinkMaintenance.asp?ProductID=<%=ProductID %>" class = "menu2">Links</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "90" height = "20" align = "center" ><b><a href = "/Administration/AdminLinkMaintenance.asp?ProductID=<%=ProductID %>" class = "menu">Links</a></b></td>
    <% end if %> 
      <% end if %> 

<% ShowTerms = False 
    if ShowTerms= True then %>    
<%  if Current3 = "Terms" then %>
<td class = "tabtopon" width = "100" height = "20" align = "center" ><b><a href = "/Administration/PageData2.asp?pagename=Terms and Policies&PeopleID=<%=PeopleID %>" class = "menu2">Terms & Policies</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "100" height = "20" align = "center" ><b><a href = "/Administration/PageData2.asp?pagename=Terms And Policies&PeopleID=<%=PeopleID %>" class = "menu">Terms & Policies</a></b></td>
    <% end if %> 
       <% end if %>    


<% ShowContactus = False 
    if ShowContactus= True then %>    
    
       <%  if Current3 = "ContactUs" then %>
<td class = "tabtopon" width = "90" height = "20" align = "center" ><b><a href = "/Administration/AdminContactUs.asp" class = "menu2">Contact Us</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "90" height = "20" align = "center" ><b><a href = "/Administration/AdminContactUs.asp#Products" class = "menu">Contact Us</a></b></td>
    <% end if %> 
   <% end if %>   

   <td >&nbsp;</td>
</tr>
</table>