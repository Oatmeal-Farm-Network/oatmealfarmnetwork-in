<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>

<!--#Include file="MembersGlobalVariables2.asp"-->

<%dim AuctionDutchID(40000) 
dim AuctionLevel(40000)
dim AuctionDutchTitle(40000) 
dim AnimalID1(400000)
dim ID(40000) 
dim CurrentPrice(40000)
dim	Name(40000) 
dim	ForSale(40000) 
dim	Category(40000) 
dim	Breed(40000) 
dim Price(40000)
dim	Discount(40000)
dim DiscountPrice(40000)
Dim ShowOnABH(40000)
Dim	ShowOnAC(40000)
Dim	ShowOnASZ(40000)
Dim	ShowOnAP(40000)
Dim	ShowOnAIA(40000)
Dim ShowOnWebsite(40000)
Dim ShowOnOurHerdPage(40000)
Dim PublishForSale(40000)
dim PublishStud(40000)
Dim SpeciesID(40000)
Dim Lastupdated(40000)
dim PackageID(200)
dim PackagePrice(200)
dim Value(200)
dim PackageName(200)
dim Description(200)
Dim MADLotID(200)
dim prodID(99999) 
dim prodName(99999)  
dim prodPrice(99999) 
dim ProdForSale(99999) 
dim ProdQuantityAvailable(99999)
dim catName(99999)
dim subcategoryName(99999)
dim catID(99999)
dim propID(99999) 
dim propName(99999)  
dim propPrice(99999) 
dim propForSale(99999) 
dim propQuantityAvailable(99999)
%>

</HEAD>
<% if mobiledevice = True or is_iPad = true then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<% end if %>
<% 
Current1 = "MembersHome"
Current2="MembersHome" %> 
<!--#Include file="MembersHeader.asp"-->
<% If not rs.State = adStateClosed Then
rs.close
End If   	
%>



<table border = "0" cellpadding = "0" cellspacing="0"  width = "<%=screenwidth -22%>">
<tr><td class = "body" valign = "Top">

<H1>Dashboard Home</h1>
<% if screenwidth > 800 then %>
<table width = 100%><tr><td class = "body2" valign = bottom>
<tr><td>
<table border = "0" cellpadding = "5" cellspacing="0"  align = "left"  width = "<%=screenwidth/2 -45%>">
<tr><td class = body>

<% if subscriptionlevel = 0 then %>
<h2><center>Your Account Is Not Active</center></h2>
Your animals and products will not show up unless your account is active.<br />
<br />

<center><a href = "MembersRenewSubscription.asp?PeopleID=<%=peopleID %>" class = "regsubmit2"><b>Renew Your Membership</b></a></center>

<% else %>
<% showstarbucksoffer = False
if showstarbucksoffer =  True then %>

<img src = "/join/Stabuckscup.jpg" align = "left" height = "120" alt = "Free Starbucks Gift Card"/><br><br>
<b>Free $15 Starbucks Gift Card </b><br>
<font color="black">When You Upgrade or Renew a Premium Membership!</b> <br />
<a href="/members/MembersRenewSubscription.asp?PeopleID=<%=peopleid %>&screenwidth=<%=screenwidth %>" class = "body">Click here to upgrade or renew.</a>

<% end if %>
<% end if %>
<br />
</font>
</td></tr></table>
</td>
<td>


<table border = "0" cellpadding = "5" cellspacing="0"  align = "right"  width = "<%=screenwidth/2 -45%>">
<tr>
<td class = "body" width=  "35">Key</td>
<td width = "30" align = "right"><img src = "images/preview_on.gif" height = "18" border = "0" alt = "View Registration"></td>
<td class = "body" width=  "35">View</td>
<td  width = "30" align = "right"><img src= "images/edit.gif" alt = "edit" height = "18"  border = "0"></td>
<td class = "body" width=  "35">Edit</td>
<td width = "30" align = "right"><img src = "images/delete.jpg" height = "18"" border = "0" alt = "Delete"></td>
<td class = "body" width=  "35" >Delete</td>
<td  width = "30" align = "right"><img src = "images/Photo.gif" height = "18" border = "0" alt = "Upload Photos"></td>
<td class = "body" width=  "40" align = "left">Photos</td>
<td></td>
</tr>
<tr>
<td colspan = 10 class = "body" >



<% if subscriptionlevel = 5 then %><br />
<b>Your Marketplace: World Farm Store</b><br />
Your products will appear on <a href="http://www.worldfarmstore.com" class=body target = '_blank'>www.worldfarmstore.com</a>.<br /><br />
<% end if %>

<% if lcase(custcountry) ="canada" and not subscriptionlevel = 5 then %><br />
<b>Your Marketplace: Livestock Of Canada</b><br />
Since your ranch is in Canada your animals and products will appear on <a href="http://www.LivestockOfCanada.com" class=body target = '_blank'>LivestockOfCanada.com</a>.<br /><br />
<% end if %>

<% if (custcountry ="USA" or lcase(custcountry) ="united states") and not subscriptionlevel = 5 then %><br />
<b>Your Marketplace: Livestock Of America</b><br />
Since your ranch is in America your animals and products will appear on <a href="http://www.LivestockOfAmerica.com" class=body target = "_blank">LivestockOfAmerica.com</a>.<br /><br />
<% end if %>


</td>
</tr>
</table></H1>

</td>
</tr>
</table>


</td></tr>
<tr><td  align = "center">

<% 
FirstTime = request.querystring("FirstTime")
if FirstTime = "True" then %>
<table border = "0" cellspacing="5" cellpadding = "5" align = "center" width = "<%=screenwidth - 22 %>">
<tr><td class = "roundedtopandbottom" align = "left"><h2>Welcome to <%=Sitenamelong %>!</h2>
 To get start we recommend that you visit some of the following pages in the Member Dashboard:
<ul>
<li><a href = "membersAccountContactsEdit.asp?screenwidth=<%=screenwidth %>" class = "body">Your Account</a> - take a moment and make sure that your information is complete.</li>
<li><a href = "MemberssiteDesign.asp?screenwidth=<%=screenwidth %>" class = "body">Ranch Profile</a> - customize your farm pages (define colors & fonts, upload graphics, enter text about your business.)</li>
<%if not Subscriptionlevel=5 then %>
<li><a href = "MembersAnimalAdd1.asp?screenwidth=<%=screenwidth %>" class = "body">Add Animals</a> - use our easy Add a New Animal pages to start entering your Animals.</li>
<% end if %>
<li><a href = "membersServicesAddPage0.asp?screenwidth=<%=screenwidth %>" class = "body">Add Services</a> - enter your Services that you offer.</li>

<li><a href = "membersPlaceClassifiedAd0.asp?screenwidth=<%=screenwidth %>" class = "body">Add Products</a> - enter your products for sale.</li>

</ul>
</td></tr>
</table>
<br />

<% session("FirstTime") = false %>

<% end if %>
<%showad = False
if showad = true then%>
<a href ="http://www.livestockofamerica.com/Membersistration/MembersRenewSubscription.asp?PeopleID=<%=PeopleID %>"><img src = "PlatinumMembersad.jpg" border = "0" width = "100%"  Alt = "Renew Today"/></a>
<% end if %>
<table border = "0" width = "<%=screenwidth -25%>"  bgcolor = "white" cellpadding=0 cellspacing=0  align = "center" >
<tr><td width = "50%" valign = "top" class = "body">


<% 
 Set rs = Server.CreateObject("ADODB.Recordset")
showauctions = false
 if showauctions =  True then
 Set rs2 = Server.CreateObject("ADODB.Recordset")%>

<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%"><tr><td class = "roundedtopandbottom" align = "left">
		<H2><div align = "left">Auctions</div></H2>
<% 

  sql2 = "select * from AuctionDutch where PeopleId= '" & PeopleID & "' order by AuctionDutchID"
'response.write(sql2)
acounter = 1
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3 
if rs2.eof then 
numauctions = 0 
else
numauctions = rs2.recordcount
end if
rs2.close


if SubscriptionLevel < 4 then %>
<b>Your account does not include auctions. Please <a href = "MembersRenewSubscription.asp?peopleID=<%=peopleID %>" class = "body"><b>click here</b></a> to upgrade your account.</b>

<% else
if (SubscriptionLevel = 4 or PeopleID = 620 ) and numauctions = 0  then
Query =  "INSERT INTO AuctionDutch (PeopleID)" 
Query =  Query & " Values ('" &  Session("PeopleID") &  "')"
Conn.Execute(Query) 
numauctions = numauctions +1
end if

if (SubscriptionLevel = 4) and numauctions = 1  then
Query =  "INSERT INTO AuctionDutch (PeopleID)" 
Query =  Query & " Values ('" &  Session("PeopleID") &  "')"
Conn.Execute(Query) 
numauctions = numauctions +1
end if

if (SubscriptionLevel = 4) and numauctions = 2  then
Query =  "INSERT INTO AuctionDutch (PeopleID)" 
Query =  Query & " Values ('" &  Session("PeopleID") &  "')"
Conn.Execute(Query) 
numauctions = numauctions +1
end if

