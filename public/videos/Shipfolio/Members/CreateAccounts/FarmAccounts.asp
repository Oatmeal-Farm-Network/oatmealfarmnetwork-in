<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="generator" content="Global Grange inc.">
    <title>Harvest Hub Dashboard</title>
      <% MasterDashboard= True %>
<!--#Include virtual="/members/MembersGlobalVariables.asp"-->

<% 
Current1 = "MembersHome"
Current2="MembersHome" 
MasterDashboard= True %> 
</head>
<body>
<!--#Include virtual="/members/MembersHeader.asp"-->
<% If not rs.State = adStateClosed Then
rs.close
End If   	
%>


<% 
Set rs = Server.CreateObject("ADODB.Recordset")
Function GetCountryFromURL(url)
    Dim parts, country
    ' Split the URL by "/"
    parts = Split(url, "/")
    ' Find the position of the "Join" segment in the URL
    joinPosition = -1
    For i = LBound(parts) To UBound(parts)
        If LCase(parts(i)) = "join" Then
            joinPosition = i
            Exit For
        End If
    Next
    ' Extract the country name if "Join" segment is found
    If joinPosition >= 0 And joinPosition < UBound(parts) Then
        country = parts(joinPosition + 1)
    Else
        country = "Country not found"
    End If
    GetCountryFromURL = country
End Function

file_name = "Default.asp"

script_name = request.servervariables("script_name")

sql = "select address.country_id, Currency, CurrencyCode from People, Address, Country  where People.addressid = Address.Addressid and Address.country_id= Country.country_id and People.PeopleID = " & Session("PeopleID")
rs.Open sql, conn, 3, 3   
if  Not rs.eof then 
LocalCurrency  = rs("Currency") 
CurrencyCode  = rs("CurrencyCode")
country_id = rs("country_id")
end if
rs.close



sql = "select distinct * from SubscriptionLevels where country_id = " & country_id & " and SubscriptionTitle = 'Intro'"
rs.Open sql, conn, 3, 3   
if  Not rs.eof then 
IntroLogo  = rs("SubscriptionLogo") 
IntroDescription  = rs("SubscriptionDescription") 
IntroFeatures  = rs("SubscriptionFeatures") 
IntroMonthlyRate = "Free"
end if
rs.close

sql = "select distinct * from SubscriptionLevels where country_id = " & country_id & " and SubscriptionTitle = 'Basic'"
rs.Open sql, conn, 3, 3   
if  Not rs.eof then 
BasicLogo  = rs("SubscriptionLogo") 
BasicDescription  = rs("SubscriptionDescription") 
BasicFeatures  = rs("SubscriptionFeatures") 
BasicMonthlyRate = rs("SubscriptionMonthlyRate") 
end if
rs.close

sql = "select distinct * from SubscriptionLevels where country_id = " & country_id & " and SubscriptionTitle = 'Business'"
response.write("sql=" & sql )

rs.Open sql, conn, 3, 3   
if  Not rs.eof then 
BusinessLogo  = rs("SubscriptionLogo") 
BusinessDescription  = rs("SubscriptionDescription") 
BusinessFeatures  = rs("SubscriptionFeatures") 
BusinessMonthlyRate = rs("SubscriptionMonthlyRate") 
end if
rs.close


sql = "select distinct * from SubscriptionLevels where country_id = " & country_id & " and SubscriptionTitle = 'International'"
rs.Open sql, conn, 3, 3   
if  Not rs.eof then 
InternationalLogo  = rs("SubscriptionLogo") 
InternationalDescription  = rs("SubscriptionDescription") 
InternationalFeatures  = rs("SubscriptionFeatures") 
InternationalMonthlyRate = rs("SubscriptionMonthlyRate") 
end if
rs.close

sql = "select distinct * from SubscriptionLevels where country_id = " & country_id & " and SubscriptionTitle = 'Global'"
rs.Open sql, conn, 3, 3   
if  Not rs.eof then 
GlobalLogo  = rs("SubscriptionLogo") 
GlobalDescription  = rs("SubscriptionDescription") 
GlobalFeatures  = rs("SubscriptionFeatures") 
GlobalMonthlyRate = rs("SubscriptionMonthlyRate") 
end if
rs.close

available = True 

 showpremium = False
 %>

