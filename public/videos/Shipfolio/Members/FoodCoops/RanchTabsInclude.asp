<br /><% if len(PageBackgroundColor) > 1 then
else
PageBackgroundColor = "White"
end if
 %>
<table border = "0" cellpadding = "0" cellspacing = "0" width = "100%" bgcolor = "<%= PageBackgroundColor%>"><tr>
<td width = '10'></td>
<% if Current2 = "RanchHome"  then %>
<td  height = "20" width = "90" align = "center"  class = "tabtopon" align = "center"><b><a href = "Default.asp" class = "menu2">Ranches Home</a></b></td>
<% else %> 
<td  height = "20" width = "90" align = "center"  class = "tabtopoff" align = "center"><b><a href = "Default.asp" class = "menu">Ranches Home</a></b></td>
<% end if %>
<% if Current2 = "SearchByState" then %>
<td  height = "20" width = "110" align = "center"  class = "tabtopon" align = "center"><b><a href = "SearchByState.asp" class = "menu2">Search by State</a></b></td>
<% else %>
<td  height = "20" width = "110" align = "center"  class = "tabtopoff" align = "center"><b><a href = "SearchByState.asp" class = "menu">Search by State</a></b></td>
<% end if %>
<td >&nbsp;</td>
</tr>
</table>