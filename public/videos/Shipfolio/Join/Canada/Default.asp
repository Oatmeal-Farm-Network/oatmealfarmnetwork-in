<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<META HTTP-EQUIV="PRAGMA" CONTENT="NO-CACHE">
<% Title= "Join Livestock Of The World"
Description = "Join Livestock Of The World. Livestock Of The World is a network of online community marketplaces for horses, cattle, dogs, donkeys, goats, chickens, turkeys, emus, rabbits, llamas, alpacas, pigs, and sheep."
currenturl = "https://www.LivestockOfTheWorld.com/join/"

 %>

<title><%=Title %></title>
<META name="description" content="<%=Description %>">
<meta name="author" content="Livestock Of The World">
<link rel="stylesheet" type="text/css" href="/style.css">
<!--#Include virtual="/includefiles/globalvariables.asp"-->

<meta property="og:locale" content="en_US" />
<meta property="og:type" content="article" />
<meta property="og:title" content="Join Livestock Of The World. ." />
<meta property="og:description" content="Join Livestock Of The World. Livestock Of The World is a network of online community marketplaces for horses, cattle, dogs, donkeys, goats, chickens, turkeys, emus, rabbits, llamas, alpacas, pigs, and sheep." />
<meta property="og:url" content="<%=currenturl %>" />
<meta property="og:site_name" content="Livestock Of The World" />
<meta property="og:image" content="<%=Image %>" />
<meta property="og:image:width" content="550" />
<meta name="twitter:card" content="summary" />
<meta name="twitter:description" content="Join Livestock Of The World. Livestock Of The World is a network of online community marketplaces for horses, cattle, dogs, donkeys, goats, chickens, turkeys, emus, rabbits, llamas, alpacas, pigs, and sheep." />
<meta name="twitter:title" content="Livestock Of The World" />
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
IntroLogo  = "https://www.livestockofamerica.com/" & rs("SubscriptionLogo") 

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


 %>
</head>
<body >
<% Current = "WebDesign" %>
<!--#Include virtual="/Header.asp"--> 


<% discount = 0 
showcomplete =False
showvendor= False
showlogoadoffer = False
%>
<% ' lg+ navigation  %>



<div class="container d-none d-lg-block">
  <div>
     <div style = "min-width: 800px">
           <div style="max-width:200px">   Marketplace
           <form action="/Join/PassToRegion.asp" method = "post">
             <!--#Include virtual="/includefiles/marketplacelistdropdowninclude.asp"-->
            <center><button type="submit" class="regsubmit2" >Submit</button></center>
            </form>
            </div> 
     <a name = "Top"></a>
<H1>Membership Options</h1>

