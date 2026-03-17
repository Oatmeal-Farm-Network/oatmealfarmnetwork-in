<!DOCTYPE HTML >
<HTML>
<HEAD>
<link rel="stylesheet" type="text/css" href="/administration/style.css">
<% 
Name=Request.querystring("Name" ) 
ARI=Request.querystring("ARI" ) 
CLAA=Request.querystring("CLAA" ) 
DOBMonth=Request.querystring( "DOBMonth" ) 
DOBDay=Request.querystring( "DOBDay" ) 
DOBYear=Request.querystring( "DOBYear" ) 
Category=Request.querystring("Category")
Breed=Request.querystring("Breed")
BreedLookupID=Request.querystring("BreedLookupID")
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
PercentUSA=Request.querystring("PercentUSA") 
PercentCanadian=Request.querystring("PercentCanadian") 
PercentPeruvian=Request.querystring("PercentPeruvian") 
PercentChilean=Request.querystring("PercentChilean") 
PercentBolivian=Request.querystring("PercentBolivian") 
PercentUnknownOther=Request.querystring("PercentUnknownOther") 
PercentAccoyo=Request.querystring("PercentAccoyo") 
PercentUSA=Request.querystring("PercentUSA") 
%>
<SCRIPT LANGUAGE="JavaScript">
function verify() {
var themessage = "Please fill out the following fields: \r";
if (document.form.Name.value=="") {
themessage = themessage + " -Name \r";
}

if (document.form.Category.value=="") {
themessage = themessage + " -Category \r";
}
//alert if fields are empty and cancel form submit
if (themessage == "Please fill out the following fields: \r") {
document.form.submit();
}
else {
alert(themessage);
return false;
   }
}
//  End -->
</script>
<!--#Include file="AdminGlobalvariables.asp"--> 
</HEAD>
<body >
<!--#Include file="AdminHeader.asp"-->
<% 
Current3 = "AddAnimal"
%> 
 <!--#Include file="AdminAnimalsTabsInclude.asp"-->
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
<H1><div align = "left">Add a New Animal Wizard</div></H1>
</td></tr>
<tr><td class = "roundedBottom" align = "left">
<br />
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 bordercolor = #000000 width = "960"  align = "left">
<tr>
<td class = "body" align = "left">
<h2><font color = "brown">Basic Facts</font> <small>(* = Required Fields)</small></h2>
Please enter the following information for your alpaca. It's okay if you are missing some information except where required fields are indicated with an asterisk. 
<% Duplicate=Request.QueryString("Duplicate")
if Duplicate then %>
<div align = "left"><br /><b><font color = "brown">You already have an alpaca entered with that name. Please enter another name.</font></b></div>
<% end if %>
</td>
</tr>
<tr>
<td>
<br>
<%
if Numofspecies = 1 then
   AnimalType = SpeciesOne
end if
if SpeciesID = 2 then
  AnimalType="Alpacas" 
end if 
if SpeciesID = 3 then
  AnimalType="Dogs"
end if 
if SpeciesID = 4 then
  AnimalType="Llamas"
end if 
if SpeciesID = 5 then
  AnimalType="Horses"
end if 
if SpeciesID = 6 then
  AnimalType="Goats"
end if 
if SpeciesID = 7 then
  AnimalType="Donkeys (includes Mules & Hinnies)"
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
  AnimalType="Rabbits"
end if 
if SpeciesID = 12 then
  AnimalType="Pigs"
end if 
if  SpeciesID = 13 then
 AnimalType="Chickens"
end if 
if SpeciesID = 14 then
  AnimalType="Turkeys"
end if 
if SpeciesID = 15 then
  AnimalType="Ducks (and other Fowel)"
end if 
if  SpeciesID = 16 then
 AnimalType="Cats"
end if 
sql = "select * from SpeciesAvailable where SpeciesAvailableonSite = True Order by SpeciesPriority "
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
if not rs.eof then
  numspecies = rs.recordcount
  if numspecies = 1 then
  SpeciesID = rs("SpeciesID")
  end if
