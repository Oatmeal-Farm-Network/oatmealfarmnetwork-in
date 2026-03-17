<% Current = "Marketing"%>
 <table cellpadding = "0" cellspacing = "0" border = "0" width = "100%" bgcolor = "#EFAE15" align = "center">
<tr><td>
<table cellpadding = "0" cellspacing = "0" border = "0" width = "<%=screenwidth %>" height = "34" align = center bgcolor = "#EFAE15">


<% 
showregister = True
if showregister = True then
if Current3="Register" then %>
<td bgcolor="#EFAE15" width = 70><center><a href = "/Join/" class = "menublack" ><big>Join</big></center></a></td>
<% else %>
<td width = 70><center><a href = "/Join/" class = "menublack" ><big>Join</big></center></a></td>
<% end if %>
<% end if %>


<% if Current3 = "Blog" then %>
<td bgcolor="#EFAE15" width = 70>
<a href = "/blog/Default.asp?PeopleID=<%=PeopleID %>&screenwidth=<%=Screenwidth %>" class = "menublack"><center>Blog</center></a>
</td>
<% else %>
<td width = 70 >
<a href = "/blog/Default.asp?PeopleID=<%=PeopleID %>&screenwidth=<%=Screenwidth %>" class = "menublack"><center>Blog</center></a>
</td>
<% end if %>


<% if Current3 = "Newsletters" then %>
<td bgcolor="#EFAE15" width = 70>
<a href = "/Newsletters/?PeopleID=<%=PeopleID %>&screenwidth=<%=Screenwidth %>" class = "menublack"><center>Newsletters</center></a>
</td>
<% else %>
<td width = 70 >
<a href = "/Newsletters/?PeopleID=<%=PeopleID %>&screenwidth=<%=Screenwidth %>" class = "menublack"><center>Newsletters</center></a>
</td>
<% end if %>


<% if Current3 = "Press" then %>
<td bgcolor="#EFAE15" width = 100>
<a href = "/Press/?PeopleID=<%=PeopleID %>&screenwidth=<%=Screenwidth %>" class = "menublack"><center>Press</center></a>
</td>
<% else %>
<td width = 100 >
<a href = "/Press/?PeopleID=<%=PeopleID %>&screenwidth=<%=Screenwidth %>" class = "menublack"><center>Press</center></a>
</td>
<% end if %>


<% if Current3 = "AboutUs" then %>
<td bgcolor="#EFAE15" width = 100>
<a href = "/communities/?PeopleID=<%=PeopleID %>&screenwidth=<%=Screenwidth %>" class = "menublack"><center>About Us</center></a>
</td>
<% else %>
<td width = 100 >
<a href = "/communities/?PeopleID=<%=PeopleID %>&screenwidth=<%=Screenwidth %>" class = "menublack"><center>About Us</center></a>
</td>
<% end if %>

<% if Current3 = "ContactUs" then %>
<td bgcolor="#EFAE15" width = 100>
<a href = "/ContactUs.asp?PeopleID=<%=PeopleID %>" class = "menublack"><center>Contact Us</center></a>
</td>
<% else %>
<td width = 100 >
<a href = "/ContactUs.asp?PeopleID=<%=PeopleID %>" class = "menublack"><center>Contact Us</center></a>
</td>
<% end if %>

<% showadvertising = false
if showadvertising = True then %>
<% if Current3="Advertising" then %>
<td bgcolor="#EFAE15" width = 100>
<a href = "/Advertising.asp?PeopleID=<%=PeopleID %>" class = "menublack"><center>Advertise</center></a>
</td>
<% else %>
<td width = 100 >
<a href = "/Advertising.asp?PeopleID=<%=PeopleID %>" class = "menublack"><center>Advertise</center></a>
</td>
<% end if %>
<% end if %>


<% if Current3="EmailSignup" then %>
<td bgcolor="#EFAE15" width = 120>
<a href = "/emailsignup.asp" alt = "Sign Up To Receive Emails" class = "menublack" ><center>Email Sign Up</center></a>
</td>
<% else %>
<td width = 120 >
<a href = "/emailsignup.asp" alt = "Sign Up To Receive Emails" class = "menublack" ><center>Email Sign Up</center></a>
</td>
<% end if %>

<% if len(Peopleid) then %>
<td width = 100><a href = "http://www.livestockoftheworld.com/members/" alt = "Sign Into Your Account" taget = "_blank" class = "menublack" ><center>My Account</center></a></td>

<% else %>
<% if Current3="Signin" then %>
<td bgcolor="#EFAE15" width = 100>
<a href = "/login.asp" alt = "Sign Into Your Account" class = "menublack" ><center>Sign In</center></a>
</td>
<% else %>
<td width = 100 >
<a href = "/login.asp" alt = "Sign Into Your Account" class = "menublack" ><center>Sign In</center></a>
</td>
<% end if %>
<% end if %>

<td>
</td></tr></table>
</td></tr></table>
<table width="<%=screenwidth %>" border="0" cellpadding=0 cellspacing=0  align = "center"  align="center" valign = top><tr><td valign="top"  bgcolor = "white" >