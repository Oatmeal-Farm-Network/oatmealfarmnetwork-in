<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<META HTTP-EQUIV="PRAGMA" CONTENT="NO-CACHE">
<% Title= "Join Rogue Week"
Description = "Rogue Week is a network of online community marketplaces for horses, cattle, dogs, donkeys, goats, chickens, turkeys, emus, rabbits, llamas, alpacas, pigs, and sheep."
currenturl = "https://www.RogueWeek.org/join/"

 %>

<title><%=Title %></title>
<META name="description" content="<%=Description %>">
<meta name="author" content="Rogue Week">
<!--#Include Virtual="/includefiles/GlobalVariables.asp"-->

<meta property="og:locale" content="en_US" />
<meta property="og:type" content="article" />
<meta property="og:title" content="Join Rogue Week." />
<meta property="og:url" content="<%=currenturl %>" />
<meta property="og:site_name" content="Global Farmer Market" />
<meta property="og:image" content="<%=Image %>" />
<meta property="og:image:width" content="550" />
<meta name="twitter:card" content="summary" />
<meta name="twitter:title" content="Global Farmer Market" />
<link rel="canonical" href="<%=currenturl %>" />

<meta http-equiv="Content-Language" content="en-us">


<% 
Set rs = Server.CreateObject("ADODB.Recordset")


file_name = "Default.asp"

script_name = request.servervariables("script_name")

str1 = script_name
str2 = "Join"
If InStr(str1,str2) > 0 Then
sitePath= Replace(str1,  str2, "")
End If 
str1 = sitePath
str2 = file_name
If InStr(str1,str2) > 0 Then
sitePath= Replace(str1,  str2, "")
End If 

str1 = sitePath
str2 = "/"
If InStr(str1,str2) > 0 Then
Region= Replace(str1,  str2, "")
End If 


'response.write("Region=" & Region & "<br>")

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

available = True 
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
<% Current = "WebDesign" %>
<!--#Include virtual="/Header.asp"--> 
 <div class="container-fluid" id="grad1" >
    <div align = center>
     <div class = "container" style="max-width: 1400px; min-height: 67px; text-align: center;">
    <div>
      <div class = "body">
        <h1>Membership Options</h1>
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

Type of Account:<br />

<ul >
    <li><a class="body" href="/Join/USA/Default.asp#farm"><b>Farm / Ranch Account</b></a></li>
    <li><a class="body" href="/Join/USA/Default.asp#artisan"><b>Artisan Producer Account</b></a></li>
    <li><a class="body" href="/Join/USA/Default.asp#foodhub"><b>Food Hub Account</b></a></li>
    <li><a class="body" href="/Join/USA/Default.asp#restaurant"><b>Restaurant Account</b></a></li>
 </ul>





<br />

