<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!--#Include file="MembersGlobalVariables.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
</head>
<% if mobiledevice = True or is_iPad = true then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<% end if %>
<% Current1="Account"
Current2 = "UpgradeorRenewYourMembership" %> 
<!--#Include file="MembersHeader.asp"-->
<%

years = request.form("years")
website = request.form("website")




if len(website) > 3 then

if InStr(website, "Livestock Of America") > 0 or InStr(website, "LOA") > 0  Then
LOASignup = True
websitesignupcount = websitesignupcount + 1
else
LOASignup = false
end if 

if InStr(website, "Livestock Of Canada") > 0 or InStr(website, "LOC") > 0 Then
LOCSignup = True
websitesignupcount = websitesignupcount + 1
else
LOCSignup = false
end if 


else

websitesignupcount = 0
sql =  "select SubscribedWebsite from peoplewebsitesubscribe where peopleId = " & Peopleid & " and SubscribedWebsite =  'Livestock Of America'  " 
rs.Open sql, conn, 3, 3   
If not rs.eof Then
	LOASignup = True
    websitesignupcount = websitesignupcount + 1
end if
rs.close

sql =  "select SubscribedWebsite from peoplewebsitesubscribe where peopleId = " & Peopleid & " and SubscribedWebsite =  'Livestock Of Canada'  " 
rs.Open sql, conn, 3, 3   
If not rs.eof Then
	LOCSignup = True
    websitesignupcount = websitesignupcount + 1
end if
rs.close


end if




Discount = 20'Percent
PremiumDiscount = 20'Percent
Oldmembership=request.querystring("Oldmembership")


'response.write("Oldmembership=" & Oldmembership )
if Oldmembership = "8" then
 Oldmembershipname = "Complete"
 Oldmembershipvalue = 0
 ToPerform = "C"
end if


if Oldmembership = "18" then
 Oldmembershipname = "Student"
 Oldmembershipvalue = 0
 ToPerform = "C"
end if
if Oldmembership = "19" then
 Oldmembershipname = "Trial"
 Oldmembershipvalue = 0
 ToPerform = "C"
end if
if Oldmembership = "0" then
 Oldmembershipname = "Inactive"
 Oldmembershipvalue = 0
 ToPerform = "C"
end if
if Oldmembership = "1" then
 Oldmembershipname = "Copper"
 Oldmembershipvalue = 0
 ToPerform = "U"
end if
if Oldmembership = "5" then
 Oldmembershipname = "Vendor"
 Oldmembershipvalue = 24
  ToPerform = "U"
  Website = "World Farm Store"
end if
if Oldmembership = "3" then
 Oldmembershipname = "Basic"
 Oldmembershipvalue = 0
   ToPerform = "U"
end if

if Oldmembership = 4 then
    Oldmembershipname = "Premium"
    Oldmembershipvalue = 98
end if

if Oldmembership = 5 then
    Oldmembershipname = "Vendor"
    Oldmembershipvalue = 24
end if

    NewMembership =request.querystring("Newmembership")

if NewMembership = 1 then
    NewMembershipname = "Copper"
    if Discount > 0 then
    Newmembershipvalue =0
    else
    Newmembershipvalue = 0
    end if
end if
if NewMembership = 5 then
    NewMembershipname = "Vendor"
        if Discount > 0 then
    Newmembershipvalue = 24
    else
    Newmembershipvalue = 24
    end if


end if
if NewMembership= 3 then
 NewMembershipname = "Basic"
        if Discount > 0 then
    Newmembershipvalue = 0 
    else
    Newmembershipvalue = 0
    end if

end if
if NewMembership = 4 then
 NewMembershipname = "Premium"
 if PremiumDiscount > 0 then
    Discount  = PremiumDiscount
 end if
 if Discount > 0 then
     Newmembershipvalue = 98 - (98 * (discount/100))
    else
     Newmembershipvalue = 98
    end if
end if

if NewMembership = 8 then
 NewMembershipname = "Complete"
 if PremiumDiscount > 0 then
    Discount  = PremiumDiscount
 end if
 if Discount > 0 then
     Newmembershipvalue = 349 - (349 * (discount/100))
    else
     Newmembershipvalue = 349
    end if
end if



