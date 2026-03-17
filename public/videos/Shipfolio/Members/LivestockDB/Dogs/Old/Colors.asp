<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!--#Include virtual="/GlobalVariables.asp"-->
<% 
speciesID = request.querystring("speciesID")
ColorSort = request.querystring("ColorSort")
if speciesID > 0 then
else
response.redirect("/default.asp")
end if
if len(ColorSort)  > 0 then
else
response.redirect("ColorsHome.asp")
end if
Set rs2 = Server.CreateObject("ADODB.Recordset")
sql2 = "select * from SpeciesAvailable where SpeciesID =" & SpeciesID 
rs2.Open sql2, conn, 3, 3
if not rs2.eof then 
SpeciesName = rs2("SingularTerm") 
SpeciesNamePlural = rs2("PluralTerm") 
end if
rs2.close

%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<title> <%= trim(ColorSort) %>&nbsp;<%=SpeciesNamePlural  %></title>
<meta name="Title" content=" <%= trim(ColorSort ) %>&nbsp;<%=SpeciesNamePlural  %>"/>
<meta name="Description" content="<%= trim(Colorsort)%>&nbsp;<%=SpeciesNamePlural  %> for sale at Livestock of America - Livestock Classifieds."> 
<meta name="robots" content="follow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="Googlebot" content="follow"/>
<meta name="author" content="The Andresen Group"/>
<link rel="stylesheet" type="text/css" href="/style.css" />
</HEAD>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center">
<!--#Include file="AnimalsVariablesInclude.asp"-->
<% Current = "Animals" 
Current3 = "ColorSearch" %>
<!--#Include virtual="/Header.asp"-->
<!--#Include virtual="/AnimalsHeader.asp"-->
<!--#Include file="AnimalTabsInclude.asp"-->
<% If not rs.State = adStateClosed Then
  rs.close
End If %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center"  width = "<%=screenwidth %>"><tr><td  align = "left" valign = "top" width = "<%=screenwidth - 300 %>" height = "540" valign = "top" class = "roundedtopandbottom">
<h1><img src= "<%=BreedIcon %>" border = "0"  alt = "<%= trim(ColorSort) %>&nbsp;<%=SpeciesNamePlural  %>"  width = "40"/><%= trim(ColorSort) %>&nbsp;<%=SpeciesNamePlural  %></h1>
      
<%
dim layout
datafound = False
target = request.querystring("target")
if len(Target) > 0 then
datafound = True
end if
layout = request.querystring("layout")
if len(layout) > 0 then
datafound = True
end if
if len(layout) > 0 then 
else
layount=1 
end if
Sortby = request.form("Sortby")
Orderby = request.form("Orderby") 
if len(Orderby) > 0 then
else
Orderby= " Price DESC"
end if

%>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth - 300 %>" ><tr><td  align = "left">
<br /><H2><div align = "left"><%=PageName %>  Search</div></H2>
<% 
Category = request.form("Category")
if len(Category) > 3 then
datafound = True
Categorysearch = " and Category = '" & Category & "' "
else
Categorysearch = ""
end if 
BreedSort = request.form("BreedSort")

if len(BreedSort) > 0 and not BreedSort = "Any" then
datafound = True
Breedsearch = " and BreedID = " & BreedSort & " "
else
Breedsearch = ""
end if 
if len(ColorSort) > 3 then 
else
ColorSort = request.form("ColorSort")
end if
if len(ColorSort) > 3 then
datafound = True
Colorsearch = " and  (Color1 = '" & ColorSort & "' or Color2 = '" & ColorSort & "' or Color3 = '" & ColorSort & "' or Color4 = '" & ColorSort & "' or Color5 = '" & ColorSort & "') "
else
Colorsearch = ""
end if 
OBO = request.form("OBO")
if OBO= "Yes" then
datafound = True
OBOSearch = " and OBO=Yes "
else
OBOSearch = ""
end if 
Registration= request.form("Registration")
if Registration= "Yes" then
datafound = True
RegistrationSearch = " and OBO=Yes "
else
RegistrationSearch = ""
end if 
currentmaxprice= request.form("currentmaxprice")
if len(currentmaxprice) > 0 then
datafound = True
currentmaxpriceSearch = " and Price <  " & currentmaxprice & " "
else
 currentmaxpriceSearch = ""
