<link href="https://www.livestockoftheworld.com/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="/includefiles/Style.css">


  <!-- Custom styles for this template -->
<link href="/includefiles/navbar.css" rel="stylesheet">
    
  
<style>
/***Navbar Background Color, Border Removed ,Border Radius Sqaure***/


.navbar.navbar-custom {
  background: white;
  border: none;
  border-radius: 0;
  
}
/***Link Color***/

.navbar.navbar-custom .navbar-nav > li > a {
  color: black;
}
/***Link Color Hover Statr***/

.navbar.navbar-custom .navbar-nav > li > a:hover {
  color: maroon;
}
/***Link Background and Color Active State***/

.navbar.navbar-custom .navbar-nav > .active,
.navbar.navbar-custom .navbar-nav > .active > a,
.navbar.navbar-custom .navbar-nav > .active > a:hover,
.navbar.navbar-custom .navbar-nav > .active > a:focus {
  background: white;
  color: white;
}
/***Navbar Brand Link Color***/

.navbar.navbar-custom .navbar-brand {
  color: white;
}
/***Navbar Brand Link Color Hover State***/

.navbar.navbar-custom .navbar-brand:hover {
  color: white;
}
/***Dropdown Background Active State***/

.navbar.navbar-custom .nav li.dropdown.open > .dropdown-toggle,
.navbar.navbar-custom .nav li.dropdown.active > .dropdown-toggle,
.navbar.navbar-custom .nav li.dropdown.open.active > .dropdown-toggle {
  background: white;
  color: black;
}
/***Dropdown-menu Background Color***/

.navbar.navbar-custom .dropdown-menu {
  background: white;
  border: none;
}
/***Dropdown-menu Color***/

.navbar.navbar-custom .dropdown-menu > li > a {
  color: maroon;
}
/***Dropdown-menu Color Hover and Focus State***/

.navbar.navbar-custom .dropdown-menu > li > a:hover,
.navbar.navbar-custom .dropdown-menu > li > a:focus {
  color: black;
  background: white;
}
/***Toggle Button***/

.navbar.navbar-custom .navbar-header .navbar-toggle {
  border-color: black;
}
/***Toggle Button Hover and Focus State***/

.navbar.navbar-custom .navbar-header .navbar-toggle:hover,
.navbar.navbar-custom .navbar-header .navbar-toggle:focus {
  background: #893333;
  border: black;
}
/***Collapse Borders***/

.navbar.navbar-custom .navbar-collapse {
  border: none;
}
@media (max-width: 640px) {
  .navbar.navbar-custom li.dropdown .dropdown-menu > li > a {
    color: white;
  }
  /***Dropdown-menu Color Hover and Focus State***/
  .navbar.navbar-custom li.dropdown .dropdown-menu > li > a:hover,
  .navbar.navbar-custom li.dropdown .dropdown-menu > li > a:focus {
    color: white;
    background: #893333;
  }
}

 .nav-link
{ 
    font-size : 30px;
	line-height : 60px;
}

.dropdown-item 
{ 
    font-size : 10px;
	line-height : 60px;
}

</style>


<!-- Google tag (gtag.js) -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-S388758935"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'G-S83349KHQ8');
</script>



 <%
    AdID=Request.querystring("AdID")
    AdType=Request.querystring("AdType")


    if len(AdID) > 0 and len(AdType) > 0 then
    Query =  "INSERT INTO AdStats (AdID, ClickDate, AdType, Click)" 
    Query =  Query & " Values ('" &  AdID & "', GETDATE(), '" & AdType & "', 1)" 

   ' response.write(Query)	

    Conn.Execute(Query) 
    end if
    
TopMenuColor="white"
FooterColor="#a87844" 
CurrentLogo = "/Logos/livestock-of-the-world-logo-color-wide.png"
TopMenuColor = "#ddd"
CurrentWebsite ="Livestock Of The World"
      %>



