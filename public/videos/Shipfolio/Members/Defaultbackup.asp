<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="John Andresen">
    <meta name="generator" content="LOTW">
    <title>Livestock Of The World</title>
<!--#Include file="MembersGlobalVariables.asp"-->


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

<% 
Current1 = "MembersHome"
Current2="MembersHome" %> 
<!--#Include file="MembersHeader.asp"-->
<% If not rs.State = adStateClosed Then
rs.close
End If   	
%>

<div class = row>
   <div class="col-12 body">
<H1>Dashboard Home</h1>
</div>
</div>

<% 
FirstTime = request.querystring("FirstTime")
if FirstTime = "True" then %>

<div class = row>
   <div class="col-12 body">
<h1>Welcome to <%=Sitenamelong %>!</h1>
 To get start we recommend that you visit some of the following pages in the Member Dashboard:
<ul>
<li><a href = "membersAccountContactsEdit.asp?screenwidth=<%=screenwidth %>" class = "body"><b>Your Account</b></a> - take a moment and make sure that your information is complete.</li>
<li><a href = "MemberssiteDesign.asp?screenwidth=<%=screenwidth %>" class = "body"><b>Ranch Profile</b></a> - customize your farm pages (define colors & fonts, upload graphics, enter text about your business.)</li>
<%if not Subscriptionlevel=5 then %>
<li><a href = "MembersAnimalAdd1.asp?screenwidth=<%=screenwidth %>" class = "body"><b>Add Animals</b></a> - use our easy Add a New Animal pages to start entering your Animals.</li>
<% end if %>
<li><a href = "membersServicesAddPage0.asp?screenwidth=<%=screenwidth %>" class = "body"><b>Add Services</b></a> - enter your Services that you offer.</li>

<li><a href = "membersPlaceClassifiedAd0.asp?screenwidth=<%=screenwidth %>" class = "body"><b>Add Products</b></a> - enter your products for sale.</li>

</ul>
<br />

<% session("FirstTime") = false %>

<% end if %>
<%showad = False
if showad = true then%>
<a href ="https://www.livestockofamerica.com/Membersistration/MembersRenewSubscription.asp?PeopleID=<%=PeopleID %>"><img src = "PlatinumMembersad.jpg" border = "0" width = "100%"  Alt = "Renew Today"/></a>
<% end if %>

   </div>
</div>


<div class = row>
   <div class="col-6 body">
        <H2>Account</H2>
        <% if subscriptionlevel = 0 then %>
            <h2><center>Your Account Is Not Active</center></h2>
            Your animals and products will not show up unless your account is active.<br /><br />
            <center><a href = "MembersRenewSubscription.asp?PeopleID=<%=peopleID %>" class = "regsubmit2"><b>Renew Your Membership</b></a></center>
        <% end if %>

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
Membership Level:
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

Membership Ends: 
<% if Noenddate = True then %>
Not Set
<% else %>
<%=custAIEndService  %>
<% end if %>

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


<% if SubscriptionLevel= 0 then %>
<center><a href = "MembersRenewSubscription.asp?PeopleID=<%=peopleID %>" class = "regsubmit2"><b>Renew Your Membership</b></a></center><br /><br />
<% else %>
<center><a href = "MembersRenewSubscription.asp?PeopleID=<%=peopleID %>" class = "regsubmit2"><b>Renew or Upgrade Your Membership</b></a></center><br /><br />
<% end if %>
    </div>




     <div class="col-6 body">

     <H2><div align = "left">Ranch Profile</div></H2>
<a href = "MemberssiteDesign.asp" class = "body">Farm Pages Design (colors, fonts, ect.)</a><br />
<a href = "membersRanchhomeMembers.asp?PeopleID=<%=PeopleID %>" class = "body">Home Page</a><br />
<a href = "membersPageData2.asp?pagename=About Us&PeopleID=<%=PeopleID %>" class = "body">About Us Page</a><br />
</td></tr></table>
<br />
    <% showpackages = false
    if showpackages = true then %>
		<H2><div align = "left">Packages</div></H2>
        <% Set rs = Server.CreateObject("ADODB.Recordset")
           sql = "select Count(PackageID) as count from Package where PeopleID =  " & session("PeopleID") & ""
           rs.Open sql, conn, 3, 3  
           Recordcount = clng(rs("count"))
            rs.close  
    
        if SubscriptionLevel < 4 and Recordcount = 0 then %>
            <b>Your account does not include packages. Please <a href = "MembersRenewSubscription.asp?peopleID=<%=peopleID %>" class = "body"><b>click here</b></a> to upgrade your account.</b>
        <% else %>
            <div align = "center"><a href = "membersPackagesAdd.asp" class = "body"><b>Add a Package</b></a>&nbsp;|
             &nbsp;<a href = "membersPackagesDelete.asp" class = "body"><b>Delete Packages</b></a>&nbsp;|
              &nbsp;<a href = "membersPackageStats.asp" class = "body"><b>Statistics</b></a></div>
	        <br />
        <% sql = "select * from Package where PeopleID =  " & session("PeopleID") & ""
            rs.Open sql, conn, 3, 3   
	        rowcount = 1
	
        if rs.eof  then%>
                <b>Currently you do not have any packages. To create a package please <a href= "memberspackagesadd.asp" class = "body"><b>click here</b></a>.
        <% else %>
          <b>Name</b>
		<b>Price</b>
		b>Options</b>
        <% even = True
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
                End If %>
	
		<b><a href = "membersAddaPackageStep4.asp?PackageID=<%= PackageID(rowcount)%>"><%= PackageName(rowcount)%></a></b> 
		<% if len(PackagePrice(rowcount)) > 1 Then %>
			<%= formatcurrency(PackagePrice(rowcount), 2) %>
		<% Else %>
		Not Assigned
		<% end if %>

	<a href = "membersAddaPackageStep4.asp?PackageID=<%= PackageID(rowcount)  %>" class = "body"><img src= "images/edit.gif" alt = "edit" height ="18" border = "0"></a> |