if ( SubscriptionLevel = 4) and numauctions = 3  then
Query =  "INSERT INTO AuctionDutch (PeopleID)" 
Query =  Query & " Values ('" &  Session("PeopleID") &  "')"
Conn.Execute(Query) 
numauctions = numauctions +1
end if


if (SubscriptionLevel = 4) and numauctions = 4  then
Query =  "INSERT INTO AuctionDutch (PeopleID)" 
Query =  Query & " Values ('" &  Session("PeopleID") &  "')"
Conn.Execute(Query) 
numauctions = numauctions +1
end if


sql = "select * from AuctionDutch where PeopleId= '" & PeopleID & "' order by AuctionDutchID"
'response.write (sql)
rs.Open sql, conn, 3, 3   

rowcount = 1

'Recordcount = rs.RecordCount +1

%>
<a Name= "Auctions" ></a>


<table border = "0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "1005">
	<tr><td class = "body" colspan = "3"><div align = "center"><a href = "MembersAuctionAdd.asp" class = "body"><b>Get Additional Auctions</b></a> | <a href = "MembersAuctionAdd.asp" class = "body"><b>Feature Your Auctions</b></a>&nbsp;<br /><a href = "membersAuctionsHome.asp" class = "body"><b>Edit Your Auctions</b></a></div><br></td></tr>
	
<% if rs.eof Then %>
<tr>
   <td class = "body" align = "left">Currently you do not have any auctions listed. To sign up for auctions please select <a href = "MembersAuctionAdd.asp" class = "body"><b>Auctions>Add Auctions</b></a>
</td>
</tr>
<% Else %>
<tr>
<td class = "body2" align = "left" colspan = '2' >Below are your current auctions (select links to edit):</td>
</tr>
<tr>
<td class = "body2" align = "left" ><b>Name</b></td>
<td class = "body2" align = "left" ></td>
</tr>
<% End If 
row = "odd"
While  Not rs.eof  
If row = "even" Then
row = "odd"
Else
row = "even"
End if
AuctionDutchID(rowcount) =   rs("AuctionDutchID")
AnimalID1(rowcount) =   rs("AnimalID1")
AuctionLevel(rowcount) =   rs("AuctionLevel")

if len(AnimalID1(rowcount)) > 0 then
sql2 = "select * from animals where Id= " & AnimalID1(rowcount) 
rs2.Open sql2, conn, 3, 3 
if not rs2.eof then
AuctionDutchTitle(rowcount) = rs2("FullName")
end if
rs2.close
end if

 auctionstartdate = rs("AuctionStartDateMonth") & "/" & rs("AuctionStartDateDay") & "/" & rs("AuctionStartDateYear")
 'response.Write("auctionstartdate=" & auctionstartdate )
if len(auctionstartdate) > 5 then
     TimePast = DateDiff("s", auctionstartdate, now)
		TotalAuctionSeconds=3628800 
		secondsRemaining =  TotalAuctionSeconds - TimePast 
		Daysremaining = round(secondsRemaining / 86400,0)
		MinutesRemainder = round((secondsRemaining - (Daysremaining * 86400)) / 60, 0) 
end if
'if secondsRemaining > 0 or len(auctionstartdate) < 3 then	
If row = "even" Then %>
   <tr>
 <% Else %>
<tr bgcolor = "antiquewhite" >
 <%	End If %>
<td  class = "body"  align = "left" height = "20"><a href = "membersAuctionsHome.asp?AuctionDutchID=<%= AuctionDutchID( rowcount)%>" class = "body">
<% if len(AuctionDutchTitle(rowcount)) > 0 then%>
<%= AuctionDutchTitle(rowcount)%>
<% else %>
Not Set Yet 
<% end if %></a></td>
<td  class = "body"  width = "10"  align = "left"><a href = "membersAuctionsHome.asp?AuctionDutchID=<%= AuctionDutchID( rowcount)%>" class = "body"><%=AuctionLevel( rowcount)%></a></td>
<td class = "body" align = "center" ><a href = "membersAuctionsHome.asp?AuctionDutchID=<%= AuctionDutchID( rowcount)%>" class = "body">&nbsp;&nbsp;<img src= "images/edit.gif" alt = "edit" height ="18" border = "0"></a>
</td></tr>
<%
'end if

 rowcount = rowcount + 1
'response.write("currentrecord=" & rs.currentrecord)
	   rs.movenext
	Wend
TotalCount=rowcount 
	rs.close



 %>
</table>
<% end if%>
</td>
</tr>
</table>
<br />
<% end if %>

<% if  subscriptionlevel = 5 then %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%"><tr><td class = "roundedtopandbottom" align = "left">
		<H2><div align = "left">My Products</div></H2>


	<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding="0" cellspacing="0" width = "100%">
	<tr><td class = "body" colspan = "3">
    <br />    
    <div align = "center"><a href = "MembersClassifiedAdPlace.asp" class = "body"><b>Add a Product</b></a>&nbsp;| &nbsp;<a href = "membersDeleteListing.asp" class = "body"><b>Delete Products</b></a>&nbsp;| &nbsp;<a href = "membersProductStats.asp" class = "body"><b>Statistics</b></a></div>
	<br />
	</td></tr>
<tr><td class = body>

<%  
sql = "select * from sfProducts where PeopleID = " & session("PeopleID") & " order by Prodname"
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3 
    if not rs.eof then  
	rowcount = 1
%><br>
<table width = "100%"   border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
<% row = "odd"
While  Not rs.eof  
If row = "even" Then
row = "odd"
Else
row = "even"
End if
prodID(rowcount) =   rs("prodID")
prodName(rowcount) =   rs("prodName")
prodPrice(rowcount) =   rs("prodPrice")
ProdForSale(rowcount) =   rs("ProdForSale")
ProdQuantityAvailable(rowcount)  =   rs("ProdQuantityAvailable")
catID(rowcount) =   rs("prodCategoryId")
if len(catID(rowcount)) > 0 then
sql2 = "select catname from  SfCategories where CatId = " & catID(rowcount) 
    Set rs2 = Server.CreateObject("ADODB.Recordset")
    rs2.Open sql2, conn, 3, 3 
    if not rs2.eof then  
    	catName(rowcount) =   rs2("catName")
    else
        catName(rowcount) = 0
    end if 
    rs2.close
end if
showstats = True
 If row = "even" Then %>
<tr>
<% Else %>
<tr bgcolor = "#F7E4D9" >
<%	End If %>
</td>
<td class = "body"  align = "left">
<a href = "MembersAdEdit2.asp?prodID=<%= prodID( rowcount)%>#BasicFacts" class = "body"><small><%= prodName( rowcount)%></small></a>
</td>
<td class = body width = 100>
<a href = "MembersAdEdit2.asp?prodID=<%= prodID( rowcount)%>#BasicFacts" class = "body">&nbsp;&nbsp;<img src= "images/edit.gif" alt = "edit" height ="18" border = "0"></a>|&nbsp;<a href = "membersProductPhotos.asp?prodID=<%=prodid( rowcount)%>" class = "body"><img src= "images/Photo.gif" alt = "edit" height ="18" border = "0"></a>|&nbsp;<a href = "membersDeleteListinghandleform1.asp?ID=<%=prodid( rowcount)%>" class = "body"><img src= "images/delete.jpg" alt = "edit" height ="18" border = "0"></a><br>
</td></tr>
<% 
rowcount = rowcount + 1
	   rs.movenext

	Wend
TotalCount=rowcount 
	rs.close
  set rs=nothing
end if
 %>
 </table>
</td></tr></table>
<% else %>

<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%"><tr><td class = "roundedtopandbottom" align = "left">
<H2><div align = "left">My Animals</div></H2>
<br />
<br />



<a Name= "<%=AnimalsSold %>" ></a>
<table border = "0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = 100%>


<tr><td colspan = 6 align = center>
<form  name=form method="post" action="MembersAnimalAdd1.asp?wizard=True&PeopleID=<%=PeopleID %>&screenwidth=<%=screenwidth %>">
<table align= 'center' class='formbox' width = 100% border = 0 class = "formbox">
<tr><td class = "body" colspan = 2><h2>Add an Animal Listing</h2>
<center><font color = "red"><b>*</font>&nbsp;Indicates a Required Field.</center></b>

</td>
<tr><td class = "body">
<font color = "red"><b>*</font># Animals in Listing</b>
</td>
<td class = "body">
<select size="1" name="NumberofAnimals" class = 'formbox' style="width: 320px">
<option  value= "1" selected>1</option>
<option  value= "2" >2</option>
<option  value= "3" >3</option>
<option  value= "4" >4</option>
<option  value= "5" >5</option>
<option  value= "6" >6</option>
<option  value= "7" >7</option>
<option  value= "8" >8</option>
<option  value= "9" >9</option>
<option  value= "10" >10</option>
<option  value= "11" >11</option>
<option  value= "12" >12</option>
<option  value= "13" >13</option>
<option  value= "14" >14</option>
<option  value= "15" >15</option>
<option  value= "16" >16</option>
<option  value= "17" >17</option>
<option  value= "18" >18</option>
<option  value= "19" >18</option>
<option  value= "20" >20</option>
<option  value= "20+" >Over 20</option>
</select></td></tr>


