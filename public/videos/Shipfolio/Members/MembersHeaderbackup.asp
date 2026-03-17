

<% 
if mobiledevice = True or is_iPad = true then 

menuSize = "12"
menuFont = "Verdana"
menuAlign = "Left"
menuWeight =" Normal"
menucolor= "white"
menuBackgroundImage = ""
menuBackgroundColor = "white"
menuradiusleft  = "3px"
menuradiusright = "3px"
menuradiusleft = "3px"
menuradiusright = "3px"

menumenuColorMouseoverr= "white"
menumenuColor= "white"
menuShadow = True
menuFontMouseOverColor= "Black"

MenuSize =MenuSize + 22
TitleSize = TitleSize + 10
FooterTextSize = FooterTextSize+ 10
H1Size = H1Size + 10
H2Size = H2Size + 10
H3Size = H3Size + 10
PageTextFontsize = PageTextFontsize + 12
buttonheight = 80
else
buttonheight = 50
end if
%>

<% if mobiledevice = True or screenwidth < 800 then %> 
<style> 
/* mobiledropdown */
#mobiledropdown
{position:relative;
text-size: 20px;
line-height: 60px;
font-family: verdana, Arial, san-serif;
align: left;
font-weight: 600;
margin:0 auto;  
margin-top:0px; 
padding:0px;
list-style: none;  
border-bottom-left-radius:3px;
border-bottom-right-radius:3px;
-moz-border-radius-bottomleft:3px; /* Firefox 3.6 and earlier */
-moz-border-radius-bottomright:3px; /* Firefox 3.6 and earlier */
-moz-box-shadow: 3px 3px 8px  black;
-webkit-box-shadow: 3px 3px 8px  black;
box-shadow: 3px 3px 8px black;
}

#mobiledropdown li
{
float: left;
padding: 0 0 0px 0;
position: relative;
line-height: 2;
}

#mobiledropdown a 
{display:inline-block;
align: left;
valign: top;
float: left;
height: 0px;
padding: 18px 18px;
color: black;
<% if screenwidth > 320 then %>
line-height: 70px;
font-size: 15px;
<% else %>
line-height: 60px;
font-size: 20px;
<% end if %>
font-family : verdana, Arial, san-serif;
text-decoration: none;
}

#mobiledropdown li:hover > a
{
color: white;
}

*html #mobiledropdown li a:hover /* IE6 */
{
color: #3D6B33;
}

#mobiledropdown li:hover > ul
{
display: block;
}

/* Sub-mobiledropdown */

#mobiledropdown ul
{list-style: none;
margin: 0;
padding: 0; 
display: none;
position: absolute;
top: 60px;
left: 0;
float: left;
z-index: 99999; 
text-align: left;
background-color: white ;
background: white;
-moz-box-shadow: 0 0 2px black;
-webkit-box-shadow: 0 0 2px black;
box-shadow: 0px 5px 5px black;
-moz-border-radius: 5px;
border-radius: 0px 0px 5px 5px;
}

#mobiledropdown ul ul
{ top: 0;
  left: 0px;}

#mobiledropdown ul li
{ float: left;
margin: 0;
padding: 0;
display: block;  
-moz-box-shadow: none;
-webkit-box-shadow: none;
box-shadow: none; 
}

#mobiledropdown ul li:last-child
{ -moz-box-shadow: none;
-webkit-box-shadow: none;
box-shadow: none; 
}

#mobiledropdown ul a
{ 
 padding: 8px;
height: 30px;
width: 280px;
height: auto;
 line-height: 1;
 display: block;
float: left;
text-transform: none;
}

*html #mobiledropdown ul a /* IE6 */
{ 
height: 30px;
}

*:first-child+html #mobiledropdown ul a /* IE7 */
{ 
height: 30px;
}

#mobiledropdown ul a:hover
{
 background: #3D6B33;
}

#mobiledropdown ul li:first-child > a
{
 -moz-border-radius: 5px 5px 0 0;
 border-radius: 5px 5px 0 0;
}

#mobiledropdown ul li:first-child > a:after
{
 content: '';
 position: absolute;
 left: 30px;
 top: -8px;
 width: 0;
 height: 0;
 border-left: 5px solid transparent;
 border-right: 5px solid transparent;
 border-bottom: 8px solid #444;
}

#mobiledropdown ul ul li:first-child a:after
{
 left: -8px;
 top: 12px;
 width: 0;
 height: 0;
 border-left: 0;
 border-bottom: 5px solid transparent;
 border-top: 5px solid transparent;
 border-right: 8px solid #444;
}

#mobiledropdown ul li:first-child a:hover:after
{
 border-bottom-color: white; 
}

#mobiledropdown ul ul li:first-child a:hover:after
{
 border-right-color: white; 
 border-bottom-color: transparent; 
}


#mobiledropdown ul li:last-child > a
{
 -moz-border-radius: 0 0 5px 5px;
 border-radius: 0 0 5px 5px;
}

/* Clear floated elements */
#mobiledropdown:after 
{
visibility: hidden;

font-size: 0;
content: " ";
clear: both;
height: 0;
}

* html #mobiledropdown { zoom: 1; } /* IE6 */
*:first-child+html #mobiledropdown { zoom: 1; } /* IE7 */