<div class="container-fluid d-none d-lg-block">
  <div class="row">
    <!-- First column spanning 2 rows -->
    <div class="col-md-2" style="max-width:230px; min-width:230px;">
      <div class="row" >
        <div class="col-md-12" rowspan="2" style="align-items: flex-end;"> <a href="/Default.asp" class="webheader"><img src="<%=CurrentLogo%>" valign="bottom" height="55" alt="<%=CurrentWebsite %>"></a></div>
      </div>
    </div>
    <!-- Second column -->
        <div class="col-md-2" style="max-width:110px;">
      <div class="row">
        <div class="col-md-12" >
          <img src="/images/px.gif" alt ="Farmers & Ranchers"/>
        </div>
      </div>
      <div class="row">
        <div class="col-md-12" >
        </div>
      </div>
    </div>
    <!-- Third column -->
       <div class="col-md-2" style="max-width:110px;">
      <div class="row">
        <div class="col-md-12">
           <img src="/images/px.gif" alt ="Associations"/>
        </div>
      </div>
      <div class="row">
         <div class="col-md-12" style="max-width:110px; min-height: 28px; align-items: flex-end;">
         
        </div>
      </div>
    </div>
    <!-- Fourth column -->
     <div class="col-md-2" style="max-width:110px;">
      <div class="row">
        <div class="col-md-12">
           <img src="/images/px.gif" alt ="Associations"/>
        </div>
      </div>
      <div class="row">
         <div class="col-md-12" style="max-width:110px; min-height: 28px; align-items: flex-end;">
          
         </div>
      </div>
    </div>
    <!-- Fifth column -->
   <div class="col" >
      <div class="row">
        <div class="col" >

        </div>
      </div>
      <div class="row">
        <div class="col" >
                 
        </div>
      </div>
    </div>
          <!-- Sixth column -->
    <div class="col-md-2">
      <div class="row">
        <div class="col-md-12" style="min-height: 19px;" nowrap align="right">
           
        </div>
      </div>
      <div class="row">
        <div class="col-md-12" align="right" nowrap>
                     <a href="https://www.livestockoftheworld.com/login.asp"  class ="menuX">Sign In |</a>
            <a href="https://www.livestockoftheworld.com/Join/USA/SetupAccountPlus.asp"  class ="menuX">Join </a>
                    <a href="https://www.livestockoftheworld.com" class ="menuX" >
                    
        </div>
      </div>
    </div>
          <!-- seventh column -->
   <div class="col" style="min-width:180px; max-width:180px">
      <div class="row">
           <div class="col" style="min-width:180px; max-width:180px">

        </div>
      </div>
      <div class="row">
           <div class="col" style="min-width:180px; max-width:180px">
                 
        </div>
      </div>
    </div>


  </div>
</div>





