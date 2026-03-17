<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<!--#Include file="membersGlobalVariables.asp"-->


</HEAD>
<body >
  <% BusinessID = Request.querystring("BusinessID")
	sql2 = "SELECT Business.*, businesstypelookup.* FROM Business INNER JOIN businesstypelookup ON Business.businesstypeID = businesstypelookup.businesstypeID WHERE BusinessID = " & BusinessID 
	Set rs2 = Server.CreateObject("ADODB.Recordset")

'response.write("sql2=" & sql2)

    rs2.Open sql2, conn, 3, 3 

if Not rs2.eof then
    BusinessName = rs2("BusinessName")
		BusinessType = rs2("BusinessType")
	end if		
	
		rs2.close
		set rs2=nothing

pagename = BusinessName 
MasterDashboard= True 
BladeSection = "accounts" 
pagename = "favassociation"
pagename = BusinessName

%> 
<!--#Include file="MembersHeader.asp"-->	<br />
<div class ="container roundedtopandbottom">
  <H1>Associations</H1>
  <p><%= BusinessName %></p>
  <p><%= BusinessType %> Account</p>


<% If not rs.State = adStateClosed Then
rs.close
End If
 

sql = "select AssociationName, FavoriteAssocitaionID from Business, associations where Business.FavoriteAssocitaionID = associations.AssociationID and Business.BusinessID = " & BusinessId 
'response.write("sql=" & sql)
rs.Open sql, conn, 3, 3   
If Not rs.eof Then
 FavoriteAssocitaionID = rs("FavoriteAssocitaionID")
 AssociationName = rs("AssociationName")
end if
rs.close



dim AssociationIDarray(2000)
Set rs = Server.CreateObject("ADODB.Recordset")

sql = "select distinct AssociationID from associationmembers where BusinessID = " & BusinessID
'response.write("sql=" & sql )

rs.Open sql, conn, 3, 3 
x = 1  
while Not rs.eof 
AssociationIDarray(x) = rs("AssociationID")
x = x + 1
rs.movenext
wend
rs.close
totalmassociations = x -1
%>


<% 
Dim AssocitionIDArray(1000) 
Dim AssociationNameArray(10000)


sql = "select AssociationName, AssociationID  from  associations order by AssociationName "
rs.Open sql, conn, 3, 3 
    x = 0
    while not rs.eof 
    x = x +1
     AssocitionIDArray(x) = rs("AssociationID")
     AssociationNameArray(x) = rs("AssociationName")
    rs.movenext
    wend
rs.close 
    totalcount = X%>
<div class ="row">
     <div class ="col body">

<% changesmade=request.querystring("changesmade") 
    
 if changesmade = "true" then %>
<big><b><font color='maroon'>Your Changes Are Made.</font></b></big>
<% else %>
<br>
   <h2>Favorite Association</h2>
    Show your support for your favorite association by selecting it here. We'll donate <b>10% of your membership fee</b> to your chosen organization. Please note that this offer is not valid for free memberships or in conjunction with other discounts or offers.<br />
<% end if %>         
<br>




  <form action="AssociationSetFavorite.asp" method="post">
    <input type="hidden" name="BusinessID" value="<%= BusinessID %>">
    <label for="associations"><B>Favorite Association:</B>
        <% if len(AssociationName) > 1 then %>
            <%=AssociationName%>
        <% else %>
            Not Selected
        <% end if %>
       <br />
    <select id="associations" name="FavoriteAssocitaionID" class ="formbox">
        <% if len(AssociationName) > 1 then %>
         <option value="<%=FavoriteAssocitaionID%>"><%=AssociationName%></option>
         <% else %>
         <option value="">Not Set</option>
        <% end if %>
     <% x = 0
    while X < totalcount
     X = X + 1 %>
     <option value="<%=AssocitionIDArray(x)%>"><%=AssociationNameArray(x)%></option>

    <% wend %>
         <option value="0">N/A</option>
       </select>
         <input type="submit" class ="regsubmit2" value="Select">
    </form> 

<% if Subscriptionlevel < 2 then %>
<h2>Upgrade Your Subscription</h2>
Elevate your experience and support your favorite association by upgrading to a paid membership today. Enjoy enhanced services and contribute to the success of your chosen organization.


<a href ="MembersRenewSubscription.asp" class ="body"><b>Click here</b></a> to upgrade to a paid account.
    <% end if %>
         
         <br /><br />
<h2>Association Memberships</h2>
Select below the associations that you belong to:

   </div>
 </div>

<% 
' ASSOCIATION STUFF






sql = "select COUNT(*) as count from associationmembers where BusinessID = " & BusinessID 
'response.write("sql=" & sql)
rs.Open sql, conn, 3, 3   
If Not rs.eof Then
 associationcount = rs("count")
end if
rs.close


FavoriteAssocitaionID = 0
sql = "select FavoriteAssocitaionID, associationname from Business, associations where Business.FavoriteAssocitaionID= associations.associationid and Business.BusinessID = " & BusinessID 
'response.write("sql=" & sql)
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
If Not rs.eof Then
 FavoriteAssocitaionID = rs("FavoriteAssocitaionID")
  FavoriteAssocitaionName = rs("associationname")
end if
rs.close

'response.write("FavoriteAssocitaionID=" & FavoriteAssocitaionID )

 %>




<form name=form method="post" action="MemberAssociationsEditForm.asp?BusinessID=<%=BusinessID %>">
<table width = 100% >


<% '**************************************************************************************************
   ' ASSOCIATIONS 
   '**************************************************************************************************%>
 
<tr><td class = body colspan = 6 ><br /><h3><img src ="/icons/alpacaicongrey.png" width = 25 />Associations & Clubs</h3></td></tr>
<tr><td bgcolor = black height = 1 colspan = 6></td></tr>




