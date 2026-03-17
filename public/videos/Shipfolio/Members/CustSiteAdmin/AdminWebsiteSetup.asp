<!doctype html>
<%@ Language=VBScript %>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<HEAD>
<% Page = "Editwebsite"  %>
<link rel="stylesheet" type="text/css" href="/administration/style.css">
<!--#Include file="AdminSecurityInclude.asp"--> 
<!--#Include file="AdminGlobalVariables.asp"--> 
</HEAD>
<% if mobiledevice = True or is_iPad = true then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
<% end if %>
<!--#Include file="AdminHeader.asp"-->

<% 
sql = "select * from SiteDesign where PeopleID = 667" 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof	 then
MenuDropdowns = rs("MenuDropdowns")
AddPages = rs("AddPages")
MultipleHeaders = rs("MultipleHeaders")
ShowLOA = rs("ShowLOA")
end if
rs.close


 sql = "select * from SpeciesAvailable where SpeciesAvailableonSite = True Order by SpeciesPriority "
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof	 then
Species1ID = rs("SpeciesID")
PreferedSpecies1ID= rs("PreferedSpeciesID")
rs.movenext
else
Species1ID =""
PreferedSpecies1ID= ""
end if


if not rs.eof	 then
Species2ID = rs("SpeciesID")
PreferedSpecies2ID= rs("PreferedSpeciesID")
rs.movenext
else
Species2ID =""
PreferedSpecies2ID = ""
end if

if not rs.eof	 then
Species3ID = rs("SpeciesID")
PreferedSpecies3ID= rs("PreferedSpeciesID")
rs.movenext
else
Species3ID =""
PreferedSpecies3ID = ""
end if

if not rs.eof	 then
Species4ID = rs("SpeciesID")
PreferedSpecies4ID= rs("PreferedSpeciesID")
rs.movenext
else
Species4ID =""
PreferedSpecies4ID = ""
end if

if not rs.eof	 then
Species5ID = rs("SpeciesID")
PreferedSpecies5ID= rs("PreferedSpeciesID")
rs.movenext
else
Species5ID =""
PreferedSpecies5ID = ""
end if

if not rs.eof then
Species6ID = rs("SpeciesID")
PreferedSpecies6ID= rs("PreferedSpeciesID")
rs.movenext
else
Species6ID =""
PreferedSpecies6ID = ""
end if

if not rs.eof	 then
Species7ID = rs("SpeciesID")
PreferedSpecies7ID= rs("PreferedSpeciesID")
rs.movenext
else
Species7ID =""
PreferedSpecies7ID = ""
end if

if not rs.eof	 then
Species8ID = rs("SpeciesID")
PreferedSpecies8ID= rs("PreferedSpeciesID")
rs.movenext
else
Species8ID =""
PreferedSpecies8ID = ""
end if

if not rs.eof	 then
Species9ID = rs("SpeciesID")
PreferedSpecies9ID= rs("PreferedSpeciesID")
rs.movenext
else
Species9ID =""
PreferedSpecies9ID = ""
end if

if not rs.eof	 then
Species10ID = rs("SpeciesID")
PreferedSpecies10ID= rs("PreferedSpeciesID")
rs.movenext
else
Species10ID =""
PreferedSpecies10ID = ""
end if

if not rs.eof	 then
Species11ID = rs("SpeciesID")
PreferedSpecies11ID= rs("PreferedSpeciesID")
rs.movenext
else
Species11ID =""
PreferedSpecies11ID = ""
end if


if not rs.eof	 then
Species12ID = rs("SpeciesID")
PreferedSpecies12ID= rs("PreferedSpeciesID")
rs.movenext
else
Species12ID =""
PreferedSpecies12ID = ""
end if

if not rs.eof	 then
Species13ID = rs("SpeciesID")
PreferedSpecies13ID= rs("PreferedSpeciesID")
rs.movenext
else
Species13ID =""
PreferedSpecies13ID = ""
end if
if not rs.eof	 then
Species14ID = rs("SpeciesID")
PreferedSpecies14ID= rs("PreferedSpeciesID")
rs.movenext
else
Species14ID =""
PreferedSpecies14ID = ""
end if

