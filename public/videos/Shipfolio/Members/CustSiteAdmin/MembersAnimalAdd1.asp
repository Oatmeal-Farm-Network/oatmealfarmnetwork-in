<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<!--#Include file="AdminGlobalVariables.asp"-->
<link rel="stylesheet" type="text/css" href="/administration/style.css">
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
Horns=Request.querystring("Horns")
BreedID=Request.querystring("BreedID")
BreedID2=Request.querystring("BreedID2")
BreedID3=Request.querystring("BreedID3")
BreedID4=Request.querystring("BreedID4")

MicrochipNumber=Request.querystring("MicrochipNumber")
Price=Request.querystring("Price")
Price2=Request.querystring("Price2")
Price3=Request.querystring("Price3")
Price4=Request.querystring("Price4")

MinOrder1=Request.querystring("MinOrder1")
MinOrder2=Request.querystring("MinOrder2")
MinOrder3=Request.querystring("MinOrder3")
MinOrder4=Request.querystring("MinOrder4")

MaxOrder1=Request.querystring("MaxOrder1")
MaxOrder2=Request.querystring("MaxOrder2")
MaxOrder3=Request.querystring("MaxOrder3")
MaxOrder4=Request.querystring("MaxOrder4")

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
if len(NumberofAnimals) > 0 then
else
NumberofAnimals = 1
end if


 tempspeciesID=Request.form("speciesID")
if len(tempSpeciesID) > 0 then
session("tempSpeciesID")  = tempSpeciesID
else
tempspeciesID=Request.querystring("speciesID")
session("tempSpeciesID")  = tempSpeciesID
end if

tempspeciesID = SpeciesID

if len(tempSpeciesID) > 0 then
else
tempspeciesID=Session("tempspeciesID")
end if

NumberofAnimals=Request.Form("NumberofAnimals")
if len(NumberofAnimals) > 0 then
session(NumberofAnimals)  = NumberofAnimals
else
NumberofAnimals=Request.querystring("NumberofAnimals")
end if

if len(NumberofAnimals) > 0 then
else
NumberofAnimals=Session("NumberofAnimals")
end if
wizard= request.querystring("wizard")
SpeciesID = TempSpeciesID
%>	
</HEAD>
<% if mobiledevice = True or is_iPad = true then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth + '&SpeciesID=<%=SpeciesID %>' + '&NumberofAnimals=<%=NumberofAnimals %>' + '&wizard=<%=wizard %>);" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<% end if %>
<% Current1="Animals" 
Current2 = "AddAnimals"%> 
<!--#Include file="AdminHeader.asp"--> 

<% Current3 = "AddAnimal"  %> 
<!--#Include file="AdminAnimalsTabsInclude.asp"-->
<table width = 100% class = "roundedtopandbottom" cellpadding = 0 cellspacing = 0>
<tr><td>
<% If not rs.State = adStateClosed Then
  rs.close
End If  
conn.close
set conn = nothing%> 
<!--#Include virtual="/ConnLOA.asp"--> 

 <%
'response.write("SpeciesID=" & SpeciesID )
'response.write("NumberofAnimals=" & NumberofAnimals )

if Numofspecies = 1 then
   AnimalType = SpeciesOne
end if
SpeciesID = tempspeciesID
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

if  SpeciesID = 17 then
 AnimalType="Yak"
end if 

if  SpeciesID = 19 then
 AnimalType="Emu"
end if 

if  SpeciesID = 22 then
 AnimalType="Geese"
end if 

tempSpeciesID =SpeciesId

if len(tempSpeciesID) >0 then 

sql = "select * from SpeciesAvailable where SingularTerm=  '" & AnimalType &"'"


Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, connLOA, 3, 3   
if not rs.eof then
SpeciesSalesType = rs("SpeciesSalesType")
'response.write("SpeciesSalesType=" & SpeciesSalesType )

PreferedSpeciesID= rs("PreferedSpeciesID")
else
PreferedSpeciesID= ""
end if

if len(PreferedSpeciesID) > 0 then
 sql2 = "select Breed from SpeciesBreedLookupTable where breedavailable = 1 and BreedLookupID=" & PreferedSpeciesID & " Order by Breed"
 ' response.Write("sql=" & sql)
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, connLOA, 3, 3
if not rs2.eof then
    PreferedSpeciesBreed = rs2("Breed")
else
    PreferedSpeciesBreed = 0
end if
rs2.close
end if




SalePending=Request.Querystring("SalePending") 
Sold=Request.Querystring("Sold") 
StudFee=Request.Querystring("StudFee") 
ForSale=Request.Querystring("ForSale") 
PriceComments=session("PriceComments") 
Description=session("Description") 
session("PriceComments") = "" 
session("Description") =""
Discount=Request.Querystring("Discount") 
ShowOnStudPage=Request.Querystring("ShowOnStudPage") 
OBO=Request.Querystring("OBO") 
PayWhatYouCanAnimal=Request.Querystring("PayWhatYouCanAnimal") 
PayWhatYouCanStud=Request.Querystring("PayWhatYouCanStud") 
EmbryoPrice=Request.Querystring("EmbryoPrice") 
SemenPrice=Request.Querystring("SemenPrice") 
Donor=Request.Querystring("Donor") 
Free=Request.Querystring("Free") 

if len(NumberofAnimals)> 0 then
else
NumberofAnimals = 1
end if
%>

<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  width = "<%=screenwidth-32 %>"  align = "left" >
<tr><td class = "body" align = "left">

<H1><div align = "left">Add a New Animal Listing</div></H1>

<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "<%=screenwidth -32%>"  align = "left">
<tr><td class = "body">
<h2><font color = "brown">Step 1: Short Form</font> <small>(<font color = "darkgreen" ><b>Required Fields are Shown in Green</b></font>)</small></h2>
<big>Enter below some basic information about your <% if NumberofAnimals = 1 then%>animal<% else %> animals<% end if %>. On the next page you will be able to add a lot more information.</big>
<br><br>
<% Duplicate=Request.QueryString("Duplicate")
if Duplicate then %>
<div align = "left"><br /><b><h2><font color = "maroon">You already have an animal entered with that Name / Title. Please enter another Name / Title.</font></h2></b></div>
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
</table>