<script>
function jumpToSection(target) {
  // Get the element with the ID matching the target link (e.g., "#farms")
  var section = document.getElementById(target.slice(1));
  
  // Check if the element exists before scrolling
  if (section) {
    section.scrollIntoView({
      behavior: "smooth" // Smooth scrolling animation
    });
  }
}
</script>
</head>
<body >
<div class="container-fluid" id="grad1" >
    <div >
     <div class = "container" style="max-width: 1400px; min-height: 67px; text-align: center;">
    <div>
      <div class = "body">
        <h1>Farm Account</h1>
          </div>
        </div>
    </div>
    </div>
 </div>

<% 
    colspan = 4
    discount = 0 
showcomplete =False
showvendor= False
showlogoadoffer = False
BusinessTypeID = 8
MembershipType = "Farm Memberships"
MembershipImage = "FarmAccountHeader.jpg"

%>


<div class="container" >
<div class ="row">
    <div class ="col">
        <img src="<%=MembershipImage %>" width ="100%" alt="<%=MembershipType %>"/>
    </div>
</div>
<div class ="row">
    <div class ="col">
        <br />
    </div>
</div>

<div class ="row">
    <div class ="col">
        <br />
    </div>
</div>
<div class ="row">
    <div class ="col" >
      Account Categories<br />
         <a class="roundedtopandbottomyellow body" href="/Join/USA/FarmAccounts.asp">&nbsp;Farm / Ranch&nbsp;</a>&nbsp;
            <a class="roundedtopandbottom body" href="/Join/USA/FoodHubAccounts.asp">&nbsp;Food Hub&nbsp;</a> &nbsp;
            <a class="roundedtopandbottom body" href="/Join/USA/RestaurantAccounts.asp">&nbsp;Restaurant&nbsp;</a> 
        <br />   <br />
            <a class="roundedtopandbottom body" href="/Join/USA/ArtisanAccounts.asp">&nbsp;Artisan Food Producer&nbsp;</a> &nbsp;
            <a class="roundedtopandbottom body" href="/Join/USA/OtherAccounts.asp">&nbsp;Other&nbsp;</a> 
    </div>
        <div>
      <br /><b>Coming Soon!</b> We are working hard to add functionality that will allow you to maintain your inventory and receive orders directly from local restaurants


    </div>
</div>


<div class ="row">
    <div class ="col">  

<br />

<h2 id="farm">Membership Options</h2>
 <div class="container roundedtopandbottom mx-auto" >

<div class="container ">
  <div>
     <div >
     <a name = "Top"></a>
<br />
     <table cellpadding = 0 cellspacing = 0 border = 0 width = "100%">
       <tr >
         <td class = "body" style="min-width:200px" ><b><center>Features</center></b></td>
         <td class = "body" style="min-width:50px" ><b><center>Intro</center></b></td>
          <td class = "body" style="min-width:50px" ><b><center>Standard</center></b></td>
         
         
         <% if showpremium = true then %>
           <td class = "body" style="min-width:50px" ><b><center>Premium</center></b></td>
           <% end if %>
      <% websitesavailable = False
      if websitesavailable = true then %>
         <td class = "body" ><b><center>Global</center></b></td>
    <% end if %>
  </tr>



  <tr  >
         <td colspan ="4"><font size = 4><b>Public Features</a></b></font>
         </td>
         <% if websitesavailable = true then %>
         <td class = "body"></td>
          <% end if %>
      </tr>
  <tr  >
         <td colspan ="4"><font size = 4>Visible at </font><a href="https://www.GlobalFarmersMarket.world" target="_blank" class = "body" ><font size = 4>GlobalFarmersMarket.world</font></a>
             & <a href="https://www.LivestockOfAmerica.com" class = "body" ><font size = 4>LivestockOfAmerica.com</font></a>

         </td>
         <% if websitesavailable = true then %>
         <td class = "body"></td>
          <% end if %>
      </tr>

 
  <tr><td height = 1 colspan = <%=colspan%>  bgcolor = "#abacab"></td></tr>
       <tr >
         <td width = "220"><font size = 4><img src="images/px.gif" width = 10 height = 4 />Farm Profile</font></td>
        <td align = "center"><font color="#6f9243">&#x2714;</font></td>
         <td align = "center"><font color="#6f9243">&#x2714;</font></td>
             <% if showpremium = true then %>
         <td align = "center"><font color="#6f9243">&#x2714;</font></td>
           <% end if %>
      </tr>
