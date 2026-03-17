<% 'session("accesslevel") = 3%>
<% if len(PeopleID) < 1 then
PeopleID = currentPeopleID
end if %>
<table cellpadding = "0" cellspacing = "0" border = "0" width = "<%=screenwidth %>" height = "28"><tr>
<%  if Current = "Home" then %>
<td class = "tabtopon" width = "130" height = "20" align = "center" ><b><a href = "/Default.asp?PeopleID=<%=PeopleID%>" class = "menu2">Home</a></b></td>
<% else %>
<td class = "tabtopoff" width = "130" height = "20" align = "center" ><b><a href = "/Default.asp?PeopleID=<%=PeopleID%>" class = "menu">Home</a></b></td>
<% end if %> 

<%  if Current = "Animals" then %>
<td class = "tabtopon" width = "130" height = "20" align = "center" ><b><a href = "/AnimalsHome.asp?PeopleID=<%=PeopleID%>" class = "menu2">Animals</a></b></td>
<% else %>
<td class = "tabtopoff" width = "130" height = "20" align = "center" ><b><a href = "/AnimalsHome.asp?PeopleID=<%=PeopleID%>" class = "menu">Animals</a></b></td>
<% end if %> 
<%  if Current = "Products" then %>
<td class = "tabtopon" width = "130" height = "20" align = "center" ><b><a href = "/Products/Default.asp?PeopleID=<%=PeopleID%>" class = "menu2">Products</a></b></td>
<% else %>
<td class = "tabtopoff" width = "130" height = "20" align = "center" ><b><a href = "/Products/Default.asp?PeopleID=<%=PeopleID%>" class = "menu">Products</a></b></td>
<% end if %> 
<%  if Current = "Ranches" then %>
<td class = "tabtopon" width = "130" height = "20" align = "center" ><b><a href = "/Ranches/Default.asp?PeopleID=<%=PeopleID%>" class = "menu2">Ranches</a></b></td>
<% else %>
<td class = "tabtopoff" width = "130" height = "20" align = "center" ><b><a href = "/Ranches/Default.asp?PeopleID=<%=PeopleID%>" class = "menu">Ranches</a></b></td>
<% end if %> 

<% showproperties = False
if showproperties = True then
 if Current = "Properties" then %>
<td class = "tabtopon" width = "130" height = "20" align = "center" ><b><a href = "/Properties/Default.asp" class = "menu2">Properties For Sale</a></b></td>
<% else %>
<td class = "tabtopoff" width = "130" height = "20" align = "center" ><b><a href = "/Properties/Default.asp" class = "menu">Properties For Sale</a></b></td>
<% end if %> 
<% end if %> 

<% showproperties = False
if showproperties = True then
if Current = "Businesses" then %>
<td class = "tabtopon" width = "130" height = "20" align = "center" ><b><a href = "/Businesses/Default.asp" class = "menu2">Businesses For Sale</a></b></td>
<% else %>
<td class = "tabtopoff" width = "130" height = "20" align = "center" ><b><a href = "/Businesses/Default.asp" class = "menu">Businesses For Sale</a></b></td>
<% end if %> 
<% end if %> 
<% 
showmarketing = false
if showmarketing = True then
 if Current = "Marketing" then %>
<td class = "tabtopon" width = "130" height = "20" align = "center" ><b><a href = "/Marketing/Default.asp" class = "menu2">Marketing Services</a></b></td>
<% else %>
<td class = "tabtopoff" width = "130" height = "20" align = "center" ><b><a href = "/Marketing/Default.asp" class = "menu">Marketing Services</a></b></td>
<% end if %> 
<% end if %> 
<%  
showbazaar = false
if showbazaar = true then

if Current = "Bazaar" then %>
<td class = "tabtopon" width = "130" height = "20" align = "center" ><b><a href = "/Bazaar/Default.asp?PeopleID=<%=PeopleID%>" class = "menu2"><img src="/images/BazaarTab.png" width = "79" height = "69" border ="0" alt="Online Holiday Bazaar" /><br />Holiday Bazaar</a></b></td>
<% else %>
<td class = "tabtopoff" width = "130" height = "20" align = "center" ><b><a href = "/Bazaar/Default.asp?PeopleID=<%=PeopleID%>" class = "menu"><img src="/images/BazaarTab.png" width = "79" height = "69" border ="0" alt="Online Holiday Bazaar" /><br />Holiday Bazaar</a></b></td>
<% end if 
end if
%>
<% If Session("LoggedIn") = True   then
if Current = "admin" then %>
<td class = "tabtopon" width = "80" height = "20" align = "center" ><b><a href = "/Administration/Default.asp?PeopleID=<%=PeopleID%>" class = "menu2">Dashboard</a></b></td>
<% else %>
<td class = "tabtopoff" width = "80" height = "20" align = "center" ><b><a href = "/Administration/Default.asp?PeopleID=<%=PeopleID%>" class = "menu">Dashboard</a></b></td>
<% end if %>
<% end if %> 
  
<td >&nbsp;</td></tr></table>