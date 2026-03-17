<table cellpadding = "0" cellspacing = "0" border = "0" width = "980" align = "center">
<tr><td>
<%Current="Ranches" %>
<!--#Include virtual="/TopTabsInclude.asp"--> 
<table cellpadding = "0" cellspacing = "0" border = "0" width = "100%" height = "34" bgcolor = "#065906">
<tr>
<td bgcolor="#ababab" width = "1"><img src = "/images/px.gif" width = "1" height = "1"></td>
<td align = "left"><img src = "/images/px.gif" width = "1" height = "1" alt = "Livestock Ranches">
<a href = "Default.asp" class = "menu2">Ranch Search</a> 

</td>
<td align = "right">
<img src = "/images/px.gif" width = "1" height = "1" alt = "Advertise your Animals">
<a href = "/Advertising.asp" class = "menu2">&nbsp;Advertise</font></a> &nbsp; |&nbsp;<a href = "/marketing/websitedesign.asp" class = "menu2">&nbsp;Website Design</font></a> &nbsp;</td><td class = "JoinLOA"><center><a href = "/Join/" class = "JoinLOA" ><big>Join Livestock Of America!</big></a></Center></td><td>
<%  if LoggedOut = true then 
Session.Abandon
%> 
<a href = '/Login.asp' class = "menu2"" >&nbsp;Sign In</a>
<img src = "/images/px.gif" width = "1" height = "1" alt = "Log Into LOA">
<a href = '/Join/' class = "menu2">&nbsp;Join LOA</font></a>
<% else %>

<%  if len(Session("PeopleID")) > 0 then %>
<a href = '/Logout.asp' class = "menu2" >&nbsp;Sign Out</a>
<% else %>
<a href = '/Login.asp' class = "menu2">&nbsp;Sign In</a>
</td>

<% end if %>
<% end if %>
</td>
<td  width = "8"><img src = "images/px.gif" width = "1" height = "1"></td>
<td bgcolor="#abacab" width = "1"><img src = "images/px.gif" width = "1" height = "1"></td>
</tr>
</tr>
<tr><td colspan = "5" height = "1" bgcolor="#abacab"></td></tr>
</table>
<table  width="980" border="0" bordercolor="#D37F1C" cellpadding=0 cellspacing=0  align = "center"  align="center"><tr><td align="center" valign="top"  bgcolor = "white" height = "628">
