<%If cint(ScreenWidth) > 988 then
   Pagewidth = 988
   screenwidth = 988
   end if 
   
   
'response.redirect("/underconstruction.asp")%>
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
MenuHyperlinkColor = rs("MenuHyperlinkColor")
MenuDropdownColor = rs("MenuDropdownColor")
TitleColor = rs("TitleColor")
TitleFont = rs("TitleFont")
TitleSize = rs("TitleSize")
TitleAlign = rs("TitleAlign")
TitleWeight = rs("TitleWeight")
TitleItalics = rs("TitleItalics")

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


'if CurrentMonth = 12 then
'CurrentMonth = 1
'else
CurrentMonth = CurrentMonth +1
'end if
'response.write("currentmonth = " & currentmonth)

if CurrentHour < 7 or CurrentHour < 7 then

sql = "select * from SiteDesignHeaderImages where (HeadertimeOfday= 'Night' or HeadertimeOfday= 'Day and Night') and Headermonth < " & CurrentMonth & " order by HeaderMonth desc, HeaderTimeOfDay"
else
sql = "select * from SiteDesignHeaderImages where (HeadertimeOfday= 'Day' or HeadertimeOfday= 'Day and Night') and Headermonth < " & CurrentMonth & " order by HeaderMonth desc, HeaderTimeOfDay"
end if
'response.write("sql=" & sql)
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
'response.write("sql=" & sql)

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



if MenuRoundedCorners = "True" then 
menuradiusleft = "10px"
menuradiusright = "10px"
end if 
 
if MenuRoundedCorners = "True" and Layoutstyle="Portrait1" then 
menuradiusleft = "0px"
menuradiusright = "20px"
end if 
 
if FooterRoundedCorners = "True" then 
Footerradius = "10px"
end if

if len(NonRepeatingScreenBackgroundImage) > 4 or len(ScreenBackgroundImage) > 0 then
if len(NonRepeatingScreenBackgroundImage) > 4 then %>
<style>
body {
background-image : url("<%=NonRepeatingScreenBackgroundImage%>");
background-color : <%=ScreenBackgroundColor %>;
background-repeat:repeat;
background-attachment:fixed;
}
</style>
<% end if 
if len(ScreenBackgroundImage) > 0 then %>
<style>
body {
background-image : url("<%= ScreenBackgroundImage%>");
background-color : <%=ScreenBackgroundColor %>;
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
background-color: <%=MenuBackgroundColor%> ;
background: <%=MenuBackgroundColor%>;
border-bottom-left-radius:<%=menuradiusleft %>;
border-bottom-right-radius:<%=menuradiusright %>;
-moz-border-radius-bottomleft:<%=menuradiusleft %>; /* Firefox 3.6 and earlier */
-moz-border-radius-bottomright:<%=menuradiusright %>; /* Firefox 3.6 and earlier */
<% if MenuShadow = "True" then %>
-moz-box-shadow: 3px 3px 8px  black;
-webkit-box-shadow: 3px 3px 8px  black;
box-shadow: 3px 3px 8px black;
<% end if %>
}


#menu li
{
float: left;
padding: 0 0 0px 0;
position: relative;
line-height: 0;
}

#menu a 
{
float: left;
height: 25px;
padding: 0 10px;
color: white;
font-size: <%=MenuSize%>px ;
font-family : <%=MenuFont%>;
text-decoration: none;
text-shadow: 0 1px 0 #000;
}

#menu li:hover > a
{
color: #fafafa;
}

*html #menu li a:hover /* IE6 */
{
color: #fafafa;
}

#menu li:hover > ul
{
display: block;
}

/* Sub-menu */

#menu ul
{list-style: none;
margin: 0;
padding: 0; 
display: none;
position: absolute;
top: 21px;
left: 0;
z-index: 99999; 
background-color: <%=MenudropdownColor%> ;
background: <%=MenudropdownColor%>;
<% if MenuShadow = "True" then %>
-moz-box-shadow: 0 0 2px black;
-webkit-box-shadow: 0 0 2px black;
box-shadow: 0px 5px 5px black;
-moz-border-radius: 5px;
border-radius: 0px 0px 5px 5px;
<% end if %>
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
-moz-box-shadow: 1px1px 1px  black;
-webkit-box-shadow: 1px 1px 1px  black;
box-shadow: 1px 1px 1px black;
}