/* mobiledropdown2 */
#mobiledropdown2
{width = 640;
 position:relative;
color: <%=mobiledropdownColor%>;
text-size: <%=mobiledropdownSize%>;
font-family: <%=mobiledropdownFont%>;
align: <%=mobiledropdownAlign%>;
font-weight: <%=mobiledropdownWeight%>;
margin:0 auto;  
margin-top:0px; 
padding:0px;
list-style: none;  
}

#mobiledropdown2 li
{ width = 640;
float: left;
padding: 0 0 0px 0;
position: relative;
line-height: 2;
}

#mobiledropdown2 a 
{display:inline-block;
align: left;
valign: bottom;
float: left;
height: 10px;
width = 640;
padding: 12px 12px;
color: <%=mobiledropdownFontMouseOverColor %>;
font-size: <%=mobiledropdownSize%>px ;
font-family : <%=mobiledropdownFont%>;
text-decoration: none;
}

#mobiledropdown2 li:hover > a
{
color: <%=mobiledropdowncolor%>;
}

*html #mobiledropdown2 li a:hover /* IE6 */
{
color: <%=mobiledropdownFontMouseOverColor %>;
}

#mobiledropdown2 li:hover > ul
{
display: block;
}

/* Sub-mobiledropdown2 */

#mobiledropdown2 ul
{width = 640;
 list-style: none;
margin: 0;
padding: 0; 
display: none;
position: absolute;
top: 23px;
left: 0;
float: left;
z-index: 99999; 
text-align: left;
background-color: <%=mobiledropdownBackgroundColor%> ;
background: <%=mobiledropdownBackgroundColor%>;
}

#mobiledropdown2 ul ul
{ top: 0;
  left: 0px;}

#mobiledropdown2 ul li
{ float: left;
margin: 0;
padding: 0;
display: block;  
-moz-box-shadow: none;
-webkit-box-shadow: none;
box-shadow: none; 
}

#mobiledropdown2 ul li:last-child
{ -moz-box-shadow: none;
-webkit-box-shadow: none;
box-shadow: none; 
}

#mobiledropdown2 ul a
{ 
 padding: 8px;
height: 10px;
width: 200px;
height: auto;
 line-height: 1;
 display: block;
float: left;
text-transform: none;
}

*html #mobiledropdown2 ul a /* IE6 */
{ 
height: 10px;
}

*:first-child+html #mobiledropdown2 ul a /* IE7 */
{ 
height: 10px;
}

#mobiledropdown2 ul a:hover
{
 background: <%=mobiledropdownDropdownColorMouseoverr%>;}

#mobiledropdown2 ul li:first-child > a
{
 -moz-border-radius: 5px 5px 0 0;
 border-radius: 5px 5px 0 0;
}

#mobiledropdown2 ul li:first-child > a:after
{
 content: '';
 position: absolute;
 left: 30px;
 top: -8px;
 width: 0;
 height: 0;
 border-left: 5px solid transparent;
 border-right: 5px solid transparent;
 border-bottom: 8px solid #444;
}

#mobiledropdown2 ul ul li:first-child a:after
{
 left: -8px;
 top: 12px;
 width: 0;
 height: 0;
 border-left: 0;
 border-bottom: 5px solid transparent;
 border-top: 5px solid transparent;
 border-right: 8px solid #444;
}

#mobiledropdown2 ul li:first-child a:hover:after
{
 border-bottom-color: <%=mobiledropdownDropdownColor%>; 
}

#mobiledropdown2 ul ul li:first-child a:hover:after
{
 border-right-color: <%=mobiledropdownDropdownColor%>; 
 border-bottom-color: transparent; 
}


#mobiledropdown2 ul li:last-child > a
{
 -moz-border-radius: 0 0 5px 5px;
 border-radius: 0 0 5px 5px;
}

/* Clear floated elements */
#mobiledropdown2:after 
{
visibility: hidden;

font-size: 0;
content: " ";
clear: both;
height: 0;
}

* html #mobiledropdown2 { zoom: 1; } /* IE6 */
*:first-child+html #mobiledropdown2 { zoom: 1; } /* IE7 */
</style>
<% end if %>

<style> 
.builtby {
font-family: arial,sans-serif;
 color: Black;
 font-size: 10px;
 font-weight: 600;
 line-height: 13px }
 
A.builtby{
font-family: arial,sans-serif;
 color: Black;
 font-size: 10px;
 font-weight: 600;
 line-height: 13px }
 
A.builtby:hover{
 text-decoration: none; 
 color: grey;
}


select {
content: <%=mobiledropdownBackgroundColor%>;
 width:150px;
 border:1px solid <%=mobiledropdownBackgroundColor%>;
 -webkit-border-top-right-radius: 15px;
 -webkit-border-bottom-right-radius: 15px;
 -moz-border-radius-topright: 15px;
 -moz-border-radius-bottomright: 15px;
 border-top-right-radius: 15px;
 border-bottom-right-radius: 15px;
 padding:2px;
}

label.custom-select {
position: relative;

  }

.custom-select select {
display: none;padding: 4px 3px 3px 5px;
margin: 0;
font: inherit;
outline:none; /* remove focus ring from Webkit */
line-height: 1.2;
background: white;
color: #bababa;
border:0;
 }


/* Select arrow styling */
.custom-select:after 
{
content: <%=mobiledropdownBackgroundColor%>;
position: absolute;
top: 0;
right: 0;
bottom: 0;
font-size: 60%;
line-height: 30px;
padding: 0 7px;
background: #000;
color: white;
}

