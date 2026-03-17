<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<title>Alpaca Infinity Administration</title>
<meta name="Title" content="Alpaca Infinity Administration"/>
<meta name="robots" content="nofollow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="revisit-after" content="1"/>
<meta name="Googlebot" content="nofollow"/>
<link rel="shortcut icon" href="/infinityknot.ico" /> 
<link rel="icon" href="http://www.alpacainfinity.com/alpacachamps/infinityknot.ico" /> 
<meta name="author" content="The Andresen Group"/>
<link rel="stylesheet" type="text/css" href="/style.css" />
<!--#Include file="AdminGlobalVariables.asp"-->
</head>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center" >
<!--#Include virtual="/Header.asp"--> 
<!--#Include file="AdminSecurityInclude.asp"-->
<% 
Current3 = "Membership" 
Current3="AccountHome" %> 
<!--#Include virtual="/adminHeader.asp"-->
<br>
<!--#Include file="AdminAccountTabsInclude.asp"-->

<% 
sql = "select distinct People.*, address.*  from People, Address where People.AddressID = Address.AddressID and People.AddressID = Address.AddressID and people.PeopleID = " & PeopleID
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
if  Not rs.eof then 
custAIStartService= rs("custAIStartService")  
custAIEndService= rs("custAIEndService")  
Membershiplevel = rs("SubscriptionLevel")  
PeopleEmail = rs("PeopleEmail")
PeopleFirstName = rs("PeopleFirstName")
PeopleLastName = rs("PeoplelastName")
PeoplePhone = rs("PeoplePhone")
AddressApt = rs("AddressApt")
AddressCity= rs("AddressCity")
AddressState = rs("AddressState")
AddressZip = rs("AddressZip")
AddressCountry = rs("AddressCountry")
 AddressStreet = rs("AddressStreet")
 WebsitesID = rs("WebsitesID")
PeopleCell = rs("PeopleCell")
 PeopleFax= rs("Peoplefax")
Logo= rs("Logo")
Owners= rs("Owners")
PeopleTitleID = rs("PeopleTitleID") 
PeopleEmail= rs("PeopleEmail") 
 rs.close
  end if
  
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