<form  name=form method="post" action="MembersAnimalAdd2B.asp?wizard=True&PeopleID=<%=PeopleID %>">
<input type = "hidden" name = "speciesID" value = "<%=speciesID %>" class = 'formbox'/>
<table border = "0" width = <%=screenwidth - 32 %> leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
<tr><td width = "300" height =60 class = "body" align = "left">	
<% if MissingName then %>
<br />
<a class="tooltip" href="#"><font color = "maroon" ><b>Name / Title</font></b><span class="custom info"><em>Name /Title</em>This can be a full name like <i>XYZ Ranches Peruvian MagaStud</i> or a title like <i>Registered Brown Boar</i></span></a><b></b>
<% else %>
<a class="tooltip" href="#"><font color = "darkgreen" ><b>Name /Title</b></font><span class="custom info"><em>Name /Title</em>This can be a full name like <i>XYZ Ranches Peruvian MagaStud</i> or a title like <i>Registered Brown Boar</i></span></a><b></b>
<% end if %>
<% 
namewidth = 90
if screenwidth < 800 then
namewidth = 70
end if

if screenwidth < 641 then
namewidth = 40
end if

if screenwidth < 325 then
namewidth = 30
end if

 %>
<input name="Name" size = "<%=namewidth %>" value="<%=Name%>" class = 'formbox'>
</td>
</tr>
</table>



<% if SpeciesID = 5 or speciesid = 8 or speciesid = 9 or speciesid = 17 then %>
<table border = "0" width = <%=screenwidth - 32 %> leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
<tr>
<td width = "100"  class = "body" align = "left">	
<b>Height</b>
</td>
<td width = "100"  class = "body" align = "left">	
<b>Weight</b>
</td>
<% if speciesid = 5 then %>
<td width = "100"  class = "body" align = "left">	
<b>Gaited</b>
</td>
<td width = "100"  class = "body" align = "left">	
<b>Warmblood</b>
</td>
<% end if %>
<% if SpeciesID = 8 or speciesid = 9 or speciesid = 17then %>
<td width = "2"></td>
<td width = "100"  class = "body" align = "left">	
<b>Horns</b>
</td>
<td width = "2"></td>
<% end if %>


</tr>
<tr>
<td width = "100"  class = "body" align = "left">	
<input name="Height" size = "10" value="<%=Height%>" class = 'formbox'>
</td>
<td width = "100"  class = "body" align = "left">	
<input name="Weight" size = "10" value="<%=Weight%>" class = 'formbox'>
</td>
<% if SpeciesID = 8 or speciesid = 9 or speciesid = 17 then %>
<td width = "2"></td>
<td width = "100"  class = "body" align = "left">	

<select size="1" name="Horns" class = 'formbox'>
<% if Horns = "Yes" then  %>
<option value="Yes" selected>Yes</option>
<option value="No" >No</option>
<option value="">Not Set</option>
<% end if %>
<% if Horns = "No" then  %>
<option value="Yes" >Yes</option>
<option value="No" selected>No</option>
<option value="">Not Set</option>
<% end if %>

<% if len(Horns) < 2 then  %>
<option value="Yes" >Yes</option>
<option value="No" >No</option>
<option value="" selected>Not Set</option>
<% end if %>


</td>
<td width = "2"></td>
<% end if %>


<% if SpeciesID = 5 then %>
<td width = "100"  class = "body" align = "left">

<% If Gaited = "True" Or Gaited = "1" Then %>
Yes<input TYPE="RADIO" name="Gaited" Value = "True" checked class = 'formbox'>
No<input TYPE="RADIO" name="Gaited" Value = "False" class = 'formbox'>
<% Else %>
Yes<input TYPE="RADIO" name="Gaited" Value = "True" class = 'formbox'>
No<input TYPE="RADIO" name="Gaited" Value = "False" checked class = 'formbox'>
<% End If %>
</td>
<td width = "100"  class = "body" align = "left">	
<% If Warmblood = "False" Or Warmblood = "1" Then %>
Yes<input TYPE="RADIO" name="Warmblood" Value = "True" checked class = 'formbox'>
No<input TYPE="RADIO" name="Warmblood" Value = "False" class = 'formbox'>
<% Else %>
Yes<input TYPE="RADIO" name="Warmblood" Value = "True" class = 'formbox'>
No<input TYPE="RADIO" name="Warmblood" Value = "False" checked class = 'formbox'>
<% End If %>
</td>
<% end if %>
</tr>
</table>
<% end if %>

<% ShowDate = True
if SpeciesSalesType="Fowl" then
   If NumberofAnimals = "1" then
        Showdate =True
  else
  ShowDate = True
end if
end if

If ShowDate = True then %>
<table  border = "0" width = <%=screenwidth - 32 %>>
<% if screenwidth < 800 then %>

<% if NumberofAnimals = "1" then %>
<tr>
<td class = "body" width = "220" align = "left">
<b>Date of Birth</b><br />
<select size="1" name="DOBMonth" class = 'formbox' width="80" style="width: 80px">
<option value="<%=DOBMonth%>" selected><%=DOBMonth%></option>
<option value="1">Jan (1)</option>
<option  value="2">Feb (2)</option>
<option  value="3">Mar (3)</option>
<option  value="4">Apr (4)</option>
<option  value="5">May (5)</option>
<option  value="6">Jun (6)</option>
<option  value="7">Jul (7)</option>
<option  value="8">Aug (8)</option>
<option  value="9">Sep (9)</option>
<option  value="10">Oct (10)</option>
<option  value="11">Nov (11)</option>
<option  value="12">Dec (12)</option>
</select>
<select size="1" name="DOBDay" class = 'formbox' style="width: 70px">
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
<select size="1" name="DOBYear" class = 'formbox' style="width: 70px">
<option value="<%=DOBYear%>" selected><%=DOBYear%></option>
<% currentyear = year(date) 
For yearv=1983 To currentyear %>
<option value="<%=yearv%>"><%=yearv%></option>		
<% Next %></select>
</td></tr>
<% end if %>


<tr>
<td align = "left" valign = top>
<font color = "darkgreen" ><b>Category</b></font><br>
<%  if NumberofAnimals = "1" then %>
<select size="1" name="Category" class = 'formbox'>
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
<select size="1" name="Category" class = 'formbox'>
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
</tr>
<tr>
<td>
<table cellspacing = 5 cellpadding = 5 border = "0" width = <%=screenwidth - 32 %>>
<tr>
<td align = "left" class = "body" width = 120  valign = top>
<b>Species</b><br />
<b><%=AnimalType%></b>
</td>
<td align = "left" class = "body" >
<b>Temperament</b><br />
<select size="1" name="Temperment" class = 'formbox' width="60" style="width: 60px">
<% if len(Temperment) > 0 then %>
<option  value= "<%=Temperment%>" selected><%=Temperment%></option>
<% else %>
<option  value= "" selected> </option>
<% end if %>
<option value="1">1</option>
<option value="2">2</option>
<option value="3">3</option>
<option value="4">4</option>
<option value="5">5</option>
<option value="6">6</option>
<option value="7">7</option>
<option value="8">8</option>
<option value="9">9</option>
<option value="10">10</option>
</select>
<font color = #404040><small><br />(1=Very Calm, <% if mobiledevice = True then %><br /><% end if %>10=Very High-Spirited)</small></font>
</td>
</tr>
</table>
</td>
<td></td>
</tr>