* html #Footer { zoom: 1; } /* IE6 */
* html #mobiledropdown { zoom: 1; } /* IE6 */
*:first-child+html #mobiledropdown { zoom: 1; } /* IE7 */
</style>

<div class="container w-100" > 

<div class="row">
  <div class="col-sm-5">
    <a href="https://www.LivestockOfTheWorld.com?Screenwidth=<%=Screenwidth %>" target = "_blank" class="topwebheader"><img src="https://www.livestockoftheworld.com/images/AboutUsIcon.png" height = 30 alt="Animals for Sale" valign = bottom />Livestock Of The World 
 </div>
 <div class="col-sm-7">
    <img src="https://www.livestockoftheworld.com/images/px.gif" height = 30 alt="Animals for Sale" valign = bottom />
    <a href="/Default.asp?Screenwidth=<%=Screenwidth %>" class="topwebheader">Home | </a>

    <a href="/Contactus.asp?Screenwidth=<%=Screenwidth %>" class="topwebheader">Contact Us | </a>

    <% if len(Session("PeopleID")) > 1 then %>
        <a href="Https://www.LivestockOfTheWorld.com/logout.asp?Screenwidth=<%=Screenwidth %>" class="topwebheader" >Sign Out</a>
    <% else %>
        <a href="Https://www.LivestockOfTheWorld.com/members/?Screenwidth=<%=Screenwidth %>" class="topwebheader" >Sign In</a>
    <% end if %>
 </div>
</div>


<div class="row whitepagewidth" >
   <div class="d-none d-md-block col-sm-4 slogan">
    <a href="/Default.asp?Screenwidth=<%=Screenwidth %>" class="webheader"><img src="/images/LOTWLogoMenu.png" align="center" width="210" alt="Livestock Of The World"></a><br />
Transforming How Livestock Is Bought and Sold!
 </div>
   <div class="d-none d-xl-block col-sm-2 ">
 </div>

 <div style = "width: 130px;" class="livestocktab"><img src = "/images/px.gif" width = 100% height = 50 border = 0/>
    <a href="/Breedsoflivestock/?Screenwidth=<%=Screenwidth %>" class="webheader" ><center>Breeds Of<br />Livestock</center></a>
 </div>
 <div style = "width: 130px;" valign="bottom" class="producttab"><img src = "/images/px.gif" width = 100% height = 50 border = 0/>
    <a href="/Communities/?Screenwidth=<%=Screenwidth %>" class="webheader" ><center>Livestock<br />Marketplaces</center></a>
 </div>
 <div style = "width: 130px;" valign="bottom" class="ranchtab"><img src = "/images/px.gif" width = 100% height = 50 border = 0/>
    <a href="/AssociationDirectory/?Screenwidth=<%=Screenwidth %>" class="webheader" ><center>Associations<br />& Clubs</center></a>
 </div>
 <div style = "width: 130px;" valign="bottom" class="admintab"><img src = "/images/px.gif" width = 100% height = 20 border = 0/>
     <a href="/communities/?Screenwidth=<%=Screenwidth %>" class="webheader3"><center>About LOTW</a>
    <img src = "/images/px.gif" width = 100 height=7 border = 0 align = "center" />
    <img src = "/images/greyline.gif" width = 100 height=1 border = 0 align = "center" />
    <img src = "/images/px.gif" width = 100 height=7 border = 0 align = "center" />
    <a href="/members/?Screenwidth=<%=Screenwidth %>" class="webheader3"><center>My Account</center></a>
    <img src = "/images/px.gif" width = 100 height=7 border = 0 align = "center" />
    <img src = "/images/greyline.gif" width = 100 height=1 border = 0 align = "center" />
    <img src = "/images/px.gif" width = 100 height=7 border = 0 align = "center" />
    <a href="/join/default.asp?Screenwidth=<%=Screenwidth %>#Top" class="webheader3">Join</a><center>
    <img src = "/images/px.gif" width = 100 height=7 border = 0 align = "center" />
 </div>
</div>



<div class="row whitepagewidth" >
   <div class="col-sm-1" style="background-color: #B35042; height:32px; width = 80px">
        <a href = "/members/Default.asp?PeopleID=<%=PeopleID%>&screenwidth=<%=screenwidth %>" class = "menu2"><center>Dashboard Home</center></a>
  </div>
  <div class="col-sm-1" style="background-color: #76A076; height:32px; width = 80px">
        <a href = "/members/MembersAnimalsHome.asp?PeopleID=<%=PeopleID%>&screenwidth=<%=screenwidth %>" class = "menu2"><center>Animals<%=membershiplevel %></center></a>
 </div>
 <div class="col-sm-1" style="background-color: #F3F3F5; height:32px; width = 80px">
        <a href = "/members/MembersProductsHome.asp?PeopleID=<%=PeopleID%>&screenwidth=<%=screenwidth %>" class = "menu2"><center>Products</center></a>
 </div>
 <div class="col-sm-1" style="background-color: #9D85BE; height:32px; width = 80px">
        <a href = "/members/MembersservicesHome.asp?PeopleID=<%=PeopleID%>&screenwidth=<%=screenwidth %>" class = "menu2"><center>Services</center></a>
 </div>
  <div class="col-sm-1" style="background-color: #F2C777; height:32px; width = 80px">
        <a href = "/members/MembersAccountContactsEdit.asp?PeopleID=<%=PeopleID%>&screenwidth=<%=screenwidth %>" class = "menu2"><center>Account Info</center></a>
 </div>
 <div class="col-sm-1" style="background-color: #9AA1B7; height:32px; width = 80px">
        <a href = "/Members/MembersRanchhomeAdmin.asp?Peopleid=<%=PeopleID %>&screenwidth=<%=screenwidth %>" class = "menu2"><center>Ranch Profile</center></a>
 </div>