<tr>
<td class = "body">
<b><font color = "red"><b>*</font>Category</b></font>
</td>
<td>
<select size="1" name="Category" class = 'formbox' style="width: 320px">
<option name = "Category12" value=""> -  </small></option>
<option name = "Category12" value="Experienced Male">Experienced Male(s) <small>(Proven/Tested Fertility)</small></option>
<option name = "Category12" value="Inexperienced Male ">Inexperienced Male(s) <small>(Untested Fertility)</small></option>
<option name = "Category14" value="Experienced Female">Experienced Female(s) <small>(Proven/Tested Fertility)</small></option>
<option name = "Category13" value="Inexperienced Female">Inexperienced Female(s) <small>(Untested Fertility)</small></option>
<option name = "Category15" value="Non-Breeder">Non Breeding Animal(s)</option>
<option name = "Category15" value="Preborn Male">Preborn Male(s)</option>
<option name = "Category15" value="Preborn Female">Preborn Female(s)</option>
<option name = "Category15" value="Preborn Baby">Preborn Baby(s) (Either Gender) / Fertilized Eggs</option>
</select>

</td></tr>


<tr><td class = "body"><font color = "red"><b>*</font>Species</b></td>
<td class = "body">

<%
if rs.state = 0 then
else
rs.close
end if

if len(Preferedspecies) > 0 then 
sql = "select Species from SpeciesAvailable where  SpeciesID = " & Preferedspecies & " Order by Species "
rs.Open sql, conn, 3, 3   
if not rs.eof then	
Preferedspeciesname = rs("Species")
end if
rs.close
end if %>

<select size="1" name="SpeciesID" class = 'formbox' style="width: 320px">
<% if len(Preferedspecies) > 0 then %>
<option  value= "<%=Preferedspecies%>" selected><%=Preferedspeciesname%></option>
<% else %>

<% end if %>
<% sql = "select * from SpeciesAvailable where SpeciesAvailable  = 1 Order by Species "
rs.Open sql, conn, 3, 3   
while not rs.eof	
tempSpeciesID = rs("SpeciesID")
if tempSpeciesID = 3 then
species  = "Working Dog"
else
species  = rs("species")
end if %>
<option  value= "<%=tempSpeciesID%>" ><%=species%></option>
<% rs.movenext
wend
rs.close
%>
</select>
</td></tr>

<tr><td align = 'center' colspan = 2>
<br>
<input type=submit value = "Submit" class="regsubmit2" >
</Form>
<br>
<br><br>
Select the <a href ="membersAccountContactsEdit.asp?screenwidth=<%=screenwidth %>" class = "body">Account Info</a> Tab to set your primary, default, species.
<br>
</td></tr></table>
<br>
</td></tr>
<tr>
<td colspan = 5><br />
</td>
</tr>
<tr><td class = "body" colspan = "6"><div align = "center"><a href = "MembersAnimalAdd1.asp" class = "body"><b>Add Animals</b></a>&nbsp;|<a href = "membersEditAnimal.asp" class = "body"> <b>Edit Animals</b></a>&nbsp;|  <a href = "membersdeleteAnimal.asp" class = "body"><b>Delete Animals</b></a>&nbsp;|
&nbsp;<a href = "membersAnimalsStats.asp" class = "body"><b>Statistics</b></a></div><br></td></tr>


<% sql = "select distinct animals.ID, speciesID, FullName, PublishForSale, PublishStud, ShowOnOurHerdPage, Lastupdated from Animals  where PeopleID = " & Session("PeopleID") & "  order by speciesID, FullName "

'response.write("sql=" & sql)

'sql = "select distinct Animals.ID, animals.speciesID, Animals.FullName, Animals.Category from Animals, pricing where Animals.ID = Pricing.ID aND PeopleID = " & session("PeopleID") & " order by Animals.FullName "


rs.Open sql, conn, 3, 3   
rowcount = 1

Recordcount = rs.RecordCount +1
%>
<% if rs.eof Then %>
<tr><td class = "body" align = "left">Currently you do not have any aniamls listed. To add animals please us the <a href = "MembersAnimalAdd1.asp" class = "body"><b>Add An Animal Link.</b></a>
</td></tr>
<% Else %>
<tr bgcolor = "#e6e6e6">
<td class = "body2" align = "center" ><b>Name</b></td>
<td class = "body2" align = "center" width= "80" ><b>Published</b></td>
<td class = "body2" align = "center" width= "90" ><b>Published<br />Stud</b></td>
<td class = "body2" align = "center" width= "80" ><b>Species</b></td>
<td class = "body2" align = "center" width = "90"><b>Options</b></td>
</tr>
<% End If 
row = "odd"
While  Not rs.eof  
SpeciesName = ""
SpeciesID(rowcount) = rs("SpeciesID")
PublishForSale(rowcount)= rs("PublishForSale")
PublishStud(rowcount)= rs("PublishStud")
Lastupdated(rowcount) = rs("Lastupdated")
if SpeciesID(rowcount) = 2 then
SpeciesName="Alpaca" 
end if 
if SpeciesID(rowcount) = 3 then
SpeciesName="Dog"
end if 
if SpeciesID(rowcount) = 4 then
SpeciesName="Llama"
end if 
if SpeciesID(rowcount) = 5 then
SpeciesName="Horse"
end if 
if SpeciesID(rowcount) = 6 then
SpeciesName="Goat"
end if 
if SpeciesID(rowcount) = 7 then
SpeciesName="Donkey"
end if 
if SpeciesID(rowcount) = 8 then
SpeciesName="Cattle"
end if 
if SpeciesID(rowcount) = 9 then
SpeciesName="Bison"
end if 
if SpeciesID(rowcount) = 10 then
SpeciesName="Sheep"
end if 
if SpeciesID(rowcount) = 11 then
SpeciesName="Rabbit"
end if 
if SpeciesID(rowcount) = 12 then
SpeciesName="Pig"
end if 
if SpeciesID(rowcount) = 13 then
SpeciesName="Chicken"
end if 
if SpeciesID(rowcount) = 14 then
SpeciesName="Turkey"
end if 
if SpeciesID(rowcount) = 15 then
SpeciesName="Duck"
end if 
if  SpeciesID(rowcount) = 16 then
SpeciesName="Cat"
end if 
if SpeciesID(rowcount) = 17 then
SpeciesName="Yak"
end if 

if SpeciesID(rowcount) = 18 then
SpeciesName="Camel"
end if 

if SpeciesID(rowcount) = 19 then
SpeciesName="Emu"
end if 

if SpeciesID(rowcount) = 20 then
SpeciesName="Elk"
end if 

if SpeciesID(rowcount) = 21 then
SpeciesName="Deer"
end if 

if SpeciesID(rowcount) = 22 then
SpeciesName="Geese"
end if 


ID(rowcount) =   rs("ID")
Name(rowcount) =   rs("FullName")

str1 = Name(rowcount)
str2 = "''"
If InStr(str1,str2) > 0 Then
Name(rowcount)= Replace(str1, "''", "'")
End If


If row = "even" Then 
row = "odd" %>
<tr bgcolor = "#e6e6e6">
<% Else 
 row = "even"%>
<tr>
<%	End If %>
<td  class = "body"  height = "20" align = "left" colspan = 5><a href = "membersEditAnimal.asp?ID=<%= ID( rowcount)%>#Top" class = "body"><small><%= Name(rowcount)%></a>
<% if len(Lastupdated(rowcount)) > 0 then %>
<font color = "#777777">Updated: <%=formatdatetime(Lastupdated(rowcount), 2) %></font>
<% end if %>
</small>
</td></tr>

<% If row = "odd" Then  %>
<tr bgcolor = "#e6e6e6">
<% Else %>
<tr>
<%	End If %>
<td></td>
<td class = "body2" align = "center">
<% if PublishForSale(rowcount) = 1 then %>
&starf;
<% end if %>
</td>
<td class = "body2" align = "center">
<% if PublishStud(rowcount) = 1 then %>
&starf;
<% end if %>
</td>
<td class = "body2" align = "center">
<small><% =SpeciesName %></small>
</td>
<td class = "body" align = "center" ><a href = "membersEditAnimal.asp?ID=<%= ID( rowcount)%>#Top" class = "body">&nbsp;&nbsp;<img src= "images/edit.gif" alt = "edit" height ="18" border = "0"></a>|&nbsp;<a href = "/members/MembersPhotos.asp?ID=<%= ID( rowcount)%>" class = "body"><img src= "images/Photo.gif" alt = "edit" height ="18" border = "0"></a>

|&nbsp;<a href = "/members/membersDeleteAnimalhandleform1.asp?ID=<%= ID( rowcount)%>" class = "body"><img src = "images/delete.jpg" height = "16"" border = "0" alt = "Delete"></a>

<br></td></tr>
<% rowcount = rowcount + 1
rs.movenext
Wend
TotalCount=rowcount 
rs.close

%>
</table>
</td>
</tr>
</table>
<% end if %>







</td>
<td width = "5"><img src = "images/px.gif" height = "1" width = "1" /></td>
<td valign = "top" width = 47%>