<% show = False
    if show = True then %>
  <tr><td height = 1 colspan = <%=colspan%> bgcolor = "#abacab"></td></tr>
     <tr >
         <td ><font size = 4><img src="images/px.gif" width = 10 height = 4 />Event Calendar</font></td>
         <td align = "center"><font color="#6f9243"></font></td>
         <td align = "center"><font color="#6f9243">&#x2714;</font></td>
         <td align = "center"><font color="#6f9243">&#x2714;</font></td>
    <% if websitesavailable = true then %>
         <td align = "center"><font color="#6f9243">&#x2714;</font></td>
    <% end if %>
      </tr>
<% end if %>
     <tr><td height = 1 colspan = <%=colspan%> bgcolor = "#abacab"></td></tr>
       <tr>
         <td><font size = 4><img src="images/px.gif" width = 10 height = 4 />Service Listings</font></td>
         <td align = "center">&#x2714;</td>
         <td align = "center">&#x2714;</td>
             <% if showpremium = true then %>
         <td align = "center">&#x2714;</td>
           <% end if %>
         <% if websitesavailable = true then %>
         <td align = "center">&#x2714;</td>
        <% end if %>
      </tr>
  <% show = False
    if show = True then %>
  <tr><td height = 1 colspan = "<%=colspan%>" bgcolor = "#abacab"></td></tr>
      <tr  >
         <td colspan ="4"><font size = 4><b>Custom Website</b>
         </td>
       </tr>
         
     <tr><td height = 1 colspan = <%=colspan%> bgcolor = "#abacab"></td></tr>
       <tr>
         <td>
             <ul> <li /><font size = 2>Unlimited pages</font></li>
                 <li><font size = 2>Ecommerce:</font>
                 <ul><li /><font size = 2>Produce</font></li>
                 <li /><font size = 2>Livestock</font></li>
                 <li /><font size = 2>Products</font></li></ul></li>
                <li /><font size = 2>Events</font></li>
                <li /><font size = 2>Hosting</font></li>
                <li /><font size = 2>Custom Domain</font></li>
                <li /><font size = 2>3 custom emails</font></li></ul>


         </td>
         <td align = "center"></td>
         <td align = "center"></td>
             <% if showpremium = true then %>
         <td align = "center">&#x2714;</td>
           <% end if %>
         <% if websitesavailable = true then %>
         <td align = "center">&#x2714;</td>
        <% end if %>
      </tr>
<% end if %>
  <tr><td height = 1 colspan = "<%=colspan%>" bgcolor = "#abacab"></td></tr>
      <tr  >
         <td colspan ="4"><font size = 4><b>Livestock Listings</b><br />
             Visible at </font><a href="https://www.LivestockOfAmerica.com" class = "body" ><font size = 4>LivestockOfAmerica.com</font></a>
         </td>
       </tr>

   <tr><td height = 1 colspan = "<%=colspan%>" bgcolor = "#abacab"></td></tr>
      <tr  >
         <td ><img src="images/px.gif" width = 10 height = 4 /><font size = 4>Simple Animal Listings</font><br />
         <img src="images/px.gif" width = 10 height = 4 /><font size = 2>Pricing, Description, 1 photo.</font>
         </td>
         <td class = "body"><center><b><big>3</big></b><center></td>
         <td class = "body"></td>
            <% if showpremium = true then %>
          <td class = "body"></td>
          <% end if %>
           <% if websitesavailable = true then %>
         <td class = "body"></td>
          <% end if %>
      </tr>
   <tr><td height = 1 colspan = "<%=colspan%>" bgcolor = "#abacab"></td></tr>
     <tr >
         <td ><img src="images/px.gif" width = 10 height = 4 /><font size = 4>Complete Animal Listings</font>
             <img src="images/px.gif" width = 10 height = 4 /><font size = 2>Pricing, Description,<br />
             <img src="images/px.gif" width = 10 height = 4 />Ancestry, Progeny, Videos, <br />
             <img src="images/px.gif" width = 10 height = 4 />8 photos, & much more!</font>


         </td>
         <td align = "center"></td>
         <td align = "center"><img src="https://www.globallivestocksolutions.com/icons/Infinity.png" width ="28" /></td>
           <% if showpremium = true then %>
         <td align = "center"><img src="https://www.globallivestocksolutions.com/icons/Infinity.png" width ="28" /></td>
         <% end if %>
    <% if websitesavailable = true then %>
         <td align = "center"><img src="https://www.globallivestocksolutions.com/icons/Infinity.png" width ="28" /></td>
    <% end if %>
      </tr>

