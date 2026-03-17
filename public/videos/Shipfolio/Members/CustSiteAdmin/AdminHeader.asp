<% Current = "Dashboard" 
Set rs = Server.CreateObject("ADODB.Recordset")
Set rs2 = Server.CreateObject("ADODB.Recordset")
Set rs3 = Server.CreateObject("ADODB.Recordset")

sql = "select * from LayoutHomePage where HomePageDesignAspect= 'Slideshow' and HomePageDesignAspectAvailable=True"
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
if not rs.eof	 then 
SlideshowAvailable = True
 else 
SlideshowAvailable = False
end if 
 
sql = "select * from WebsiteType where WebsiteType= 'Ecommerce' and active=True"
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
if not rs.eof	 then 
EcommerceAvailable = True
 else 
EcommerceAvailable = False
end if 
rs.close
  sql = "select * from WebsiteType where WebsiteType= 'Artwork' and active=True"
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
if not rs.eof	 then 
ArtworkAvailable = True
 else 
ArtworkAvailable = False
end if 
rs.close

sql = "select * from WebsiteType where WebsiteType= 'Services' and active=True"
rs.Open sql, conn, 3, 3   
if not rs.eof	 then 
ServicesAvailable = True
 else 
ServicesAvailable = False
end if 
rs.close

sql = "select * from WebsiteType where WebsiteType= 'LivestockAssociation' and active=True"
rs.Open sql, conn, 3, 3   
if not rs.eof	 then 
LivestockAssociationAvailable = True
 else 
LivestockAssociationAvailable = False
end if 
rs.close
 
sql = "select * from WebsiteType where WebsiteType= 'Livestock' and active=True"
rs.Open sql, conn, 3, 3   
if not rs.eof	 then 
LivestockAvailable = True
 else 
 LivestockAvailable = False
end if 
 rs.close
 

sql = "select * from SiteDesign where PeopleID = 667 "
rs.Open sql, conn, 3, 3   
if not rs.eof	 then
MenuDropdowns = rs("MenuDropdowns")
AddPages = rs("AddPages")
Customerlogo = rs("Logo")
end if
rs.close

 
if LivestockAvailable = True then
AlpacasFound = False
  DogsAvailable = False
   LlamasAvailable = False
  HorsesAvailable = False
  GoatsAvailable = False  
  DonkeysAvailable = False
  CattleAvailable = False
  BisonAvailable = False
   SheepAvailable = False
  RabbitsAvailable = False
  PigsAvailable = False
  ChickensAvailable = False
 TurkeysAvailable = False
  CatsAvailable = False



 sql = "select * from SpeciesAvailable where SpeciesAvailableonSite = True Order by SpeciesPriority "
Numofspecies	 = 0
SpeciesOne = ""
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
while not rs.eof 
 if rs("Species") = "Alpacas" then
    AlpacasAvailable = True
    Numofspecies	 = Numofspecies	 + 1
    SpeciesOne =  "Alpacas"
end if

 if rs("Species") = "Dogs" then
    DogsAvailable = True
       Numofspecies	 = Numofspecies	 + 1
       SpeciesOne = "Dogs"
end if

 if rs("Species") = "Llamas" then
    LlamasAvailable = True
       Numofspecies	 = Numofspecies	 + 1
       SpeciesOne = "Llamas"
end if

 if rs("Species") = "Horses" then
    HorsesAvailable = True
       Numofspecies	 = Numofspecies	 + 1
       SpeciesOne = "Horses"
end if

 if rs("Species") = "Goats" then
    GoatsAvailable = True
       Numofspecies	 = Numofspecies	 + 1
       SpeciesOne = "Goats"
end if

 if rs("Species") = "Donkeys (includes Mules & Hinnies)" then
    DonkeysAvailable = True
    SpeciesOne = "Donkeys (includes Mules & Hinnies)"
end if

 if rs("Species") = "Cattle" then
    CattleAvailable = True
       Numofspecies	 = Numofspecies	 + 1
       SpeciesOne = "Cattle"
end if

 if rs("Species") = "Bison" then
    BisonAvailable = True
       Numofspecies	 = Numofspecies	 + 1
       SpeciesOne = "Bison"
end if

 if rs("Species") = "Sheep" then
    SheepAvailable = True
       Numofspecies	 = Numofspecies	 + 1
       SpeciesOne ="Sheep"
end if

 if rs("Species") = "Rabbits" then
    RabbitsAvailable = True
       Numofspecies	 = Numofspecies	 + 1
       SpeciesOne ="Rabbits"
end if

 if rs("Species") = "Pigs" then
    PigsAvailable = True
       Numofspecies	 = Numofspecies	 + 1
       SpeciesOne ="Pigs"
end if

 if rs("Species") = "Chickens" then
    ChickensAvailable = True
       Numofspecies	 = Numofspecies	 + 1
       SpeciesOne = "Chickens"
end if

 if rs("Species") = "Turkeys" then
   TurkeysAvailable = True
      Numofspecies	 = Numofspecies	 + 1
      SpeciesOne = "Turkeys"
end if
 if rs("Species") = "Ducks (and other Fowel)" then
    DucksAvailable = True
       Numofspecies	 = Numofspecies	 + 1
       SpeciesOne = "Ducks (and other Fowel)"
end if
 if rs("Species") = "Cats" then
    CatsAvailable = True
       Numofspecies	 = Numofspecies	 + 1
       SpeciesOne = "Cats"
end if

rs.movenext
wend

rs.close
end if

