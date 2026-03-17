





<table width = "100%" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center" ><tr><td class = "roundedtop" align = "left" >
<H1><%=CurrentBreed%></h1>
</td></tr>
<tr><td class = "roundedBottom" align = "left" height = "530" valign = "top">

<% if ( TotalAnimals > 3 or TotalStuds > 3) then %> 

<table border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center" valign = "top" width = "<%=screenwidth -60 %>">
<tr><td class = "body">
<% if TotalAnimals > 0 then %>
<a href = "?ScreenWidth=<%=Screenwidth %>&CurrentPeopleID=<%=CurrentPeopleID %>#ForSale" class = "body"><%=CurrentBreed %> for Sale</a>
<% if TotalStuds > 0 then %>
| 
<% end if %>  
<% end if %>

<% if TotalStuds > 0 then %>
<a href = "?ScreenWidth=<%=Screenwidth %>&CurrentPeopleID=<%=CurrentPeopleID %>#studs" class = "body"><%= CurrentBreedSingular %> Studs </a>  
<% end if %>

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
sql = "select animals.ID, Category, Color1, Color2, Color3, Color4, Color5, Photo1, Photo2, Photo3, Photo4, Photo5, Photo6, Photo7, Photo8, studfee, PriceComments,  SalePending,  Sold,  Free,  ShowPrices,  price, discount,  fullname, DOBDay, DOBMonth, DOBYear, Sire, Dam  from Animals, Pricing, Colors, Photos, ancestors  where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = 0 and PublishForSale = 1  and AGBrokered = 1 and (category = 'Experienced Male'  or category = 'Experienced Males' or category = 'Proven Male' ) and speciesID = " & CurrentspeciesId & " order by " & Sortby
else
sql = "select animals.ID, Category, Color1, Color2, Color3, Color4, Color5, Photo1, Photo2, Photo3, Photo4, Photo5, Photo6, Photo7, Photo8, studfee, PriceComments,  SalePending,  Sold,  Free,  ShowPrices,  price, discount,  fullname, DOBDay, DOBMonth, DOBYear, Sire, Dam  from Animals, Pricing, Colors, Photos, ancestors  where Animals.ID = Pricing.ID and Animals.ID = ancestors.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = 0 and PublishForSale = 1 and PeopleID= " & CurrentPeopleID & " and speciesID = " & CurrentspeciesId & " order by " & Sortby
end if 

response.write ("Sql=" & sql)

Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
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












<% if cint(TotalStuds) < 1 then %>
<br />
<table width = "<%=screenwidth %>" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center"><tr><td class = "roundedtop" align = "left" ><H2><div align = "left"><%=CurrentBreedSingular %> Studs</font></h2>
</td></tr>
<tr><td class = "roundedBottom" valign = top><br />
<center>Sorry, we do not currently have any <%=CurrentBreed %> for stud.</center>
</td></tr></table>

<% else %>
<tr><td><br /><br />

<a name= "studs"></a>
<% if TotalAnimals > 0 then %>
<a href = "?CurrentPeopleID=<%=CurrentPeopleID %>#ForSale" class = "body"><%=CurrentBreed %> for Sale</a>
<% if TotalStuds > 0 then %>
| <a href = "?CurrentPeopleID=<%=CurrentPeopleID %>#studs" class = "body"><%=CurrentBreedSingular %> Studs</a>
<% end if %>  
<% end if %>
<table width = "<%=screenwidth%>" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center"><tr><td class = "roundedtop" align = "left" ><H2><div align = "left"><%=CurrentBreedSingular %> Studs</font></h2>
</td></tr>
<tr><td class = "roundedBottom" align = "left" valign = "top">




<% if CurrentPeopleID = 1016 then

sql = "select distinct animals.ID, Category, Color1, Color2, Color3, Color4, Color5, Photo1, Photo2, Photo3, Photo4, Photo5, Photo6, Photo7, Photo8, studfee, fullname, DOBDay, DOBMonth, DOBYear, Sire, Dam  from Animals, Pricing, Colors, Photos, ancestors  where  Animals.ID = ancestors.ID and Animals.ID = Pricing.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = 0 and PublishStud = 1  and AGBrokered = 1 and speciesID = " & SpeciesID & " order by " & Sortby

else

sql = "select distinct animals.ID, Category, Color1, Color2, Color3, Color4, Color5, Photo1, Photo2, Photo3, Photo4, Photo5, Photo6, Photo7, Photo8, studfee, fullname, DOBDay, DOBMonth, DOBYear, Sire, Dam  from Animals, Pricing, Colors, Photos, ancestors  where  Animals.ID = ancestors.ID and Animals.ID = Pricing.ID and Animals.ID = Photos.ID and Animals.ID = Colors.ID  and sold = 0 and PublishStud = 1 and PeopleID= " & CurrentPeopleID & " and speciesID = " & SpeciesID & " order by " & Sortby

end if 

'response.write("sql=" & sql)
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then %>
<%   
DetailType = "Sire" 
if len(Layout) = 0 then
Layout=2 
end if
If Layout = 2 or len(Layout) < 1 then
%>
<!--#Include file="StudDetailInclude2.asp"--> 
<% end if %>
<% If Layout = 1 then %>
<!--#Include file="StudDetailInclude.asp"--> 
<% end if %>
<% If Layout = 3 then %>
<!--#Include file="StudDetailInclude3.asp"--> 
<% end if %>
<% end if%>
</td></tr>

</td></tr></table>
<% end if%>
<% if TotalAnimals > 3 or TotalStuds > 3 then %>
<br />
<a href = "#top" class = "body2"><center>Top</center></a>
<br />
<% end if %>
    <% end if %>
</td></tr></table>

</td></tr></table>