rs.close %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth %>"><tr><td class = "roundedtop" align = "left">
<H1><div align = "left">Website Setup</div></H1>
</td></tr>
<tr><td class = "roundedBottom" align = "center" width = "<%=screenwidth %>">
<table cellpadding = "0" cellspacing = "0" border = "0">
<tr><td class = "body " >
<form  name=form method="post" action="AdminWebsiteSetupHandle.asp">
<table width = "<%=screenwidth %>" cellpadding = "0" cellspacing = "0" border = "0" align = "left" class = "roundedtopandbottom">
<tr>
<td class = "body2" align = "right" height = "25">
<b>Type of Website:</b>
</td>
<td class = "body2" align = "left" colspan = "3" >
<table cellpadding = "0" cellspacing = "0" border = "0">
<tr><td class = "body">

<%

sql = "select * from WebsiteType where WebsiteType= 'Livestock' and active=True"
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof	 then 
ShowLivestock = True %>
<input type="checkbox" name="WebsiteType" value="Livestock" checked>Livestock&nbsp;
<% else %>
<input type="checkbox" name="WebsiteType" value="Livestock" >Livestock&nbsp;
<% end if %>
</td>
<td class = "body">
<% sql = "select * from WebsiteType where WebsiteType= 'ECommerce' and active=True"
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof	 then %>
<input type="checkbox" name="WebsiteType" value="ECommerce" checked >ECommerce&nbsp;
<% else %>
<input type="checkbox" name="WebsiteType" value="ECommerce">ECommerce&nbsp;
<% end if %>
</td>
<td class = "body">
<% sql = "select * from WebsiteType where WebsiteType= 'Services' and active=True"
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof	 then %>
<input type="checkbox" name="WebsiteType" value="Services" checked >Services&nbsp;
<% else %>
<input type="checkbox" name="WebsiteType" value="Services" >Services&nbsp;
<% end if %>
</td>
<td class = "body">
<% sql = "select * from WebsiteType where WebsiteType= 'Artwork' and active=True"
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof	 then %>
<input type="checkbox" name="WebsiteType" value="Artwork" checked >Artwork&nbsp;
<% else %>
<input type="checkbox" name="WebsiteType" value="Artwork" >Artwork&nbsp;
<% end if %>
</td>
<td class = "body">
<% sql = "select * from WebsiteType where WebsiteType= 'LivestockAssociation' and active=True"
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof	 then %>
<input type="checkbox" name="WebsiteType" value="LivestockAssociation" checked >Livestock Association&nbsp;
<% else %>
<input type="checkbox" name="WebsiteType" value="LivestockAssociation" >Livestock Association&nbsp;
<% end if %>
</td>
</tr>
</table>
</td>
</tr>


<tr>
<td class = "body2" align = "right" width = "200" height = "25" >
<b>Home Page Design Aspects:</b>
</td>
<td class = "body2" align = "left" colspan = "3">
<table cellpadding = "0" cellspacing = "0" border = "0">
<tr><td class = "body" >

<% sql = "select * from LayoutHomePage where HomePageDesignAspect= 'SlideShow' and HomePageDesignAspectAvailable=True"
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof	 then
Slideshow = True 
SlideshowDimensions = rs("HomePageDesignAspectTitle")%>
<input type="checkbox" name="HomePageDesignAspect" value="SlideShow" checked >Slide Show&nbsp;
<% else %>
<input type="checkbox" name="HomePageDesignAspect" value="SlideShow" >Slide Show&nbsp;
<% end if %>
</td>
<td class = "body" colspan = "2" >