end if
if len(SpeciesID) >0 then 
sql = "select * from SpeciesAvailable where Species=  '" & AnimalType &"'"
 'response.Write("sql=" & sql)
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
if not rs.eof then
PreferedSpeciesID= rs("PreferedSpeciesID")
else
PreferedSpeciesID= ""
end if
if len(PreferedSpeciesID) > 0 then
 sql2 = "select Breed from SpeciesBreedLookupTable where BreedLookupID=" & PreferedSpeciesID
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
%>
<form  name=form method="post" action="AdminAnimalAdd2A.asp?wizard=True&PeopleID=<%=PeopleID %>">
<input type = "hidden" name = "speciesID" value = "<%=speciesID %>" />
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
<tr>
<td width = "300"  class = "body" align = "left">
<b>Full Name:*</b>
</td>
</tr>
<tr>
<td align = "left">
<input name="Name" size = "90" value="<%=Name%>">
</td>
</tr>
</table>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
<%
dim RegistrationType(100)
dim RegistrationNumber(100)
x = 0
lastx = 0
firstx = 0
if len(SpeciesID) > 0 then
else
SpeciesID = 1
end if
if len(SpeciesID) > 0 then 
 sql2 = "select * from SpeciesRegistrationTypeLookupTable where SpeciesID=" & speciesID
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3
while not(rs2.eof)  
x = x + 1%>
<% if x = 1  or x = (firstx + 4)  then
firstx = x %>
<tr>
<% end if %>
<td width = "200"  class = "body" align = "left">
<b><%=rs2("SpeciesRegistrationType")%></b><br />
<input name="RegistrationNumber(<%=x%>)" size = "20" value="">
</td>
<% if x = 4 or x = lastx + 4  then 
lastx = x%>
</tr>
<% end if %>
<% rs2.movenext
wend 
rs2.close 
end if%>
<input type = 'hidden' name="totalregistrations"  value="<%=x%>">
</table>
<table>
<tr>
<td class = "body" width = "200" align = "left">
 <% If AdministrationID  = 2 then %>
<b>Date of Birth (DD/MM/YY):</b>
<% else %>
<b>Date of Birth (MM/DD/YY):</b>
<% end if %> 

</td>
<td class = "body" width = "300" align = "left">
<b>Category:*</b>
</td>
<td class = "body" width = "300" align = "left">

</td>
</tr>
<tr>
<td align = "left">
 <% If AdministrationID  = 2 then %>
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

<select size="1" name="DOBYear">
<option value="<%=DOBYear%>" selected><%=DOBYear%></option>
<% currentyear = year(date) 
response.write(currentyear)
For yearv=1983 To currentyear %>
<option value="<%=yearv%>"><%=yearv%></option>
<% Next %></select>
<% else %>
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
response.write(currentyear)
For yearv=1983 To currentyear %>
<option value="<%=yearv%>"><%=yearv%></option>
<% Next %></select>
<% end if %> 


</td>
<td align = "left">
<% DamName = "dam"
if SpeciesID = 3 then
DamName = "bitch"
end if %>

<select size="1" name="Category">
<option name = "Category2" value= "<%=Category%>" selected><%=Category%></option>
<option name = "Category12" value="Experienced Male">Experienced Male <small>(gotten at least one <%=DamName %> pregnant)</small></option>
<option name = "Category12" value="Inexperienced Male ">Inexperienced Male <small>(never gotten a <%=DamName %> pregnant)</small></option>
<option name = "Category14" value="Experienced Female">Experienced Female <small>(has been pregnant at least once.)</small></option>
<option name = "Category13" value="Inexperienced Female">Inexperienced Female <small>(has never been pregnant)</small></option>
 <% If AdministrationID  = 2 then %>
<option name = "Category15" value="Non-Breeder">Fibre/Companion </option>
<% else %>
<option name = "Category15" value="Non-Breeder">Fiber/Companion </option>
<% end if %> 

<option name = "Category13" value="Unowned Animal">Unowned Animal<small> (a stud or progeny that is owned by another ranch)</small></option>
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
<% if SpeciesID = 4 then %>
<b>Type:*</b>
<% else %>
<b>Breed 1:*</b>
<% end if %>
</td>
<td class = "body" width = "160" align = "left">
<% if SpeciesID = 4 then %>

