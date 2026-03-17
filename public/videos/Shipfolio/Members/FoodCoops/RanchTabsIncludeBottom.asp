<% if len(PageBackgroundColor) > 1 then
else
PageBackgroundColor = "White"
end if
 %>
 <table border = "0" cellpadding = "0" cellspacing = "0" width = "100%" bgcolor = "<%= PageBackgroundColor%>">
     <tr>
 <% if Current2 = "FarmHome"  then %>
<td  height = "20" width = "90" align = "center"  class = "tabBottomOn" align = "center"><b><a href = "/AlpacaRanchQuest/Default.asp" class = "menu">Farms Home</a></b></td>
<% else %> 
<td  height = "20" width = "90" align = "center"  class = "tabBottomOff" align = "center"><b><a href = "/AlpacaRanchQuest/Default.asp" class = "menu">Farms Home</a></b></td>
<% end if %>
<% if Current2 = "SearchByState" then %>
		 <td  height = "20" width = "110" align = "center"  class = "tabBottomOn" align = "center"><b><a href = "/AlpacaRanchQuest/SearchByState.asp" class = "menu">Search by State</a></b></td>
	   <% else %>
<td  height = "20" width = "110" align = "center"  class = "tabBottomOff" align = "center"><b><a href = "/AlpacaRanchQuest/SearchByState.asp" class = "menu">Search by State</a></b></td>
	   <% end if %>
    <td >&nbsp;</td>
   </tr>
   </table>