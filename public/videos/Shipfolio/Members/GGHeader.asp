
<link href="https://www.Globallivestocksolutions.com/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="/includefiles/Style.css">
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
CurrentLogo = "https://www.globallivestocksolutions.com/Logos/GlobalGrangelogoHorizontal.png"
TopMenuColor = "#ddd"
      %>
<div class="container-fluid d-none d-lg-block">
  <div class="row">
    <!-- First column spanning 2 rows -->
    <div class="col-md-2" style="max-width:230px; min-width:230px;">
      <div class="row" >
        <div class="col-md-12" rowspan="2" style="align-items: flex-end;"><a href="https://www.GlobalGrange.world"><img src="<%=CurrentLogo %>" valign="bottom" align="center" class ="menuX" border ="0" height="45" style="padding-top:2px; margin-top:2px" alt="Livestock Of Canada"></a></div>
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
        <div class="col-md-12" style="background-color:#f0f0f0; max-width:110px; min-height: 34px">
          &nbsp;&nbsp;&nbsp;<a href="https://www.GlobalGrange.world/Landing/Ranchers.asp" class ="menuX">Ranchers</a>
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
          &nbsp;&nbsp;<a href="https://www.AgricultureAssociations.World" class ="menuX">Associations</a>
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
            <a href="https://www.HarvestHub.world/login.asp"  class ="menuX">Sign In |</a>
            <a href="https://www.harvesthub.world/Join/"  class ="menuX">Join </a>     
            <a href="https://www.HarvestHub.world" class ="menuX" >
                    
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

<div class="container-fluid d-none d-lg-block">
      <div class="row" style="min-height: 30px; background-color:#f0f0f0">
          <div class="col-md-2" style="width: 130px;">&nbsp;<a href="#" class ="menuX"></a></div>
        <div class="col-md-2" style="width: 100px;">&nbsp;<a href="https://www.LivestockofAmerica.com" class ="menuX">America</a></div>
        <div class="col-md-2" style="width: 110px;">&nbsp;&nbsp;&nbsp;&nbsp;<a href="https://www.LivestockofCanada.ca" class ="menuX">Canada</a></div>
        <div class="col-md-2" style="width: 100px;">&nbsp;&nbsp;&nbsp;<a href="https://www.LivestockofTheWorld.com" class ="menuX">LOTW </a></div>
        <div class="col-md-2" style="width: 120px; background-color: #ddd">&nbsp;&nbsp;&nbsp;<a href="https://www.HarvestHub.world" class ="menuX">Harvest Hub</a></div>
        <div class="col" align="right" style="margin:0px; padding: 0px"><div style=" max-width:110px; min-height:30px; margin:0px; padding: 0px" align="right"><a href="https://www.GlobalGrange.world" class ="menuX" >Global Grange &nbsp;&nbsp;</a></div></div></div>
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


 
       <li class=" dropdown"   style="background-color:<%=TopMenuColor%>">
            <a class="menu2" href="/AboutHH.asp"  id="A2"  aria-expanded="false">About</a>
          </li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <li class=" dropdown"   style="background-color:<%=TopMenuColor%>">
            <a class="menu2" href="/Invest/Default.asp"  id="A2"  aria-expanded="false">Invest</a>
          </li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              <li class=" dropdown"   style="background-color:<%=TopMenuColor%>">
            <a class="menu2" href="/Advertise.asp"  id="A2"  aria-expanded="false">Advertise</a>
          </li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 


        </ul>
      </div>
    </div>



