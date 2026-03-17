<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<!--#Include file="MembersGlobalvariables.asp"--> 

<% 
Temperment = Request.Querystring("Temperment")
Name=Request.querystring("Name" ) 
ARI=Request.querystring("ARI" ) 
CLAA=Request.querystring("CLAA" ) 
DOBMonth=Request.querystring( "DOBMonth" ) 
DOBDay=Request.querystring( "DOBDay" ) 
DOBYear=Request.querystring( "DOBYear" ) 
Category=Request.querystring("Category")
Gaited=Request.querystring("Gaited")
Warmblooded=Request.querystring("Warmblooded")
BreedID=Request.querystring("BreedID")
BreedID2=Request.querystring("BreedID2")
BreedID3=Request.querystring("BreedID3")
BreedID4=Request.querystring("BreedID4")
speciesID=Request.querystring("speciesID")
if len(SpeciesID) > 0 then
else
speciesID=Request.Form("speciesID")
end if
Color1=Request.querystring("Color1") 
Color2=Request.querystring("Color2") 
Color3=Request.querystring("Color3") 
Color4=Request.querystring("Color4") 
Color5=Request.querystring("Color5") 
Weight=Request.querystring("Weight") 
Height=Request.querystring("Height") 
PercentUSA=Request.querystring("PercentUSA") 
PercentCanadian=Request.querystring("PercentCanadian") 
PercentPeruvian=Request.querystring("PercentPeruvian") 
PercentChilean=Request.querystring("PercentChilean") 
PercentBolivian=Request.querystring("PercentBolivian") 
PercentUnknownOther=Request.querystring("PercentUnknownOther") 
PercentAccoyo=Request.querystring("PercentAccoyo") 
PercentUSA=Request.querystring("PercentUSA") 
NumberofAnimals = Request.querystring("NumberofAnimals")
%>	
</HEAD>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center">
<% Current2="Animals" %> 
<!--#Include file="MembersHeader.asp"-->
<% If not rs.State = adStateClosed Then
  rs.close
End If   	
Current3="AddAnimal"  %> 
 <!--#Include file="MembersAnimalsTabsInclude.asp"-->
 <table border = "0" cellspacing="0" cellpadding = "0" align = "center"  class = "roundedtopandbottom body">
 <tr><td class = "roundedtopandbottom body" align = "left">

<H1><div align = "left">Add a New Animal Listing</div></H1>
A listing can be for a single animal or for a group of animals.


<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 bordercolor = #000000 width = "<%=screenwidth %>"  align = "left">
 <%
 NumberofAnimals = request.form("NumberofAnimals")
if Numofspecies = 1 then
   AnimalType = SpeciesOne
end if

 if SpeciesID = 2 then
  AnimalType="Alpaca" 
end if 
if SpeciesID = 3 then
  AnimalType="Dog"
end if 
if SpeciesID = 4 then
  AnimalType="Llama"
end if 
if SpeciesID = 5 then
  AnimalType="Horse"
end if 
if SpeciesID = 6 then
  AnimalType="Goat"
end if 
if SpeciesID = 7 then
  AnimalType="Donkey (includes Mules & Hinnies)"
end if 
if SpeciesID = 8 then
  AnimalType="Cattle"
end if 
if SpeciesID = 9 then
  AnimalType="Bison"
end if 
if SpeciesID = 10 then
  AnimalType="Sheep"
end if 
if SpeciesID = 11 then
  AnimalType="Rabbit"
end if 
if SpeciesID = 12 then
  AnimalType="Pig"
end if 
if  SpeciesID = 13 then
 AnimalType="Chicken"
end if 
if SpeciesID = 14 then
  AnimalType="Turkey"
end if 
if SpeciesID = 15 then
  AnimalType="Duck (and other Fowel)"
end if 
if  SpeciesID = 16 then
 AnimalType="Cat"
end if 


if len(SpeciesID) >0 then 

 sql = "select * from SpeciesAvailable where Species=  '" & AnimalType &"'"
 'response.Write("sql=" & sql)
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
if not rs.eof	 then
PreferedSpeciesID= rs("PreferedSpeciesID")
else
PreferedSpeciesID= ""
end if

if len(PreferedSpeciesID) > 0 then
 sql2 = "select Breed from SpeciesBreedLookupTable where BreedLookupID=" & PreferedSpeciesID & " Order by Breed"
 ' response.Write("sql=" & sql)
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3
if not rs2.eof then
    PreferedSpeciesBreed = rs2("Breed")
else
    PreferedSpeciesBreed = 0
end if
rs2.close
end if


Price=Request.Querystring("Price") 
SalePending=Request.Querystring("SalePending") 
Sold=Request.Querystring("Sold") 
StudFee=Request.Querystring("StudFee") 
ForSale=Request.Querystring("ForSale") 
PriceComments=Request.Querystring("PriceComments") 
Description=Request.Querystring("Description") 

Discount=Request.Querystring("Discount") 
ShowOnStudPage=Request.Querystring("ShowOnStudPage") 
OBO=Request.Querystring("OBO") 
PayWhatYouCanAnimal=Request.Querystring("PayWhatYouCanAnimal") 
PayWhatYouCanStud=Request.Querystring("PayWhatYouCanStud") 
EmbryoPrice=Request.Querystring("EmbryoPrice") 
SemenPrice=Request.Querystring("SemenPrice") 
Donor=Request.Querystring("Donor") 
Free=Request.Querystring("Free") 