<% else %>
<tr>
<% if NumberofAnimals = "1" then %>
<td class = "body" width = "360" align = "left">
<b>Date of Birth</b>
</td>
<% end if %>

<% if Missingcategory then %>
<td class = "body" width = "300" align = "left" >
<b><font color='maroon'>Category</font></b>
</td>
<% else %>
<td class = "body" width = "300" align = "left">
<font color = "darkgreen" ><b>Category</b></font>
</td>
<% end if %>
<td class = "body" align = "left">	
<b>Species</b>
</td>
<td width = "300"  class = "body" align = "left">	
<b>Temperament 
</b>
</td>
</tr>
<tr>
<% if NumberofAnimals = "1" then %>
<td align = "left" valign = top>
<select size="1" name="DOBMonth" class = 'formbox' width="90" style="width: 90px">
<option value="<%=DOBMonth%>" selected><%=DOBMonth%></option>
<option value="1">Jan (1)</option>
<option  value="2">Feb (2)</option>
<option  value="3">Mar (3)</option>
<option  value="4">Apr (4)</option>
<option  value="5">May (5)</option>
<option  value="6">Jun (6)</option>
<option  value="7">Jul (7)</option>
<option  value="8">Aug (8)</option>
<option  value="9">Sep (9)</option>
<option  value="10">Oct (10)</option>
<option  value="11">Nov (11)</option>
<option  value="12">Dec (12)</option>
</select>
<select size="1" name="DOBDay" class = 'formbox' width="70" style="width: 70px">
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
<select size="1" name="DOBYear" class = 'formbox' width="70" style="width: 70px">
<option value="<%=DOBYear%>" selected><%=DOBYear%></option>
<% currentyear = year(date) 
For yearv=1983 To currentyear %>
<option value="<%=yearv%>"><%=yearv%></option>		
<% Next %></select>
</td>
<% end if %>
<td align = "left" width = 330  valign = top>
<%  if NumberofAnimals = "1" then %>
<select size="1" name="Category" class = 'formbox' width="330" style="width: 330px">
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
<select size="1" name="Category" class = 'formbox' width="330" style="width: 330px">
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
<td align = "left" class = "body" width = 120  valign = top>
 <b><%=AnimalType%></b>
</td>
<td align = "left" class = "body" >
<select size="1" name="Temperment" class = 'formbox' width="60" style="width: 60px">
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
<font color = #404040><small><br />(1=Very Calm, 10=Very High-Spirited)</small></font>
</td>
<td></td>
</tr>
</table>
<% end if %>
<% end if %>


<% 
speciesIDfound = false
sql2 = "select * from SpeciesBreedLookupTable where breedavailable = 1 and SpeciesID=" & speciesID & " Order by Breed"
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, connLOA, 3, 3
if not rs2.eof then 

speciesIDfound = True
end if
rs2.close
if speciesIDfound = True then
%>

<table>
<% if not SpeciesID = 4 then %>
<tr>
<td class = "body" width = "160" align = "left">
<% if MissingBreed then %>
<b><font color="darkgreen"><big>Breed 1</big></font></b>
<% else %>
<font color = "darkgreen" ><b>Breed 1</b></font>
<% end if %>
<br />
<% 
Set rsb = Server.CreateObject("ADODB.Recordset")
'if SpeciesID = 3 then
'sql2 = "select * from SpeciesBreedLookupTable where BreedLookupID = 10 or BreedLookupID = 12 or BreedLookupID = 16 or BreedLookupID = 17 or BreedLookupID = 28 or BreedLookupID =32 or BreedLookupID = 41 or BreedLookupID = 51 or BreedLookupID = 64 or BreedLookupID = 65 or BreedLookupID = 66 or BreedLookupID = 67 or BreedLookupID = 68 or BreedLookupID = 72 or BreedLookupID = 79 or BreedLookupID = 84 or BreedLookupID =87 or BreedLookupID = 96 or BreedLookupID = 109 or BreedLookupID = 114 or BreedLookupID = 118 or BreedLookupID = 120 or BreedLookupID = 125 or BreedLookupID = 127 or BreedLookupID = 128 or BreedLookupID = 130 or BreedLookupID = 154 or BreedLookupID = 161 or BreedLookupID = 162 or BreedLookupID = 168 or BreedLookupID = 170 or BreedLookupID = 176 or BreedLookupID = 179 or BreedLookupID = 188 or BreedLookupID = 201 or BreedLookupID = 202 or BreedLookupID = 207 or BreedLookupID = 216 or BreedLookupID = 217 or BreedLookupID = 218 or BreedLookupID = 231 or BreedLookupID = 239 or BreedLookupID = 264 or BreedLookupID = 270 or BreedLookupID = 273 or BreedLookupID = 280 or BreedLookupID = 282 or BreedLookupID = 289 or BreedLookupID = 299 or BreedLookupID = 302 or BreedLookupID = 318 or BreedLookupID = 319 or BreedLookupID = 331 or BreedLookupID = 333 or BreedLookupID = 341 or BreedLookupID = 353 or BreedLookupID = 354 or BreedLookupID = 361 or BreedLookupID = 369 or BreedLookupID = 377 or BreedLookupID = 384 or BreedLookupID = 386 or BreedLookupID = 394 or BreedLookupID = 402 or BreedLookupID = 406 or BreedLookupID = 410 or BreedLookupID = 411 or BreedLookupID = 427 or BreedLookupID = 428 or BreedLookupID = 442 or BreedLookupID = 458 or BreedLookupID = 467 or BreedLookupID = 893 or BreedLookupID = 1023 or BreedLookupID = 1487 order by Breed"
'else
sql2 = "select * from SpeciesBreedLookupTable where breedavailable = 1 and SpeciesID=" & speciesID & " Order by trim(Breed)"
'end if

rs2.Open sql2, connLOA, 3, 3
if not rs2.eof then 
if len(BreedID) > 0 then 