<% sql2 = "select * from CustSite where PeopleId= " & session("PeopleID") 
CWcounter = 0
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3 
while not rs2.EOF
    CWcounter = CWcounter + 1
rs2.movenext
wend
rs2.close

if CWCounter > 0 then
If CWcounter > 1 then
  WebsiteReference = "Websites"
else
  WebsiteReference=  "website"
end if
 %>
 <div class="col-sm-1"  style="background-color: #866c59; height:32px; width = 80px">
       <a href = "/Members/MemberscustsitehomeAdmin.asp?Peopleid=<%=PeopleID %>&screenwidth=<%=screenwidth %>" class = "menu2"><center>Custom <%=WebsiteReference %></center></a>
 </div>
<% end if %>

 <div class="col-sm-2 d-none d-md-block" style="background-color: #EFAE15; height:32px; width = 80px">
 </div>
 <div class="col-sm-3 d-none d-sm-block background" style="background-color: #EFAE15; height:32px; width = 80px">
 </div>
</div>






<table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">

<tr ><td align=center >
<div class="background" width =130 height=199 align = center>

<table cellpadding = "0" cellspacing = "0" border = "0" width="<%=screenwidth  %>" align = "center" >


<% Current = "Members" %>



<tr><td align = left>
<% if mobiledevice = True then %>
<table cellpadding = "1" cellspacing = "0" border = "0" width="100%" height = "34" align = left>
<% else %>
<table cellpadding = "1" cellspacing = "0" border = "0" width="<%=screenwidth -40%>" height = "34" align = center>
<% end if %>
   <tr>
   <td align = "center" bgcolor="#B35042" width = 120><a href = "/members/Default.asp?PeopleID=<%=PeopleID%>&screenwidth=<%=screenwidth %>" class = "menu2"><center>Dashboard Home</center></a></td>

<% if not subscriptionlevel = 5 then %>
    <td align = "center" bgcolor="#76A076" width = 120><a href = "/members/MembersAnimalsHome.asp?PeopleID=<%=PeopleID%>&screenwidth=<%=screenwidth %>" class = "menu2"><center>Animals<%=membershiplevel %></center></a></td>
<% end if %>
    <td align = "center" bgcolor = "#F3F3F5"  width = 120><a href = "/members/MembersProductsHome.asp?PeopleID=<%=PeopleID%>&screenwidth=<%=screenwidth %>" class = "menu2"><center>Products</center></a></td>

    <td align = "center" bgcolor = "#9D85BE"  width = 120><a href = "/members/MembersservicesHome.asp?PeopleID=<%=PeopleID%>&screenwidth=<%=screenwidth %>" class = "menu2"><center>Services</center></a>
    </td>


 <td align = "center" bgcolor = "#F2C777" width = 120><a href = "/members/MembersAccountContactsEdit.asp?PeopleID=<%=PeopleID%>&screenwidth=<%=screenwidth %>" class = "menu2"><center>Account Info</center></a></td>
   <td align = "center" bgcolor = "#9AA1B7"  width = 120><a href = "/Members/MembersRanchhomeAdmin.asp?Peopleid=<%=PeopleID %>&screenwidth=<%=screenwidth %>" class = "menu2"><center>Ranch Profile</center></a></td> 

<% sql2 = "select * from CustSite where PeopleId= " & session("PeopleID") 
CWcounter = 0
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3 
while not rs2.EOF
    CWcounter = CWcounter + 1
rs2.movenext
wend
rs2.close

if CWCounter > 0 then
If CWcounter > 1 then
  WebsiteReference = "Websites"
else
  WebsiteReference=  "website"
end if
 %>
   <td align = "center" bgcolor = "#866c59"  width = 120><a href = "/Members/MemberscustsitehomeAdmin.asp?Peopleid=<%=PeopleID %>&screenwidth=<%=screenwidth %>" class = "menu2"><center>Custom <%=WebsiteReference %></center></a></td> 
<% end if %>
<td ><img src = "/images/px.gif" width = "1" height = "1"></td>
	</tr>
</table>


<% 
'***********************************************************
'Sub Menus 
'***********************************************************
%>


<% if Current1 = "CustSites" then %>
<table cellpadding = "0" cellspacing = "0" border = "0" width="<%=screenwidth %>" align = "center" height = "34" bgcolor="#866c59">
<tr>


<%
if CWcounter > 1 then
 if Current2 = "CustomHome" then %>
<td bgcolor = "#593C1F" width = 160 align = center>
&nbsp;<a href = "/members/MemberscustsitehomeAdmin.asp?PeopleID=<%=PeopleID%>" class = 'menu2'>Custom Sites Home</a><img src = "/images/px.gif" width = "5" height = "1">  
</td>
<% else %>
<td bgcolor="#866c59" width = 160 align = center>
&nbsp;<a href = "/members/MemberscustsitehomeAdmin.asp" class = 'menu2'>Home</a><img src = "/images/px.gif" width = "5" height = "1"> 
</td> 
<% end if 
end if %>


