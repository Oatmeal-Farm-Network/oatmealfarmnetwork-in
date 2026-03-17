<!--#Include file="associationSecurityInclude.asp"-->
<% PeopleID = Session("PeopleID")

if len(PeopleID) < 1 then
PeopleID = request.QueryString("PeopleID")
end if


CurrentPeopleID = PeopleID

AssociationID = Session("AssociationID")

if len(AssociationID) < 1 then
AssociationID = request.QueryString("AssociationID")
end if

currentdate = now

%>

<link rel="canonical" href="https://getbootstrap.com/docs/5.0/examples/navbars/">
  
<!-- Bootstrap core CSS -->
<link href="/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="/includefiles/Style.css">
  
<style>
/***Navbar Background Color, Border Removed ,Border Radius Sqaure***/

.navbar.navbar-custom {
  background: #354800;
  border: none;
  border-radius: 0;
}
/***Link Color***/

.navbar.navbar-custom .navbar-nav > li > a {
  color: #F3E9CD;
}
/***Link Color Hover Statr***/

.navbar.navbar-custom .navbar-nav > li > a:hover {
  color: #F3E9CD;
}
/***Link Background and Color Active State***/

.navbar.navbar-custom .navbar-nav > .active,
.navbar.navbar-custom .navbar-nav > .active > a,
.navbar.navbar-custom .navbar-nav > .active > a:hover,
.navbar.navbar-custom .navbar-nav > .active > a:focus {
  background: #354800;
  color: #F3E9CD;
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
  background: #354800;
  color: #F3E9CD;
}
/***Dropdown-menu Background Color***/

.navbar.navbar-custom .dropdown-menu {
  background: #354800;
  border: none;
}
/***Dropdown-menu Color***/

.navbar.navbar-custom .dropdown-menu > li > a {
  color: #F3E9CD;
}
/***Dropdown-menu Color Hover and Focus State***/

.navbar.navbar-custom .dropdown-menu > li > a:hover,
.navbar.navbar-custom .dropdown-menu > li > a:focus {
  color: #F3E9CD;
  background: #354800;
}
/***Toggle Button***/

.navbar.navbar-custom .navbar-header .navbar-toggle {
  border-color: green;
}
/***Toggle Button Hover and Focus State***/

.navbar.navbar-custom .navbar-header .navbar-toggle:hover,
.navbar.navbar-custom .navbar-header .navbar-toggle:focus {
  background: #354800;
  border: white;
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
    background: #354800;
  }
}

 .nav-link
{ 
    font-size : 30px;
	line-height : 60px;
}

.dropdown-item 
{ 
    font-size : 30px;
	line-height : 60px;
}

H1{
	font-family : verdana, Arial, Helvetica, sans-serif;
	font-size : 20px;
	color: #232f3a;
	line-height : 29px;
	font-weight : 300;
	margin-left: 0px;
	margin-bottom: 10px;
	margin-top: 10px;
	text-align: left ;
}

H1:after
{
    content:' ';
    display:block;
    border:1px solid black;
}



</style>

<!-- Google tag (gtag.js) -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-140663806-1"></script>
<script>
    window.dataLayer = window.dataLayer || [];
    function gtag() { dataLayer.push(arguments); }
    gtag('js', new Date());

    gtag('config', 'UA-140663806-1');
</script>


</head>

<body>
 <header role="banner">
   <div class = "row">
   <div class="col-sm-4">

   </div>
  <div class="col-sm-4">
    <center><a href="/Default.asp" class="webheader"><img src="/Logos/LALogo.png" align="center" height="110" alt="Livestock Associations & Registrars"></a><br /></center>
  </div>
  <div class="col-lg-1 d-none d-lg-block "><br /><br /><br /><a href = "/associationadmin/associationLogout.asp" class = body><b>Sign Out</b></a></div>

</div>

<nav class="navbar navbar-expand-lg navbar-dark navbar-custom" style="background-color: #354800;">

<% ' lg+ navigation  %>
    <div class="container d-none d-lg-block">
      <div class="collapse navbar-collapse" id="navbarsExample07">
        <ul class="navbar-nav me-auto mb-2 mb-lg-0">
           <li class="menu2 dropdown">
            <a class="menu2" href="/associationadmin/default.asp" id="dropdown07"  aria-expanded="false">Dashboard!&nbsp;&nbsp;&nbsp;</a>
          </li>
          <li class=" dropdown">
            <a class="menu2 dropdown-toggle " href="#" id="dropdown07" data-bs-toggle="dropdown" aria-expanded="false" >Members</a>
            <ul class="dropdown-menu" aria-labelledby="dropdown07">
                 <li><a class="menu2" href="AssociationEditMembers.asp">Summary</a></li>
                 <li><a class="menu2" href="AssociationRemoveUser.asp" >Remove Accounts</a></li>
                 <li><img src = "/images/px.gif" height = 0 width = 140 /></li>
            </ul>
          </li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <li class="dropdown">
            <a class="menu2 dropdown-toggle " href="#" id="dropdown07" data-bs-toggle="dropdown" aria-expanded="false">Account</a>
            <ul class="dropdown-menu " aria-labelledby="dropdown07">
                 <li><a class="menu2" href="AssociationListingEdit.asp" >Summary</a></li>
                 <li><a class="menu2" href="AssociationAddMembers.asp" >Add Member</a></li>
                 <li><a class="menu2" href="http://www.livestockasssociations.com/" >Associations</a></li>
            <li><img src = "/images/px.gif" height = 0 width = 140 /></li>
            </ul>
          </li>
          
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
             <li class=" dropdown">
            <a class="menu2" href="/Contactus.asp"  id="dropdown07"  aria-expanded="false" onMouseOver="this.style.color='#ffffff'"