if NewMembership = 5 then
 NewMembershipname = "Vendor"
 Newmembershipvalue = 24

  if Discount > 0 then
     Newmembershipvalue = 24 - (24 * (discount/100))
    else
     Newmembershipvalue = 24
    end if


end if


ChangeinValue =  Newmembershipvalue -  Oldmembershipvalue 
if oldMembership = NewMembership then
   ToPerform = "R"
   Changeinvalue = Newmembershipvalue
else
if Changeinvalue < 0 then
    ToPerform = "D"
end if

end if




'response.write("ToPerform=" & ToPerform )
custAIStartService=Request.Form("custAIStartService")  
custAIEndService=Request.Form("custAIEndService")  
oldcustAIEndService = custAIEndService
monthinsubscription = DateDiff("m", Now, custAIEndService) 

monthsleftinsubscription = 12 - monthinsubscription
addextramonths = monthsleftinsubscription * 2
custAIEndService  = dateadd("m", addextramonths, custAIEndService)

'response.write("monthinsubscription=" & monthinsubscription )

PeopleFirstName  =Request.Form("PeopleFirstName") 
PeopleLastName  =Request.Form("PeopleLastName") 
PeopleTitleID =Request.Form("PeopleTitleID") 
PeopleWebsite =Request.Form("PeopleWebsite") 
PeopleEmail =Request.Form("PeopleEmail") 
if len(Peopleemail)> 0  then
else
Peopleemail =Request.querystring("PeopleEmail") 
end if
ConfirmEmail =Request.Form("ConfirmEmail") 
confirm  =Request.Form("confirm") 
AddressStreet = Request.Form("AddressStreet") 
AddressApt = Request.Form("AddressApt") 
AddressCity  = Request.Form("AddressCity")
AddressState  = Request.Form("AddressState")
AddressZip  = Request.Form("AddressZip")
PeoplePhone  = Request.Form("PeoplePhone")
PeopleCell  = Request.Form("PeopleCell")
PeopleFax  = Request.Form("PeopleFax")
PeopleID = Request.Form("PeopleID")
if len(PeopleID) > 0 then
else
PeopleID = Request.querystring("PeopleID")
end if 

 Confirmed = False
 Confirmed = request.querystring("Confirmed")







if NewMembership= 3 then

Query =  " UPDATE People Set AISubscription  = 1," 
    Query =  Query & " AESubscription  = 1 ,"
	Query =  Query &  " custAIEndService = '" & cstr(FormatDateTime(custAIEndService ,2)) & "' , " 'custAIEndService
	Query =  Query & " SubscriptionLevel  = " & newmembership & "" 
	Query =  Query & " where PeopleID = " & PeopleID & ";" 
   'response.write("Query =" & Query )
Conn.Execute(Query) 
Conn.close

%>
<br /><br />
<h2><center>Your basic membership has been renewed.</center></h2>
<center><a href = default.asp class = body>Click here to return to your dashboard home page.</a></center>
<%
else





if Oldmembership = "0" then
'Newmembershipvalue = (Newmembershipvalue/2)

end if
'response.write("Newmembershipvalue=" & Newmembershipvalue )
%>

<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%" height = "530">
<tr><td  valign = "top"  align = 'center'>
<% if ToPerform = "D"  then %>

<% if  not Confirmed = "True" then %>
<table border = "0" width = "600" align = "center"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=5 >
	<tr>
		<td class = "body2" colspan = "2" align = "left">
         <h1>Change Your Membership</h1>
           </td>
        </tr>
        <tr><td class = 'body2' align = 'right' width = '290'>Old Membership Level:</td><td class = 'body' ><b><%=Oldmembershipname %></b></td></tr>
        <tr><td class = 'body2' align = 'right'>New Membership Level:</td><td class = 'body' ><b><%=Newmembershipname %><b></td></tr>

    <tr><td class = 'body2' align = 'right'>Prorated Time Added to Membership:</td><td class = 'body' ><b><%=addextramonths %> months</b></td></tr>

    <tr>
    <td class = "body2" colspan = "2" align = "center" valign = "top">
    <br /> 
		 	
	<b>
    This will limit your membership.<br /> Are you sure that you wish to make this change?<br /> 
    </b>
    <% if len(oldcustAIEndService) > 3 then
    else
    oldcustAIEndService = now
    end if %>


     <form action= 'MembersAccountPaymentAddYear.asp?Oldmembership=<%=Oldmembership %>&Newmembership=<%=Newmembership %>&Confirmed=True' method = "post">
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
          <input type = "hidden" name = "custAIEndService" value = "<%=oldcustAIEndService %>" /> 