<% 
If Request.Querystring("SetLive" ) = "False" Then
Query =  " UPDATE people Set "
Query =  Query & " AIPublish = False"
Query =  Query & " where PeopleID = " & PeopleID & ";" 
Conn.Execute(Query) 
response.redirect("Default.asp?PeopleID=" & PeopleID & "#Status")
end if 
If Request.Querystring("SetLive" ) = "True" Then
Query =  " UPDATE people Set "
Query =  Query & " AIPublish = True"
Query =  Query & " where PeopleID = " & PeopleID & ";" 
Conn.Execute(Query) 
response.redirect("Default.asp?PeopleID=" & PeopleID & "#Status")
end if 

 Set rs = Server.CreateObject("ADODB.Recordset")

sql = "select AIPublish from People  where PeopleID = " & Session("PeopleID") 
'response.write("sql=" & sql)
rs.Open sql, conn, 3, 3   
AIPublish = rs("AIPublish")
rs.close
%>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = 100%>
<tr><td class = "roundedtopandbottom" align = "left">
<H2><div align = "left">My Account</div></H2>
      <% if len(custAIEndService) > 3 then
        else
        Noenddate = True
         end if %>
<% if accesslevel < 1 and DateDiff("d", now, custAIEndService )< 0 then %>
<b>Your Account has Expired</b>
Your products and animals are not currently appearing. 
To reactivate your account:
<ol><li>Renew your account by selecting the appropriate button below.</li>
<li>Republish your animals and products.</li></ol>

<% end if %>

<% if accesslevel < 1 and (DateDiff("d", now, custAIEndService ) > 0 or Noenddate = True) then %>
<b>Your Account is Not Currently Active</b>
That means that a payment for your account has not been processed yet. If you just signed up, your payment might take a little time to process.

<% end if %>

<a name="Status"></a>
<table><tr><td class = "body2" align = "left" width = "300">
Membership Level:<br>
Membership Ends:<br />
</td>
<td class = "body" width = "<%=screenwidth - 120 %>" valign = top>
<% if SubscriptionLevel= 0 then %>
<b><big><font color = maroon>Expired</font></big></b>
<% end if %>
<% if SubscriptionLevel= 1 then %>
<b>Copper</b>
<% end if %>
<% if SubscriptionLevel= 2 then %>
<b>Silver</b>
<% end if %>
<% if SubscriptionLevel= 3 then %>
<b>Basic</b>
<% end if %>
<% if SubscriptionLevel= 4 then %>
<b>Premium</b>
<% end if %>
<% if SubscriptionLevel= 5 then %>
<b>Vendor</b>
<% end if %>
<% if SubscriptionLevel= 19 then %>
<b>Trial</b>
<% end if %>
<br />
<% if Noenddate = True then %>
Not Set
<% else %>
<%=custAIEndService  %>
<% end if %>
</td>
</tr>
<% 
SubscribedWebsites = ""
sql = "SELECT distinct SubscribedWebsite from peoplewebsitesubscribe where PeopleID = " & PeopleID  
rs.Open sql, conn, 3, 3   
while Not rs.eof 
SubscribedWebsites = SubscribedWebsites & rs("SubscribedWebsite") & "<br>"
rs.movenext
wend
rs.close
%>

<tr>
<td colspan = '2' align = "center">
<% if SubscriptionLevel= 0 then %>
<a href = "MembersRenewSubscription.asp?PeopleID=<%=peopleID %>" class = "regsubmit2"><b>Renew Your Membership</b></a><br /><br />
<% else %>
<a href = "MembersRenewSubscription.asp?PeopleID=<%=peopleID %>" class = "regsubmit2"><b>Renew or Upgrade Your Membership</b></a><br /><br />
<% end if %>
</td>
</tr></table>





   </td>
   </tr>
  </table>
<br />
<% 
showlogoad = True
if SubscriptionLevel= 4 or SubscriptionLevel= 5 then %>
<table width = 100% class = "formbox" cellpadding = 0 cellspacing = 0 border = 0>
<tr>
<td class = "body" valign = top>
<h2>Free Online Ad</h2>
<b>Size: 200 pixels x 200 pixels</b><br />
<% 
sql =  "select AdImage from Ads where PeopleId = " &  PeopleID  & " and Adtype = 'Logo' order by adid desc"
rs.Open sql, conn, 3, 3  
if not rs.eof then
LogoAd = rs("AdImage")
end if
rs.close %>


<table width = 205  align = left cellpadding = 5 cellspacing = 5>
<tr><td class = "body">
<b>Your Ad</b><br />
<% if len(LogoAd) > 3 then %>
<img src = <%=LogoAd%> width = 200 height = 200 />
<% else %>
<table width = 200 height = 200 border = 1 cellspacing = 0 cellpadding = 0>
<tr><td class = body2 align = center><b><font size = 4>Your Ad<br /> Hasn't Been <br />Uploaded Yet.</b><br /> <br />Upload Your Ad Below.</font></td></tr></table>
<% end if %>
</td></tr>
</table>

As a Premium member, you get a free logo ad worth over $200! The ad can be your logo or just about any other image that you want!*<br /><br />
Online ads randomly appear on list pages throughout the Livestock site that you are a member of, until the end of December 2017.<br /><br />
Your ad will link to your livestock farm pages.<br /><br />
<i><small>* We reserve the right to remove any inappropriate content.</small></i>
<br /><br /><br />
<b>Upload Ad (JPG or PNG format only)</b><br />
<form name="frmSend" method="POST" enctype="multipart/form-data" action="MembersUploadLogoAdImagehandle.asp?Returnpage=<%=Returnpage %>&PeopleID=<%=PeopleID%>&AdType=Breed Ad&AdID=<%=AdID%>" class = "formbox">
<input name="Returnpage" value="<%=Returnpage %>" type = "hidden" >			
<input name="attach1" type="file" size=65  >
<center><input  type=submit value="  UPLOAD " class = "regsubmit2"></center>

</form>
<br />

<h3>Need Help Designing Your Ad?</h3>
<a href="/contactus.asp" class = "body" target = "_blank"><b>Contact us</b></a> and we will be happy to provide you with a professional graphic design quote. 
<br />
<br />
</td>
</tr>
</table>

<% end if %>
  
<br />
<% showadditionalservices = False
if showadditionalservices = true then %>

<!--#Include virtual="/conn.asp"-->
  <table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "445"><tr><td class = "roundedtopandbottom" align = "left">
<H2><div align = "left">Additional Services</div></H2>
<a href = "MembersAdvertisingAdd.asp" class = "body"><b>Sign up for Advertising and other additional services!</b></a><br>
<a href = "membersAdvertisinghome.asp" class = "body">Manage Your Advertisements.</a><br>
</td></tr></table>

<br />
<% end if %>
  <table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%"><tr><td class = "roundedtopandbottom" align = "left">
<H2><div align = "left">My Ranch Profile</div></H2>
<a href = "MemberssiteDesign.asp" class = "body">Graphic Design (colors, fonts, ect.)</a><br />
<a href = "membersRanchhomeadmin.asp?PeopleID=<%=PeopleID %>" class = "body">Home Page</a><br />
<a href = "membersPageData2.asp?pagename=About Us&PeopleID=<%=PeopleID %>" class = "body">About Us Page</a><br />
</td></tr></table>
<br />
<% showpackages = false
if showpackages = true then %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "445"><tr><td class = "body roundedtopandbottom" align = "left">
		<H2><div align = "left">Packages</div></H2>
<%  
   Set rs = Server.CreateObject("ADODB.Recordset")
sql = "select Count(PackageID) as count from Package where PeopleID =  " & session("PeopleID") & ""
    rs.Open sql, conn, 3, 3  
    Recordcount = clng(rs("count"))
  rs.close  
    
if SubscriptionLevel < 4 and Recordcount = 0 then %>
<b>Your account does not include packages. Please <a href = "MembersRenewSubscription.asp?peopleID=<%=peopleID %>" class = "body"><b>click here</b></a> to upgrade your account.</b>

<% else %>




	<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding="0" cellspacing="0" width = "100%">
	<tr><td class = "body" colspan = "3"><div align = "center"><a href = "membersPackagesAdd.asp" class = "body"><b>Add a Package</b></a>&nbsp;| &nbsp;<a href = "membersPackagesDelete.asp" class = "body"><b>Delete Packages</b></a>&nbsp;| &nbsp;<a href = "membersPackageStats.asp" class = "body"><b>Statistics</b></a></div>
	<br />
	</td></tr>
<%

 sql = "select * from Package where PeopleID =  " & session("PeopleID") & ""

'response.write (sql)
 
    rs.Open sql, conn, 3, 3   
	rowcount = 1
	
if rs.eof  then%>
<tr>
   <td class = "body" align = "left"><b>Currently you do not have any packages. To create a package please <a href= "memberspackagesadd.asp" class = "body"><b>click here</b></a>.
	</td>
</tr>
<% else %>
<tr>
		<td class = "body" align = "center" width = "265"><b>Name</b></td>
		<td class = "body" align = "center" width = "100"><b>Price</b></td>
		<td class = "body" width = "100" align = "center"><b>Options</b></td>
 </tr>