<h2 id="farm">Farm / Ranch Account</h2>
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
         <td class = "body" style="min-width:50px" ><b><center>Premium</center></b></td>
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
             <br />& <a href="https://www.LivestockOfAmerica.com" class = "body" ><font size = 4>LivestockOfAmerica.com</font></a>

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
         <td align = "center"><font color="#6f9243">&#x2714;</font></td>
      </tr>

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

     <tr><td height = 1 colspan = <%=colspan%> bgcolor = "#abacab"></td></tr>
       <tr>
         <td><font size = 4><img src="images/px.gif" width = 10 height = 4 />Service Listings</font></td>
         <td align = "center">&#x2714;</td>
         <td align = "center">&#x2714;</td>
         <td align = "center">&#x2714;</td>
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
         <td class = "body"><center><b><big>5</big></b><center></td>
         <td class = "body"></td>
          <td class = "body"></td>
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
         <td align = "center"><img src="https://www.globallivestocksolutions.com/icons/Infinity.png" width ="28" /></td>
    <% if websitesavailable = true then %>
         <td align = "center"><img src="https://www.globallivestocksolutions.com/icons/Infinity.png" width ="28" /></td>
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
         <td ><font size = 4><img src="images/px.gif" width = 10 height = 4 /># Food Hubs</font>
          </td>
         <td align = "center"></td>
         <td align = "center"><big><b>1</b></big></td>
          <td align = "center"><img src="https://www.globallivestocksolutions.com/icons/Infinity.png" width ="28" /></td>
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
          <td align = "center">&#x2714;</td>
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
          <td align = "center">&#x2714;</td>
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
          <td align = "center"><img src="https://www.globallivestocksolutions.com/icons/Infinity.png" width ="28" /></td>
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
         <td ><font size = 4><img src="images/px.gif" width = 10 height = 4 />Reports</font>
         </td>
         <td align = "center"></td>
         <td align = "center"></td>
          <td align = "center">&#x2714;</td>
           <% if websitesavailable = true then %>
         <td align = "center"></td>
          <% end if %>
      </tr>

       <tr><td height = 1 colspan = <%=colspan%> bgcolor = "#abacab"></td></tr>
       <tr>
         <td><font size = 4>Statistics</font></td>
         <td align = "center"><font color="#6f9243">&#x2714;</font></td>
         <td align = "center"><font color="#6f9243">&#x2714;</font></td>
         <td align = "center"><font color="#6f9243">&#x2714;</font></td>
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
          <td align = "center"></td>
           <% if websitesavailable = true then %>
         <td align = "center"></td>
          <% end if %>
      </tr>
      <tr><td height = 2 colspan = <%=colspan%> bgcolor = "#abacab"></td></tr>
      <tr >
         <td><font size = 4></font></td>
         <td align = "center" valign = bottom><b>FREE</b>
         <form action= 'SetupAccountPlus.asp?Membership=Intro&Subscription=Farm' method = "post"><input type=submit value = "SELECT" class = "roundedtopandbottomyellow" ></form></center>
         
         </td>
         <td align = "center">
        <% if available = True then %>
             Not Available Yet
        <% else %>   
             <form action= 'SetupAccountPlus.asp?Membership=Basic&Subscription=Farm' method = "post"><input type=submit value = "SELECT" class = "roundedtopandbottomyellow" ></form>
         <% end if %>    
             
             </center></td>
          
            <td align = "center">
             <% if available = True then %>
             Not Available Yet
        <% else %>  
         <form action= 'SetupAccountPlus.asp?Membership=Business&Subscription=Farm' method = "post"><input type=submit value = "SELECT" class = "roundedtopandbottomyellow" ></form>
         <% end if %>       
                
                </center></td>
          <% 
   if showMarketplaces = True then %>
         <td align = "center"><b><%=CurrencyCode %><%= GlobalMonthlyRate%>&nbsp;<%=LocalCurrency%>  / Month</b>
          <form action= 'SetupAccountPlus.asp?Membership=Global&Subscription=Farm' method = "post"><input type=submit value = "SELECT" class = "roundedtopandbottomyellow" ></form></center></td></td>
      </tr>
    <% end if  %>
    </table>
<br />
    </div>
  </div>
</div>
</div>



<br />