sqlb = "select * from SpeciesBreedLookupTable where breedavailable = 1 and BreedLookupID=" & BreedID 
rsb.Open sqlb, connLOA, 3, 3
if not rsb.eof then 
Currentbreed = rsb("Breed")
end if
rsb.close
end if
%>
<select size="1" name="BreedID" class = 'formbox'>
<%
 if len(Currentbreed) > 1 then %>
<option value="<%=BreedID %>" selected><%=Currentbreed %></option>
<% else %>
<% if len(PreferedSpeciesBreed) > 1 then %>
<option value="<%=PreferedSpeciesID %>" selected><%=PreferedSpeciesBreed %></option>
<option value="" class="body"> ---</option>
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
<% if screenwidth < 400 then %>
</tr>
<tr>
<% end if %>

<td class = "body" width = "160" align = "left">

<b>Breed 2</b>

<% 
Set rsb = Server.CreateObject("ADODB.Recordset")
'if SpeciesID = 3 then
'sql2 = "select * from SpeciesBreedLookupTable where BreedLookupID = 10 or BreedLookupID = 12 or BreedLookupID = 16 or BreedLookupID = 17 or BreedLookupID = 28 or BreedLookupID =32 or BreedLookupID = 41 or BreedLookupID = 51 or BreedLookupID = 64 or BreedLookupID = 65 or BreedLookupID = 66 or BreedLookupID = 67 or BreedLookupID = 68 or BreedLookupID = 72 or BreedLookupID = 79 or BreedLookupID = 84 or BreedLookupID =87 or BreedLookupID = 96 or BreedLookupID = 109 or BreedLookupID = 114 or BreedLookupID = 118 or BreedLookupID = 120 or BreedLookupID = 125 or BreedLookupID = 127 or BreedLookupID = 128 or BreedLookupID = 130 or BreedLookupID = 154 or BreedLookupID = 161 or BreedLookupID = 162 or BreedLookupID = 168 or BreedLookupID = 170 or BreedLookupID = 176 or BreedLookupID = 179 or BreedLookupID = 188 or BreedLookupID = 201 or BreedLookupID = 202 or BreedLookupID = 207 or BreedLookupID = 216 or BreedLookupID = 217 or BreedLookupID = 218 or BreedLookupID = 231 or BreedLookupID = 239 or BreedLookupID = 264 or BreedLookupID = 270 or BreedLookupID = 273 or BreedLookupID = 280 or BreedLookupID = 282 or BreedLookupID = 289 or BreedLookupID = 299 or BreedLookupID = 302 or BreedLookupID = 318 or BreedLookupID = 319 or BreedLookupID = 331 or BreedLookupID = 333 or BreedLookupID = 341 or BreedLookupID = 353 or BreedLookupID = 354 or BreedLookupID = 361 or BreedLookupID = 369 or BreedLookupID = 377 or BreedLookupID = 384 or BreedLookupID = 386 or BreedLookupID = 394 or BreedLookupID = 402 or BreedLookupID = 406 or BreedLookupID = 410 or BreedLookupID = 411 or BreedLookupID = 427 or BreedLookupID = 428 or BreedLookupID = 442 or BreedLookupID = 458 or BreedLookupID = 467 or BreedLookupID = 893 or BreedLookupID = 1023 or BreedLookupID = 1487 order by Breed"
'else
sql2 = "select * from SpeciesBreedLookupTable where breedavailable = 1 and SpeciesID=" & speciesID & " Order by trim(Breed)"
'end if

rs2.Open sql2, connLOA, 3, 3
if not rs2.eof then 
if len(BreedID2) > 0 then 

sqlb = "select * from SpeciesBreedLookupTable where breedavailable = 1 and BreedLookupID=" & BreedID2 
rsb.Open sqlb, connLOA, 3, 3
if not rsb.eof then 
Currentbreed2 = rsb("Breed")
end if
rsb.close
end if
%>
<select size="1" name="BreedID2" class = 'formbox'>
<% if len(Currentbreed2) > 1 then %>
<option value="<%=BreedID2 %>" selected><%=Currentbreed2 %></option>
<% else %>
<option value="" class="body">Select a Breed</option>
<% 
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
<% if screenwidth < 700 then %>
</tr>
<tr>
<% end if %>


<% if not (speciesid = 2 or speciesid = 4) then %>
<td class = "body" width = "160" align = "left">
<b>Breed 3</b>
<% 
Set rsb = Server.CreateObject("ADODB.Recordset")
'if SpeciesID = 3 then
'sql2 = "select * from SpeciesBreedLookupTable where BreedLookupID = 10 or BreedLookupID = 12 or BreedLookupID = 16 or BreedLookupID = 17 or BreedLookupID = 28 or BreedLookupID =32 or BreedLookupID = 41 or BreedLookupID = 51 or BreedLookupID = 64 or BreedLookupID = 65 or BreedLookupID = 66 or BreedLookupID = 67 or BreedLookupID = 68 or BreedLookupID = 72 or BreedLookupID = 79 or BreedLookupID = 84 or BreedLookupID =87 or BreedLookupID = 96 or BreedLookupID = 109 or BreedLookupID = 114 or BreedLookupID = 118 or BreedLookupID = 120 or BreedLookupID = 125 or BreedLookupID = 127 or BreedLookupID = 128 or BreedLookupID = 130 or BreedLookupID = 154 or BreedLookupID = 161 or BreedLookupID = 162 or BreedLookupID = 168 or BreedLookupID = 170 or BreedLookupID = 176 or BreedLookupID = 179 or BreedLookupID = 188 or BreedLookupID = 201 or BreedLookupID = 202 or BreedLookupID = 207 or BreedLookupID = 216 or BreedLookupID = 217 or BreedLookupID = 218 or BreedLookupID = 231 or BreedLookupID = 239 or BreedLookupID = 264 or BreedLookupID = 270 or BreedLookupID = 273 or BreedLookupID = 280 or BreedLookupID = 282 or BreedLookupID = 289 or BreedLookupID = 299 or BreedLookupID = 302 or BreedLookupID = 318 or BreedLookupID = 319 or BreedLookupID = 331 or BreedLookupID = 333 or BreedLookupID = 341 or BreedLookupID = 353 or BreedLookupID = 354 or BreedLookupID = 361 or BreedLookupID = 369 or BreedLookupID = 377 or BreedLookupID = 384 or BreedLookupID = 386 or BreedLookupID = 394 or BreedLookupID = 402 or BreedLookupID = 406 or BreedLookupID = 410 or BreedLookupID = 411 or BreedLookupID = 427 or BreedLookupID = 428 or BreedLookupID = 442 or BreedLookupID = 458 or BreedLookupID = 467 or BreedLookupID = 893 or BreedLookupID = 1023 or BreedLookupID = 1487 order by Breed"
'else
sql2 = "select * from SpeciesBreedLookupTable where breedavailable = 1 and SpeciesID=" & speciesID & " Order by trim(Breed)"
'end if