<%
Query =  "Select distinct Associations.* from Associations where speciesID = 2 ORDER BY AssociationName" 
rs.Open Query, conn, 3, 3
colnum = 1
while not rs.eof %>


<% if cint(screenwidth) > 1000 then 
 if colnum = 1 then %>
<tr>
<% end if %>
<% end if %>

<% if screenwidth > 640 and screenwidth < 1001 then 
 if colnum = 1 then %>
<tr>
<% end if %>
<% end if %>


<% if screenwidth < 641 then %>
<tr>
<%end if %>


<td class = body width = 10>
<% 
CurrentassociationID = rs("AssociationID") 
Found = False
for i = 1 to totalmassociations 
if CurrentassociationID = AssociationIDarray(i) then
Found = True
end if
Next %>

<% if Found =True then %>
<input id="Checkbox2" type="checkbox" name = "associations" value = "<%=rs("AssociationID") %>" checked>
<% else %>
<input id="Checkbox16" type="checkbox" name = "associations" value = "<%=rs("AssociationID") %>">
<% end if %>
</td>
<td class = "body"><%=rs("AssociationName") %> </td>

<% if cint(screenwidth) > 1000 then
 if colnum = 1 or colnum = 2 then 
  colnum = colnum + 1 %>
<% else
colnum = 1 %>
</tr>
<% end if %>
<% end if %>

<% if screenwidth > 640 and screenwidth < 1001 then
 if colnum = 1 then 
  colnum = 2%>
<% else
colnum = 1 %>
</tr>
<% end if %>
<% end if %>

<% if screenwidth < 641 then %>
</tr>
<%end if %>

<% rs.movenext 
wend
rs.close
%>


<% '**************************************************************************************************
   ' BISON ASSOCIATIONS 
   '**************************************************************************************************%>
 
<% if screenwidth > 1000 then %>
<tr><td class = body colspan = 6 ><br /><h3><img src ="/icons/buffaloicongrey.png" width = 25 />Bison Associations & Clubs</h3></td></tr>
<tr><td bgcolor = black height = 1 colspan = 6></td></tr>
<% end if%>
<% if screenwidth > 640 and screenwidth < 1001 then %>
<tr><td class = body colspan = 4 ><br /><h3><img src ="/icons/buffaloicongrey.png" width = 25 />Bison Associations & Clubs</h3></td></tr>
<tr><td bgcolor = black height = 1 colspan = 4></td></tr>
<% end if %>
<% if screenwidth < 641 then %>
<tr><td class = body colspan = 2 ><br /><h3><img src ="/icons/buffaloicongrey.png" width = 25 />Bison Associations & Clubs</h3></td></tr>
<tr><td bgcolor = black height = 1 colspan = 2></td></tr>
<% end if %>



<%
 Query =  "Select distinct Associations.* from Associations where speciesID = 9 ORDER BY AssociationName" 
rs.Open Query, conn, 3, 3
colnum = 1
while not rs.eof %>


<% if cint(screenwidth) > 1000 then 
 if colnum = 1 then %>
<tr>
<% end if %>
<% end if %>

<% if screenwidth > 640 and screenwidth < 1001 then 
 if colnum = 1 then %>
<tr>
<% end if %>
<% end if %>


<% if screenwidth < 641 then %>
<tr>
<%end if %>

<td class = body width = 10>
<% 
CurrentassociationID = rs("AssociationID") 
Found = False
for i = 1 to totalmassociations 
if CurrentassociationID = AssociationIDarray(i) then
Found = True
end if
Next %>

<% if Found =True then %>
<input id="Checkbox1" type="checkbox" name = "associations" value = "<%=rs("AssociationID") %>" checked>
<% else %>
<input id="Checkbox17" type="checkbox" name = "associations" value = "<%=rs("AssociationID") %>">
<% end if %>
</td>
<td class = "body"><%=rs("AssociationName") %> </td>

<% if cint(screenwidth) > 1000 then
 if colnum = 1 or colnum = 2 then 
  colnum = colnum + 1 %>
<% else
colnum = 1 %>
</tr>
<% end if %>
<% end if %>

<% if screenwidth > 640 and screenwidth < 1001 then
 if colnum = 1 then 
  colnum = 2%>
<% else
colnum = 1 %>
</tr>
<% end if %>
<% end if %>

<% if screenwidth < 641 then %>
</tr>
<%end if %>

<% rs.movenext 
wend
rs.close
%>



<% '**************************************************************************************************
   ' CATTLE ASSOCIATIONS 
   '**************************************************************************************************%>
 
<% if screenwidth > 1000 then %>
<tr><td class = body colspan = 6 ><br /><h3><img src ="/icons/cattleicongrey.png" width = 25 />Cattle Associations & Clubs</h3></td></tr>
<tr><td bgcolor = black height = 1 colspan = 6></td></tr>
<% end if%>
<% if screenwidth > 640 and screenwidth < 1001 then %>
<tr><td class = body colspan = 4 ><br /><h3><img src ="/icons/cattleicongrey.png" width = 25 />Cattle Associations & Clubs</h3></td></tr>
<tr><td bgcolor = black height = 1 colspan = 4></td></tr>
<% end if %>
<% if screenwidth < 641 then %>
<tr><td class = body colspan = 2 ><br /><h3><img src ="/icons/cattleicongrey.png" width = 25 />Cattle Associations & Clubs</h3></td></tr>
<tr><td bgcolor = black height = 1 colspan = 2></td></tr>
<% end if %>



<%
 Query =  "Select distinct Associations.* from Associations where speciesID = 8 ORDER BY AssociationName" 
rs.Open Query, conn, 3, 3
colnum = 1
while not rs.eof %>


<% if cint(screenwidth) > 1000 then 
 if colnum = 1 then %>
