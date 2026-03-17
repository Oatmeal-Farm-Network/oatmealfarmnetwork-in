<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<head>
  <% MasterDashboard= True 
  BladeSection = "account"
  pagename = "subscription" %> 
  <!--#Include file="membersGlobalVariables.asp"-->



<% Discount = 0
PremiumDiscount = 0
showcomplete = True

sql = "select People.*, address.*  from People, Address where People.AddressID = Address.AddressID and People.AddressID = Address.AddressID and people.PeopleID = " & PeopleID
'response.write("sql=" & sql )
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
if  Not rs.eof then 
    StripeSubscriptionID = rs("StripeSubscriptionID")
    PeopleStripeCustomerID = rs("PeopleStripeCustomerID")

    custAIStartService= rs("custAIStartService")  
    custAIEndService= rs("custAIEndService")  
    Membershiplevel = rs("SubscriptionLevel")  
    StripeID = rs("StripeID")  

    'response.write("Membershiplevel=" & Membershiplevel )
    PeopleEmail = rs("PeopleEmail")
    PeopleFirstName = rs("PeopleFirstName")
    PeopleLastName = rs("PeoplelastName")
    PeoplePhone = rs("PeoplePhone")
    AddressApt = rs("AddressApt")
    AddressCity= rs("AddressCity")
    AddressState = rs("AddressState")
    AddressZip = rs("AddressZip")
	
    country_id = rs("country_id")
    AddressStreet = rs("AddressStreet")
    WebsitesID = rs("WebsitesID")
    PeopleCell = rs("PeopleCell")
    PeopleFax= rs("Peoplefax")
    Logo= rs("Logo")
    Owners= rs("Owners")
    PeopleTitleID = rs("PeopleTitleID") 
    PeopleEmail= rs("PeopleEmail") 
    	
    CurrentSubscriptionID = rs("Subscriptionlevel")
rs.close
end if
  

sql = "select Region from Country where country_id = " & country_id
'response.write("sql=" & sql)
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
 if  Not rs.eof then 
   Region  = rs("Region")
end if

'response.write ("Region=" & Region)
 sql = "select distinct BusinessName, BusinessLogo, Business.BusinessID from People, Business where People.BusinessID = Business.BusinessID and  people.PeopleID = " & PeopleID & " order by Business.BusinessID Asc"

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
 if  Not rs.eof then 
 BusinessName = rs("BusinessName")
 BusinessLogo = rs("BusinessLogo")
 BusinessID = rs("BusinessID")
end if



if len(WebsitesID) > 0 then
 sql = "select distinct * from Websites where WebsitesID = " & WebsitesID

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
 if  Not rs.eof then 
PeopleWebsite = rs("Website")
end if
end if


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
    IntroSubscriptionID = rs("SubscriptionID")
    IntroLogo  = rs("SubscriptionLogo") 
    IntroDescription  = rs("SubscriptionDescription") 
    IntroFeatures  = rs("SubscriptionFeatures") 
    IntroMonthlyRate = "Free"
end if
rs.close

sql = "select distinct * from SubscriptionLevels where Region = '" & Region & "' and SubscriptionTitle = 'Basic'"
rs.Open sql, conn, 3, 3   
if  Not rs.eof then 
        BasicSubscriptionID = rs("SubscriptionID")
        BasicLogo  = rs("SubscriptionLogo") 
        BasicDescription  = rs("SubscriptionDescription") 
        BasicFeatures  = rs("SubscriptionFeatures") 
        BasicMonthlyRate = rs("SubscriptionMonthlyRate") 
end if
rs.close

sql = "select distinct * from SubscriptionLevels where Region = '" & Region & "' and SubscriptionTitle = 'Business'"
rs.Open sql, conn, 3, 3   
if  Not rs.eof then 
        BusinessSubscriptionID = rs("SubscriptionID")
        BusinessLogo  = rs("SubscriptionLogo") 
        BusinessDescription  = rs("SubscriptionDescription") 
        BusinessFeatures  = rs("SubscriptionFeatures") 
        BusinessMonthlyRate = rs("SubscriptionMonthlyRate") 