<center><input type=submit value = " Yes, Change My Account " class = "regsubmit2" ></center>
</form>

    <div align = 'left'><a href = "MembersRenewSubscription.asp?PeopleID=<%=PeopleID%>" class = "body2">Click here to go back.</a></div><br><br>
    </td></tr>
</table>



<% else 

%>
<table border = "0" width = "600" align = "center"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=5 class = "roundedtopandbottom">
	<tr>
		<td class = "body2" colspan = "2" align = "left">
         <h1>Change your Membership</h1>
           </td>
        </tr>
       <% 
      ' response.write("Changeinvalue=" & Changeinvalue )
       
       if ToPerform  = "R" then %>
        <tr><td class = 'body2' align = 'right' width = '290'>Membership Level:</td><td class = 'body' ><b><%=Newmembershipname %><b></td></tr>
       <% else %>
        <tr><td class = 'body2' align = 'right' width = '290'>Old Membership Level:</td><td class = 'body' ><b><%=Oldmembershipname %></b></td></tr>
        <tr><td class = 'body2' align = 'right'>New Membership Level:</td><td class = 'body' ><b><%=Newmembershipname %><b></td></tr>
     <% end if %>
    <% 
    if Changeinvalue < 1 then
    ToPerform = "D"
    
    Query =  " UPDATE People Set AISubscription  = True ," 
    Query =  Query & " AESubscription  = True ,"
	Query =  Query &  " custAIEndService = '" & cstr(FormatDateTime(custAIEndService ,2)) & "' , " 'custAIEndService
	Query =  Query & " SubscriptionLevel  = " & newmembership & "" 
	Query =  Query & " where PeopleID = " & PeopleID & ";" 
   'response.write("Query =" & Query )
Conn.Execute(Query) 
Conn.close
Set Conn = Nothing
    
%>
    <tr><td class = 'body2' align = 'right'>Prorated Time Added to Membership:</td><td class = 'body' ><b><%=addextramonths %> months</b></td></tr>
    <% end if %>
 
 

     
<% if Oldmembershipvalue = 0 then %>
          <tr><td class = 'body2' align = 'right'>Price:</td><td class = 'body' ><b><%=formatcurrency(Newmembershipvalue,2)%><b></td></tr>
     <% else 
   if ChangeinValue > 0 then
  %>
  <tr><td class = 'body2' align = 'right'>Price:</td><td class = 'body' ><b><%=formatcurrency(Changeinvalue ,2) %></b></td></tr>
<% end if %>
   <% end if %>
 <% if NewMembership = 4 then %>
  <tr><td class = 'body2' align = 'right'>Time Added to Membership:</td><td class = 'body' ><b>Premium membership</b></td></tr>
 <% else 
 if ChangeinValue > 0 then  %>
  <tr><td class = 'body2' align = 'right'>Time Added to Membership:</td><td class = 'body' ><b>1 Year <% if ToPerform = "C" then %>from today <% end if %></b></td></tr>
<% end if %>
   <% end if %>

    <tr>
    <td class = "body2" colspan = "2" align = "center" valign = "top"><br />
		<big><b>Your Change Has Been Made.</b></big>
	
 	<div align = 'left'><a href = "MembersRenewSubscription.asp?PeopleID=<%=PeopleID%>" class = "body2">Click here to go back.</a></div><br><br>
		</td>
	</tr>
</table>



<% end if %>
<% end if %>

<%

 if not ToPerform = "D"  then %>
 <form  name=form method="post" action="MembersAccountPaymentAddYear.asp?Oldmembership=<%=Oldmembership %>&Newmembership=<%=Newmembership%>">