%>
<tr><td class = "body" align = "left">
<h2><font color = "brown">Step 1: Basic Facts</font> <small>(* = Required Fields)</small></h2>
Please enter the following information for your animal. It's okay if you are missing some information except where required fields are indicated with an asterisk. 
<% Duplicate=Request.QueryString("Duplicate")
if Duplicate then %>
<div align = "left"><br /><b><h2><font color = "maroon">You already have an animal entered with that Name/Title. Please enter another Name/Title.</font></h2></b></div>
<% end if %>
<% MissingName=Request.QueryString("MissingName")
if MissingName then %>
<div align = "left">&nbsp;<b><font color = "maroon">Please enter a Name / Title for your listing. </font></b></div>
<% end if %>
<% MissingCategory=Request.QueryString("MissingCategory")
if MissingCategory then %>
<div align = "left">&nbsp;<b><font color = "maroon">Please select a category.</font></b></div>
<% end if %>
<% MissingBreed=Request.QueryString("MissingBreed")
if  MissingBreed then %>
<div align = "left">&nbsp;<b><font color = "maroon">Please select a breed.</font></b></div>
<% end if %>
</td></tr>
<form  name=form method="post" action="MembersAnimalAdd2B.asp?wizard=True&PeopleID=<%=PeopleID %>">
<input type = "hidden" name = "speciesID" value = "<%=speciesID %>" />
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
<tr><td width = "300"  class = "body" align = "left">	
<% if MissingName then %>
<br />
<a class="tooltip" href="#"><b><font color='maroon'>Name /Title</font></b><span class="custom info"><em>Name /Title</em>This can be a full name like <i>XYZ Ranches Peruvian MagaStud</i> or a title like <i>Registered Brown Boar</i></span></a><b>*</b>
<% else %>
<a class="tooltip" href="#"><b>Name /Title</b><span class="custom info"><em>Name /Title</em>This can be a full name like <i>XYZ Ranches Peruvian MagaStud</i> or a title like <i>Registered Brown Boar</i></span></a><b>*</b>
<% end if %>
<input name="Name" size = "90" value="<%=Name%>">
</td>
</tr>
</table>
<%
 if SpeciesID = 5 then %>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
<tr>
<td width = "100"  class = "body" align = "left">	
<b>Height</b>
</td>
<td width = "100"  class = "body" align = "left">	
<b>Weight</b>
</td>
<td width = "100"  class = "body" align = "left">	
<b>Gaited</b>
</td>
<td width = "100"  class = "body" align = "left">	
<b>Warmblood</b>
</td>
</tr>
<tr>
<td width = "100"  class = "body" align = "left">	
<input name="Height" size = "10" value="<%=Height%>">
</td>
<td width = "100"  class = "body" align = "left">	
<input name="Weight" size = "10" value="<%=Weight%>">
</td>
<td width = "100"  class = "body" align = "left">	
<% If Gaited = "Yes" Or Gaited = True Then %>
Yes<input TYPE="RADIO" name="Gaited" Value = "Yes" checked>
No<input TYPE="RADIO" name="Gaited" Value = "No" >
<% Else %>
Yes<input TYPE="RADIO" name="Gaited" Value = "Yes" >
No<input TYPE="RADIO" name="Gaited" Value = "No" checked>
<% End If %>
</td>
<td width = "100"  class = "body" align = "left">	
<% If Warmblood = "Yes" Or Warmblood = True Then %>
Yes<input TYPE="RADIO" name="Warmblood" Value = "Yes" checked>
No<input TYPE="RADIO" name="Warmblood" Value = "No" >
<% Else %>
Yes<input TYPE="RADIO" name="Warmblood" Value = "Yes" >
No<input TYPE="RADIO" name="Warmblood" Value = "No" checked>
<% End If %>
</td>
</tr>
</table>
<% end if %>
<table border = '0'>
<tr>
<% if NumberofAnimals = "1" then %>
<td class = "body" width = "200" align = "left">
<b>Date of Birth</b>
</td>
<% end if %>
<% if Missingcategory then %>
<td class = "body" width = "300" align = "left" >
<b><font color='maroon'>Category*</font></b>
</td>
<% else %>
<td class = "body" width = "300" align = "left">
<b>Category*</b>
</td>
<% end if %>
<td width = "300"  class = "body" align = "left">	
<b>Species</b>
</td>
<td width = "300"  class = "body" align = "left">	
<b>Temperment <br /><small>(1=Very Calm, 10=Very High-Spirited)</small>
</b>
</td>
</tr>
<tr>
<% if NumberofAnimals = "1" then %>
<td align = "left">
<select size="1" name="DOBMonth">
<option value="<%=DOBMonth%>" selected><%=DOBMonth%></option>
<option value="1">1</option>
<option  value="2">2</option>
<option  value="3">3</option>
<option  value="4">4</option>
<option  value="5">5</option>
<option  value="6">6</option>
<option  value="7">7</option>
<option  value="8">8</option>
<option  value="9">9</option>
<option  value="10">10</option>
<option  value="11">11</option>
<option  value="12">12</option>
</select>
<select size="1" name="DOBDay">
<option value="<%=DOBDay%>" selected><%=DOBDay%></option>
<option value="1">1</option>
<option  value="2">2</option>
<option  value="3">3</option>
<option  value="4">4</option>
<option  value="5">5</option>
<option  value="6">6</option>
<option  value="7">7</option>
<option  value="8">8</option>
<option  value="9">9</option>
<option  value="10">10</option>
<option  value="11">11</option>
<option  value="12">12</option>
<option  value="13">13</option>
<option  value="14">14</option>
<option  value="15">15</option>
<option  value="16">16</option>
<option  value="17">17</option>
<option  value="18">18</option>
<option  value="19">19</option>
<option  value="20">20</option>
<option  value="21">21</option>
<option  value="22">22</option>
<option  value="23">23</option>
<option  value="24">24</option>
<option  value="25">25</option>
<option  value="26">26</option>
<option  value="27">27</option>
<option  value="28">28</option>
<option  value="29">29</option>
<option  value="30">30</option>
<option  value="31">31</option>
</select>
<select size="1" name="DOBYear">
<option value="<%=DOBYear%>" selected><%=DOBYear%></option>
<% currentyear = year(date) 
For yearv=1983 To currentyear %>
<option value="<%=yearv%>"><%=yearv%></option>		
<% Next %></select>
</td>
<% end if %>
<td align = "left">
<%  if NumberofAnimals = "1" then %>
<select size="1" name="Category">
<option name = "Category2" value= "<%=Category%>" selected><%=Category%></option>
<option name = "Category12" value="Experienced Male">Experienced Male <small>(Proven/Tested Fertility)</small></option>
<option name = "Category12" value="Inexperienced Male ">Inexperienced Male <small>(Untested Fertility)</small></option>
<option name = "Category14" value="Experienced Female">Experienced Female <small>(Proven/Tested Fertility)</small></option>
<option name = "Category13" value="Inexperienced Female">Inexperienced Female <small>(Untested Fertility)</small></option>
<option name = "Category15" value="Non-Breeder">Non Breeding Animal</option>
<option name = "Category15" value="Preborn Male">Preborn Male</option>
<option name = "Category15" value="Preborn Female">Preborn Female</option>
<option name = "Category15" value="Preborn Baby">Preborn Baby (Either Gender)</option>
</select>
<% else %>
<select size="1" name="Category">
<option name = "Category2" value= "<%=Category%>" selected><%=Category%></option>
<option name = "Category12" value="Experienced Males">Experienced Males <small>(Proven/Tested Fertility)</small></option>
<option name = "Category12" value="Inexperienced Males">Inexperienced Males <small>(Untested Fertility)</small></option>
<option name = "Category14" value="Experienced Females">Experienced Females<small>(Proven/Tested Fertility)</small></option>
<option name = "Category13" value="Inexperienced Females">Inexperienced Females <small>(Untested Fertility)</small></option>
<option name = "Category13" value="Assortment">Assortment <small>(Variety of Genders and/or Fertility )</small></option>
<option name = "Category15" value="Non-Breeders">Non Breeding Animals</option>
<option name = "Category15" value="Preborn Males">Preborn Males</option>
<option name = "Category15" value="Preborn Females">Preborn Females</option>
<option name = "Category15" value="Preborn Babies">Preborn Babies (Either gender)</option>
</select>
<% end if %>
</td>
<td align = "left" class = "body">
 <b><%=AnimalType%></b>