ShowFoundationHerd = False
sql2 = "select ShowPage from Pagelayout where  ShowPage = True and FileName='FoundationHerd.asp'"	
	'response.write(sql2)
	acounter = 1
	rs2.Open sql2, conn, 3, 3 
	if Not rs2.eof then
	  ShowFoundationHerd = True
	end if
rs2.close	

 %>
 <!--#Include virtual="/administration/AdminSecurityInclude.asp"--> 
 <% if AnimaType="Alpacas"  then %>
 <table width = 1200 border="1" cellspacing="0" cellpadding="0" align = "center">
 <tr><td>
 <table width = 200 border="0" cellspacing="0" cellpadding="0" align = "right">
 <tr><td> <%=RealScreenWidth %></td></tr>
 </table>
 </td>
 <td>
 <% end if %>
 <% if screenwidth < 989 then %>
<table width = "<%=ScreenWidth %>" bgcolor = "white" border="0" cellspacing="0" cellpadding="0" align = "left">
<% else %>
<table width = "<%=ScreenWidth %>" bgcolor = "white" border="0" cellspacing="0" cellpadding="0" align = "center">
<% end if %>
<tr><td><table width = "100%" align = "center" border="0" cellspacing="0" cellpadding="0" >
<tr>



<td class = "body" height = "80">
<% if len(Customerlogo) > 4 then %>
<% if mobiledevice = True and SmallMobile = False then %>
<a href = "default.asp"><center><img src =  "<%=Customerlogo %>" alt = "Content Management System" height = "129" border = "0"></center></a><br />
This Content Management System is presented by <a href ="<%=CopyrightLink%>" class = "body" target = "blank"><%=AdminAuthor%></a>.
<% else %>
<a href = "default.asp"><img src =  "<%=Customerlogo %>" alt = "Content Management System" height = "129" border = "0"></a><br />
This Content Management System is presented by <a href ="<%=CopyrightLink%>" class = "body" target = "blank"><%=AdminAuthor%></a>.
<% end if %>

<% else %>
<% if mobiledevice = True and SmallMobile = False then %>
<a href = "default.asp"><center><img src =  "<%=AdminHeaderImage %>" alt = "Content Management System" height = "129" width = "324"  border = "0"></center></a>
<% else %>
<a href = "default.asp"><img src =  "<%=AdminHeaderImage %>" alt = "Content Management System" height = "129" width = "324" border = "0"></a>
<% end if %>
<% end if %>
<td>
</tr>
</table></td>
<% if mobiledevice = False then %>
<td class = "body2" valign = "bottom" align = "right"><a href = "/" class = "body" target = "blank"><b>Your Website</b></a>&nbsp;&nbsp;&nbsp;
<a href = "/administration/Adminlogout.asp" class = "body"><b>Logout</b></a>&nbsp;</td>
<% end if %>

</tr></table>
<% 

if mobiledevice = True or screenwidth < 481 then %>
<!--#Include file="AdminMobileMenuInclude.asp"-->
<% else

if len(PageWidth) < 9 then
 if ScreenWidth > 480 then 
%>
<table width = "<%=ScreenWidth +26 %>" align = "center" border="0" cellspacing="0" cellpadding="0" >

<tr><td align = "left" >
<ul id="menu">
<li><a href = "/ADMINISTRATION/Default.asp" >Home</a></li>
<li><a href="#">Pages</a>
<ul>
<% showheaderpage = True
if showheaderpage = True then %>
<li><a href = "/administration/AdminUpdateHeader.asp" >Header & FavIcon</a></li>
<% end if %>
<li><a href = "/administration/AdminPageSEOMantainance.asp" >SEO</a></li>


<% if MenuDropdowns  = "Yes" or MenuDropdowns = True then 
Showpagegroups = True
end if   %>	
<% if AddPages = "Yes" Or AddPages = True Then %>
<li><a href = "/ADMINISTRATION/AdminPageAdd.asp" >Add a Page</a></li>
<% end if %>
<li><a href = "/ADMINISTRATION/Default.asp#pages" >List of Pages</a></li>
<% if AddPages = True then %>
<li><a href = "/administration/Default.asp#pages" >Edit Page Groups</a></li>
<% sql3 = "select * from Pagegroups where PagegroupShow = True order by PageGrouporder"	
acounter = 1
Set rs3 = Server.CreateObject("ADODB.Recordset")
rs3.Open sql3, conn, 3, 3 
While Not rs3.eof 
PageGroupTitle = rs3("PageGroupTitle")
PageGroupID = rs3("PageGroupID")  %>
<li><a href = "#" ><%=PageGroupTitle%></a><ul>
<% sql2 = "select * from Pagelayout where PageAvailable = True and PageGroupID = " & PageGroupID & " order by Pagename"
rs2.Open sql2, conn, 3, 3 
  
While Not rs2.eof 
Pagename =  rs2("PageName")

Alreadyshown = false
LinkName = rs2("LinkName") 
if LinkName = "Packages" then
    Packages = true
end if 


