
<table cellpadding = "0" cellspacing = "0" border = "0" width = "970" height = "28" align = "center">
   <tr>
     <td>
<%  if Current3 = "AccountHome" then %>
<td class = "tabtopon" width = "120" height = "20" align = "center" ><b><a href = "/Administration/AdminAccountMaintenance.asp" class = "menu2">Account Info</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "120" height = "20" align = "center" ><b><a href = "/Administration/AdminAccountMaintenance.asp" class = "menu">Account Info</a></b></td>
<% end if %> 
    
    
<%  if Current3 = "Password" then %>
<td class = "tabtopon" width = "110" height = "20" align = "center" ><b><a href = "/Administration/AdminPasswordChange.asp" class = "menu2">Reset Password</a></b></td>
   <% else %>
<td class = "tabtopoff" width = "110" height = "20" align = "center" ><b><a href = "/Administration/AdminPasswordChange.asp" class = "menu">Reset Password</a></b></td>
    <% end if %> 
    
   

   <td >&nbsp;</td>
</tr>
</table>




   

