<table cellpadding = "0" cellspacing = "0" border = "0" width = "980" align = "center">
<tr><td>
<!--#Include virtual="TopTabsInclude.asp"--> 
<table cellpadding = "0" cellspacing = "0" border = "0" width = "988" height = "34" bgcolor = "#065906">
<tr><td bgcolor = "#065906" width = "1"><img src = "/images/px.gif" width = "1" height = "1" alt ="animals"/></td>
<td ><img src = "/images/px.gif" width = "20" height = "1" title = "About Livestock Of America" alt = "About Livestock Of America">
<a href = "/AboutUs.asp?PeopleID=<%=PeopleID %>" class = "menu2">About LOA</a> | 
<% 
if showtoptabs = true then
%>
<a href = "/LOAcelebration.asp" class = "menu2">Members-Only Offers</a> | 
<% end if %><a href = "/ContactUs.asp" class = "menu2">Contact Us</a> | 
</td>
<td align = "right">
<% showreferalprogram = True
if showreferalprogram = True Then %>

<img src = "/images/px.gif" width = "1" height = "1" alt = "Referral Program">
<a href = "/ReferralProgram.asp" class = "menu2">&nbsp;Refer a Friend</font></a> |
<% end if %>
<img src = "/images/px.gif" width = "1" height = "1" title = "Advertise with Livestock of America and Sell Animals" alt = "Advertise with Livestock of America and Sell Animals">

<a href = "/join/default.asp#advertising" class = "menu2">&nbsp;Advertise</font></a>&nbsp;&nbsp;|<a href = "emailsignup.asp" alt = "Sign Up To Receive Emails" class = "menu2" >Sign Up To Receive Our Emails</a> | </td><td class = "JoinLOA"><center><a href = "/Join/" class = "JoinLOA" ><big>Join Livestock Of America!</big></center></a></td><td>
<% screenwidth = 980 
if LoggedOut = true then 
Session.Abandon
%> 
<img src = "/images/px.gif" width = "1" height = "1" title = "Log into Livestock of America and Sell livestock" alt = "Log into Livestock of America and Sell Animals"/>
<a href = '/Login.asp' class = "menu2">&nbsp;Sign In</a>
<% else %>
<%  if  Session("Loggedin")= True then %>
<a href ="/Logout.asp" class = "menu2" >&nbsp;Sign Out</a>
<% else %>
<a href = "/Login.asp" class = "menu2">&nbsp;Sign In</a>
<img src = "/images/px.gif" width = "1" height = "1" title= "Sign into of Livestock of America & sell your animals." alt = "Sign into of Livestock of America & sell your animals."/>

<% end if %>
<% end if %>
</td>
<td  width = "9">
<img src = "/images/px.gif" width = "1" height = "1" title = "Sign into of Livestock of America  - Animal Marketplace" alt = "Sign into of Livestock of America  - Animal Marketplace"></td>
<td bgcolor="#abacab" width = "1">
<img src = "/images/px.gif" width = "1" height = "1" title = "Livestock of America  - Animal Marketplace" alt = "Livestock of America  - Animal Marketplace"></td>
</tr></table>
<!--#Include virtual="AnimalsTabsIncludeBottom.asp"--> 
<table  width="987" border="0" cellpadding=0 cellspacing=0  align = "center"  align="center"><tr><td align="center" valign="top"  bgcolor = "white" height = "628"><br />