<h2 id="artisan">Artisan Producer Account</h2>

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
         <td class = "body" style="min-width:50px" ><b><center>Premium</center></b></td>
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
             <br />& <a href="https://www.LivestockOfAmerica.com" class = "body" ><font size = 4>LivestockOfAmerica.com</font></a>

         </td>
         <% if websitesavailable = true then %>
         <td class = "body"></td>
          <% end if %>
      </tr>

 
  <tr><td height = 1 colspan = <%=colspan%>  bgcolor = "#abacab"></td></tr>
       <tr >
         <td width = "220"><font size = 4><img src="images/px.gif" width = 10 height = 4 />Business Profile</font></td>
        <td align = "center"><font color="#6f9243">&#x2714;</font></td>
         <td align = "center"><font color="#6f9243">&#x2714;</font></td>
         <td align = "center"><font color="#6f9243">&#x2714;</font></td>
      </tr>

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

     <tr><td height = 1 colspan = <%=colspan%> bgcolor = "#abacab"></td></tr>
       <tr>
         <td><font size = 4><img src="images/px.gif" width = 10 height = 4 />Service Listings</font></td>
         <td align = "center">&#x2714;</td>
         <td align = "center">&#x2714;</td>
         <td align = "center">&#x2714;</td>
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
         <td ><font size = 4><img src="images/px.gif" width = 10 height = 4 />Inventory Management</font>
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
         <td ><font size = 4><img src="images/px.gif" width = 10 height = 4 />Future Production</font>
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
         <td ><font size = 4><img src="images/px.gif" width = 10 height = 4 />Order Produce</font>
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
         <td ><font size = 4><img src="images/px.gif" width = 10 height = 4 />Place and Receive<br />
             <img src="images/px.gif" width = 10 height = 4 />"Food Wanted" Ads</font>
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
             <img src="images/px.gif" width = 10 height = 4 />Producers compete in an <br />
             <img src="images/px.gif" width = 10 height = 4 />auction to provide the <br />
             <img src="images/px.gif" width = 10 height = 4 />produce that you need.
         </td>
         <td align = "center"></td>
         <td align = "center"></td>
          <td align = "center">&#x2714;</td>
           <% if websitesavailable = true then %>
         <td align = "center"><img src="https://www.globallivestocksolutions.com/icons/Infinity.png" width ="28" /></td>
          <% end if %>
      </tr>



   <tr><td height = 1 colspan = "<%=colspan%>" bgcolor = "#abacab"></td></tr>
    <tr  >
         <td ><font size = 4><img src="images/px.gif" width = 10 height = 4 />Receive Restaurant<br />
             <img src="images/px.gif" width = 10 height = 4 />Orders</font>
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
         <td ><font size = 4><img src="images/px.gif" width = 10 height = 4 />Preferred Customers<br />
             <img src="images/px.gif" width = 10 height = 4 />& Producers</font>
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
         <td ><font size = 4><img src="images/px.gif" width = 10 height = 4 />Recipe Maintenance</font>
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
         <td ><font size = 4><img src="images/px.gif" width = 10 height = 4 />Reports</font>
         </td>
         <td align = "center"></td>
         <td align = "center"></td>
          <td align = "center">&#x2714;</td>
           <% if websitesavailable = true then %>
         <td align = "center"></td>
          <% end if %>
      </tr>

       <tr><td height = 1 colspan = <%=colspan%> bgcolor = "#abacab"></td></tr>
       <tr>
         <td><font size = 4>Statistics</font></td>
         <td align = "center"><font color="#6f9243">&#x2714;</font></td>
         <td align = "center"><font color="#6f9243">&#x2714;</font></td>
         <td align = "center"><font color="#6f9243">&#x2714;</font></td>
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
          <td align = "center"></td>
           <% if websitesavailable = true then %>
         <td align = "center"></td>
          <% end if %>
      </tr>
      <tr><td height = 2 colspan = <%=colspan%> bgcolor = "#abacab"></td></tr>
      <tr >
         <td><font size = 4></font></td>
         <td align = "center" valign = bottom><b>FREE</b>
         <form action= 'SetupAccountPlus.asp?Membership=Intro&Subscription=Artisan' method = "post"><input type=submit value = "SELECT" class = "roundedtopandbottomyellow" ></form></center>
         
         </td>
         <td align = "center">
        <% if available = True then %>
             Not Available Yet
        <% else %>   
             <form action= 'SetupAccountPlus.asp?Membership=Basic&Subscription=Artisan' method = "post"><input type=submit value = "SELECT" class = "roundedtopandbottomyellow" ></form>
         <% end if %>    
             
             </center></td>
          
            <td align = "center">
             <% if available = True then %>
             Not Available Yet
        <% else %>  
         <form action= 'SetupAccountPlus.asp?Membership=Business&Subscription=Artisan' method = "post"><input type=submit value = "SELECT" class = "roundedtopandbottomyellow" ></form>
         <% end if %>       
                
                </center></td>
          <% 
   if showMarketplaces = True then %>
         <td align = "center"><b><%=CurrencyCode %><%= GlobalMonthlyRate%>&nbsp;<%=LocalCurrency%>  / Month</b>
          <form action= 'SetupAccountPlus.asp?Membership=Global&Subscription=Artisan' method = "post"><input type=submit value = "SELECT" class = "roundedtopandbottomyellow" ></form></center></td></td>
      </tr>
    <% end if  %>
    </table>
<br />
    </div>
  </div>
</div>
</div>

<br />

