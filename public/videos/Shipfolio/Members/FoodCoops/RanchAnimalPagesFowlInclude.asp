
<table width = "<%=screenwidth %>" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center" ><tr><td class = "roundedtop" align = "left" >
<H1><%=CurrentBreed%></h1>
</td></tr>
<tr><td class = "roundedBottom" align = "left" height = "530" valign = "top">
<% if screenwidth > 800 and TotalAnimals > 3  then %> 


<table border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center" valign = "top" width = "<%=screenwidth -60 %>">
<tr><td class = "body">



<% Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3  %> 
<table border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "right" valign = "top">
<tr>

<td class = "body"  align = "right">
<form name="sort" action="<%=CurrentFile %>?Layout=<%=Layout %>&target=<%=Target %>&CurrentPeopleID=<%=CurrentPeopleID %>&screenwidth=<%=Screenwidth %>&" method="POST">
<select size="1" name="SortOrder"  >
<% if len(SortOrder) > 1 then %>
<option name = "AID0" value= "<%=SortOrder%>" selected><%=SortOrder%></option>
<% end if %>
<option name = "AID0" value= "Name" >Name</option>
<option name = "AID0" value= "Price - Ascending" >Price - Ascending</option>
<option name = "AID0" value= "Price - Descending" >Price - Descending</option>
<option name = "AID0" value= "Color" >Color</option>
<option name = "AID0" value= "DOB" >DOB</option>
</select>
</td>
<td class = "body" width = "60">
<input type=submit value = "Sort "  class = "regsubmit2" >
</form>
</td>
<td class = "body" valign = "bottom" width = "60">
<img src = "/images/px.gif" width = 10 alt = "<%=CurrentBreed%> for Sale" />
</td>




<td class = "body">View:</td><td>
<form name="Layoutform1" action="<%=CurrentFile %>?Layout=1&target=<%=Target %>&CurrentPeopleID=<%=CurrentPeopleID %>&screenwidth=<%=Screenwidth %>" method="POST">
<input type="image" src="/images/PageLayout1.jpg" name="image" width="35" height="28" alt = "Standard"></td>
</form>
<td>
<form name="Layoutform2" action="<%=CurrentFile %>?Layout=2&target=<%=Target %>&CurrentPeopleID=<%=CurrentPeopleID %>&screenwidth=<%=Screenwidth %>" method="POST">
<input type="image" src="/images/PageLayout2.jpg" name="image" width="35" height="28" alt = "Gallery"></form>
</td>
<td>
<form name="Layoutform3" action="<%=CurrentFile %>?Layout=3&target=<%=Target %>&CurrentPeopleID=<%=CurrentPeopleID %>&screenwidth=<%=Screenwidth %>" method="POST">
<input type="image" src="/images/PageLayout3.jpg" name="image" width="35" height="28" alt = "List"></form></td>
<td width = "5">
</td>

<td width="60">
&nbsp;
</td>

</tr></table>
<INPUT TYPE="image" SRC="images/px.gif" HEIGHT="1" WIDTH="1" BORDER="0" ALT="Submit Form">
<% if len(Layout) < 1 then layount=2 %>
<form  action="<%=CurrentFile %>?target=<%=Target %>&Layout=<%=Layout%>&CurrentPeopleID=<%=CurrentPeopleID %>&screenwidth=<%=Screenwidth %>" method = "post">
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  width = "300" align = "right">
<tr>

 
</tr>
</table>
</form>
</td></tr>
<tr><td><br />


</td></tr>
<% end if %>




<% if cint(TotalAnimals) < 1 then %>
<table width = "<%=screenwidth %>" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center"><tr><td class = "roundedtop" align = "left" ><H2><div align = "left"><%=CurrentBreedSingular %>  for Sale</font></h2>
</td></tr>
<tr><td class = "roundedBottom" valign = top><br />
<center>Sorry, we do not currently have any <%=CurrentBreed %> for sale.</center>
</td></tr></table>

