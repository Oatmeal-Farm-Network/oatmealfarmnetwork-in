<SCRIPT LANGUAGE="JavaScript" type="text/javascript">
<!-- Begin
function NewWindow(mypage, myname, w, h, scroll) {
var winl = (screen.width - w) / 2;
var wint = (screen.height - h) / 2;
winprops = 'height='+h+',width='+w+',top='+wint+',left='+winl+',scrollbars='+scroll+',resizable'
win = window.open(mypage, myname, winprops)
if (parseInt(navigator.appVersion) >= 4) { win.window.focus(); }
}
//  End -->
</script>

<script type="text/javascript"><!--//--><![CDATA[//><!--

sfHover = function() {
var sfEls = document.getElementById("nav").getElementsByTagName("LI");
for (var i=0; i<sfEls.length; i++) {
sfEls[i].onmouseover=function() {
this.className+=" sfhover";
}
sfEls[i].onmouseout=function() {
this.className=this.className.replace(new RegExp(" sfhover\\b"), "");
}
}
}
if (window.attachEvent) window.attachEvent("onload", sfHover);

//--><!]]></script>
<%
dim Owners
CurrentPeopleID = 667
if len(CurrentPeopleID) > 0 then
sql = "select  * from People where PeopleID= " & CurrentPeopleID

rs.Open sql, conn, 3, 3
If not rs.eof then
PeopleFirstName = rs("PeopleFirstName")
PeopleLastName = rs("PeopleLastName")
RanchHomeText = rs("RanchHomeText")
BusinessID= rs("BusinessID")
AddressID  = rs("AddressID")
RanchHomeText = rs("RanchHomeText")
Phone = rs("PeoplePhone")
Cellphone = rs("PeopleCell")
Fax = rs("PeopleFax")
Owners = rs("Owners")
ScreenBackground=rs("ScreenBackground")
PaypalEmail = rs("PaypalEmail")
if len(trim(Owners)) < 2 then
Owners = PeopleFirstName & " " & PeopleLastName
end if
screenbackground = rs("screenbackground")

str1 = RanchHomeText
str2 = vblf
If InStr(str1,str2) > 0 Then
RanchHomeText= Replace(str1, str2 , "</br>")
End If  

str1 = RanchHomeText
str2 = vbtab
If InStr(str1,str2) > 0 Then
RanchHomeText= Replace(str1, str2 , "&nbsp;&nbsp;&nbsp;&nbsp;")
End If  
end if 

rs.close



sql = "select  BusinessName from Business where BusinessID= " & BusinessID
rs.Open sql, conn, 3, 3
If not rs.eof then
BusinessName = rs("BusinessName")
end if 

rs.close
sql = "select  * from Address where AddressID= " & AddressID
rs.Open sql, conn, 3, 3
If not rs.eof then
AddressStreet = rs("AddressStreet")
AddressApt = rs("AddressApt")
AddressCity = rs("AddressCity")
AddressState = rs("AddressState")
AddressCountry = rs("AddressCountry")
AddressZip = rs("AddressZip")
end if 
rs.close


sql = "select * from SiteDesign where PeopleID= " & CurrentPeopleID
rs.Open sql, conn, 3, 3
If not rs.eof Then

MultipleHeaders = rs("MultipleHeaders")
MenuDropdowns = rs("MenuDropdowns")
MenuColor = rs("MenuColor")
MenuFontMouseOverColor = rs("MenuFontMouseOverColor")
MenuSize = rs("MenuSize")
MenuFont = rs("MenuFont")
MenuAlign = rs("MenuAlign")
MenuWeight = rs("MenuWeight")
MenuItalics = rs("MenuItalics")
MenuBackgroundImage = rs("MenuBackgroundImage")
MenuHyperlinkColor = rs("MenuHyperlinkColor")
MenuDropdownColor = rs("MenuDropdownColor")
MenuBackgroundColor = rs("MenuBackgroundColor")
MenuDropdownColorMouseover = rs("MenuDropdownColorMouseover")

TitleColor = rs("TitleColor")
TitleFont = rs("TitleFont")
TitleSize = rs("TitleSize")
TitleAlign = rs("TitleAlign")
TitleWeight = rs("TitleWeight")
TitleItalics = rs("TitleItalics")

FooterImage = rs("FooterImage")
FooterTextColor = rs("FooterTextColor")
FooterTextSize = rs("FooterTextSize")
FooterTextFont = rs("FooterTextFont")
FooterWeight = rs("FooterWeight")
FooterItalics = rs("FooterItalics")
FooterAlign = rs("FooterAlign")
FooterMouseOverColor= rs("FooterMouseOverColor")
FooterHyperlinkColor= rs("FooterHyperlinkColor")