</td>
<td align = "left" class = "body">
<select size="1" name="Temperment">
<% if len(Temperment) > 0 then %>
<option  value= "<%=Temperment%>" selected><%=Temperment%></option>
<% else %>
<option  value= "" selected> </option>
<% end if %>
<option  value="1">1</option>
<option  value="2">2</option>
<option value="3">3</option>
<option  value="4">4</option>
<option  value="5">5</option>
<option  value="6">6</option>
<option  value="7">7</option>
<option  value="8">8</option>
<option  value="9">9</option>
<option  value="10">10</option>
</select>
</td>
</tr>
</table>

<% 
speciesIDfound = false
sql2 = "select * from SpeciesBreedLookupTable where SpeciesID=" & speciesID & " Order by Breed"
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3
if not rs2.eof then 
speciesIDfound = True
end if
rs2.close
if speciesIDfound = True then
%>

<table>
<tr>
<td class = "body" width = "160" align = "left">
<% if MissingBreed then %>
<% if SpeciesID = 4 then %>
<b><font color="maroon">Type*</font></b>
<% else %>
<b><font color="maroon">Breed 1*</font></b>
<% end if %>
<% else %>
<% if SpeciesID = 4 then %>
<b>Type*</b>
<% else %>
<b>Breed 1*</b>
<% end if %>
<% end if %>
</td>
<td class = "body" width = "160" align = "left">
<% if SpeciesID = 4 then %>
<% else %>
<b>Breed 2</b>
<% end if %>
</td>
</tr>
<tr>
<td align = "left">
<% 
Set rsb = Server.CreateObject("ADODB.Recordset")
if SpeciesID = 3 then
sql2 = "select * from SpeciesBreedLookupTable where BreedLookupID = 10 or BreedLookupID = 12 or BreedLookupID = 16 or BreedLookupID = 17 or BreedLookupID = 28 or BreedLookupID =32 or BreedLookupID = 41 or BreedLookupID = 51 or BreedLookupID = 64 or BreedLookupID = 65 or BreedLookupID = 66 or BreedLookupID = 67 or BreedLookupID = 68 or BreedLookupID = 72 or BreedLookupID = 79 or BreedLookupID = 84 or BreedLookupID =87 or BreedLookupID = 96 or BreedLookupID = 109 or BreedLookupID = 114 or BreedLookupID = 118 or BreedLookupID = 120 or BreedLookupID = 125 or BreedLookupID = 127 or BreedLookupID = 128 or BreedLookupID = 130 or BreedLookupID = 154 or BreedLookupID = 161 or BreedLookupID = 162 or BreedLookupID = 168 or BreedLookupID = 170 or BreedLookupID = 176 or BreedLookupID = 179 or BreedLookupID = 188 or BreedLookupID = 201 or BreedLookupID = 202 or BreedLookupID = 207 or BreedLookupID = 216 or BreedLookupID = 217 or BreedLookupID = 218 or BreedLookupID = 231 or BreedLookupID = 239 or BreedLookupID = 264 or BreedLookupID = 270 or BreedLookupID = 273 or BreedLookupID = 280 or BreedLookupID = 282 or BreedLookupID = 289 or BreedLookupID = 299 or BreedLookupID = 302 or BreedLookupID = 318 or BreedLookupID = 319 or BreedLookupID = 331 or BreedLookupID = 333 or BreedLookupID = 341 or BreedLookupID = 353 or BreedLookupID = 354 or BreedLookupID = 361 or BreedLookupID = 369 or BreedLookupID = 377 or BreedLookupID = 384 or BreedLookupID = 386 or BreedLookupID = 394 or BreedLookupID = 402 or BreedLookupID = 406 or BreedLookupID = 410 or BreedLookupID = 411 or BreedLookupID = 427 or BreedLookupID = 428 or BreedLookupID = 442 or BreedLookupID = 458 or BreedLookupID = 467 or BreedLookupID = 893 or BreedLookupID = 1023 or BreedLookupID = 1487 order by Breed"
else
sql2 = "select * from SpeciesBreedLookupTable where SpeciesID=" & speciesID & " Order by trim(Breed)"
end if

rs2.Open sql2, conn, 3, 3
if not rs2.eof then 
if len(BreedID) > 0 then 

sqlb = "select * from SpeciesBreedLookupTable where BreedLookupID=" & BreedID 
rsb.Open sqlb, conn, 3, 3
if not rsb.eof then 
Currentbreed = rsb("Breed")
end if
rsb.close
end if
%>
<select size="1" name="BreedID">

<%
 if len(Currentbreed) > 1 then %>
<option value="<%=BreedID %>" selected><%=Currentbreed %></option>
<% else %>
<% if len(PreferedSpeciesBreed) > 1 then %>
<option value="<%=PreferedSpeciesID %>" selected><%=PreferedSpeciesBreed %></option>
<% else %>
<option value="" class="body">Select a Breed</option>
<% end if
 end if

while not(rs2.eof) 
Breed = rs2("Breed") 
BreedID = rs2("BreedLookupID") %>
<% if not Breed = PreferedSpeciesBreed then %>
<option value="<%= BreedID %>" class="body"><%= trim(Breed) %></option>
<%
end if
 rs2.movenext