<% else %>
<tr><td><a name= "ForSale"></a>
<table width = "<%=screenwidth -40%>" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center"><tr><td class = "roundedtop" align = "left" ><H2><div align = "left"><%=CurrentBreed %> for Sale</font></h2>
</td></tr>
<tr><td class = "roundedBottom" align = "left" valign = "top">
<% 
CurrentspeciesId = 2
if CurrentPeopleID = 1016 then
sql = "select distinct animals.ID, Category, Color1, Color2, Color3, Color4, Color5, Photo1, Photo2, Photo3, Photo4, Photo5, Photo6, Photo7, Photo8, studfee, PriceComments,  SalePending,  Sold,  Free,  ShowPrices,  price, discount,  fullname, DOBDay, DOBMonth, DOBYear, Sire, Dam  from Animals, Pricing, Colors, Photos, ancestors  where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Experienced Male'  or category = 'Experienced Males' or category = 'Proven Male' ) and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select distinct animals.ID, Category, Color1, Color2, Color3, Color4, Color5, Photo1, Photo2, Photo3, Photo4, Photo5, Photo6, Photo7, Photo8, studfee, PriceComments,  SalePending,  Sold,  Free,  ShowPrices,  price, discount,  fullname, DOBDay, DOBMonth, DOBYear, Sire, Dam  from Animals, Pricing, Colors, Photos, ancestors  where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Experienced Male'  or category = 'Experienced Males' or category = 'Proven Male' ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<br /><big><b>Experienced Males for Sale</b></big>
<%   
DetailType = "Sire" 
if len(Layout) = 0 then
Layout=2 
end if
If Layout = 2 or len(Layout) < 1 then
%>
<!--#Include file="DetailInclude2.asp"--> 
<% end if %>
<% If Layout = 1 then %>
<!--#Include file="DetailInclude.asp"--> 
<% end if %>
<% If Layout = 3 then %>
<!--#Include file="DetailInclude3.asp"--> 
<% end if %>
<% end if%>
<% if CurrentPeopleID = 1016 then
sql = "select distinct animals.ID, Category, Color1, Color2, Color3, Color4, Color5, Photo1, Photo2, Photo3, Photo4, Photo5, Photo6, Photo7, Photo8, studfee, PriceComments,  SalePending,  Sold,  Free,  ShowPrices,  price, discount,  fullname, DOBDay, DOBMonth, DOBYear, Sire, Dam  from Animals, Pricing, Colors, Photos, ancestors  where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Inexperienced Male' or category = 'Unproven Male' )   and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select distinct animals.ID, Category, Color1, Color2, Color3, Color4, Color5, Photo1, Photo2, Photo3, Photo4, Photo5, Photo6, Photo7, Photo8, studfee, PriceComments,  SalePending,  Sold,  Free,  ShowPrices,  price, discount,  fullname, DOBDay, DOBMonth, DOBYear, Sire, Dam  from Animals, Pricing, Colors, Photos, ancestors  where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Inexperienced Male' or category = 'Unproven Male' ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<h3>Inexperienced Males for Sale</h3>
<%   
DetailType = "Sire" 
if len(Layout) = 0 then
Layout=2 
end if
If Layout = 2 or len(Layout) < 1 then
%>
<!--#Include file="DetailInclude2.asp"--> 
<% end if %>
<% If Layout = 1 then %>
<!--#Include file="DetailInclude.asp"--> 
<% end if %>
<% If Layout = 3 then %>
<!--#Include file="DetailInclude3.asp"--> 
<% end if %>
<% end if%>