H2Color = rs("H2Color")
H2Font = rs("H2Font")
H2Size = rs("H2Size")
H2Align = rs("H2Align")
H2Weight = rs("H2Weight")
H2Italics = rs("H2Italics")

H3Color = rs("H3Color")
H3Font = rs("H3Font")
H3Size = rs("H3Size")
H3Align = rs("H3Align")
H3Weight = rs("H3Weight")
H3Italics = rs("H3Italics")

H4Color = rs("H4Color")
H4Font = rs("H4Font")
H4Size = rs("H4Size")
H4Align = rs("H4Align")
H4Weight = rs("H4Weight")
H4Italics = rs("H4Italics")

Logo = rs("Logo")
FooterLogo = rs("Logo")
Header = rs("Header")
MenuRoundedCorners = rs("MenuRoundedCorners")
MenuDropdownColorMouseover = rs("MenuDropdownColorMouseover")
PicturesBorderSize = rs("PicturesBorderSize")
MenuDropdownColorMouseover =rs("MenuDropdownColorMouseover")
PicturesBorderColor = rs("PicturesBorderColor")
NonRepeatingScreenBackgroundImage=rs("NonRepeatingScreenBackgroundImage")
ScreenBackgroundColor=rs("ScreenBackgroundColor")
ScreenBackgroundImage=rs("ScreenBackgroundImage")

PicturesShadow = rs("PicturesShadow")
PageBackgroundColor = rs("PageBackgroundColor")
PageBackgroundImage = rs("PageBackgroundImage")
PageTextColor = rs("PageTextColor")
LayoutStyle = rs("LayoutStyle")
PageTextColor = rs("PageTextColor")
PageTextFontsize = rs("PageTextFontSize")
PageTextFont = rs("PageTextFont")
PageTextHyperlinkColor = rs("PageTextHyperlinkColor")
PageTextMouseOverColor = rs("PageTextMouseOverColor")
PageTextAlign = rs("PageTextAlign")
PageTextWeight = rs("PageTextWeight")
PageTextItalics = rs("PageTextItalics")
MenuShadow = rs("MenuShadow")
FooterColor = rs("FooterColor")
FooterRoundedCorners = rs("FooterRoundedCorners")
FooterShadow = rs("FooterShadow")
End If
rs.close 
end if

if MultipleHeaders = True then
CurrentHour = Hour(now)
CurrentMonth = Month(now)
if CurrentMonth = 12 then
CurrentMonth = 1
else
CurrentMonth = CurrentMonth +1
end if
CurrentMonth = 6
if CurrentHour < 7 or CurrentHour < 7 then

sql = "select * from SiteDesignHeaderImages where (HeadertimeOfday= 'Night' or HeadertimeOfday= 'Day and Night') and Headermonth < " & CurrentMonth & " order by HeaderMonth desc, HeaderTimeOfDay"
else
sql = "select * from SiteDesignHeaderImages where (HeadertimeOfday= 'Day' or HeadertimeOfday= 'Day and Night') and Headermonth < " & CurrentMonth & " order by HeaderMonth desc, HeaderTimeOfDay"
end if

rs.Open sql, conn, 3, 3   
if not rs.eof then 

tempHeader = rs("HeaderImage")

end if
rs.close
end if

'response.write("tempHeader=" & tempHeader )

if len(tempHeader) > 4 then
else
if CurrentHour < 7 or CurrentHour < 7 then
sql = "select * from SiteDesignHeaderImages where (HeadertimeOfday= 'Night' or HeadertimeOfday= 'Day and Night') order by HeaderMonth, HeaderTimeOfDay, HeaderDay"
else
sql = "select * from SiteDesignHeaderImages where (HeadertimeOfday= 'Night' or HeadertimeOfday= 'Day and Night') order by HeaderMonth, HeaderTimeOfDay, HeaderDay"
end if


rs.Open sql, conn, 3, 3   
if not rs.eof then 

tempHeader = rs("HeaderImage")

end if
rs.close
end if


if len(tempHeader) > 4 then
Header = tempHeader
else
if CurrentHour < 7 or CurrentHour < 7 then
sql = "select * from SiteDesignHeaderImages order by HeaderMonth, HeaderTimeOfDay, HeaderDay"
else
sql = "select * from SiteDesignHeaderImages order by HeaderMonth, HeaderTimeOfDay, HeaderDay"
end if
'response.write("sql=" & sql)