rs2.Open sql2, connLOA, 3, 3
if not rs2.eof then 
if len(BreedID3) > 0 then 

sqlb = "select * from SpeciesBreedLookupTable where breedavailable = 1 and BreedLookupID=" & BreedID3 
rsb.Open sqlb, connLOA, 3, 3
if not rsb.eof then 
Currentbreed3 = rsb("Breed")
end if
rsb.close
end if
%>
<select size="1" name="BreedID3" class = 'formbox'>
<%
 if len(Currentbreed3) > 1 then %>
<option value="<%=BreedID3 %>" selected><%=Currentbreed3 %></option>
<% else %>
<option value="" class="body">Select a Breed</option>
<% end if

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
<% if screenwidth < 400 then %>
</tr>
<tr>
<% end if %>


<td class = "body" width = "160" align = "left">
<b>Breed 4</b>

<% 
Set rsb = Server.CreateObject("ADODB.Recordset")
'if SpeciesID = 3 then
'sql2 = "select * from SpeciesBreedLookupTable where BreedLookupID = 10 or BreedLookupID = 12 or BreedLookupID = 16 or BreedLookupID = 17 or BreedLookupID = 28 or BreedLookupID =32 or BreedLookupID = 41 or BreedLookupID = 51 or BreedLookupID = 64 or BreedLookupID = 65 or BreedLookupID = 66 or BreedLookupID = 67 or BreedLookupID = 68 or BreedLookupID = 72 or BreedLookupID = 79 or BreedLookupID = 84 or BreedLookupID =87 or BreedLookupID = 96 or BreedLookupID = 109 or BreedLookupID = 114 or BreedLookupID = 118 or BreedLookupID = 120 or BreedLookupID = 125 or BreedLookupID = 127 or BreedLookupID = 128 or BreedLookupID = 130 or BreedLookupID = 154 or BreedLookupID = 161 or BreedLookupID = 162 or BreedLookupID = 168 or BreedLookupID = 170 or BreedLookupID = 176 or BreedLookupID = 179 or BreedLookupID = 188 or BreedLookupID = 201 or BreedLookupID = 202 or BreedLookupID = 207 or BreedLookupID = 216 or BreedLookupID = 217 or BreedLookupID = 218 or BreedLookupID = 231 or BreedLookupID = 239 or BreedLookupID = 264 or BreedLookupID = 270 or BreedLookupID = 273 or BreedLookupID = 280 or BreedLookupID = 282 or BreedLookupID = 289 or BreedLookupID = 299 or BreedLookupID = 302 or BreedLookupID = 318 or BreedLookupID = 319 or BreedLookupID = 331 or BreedLookupID = 333 or BreedLookupID = 341 or BreedLookupID = 353 or BreedLookupID = 354 or BreedLookupID = 361 or BreedLookupID = 369 or BreedLookupID = 377 or BreedLookupID = 384 or BreedLookupID = 386 or BreedLookupID = 394 or BreedLookupID = 402 or BreedLookupID = 406 or BreedLookupID = 410 or BreedLookupID = 411 or BreedLookupID = 427 or BreedLookupID = 428 or BreedLookupID = 442 or BreedLookupID = 458 or BreedLookupID = 467 or BreedLookupID = 893 or BreedLookupID = 1023 or BreedLookupID = 1487 order by Breed"
'else
sql2 = "select * from SpeciesBreedLookupTable where breedavailable = 1 and SpeciesID=" & speciesID & " Order by trim(Breed)"
'end if

rs2.Open sql2, connLOA, 3, 3
if not rs2.eof then 
if len(BreedID3) > 0 then 

sqlb = "select * from SpeciesBreedLookupTable where breedavailable = 1 and BreedLookupID=" & BreedID4 
rsb.Open sqlb, connLOA, 3, 3
if not rsb.eof then 
Currentbreed4 = rsb("Breed")
end if
rsb.close
end if
%>
<select size="1" name="BreedID4" class = 'formbox'>
<%
 if len(Currentbreed4) > 1 then %>
<option value="<%=BreedID4 %>" selected><%=Currentbreed4 %></option>
<% else %>
<option value="" class="body">Select a Breed</option>
<% end if

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
<% end if %>

</tr>
<% end if %>
</table>
</td></tr>
<% end if %>


<% if not SpeciesSalesType = "Fowl" then %>
<tr><td align = left>
<table cellspacing = 0 cellpadding = 5 align = left border = "0" >
<tr>
<td align = "left">
<B>Color 1</B><br />
<select size="1" name="Color1" class = 'formbox'>
<%If len(color1) > 0 then %>
<option  value= "<%=Color1 %>"><%=Color1 %></option>
<% else %>
<option  value= ""></option>
<% end if %>
<% sql = "select * from SpeciesColorlookupTable where SpeciesID =  " & SpeciesID & " order by SpeciesColor "
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, connLOA, 3, 3   
while not rs.eof	 %>
<option  value= "<%=rs("SpeciesColor")%>" ><%=rs("SpeciesColor")%></option>
<% rs.movenext
wend
rs.close
%>
</select>
</td>
<% if screenwidth < 400 then %>
</tr>
<tr>
<% end if %>
<td align = "left">
<B>Color 2</B><br />
<select size="1" name="Color2" class = 'formbox'>
<%If len(color2) > 0 then %>
<option  value= "<%=Color2 %>"><%=Color2 %></option>
<% else %>
<option  value= ""></option>
<% end if %>
<% sql = "select * from SpeciesColorlookupTable where SpeciesID =  " & SpeciesID & " order by SpeciesColor "
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, connLOA, 3, 3   
while not rs.eof	 %>
<option  value= "<%=rs("SpeciesColor")%>" ><%=rs("SpeciesColor")%></option>
<% rs.movenext
wend
rs.close
%>
</select>
</td>
<% if screenwidth < 700 then %>
</tr>
<tr>
<% end if %>
<td align = "left">


