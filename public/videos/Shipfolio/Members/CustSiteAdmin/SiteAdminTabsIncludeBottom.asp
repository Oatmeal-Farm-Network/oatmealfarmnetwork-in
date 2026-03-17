<table border = "0" cellpadding = "0" cellspacing = "0" width = "100%"  bgcolor = "<%=BorderColor %>"><tr><td height = "10"></td></tr></table>
<table border = "0" cellpadding = "0" cellspacing = "0" width = "100%" bgcolor = "white"><tr>
<td width = "10">&nbsp;</td>
<% if Current4 = "PageAdmin" then %>
<% if Current3 = "EditPages" then%>
<td height = "20" width = "115" align = "center"  class = "tabBottomOn" align = "center"><b><a href = "/Administration/Siteadminhome.asp" class = "menu2">List of Pages</a></b></td>
<% else %> 
<td height = "20" width = "115" align = "center"  class = "tabBottomOff" align = "center"><b><a href = "/Administration/Siteadminhome.asp" class = "menu">List of Pages</a></b></td>
<% end if %>

<% if Current3 = "AddaPage" then%>
<td height = "20" width = "115" align = "center"  class = "tabBottomOn" align = "center"><b><a href = "/Administration/AdminPageAdd.asp" class = "menu2">Add a Page</a></b></td>
<% else %> 
<td height = "20" width = "115" align = "center"  class = "tabBottomOff" align = "center"><b><a href = "/Administration/AdminPageAdd.asp" class = "menu">Add a Page</a></b></td>
<% end if %>

<% if Current3 = "DeletePage" then%>
<td  height = "20" width = "115" align = "center"  class = "tabBottomOn" align = "center"><b><a href = "/Administration/AdminpageDeleteList.asp" class = "menu2">Delete a Page</a></b></td>
<% else %> 
<td  height = "20" width = "115" align = "center"  class = "tabBottomOff" align = "center"><b><a href = "/Administration/AdminpageDeleteList.asp" class = "menu">Delete a Page</a></b></td>
<% end if %>

<% if  Current3 = "PageGroups"  then%>
<td  height = "20" width = "115" align = "center"  class = "tabBottomOn" align = "center"><b><a href = "/Administration/AdminPageGroups.asp" class = "menu2">Page Groups</a></b></td>
<% else %> 
<td  height = "20" width = "115" align = "center"  class = "tabBottomOff" align = "center"><b><a href = "/Administration/AdminPageGroups.asp" class = "menu">Page Groups</a></b></td>
<% end if %>
<% end if %>


<% if Current4 = "EventsAdmin" then %>
<% if Current3 = "EditEvents" then%>
<td  height = "20" width = "115" align = "center"  class = "tabBottomOn" align = "center"><b><a href = "/Administration/EventMantainance.asp" class = "menu2">Edit Events</a></b></td>
<% else %> 
<td  height = "20" width = "115" align = "center"  class = "tabBottomOff" align = "center"><b><a href = "/Administration/EventMantainance.asp" class = "menu">Edit Events</a></b></td>
<% end if %>

<% if Current3 = "AddEvents" then%>
<td  height = "20" width = "115" align = "center"  class = "tabBottomOn" align = "center"><b><a href = "/Administration/EventsAdd.asp" class = "menu2">Add Events</a></b></td>
<% else %> 
<td  height = "20" width = "115" align = "center"  class = "tabBottomOff" align = "center"><b><a href = "/Administration/EventsAdd.asp" class = "menu">Add Events</a></b></td>
<% end if %>

<% if Current3 = "DeleteEvents" then%>
<td  height = "20" width = "115" align = "center"  class = "tabBottomOn" align = "center"><b><a href = "/Administration/EventsDelete.asp" class = "menu2">Delete Events</a></b></td>
<% else %> 
<td  height = "20" width = "115" align = "center"  class = "tabBottomOff" align = "center"><b><a href = "/Administration/EventsDelete.asp" class = "menu">Delete Events</a></b></td>
<% end if %>


<% end if %>
<td >&nbsp;</td></tr></table>