wend 
end if
rs2.close 
%>
</select>
</td>
<% if not SpeciesID = 4 then %>
<td>
<% if SpeciesID = 3 then
sql2 = "select * from SpeciesBreedLookupTable where BreedLookupID = 10 or BreedLookupID = 12 or BreedLookupID = 16 or BreedLookupID = 17 or BreedLookupID = 28 or BreedLookupID =32 or BreedLookupID = 41 or BreedLookupID = 51 or BreedLookupID = 64 or BreedLookupID = 65 or BreedLookupID = 66 or BreedLookupID = 67 or BreedLookupID = 68 or BreedLookupID = 72 or BreedLookupID = 79 or BreedLookupID = 84 or BreedLookupID =87 or BreedLookupID = 96 or BreedLookupID = 109 or BreedLookupID = 114 or BreedLookupID = 118 or BreedLookupID = 120 or BreedLookupID = 125 or BreedLookupID = 127 or BreedLookupID = 128 or BreedLookupID = 130 or BreedLookupID = 154 or BreedLookupID = 161 or BreedLookupID = 162 or BreedLookupID = 168 or BreedLookupID = 170 or BreedLookupID = 176 or BreedLookupID = 179 or BreedLookupID = 188 or BreedLookupID = 201 or BreedLookupID = 202 or BreedLookupID = 207 or BreedLookupID = 216 or BreedLookupID = 217 or BreedLookupID = 218 or BreedLookupID = 231 or BreedLookupID = 239 or BreedLookupID = 264 or BreedLookupID = 270 or BreedLookupID = 273 or BreedLookupID = 280 or BreedLookupID = 282 or BreedLookupID = 289 or BreedLookupID = 299 or BreedLookupID = 302 or BreedLookupID = 318 or BreedLookupID = 319 or BreedLookupID = 331 or BreedLookupID = 333 or BreedLookupID = 341 or BreedLookupID = 353 or BreedLookupID = 354 or BreedLookupID = 361 or BreedLookupID = 369 or BreedLookupID = 377 or BreedLookupID = 384 or BreedLookupID = 386 or BreedLookupID = 394 or BreedLookupID = 402 or BreedLookupID = 406 or BreedLookupID = 410 or BreedLookupID = 411 or BreedLookupID = 427 or BreedLookupID = 428 or BreedLookupID = 442 or BreedLookupID = 458 or BreedLookupID = 467 or BreedLookupID = 893 or BreedLookupID = 1023 or BreedLookupID = 1487 order by Breed"
else
sql2 = "select * from SpeciesBreedLookupTable where SpeciesID=" & speciesID & " Order by trim(Breed)"
end if 
rs2.Open sql2, conn, 3, 3
if not rs2.eof then 
if len(BreedID2) > 0 then 

sqlb = "select * from SpeciesBreedLookupTable where BreedLookupID=" & BreedID2 
rsb.Open sqlb, conn, 3, 3
if not rsb.eof then 
Currentbreed = rsb("Breed")
end if
rsb.close
end if %>
<select size="1" name="BreedID2">
<%


 if len(BreedID2) > 0 then 
%>
<option value="<%=BreedID2 %>" selected><%=CurrentBreed %></option>
<% else %>
<option value="" class="body">Select a Breed</option>
<% end if %>
<% while not(rs2.eof) 
Breed = rs2("Breed") 
BreedID = rs2("BreedLookupID") %>
<% if not Breed  = PreferedSpeciesBreed then %>
<option value="<%= BreedID %>" class="body"><%= trim(Breed) %></option>
<%
end if
 rs2.movenext
wend %>
</select>
<% end if
rs2.close
%>
</td>
</tr>
<% if not(speciesID= 2 or  speciesID= 9 ) then%>
<tr>
<td class = "body" width = "160" align = "left">
<b>Breed 3</b>
</td>
<td class = "body" width = "160" align = "left">
<b>Breed 4</b>
</td>
</tr>
<tr>
<td>
<% if SpeciesID = 3 then
sql2 = "select * from SpeciesBreedLookupTable where BreedLookupID = 10 or BreedLookupID = 12 or BreedLookupID = 16 or BreedLookupID = 17 or BreedLookupID = 28 or BreedLookupID =32 or BreedLookupID = 41 or BreedLookupID = 51 or BreedLookupID = 64 or BreedLookupID = 65 or BreedLookupID = 66 or BreedLookupID = 67 or BreedLookupID = 68 or BreedLookupID = 72 or BreedLookupID = 79 or BreedLookupID = 84 or BreedLookupID =87 or BreedLookupID = 96 or BreedLookupID = 109 or BreedLookupID = 114 or BreedLookupID = 118 or BreedLookupID = 120 or BreedLookupID = 125 or BreedLookupID = 127 or BreedLookupID = 128 or BreedLookupID = 130 or BreedLookupID = 154 or BreedLookupID = 161 or BreedLookupID = 162 or BreedLookupID = 168 or BreedLookupID = 170 or BreedLookupID = 176 or BreedLookupID = 179 or BreedLookupID = 188 or BreedLookupID = 201 or BreedLookupID = 202 or BreedLookupID = 207 or BreedLookupID = 216 or BreedLookupID = 217 or BreedLookupID = 218 or BreedLookupID = 231 or BreedLookupID = 239 or BreedLookupID = 264 or BreedLookupID = 270 or BreedLookupID = 273 or BreedLookupID = 280 or BreedLookupID = 282 or BreedLookupID = 289 or BreedLookupID = 299 or BreedLookupID = 302 or BreedLookupID = 318 or BreedLookupID = 319 or BreedLookupID = 331 or BreedLookupID = 333 or BreedLookupID = 341 or BreedLookupID = 353 or BreedLookupID = 354 or BreedLookupID = 361 or BreedLookupID = 369 or BreedLookupID = 377 or BreedLookupID = 384 or BreedLookupID = 386 or BreedLookupID = 394 or BreedLookupID = 402 or BreedLookupID = 406 or BreedLookupID = 410 or BreedLookupID = 411 or BreedLookupID = 427 or BreedLookupID = 428 or BreedLookupID = 442 or BreedLookupID = 458 or BreedLookupID = 467 or BreedLookupID = 893 or BreedLookupID = 1023 or BreedLookupID = 1487 order by Breed"
else
sql2 = "select * from SpeciesBreedLookupTable where SpeciesID=" & speciesID & " Order by trim(Breed)"
end if 
rs2.Open sql2, conn, 3, 3
if not rs2.eof then
if len(BreedID3) > 0 then 