#menu ul li:last-child
{ -moz-box-shadow: none;
-webkit-box-shadow: none;
box-shadow: none; 
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
 background: <%=MenuDropdownColorMouseoverr%>;

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
 border-bottom: 8px solid #444;
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


/* Footer */
#Footer
{
width: 100%;
margin: 0;
padding: 10px 0 0 0;
list-style: none;  
  background-color: <%=MenuBackgroundColor%> ;
 background: <%=MenuBackgroundColor%>;
border-bottom-left-radius:<%=Footerradius %>;
border-bottom-right-radius:<%=Footerradius %>;
-moz-border-radius-bottomleft:<%=Footerradius %>; /* Firefox 3.6 and earlier */
-moz-border-radius-bottomright:<%=Footerradius %>; /* Firefox 3.6 and earlier */

<% if FooterShadow = "True" then %>
-moz-box-shadow: 3px 3px 8px  black;
-webkit-box-shadow: 3px 3px 8px  black;
box-shadow: 3px 3px 8px black;
<% end if %>
}

#Footer li
{
float: left;
padding: 0 0 10px 0;
position: relative;
line-height: 0;
}



*html #Footer li a:hover /* IE6 */
{
color: #fafafa;
}

#Footer li:hover > ul
{
display: block;
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
 color: white;
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

.Footer {font: <%=FooterTextSize%>px <%=FooterTextFont %>; font-weight:  <%=FooterWeight %> ;  <% if FooterItalics = "Yes" then %> font-style: italic;<% end if %> color: <%=FooterTextColor%> ; text-align: <%=FooterAlign %>; PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; LINE-HEIGHT: <%=TitleSize  %>px; PADDING-TOP: 0px; }

A.Footer {font: <%=FooterTextSize%>px <%=FooterTextFont%>; font-weight:  <%=FooterWeight %> ;  <% if FooterItalics = "Yes" then %> font-style: italic;<% end if %> color: <%=FooterHyperlinkColor %>; text-decoration :none; text-align: <%=FooterAlign %>; PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; LINE-HEIGHT: <%=FooterTextSize  %>px; PADDING-TOP: 0px; }

A.Footer:hover {font: <%=FooterTextSize%>px <%=FooterTextFont%>; color: <%=FooterMouseOverColor%> ; text-decoration :none; font-weight:  <%=FooterWeight %> ;  <% if FooterItalics = "Yes" then %> font-style: italic;<% end if %>  text-align: <%=FooterAlign %>; PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; LINE-HEIGHT: <%=FooterTextSize  %>px; PADDING-TOP: 0px; }

H1 {font: <%=TitleSize %>px <%=TitleFont %>; font-weight:  <%=TitleWeight %> ;  <% if TitleItalics = "Yes" then %> font-style: italic;<% end if %> color: <%=TitleColor %>; text-align: <%=TitleAlign %>; PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN-top: 15px; MARGIN-Bottom: 0px; LINE-HEIGHT: <%=TitleSize  + 5 %>px; PADDING-TOP: 0px; }
h1 {font: <%=TitleSize %>px <%=TitleFont %>; font-weight:  <%=TitleWeight %> ;  <% if TitleItalics = "Yes" then %> font-style: italic;<% end if %> color: <%=TitleColor %>; text-align: <%=TitleAlign %>; PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN-top: 15px; MARGIN-Bottom: 0px;  LINE-HEIGHT: <%=TitleSize  + 5 %>px; PADDING-TOP: 0px; }

H2 {font: <%=H2Size %>px <%=H2Font %>;  font-weight:  <%=H2Weight %> ;  <% if TitleItalics = "Yes" then %> font-style: italic;<% end if %> color: <%=H2Color %>; text-align: <%=H2Align %>; PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; LINE-HEIGHT: <%=TitleSize  + 10 %>px; PADDING-TOP: 0px; }
h2 {font: <%=H2Size %>px <%=H2Font %>;  font-weight:  <%=H2Weight %> ;  <% if TitleItalics = "Yes" then %> font-style: italic;<% end if %> color: <%=H2Color %>; text-align: <%=H2Align %>; PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; LINE-HEIGHT: <%=TitleSize  + 10%>px; PADDING-TOP: 0px; }


H3 {font: <%=H3Size %>px <%=H3Font %>;  font-weight:  <%=H3Weight %> ;  <% if TitleItalics = "Yes" then %> font-style: italic;<% end if %> color: <%=H3Color %>; text-align: <%=H3Align %>; PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; LINE-HEIGHT: <%=TitleSize  + 10%>px; PADDING-TOP: 0px; }

h3 {font: <%=H3Size %>px <%=H3Font %>;  font-weight:  <%=H3Weight %> ;  <% if TitleItalics = "Yes" then %> font-style: italic;<% end if %> color: <%=H3Color %>; text-align: <%=H3Align %>; PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; LINE-HEIGHT: <%=TitleSize + 10 %>px; PADDING-TOP: 0px; }



LI UL {font: <%=PageTextFontSize%>px <%=PageTextFont%>; color: <%=PageTextHyperlinkColor %>; text-decoration :none;}
.Body {font: <%=PageTextFontSize%>px <%=PageTextFont%>;  font-weight:  <%=PageTextWeight %> ;  <% if PageTextItalics = "Yes" then %> font-style: italic;<% end if %> color: <%=PageTextColor %>; text-align: <%=PageTextAlign %>; PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; LINE-HEIGHT: <%=TitleSize + 5 %>px; PADDING-TOP: 0px; }
A.Body {font: <%=PageTextFontSize%>px <%=PageTextFont%>; font-weight:  <%=PageTextWeight %> ;  <% if PageTextItalics = "Yes" then %> font-style: italic;<% end if %>  color: <%=PageTextHyperlinkColor %>; text-decoration :none; text-align: <%=PageTextAlign %>; PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; LINE-HEIGHT: <%=TitleSize + 5 %>px; PADDING-TOP: 0px; }
A.Body:hover {font: <%=PageTextFontSize%>px <%=PageTextFont%>; font-weight:  <%=PageTextWeight %> ;  <% if PageTextItalics = "Yes" then %> font-style: italic;<% end if %> color: <%=PageTextMouseOverColor %> ; text-decoration :none; text-align: <%=PageTextAlign %>; PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; LINE-HEIGHT: <%=TitleSize +5 %>px; PADDING-TOP: 0px; }

.body {font: <%=PageTextFontSize%>px <%=PageTextFont%>;  font-weight:  <%=PageTextWeight %> ;  <% if PageTextItalics = "Yes" then %> font-style: italic;<% end if %> color: <%=PageTextColor %>; text-align: <%=PageTextAlign %>; PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; LINE-HEIGHT: <%=TitleSize %>px; PADDING-TOP: 0px; }
A.body {font: <%=PageTextFontSize%>px <%=PageTextFont%>; font-weight:  <%=PageTextWeight %> ;  <% if PageTextItalics = "Yes" then %> font-style: italic;<% end if %>  color: <%=PageTextHyperlinkColor %>; text-decoration :none; text-align: <%=PageTextAlign %>; PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; LINE-HEIGHT: <%=TitleSize %>px; PADDING-TOP: 0px; }
A.body:hover {font: <%=PageTextFontSize%>px <%=PageTextFont%>; font-weight:  <%=PageTextWeight %> ;  <% if PageTextItalics = "Yes" then %> font-style: italic;<% end if %> color: <%=PageTextMouseOverColor %> ; text-decoration :none; text-align: <%=PageTextAlign %>; PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; LINE-HEIGHT: <%=TitleSize %>px; PADDING-TOP: 0px; }

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
{
border-top:1px solid #a1a1a1;
border-bottom:1px solid #a1a1a1;
border-left:1px solid #a1a1a1;
border-right:1px solid #a1a1a1;
margin-top:10px;
 margin-bottom:10px;
 margin-right:10px;
 margin-left:10px;
padding:10px 0px; 
box-shadow: 0px 0px 0px black;
border-bottom-left-radius: 0px;
border-bottom-right-radius: 0px;
-moz-border-radius-bottomleft: 0px; /* Firefox 3.6 and earlier */
-moz-border-radius-bottomright: 0px; /* Firefox 3.6 and earlier */
border-top-left-radius: 0px;
border-top-right-radius: 0px;
-moz-border-radius-topleft: 0px; /* Firefox 3.6 and earlier */
-moz-border-radius-topright: 0px; /* Firefox 3.6 and earlier */
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

<%
 ShowFemaleAlpacasForSale = False
  ShowMaleAlpacasForSale = False
ShowNonBreedingAlpacasForSale = False
  ShowStud = False
  ShowArticles = False
  ShowFoundationHerd = False
  ShowAboutUs = False
  ShowContactUs = False
  ShowLinks = False
  ShowStore = False
  ShowGallery = False
  Showservices = False
  ShowBlog = False
ShowCompleteHerd= False
 ShowComingAttractions= False
 
 
 sql2 = "select ShowPage from Pagelayout where  ShowPage = True and PageName='Articles'"

acounter = 1
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3 
if Not rs2.eof then 
ShowArticles = True
 end if
 
 rs2.close
 
  
  
 sql2 = "select ShowPage from Pagelayout where  ShowPage = True and FileName='Blog.asp'"

acounter = 1
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3 
if Not rs2.eof then 
ShowBlog = True
 end if
 
 rs2.close
  
  sql2 = "select ShowPage from Pagelayout where  ShowPage = True and FileName='ProductsStore.asp'"

acounter = 1
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3 
if Not rs2.eof then 
ShowStore = True
 end if
 
 rs2.close  
 
 sql2 = "select ShowPage from Pagelayout where  ShowPage = True and FileName='AlpacaSale.asp'"
acounter = 1
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3 
if Not rs2.eof then 
ShowAlpacasForSale = True
 end if
 
 sql2 = "select ShowPage from Pagelayout where  ShowPage = True and FileName='Males.asp'"
acounter = 1
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3 
if Not rs2.eof then 
ShowMaleAlpacasForSale = True
end if
 
sql2 = "select ShowPage from Pagelayout where  ShowPage = True and FileName='NonBreeding.asp'"
acounter = 1
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3 
if Not rs2.eof then 
ShowNonBreedingAlpacasForSale = True
end if
sql2 = "select ShowPage from Pagelayout where  ShowPage = True and FileName='CompleteHerd.asp'"
acounter = 1
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3 
if Not rs2.eof then 
ShowCompleteherd = True
end if
sql2 = "select ShowPage from Pagelayout where  ShowPage = True and FileName='ComingAttractions.asp'"
acounter = 1
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3 
if Not rs2.eof then 
ShowComingAttractions= True
end if
rs2.close
sql2 = "select ShowPage from Pagelayout where  ShowPage = True and FileName='Studs.asp'"
acounter = 1
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3 
if Not rs2.eof then
ShowStud = True
end if
rs2.close
sql2 = "select ShowPage from Pagelayout where  ShowPage = True and FileName='FoundationHerd.asp'"
acounter = 1
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3 
if Not rs2.eof then
ShowFoundationHerd = True
end if
sql2 = "select ShowPage from Pagelayout where  ShowPage = True and FileName='AboutUs.asp'"
acounter = 1
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3 
if Not rs2.eof then 
ShowAboutUs = True
end if
sql2 = "select ShowPage from Pagelayout where  ShowPage = True and FileName='ContactUs.asp'"
acounter = 1
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3 
if Not rs2.eof then 
ShowContactUs = True
end if
sql2 = "select ShowPage from Pagelayout where  ShowPage = True and FileName='Links.asp'"
acounter = 1
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3 
if Not rs2.eof then 
ShowLinks= True
end if
sql2 = "select ShowPage from Pagelayout where  ShowPage = True and FileName='Services.asp'"
acounter = 1
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3 
if Not rs2.eof then 
ShowServices= True
end if
sql2 = "select ShowPage from Pagelayout where  ShowPage = True and FileName='Testimonials.asp'"
acounter = 1
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3 
if Not rs2.eof then 
ShowTestimonials= True
end if
sql2 = "select ShowPage from Pagelayout where  ShowPage = True and FileName='GalleryHome.asp'"
acounter = 1
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3 
if Not rs2.eof then 
ShowGallery= True
end if
pagewidth = "980"
textwidth = "950"
layoutstylefound = False
if LayoutStyle = "Portrait1" then 
pagewidth = "780"
textwidth = "750"
%>
<table  width="980" border="0" bordercolor="black" cellpadding=0 cellspacing=0  align = "<%=PageAlign%>"  align="center"><tr>
<td align="center" valign="top" width = "980">
<table width="980" border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" class="HeaderImage"><tr><td colspan = "2" align = "center" valign = "abstop" class="HeaderImage" bgcolor = "<%=pageBackgroundColor%>"><% if len(Header) > 1 then%><img src = "" width="980" border = "0" class="HeaderImage" align = "abstop"  id="menu"><% else if len(Logo) > 1 then %><center><img src = "<%=Logo%>" width="100" border = "0" align= "center"></center><% else %><center><font size = "6"><%=Businessname %></font></center><% end if %><% end if %></td>
</tr>
<tr >
<td bgcolor = "<%=pageBackgroundColor%>" width = "160" valign="top">
<table width = "160" align = "left" border="0" cellspacing="0" cellpadding="0"  id="menu">
<tr><td class = "Menu" colspan="2">
<a href = "Default.asp" class = "Menu" >Home</a><br />
</td></tr>
<% if  ShowAlpacasForSale = True then %>
<tr><td colspan="2">
<a href = "AlpacaSale.asp" class = "Menu">Alpacas For Sale</b></a>
</td></tr>
<tr><td><img src = "images/px.gif" width = "9" alt="Female Alpacas for Sale" /></td>
<td><a href = "AlpacaSale.asp#Females" class = "Menu">Females</a></td></tr>
<tr><td><img src = "images/px.gif" width = "9" alt="Female Alpacas for Sale" /></td>
<td><a href = "AlpacaSale.asp#Males" class = "Menu" >Males</a>
</td></tr>
<tr><td><img src = "images/px.gif" width = "9" alt="Female Alpacas for Sale" /></td>
<td><a href = "AlpacaSale.asp#NonBreeding" >Non-Breeding</a></td></tr>
<% end if 
if ShowStud = True then %>
<tr><td colspan="2">
<a href = "Studs.asp" >Stud Services</a></td>
</tr>
<% end if  %>
<% if ShowFoundationHerd = True then %>
<tr><td colspan="2">
<a href = "Foundation.asp" > Foundation Herd</a></td>
</tr>
<% end if %>
<% if ShowCompleteHerd = True then %>
<tr><td colspan="2"><a href = "CompleteHerd.asp" >Complete Herd</a></td>
</tr>
<% end if %>

<% ShowGallery= False
 If ShowGallery=True Then %>
<tr><td colspan="2"><a href = 'Gallery.asp'>Photo Gallery</a></td></tr>
<% End If %>
<% if ShowAboutUs = False and  ShowContactUs = False and  ShowLinks = False then 
else %>
<tr><td colspan="2"><a href = 'Aboutus.asp'>About Us</a><br /></td></tr>
<% end if  %>
</ul>
</td>
</tr>
<tr><td colspan="2" height = "10"></td></tr>
</table>
<br /> <br />  <br /> 
</td>
<td background = "<%=PageBackgroundImage %>" bgcolor = "<%=PageBackgroundColor %>" width = "820">
<% layoutstylefound = True 
end if %>
<% if LayoutStyle = "Portrait2" then %>
<table  width="980" border="<%=PageBorder%>" bordercolor="<%=PageBordercolor%>" cellpadding=0 cellspacing=0  align = "<%=PageAlign%>" bgcolor = "<%=MenuBackgroundColor%>" align="center">
<tr>
<td align="center" valign="top" width = "<%=screenwidth %>">
<table  width="<%=screenwidth %>"  cellpadding=0 cellspacing=0  bgcolor = "<%=MenuBackgroundColor%>" align="left"  background = "<%=MenuBackgroundImage%>">
<tr>
<td align="center" valign="top" width = "150" >
<% if len(Logo) > 1 then %><img src = "<%=Logo%>" height="150" border = "0">
<% end if %>
<br><br>
</td>
<td class = "body" valign = "top" width = "830" bgcolor = "<%=PageBackgroundColor%>" background = "<%=PageBackgroundImage%>">
<% if len(Header) > 1 then%><img src = "<%=Header%>" width="830" border = "0" ><br><% end if %>
<% layoutstylefound = True 
end if %>
<% if LayoutStyle = "Landscape" and layoutstylefound = False then %>
<table  width="<%=screenwidth %>" border="0" bordercolor="black" cellpadding=0 cellspacing=0  align = "<%=PageAlign%>"  align="center"><tr>
<td align="center" valign="top" width = "<%=screenwidth %>">
<table width="<%=screenwidth %>" border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" ><tr><td class = "body2" align = "right"><a href = "/default.asp" class = "Menu">Home</a>&nbsp;&nbsp;
<a href = "/RanchTour/default.asp" class = "Menu">Ranch Tour</a>&nbsp;&nbsp;<a href = "/links.asp" class = "Menu">Links</a>&nbsp;&nbsp;<a href = "/contactus.asp" class = "Menu">Contact Us</a>&nbsp;&nbsp;(541) 821-8071&nbsp;&nbsp; </td><td width = "90"><img src = "/images/Visamastercard.png" width = "83" height = "26" /></td></tr></table>
<table width="<%=screenwidth %>" border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" class="HeaderImage">
<tr><td colspan = "2" align = "center" valign = "absbottom" class="HeaderImage"><% if len(Header) > 1 then%><img src = "<%=Header%>" width="<%=screenwidth %>" border = "0" class="HeaderImage" align = "absbottom" ><% else if len(Logo) > 1 then %><center><img src = "<%=Logo%>" height="150" border = "0" align= "center"></center><% else %><center><font size = "6"><%=Businessname %></font></center><% end if %><% end if %></td></tr>
<tr ><td colspan = "2" background = "<%=PageBackgroundImage %>" bgcolor = "<%=PageBackgroundColor %>"><table width = "<%=screenwidth %>" align = "center" border="0" cellspacing="0" cellpadding="0" ><tr><td colspan = "2">
<ul id="menu">
<li><a href = "/Default.asp"  >Home</a></li>
<% Set rsg = Server.CreateObject("ADODB.Recordset")
sqlg = "select  * from PageGroups where Pagegroupshow = True and not (PagegroupID = 2)  order by PageGroupOrder " 
rsg.Open sqlg, conn, 3, 3
If not rsg.eof then
PageGroups = True 

while not rsg.eof 
pagefound = false

if rsg("PageGroupid") = 1 then 
pagefound = True %>
<li><a href ="#"><%=Rsg("pageGrouptitle") %></a>
<ul>
<% Set rsg2 = Server.CreateObject("ADODB.Recordset")
sqlg2 = "select  * from Pagelayout where ShowPage = true and pagegroupid= " & rsg("PageGroupID") & " order by LinkOrder"
rsg2.Open sqlg2, conn, 3, 3

If not rsg2.eof then %>
<% while not rsg2.eof %>
<li ><a href = "<%=rsg2("Filename") %>" ><%=rsg2("LinkName") %></a></li>
<% rsg2.movenext
 wend
 end if 
  rsg2.close %>
</ul>
<% End If 


 if rsg("PageGroupid") = 9 then 
pagefound = True %>
<li ><a href = '#' >Products for Sale</a>
<ul>
<% 
sql2 = "SELECT distinct CatID, catname FROM SFCategories, productCategoriesList, sfProducts where catID = productCategoriesList.prodCategoryId and sfproducts.prodID = productcategoriesList.ProductID and prodForSale = True order by catname"
acounter = 1
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3 
While Not rs2.eof %>
<li ><a href = "/products/store.asp?CatID=<%=rs2("CatID")%>"  ><%=rs2("CatName")%></a>
</li>
<% 
rs2.movenext
Wend %>
</ul>
<% End If %>

<%
 if rsg("PageGroupid") = 10 then  
pagefound = True 
Set rsg2 = Server.CreateObject("ADODB.Recordset")
sqlg2 = "select  * from Pagelayout where ShowPage = true and pagegroupid= " & rsg("PageGroupID")
rsg2.Open sqlg2, conn, 3, 3

%>
<li><a href ="#">Special Offers</a>
<ul>
<% 
If not rsg2.eof then %>
<% while not rsg2.eof %>
<li ><a href = "<%=rsg2("Filename") %>" ><%=rsg2("LinkName") %></a></li>
<% rsg2.movenext
 wend
 end if 
  rsg2.close%>
    



<% if showarticles = True then %>
<li><a href ="#">Articles</a>
<ul>
<% sql2 = "SELECT distinct Articlecategories.ArticleCategoryName, Articlecategories.ArticleCATID FROM Articlecategories, articles where Articlecategories.articleCatID =  articles.ArticleCatID  "	
acounter = 1
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3 
While Not rs2.eof %>
<li ><a href = "/Articles.asp?ArticleCATID=<%=rs2("ArticleCATID")%>"  ><%=rs2("ArticleCategoryName")%></a></li>
<%rs2.movenext
Wend %></ul>
</li>
<% end if %>
</ul>
<% End If %>


<% if rsg("PageGroupid") = 20 then  
pagefound = True %>
<li><a href =="#"><%=Rsg("pageGrouptitle") %></a>
<ul>
<% sql2 = "SELECT * FROM GalleryCategories where GalleryCategoryShow = True "	
acounter = 1
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3 
While Not rs2.eof %>
<li ><a href = "/Gallery.asp?GCATID=<%=rs2("GalleryCatID")%>"  ><%=rs2("GalleryCategoryName")%></a></li>
<% rs2.movenext
Wend %></ul><br />
<% End If %>

  <%
 if rsg("PageGroupid") = 11 then  
pagefound = True 
Set rsg2 = Server.CreateObject("ADODB.Recordset")
sqlg2 = "select  * from Pagelayout where ShowPage = true and pagegroupid= " & rsg("PageGroupID")
rsg2.Open sqlg2, conn, 3, 3

%>
<li><a href =="#">News</a>
<ul>
<% 
If not rsg2.eof then %>
<% while not rsg2.eof %>
<li><a href = "<%=rsg2("Filename") %>" class = "body"><%=rsg2("LinkName") %></a></li>
<% rsg2.movenext
 wend
 end if 
  rsg2.close%>
</ul>
    <% End If %>



<% if rsg("PageGroupid") = 19 then  
pagefound = True %>
<li><a href =="#"><%=Rsg("pageGrouptitle") %></a>
<ul>
<li ><a href = "/Blog.asp?" >Blog Home Page</a>
</li>
<% 
sql2 = "SELECT * FROM Blog order by BlogID Desc "	
acounter = 1
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3 
While Not rs2.eof 
BlogHeadline = left(rs2("BlogHeadline"), 22)
str1 = BlogHeadline
str2 = "''"
If InStr(str1,str2) > 0 Then
BlogHeadline= Replace(str1, str2 , "'")
End If %>
<li ><a href = "/BlogDetails.asp?BlogID=<%=rs2("BlogID")%>"  ><%=BlogHeadline%>...</a></li>
<% rs2.movenext
Wend %>
</ul>
<% End If %>

<%
Set rsg2 = Server.CreateObject("ADODB.Recordset")
sqlg2 = "select  * from Pagelayout where ShowPage = true and pagegroupid= " & rsg("PageGroupID") & " order by LinkOrder"
rsg2.Open sqlg2, conn, 3, 3

 if not (Rsg("pageGrouptitle") ="Top Level (no dropdown)") and pagefound = false then%>
<li><a href ="#"><%=Rsg("pageGrouptitle") %></a>
<% 
If not rsg2.eof then %>
<ul>
<% while not rsg2.eof %>
<li ><a href = "<%=rsg2("Filename") %>" ><%=rsg2("LinkName") %></a></li>
<% rsg2.movenext
 wend
 %>
 </ul></li>
<%
 end if 
  rsg2.close%>

<% end if
 rsg.movenext
wend %>
<%
end if
rsg.close
%>
</ul>
</td></tr>
<%  if len(Current) > 0 then %>
<tr><td width = "150" align = "left" valign = "top"><br />

<table border = "0" cellpadding =0 cellspacing = 0 width = "150" align = 'center'>
<tr><td width = "7"></td>
<td  width = "143" class = "body">
<%
 Set rsg = Server.CreateObject("ADODB.Recordset")
sqlg = "select  * from PageGroups where Pagegroupshow = True and not (PagegroupID = 2)  order by PageGroupOrder " 
rsg.Open sqlg, conn, 3, 3
If not rsg.eof then
PageGroups = True 

while not rsg.eof 
pagefound = false

 

if rsg("PageGroupid") = 1 and Current = "Alpacas" then 
pagefound = True %>
<b>Alpaca Sales</b><br />
<% Set rsg2 = Server.CreateObject("ADODB.Recordset")
sqlg2 = "select  * from Pagelayout where ShowPage = true and pagegroupid= " & rsg("PageGroupID") & " order by LinkOrder"
rsg2.Open sqlg2, conn, 3, 3

If not rsg2.eof then %>
<% while not rsg2.eof %>
<a href = "<%=rsg2("Filename") %>" class = "body"><%=rsg2("LinkName") %></a><br />
<% rsg2.movenext
 wend
 end if 
  rsg2.close %>
<% End If 

 if rsg("PageGroupid") = 9 and Current = "Products" then 
pagefound = True %>
<a href ="/StoreHome.asp" class = "Body">Products for Sale</a><br>
<% 
sql2 = "SELECT distinct CatID, catname FROM SFCategories, productCategoriesList, sfProducts where catID = productCategoriesList.prodCategoryId and sfproducts.prodID = productcategoriesList.ProductID and prodForSale = True order by catname"
acounter = 1
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3 
While Not rs2.eof %>
<a href = "/products/store.asp?CatID=<%=rs2("CatID")%>"  class = "body"><%=rs2("CatName")%></a><br>
<% 
rs2.movenext
Wend %>

<% End If %>

<%
 if rsg("PageGroupid") = 10 and Current = "SpecialOffers" then  
pagefound = True 
Set rsg2 = Server.CreateObject("ADODB.Recordset")
sqlg2 = "select  * from Pagelayout where ShowPage = true and pagegroupid= " & rsg("PageGroupID")
rsg2.Open sqlg2, conn, 3, 3

%>
Special Offers<br>
<% 
If not rsg2.eof then %>
<% while not rsg2.eof %>
<a href = "<%=rsg2("Filename") %>" class = "body"><%=rsg2("LinkName") %></a><br>
<% rsg2.movenext
 wend
 end if 
  rsg2.close%>
  <% End If %>  

    <%
 if rsg("PageGroupid") = 11 and Current = "News" then  
pagefound = True 
Set rsg2 = Server.CreateObject("ADODB.Recordset")
sqlg2 = "select  * from Pagelayout where ShowPage = true and pagegroupid= " & rsg("PageGroupID")
rsg2.Open sqlg2, conn, 3, 3

%>
News<br>
<% 
If not rsg2.eof then %>
<% while not rsg2.eof %>
<a href = "<%=rsg2("Filename") %>" class = "body"><%=rsg2("LinkName") %></a><br>
<% rsg2.movenext
 wend
 end if 
  rsg2.close
  showcrias = false
  if showcraias = true then %>
  <a href = "/Crias.asp" class = "body"><%=Year(now)%> Crias</a><br>
    <% End If %>
    <% End If %>

<% if showarticles = True and Current = "Articles"  then %>
<a href ="#">Articles</a>
<% sql2 = "SELECT distinct Articlecategories.ArticleCategoryName, Articlecategories.ArticleCATID FROM Articlecategories, articles where Articlecategories.articleCatID =  articles.ArticleCatID  "	
acounter = 1
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3 
While Not rs2.eof %>
<a href = "/Articles.asp?ArticleCATID=<%=rs2("ArticleCATID")%>"  class = "body"><%=rs2("ArticleCategoryName")%></a>
<%rs2.movenext
Wend %>

<% end if %>




<% if rsg("PageGroupid") = 20 and Current = "Gallery" then  
pagefound = True %>
<%=Rsg("pageGrouptitle") %><br>
<% sql2 = "SELECT * FROM GalleryCategories where GalleryCategoryShow = True "	
acounter = 1
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3 
While Not rs2.eof %>
<a href = "/Gallery.asp?GCATID=<%=rs2("GalleryCatID")%>"  class = "body"><%=rs2("GalleryCategoryName")%></a><br>
<% rs2.movenext
Wend %><br />
<% End If %>
<%

 if rsg("PageGroupid") = 38 and Current = "Blog" then  
pagefound = True %>
<a href = "/Blog.asp?" >Blog Home Page</a><br>

<% 
sql2 = "SELECT * FROM Blog order by BlogID Desc "	
acounter = 1
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3 
While Not rs2.eof 
BlogHeadline = left(rs2("BlogHeadline"), 22)
str1 = BlogHeadline
str2 = "''"
If InStr(str1,str2) > 0 Then
BlogHeadline= Replace(str1, str2 , "'")
End If %>
<a href = "/BlogDetails.asp?BlogID=<%=rs2("BlogID")%>"  class = "body"><%=BlogHeadline%>...</a><br>
<% rs2.movenext
Wend
 end if %>
<%
Set rsg2 = Server.CreateObject("ADODB.Recordset")
sqlg2 = "select  * from Pagelayout where ShowPage = true and pagegroupid= " & rsg("PageGroupID") & " order by LinkOrder"
rsg2.Open sqlg2, conn, 3, 3

 if not (Rsg("pageGrouptitle") ="Top Level (no dropdown)") and pagefound = false and Current = Rsg("pageGrouptitle") then%>
<b><%=Rsg("pageGrouptitle") %></b><br />
<% 
If not rsg2.eof then %>
<% while not rsg2.eof %>
<a href = "<%=rsg2("Filename") %>" class = "body"><%=rsg2("LinkName") %></a><br>
<% rsg2.movenext
 wend
 %>

<%
 end if 
  rsg2.close
  end if

 rsg.movenext
wend %>
<%
end if
rsg.close
%>
</td></tr></table>
<% 
screenwidth  = screenwidth -150 
end if  
textwidth  = screenwidth -12
%>
<td width = "<%=screenwidth %>" valign = "top">
<% end if %>

<script>
    (function (i, s, o, g, r, a, m) {
        i['GoogleAnalyticsObject'] = r; i[r] = i[r] || function () {
            (i[r].q = i[r].q || []).push(arguments)
        }, i[r].l = 1 * new Date(); a = s.createElement(o),
  m = s.getElementsByTagName(o)[0]; a.async = 1; a.src = g; m.parentNode.insertBefore(a, m)
    })(window, document, 'script', '//www.google-analytics.com/analytics.js', 'ga');

    ga('create', 'UA-55968005-1', 'auto');
    ga('send', 'pageview');

</script>