Membershiplevel  = 1
%>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%" ><tr><td class = "roundedtopandbottom" align = "left">
		<H1><div align = "left">Renew or Upgrade Your Alpaca Infinity Memberships</div></H1><br />
        <table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "800" >
        <tr>
        <td width = '250'  valign = "top">
        <table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = '250' class = "roundedtopandbottom body">
         <tr><td class = "body" height = "30" bgcolor = "dcdcdc"><h2>Membership Level</h2></td></tr>
         <tr><td class = "body" height = "120" >
         <big>Basic Farm Pages:
        <ul><li>Home</li>
         <li>Alpacas for Sale</li>
         <li>Herdsires</li>
          <li>Packages</li>
        <li>About Us</li>
        <li>Contact Us</li>
        </ul></big>
        </td></tr>
        <tr><td class = "body" height = "30" bgcolor = "dcdcdc">
        <big> No. Alpacas for Sale </big>
        </td></tr>
        <tr><td class = "body" height = "30">
        <big>No. Herdsires for Breeding </big>
        </td></tr>
        <tr><td class = "body" height = "30" bgcolor = "dcdcdc">
         <big>Packages </big>
        </td></tr>
        <tr><td class = "body" height = "30">
         <big>No. Products </big></td></tr>
        <tr><td class = "body" height = "60" bgcolor = "dcdcdc">
         <big>Free Header Ads <br />(worth $45 each) </big>
        </td></tr>
        <tr><td class = "body" height = "60">
         <big>Free Home Page Ads <br />(worth $125 each) </big>
        </td></tr>
        <tr><td class = "body" height = "60" bgcolor = "dcdcdc">
         <big>Free one-time sale list upload (from another website). </big>
        </td></tr>
         <tr><td class = "body2" align = center height = "30">
         <big><b>Rate</b></big>
        </td></tr>
        </table>
        </td>
        <td width = '175' align= "center"  valign = "top">
         <table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "175" class = "roundedtopandbottom">
          <tr><td class = "body2" height = "30" bgcolor = "dcdcdc" align = "center"><h2><center>Copper</center></h2></td></tr>
              
        <tr><td class = "body2" valign = "top" align = "center" height = "120">
        <big><b>Yes</b></big>
        </td></tr>
        <tr><td class = "body2" align = center height = "30" bgcolor = "dcdcdc">
         <big><b>5<b></big>
        </td></tr>
        <tr><td class = "body2" align = center height = "30">
         <big><b>1</b></big>
        </td></tr>
        <tr><td class = "body2" align = center height = "30" bgcolor = "dcdcdc">
         <big><b>Infinite</b></big>
        </td></tr>
        <tr><td class = "body2" align = center height = "30">
         <big><b>5</b></big>
        </td></tr>
        <tr><td class = "body2" align = center height = "60" bgcolor = "dcdcdc">
         <big><b>0</b></big>
        </td></tr>
        <tr><td class = "body2" align = center height = "60">
         <big><b>0</b></big>
        </td></tr>
         <tr><td class = "body2" align = center height = "60" bgcolor = "dcdcdc">
         <big><b>0</b></big>
        </td></tr>
         <tr><td class = "body2" align = center height = "30">
         <big><b>FREE</b></big>
        </td></tr>
        <tr><td class = "body2" align = center valign = "top" height = "60" bgcolor = "dcdcdc"><br />
          <% if Membershiplevel  =  4 then %>
        <big><b>N/A - Platinum memberships cannot be degraded.</b></big>
        <% else %>
    <% if Membershiplevel  =  1 then %>
        <big><b>Your Current Membership</b></big>
        <% else %>
          <form action= 'AdminAccountsetupStep2.asp?Membership=copper' method = "post">
        
  
<center><input type=submit value = " Change Membership " class = "regsubmit2" ></center>
</form>
<% end if %>
<% end if %>
        </td></tr>
        </table></td>
         <td width = '175' align= "center"  valign = "top">
         <table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "175" class = "roundedtopandbottom">
          <tr><td class = "body2" height = "30" bgcolor = "dcdcdc" align = "center"><h2><center>Silver</center></h2></td></tr>
        <tr><td class = "body2" valign = "top" align = "center" height = "120">
        <big><b>Yes</b></big>
        </td></tr>
        <tr><td class = "body2" align = center height = "30" bgcolor = "dcdcdc">
         <big><b>20</b></big>
        </td></tr>
        <tr><td class = "body2" align = center height = "30">
         <big><b>3</b></big>
        </td></tr>
        <tr><td class = "body2" align = center height = "30" bgcolor = "dcdcdc">
         <big><b>Infinite</b></big>
        </td></tr>
        <tr><td class = "body2" align = center height = "30">
         <big><b>5</b></big>
        </td></tr>
        <tr><td class = "body2" align = center height = "60" bgcolor = "dcdcdc">
         <big><b>0</b></big>
        </td></tr>
        <tr><td class = "body2" align = center height = "60" >
         <big><b>0</b></big>
        </td></tr>
           <tr><td class = "body2" align = center height = "60" bgcolor = "dcdcdc"> <big><b>0</b></big>
        </td></tr>
         <tr><td class = "body2" align = center height = "30">
         <big><b>$45 / Year</b></big>
        </td></tr>
        <tr><td class = "body2" align = center valign = "top" height = "60" bgcolor = "dcdcdc"><br />
          <% if Membershiplevel  =  4 then %>
        <big><b>N/A - Platinum memberships cannot be degraded.</b></big>
        <% else %>
    <% if Membershiplevel  =  2 then %>
        <big><b>Your Current Membership</b></big>
        <% else %>
          <form action= 'AdminAccountsetupStep2.asp?Membership=silver' method = "post">
        <input type = "hidden" name = "PeopleFirstName" value = "<%=PeopleFirstName%>" /> 
          <input type = "hidden" name = "PeoplelastName" value = "<%=PeoplelastName%>" /> 
          <input type = "hidden" name = "PeopleEmail" value = "<%=PeopleEmail%>" /> 
          <input type = "hidden" name = "AddressStreet" value = "<%=AddressStreet%>" /> 
          <input type = "hidden" name = "AddressApt" value = "<%=AddressApt%>" /> 
          <input type = "hidden" name = "AddressCity" value = "<%=AddressCity%>" /> 
          <input type = "hidden" name = "AddressState" value = "<%=AddressState%>" /> 
          <input type = "hidden" name = "AddressZip " value = "<%=AddressZip %>" /> 
          <input type = "hidden" name = "PeoplePhone " value = "<%=PeoplePhone %>" /> 
          <input type = "hidden" name = "PeopleID" value = "<%=PeopleID%>" /> 
          <input type = "hidden" name = "custAIStartService" value = "<%=custAIStartService%>" /> 
          <input type = "hidden" name = "custAIEndService" value = "<%=custAIEndService%>" /> 
