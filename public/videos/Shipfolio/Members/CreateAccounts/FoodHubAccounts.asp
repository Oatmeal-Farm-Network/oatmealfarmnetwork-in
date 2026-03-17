<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<META HTTP-EQUIV="PRAGMA" CONTENT="NO-CACHE">
<% Title= "Join Global Farmers' Market"
Description = "The Global Farmers' Market will simplify the farm-to-fork journey by seamlessly connecting producers (farms, ranches, fishermen, foragers, butchers, etc.) with restaurants and home cooks. We will foster a direct relationship, ensuring the freshest ingredients for everyone."
currenturl = "https://www.LivestockOfTheWorld.com/join/"

 %>

<title><%=Title %></title>
<META name="description" content="<%=Description %>">
<meta name="author" content="Global Grange">
<!--#Include Virtual="/includefiles/GlobalVariables.asp"-->

<meta property="og:locale" content="en_US" />
<meta property="og:type" content="article" />
<meta property="og:title" content="Join Global Farmers' Market." />
<meta property="og:description" content="The Global Farmers' Market will simplify the farm-to-fork journey by seamlessly connecting producers (farms, ranches, fishermen, foragers, butchers, etc.) with restaurants and home cooks. We will foster a direct relationship, ensuring the freshest ingredients for everyone." />
<meta property="og:url" content="<%=currenturl %>" />
<meta property="og:site_name" content="Global Farmer Market" />
<meta property="og:image" content="<%=Image %>" />
<meta property="og:image:width" content="550" />
<meta name="twitter:card" content="summary" />
<meta name="twitter:description" content="The Global Farmers' Market will simplify the farm-to-fork journey by seamlessly connecting producers (farms, ranches, fishermen, foragers, butchers, etc.) with restaurants and home cooks. We will foster a direct relationship, ensuring the freshest ingredients for everyone." />
<meta name="twitter:title" content="Global Farmer Market" />
<link rel="canonical" href="<%=currenturl %>" />

<meta http-equiv="Content-Language" content="en-us">


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



Region = GetCountryFromURL(script_name)




sql = "select * from Country where name = '" & Region & "'"
rs.Open sql, conn, 3, 3   
if  Not rs.eof then 
LocalCurrency  = rs("Currency") 
CurrencyCode  = rs("CurrencyCode")
country_id = rs("country_id")
end if
rs.close

sql = "select distinct * from SubscriptionLevels where Region = '" & Region & "' and SubscriptionTitle = 'Intro'"
rs.Open sql, conn, 3, 3   
if  Not rs.eof then 
IntroLogo  = rs("SubscriptionLogo") 
IntroDescription  = rs("SubscriptionDescription") 
IntroFeatures  = rs("SubscriptionFeatures") 
IntroMonthlyRate = "Free"
end if
rs.close

sql = "select distinct * from SubscriptionLevels where Region = '" & Region & "' and SubscriptionTitle = 'Basic'"
rs.Open sql, conn, 3, 3   
if  Not rs.eof then 
BasicLogo  = rs("SubscriptionLogo") 
BasicDescription  = rs("SubscriptionDescription") 
BasicFeatures  = rs("SubscriptionFeatures") 
BasicMonthlyRate = rs("SubscriptionMonthlyRate") 
end if
rs.close

sql = "select distinct * from SubscriptionLevels where Region = '" & Region & "' and SubscriptionTitle = 'Business'"
rs.Open sql, conn, 3, 3   
if  Not rs.eof then 
BusinessLogo  = rs("SubscriptionLogo") 
BusinessDescription  = rs("SubscriptionDescription") 
BusinessFeatures  = rs("SubscriptionFeatures") 
BusinessMonthlyRate = rs("SubscriptionMonthlyRate") 
end if
rs.close