<div class="container-fluid" >
    <div class="row" style="background-color:#ddd; min-height: 10px">
    <div class="navbar navbar-expand-lg navbar-light justify-content-center"  >
    <% ' lg+ navigation  %>
     <div class="container-fluid d-none d-lg-block" style="background-color:#ddd; min-height: 10px">
      <div class="collapse navbar-collapse " id="navbarCenteredExample"  >
       <ul class="navbar-nav me-auto mb-2 mb-lg-0"   style="background-color:<%=TopMenuColor%>">
         <li class=" dropdown"   style="background-color:<%=TopMenuColor%>">
              <a class="menu2" href="/default.asp" id="dropdown07" aria-expanded="false">Home&nbsp;&nbsp;&nbsp;</a>
          </li>

            <li class=" dropdown">
            <a class="menu2 dropdown-toggle " href="#" id="A1" data-bs-toggle="dropdown" aria-expanded="false">Livestock</a>
            <ul class="dropdown-menu" aria-labelledby="dropdown07" style="background-color: <%=TopMenuColor%>">
                 <li><a class="menu2" href="/alpacas/">Alpacas</a></li>
                 <li><a class="menu2" href="/HoneyBees/">Bees</a></li>
                 <li><a class="menu2" href="/bison/">Bison</a></li>
                 <li><a class="menu2" href="/Buffalo/">Buffalo</a></li>
                 <li><a class="menu2" href="/camels/">Camels</a></li>
                 <li><a class="menu2" href="/cattle/">Cattle</a></li>
                 <li><a class="menu2" href="/chickens/">Chickens</a></li>
                 <li><a class="menu2" href="/Crocodiles/">Crocodiles & &nbsp;&nbsp;Alligators</a></li>
                 <li><a class="menu2" href="/deer/">Deer</a></li>
                 <li><a class="menu2" href="/Donkeys/">Donkeys</a></li>
                 <li><a class="menu2" href="/Ducks/">Ducks</a></li>
                 <li><a class="menu2" href="/Emus/">Emus</a></li>
                 <li><a class="menu2" href="/geese/">Geese</a></li>
                 <li><a class="menu2" href="/Goats/">Goats</a></li>
                 <li><a class="menu2" href="/guineafowl/">Guinea Fowl</a></li>
                 <li><a class="menu2" href="/Horses/">Horses</a></li>
                 <li><a class="menu2" href="/Llamas/">Llamas</a></li>
                 <li><a class="menu2" href="/muskox/">Musk Ox</a></li>
                 <li><a class="menu2" href="/ostriches/">Ostriches</a></li>
                 <li><a class="menu2" href="/pheasants/">Pheasants</a></li>
                 <li><a class="menu2" href="/pigeons/">Pigeons</a></li>
                 <li><a class="menu2" href="/pigs/">Pigs</a></li>
                 <li><a class="menu2" href="/quail/">Quail</a></li>
                 <li><a class="menu2" href="/Rabbits/">Rabbits</a></li>
                 <li><a class="menu2" href="/Sheep/">Sheep</a></li>
                 <li><a class="menu2" href="/Snails/">Snails</a></li>
                 <li><a class="menu2" href="/Turkeys/">Turkeys</a></li>
                 <li><a class="menu2" href="/Yaks/">Yaks</a></li>
            </ul>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            </li>

             <li><a class="menu2" href="/Aboutus.asp">About LOTW</a></li>
             <li><a class="menu2" href="/Contactus.asp" >Contact Us</a></li>

        </ul>
      </div>
    </div>



   <% ' XS and SM navigation  %>
    <div class="container-fluid d-lg-none ">
     <a href="/Default.asp" class="webheader"><img src="<%=CurrentLogo %>" align="center" width="220" alt="<%=CurrentWebsite %>"></a>
     <a class="navbar-brand me-auto" style="margin-left: 10px" href="#"></a>


    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarTogglerDemo01" aria-controls="navbarTogglerDemo01" aria-expanded="false" aria-label="Toggle navigation" >
    <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarTogglerDemo01">
        <ul class="navbar-nav me-auto mb-2 mb-lg-0">
           <li class="nav-item dropdown">
            <a class="menu3 dropdown" href="/default.asp" id="dropdown07"  aria-expanded="false" style="text-align: left;">Home</a>
          </li>
           <li class=" dropdown">
            <a class="menu3 dropdown-toggle " href="#" id="A1" data-bs-toggle="dropdown" aria-expanded="false">Livestock</a>
            <ul class="dropdown-menu" aria-labelledby="dropdown07" style="background-color: <%=TopMenuColor%>">
                 <li><a class="menu3" href="/alpacas/">Alpacas</a></li>
                 <li><a class="menu3" href="/HoneyBees/">Bees</a></li>
                 <li><a class="menu3" href="/bison/">Bison</a></li>
                 <li><a class="menu3" href="/Buffalo/">Buffalo</a></li>
                 <li><a class="menu3" href="/camels/">Camels</a></li>
                 <li><a class="menu3" href="/cattle/">Cattle</a></li>
                 <li><a class="menu3" href="/chickens/">Chickens</a></li>
                 <li><a class="menu3" href="/Crocodiles/">Crocodiles & &nbsp;&nbsp;Alligators</a></li>
                 <li><a class="menu3" href="/deer/">Deer</a></li>
                 <li><a class="menu3" href="/Donkeys/">Donkeys</a></li>
                 <li><a class="menu3" href="/Ducks/">Ducks</a></li>
                 <li><a class="menu3" href="/Emus/">Emus</a></li>
                 <li><a class="menu3" href="/geese/">Geese</a></li>
                 <li><a class="menu3" href="/Goats/">Goats</a></li>
                 <li><a class="menu3" href="/guineafowl/">Guinea Fowl</a></li>
                 <li><a class="menu3" href="/Horses/">Horses</a></li>
                 <li><a class="menu3" href="/Llamas/">Llamas</a></li>
                 <li><a class="menu3" href="/muskox/">Musk Ox</a></li>
                 <li><a class="menu3" href="/ostriches/">Ostriches</a></li>
                 <li><a class="menu3" href="/pheasants/">Pheasants</a></li>
                 <li><a class="menu3" href="/pigeons/">Pigeons</a></li>
                 <li><a class="menu3" href="/pigs/">Pigs</a></li>
                 <li><a class="menu3" href="/quail/">Quail</a></li>
                 <li><a class="menu3" href="/Rabbits/">Rabbits</a></li>
                 <li><a class="menu3" href="/Sheep/">Sheep</a></li>
                 <li><a class="menu3" href="/Snails/">Snails</a></li>
                 <li><a class="menu3" href="/Turkeys/">Turkeys</a></li>
                 <li><a class="menu3" href="/Yaks/">Yaks</a></li>
            </ul>
            </li>
            <li class=" dropdown">
            <a class="menu3 dropdown-toggle " href="#" id="A5" data-bs-toggle="dropdown" aria-expanded="false">About&nbsp;</a>
            <ul class="dropdown-menu" aria-labelledby="dropdown07" style="background-color: <%=TopMenuColor%>">
             <li><a class="menu3" href="/Aboutus.asp">About This Website</a></li>
             <li><a class="menu3" href="/AboutLOTW.asp" >About Livestock Of The World</a></li>
             <li><a class="menu3" href="/Contactus.asp" >Contact Us</a></li>
            </ul>
          </li>      


      <br />

    

        <li class="dropdown">
           <a class="menu3 " href="https://www.HarvestHub.world/login.asp" aria-expanded="false">Sign In</a>
        </li>
        <li class="dropdown">
           <a class="menu3" href="https://www.livestockoftheworld.com/Join/USA/SetupAccountPlus.asp" aria-expanded="false">Join</a>
        </li>

        </ul></div></div></div>
    </div>
        </div>
    </div>
</div>
</div>
</div>
<!--#Include file="BreedsOfLivestock/BreedsOfLivestockHeader.asp"-->