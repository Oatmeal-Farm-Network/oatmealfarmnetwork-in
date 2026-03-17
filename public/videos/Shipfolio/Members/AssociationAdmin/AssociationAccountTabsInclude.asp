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

<%
'********************************************
' If OVER 800 Pixels wide
'********************************************

if screenwidth > 800 then %>

<% CurrentWebsite = "LivestockofTHeWorld" %>
<!--#Include virtual="/WebHeaderTabs2.asp"-->

<table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">

<tr ><td align="center">


<div class="transbox2">
<table width="<%=screenwidth %>" cellpadding="0" cellspacing="0" border="0"  align="center">
<td width="<%=screenwidth-810 %>" ></td>
<td  width=130></td>

<td align="right" colspan = 5>
associationid = <%=Session("AssociationID")%>
<a href="/Default.asp?Screenwidth=<%=Screenwidth %>" class="webheader">Home | </a>
<a href="/BreedsofLivestock/?Screenwidth=<%=Screenwidth %>" class="webheader">Breeds of Livestock | </a>
<a href="/Associations/?Screenwidth=<%=Screenwidth %>" class="webheader">Livestock Associations | </a>
<a href="/Communities/?Screenwidth=<%=Screenwidth %>" class="webheader">About Us | </a>
<a href="/Contactus.asp?Screenwidth=<%=Screenwidth %>" class="webheader">Contact Us | </a>

<% if len(Session("AssociationID")) > 0 then %>
<a href="Http://www.LivestockOfTheWorld.com/associationadmin/associationlogout.asp?Screenwidth=<%=Screenwidth %>" class="webheader" >Sign Out</a><img src = "/images/px.gif" width = 40 height =1 alt = "Livestock Of the World" border = 0/></td>
<% else %>
<a href="Http://www.LivestockOfTheWorld.com/associationadmin/?Screenwidth=<%=Screenwidth %>" class="webheader" >Sign In<img src = "/images/px.gif" width = 40 height =1 alt = "Livestock Of the World" border = 0/></a></td>
<% end if %>
</tr></table>
</div>
</td></tr>
<tr ><td align=center >
<div class="background" width =130 height=199 align = center>


<table width="<%=screenwidth %>" cellpadding="0" cellspacing="0" border="0"  align="center" height = 160 >
<tr>
<% if screenwidth > 650 then %>
<td width="<%=screenwidth-650 %>" align="center" valign="bottom"><a href="/Default.asp?Screenwidth=<%=Screenwidth %>" class="webheader"><img src="/images/LOTWLogoMenu.png" align="center" width="309" alt="Livestock"></a></td>
<% else %>
<td  valign="bottom"><a href="/Default.asp?Screenwidth=<%=Screenwidth %>" class="webheader"><img src="/images/LOTWLogoMenu.png" align="left" width="<%=screenwidth %>" alt="Livestock"></a></td>
<% end if %>
<td width=130 valign="top">
<a href="/Communities/?Screenwidth=<%=Screenwidth %>" class="webheader">
<div class="transbox" width =130 height=100>
<img src="/images/px.gif" width =130 height=1 alt="Livestock For Sale"/>
<p><img src="/images/px.gif" width =1 height=64 alt="Livestock Sales"/>Livestock<br />Communities</p>
</div></a></td>

<td width=130 valign="top">
<a href="/BreedsOfLivestock/?Screenwidth=<%=Screenwidth %>" class="webheader">
<div class="transbox2" width =130 height=100>
<img src="/images/px.gif" width =130 height=1 alt="Animal Product"/>
<p><img src="/images/px.gif" width =1 height=64 alt="Animal Products"/>Breeds Of<br />Livestock</p>
</div></a>
</td>
<td width=130 valign="top">
<a href="/Associations/?Screenwidth=<%=Screenwidth %>" class="webheader">
<div class="transbox3" width =130 height=100>
<img src="/images/px.gif" width =130 height=1 alt="Livestock Ranches"/>
<p><img src="/images/px.gif" width =1 height=64 alt="Livestock Farms"/>Livestock<br />Associations</p>
</div></a>
</td>
<% if len(Session("AssociationID")) > 1 then %>
<td width=130 valign="top">
<div class="transbox4" width =130 height=100>
<a href="Http://www.LivestockOfTheWorld.com/associationadmin/?Screenwidth=<%=Screenwidth %>" class="webheader"><img src="/images/px.gif" width =130 height=1 alt="Livestock Website"/>
<p><img src="/images/px.gif" width =1 height=64 alt="Livestock Website Account"/>My<br />Account</p></a>

