<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!--#Include file="AdminGlobalVariables.asp"-->
</head>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center" >
<% Discount = 0'Percent
Current2="Account"
 Current3 = "Membership"  %> 
<!--#Include file="adminHeader.asp"-->
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

Colwidth =295
If Membershiplevel  =  18 then
membershipname = "Student"
end if
If Membershiplevel  =  19 then
membershipname = "Trial"
end if

if Membershiplevel  =  0 or Membershiplevel  =  18 or Membershiplevel  =  19 then
Colwidth = 235
end if
%>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%" ><tr><td class = "body roundedtopandbottom" align = "left">
		<H1><div align = "left">Renew / Upgrade Your Livestock Of America Memberships</div></H1>
<% if discount > 0 then%>
 <b>No need for Coupons!</b> We will automatically apply the best discount to save you the most money.
 <% end if %>
<br />





<table>
<tr><td class = 'body'>
<font size = 4>Gold Membership</font><font size = 3>......................................................<font size = 3><b>Free</font></b><br /><font size = 3>
5 animals listings, 1 image each, member ranch pages (includes home page, animals for sale, stud listings, products, about us, & contact us pages), and product listings.<br /><br />
Default membership. If you want a gold membership, you don't need to do anything.<br /><br /></font>
<br />

<img src="/images/Platinummembershipbadge.png" align = "left" height = 175/><font size = 5>Platinum Membership</font>.......<font size = 3><b><strike>$85/Year</strike>$42.50</font></b><br /><br />
Unlimited animals listings, unlimited stud listings, 8 images each, video uploads, member ranch pages (includes home page, animals for sale, stud listings, products for sale, packages, about us, & contact us pages), property listings, business listings, classifieds, packages, 4 Auctions at a time, unlimited product & fiber listings,  and search classifieds.
<br /><br /><center><b>Half Off. Only $42.50! <br />Sale ends Tuday April 5 <sup>th</sup>.</center></b>
<center><form action= 'AdminAccountPaymentAddYear.asp?Oldmembership=<%=Membershiplevel %>&Newmembership=4' method = "post">
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
 <%if Membershiplevel = 4 then %>
<center><input type=submit value = "Renew " size = '3' class = "regsubmit2" ></center>
<% else %>
<center><input type=submit value = "Upgrade" size = '3' class = "regsubmit2" ></center>
<% end if %>
</form></center>
<br /><br />


</td>
<td width = "300" class = "body roundedtopandbottom" >
<font size = 4><b>Search Classifieds</b></font></br><br>
<b>Exclusive Only to Platinum Members!</b></br><br />
Automatically display your animals right where you want them to be seen. As buyers search for the type of animals that you are selling, your animal’s classified ad will appear and make your animal stand out! For instance if you have a black suri alpaca for sale and a buyer searches for black suri alpacas your classified will be displayed prominently with a photo, name, price, stud fee (if appropriate), category, and a link to your animal. This is a great way to make your specific animals stand out right where you want them to.<br />
<br />
You don't need to anything; search classifieds are generated automatically.

</td>
</tr>
</table>





<br /><br />
<!--#Include virtual="/Footer.asp"-->
</body>
</html>