<B>Color 3</B><br />
<select size="1" name="Color3" class = 'formbox'>
<%If len(color3) > 0 then %>
<option  value= "<%=Color3 %>"><%=Color3 %></option>
<% else %>
<option  value= ""></option>
<% end if %>
<% sql = "select * from SpeciesColorlookupTable where SpeciesID =  " & SpeciesID & " order by SpeciesColor "
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, connLOA, 3, 3   
while not rs.eof	 %>
<option  value= "<%=rs("SpeciesColor")%>" ><%=rs("SpeciesColor")%></option>
<% rs.movenext
wend
rs.close
%>
</select>

</td>
<% if screenwidth < 400 then %>
</tr>
<tr>
<% end if %>
<td align = "left">
<% if not speciesid = 9 then %>
<B>Color 4</B><br />
<select size="1" name="Color4" class = 'formbox'>
<%If len(color4) > 0 then %>
<option  value= "<%=Color4 %>"><%=Color4 %></option>
<% else %>
<option  value= ""></option>
<% end if %>
<% sql = "select * from SpeciesColorlookupTable where SpeciesID =  " & SpeciesID & " order by SpeciesColor "
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, connLOA, 3, 3   
while not rs.eof	 %>
<option  value= "<%=rs("SpeciesColor")%>" ><%=rs("SpeciesColor")%></option>
<% rs.movenext
wend
rs.close
%>
</select>
<% end if %>
</td></tr></table>
</td></tr>
<% end if %>


<% if SpeciesID  = 2 then %>
<tr><td align = left>
<table cellspacing = 0 cellpadding = 5 align = left border = "0" width = <%=screenwidth - 42 %>>
<tr><td align = "left">
<b>% Peruvian</b><br />
<select size="1" name="PercentPeruvian" class = 'formbox'>
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
<% if screenwidth < 700 then %>
</tr><tr>
<% end if %>
<td align = "left">
<b>% Chilean</b><br />
<select size="1" name="PercentChilean" class = 'formbox'>
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
<% if screenwidth < 400 then %>
</tr><tr>
<% end if %>
<td align = "left">
<b>% Bolivian</b><br />
<select size="1" name="PercentBolivian" class = 'formbox'>
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
<% if screenwidth < 700 then %>
</tr><tr>
<% end if %>
<td align = "left">
<b>% Other/Unknown</b><br />
<select size="1" name="PercentUnknownOther" class = 'formbox'>
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
<% if screenwidth < 400 then %>
</tr><tr>
<% end if %>
<td align = "left">
<b>% Accoyo</b><br />
<select size="1" name="PercentAccoyo" class = 'formbox'>
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
</td></tr>
<% end if %>

<table cellspacing="0" cellpadding = "0" align = "left" border = "0" width = <%=screenwidth - 42 %>>
<tr><td width = "300" valign = "top">
<form action= 'MembersPricingHandleForm.asp' method = "post"  action="/articles/articles/javascript/checkNumeric.asp?ID=<%=siteID%>" name = "pricingform">
<input type = "hidden" name="ID" Value = "<%=  ID%>">
<table border = "0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "300">
<tr ><td class = "body" height = "30" align = "left">
		<b>For Sale?</b>
       <% 		
		if ForSale = "False"  Then %>
			Yes<input TYPE="RADIO" name="ForSale" Value = "True"  >
			No<input TYPE="RADIO" name="ForSale" Value = "False" checked >
		<% Else %>
			Yes<input TYPE="RADIO" name="ForSale" Value = "True" checked>
			No<input TYPE="RADIO" name="ForSale" Value = "False"  >
		<% End If %>
		<br>
		</td>
		</tr>
        <tr ><td class = "body" height = "30" align = "left">
		<b>Free?</b>
		<% 		
		if Free = "True" Then %>
			Yes<input TYPE="RADIO" name="Free" Value = "True" checked>
			No<input TYPE="RADIO" name="Free" Value = "False" >
		<% Else %>
			Yes<input TYPE="RADIO" name="Free" Value = "True" >
			No<input TYPE="RADIO" name="Free" Value = "False" checked>
		<% End If %>
		<br>
		</td>
        </tr>
		
<% SHOWOBO = FALSE
if SHOWOBO = True then %>        
         <tr >
				<td class = "body" height = "30" align = "left">
		
		<a class="tooltip" href="#"><b>OBO?</b><span class="custom info"><em>About OBO</em>By sellecting OBO you are adding the ability for potential buyers to make you an offer; however, that does not mean that you have to accept an offer, if you are not interested.</span></a>
<% 		
		if OBO = "True" Then %>
			Yes<input TYPE="RADIO" name="OBO" Value = "True" checked>
			No<input TYPE="RADIO" name="OBO" Value = "False" >
		<% Else %>
			Yes<input TYPE="RADIO" name="OBO" Value = "True" >
			No<input TYPE="RADIO" name="OBO" Value = "False" checked>
		<% End If %>
		<br>
		</td>
		</tr>
<% end if %>
<% SHOWFoundation = FALSE
if SHOWFoundation = True then %> 
<tr ><td class = "body" height = "30" align = "left">
<a class="tooltip" href="#"><b>Foundation Animal?</b><span class="custom info"><em>Foundation Animal</em>This means an animal that you want show as an important breeding animal but not necessarily for sale.</span></a>
<% 	if Foundation = "True" Or Foundation = 1 Then %>
	Yes<input TYPE="RADIO" name="Foundation" Value = "True" checked>
	No<input TYPE="RADIO" name="Foundation" Value = "False" >
<% Else %>
	Yes<input TYPE="RADIO" name="Foundation" Value = "True" >
	No<input TYPE="RADIO" name="Foundation" Value = "False" checked>
<% End If %>
<br>
</td></tr>
<% End if %>

<% if SpeciesSalesType = "Fowl" and numberofanimals > 1 then %>
<tr>
	<td class = "body" height = "30" align = "left">
    <br />
            <b>
            <a class="tooltip" href="#"><b>Straight Run</b><span class="custom info"><em>Straight Run</em>Random Gender</span></a>
             Price</b><br />
            <% tempPrice = Price
            if Price = "0" then
            tempPrice  = "" 
            end if %>
		$<input class = 'formbox' type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"
		name='Price' size=10 maxlength=10 Value= "<%= tempPrice%>"><font color="#404040">
		</td>
	</tr>
    <tr>
		<td class = "body" align = "left">
            <b>Min Order</b><br />
            <% tempMinOrder1 = MinOrder1
            if MinOrder1 = "0" then
            tempMinOrder1  = "" 
            end if %>
		&nbsp;&nbsp;<input class = 'formbox' type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"
		name='MinOrder1' size=10 maxlength=10 Value= "<%= tempMinOrder1%>"><br />
		</td>
	</tr>
    <tr>
			<td class = "body" height = "30" align = "left">
            <b>Max Order</b><br />
            <% tempMaxOrder1 = MaxOrder1
            if MaxOrder1 = "0" then
            tempMaxOrder1  = "" 
            end if %>
		&nbsp;&nbsp;<input class = 'formbox' type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"
		name='MaxOrder1' size=10 maxlength=10 Value= "<%= tempMaxOrder1%>"><br /><br>
		</td>
	</tr>