sqlb = "select * from SpeciesBreedLookupTable where BreedLookupID=" & BreedID3
rsb.Open sqlb, conn, 3, 3
if not rsb.eof then 
Currentbreed = rsb("Breed")
end if
rsb.close
end if  
%>
<select size="1" name="BreedID3">
<% if len(BreedID3) > 0 then %>
<option value="<%=BreedID3 %>" selected><%=CurrentBreed %></option>
<% else %>
<option value="" class="body">Select a Breed</option>
<% end if %>
<option value="<%= Breed %>" class="body"><%= trim(Breed) %></option>
<% while not(rs2.eof) 
Breed = rs2("Breed") 
BreedID = rs2("BreedLookupID") %>
<% if not Breed  = PreferedSpeciesBreed then %>
<option value="<%= BreedID %>" class="body"><%= trim(Breed) %></option>
<%
end if
 rs2.movenext
wend %>
</select>
<% end if
rs2.close
%>
</td>
<td>
<% if SpeciesID = 3 then
sql2 = "select * from SpeciesBreedLookupTable where BreedLookupID = 10 or BreedLookupID = 12 or BreedLookupID = 16 or BreedLookupID = 17 or BreedLookupID = 28 or BreedLookupID =32 or BreedLookupID = 41 or BreedLookupID = 51 or BreedLookupID = 64 or BreedLookupID = 65 or BreedLookupID = 66 or BreedLookupID = 67 or BreedLookupID = 68 or BreedLookupID = 72 or BreedLookupID = 79 or BreedLookupID = 84 or BreedLookupID =87 or BreedLookupID = 96 or BreedLookupID = 109 or BreedLookupID = 114 or BreedLookupID = 118 or BreedLookupID = 120 or BreedLookupID = 125 or BreedLookupID = 127 or BreedLookupID = 128 or BreedLookupID = 130 or BreedLookupID = 154 or BreedLookupID = 161 or BreedLookupID = 162 or BreedLookupID = 168 or BreedLookupID = 170 or BreedLookupID = 176 or BreedLookupID = 179 or BreedLookupID = 188 or BreedLookupID = 201 or BreedLookupID = 202 or BreedLookupID = 207 or BreedLookupID = 216 or BreedLookupID = 217 or BreedLookupID = 218 or BreedLookupID = 231 or BreedLookupID = 239 or BreedLookupID = 264 or BreedLookupID = 270 or BreedLookupID = 273 or BreedLookupID = 280 or BreedLookupID = 282 or BreedLookupID = 289 or BreedLookupID = 299 or BreedLookupID = 302 or BreedLookupID = 318 or BreedLookupID = 319 or BreedLookupID = 331 or BreedLookupID = 333 or BreedLookupID = 341 or BreedLookupID = 353 or BreedLookupID = 354 or BreedLookupID = 361 or BreedLookupID = 369 or BreedLookupID = 377 or BreedLookupID = 384 or BreedLookupID = 386 or BreedLookupID = 394 or BreedLookupID = 402 or BreedLookupID = 406 or BreedLookupID = 410 or BreedLookupID = 411 or BreedLookupID = 427 or BreedLookupID = 428 or BreedLookupID = 442 or BreedLookupID = 458 or BreedLookupID = 467 or BreedLookupID = 893 or BreedLookupID = 1023 or BreedLookupID = 1487 order by Breed"
else
sql2 = "select * from SpeciesBreedLookupTable where SpeciesID=" & speciesID & " Order by trim(Breed)"
end if 
rs2.Open sql2, conn, 3, 3
if not rs2.eof then 
if len(BreedID4) > 0 then 

sqlb = "select * from SpeciesBreedLookupTable where BreedLookupID=" & BreedID4
rsb.Open sqlb, conn, 3, 3
if not rsb.eof then 
Currentbreed = rsb("Breed")
end if
rsb.close
end if  %>
<select size="1" name="BreedID4">
<% if len(BreedID4) > 0 then %>
<option value="<%=BreedID4 %>" selected><%=CurrentBreed %></option>
<% else %>
<option value="" class="body">Select a Breed</option>
<% end if %>
<option value="<%= Breed %>" class="body"><%= trim(Breed) %></option>
<% while not(rs2.eof) 
Breed = rs2("Breed") 
BreedID = rs2("BreedLookupID") %>
<% if not Breed  = PreferedSpeciesBreed then %>
<option value="<%= BreedID %>" class="body"><%= trim(Breed) %></option>
<%
end if
 rs2.movenext
wend %>
</select>
<% end if
rs2.close
%>

<% end if %>
</td></tr>

<% end if %>
</table>