<tr>
<% end if %>
<% end if %>

<% if screenwidth > 640 and screenwidth < 1001 then 
 if colnum = 1 then %>
<tr>
<% end if %>
<% end if %>


<% if screenwidth < 641 then %>
<tr>
<%end if %>

<td class = body width = 10>
<% 
CurrentassociationID = rs("AssociationID") 
Found = False
for i = 1 to totalmassociations 
if CurrentassociationID = AssociationIDarray(i) then
Found = True
end if
Next %>

<% if Found =True then %>
<input id="Checkbox3" type="checkbox" name = "associations" value = "<%=rs("AssociationID") %>" checked>
<% else %>
<input id="Checkbox18" type="checkbox" name = "associations" value = "<%=rs("AssociationID") %>">
<% end if %>
</td>
<td class = "body"><%=rs("AssociationName") %> </td>

<% if cint(screenwidth) > 1000 then
 if colnum = 1 or colnum = 2 then 
  colnum = colnum + 1 %>
<% else
colnum = 1 %>
</tr>
<% end if %>
<% end if %>

<% if screenwidth > 640 and screenwidth < 1001 then
 if colnum = 1 then 
  colnum = 2%>
<% else
colnum = 1 %>
</tr>
<% end if %>
<% end if %>

<% if screenwidth < 641 then %>
</tr>
<%end if %>

<% rs.movenext 
wend
rs.close
%>



<% '**************************************************************************************************
   ' CHICKEN ASSOCIATIONS 
   '**************************************************************************************************%>
 
<% if screenwidth > 1000 then %>
<tr><td class = body colspan = 6 ><br /><h3><img src ="/icons/chickenicongrey.png" width = 25 />Chicken Associations & Clubs</h3></td></tr>
<tr><td bgcolor = black height = 1 colspan = 6></td></tr>
<% end if%>
<% if screenwidth > 640 and screenwidth < 1001 then %>
<tr><td class = body colspan = 4 ><br /><h3><img src ="/icons/chickenicongrey.png" width = 25 />Chicken Associations & Clubs</h3></td></tr>
<tr><td bgcolor = black height = 1 colspan = 4></td></tr>
<% end if %>
<% if screenwidth < 641 then %>
<tr><td class = body colspan = 2 ><br /><h3><img src ="/icons/chickenicongrey.png" width = 25 />Chicken Associations & Clubs</h3></td></tr>
<tr><td bgcolor = black height = 1 colspan = 2></td></tr>
<% end if %>



<%
 Query =  "Select distinct Associations.* from Associations where speciesID = 13 ORDER BY AssociationName" 
rs.Open Query, conn, 3, 3
colnum = 1
while not rs.eof %>


<% if cint(screenwidth) > 1000 then 
 if colnum = 1 then %>
<tr>
<% end if %>
<% end if %>

<% if screenwidth > 640 and screenwidth < 1001 then 
 if colnum = 1 then %>
<tr>
<% end if %>
<% end if %>


<% if screenwidth < 641 then %>
<tr>
<%end if %>


<td class = body width = 10>
<% 
CurrentassociationID = rs("AssociationID") 
Found = False
for i = 1 to totalmassociations 
if CurrentassociationID = AssociationIDarray(i) then
Found = True
end if
Next %>

<% if Found =True then %>
<input id="Checkbox4" type="checkbox" name = "associations" value = "<%=rs("AssociationID") %>" checked>
<% else %>
<input id="Checkbox19" type="checkbox" name = "associations" value = "<%=rs("AssociationID") %>">
<% end if %>
</td>
<td class = "body"><%=rs("AssociationName") %> </td>

<% if cint(screenwidth) > 1000 then
 if colnum = 1 or colnum = 2 then 
  colnum = colnum + 1 %>
<% else
colnum = 1 %>
</tr>
<% end if %>
<% end if %>

<% if screenwidth > 640 and screenwidth < 1001 then
 if colnum = 1 then 
  colnum = 2%>
<% else
colnum = 1 %>
</tr>
<% end if %>
<% end if %>

<% if screenwidth < 641 then %>
</tr>
<%end if %>

<% rs.movenext 
wend
rs.close
%>




<% '**************************************************************************************************
   ' DOG ASSOCIATIONS 
   '**************************************************************************************************%>
 
<% if screenwidth > 1000 then %>
<tr><td class = body colspan = 6 ><br /><h3><img src ="/icons/dogicongrey.png" width = 25 />Dog Associations & Clubs</h3></td></tr>
<tr><td bgcolor = black height = 1 colspan = 6></td></tr>
<% end if%>
<% if screenwidth > 640 and screenwidth < 1001 then %>
<tr><td class = body colspan = 4 ><br /><h3><img src ="/icons/dogicongrey.png" width = 25 />Dog Associations & Clubs</h3></td></tr>
<tr><td bgcolor = black height = 1 colspan = 4></td></tr>
<% end if %>
<% if screenwidth < 641 then %>
<tr><td class = body colspan = 2 ><br /><h3><img src ="/icons/dogicongrey.png" width = 25 />Dog Associations & Clubs</h3></td></tr>
<tr><td bgcolor = black height = 1 colspan = 2></td></tr>
<% end if %>



<%
 Query =  "Select distinct Associations.* from Associations where speciesID = 3 ORDER BY AssociationName" 
rs.Open Query, conn, 3, 3
colnum = 1
while not rs.eof %>


<% if cint(screenwidth) > 1000 then 
 if colnum = 1 then %>
<tr>
<% end if %>
<% end if %>

<% if screenwidth > 640 and screenwidth < 1001 then 
 if colnum = 1 then %>
<tr>
<% end if %>
<% end if %>


<% if screenwidth < 641 then %>
<tr>
<%end if %>