if rs2("PageName") = "Alpacas For Sale" then %>
<li><a href = "<%=rs2("EditLink")%>" ><%=LinkName %></a><ul>
<li><a href = "/ADMINISTRATION/AdminAlpacasHome.asp" >List of Alpacas</a></li>
<li><a href = "/ADMINISTRATION/AdminAnimalAdd1.asp" >Add</a></li>
<li><a href = "/ADMINISTRATION/AdminAnimalEdit.asp"   >Edit</a></li>
<li><a href = "/ADMINISTRATION/AdminPhoto.asp"  >Photos</a></li>			
<li><a href = "/ADMINISTRATION/AdminAnimalDelete.asp"   >Delete</a></li>
<li><a href = "/ADMINISTRATION/AdminOutsideStud.asp" >Outside Studs</a></li>
<li><a href = "/ADMINISTRATION/AdminFemaleData.asp" >Breeding Record</a></li>
<li><a href = "/ADMINISTRATION/AdminPageMaintenance.asp?pagename=Alpacas For Sale (Header)" >Heading</a></li>
<li><a href = "/ADMINISTRATION/AdminalpacasStats.asp" >Statistics</a></li>
</ul>
</li>
<% 
Alreadyshown = true
end if  %>

<% if rs2("PageName") = "Articles" then %>
	
		<li><a href = "/Administration/AdminArticleMaintenance.asp?PeopleID=<%=session("PeopleID") %>">List of Articles</a></li>
        <li><a href = "/ADMINISTRATION/AdminArticleAdd.asp" >Add</a></li>
		<li><a href = "/ADMINISTRATION/AdminArticleEdit.asp" >Edit</a></li>
		<li><a href = "/ADMINISTRATION/AdminArticleDelete.asp" >Delete</a></li>
		<li><a href = "/ADMINISTRATION/AdminArticleCategoriesSet.asp" >Categories</a></li>
		<li><a href = "/ADMINISTRATION/AdminPageMaintenance.asp?pagename=Articles" >Header</a></li>

	<% 
	Alreadyshown = true
	end if  %>

    <% 
	
	 if rs2("PageName") = "Galleries" then %>
	<li>
		<a href = "<%=rs2("EditLink")%>" ><%=LinkName %></a>
		<ul>
		 <li><a href = "/Administration/AdminGallerySetCategories.asp">List of Galleries</a></li>
        <li><a href = "/Administration/AdminGalleryAddImage1.asp" >Add Images</a></li>
		<li><a  href = "/Administration/AdminGalleryEditImages.asp" >Edit Images</a></li>
		<li><a href = "/Administration/AdminGallerySetCategories.asp" >Gallery Categories</a></li>
		<li><a href = "/Administration/AdminPageMaintenance.asp?pagename=Galleries" >Heading</a></li>
		</ul>
	</li>
	<% 
	Alreadyshown = true
	end if  
	
	 if rs2("PageName") = "Blog" then %>
	
		 <li><a href = "/Administration/BlogAdmin/Default.asp">List of Blog Articles</a></li>
        <li><a href = "/Administration/BlogAdmin/BlogAdminArticleDelete.asp" >Delete</a></li>
   		<li><a href = "/Administration/AdminPageMaintenance.asp?pagename=Blog" >Heading</a></li>

	<% 
	Alreadyshown = true
	end if  %>

<% 
if rs2("PageName") = "Home Page" then %>
	<li>
		<a href = "<%=rs2("EditLink")%>" ><%=LinkName %></a>
		<ul>
		 <li><a href = "/Administration/AdminHomePage.asp">Page Content</a></li>
	 <% if SlideshowAvailable = True then %>
        <li><a href = "/Administration/AdminGalleryEditImages.asp?GalleryCatID=3" >Slideshow Images</a></li>
<% end if %>
		</ul>
	</li>
	<% 
	Alreadyshown = true
	end if  %>
    <% if rs2("PageName") = "Coming Attractions" then 
	ShowComingattractionspage = True
	end if
	
if Alreadyshown = false then %>
	<li ><a href = "/ADMINISTRATION/<%=rs2("EditLink")%>" ><%=LinkName %></a></li>
	<% end if %>	

<% rs2.movenext
wend
rs2.close%>
</ul>
</li>
<% rs3.movenext
wend
rs3.close
%>

<% else %>
	
	
<%  sql2 = "select * from Pagelayout where PageAvailable = True and not (PageName='Farm Store (Header)')  and not (PageName='Photo Galleries') order by Pagename"	
	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
  
	While Not rs2.eof 
    Alreadyshown = false
LinkName = rs2("LinkName")
if LinkName = "Packages" then
    Packages = true
end if
Pagename =  rs2("PageName") %>
<%

 if rs2("PageName") = "Alpacas For Sale" then %>
