<table cellpadding = "0" cellspacing = "0" border = "0" width = "<%=screenwidth -35  %>" height = "28" align = "left">
   <tr><% if mobiledevice = False then%>
   <td width = "25"></td>
   <% end if %>
       <td>
     <%  if Current3 = "ArticlesHome" then %>
<% if mobiledevice = False then%>
<td class = "tabtopon" width = "80" height = "20" align = "center" >
<%else %>
<td class = "tabtopon" width = "170" height = "50" align = "center" >
<% end if %>
<b><a href = "/Administration/AdminArticleMaintenance.asp?PeopleID=<%=session("PeopleID") %>" class = "menu2">List of Articles</a></b></td>
   <% else %>
<% if mobiledevice = False then %>
<td class = "tabtopoff" width = "80" height = "20" align = "center" >
<%else %>
<td class = "tabtopoff" width = "170" height = "50" align = "center" >
<% end if %><b><a href = "/Administration/AdminArticleMaintenance.asp?PeopleID=<%=session("PeopleID") %>" class = "menu">List of Articles</a></b></td>
<% end if %> 

<%  if Current3 = "AddArticles" then %>
<% if mobiledevice = False then %>
<td class = "tabtopon" width = "80" height = "20" align = "center" >
<%else %>
<td class = "tabtopon" width = "120" height = "50" align = "center" >
<% end if %><b><a href = "/Administration/AdminArticleAdd.asp?PeopleID=<%=session("PeopleID") %>" class = "menu2">Add</a></b></td>
   <% else %>
<% if mobiledevice = False then %>
<td class = "tabtopoff" width = "80" height = "20" align = "center" >
<%else %>
<td class = "tabtopoff" width = "120" height = "50" align = "center" >
<% end if %><b><a href = "/Administration/AdminArticleAdd.asp?PeopleID=<%=session("PeopleID") %>" class = "menu">Add</a></b></td>
<% end if %> 
    
    
<%  if Current3 = "EditArticles"  and mobiledevice = False  then %>
<% if mobiledevice = False then%>
<td class = "tabtopon" width = "80" height = "20" align = "center" >
<%else %>
<td class = "tabtopon" width = "120" height = "50" align = "center" >
<% end if %><b><a href = "/Administration/AdminArticleEdit.asp?PeopleID=<%=session("PeopleID") %>" class = "menu2">Edit</a></b></td>
   <% else %>
<% if mobiledevice = False then%>
<td class = "tabtopoff" width = "80" height = "20" align = "center" >
<%else %>
<td class = "tabtopoff" width = "120" height = "50" align = "center" >
<% end if %><b><a href = "/Administration/AdminArticleEdit.asp?PeopleID=<%=session("PeopleID") %>" class = "menu">Edit</a></b></td>
    <% end if %> 
    
    
         <%  if Current3 = "DeleteArticles" then %>
<% if mobiledevice = False then%>
<td class = "tabtopon" width = "80" height = "20" align = "center" >
<%else %>
<td class = "tabtopon" width = "120" height = "50" align = "center" >
<% end if %><b><a href = "/Administration/AdminArticleDelete.asp??PeopleID=<%=session("PeopleID") %>" class = "menu2">Delete</a></b></td>
   <% else %>
<% if mobiledevice = False then %>
<td class = "tabtopoff" width = "80" height = "20" align = "center" >
<%else %>
<td class = "tabtopoff" width = "120" height = "50" align = "center" >
<% end if %><b><a href = "/Administration/AdminArticleDelete.asp?PeopleID=<%=session("PeopleID") %>" class = "menu">Delete</a></b></td>
    <% end if %> 
    
    <%  if Current3 = "ArticleCategories" then %>
<% if mobiledevice = False then %>
<td class = "tabtopon" width = "80" height = "20" align = "center" >
<%else %>
<td class = "tabtopon" width = "130" height = "50" align = "center" >
<% end if %><b><a href = "/Administration/AdminArticleCategoriesSet.asp?PeopleID=<%=session("PeopleID") %>" class = "menu2">Categories</a></b></td>
   <% else %>
<% if mobiledevice = False then %>
<td class = "tabtopoff" width = "80" height = "20" align = "center" >
<%else %>
<td class = "tabtopoff" width = "130" height = "50" align = "center" >
<% end if %><b><a href = "/Administration/AdminArticleCategoriesSet.asp?PeopleID=<%=session("PeopleID") %>" class = "menu">Categories</a></b></td>
    <% end if %> 
    
 
       <%  if Current3 = "ArticlesHeader" then %>
<% if mobiledevice = False then %>
<td class = "tabtopon" width = "90" height = "20" align = "center" >
<%else %>
<td class = "tabtopon" width = "130" height = "50" align = "center" >
<% end if %><b><a href = "/administration/AdminPageMaintenance.asp?pagename=Alpaca Library?PeopleID=<%=session("PeopleID") %>" class = "menu2">Header</a></b></td>
   <% else %>
<% if mobiledevice = False then%>
<td class = "tabtopoff" width = "90" height = "20" align = "center" >
<%else %>
<td class = "tabtopoff" width = "130" height = "50" align = "center" >
<% end if %><b><a href = "/administration/AdminPageMaintenance.asp?pagename=Articles&PeopleID=<%=session("PeopleID") %>" class = "menu">Header</a></b></td>
    <% end if %> 
      
      
       
       
   <td >&nbsp;</td>
</tr>
</table>




   