</td>
<% else %>
<td width=130 valign="top">

<div class="transbox4" width =130 height=100>
<a href="Http://www.LivestockOfTheWorld.com/login.asp?Screenwidth=<%=Screenwidth %>" class="webheader"><img src="/images/px.gif" width =130 height=1 alt="Livestock Website"/>
<p><img src="/images/px.gif" width =1 height=64 alt="Livestock Website Account"/>My<br />Account</p></a>
</div>

</td>
<% end if %>
<td width=130></td>
</tr>
</table>

<% end if %>

<% 
'********************************************
' If UNDER 800 Pixels wide
'********************************************

if screenwidth < 801 then %>
<table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">
<% if screenwidth > 640 then %>
<tr><td valign="bottom" align="center" colspan=6><a href="/Default.asp?Screenwidth=<%=Screenwidth %>" class="webheader"><img src="/images/LOTWLogoMenu.png" align="center" width="80%" alt="Livestock"></a></td></tr>
<% else %>
<tr><td valign="bottom" colspan=6><center><a href="/Default.asp?Screenwidth=<%=Screenwidth %>" class="webheader"><img src="/images/LOTWLogoMenu.png" align="center" width="80%" alt="Livestock"></a></center></td></tr>
<% end if %>
<tr ><td align="center">

<table width="100%" cellpadding="0" cellspacing="0" border="0"  align="center" bgcolor = "#3D6B33">
<tr>
<td align="left" width=100% height = 30>
<ul id="mobiledropdown">
<li><a href = "#"  ><font color = white>Menu</font></a>
<ul>
<li ><a href = "/Communities/?screenwidth=<%=screenwidth %>" >Livestock Communities</a></li>
<li ><a href = "/BreedsOfLivestock/?screenwidth=<%=screenwidth %>" >Breeds Of Livestock</a></li>
<li ><a href = "/Ranches/?screenwidth=<%=screenwidth %>" >Ranch Directory</a></li>
<li ><a href = "/Associations/?screenwidth=<%=screenwidth %>" >Associations</a></li>
<li ><a href = "/associationadmin/?screenwidth=<%=screenwidth %>" >My Account</a></li>
<li><a href = "/Communities/default.asp?screenwidth=<%=screenwidth %>"  >About Us</a></li>
<li><a href = "/ContactUs.asp?screenwidth=<%=screenwidth %>"  >Contact Us</a></li>
<li><a href = "/Default.asp?screenwidth=<%=screenwidth %>"  >Home</a></li>
</ul>
</li>
</ul>
</td>
</tr>
<tr><td align="left" width=100% height = 30>&nbsp;</td></tr>
</table>
<br />
</td>
</tr></table>
</td></tr>
<tr bgcolor="#EBEBEB"><td  valign="top" align = center>

<% if mobiledevice = True then %>
<table width="100%" cellpadding="0" cellspacing="0" border="0" align="center" >
<tr><td width="100%" valign="top" bgcolor=white align = center>
<% else %>

<% if screenwidth < 1200 then %>
<table width="<%=screenwidth  %>" cellpadding="0" cellspacing="0" border="0"  align="center" >
<tr><td width="<%=screenwidth  %>" valign="top"  align = center>
<% else %>
<table width="<%=screenwidth - 22 %>" cellpadding="0" cellspacing="0" border="0"  align="center" >
<tr><td width="<%=screenwidth - 22 %>" valign="top" align = center>
<% end if %>

<% end if %>

<% end if %>


<% if screenwidth < 1158 then %>
 <table cellpadding = "0" cellspacing = "0" border = "0" width="100%" align = "left" >
<% else
 screenwidth = screenwidth  %>
<table cellpadding = "0" cellspacing = "0" border = "0" width="<%=screenwidth  %>" align = "center" >
<% end if %>

<% Current = "Members" %>