<% if CurrentPeopleID = 1016 then
sql = "select distinct animals.ID, Category, Color1, Color2, Color3, Color4, Color5, Photo1, Photo2, Photo3, Photo4, Photo5, Photo6, Photo7, Photo8, studfee, PriceComments,  SalePending,  Sold,  Free,  ShowPrices,  price, discount,  fullname, DOBDay, DOBMonth, DOBYear, Sire, Dam  from Animals, Pricing, Colors, Photos, ancestors  where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Experienced Female'  or category = 'Experienced Females' or category = 'Proven Female' ) and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select distinct animals.ID, Category, Color1, Color2, Color3, Color4, Color5, Photo1, Photo2, Photo3, Photo4, Photo5, Photo6, Photo7, Photo8, studfee, PriceComments,  SalePending,  Sold,  Free,  ShowPrices,  price, discount,  fullname, DOBDay, DOBMonth, DOBYear, Sire, Dam  from Animals, Pricing, Colors, Photos, ancestors  where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Experienced Female'  or category = 'Experienced Females' or category = 'Proven Female' ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>

<br /><big><b>Experienced Females for Sale</b></big>

<%   
DetailType = "Sire" 
if len(Layout) = 0 then
Layout=2 
end if
If Layout = 2 or len(Layout) < 1 then
%>
<!--#Include file="DetailInclude2.asp"--> 
<% end if %>
<% If Layout = 1 then %>
<!--#Include file="DetailInclude.asp"--> 
<% end if %>
<% If Layout = 3 then %>
<!--#Include file="DetailInclude3.asp"--> 
<% end if %>
<% end if%>
<% if CurrentPeopleID = 1016 then
sql = "select distinct animals.ID, Category, Color1, Color2, Color3, Color4, Color5, Photo1, Photo2, Photo3, Photo4, Photo5, Photo6, Photo7, Photo8, studfee, PriceComments,  SalePending,  Sold,  Free,  ShowPrices,  price, discount,  fullname, DOBDay, DOBMonth, DOBYear, Sire, Dam  from Animals, Pricing, Colors, Photos, ancestors  where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Inexperienced Female' or category = 'Unproven Female' ) and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select distinct animals.ID, Category, Color1, Color2, Color3, Color4, Color5, Photo1, Photo2, Photo3, Photo4, Photo5, Photo6, Photo7, Photo8, studfee, PriceComments,  SalePending,  Sold,  Free,  ShowPrices,  price, discount,  fullname, DOBDay, DOBMonth, DOBYear, Sire, Dam  from Animals, Pricing, Colors, Photos, ancestors  where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Inexperienced Female' or category = 'Unproven Female' ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<br /><big><b>Inexperienced Females for Sale</b></big>
<%   
DetailType = "Sire" 
if len(Layout) = 0 then
Layout=2 
end if
If Layout = 2 or len(Layout) < 1 then
%>
<!--#Include file="DetailInclude2.asp"--> 
<% end if %>
<% If Layout = 1 then %>
<!--#Include file="DetailInclude.asp"--> 
<% end if %>
<% If Layout = 3 then %>
<!--#Include file="DetailInclude3.asp"--> 
<% end if %>
<% end if%>
<% if CurrentPeopleID = 1016 then
sql = "select distinct animals.ID, Category, Color1, Color2, Color3, Color4, Color5, Photo1, Photo2, Photo3, Photo4, Photo5, Photo6, Photo7, Photo8, studfee, PriceComments,  SalePending,  Sold,  Free,  ShowPrices,  price, discount,  fullname, DOBDay, DOBMonth, DOBYear, Sire, Dam  from Animals, Pricing, Colors, Photos, ancestors  where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Non-Breeder' or category = 'Non-Breeders') and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select distinct animals.ID, Category, Color1, Color2, Color3, Color4, Color5, Photo1, Photo2, Photo3, Photo4, Photo5, Photo6, Photo7, Photo8, studfee, PriceComments,  SalePending,  Sold,  Free,  ShowPrices,  price, discount,  fullname, DOBDay, DOBMonth, DOBYear, Sire, Dam  from Animals, Pricing, Colors, Photos, ancestors  where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Non-Breeder' or category = 'Non-Breeders') order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<br /><big><b>Non-Breeding / Fiber / Pet Quality Animals for Sale</b></big>
<%  DetailType = "Sire" 
if len(Layout) = 0 then
Layout=2 
end if
If Layout = 2 or len(Layout) < 1 then
%>
<!--#Include file="DetailInclude2.asp"--> 
<% end if %>
<% If Layout = 1 then %>
<!--#Include file="DetailInclude.asp"--> 
<% end if %>
<% If Layout = 3 then %>
<!--#Include file="DetailInclude3.asp"--> 
<% end if %>
<% end if%>