<h2 id="foodhub">Food Hub Account</h2>
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
         <td class = "body" style="min-width:50px" ><b><center>Premium</center></b></td>
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
         <td align = "center"><font color="#6f9243">&#x2714;</font></td>
      </tr>

  <tr><td height = 1 colspan = <%=colspan%> bgcolor = "#abacab"></td></tr>
     <tr >
         <td ><font size = 4><img src="images/px.gif" width = 10 height = 4 />Event Calendar</font></td>
         <td align = "center"><font color="#6f9243">&#x2714;</font></td>
         <td align = "center"><font color="#6f9243">&#x2714;</font></td>
         <td align = "center"><font color="#6f9243">&#x2714;</font></td>
    <% if websitesavailable = true then %>
         <td align = "center"><font color="#6f9243">&#x2714;</font></td>
    <% end if %>
      </tr>

     <tr><td height = 1 colspan = <%=colspan%> bgcolor = "#abacab"></td></tr>
       <tr>
         <td><font size = 4><img src="images/px.gif" width = 10 height = 4 />Service Listings</font></td>
         <td align = "center"></td>
         <td align = "center">&#x2714;</td>
         <td align = "center">&#x2714;</td>
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
         <td align = "center"><img src="https://www.globallivestocksolutions.com/icons/Infinity.png" width ="28" /></td>
         <td align = "center"><img src="https://www.globallivestocksolutions.com/icons/Infinity.png" width ="28" /></td>
    <% if websitesavailable = true then %>
         <td align = "center"><img src="https://www.globallivestocksolutions.com/icons/Infinity.png" width ="28" /></td>
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
         <td align = "center"><img src="https://www.globallivestocksolutions.com/icons/Infinity.png" width ="28" /></td>
         <td align = "center"><img src="https://www.globallivestocksolutions.com/icons/Infinity.png" width ="28" /></td>
    <% if websitesavailable = true then %>
         <td align = "center"><img src="https://www.globallivestocksolutions.com/icons/Infinity.png" width ="28" /></td>
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
         <td align = "center"><img src="https://www.globallivestocksolutions.com/icons/Infinity.png" width ="28" /></td>
          <td align = "center"><img src="https://www.globallivestocksolutions.com/icons/Infinity.png" width ="28" /></td>
           <% if websitesavailable = true then %>
         <td align = "center"><img src="https://www.globallivestocksolutions.com/icons/Infinity.png" width ="28" /></td>
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
         <td align = "center"><img src="https://www.globallivestocksolutions.com/icons/Infinity.png" width ="28" /></td>
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
         <td align = "center"><img src="https://www.globallivestocksolutions.com/icons/Infinity.png" width ="28" /></td>
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

       <tr><td height = 1 colspan = <%=colspan%> bgcolor = "#abacab"></td></tr>
       <tr>
         <td><font size = 4>Statistics</font></td>
         <td align = "center"><font color="#6f9243">&#x2714;</font></td>
         <td align = "center"><font color="#6f9243">&#x2714;</font></td>
         <td align = "center"><font color="#6f9243">&#x2714;</font></td>
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
          <td align = "center"></td>
           <% if websitesavailable = true then %>
         <td align = "center"></td>
          <% end if %>
      </tr>
      <tr><td height = 2 colspan = <%=colspan%> bgcolor = "#abacab"></td></tr>
      <tr >
         <td><font size = 4></font></td>
         <td align = "center" valign = bottom><b>FREE</b>
         <form action= 'SetupAccountPlus.asp?Membership=Intro&Subscription=FoodHub' method = "post"><input type=submit value = "SELECT" class = "roundedtopandbottomyellow" ></form></center>
         
         </td>
         <td align = "center">
        <% if available = True then %>
             Not Available Yet
        <% else %>   
             <form action= 'SetupAccountPlus.asp?Membership=Basic&Subscription=FoodHub' method = "post"><input type=submit value = "SELECT" class = "roundedtopandbottomyellow" ></form>
         <% end if %>    
             
             </center></td>
          
            <td align = "center">
             <% if available = True then %>
             Not Available Yet
        <% else %>  
         <form action= 'SetupAccountPlus.asp?Membership=Business&Subscription=FoodHub' method = "post"><input type=submit value = "SELECT" class = "roundedtopandbottomyellow" ></form>
         <% end if %>       
                
                </center></td>
          <% 
   if showMarketplaces = True then %>
         <td align = "center"><b><%=CurrencyCode %><%= GlobalMonthlyRate%>&nbsp;<%=LocalCurrency%>  / Month</b>
          <form action= 'SetupAccountPlus.asp?Membership=Global&Subscription=FoodHub' method = "post"><input type=submit value = "SELECT" class = "roundedtopandbottomyellow" ></form></center></td></td>
      </tr>
    <% end if  %>
    </table>
<br />
    </div>
  </div>
</div>
</div>