<%
even = True
rowcount = 1
 While  Not rs.eof     
	 PackageID(rowcount) =   rs("PackageID")
	 PackageName(rowcount) =   rs("PackageName")
	 PackagePrice(rowcount) =   rs("PackagePrice")
	  Value(rowcount) =   rs("PackageValue")
	 Description(rowcount) =   rs("Description")

If even = True then
	even = False
Else
	even = True
End If 

If even = True then
%>
   <tr>
<% Else %>
<tr>
<% End If %>
	
		<td class = "body"  align = "left">
		<b><a href = "membersAddaPackageStep4.asp?PackageID=<%= PackageID(rowcount)%>" class = "body"><%= PackageName(rowcount)%></a></b> 
		</td>
		<td class = "body"  align = "right" >
		<% if len(PackagePrice(rowcount)) > 1 Then %>
			<%= formatcurrency(PackagePrice(rowcount), 2) %>
		<% Else %>
		Not Assigned
		<% end if %>

		</td>
		<td  align = "right">
	<a href = "membersAddaPackageStep4.asp?PackageID=<%= PackageID(rowcount)  %>" class = "body"><img src= "images/edit.gif" alt = "edit" height ="18" border = "0"></a> |
<a href = "membersEditPackageLayout2.asp?PackageID=<%= PackageID(rowcount)  %>" class = "body"><img src= "images/Layout.gif" alt = "edit" height ="18" border = "0"></a>

		</td>
		</tr>
		
<%
		rowcount = rowcount + 1
	   rs.movenext
	Wend
TotalCount=rowcount 

 end if%>
<tr><td>

</td></tr>
</table>
<% end if %>
</td></tr>
</table>
<br />
<% end if %>



<% if not SubscriptionLevel= 5 then %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%"><tr><td class = "roundedtopandbottom" align = "left">
		<H2><div align = "left">My Products</div></H2>


	<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding="0" cellspacing="0" width = "100%">
	<tr><td class = "body" colspan = "3">
    <br />    
    <div align = "center"><a href = "MembersClassifiedAdPlace.asp" class = "body"><b>Add a Product</b></a>&nbsp;| &nbsp;<a href = "membersDeleteListing.asp" class = "body"><b>Delete Products</b></a>&nbsp;| &nbsp;<a href = "membersProductStats.asp" class = "body"><b>Statistics</b></a></div>
	<br />
	</td></tr>
<tr><td class = body>

<%  
sql = "select * from sfProducts where PeopleID = " & session("PeopleID") & " order by Prodname"
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3 
    if not rs.eof then  
	rowcount = 1
%><br>
<table width = "100%"   border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
<% row = "odd"
While  Not rs.eof  
If row = "even" Then
row = "odd"
Else
row = "even"
End if
prodID(rowcount) =   rs("prodID")
prodName(rowcount) =   rs("prodName")
prodPrice(rowcount) =   rs("prodPrice")
ProdForSale(rowcount) =   rs("ProdForSale")
ProdQuantityAvailable(rowcount)  =   rs("ProdQuantityAvailable")
catID(rowcount) =   rs("prodCategoryId")
if len(catID(rowcount)) > 0 then
sql2 = "select catname from  SfCategories where CatId = " & catID(rowcount) 
    Set rs2 = Server.CreateObject("ADODB.Recordset")
    rs2.Open sql2, conn, 3, 3 
    if not rs2.eof then  
    	catName(rowcount) =   rs2("catName")
    else
        catName(rowcount) = 0
    end if 
    rs2.close
end if
showstats = True
 If row = "even" Then %>
<tr>
<% Else %>
<tr bgcolor = "#F7E4D9" >
<%	End If %>
</td>
<td class = "body"  align = "left">
<a href = "MembersAdEdit2.asp?prodID=<%= prodID( rowcount)%>#BasicFacts" class = "body"><small><%= prodName( rowcount)%></small></a>
</td>
<td class = body width = 100>
<a href = "MembersAdEdit2.asp?prodID=<%= prodID( rowcount)%>#BasicFacts" class = "body">&nbsp;&nbsp;<img src= "images/edit.gif" alt = "edit" height ="18" border = "0"></a>|&nbsp;<a href = "membersProductPhotos.asp?prodID=<%=prodid( rowcount)%>" class = "body"><img src= "images/Photo.gif" alt = "edit" height ="18" border = "0"></a>|&nbsp;<a href = "membersDeleteListinghandleform1.asp?ID=<%=prodid( rowcount)%>" class = "body"><img src= "images/delete.jpg" alt = "edit" height ="18" border = "0"></a><br>
</td></tr>
<% 
rowcount = rowcount + 1
	   rs.movenext

	Wend
TotalCount=rowcount 
	rs.close
  set rs=nothing
end if
 %>
 </table>
</td></tr></table>
<% showproperties = false
if showproperties = True then %>
	<br />
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%"><tr><td class = "body roundedtopandbottom" align = "left">
		<H2><div align = "left">Properties</div></H2>

<% if SubscriptionLevel < 4 then %>
<b>Your account does not include property listings. Please <a href = "MembersRenewSubscription.asp?peopleID=<%=peopleID %>" class = "body"><b>click here</b></a> to upgrade your account.</b>

<% else %>

	<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding="0" cellspacing="0" width = "100%">
	<tr><td class = "body" colspan = "3"><div align = "center"><a href = "membersAddaProperty.asp" class = "body"><b>Add a Property</b></a>&nbsp;|&nbsp;<a href = "membersDeleteProperty.asp" class = "body"><b>Delete Properties</b></a></div>
	<br />
	</td></tr>
<%  
sql = "select * from Properties where PeopleID = " & session("PeopleID") & " order by propname"
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3 
if not rs.eof then  
rowcount = 1
%><br>
<table width = "100%"   border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
<tr>
<td class = "body" align = "center" ><b>Property</b></td>
<td class = "body" align = "center" width = "50" ><b>For Sale</b></td>
<td class = "body" align = "center"width = "29" ><b>Price </b></td>
<td class = "body" align = "center" ><b>Options</b></td>
</tr>
<% row = "odd"
While  Not rs.eof  
If row = "even" Then
row = "odd"
Else
row = "even"
End if
propID(rowcount) =   rs("propID")
propName(rowcount) =   rs("propName")
propPrice(rowcount) =   rs("propPrice")
PropForSale(rowcount) =   rs("PropForSale")
showstats = True
 If row = "even" Then %>
<tr>
<% Else %>
<tr bgcolor = "#F7E4D9" >
<%	End If %>
</td>
<td class = "body" width = "100%" align = "left">
<a href = "membersEditProperty0.asp?prodID=<%= propID( rowcount)%>#BasicFacts" class = "body"><%= propName( rowcount)%></a>
</td>
<td class = "body" align = "center" >
<%=PropForSale(rowcount) %>
</td>
<td class = "body" width = "29" align = "right">
<% if len(propPrice(rowcount)) > 0 then%>
<%=  formatcurrency(propPrice(rowcount)) %>
<% else %>    
$0
<% end if %>
</td>
<td class = "body" align = "center" ><a href = "membersEditProperty0.asp?prodID=<%= prodID( rowcount)%>#BasicFacts" class = "body">&nbsp;&nbsp;<img src= "images/edit.gif" alt = "edit" height ="12" border = "0"></a>|&nbsp;<a href = "membersPropertyPhotos.asp?prodID=<%=prodid( rowcount)%>" class = "body"><img src= "images/Photo.gif" alt = "edit" height ="14" border = "0"></a><br>
		</td>
		</tr>
<% 

		rowcount = rowcount + 1
	   rs.movenext

	Wend
TotalCount=rowcount 
	rs.close
  set rs=nothing
end if
 %>

</table>
	<% end if %>
	
<tr><td></td></tr>
</table>
<% end if %>
<% end if %>

<% showpages = false

if showpages = true then %>
<br />	
	
	   <table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%"><tr><td class = "roundedtopandbottom" align = "left">
		<H2><div align = "left">My Ranch Pages</div></H2>
<br />

<% 
If Request.Querystring("UpdatePages" ) = "True" Then
ShowSitePages = request.Form("ShowSitePages")
  		sqlp = "select * from RanchpageLayout where PeopleID = " & PeopleID
			Set rsp = Server.CreateObject("ADODB.Recordset")
			rsp.Open sqlp, conn, 3, 3
			if not rsp.eof then 
			 while Not rsp.eof 
			 PageName = rsp("PageName")
			str1 = ShowSitePages 
			str2 = PageName
			If InStr(str1, str2) > 0 Then
				Query =  " UPDATE RanchpageLayout Set "
Query =  Query & " ShowPage = True"
Query =  Query & " where PeopleID = " & PeopleID & " and PageName = '" & PageName & "' ;" 
    Conn.Execute(Query) 

			
	else
				Query =  " UPDATE RanchpageLayout Set "
Query =  Query & " ShowPage = False"
Query =  Query & " where PeopleID = " & PeopleID & " and PageName = '" & PageName & "' ;" 

       Conn.Execute(Query) 
  
			End If  
			
			 rsp.movenext
			wend 
		 end if 
end if
	' End Update Pages %>
 