<% if CurrentPeopleID = 1016 then
sql = "select distinct animals.ID, Category, Color1, Color2, Color3, Color4, Color5, Photo1, Photo2, Photo3, Photo4, Photo5, Photo6, Photo7, Photo8, studfee, PriceComments,  SalePending,  Sold,  Free,  ShowPrices,  price, discount,  fullname, DOBDay, DOBMonth, DOBYear, Sire, Dam  from Animals, Pricing, Colors, Photos, ancestors  where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Preborn Baby'  or category = 'Preborn Babies' or category = 'Preborn Female'  or category = 'Preborn Females' or category = 'Preborn Male' or category = 'Preborn Males'  )  and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select distinct animals.ID, Category, Color1, Color2, Color3, Color4, Color5, Photo1, Photo2, Photo3, Photo4, Photo5, Photo6, Photo7, Photo8, studfee, PriceComments,  SalePending,  Sold,  Free,  ShowPrices,  price, discount,  fullname, DOBDay, DOBMonth, DOBYear, Sire, Dam  from Animals, Pricing, Colors, Photos, ancestors  where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Preborn Baby'  or category = 'Preborn Babies' or category = 'Preborn Female'  or category = 'Preborn Females' or category = 'Preborn Male' or category = 'Preborn Males'  ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>

<br /><big><b>Preborn Babies</b></big>


<%  DetailType = "Sire" 
if len(Layout) = 0 then
Layout=2 
end if
If Layout = 2 or len(Layout) < 1 then
%>
<!--#Include file="DetailInclude2.asp"--> 
<% end if %>
<% If Layout = 1 then %>
<!--#Include file="DetailInclude.asp"--> 
<% end if %>
<% If Layout = 3 then %>
<!--#Include file="DetailInclude3.asp"--> 
<% end if %>
<% end if%>



<% if CurrentPeopleID = 1016 then
sql = "select distinct animals.ID, Category, Color1, Color2, Color3, Color4, Color5, Photo1, Photo2, Photo3, Photo4, Photo5, Photo6, Photo7, Photo8, studfee, PriceComments,  SalePending,  Sold,  Free,  ShowPrices,  price, discount,  fullname, DOBDay, DOBMonth, DOBYear, Sire, Dam  from Animals, Pricing, Colors, Photos, ancestors  where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true  and AGBrokered = True and (category = 'Assortment'   )  and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select distinct animals.ID, Category, Color1, Color2, Color3, Color4, Color5, Photo1, Photo2, Photo3, Photo4, Photo5, Photo6, Photo7, Photo8, studfee, PriceComments,  SalePending,  Sold,  Free,  ShowPrices,  price, discount,  fullname, DOBDay, DOBMonth, DOBYear, Sire, Dam  from Animals, Pricing, Colors, Photos, ancestors  where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = false and PublishForSale = true and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " and (category = 'Assortment'   ) order by " & Sortby
end if 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<h3>Assortment of <%=CurrentBreed %></h3>
<%  DetailType = "Sire" 
if len(Layout) = 0 then
Layout=2 
end if
If Layout = 2 or len(Layout) < 1 then
%>
<!--#Include file="DetailInclude2.asp"--> 
<% end if %>
<% If Layout = 1 then %>
<!--#Include file="DetailInclude.asp"--> 
<% end if %>
<% If Layout = 3 then %>
<!--#Include file="DetailInclude3.asp"--> 
<% end if %>
<% end if%>

</td></tr>

</td></tr></table>
<% end if%>





</td></tr></table>

</td></tr></table>