<li><a href = "<%=rs2("EditLink")%>" ><%=LinkName %></a><ul>
<li><a href = "/ADMINISTRATION/AdminAlpacasHome.asp" >List of Alpacas</a></li>
<li><a href = "/ADMINISTRATION/AdminAnimalAdd1.asp" >Add</a></li>
<li><a href = "/ADMINISTRATION/AdminAnimalEdit.asp"   >Edit</a></li>
<li><a href = "/ADMINISTRATION/AdminPhoto.asp"  >Photos</a></li>			
<li><a href = "/ADMINISTRATION/AdminAnimalDelete.asp"   >Delete</a></li>
<li><a href = "/ADMINISTRATION/AdminOutsideStud.asp" >Outside Studs</a></li>
<li><a href = "/ADMINISTRATION/AdminFemaleData.asp" >Breeding Record</a></li>
<li><a href = "/ADMINISTRATION/AdminPageMaintenance.asp?pagename=Alpacas For Sale (Header)" >Heading</a></li>
<li><a href = "/ADMINISTRATION/AdminalpacasStats.asp" >Statistics</a></li>
</ul>
</li>
<% 
Alreadyshown = true
end if  %>
<% if rs2("PageName") = "Articles" then %>
	<li>
		<a href = "<%=rs2("EditLink")%>" ><%=LinkName %></a>
		<ul>
		 <li><a href = "/Administration/AdminArticleMaintenance.asp?PeopleID=<%=session("PeopleID") %>">List of Articles</a></li>
        <li><a href = "/ADMINISTRATION/AdminArticleAdd.asp" >Add</a></li>
		<li><a href = "/ADMINISTRATION/AdminArticleEdit.asp" >Edit</a></li>
		<li><a href = "/ADMINISTRATION/AdminArticleDelete.asp" >Delete</a></li>
		<li><a href = "/ADMINISTRATION/AdminArticleCategoriesSet.asp" >Categories</a></li>
		<li><a href = "/ADMINISTRATION/AdminPageMaintenance.asp?pagename=Articles" >Header</a></li>
		</ul>
	</li>
	<% 
	Alreadyshown = true
	end if  %>
	
	<% 
	
	 if rs2("PageName") = "Galleries" then %>
	<li>
		<a href = "<%=rs2("EditLink")%>" ><%=LinkName %></a>
		<ul>
		 <li><a href = "/Administration/AdminGalleryHome.asp">List of Galleries</a></li>
        <li><a href = "/Administration/AdminGalleryAddImage1.asp" >Add Images</a></li>
		<li><a  href = "/Administration/AdminGalleryEditImages.asp" >Edit Images</a></li>
		<li><a href = "/Administration/AdminGallerySetCategories.asp" >Gallery Categories</a></li>
		<li><a href = "/Administration/AdminPageMaintenance.asp?pagename=Galleries" >Heading</a></li>
		</ul>
	</li>
	<% 
	Alreadyshown = true
	end if  
	
	 if rs2("PageName") = "Blog" then %>
	<li>
		<a href = "<%=rs2("EditLink")%>" ><%=LinkName %></a>
		<ul>
		 <li><a href = "/Administration/BlogAdmin/Default.asp">List of Blog Articles</a></li>
        <li><a href = "/Administration/BlogAdmin/BlogAdminArticleDelete.asp" >Delete</a></li>
   		<li><a href = "/Administration/AdminPageMaintenance.asp?pagename=Blog" >Heading</a></li>
		</ul>
	</li>
	<% 
	Alreadyshown = true
	end if  %>
	
<% 
if rs2("PageName") = "Home Page" then %>
	<li>
		<a href = "<%=rs2("EditLink")%>" ><%=LinkName %></a>
		<ul>
		 <li><a href = "/Administration/AdminHomePage.asp">Page Content</a></li>
	 <% if SlideshowAvailable = True then %>
        <li><a href = "/Administration/AdminGalleryEditImages.asp?GalleryCatID=3" >Slideshow Images</a></li>
<% end if %>
		</ul>
	</li>
	<% 
	Alreadyshown = true
	end if  %>
	
<% if rs2("PageName") = "Coming Attractions" then 
	ShowComingattractionspage = True
	end if
	
if Alreadyshown = false then %>
	<li ><a href = "/ADMINISTRATION/<%=rs2("EditLink")%>" ><%=LinkName %></a></li>
	<% end if %>	
 <% 
	rs2.movenext
 Wend %>
 <% end if %>
</ul>
</li>


<% if LivestockAvailable = True then %>
<li><a href= "/ADMINISTRATION/Default.asp#animals" >Animals</a><ul>

<% if AlpacasAvailable = True then %>
<li><a href= "/ADMINISTRATION/AdminAlpacasHome.asp" >Alpacas</a><ul>
<li><a href = "/ADMINISTRATION/AdminalpacasHome.asp" >List of Alpacas</a></li>
<li><a href = "/ADMINISTRATION/AdminAnimalAdd1.asp?speciesID=2" >Add Alpacas</a></li>
 <% if Packages = true then%>
<li><a href = "/ADMINISTRATION/AdminPackageshome.asp" >Packages</a></li>
 <% end if %>
</ul>
<% end if %>

<% if BisonAvailable = True then %>
<li><a href= "/ADMINISTRATION/AdminBisonHome.asp" >Bison</a><ul>
<li><a href = "/ADMINISTRATION/AdminBisonHome.asp" >List of Bison</a></li>
<li><a href = "/ADMINISTRATION/AdminAnimalAdd1.asp?speciesID=9" >Add a Bison</a></li>
 <% if Packages = true then%>
<li><a href = "/ADMINISTRATION/AdminPackageshome.asp" >Packages</a></li>
 <% end if %>
</ul>
<% end if %>

<% if CattleAvailable = True then %>
<li><a href= "/ADMINISTRATION/AdminBisonHome.asp" >Cattle</a><ul>
<li><a href = "/ADMINISTRATION/AdminBisonHome.asp" >List of Cattle</a></li>
<li><a href = "/ADMINISTRATION/AdminAnimalAdd1.asp?speciesID=8" >Add Cattle</a></li>

 <% if Packages = true then%>
<li><a href = "/ADMINISTRATION/AdminPackageshome.asp" >Packages</a></li>
 <% end if %>
</ul>
<% end if %>


<% if ChickensAvailable = True then %>
<li><a href= "/ADMINISTRATION/AdminChickensHome.asp" >Chickens</a><ul>
<li><a href = "/ADMINISTRATION/AdminChickensHome.asp" >List of Chickens</a></li>
<li><a href = "/ADMINISTRATION/AdminAnimalAdd1.asp?speciesID=13" >Add Chickens</a></li>
 <% if Packages = true then%>
<li><a href = "/ADMINISTRATION/AdminPackageshome.asp" >Packages</a></li>
 <% end if %>
