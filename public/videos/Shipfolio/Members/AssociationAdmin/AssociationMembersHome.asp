<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>

<!--#Include virtual="/includefiles/GlobalVariables.asp"-->

</HEAD>
<% if mobiledevice = True or is_iPad = true then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<% end if %>
<% 
Current3 = "Summary" %> 
<!--#Include virtual="/AssociationAdmin/AssociationHeader.asp"-->
<!--#Include virtual="/AssociationAdmin/AssociationMembersAccountJumpLinks.asp"-->
<h1>Association Members</h1>
Below are the ranches misted as members of your association:<br />

<table cellpadding = 5 cellspacing = 5 border = 0 width = "100%">
<% 
Query =  "Select * from Associationmembers, people, business, address where Associationmembers.peopleId = people.peopleID and people.addressid = address.addressid and people.businessid  = business.businessid and AssociationID = " & associationid & " Order by PeopleLastname" 
'response.write("Query=" & Query )
rs.Open Query, conn, 3, 3
while not rs.eof 

PeopleLastName = rs("PeopleLastname")
PeopleFirstName = rs("PeopleFirstname") 
businessName =rs("businessname")
AddressStreet1=rs("Addressstreet") 
AddressStreet2=rs("AddressApt") 
AddressCity=rs("AddressCity") 
AddressState=rs("AddressState")
AddressCountry=rs("AddressCountry") 
AddressZip=rs("AddressZip") 
 %>
<tr><td class = body>
<%=PeopleLastname %>, <%=PeopleFirstname %><br />
<% if len(BusinessName) > 2 then %>
<%=businessname %><br />
<% end if %>
<% if len(Addressstreet1) > 2 then %>
<%=Addressstreet1 %><br />
<% end if %>
<% if len(Addressstreet2) > 2 then %>
<%=Addressstreet2 %><br />
<% end if %>
<%=AddressCity %>&nbsp; 
<%=AddressState %>&nbsp; 
<%=AddressCountry %>&nbsp; 
<%=AddressZip %><br />
<br />

</td></tr>
<%
rs.movenext
wend
%>

</table>

<!--#Include virtual="/AssociationAdmin/AssociationFooter.asp"-->

</body>
</html>