<% sql = "select * from LayoutHomePage where HomePageDesignAspect= 'SlideShow2' and HomePageDesignAspectAvailable=True"
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof	 then
Slideshow2 = True %>
<input type="checkbox" name="HomePageDesignAspect" value="SlideShow2" checked >Small Slide Show&nbsp;
<% else %>
<input type="checkbox" name="HomePageDesignAspect" value="SlideShow2" >Small Slide Show&nbsp;
<% end if %>
(choose 1)
</td>
<td colspan = "3" class = "body" align = "left"></td>
</tr>
<tr>
<td class = "body">
<% sql = "select * from LayoutHomePage where HomePageDesignAspect= 'FeaturedNews' and HomePageDesignAspectAvailable=True"
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof	 then %>
<input type="checkbox" name="HomePageDesignAspect" value="FeaturedNews" checked >Featured News&nbsp;
<% else %>
<input type="checkbox" name="HomePageDesignAspect" value="FeaturedNews" >Featured News&nbsp;
<% end if %>
</td>
<td class = "body">
<% sql = "select * from LayoutHomePage where HomePageDesignAspect= 'FeaturedAnimal' and HomePageDesignAspectAvailable=True"
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof	 then %>
<input type="checkbox" name="HomePageDesignAspect" value="FeaturedAnimal" checked>Featured Animal&nbsp;
<% else %>
<input type="checkbox" name="HomePageDesignAspect" value="FeaturedAnimal" >Featured Animal&nbsp;
<% end if %>
</td>
<td class = "body">
<% sql = "select * from LayoutHomePage where HomePageDesignAspect= 'FeaturedStud' and HomePageDesignAspectAvailable=True"
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof	 then %>
<input type="checkbox" name="HomePageDesignAspect" value="FeaturedStud" checked >Featured Stud&nbsp;
<% else %>
<input type="checkbox" name="HomePageDesignAspect" value="FeaturedStud" >Featured Stud&nbsp;
<% end if %>
</td>
<td class = "body">
<% sql = "select * from LayoutHomePage where HomePageDesignAspect= 'FeaturedProduct' and HomePageDesignAspectAvailable=True"
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof	 then %>
<input type="checkbox" name="HomePageDesignAspect" value="FeaturedProduct" checked >Featured Product&nbsp;
<% else %>
<input type="checkbox" name="HomePageDesignAspect" value="FeaturedProduct" >Featured Product&nbsp;
<% end if %>
</td>
<td class = "body">
<% sql = "select * from LayoutHomePage where HomePageDesignAspect= 'FeaturedVideo' and HomePageDesignAspectAvailable=True"
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof	 then %>
<input type="checkbox" name="HomePageDesignAspect" value="FeaturedVideo" checked >Featured Video&nbsp;
<% else %>
<input type="checkbox" name="HomePageDesignAspect" value="FeaturedVideo" >Featured Video&nbsp;
<% end if %>
</td>
<td class = "body">
<% sql = "select * from LayoutHomePage where HomePageDesignAspect= 'Textblocks' and HomePageDesignAspectAvailable=True"
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof	 then %>
<input type="checkbox" name="HomePageDesignAspect" value="Textblocks" checked >Text Blocks&nbsp;
<% else %>
<input type="checkbox" name="HomePageDesignAspect" value="Textblocks">Text Blocks&nbsp;
<% end if %>
</td>
<td class = "body">
<% sql = "select * from LayoutHomePage where HomePageDesignAspect= 'FeaturedEvent' and HomePageDesignAspectAvailable=True"
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof	 then %>
<input type="checkbox" name="HomePageDesignAspect" value="FeaturedEvent" checked >Featured Event&nbsp;
<% else %>
<input type="checkbox" name="HomePageDesignAspect" value="FeaturedEvent" >Featured Event&nbsp;
<% end if %>
</td></tr>
</table>
</td>
</tr>
<tr><td colspan = "5">
<table border = 0>
<% if Slideshow = True then %>

<tr>
<td class = "body2" height = "23" align = "right" width = "200"><b>Slideshow Dimensions: </b></td>
	 <td class = "body2" align = "left">
<input name="SlideshowDimensions"  size = "32" value = '<%=SlideshowDimensions%>' >
</td>
</tr>
<% end if %>
<tr>
<td class = "body2" height = "23" align = "right" ><b>Dropdown Menu?</b></td>
	 <td class = "body2" align = "left">
<% if len(MenuDropdowns) > 0 then%>
<% if MenuDropdowns = "Yes" Or MenuDropdowns = True Then %>
			On<input TYPE="RADIO" name="MenuDropdowns" Value = "Yes" checked >
			Off<input TYPE="RADIO" name="MenuDropdowns" Value = "No" >
		<% Else %>
			On<input TYPE="RADIO" name="MenuDropdowns" Value = "Yes" >
			Off<input TYPE="RADIO" name="MenuDropdowns" Value = "No" checked>
		<% End If %>

