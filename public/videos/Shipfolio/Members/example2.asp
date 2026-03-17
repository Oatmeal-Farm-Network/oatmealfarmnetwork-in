<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="John Andresen">
    <meta name="generator" content="LOTW">
    <title>Livestock Of The World</title>
<!--#Include file="MembersGlobalVariables.asp"-->

    <link rel="canonical" href="https://getbootstrap.com/docs/5.0/examples/navbars/">
    <!-- Custom styles for this template -->
    <link href="navbar.css" rel="stylesheet">
    

    <!-- Bootstrap core CSS -->
<link href="/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="/includefiles/Style.css">
    <style>
      .bd-placeholder-img {
        font-size: 1.125rem;
        text-anchor: middle;
        -webkit-user-select: none;
        -moz-user-select: none;
        user-select: none;
      }

      @media (min-width: 768px) {
        .bd-placeholder-img-lg {
          font-size: 3.5rem;
        }
      }
      
      
      .navbar.navbar-custom {
  background: #893333;
  border: none;
  border-radius: 0;
}


<style>
/***Navbar Background Color, Border Removed ,Border Radius Sqaure***/

.navbar.navbar-custom {
  background: #893333;
  border: none;
  border-radius: 0;
}
/***Link Color***/

.navbar.navbar-custom .navbar-nav > li > a {
  color: white;
}
/***Link Color Hover Statr***/

.navbar.navbar-custom .navbar-nav > li > a:hover {
  color: white;
}
/***Link Background and Color Active State***/

.navbar.navbar-custom .navbar-nav > .active,
.navbar.navbar-custom .navbar-nav > .active > a,
.navbar.navbar-custom .navbar-nav > .active > a:hover,
.navbar.navbar-custom .navbar-nav > .active > a:focus {
  background: #893333;
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
  background: #893333;
  color: white;
}
/***Dropdown-menu Background Color***/

.navbar.navbar-custom .dropdown-menu {
  background: #893333;
  border: none;
}
/***Dropdown-menu Color***/

.navbar.navbar-custom .dropdown-menu > li > a {
  color: white;
}
/***Dropdown-menu Color Hover and Focus State***/

.navbar.navbar-custom .dropdown-menu > li > a:hover,
.navbar.navbar-custom .dropdown-menu > li > a:focus {
  color: white;
  background: #893333;
}
/***Toggle Button***/

.navbar.navbar-custom .navbar-header .navbar-toggle {
  border-color: green;
}
/***Toggle Button Hover and Focus State***/

.navbar.navbar-custom .navbar-header .navbar-toggle:hover,
.navbar.navbar-custom .navbar-header .navbar-toggle:focus {
  background: #893333;
  border: white;
}
/***Collapse Borders***/