<td class = body width = 10>
<% 
CurrentassociationID = rs("AssociationID") 
Found = False
for i = 1 to totalmassociations 
if CurrentassociationID = AssociationIDarray(i) then
Found = True
end if
Next %>

<% if Found =True then %>
<input id="Checkbox5" type="checkbox" name = "associations" value = "<%=rs("AssociationID") %>" checked>
<% else %>
<input id="Checkbox20" type="checkbox" name = "associations" value = "<%=rs("AssociationID") %>">
<% end if %>
</td>
<td class = "body"><%=rs("AssociationName") %> </td>

<% if cint(screenwidth) > 1000 then
 if colnum = 1 or colnum = 2 then 
  colnum = colnum + 1 %>
<% else
colnum = 1 %>
</tr>
<% end if %>
<% end if %>

<% if screenwidth > 640 and screenwidth < 1001 then
 if colnum = 1 then 
  colnum = 2%>
<% else
colnum = 1 %>
</tr>
<% end if %>
<% end if %>

<% if screenwidth < 641 then %>
</tr>
<%end if %>

<% rs.movenext 
wend
rs.close
%>



<% '**************************************************************************************************
   ' DONKEY ASSOCIATIONS 
   '**************************************************************************************************%>
 
<% if screenwidth > 1000 then %>
<tr><td class = body colspan = 6 ><br /><h3><img src ="/icons/donkeyicongrey.png" width = 25 />Donkey Associations & Clubs</h3></td></tr>
<tr><td bgcolor = black height = 1 colspan = 6></td></tr>
<% end if%>
<% if screenwidth > 640 and screenwidth < 1001 then %>
<tr><td class = body colspan = 4 ><br /><h3><img src ="/icons/donkeyicongrey.png" width = 25 />Donkey Associations & Clubs</h3></td></tr>
<tr><td bgcolor = black height = 1 colspan = 4></td></tr>
<% end if %>
<% if screenwidth < 641 then %>
<tr><td class = body colspan = 2 ><br /><h3><img src ="/icons/donkeyicongrey.png" width = 25 />Donkey Associations & Clubs</h3></td></tr>
<tr><td bgcolor = black height = 1 colspan = 2></td></tr>
<% end if %>



<%
 Query =  "Select distinct Associations.* from Associations where speciesID = 7 ORDER BY AssociationName" 
rs.Open Query, conn, 3, 3
colnum = 1
while not rs.eof %>


<% if cint(screenwidth) > 1000 then 
 if colnum = 1 then %>
<tr>
<% end if %>
<% end if %>

<% if screenwidth > 640 and screenwidth < 1001 then 
 if colnum = 1 then %>
<tr>
<% end if %>
<% end if %>


<% if screenwidth < 641 then %>
<tr>
<%end if %>


<td class = body width = 10>
<% 
CurrentassociationID = rs("AssociationID") 
Found = False
for i = 1 to totalmassociations 
if CurrentassociationID = AssociationIDarray(i) then
Found = True
end if
Next %>

<% if Found =True then %>
<input id="Checkbox6" type="checkbox" name = "associations" value = "<%=rs("AssociationID") %>" checked>
<% else %>
<input id="Checkbox21" type="checkbox" name = "associations" value = "<%=rs("AssociationID") %>">
<% end if %>
</td>
<td class = "body"><%=rs("AssociationName") %> </td>

<% if cint(screenwidth) > 1000 then
 if colnum = 1 or colnum = 2 then 
  colnum = colnum + 1 %>
<% else
colnum = 1 %>
</tr>
<% end if %>
<% end if %>

<% if screenwidth > 640 and screenwidth < 1001 then
 if colnum = 1 then 
  colnum = 2%>
<% else
colnum = 1 %>
</tr>
<% end if %>
<% end if %>

<% if screenwidth < 641 then %>
</tr>
<%end if %>

<% rs.movenext 
wend
rs.close
%>



<% '**************************************************************************************************
   ' EMUS ASSOCIATIONS 
   '**************************************************************************************************%>
 
<% if screenwidth > 1000 then %>
<tr><td class = body colspan = 6 ><br /><h3><img src ="/icons/emuicongrey.jpg" width = 25 />Emu Associations & Clubs</h3></td></tr>
<tr><td bgcolor = black height = 1 colspan = 6></td></tr>
<% end if%>
<% if screenwidth > 640 and screenwidth < 1001 then %>
<tr><td class = body colspan = 4 ><br /><h3><img src ="/icons/emuicongrey.jpg" width = 25 />Emu Associations & Clubs</h3></td></tr>
<tr><td bgcolor = black height = 1 colspan = 4></td></tr>
<% end if %>
<% if screenwidth < 641 then %>
<tr><td class = body colspan = 2 ><br /><h3><img src ="/icons/emuicongrey.jpg" width = 25 />Emu Associations & Clubs</h3></td></tr>
<tr><td bgcolor = black height = 1 colspan = 2></td></tr>
<% end if %>



<%
 Query =  "Select distinct Associations.* from Associations where speciesID = 19 ORDER BY AssociationName" 
rs.Open Query, conn, 3, 3
colnum = 1
while not rs.eof %>


<% if cint(screenwidth) > 1000 then 
 if colnum = 1 then %>
<tr>
<% end if %>
<% end if %>

<% if screenwidth > 640 and screenwidth < 1001 then 
 if colnum = 1 then %>
<tr>
<% end if %>
<% end if %>


<% if screenwidth < 641 then %>
<tr>
<%end if %>


<td class = body width = 10>
<% 
CurrentassociationID = rs("AssociationID") 
Found = False
for i = 1 to totalmassociations 
if CurrentassociationID = AssociationIDarray(i) then
Found = True
end if
Next %>