<%
sql2 = "select * from CustSite where PeopleId= " & PeopleID 
'response.write(sql2)
CWcounter = 0
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3 
while not rs2.EOF
    CWcounter = CWcounter + 1
    SiteName = rs2("SiteName")
    CustSiteID = rs2("CustSiteID")


If cint(CurrentWebsiteID) = cint(CustSiteID) then
 %>
<td bgcolor = "#593C1F" width = 160 align = center>
&nbsp;<a href = "/members/CustSiteAdmin/Default.asp?WebsiteID=<%=CustSiteID %>&PeopleID=<%=PeopleID%>" class = 'menu2'><%=SiteName %></a><img src = "/images/px.gif" width = "5" height = "1">  
</td>
<% else %>
<td bgcolor = "#866c59" width = 160 align = center>
&nbsp;<a href = "/members/CustSiteAdmin/Default.asp?WebsiteID=<%=CustSiteID %>&PeopleID=<%=PeopleID%>" class = 'menu2'><%=SiteName %></a><img src = "/images/px.gif" width = "5" height = "1">  
</td>
<% end if %>
<% rs2.movenext
wend
rs2.close

end if%>
<td> </td>
</tr></table>




<% if Current1 = "MembersHome" then %>
<table cellpadding = "0" cellspacing = "0" border = "0" width="<%=screenwidth %>" align = "center" height = "34" bgcolor="#B35042">
<tr>

<% if Current2 = "MembersHome" then %>
<td bgcolor = "#840000" width = 160 align = center>
&nbsp;<a href = "/members/Default.asp?PeopleID=<%=PeopleID%>&screenwidth=<%=screenwidth %>" class = 'menu2'>Home</a><img src = "/images/px.gif" width = "5" height = "1">  
</td>
<% else %>
<td bgcolor="#B35042" width = 160 align = center>
&nbsp;<a href = "/members/Default.asp?PeopleID=<%=PeopleID%>&screenwidth=<%=screenwidth %>" class = 'menu2'>Home</a><img src = "/images/px.gif" width = "5" height = "1"> 
</td> 
<% end if %>


<% if Current2 = "Advertising" then %>
<td bgcolor = "#840000" width = 160 align = center>
&nbsp;<a href = "/members/Membersadvertising.asp?PeopleID=<%=PeopleID%>&screenwidth=<%=screenwidth %>" class = 'menu2'>Advertising</a><img src = "/images/px.gif" width = "5" height = "1">  
</td>
<% else %>
<td bgcolor="#B35042" width = 160 align = center>
&nbsp;<a href = "/members/Membersadvertising.asp?PeopleID=<%=PeopleID%>&screenwidth=<%=screenwidth %>" class = 'menu2'>Advertising</a><img src = "/images/px.gif" width = "5" height = "1"> 
</td> 
<% end if %>


<td bgcolor="#B35042" width = 160 align = center>
<a href = "/members/MembersRenewSubscription.asp?PeopleID=<%=PeopleID%>&screenwidth=<%=screenwidth %>" class = "menu2">Renew My Account</a></td>
<td> </td>
</tr></table>

<% end if %>



<% if Current1="Animals" then %>
<table cellpadding = "0" cellspacing = "0" border = "0" width="<%=screenwidth %>" align = "center" height = "34" bgcolor="#76A076">
<tr>

<% if Current2 = "ListOfAnimals" then %>
<td bgcolor = "#358535" width = 160 align = center>
<b><a href = "/Members/MembersAnimalsHome.asp?screenwidth=<%=screenwidth %>" class = "menu2">List of Animals</a></b></td>
<% else %>
<td bgcolor = "#76A076" width = 160 align = center><b><a href = "/Members/MembersAnimalsHome.asp?screenwidth=<%=screenwidth %>" class = "menu2">List of Animals</a></b></td>
<% end if %>


<% if Current2 = "AddAnimals" then %>
<td bgcolor = "#358535" width = 160 align = center>
<b><a href = "/Members/MembersAnimalAdd1.asp?screenwidth=<%=screenwidth %>" class = "menu2">Add Animal</a></b>
</td>
<% else %>
<td bgcolor = "#76A076" width = 160 align = center>
<b><a href = "/Members/MembersAnimalAdd1.asp?screenwidth=<%=screenwidth %>" class = "menu2">Add Animal</a></b>
</td>
<% end if %>



<% if Current2 = "EditAnimals" then %>
<td bgcolor = "#358535" width = 160 align = center>
<b><a href = "/Members/MemberseditAnimal.asp?ID=<%=ID %>&screenwidth=<%=screenwidth %>" class = "menu2">Edit</a></b>
</td>
<% else %>
<td bgcolor = "#76A076" width = 160 align = center>
<b><a href = "/Members/MemberseditAnimal.asp?ID=<%=ID %>&screenwidth=<%=screenwidth %>" class = "menu2">Edit</a></b>
</td>
<% end if %>


<% if Current2 = "AnimalPhotos" then %>
<td bgcolor = "#358535" width = 160 align = center>
 <b><a href = "/Members/MembersPhotos.asp?ID=<%=ID %>&screenwidth=<%=screenwidth %>" class = "menu2">Photos & Videos</a></b>