<% ' XS and SM navigation  %>
    <div class="container-fluid d-lg-none ">
     <a href="/Default.asp" class="webheader"><img src="<%=CurrentLogo %>" align="center" width="220" alt="Harvest Hub"></a>
     <a class="navbar-brand me-auto" style="margin-left: 10px" href="#"></a>


    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarTogglerDemo01" aria-controls="navbarTogglerDemo01" aria-expanded="false" aria-label="Toggle navigation" >
    <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarTogglerDemo01">
        <ul class="navbar-nav me-auto mb-2 mb-lg-0">
           <li class="nav-item dropdown">
            <a class="menu3 dropdown" href="/members/default.asp" id="dropdown07"  aria-expanded="false" style="text-align: left;">Dashboard</a>
          </li>

           
  



           <li class="nav-item dropdown">
            <a class="menu3 dropdown-toggle" href="#" id="A2" data-bs-toggle="dropdown" aria-expanded="false">For Ranchers</a>
            <ul class="dropdown-menu" aria-labelledby="dropdown07" style="background-color: <%=TopMenuColor%>">
                  <li><a class="menu3" href="https://www.LivestockOfAmerica.com">Livestock Of America</a></li>
                 <li><a class="menu3" href="https://www.LivestockOfCanada.ca">Livestock Of Canada</a></li>
                 <li><a class="menu3" href="Https://www.LivestockOfTheWorld.com">Livestock Of The World</a></li>
             </ul>
          </li>

           <li class="nav-item dropdown">
            <a class="menu3 dropdown-toggle" href="#" id="A3" data-bs-toggle="dropdown" aria-expanded="false">For Associations</a>
            <ul class="dropdown-menu" aria-labelledby="dropdown07" style="background-color: <%=TopMenuColor%>">
                 <li><a class="menu3" href="https://www.agricultureassociations.world">Agriculture Associations<br />of the World</a></li>
             </ul>
          </li>
       


        <li class="nav-item dropdown">
           <a class="menu3 " href="https://www.HarvestHub.world" aria-expanded="false">Harvest Hub</a>
        </li>
        <li class="nav-item dropdown">
           <a class="menu3 " href="https://www.HarvestHub.world/login.asp" aria-expanded="false">Sign In</a>
        </li>
        <li class="nav-item dropdown">
           <a class="menu3" href="https://www.HarvestHub.world/Join/" aria-expanded="false">Join</a>
        </li>
     <li class=" dropdown"   style="background-color:<%=TopMenuColor%>">
            <a class="menu3" href="/Invest/Default.asp"  id="A2"  aria-expanded="false">Invest</a>
          </li>
              <li class=" dropdown"   style="background-color:<%=TopMenuColor%>">
            <a class="menu3" href="/Advertise.asp"  id="A2"  aria-expanded="false">Advertise</a>
          </li>

        </ul></div></div></div>
    </div>
        </div>
    </div>
</div>
</div>
</div>





<% TopMenuColor="#e59a22"
   FooterColor="#e59a22" %>



<nav class="navbar navbar-expand-lg navbar-light bg-light justify-content-center" style="max-width:1200px; background-color:<%=menu2Color%>" >
    <div class="container-fluid d-none d-lg-block">
      <div class="collapse navbar-collapse justify-content-center" id="navbarCenteredExample" >
        <ul class="navbar-nav me-auto mb-2 mb-lg-0" >
          <a href="/Default.asp" class="webheadertop"><img src="https://www.globallivestocksolutions.com/images/px.gif" height="50" width = "5">
              <img src="https://www.globallivestocksolutions.com/Logos/GlobalGrangelogoHorizontal.png" valign="bottom" height="50" alt="Global Grange Inc.">&nbsp;&nbsp;&nbsp;</a>


            
        <li class=" dropdown "><img src ="https://www.globallivestocksolutions.com/images/px.gif" width = 100% height = 23/><br/>
            <a class="menu2 dropdown-toggle " href="#" id="A2" data-bs-toggle="dropdown" aria-expanded="false">Coming Soon</a>
            <ul class="dropdown-menu " aria-labelledby="dropdown07">
                <li><a class="menu2" href="AboutLivestockOfCanada.asp" >Livestock Of Canada</a></li>
                <li><a class="menu2" href="AboutWorldFarmStore.asp" >World Farm Store</a></li>
              
                
            </ul>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        </li>

        <li class=" dropdown "><img src ="https://www.globallivestocksolutions.com/images/px.gif" width = 100% height = 23/><br/>
            <a class="menu2 dropdown-toggle " href="#" id="A2" data-bs-toggle="dropdown" aria-expanded="false">Community Sites</a>
            <ul class="dropdown-menu " aria-labelledby="dropdown07" >
                <li><a class="menu2" target="_blank" href="https://www.GlobalGrange.World" >Global Grange</a></li>
                <li><a class="menu2" target="_blank"  href="https://www.LivestockOfAmerica.com" >Livestock Of America</a></li>
                <li><a class="menu2" target="_blank"  href="https://www.livestockoftheworld.com/" >Livestock Of The World</a></li>
                <li><a class="menu2" target="_blank"  href="https://www.agricultureassociations.world" >Agriculture Associations <small>of the</small> World</a><br />
                    <img src ="/images/px.gif" width = 275 height = 12/></li>
            </ul>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        </li>