<br />
<h2 id="restaurant">Restaurant Account</h2>
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
         <td class = "body" style="min-width:50px" ><b><center>Premium</center></b></td>
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
     
         </td>
         <% if websitesavailable = true then %>
         <td class = "body"></td>
          <% end if %>
      </tr>

 
  <tr><td height = 1 colspan = <%=colspan%>  bgcolor = "#abacab"></td></tr>
       <tr >
         <td width = "220"><font size = 4><img src="images/px.gif" width = 10 height = 4 />Business Profile</font></td>
        <td align = "center"><font color="#6f9243">&#x2714;</font></td>
         <td align = "center"><font color="#6f9243">&#x2714;</font></td>
         <td align = "center"><font color="#6f9243">&#x2714;</font></td>
      </tr>

  <tr><td height = 1 colspan = <%=colspan%> bgcolor = "#abacab"></td></tr>
     <tr >
         <td ><font size = 4><img src="images/px.gif" width = 10 height = 4 />Event Calendar</font></td>
         <td align = "center"><font color="#6f9243">&#x2714;</font></td>
         <td align = "center"><font color="#6f9243">&#x2714;</font></td>
         <td align = "center"><font color="#6f9243">&#x2714;</font></td>
    <% if websitesavailable = true then %>
         <td align = "center"><font color="#6f9243">&#x2714;</font></td>
    <% end if %>
      </tr>

     <tr><td height = 1 colspan = <%=colspan%> bgcolor = "#abacab"></td></tr>
       <tr>
         <td><font size = 4><img src="images/px.gif" width = 10 height = 4 />Service Listings</font></td>
         <td align = "center"></td>
         <td align = "center">&#x2714;</td>
         <td align = "center">&#x2714;</td>
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
         <td ><font size = 4><img src="images/px.gif" width = 10 height = 4 />Order Produce</font>
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
             <img src="images/px.gif" width = 10 height = 4 />Producers compete in an <br />
             <img src="images/px.gif" width = 10 height = 4 />auction to provide the <br />
             <img src="images/px.gif" width = 10 height = 4 />produce that you need.
         </td>
         <td align = "center"></td>
         <td align = "center"></td>
          <td align = "center">&#x2714;</td>
           <% if websitesavailable = true then %>
         <td align = "center"><img src="https://www.globallivestocksolutions.com/icons/Infinity.png" width ="28" /></td>
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
         <td ><font size = 4><img src="images/px.gif" width = 10 height = 4 />Preferred Producers</font>
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
         <td ><font size = 4><img src="images/px.gif" width = 10 height = 4 />Recipe Maintenance</font>
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
         <td ><font size = 4><img src="images/px.gif" width = 10 height = 4 />Food Provenance</font>
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
         <td ><font size = 4><img src="images/px.gif" width = 10 height = 4 />Menu Costing</font>
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

       <tr><td height = 1 colspan = <%=colspan%> bgcolor = "#abacab"></td></tr>
       <tr>
         <td><font size = 4>Statistics</font></td>
         <td align = "center"><font color="#6f9243">&#x2714;</font></td>
         <td align = "center"><font color="#6f9243">&#x2714;</font></td>
         <td align = "center"><font color="#6f9243">&#x2714;</font></td>
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
          <td align = "center"></td>
           <% if websitesavailable = true then %>
         <td align = "center"></td>
          <% end if %>
      </tr>
      <tr><td height = 2 colspan = <%=colspan%> bgcolor = "#abacab"></td></tr>
      <tr >
         <td><font size = 4></font></td>
         <td align = "center" valign = bottom><b>FREE</b>
         <form action= 'SetupAccountPlus.asp?Membership=Intro&Subscription=Restaurant' method = "post"><input type=submit value = "SELECT" class = "roundedtopandbottomyellow" ></form></center>
         
         </td>
         <td align = "center">
        <% if available = True then %>
             Not Available Yet
        <% else %>   
             <form action= 'SetupAccountPlus.asp?Membership=Basic&Subscription=Restaurant' method = "post"><input type=submit value = "SELECT" class = "roundedtopandbottomyellow" ></form>
         <% end if %>    
             
             </center></td>
          
            <td align = "center">
             <% if available = True then %>
             Not Available Yet
        <% else %>  
         <form action= 'SetupAccountPlus.asp?Membership=Business&Subscription=Restaurant' method = "post"><input type=submit value = "SELECT" class = "roundedtopandbottomyellow" ></form>
         <% end if %>       
                
                </center></td>
          <% 
   if showMarketplaces = True then %>
         <td align = "center"><b><%=CurrencyCode %><%= GlobalMonthlyRate%>&nbsp;<%=LocalCurrency%>  / Month</b>
          <form action= 'SetupAccountPlus.asp?Membership=Global' method = "post"><input type=submit value = "SELECT" class = "roundedtopandbottomyellow" ></form></center></td></td>
      </tr>
    <% end if  %>
    </table>
<br />
    </div>
  </div>
</div>
</div>
</div>

</div>
<br /><br />

<!--#Include virtual="/Footer.asp"-->