<center><input type=submit value = " Change Membership " class = "regsubmit2" ></center>
</form>
<% end if %>
<% end if %>
        </td></tr>
        </table></td>
         <td width = '175' align= "center"  valign = "top">
         <table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "175" class = "roundedtopandbottom">
          <tr><td class = "body2" height = "30" bgcolor = "dcdcdc" align = "center"><h2><center>Gold</center></h2></td></tr>
        <tr><td class = "body2" valign = "top" align = "center" height = "120">
        <big><b>Yes</b></big>
        </td></tr>
        <tr><td class = "body2" align = center height = "30" bgcolor = "dcdcdc">
         <big><b>Infinite</b></big>
        </td></tr>
        <tr><td class = "body2" align = center height = "30">
         <big><b>Infinite</b></big>
        </td></tr>
        <tr><td class = "body2" align = center height = "30" bgcolor = "dcdcdc">
         <big><b>Infinite</b></big>
        </td></tr>
        <tr><td class = "body2" align = center height = "30">
         <big><b>Infinite</b></big>
        </td></tr>
        <tr><td class = "body2" align = center height = "60" bgcolor = "dcdcdc">
         <big><b>1 Month</b></big>
        </td></tr>
        <tr><td class = "body2" align = center height = "60">
         <big><b>0</b></big>
        </td></tr>
           <tr><td class = "body2" align = center height = "60" bgcolor = "dcdcdc">
         <big><b>20 Animals & Products</b></big>
        </td></tr>
         <tr><td class = "body2" align = center height = "30">
         <big><b>$89 / Year</b></big>
        </td></tr>
        <tr><td class = "body2" align = center valign = "top" height = "60" bgcolor = "dcdcdc"><br />
         <% if Membershiplevel  =  4 then %>
        <big><b>N/A - Platinum memberships cannot be degraded.</b></big>
        <% else %>

    <% if Membershiplevel  =  3 then %>
        <big><b>Your Current Membership</b></big>
        <% else %>
          <form action= 'AdminAccountsetupStep2.asp?Membership=gold' method = "post">
           <input type = "hidden" name = "PeopleFirstName" value = "<%=PeopleFirstName%>" /> 
          <input type = "hidden" name = "PeoplelastName" value = "<%=PeoplelastName%>" /> 
          <input type = "hidden" name = "PeopleEmail" value = "<%=PeopleEmail%>" /> 
          <input type = "hidden" name = "AddressStreet" value = "<%=AddressStreet%>" /> 
          <input type = "hidden" name = "AddressApt" value = "<%=AddressApt%>" /> 
          <input type = "hidden" name = "AddressCity" value = "<%=AddressCity%>" /> 
          <input type = "hidden" name = "AddressState" value = "<%=AddressState%>" /> 
          <input type = "hidden" name = "AddressZip " value = "<%=AddressZip %>" /> 
          <input type = "hidden" name = "PeoplePhone " value = "<%=PeoplePhone %>" /> 
          <input type = "hidden" name = "PeopleID" value = "<%=PeopleID%>" /> 
          <input type = "hidden" name = "custAIStartService" value = "<%=custAIStartService%>" /> 
          <input type = "hidden" name = "custAIEndService" value = "<%=custAIEndService%>" /> 