<% else %>
<b>Breed 2:</b>
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
sqlb = "select * from SpeciesBreedLookupTable where BreedlookupID=" & BreedID
rsb.Open sqlb, conn, 3, 3
if not rsb.eof then 
Currentbreed = rsb("BreedID")
end if
rsb.close
end if
%>
<select size="1" name="BreedID">

<% if len(BreedID) > 0 then %>
<option value="<%=BreedID %>" selected><%=Currentbreed %></option>
<% else %>
<% if len(PreferedSpeciesBreed) > 0 then %>
<option value="<%=PreferedSpeciesBreedID %>" selected><%=PreferedSpeciesBreed %></option>
<% else %>
<option value="" class="body">Select a breed</option>
<% end if
 end if



while not(rs2.eof) 
Breed = rs2("Breed") 
BreedID = rs2("BreedLookupID") %>
<% if not( Breed  = PreferedSpeciesBreed) and not(trim(Breed) = trim(Currentbreed))  then %>
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
if len(BreedlookupID2) > 0 then 
sqlb = "select * from SpeciesBreedLookupTable where BreedlookupID=" & BreedlookupID2 
rsb.Open sqlb, conn, 3, 3
if not rsb.eof then 
Currentbreed = rsb("Breed")
end if
rsb.close
end if %>

<select size="1" name="BreedID2">
<% if len(BreedlookupID2 ) > 0 then
 if BreedlookupID2 =  0 then 
  CurrentBreed = ""%>
<option value="" class="body">Select a Breed</option>
 <% else %>
<option value="<%=BreedlookupID2  %>" selected><%=CurrentBreed %></option>
<option value="0" class="body"> - </option>
<% end if %>
<% else %>
<option value="" class="body">Select a Breed</option>
<% end if %>

<% while not(rs2.eof) 
Breed = rs2("Breed") 
BreedID = rs2("BreedLookupID") %>
<% 'if not( Breed  = PreferedSpeciesBreed) and not(trim(Breed) = trim(Currentbreed))  then %>
<option value="<%= BreedID %>" class="body"><%= trim(Breed) %></option>
<%
'end if
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
<b>Breed 3:</b>
</td>
<td class = "body" width = "160" align = "left">
<b>Breed 4:</b>
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
if len(BreedlookupID3) > 0 then 
sqlb = "select * from SpeciesBreedLookupTable where BreedlookupID=" & BreedlookupID3 
rsb.Open sqlb, conn, 3, 3
if not rsb.eof then 
Currentbreed = rsb("Breed")
end if
rsb.close
end if %>
<select size="1" name="BreedID3">
<% if len(BreedlookupID3 ) > 0 then
 if BreedlookupID3 =  0 then 
  CurrentBreed = ""%>
<option value="" class="body">Select a Breed</option>
 <% else %>
<option value="<%=BreedlookupID3  %>" selected><%=CurrentBreed %></option>
<option value="0" class="body"> - </option>
<% end if %>
<% else %>
<option value="" class="body">Select a Breed</option>
<% end if %>
<% while not(rs2.eof) 
Breed = rs2("Breed") 
BreedID = rs2("BreedLookupID") %>
<% if not( Breed  = PreferedSpeciesBreed) and not(trim(Breed) = trim(Currentbreed))  then %>
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
if len(BreedlookupID4) > 0 then 
sqlb = "select * from SpeciesBreedLookupTable where BreedlookupID=" & BreedlookupID4 
rsb.Open sqlb, conn, 3, 3
if not rsb.eof then 
Currentbreed = rsb("Breed")
end if
rsb.close
end if %>
<select size="1" name="BreedID4">
<% if len(BreedlookupID4 ) > 0 then
 if BreedlookupID4 =  0 then 
 CurrentBreed = ""%>
<option value="" class="body">Select a Breed</option>
 <% else %>
<option value="<%=BreedlookupID4  %>" selected><%=CurrentBreed %></option>
<option value="0" class="body"> - </option>
<% end if %>
<% else %>
<option value="" class="body">Select a Breed</option>
<% end if %>
<% while not(rs2.eof) 
Breed = rs2("Breed") 
BreedID = rs2("BreedLookupID") %>
<% if not( Breed  = PreferedSpeciesBreed) and not(trim(Breed) = trim(Currentbreed))  then %>
<option value="<%= BreedID %>" class="body"><%= trim(Breed) %></option>
<%
end if
 rs2.movenext
