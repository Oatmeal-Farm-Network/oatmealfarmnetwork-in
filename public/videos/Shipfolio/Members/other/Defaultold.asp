<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<% MasterDashboard= True %>
<!--#Include virtual="/Members/Membersglobalvariables.asp"-->
     <!--#Include file="SpeciesVariables.asp"-->

<% StateIndex = request.form("StateIndex") 
   if len(StateIndex) > 0 then
   else
   StateIndex = request.querystring("StateIndex")
   end if

    if len(StateIndex) > 0 and not (StateIndex=10000) and not (StateIndex=0) then
        statesort = " and StateIndex= " & StateIndex
    else
        statesort = " "
    end if
     %>
     <% 
     current = "The Other Directory" 
     Icon = "https://www.OatmealFarmnetwork.com/icons/Other.png"
      Businesstypeid = 3  %>

<link rel="canonical" href="<%=currenturl %>" />
<title>Other Directory - Discover Farm-to-Table Organizations | Global Farmers' Market</title>
<meta name="title" content="Other Directory - Discover Farm-to-Table Organizations | Global Farmers' Market" />
<meta name="description" content="Explore our comprehensive Other Directory to discover various farm-to-table organizations that are not farms, food hubs, food co-ops, restaurants, or artisan food producers. Connect with community resources, educational institutions, and more." />
<meta name="keywords" content="other directory, farm-to-table organizations, community resources, educational institutions, Global Farmers' Market" />
<meta name="author" content="Global Farmers' Market" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta name="robots" content="index, follow" />
<meta name="revisit-after" content="7 days" />
<meta charset="UTF-8" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

<!-- Open Graph Meta Tags for social media sharing -->
<meta property="og:title" content="Other Directory - Discover Farm-to-Table Organizations | Global Farmers' Market" />
<meta property="og:description" content="Explore our comprehensive Other Directory to discover various farm-to-table organizations that are not farms, food hubs, food co-ops, restaurants, or artisan food producers. Connect with community resources, educational institutions, and more." />
<meta property="og:image" content="https://www.GlobalFarmersMarket.world/images/other-directory.jpg" />
<meta property="og:url" content="https://www.globalfarmersmarket.world/other" />
<meta property="og:type" content="website" />

<!-- Twitter Card Meta Tags for social media sharing -->
<meta name="twitter:card" content="summary_large_image" />
<meta name="twitter:title" content="Other Directory - Discover Farm-to-Table Organizations | Global Farmers' Market" />
<meta name="twitter:description" content="Explore our comprehensive Other Directory to discover various farm-to-table organizations that are not farms, food hubs, food co-ops, restaurants, or artisan food producers. Connect with community resources, educational institutions, and more." />
<meta name="twitter:image" content="https://www.GlobalFarmersMarket.world/images/other-directory.jpg" />
<meta name="twitter:site" content="@YourTwitterHandle" />
</HEAD>
<body >

<!--#Include virtual="/Members/MembersHeader.asp"-->

<% 'response.write("StateIndex=" & StateIndex ) %> 

<div class="container-fluid " id="grad1" align = "center" style=" min-height: 80px" >
    <div class = "row" align = "center" >
        <div class = "col body" >
            <h1><img src="<%=Icon %>" class="img-fluid" style="max-width: 70px; max-height: 70px; object-fit: contain;">&nbsp;<%=current%></h1>
        </div>
</div>
</div>
    
    <%dim AdFooterID(100)
dim AdFooterImage(100)
dim AdFooterLink(100)

            if len(Currentcountry_id) = 0 then
                 Currentcountry_id = 1228
                Currentname = "USA"
                ProvinceTitle="State"
            else

             sql = "select name, ProvinceTitle  from country where country_id=" & Currentcountry_id
                rs.Open sql, conn, 3, 3   
                if Not rs.eof then
                    Currentname = rs("name") 
                    ProvinceTitle=rs("ProvinceTitle")
                end if
               
            end if
    if rs.state > 0 then
    rs.close
    end if


%>


<div class="container-fluid d-none d-lg-block"  align = "center" >
    <div class="row justify-content-center">
        <div class="col-lg-8" style="max-width: 1000px; min-height: 67px;">
            <!--#Include virtual="/FarmersMarkets/RanchSearchResults.asp"-->
        </div>
    </div>
</div>
<div class="container-fluid d-lg-none dropshadow">
    <div class="row justify-content-center">
        <div class="col" style="max-width: 1000px; min-height: 67px;">
            <!--#Include virtual="/FarmersMarkets/RanchSearchResults.asp"-->
        </div>
    </div>
</div>




<!--#Include virtual="/Members/MembersFooter.asp"-->


