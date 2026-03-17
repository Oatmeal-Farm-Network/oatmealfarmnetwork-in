<br />
<table cellpadding = "0" cellspacing = "0" border = "0">
<tr><td>
<% if Current3 = "EditEvents" then%>
<td  height = "20" width = "115" align = "center"  class = "tabtopon" align = "center"><b><a href = "/Administration/EventMantainance.asp" class = "menu2">Edit Events</a></b></td>
<% else %> 
<td  height = "20" width = "115" align = "center"  class = "tabtopoff" align = "center"><b><a href = "/Administration/EventMantainance.asp" class = "menu">Edit Events</a></b></td>
<% end if %>

<% if Current3 = "AddEvents" then%>
<td  height = "20" width = "115" align = "center"  class = "tabtopon" align = "center"><b><a href = "/Administration/EventsAdd.asp" class = "menu2">Add Events</a></b></td>
<% else %> 
<td  height = "20" width = "115" align = "center"  class = "tabtopoff" align = "center"><b><a href = "/Administration/EventsAdd.asp" class = "menu">Add Events</a></b></td>
<% end if %>

<% if Current3 = "DeleteEvents" then%>
<td  height = "20" width = "115" align = "center"  class = "tabtopon" align = "center"><b><a href = "/Administration/EventsDelete.asp" class = "menu2">Delete Events</a></b></td>
<% else %> 
<td  height = "20" width = "115" align = "center"  class = "tabtopoff" align = "center"><b><a href = "/Administration/EventsDelete.asp" class = "menu">Delete Events</a></b></td>
<% end if %>
<td >&nbsp;</td></tr></table>