.navbar.navbar-custom .navbar-collapse {
  border: none;
}
@media (max-width: 767px) {
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
</head>

<body>
<main>

 <header role="banner">
   <div class = "row">
   <div class="col-sm-4">

   </div>
  <div class="col-sm-4">
    <center><a href="/Default.asp?Screenwidth=<%=Screenwidth %>" class="webheader"><img src="/images/LOTWLogoMenu.png" align="center" width="210" alt="Livestock Of The World"></a><br /></center>
  </div>
  <div class="col-lg-1 d-none d-lg-block "><br /><a href = "https://www.livestockofamerica.com/" target = "_blank"><img id="logo-main" src="/images/LOALogo.png" width="90" alt="Livestock Of America"></a></div>
  <div class="col-lg-1 d-none d-lg-block "><br /><a href = "https://www.livestockofCanada.ca/" target = "_blank"><img id="logo-main" src="/images/LOCLogo.png" width="120" alt="Livestock Of Canada"></a></div>
  <div class="col-lg-2 d-none d-lg-block ">  </div>
</div>

<nav class="navbar navbar-expand-lg navbar-dark navbar-custom" style="background-color: #893333;">


    <div class="container">
      <a class="navbar-brand" href="#"></a>
        <button class="navbar-inverse navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarsExample07" aria-controls="navbarsExample07" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>

      <div class="collapse navbar-collapse" id="navbarsExample07">
        <ul class="navbar-nav me-auto mb-2 mb-lg-0">
           <li class="nav-item dropdown">
            <a class="nav-link " href="/members/default.asp" id="dropdown07"  aria-expanded="false">Home</a>
          </li>

             <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle " href="#" id="dropdown07" data-bs-toggle="dropdown" aria-expanded="false">Animals</a>
            <ul class="dropdown-menu" aria-labelledby="dropdown07">
                 <li><a class="menu2" href="/members/MembersAnimalsHome.asp">List Of Animals</a></li>
                 <li><a class="menu2" href="/Members/MemberseditAnimal.asp">Edit Listing</a></li>
                 <li><a class="menu2" href="/Members/MembersPhotos.asp">Photos</a></li>
                 <li><a class="menu2" href="/Members/MembersdeleteAnimal.asp">Delete Animals</a></li>
                 <li><a class="menu2" href="/Members/MembersAnimalsStats.asp">Statistics</a></li>
            </ul>
          </li>

          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle " href="#" id="dropdown07" data-bs-toggle="dropdown" aria-expanded="false">Products</a>
            <ul class="dropdown-menu" aria-labelledby="dropdown07">
                 <li><a class="menu2" href="/members/MembersProductsHome.asp">List of Products</a></li>
                 <li><a class="menu2" href="/Members/MembersClassifiedAdPlace0.asp">Add a Product</a></li>
                 <li><a class="menu2" href="/Members/MembersEditAd.asp">Edit Product</a></li>
                 <li><a class="menu2"href="/Members/MembersProductPhotos.asp">Photos</a></li>
                 <li><a class="menu2" href="/Members/Membersdeletelisting.asp">Delete Product</a></li>
                 <li><a class="menu2" href="/Members/MembersServicesSuggestCategory.asp">Suggest Category</a></li>
                 <li><a class="menu2" href="/Members/MembersProductStats.asp">Statistics</a></li>

            </ul>
          </li>

         <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle " href="#" id="dropdown07" data-bs-toggle="dropdown" aria-expanded="false">Services</a>
            <ul class="dropdown-menu" aria-labelledby="dropdown07">
                 <li><a class="menu2" href="/members/MembersservicesHome.asp">List of Services</a></li>
                 <li><a class="menu2" href="/Members/membersServicesAddPage0.asp">Add a Service</a></li>
                 <li><a class="menu2" href="/Members/membersServicesEdit.asp">Edit Service</a></li>
                 <li><a class="menu2"href="/Members/membersServiceDelete.asp">Delete Service</a></li>
                 <li><a class="menu2" href="/Members/MembersPlaceClassifiedAd0.asp">Suggest Category</a></li>
                 <%' Hide  <li><a href="/Members/MembersServicesStats.asp">Statistics</a></li> %>
            </ul>
          </li>


         <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle " href="#" id="dropdown07" data-bs-toggle="dropdown" aria-expanded="false">Account</a>
            <ul class="dropdown-menu" aria-labelledby="dropdown07">
                 <li><a class="menu2" href="/members/MembersAccountContactsEdit.asp">My Account Info</a></li>
                 <li><a class="menu2"  href="/Members/MembersPasswordChange.asp">Reset Password</a></li>
                 <li><a class="menu2"  href="/Members/MembersAssociations.asp">Associations</a></li>
                <li><a class="menu2" href="/Members/MembersRenewSubscription.asp">Upgrade or Renew Your Membership</a></li>
            </ul>
          </li>

            <li class="nav-item dropdown">
              <a class="nav-link dropdown-toggle " href="#" id="dropdown07" data-bs-toggle="dropdown" aria-expanded="false">Ranch Profile</a>
              <ul class="dropdown-menu" aria-labelledby="dropdown07">
              <li><a class="menu2" href="/Members/MembersRanchhomeAdmin.asp">Home Page</a></li>
              <li><a class="menu2"  href="/Members/MembersPageData2.asp">About Us Page</a></li>
              <li><a class="menu2"  href="/Members/MemberssiteDesign.asp">Ranch Site Graphic Design</a></li>
            </ul>
          </li>
      
          <li class="nav-item dropdown">
            <a class="nav-link " href="/contactus.asp" target = "_blank" id="dropdown07"  aria-expanded="false">Contact Us</a>
          </li>
              <li class="nav-item dropdown">
            <a class="nav-link " href="/logout.asp"  id="dropdown07"  aria-expanded="false">Sign Out</a>
          </li>
        </ul>

      </div>
    </div>
  </nav>


</header>




<footer>
   <div class = "row">
   <div class="col-sm-4">
 <div class="col-lg-4 d-none d-lg-block copyright">&nbsp;&copy; LIvestock Of The World Enterprises, inc.  All Rights Reserved.</div>
   </div>
  <div class="col-sm-4">
    </div>
 </div>
 <script src="/dist/js/bootstrap.bundle.min.js"></script>
  <% set conn = nothing %>
 </footer>
</main>

      
  </body>
</html>