</td>
<% else %>
<td bgcolor = "#76A076" width = 160 align = center>
 <b><a href = "/Members/MembersPhotos.asp?ID=<%=ID %>&screenwidth=<%=screenwidth %>" class = "menu2">Photos & Videos</a></b>
</td>
<% end if %>

<% showpreview= false
if showpreview = true then %>
<% if Current2 = "AnimalPreview" then %>
<td bgcolor = "#358535" width = 160 align = center>
 <b><a href = "/Members/MembersPreview.asp?ID=<%=ID %>&screenwidth=<%=screenwidth %>" class = "menu2">Preview</a></b>
</td>
<% else %>
<td bgcolor = "#76A076" width = 160 align = center>
 <b><a href = "/Members/MembersPreview.asp?ID=<%=ID %>&screenwidth=<%=screenwidth %>" class = "menu2">Preview</a></b>
</td>
<% end if %>
<% end if %>

<% if Current2 = "AnimalDelete" then %>
<td bgcolor = "#358535" width = 160 align = center>
<b><a href = "/Members/MembersdeleteAnimal.asp?screenwidth=<%=screenwidth %>" class = "menu2">Delete Animals</a></b>
</td>
<% else %>
<td bgcolor = "#76A076" width = 160 align = center>
<b><a href = "/Members/MembersdeleteAnimal.asp?screenwidth=<%=screenwidth %>" class = "menu2">Delete Animals</a></b>
</td>
<% end if %>


<% if Current2 = "AnimalStatistics" then %>
<td bgcolor = "#358535" width = 160 align = center>
<b><a href = "/Members/MembersAnimalsStats.asp?screenwidth=<%=screenwidth %>" class = "menu2">Statistics</a></b>
</td>
<% else %>
<td bgcolor = "#76A076" width = 160 align = center>
<b><a href = "/Members/MembersAnimalsStats.asp?screenwidth=<%=screenwidth %>" class = "menu2">Statistics</a></b>
</td>
<% end if %>


<td >&nbsp;</td>
</tr></table>
<% end if %>


<% if Current1="Products" then %>
<table cellpadding = "0" cellspacing = "0" border = "0" width="<%=screenwidth %>" align = "center" height = "34" bgcolor = "#F3F3F5">

<% if Current2 = "ListOfProducts" then %>
<td bgcolor = "#DDDDE5" width = 160 align = center>
<b><a href = "/Members/MembersProductshome.asp?screenwidth=<%=screenwidth %>" class = "menu2">List of Products</a></b></td>
<% else %>
<td bgcolor = "#F3F3F5" width = 160 align = center><b><a href = "/Members/MembersProductshome.asp?screenwidth=<%=screenwidth %>" class = "menu2">List of Products</a></b></td>
<% end if %>


<% if Current2 = "AddaProduct" then %>
<td bgcolor = "#DDDDE5" width = 160 align = center>
<b><a href = "/Members/MembersClassifiedAdPlace0.asp?screenwidth=<%=screenwidth %>" class = "menu2">Add a Product</a></b></td>
<% else %>
<td bgcolor = "#F3F3F5" width = 160 align = center><b><a href = "/Members/MembersClassifiedAdPlace0.asp?screenwidth=<%=screenwidth %>" class = "menu2">Add a Product</a></b></td>
<% end if %>

<% if Current2 = "EditProduct" then %>
<td bgcolor = "#DDDDE5" width = 160 align = center>
<b><a href = "/Members/MembersEditAd.asp?ID=<%=ID %>&screenwidth=<%=screenwidth %>" class = "menu2">Edit Product</a></b></td>
<% else %>
<td bgcolor = "#F3F3F5" width = 160 align = center><b><a href = "/Members/MembersEditAd.asp?ID=<%=ID %>&screenwidth=<%=screenwidth %>" class = "menu2">Edit Product</a></b></td>
<% end if %>


<% if Current2 = "ProductPhotos" then %>
<td bgcolor = "#DDDDE5" width = 160 align = center>
<b><a href = "/Members/MembersProductPhotos.asp?ID=<%=ID %>&screenwidth=<%=screenwidth %>" class = "menu2">Photos</a></b></td>
<% else %>
<td bgcolor = "#F3F3F5" width = 160 align = center><b><a href = "/Members/MembersProductPhotos.asp?ID=<%=ID %>&screenwidth=<%=screenwidth %>" class = "menu2">Photos</a></b></td>
<% end if %>


<% if Current2 = "DeleteProduct" then %>
<td bgcolor = "#DDDDE5" width = 160 align = center>
<b><a href = "/Members/Membersdeletelisting.asp?ID=<%=ID %>&screenwidth=<%=screenwidth %>" class = "menu2">Delete Product</a></b></td>
<% else %>
<td bgcolor = "#F3F3F5" width = 160 align = center><b><a href = "/Members/Membersdeletelisting.asp?ID=<%=ID %>&screenwidth=<%=screenwidth %>" class = "menu2">Delete Product</a></b></td>
<% end if %>



<% if Current2 = "SuggestCategory" then %>
<td bgcolor = "#DDDDE5" width = 160 align = center>
<b><a href = "/Members/MembersServicesSuggestCategory.asp?screenwidth=<%=screenwidth %>" class = "menu2">Suggest Category</a></b></td>
<% else %>
<td bgcolor = "#F3F3F5" width = 160 align = center><b><a href = "/Members/MembersServicesSuggestCategory.asp?screenwidth=<%=screenwidth %>" class = "menu2">Suggest Category</a></b></td>
<% end if %>