</ul>
<% end if %>

<% if DogsAvailable = True then %>
<li><a href= "/ADMINISTRATION/AdminDogsHome.asp" >Dogs</a><ul>
<li><a href = "/ADMINISTRATION/AdminDogsHome.asp" >List of Dogs</a></li>
<li><a href = "/ADMINISTRATION/AdminAnimalAdd1.asp?speciesID=3" >Add Dogs</a></li>
 <% if Packages = true then%>
<li><a href = "/ADMINISTRATION/AdminPackageshome.asp" >Packages</a></li>
 <% end if %>
</ul>
<% end if %>


<% if DonkeysAvailable = True then %>
<li><a href= "/ADMINISTRATION/AdminDonkeysHome.asp" >Donkeys</a><ul>
<li><a href = "/ADMINISTRATION/AdminDonkeysHome.asp" >List of Donkeys</a></li>
<li><a href = "/ADMINISTRATION/AdminAnimalAdd1.asp?speciesID=7" >Add Donkeys</a></li>
 <% if Packages = true then%>
<li><a href = "/ADMINISTRATION/AdminPackageshome.asp" >Packages</a></li>
 <% end if %>
</ul>
<% end if %>

<% if DucksAvailable = True then %>
<li><a href= "/ADMINISTRATION/AdminDucksHome.asp" >Ducks</a><ul>
<li><a href = "/ADMINISTRATION/AdminDucksHome.asp" >List of Ducks</a></li>
<li><a href = "/ADMINISTRATION/AdminAnimalAdd1.asp?speciesID=15" >Add Ducks</a></li>
 <% if Packages = true then%>
<li><a href = "/ADMINISTRATION/AdminPackageshome.asp" >Packages</a></li>
 <% end if %>
</ul>
<% end if %>

<% if GoatsAvailable = True then %>
<li><a href= "/ADMINISTRATION/AdminGoatsHome.asp" >Goats</a><ul>
<li><a href = "/ADMINISTRATION/AdminGoatsHome.asp" >List of Goats</a></li>
<li><a href = "/ADMINISTRATION/AdminAnimalAdd1.asp?speciesID=6" >Add Goats</a></li>
 <% if Packages = true then%>
<li><a href = "/ADMINISTRATION/AdminPackageshome.asp" >Packages</a></li>
 <% end if %>
</ul>
<% end if %>

<% if HorsesAvailable = True then %>
<li><a href= "/ADMINISTRATION/AdminHorsesHome.asp" >Horses</a><ul>
<li><a href = "/ADMINISTRATION/AdminHorsesHome.asp" >List of Horses</a></li>
<li><a href = "/ADMINISTRATION/AdminAnimalAdd1.asp?speciesID=5" >Add Horses</a></li>
 <% if Packages = true then%>
<li><a href = "/ADMINISTRATION/AdminPackageshome.asp" >Packages</a></li>
 <% end if %>
</ul>
<% end if %>

<% if LlamasAvailable = True then %>
<li><a href= "/ADMINISTRATION/AdminLlamasHome.asp" >Llamas</a><ul>
<li><a href = "/ADMINISTRATION/AdminLlamasHome.asp" >List of Llamas</a></li>
<li><a href = "/ADMINISTRATION/AdminAnimalAdd1.asp?speciesID=4" >Add Llamas</a></li>
 <% if Packages = true then%>
<li><a href = "/ADMINISTRATION/AdminPackageshome.asp" >Packages</a></li>
 <% end if %>
</ul>
<% end if %>


<% if PigsAvailable = True then %>
<li><a href= "/ADMINISTRATION/AdminPigsHome.asp" >Pigs</a><ul>
<li><a href = "/ADMINISTRATION/AdminPigsHome.asp" >List of Pigs</a></li>
<li><a href = "/ADMINISTRATION/AdminAnimalAdd1.asp?speciesID=12" >Add Pigs</a></li>
 <% if Packages = true then%>
<li><a href = "/ADMINISTRATION/AdminPackageshome.asp" >Packages</a></li>
 <% end if %>
</ul>
<% end if %>

<% if RabbitsAvailable = True then %>
<li><a href= "/ADMINISTRATION/AdminRabbitsHome.asp" >Rabbits</a><ul>
<li><a href = "/ADMINISTRATION/AdminRabbitsHome.asp" >List of Rabbits</a></li>
<li><a href = "/ADMINISTRATION/AdminAnimalAdd1.asp?speciesID=11" >Add Rabbits</a></li>
 <% if Packages = true then%>
<li><a href = "/ADMINISTRATION/AdminPackageshome.asp" >Packages</a></li>
 <% end if %>
</ul>
<% end if %>

<% if SheepAvailable = True then %>
<li><a href= "/ADMINISTRATION/AdminSheepHome.asp" >Sheep</a><ul>
<li><a href = "/ADMINISTRATION/AdminSheepHome.asp" >List of Sheep</a></li>
<li><a href = "/ADMINISTRATION/AdminAnimalAdd1.asp?speciesID=10" >Add Sheep</a></li>
 <% if Packages = true then%>
<li><a href = "/ADMINISTRATION/AdminPackageshome.asp" >Packages</a></li>
 <% end if %>
</ul>
<% end if %>

<% if TurkeysAvailable = True then %>
<li><a href= "/ADMINISTRATION/AdminTurkeysHome.asp" >Turkeys</a><ul>
<li><a href = "/ADMINISTRATION/AdminTurkeysHome.asp" >List of Turkeys</a></li>
<li><a href = "/ADMINISTRATION/AdminAnimalAdd1.asp?speciesID=14" >Add Turkeys</a></li>
 <% if Packages = true then%>