<% if Found =True then %>
<input id="Checkbox7" type="checkbox" name = "associations" value = "<%=rs("AssociationID") %>" checked>
<% else %>
<input id="Checkbox22" type="checkbox" name = "associations" value = "<%=rs("AssociationID") %>">
<% end if %>
</td>
<td class = "body"><%=rs("AssociationName") %> </td>

<% if cint(screenwidth) > 1000 then
 if colnum = 1 or colnum = 2 then 
  colnum = colnum + 1 %>
<% else
colnum = 1 %>
</tr>
<% end if %>
<% end if %>

<% if screenwidth > 640 and screenwidth < 1001 then
 if colnum = 1 then 
  colnum = 2%>
<% else
colnum = 1 %>
</tr>
<% end if %>
<% end if %>

<% if screenwidth < 641 then %>
</tr>
<%end if %>

<% rs.movenext 
wend
rs.close
%>



<% '**************************************************************************************************
   ' GOAT ASSOCIATIONS 
   '**************************************************************************************************%>
 
<% if screenwidth > 1000 then %>
<tr><td class = body colspan = 6 ><br /><h3><img src ="/icons/goaticongrey.png" width = 25 />Goat Associations & Clubs</h3></td></tr>
<tr><td bgcolor = black height = 1 colspan = 6></td></tr>
<% end if%>
<% if screenwidth > 640 and screenwidth < 1001 then %>
<tr><td class = body colspan = 4 ><br /><h3><img src ="/icons/goaticongrey.png" width = 25 />Goat Associations & Clubs</h3></td></tr>
<tr><td bgcolor = black height = 1 colspan = 4></td></tr>
<% end if %>
<% if screenwidth < 641 then %>
<tr><td class = body colspan = 2 ><br /><h3><img src ="/icons/goaticongrey.png" width = 25 />Goat Associations & Clubs</h3></td></tr>
<tr><td bgcolor = black height = 1 colspan = 2></td></tr>
<% end if %>



<%
 Query =  "Select distinct Associations.* from Associations where speciesID = 6 ORDER BY AssociationName" 
rs.Open Query, conn, 3, 3
colnum = 1
while not rs.eof %>


<% if cint(screenwidth) > 1000 then 
 if colnum = 1 then %>
<tr>
<% end if %>
<% end if %>

<% if screenwidth > 640 and screenwidth < 1001 then 
 if colnum = 1 then %>
<tr>
<% end if %>
<% end if %>


<% if screenwidth < 641 then %>
<tr>
<%end if %>


<td class = body width = 10>
<% 
CurrentassociationID = rs("AssociationID") 
Found = False
for i = 1 to totalmassociations 
if CurrentassociationID = AssociationIDarray(i) then
Found = True
end if
Next %>

<% if Found =True then %>
<input id="Checkbox8" type="checkbox" name = "associations" value = "<%=rs("AssociationID") %>" checked>
<% else %>
<input id="Checkbox23" type="checkbox" name = "associations" value = "<%=rs("AssociationID") %>">
<% end if %>
</td>
<td class = "body"><%=rs("AssociationName") %> </td>

<% if cint(screenwidth) > 1000 then
 if colnum = 1 or colnum = 2 then 
  colnum = colnum + 1 %>
<% else
colnum = 1 %>
</tr>
<% end if %>
<% end if %>

<% if screenwidth > 640 and screenwidth < 1001 then
 if colnum = 1 then 
  colnum = 2%>
<% else
colnum = 1 %>
</tr>
<% end if %>
<% end if %>

<% if screenwidth < 641 then %>
</tr>
<%end if %>

<% rs.movenext 
wend
rs.close
%>





<% '**************************************************************************************************
   ' HORSE ASSOCIATIONS 
   '**************************************************************************************************%>
 
<% if screenwidth > 1000 then %>
<tr><td class = body colspan = 6 ><br /><h3><img src ="/icons/horseicongrey.png" width = 25 />Horse Associations & Clubs</h3></td></tr>
<tr><td bgcolor = black height = 1 colspan = 6></td></tr>
<% end if%>
<% if screenwidth > 640 and screenwidth < 1001 then %>
<tr><td class = body colspan = 4 ><br /><h3><img src ="/icons/horseicongrey.png" width = 25 />Horse Associations & Clubs</h3></td></tr>
<tr><td bgcolor = black height = 1 colspan = 4></td></tr>
<% end if %>
<% if screenwidth < 641 then %>
<tr><td class = body colspan = 2 ><br /><h3><img src ="/icons/horseicongrey.png" width = 25 />Horse Associations & Clubs</h3></td></tr>
<tr><td bgcolor = black height = 1 colspan = 2></td></tr>
<% end if %>



<%
 Query =  "Select distinct Associations.* from Associations where speciesID = 5 ORDER BY AssociationName" 
rs.Open Query, conn, 3, 3
colnum = 1
while not rs.eof %>


<% if cint(screenwidth) > 1000 then 
 if colnum = 1 then %>
<tr>
<% end if %>
<% end if %>

<% if screenwidth > 640 and screenwidth < 1001 then 
 if colnum = 1 then %>
<tr>
<% end if %>
<% end if %>


<% if screenwidth < 641 then %>
<tr>
<%end if %>

<td class = body width = 10>
<% 
CurrentassociationID = rs("AssociationID") 
Found = False
for i = 1 to totalmassociations 
if CurrentassociationID = AssociationIDarray(i) then
Found = True
end if
Next %>

<% if Found =True then %>
<input id="Checkbox9" type="checkbox" name = "associations" value = "<%=rs("AssociationID") %>" checked>
<% else %>
<input id="Checkbox24" type="checkbox" name = "associations" value = "<%=rs("AssociationID") %>">
<% end if %>
</td>
<td class = "body"><%=rs("AssociationName") %> </td>