<script type="text/javascript">
    (function (c, l, a, r, i, t, y) {
        c[a] = c[a] || function () { (c[a].q = c[a].q || []).push(arguments) };
        t = l.createElement(r); t.async = 1; t.src = "https://www.clarity.ms/tag/" + i;
        y = l.getElementsByTagName(r)[0]; y.parentNode.insertBefore(t, y);
    })(window, document, "clarity", "script", "gxa8o25uwr");
</script>





        </ul>
     </div>
</div>
<% ' XS and SM navigation  %>
<div class="container-fluid d-lg-none">
<a href="/Default.asp" class="webheader"><img src="https://www.globallivestocksolutions.com/Logos/GlobalGrangelogoHorizontal.png" align="center" height="50" alt="Global Grange inc."></a>
<a class="navbar-brand me-auto" style="margin-left: 20px" href="#"></a>




<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarTogglerDemo01" aria-controls="navbarTogglerDemo01" aria-expanded="false" aria-label="Toggle navigation" >
<span class="navbar-toggler-icon"></span>
</button>
<div class="collapse navbar-collapse" id="navbarTogglerDemo01">
 <ul style=" list-style-type: none;">

 
<li class="nav-item dropdown ">
    <a class="menu3 dropdown-toggle " href="#" id="A6" data-bs-toggle="dropdown" aria-expanded="false"  style="list-style-type: none;">Community Sites</a>
    <ul class="dropdown-menu " aria-labelledby="dropdown07" style=" list-style-type: none;">
    <li><a class="menu3" target="_blank"  href="https://www.GlobalGrange.World">Global Grange</a></li>
    <li><a class="menu3" target="_blank"  href="https://www.LivestockOfAmerica.com" >Livestock Of America</a></li>
    <li><a class="menu3" target="_blank"  href="https://www.livestockoftheworld.com" >Livestock Of The World</a></li>
    <li><a class="menu3" target="_blank"  href="https://www.agricultureassociations.world" >Agriculture Associations <small>of the</small> World</a><br />
                    <img src ="/images/px.gif" width = 275 height = 12/></li>
    </ul>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</li>

             <li class=" dropdown ">
            <a class="menu3 dropdown-toggle " href="#" id="A2" data-bs-toggle="dropdown" aria-expanded="false">Coming Soon</a>
            <ul class="dropdown-menu " aria-labelledby="dropdown07" >
                <li><a class="menu3" href="GlobalFarmersMarket.asp" >Global Farmers Market</a></li>
                <li><a class="menu3" href="AboutLivestockOfCanada.asp" >Livestock Of Canada</a></li>
                <li><a class="menu3" href="AboutWorldFarmStore.asp" >World Farm Store</a><img src ="/images/px.gif" width = 265 height = 1/></li>
                
            </ul>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        </li>


</ul></div></div></nav>

<script type="text/javascript">
    (function (c, l, a, r, i, t, y) {
        c[a] = c[a] || function () { (c[a].q = c[a].q || []).push(arguments) };
        t = l.createElement(r); t.async = 1; t.src = "https://www.clarity.ms/tag/" + i;
        y = l.getElementsByTagName(r)[0]; y.parentNode.insertBefore(t, y);
    })(window, document, "clarity", "script", "gxa8o25uwr");
</script>