<form  name=UpdatePagesform method="post" action="Default.asp?PeopleID=<%=PeopleID%>&UpdatePages=True#pages">

	<table border = "0"  width = "100%" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "center">
	<tr bgcolor = "#eeeeee">
	<td class = "body" align = "center" width = "100" height = "25"><a name="pages"></a><b>Page</b></td>
	<td class = "body" align = "center" width = "200"><b>Include on Ranch site</b></td>
	<td class = "body"  align = "center" ><b>Actions</b></td>
	</tr>

	
	
	
		
<% 
order = "odd"	
sql2 = "select * from RanchPageLayout where PeopleID = " & PeopleID & " order by LinkOrder"	
	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	
	While Not rs2.eof 
	ShowPage = rs2("ShowPage")
	
	 if order = "even" then
	  	order = "odd" %>
	  	<tr bgcolor = "#eeeeee">
	  	
	 <% else
	     order = "even" %>
	 	<tr bgcolor = "white">    
	<% end if %> 
 
 	 <td class = "body">&nbsp;<a href = "<%=rs2("EditLink")%>" class= "body" ><%=rs2("PageName")%></a></td>
 	 	<td class = "body" align = "center" width = "80">
 	 	<% if rs2("PageName") ="Home" then %>
 	 	Always
 	 	    <% else %>   
 	 	<% if ShowPage  = True then %>
 	 	    <input type="checkbox" name="ShowSitePages" value="<%=rs2("PageName") %>" checked>Yes
 	 	<% else %>
 	 	    <input type="checkbox" name="ShowSitePages" value="<%=rs2("PageName") %>" >No
 	 	<% end if %>
 	 	<% end if %>
 	 	</td>
	 </tr>
 <% 
	rs2.movenext
 Wend %>

		<tr>
	<td class = "body" colspan = "3" align = "center">
	<input type="submit"  value="Submit" class = "Regsubmit2" ><br>

	</td>
	</tr>

</form>
</table>


</td>
</tr>
</table>
<% end if %>
</td>
</tr>
</table>

	</td>
</tr>
</table>
<% 
else

'*********************************************************************
' Mobile Version of Dashboard Home
'*********************************************************************
%>

<table border = "0" cellpadding = "0" cellspacing="0"  width = "100%">
<tr>
<td valign = "top" width = 100%>

<% showstarbucksoffer = False
if showstarbucksoffer =  True then %>
<table width = 100%><tr><td class = "body2" valign = bottom>
<img src = "/join/Stabuckscup.jpg" align = "left" height = "120" alt = "Free Starbucks Gift Card"/><br><br>
<b>Free $15 Starbucks Gift Card </b><br>
<font color="black">When You Sign Up or Renew a Premium Membership!</b> <br />

<a href="/members/MembersRenewSubscription.asp?PeopleID=<%=peopleid %>&screenwidth=<%=screenwidth %>" class = "body">Click here to upgrade or renew.</a>
<br /><br /><br />
<br><br></font>
</td></tr></table>
<% end if %>


 <% 

 if len(custAIEndService) > 3 then
else
   Noenddate = True
end if %>

</td></tr>

<br />
<% if accesslevel < 1 and DateDiff("d", now, custAIEndService )< 0 then %>
<tr><td bgcolor = "#F9E4C5">
<h2>Your Account has Expired</h2>
Your products and animals are not currently appearing. 
To reactivate your account:
<ol><li>Renew your account by selecting the appropriate button below.</li>
<li>Republish your animals and products.</li></ol>

</td></tr>
<tr><td><br /></td></tr>
<% end if %>

<% if accesslevel < 1 and (DateDiff("d", now, custAIEndService ) > 0 or Noenddate = True) then %>
<tr><td bgcolor = "#F9E4C5">
<h2>Your Account is Not Currently Active</h2>
That means that a payment for your account has not been processed yet. But if you feel like that this is in error please <a href="/contactus.asp" class = body>contact us</a>.
</td></tr>
<tr><td><br /></td></tr>
<% end if %>



<% if subscriptionlevel = 5 then %>
<tr><td bgcolor = "#F9E4C5"><br />
<b>Your Marketplace: World Farm Store</b><br />
Your products will appear on <a href="http://www.worldfarmstore.com" class=body target = '_blank'>www.worldfarmstore.com</a>.<br /><br />
</td></tr>
<% end if %>




<% if custcountry ="Canada" and not subscriptionlevel = 5 then %>
<tr><td bgcolor = "#F9E4C5">
<b>Your Marketplace: Livestock Of Canada</b><br />
Since your ranch is in Canada your animals and products will appear on <a href="http://www.LivestockOfCanada.com" class=body target = '_blank'>LivestockOfCanada.com</a>.
</td></tr>
<% end if %>

<% if custcountry ="USA" and not subscriptionlevel = 5 then %>
<tr><td bgcolor = "#F9E4C5">
<b>Your Marketplace: Livestock Of America</b><br />
Since your ranch is in America your animals and products will appear on <a href="http://www.LivestockOfAmerica.com" class=body target = "_blank">LivestockOfAmerica.com</a>.
</td></tr>
<% end if %>
<br />


<% 
If Request.Querystring("SetLive" ) = "False" Then
Query =  " UPDATE people Set "
Query =  Query & " AIPublish = False"
Query =  Query & " where PeopleID = " & PeopleID & ";" 
Conn.Execute(Query) 
response.redirect("Default.asp?PeopleID=" & PeopleID & "#Status")
end if 
If Request.Querystring("SetLive" ) = "True" Then
Query =  " UPDATE people Set "
Query =  Query & " AIPublish = True"
Query =  Query & " where PeopleID = " & PeopleID & ";" 
Conn.Execute(Query) 
response.redirect("Default.asp?PeopleID=" & PeopleID & "#Status")
end if 
sql = "select AIPublish from People  where PeopleID = " & Session("PeopleID") 
rs.Open sql, conn, 3, 3   
AIPublish = rs("AIPublish")
rs.close
%>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = 100%>
<tr><td class = "roundedtopandbottom" align = "left">
<H2><div align = "left">My Account</div></H2>


<a name="Status"></a>
<table><tr><td class = "body2" align = "left" width = "200">
Membership Level:<br>
Membership Ends: 
</td>
<td class = "body" >
<% if SubscriptionLevel= 0 then %>
<b>Tin</b>
<% end if %>
<% if SubscriptionLevel= 1 then %>
<b>Copper</b>
<% end if %>
<% if SubscriptionLevel= 2 then %>
<b>Silver</b>
<% end if %>
<% if SubscriptionLevel= 3 then %>
<b>Basic</b>
<% end if %>
<% if SubscriptionLevel= 4 then %>
<b>Premium</b>
<% end if %>
<% if SubscriptionLevel= 5 then %>
<b>Standard</b>
<% end if %>
<% if SubscriptionLevel= 19 then %>
<b>Trial</b>
<% end if %>
<br />
<% if Noenddate = True then %>
Not set
<% else %>
<%=custAIEndService  %>
<% end if %>

</td>
</tr>

<tr>
<td colspan = '2' align = "center">

<a href = "MembersRenewSubscription.asp?PeopleID=<%=peopleID %>&screenwidth=<%=screenwidth %>" class = "regsubmit2"><font face="verdana" size = '2' color = black>Renew or Upgrade Your Membership</font></a><br /><br />
</td>
</tr></table>

</td></tr>

<% if subscriptionlevel= 5 then %>
<tr><td><br /></td></tr>
<% else %>

<tr><td>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%">
<tr><td class = "roundedtopandbottom" align = "left">
<H2><div align = "left">My Animals</div></H2>



<a Name= "<%=AnimalsSold %>" ></a>
<form  name=form method="post" action="MembersAnimalAdd1.asp?wizard=True&PeopleID=<%=PeopleID %>&screenwidth=<%=screenwidth%>">
<table border = "0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = 100%>


<tr><td colspan = 6 align = center>

<table align= 'center' class='formbox' width = 100% border = 0 >
<tr><td class = "body" colspan = 2><h2>Add an Animal Listing</h2>
<font color = "red"><b><center>*</font> Indicates a Required Field.</center></b></td></tr>
<tr><td class = "body">
<br />
<b><font color = "#993333">Number of Animals in Listing </b></font><br />

<select size="1" name="NumberofAnimals" class = 'formbox' style="width: 320px">
<option  value= "1" selected>1</option>
<option  value= "2" >2</option>
<option  value= "3" >3</option>
<option  value= "4" >4</option>
<option  value= "5" >5</option>
<option  value= "6" >6</option>
<option  value= "7" >7</option>
<option  value= "8" >8</option>
<option  value= "9" >9</option>
<option  value= "10" >10</option>
<option  value= "11" >11</option>
<option  value= "12" >12</option>
<option  value= "13" >13</option>
<option  value= "14" >14</option>
<option  value= "15" >15</option>
<option  value= "16" >16</option>
<option  value= "17" >17</option>
<option  value= "18" >18</option>
<option  value= "19" >18</option>
<option  value= "20" >20</option>
<option  value= "20+" >Over 20</option>
</select></td></tr>