<% show = False
    if show = True then %>
    <tr  >
         <td colspan ="4"><font size = 4><b>Farmflow Management</a></b></font>
         </td>
         <% if websitesavailable = true then %>
         <td class = "body"></td>
          <% end if %>
      </tr>
      <tr><td height = 1 colspan = "<%=colspan%>" bgcolor = "#abacab"></td></tr>
    <tr  >
         <td ><font size = 4><img src="images/px.gif" width = 10 height = 4 /># Food Hubs</font>
          </td>
         <td align = "center"></td>
         <td align = "center"><big><b>1</b></big></td>
          <% if showpremium = true then %>
          <td align = "center"><img src="https://www.globallivestocksolutions.com/icons/Infinity.png" width ="28" /></td>
        <% end if %>
           <% if websitesavailable = true then %>
         <td align = "center">&#x2714;</td>
          <% end if %>
      </tr>
    <tr><td height = 1 colspan = "<%=colspan%>" bgcolor = "#abacab"></td></tr>
    <tr  >
         <td ><font size = 4><img src="images/px.gif" width = 10 height = 4 />Inventory Management</font>
         </td>
         <td align = "center"></td>
         <td align = "center">&#x2714;</td>
          <% if showpremium = true then %>
          <td align = "center">&#x2714;</td>
        <% end if %>
           <% if websitesavailable = true then %>
         <td align = "center">&#x2714;</td>
          <% end if %>
      </tr>

   <tr><td height = 1 colspan = "<%=colspan%>" bgcolor = "#abacab"></td></tr>
    <tr  >
         <td ><font size = 4><img src="images/px.gif" width = 10 height = 4 />Maintain Futures</font>
         </td>
         <td align = "center"></td>
         <td align = "center">&#x2714;</td>
          <% if showpremium = true then %>
          <td align = "center">&#x2714;</td>
         <% end if %>
           <% if websitesavailable = true then %>
         <td align = "center">&#x2714;</td>
          <% end if %>
      </tr>
   <tr><td height = 1 colspan = "<%=colspan%>" bgcolor = "#abacab"></td></tr>
    <tr  >
         <td ><font size = 4><img src="images/px.gif" width = 10 height = 4 />Restaurant Demands</font>
         </td>
         <td align = "center"></td>
         <td align = "center">&#x2714;</td>
          <td align = "center">&#x2714;</td>
           <% if websitesavailable = true then %>
         <td align = "center">&#x2714;</td>
          <% end if %>
      </tr>

   <tr><td height = 1 colspan = "<%=colspan%>" bgcolor = "#abacab"></td></tr>
    <tr  >
         <td ><font size = 4><img src="images/px.gif" width = 10 height = 4 />Restaurant Orders</font>
         </td>
         <td align = "center"></td>
         <td align = "center"><img src="https://www.globallivestocksolutions.com/icons/Infinity.png" width ="28" /></td>
          <% if showpremium = true then %>
          <td align = "center"><img src="https://www.globallivestocksolutions.com/icons/Infinity.png" width ="28" /></td>
          <% end if %>
           <% if websitesavailable = true then %>
         <td align = "center"><img src="https://www.globallivestocksolutions.com/icons/Infinity.png" width ="28" /></td>
          <% end if %>
      </tr>

   <tr><td height = 1 colspan = "<%=colspan%>" bgcolor = "#abacab"></td></tr>
    <tr  >
         <td ><font size = 4><img src="images/px.gif" width = 10 height = 4 />Delivery Tracking</font>
         </td>
         <td align = "center"></td>
         <td align = "center">&#x2714;</td>
          <% if showpremium = true then %>
          <td align = "center">&#x2714;</td>
        <% end if %>
           <% if websitesavailable = true then %>
         <td align = "center">&#x2714;</td>
          <% end if %>
      </tr>


   <tr><td height = 1 colspan = "<%=colspan%>" bgcolor = "#abacab"></td></tr>
    <tr  >
         <td ><font size = 4><img src="images/px.gif" width = 10 height = 4 />Contract Support</font>
         </td>
         <td align = "center"></td>
         <td align = "center">&#x2714;</td>
          <% if showpremium = true then %>
          <td align = "center">&#x2714;</td>
         <% end if %>
           <% if websitesavailable = true then %>
         <td align = "center">&#x2714;</td>
          <% end if %>
      </tr>

   <tr><td height = 1 colspan = "<%=colspan%>" bgcolor = "#abacab"></td></tr>
    <tr  >
         <td ><font size = 4><img src="images/px.gif" width = 10 height = 4 />Order Tracking</font>
         </td>
         <td align = "center"></td>
         <td align = "center">&#x2714;</td>
          <% if showpremium = true then %>
          <td align = "center">&#x2714;</td>
          <% end if %>
           <% if websitesavailable = true then %>
         <td align = "center">&#x2714;</td>
          <% end if %>
      </tr>


   <tr><td height = 1 colspan = "<%=colspan%>" bgcolor = "#abacab"></td></tr>
    <tr  >
         <td ><font size = 4><img src="images/px.gif" width = 10 height = 4 />Preferred Customers</font>
         </td>
         <td align = "center"></td>
         <td align = "center"></td>
          <% if showpremium = true then %>
          <td align = "center">&#x2714;</td>
          <% end if %>
           <% if websitesavailable = true then %>
         <td align = "center"></td>
          <% end if %>
      </tr>

  <tr><td height = 1 colspan = "<%=colspan%>" bgcolor = "#abacab"></td></tr>
    <tr  >
         <td ><font size = 4><img src="images/px.gif" width = 10 height = 4 />Reports</font>
         </td>
         <td align = "center"></td>
         <td align = "center"></td>
          <% if showpremium = true then %>
          <td align = "center">&#x2714;</td>
          <% end if %>
           <% if websitesavailable = true then %>
         <td align = "center"></td>
          <% end if %>
      </tr>