<% if cint(screenwidth) > 1000 then
 if colnum = 1 or colnum = 2 then 
  colnum = colnum + 1 %>
<% else
colnum = 1 %>
</tr>
<% end if %>
<% end if %>

<% if screenwidth > 640 and screenwidth < 1001 then
 if colnum = 1 then 
  colnum = 2%>
<% else
colnum = 1 %>
</tr>
<% end if %>
<% end if %>

<% if screenwidth < 641 then %>
</tr>
<%end if %>

<% rs.movenext 
wend
rs.close
%>


<% '**************************************************************************************************
   ' LLAMA ASSOCIATIONS 
   '**************************************************************************************************%>
 
<% if screenwidth > 1000 then %>
<tr><td class = body colspan = 6 ><br /><h3><img src ="/icons/llamaicongrey.png" width = 25 />Llama Associations & Clubs</h3></td></tr>
<tr><td bgcolor = black height = 1 colspan = 6></td></tr>
<% end if%>
<% if screenwidth > 640 and screenwidth < 1001 then %>
<tr><td class = body colspan = 4 ><br /><h3><img src ="/icons/llamaicongrey.png" width = 25 />Llama Associations & Clubs</h3></td></tr>
<tr><td bgcolor = black height = 1 colspan = 4></td></tr>
<% end if %>
<% if screenwidth < 641 then %>
<tr><td class = body colspan = 2 ><br /><h3><img src ="/icons/llamaicongrey.png" width = 25 />Llama Associations & Clubs</h3></td></tr>
<tr><td bgcolor = black height = 1 colspan = 2></td></tr>
<% end if %>



<%
 Query =  "Select distinct Associations.* from Associations where speciesID = 4 ORDER BY AssociationName" 
rs.Open Query, conn, 3, 3
colnum = 1
while not rs.eof %>


<% if cint(screenwidth) > 1000 then 
 if colnum = 1 then %>
<tr>
<% end if %>
<% end if %>

<% if screenwidth > 640 and screenwidth < 1001 then 
 if colnum = 1 then %>
<tr>
<% end if %>
<% end if %>


<% if screenwidth < 641 then %>
<tr>
<%end if %>


<td class = body width = 10>
<% 
CurrentassociationID = rs("AssociationID") 
Found = False
for i = 1 to totalmassociations 
if CurrentassociationID = AssociationIDarray(i) then
Found = True
end if
Next %>

<% if Found =True then %>
<input id="Checkbox10" type="checkbox" name = "associations" value = "<%=rs("AssociationID") %>" checked>
<% else %>
<input id="Checkbox25" type="checkbox" name = "associations" value = "<%=rs("AssociationID") %>">
<% end if %>
</td>
<td class = "body"><%=rs("AssociationName") %> </td>

<% if cint(screenwidth) > 1000 then
 if colnum = 1 or colnum = 2 then 
  colnum = colnum + 1 %>
<% else
colnum = 1 %>
</tr>
<% end if %>
<% end if %>

<% if screenwidth > 640 and screenwidth < 1001 then
 if colnum = 1 then 
  colnum = 2%>
<% else
colnum = 1 %>
</tr>
<% end if %>
<% end if %>

<% if screenwidth < 641 then %>
</tr>
<%end if %>

<% rs.movenext 
wend
rs.close
%>




<% '**************************************************************************************************
   ' PIG ASSOCIATIONS 
   '**************************************************************************************************%>
 
<% if screenwidth > 1000 then %>
<tr><td class = body colspan = 6 ><br /><h3><img src ="/icons/PigsIconGrey.png" width = 25 />Pig Associations & Clubs</h3></td></tr>
<tr><td bgcolor = black height = 1 colspan = 6></td></tr>
<% end if%>
<% if screenwidth > 640 and screenwidth < 1001 then %>
<tr><td class = body colspan = 4 ><br /><h3><img src ="/icons/PigsIconGrey.png" width = 25 />Pig Associations & Clubs</h3></td></tr>
<tr><td bgcolor = black height = 1 colspan = 4></td></tr>
<% end if %>
<% if screenwidth < 641 then %>
<tr><td class = body colspan = 2 ><br /><h3><img src ="/icons/PigsIconGrey.png" width = 25 />Pig Associations & Clubs</h3></td></tr>
<tr><td bgcolor = black height = 1 colspan = 2></td></tr>
<% end if %>



<%
 Query =  "Select distinct Associations.* from Associations where speciesID = 12 ORDER BY AssociationName" 
rs.Open Query, conn, 3, 3
colnum = 1
while not rs.eof %>


<% if cint(screenwidth) > 1000 then 
 if colnum = 1 then %>
<tr>
<% end if %>
<% end if %>

<% if screenwidth > 640 and screenwidth < 1001 then 
 if colnum = 1 then %>
<tr>
<% end if %>
<% end if %>


<% if screenwidth < 641 then %>
<tr>
<%end if %>


<td class = body width = 10>
<% 
CurrentassociationID = rs("AssociationID") 
Found = False
for i = 1 to totalmassociations 
if CurrentassociationID = AssociationIDarray(i) then
Found = True
end if
Next %>

<% if Found =True then %>
<input id="Checkbox11" type="checkbox" name = "associations" value = "<%=rs("AssociationID") %>" checked>
<% else %>
<input id="Checkbox26" type="checkbox" name = "associations" value = "<%=rs("AssociationID") %>">
<% end if %>
</td>
<td class = "body"><%=rs("AssociationName") %> </td>

<% if cint(screenwidth) > 1000 then
 if colnum = 1 or colnum = 2 then 
  colnum = colnum + 1 %>
<% else
colnum = 1 %>
</tr>
<% end if %>
<% end if %>