<tr>
<td class = "body">
<b><font color = "#993333">Category</b></font></b>
</td>
</tr>
<tr>
<td>
<select size="1" name="Category" class = 'formbox' style="width: 320px">
<option name = "Category12" value=""> -  </small></option>
<option name = "Category12" value="Experienced Male">Experienced Male(s) <small>(Proven/Tested Fertility)</small></option>
<option name = "Category12" value="Inexperienced Male ">Inexperienced Male(s) <small>(Untested Fertility)</small></option>
<option name = "Category14" value="Experienced Female">Experienced Female(s) <small>(Proven/Tested Fertility)</small></option>
<option name = "Category13" value="Inexperienced Female">Inexperienced Female(s) <small>(Untested Fertility)</small></option>
<option name = "Category15" value="Non-Breeder">Non Breeding Animal(s)</option>
<option name = "Category15" value="Preborn Male">Preborn Male(s)</option>
<option name = "Category15" value="Preborn Female">Preborn Female(s)</option>
<option name = "Category15" value="Preborn Baby">Preborn Baby(s) (Either Gender) / Fertilized Eggs</option>
</select>

</td></tr>
<tr><td class = "body"><b><font color = "#993333">Species</b></font><br />


<%
if rs.state = 0 then
else
rs.close
end if

if len(Preferedspecies) > 0 then 
sql = "select Species from SpeciesAvailable where SpeciesID = " & Preferedspecies & " Order by Species "
rs.Open sql, conn, 3, 3   
if not rs.eof then	
Preferedspeciesname = rs("Species")
end if
rs.close
end if %>

<%
if rs.state = 0 then
else
rs.close
end if

sql = "select * from SpeciesAvailable where SpeciesID = 2  or SpeciesID = 4 or SpeciesID = 5 or SpeciesID = 6 or SpeciesID = 7 or SpeciesID = 8 or speciesid = 9 or SpeciesID = 10 or SpeciesID = 11 or SpeciesID = 12 or SpeciesID = 13 or SpeciesID = 14 or SpeciesID = 15 or SpeciesID = 16 or SpeciesID = 17 or SpeciesID = 19 Order by Species "
'response.write("sql=" & sql)
%>
<select size="1" name="SpeciesID" class = 'formbox' style="width: 320px">
<% if len(Preferedspecies) > 0 then %>
<option  value= "<%=Preferedspecies%>" selected><%=Preferedspeciesname%></option>
<% else %>

<% end if %>
<% 
rs.Open sql, conn, 3, 3   
while not rs.eof	
tempSpeciesID = rs("SpeciesID")
if tempSpeciesID = 3 then
singularterm  = "Working Dog"
else
singularterm  = rs("singularterm")
end if %>
<option  value= "<%=tempSpeciesID%>" ><%=singularterm%></option>
<% rs.movenext
wend
rs.close
%>
</select>
</td></tr>
<tr><td align = 'center' colspan = 2>
<br>
<input type=submit value = "Submit" class="regsubmit2" >
</Form>
<br><br>
Select the <a href ="membersAccountContactsEdit.asp?screenwidth=<%=screenwidth %>" class = "body">Account Info</a> Tab to set your primary, default, species.
<br>
</td></tr></table>
<br>
</td></tr>
<tr>
<td colspan = 5><br />
</td>
</tr>
<tr><td class = "body" colspan = "6"><div align = "center"><a href = "MembersAnimalAdd1.asp" class = "body"><b>Add Animals</b></a>&nbsp;|<a href = "membersEditAnimal.asp" class = "body"> <b>Edit Animals</b></a>&nbsp;|  <a href = "membersdeleteAnimal.asp" class = "body"><b>Delete Animals</b></a>&nbsp;|
&nbsp;<a href = "membersAnimalsStats.asp" class = "body"><b>Statistics</b></a></div><br></td></tr>


<% sql = "select distinct animals.ID, animals.speciesID, FullName, PublishForSale, PublishStud, ShowOnOurHerdPage, Lastupdated from Animals  where PeopleID = " & Session("PeopleID") & " order by SpeciesID, FullName"
'response.write("sql=" & sql)
'sql = "select distinct Animals.ID, animals.speciesID, Animals.FullName, Animals.Category from Animals, pricing where Animals.ID = Pricing.ID aND PeopleID = " & session("PeopleID") & " order by Fullname"
rs.Open sql, conn, 3, 3   
rowcount = 1

Recordcount = rs.RecordCount +1
%>
<% if rs.eof Then %>
<tr><td class = "body" align = "left">Currently you do not have any aniamls listed. To add animals please us the <a href = "MembersAnimalAdd1.asp" class = "body"><b>Add An Animal Wizard.</b></a>
</td></tr>
<% Else %>
<tr bgcolor = "#e6e6e6">
<td class = "body2" align = "center" ><b>Name</b></td>
<td class = "body2" align = "center" width= "80" ><b>Published</b></td>
<td class = "body2" align = "center" width= "120" ><b>Published<br />Stud</b></td>
<td class = "body2" align = "center" width= "80" ><b>Species</b></td>
</tr>
<% End If 
row = "odd"
While  Not rs.eof  
SpeciesName = ""
SpeciesID(rowcount) = rs("SpeciesID")
PublishForSale(rowcount)= rs("PublishForSale")
PublishStud(rowcount)= rs("PublishStud")
Lastupdated(rowcount) = rs("Lastupdated")
if SpeciesID(rowcount) = 2 then
SpeciesName="Alpaca" 
end if 
if SpeciesID(rowcount) = 3 then
SpeciesName="Dog"
end if 
if SpeciesID(rowcount) = 4 then
SpeciesName="Llama"
end if 
if SpeciesID(rowcount) = 5 then
SpeciesName="Horse"
end if 
if SpeciesID(rowcount) = 6 then
SpeciesName="Goat"
end if 
if SpeciesID(rowcount) = 7 then
SpeciesName="Donkey"
end if 
if SpeciesID(rowcount) = 8 then
SpeciesName="Cattle"
end if 
if SpeciesID(rowcount) = 9 then
SpeciesName="Bison"
end if 
if SpeciesID(rowcount) = 10 then
SpeciesName="Sheep"
end if 
if SpeciesID(rowcount) = 11 then
SpeciesName="Rabbit"
end if 
if SpeciesID(rowcount) = 12 then
SpeciesName="Pig"
end if 
if SpeciesID(rowcount) = 13 then
SpeciesName="Chicken"
end if 
if SpeciesID(rowcount) = 14 then
SpeciesName="Turkey"
end if 
if SpeciesID(rowcount) = 15 then
SpeciesName="Duck"
end if 
if  SpeciesID(rowcount) = 16 then
SpeciesName="Cat"
end if 
ID(rowcount) =   rs("ID")
Name(rowcount) =   rs("FullName")

str1 = Name(rowcount)
str2 = "''"
If InStr(str1,str2) > 0 Then
Name(rowcount)= Replace(str1, "''", "'")
End If


If row = "even" Then 
row = "odd" %>
<tr bgcolor = "#e6e6e6">
<% Else 
 row = "even"%>
<tr>
<%	End If %>
<td  class = "body"  height = "20" align = "left" colspan = 5><a href = "membersEditAnimal.asp?ID=<%= ID( rowcount)%>#Top" class = "body"><%= Name(rowcount)%></a>

</td></tr>

<% If row = "odd" Then  %>
<tr bgcolor = "#e6e6e6">
<% Else %>
<tr>
<%	End If %>
<td></td>
<td class = "body2" align = "center">
<% if PublishForSale(rowcount) = 1 then %>
&starf;
<% end if %>
</td>
<td class = "body2" align = "center">
<% if PublishStud(rowcount) = 1 then %>
&starf;
<% end if %>
</td>
<td class = "body2" align = "center">
<small><% =SpeciesName %></small>
</td>
</tr>
<% rowcount = rowcount + 1
rs.movenext
Wend
TotalCount=rowcount 
rs.close

%>

<tr><td height= 10></td></tr>
</table>
<% end if %>



 <table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%"><tr><td class = "roundedtopandbottom" align = "left">
<H2><div align = "left">My Ranch Pages</div></H2>
<a href = "MemberssiteDesign.asp" class = "body">Farm Pages Design (colors, fonts, ect.)</a><br />
<a href = "membersRanchhomeMembers.asp?PeopleID=<%=PeopleID %>" class = "body">Home Page</a><br />
<a href = "membersPageData2.asp?pagename=About Us&PeopleID=<%=PeopleID %>" class = "body">About Us Page</a><br />
</td></tr></table>
<br />
<% showpackages = false
if showpackages = true then %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "445"><tr><td class = "body roundedtopandbottom" align = "left">
		<H2><div align = "left">Packages</div></H2>
<%  
   Set rs = Server.CreateObject("ADODB.Recordset")
sql = "select Count(PackageID) as count from Package where PeopleID =  " & session("PeopleID") & ""
    rs.Open sql, conn, 3, 3  
    Recordcount = clng(rs("count"))
  rs.close  
    
if SubscriptionLevel < 4 and Recordcount = 0 then %>
<b>Your account does not include packages. Please <a href = "MembersRenewSubscription.asp?peopleID=<%=peopleID %>" class = "body"><b>click here</b></a> to upgrade your account.</b>