<center><input type=submit value = " Change Membership " class = "regsubmit2" ></center>
</form>
<% end if %>
<% end if %>

        </td></tr>
        </table></td>
          <td width = '175' align= "center"  valign = "top">
         <table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "175" class = "roundedtopandbottom">
          <tr><td class = "body2" height = "30" bgcolor = "dcdcdc" align = "center"><h2><center>Platinum</center></h2></td></tr>
        <tr><td class = "body2" valign = "top" align = "center" height = "120">
        <big><b>Yes</b></big>
        </td></tr>
        <tr><td class = "body2" align = center height = "30" bgcolor = "dcdcdc">
         <big><b>Infinite</b></big>
        </td></tr>
        <tr><td class = "body2" align = center height = "30">
         <big><b>Infinite</b></big>
        </td></tr>
        <tr><td class = "body2" align = center height = "30" bgcolor = "dcdcdc">
         <big><b>Infinite</b></big>
        </td></tr>
        <tr><td class = "body2" align = center height = "30">
         <big><b>Infinite</b></big>
        </td></tr>
        <tr><td class = "body2" align = center height = "60" bgcolor = "dcdcdc">
         <big><b>2 Months</b></big>
        </td></tr>
        <tr><td class = "body2" align = center height = "60">
         <big><b>1 Month</b></big>
        </td></tr>
           <tr><td class = "body2" align = center height = "60" bgcolor = "dcdcdc">
         <big><b>30 Animals & Products</b></big>
        </td></tr>
         <tr><td class = "body2" align = center height = "30">
         <big><b>$189 Lifetime Membership*</b></big>
        </td></tr>
        <tr><td class = "body2" align = center valign = "top" height = "60" bgcolor = "dcdcdc"><br />
    <% if Membershiplevel  =  4 then %>
        <big><b>Your Current Membership</b></big>
        <% else %>
          <form action= 'AdminAccountsetupStep2.asp?Membership=platinum' method = "post">
         <input type = "hidden" name = "PeopleFirstName" value = "<%=PeopleFirstName%>" /> 
          <input type = "hidden" name = "PeoplelastName" value = "<%=PeoplelastName%>" /> 
          <input type = "hidden" name = "PeopleEmail" value = "<%=PeopleEmail%>" /> 
          <input type = "hidden" name = "AddressStreet" value = "<%=AddressStreet%>" /> 
          <input type = "hidden" name = "AddressApt" value = "<%=AddressApt%>" /> 
          <input type = "hidden" name = "AddressCity" value = "<%=AddressCity%>" /> 
          <input type = "hidden" name = "AddressState" value = "<%=AddressState%>" /> 
          <input type = "hidden" name = "AddressZip " value = "<%=AddressZip %>" /> 
          <input type = "hidden" name = "PeoplePhone " value = "<%=PeoplePhone %>" /> 
          <input type = "hidden" name = "PeopleID" value = "<%=PeopleID%>" /> 
          <input type = "hidden" name = "custAIStartService" value = "<%=custAIStartService%>" /> 
          <input type = "hidden" name = "custAIEndService" value = "<%=custAIEndService%>" /> 
<center><input type=submit value = " Change Membership " class = "regsubmit2" ></center>
</form>
<% end if %>

        </td></tr>
        </table></td>
	</tr>
</table>
 <div class = 'body'><br />* Platinum members' membership last as long as Alpaca Infinity exists and it is owned by <a href= 'http://www.theandresengroup.com' target = 'blank' class = "body"></a>The ANDRESEN<b>GROUP</b></a>.</div>
<br /><br />
<!--#Include virtual="/Footer.asp"-->
</body>
</html>