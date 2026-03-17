

<!--#Include virtual="/members/MembersHeader.asp"-->





<% 
sql = "select Logo from people where PeopleID = " & session("PeopleID")

rs.Open sql, conn, 3, 3   
if not rs.eof	 then
Customerlogo = rs("Logo")
end if

rs.close

Current = "Dashboard" 
Set rs = Server.CreateObject("ADODB.Recordset")
Set rs2 = Server.CreateObject("ADODB.Recordset")
Set rs3 = Server.CreateObject("ADODB.Recordset")

sql = "select * from LayoutHomePage where HomePageDesignAspect= 'Slideshow' and HomePageDesignAspectAvailable=1"
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
if not rs.eof	 then 
SlideshowAvailable = True
 else 
SlideshowAvailable = False
end if 
 
sql = "select * from WebsiteType where WebsiteType= 'Ecommerce' and active=1"
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
if not rs.eof then 
EcommerceAvailable = True
 else 
EcommerceAvailable = False
end if 
rs.close
  sql = "select * from WebsiteType where WebsiteType= 'Artwork' and active=1"
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
if not rs.eof	 then 
ArtworkAvailable = True
 else 
ArtworkAvailable = False
end if 
rs.close

sql = "select * from WebsiteType where WebsiteType= 'Services' and active=1"
rs.Open sql, conn, 3, 3   
if not rs.eof	 then 
ServicesAvailable = True
 else 
ServicesAvailable = False
end if 
rs.close

sql = "select * from WebsiteType where WebsiteType= 'LivestockAssociation' and active=1"
rs.Open sql, conn, 3, 3   
if not rs.eof	 then 
LivestockAssociationAvailable = True
 else 
LivestockAssociationAvailable = False
end if 
rs.close
 
sql = "select * from WebsiteType where WebsiteType= 'Livestock' and active=1"
rs.Open sql, conn, 3, 3   
if not rs.eof	 then 
LivestockAvailable = True
 else 
 LivestockAvailable = False
end if 
 rs.close
 
 sql = "select * from SiteDesign where PeopleID = " & session("PeopleID")
rs.Open sql, conn, 3, 3   
if not rs.eof	 then
MenuDropdowns = rs("MenuDropdowns")
AddPages = rs("AddPages")
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
EmusAvailable = False
chickensAvailable = False

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
    AlpacasFound = True
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
sql2 = "select ShowPage from Pagelayout where  ShowPage = 1 and FileName='FoundationHerd.asp' and Peopleid=" & session("PeopleID")	
	'response.write(sql2)
	acounter = 1
	rs2.Open sql2, conn, 3, 3 
	if Not rs2.eof then
	  ShowFoundationHerd = True
	end if
rs2.close	

 %>



<style>

#topheader .navbar-nav li > a {
	text-transform: capitalize;
	color: #333;
	transition: background-color .2s, color .2s;
	
	&:hover,
	&:focus {
		background-color: #333;
		color: #fff;
	}
}

#topheader .navbar-nav li.active > a {
	background-color: #333;
	color: #fff;
}

</style>
<div style="background-color:black; height:2px" ></div> 


<div class="container-fluid " id="topheader">

<nav class="navbar navbar-default" style="background-color: tan;">
  <div class="container-fluid ">

    <div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-2" aria-expanded="false">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
    </div>

    <div class="collapse navbar-collapse " style="background-color: #CFA76E" id="bs-example-navbar-collapse-2">

      <ul class="nav navbar-nav " style="background-color: tan;">
        <li style="background-color: tan;"><a href="/members/default.asp" >Website Admin Home <span class="sr-only">(current)</span></a></li>
        
        <li class="dropdown" style="background-color: tan;">
          <a href="/members/MembersAnimalsHome.asp" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Pages <span class="caret"></span></a>
          <ul class="dropdown-menu" style="background-color: tan;">
            <li style="background-color: tan;"><a href="/members/AdminUpdateHeader.asp">Header & FavIcon</a></li>
            <li style="background-color: tan;"><a href="/Members/AdminPageSEOMantainance.asp">SEO</a></li>
            <li style="background-color: tan;"><a href="/Members/Default.asp">List Of Pages</a></li>
          </ul>
        </li>
 

   </ul>

    </div><!-- /.navbar-collapse -->
  </div><!-- /.container-fluid -->
</nav>
</div>

<style>
.fixed{
    width: 200px;
}
</style>
<div container class = "container-fluid">
    <div class="row">
        <div class=" visible-lg visible-xl col-md-2 fixed " style="width=200px" >

            <!--#Include file="AdminleftSidemenu.asp"-->


        </div>
        <div class="col-md-10">