<% end if %>
</td>
</tr>
<tr>
<td class = "body2" height = "23" align = "right"><b>Ability to Add Pages?</b></td>
	 <td class = "body2" align = "left" >
<% if len(AddPages) > 0 then%>
<% if AddPages = "Yes" Or AddPages = True Then %>
On<input TYPE="RADIO" name="AddPages" Value = "Yes" checked >
Off<input TYPE="RADIO" name="AddPages" Value = "No" >
<% Else %>
On<input TYPE="RADIO" name="AddPages" Value = "Yes">
Off<input TYPE="RADIO" name="AddPages" Value = "No" checked >
<% End If %>

<% end if %>
</td>
</tr>
<tr>
<td class = "body2" height = "23" align = "right"><b>Muiltiple Headers?</b></td>
<td class = "body2" align = "left" >
<% if MultipleHeaders = "Yes" Or MultipleHeaders = True Then %>
On<input TYPE="RADIO" name="MultipleHeaders" Value = "Yes" checked >
Off<input TYPE="RADIO" name="MultipleHeaders" Value = "No" >
<% Else %>
On<input TYPE="RADIO" name="MultipleHeaders" Value = "Yes">
Off<input TYPE="RADIO" name="MultipleHeaders" Value = "No" checked >
<% End If %>
</td>
</tr>

<tr>
<td class = "body2" height = "23" align = "right"><b>Show LOA?</b></td>
<td class = "body2" align = "left" >
<% if ShowLOA = "Yes" Or ShowLOA = True Then %>
On<input TYPE="RADIO" name="ShowLOA" Value = "Yes" checked >
Off<input TYPE="RADIO" name="ShowLOA" Value = "No" >
<% Else %>
On<input TYPE="RADIO" name="ShowLOA" Value = "Yes">
Off<input TYPE="RADIO" name="ShowLOA" Value = "No" checked >
<% End If %>
</td>
</tr>

</table>
<tr>
<td align = "center" colspan = "2">
	<input type=submit value = "Update" class = "regsubmit2" >
</td></tr>
</td>
</tr>
</table>
</form>
</td>
</tr>
</table>
<form  name=form method="post" action="AdminWebsitespeciessetup.asp">
<%
'ShowLivestock = True
if ShowLivestock = True then  %>
<br />
<table class = "roundedtopandbottom" width = "100%">
<tr>
<td class = "body2" align = "right" height = "25">
<b>Types of Livestock:</b>
</td>
<td></td>
</tr>
<% 
 TempSpeciesNum = 1
 TempSpeciesIDName = "Species1ID"
 TempPreferedSpeciesID = PreferedSpecies1ID
if len(Species1ID) > 0 then
TempspeciesID=Species1ID
else
TempspeciesID = ""
end if %>
<!--#Include file="AdminWebsiteSetupspeciesInclude.asp"-->

<%' if len(Species2ID) > 0 then
 TempSpeciesNum = 2
TempPreferedSpeciesID = PreferedSpecies2ID
TempSpeciesIDName = "Species2ID"
if len(Species2ID) > 0 then
TempspeciesID=Species2ID
else
TempspeciesID = ""
end if

%>
<!--#Include file="AdminWebsiteSetupspeciesInclude.asp"-->
<% 'end if %>

<%' if len(Species3ID) > 0 then
 TempSpeciesNum = 3
TempPreferedSpeciesID = PreferedSpecies3ID
TempSpeciesIDName = "Species3ID"
if len(Species3ID) > 0 then
TempspeciesID=Species3ID
else
TempspeciesID = ""
end if
%>
<!--#Include file="AdminWebsiteSetupspeciesInclude.asp"-->
<% 'end if %>

<% 'if len(Species4ID) > 0 then
 TempSpeciesNum = 4
TempPreferedSpeciesID = PreferedSpecies4ID
TempSpeciesIDName = "Species4ID"
if len(Species4ID) > 0 then
TempspeciesID=Species4ID
else
TempspeciesID = ""
end if
%>
<!--#Include file="AdminWebsiteSetupspeciesInclude.asp"-->
<% 'end if %>

<% 'if len(Species5ID) > 0 then
 TempSpeciesNum = 5
