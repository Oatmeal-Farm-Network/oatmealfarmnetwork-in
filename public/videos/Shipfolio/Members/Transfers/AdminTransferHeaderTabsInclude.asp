<% EventID = request.querystring("EventID")  %>

<h1><%=EventName%></h1>
<table cellpadding = "0" cellspacing = "0" border = "0" width = "100%" height = "28">
   <tr>
     <td>
        <% if Current = "Dashboard" then %>
   <td class = "body2" width = "90" height = "30" align = "center" background = "images/TabOn.jpg"><b><a href = "/administration/default.asp" class = "menu2">Dashboard</a></b></td>
   <% else %>
   <td class = "body2" width = "90" height = "30" align = "center" background = "images/TabOff.jpg"><b><a href = "/administration/default.asp" class = "menu2">Dashboard</a></b></td>
   <% end if %>
   
  
   <% if Current = "Reports" then %>
   <td class = "body2" width = "90" height = "30" align = "center" background = "images/TabOn.jpg"><b><a href = "/administration/reports/default.asp" class = "menu2">Reports</a></b></td>
   <% else %>
   <td class = "body2" width = "90" height = "30" align = "center" background = "images/TabOff.jpg"><b><a href = "/administration/reports/default.asp" class = "menu2">Reports</a></b></td>
   <% end if %>
   
<% if Current = "Transfer Data" then %>
   <td class = "body2" width = "90" height = "30" align = "center" background = "images/TabOn.jpg"><b><a href = "/administration/Transfers/default.asp" class = "menu2">Transfer Data</a></b></td>
   <% else %>
   <td class = "body2" width = "90" height = "30" align = "center" background = "images/TabOff.jpg"><b><a href = "/administration/Transfers/default.asp" class = "menu2">Transfer Data</a></b></td>
   <% end if %>

 <% if Current = "Alpaca Infinity" then %>
   <td class = "body2" width = "90" height = "30" align = "center" background = "images/TabOn.jpg"><b><a href = "/administration/AI/default.asp" class = "menu2">Alpaca Infinity</a></b></td>
   <% else %>
   <td class = "body2" width = "90" height = "30" align = "center" background = "images/TabOff.jpg"><b><a href = "/administration/AI/default.asp" class = "menu2">Alpaca Infinity</a></b></td>
   <% end if %>


   <td background = "images/TopTabBlank.jpg">&nbsp;</td>
</tr>
</table>