<tr><td align = left>
<% if mobiledevice = True then %>
<table cellpadding = "1" cellspacing = "0" border = "0" width="100%" height = "34" align = left>
<% else %>
<table cellpadding = "1" cellspacing = "0" border = "0" width="<%=screenwidth -40%>" height = "34" align = center>
<% end if %>
   <tr>
   <td align = "center" bgcolor="#B35042" width = 120><a href = "/associationadmin/Default.asp?AssociationID=<%=AssociationID%>&screenwidth=<%=screenwidth %>" class = "menu2"><center>Dashboard Home</center></a></td>
    <td align = "center" bgcolor="#76A076" width = 120><a href = "/associationadmin/MembersAnimalsHome.asp?AssociationID=<%=AssociationID%>&screenwidth=<%=screenwidth %>" class = "menu2"><center>Members</center></a></td>
    <td align = "center" bgcolor = "#F3F3F5"  width = 120><a href = "/associationadmin/MembersProductsHome.asp?AssociationID=<%=AssociationID%>&screenwidth=<%=screenwidth %>" class = "menu2"><center>Events</center></a></td>
 <td align = "center" bgcolor = "#F2C777" width = 120><a href = "/associationadmin/AssociationEditMembers.asp?AssociationID=<%=AssociationID%>&screenwidth=<%=screenwidth %>" class = "menu2"><center>Account Info</center></a></td>
    
<td ><img src = "/images/px.gif" width = "1" height = "1"></td>
	</tr>
</table>


<% 
'***********************************************************
'Sub Menus 
'***********************************************************
%>

<% if Current1 = "AssociationHome" then %>
<table cellpadding = "0" cellspacing = "0" border = "0" width="<%=screenwidth %>" align = "center" height = "34" bgcolor="#B35042">
<tr>

<% if Current2 = "AssociationHome" then %>
<td bgcolor = "#840000" width = 160 align = center>
&nbsp;<a href = "/associationadmin/Default.asp?AssociationID=<%=AssociationID%>&screenwidth=<%=screenwidth %>" class = 'menu2'>Home</a><img src = "/images/px.gif" width = "5" height = "1">  
</td>
<% else %>
<td bgcolor="#B35042" width = 160 align = center>
&nbsp;<a href = "/associationadmin/Default.asp?AssociationID=<%=AssociationID%>&screenwidth=<%=screenwidth %>" class = 'menu2'>Home</a><img src = "/images/px.gif" width = "5" height = "1"> 
</td> 
<% end if %>

<% if Current2 = "DirectoryListing" then %>
<td bgcolor = "#840000" width = 160 align = center>
&nbsp;<a href = "/associationadmin/AssociationListingEdit.asp?AssociationID=<%=AssociationID%>&screenwidth=<%=screenwidth %>" class = 'menu2'>Directory Listing</a><img src = "/images/px.gif" width = "5" height = "1">  
</td>
<% else %>
<td bgcolor="#B35042" width = 160 align = center>
&nbsp;<a href = "/associationadmin/AssociationListingEdit.asp?AssociationID=<%=AssociationID%>&screenwidth=<%=screenwidth %>" class = 'menu2'>Directory Listing</a><img src = "/images/px.gif" width = "5" height = "1"> 
</td> 
<% end if %>

<td >&nbsp;</td>
</tr></table>
<% end if %>



<% if Current1="Animals" then %>
<table cellpadding = "0" cellspacing = "0" border = "0" width="<%=screenwidth %>" align = "center" height = "34" bgcolor="#76A076">
<tr>

<% if Current2 = "ListOfAnimals" then %>
<td bgcolor = "#358535" width = 160 align = center>
<b><a href = "/associationadmin/MembersAnimalsHome.asp?screenwidth=<%=screenwidth %>" class = "menu2">List of Animals</a></b></td>
<% else %>
<td bgcolor = "#76A076" width = 160 align = center><b><a href = "/associationadmin/MembersAnimalsHome.asp?screenwidth=<%=screenwidth %>" class = "menu2">List of Animals</a></b></td>
<% end if %>