onMouseOut="this.style.color='#F3E9CD'">Contact Us</a>
          </li>
        
          
        </ul>

     
      
      </div>
    </div>

<% ' XS and SM navigation  %>
    <div class="container d-lg-none">
      <a class="navbar-brand" href="#"></a>
        <button class="navbar-inverse navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarsExample07" aria-controls="navbarsExample07" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>

      <div class="collapse navbar-collapse" id="navbarsExample07">
        <ul class="navbar-nav me-auto mb-2 mb-lg-0">
           <li class="nav-item dropdown">
            <a class="nav-link" href="/default.asp" id="dropdown07"  aria-expanded="false">Home</a>
          </li>

             <li class="nav-item dropdown ">
            <a class="nav-link dropdown-toggle " href="#" id="dropdown07" data-bs-toggle="dropdown" aria-expanded="false">Affiliate Websites</a>
            <ul class="dropdown-menu " aria-labelledby="dropdown07">
                 <li><a class="dropdown-item" href="https://www.LivestockOfAmerica.com">America</a></li>
                 <li><a class="dropdown-item" href="https://www.LivestockOfCanada.com">Canada</a></li>
                 <li><a class="dropdown-item" href="https://www.LivestockAssociations.com">Associations</a></li>
            </ul>
          </li>
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle " href="#" id="dropdown07" data-bs-toggle="dropdown" aria-expanded="false">Associations</a>
            <ul class="dropdown-menu" aria-labelledby="dropdown07">
                 <li><a class="dropdown-item" href="/alpacas/">Alpacas</a></li>
                  <li><a class="dropdown-item" href="/AssociationDirectory/Default.asp?SpeciesID=2">Alpacas</a></li>
                 <li><a class="dropdown-item" href="/AssociationDirectory/Default.asp?SpeciesID=9">Bison</a></li>
                 <li><a class="dropdown-item" href="/AssociationDirectory/Default.asp?SpeciesID=8">Cattle</a></li>
                   <li><a class="dropdown-item" href="/AssociationDirectory/Default.asp?SpeciesID=18">Camels</a></li>
                 <li><a class="dropdown-item" href="/AssociationDirectory/Default.asp?SpeciesID=13">Chickens</a></li>
                 <li><a class="dropdown-item" href="/AssociationDirectory/Default.asp?SpeciesID=3">Working Dogs</a></li>
                 <li><a class="dropdown-item" href="/AssociationDirectory/Default.asp?SpeciesID=7">Donkeys</a></li>
                     <li><a class="dropdown-item" href="/AssociationDirectory/Default.asp?SpeciesID=19">Ducks</a></li>
                 <li><a class="dropdown-item" href="/AssociationDirectory/Default.asp?SpeciesID=19">Emus</a></li>
                 <li><a class="dropdown-item" href="/AssociationDirectory/Default.asp?SpeciesID=6">Goats</a></li>
                 <li><a class="dropdown-item" href="/AssociationDirectory/Default.asp?SpeciesID=23">Honey Bees</a></li>
                 <li><a class="dropdown-item" href="/AssociationDirectory/Default.asp?SpeciesID=5">Horses</a></li>
                 <li><a class="dropdown-item" href="/AssociationDirectory/Default.asp?SpeciesID=4">Llamas</a></li>
                 <li><a class="dropdown-item" href="/AssociationDirectory/Default.asp?SpeciesID=12">Pigs</a></li>
                 <li><a class="dropdown-item" href="/AssociationDirectory/Default.asp?SpeciesID=11">Rabbits</a></li>
                 <li><a class="dropdown-item" href="/AssociationDirectory/Default.asp?SpeciesID=10">Sheep</a></li>
                 <li><a class="dropdown-item" href="/AssociationDirectory/Default.asp?SpeciesID=14">Turkeys</a></li>
                 <li><a class="dropdown-item" href="/AssociationDirectory/Default.asp?SpeciesID=17">Yaks</a></li>
            </ul>
          </li>
          <li class="nav-item dropdown">
            <a class="nav-link " href="/Contactus.asp"  id="dropdown07"  aria-expanded="false">Contact Us</a>
          </li>
           <li class="nav-item dropdown">
             <a class="nav-link " href="/associationadmin/associationLogin.asp" ><b>Sign In</b></a>
          </li>
           <li class="nav-item dropdown">
             <a class="nav-link " href="/associationadmin/SetupAssociationAccountStep1.asp" ><b>Join</b></a>
          </li>
        </ul>

     
      
      </div>
    </div>

  </nav>


</header>


 <main role="main" class="container">
 <div class = "row" >
   <div class="col-12 bg-light" style="min-height: 600px" valign:top>