sql = "select distinct * from SubscriptionLevels where Region = '" & Region & "' and SubscriptionTitle = 'International'"
rs.Open sql, conn, 3, 3   
if  Not rs.eof then 
InternationalLogo  = rs("SubscriptionLogo") 
InternationalDescription  = rs("SubscriptionDescription") 
InternationalFeatures  = rs("SubscriptionFeatures") 
InternationalMonthlyRate = rs("SubscriptionMonthlyRate") 
end if
rs.close

sql = "select distinct * from SubscriptionLevels where Region = '" & Region & "' and SubscriptionTitle = 'Global'"
rs.Open sql, conn, 3, 3   
if  Not rs.eof then 
GlobalLogo  = rs("SubscriptionLogo") 
GlobalDescription  = rs("SubscriptionDescription") 
GlobalFeatures  = rs("SubscriptionFeatures") 
GlobalMonthlyRate = rs("SubscriptionMonthlyRate") 
end if
rs.close

showpremium = False
available = True 
BusinessTypeID = 10
MembershipType = "Food Hub Memberships"
MembershipImage = "FoodHubAccountHeader.jpg"

 %>

</head>
<body >
<!--#Include virtual="/Header.asp"--><div class="container-fluid" id="grad1" >
    <div >
     <div class = "container" style="max-width: 1400px; min-height: 67px; text-align: center;">
    <div>
      <div class = "body">
        <h1><%=MembershipType %></h1>
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
    <div class ="col" style="max-width:250px">
       Country<br />
        <form action="/Join/PassToRegion.asp" method = "post" >
             <!--#Include virtual="/includefiles/marketplacelistdropdowninclude.asp"-->
    </div>
     <div class ="col" style="max-width:110px">
         <br />
          <button type="submit" class="regsubmit2" >Submit</button>
            </form>
    </div>
         <div class ="col">

    </div>
</div>
<div class ="row">
    <div class ="col">
        <br />
    </div>
</div>
<div class ="row">
    <div class ="col" >
      Membership Categories<br />
         <a class="roundedtopandbottom body" href="/Join/USA/FarmAccounts.asp">&nbsp;Farm / Ranch&nbsp;</a>&nbsp;
            <a class="roundedtopandbottomyellow body" href="/Join/USA/FoodHubAccounts.asp">&nbsp;Food Hub&nbsp;</a> &nbsp;
            <a class="roundedtopandbottom body" href="/Join/USA/RestaurantAccounts.asp">&nbsp;Restaurant&nbsp;</a> 
        <br />   <br />
            <a class="roundedtopandbottom body" href="/Join/USA/ArtisanAccounts.asp">&nbsp;Artisan Food Producer&nbsp;</a> &nbsp;
            <a class="roundedtopandbottom body" href="/Join/USA/OtherAccounts.asp">&nbsp;Other&nbsp;</a> 
    </div>
        <div>
      <br /><b>Coming Soon!</b> We are working hard to add functionality that will allow you to manage member farms' combined inventory; manage CSA options; and receive orders directly from local restaurants.
    </div>
</div>


    <br />
<h2 id="farm">Membership Options</h2>
    <div class="container roundedtopandbottom mx-auto" >

<div class="container ">
  <div>
     <div >
     <a name = "Top"></a>