<a href = "membersEditPackageLayout2.asp?PackageID=<%= PackageID(rowcount)  %>" class = "body"><img src= "images/Layout.gif" alt = "edit" height ="18" border = "0"></a>

	
<%
		rowcount = rowcount + 1
	   rs.movenext
	Wend
TotalCount=rowcount 

 end if
 end if
 end if%>
     </div>
</div>
<div class ="row">
  <div class = "col-12" align = "center">
  <H2><div align = "left">Animals</div></H2>
  <a href = "MembersAnimalAdd1.asp" class = "body"><b>Add</b></a>&nbsp;|<a href = "membersEditAnimal.asp" class = "body"> <b>Edit</b></a>&nbsp;|  <a href = "membersdeleteAnimal.asp" class = "body"><b>Delete</b></a>&nbsp;|
&nbsp;<a href = "membersAnimalsStats.asp" class = "body"><b>Statistics</b></a>
 </div>
 </div>
<div class ="row">
  <div class = "col-12">

<% sql = "select distinct animals.ID, speciesID, FullName, PublishForSale, PublishStud, ShowOnOurHerdPage, Lastupdated from Animals  where PeopleID = " & Session("PeopleID") & "  order by speciesID, FullName "

'response.write("sql=" & sql)

'sql = "select distinct Animals.ID, animals.speciesID, Animals.FullName, Animals.Category from Animals, pricing where Animals.ID = Pricing.ID aND PeopleID = " & session("PeopleID") & " order by Animals.FullName "


rs.Open sql, conn, 3, 3   
rowcount = 1

Recordcount = rs.RecordCount +1
%>
<% if rs.eof Then %>
Currently you do not have any aniamls listed. To add animals please us the <a href = "MembersAnimalAdd1.asp" class = "body"><b>Add An Animal Link.</b></a>
<% Else %>

<table align= 'center'  width = 100% border = 0 >
<tr bgcolor = "#F7E4D9">
 <td colspan = 1></td>
 <td colspan = 2 class = "body2" align = Center ><b>Published</b></td>
 <td colspan = 2></td>
</tr>
<tr bgcolor = "#F7E4D9">
<td class = "body2" align = "center" width = 120><b>Name</b></td>
<td class = "body2" align = "center" ><b>For Sale</b></td>
<td class = "body2" align = "center" ><b>Stud</b></td>
<td class = "body2" align = "center" ><b>Species</b></td>
<td class = "body2" align = "center" ><b>Options</b></td>
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
<tr bgcolor = "#F7E4D9">
<% Else 
 row = "even"%>
<tr>
<%	End If %>
<td  class = "body"  height = "20" align = "left" ><a href = "membersEditAnimal.asp?ID=<%= ID( rowcount)%>#Top" class = "body"><small><%= Name(rowcount)%></a>
<% if len(Lastupdated(rowcount)) > 0 then %>
<font bgcolor = "#F7E4D9">Updated: <%=formatdatetime(Lastupdated(rowcount), 2) %></font>
<% end if %>
</small>
</td>
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
<td class = "body" align = "right" >
<a href = "membersEditAnimal.asp?ID=<%= ID( rowcount)%>#Top" class = "body"><div align = right><img src= "images/edit.gif" alt = "edit" height ="18" border = "0"></a>|&nbsp;<a href = "/members/MembersPhotos.asp?ID=<%= ID( rowcount)%>" class = "body"><img src= "images/Photo.gif" alt = "edit" height ="18" border = "0"></a>
|&nbsp;<a href = "/members/membersDeleteAnimalhandleform1.asp?ID=<%= ID( rowcount)%>" class = "body"><img src = "images/delete.gif" height = "16"" border = "0" alt = "Delete"></a></div></td></tr>
<% rowcount = rowcount + 1
rs.movenext
Wend
TotalCount=rowcount 
rs.close

%>
</table>

  </div>
</div>
<div class = "row">
  <div class = "col-12">
  
<% if not SubscriptionLevel= 5 then %>
<H2><div align = "left">Products</div></H2>
<div align = "center"><a href = "MembersClassifiedAdPlace0.asp" class = "body"><b>Add</b></a>&nbsp;| &nbsp;<a href = "membersDeleteListing.asp" class = "body"><b>Delete</b></a>&nbsp;| &nbsp;<a href = "membersProductStats.asp" class = "body"><b>Statistics</b></a></div>

		


	<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding="0" cellspacing="0" width = "100%">
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
<a href = "MembersAdEdit2.asp?prodID=<%= prodID( rowcount)%>#BasicFacts" class = "body">&nbsp;&nbsp;<img src= "images/edit.gif" alt = "edit" height ="18" border = "0"></a>|&nbsp;<a href = "membersProductPhotos.asp?prodID=<%=prodid( rowcount)%>" class = "body"><img src= "images/Photo.gif" alt = "edit" height ="18" border = "0"></a>|&nbsp;<a href = "membersDeleteListinghandleform1.asp?ID=<%=prodid( rowcount)%>" class = "body"><img src= "images/delete.gif" alt = "edit" height ="18" border = "0"></a><br>
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
	

<% end if %>
<% end if %>
  
  
  </div>
</div>

<!--#Include file="MembersFooter.asp"--> 
</body></html>