end if
rs.close


sql = "select distinct * from SubscriptionLevels where Region = '" & Region & "' and SubscriptionTitle = 'International'"
rs.Open sql, conn, 3, 3   
if  Not rs.eof then 
        InternationalSubscriptionID = rs("SubscriptionID")
        InternationalLogo  = rs("SubscriptionLogo") 
        InternationalDescription  = rs("SubscriptionDescription") 
        InternationalFeatures  = rs("SubscriptionFeatures") 
        InternationalMonthlyRate = rs("SubscriptionMonthlyRate") 
end if
rs.close

sql = "select distinct * from SubscriptionLevels where Region = '" & Region & "' and SubscriptionTitle = 'Global'"
rs.Open sql, conn, 3, 3   
if  Not rs.eof then 
        GlobalSubscriptionID = rs("SubscriptionID")
        GlobalLogo  = rs("SubscriptionLogo") 
        GlobalDescription  = rs("SubscriptionDescription") 
        GlobalFeatures  = rs("SubscriptionFeatures") 
        GlobalMonthlyRate = rs("SubscriptionMonthlyRate") 
end if
rs.close

colspan = 4
ShowBusiness = False
 %>
</head>
<body>

<% Current1="Account"
Current2 = "UpgradeorRenewYourMembership" 
Current3 = "Membership" 
Current3 = "Subscriptions" 
     showMarketplaces = false 
      websitesavailable = False   %> 
<!--#Include file="MembersHeader.asp"-->
    <br />


<div class="container roundedtopandbottom mx-auto" >


<div class ="row">
    <div class ="col">  

<H1 id="farm">Membership Options</H1>
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
         <td class = "body"><center><b><big>5</big></b><center></td>
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
         <td align = "center" valign = bottom>
             
             <% if Membershiplevel = 1 then %>
                Current
            
             <% else %>
                <form action= '/members/Payment/CancelStripePayments.asp?CurrentSusbcriptionID=<%=CurrentSubscriptionID %>&NewMembership=<%=IntroSubscriptionID %>' method = "post"><input type=submit value = "Downgrade" class = "submitbuttoncenter" ></form>
             <% end if %>
         
         </td>
         <td align = "center">
         <% if Membershiplevel = 1 then %>
                <form action= '/members/Payment/AddAccount.asp?CurrentSusbcriptionID=<%=CurrentSubscriptionID %>&NewMembership=<%=BasicSubscriptionID %>' method = "post"><input type=submit value = "Upgrade" class = "submitbuttoncenter" ></form>
             <% end if %>
             
             
             <% if Membershiplevel = 2 then %>
                Current
             <% end if %>


             <% if Membershiplevel = 3 then %>
                <form action= '/members/Payment/DowngradeAccount.asp?CurrentSusbcriptionID=<%=CurrentSubscriptionID %>&NewMembership=<%=BusinessSubscriptionID %>' method = "post"><input type=submit value = "Downgrade" class = "submitbuttoncenter" ></form>
             <% end if %>




         </td>
            <% if showpremium = true then %>
            <td align = "center">
       <b><%=CurrencyCode %><%= BusinessMonthlyRate%>&nbsp;<%=LocalCurrency%>  / Month</b>
              <% if Membershiplevel = 1 then %>
                  <form action= '/members/Payment/AddAccount.asp?CurrentSusbcriptionID=<%=CurrentSubscriptionID %>&NewMembership=<%=BusinessSubscriptionID %>' method = "post"><input type=submit value = "Upgrade" class = "submitbuttoncenter" ></form>
             <% end if %>
             
           <% if Membershiplevel = 2 then %>    
               <form action= '/members/Payment/UpgradeAccount.asp?CurrentSusbcriptionID=<%=CurrentSubscriptionID %>&NewMembership=<%=BusinessSubscriptionID %>' method = "post"><input type=submit value = "Upgrade" class = "submitbuttoncenter" ></form>
             <% end if %>

             <% if Membershiplevel = 3 then %>
                Current
             <% end if %></td>
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
<br /><br />
<!--#Include file="membersFooter.asp"-->
</body>
</html>