<% if screenwidth > 640 and screenwidth < 1001 then
 if colnum = 1 then 
  colnum = 2%>
<% else
colnum = 1 %>
</tr>
<% end if %>
<% end if %>

<% if screenwidth < 641 then %>
</tr>
<%end if %>

<% rs.movenext 
wend
rs.close
%>



<% '**************************************************************************************************
   ' Rabbit ASSOCIATIONS 
   '**************************************************************************************************%>
 
<% if screenwidth > 1000 then %>
<tr><td class = body colspan = 6 ><br /><h3><img src ="/icons/rabbiticongrey.png" width = 25 />Rabbit Associations & Clubs</h3></td></tr>
<tr><td bgcolor = black height = 1 colspan = 6></td></tr>
<% end if%>
<% if screenwidth > 640 and screenwidth < 1001 then %>
<tr><td class = body colspan = 4 ><br /><h3><img src ="/icons/rabbiticongrey.png" width = 25 />Rabbit Associations & Clubs</h3></td></tr>
<tr><td bgcolor = black height = 1 colspan = 4></td></tr>
<% end if %>
<% if screenwidth < 641 then %>
<tr><td class = body colspan = 2 ><br /><h3><img src ="/icons/rabbiticongrey.png" width = 25 />Rabbit Associations & Clubs</h3></td></tr>
<tr><td bgcolor = black height = 1 colspan = 2></td></tr>
<% end if %>



<%
 Query =  "Select distinct Associations.* from Associations where speciesID = 11 ORDER BY AssociationName" 
rs.Open Query, conn, 3, 3
colnum = 1
while not rs.eof %>


<% if cint(screenwidth) > 1000 then 
 if colnum = 1 then %>
<tr>
<% end if %>
<% end if %>

<% if screenwidth > 640 and screenwidth < 1001 then 
 if colnum = 1 then %>
<tr>
<% end if %>
<% end if %>


<% if screenwidth < 641 then %>
<tr>
<%end if %>


<td class = body width = 10>
<% 
CurrentassociationID = rs("AssociationID") 
Found = False
for i = 1 to totalmassociations 
if CurrentassociationID = AssociationIDarray(i) then
Found = True
end if
Next %>

<% if Found =True then %>
<input id="Checkbox12" type="checkbox" name = "associations" value = "<%=rs("AssociationID") %>" checked>
<% else %>
<input id="Checkbox27" type="checkbox" name = "associations" value = "<%=rs("AssociationID") %>">
<% end if %>
</td>
<td class = "body"><%=rs("AssociationName") %> </td>

<% if cint(screenwidth) > 1000 then
 if colnum = 1 or colnum = 2 then 
  colnum = colnum + 1 %>
<% else
colnum = 1 %>
</tr>
<% end if %>
<% end if %>

<% if screenwidth > 640 and screenwidth < 1001 then
 if colnum = 1 then 
  colnum = 2%>
<% else
colnum = 1 %>
</tr>
<% end if %>
<% end if %>

<% if screenwidth < 641 then %>
</tr>
<%end if %>

<% rs.movenext 
wend
rs.close
%>






<% '**************************************************************************************************
   ' SHEEP ASSOCIATIONS 
   '**************************************************************************************************%>
 
<% if screenwidth > 1000 then %>
<tr><td class = body colspan = 6 ><br /><h3><img src ="/icons/sheepicongrey.png" width = 25 />Sheep Associations & Clubs</h3></td></tr>
<tr><td bgcolor = black height = 1 colspan = 6></td></tr>
<% end if%>
<% if screenwidth > 640 and screenwidth < 1001 then %>
<tr><td class = body colspan = 4 ><br /><h3><img src ="/icons/sheepicongrey.png" width = 25 />Sheep Associations & Clubs</h3></td></tr>
<tr><td bgcolor = black height = 1 colspan = 4></td></tr>
<% end if %>
<% if screenwidth < 641 then %>
<tr><td class = body colspan = 2 ><br /><h3><img src ="/icons/sheepicongrey.png" width = 25 />Sheep Associations & Clubs</h3></td></tr>
<tr><td bgcolor = black height = 1 colspan = 2></td></tr>
<% end if %>



<%
 Query =  "Select distinct Associations.* from Associations where speciesID = 10 ORDER BY AssociationName" 
rs.Open Query, conn, 3, 3
colnum = 1
while not rs.eof %>


<% if cint(screenwidth) > 1000 then 
 if colnum = 1 then %>
<tr>
<% end if %>
<% end if %>

<% if screenwidth > 640 and screenwidth < 1001 then 
 if colnum = 1 then %>
<tr>
<% end if %>
<% end if %>


<% if screenwidth < 641 then %>
<tr>
<%end if %>


<td class = body width = 10>
<% 
CurrentassociationID = rs("AssociationID") 
Found = False
for i = 1 to totalmassociations 
if CurrentassociationID = AssociationIDarray(i) then
Found = True
end if
Next %>

<% if Found =True then %>
<input id="Checkbox13" type="checkbox" name = "associations" value = "<%=rs("AssociationID") %>" checked>
<% else %>
<input id="Checkbox28" type="checkbox" name = "associations" value = "<%=rs("AssociationID") %>">
<% end if %>
</td>
<td class = "body"><%=rs("AssociationName") %> </td>

<% if cint(screenwidth) > 1000 then
 if colnum = 1 or colnum = 2 then 
  colnum = colnum + 1 %>
<% else
colnum = 1 %>
</tr>
<% end if %>
<% end if %>

<% if screenwidth > 640 and screenwidth < 1001 then
 if colnum = 1 then 
  colnum = 2%>
<% else
colnum = 1 %>
</tr>
<% end if %>
<% end if %>

<% if screenwidth < 641 then %>
</tr>
<%end if %>