<tr>
	<td class = "body" height = "30" align = "left">
      <b>Female Price</b><br>
            <% tempPrice2 = Price2
            if Price2 = "0" then
            tempPrice2  = "" 
            end if %>
		$<input class = 'formbox' type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"
		name='price2' size=10 maxlength=10 Value= "<%= tempPrice2%>">
		</td>
	</tr>
        <tr>
			<td class = "body" height = "30" align = "left">
          <b>Min Order</b><br>
            <% tempMinOrder2 = MinOrder2
            if MinOrder2 = "0" then
            tempMinOrder2  = "" 
            end if %>
		&nbsp;&nbsp;<input class = 'formbox' type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"
		name='MinOrder2' size=10 maxlength=10 Value= "<%= tempMinOrder2%>"><br />
		</td>
	</tr>
        <tr>
			<td class = "body" height = "30" align = "left">
            <b>Max Order</b><br />
            <% tempMaxOrder2 = MaxOrder2
            if MaxOrder2 = "0" then
            tempMaxOrder2  = "" 
            end if %>
		&nbsp;&nbsp;<input class = 'formbox' type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"
		name='MaxOrder2' size=10 maxlength=10 Value= "<%= tempMaxOrder2%>"><br /><br>
		</td>
	</tr>

    <tr>
	<td class = "body" height = "30" align = "left">
      <b>Male Price</b><br>
            <% tempPrice3 = Price3
            if Price3 = "0" then
            tempPrice3  = "" 
            end if %>
		$<input class = 'formbox' type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"
		name='Price3' size=10 maxlength=10 Value= "<%= tempPrice3%>">
		</td>
	</tr>
    <tr>
	<td class = "body" height = "30" align = "left">
       <b>Min Order</b><br>
            <% tempMinOrder3 = MinOrder3
            if MinOrder3 = "0" then
            tempMinOrder3  = "" 
            end if %>
		&nbsp;&nbsp;<input class = 'formbox' type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"
		name='MinOrder3' size=10 maxlength=10 Value= "<%= tempMinOrder3%>"><br />
		</td>
	</tr>
        <tr>
			<td class = "body" height = "30" align = "left">
            <b>Max Order</b><br />
            <% tempMaxOrder3 = MaxOrder3
            if MaxOrder3 = "0" then
            tempMaxOrder3  = "" 
            end if %>
		&nbsp;&nbsp;<input class = 'formbox' type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"
		name='MaxOrder3' size=10 maxlength=10 Value= "<%= tempMaxOrder3%>"><br /><br>
		</td>
	</tr>
<tr>
	<td class = "body" height = "30" align = "left">
      <b>Egg Price</b><br>
            <% tempPrice4 = Price4
            if Price4 = "0" then
            tempPrice4  = "" 
            end if %>
		$<input class = 'formbox' type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"
		name='price4' size=10 maxlength=10 Value= "<%= tempPrice4%>">
		</td>
	</tr>
        <tr>
			<td class = "body" height = "30" align = "left">
         <b>Min Order</b><br>
            <% tempMinOrder4 = MinOrder4
            if MinOrder4 = "0" then
            tempMinOrder4  = "" 
            end if %>
		&nbsp;&nbsp;<input class = 'formbox' type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"
		name='MinOrder4' size=10 maxlength=10 Value= "<%= tempMinOrder4%>"><br />
		</td>
	</tr>
        <tr>
			<td class = "body" height = "30" align = "left">
            <b>Max Order</b><br />
            <% tempMaxOrder4 = MaxOrder4
            if MaxOrder4 = "0" then
            tempMaxOrder4  = "" 
            end if %>
		&nbsp;&nbsp;<input class = 'formbox' type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"
		name='MaxOrder4' size=10 maxlength=10 Value= "<%= tempMaxOrder4%>"><br /><br>
		</td>
	</tr>


<% else %>
		<tr>
			<td class = "body" height = "30" align = "left">
            	<a class="tooltip" href="#"><b>Price</b><span class="custom info"><em>Price</em>If you do not enter a price but you set the animal as 'For Sale' then the price will be listed as 'call for price'.</span></a>
            <% tempPrice = Price
            if Price = "0" then
            tempPrice  = "" 
            end if %>
		$<input class = 'formbox' type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"
		name='price' size=10 maxlength=10 Value= "<%= tempPrice%>"><br /><font color="grey">Must be a number.</font>
		</td>
	</tr>
<% end if %>
<% If trim(category) = "Experienced Female" Or trim(category) = "Inexperienced female" Then %>
<tr >
		<td class = "body" height = "30">
		<a class="tooltip" href="#"><b>Embryos For Sale?</b><span class="custom info" align = "left"><img src="/images/logoTip.png" alt="Livestock Of America Screen Tip" height="48" width="48" /><em>Embryos For Sale?</em>Are you offering for sale embryos donated by this animal?</span></a>
		
		<% 		
		if Donor= "True" Or Donor = 1 Then %>
			Yes<input TYPE="RADIO" name="Donor" Value = "True" checked>
			No<input TYPE="RADIO" name="Donor" Value = "False" >
		<% Else %>
			Yes<input TYPE="RADIO" name="Donor" Value = "True" >
			No<input TYPE="RADIO" name="Donor" Value = "False" checked>
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
		if PayWhatYouCanStud = "True" Or PayWhatYouCanStud = 1 Then %>
			Yes<input TYPE="RADIO" name="PayWhatYouCanStud" Value = "True" checked>
			No<input TYPE="RADIO" name="PayWhatYouCanStud" Value = "False" >
		<% Else %>
			Yes<input TYPE="RADIO" name="PayWhatYouCanStud" Value = "True" >
			No<input TYPE="RADIO" name="PayWhatYouCanStud" Value = "False" checked>
		<% End If %>
		<br><br>
		</td>
		</tr>
         <tr >
		<td class = "body" height = "30">
		<a class="tooltip" href="#"><b>Semen For Sale?</b><span class="custom info"><img src="/images/logoTip.png" alt="Livestock Of America Screen Tip" height="48" width="48" /><em>Semen For Sale?</em>Are you offering for sale semen donated by this animal?</span></a>

		<% 		
		if Donor= "True" Or Donor = 1 Then %>
			Yes<input TYPE="RADIO" name="Donor" Value = "True" checked>
			No<input TYPE="RADIO" name="Donor" Value = "False" >
		<% Else %>
			Yes<input TYPE="RADIO" name="Donor" Value = "True" >
			No<input TYPE="RADIO" name="Donor" Value = "False" checked>
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

    <input type=hidden  name='SalePanding'  Value= "">
		<tr>
		<td class = "body" height = "30" align = "left">
		<b>Sold?</B>
		<% 'response.write("Forsale=")
		' response.write(Forsale)
		
		if Sold = "True" Then %>
        Yes<input TYPE="RADIO" name="Sold" Value = "True" checked>
			No<input TYPE="RADIO" name="Sold" Value = "False" >
		<% Else %>
			Yes<input TYPE="RADIO" name="Sold" Value = "True" >
			No<input TYPE="RADIO" name="Sold" Value = "False" checked>
		<% End If %>
		
		</td>
	</tr>