end if 
currentminprice= request.form("currentminprice")
if len(currentminprice) > 0 then
if currentminprice > 0 then
datafound = True
currentminpriceSearch = " and Price >  " & currentminprice & " "
else
currentminpriceSearch = ""
end if 
else
currentminpriceSearch = ""
end if 
AddressState = request.form("AddressState")
MinAge = request.Form("MinAge")
If Len(MinAge) > 0 Then
datafound = True
Session("MinAge") = MinAge
Else
MinAge= Session("MinAge") 
End If 
MaxAge = request.Form("MaxAge")
If Len(MaxAge) > 0 Then
datafound = True
Session("MaxAge") =MaxAge
Else
MaxAge= Session("MaxAge") 
End If 
If Len(MinAge) >  0 and not MinAge = "Any" Then
datafound = True
QMinAge =  MinAge *12  
Else
QMinAge = 0
End If 
QMinAge = ""
If Len(MinAge) >  0 and not MinAge = "Any" Then
datafound = True
QMinAge =  " and datemonths >  " &  MinAge *12  & " "
End If 
If Len(MaxAge) >  0  and not MaxAge = "Any"Then
datafound = True
QMaxAge =  MaxAge *12  
Else
QMaxAge = 10000
End If 
Ancestry = request.Form("Ancestry")
QAncestry = ""
If Ancestry = "Partial Peruvian" Then
datafound = True
QAncestry = " and len(Percentperuvian) > 1 "
End If 
If Ancestry = "Full Peruvian" Then
datafound = True
QAncestry = " and (Percentperuvian = 'Full Peruvian' or Percentperuvian = 'FullPeruvian') "
End If 
If Ancestry = "Partial Chilean" Then
datafound = True
QAncestry = " and len(PercentChilean) > 1 "
End If 
If Ancestry = "Full Chilean" Then
datafound = True
QAncestry = " and (PercentChilean = 'Full Chilean' or PercentChilean = 'FullChilean')"
End If 
If Ancestry = "Partial Bolivian" Then
QAncestry = " and len(PercentBolivian) > 1 "
End If 
If Ancestry = "Full Bolivian" Then
datafound = True
QAncestry = " and (PercentBolivian = 'Full Bolivian' or PercentBolivian = 'Full Bolivian') "
End If 
Percentaccoyo = request.Form("Percentaccoyo")
QPercentAccoyo = ""
If PercentAccoyo = "0" Then
QPercentAccoyo = " and ( Percentaccoyo = '0' or len(Percentaccoyo) <1 ) "
End If 
If PercentAccoyo = "1/8" Then
datafound = True
QPercentAccoyo = " and ( len(Percentaccoyo) <2 ) "
End If 
If PercentAccoyo = "1/4" Then
datafound = True
QPercentAccoyo = " and ( Percentaccoyo ='1/4' or Percentaccoyo ='3/8' or Percentaccoyo ='1/2' or Percentaccoyo ='5/8'  or Percentaccoyo ='3/4' or Percentaccoyo ='7/8' or Percentaccoyo ='FullAccoyo') "
End If 
If PercentAccoyo = "3/8" Then
datafound = True
QPercentAccoyo = " and ( Percentaccoyo ='3/8' or Percentaccoyo ='1/2' or Percentaccoyo ='5/8'  or Percentaccoyo ='3/4' or Percentaccoyo ='7/8' or Percentaccoyo ='FullAccoyo') "
End If 	
If PercentAccoyo = "1/2" Then
datafound = True
QPercentAccoyo = " and ( Percentaccoyo ='1/2' or Percentaccoyo ='5/8'  or Percentaccoyo ='3/4' or Percentaccoyo ='7/8' or Percentaccoyo ='FullAccoyo') "
End If 	
If PercentAccoyo = "5/8" Then
datafound = True
QPercentAccoyo = " and ( Percentaccoyo ='5/8'  or Percentaccoyo ='3/4' or Percentaccoyo ='7/8' or Percentaccoyo ='FullAccoyo') "
End If 	
If PercentAccoyo = "3/4" Then
QPercentAccoyo = " and ( Percentaccoyo ='3/4' or Percentaccoyo ='7/8' or Percentaccoyo ='FullAccoyo') "
End If 	
If PercentAccoyo = "7/8" Then
datafound = True
QPercentAccoyo = " and ( Percentaccoyo ='7/8' or Percentaccoyo ='FullAccoyo') "
End If 
If PercentAccoyo = "FullAccoyo" Then
datafound = True
QPercentAccoyo = " and ( Percentaccoyo ='FullAccoyo') "
End If 
Category = request.Form("Category")
if len(Category) > 3 then
datafound = True
if Category = "Experienced Male" then
CategorySearch = " and (Category = 'Experienced Male' or Category = 'Herdsire' or 'Proven Male') "
end if
if Category = "Inexperienced Male" then
CategorySearch = " and (Category = 'Inexperienced Male' or Category = 'Jr.Herdsire') "
end if
if Category = "Experienced Female" then
CategorySearch = " and (Category = 'Experienced Female' or Category = 'Dam') "
end if
if Category = "Inexperienced Female" then
CategorySearch = " and (Category = 'Inexperienced Female' or Category = 'Maiden') "
end if
if Category = "Non-Breeder" then
CategorySearch = " and (Category = 'Non-Breeder' or Category = 'NonBreeder') "
end if
else
CategorySearch =""
End if
if len(AddressState) > 0 and not(AddressState="Any") then
datafound = True
Statesearch = " and AddressState = '" & AddressState & "' "
else
Statesearch = ""
end if
if datafound = False then
'response.Redirect("Default.asp") 
end if