<li><a href = "/ADMINISTRATION/AdminPackageshome.asp" >Packages</a></li>
 <% end if %>
</ul>
<% end if %>



<li><a href = "/ADMINISTRATION/AdminAnimalEdit.asp" >Edit</a></li>
<li><a href = "/ADMINISTRATION/AdminPhoto.asp" >Photos</a></li>			
<li><a href = "/ADMINISTRATION/AdminAnimalDelete.asp">Delete</a></li>
<li><a href = "/ADMINISTRATION/AdminOutsideStud.asp" >Outside Studs</a></li>
<li><a href = "/ADMINISTRATION/AdminFemaleData.asp" >Breeding Record</a></li>
<li><a href = "/ADMINISTRATION/AdminalpacasStats.asp" >Statistics</a></li>
</ul>
</li><% end if %>


<% if ECommerceAvailable = True then %>
<li ><a href = '#' >Products</a><ul>
<li ><a href = "/Administration/AdminProductsHome.asp?PeopleID=<%=session("PeopleID") %>" >List of Products</a></li>	
<li ><a href = "/ADMINISTRATION/AdminClassifiedAdPlace.asp" >Add</a></li>	
<li ><a href = "/ADMINISTRATION/AdminAdEdit.asp" >Edit</a>	
</li>
<li ><a href = "/ADMINISTRATION/AdminProductPhotos.asp">Photos </a>	
</li>
<li ><a href = "/ADMINISTRATION/AdminListingDelete.asp">Delete</a>
</li>
<li ><a href = "/ADMINISTRATION/AdminStoreMaintenance.asp?Tabs=Products">Payment Method</a>
</li>
<li ><a href = "/ADMINISTRATION/AdminStoreMaintenance.asp?Tabs=Products#Taxes">Taxes</a>
<% showdiscounts = False 
if howdiscounts = True then%>
<li ><a href = "/ADMINISTRATION/AdminDiscounts.asp?Tabs=Products">Discounts/Coupons</a></li>
<% end if %>
</ul>
<% end if %>
		
		
<% if ServicesAvailable = True then %>
<li ><a href = '#' >Services</a><ul>
<li ><a href = "/Administration/AdminServicesHome.asp?PeopleID=<%=session("PeopleID") %>" >List of Services</a></li>	
<li ><a href = "/ADMINISTRATION/AdminServicesAdPlace.asp" >Add</a></li>	
<li ><a href = "/ADMINISTRATION/AdminServicesPhotos.asp" >Photos </a></li>
<li ><a href = "/ADMINISTRATION/AdminServiceDelete.asp" >Delete</a></li>
<li ><a href = "/ADMINISTRATION/AdminStoreMaintenance.asp?Tabs=Services"  >Payment Method</a></li>
<li ><a href = "/ADMINISTRATION/AdminStoreMaintenance.asp?Tabs=Services#Taxes"  >Taxes</a>
<li ><a href = "/ADMINISTRATION/AdminDiscounts.asp?Tabs=Services">Discounts/Coupons</a>
</ul>
<% end if %>
		
		
<%
showreports = false
if showreports = true then
 if LivestockAvailable = True then %>
	<li>
		<a href="#">Reports</a>
		<ul>
			<li><a href = "/ADMINISTRATION/AdminReportSaleList.asp" target = "blank">Alpaca Sales List</a></li>
			<li><a href = "/ADMINISTRATION/AdminReportAnimalSalesPage.asp" >Animal Flyer</a></li>
		</ul>
	</li>
	<% end if %>
    	<% end if %>
	<li>
		<a href="#">Contact Info</a>
		<ul>
			<li><a href = "/ADMINISTRATION/AdminAccountMaintenance.asp" >Contact Information</a></li>
			<li><a href = "/ADMINISTRATION/AdminPasswordChange.asp" >Change Password</a></li>
		</ul>
	</li>
	<% 
	if len(PageWidth) < 9  and mobiledevice = False then
	 if session("accesslevel") > 2  then %>
	<li>
		<a href="#">Executive Functions</a>
		<ul>
			<li><a href = "/ADMINISTRATION/AdminWebsitesetup.asp" >Website Setup</a></li>
			<li><a href = "/ADMINISTRATION/AdminStandardStylesMaster.asp" >Layout Styles</a></li>
			<li><a href = "/ADMINISTRATION/AdminStandardStylesmaster.asp#images" >Upload Layout Images</a></li>
			<li><a href = "/ADMINISTRATION/AdminLayoutEdit.asp" >Font Styles</a></li>
		</ul>
	</li>
	<% end if %>
		<% end if %>
</ul>
</td>
</tr>
</table>
	<% end if %>

<% else 
if len(PageWidth) < 9 then
 if PageWidth > 480 then %>
 	 <% if mobiledevice = False then %>
<table width = "<%=PageWidth %>" align = "center" border="0" cellspacing="0" cellpadding="0" >
<% else %>
<table width = "100%" align = "center" border="0" cellspacing="0" cellpadding="0" >
<% end if %>
<tr><td >