TempPreferedSpeciesID = PreferedSpecies5ID
TempSpeciesIDName = "Species5ID"
if len(Species5ID) > 0 then
TempspeciesID=Species5ID
else
TempspeciesID = ""
end if
%>
<!--#Include file="AdminWebsiteSetupspeciesInclude.asp"-->
<% 'end if %>

<% 'if len(Species6ID) > 0 then
 TempSpeciesNum = 6
TempPreferedSpeciesID = PreferedSpecies6ID
TempSpeciesIDName = "Species6ID"
if len(Species6ID) > 0 then
TempspeciesID=Species6ID
else
TempspeciesID = ""
end if
%>
<!--#Include file="AdminWebsiteSetupspeciesInclude.asp"-->
<% 'end if %>

<% 'if len(Species7ID) > 0 then
 TempSpeciesNum = 7
TempPreferedSpeciesID = PreferedSpecies7ID
TempSpeciesIDName = "Species7ID"
if len(Species7ID) > 0 then
TempspeciesID=Species7ID
else
TempspeciesID = ""
end if
%>
<!--#Include file="AdminWebsiteSetupspeciesInclude.asp"-->
<% 'end if %>

<% 'if len(Species8ID) > 0 then
 TempSpeciesNum = 8
TempPreferedSpeciesID = PreferedSpecies8ID
TempSpeciesIDName = "Species8ID"
if len(Species8ID) > 0 then
TempspeciesID=Species8ID
else
TempspeciesID = ""
end if
%>
<!--#Include file="AdminWebsiteSetupspeciesInclude.asp"-->
<% 'end if %>

<% 'if len(Species9ID) > 0 then
 TempSpeciesNum = 9
TempPreferedSpeciesID = PreferedSpecies9ID
TempSpeciesIDName = "Species9ID"
if len(Species9ID) > 0 then
TempspeciesID=Species9ID
else
TempspeciesID = ""
end if
%>
<!--#Include file="AdminWebsiteSetupspeciesInclude.asp"-->
<% 'end if %>

<% 'if len(Species10ID) > 0 then
 TempSpeciesNum = 10
TempPreferedSpeciesID = PreferedSpecies10ID
TempSpeciesIDName = "Species10ID"
if len(Species10ID) > 0 then
TempspeciesID=Species10ID
else
TempspeciesID = ""
end if
%>
<!--#Include file="AdminWebsiteSetupspeciesInclude.asp"-->
<% 'end if %>

<% 'if len(Species11ID) > 0 then
 TempSpeciesNum = 11
TempPreferedSpeciesID = PreferedSpecies11ID
TempSpeciesIDName = "Species11ID"
if len(Species11ID) > 0 then
TempspeciesID=Species11ID
else
TempspeciesID = ""
end if
%>
<!--#Include file="AdminWebsiteSetupspeciesInclude.asp"-->
<% 'end if %>

<% 'if len(Species12ID) > 0 then
 TempSpeciesNum = 12
TempPreferedSpeciesID = PreferedSpecies12ID
TempSpeciesIDName = "Species12ID"
if len(Species12ID) > 0 then
TempspeciesID=Species12ID
else
TempspeciesID = ""
end if
%>
<!--#Include file="AdminWebsiteSetupspeciesInclude.asp"-->
<% 'end if %>

<% 'if len(Species13ID) > 0 then
 TempSpeciesNum = 13
TempPreferedSpeciesID = PreferedSpecies13ID
TempSpeciesIDName = "Species13ID"
if len(Species13ID) > 0 then
TempspeciesID=Species13ID
else
TempspeciesID = ""
end if
%>
<!--#Include file="AdminWebsiteSetupspeciesInclude.asp"-->
<% 'end if %>


<%
'if len(Species14ID) > 0 then 
TempSpeciesNum = 14
TempPreferedSpeciesID = PreferedSpecies14ID
TempSpeciesIDName = "Species14ID"
if len(Species14ID) > 0 then
TempspeciesID=Species14ID
else
TempspeciesID = ""
end if

%>
<!--#Include file="AdminWebsiteSetupspeciesInclude.asp"-->
<% 'end if %>

</table>

