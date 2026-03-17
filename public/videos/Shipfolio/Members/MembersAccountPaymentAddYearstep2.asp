<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!--#Include file="MembersGlobalVariables.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
</head>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center" >

<%
years = request.form("years")
website = request.form("website")

'response.write("years=" & years & "<br>" )
'response.write("website =" & website  & "<br>" )


if InStr(website, "World Farm Store") > 0  Then
WFSSignup = True
websitesignupcount = websitesignupcount + 1

Query =  "INSERT INTO peoplewebsitesubscribe (PeopleID, SubscribedWebsite)" 
Query =  Query & " Values (" &  PeopleID & ", "
Query =  Query &   " 'World Farm Store'  )" 
'response.write("Query=" & Query)	
Conn.Execute(Query) 
else
WFSSignup = false

Query =  "Delete from peoplewebsitesubscribe where peopleID = " &  PeopleID & " and SubscribedWebsite = 'World Farm Store' " 
'response.write("Query=" & Query)	
Conn.Execute(Query) 


end if 


if InStr(website, "Livestock Of America") > 0 or InStr(website, "LOA") > 0  Then
LOASignup = True
websitesignupcount = websitesignupcount + 1

Query =  "INSERT INTO peoplewebsitesubscribe (PeopleID, SubscribedWebsite)" 
Query =  Query & " Values (" &  PeopleID & ", "
Query =  Query &   " 'Livestock Of America'  )" 
'response.write("Query=" & Query)	
Conn.Execute(Query) 
else
LOASignup = false

Query =  "Delete from peoplewebsitesubscribe where peopleID = " &  PeopleID & " and SubscribedWebsite = 'Livestock Of America' " 
'response.write("Query=" & Query)	
Conn.Execute(Query) 


end if 

if InStr(website, "Livestock Of Canada") > 0 or InStr(website, "LOC") > 0 Then
LOCSignup = True
websitesignupcount = websitesignupcount + 1
Query =  "INSERT INTO peoplewebsitesubscribe (PeopleID, SubscribedWebsite)" 
Query =  Query & " Values (" &  PeopleID & ", "
Query =  Query &   " 'Livestock Of Canada'  )" 
'response.write("Query=" & Query)	
Conn.Execute(Query) 

else
LOCSignup = false

Query =  "Delete from peoplewebsitesubscribe where peopleID = " &  PeopleID & " and SubscribedWebsite = 'Livestock Of Canada' " 
'response.write("Query=" & Query)	
Conn.Execute(Query) 

end if 




Discount = 20'Percent
Oldmembership=request.form("Oldmembership")
Newmembership=request.form("Newmembership")
PeopleId=request.form("PeopleId")
TotalPrice = request.form("TotalPrice")
'response.write("TotalPrice=" & TotalPrice )
ToPerform = request.form("ToPerform")
Years = request.form("Years")  

Query =  " insert into PeopleRenewel (PeopleID, OldmembershipID, NewmembershipID, Years) "
Query =  Query &  "values (" & PeopleID & ", " & Oldmembership & " , " & Newmembership & " , " & Years & ");" 
'response.write("Query =" & Query )
Conn.Execute(Query) 

if Newmembership = 3 then
Membership = "Basic"
end if

if Newmembership = 5 then
Membership = "Vendor"
end if

if Newmembership = 3 then
Membership = "Premium"
end if



sql =  "select * from address, people where address.addressid = people.addressid and peopleId = " & Peopleid 
rs.Open sql, conn, 3, 3   
If not rs.eof Then

PeopleFirstName  =rs("PeopleFirstName") 
PeopleLastName  =rs("PeopleLastName") 
PeopleTitleID =rs("PeopleTitleID") 
CustCountry =rs("CustCountry") 
PeopleEmail =rs("PeopleEmail") 
if len(Peopleemail)> 0  then
else
Peopleemail =rs("PeopleEmail") 
end if
AddressStreet = rs("AddressStreet") 
AddressApt = rs("AddressApt") 
AddressCity  = rs("AddressCity")
AddressState  = rs("AddressState")
AddressZip  = rs("AddressZip")
PeoplePhone  = rs("PeoplePhone")
PeopleCell  = rs("PeopleCell")
PeopleFax  = rs("PeopleFax")
PeopleID = rs("PeopleID")


end if
rs.close
Conn.close


test = False
if test = True then%>
<form action="https://www.sandbox.paypal.com/cgi-bin/webscr" method="post" >
<% else %>
<form action="https://www.paypal.com/cgi-bin/webscr" method="post" target="_top">
<% end if %>


<input type="hidden" name="add" value="1"/>
<input type="hidden" name="cmd" value="_cart"/>
<input type="hidden" name="business" value="ContactUs@LivestockOfTheWorld.com">   
<input type="hidden" name="currency_code" value="USD">

<% if len(discount) > 0 then
Rate = DiscountRate
end if %>
				<input type="hidden" name="amount" value="<%=TotalPrice%>"/>
				<input type="hidden" name="no_shipping" value="0"/>
				<input type="hidden" name="no_note" value="1"/>
				<input type="hidden" name="lc" value="US"/>
				<input type="hidden" name="bn" value="PP-ShopCartBF"/>
<input type="hidden" name="quantity" value="1">

<% if years = 1 then %>
<input type="hidden" name="item_name" value="<%=years %> Year Livestock Of The World <%=membership %> Membership">
<% else %>
<input type="hidden" name="item_name" value="<%=years %> Years Livestock Of The World <%=membership %> Membership">
<% end if %>
<input type="hidden" name="item_number" value="<%=membership %>" Membership">
<input type="hidden" name="currency_code" value="USD">

<input type="hidden" name="cancel_return" value="http://www.LivestockOfTheWorld.com/members/membersAccountPaymentAddYear.asp?membership=<%=membership %>&PeopleID=<%=PeopleID%>&Peopleemail=<%=Peopleemail %>">
<input type="hidden" name="cbt" value="Return to Livestock Of The World">
<input type="hidden" name="return" value="http://www.LivestockOfTheWorld.com/SignUpCompletionPage.asp">
    <input type="hidden" name="bn" value="PP-BuyNowBF">
    
<input type="hidden" name="first_name" value="<%=PeopleFirstName %>">
<input type="hidden" name="last_name" value="<%=PeopleLastName %>">
<input type="hidden" name="address1" value="<%=AddressStreet %>">
<input type="hidden" name="address2" value="<%=AddressApt %>">
<input type="hidden" name="city" value="<%=AddressCity %>">
<input type="hidden" name="state" value="<%=AddressState %>">
<input type="hidden" name="zip" value="<%=AddressZip  %>">
<input type="hidden" name="lc" value="<%=CustCountry  %>">
<input type="hidden" name="email" value="<%=Peopleemail  %>">


<input name="custom" type="hidden" id="Hidden2" value="<%=PeopleID %>"> 
<input type="hidden" name="no_shipping" value="0">
<input type="hidden" name="no_note" value="1">
<input type="hidden" name="lc" value="AU">
<input type="hidden" name="rm" value="2">

 <center><input type="image" src="/administration/images/px.gif" border="0" name="submit" ></center>

</form>





 <% test = false
  if test = false then %>
 <SCRIPT LANGUAGE="JavaScript">     document.forms[0].submit();</SCRIPT>
 <% end if %>
</Body>
</HTML>