<% end if %>
<table>
<tr>
<td class = "body" width = "160" align = "left">
<b>Color 1</b>
</td>
<td class = "body" width = "160" align = "left">
<b>Color 2</b>
</td>
<td class = "body" width = "160" align = "left">
<b>Color 3</b>
</td>
<td class = "body" width = "160" align = "left">
<b>Color 4</b>
</td>
<td class = "body" width = "160" align = "left">
<b>Color 5</b>
</td>
</tr>
<tr>
<td align = "left">
<select size="1" name="Color1">
<%If len(color1) > 0 then %>
<option  value= "<%=Color1 %>"><%=Color1 %></option>
<% else %>
<option  value= ""></option>
<% end if %>
<% sql = "select * from SpeciesColorlookupTable where SpeciesID =  " & SpeciesID & " order by SpeciesColor "
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
while not rs.eof	 %>
<option  value= "<%=rs("SpeciesColor")%>" ><%=rs("SpeciesColor")%></option>
<% rs.movenext
wend
rs.close
%>
</select>
</td>
<td align = "left">
<select size="1" name="Color2">
<%If len(color2) > 0 then %>
<option  value= "<%=Color2 %>"><%=Color2 %></option>
<% else %>
<option  value= ""></option>
<% end if %>
<% sql = "select * from SpeciesColorlookupTable where SpeciesID =  " & SpeciesID & " order by SpeciesColor "
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
while not rs.eof	 %>
<option  value= "<%=rs("SpeciesColor")%>" ><%=rs("SpeciesColor")%></option>
<% rs.movenext
wend
rs.close
%>
</select>
</td>
<td align = "left">
<select size="1" name="Color3">
<%If len(color3) > 0 then %>
<option  value= "<%=Color3 %>"><%=Color3 %></option>
<% else %>
<option  value= ""></option>
<% end if %>
<% sql = "select * from SpeciesColorlookupTable where SpeciesID =  " & SpeciesID & " order by SpeciesColor "
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
while not rs.eof	 %>
<option  value= "<%=rs("SpeciesColor")%>" ><%=rs("SpeciesColor")%></option>
<% rs.movenext
wend
rs.close
%>
</select>
</td>
<td align = "left">
<select size="1" name="Color4">
<%If len(color4) > 0 then %>
<option  value= "<%=Color4 %>"><%=Color4 %></option>
<% else %>
<option  value= ""></option>
<% end if %>
<% sql = "select * from SpeciesColorlookupTable where SpeciesID =  " & SpeciesID & " order by SpeciesColor "
response.write("sql=" & sql)
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
while not rs.eof	 %>
<option  value= "<%=rs("SpeciesColor")%>" ><%=rs("SpeciesColor")%></option>
<% rs.movenext
wend
rs.close
%>
</select>
</td>
<td align = "left">
<select size="1" name="Color5">
<%If len(color4) > 0 then %>
<option  value= "<%=Color5 %>"><%=Color5 %></option>
<% else %>
<option  value= ""></option>
<% end if %>
<% sql = "select * from SpeciesColorlookupTable where SpeciesID =  " & SpeciesID & " order by SpeciesColor "
response.write("sql=" & sql)
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
while not rs.eof	 %>
<option  value= "<%=rs("SpeciesColor")%>" ><%=rs("SpeciesColor")%></option>
<% rs.movenext
wend
rs.close
%>
</select>
</td></tr></table>
<% if SpeciesID  = 2 then %>
<table>
<tr>
		<td class = "body" width = "160" align = "left">
			<b>% Peruvian</b>
		</td>
		<td class = "body" width = "160" align = "left">
			<b>% Chilean</b>
		</td>
		<td class = "body" width = "160" align = "left">
			<b>% Bolivian</b>
		</td>
		<td class = "body" width = "160" align = "left">
			<b>% Other/Unknown</b>
		</td>
			<td class = "body" width = "160" align = "left">
			<b>% Accoyo</b>
		</td>
</tr>
<tr><td align = "left">
		<select size="1" name="PercentPeruvian">
<option name = "PercentPeruvian1" value= "<%=PercentPeruvian%>" selected><%=PercentPeruvian%></option>
<option name = "PercentPeruvian2" value="0">0%</option>
<option name = "PercentPeruvian3" value="1/8">1/8</option>
				     <option name = "PercentPeruvian4" value="1/4">1/4</option>
				     <option name = "PercentPeruvian5" value="3/8">3/8</option>
				     <option name = "PercentPeruvian6" value="1/2">1/2</option>
				     <option name = "PercentPeruvian7" value="5/8">5/8</option>
				     <option name = "PercentPeruvian8" value="3/4">3/4</option>
				     <option name = "PercentPeruvian9" value="7/8">7/8</option>
  <option name = "PercentPeruvian10" value="FullPeruvian">Full Peruvian</option>
			 </select>
		</td>
		<td align = "left">
				<select size="1" name="PercentChilean">
<option name = "PercentChilean1" value= "<%=PercentChilean%>" selected><%=PercentChilean%></option>
<option name = "PercentChilean2" value="0">0%</option>
<option name = "PercentChilean3" value="1/8">1/8</option>
				     <option name = "PercentChilean4" value="1/4">1/4</option>
				     <option name = "PercentChilean5" value="3/8">3/8</option>
				     <option name = "PercentChilean6" value="1/2">1/2</option>
				     <option name = "PercentChilean7" value="5/8">5/8</option>
				     <option name = "PercentChilean8" value="3/4">3/4</option>
				     <option name = "PercentChilean9" value="7/8">7/8</option>
  <option name = "PercentChilean10" value="FullChilean">Full Chilean</option>
			 </select>
			
		</td>
		<td align = "left">
			<select size="1" name="PercentBolivian">
<option name = "PercentBolivian1" value= "<%=PercentBolivian%>" selected><%=PercentBolivian%></option>
<option name = "PercentBolivian2" value="0">0%</option>
<option name = "PercentBolivian3" value="1/8">1/8</option>
				     <option name = "PercentBolivian4" value="1/4">1/4</option>
				     <option name = "PercentBolivian5" value="3/8">3/8</option>
				     <option name = "PercentBolivian6" value="1/2">1/2</option>
				     <option name = "PercentBolivian7" value="5/8">5/8</option>
				     <option name = "PercentBolivian8" value="3/4">3/4</option>
				     <option name = "PercentBolivian9" value="7/8">7/8</option>
  <option name = "PercentBolivian10" value="FullBolivian">Full Bolivian</option>
			 </select>
		</td>
		<td align = "left">
			<select size="1" name="PercentUnknownOther">
<option name = "PercentUnknownOther1" value= "<%=PercentUnknownOther%>" selected><%=PercentUnknownOther%></option>
<option name = "PercentUnknownOther2" value="0">0%</option>
<option name = "PercentUnknownOther3" value="1/8">1/8</option>
				     <option name = "PercentUnknownOther4" value="1/4">1/4</option>
				     <option name = "PercentUnknownOther5" value="3/8">3/8</option>
				     <option name = "PercentUnknownOther6" value="1/2">1/2</option>
				     <option name = "PercentUnknownOther7" value="5/8">5/8</option>
				     <option name = "PercentUnknownOther8" value="3/4">3/4</option>
				     <option name = "PercentUnknownOther9" value="7/8">7/8</option>
  <option name = "PercentUnknownOther10" value="FullPeruvian">100% Unknown or Other</option>
			 </select>
		</td>
		<td align = "left">
			<select size="1" name="PercentAccoyo">
