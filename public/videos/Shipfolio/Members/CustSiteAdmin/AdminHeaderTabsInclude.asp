<table cellpadding = "0" cellspacing = "0" border = "0"  height = "28" align = "left">
   <tr>
   <td width = "6"></td>
     <td>
        <% if Current = "Dashboard" then %>
   <td class = "tabtopon" width = "90" height = "20" align = "center" ><b><a href = "/administration/default.asp" class = "menu2">Dashboard</a></b></td>
   <% else %>
   <td class = "tabtopoff" width = "90" height = "20" align = "center" ><b><a href = "/administration/default.asp" class = "menu2">Dashboard</a></b></td>
   <% end if %>
   
   
	<% if session("accesslevel") > 2 then %>
   <% if Current = "Reports" then %>
   <td class = "tabtopon" width = "90" height = "20" align = "center" ><b><a href = "/administration/reports/default.asp" class = "menu2">Reports</a></b></td>
   <% else %>
   <td class = "tabtopoff" width = "90" height = "20" align = "center" ><b><a href = "/administration/reports/default.asp" class = "menu2">Reports</a></b></td>
   <% end if %>
   
<% if Current = "Transfer Data" then %>
  <td class = "tabtopon" width = "90" height = "20" align = "center" ><b><a href = "/administration/Transfers/default.asp" class = "menu2">Transfer Data</a></b></td>
   <% else %>
   <td class = "tabtopoff" width = "90" height = "20" align = "center" ><b><a href = "/administration/Transfers/default.asp" class = "menu2">Transfer Data</a></b></td>
   <% end if %>

<% end if %>
 <% if Current = "Alpaca Infinity" then %>
   <td class = "tabtopon" width = "90" height = "20" align = "center" ><b><a href = "/administration/AI/default.asp" class = "menu2">Alpaca Infinity</a></b></td>
   <% else %>
   <td class = "tabtopoff" width = "90" height = "20" align = "center" ><b><a href = "/administration/AI/default.asp" class = "menu2">Alpaca Infinity</a></b></td>
   <% end if %>
   <td ></td>
</tr>
</table>