<% if Current2 = "AddAnimals" then %>
<td bgcolor = "#358535" width = 160 align = center>
<b><a href = "/associationadmin/MembersAnimalAdd1.asp?screenwidth=<%=screenwidth %>" class = "menu2">Add Animal</a></b>
</td>
<% else %>
<td bgcolor = "#76A076" width = 160 align = center>
<b><a href = "/associationadmin/MembersAnimalAdd1.asp?screenwidth=<%=screenwidth %>" class = "menu2">Add Animal</a></b>
</td>
<% end if %>



<% if Current2 = "EditAnimals" then %>
<td bgcolor = "#358535" width = 160 align = center>
<b><a href = "/associationadmin/MemberseditAnimal.asp?ID=<%=ID %>&screenwidth=<%=screenwidth %>" class = "menu2">Edit</a></b>
</td>
<% else %>
<td bgcolor = "#76A076" width = 160 align = center>
<b><a href = "/associationadmin/MemberseditAnimal.asp?ID=<%=ID %>&screenwidth=<%=screenwidth %>" class = "menu2">Edit</a></b>
</td>
<% end if %>


<% if Current2 = "AnimalPhotos" then %>
<td bgcolor = "#358535" width = 160 align = center>
 <b><a href = "/associationadmin/MembersPhotos.asp?ID=<%=ID %>&screenwidth=<%=screenwidth %>" class = "menu2">Photos & Videos</a></b>
</td>
<% else %>
<td bgcolor = "#76A076" width = 160 align = center>
 <b><a href = "/associationadmin/MembersPhotos.asp?ID=<%=ID %>&screenwidth=<%=screenwidth %>" class = "menu2">Photos & Videos</a></b>
</td>
<% end if %>

<% showpreview= false
if showpreview = true then %>
<% if Current2 = "AnimalPreview" then %>
<td bgcolor = "#358535" width = 160 align = center>
 <b><a href = "/associationadmin/MembersPreview.asp?ID=<%=ID %>&screenwidth=<%=screenwidth %>" class = "menu2">Preview</a></b>
</td>
<% else %>
<td bgcolor = "#76A076" width = 160 align = center>
 <b><a href = "/associationadmin/MembersPreview.asp?ID=<%=ID %>&screenwidth=<%=screenwidth %>" class = "menu2">Preview</a></b>
</td>
<% end if %>
<% end if %>

<% if Current2 = "AnimalDelete" then %>
<td bgcolor = "#358535" width = 160 align = center>
<b><a href = "/associationadmin/MembersdeleteAnimal.asp?screenwidth=<%=screenwidth %>" class = "menu2">Delete Animals</a></b>
</td>
<% else %>
<td bgcolor = "#76A076" width = 160 align = center>
<b><a href = "/associationadmin/MembersdeleteAnimal.asp?screenwidth=<%=screenwidth %>" class = "menu2">Delete Animals</a></b>
</td>
<% end if %>


<% if Current2 = "AnimalStatistics" then %>
<td bgcolor = "#358535" width = 160 align = center>
<b><a href = "/associationadmin/MembersAnimalsStats.asp?screenwidth=<%=screenwidth %>" class = "menu2">Statistics</a></b>
</td>
<% else %>
<td bgcolor = "#76A076" width = 160 align = center>
<b><a href = "/associationadmin/MembersAnimalsStats.asp?screenwidth=<%=screenwidth %>" class = "menu2">Statistics</a></b>
</td>
<% end if %>


<td >&nbsp;</td>
</tr></table>
<% end if %>


<% if Current1="Products" then %>
<table cellpadding = "0" cellspacing = "0" border = "0" width="<%=screenwidth %>" align = "center" height = "34" bgcolor = "#F3F3F5">

<% if Current2 = "ListOfProducts" then %>
<td bgcolor = "#DDDDE5" width = 160 align = center>
<b><a href = "/associationadmin/MembersProductshome.asp?screenwidth=<%=screenwidth %>" class = "menu2">List of Products</a></b></td>
<% else %>
<td bgcolor = "#F3F3F5" width = 160 align = center><b><a href = "/associationadmin/MembersProductshome.asp?screenwidth=<%=screenwidth %>" class = "menu2">List of Products</a></b></td>
<% end if %>


