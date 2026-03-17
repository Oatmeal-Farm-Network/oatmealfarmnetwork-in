
<table cellpadding = "0" cellspacing = "0" border = "0" width = "<%=screenwidth - 35 %>" height = "28" align = "center">
   <tr>
     <td>
  
<%  if Current3 = "BlogHome" then %>
<td class = "tabtopon" width = "200" height = "20" align = "center" ><b><a href = "/Administration/BlogAdmin/Default.asp" class = "menu2">List of Blog Articles & Add Articles</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "200" height = "20" align = "center" ><b><a href = "/Administration/BlogAdmin/Default.asp" class = "menu">List of Blog Articles & Add Articles</a></b></td>
<% end if %> 



    <%  if Current3 = "DeleteArticles" then %>
<td class = "tabtopon" width = "120" height = "20" align = "center" ><b><a href = "/Administration/BlogAdmin/BlogAdminArticleDelete.asp" class = "menu2">Delete</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "120" height = "20" align = "center" ><b><a href = "/Administration/BlogAdmin/BlogAdminArticleDelete.asp" class = "menu">Delete</a></b></td>
<% end if %> 
  <%  if Current3 = "PageContent" then %>
<td class = "tabtopon" width = "120" height = "20" align = "center" ><b><a href = "/Administration/AdminPageMaintenance.asp?pagelayoutid=38" class = "menu2">Heading</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "120" height = "20" align = "center" ><b><a href = "/Administration/AdminPageMaintenance.asp?pagelayoutid=38" class = "menu">Heading</a></b></td>
<% end if %> 
    
   <%  if Current3 = "SEO" then %>
<td class = "tabtopon" width = "40" height = "20" align = "center" ><b><a href = "/Administration/AdminEditSEO.asp?pagename=Blog" class = "menu2">SEO</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "40" height = "20" align = "center" ><b><a href = "/Administration/AdminEditSEO.asp?pagename=Blog" class = "menu">SEO</a></b></td>
    <% end if %>  
    
    <% 
     if Current3 = "SEO" or Current3 = "SEOArticle" then
    
     if Current3 = "SEOArticle" then %>
<td class = "tabtopon" width = "70" height = "20" align = "center" ><b><a href = "/Administration/AdminSEOArticle.asp?pagename=Blog" class = "menu2">About SEO</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "70" height = "20" align = "center" ><b><a href = "/Administration/AdminSEOArticle.asp?pagename=Blog" class = "menu">About SEO</a></b></td>
    <% end if %>  
       <% end if %>  
   <td >&nbsp;</td>
</tr>
</table>




   