rs.Open sql, conn, 3, 3   
if not rs.eof then 

tempHeader = rs("HeaderImage")

end if
rs.close

end if

if mobiledevice = True and screenwidth > 690 then

MenuSize =MenuSize + 22
TitleSize = TitleSize + 18
FooterTextSize = FooterTextSize+ 18
H1Size = H1Size + 18
H2Size = H2Size + 18
H3Size = H3Size + 18
PageTextFontsize = PageTextFontsize + 22
buttonheight = 80
else
buttonheight = 50
end if

if mobiledevice = True then
Lineheight = 50
else
Lineheight = 15
end if

if MenuRoundedCorners = "True" then 
menuradiusleft = "10px"
menuradiusright = "10px"
end if 
 
if MenuRoundedCorners = "True" and Layoutstyle="Portrait1" then 
menuradiusleft = "0px"
menuradiusright = "20px"
end if 
 
if ((Layoutstyle="Portrait1" or Layoutstyle="Portrait2") and screenwidth < 800) or  mobiledevice = True then 
Layoutstyle="Landscape"
end if
if FooterRoundedCorners = "True" then 
Footerradius = "10px"
end if

if len(NonRepeatingScreenBackgroundImage) > 4 or len(ScreenBackgroundImage) > 0 then
if len(NonRepeatingScreenBackgroundImage) > 4 then %>
<style>
body {
background-color : <%=pageBackgroundColor %>;
background-repeat:repeat;
background-attachment:fixed;
}
</style>
<% end if 
if len(ScreenBackgroundImage) > 0 then %>
<style>
body {
background-color : <%=PageBackgroundColor %>;
background-repeat:repeat;
background-attachment:fixed;
}
</style>
<% end if %>

 <% else %>
<style>
body {
background-color : <%=ScreenBackgroundColor %>;
background-repeat : no-repeat;
background-attachment:fixed;
background-position:center;
background-position:top;
}
</style>
<% end if %>
<style>
/* Main */
#menu
{
width: 100%;
margin: 0;
padding: 15px 0 0 0;
list-style: none;
border-bottom-left-radius:<%=menuradiusleft %>;
border-bottom-right-radius:<%=menuradiusright %>;
-moz-border-radius-bottomleft:<%=menuradiusleft %>; /* Firefox 3.6 and earlier */
-moz-border-radius-bottomright:<%=menuradiusright %>; /* Firefox 3.6 and earlier */

}


#menu li
{
float: left;
padding: 0 0 0px 0;
position: relative;
line-height: 0;
font-weight: bold;
}

#menu a 
{
float: left;
height: 19px;
padding: 0 10px;
color: <%=MenuHyperlinkColor%>;
font-size: <%=MenuSize%>px ;
font-family : <%=MenuFont%>;
text-decoration: none;
font-weight: bold;
}

#menu li:hover > a
{
font-weight: bold;
color: <%=MenuHyperlinkColor%>;
}




*html #menu li a:hover /* IE6 */
{font-weight: bold;
color: <%=MenuFontMouseOverColor%>;
}

#menu li:hover > ul
{font-weight: bold;
display: block;
}

/* Sub-menu */

#menu ul
{list-style: none;
margin: 0;
padding: 0; 
display: none;
position: absolute;
top: 15px;
left: 0;
z-index: 99999; 
background: <%=MenuDropdownColor%>;
text-align: left;
}

#menu ul ul
{ top: 0;
  left: 150px;}

#menu ul li
{ float: none;
margin: 0;
padding: 0;
display: block;  

}



#menu ul a
{ 
 padding: 8px;
height: 10px;
width: 200px;
height: auto;
 line-height: 1;
 display: block;
 white-space: nowrap;
 float: none;
text-transform: none;
}

*html #menu ul a /* IE6 */
{ 
height: 10px;
}

*:first-child+html #menu ul a /* IE7 */
{ 
height: 10px;
}

#menu ul a:hover
{
 background: <%=MenuDropdownColorMouseover%>;

background: -webkit-linear-gradient(<%=MenudropdownColor%>,  <%=MenuDropdownColorMouseover%>);
background: -o-linear-gradient(<%=MenudropdownColor%>,  <%=MenuDropdownColorMouseover%>);
background: -ms-linear-gradient(<%=MenudropdownColor%>,  <%=MenuDropdownColorMouseover%>);
background: linear-gradient(<%=MenudropdownColor%>,  <%=MenuDropdownColorMouseover%>);
}