%>
<!--#Include file="AdvancedSearchInclude2.asp"-->
<% 
'if len(Categorysearch)> 0 or len(Breedsearch)> 0 or len(Colorsearch) > 0 or len(OBOSearch) > 0 or len(currentmaxpriceSearch) > 0 or len(currentminpriceSearch) > 0 or len(QAncestry) > 0 or len(QPercentAccoyo) > 0  or len(CategorySearch)> 0 or len(Statesearch)> 0 then


sql = "SELECT  animals.*, Pricing.*, colors.*, Photos.*, SpeciesBreedLookupTable.Breed FROM Animals, Pricing,  Ancestrypercents, Photos, colors , address, People, SpeciesBreedLookupTable WHERE animals.speciesID = " & speciesID & " and animals.PeopleID = People.PeopleID  and animals.BreedID = SpeciesBreedLookupTable.BreedLookupID and People.AddressID = address.AddressID And pricing.id=Animals.id and Ancestrypercents.id=Animals.id And Photos.id=Animals.id  and Colors.id=Animals.id and sold = false and PublishForSale = True and sold = false " & Categorysearch & Breedsearch & Colorsearch &  OBOSearch & currentmaxpriceSearch & currentminpriceSearch &  QAncestry & QPercentAccoyo & CategorySearch & Statesearch & " order by " & Sortby &  " " & Orderby
'response.Write("sql=" & sql)


Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
if rs.eof then %>
<H1><div align = "left"><%=  SaleCategory %></div></H1>
<blockquote>There currently are no <%=PageName %> that fit that criteria. Please try a different search.</blockquote>
<br><br>
<%else%>
<% DOB = rs("DobMonth") & "/" & rs("DOBDay") & "/" & rs("Dobyear")
if len(DOB) > 5 then
datemonths = DateDiff("m", DOB, Now())
else
datemonths = 0
end if
showlayouts = False
if showlayouts = True then%>	
        <table border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "right" valign = "top">
<tr><td class = "body"></td>
<td></td>
<td><form name="layoutform2" action="SearchLivestockforSale.asp?layout=2&target=<%=Target %>&CurrentPeopleID=<%=CurrentPeopleID %>" method="POST">
<input type="image" src="/images/PageLayout2.jpg" name="image" width="35" height="28" alt = "Gallery"></td>
</form>
<form name="layoutform3" action="SearchLivestockforSale.asp?layout=3&target=<%=Target %>&CurrentPeopleID=<%=CurrentPeopleID %>" method="POST"><td>
<input type="image" src="/images/PageLayout3.jpg" name="image" width="35" height="28" alt = "List"></td>
<td width = "5">
</td></tr></table>
</form>
<INPUT TYPE="image" SRC="images/px.gif" HEIGHT="1" WIDTH="1" BORDER="0" ALT="Submit Form">
<% end if %>
<% if len(layout) < 1 then layount=1 %>
<% DetailType = "Dam" 
if len(trim(layout)) >0 then
else
layout=3 
end if
If layout = 1  then %>
<!--#Include file="ListDetailInclude.asp"--> 
<% end if %>
<% If layout = 2 then %>
<!--#Include file="DetailInclude2.asp"--> 
<% end if %>
<% If layout = 3  or len(layout) < 1 then %>
<!--#Include file="DetailInclude3.asp"--> 
<% end if %>
<% end if%>
</td></tr></table>
</td>
<td valign = "top" width = "300" class = " body roundedtopandbottom">
<center><a href = "/advertising.asp" class = "body2" align = "center">Advertise Here</a></center><br>
<%  Query =  "Select AdID, AdImage, AdLink from Ads  where AdType='Search' and AdMonth = '" & month(now) & "' and adYear='" & year(now)& "' and speciesID = 2 ORDER BY rand() limit 6"
if rs.state = 0 then
else
rs.close
end if
rs.Open Query, conn, 3, 3
x = 0


while not rs.eof and x < 8
 x = x + 1