<table border = "0" width = "600" align = "center"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=5 >
	<tr>
		<td class = "body2" colspan = "2" align = "left">
        <% if ToPerform = "C" then %>
        <h1>Change your Membership</h1>
        <% end if %>
         <% if ToPerform = "U" then %>
        <h1>Upgrade your Membership</h1>
        <% end if %>
         <% if ToPerform = "R" then %>
         <h1>Renew your Membership</h1>
         <% end if %>
        </td>
        </tr>
       <% 
      ' response.write("Changeinvalue=" & Changeinvalue )
       
       if ToPerform  = "R" then 
       
       

       %>
        <tr><td class = 'body2' align = 'right' width = '290'>Membership Level:</td><td class = 'body' ><b><%=Newmembershipname %><b></td></tr>
       <% else %>
        <tr><td class = 'body2' align = 'right' width = '290'>Old Membership Level:</td><td class = 'body' ><b><%=Oldmembershipname %></b></td></tr>
        <tr><td class = 'body2' align = 'right'>New Membership Level:</td><td class = 'body' ><b><%=Newmembershipname %><b></td></tr>
     <% end if %>




<% if Oldmembershipname = Newmembershipname then %>
   <tr><td class = 'body2' align = 'right'>
 Number of Years: 
</td><td class = 'body' >
<select size="1" name="years" width="60" style="width: 60px" onchange="this.form.submit()" class = "formbox">
<% If Len(years) > 0 then%>
<option value="<%=years%>" selected><%=years%></option>
<% End If %>
<option value="1">1</option>
<option  value="2">2</option>
<option  value="3">3</option>
<option  value="4">4</option>
<option  value="5">5</option>
<option  value="6">6</option>
<option  value="7">7</option>
</select>
</td></tr>
<% end if %>
<% if Oldmembershipvalue = 0 then
if len(years) > 0 then
else
years = 1
end if 
TotalPrice= Newmembershipvalue * years 

%>
<tr><td class = 'body2' align = 'right'>Time:</td><td class = 'body' ><b><%=years%> Years<b></td></tr>
 <tr><td class = 'body2' align = 'right'>Price:</td><td class = 'body' ><b><%=formatcurrency(Newmembershipvalue,2)%> / Year<b></td></tr>
 <tr><td class = 'body2' align = 'right'>Total Price:</td><td class = 'body' ><b><%=formatcurrency(TotalPrice ,2) %></b></td></tr>
<% else 
if ChangeinValue > 0 then
if len(years) > 0 then
else
years = 1
end if 

TotalPrice= Changeinvalue * Years 
  %>
  <tr><td class = 'body2' align = 'right'>Price:</td><td class = 'body' ><b><%=formatcurrency(Changeinvalue ,2) %> / Year</b></td></tr>
   <tr><td class = 'body2' align = 'right'>Total Price:</td><td class = 'body' >
   <b><%=formatcurrency(TotalPrice ,2) %> / Year</b></td></tr>
<% end if %>
   <% end if %>
 <% if NewMembership = 4 then %>

 <% else 
 if ChangeinValue > 0 then  %>
  <tr><td class = 'body2' align = 'right'>Time Added to Membership:</td><td class = 'body' ><b><%=years%> Year<% if years > 1 then %>(s)<% end if %> <% if ToPerform = "C" then %> from today <% end if %></b></td></tr>
<% end if %>
   <% end if %>
   </form>
    <tr>
    <td class = "body2" colspan = "2" align = "center" valign = "top">
		
		
<% if not (ToPerform="D") then

if years > 0 then
else
Years = 0
end if


 %>
<form action="MembersAccountPaymentAddYearstep2.asp" method="post" target = "_blank">
<input type = hidden name="website" value="<%=website %>" />
<input type = hidden name="Oldmembership" value=<%=oldmembership %> />
<input type = hidden name="Newmembership" value=<%=Newmembership %> />
<input type = hidden name="TotalPrice" value=<%=formatnumber(TotalPrice, 2) %> />
<input type = hidden name="ToPerform" value=<%=ToPerform %> />
<input type = hidden name="PeopleID" value="<%=session("peopleID") %>" />
<input type = hidden name="years" value=<%=years %> />

<input type="image" src="/Members/images/paynow.jpg" border="0" name="submit" >
</form>

<% end if %>



 	<div align = 'left'><a href = "MembersRenewSubscription.asp?PeopleID=<%=PeopleID%>" class = "body2">Click here to go back.</a></div><br><br>
		</td>
	</tr>
</table>
<% end if %>
<% end if %>		
  </td></tr></table>
  
<!--#Include File="MembersFooter.asp"-->
</Body>
</HTML>