<% end if %>
</form>
<br />
<form  name=form method="post" action="AdminWebsiteSetupPagesHandle.asp">
<table class = "roundedtopandbottom" width = "<%=screenwidth - 35 %>">
 <tr>
  <td class = "body2" align = "right" valign = "top" height = "25">
 <b>Pages Available:</b>
 </td>
 <td colspan = "3" align = "left">  
	<table border = "0" bordercolor = "#CEBD99" width = "530" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "left">
	<tr ">
	<td class = "body" align = "center" height = "23"><b>Title</b></td>
	<td class = "body"  width = "100" align = "center"><b>Display Page</b></td>
		<td class = "body"  width = "100" align = "center"><b>Page Available</b></td>
	</tr>

		
<% 
order = "odd"	
sql2 = "select * from Pagelayout order by pagename"	

	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	While Not rs2.eof 
	 PageFound = False
		ShowPage = rs2("ShowPage")
		PageAvailable = rs2("PageAvailable")
		
	 if order = "even" then
	  	order = "odd" %>
	  	<tr bgcolor = "#e6e6e6">
	  	
	 <% else
	order = "even" %>
	 	<tr bgcolor = "White"> 
	<% end if 
	 
	 
 if rs2("PageName") ="Photo Galleries" then
	 PageFound = True	%> 
  <td class = "body" height = "23">&nbsp;Photo Galleries</td>
	 <td class = "body2" align = "center">
<% if ShowPage  = True then %>
 <input type="checkbox" name="ShowPages" value="<%=rs2("PageName") %>" checked">Yes
<% else %>
 <input type="checkbox" name="ShowPages" value="<%=rs2("PageName") %>" >No
<% end if %>
</td>
	 <td class = "body" align = "center"></td>
	 </tr>
	  <% if order = "even" then %>
	  		<tr bgcolor = "white">
	 <% else %>
		<tr bgcolor = "#efefef">
	<% end if  %>
	<td colspan = "3" align = "center">
	 	<% if PageAvailable  = True then %>
 <input type="checkbox" name="PageAvailable" value="<%=rs2("PageName") %>" checked >Yes
<% else %>
 <input type="checkbox" name="PageAvailable" value="<%=rs2("PageName") %>" >No
<% end if %>
			  
	</td>
	 </tr>
<% end if %>
	 

<% if rs2("PageName") ="Farm Store (Header)" then
	 PageFound = True	%> 
  <td class = "body" height = "23">&nbsp;Farm Store</td>
	 <td class = "body2" align = "center">
<% if ShowPage  = True then %>
 <input type="checkbox" name="ShowPages" value="<%=rs2("PageName") %>" checked >Yes
<% else %>
 <input type="checkbox" name="ShowPages" value="<%=rs2("PageName") %>" >No
<% end if %>
</td>
	 <td class = "body" align = "center"></td>
	 </tr>
	  <% if order = "even" then %>
	  		<tr bgcolor = "white">
	 <% else %>
		<tr bgcolor = "#efefef">
	<% end if  %>
	<td colspan = "3" align = "center">
	 	<% if PageAvailable  = True then %>
 <input type="checkbox" name="PageAvailable" value="<%=rs2("PageName") %>" checked >Yes
<% else %>
 <input type="checkbox" name="PageAvailable" value="<%=rs2("PageName") %>" >No
<% end if %>
 </td></tr>
	 <% end if %>
	<% if  PageFound = False then %>
<td class = "body" height = "23" width = "300">&nbsp;&nbsp;<a href = "<%=rs2("EditLink")%>" class= "body" ><%=rs2("LinkName")%></a></td>
	 <td class = "body2" align = "center" ><% if rs2("PageName") ="Home Page" then %>
  Always
 <% else %>
<% if ShowPage  = True then %>
 <input type="checkbox" name="ShowPages" value="<%=rs2("PageName") %>" checked >Yes
<% else %>
 <input type="checkbox" name="ShowPages" value="<%=rs2("PageName") %>"  >No
<% end if %>
<% end if %></td>
	 <td class = "body2" align = "center">
	 	<% if PageAvailable  = True then %>
 <input type="checkbox" name="PageAvailable" value="<%=rs2("PageName") %>" checked >Yes