<% rs.movenext 
wend
rs.close
%>




<% '**************************************************************************************************
   ' Turkey ASSOCIATIONS 
   '**************************************************************************************************%>
 
<% if screenwidth > 1000 then %>
<tr><td class = body colspan = 6 ><br /><h3><img src ="/icons/turkeyicongrey.png" width = 25 />Turkey Associations & Clubs</h3></td></tr>
<tr><td bgcolor = black height = 1 colspan = 6></td></tr>
<% end if%>
<% if screenwidth > 640 and screenwidth < 1001 then %>
<tr><td class = body colspan = 4 ><br /><h3><img src ="/icons/turkeyicongrey.png" width = 25 />Turkey Associations & Clubs</h3></td></tr>
<tr><td bgcolor = black height = 1 colspan = 4></td></tr>
<% end if %>
<% if screenwidth < 641 then %>
<tr><td class = body colspan = 2 ><br /><h3><img src ="/icons/turkeyicongrey.png" width = 25 />Turkey Associations & Clubs</h3></td></tr>
<tr><td bgcolor = black height = 1 colspan = 2></td></tr>
<% end if %>



<%
 Query =  "Select distinct Associations.* from Associations where speciesID = 14 ORDER BY AssociationName" 
rs.Open Query, conn, 3, 3
colnum = 1
while not rs.eof %>


<% if cint(screenwidth) > 1000 then 
 if colnum = 1 then %>
<tr>
<% end if %>
<% end if %>

<% if screenwidth > 640 and screenwidth < 1001 then 
 if colnum = 1 then %>
<tr>
<% end if %>
<% end if %>


<% if screenwidth < 641 then %>
<tr>
<%end if %>


<td class = body width = 10>
<% 
CurrentassociationID = rs("AssociationID") 
Found = False
for i = 1 to totalmassociations 
if CurrentassociationID = AssociationIDarray(i) then
Found = True
end if
Next %>

<% if Found =True then %>
<input id="Checkbox14" type="checkbox" name = "associations" value = "<%=rs("AssociationID") %>" checked>
<% else %>
<input id="Checkbox29" type="checkbox" name = "associations" value = "<%=rs("AssociationID") %>">
<% end if %>
</td>
<td class = "body"><%=rs("AssociationName") %> </td>

<% if cint(screenwidth) > 1000 then
 if colnum = 1 or colnum = 2 then 
  colnum = colnum + 1 %>
<% else
colnum = 1 %>
</tr>
<% end if %>
<% end if %>

<% if screenwidth > 640 and screenwidth < 1001 then
 if colnum = 1 then 
  colnum = 2%>
<% else
colnum = 1 %>
</tr>
<% end if %>
<% end if %>

<% if screenwidth < 641 then %>
</tr>
<%end if %>

<% rs.movenext 
wend
rs.close
%>





<% '**************************************************************************************************
   ' YAK ASSOCIATIONS 
   '**************************************************************************************************%>
 
<% if screenwidth > 1000 then %>
<tr><td class = body colspan = 6 ><br /><h3><img src ="/icons/yakicongrey.png" width = 25 />Yak Associations & Clubs</h3></td></tr>
<tr><td bgcolor = black height = 1 colspan = 6></td></tr>
<% end if%>
<% if screenwidth > 640 and screenwidth < 1001 then %>
<tr><td class = body colspan = 4 ><br /><h3><img src ="/icons/yakicongrey.png" width = 25 />Yak Associations & Clubs</h3></td></tr>
<tr><td bgcolor = black height = 1 colspan = 4></td></tr>
<% end if %>
<% if screenwidth < 641 then %>
<tr><td class = body colspan = 2 ><br /><h3><img src ="/icons/yakicongrey.png" width = 25 />Yak Associations & Clubs</h3></td></tr>
<tr><td bgcolor = black height = 1 colspan = 2></td></tr>
<% end if %>



<%
 Query =  "Select distinct Associations.* from Associations where speciesID = 14 ORDER BY AssociationName" 
rs.Open Query, conn, 3, 3
colnum = 1
while not rs.eof %>


<td class = body width = 10>
<% 
CurrentassociationID = rs("AssociationID") 
Found = False
for i = 1 to totalmassociations 
if CurrentassociationID = AssociationIDarray(i) then
Found = True
end if
Next %>

<% if Found =True then %>
<input id="Checkbox15" type="checkbox" name = "associations" value = "<%=rs("AssociationID") %>" checked>
<% else %>
<input id="Checkbox30" type="checkbox" name = "associations" value = "<%=rs("AssociationID") %>">
<% end if %>
</td>
<td class = "body"><%=rs("AssociationName") %> </td>

<% if cint(screenwidth) > 1000 then
 if colnum = 1 or colnum = 2 then 
  colnum = colnum + 1 %>
<% else
colnum = 1 %>
</tr>
<% end if %>
<% end if %>

<% if screenwidth > 640 and screenwidth < 1001 then
 if colnum = 1 then 
  colnum = 2%>
<% else
colnum = 1 %>
</tr>
<% end if %>
<% end if %>

<% if screenwidth < 641 then %>
</tr>
<%end if %>

<% rs.movenext 
wend
rs.close
%>




  </td></tr>
<% 

Conn.close
set Conn = nothing
%>
<tr>

<td class = body colspan = 2>



	<div align = right><input type=submit value="Submit"  class = "regsubmit2"></div>
    </form>

<br /><br />If your favorite association is not listed on our website please email us a <a href="Hello@Oatmeal-Ai.com" target = "_blank" class = "body">Hello@Oatmeal-Ai.com</a> and let us know.<br /><br />
 </td></tr></table>
</td></tr></table>
</td></tr></table>
</div>
<!--#Include file="membersFooter.asp"-->
</Body>
</HTML>