</table>
</td>
<% if screenwidth < 800 then %>
</tr>
<tr>
<% end if %>
<td class = "body" height = "30" align = "left" valign = "top">
<% if mobiledevice = True then %>
<% else %>
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
<% end if %>
<b>Price Comment</b>
<% if mobiledevice = True then %>
<% else %> (a short comment like "Great Price!" or "Wonderful Ancestors!")
<% end if %>
<br>
<textarea name="PriceComments" ID="PriceComments" cols="30" rows="2" wrap="VIRTUAL" ><%= PriceComments%></textarea>
<br><br />
<b>Description</b><br>
<% if mobildevice = True then %>
<% else %>
<script type="text/javascript">
    var mysettings = new WYSIWYG.Settings();
    mysettings.Width = "550";
    mysettings.Height = "380px";
    mysettings.ImagePopupWidth = 600;
    mysettings.ImagePopupHeight = 245;
    WYSIWYG.attach('Description', mysettings);
</script>
<% end if %>
<textarea name="Description"  cols="30" rows="20"   class = "body"  ID="Description"><%= Description%></textarea>


<input type='hidden'  name="NumberofAnimals"  Value= "<%= NumberofAnimals%>">
<tr><td  align = "center" colspan = "2"><br />

<input type = hidden name="SpeciesSalesType" value = "<%=SpeciesSalesType %>" />
<input type="submit" value = "SAVE & PROCEED TO NEXT PAGE" class="regsubmit2" >
</form>
</td></tr></table>




<% else %>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=5 cellspacing=5 bordercolor = #000000 width = "<%=screenwidth-32 %>"  >
<tr><td class = "body" align = "left">

<H1><div align = "left">Add a New Animal Listing</div></H1>
A listing can be for a single animal or for a group of animals.

</td></tr>
<tr><td valign = "top"><br>
<form  name=form method="post" action="MembersAnimalAdd1.asp?wizard=True&PeopleID=<%=PeopleID %>">
<table align= 'center'>
<tr><td class = "body">
<b>Number of Animals in Listing </b>
</td>
<td class = "body">
<select size="1" name="NumberofAnimals"  class = "formbox">
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


<tr><td class = "body" valign = "top"><b>What Species is the Animal?</b><br />
<div align = "right"><font color = "#404040">(In alphabetical order.)</font></div></td>
<td class = "body" valign = "top">

<% if len(Preferedspecies) > 0 then 
sql = "select Species from SpeciesAvailable where SpeciesID = " & Preferedspecies & " Order by Species "
rs.Open sql, connLOA, 3, 3   
if not rs.eof then	
Preferedspeciesname = rs("Species")
end if
rs.close
end if %>
<select size="1" name="SpeciesID" class = "formbox">
<% if AlpacasAvailable = True then %>
<option  value= "2" >Alpaca</option>
<% end if %>

<% if BisonAvailable = True then %>
<option  value= "9" >Bison</option>
<% end if %>

<% if CattleAvailable = True then %>
<option  value= "8" >Cattle</option>
<% end if %>
 
 <% if CatsAvailable = True then %>
<option  value= "16" >Cats</option>
<% end if %>

<% if ChickensAvailable = True then %>
<option  value= "13" >Chicken</option>
<% end if %>

<% if DogsAvailable = True then %>
<option  value= "3" >Working Dog</option>
<% end if %>


<% if DonkeysAvailable = True then %>
<option  value= "7" >Donkey</option>
<% end if %>

<% if EmusAvailable = True then %>
<option  value= "20" >Emus</option>
<% end if %>

<% if GoatsAvailable = True then %>
<option  value= "6" >Goat</option>
<% end if %>

<% if HorsesAvailable = True then %>
<option  value= "5" >Horse</option>
<% end if %>

<% if LlamasAvailable = True then %>
<option  value= "4" >Llama</option>
<% end if %>

<% if PigsAvailable = True then %>
<option  value= "12" >Pig</option>
<% end if %>

<% if RabbitsAvailable = True then %>
<option  value= "11" >Rabbit</option>
<% end if %>

<% if SheepAvailable = True then %>
<option  value= "10" >Sheep</option>
<% end if %>

<% if TurkeysAvailable = True then %>
<option  value= "14" >Turkey</option>
<% end if %>

<% if YaksAvailable = True then %>
<option  value= "17" >Yaks</option>
<% end if %>
</select>


</td></tr>

<tr><td align = 'center'>
<input type=submit value = "SUBMIT" class="regsubmit2" >
</Form>
</td></tr></table>

</td>
<% if screenwidth > 700 then %>
<td class = "body" width = "340" valign = "top">
<br /><br />
<div class = "formbox">
<h3><b>When to List Individual Animals or Groups</b></h3>
If you have a lot of information to share on individual animals then we recommend that you list them individually. Also we highly recommend that you enter separate listings per breed or species. Buyers are more likely to respond if a listing has the information they are looking for (i.e. someone looking for an angora goat most likely will not take the time to review a listing with 12 Holstein cattle, 2 Nubian goats, 2 Huacaya alpacas, and 1 angora goat.) 
</div>
 </td>
 <% end if %>
 
 </tr></table>
 <% end if 
 
 connloa.close
 set ConnLOA = Nothing
 %>
 <br></td></tr></table></td></tr></table><br>
<!--#Include file="adminFooter.asp"--></Body>
</HTML>