<% end if %>
       <tr><td height = 1 colspan = <%=colspan%> bgcolor = "#abacab"></td></tr>
       <tr>
         <td><font size = 4>Statistics</font></td>
         <td align = "center"><font color="#6f9243">&#x2714;</font></td>
         <td align = "center"><font color="#6f9243">&#x2714;</font></td>
             <% if showpremium = true then %>
         <td align = "center"><font color="#6f9243">&#x2714;</font></td>
           <% end if %>
         <% if websitesavailable = true then %>
         <td align = "center"><font color="#6f9243">&#x2714;</font></td>
        <% end if %>
      </tr>



     <tr><td height = 1 colspan = <%=colspan%> bgcolor = "#abacab"></td></tr>
      <tr  >
         <td ><font size = 4>Ads. in Your Member Portal</font><br />
              <font size = 2>Your member portal account will include ads from other organizations.</font>
         </td>
         <td align = "center">&#x2714;</td>
         <td align = "center"></td>
            <% if showpremium = true then %>
          <td align = "center"></td>
          <% end if %>
           <% if websitesavailable = true then %>
         <td align = "center"></td>
          <% end if %>
      </tr>
      <tr><td height = 2 colspan = <%=colspan%> bgcolor = "#abacab"></td></tr>
      <tr >
         <td><font size = 4></font></td>
         <td align = "center" valign = bottom><b>FREE</b>
         <form action= 'SetupAccountPlus.asp?BusinessTypeID=<%=BusinessTypeID %>&Membership=Intro&Subscription=Farm' method = "post"><input type=submit value = "SELECT" class = "roundedtopandbottomyellow" ></form></center>
         
         </td>
         <td align = "center">
       <b><%=CurrencyCode %><%= BasicMonthlyRate%>&nbsp;<%=LocalCurrency%>  / Month</b>
             <form action= 'SetupAccountPlus.asp?BusinessTypeID=<%=BusinessTypeID %>&Membership=Basic&Subscription=Farm' method = "post"><input type=submit value = "SELECT" class = "roundedtopandbottomyellow" ></form>
  
             
             </center></td>
            <% if showpremium = true then %>
            <td align = "center">
        <b><%=CurrencyCode %><%= BusinessMonthlyRate%>&nbsp;<%=LocalCurrency%>  / Month</b>
         <form action= 'SetupAccountPlus.asp?BusinessTypeID=<%=BusinessTypeID %>&Membership=Business&Subscription=Farm' method = "post"><input type=submit value = "SELECT" class = "roundedtopandbottomyellow" ></form>
          
                
                </center></td>
     <% end if %> 

          <% 
   if showMarketplaces = True then %>
         <td align = "center"><b><%=CurrencyCode %><%= GlobalMonthlyRate%>&nbsp;<%=LocalCurrency%>  / Month</b>
          <form action= 'SetupAccountPlus.asp?BusinessTypeID=<%=BusinessTypeID %>&Membership=Global&Subscription=Farm' method = "post"><input type=submit value = "SELECT" class = "roundedtopandbottomyellow" ></form></center></td></td>
      </tr>
    <% end if  %>
    </table>
<br />
    </div>
  </div>
</div>
</div>



<br />
</div>
</div>

</div>
<br /><br />

<!--#Include virtual="/Footer.asp"-->