<br />
     <table cellpadding = 0 cellspacing = 0 border = 0 width = "100%">
       <tr >
         <td class = "body" width = "220"><b><center>Features</center></b></td>
         <td class = "body" ><b><center>Intro</center></b></td>
         <td class = "body" ><b><center>Basic</center></b></td>
         <td class = "body" ><b><center>Business</center></b></td>
         <td class = "body" ><b><center>International</center></b></td>
         <td class = "body" ><b><center>Global</center></b></td>
      </tr>
       
       
        <tr><td height = 1 colspan = 6 bgcolor = black></td></tr>
        <tr><td height = 6 colspan = 6 bgcolor = white></td></tr>
     <tr >
         <td ><font size = 4>Complete Animal Listings</font><br />
         <font size = 2>Pricing, Description, Ancestry, Progeny, Video, 8 photos, & much more!</font></td>
         <td align = "center">0</td>
         <td align = "center">0</td>
         <td align = "center">Unlimited</b></td>
         <td align = "center">Unlimited</b></td>
         <td align = "center">Unlimited</td>
      </tr>
       <tr><td height = 8 colspan = 6 bgcolor = white></td></tr>
      <tr bgcolor = "dddddd" >
         <td ><font size = 4>Simple Animal Classifieds</font><br />
         <font size = 2>Pricing, Description, 1 photo.</font>
         </td>
         <td class = "body"><center>5<center></td>
         <td class = "body"><center>20<center></td>
         <td class = "body"><center>0<center></td>
         <td class = "body"><center>0<center></td>
         <td class = "body"><center>0<center></td>
      </tr>

 
       <tr><td height = 8 colspan = 6 bgcolor = white></td></tr>
      <tr>
         <td><font size = 4>Featured Animal Ads</font><br />
         <font size = 2>Your featured listing will show up on the marketplace home page!</font></td>
         <td align = "center">0</td>
         <td align = "center">0</td>
         <td align = "center">1</b></td>
         <td align = "center"><font size = 5 color = darkgreen><b>&#10003;</b></font></b></td>
         <td align = "center"><font size = 5 color = darkgreen><b>&#10003;</b></font></td>
      </tr>
       <tr><td height = 8 colspan = 6 bgcolor = white></td></tr>
       <tr bgcolor = "dddddd" >
         <td><font size = 4>Product Listings</font></td>
         <td align = "center">1</td>
         <td align = "center">5</td>
         <td align = "center">Unlimited</b></td>
         <td align = "center">Unlimited</b></td>
         <td align = "center">Unlimited</td>
      </tr>
       <tr><td height = 8 colspan = 6 bgcolor = white></td></tr>
       <tr>
         <td><font size = 4>Service Listings</font></td>
         <td align = "center">1</td>
         <td align = "center">5</td>
         <td align = "center">Unlimited</b></td>
         <td align = "center">Unlimited</b></td>
         <td align = "center">Unlimited</td>
      </tr>
       <tr><td height = 8 colspan = 6 bgcolor = white></td></tr>
        <tr bgcolor = "dddddd" >
         <td><font size = 4>Appear on # Marketplace(s)</font><br />
         <font size = 2>The more marketplaces, the more attention you get!</font></td>
         <td align = "center">1</td>
         <td align = "center">1</td>
         <td align = "center">1</b></td>
         <td align = "center">2</b></td>
         <td align = "center">All of Them</td>
      </tr>
    <% websitesavailable = False
      if websitesavailable = true then %>
      <tr><td height = 5 colspan = 6 bgcolor = white></td></tr>
       <tr><td colspan = 6><h2>Business Website</h2></td></tr>
         <tr><td height = 5 colspan = 6 bgcolor = white></td></tr>
     <tr bgcolor = "dddddd" >
         <td><font size = 4>Secure Hosting (SSL)</font></td>
         <td align = "center"><font size = 5 color = darkgreen><b>&#10003;</b></font></td>
         <td align = "center"><font size = 5 color = darkgreen><b>&#10003;</b></font></td>
         <td align = "center"><font size = 5 color = darkgreen><b>&#10003;</b></font></td>
         <td align = "center"><font size = 5 color = darkgreen><b>&#10003;</b></font></td>
         <td align = "center"><font size = 5 color = darkgreen><b>&#10003;</b></font></td>
      </tr>
       <tr><td height = 5 colspan = 6 bgcolor = white></td></tr>
      <tr>
         <td><font size = 4>Custom URL</font></td>
         <td align = "center"></td>
         <td align = "center"></td>
         <td align = "center"><font size = 5 color = darkgreen><b>&#10003;</b></font></td>
         <td align = "center"><font size = 5 color = darkgreen><b>&#10003;</b></font></td>
         <td align = "center"><font size = 5 color = darkgreen><b>&#10003;</b></font></td>
      </tr>
       <tr><td height = 5 colspan = 6 bgcolor = white></td></tr>
      <tr bgcolor = "dddddd" >
         <td><font size = 4>Basic Pages</font><br />
         <small>Home Page, About Us, Contact Us, Basic Animals For Sale & Stud pages.</small></td>
         <td align = "center"><font size = 5 color = darkgreen><b>&#10003;</b></font></td>
         <td align = "center"><font size = 5 color = darkgreen><b>&#10003;</b></font></td>
         <td align = "center"><font size = 5 color = darkgreen><b>&#10003;</b></font></td>
         <td align = "center"><font size = 5 color = darkgreen><b>&#10003;</b></font></td>
         <td align = "center"><font size = 5 color = darkgreen><b>&#10003;</b></font></td>
      </tr>
       <tr><td height = 5 colspan = 6 bgcolor = white></td></tr>
      <tr >
         <td><font size = 4>ECommerce Pages</font><br />
         <small>Products for Sale, Shopping Cart, Checkout pages</small></td>
         <td align = "center"></td>
         <td align = "center"><font size = 5 color = darkgreen><b>&#10003;</b></font></td>
         <td align = "center"><font size = 5 color = darkgreen><b>&#10003;</b></font></td>
         <td align = "center"><font size = 5 color = darkgreen><b>&#10003;</b></font></td>
         <td align = "center"><font size = 5 color = darkgreen><b>&#10003;</b></font></td>
      </tr>
      <tr><td height = 5 colspan = 6 bgcolor = white></td></tr>
      <tr bgcolor = "dddddd" >
         <td><font size = 4>Advanced Pages</font><br />
         <font size = 2>Complete Animals for Sale & Stud pages, Coming Attractions, Services, and much more.</font></td>
         <td align = "center"></td>
         <td align = "center"></td>
         <td align = "center"><font size = 5 color = darkgreen><b>&#10003;</b></font></td>
         <td align = "center"><font size = 5 color = darkgreen><b>&#10003;</b></font></td>
         <td align = "center"><font size = 5 color = darkgreen><b>&#10003;</b></font></td>
      </tr>
      <% end if %>
      <tr><td height = 5 colspan = 6 bgcolor = white></td></tr>
      <tr bgcolor = "dddddd">
         <td><font size = 4>Price</font></td>
         <td align = "center" valign = bottom><b>FREE</b>
         <form action= 'SetupAccountPlus.asp?Membership=Intro' method = "post"><input type=submit value = "SELECT" class = "regsubmit2" ></form></center>
         
         </td>
       <td align = "center"><b><%=CurrencyCode %><%= BasicMonthlyRate%>&nbsp;<%=LocalCurrency%>  / Month</b>
         <form action= 'SetupAccountPlus.asp?Membership=Basic' method = "post"><input type=submit value = "SELECT" class = "regsubmit2" ></form></center></td>
         <td align = "center"><b><%=CurrencyCode %><%= BusinessMonthlyRate%>&nbsp;<%=LocalCurrency%>  / Month</b>
         <form action= 'SetupAccountPlus.asp?Membership=Business' method = "post"><input type=submit value = "SELECT" class = "regsubmit2" ></form></center></td>
         <td align = "center"><b><%=CurrencyCode %><%= InternationalMonthlyRate%>&nbsp;<%=LocalCurrency%>  / Month</b>
          <form action= 'SetupAccountPlus.asp?Membership=International' method = "post"><input type=submit value = "SELECT" class = "regsubmit2" ></form></center></td></td>

           <td align = "center"><b><%=CurrencyCode %><%= GlobalMonthlyRate%>&nbsp;<%=LocalCurrency%>  / Month</b>
          <form action= 'SetupAccountPlus.asp?Membership=Global' method = "post"><input type=submit value = "SELECT" class = "regsubmit2" ></form></center></td></td>
      </tr>
    </table>

    </div>
  </div>
