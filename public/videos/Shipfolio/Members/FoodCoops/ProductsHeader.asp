<table cellpadding = "0" cellspacing = "0" border = "0" width = "<%=screenwidth %>" align = "center" >
<tr><td>
<!--#Include virtual="/TopTabsInclude.asp"--> 
<table cellpadding = "0" cellspacing = "0" border = "0" width = "988" height = "34" bgcolor = "#065906">
<tr><td bgcolor = "#065906" width = "1"><img src = "/images/px.gif" width = "1" height = "1" alt ="animals"></td>
<td >
<a href = "/Default.asp?PeopleID=<%=PeopleID%>" class = "menu2"><img src="/images/HomeTab.png"  height = "19" border ="0" alt="Animals" />Home</a> |

<img src = "images/px.gif" width = "20" height = "1" alt ="About Livestock of America">
<a href = "/AboutUs.asp?PeopleID=<%=PeopleID %>" class = "menu2">About Livestock of America</a> | 
 <a href = "/ContactUs.asp" class = "menu2">Contact Us</a> | <a href = "/emailsignup.asp" alt= "Sign Up To Receive Emails"  class = "menu2" >Email Sign Ups</a> |
<a href = "/Advertising.asp" class = "menu2">&nbsp;Advertise</font></a> &nbsp;</td><td class = "Discounts"> <a href = "/marketing/discounts.asp" alt = "Discounts" class = "menu2" >Discounts</a> </td><td class = "JoinLOA"><center><a href = "/Join/" class = "JoinLOA" ><big>Join Livestock Of America!</big></a></Center></td><td>
<%  if LoggedOut = true then 
Session.Abandon
%> 
<img src = "/images/px.gif" width = "1" height = "1" alt = "Log into Livestock of America and Sell animals">
<a href = '/Login.asp' class = "menu2">&nbsp;Sign In</a>
<% else %>
<%  if len(Session("PeopleID")) > 0 then %>
<a href = '/Logout.asp' class = "menu2" >&nbsp;Sign Out</a>
<% else %>
<a href = '/Login.asp' class = "menu2">&nbsp;Sign In</a>
</td>
<% end if %>
<% end if %>
</td>
<td  width = "9"><img src = "images/px.gif" width = "1" height = "1" alt = "Sign into of Livestock of America  - Animal Marketplace"></td>
<td bgcolor="#abacab" width = "1"><img src = "images/px.gif" width = "1" height = "1" alt = "Livestock of Americay  - Animal Marketplace"></td>
</tr></table>
<!--#Include file="ProductsTabsIncludeBottom.asp"--> 
<table  width="<%=screenwidth %>" border="0" bordercolor="<%=PrimaryColor %>" cellpadding=0 cellspacing=0  align = "center"  align="center"><tr><td align="center" valign="top"  bgcolor = "white" height = "628">