<br />
     <table cellpadding = 0 cellspacing = 0 border = 0 width = "100%">
  <tr  >
         <td colspan ="4"><font size = 4><b>Public Features</a></b></font>
         </td>
         <% if websitesavailable = true then %>
         <td class = "body"></td>
          <% end if %>
      </tr>
  <tr  >
         <td colspan ="4"><font size = 4>Visible at </font><a href="https://www.GlobalFarmersMarket.world" target="_blank" class = "body" ><font size = 4>GlobalFarmersMarket.world</font></a>
         </td>
         <% if websitesavailable = true then %>
         <td class = "body"></td>
          <% end if %>
      </tr>

 
  <tr><td height = 1 colspan = <%=colspan%>  bgcolor = "#abacab"></td></tr>
       <tr >
         <td width = "220"><font size = 4><img src="images/px.gif" width = 10 height = 4 />Profile</font></td>
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
       <tr>
         <td><font size = 4><img src="images/px.gif" width = 10 height = 4 />Service Listings</font></td>
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
         <td align = "center">&#x2714;</td>
         <% if websitesavailable = true then %>
         <td align = "center">&#x2714;</td>
        <% end if %>
      </tr>

   <tr  >
         <td colspan ="4"><font size = 4><b>Farmflow Management</a></b></font>
         </td>
         <% if websitesavailable = true then %>
         <td class = "body"></td>
          <% end if %>
      </tr>

   <tr><td height = 1 colspan = "<%=colspan%>" bgcolor = "#abacab"></td></tr>
      <tr  >
         <td ><img src="images/px.gif" width = 10 height = 4 /><font size = 4>Centralized Member DB</font>
             <ul><li><font size = 2>List of patronizing farms.</font></li>
             <li><font size = 2>Track payment terms.</font></li></ul>
         </td>
         <td class = "body"></td>
         <td align = "center">&#x2714;</td>
          <td align = "center">&#x2714;</td>
           <% if websitesavailable = true then %>
         <td class = "body"></td>
          <% end if %>
      </tr>
   <tr><td height = 1 colspan = "<%=colspan%>" bgcolor = "#abacab"></td></tr>
     <tr >
         <td ><img src="images/px.gif" width = 10 height = 4 /><font size = 4>Centralized Inventory</font><br />
             <img src="images/px.gif" width = 20 height = 4 /><font size = 2>Manage a combined</font> <br />
             <img src="images/px.gif" width = 20 height = 4 /><font size = 2>inventory of all</font><br />
             <img src="images/px.gif" width = 20 height = 4 /><font size = 2>produce from farms.</font></font>
         </td>
         <td align = "center"></td>
         <td align = "center">&#x2714;</td>
         <td align = "center">&#x2714;</td>
    <% if websitesavailable = true then %>
         <td align = "center">&#x2714;</td>
    <% end if %>
      </tr>
 
    <tr><td height = 1 colspan = "<%=colspan%>" bgcolor = "#abacab"></td></tr>
     <tr >
         <td ><img src="images/px.gif" width = 10 height = 4 /><font size = 4>Centralized Futures</font><br />
             <img src="images/px.gif" width = 20 height = 4 /><font size = 2>Combined inventory of<br />
             <img src="images/px.gif" width = 20 height = 4 />future production<br />
             <img src="images/px.gif" width = 20 height = 4 />from member farms.</font>
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
         <td ><font size = 4><img src="images/px.gif" width = 10 height = 4 />Process Orders</font>
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
         <td align = "center">&#x2714;</td>
          <td align = "center">&#x2714;</td>
           <% if websitesavailable = true then %>
         <td align = "center">&#x2714;</td>
          <% end if %>
      </tr>

          <tr><td height = 1 colspan = "<%=colspan%>" bgcolor = "#abacab"></td></tr>
    <tr  >
         <td ><font size = 4><img src="images/px.gif" width = 10 height = 4 />"Food Wanted" Ads</font>
         </td>
         <td align = "center"></td>
         <td align = "center"></td>
          <td align = "center">&#x2714;</td>
           <% if websitesavailable = true then %>
         <td align = "center">&#x2714;</td>
          <% end if %>
      </tr>

   <tr><td height = 1 colspan = "<%=colspan%>" bgcolor = "#abacab"></td></tr>
    <tr  >
         <td ><font size = 4><img src="images/px.gif" width = 10 height = 4 />Bidding</font><br />
             <img src="images/px.gif" width = 20 height = 4 />Producers compete in an <br />
             <img src="images/px.gif" width = 20 height = 4 />auction to provide the <br />
             <img src="images/px.gif" width = 20 height = 4 />produce that you, <br />
             <img src="images/px.gif" width = 20 height = 4 />& restaurants need.
         </td>
         <td align = "center"></td>
         <td align = "center"></td>
          <td align = "center">&#x2714;</td>
           <% if websitesavailable = true then %>
         <td align = "center">&#x2714;</td>
          <% end if %>
      </tr>


   <tr><td height = 1 colspan = "<%=colspan%>" bgcolor = "#abacab"></td></tr>
    <tr  >
         <td ><font size = 4><img src="images/px.gif" width = 10 height = 4 />CSA Boxes</font><br />
             <ul><li>Maintain inventory.</li>
                <li>Receive orders.</li></ul>
         </td>
         <td align = "center"></td>
         <td align = "center"></td>
          <td align = "center">&#x2714;</td>
           <% if websitesavailable = true then %>
         <td align = "center">&#x2714;</td>
          <% end if %>
      </tr>






   <tr><td height = 1 colspan = "<%=colspan%>" bgcolor = "#abacab"></td></tr>
    <tr  >
         <td ><font size = 4><img src="images/px.gif" width = 10 height = 4 />Process Payments</font>
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
         <td ><font size = 4><img src="images/px.gif" width = 10 height = 4 />Delivery Tracking</font>
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
         <td ><font size = 4><img src="images/px.gif" width = 10 height = 4 />Contract Support</font>
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
         <td ><font size = 4><img src="images/px.gif" width = 10 height = 4 />Order Tracking</font>
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
         <td ><font size = 4><img src="images/px.gif" width = 10 height = 4 />Preferred Customers</font>
         </td>
         <td align = "center"></td>
         <td align = "center"></td>
          <td align = "center">&#x2714;</td>
           <% if websitesavailable = true then %>
         <td align = "center"></td>
          <% end if %>
      </tr>

  <tr><td height = 1 colspan = "<%=colspan%>" bgcolor = "#abacab"></td></tr>
    <tr  >
         <td ><font size = 4>Reports</font>
         </td>
         <td align = "center"></td>
         <td align = "center"></td>
          <td align = "center">&#x2714;</td>
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
         <form action= 'SetupAccountPlus.asp?BusinessTypeID=<%=BusinessTypeID %>&Membership=Intro&Subscription=FoodHub' method = "post"><input type=submit value = "SELECT" class = "roundedtopandbottomyellow" ></form></center>
         
         </td>
         <td align = "center">
         <b><%=CurrencyCode %><%= BasicMonthlyRate%>&nbsp;<%=LocalCurrency%>  / Month</b>
             <form action= 'SetupAccountPlus.asp?BusinessTypeID=<%=BusinessTypeID %>&Membership=Basic&Subscription=FoodHub' method = "post"><input type=submit value = "SELECT" class = "roundedtopandbottomyellow" ></form>
   
             
             </center></td>
         <% if showpremium = true then %>
            <td align = "center">
 
         <form action= 'SetupAccountPlus.asp?BusinessTypeID=<%=BusinessTypeID %>&Membership=Business&Subscription=FoodHub' method = "post"><input type=submit value = "SELECT" class = "roundedtopandbottomyellow" ></form>
               
                
                </center></td>
            <% end if %>

          <% 
   if showMarketplaces = True then %>
         <td align = "center"><b><%=CurrencyCode %><%= GlobalMonthlyRate%>&nbsp;<%=LocalCurrency%>  / Month</b>
          <form action= 'SetupAccountPlus.asp?BusinessTypeID=<%=BusinessTypeID %>&Membership=Global&Subscription=FoodHub' method = "post"><input type=submit value = "SELECT" class = "roundedtopandbottomyellow" ></form></center></td></td>
      </tr>
    <% end if  %>
    </table>
<br />
    </div>
  </div>
</div>
</div>


</div>
<br /><br />

<!--#Include virtual="/Footer.asp"-->