<% else %>
 <input type="checkbox" name="PageAvailable" value="<%=rs2("PageName") %>" >No
<% end if %>
	 </td>
	 </tr>
 <%
 end if  
	rs2.movenext
 Wend %>

</table>
<br />
<tr>
<td align = "center" colspan = "2">
	<input type=submit value = "Update" class = "regsubmit2" ></form>
</td>
</tr>
</table>
</td>
</tr>
</table>




<br />
<form  name=form method="post" action="AdminWebsiteSetupPageGroupsHandle.asp">
<table class = "roundedtopandbottom" width = "<%=screenwidth - 35 %>">
 <tr>
  <td class = "body2" align = "right" valign = "top" height = "25">
 <b>Pages Groups Available:</b>
 </td>
 <td colspan = "3" align = "left">  
	<table border = "0" bordercolor = "#CEBD99" width = "530" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "left">
	<tr ">
	<td class = "body" align = "center" height = "23"><b>Title</b></td>
	<td class = "body"  width = "100" align = "center"><b>Display Page</b></td>
		<td class = "body"  width = "100" align = "center"><b>Group Available</b></td>
	</tr>

		
<% 
order = "odd"	
sql2 = "select * from Pagegroups order by PageGroupOrder"	

	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	While Not rs2.eof 
	 PageFound = False
		PageGroupShow = rs2("PageGroupShow")
		PageGroupAvailable = rs2("PageGroupAvailable")
		
	 if order = "even" then
	  	order = "odd" %>
	  	<tr bgcolor = "#e6e6e6">
	  	
	 <% else
	order = "even" %>
	 	<tr bgcolor = "White"> 
	<% end if 
	 
	 
if rs2("PageGrouptitle") ="Farm Store (Header)" then
	 PageFound = True	%> 
  <td class = "body" height = "23">&nbsp;Farm Store</td>
	 <td class = "body2" align = "center">
<% if ShowPage  = True then %>
 <input type="checkbox" name="PageGroupShow" value="<%=rs2("PageGrouptitle") %>" checked >Yes
<% else %>
 <input type="checkbox" name="PageGroupShow " value="<%=rs2("PageGrouptitle") %>" >No
<% end if %>
</td>
	 <td class = "body" align = "center"></td>
	 </tr>
	  <% if order = "even" then %>
	  		<tr bgcolor = "white">
	 <% else %>
		<tr bgcolor = "#efefef">
	<% end if  %>
	<td colspan = "3" align = "center">
	 	<% if PageGroupAvailable  = True then %>
 <input type="checkbox" name="PageGroupAvailable" value="<%=rs2("PageGrouptitle") %>" checked >Yes
<% else %>
 <input type="checkbox" name="PageGroupAvailable" value="<%=rs2("PageGrouptitle") %>" >No
<% end if %>
 </td></tr>
	 <% end if %>
	<% if  PageFound = False then %>
<td class = "body" height = "23" width = "300">&nbsp;&nbsp;<%=rs2("PageGrouptitle")%></td>
	 <td class = "body2" align = "center" ><% if rs2("PageGrouptitle") ="Home Page" then %>
  Always
 <% else %>
<% if PageGroupShow  = True then %>
 <input type="checkbox" name="PageGroupShow" value="<%=rs2("PageGrouptitle") %>" checked >Yes
<% else %>
 <input type="checkbox" name="PageGroupShow" value="<%=rs2("PageGrouptitle") %>"  >No
<% end if %>
<% end if %></td>
	 <td class = "body2" align = "center">
	 	<% if PageGroupAvailable  = True then %>
 <input type="checkbox" name="PageGroupAvailable" value="<%=rs2("PageGrouptitle") %>" checked >Yes
<% else %>
 <input type="checkbox" name="PageGroupAvailable" value="<%=rs2("PageGrouptitle") %>" >No
<% end if %>
	 </td>
	 </tr>
 <%
 end if  
	rs2.movenext
 Wend %>

</table>
<br />
<tr>
<td align = "center" colspan = "2">
	<input type=submit value = "Update" class = "regsubmit2" ></form>
</td>
</tr>
</table>
<br>	
<!-- #include file="AdminFooter.asp" -->
 </Body>
</HTML>