wend %>
</select>
<% end if
rs2.close
%>
</td></tr>
<% end if %>
<% end if %>
</table>

<% end if %>






<table>
<tr>
<td class = "body" width = "160" align = "left">
<b>Color 1:</b>
</td>
<td class = "body" width = "160" align = "left">
<b>Color 2:</b>
</td>
<td class = "body" width = "160" align = "left">
<b>Color 3:</b>
</td>
<td class = "body" width = "160" align = "left">
<b>Color 4:</b>
</td>
<td class = "body" width = "160" align = "left">
<b>Color 5:</b>
</td>
</tr>
<tr>
<td align = "left">
<select size="1" name="Color1">
<% if len(Color1) > 0 then %>
<option  value= "<%=Color1 %>" selected><%=Color1 %></option>
<option  value= "">--</option>
<% else %>
<option  value= "" selected>--</option>
<% end if %>
<% sqlc = "select * from SpeciesColorlookupTable where SpeciesID =  " & SpeciesID & " order by SpeciesColor "
Set rsc = Server.CreateObject("ADODB.Recordset")
rsc.Open sqlc, conn, 3, 3   
while not rsc.eof	
if not rsc("SpeciesColor") = Color1 then %>
<option  value= "<%=rsc("SpeciesColor")%>" ><%=rsc("SpeciesColor")%></option>
<% end if 
rsc.movenext
wend
rsc.close
%>
</select>
</td>
<td align = "left">
<select size="1" name="Color2">
<% if len(Color1) > 0 then %>
<option  value= "<%=Color1 %>" selected><%=Color1 %></option>
<option  value= "">--</option>
<% else %>
<option  value= "" selected>--</option>
<% end if %>
<% sqlc = "select * from SpeciesColorlookupTable where SpeciesID =  " & SpeciesID & " order by SpeciesColor "
Set rsc = Server.CreateObject("ADODB.Recordset")
rsc.Open sqlc, conn, 3, 3   
while not rsc.eof	
if not rsc("SpeciesColor") = Color1 then %>
<option  value= "<%=rsc("SpeciesColor")%>" ><%=rsc("SpeciesColor")%></option>
<% end if 
rsc.movenext
wend
rsc.close
%>
</select>
</td>
<td align = "left">
<select size="1" name="Color3">
<% if len(Color1) > 0 then %>
<option  value= "<%=Color1 %>" selected><%=Color1 %></option>
<option  value= "">--</option>
<% else %>
<option  value= "" selected>--</option>
<% end if %>
<% sqlc = "select * from SpeciesColorlookupTable where SpeciesID =  " & SpeciesID & " order by SpeciesColor "
Set rsc = Server.CreateObject("ADODB.Recordset")
rsc.Open sqlc, conn, 3, 3   
while not rsc.eof	
if not rsc("SpeciesColor") = Color1 then %>
<option  value= "<%=rsc("SpeciesColor")%>" ><%=rsc("SpeciesColor")%></option>
<% end if 
rsc.movenext
wend
rsc.close
%>
</select>
</td>
<td align = "left">
<select size="1" name="Color4">
<% if len(Color1) > 0 then %>
<option  value= "<%=Color1 %>" selected><%=Color1 %></option>
<option  value= "">--</option>
<% else %>
<option  value= "" selected>--</option>
<% end if %>
<% sqlc = "select * from SpeciesColorlookupTable where SpeciesID =  " & SpeciesID & " order by SpeciesColor "
Set rsc = Server.CreateObject("ADODB.Recordset")
rsc.Open sqlc, conn, 3, 3   
while not rsc.eof	
if not rsc("SpeciesColor") = Color1 then %>
<option  value= "<%=rsc("SpeciesColor")%>" ><%=rsc("SpeciesColor")%></option>
<% end if 
rsc.movenext
wend
rsc.close
%>
</select>
</td>
<td align = "left">
<select size="1" name="Color5">
<% if len(Color1) > 0 then %>
<option  value= "<%=Color1 %>" selected><%=Color1 %></option>
<option  value= "">--</option>
<% else %>
<option  value= "" selected>--</option>
<% end if %>
<% sqlc = "select * from SpeciesColorlookupTable where SpeciesID =  " & SpeciesID & " order by SpeciesColor "
Set rsc = Server.CreateObject("ADODB.Recordset")
rsc.Open sqlc, conn, 3, 3   
while not rsc.eof	
if not rsc("SpeciesColor") = Color1 then %>
<option  value= "<%=rsc("SpeciesColor")%>" ><%=rsc("SpeciesColor")%></option>
<% end if 
rsc.movenext
wend
rsc.close
%>
</select>
</td>
</tr>
</table>
<% if SpeciesID  = 2 then %>
<table>
<tr>
<td class = "body" width = "160" align = "left">
<br><b>% USA:</b>
</td>
<td class = "body" width = "160" align = "left">
<br><b>% Canadian:</b>
</td>
<td class = "body" width = "160" align = "left">
<b>% Peruvian:</b>
</td>
<td class = "body" width = "160" align = "left">
<b>% Chilean:</b>
</td>
<td class = "body" width = "160" align = "left">
<b>% Bolivian:</b>
</td>
<td class = "body" width = "160" align = "left">
<b>% Other/Unknown:</b>
</td>
<td class = "body" width = "160" align = "left">
<b>% Accoyo</b>
</td>
</tr>
<td align = "left">
<select size="1" name="PercentUSA">
<option name = "PercentUSA" value= "<%=PercentUSA%>" selected><%=PercentUSA%></option>
<option name = "PercentUSA2" value="0">0%</option>
<option name = "PercentUSA3" value="1/8">1/8</option>
<option name = "PercentUSA4" value="1/4">1/4</option>
<option name = "PercentUSA5" value="3/8">3/8</option>
<option name = "PercentUSA6" value="1/2">1/2</option>
<option name = "PercentUSA7" value="5/8">5/8</option>
<option name = "PercentUSA8" value="3/4">3/4</option>
<option name = "PercentUSA9" value="7/8">7/8</option>
<option name = "PercentUSA" value="Full US">Full USA</option>
</select>
</td>
<td align = "left">
<select size="1" name="PercentCanadian">
<option name = "PercentCanadian" value= "<%=PercentCanadian%>" selected><%=PercentCanadian%></option>
<option name = "PercentCanadian2" value="0">0%</option>
<option name = "PercentCanadian3" value="1/8">1/8</option>
<option name = "PercentCanadian4" value="1/4">1/4</option>
<option name = "PercentCanadian5" value="3/8">3/8</option>
<option name = "PercentCanadian6" value="1/2">1/2</option>
<option name = "PercentCanadian7" value="5/8">5/8</option>
<option name = "PercentCanadian8" value="3/4">3/4</option>
<option name = "PercentCanadian9" value="7/8">7/8</option>
<option name = "PercentCanadian" value="Full Canadian">Full Canadian</option>
</select>
</td>
<td align = "left">
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
<table width = "800">
<tr>
<td  align = "right"><br />
<input type=button value = "Save & Proceed To Next Page" class="regsubmit2" <%=Disablebutton %> onclick="verify();">
</form>
</td>
</tr>
</table>
<% else %>
<table><tr><td class = "body"><b>What species is the Animal?</b></td>
<td class = "body">
<form  name=form method="post" action="AdminAnimalAdd1.asp?wizard=True&PeopleID=<%=PeopleID %>">
<select size="1" name="SpeciesID">
<% sql = "select * from SpeciesAvailable where SpeciesAvailableonSite = True Order by SpeciesPriority "
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
while not rs.eof %>
<option  value= "<%=rs("SpeciesID")%>" selected><%=rs("Species")%></option>
<% rs.movenext
wend
rs.close
%>
</select>
<input type=submit value = "Submit" class="regsubmit2" >
</Form>
</td></table>
<% end if %>
</td>
</tr>
</table>
<br></td>
</tr>
</table><br>
<!--#Include file="AdminFooter.asp"-->
</Body>
</HTML>