<option name = "PercentAccoyo1" value= "<%=PercentAccoyo%>" selected><%=PercentAccoyo%></option>
<option name = "PercentAccoyo2" value="0">0%</option>
<option name = "PercentAccoyo3" value="1/8">1/8</option>
				     <option name = "PercentAccoyo4" value="1/4">1/4</option>
				     <option name = "PercentAccoyo5" value="3/8">3/8</option>
				     <option name = "PercentAccoyo6" value="1/2">1/2</option>
				     <option name = "PercentAccoyo7" value="5/8">5/8</option>
				     <option name = "PercentAccoyo8" value="3/4">3/4</option>
				     <option name = "PercentAccoyo9" value="7/8">7/8</option>
  <option name = "PercentAccoyo10" value="FullAccoyo">Full Accoyo</option>
			 </select>
		</td>
	</tr>
</table>
<% end if %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%">
<tr><td width = "300" valign = "top">
	<form action= 'MembersPricingHandleForm.asp' method = "post"  action="/articles/articles/javascript/checkNumeric.asp?ID=<%=siteID%>" name = "pricingform">
	<input type = "hidden" name="ID" Value = "<%=  ID%>">
<table border = "0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "300">
<tr ><td class = "body" height = "30" align = "left">
		<b>For Sale?</b>
		<% 		
		if ForSale = "Yes" Or ForSale = True Then %>
			Yes<input TYPE="RADIO" name="ForSale" Value = "Yes" checked>
			No<input TYPE="RADIO" name="ForSale" Value = "No" >
		<% Else %>
			Yes<input TYPE="RADIO" name="ForSale" Value = "Yes" >
			No<input TYPE="RADIO" name="ForSale" Value = "No" checked>
		<% End If %>
		<br>
		</td>
		</tr>
        <tr ><td class = "body" height = "30" align = "left">
		<b>Free?</b>
		<% 		
		if Free = "Yes" Or Free = True Then %>
			Yes<input TYPE="RADIO" name="Free" Value = "Yes" checked>
			No<input TYPE="RADIO" name="Free" Value = "No" >
		<% Else %>
			Yes<input TYPE="RADIO" name="Free" Value = "Yes" >
			No<input TYPE="RADIO" name="Free" Value = "No" checked>
		<% End If %>
		<br>
		</td>
		</tr>
		 <tr >
				<td class = "body" height = "30" align = "left">
		
		<a class="tooltip" href="#"><b>OBO?</b><span class="custom info"><em>About OBO</em>By sellecting OBO you are adding the ability for potential buyers to make you an offer; however, that does not mean that you have to accept an offer, if you are not interested.</span></a>
		
		
		<% 		
		if OBO = "Yes" Or OBO = True Then %>
			Yes<input TYPE="RADIO" name="OBO" Value = "Yes" checked>
			No<input TYPE="RADIO" name="OBO" Value = "No" >
		<% Else %>
			Yes<input TYPE="RADIO" name="OBO" Value = "Yes" >
			No<input TYPE="RADIO" name="OBO" Value = "No" checked>
		<% End If %>
		<br>
		</td>
		</tr>
<tr ><td class = "body" height = "30" align = "left">
<a class="tooltip" href="#"><b>Foundation Animal?</b><span class="custom info"><em>Foundation Animal</em>This means an animal that you want show as an important breeding animal but not necessarily for sale.</span></a>
<% 	if Foundation = "Yes" Or Foundation = True Then %>
			Yes<input TYPE="RADIO" name="Foundation" Value = "Yes" checked>
			No<input TYPE="RADIO" name="Foundation" Value = "No" >
		<% Else %>
			Yes<input TYPE="RADIO" name="Foundation" Value = "Yes" >
			No<input TYPE="RADIO" name="Foundation" Value = "No" checked>
		<% End If %>
<br>
</td></tr>
		<tr>
			<td class = "body" height = "30" align = "left">
            	<a class="tooltip" href="#"><b>Price</b><span class="custom info"><em>Price</em>If you do not enter a price but you set the animal as 'For Sale' then the price will be listed as 'call for price'.</span></a>
            <% tempPrice = Price
            if Price = "0" then
            tempPrice  = "" 
            end if %>
		$<input type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"
		name='price' size=10 maxlength=10 Value= "<%= tempPrice%>"><br /><font color="grey">Must be a number.</font>
		</td>
	</tr>
<% If trim(category) = "Experienced Female" Or trim(category) = "Inexperienced female" Then %>
<tr >
		<td class = "body" height = "30">
		<a class="tooltip" href="#"><b>Embryos For Sale?</b><span class="custom info" align = "left"><img src="/images/logoTip.png" alt="Livestock Of America Screen Tip" height="48" width="48" /><em>Embryos For Sale?</em>Are you offering for sale embryos donated by this animal?</span></a>
		
		<% 		
		if Donor= "Yes" Or Donor = True Then %>
			Yes<input TYPE="RADIO" name="Donor" Value = "Yes" checked>
			No<input TYPE="RADIO" name="Donor" Value = "No" >
		<% Else %>
			Yes<input TYPE="RADIO" name="Donor" Value = "Yes" >
			No<input TYPE="RADIO" name="Donor" Value = "No" checked>
		<% End If %>
		<br>
		</td>
		</tr>
<tr>
<td class = "body" height = "30" align = "left"><b>Embryo Price</b>
$<input type=text onBlur="checkNumeric(this,-5,5000,',','.','-');" name="EmbryoPrice" size=5 maxlength=5 Value= "<%= EmbryoPrice%>"> per embyo.
				</td>
		</tr>