#menu ul li:first-child > a
{
 -moz-border-radius: 5px 5px 0 0;
 border-radius: 5px 5px 0 0;
}

#menu ul li:first-child > a:after
{
 content: '';
 position: absolute;
 left: 30px;
 top: -8px;
 width: 0;
 height: 0;
 border-left: 5px solid transparent;
 border-right: 5px solid transparent;
 border-bottom: 8px solid black;
}

#menu ul ul li:first-child a:after
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

#menu ul li:first-child a:hover:after
{
 border-bottom-color: <%=MenuDropdownColor%>; 
}

#menu ul ul li:first-child a:hover:after
{
 border-right-color: <%=MenuDropdownColor%>; 
 border-bottom-color: transparent; 
}


#menu ul li:last-child > a
{
 -moz-border-radius: 0 0 5px 5px;
 border-radius: 0 0 5px 5px;
}

/* Clear floated elements */
#menu:after 
{
visibility: hidden;
display: block;
font-size: 0;
content: " ";
clear: both;
height: 0;
}

* html #menu { zoom: 1; } /* IE6 */
*:first-child+html #menu { zoom: 1; } /* IE7 */



/* Main */
#menu2
{
width: 100%;
margin: 0;
padding: 15px 0 0 0;
list-style: none;
border-bottom-left-radius:<%=menuradiusleft %>;
border-bottom-right-radius:<%=menuradiusright %>;
-moz-border-radius-bottomleft:<%=menuradiusleft %>; /* Firefox 3.6 and earlier */
-moz-border-radius-bottomright:<%=menuradiusright %>; /* Firefox 3.6 and earlier */

}



#menu2 li
{
float: left;
padding: 10 10 10px 0;
position: relative;
line-height: 0;
font-weight: bold;

}

#menu2 a 
{
float: left;
height: 19px;
width: 700;
padding: 0 10px;
color: <%=MenuHyperlinkColor%>;
font-size: <%=MenuSize%>px ;
font-family : <%=MenuFont%>;
text-decoration: none;
font-weight: bold;
}




#menu2 li:hover > a
{
font-weight: bold;
color: <%=MenuFontMouseOverColor%>;
}

*html #menu2 li a:hover /* IE6 */
{font-weight: bold;
color: <%=MenuDropdownColor%>;
}

#menu2 li:hover > ul
{font-weight: bold;
display: block;
}

/* Sub-menu2 */

#menu2 ul
{list-style: none;
margin: 13;
padding: 0; 
display: none;
position: absolute;
left: 10;
z-index: 99999; 
background: <%=MenuDropdownColor%>;
text-align: left;
}

#menu2 ul ul
{ top: 0;
  left: 250px;}

#menu2 ul li
{ float: none;
margin: 0;
padding: 0;
display: block;  

}



#menu2 ul a
{ 
 padding: 8px;
height: <%=Lineheight%>px;
 line-height: 1;
 display: block;
 white-space: nowrap;
 float: none;
text-transform: none;
}

*html #menu2 ul a /* IE6 */
{ 
height: 60px;
}

*:first-child+html #menu2 ul a /* IE7 */
{ 
height: 60px;
}

#menu2 ul a:hover
{
 background: <%=MenuDropdownColorMouseover%>;
}

#menu2 ul li:first-child > a
{
 -moz-border-radius: 5px 5px 0 0;
 border-radius: 5px 5px 0 0;
}

#menu2 ul li:first-child > a:after
{
 content: '';
 position: absolute;
 left: 30px;
 top: -18px;
 width: 700;
 height: 0;
 border-left: 5px solid black;
 border-right: 5px solid black;
 border-bottom: 8px solid black;
}

#menu2 ul ul li:first-child a:after
{
 left: -18px;
 top: 12px;
 width: 700;
 height: 0;
 border-left: 0;
 border-bottom: 5px solid black;
 border-top: 5px solid black;
 border-right: 8px solid #444;
}

#menu2 ul li:first-child a:hover:after
{
 border-bottom-color: black; 
}

#menu2 ul ul li:first-child a:hover:after
{
 border-right-color: black; 
 border-bottom-color: black; 
}


#menu2 ul li:last-child > a
{
 -moz-border-radius: 0 0 5px 5px;
 border-radius: 0 0 5px 5px;
}

/* Clear floated elements */
#menu2:after 
{
visibility: hidden;
display: block;
font-size: 0;
content: " ";
clear: both;
height: 0;
}