<ul id="menu">
	<li><a href = "/ADMINISTRATION/Default.asp" >Home</a></li>
	<li>
		<a href= "/ADMINISTRATION/AdminAlpacasHome.asp" >Alpacas</a>
		<ul>
		<li><a href = "/ADMINISTRATION/AdminAlpacasHome.asp" >List of Alpacas</a></li>
			<li><a href = "/ADMINISTRATION/AdminAnimalAdd1.asp" >Add</a></li>
			<li><a href = "/ADMINISTRATION/AdminAnimalEdit.asp"   >Edit</a></li>
			<li><a href = "/ADMINISTRATION/AdminPhoto.asp"  >Photos</a></li>			
			<li><a href = "/ADMINISTRATION/AdminAnimalDelete.asp"   >Delete</a></li>
			<li><a href = "/ADMINISTRATION/AdminOutsideStud.asp" >Outside Studs</a></li>
			<li><a href = "/ADMINISTRATION/AdminFemaleData.asp" >Breeding Record</a></li>
			<li><a href = "/ADMINISTRATION/AdminPageMaintenance.asp?pagename=Alpacas For Sale (Header)" >Heading</a></li>
			<li><a href = "/ADMINISTRATION/AdminalpacasStats.asp" >Statistics</a></li>
		</ul>
	</li>
<li>
		<a href="#">Pages</a>
		<ul>
		
		<% if MenuDropdowns  = "Yes" or MenuDropdowns = True then %>
		<li>
		<a href = "AdminPageGroups.asp" >Page Groups</a></li>
		
		<% end if %>
			<%  sql2 = "select * from Pagelayout where PageAvailable = True and not (PageName='Farm Store (Header)')  and not (PageName='Photo Galleries') order by Pagename"	
	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
  
	While Not rs2.eof 
	Alreadyshown = false
%> 
	<% 
	
	 if rs2("PageName") = "Alpacas For Sale" then %>
	<li>
		<a href = "<%=rs2("EditLink")%>" ><%=rs2("LinkName")%></a>
		<ul>
		 <li><a href = "/ADMINISTRATION/AdminAlpacasHome.asp" >List of Alpacas</a></li>
			<li><a href = "/ADMINISTRATION/AdminAnimalAdd1.asp" >Add</a></li>
			<li><a href = "/ADMINISTRATION/AdminAnimalEdit.asp"   >Edit</a></li>
			<li><a href = "/ADMINISTRATION/AdminPhoto.asp"  >Photos</a></li>			
			<li><a href = "/ADMINISTRATION/AdminAnimalDelete.asp"   >Delete</a></li>
			<li><a href = "/ADMINISTRATION/AdminOutsideStud.asp" >Outside Studs</a></li>
			<li><a href = "/ADMINISTRATION/AdminFemaleData.asp" >Breeding Record</a></li>
			<li><a href = "/ADMINISTRATION/AdminPageMaintenance.asp?pagename=Alpacas For Sale (Header)" >Heading</a></li>
			<li><a href = "/ADMINISTRATION/AdminalpacasStats.asp" >Statistics</a></li>
			</ul>
	</li>
	<% 
	Alreadyshown = true
	end if  %>
	
	

	<% if rs2("PageName") = "Articles" then %>
	<li>
		<a href = "<%=rs2("EditLink")%>" ><%=rs2("LinkName")%></a>
		<ul>
		 <li><a href = "/Administration/AdminArticleMaintenance.asp?PeopleID=<%=session("PeopleID") %>">List of Articles</a></li>
        <li><a href = "/ADMINISTRATION/AdminArticleAdd.asp" >Add</a></li>
		<li><a href = "/ADMINISTRATION/AdminArticleEdit.asp" >Edit</a></li>
		<li><a href = "/ADMINISTRATION/AdminArticleDelete.asp" >Delete</a></li>
		<li><a href = "/ADMINISTRATION/AdminArticleCategoriesSet.asp" >Categories</a></li>
		<li><a href = "/ADMINISTRATION/AdminPageMaintenance.asp?pagename=Articles" >Header</a></li>
		</ul>
	</li>
	<% 
	Alreadyshown = true
	end if  %>
	
	<% 
	
	 if rs2("PageName") = "Galleries" then %>
	<li>
		<a href = "<%=rs2("EditLink")%>" ><%=rs2("LinkName")%></a>
		<ul>
		 <li><a href = "/Administration/AdminGalleryHome.asp">List of Galleries</a></li>
        <li><a href = "/Administration/AdminGalleryAddImage1.asp" >Add Images</a></li>
		<li><a  href = "/Administration/AdminGalleryEditImages.asp" >Edit Images</a></li>
		<li><a href = "/Administration/AdminGallerySetCategories.asp" >Gallery Categories</a></li>
		<li><a href = "/Administration/AdminPageMaintenance.asp?pagename=Galleries" >Heading</a></li>
		</ul>
	</li>
	<% 
	Alreadyshown = true
	end if 
	 if rs2("PageName") = "Farm Store" then %>
	<li>
		<a href = "<%=rs2("EditLink")%>" >Products</a>
		<ul>
		 <li ><a href = "/Administration/AdminProductsHome.asp?PeopleID=<%=session("PeopleID") %>" >List of Products</a></li>	
			<li ><a href = "/ADMINISTRATION/AdminClassifiedAdPlace.asp" >Add</a></li>	
			<li ><a href = "/ADMINISTRATION/AdminAdEdit.asp" >Edit</a>	
			</li>
			<li ><a href = "/ADMINISTRATION/AdminProductPhotos.asp" >Photos </a>	
			</li>
			<li ><a href = "/ADMINISTRATION/AdminListingDelete.asp" >Delete</a>
			</li>
			<li ><a href = "/ADMINISTRATION/AdminSetSaleCategories.asp" >Categories</a>	
			</li>
			<li ><a href = "/ADMINISTRATION/AdminStoreShippingRates.asp"  >Shipping Rates</a>	
			</li>
			<li ><a href = "/ADMINISTRATION/AdminStoreMaintenance.asp"  >Settings</a>
			</li>
			<li ><a href = "/ADMINISTRATION/AdminPageMaintenance.asp?pagename=Farm Store" >Header</a>
			</li>
		</ul>
	</li>
	<% 
	Alreadyshown = true
	end if  %>
	
	
	
	<% 
	
	 if rs2("PageName") = "Blog" then %>
	<li>
		<a href = "<%=rs2("EditLink")%>" ><%=rs2("LinkName")%></a>
		<ul>
		 <li><a href = "/Administration/BlogAdmin/Default.asp">List of Blog Articles</a></li>
        <li><a href = "/Administration/BlogAdmin/BlogAdminArticleDelete.asp" >Delete</a></li>
        <li><a href = "/Administration/AdminPageMaintenance.asp?pagename=Blog" >Heading</a></li>
		</ul>
	</li>
	<% 
	Alreadyshown = true
	end if  
	 if rs2("PageName") = "Home Page" then %>
	<li>
		<a href = "<%=rs2("EditLink")%>" ><%=rs2("LinkName")%></a>
		<ul>
		 <li><a href = "/Administration/AdminHomePage.asp">Page Content</a></li>
		 <% if SlideshowAvailable = True then %>
        <li><a href = "/Administration/AdminGalleryEditImages.asp?GalleryCatID=3" >Slideshow Images</a></li>
        <% end if %>
		</ul>
	</li>
	<% 
	Alreadyshown = true
	end if 