<% if Current2 = "ProductStatistics" then %>
<td bgcolor = "#DDDDE5" width = 160 align = center>
<b><a href = "/Members/MembersProductStats.asp?screenwidth=<%=screenwidth %>" class = "menu2">Statistics</a></b></td>
<% else %>
<td bgcolor = "#F3F3F5" width = 160 align = center><b><a href = "/Members/MembersProductStats.asp?screenwidth=<%=screenwidth %>" class = "menu2">Statistics</a></b></td>
<% end if %>


<% 
showstoresttings = false
if showstoresttings = True then
if Current2 = "StoreSettings" then %>
<td bgcolor = "#DDDDE5" width = 160 align = center>
<b><a href = "/Members/MembersStoreMaintenance.asp?screenwidth=<%=screenwidth %>" class = "menu2">Store Settings</a></b></td>
<% else %>
<td bgcolor = "#F3F3F5" width = 160 align = center><b><a href = "/Members/MembersStoreMaintenance.asp?screenwidth=<%=screenwidth %>" class = "menu2">Store Settings</a></b></td>
<% end if %>
<% end if %>

 <td >&nbsp;</td>
</tr></table>
<% end if %>



<% if Current1="Services" then %>
<table cellpadding = "0" cellspacing = "0" border = "0" width="<%=screenwidth %>" align = "center" height = "34" bgcolor = "#F3F3F5">

<% if Current2 = "ListOfServices" then %>
<td bgcolor = "#9D85BE" width = 160 align = center>
<b><a href = "/Members/MembersServicesHome.asp?screenwidth=<%=screenwidth %>" class = "menu2">List of Services</a></b></td>
<% else %>
<td bgcolor = "#BCAED5" width = 160 align = center><b><a href = "/Members/MembersServicesHome.asp?screenwidth=<%=screenwidth %>" class = "menu2">List of Services</a></b></td>
<% end if %>


<% if Current2 = "AddaServices" then %>
<td bgcolor = "#9D85BE" width = 160 align = center>
<b><a href = "/Members/membersServicesAddPage0.asp?screenwidth=<%=screenwidth %>" class = "menu2">Add a Service</a></b></td>
<% else %>
<td bgcolor = "#BCAED5" width = 160 align = center><b><a href = "/Members/membersServicesAddPage0.asp?screenwidth=<%=screenwidth %>" class = "menu2">Add a Service</a></b></td>
<% end if %>

<% if Current2 = "EditServices" then %>
<td bgcolor = "#9D85BE" width = 160 align = center>
<b><a href = "/Members/membersServicesEdit.asp?ID=<%=ID %>&screenwidth=<%=screenwidth %>" class = "menu2">Edit Service</a></b></td>
<% else %>
<td bgcolor = "#BCAED5" width = 160 align = center><b><a href = "/Members/membersServicesEdit.asp?ID=<%=ID %>&screenwidth=<%=screenwidth %>" class = "menu2">Edit Service</a></b></td>
<% end if %>



<% if Current2 = "DeleteService" then %>
<td bgcolor = "#9D85BE" width = 160 align = center>
<b><a href = "/Members/membersServiceDelete.asp?ID=<%=ID %>&screenwidth=<%=screenwidth %>" class = "menu2">Delete Service</a></b></td>
<% else %>
<td bgcolor = "#BCAED5" width = 160 align = center><b><a href = "/Members/membersServiceDelete.asp?ID=<%=ID %>&screenwidth=<%=screenwidth %>" class = "menu2">Delete Service</a></b></td>
<% end if %>



<% if Current2 = "SuggestCategory" then %>
<td bgcolor = "#9D85BE" width = 160 align = center>
<b><a href = "/Members/MembersPlaceClassifiedAd0.asp?screenwidth=<%=screenwidth %>" class = "menu2">Suggest Category</a></b></td>
<% else %>
<td bgcolor = "#BCAED5" width = 160 align = center><b><a href = "/Members/MembersPlaceClassifiedAd0.asp?screenwidth=<%=screenwidth %>" class = "menu2">Suggest Category</a></b></td>
<% end if %>


<% if Current2 = "ServiceStatistics" then %>
<td bgcolor = "#9D85BE" width = 160 align = center>
<b><a href = "/Members/MembersServicesStats.asp?screenwidth=<%=screenwidth %>" class = "menu2">Statistics</a></b></td>
<% else %>
<td bgcolor = "#BCAED5" width = 160 align = center><b><a href = "/Members/MembersServicesStats.asp?screenwidth=<%=screenwidth %>" class = "menu2">Statistics</a></b></td>
<% end if %>



 <td bgcolor = "#BCAED5">&nbsp;</td>
</tr></table>
<% end if %>






<% if Current1="RanchPages" then %>
<table cellpadding = "0" cellspacing = "0" border = "0" width="<%=screenwidth %>" align = "center" height = "34" bgcolor="#9AA1B7">