</div>
<% ' XS and SM navigation  %>
<div class="container d-lg-none">
  <div>
     <div style = >
     <a name = "Top"></a>
           <div style="max-width:200px">   Marketplace
       <form action="/Join/PassToRegion.asp" method = "post">
         <!--#Include virtual="/includefiles/marketplacelistdropdowninclude.asp"-->
        <center><button type="submit" class="regsubmit2" >Submit</button></center>
</form>
</div> 
<H1>Membership Options</h1>
<br />
<table width = 100% align =center style = "max-width:400px">
  <tr>
    <td width = 100% class = body>


        <center><%=IntroDescription%><br /><br />
        <i><%=IntroFeatures%></i><br />
       <b><%= IntroMonthlyRate%></b><br />
        <form action= 'SetupAccountfree.asp?Membership=FreeTrial' method = "post"><input type=submit value = "SELECT" class = "regsubmit2" ></form>
        <small>We will not ask for a credit card. This option is free and stays free.</small></center>
        <br />
        <br />
         
        <center><%=BasicDescription%><br /><br />
        <i><%=BasicFeatures%></i><br />
    
        <br />
       <b><%=CurrencyCode %><%= BasicMonthlyRate%>&nbsp;<%=LocalCurrency%>  / Month</b><br />
        <form action= 'SetupAccountPlus.asp?Membership=Intro' method = "post"><input type=submit value = "SELECT" class = "regsubmit2" ></form>
         <br />
        <br />

        <center><%=BusinessDescription%><br /><br />
        <i><%=BusinessFeatures%></i><br /><br />
         <b><%=CurrencyCode %><%= BusinessMonthlyRate%>&nbsp;<%=LocalCurrency%>  / Month</b><br />
        <form action= 'SetupAccountPlus.asp?Membership=Business' method = "post"><input type=submit value = "SELECT" class = "regsubmit2" ></form>
         <br />
        <br />
        <center><%=InternationalDescription%><br /><br />
        <i><%=InternationalFeatures%></i><br /><br />
        <b><%=CurrencyCode %><%= InternationalMonthlyRate%>&nbsp;<%=LocalCurrency%>  / Month</b><br />
        <form action= 'SetupAccountPlus.asp?Membership=International' method = "post"><input type=submit value = "SELECT" class = "regsubmit2" ></form>
         <br />
        <br />

        <center><%=GlobalDescription%><br /><br />
        <i><%=GlobalFeatures%></i><br /><br />
         <b><%=CurrencyCode %><%= GlobalMonthlyRate%>&nbsp;<%=LocalCurrency%>  / Month</b><br />
        <form action= 'SetupAccountPlus.asp?Membership=Global' method = "post"><input type=submit value = "SELECT" class = "regsubmit2" ></form>
         <br />
        <br />

    </td>
  </tr>
</table>
</div>
</div>
</div>


<br /><br />

<!--#Include virtual="/Footer.asp"-->