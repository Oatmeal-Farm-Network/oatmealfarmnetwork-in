<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!--#Include virtual="/includefiles/globalvariables.asp"-->
<link rel="canonical" href="<%=currenturl %>" />

<% 'response.redirect("https://www.harvesthub.world/Join/USA/Default.asp") %>
<title>Join The Global Farmers' Market</title>
<meta name="title" content="Join The Global Farmers' Market Community"/> 
<meta name="description" content=""/>  
<meta charset="UTF-8">
<meta name="revisit-after" content="7 Days"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<% homepage = true %>
<!--#Include virtual="/Header.asp"-->
 <div class="container-fluid" id="grad1" >
    <div align = center>
     <div class = "container" style="max-width: 1400px; min-height: 67px; text-align: center;">
    <div>
      <div class = "body">
        <h1>Join Our Community</h1>
          </div>
        </div>
    </div>
    </div>
 </div>







<a name = "Top"></a>
<div class="container ">
  <div class = "  row d-flex  align-items-center justify-content-center"  >
      <img src="AllAccountsHeader.jpg" width ="100%" alyt="Farm Memberships"/>
<br />
<h2><br /><br />Membership Categories</h2>
If you grow food, cook food, or just about anything in between, then we have membership options that will fit your needs.<br /><br />

<div class="row">
  <div class="col-md-3 col-sm-6 roundedtopandbottom" style="background-image: URL(FarmOrderBackground.png); min-height: 300px" ><h2><center>Farm / Ranch<br /> Membership Options</center></h2>

Do you grow food or raise animals. Do you produce fiber, wool, feathers, leather, or grain. Do you help produce the raw ingredients that feed and cloth the human race?<br /><br />

      <form action="/Join/USA/FarmAccounts.asp" method="post">
  <input type="hidden" name="value" value="SELECT">
  <div align =" Right"><button type="submit" class="regsubmit2"><b>Membership Options</b></button></div>
</form>
<br />

</div>
  <div class="col-md-3 col-sm-6 roundedtopandbottom" style="background-image: URL(FoodHubOrderrBackground.png); min-height: 300px" ><h2><center>Food Hub<br /> Membership Options</center></h2>

Are you passionate about getting local food onto plates? Are you dedicated to supporting local, community agriculture, and food production?<br /><br />

      <form action="/Join/USA/FoodHubAccounts.asp" method="post">
  <input type="hidden" name="value" value="SELECT">
<div align =" Right"><button type="submit" class="regsubmit2"><b>Membership Options</b></button></div>
</form>
<br /></div>
  <div class="col-md-3 col-sm-6 roundedtopandbottom"   style="background-image: URL(ArtisanrderBackground.png); min-height: 300px" ><h2><center>Artisan Food Producer<br /> Membership Options</center></h2>

Do you take raw ingredients and transform them into something miraculous like pasta, bread, tea, or ice cream?<br /><br />

      <form action="/Join/USA/ArtisanAccounts.asp" method="post">
  <input type="hidden" name="value" value="SELECT">
<div align =" Right"><button type="submit" class="regsubmit2"><b>Membership Options</b></button></div>
</form>
<br /></div>
  <div class="col-md-3 col-sm-6 roundedtopandbottom" style="background-image: URL(RestaurantOrderBackground.png); min-height: 300px"><h2><center>Restaurant<br /> Membership Options</center></h2>

        Do you grow food or raise animals. Do you produce fiber, wool, feathers, leather, or grain. Do you help produce the raw ingredients that feed and cloth the human race?<br /><br />

      <form action="/Join/USA/RestaurantAccounts.asp" method="post">
  <input type="hidden" name="value" value="SELECT">
<div align =" Right"><button type="submit" class="regsubmit2"><b>Membership Options</b></button></div>
</form>
<br /></div>
</div>
      </div>
<div>
    <div>
        <br />

    </div>
</div>
 <div class="col roundedtopandbottom" style="background-image: URL(RestaurantOrderBackground.png)">
     
     <h2><center>Other<br /> Membership Options</center></h2>

        Are you involved in a Crafters Organization, Fiber Cooperative, Fiber Mill, Livestock Association, Manufacturer, Marina, Meat Wholesaler, Retailer, Service Provider, Veterinarian, or other ag or food related organization? If so then, this is probably the best option for you.
<br /><br />

      <form action="/Join/USA/OtherAccounts.asp" method="post">
  <input type="hidden" name="value" value="SELECT">
<div align =" Right"><button type="submit" class="regsubmit2"><b>Membership Options</b></button></div>
          <br /><br />
</form>
</div>
</div>




  </div>



            <br /><br />
            <center>
<h3>Already Have an Membership?</h3>
<center><a href = "/Login.asp" class = "body">Sign In here</a>.</center>
<br />

         <% if ShowAssociations = True then  %>
            <h3>Already Have an Association Membership?</h3>
            <center><a href = "https://www.livestockassociations.com/associationadmin/associationLogin.asp" class = "body" target = "_blank">Sign In here</a>.</center>
            <br />
         <% end if %>
<br />
</center>



</div>


<!--#Include virtual="/Footer.asp"-->