<% if Current2 = "AddaProduct" then %>
<td bgcolor = "#DDDDE5" width = 160 align = center>
<b><a href = "/associationadmin/MembersClassifiedAdPlace.asp?screenwidth=<%=screenwidth %>" class = "menu2">Add a Product</a></b></td>
<% else %>
<td bgcolor = "#F3F3F5" width = 160 align = center><b><a href = "/associationadmin/MembersClassifiedAdPlace.asp?screenwidth=<%=screenwidth %>" class = "menu2">Add a Product</a></b></td>
<% end if %>

<% if Current2 = "EditProduct" then %>
<td bgcolor = "#DDDDE5" width = 160 align = center>
<b><a href = "/associationadmin/MembersEditAd.asp?ID=<%=ID %>&screenwidth=<%=screenwidth %>" class = "menu2">Edit Product</a></b></td>
<% else %>
<td bgcolor = "#F3F3F5" width = 160 align = center><b><a href = "/associationadmin/MembersEditAd.asp?ID=<%=ID %>&screenwidth=<%=screenwidth %>" class = "menu2">Edit Product</a></b></td>
<% end if %>


<% if Current2 = "ProductPhotos" then %>
<td bgcolor = "#DDDDE5" width = 160 align = center>
<b><a href = "/associationadmin/MembersProductPhotos.asp?ID=<%=ID %>&screenwidth=<%=screenwidth %>" class = "menu2">Photos</a></b></td>
<% else %>
<td bgcolor = "#F3F3F5" width = 160 align = center><b><a href = "/associationadmin/MembersProductPhotos.asp?ID=<%=ID %>&screenwidth=<%=screenwidth %>" class = "menu2">Photos</a></b></td>
<% end if %>


<% if Current2 = "DeleteProduct" then %>
<td bgcolor = "#DDDDE5" width = 160 align = center>
<b><a href = "/associationadmin/Membersdeletelisting.asp?ID=<%=ID %>&screenwidth=<%=screenwidth %>" class = "menu2">Delete Product</a></b></td>
<% else %>
<td bgcolor = "#F3F3F5" width = 160 align = center><b><a href = "/associationadmin/Membersdeletelisting.asp?ID=<%=ID %>&screenwidth=<%=screenwidth %>" class = "menu2">Delete Product</a></b></td>
<% end if %>



<% if Current2 = "SuggestCategory" then %>
<td bgcolor = "#DDDDE5" width = 160 align = center>
<b><a href = "/associationadmin/MembersPlaceClassifiedAd0.asp?screenwidth=<%=screenwidth %>" class = "menu2">Suggest Category</a></b></td>
<% else %>
<td bgcolor = "#F3F3F5" width = 160 align = center><b><a href = "/associationadmin/MembersPlaceClassifiedAd0.asp?screenwidth=<%=screenwidth %>" class = "menu2">Suggest Category</a></b></td>
<% end if %>


<% if Current2 = "ProductStatistics" then %>
<td bgcolor = "#DDDDE5" width = 160 align = center>
<b><a href = "/associationadmin/MembersProductStats.asp?screenwidth=<%=screenwidth %>" class = "menu2">Statistics</a></b></td>
<% else %>
<td bgcolor = "#F3F3F5" width = 160 align = center><b><a href = "/associationadmin/MembersProductStats.asp?screenwidth=<%=screenwidth %>" class = "menu2">Statistics</a></b></td>
<% end if %>


<% 
showstoresttings = false
if showstoresttings = True then
if Current2 = "StoreSettings" then %>
<td bgcolor = "#DDDDE5" width = 160 align = center>
<b><a href = "/associationadmin/MembersStoreMaintenance.asp?screenwidth=<%=screenwidth %>" class = "menu2">Store Settings</a></b></td>
<% else %>
<td bgcolor = "#F3F3F5" width = 160 align = center><b><a href = "/associationadmin/MembersStoreMaintenance.asp?screenwidth=<%=screenwidth %>" class = "menu2">Store Settings</a></b></td>
<% end if %>
<% end if %>

 <td >&nbsp;</td>
</tr></table>
<% end if %>

<% if Current1="RanchPages" then %>
<table cellpadding = "0" cellspacing = "0" border = "0" width="<%=screenwidth %>" align = "center" height = "34" bgcolor="#9AA1B7">