* html #menu2 { zoom: 1; } /* IE6 */
*:first-child+html #menu2 { zoom: 1; } /* IE7 */



.Regsubmit2
{ color = Black;
background-color : #a1a1a1;
border-bottom:1px solid #CCCCCC;
border-left:1px solid #CCCCCC;
border-right:1px solid #CCCCCC;
margin-top:1px solid #CCCCCC;
margin-bottom:10px;
margin-right:0px;
margin-left:0px;
padding:5px 10px; 
background:#9A733B;
text-align: center;
box-shadow: 5px 5px 5px #CCCCCC;
border-top-left-radius:5px;
border-top-right-radius:5px;
border-bottom-left-radius:5px;
border-bottom-right-radius:5px;
-moz-border-radius-topleft:5px; /* Firefox 3.6 and earlier */
-moz-border-radius-topright:5px; /* Firefox 3.6 and earlier */
-moz-border-radius-bottomleft:5px; /* Firefox 3.6 and earlier */
-moz-border-radius-bottomright:5px; /* Firefox 3.6 and earlier */
}
 
.regsubmit2
{ 
background-color : #a1a1a1;
border-bottom:1px solid #ababab;
border-left:1px solid #ababab;
border-right:1px solid #ababab;
margin-top:1px solid #ababab;
margin-bottom:10px;
margin-right:0px;
margin-left:0px;
padding:5px 10px; 
background:#9A733B;
text-align: left;
box-shadow: 5px 5px 5px #ababab;
border-top-left-radius:5px;
border-top-right-radius:5px;
border-bottom-left-radius:5px;
border-bottom-right-radius:5px;
-moz-border-radius-topleft:5px; /* Firefox 3.6 and earlier */
-moz-border-radius-topright:5px; /* Firefox 3.6 and earlier */
-moz-border-radius-bottomleft:5px; /* Firefox 3.6 and earlier */
-moz-border-radius-bottomright:5px; /* Firefox 3.6 and earlier */
}

.builtby {
font-family: arial,sans-serif;
 color: white;
 font-size: 10px;
 font-weight: 600;
 line-height: 13px }
 
A.builtby{
font-family: arial,sans-serif;
 color: white;
 font-size: 10px;
 font-weight: 600;
 line-height: 13px }
 
A.builtby:hover{
 text-decoration: none; 
 color: grey;
}


select {
content: <%=MenuBackgroundColor%>;
 width:150px;
 border:1px solid <%=MenuBackgroundColor%>;
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
display: inline-block;

  }