<% if Current2 = "RanchHomePage" then %>
<td bgcolor = "#737FA0" width = 160 align = center>
<b><a href = "/Members/MembersRanchhomeAdmin.asp?Peopleid=<%=PeopleID %>&screenwidth=<%=screenwidth %>" class = "menu2">Home Page</a></b></td>
<% else %>
<td bgcolor = "#9AA1B7" width = 160 align = center><b><a href = "/Members/MembersRanchhomeAdmin.asp?Peopleid=<%=PeopleID %>&screenwidth=<%=screenwidth %>" class = "menu2">Home Page</a></b></td>
<% end if %>

<% if Current2 = "RanchAboutus" then %>
<td bgcolor = "#737FA0" width = 160 align = center>
<b><a href = "/Members/MembersPageData2.asp?Peopleid=<%=PeopleID %>&screenwidth=<%=screenwidth %>" class = "menu2">About Us Page</a></b></td>
<% else %>
<td bgcolor = "#9AA1B7" width = 160 align = center><b><a href = "/Members/MembersPageData2.asp?Peopleid=<%=PeopleID %>&pagename=About Us&screenwidth=<%=screenwidth %>" class = "menu2">About Us Page</a></b></td>
<% end if %>

<% if Current2 = "RanchSetUp" then %>
<td bgcolor = "#737FA0" width = 200 align = center>
<b><a href = "/Members/MemberssiteDesign.asp?Peopleid=<%=PeopleID %>&screenwidth=<%=screenwidth %>" class = "menu2">Ranch Site Graphic Design</a></b></td>
<% else %>
<td bgcolor = "#9AA1B7" width = 200 align = center><b><a href = "/Members/MemberssiteDesign.asp?Peopleid=<%=PeopleID %>&screenwidth=<%=screenwidth %>" class = "menu2">Ranch Site Graphic Design</a></b></td>
<% end if %>

   
 <td >&nbsp;</td>
</tr></table>
<% end if %>



<% if Current1="Account" then %>
<table cellpadding = "0" cellspacing = "0" border = "0" width="<%=screenwidth %>" align = "center" height = "34" bgcolor="#F2C777">
<tr>

<% if Current2 = "AccountInfo" then %>
<td bgcolor = "#F2BE42" width = 160 align = center>
<b><a href = "/Members/MembersAccountContactsEdit.asp?Peopleid=<%=PeopleID %>&screenwidth=<%=screenwidth %>" class = "menu2">My Account Info</a></b></td>
<% else %>
<td bgcolor = "#F2C777" width = 160 align = center><b><a href = "/Members/MembersAccountContactsEdit.asp?Peopleid=<%=PeopleID %>&screenwidth=<%=screenwidth %>" class = "menu2">My Account Info</a></b></td>
<% end if %>

<% if Current2 = "ResetPassword" then %>
<td bgcolor = "#F2BE42" width = 160 align = center>
<b><a href = "/Members/MembersPasswordChange.asp?Peopleid=<%=PeopleID %>&screenwidth=<%=screenwidth %>" class = "menu2">Reset Password</a></b></td>
<% else %>
<td bgcolor = "#F2C777" width = 160 align = center><b><a href = "/Members/MembersPasswordChange.asp?Peopleid=<%=PeopleID %>&screenwidth=<%=screenwidth %>" class = "menu2">Reset Password</a></b></td>
<% end if %>



<% if Current2 = "Associations" then %>
<td bgcolor = "#F2BE42" width = 160 align = center>
<b><a href = "/Members/MembersAssociations.asp?Peopleid=<%=PeopleID %>&screenwidth=<%=screenwidth %>" class = "menu2">Associations</a></b></td>
<% else %>
<td bgcolor = "#F2C777" width = 160 align = center><b><a href = "/Members/MembersAssociations.asp?Peopleid=<%=PeopleID %>&screenwidth=<%=screenwidth %>" class = "menu2">Associations</a></b></td>
<% end if %>

<% if Current2 = "UpgradeorRenewYourMembership" then %>
<td bgcolor = "#F2BE42" width = 260 align = center>
<b><a href = "/Members/MembersRenewSubscription.asp?Peopleid=<%=PeopleID %>&screenwidth=<%=screenwidth %>" class = "menu2">Upgrade or Renew Your Membership</a></b></td>
<% else %>
<td bgcolor = "#F2C777" width = 260 align = center><b><a href = "/Members/MembersRenewSubscription.asp?Peopleid=<%=PeopleID %>&screenwidth=<%=screenwidth %>" class = "menu2">Upgrade or Renew Your Membership</a></b></td>
<% end if %>


   
 <td >&nbsp;</td>
</tr></table>
<% end if %>



</td></tr>
</table>
</td></tr>
</table>
</td></tr>
</table>
</td></tr>
</table>
</td></tr>
</table>
</div>
<% if mobiledevice = True then %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" bgcolor = "white" width = "100%">
<% else %>
<% if mobiledevice = True or screenwidth < 1176 then 
screenwidth = screenwidth 
%>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" bgcolor = "white" width = "<%=screenwidth %>">
<% else 
screenwidth = screenwidth %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" bgcolor = "white" width = "<%=screenwidth %>">
<% end if%>
<% end if%>


<% if screenwidth > 800 then %>
<tr><td >

<% end if %>
<% if mobiledevice = True or screenwidth < 1150 then %>
<tr><td class = "body roundedtopandbottom" align = "left" height = "500" valign = top>
<% else %>
<tr><td class = "body roundedtopandbottom" align = "center" height = "500" valign = top>
<% end if %>