<% else %>




	<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding="0" cellspacing="0" width = "100%">
	<tr><td class = "body" colspan = "3"><div align = "center"><a href = "membersPackagesAdd.asp" class = "body"><b>Add a Package</b></a>&nbsp;| &nbsp;<a href = "membersPackagesDelete.asp" class = "body"><b>Delete Packages</b></a>&nbsp;| &nbsp;<a href = "membersPackageStats.asp" class = "body"><b>Statistics</b></a></div>
	<br />
	</td></tr>
<%

 sql = "select * from Package where PeopleID =  " & session("PeopleID") & ""

'response.write (sql)
 
    rs.Open sql, conn, 3, 3   
	rowcount = 1
	
if rs.eof  then%>
<tr>
   <td class = "body" align = "left"><b>Currently you do not have any packages. To create a package please <a href= "memberspackagesadd.asp" class = "body"><b>click here</b></a>.
	</td>
</tr>
<% else %>
<tr>
		<td class = "body" align = "center" width = "265"><b>Name</b></td>
		<td class = "body" align = "center" width = "100"><b>Price</b></td>
		<td class = "body" width = "100" align = "center"><b>Options</b></td>
 </tr>
<%
even = True
rowcount = 1
 While  Not rs.eof     
	 PackageID(rowcount) =   rs("PackageID")
	 PackageName(rowcount) =   rs("PackageName")
	 PackagePrice(rowcount) =   rs("PackagePrice")
	  Value(rowcount) =   rs("PackageValue")
	 Description(rowcount) =   rs("Description")

If even = True then
	even = False
Else
	even = True
End If 

If even = True then
%>
   <tr>
<% Else %>
<tr>
<% End If %>
	
		<td class = "body"  align = "left">
		<b><a href = "membersAddaPackageStep4.asp?PackageID=<%= PackageID(rowcount)%>" class = "body"><%= PackageName(rowcount)%></a></b> 
		</td>
		<td class = "body"  align = "right" >
		<% if len(PackagePrice(rowcount)) > 1 Then %>
			<%= formatcurrency(PackagePrice(rowcount), 2) %>
		<% Else %>
		Not Assigned
		<% end if %>

		</td>
		<td  align = "right">
	<a href = "membersAddaPackageStep4.asp?PackageID=<%= PackageID(rowcount)  %>" class = "body"><img src= "images/edit.gif" alt = "edit" height ="18" border = "0"></a> |
<a href = "membersEditPackageLayout2.asp?PackageID=<%= PackageID(rowcount)  %>" class = "body"><img src= "images/Layout.gif" alt = "edit" height ="18" border = "0"></a>

		</td>
		</tr>
		
<%
		rowcount = rowcount + 1
	   rs.movenext
	Wend
TotalCount=rowcount 

 end if%>
<tr><td>

</td></tr>
</table>
<% end if %>
</td></tr>
</table>
<br />
<% end if %>



<% if not SubscriptionLevel= 18 then %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%"><tr><td class = "roundedtopandbottom" align = "left">
		<H2><div align = "left">My Products</div></H2>
	<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding="0" cellspacing="0" width = "100%">
	<tr><td class = "body" colspan = "3"><div align = "center"><a href = "MembersClassifiedAdPlace.asp" class = "body"><b>Add a Product</b></a>&nbsp;| &nbsp;<a href = "membersDeleteListing.asp" class = "body"><b>Delete Products</b></a>&nbsp;| &nbsp;<a href = "membersProductStats.asp" class = "body"><b>Statistics</b></a></div>
	<br />
	</td></tr>
<%  
sql = "select * from sfProducts where PeopleID = " & session("PeopleID") & " order by Prodname"
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3 
    if not rs.eof then  
	rowcount = 1
%><br>
<table width = "100%"   border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
<% row = "odd"
While  Not rs.eof  
If row = "even" Then
row = "odd"
Else
row = "even"
End if
prodID(rowcount) =   rs("prodID")
prodName(rowcount) =   rs("prodName")
prodPrice(rowcount) =   rs("prodPrice")
ProdForSale(rowcount) =   rs("ProdForSale")
ProdQuantityAvailable(rowcount)  =   rs("ProdQuantityAvailable")
catID(rowcount) =   rs("prodCategoryId")
if len(catID(rowcount)) > 0 then
sql2 = "select catname from  SfCategories where CatId = " & catID(rowcount) 
    Set rs2 = Server.CreateObject("ADODB.Recordset")
    rs2.Open sql2, conn, 3, 3 
    if not rs2.eof then  
    	catName(rowcount) =   rs2("catName")
    else
        catName(rowcount) = 0
    end if 
    rs2.close
end if
showstats = True
 If row = "even" Then %>
<tr>
<% Else %>
<tr bgcolor = "#F7E4D9" >
<%	End If %>
</td>
<td class = "body" width = "100%" align = "left">
<a href = "MembersAdEdit2.asp?prodID=<%= prodID( rowcount)%>#BasicFacts" class = "body"><small><%= prodName( rowcount)%></small></a>
</td>
</tr>
<tr>
<td class = "body2" align = "center" >
<small>QTY:<%=ProdQuantityAvailable(rowcount) %>&nbsp;

<% if ProdForSale(rowcount)  = 1 then%>For Sale<%else %>Not For Sale<% end if %>
Price:
<% if len(prodPrice(rowcount)) > 0 then%>
<%=  formatcurrency(prodPrice(rowcount)) %>
<% else %>    
Not Set
<% end if %></small>
<a href = "MembersAdEdit2.asp?prodID=<%= prodID( rowcount)%>#BasicFacts" class = "body">&nbsp;&nbsp;<img src= "images/edit.gif" alt = "edit" height ="12" border = "0"></a>|&nbsp;<a href = "membersProductsUploadPhotos.asp?prodID=<%=prodid( rowcount)%>" class = "body"><img src= "images/Photo.gif" alt = "edit" height ="14" border = "0"></a><br>
</td></tr>
<% 
rowcount = rowcount + 1
	   rs.movenext

	Wend
TotalCount=rowcount 
	rs.close
  set rs=nothing
end if
 %>
 </table>
</td></tr></table>
		<br />

<% showproperties = false
if showproperties = True then %>

<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%"><tr><td class = "body roundedtopandbottom" align = "left">
		<H2><div align = "left">Properties</div></H2>

<% if SubscriptionLevel < 4 then %>
<b>Your account does not include property listings. Please <a href = "MembersRenewSubscription.asp?peopleID=<%=peopleID %>" class = "body"><b>click here</b></a> to upgrade your account.</b>

<% else %>

	<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding="0" cellspacing="0" width = "100%">
	<tr><td class = "body" colspan = "3"><div align = "center"><a href = "membersAddaProperty.asp" class = "body"><b>Add a Property</b></a>&nbsp;|&nbsp;<a href = "membersDeleteProperty.asp" class = "body"><b>Delete Properties</b></a></div>
	<br />
	</td></tr>
<%  
sql = "select * from Properties where PeopleID = " & session("PeopleID") & " order by propname"
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3 
if not rs.eof then  
rowcount = 1
%><br>
<table width = "100%"   border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
<tr>
<td class = "body" align = "center" ><b>Property</b></td>
<td class = "body" align = "center" width = "50" ><b>For Sale</b></td>
<td class = "body" align = "center"width = "29" ><b>Price </b></td>
<td class = "body" align = "center" ><b>Options</b></td>
</tr>
<% row = "odd"
While  Not rs.eof  
If row = "even" Then
row = "odd"
Else
row = "even"
End if
propID(rowcount) =   rs("propID")
propName(rowcount) =   rs("propName")
propPrice(rowcount) =   rs("propPrice")
PropForSale(rowcount) =   rs("PropForSale")
showstats = True
 If row = "even" Then %>
<tr>
<% Else %>
<tr bgcolor = "#F7E4D9" >
<%	End If %>
</td>
<td class = "body" width = "100%" align = "left">
<a href = "membersEditProperty0.asp?prodID=<%= propID( rowcount)%>#BasicFacts" class = "body"><%= propName( rowcount)%></a>
</td>
<td class = "body" align = "center" >
<%=PropForSale(rowcount) %>
</td>
<td class = "body" width = "29" align = "right">
<% if len(propPrice(rowcount)) > 0 then%>
<%=  formatcurrency(propPrice(rowcount)) %>
<% else %>    
$0
<% end if %>
</td>
<td class = "body" align = "center" ><a href = "membersEditProperty0.asp?prodID=<%= prodID( rowcount)%>#BasicFacts" class = "body">&nbsp;&nbsp;<img src= "images/edit.gif" alt = "edit" height ="12" border = "0"></a>|&nbsp;<a href = "membersPropertyPhotos.asp?prodID=<%=prodid( rowcount)%>" class = "body"><img src= "images/Photo.gif" alt = "edit" height ="14" border = "0"></a><br>
		</td>
		</tr>
<% 

		rowcount = rowcount + 1
	   rs.movenext

	Wend
TotalCount=rowcount 
	rs.close
  set rs=nothing
end if
 %>

</table>
	<% end if %>
	
<tr><td></td></tr>
</table>
<% end if %>



</td></tr></table>
<% end if %>
<% end if %>
</td>
</tr>
</table>

<!--#Include file="MembersFooter.asp"--> 
</body></html>