<% end if

 If trim(category) = "Experienced Male" Or trim(category) = "Inexperienced Male" Then 
			If Len(StudFee) < 2 Then
				StudFee = ""
			End If
		%>
		<tr>
				<td class = "body" height = "30" align = "left"><b>Stud Fee</b>
					$<input type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"
					name='StudFee' size=10 maxlength=10 Value= "<%= StudFee%>">
				</td>
		</tr>
		<tr >
				<td class = "body" height = "30" align = "left">
		<a class="tooltip" href="#"><b>Offer Pay What You Can Stud Breedings?</b><span class="custom info"><img src="/images/logoTip.png" alt="Livestock of America Screen Tip" height="48" width="48" /><em>About Pay What You Can </em>By offering <i>Pay What You Can</i>you are adding the ability for potential buyers to make you an offer on a  Stud Breeding based upon what they can afford; however, that does not mean that you have to accept an offer, if you don't want to.</span></a>
		<br />
		<% 		
		if PayWhatYouCanStud = "Yes" Or PayWhatYouCanStud = True Then %>
			Yes<input TYPE="RADIO" name="PayWhatYouCanStud" Value = "Yes" checked>
			No<input TYPE="RADIO" name="PayWhatYouCanStud" Value = "No" >
		<% Else %>
			Yes<input TYPE="RADIO" name="PayWhatYouCanStud" Value = "Yes" >
			No<input TYPE="RADIO" name="PayWhatYouCanStud" Value = "No" checked>
		<% End If %>
		<br><br>
		</td>
		</tr>
         <tr >
		<td class = "body" height = "30">
		<a class="tooltip" href="#"><b>Semen For Sale?</b><span class="custom info"><img src="/images/logoTip.png" alt="Livestock Of America Screen Tip" height="48" width="48" /><em>Semen For Sale?</em>Are you offering for sale semen donated by this animal?</span></a>

		<% 		
		if Donor= "Yes" Or Donor = True Then %>
			Yes<input TYPE="RADIO" name="Donor" Value = "Yes" checked>
			No<input TYPE="RADIO" name="Donor" Value = "No" >
		<% Else %>
			Yes<input TYPE="RADIO" name="Donor" Value = "Yes" >
			No<input TYPE="RADIO" name="Donor" Value = "No" checked>
		<% End If %>
		<br>
		</td>
		</tr>
        		<tr>
				<td class = "body" height = "30" ><b>Semen price</b>
$<input type=text onBlur="checkNumeric(this,-5,5000,',','-');" name="SemenPrice" size=3 maxlength=6 Value= "<%= SemenPrice%>"> per straw.
				</td>
		</tr>

	<tr>
	
		
	<% Else %>
				<input type=hidden  name='StudFee'  Value= "">
	<% End If %>

	<tr>
		<td class = "body" height = "30" align = "left"><b>Sale Pending?</b>
		<% 'response.write("Forsale=")
		' response.write(Forsale)
		
		if SalePending = "Yes" Or SalePending = True Then %>
			Yes<input TYPE="RADIO" name="SalePending" Value = "Yes" checked>
			No<input TYPE="RADIO" name="SalePending" Value = "No" >
		<% Else %>
			Yes<input TYPE="RADIO" name="SalePending" Value = "Yes" >
			No<input TYPE="RADIO" name="SalePending" Value = "No" checked>
		<% End If %>
		
		</td>
		</tr>
		<tr>
		<td class = "body" height = "30" align = "left">
		<b>Sold?</B>
		<% 'response.write("Forsale=")
		' response.write(Forsale)
		
		if Sold = "Yes" Or Sold = True Then %>
			Yes<input TYPE="RADIO" name="Sold" Value = "Yes" checked>
			No<input TYPE="RADIO" name="Sold" Value = "No" >
		<% Else %>
			Yes<input TYPE="RADIO" name="Sold" Value = "Yes" >
			No<input TYPE="RADIO" name="Sold" Value = "No" checked>
		<% End If %>
		
		</td>
	</tr>
</table>
</td>
<td class = "body" height = "30" align = "left" valign = "top">
<script language="JavaScript" type="text/javascript" src="/cgi-bin/wysiwyg.js"></script> 
<script language="JavaScript" type="text/javascript" src="/cgi-bin/wysiwyg-settings.js"></script>
<script type="text/javascript">
    var mysettings = new WYSIWYG.Settings();
    mysettings.Width = "550";
    mysettings.Height = "80px";
    mysettings.ImagePopupWidth = 600;
    mysettings.ImagePopupHeight = 245;
    WYSIWYG.attach('PriceComments', mysettings);
</script>
<b>Price Comment</b> (a short comment like "Great Price!" or "Wonderful Ancestors!")<br>
<textarea name="PriceComments" ID="PriceComments" cols="45" rows="2" wrap="VIRTUAL" ><%= PriceComments%></textarea>
<br><br />
<b>Description</b>

<script type="text/javascript">
    var mysettings = new WYSIWYG.Settings();
    mysettings.Width = "550";
    mysettings.Height = "380px";
    mysettings.ImagePopupWidth = 600;
    mysettings.ImagePopupHeight = 245;
    WYSIWYG.attach('Description', mysettings);
</script>
<textarea name="Description"  cols="45" rows="40"   class = "body"  ID="Description"><%= Description%></textarea>
<input type='hidden'  name="NumberofAnimals"  Value= "<%= NumberofAnimals%>">
<tr><td  align = "center" colspan = "2"><br />
<input type="submit" value = "Save & Proceed To Next Page" class="regsubmit2" >
</form>
</td></tr></table>
<% else %>
<tr><td valign = "top"><br>
<table align= 'center'><tr><td class = "body"><b>What Species is the Animal?</b></td>
<td class = "body">
<form  name=form method="post" action="MembersAnimalAdd1Test.asp?wizard=True&PeopleID=<%=PeopleID %>">
<select size="1" name="SpeciesID">
<% sql = "select * from SpeciesAvailable where SpeciesID = 2 or SpeciesID = 3 or SpeciesID = 4 or SpeciesID = 5 or SpeciesID = 6 or SpeciesID = 7 or SpeciesID = 8 or SpeciesID = 10 or SpeciesID = 12 Order by Species "
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
while not rs.eof	
SpeciesID = rs("SpeciesID")
if SpeciesID = 3 then
singularterm  = "Working Dog"
else
singularterm  = rs("singularterm")
end if %>
<option  value= "<%=SpeciesID%>" selected><%=singularterm%></option>
<% rs.movenext
wend
rs.close
%>
</select>
</td></tr>
<tr><td class = "body">
<b>Number of Animals in Listing </b>
</td>
<td class = "body">
<select size="1" name="NumberofAnimals">
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
<tr><td align = 'center'>
<input type=submit value = "Submit" class="regsubmit2" >
</Form>
</td></tr></table>

</td>
<td class = "roundedtopandbottom body" width = "340">
<h3><b>When to List Individual Animals or Groups</b></h3>
If you have a lot of information to share on individual animals then we recommend that you list them individually. Also we highly recommend that you enter separate listings per breed or species. Buyers are more likely to respond if a listing has the information they are looking for (i.e. someone looking for an angora goat most likely will not take the time to review a listing with 12 Holstein cows, 2 Nubian goats, 2 Huacaya alpacas, and 1 angora goat.) 
<br /><br />
After you add your listings you can group combine them into a package.
 </td></tr></table>
 <% end if %>
 <br></td>
</tr>
</table><br>
<!--#Include virtual="/Footer.asp"--></Body>
</HTML>