if rs2("PageName") = "Coming Attractions" then 
	ShowComingattractionspage = True
	else
	ShowComingattractionspage = False
	end if
	 if Alreadyshown = false then %>
	<li ><a href = "/ADMINISTRATION/<%=rs2("EditLink")%>" ><%=rs2("LinkName")%></a></li>
	<% end if %>	
 <% 
	rs2.movenext
 Wend %>
		</ul>
	</li>
<li ><a href = '#' >Products</a><ul>
<li ><a href = "/Administration/AdminProductsHome.asp?PeopleID=<%=session("PeopleID") %>" >List of Products</a></li>	
<li ><a href = "/ADMINISTRATION/AdminClassifiedAdPlace.asp" >Add</a></li>	
<li ><a href = "/ADMINISTRATION/AdminAdEdit.asp" >Edit</a></li>
<li ><a href = "/ADMINISTRATION/AdminProductPhotos.asp" >Photos </a></li>
<li ><a href = "/ADMINISTRATION/AdminListingDelete.asp" >Delete</a></li>
<li ><a href = "/ADMINISTRATION/AdminSetSaleCategories.asp" >Categories</a></li>
<li ><a href = "/ADMINISTRATION/AdminStoreShippingRates.asp"  >Shipping Rates</a></li>
<li ><a href = "/ADMINISTRATION/AdminStoreMaintenance.asp"  >Settings</a>	</li>
<li ><a href = "/ADMINISTRATION/AdminPageMaintenance.asp?pagename=Farm Store" >Header</a></li>
</ul>
</li>
<% if LivestockAvailable = True then %>	 
<li><a href="#">Reports</a>
<ul>
<% if AlpacasFound = True then %>
<li><a href = "/ADMINISTRATION/AdminReportSaleList.asp" target = "blank">Alpaca Sales List</a></li>
<% end if %>
<li><a href = "/ADMINISTRATION/AdminReportAnimalSalesPage.asp" >Individual Sales Pages</a></li>
</ul>
</li>
<% end if %>
	<li>
		<a href="#">Contact Info</a>
		<ul>
			<li><a href = "/ADMINISTRATION/AdminAccountMaintenance.asp" >Contact Information</a></li>
			<li><a href = "/ADMINISTRATION/AdminPasswordChange.asp" >Change Password</a></li>
		</ul>
	</li>

    <% if cint(session("accesslevel")) > 2 then %>
	<li>
		<a href="#">Executive Functions</a>
		<ul>
			<li><a href = "/ADMINISTRATION/AdminWebsitesetup.asp" >Website Setup</a></li>
			<li><a href = "/ADMINISTRATION/AdminStandardStylesMaster.asp" >Layout Styles</a></li>
			<li><a href = "/ADMINISTRATION/AdminStandardStylesmaster.asp#images" >Upload Layout Images</a></li>
			<li><a href = "/ADMINISTRATION/AdminLayoutEdit.asp" >Font Styles</a></li>
</ul>
</li>
<% end if %>
</ul>
</td></tr></table>
<% end if %>
<% end if %>
<% end if %>
<% end if %>

<% 
if screenwidth < 1198 then %>
<table width="<%=screenwidth %>"   border="0" cellpadding=0 cellspacing=0 bgcolor = "white" align = "center">
<tr><td ><br>
<% else 
if AdminHome = True or Page = "Editwebsite" or mobiledevice = True then%>
<table width="<%=screenwidth %>"   border="0" cellpadding=0 cellspacing=0 bgcolor = "white" align = "center">
<tr><td ><br>
<% else 
%>
<table width="<%=screenwidth +30%>"   border="0" cellpadding=0 cellspacing=0 bgcolor = "white" align = "center">
<tr><td width = "200" valign = "top"><!--#Include file="AdminleftSidemenu.asp"--> </td><td width = '<%=screenwidth %>' valign = "top"><% screenwidth = screenwidth - 200 
 end if %><% end if %>