AdID = rs("AdID")
AdImage  = rs("AdImage") 
AdLink = rs("AdLink")
Link1=""
Link2 = ""
if len(AdLink) > 3 then
Link1=  AdLink
Link2= "http://" & AdLink
else
 Link2 = "/Ranches/RanchHome.asp?CurrentPeopleID=" & PeopleID
end if %>
<% If Len(AdImage) > 1 and Len(AdImage) < 131 then%>
<% If Len(Link2) > 1  then%>
<center> <a href = "<%=Link2 %>" target = "blank">
 <% end if %>
<img src = "<%= AdImage%>" width ="200" height = "200" border = "0">
<% If Len(Link2) > 1  then%>
 <a></center>
 <% end if %>
<% End If %>

<% rs.movenext
wend
 %>
<br>

<%
if rs.state = 0 then
else
rs.close
end if
OldCurrentID = 0
sql = "Select animals.ID, People.PeopleID, Photo1, category, FullName, Pricing.Price, Pricing.SalePrice, Pricing.Studfee, SpeciesBreedLookupTable.Breed, Color1, Color2, Color3, Color4, Color5  from animals, people, Photos, SpeciesBreedLookupTable, pricing, Colors  where animals.speciesID = " & speciesID & " and pricing.ID = animals.ID and colors.ID = animals.ID  and photos.ID = animals.ID  and animals.BreedID = SpeciesBreedLookupTable.BreedLookupID and length(Photo1) > 4 and animals.peopleID = People.peopleID and People.Subscriptionlevel = 4   and animals.peopleID = People.peopleID And pricing.id=Animals.id and People.AccessLevel  > 0 and People.AIPublish = True and PublishForSale = true and (Color1 = '" & ColorSort & "' or Color2 = '" & ColorSort & "' or Color3 = '" & ColorSort & "' or Color4 = '" & ColorSort & "' or Color5 = '" & ColorSort & "') ORDER BY rand() limit 10;"
rs.Open sql, conn, 3, 3   
while not rs.eof 
animalID = rs("ID")
NewCurrentID = animalID
if NewCurrentID  = OldCurrentID then
rs.movenext
end if

if not rs.eof then

OldCurrentID = animalID

TempPeopleID = rs("PeopleID")
color1 = rs("Color1")
color2= rs("Color2")
color3 = rs("Color3")
color4 = rs("Color4")
color5 = rs("Color5")
Photo1 = rs("Photo1")
FullName = rs("FullName")
Breed = rs("Breed")
Price= rs("Price")
SalePrice= rs("salePrice")
StudFee= rs("StudFee")
category = rs("category")
link = "/Ranches/Details.asp?ID=" & animalID & "&CurrentPeopleID=" & TempPeopleID
%>
<table cellspacing = 0 cellpadding = 0>
<% if even = true then %>
<tr>
<% else %>
<tr bgcolor = "#dfdfdf">
<% end if %>
<td colspan = "2">
<small><a href="<%=link%>" class = "body"><b><%=FullName %></b></a></small>
</td></tr>
<% if even = true then 
even = false %>
<tr>
<% else 
even = true %>
<tr bgcolor = "#dfdfdf">
<% end if %>
<td class = "body" valign = "top" width = "249">
<small><%=Breed %><br>
<% If Len(color1) > 1 or Len(color2) > 1 or Len(color3) > 1 or Len(color4) > 1 Then %>
<% If Len(color1) > 1 Then %>
<%=Color1%><% end if %>
<% If Len(color2) > 1 Then %> / <%=Color2%>
<% end if %>
<% If Len(color3) > 1 Then %>
/ <%=Color3%>
<% end if %>
<% If Len(color4) > 1 Then %>
/ <%=Color4%>
<% end if %>
<% If Len(color5) > 1 Then %>
/ <%=Color5%>
 <% end if %>	
 <br /><% end if %>
<%=category %><br>

<% if len(Price) > 1 then %>
Price: <%=formatcurrency(Price,2)%><br />
<% else %>
Call For Price<br />
<% end if %>
<% if len(SalePrice) > 1 then %>
Sale Price: <%=formatcurrency(SalePrice,2)%><br />
<% end if %>
<% if len(StudFee) > 1 then %>
Stud Fee: <%=formatcurrency(StudFee,2)%><br />
<% end if %>
<a href="<%=link%>" class = "body">Learn More</a><br /><br />
</small>
</td>
<td width = 101>
<a href="<%=link%>"><img src = "<%=Photo1%>" width = "100" border = "0" /></a>
</td>
</tr></table>
<% 
end if
if not rs.eof then
rs.movenext
end if
wend %>
<center><a href = "/advertising.asp" class = "body2" align = "center">Advertise Here</a></center><br>
</td></tr></table>



<br /><br /></td>

</tr></table>

<!--#Include virtual="/Footer.asp"-->
</body>
</html>