<% if Current2 = "RanchHomePage" then %>
<td bgcolor = "#737FA0" width = 160 align = center>
<b><a href = "/associationadmin/MembersRanchhomeAdmin.asp?AssociationID=<%=AssociationID %>&screenwidth=<%=screenwidth %>" class = "menu2">Home Page</a></b></td>
<% else %>
<td bgcolor = "#9AA1B7" width = 160 align = center><b><a href = "/associationadmin/MembersRanchhomeAdmin.asp?AssociationID=<%=AssociationID %>&screenwidth=<%=screenwidth %>" class = "menu2">Home Page</a></b></td>
<% end if %>

<% if Current2 = "RanchAboutus" then %>
<td bgcolor = "#737FA0" width = 160 align = center>
<b><a href = "/associationadmin/MembersPageData2.asp?AssociationID=<%=AssociationID %>&screenwidth=<%=screenwidth %>" class = "menu2">About Us Page</a></b></td>
<% else %>
<td bgcolor = "#9AA1B7" width = 160 align = center><b><a href = "/associationadmin/MembersPageData2.asp?AssociationID=<%=AssociationID %>&pagename=About Us&screenwidth=<%=screenwidth %>" class = "menu2">About Us Page</a></b></td>
<% end if %>

<% if Current2 = "RanchSetUp" then %>
<td bgcolor = "#737FA0" width = 200 align = center>
<b><a href = "/associationadmin/MemberssiteDesign.asp?AssociationID=<%=AssociationID %>&screenwidth=<%=screenwidth %>" class = "menu2">Ranch Site Graphic Design</a></b></td>
<% else %>
<td bgcolor = "#9AA1B7" width = 200 align = center><b><a href = "/associationadmin/MemberssiteDesign.asp?AssociationID=<%=AssociationID %>&screenwidth=<%=screenwidth %>" class = "menu2">Ranch Site Graphic Design</a></b></td>
<% end if %>

   
 <td >&nbsp;</td>
</tr></table>
<% end if %>



<% if Current1="Account" then %>
<table cellpadding = "0" cellspacing = "0" border = "0" width="<%=screenwidth %>" align = "center" height = "34" bgcolor="#F2C777">
<tr>

<% if Current2 = "AccountInfo" then %>
<td bgcolor = "#F2BE42" width = 160 align = center>
<b><a href = "/associationadmin/MembersAccountContactsEdit.asp?AssociationID=<%=AssociationID %>&screenwidth=<%=screenwidth %>" class = "menu2">My Account Info</a></b></td>
<% else %>
<td bgcolor = "#F2C777" width = 160 align = center><b><a href = "/associationadmin/MembersAccountContactsEdit.asp?AssociationID=<%=AssociationID %>&screenwidth=<%=screenwidth %>" class = "menu2">My Account Info</a></b></td>
<% end if %>

<% if Current2 = "ResetPassword" then %>
<td bgcolor = "#F2BE42" width = 160 align = center>
<b><a href = "/associationadmin/MembersPasswordChange.asp?AssociationID=<%=AssociationID %>&screenwidth=<%=screenwidth %>" class = "menu2">Reset Password</a></b></td>
<% else %>
<td bgcolor = "#F2C777" width = 160 align = center><b><a href = "/associationadmin/MembersPasswordChange.asp?AssociationID=<%=AssociationID %>&screenwidth=<%=screenwidth %>" class = "menu2">Reset Password</a></b></td>
<% end if %>

<% if Current2 = "UpgradeorRenewYourMembership" then %>
<td bgcolor = "#F2BE42" width = 260 align = center>
<b><a href = "/associationadmin/MembersRenewSubscription.asp?AssociationID=<%=AssociationID %>&screenwidth=<%=screenwidth %>" class = "menu2">Upgrade or Renew Your Membership</a></b></td>
<% else %>
<td bgcolor = "#F2C777" width = 260 align = center><b><a href = "/associationadmin/MembersRenewSubscription.asp?AssociationID=<%=AssociationID %>&screenwidth=<%=screenwidth %>" class = "menu2">Upgrade or Renew Your Membership</a></b></td>
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


<% if mobiledevice = True or screenwidth < 1150 then %>
<tr><td class = "body roundedtopandbottom" align = "left" height = "500" valign = top>
<% else %>
<tr><td class = "body roundedtopandbottom" align = "center" height = "500" valign = top>
<% end if %>