.custom-select select {
display: inline-block;
padding: 4px 3px 3px 5px;
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
content: <%=MenuBackgroundColor%>;
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
* html #menu { zoom: 1; } /* IE6 */
*:first-child+html #menu { zoom: 1; } /* IE7 */

.Footer {font: <%=FooterTextSize%>px <%=FooterTextFont %>; font-weight:  <%=FooterWeight %> ;  <% if FooterItalics = "Yes" then %> font-style: italic;<% end if %> color: <%=FooterTextColor%> ; text-align: <%=FooterAlign %>; PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; LINE-HEIGHT: 18px; PADDING-TOP: 0px; }

A.Footer {font: <%=FooterTextSize%>px <%=FooterTextFont%>; font-weight:  <%=FooterWeight %> ;  <% if FooterItalics = "Yes" then %> font-style: italic;<% end if %> color: <%=FooterHyperlinkColor %>; text-decoration :none; text-align: <%=FooterAlign %>; PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; LINE-HEIGHT: 18px; PADDING-TOP: 0px; }

A.Footer:hover {font: <%=FooterTextSize%>px <%=FooterTextFont%>; color: <%=FooterMouseOverColor%> ; text-decoration :none; font-weight:  <%=FooterWeight %> ;  <% if FooterItalics = "Yes" then %> font-style: italic;<% end if %>  text-align: <%=FooterAlign %>; PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; LINE-HEIGHT: 18px; PADDING-TOP: 0px; }

H1 {font: <%=TitleSize %>px <%=TitleFont %>; font-weight:  <%=TitleWeight %> ;  <% if TitleItalics = "Yes" then %> font-style: italic;<% end if %> color: <%=TitleColor %>; text-align: <%=TitleAlign %>; PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN-top: 5px; MARGIN-Bottom: 0px; LINE-HEIGHT: <%=TitleSize  + 15 %>px; PADDING-TOP: 0px; }
h1 {font: <%=TitleSize %>px <%=TitleFont %>; font-weight:  <%=TitleWeight %> ;  <% if TitleItalics = "Yes" then %> font-style: italic;<% end if %> color: <%=TitleColor %>; text-align: <%=TitleAlign %>; PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN-top: 5px; MARGIN-Bottom: 0px;  LINE-HEIGHT: <%=TitleSize  + 15 %>px; PADDING-TOP: 0px; }

H2 {font: <%=H2Size %>px <%=H2Font %>;  font-weight:  <%=H2Weight %> ;  <% if TitleItalics = "Yes" then %> font-style: italic;<% end if %> color: <%=H2Color %>; text-align: <%=H2Align %>; PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; LINE-HEIGHT: <%=TitleSize  + 10 %>px; PADDING-TOP: 0px; }
h2 {font: <%=H2Size %>px <%=H2Font %>;  font-weight:  <%=H2Weight %> ;  <% if TitleItalics = "Yes" then %> font-style: italic;<% end if %> color: <%=H2Color %>; text-align: <%=H2Align %>; PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; LINE-HEIGHT: <%=TitleSize  + 10%>px; PADDING-TOP: 0px; }


H3 {font: <%=H3Size %>px <%=H3Font %>;  font-weight:  <%=H3Weight %> ;  <% if TitleItalics = "Yes" then %> font-style: italic;<% end if %> color: <%=H3Color %>; text-align: <%=H3Align %>; PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; LINE-HEIGHT: <%=TitleSize  + 10%>px; PADDING-TOP: 0px; }

h3 {font: <%=H3Size %>px <%=H3Font %>;  font-weight:  <%=H3Weight %> ;  <% if TitleItalics = "Yes" then %> font-style: italic;<% end if %> color: <%=H3Color %>; text-align: <%=H3Align %>; PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; LINE-HEIGHT: <%=TitleSize + 10 %>px; PADDING-TOP: 0px; }



LI UL {font: <%=PageTextFontSize%>px <%=PageTextFont%>; color: <%=PageTextHyperlinkColor %>; text-decoration :none;}

.Body {font: <%=PageTextFontSize%>px <%=PageTextFont%>;  font-weight:  <%=PageTextWeight %> ;  <% if PageTextItalics = "Yes" then %> font-style: italic;<% end if %> color: <%=PageTextColor %>; text-align: <%=PageTextAlign %>; PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; LINE-HEIGHT: <%=PageTextFontSize +5 %>px; PADDING-TOP: 0px; }

A.Body {font: <%=PageTextFontSize%>px <%=PageTextFont%>; font-weight:  <%=PageTextWeight %> ;  <% if PageTextItalics = "Yes" then %> font-style: italic;<% end if %>  color: <%=PageTextHyperlinkColor %>; text-decoration :none; text-align: <%=PageTextAlign %>; PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; LINE-HEIGHT: 18px; PADDING-TOP: 0px; }
A.Body:hover {font: <%=PageTextFontSize%>px <%=PageTextFont%>; font-weight:  <%=PageTextWeight %> ;  <% if PageTextItalics = "Yes" then %> font-style: italic;<% end if %> color: <%=PageTextMouseOverColor %> ; text-decoration :none; text-align: <%=PageTextAlign %>; PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; LINE-HEIGHT: 18px; PADDING-TOP: 0px; }

.body {font: <%=PageTextFontSize%>px <%=PageTextFont%>;  font-weight:  <%=PageTextWeight %> ;  <% if PageTextItalics = "Yes" then %> font-style: italic;<% end if %> color: <%=PageTextColor %>; text-align: <%=PageTextAlign %>; PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; LINE-HEIGHT: <%=PageTextFontSize +5 %>px; PADDING-TOP: 0px; }
A.body {font: <%=PageTextFontSize%>px <%=PageTextFont%>; font-weight:  <%=PageTextWeight %> ;  <% if PageTextItalics = "Yes" then %> font-style: italic;<% end if %>  color: <%=PageTextHyperlinkColor %>; text-decoration :none; text-align: <%=PageTextAlign %>; PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; LINE-HEIGHT: 18px; PADDING-TOP: 0px; }
A.body:hover {font: <%=PageTextFontSize%>px <%=PageTextFont%>; font-weight:  <%=PageTextWeight %> ;  <% if PageTextItalics = "Yes" then %> font-style: italic;<% end if %> color: <%=PageTextMouseOverColor %> ; text-decoration :none; text-align: <%=PageTextAlign %>; PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; LINE-HEIGHT: 18px; PADDING-TOP: 0px; }

.Body2 {font: <%=PageTextFontSize%>px <%=PageTextFont%>;  font-weight:  <%=PageTextWeight %> ;  <% if PageTextItalics = "Yes" then %> font-style: italic;<% end if %> color: <%=PageTextColor %>;  PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; LINE-HEIGHT: <%=TitleSize + 5 %>px; PADDING-TOP: 0px; }
A.Body2 {font: <%=PageTextFontSize%>px <%=PageTextFont%>; font-weight:  <%=PageTextWeight %> ;  <% if PageTextItalics = "Yes" then %> font-style: italic;<% end if %>  color: <%=PageTextHyperlinkColor %>; text-align: <%=PageTextAlign %>; PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; LINE-HEIGHT: <%=TitleSize + 5 %>px; PADDING-TOP: 0px; }
A.Body2:hover {font: <%=PageTextFontSize%>px <%=PageTextFont%>; font-weight:  <%=PageTextWeight %> ;  <% if PageTextItalics = "Yes" then %> font-style: italic;<% end if %> color: <%=PageTextMouseOverColor %> ;  text-align: <%=PageTextAlign %>; PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; LINE-HEIGHT: <%=TitleSize +5 %>px; PADDING-TOP: 0px; }

.body2 {font: <%=PageTextFontSize%>px <%=PageTextFont%>;  font-weight:  <%=PageTextWeight %> ;  <% if PageTextItalics = "Yes" then %> font-style: italic;<% end if %> color: <%=PageTextColor %>;  PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; LINE-HEIGHT: <%=TitleSize %>px; PADDING-TOP: 0px; }
A.body2 {font: <%=PageTextFontSize%>px <%=PageTextFont%>; font-weight:  <%=PageTextWeight %> ;  <% if PageTextItalics = "Yes" then %> font-style: italic;<% end if %>  color: <%=PageTextHyperlinkColor %>;  text-align: <%=PageTextAlign %>; PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; LINE-HEIGHT: <%=TitleSize %>px; PADDING-TOP: 0px; }
A.body2:hover {font: <%=PageTextFontSize%>px <%=PageTextFont%>; font-weight:  <%=PageTextWeight %> ;  <% if PageTextItalics = "Yes" then %> font-style: italic;<% end if %> color: <%=PageTextMouseOverColor %> ; text-align: <%=PageTextAlign %>; PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; LINE-HEIGHT: <%=TitleSize %>px; PADDING-TOP: 0px; }


.Menu {font: <%=MenuSize%>px <%=MenuFont%>; font-weight:  <%=MenuWeight %> ;  <% if MenuItalics = "Yes" then %> font-style: italic;<% end if %>  color: <%=MenuColor %> ; text-decoration :none; text-align: <%=MenuAlign %>; PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; LINE-HEIGHT: <%=TitleSize %>px; PADDING-TOP: 0px; }
A.Menu {font: <%=MenuSize%>px <%=MenuFont%>; font-weight:  <%=MenuWeight %> ;  <% if MenuItalics = "Yes" then %> font-style: italic;<% end if %>  color: <%=MenuColor %> ; text-decoration :none; text-align: <%=MenuAlign %>; PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; LINE-HEIGHT: <%=TitleSize %>px; PADDING-TOP: 0px; }
A.Menu:Hover { font: <%=MenuSize%>px <%=MenuFont%>; font-weight:  <%=MenuWeight %> ;  <% if MenuItalics = "Yes" then %> font-style: italic;<% end if %>  color: <%=MenuFontMouseOverColor %> ; text-align: <%=MenuAlign %>; PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; LINE-HEIGHT: <%=TitleSize  %>px; PADDING-TOP: 0px; }

 
 .pictures 
 { border-style: solid;
 border:<%=PicturesBorderSize%>;
 border-color:<%=PicturesBorderColor%>;
 <% if PicturesShadow = "True" then %>
-moz-box-shadow: 3px 3px 8px  black;
-webkit-box-shadow: 3px 3px 8px  black;
box-shadow: 3px 3px 8px  black;
<% end if %>
}

 
.Ranchmenu2 {font-family : verdana, Arial, Helvetica, sans-serif;
font-size : 11px;
line-height : 18px;
color : black;
margin:5;
padding-left: 10;
font-weight: normal;
}

A.Ranchmenu2 {font-family : verdana, Arial, Helvetica, sans-serif;
font-size : 11px;
line-height : 18px;
margin:5;
padding:0;
color : brown;
font-weight: normal;
text-decoration :none;
}
A.Ranchmenu2:Hover {
color :black ;
text-decoration : none;
}
 
 
.roundedtop
{
border-top:1px solid #a1a1a1;
border-left:1px solid #a1a1a1;
border-right:1px solid #a1a1a1;
padding:5px 10px; 
box-shadow: 5px 5px 10px #ababab;
background-color: <%=menuBackgroundColor%> ;
margin:0px;
border-top-left-radius:15px;
border-top-right-radius:15px;
-moz-border-radius-topleft:15px; /* Firefox 3.6 and earlier */
-moz-border-radius-topright:15px; /* Firefox 3.6 and earlier */
}

.roundedBottom
{
border-bottom:1px solid #a1a1a1;
border-left:1px solid #a1a1a1;
border-right:1px solid #a1a1a1;
margin-top:0px;
 margin-bottom:10px;
 margin-right:0px;
 margin-left:0px;
padding:5px 10px; 
background:<%=PageBackgroundColor %>;
background-color: <%=PageBackgroundColor %>;
box-shadow: 5px 5px 10px #ababab;
border-bottom-left-radius:15px;
border-bottom-right-radius:15px;
-moz-border-radius-bottomleft:15px; /* Firefox 3.6 and earlier */
-moz-border-radius-bottomright:15px; /* Firefox 3.6 and earlier */
}


.roundedtopandbottom
{ background:<%=PageBackgroundColor %>;
background-color: <%=PageBackgroundColor %>;
border-top:1px solid black;
border-bottom:1px solid black;
border-left:1px solid black;
border-right:1px solid black;
margin-top:10px;
 margin-bottom:10px;
 margin-right:10px;
 margin-left:10px;
padding:10px 0px; 
box-shadow: 0px 0px 0px black;
border-bottom-left-radius: 5px;
border-bottom-right-radius: 5px;
-moz-border-radius-bottomleft: 5px; /* Firefox 3.6 and earlier */
-moz-border-radius-bottomright: 5px; /* Firefox 3.6 and earlier */
border-top-left-radius: 5px;
border-top-right-radius: 5px;
-moz-border-radius-topleft: 5px; /* Firefox 3.6 and earlier */
-moz-border-radius-topright: 5px; /* Firefox 3.6 and earlier */
}


.featuredroundedtopandbottom
{ background:black;
background-color: black;
border-top:1px solid black;
border-bottom:1px solid black;
border-left:1px solid black;
border-right:1px solid black;
margin-top:10px;
 margin-bottom:10px;
 margin-right:10px;
 margin-left:10px;
padding:10px 0px; 
box-shadow: 0px 0px 0px black;
border-bottom-left-radius: 5px;
border-bottom-right-radius: 5px;
-moz-border-radius-bottomleft: 5px; /* Firefox 3.6 and earlier */
-moz-border-radius-bottomright: 5px; /* Firefox 3.6 and earlier */
border-top-left-radius: 5px;
border-top-right-radius: 5px;
-moz-border-radius-topleft: 5px; /* Firefox 3.6 and earlier */
-moz-border-radius-topright: 5px; /* Firefox 3.6 and earlier */
}
</style>
<SCRIPT LANGUAGE="JavaScript" type="text/javascript">
<!-- Begin
 function NewWindow(mypage, myname, w, h, scroll) {
  var winl = (screen.width - w) / 2;
  var wint = (screen.height - h) / 2;
  winprops = 'height=' + h + ',width=' + w + ',top=' + wint + ',left=' + winl + ',scrollbars=' + scroll + ',resizable'
  win = window.open(mypage, myname, winprops)
  if (parseInt(navigator.appVersion) >= 4) { win.window.focus(); }
 }
//  End -->
</script>

<script type="text/javascript"><!-- //--><![CDATA[//><!--

 sfHover = function() {
  var sfEls = document.getElementById("nav").getElementsByTagName("LI");
  for (var i = 0; i < sfEls.length; i++) {
sfEls[i].onmouseover = function() {
 this.className += " sfhover";
}
sfEls[i].onmouseout = function() {
 this.className = this.className.replace(new RegExp(" sfhover\\b"), "");
}
  }
 }
 if (window.attachEvent) window.attachEvent("onload", sfHover);

 //--><!]]></script>


<tr><td width = "100%" height = "500" valign = "top" bgcolor="<%=PageBackgroundColor %>" background = "<%=PageBackgroundImage %>">
