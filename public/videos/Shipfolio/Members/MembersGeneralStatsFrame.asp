<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<link rel="stylesheet" type="text/css" href="style.css">
<!--#Include file="MembersGlobalVariables.asp"-->


<style type="text/css">
.blink_text {
-webkit-animation-name: blinker;
-webkit-animation-duration: 2s;
-webkit-animation-timing-function: linear;
-webkit-animation-iteration-count: 1;

-moz-animation-name: blinker;
-moz-animation-duration: 2s;
-moz-animation-timing-function: linear;
-moz-animation-iteration-count: 1;

 animation-name: blinker;
 animation-duration: 2s;
 animation-timing-function: linear;
 animation-iteration-count: 1;

 color: green;
}

@-moz-keyframes blinker {  
 0% { opacity: 1.0; }
 50% { opacity: 0.2; }
 100% { opacity: 1.0; }
 }

@-webkit-keyframes blinker {  
 0% { opacity: 1.0; }
 50% { opacity: 0.2; }
 100% { opacity: 1.0; }
 }

@keyframes blinker {  
 0% { opacity: 1.0; }
 50% { opacity: 0.2; }
 100% { opacity: 1.0; }
 }
 </style>
</head>
<body>
<% screenwidth = request.querystring("screenwidth")

ID = request.QueryString("ID")
if len(ID) < 1 then
ID = Request.Form("ID")
end if


sql = "select SpeciesID, DOBMonth, DOBDay, DOBYear, Temperment, Weight, Height, Gaited, Warmblooded, BreedID, BreedID2, BreedID3, BreedID4, BreedID5, Category, FullName, BreedID, BreedID2, BreedID3, BreedID4, NumberofAnimals, Horns, Vaccinations from Animals where ID=" & ID	
rs.Open sql, conn, 3, 3
SpeciesID= rs("SpeciesID")
DOBMonth = rs("DOBMonth") 
DOBDay = rs("DOBDay")
DOBYear= rs("DOBYear")
Temperment= rs("Temperment") 
Weight = rs("Weight") 
Height = rs("Height") 
Gaited = rs("Gaited") 
Warmblooded= rs("Warmblooded")
BreedID= rs("BreedID")
BreedID2 = rs("BreedID2")
BreedID3= rs("BreedID3")
BreedID4 = rs("BreedID4")
Category = rs("Category")
Horns = rs("Horns")
name = rs("FullName")
BreedlookupID  = rs("BreedID")
BreedlookupID2  = rs("BreedID2")
BreedlookupID3  = rs("BreedID3")  
BreedlookupID4  = rs("BreedID4")
NumberofAnimals = rs("NumberofAnimals") 
Vaccinations = rs("Vaccinations")
if len(NumberofAnimals) > 0 then
else
NumberofAnimals = 1
end if
rs.close


if SpeciesID = 2 then
SpeciesName="Alpaca" 
end if 
if SpeciesID = 3 then
SpeciesName="Dog"
end if 
if SpeciesID = 4 then
SpeciesName="Llama"
end if 
if SpeciesID = 5 then
SpeciesName="Horse"
end if 
if SpeciesID = 6 then
SpeciesName="Goat"
end if 
if SpeciesID = 7 then
SpeciesName="Donkey"
end if 
if SpeciesID = 8 then
SpeciesName="Cattle"
end if 
if SpeciesID = 9 then
SpeciesName="Bison"
end if 
if SpeciesID = 10 then
SpeciesName="Sheep"
end if 
if SpeciesID = 11 then
SpeciesName="Rabbit"
end if 
if SpeciesID = 12 then
SpeciesName="Pig"
end if 
if  SpeciesID = 13 then
SpeciesName="Chicken"
end if 
if SpeciesID = 14 then
SpeciesName="Turkey"
end if 
if SpeciesID = 15 then
SpeciesName="Duck"
end if 
if  SpeciesID = 16 then
SpeciesName="Cat"
end if 
if  SpeciesID = 17 then
SpeciesName="Yak"
end if 
if  SpeciesID = 19 then
SpeciesName="Emu"
end if 

'response.write("len SpeciesID=" & len(SpeciesID) & "!")
if len(SpeciesID) >0 then
else
SpeciesID = 2
SpeciesName="Alpaca" 
end if


sql = "select * from SpeciesAvailable where SpeciesID=  " & SpeciesID &""
rs.Open sql, conn, 3, 3   
if not rs.eof then
SpeciesSalesType = rs("SpeciesSalesType")
'response.write("SpeciesSalesType=" & SpeciesSalesType )
end if
rs.close


sql = "select PercentBolivian, PercentChilean, PercentUnknownOther, PercentAccoyo, PercentPeruvian from AncestryPercents where ID=" & ID
rs.Open sql, conn, 3, 3
If rs.eof then
Query =  "INSERT INTO AncestryPercents (ID)" 
Query =  Query & " Values (" &  ID & ")"
Conn.Execute(Query) 
rs.close

sql = "select PercentBolivian, PercentChilean, PercentUnknownOther, PercentAccoyo, PercentPeruvian from AncestryPercents where ID=" & ID
rs.Open sql, conn, 3, 3
End If 
PercentPeruvian = rs("PercentPeruvian")
PercentAccoyo = rs("PercentAccoyo")
PercentBolivian = rs("PercentBolivian")
PercentChilean = rs("PercentChilean")
PercentUnknownOther = rs("PercentUnknownOther") 

rs.close

sql = "select Color1, Color2, Color3, Color4, Color5 from Colors where ID=" & ID
rs.Open sql, conn, 3, 3
If rs.eof then
Query =  "INSERT INTO Colors (ID)" 
Query =  Query & " Values (" &  ID & ")"
Conn.Execute(Query) 
rs.close

sql = "select Color1, Color2, Color3, Color4, Color5 from Colors where ID=" & ID
'response.write("sql=" & sql)
rs.Open sql, conn, 3, 3
End If 
Color1 = rs("Color1")
Color2 = rs("Color2")
Color3 = rs("Color3")
Color4 = rs("Color4")
Color5 = rs("Color5")
rs.close
%>

<a name="BasicFacts"></a>

 <div class = "row" >
   <div class="col-12">
        <H1><div align = "left">Basic Facts</div></H1>
        <% changesmade = request.querystring("changesmade")
        if changesmade = "True" then %>
            <div align = "left"><font class="blink_text"><b>Your Basic Fact Changes Have Been Made.</b></font></div>
        <% end if %>

        <form action= 'MembersGeneralStatsHandle.asp' method = "post" name = "g1">
    </div>
</div>
 <div class = "row" >
   <div class="col-12 body">	
        <b># Animals in Listing</b><br />
<select size="1" name="NumberofAnimals" class = 'formbox'>
<% if len(NumberofAnimals) > 0 then %>
<option  value= "<%=NumberofAnimals %>" selected><%=NumberofAnimals%></option>
<% if NumberofAnimals = "1" then
else %>
<option  value= "1" >1</option>
<% end if %>
<% else %>
<option  value= "1" selected>1</option>
<% end if %>
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
</select>
    </div>
</div>
 <div class = "row" >
   <div class="col-2 body">	
        <a class="tooltip " href="#"><b>Name / Title</b><b><font color = "maroon">*</font></b><br />
        <span class="custom info"><em>Name /Title</em>This can be a full name like <i>XYZ Ranches Peruvian MagaStud</i> or a title like <i>5 Registered Brown Boars</i></span></a>
        <% str1 = name
           str2 = """"
           If InStr(str1,str2) > 0 Then
	        name = Replace(str1, """", "''")
            End If %>
	        <input name="Name" size = "40" value = "<%=Name%>" class = 'formbox'>

    </div>
</div>
<% if  NumberofAnimals = "1" and not(Category = "Preborn Male" or Category = "Preborn Female" or Category = "Preborn Baby" or Category = "Preborn Male" or Category = "Preborn Female" or Category = "Preborn Baby") then %>
 <div class = "row" >
   <div class="col-12 body">	
    <b>Date of Birth</b><br />
 <select size="1" name="DOBMonth" class = 'formbox'>
<% 'DOBMonth = rs("DOBMonth")
if DOBMonth > 0 then  %>
	<option value="<%=DOBMonth %>" selected><%=DOBMonth %></option>
<% else %>
	<option value="0" selected>-</option>
<% end if %>
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
<select size="1" name="DOBDay" class = 'formbox'>
<% 'DOBDay = rs("DOBDay")
if DOBMonth > 0 then  %>
	<option value="<%=DOBDay %>" selected><%=DOBDay %></option>
<% else %>
	<option value="0" selected>-</option>
<% end if %>
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

<select size="1" name="DOBYear" class = 'formbox'>
<% 'DOBYear = rs("DOBYear")
if DOBYear > 0 then  %>
<option value="<%=DOBYear %>" selected><%=DOBYear %></option>
<% else %>
<option value="0" selected>-</option>
<% end if %>
<% currentyear = year(date) 
For yearv=1983 To currentyear %>
<option value="<%=yearv%>"><%=yearv%></option>
<% Next %></select>

<% end if %>
   </div>
</div>

<% if  NumberofAnimals = "1" and not(Category = "Preborn Male" or Category = "Preborn Female" or Category = "Preborn Baby" or Category = "Preborn Male" or Category = "Preborn Female" or Category = "Preborn Baby" or species = 22 or speciesis = 19 or speciesid = 15 or speciesid = 14 or speciesid = 13) then %>
 <div class = "row" >
   <div class="col-12">	
        <a class="tooltip body" href="#"><b>Temperament</b><span class="custom info"><em>Temperament</em>1=Very Calm, 10=Very High-Spirited</span></a><br />
<select size="1" name="Temperment" class = 'formbox'>
<% if len(Temperment) > 0 then
if Temperment = "0" then
Temperment = ""
end if %>
<option  value= "<%=Temperment%>" selected><%=Temperment%></option>
<option  value= "">-</option>
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
    </div>
  </div>
<% end if %>

 <div class = "row" >
   <div class="col-12">	

<b>Category</b><br />
<% if len(NumberofAnimals) > 0 then
    else
    NumberofAnimals = "1"
    end if
%>

<% if SpeciesSalesType = "Fowl" then %>
<%
if NumberofAnimals = "1" then 
If category = "Experienced Male" then showncategory = "Adult Male"
If category = "Experienced Female" then showncategory = "Adult Female"
If category = "Inexperienced Male" then showncategory = "Male Chick"
If category = "Inexperienced Female" then showncategory = "Female Chick"
If category = "Preborn Baby" then showncategory = "Eggs"
If category = "Preborn Male" then showncategory = "Preborn Male Chick"
If category = "Preborn Female" then showncategory = "Preborn Female Chick"
%>
<select size="1" name="Category" class = 'formbox' width="330" style="width: 330px">
<option value= "<%=Category%>" selected><%=showncategory%></option>
<option value="Preborn Baby">Eggs</option>
<option value="Experienced Male">Adult Male</option>
<option value="Experienced Female">Adult Female</option>
<option value="Inexperienced Male">Male Chick</option>
<option value="Inexperienced Female">Female Chick</option>
</select>
<% else
If category = "Experienced Males" or category = "Experienced Male" then showncategory = "Adult Males"
If category = "Experienced Females" or category = "Experienced Female" then showncategory = "Adult Females"
If category = "Inexperienced Males" or category = "Inexperienced Male" then showncategory = "Male Chicks"
If category = "Inexperienced Females" or category = "Inexperienced Female" then showncategory = "Female Chicks"
If category = "Preborn Babies" or category = "Preborn Baby" then showncategory = "Eggs"
If category = "Preborn Males" or category = "Preborn Males" then showncategory = "Preborn Male Chicks"
If category = "Preborn Females" or category = "Preborn Female" then showncategory = "Preborn Female Chicks"
 %>
 <select size="1" name="Category" class = 'formbox' width="330" style="width: 330px">
<option value= "<%=Category%>" selected><%=showncategory%></option>
<option value="Preborn Babies">Eggs</option>
<option value="Experienced Males">Adult Males</option>
<option value="Experienced Females">Adult Females</option>
<option value="Inexperienced Males">Male Chicks</option>
<option value="Inexperienced Females">Female Chicks</option>
</select>

<% end if %>
<% else %>
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

<% end if %>


</div>
</div>
 <div class = "row" >
   <div class="col-12">	
   <b>Species</b><br>

<% dim SpeciesIDList(100)
dim SingularTermList(100)
speciescount = 0
Set rs2 = Server.CreateObject("ADODB.Recordset")
sql2 = "select * from SpeciesAvailable where SpeciesAvailable  = 1 Order by Species "
rs2.Open sql2, conn, 3, 3   
while not rs2.eof
speciescount = speciescount + 1
SpeciesIDlist(speciescount) = rs2("SpeciesID")
SingularTermList(speciescount) = rs2("Species")

rs2.movenext
wend
rs2.close
%>

<select size="1" name="SpeciesID" class = 'formbox'>
<%
 if len(SpeciesName) > 0 then %>
<option value="<%=SpeciesID %>" selected><%=SpeciesName %></option>
<% end if %>
<% 
i = 0
while i < speciescount
i = i + 1%>
<option value="<%=SpeciesIDlist(i) %>" ><%=SingularTermList(i) %></option>

<% wend %>
</select>

</div>
</div>
 <div class = "row" >
   <div class="col-12">	
    <br />
    <%  if SpeciesID = 5 or SpeciesID = 8 then %>
    <b>Height</b><br />
    <input name="Height" size = "10" value="<%=Height%>" class = 'formbox'><br />
    <b>Weight</b><br />
    <input name="Weight" size = "10" value="<%=Weight%>" class = 'formbox'>
    <% if SpeciesID = 8 or SpeciesID = 9 or SpeciesID = 17 then %>
    <b>Horns</b>
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
  </select>
<% end if %>

<% if SpeciesID = 5 then %>
    <b>Gaited</b><br />
    <select size="1" name="Gaited" class = 'formbox'>
        <% if len(Gaited) > 1 then  %>
            <option value="<%=Gaited%>" selected><%=Gaited%></option>
            <option value="">Not Set</option>
        <% else %>
            <option value="">Not Set</option>
        <% end if %>
            <option value="Yes">Yes</option>
            <option  value="No">No</option>
    </select>

<b>Warmblood</b><br />

<select size="1" name="Warmblooded" class = 'formbox'>
<% if len(Warmblooded) > 1 then  %>
<option value="<%=Warmblooded%>" selected><%=Warmblooded%></option>
<option value="">Not Set</option>
<% else %>
<option value="">Not Set</option>
<% end if %>
<option value="Yes">Yes</option>
<option  value="No">No</option>
</select>


<% end if %>

<% end if %>


<%
dim RegistrationType(100)
dim RegistrationNumber(100)
x = 0
Set rs3 = Server.CreateObject("ADODB.Recordset")

if len(SpeciesID) > 0 then 
 sql2 = "select * from SpeciesRegistrationTypeLookupTable where SpeciesID=" & speciesID & " order by SpeciesRegistrationType"
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3
while not(rs2.eof)  
RegNumber = ""
SpeciesRegistrationType = rs2("SpeciesRegistrationType")
sql3 = "select * from Animalregistration where RegType = '" & SpeciesRegistrationType & "' and AnimalID = " & ID
rs3.Open sql3, conn, 3, 3   
if not rs3.eof then
RegNumber = rs3("Regnumber")
else
rs3.close

Query =  "INSERT INTO Animalregistration (RegType, AnimalID)" 
Query =  Query & " Values ('" & SpeciesRegistrationType & "' ,"
Query =  Query &   " " & ID & " )" 
Conn.Execute(Query) 

end if
if rs3.state = 0 then
else
rs3.close
end if

x = x + 1%>
<% if x = 1  or  x = 5 or x = 9 or x = 13 or  x = 17 or x = 21 or x = 25 or x = 29 then %>
 <div class = "row" >
<% end if %>
   <div class="col-12">	
<b><%=SpeciesRegistrationType %></b><br />
<input name="SpeciesRegistrationType(<%=x%>)"  type = "hidden" value="<%=SpeciesRegistrationType %>" >
<input name="RegistrationNumber(<%=x%>)" size = "20" value="<%= RegNumber%>" class='formbox'>
</div>
<% if x = 4  or  x = 8 or  x = 12 or  x = 16  or  x = 20  or  x = 24 or  x = 28 or x = (rs2.recordcount + 1) then %>
</div>
<% end if %>
<% rs2.movenext
wend 
rs2.close 	
end if%>	
<input type = 'hidden' name="totalregistrations"  value="<%=x%>">
<% 
if SpeciesId > 0 then
else
SpeciesID  =2
end if
speciesIDfound = false
sql2 = "select * from SpeciesBreedLookupTable where breedavailable = 1 and SpeciesID=" & speciesID & " Order by Breed"
'response.write("sql2=" & sql2 )
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3
if not rs2.eof then 
speciesIDfound = True
end if
rs2.close
if speciesIDfound = True then
%>

<div class = "row">
   <div class="col-12">	
<% if SpeciesID = 4 then %>
<b>Type<b><font color = "maroon">*</font></b></b>
<% else %>
<b>Breed 1<b><font color = "maroon">*</font></b>
<% end if %>
<br />


<% 
Set rsb = Server.CreateObject("ADODB.Recordset")
'if SpeciesID = 3 then
'sql2 = "select * from SpeciesBreedLookupTable where BreedLookupID = 10 or BreedLookupID = 12 or BreedLookupID = 16 or BreedLookupID = 17 or BreedLookupID = 28 or BreedLookupID =32 or BreedLookupID = 41 or BreedLookupID = 51 or BreedLookupID = 64 or BreedLookupID = 65 or BreedLookupID = 66 or BreedLookupID = 67 or BreedLookupID = 68 or BreedLookupID = 72 or BreedLookupID = 79 or BreedLookupID = 84 or BreedLookupID =87 or BreedLookupID = 96 or BreedLookupID = 109 or BreedLookupID = 114 or BreedLookupID = 118 or BreedLookupID = 120 or BreedLookupID = 125 or BreedLookupID = 127 or BreedLookupID = 128 or BreedLookupID = 130 or BreedLookupID = 154 or BreedLookupID = 161 or BreedLookupID = 162 or BreedLookupID = 168 or BreedLookupID = 170 or BreedLookupID = 176 or BreedLookupID = 179 or BreedLookupID = 188 or BreedLookupID = 201 or BreedLookupID = 202 or BreedLookupID = 207 or BreedLookupID = 216 or BreedLookupID = 217 or BreedLookupID = 218 or BreedLookupID = 231 or BreedLookupID = 239 or BreedLookupID = 264 or BreedLookupID = 270 or BreedLookupID = 273 or BreedLookupID = 280 or BreedLookupID = 282 or BreedLookupID = 289 or BreedLookupID = 299 or BreedLookupID = 302 or BreedLookupID = 318 or BreedLookupID = 319 or BreedLookupID = 331 or BreedLookupID = 333 or BreedLookupID = 341 or BreedLookupID = 353 or BreedLookupID = 354 or BreedLookupID = 361 or BreedLookupID = 369 or BreedLookupID = 377 or BreedLookupID = 384 or BreedLookupID = 386 or BreedLookupID = 394 or BreedLookupID = 402 or BreedLookupID = 406 or BreedLookupID = 410 or BreedLookupID = 411 or BreedLookupID = 427 or BreedLookupID = 428 or BreedLookupID = 442 or BreedLookupID = 458 or BreedLookupID = 467 or BreedLookupID = 893 or BreedLookupID = 1023 or BreedLookupID = 1487 order by Breed"
'else
sql2 = "select * from SpeciesBreedLookupTable where breedavailable = 1 and  SpeciesID=" & speciesID & " Order by trim(Breed)"
'end if

rs2.Open sql2, conn, 3, 3
if not rs2.eof then 

if len(BreedLookupID) > 0 then 
sqlb = "select * from SpeciesBreedLookupTable where breedavailable = 1 and BreedlookupID=" & BreedlookupID 
rsb.Open sqlb, conn, 3, 3
if not rsb.eof then 
Currentbreed = rsb("Breed")
end if
rsb.close
end if
%>
<select size="1" name="BreedID" class = 'formbox'>

<% if len(Currentbreed) > 0 then %>
<option value="<%=BreedlookupID %>" selected><%=Currentbreed %></option>
<option value="0" >-</option>
<% else %>
<% if len(PreferedSpeciesBreed) > 0 then %>
<option value="<%=PreferedSpeciesBreed %>" selected><%=PreferedSpeciesBreed %></option>
<% else %>
<option value="0" >-</option>
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
</select><br />

<% if SpeciesID = 4  then 
 else %>
<b>Breed 2</b><br />

<%' if SpeciesID = 3 then
'sql2 = "select * from SpeciesBreedLookupTable where BreedLookupID = 10 or BreedLookupID = 12 or BreedLookupID = 16 or BreedLookupID = 17 or BreedLookupID = 28 or BreedLookupID =32 or BreedLookupID = 41 or BreedLookupID = 51 or BreedLookupID = 64 or BreedLookupID = 65 or BreedLookupID = 66 or BreedLookupID = 67 or BreedLookupID = 68 or BreedLookupID = 72 or BreedLookupID = 79 or BreedLookupID = 84 or BreedLookupID =87 or BreedLookupID = 96 or BreedLookupID = 109 or BreedLookupID = 114 or BreedLookupID = 118 or BreedLookupID = 120 or BreedLookupID = 125 or BreedLookupID = 127 or BreedLookupID = 128 or BreedLookupID = 130 or BreedLookupID = 154 or BreedLookupID = 161 or BreedLookupID = 162 or BreedLookupID = 168 or BreedLookupID = 170 or BreedLookupID = 176 or BreedLookupID = 179 or BreedLookupID = 188 or BreedLookupID = 201 or BreedLookupID = 202 or BreedLookupID = 207 or BreedLookupID = 216 or BreedLookupID = 217 or BreedLookupID = 218 or BreedLookupID = 231 or BreedLookupID = 239 or BreedLookupID = 264 or BreedLookupID = 270 or BreedLookupID = 273 or BreedLookupID = 280 or BreedLookupID = 282 or BreedLookupID = 289 or BreedLookupID = 299 or BreedLookupID = 302 or BreedLookupID = 318 or BreedLookupID = 319 or BreedLookupID = 331 or BreedLookupID = 333 or BreedLookupID = 341 or BreedLookupID = 353 or BreedLookupID = 354 or BreedLookupID = 361 or BreedLookupID = 369 or BreedLookupID = 377 or BreedLookupID = 384 or BreedLookupID = 386 or BreedLookupID = 394 or BreedLookupID = 402 or BreedLookupID = 406 or BreedLookupID = 410 or BreedLookupID = 411 or BreedLookupID = 427 or BreedLookupID = 428 or BreedLookupID = 442 or BreedLookupID = 458 or BreedLookupID = 467 or BreedLookupID = 893 or BreedLookupID = 1023 or BreedLookupID = 1487 order by Breed"
'else
sql2 = "select * from SpeciesBreedLookupTable where breedavailable = 1 and SpeciesID=" & speciesID & " Order by trim(Breed)"
'end if 
rs2.Open sql2, conn, 3, 3
if not rs2.eof then 
if len(BreedlookupID2) > 0 then 
sqlb = "select * from SpeciesBreedLookupTable where breedavailable = 1 and  BreedlookupID=" & BreedlookupID2 
rsb.Open sqlb, conn, 3, 3
if not rsb.eof then 
Currentbreed = rsb("Breed")
end if
rsb.close
end if %>

<select size="1" name="BreedID2" class = 'formbox'>
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
</div>
</div>

<% if not(speciesID= 2 ) then%>
<div class = "row">
    <div class="col-12">
        <b>Breed 3</b><br />

<% 'if SpeciesID = 3 then
'sql2 = "select * from SpeciesBreedLookupTable where BreedLookupID = 10 or BreedLookupID = 12 or BreedLookupID = 16 or BreedLookupID = 17 or BreedLookupID = 28 or BreedLookupID =32 or BreedLookupID = 41 or BreedLookupID = 51 or BreedLookupID = 64 or BreedLookupID = 65 or BreedLookupID = 66 or BreedLookupID = 67 or BreedLookupID = 68 or BreedLookupID = 72 or BreedLookupID = 79 or BreedLookupID = 84 or BreedLookupID =87 or BreedLookupID = 96 or BreedLookupID = 109 or BreedLookupID = 114 or BreedLookupID = 118 or BreedLookupID = 120 or BreedLookupID = 125 or BreedLookupID = 127 or BreedLookupID = 128 or BreedLookupID = 130 or BreedLookupID = 154 or BreedLookupID = 161 or BreedLookupID = 162 or BreedLookupID = 168 or BreedLookupID = 170 or BreedLookupID = 176 or BreedLookupID = 179 or BreedLookupID = 188 or BreedLookupID = 201 or BreedLookupID = 202 or BreedLookupID = 207 or BreedLookupID = 216 or BreedLookupID = 217 or BreedLookupID = 218 or BreedLookupID = 231 or BreedLookupID = 239 or BreedLookupID = 264 or BreedLookupID = 270 or BreedLookupID = 273 or BreedLookupID = 280 or BreedLookupID = 282 or BreedLookupID = 289 or BreedLookupID = 299 or BreedLookupID = 302 or BreedLookupID = 318 or BreedLookupID = 319 or BreedLookupID = 331 or BreedLookupID = 333 or BreedLookupID = 341 or BreedLookupID = 353 or BreedLookupID = 354 or BreedLookupID = 361 or BreedLookupID = 369 or BreedLookupID = 377 or BreedLookupID = 384 or BreedLookupID = 386 or BreedLookupID = 394 or BreedLookupID = 402 or BreedLookupID = 406 or BreedLookupID = 410 or BreedLookupID = 411 or BreedLookupID = 427 or BreedLookupID = 428 or BreedLookupID = 442 or BreedLookupID = 458 or BreedLookupID = 467 or BreedLookupID = 893 or BreedLookupID = 1023 or BreedLookupID = 1487 order by Breed"
'else
sql2 = "select * from SpeciesBreedLookupTable where breedavailable = 1 and SpeciesID=" & speciesID & " Order by trim(Breed)"
'end if 
rs2.Open sql2, conn, 3, 3
if not rs2.eof then 
if len(BreedlookupID3) > 0 then 
sqlb = "select * from SpeciesBreedLookupTable where breedavailable = 1 and BreedlookupID=" & BreedlookupID3 
rsb.Open sqlb, conn, 3, 3
if not rsb.eof then 
Currentbreed = rsb("Breed")
end if
rsb.close
end if %>
<select size="1" name="BreedID3" class = 'formbox'>
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
</div>
</div>
<div class = "row">
    <div class="col-12">
        <b>Breed 4</b><br />
<% 'if SpeciesID = 3 then
'sql2 = "select * from SpeciesBreedLookupTable where BreedLookupID = 10 or BreedLookupID = 12 or BreedLookupID = 16 or BreedLookupID = 17 or BreedLookupID = 28 or BreedLookupID =32 or BreedLookupID = 41 or BreedLookupID = 51 or BreedLookupID = 64 or BreedLookupID = 65 or BreedLookupID = 66 or BreedLookupID = 67 or BreedLookupID = 68 or BreedLookupID = 72 or BreedLookupID = 79 or BreedLookupID = 84 or BreedLookupID =87 or BreedLookupID = 96 or BreedLookupID = 109 or BreedLookupID = 114 or BreedLookupID = 118 or BreedLookupID = 120 or BreedLookupID = 125 or BreedLookupID = 127 or BreedLookupID = 128 or BreedLookupID = 130 or BreedLookupID = 154 or BreedLookupID = 161 or BreedLookupID = 162 or BreedLookupID = 168 or BreedLookupID = 170 or BreedLookupID = 176 or BreedLookupID = 179 or BreedLookupID = 188 or BreedLookupID = 201 or BreedLookupID = 202 or BreedLookupID = 207 or BreedLookupID = 216 or BreedLookupID = 217 or BreedLookupID = 218 or BreedLookupID = 231 or BreedLookupID = 239 or BreedLookupID = 264 or BreedLookupID = 270 or BreedLookupID = 273 or BreedLookupID = 280 or BreedLookupID = 282 or BreedLookupID = 289 or BreedLookupID = 299 or BreedLookupID = 302 or BreedLookupID = 318 or BreedLookupID = 319 or BreedLookupID = 331 or BreedLookupID = 333 or BreedLookupID = 341 or BreedLookupID = 353 or BreedLookupID = 354 or BreedLookupID = 361 or BreedLookupID = 369 or BreedLookupID = 377 or BreedLookupID = 384 or BreedLookupID = 386 or BreedLookupID = 394 or BreedLookupID = 402 or BreedLookupID = 406 or BreedLookupID = 410 or BreedLookupID = 411 or BreedLookupID = 427 or BreedLookupID = 428 or BreedLookupID = 442 or BreedLookupID = 458 or BreedLookupID = 467 or BreedLookupID = 893 or BreedLookupID = 1023 or BreedLookupID = 1487 order by Breed"
'else
sql2 = "select * from SpeciesBreedLookupTable where breedavailable = 1 and SpeciesID=" & speciesID & " Order by trim(Breed)"
'end if 
rs2.Open sql2, conn, 3, 3
if not rs2.eof then 
if len(BreedlookupID4) > 0 then 
sqlb = "select * from SpeciesBreedLookupTable where breedavailable = 1 and BreedlookupID=" & BreedlookupID4 
rsb.Open sqlb, conn, 3, 3
if not rsb.eof then 
Currentbreed = rsb("Breed")
end if
rsb.close
end if %>
<select size="1" name="BreedID4" class = 'formbox'>
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
</div></div>
<% end if %>
<% end if %>

<% end if %>

<% if len(SpeciesName) > 0 and not(speciesid = 22 or speciesid = 19 or speciesid = 15 or speciesid = 14 or speciesid = 13) then %>
<div class = "row" >
	<div >
	<b>Color 1</b><br>
        <% sqlc = "select * from SpeciesColorlookupTable where SpeciesID =  " & SpeciesID & " order by SpeciesColor "
            Set rsc = Server.CreateObject("ADODB.Recordset")
            rsc.Open sqlc, conn, 3, 3  %>
                <select size="1" name="Color1" class = 'formbox'>
                <% if len(Color1) > 0 then %>
                <option  value= "<%=Color1 %>" selected><%=Color1 %></option>
                <option  value= "">--</option>
                <% else %>
                <option  value= "" selected>--</option>
                <% end if %>

            <% while not rsc.eof  %>
                <option  value= "<%=rsc("SpeciesColor")%>" ><%=rsc("SpeciesColor")%></option>
                <% rsc.movenext
             wend %>
            </select>

    </div>
</div>
<div class = "row" >
	<div >
	<b>Color 2</b><br>
        <% sqlc = "select * from SpeciesColorlookupTable where SpeciesID =  " & SpeciesID & " order by SpeciesColor "
            Set rsc = Server.CreateObject("ADODB.Recordset")
            rsc.Open sqlc, conn, 3, 3  %>
                <select size="1" name="Color2" class = 'formbox'>
                <% if len(Color2) > 0 then %>
                <option  value= "<%=Color2 %>" selected><%=Color2 %></option>
                <option  value= "">--</option>
                <% else %>
                <option  value= "" selected>--</option>
                <% end if %>

            <% while not rsc.eof  %>
                <option  value= "<%=rsc("SpeciesColor")%>" ><%=rsc("SpeciesColor")%></option>
                <% rsc.movenext
             wend %>
            </select>

    </div>
</div>
<div class = "row" >
	<div >
	<b>Color 3</b><br>
        <% sqlc = "select * from SpeciesColorlookupTable where SpeciesID =  " & SpeciesID & " order by SpeciesColor "
            Set rsc = Server.CreateObject("ADODB.Recordset")
            rsc.Open sqlc, conn, 3, 3  %>
                <select size="1" name="Color3" class = 'formbox'>
                <% if len(Color3) > 0 then %>
                <option  value= "<%=Color3 %>" selected><%=Color3 %></option>
                <option  value= "">--</option>
                <% else %>
                <option  value= "" selected>--</option>
                <% end if %>

            <% while not rsc.eof  %>
                <option  value= "<%=rsc("SpeciesColor")%>" ><%=rsc("SpeciesColor")%></option>
                <% rsc.movenext
             wend %>
            </select>

    </div>
</div>


<% if not speciesid = 9 then %>
<div class = "row" >
	<div >
	<b>Color 4</b><br>
        <% sqlc = "select * from SpeciesColorlookupTable where SpeciesID =  " & SpeciesID & " order by SpeciesColor "
            Set rsc = Server.CreateObject("ADODB.Recordset")
            rsc.Open sqlc, conn, 3, 3  %>
                <select size="1" name="Color4" class = 'formbox'>
                <% if len(Color4) > 0 then %>
                <option  value= "<%=Color4 %>" selected><%=Color4 %></option>
                <option  value= "">--</option>
                <% else %>
                <option  value= "" selected>--</option>
                <% end if %>

            <% while not rsc.eof  %>
                <option  value= "<%=rsc("SpeciesColor")%>" ><%=rsc("SpeciesColor")%></option>
                <% rsc.movenext
             wend %>
            </select>

    </div>
</div>
<% end if %>

<% if not speciesid = 9 then %>
<div class = "row" >
	<div >
	<b>Color 5</b><br>
        <% sqlc = "select * from SpeciesColorlookupTable where SpeciesID =  " & SpeciesID & " order by SpeciesColor "
            Set rsc = Server.CreateObject("ADODB.Recordset")
            rsc.Open sqlc, conn, 3, 3  %>
                <select size="1" name="Color5" class = 'formbox'>
                <% if len(Color5) > 0 then %>
                <option  value= "<%=Color5 %>" selected><%=Color5 %></option>
                <option  value= "">--</option>
                <% else %>
                <option  value= "" selected>--</option>
                <% end if %>

            <% while not rsc.eof  %>
                <option  value= "<%=rsc("SpeciesColor")%>" ><%=rsc("SpeciesColor")%></option>
                <% rsc.movenext
             wend %>
            </select>

    </div>
</div>
<% end if %>


<% 


if SpeciesId =2 then %>
<div>
	<div>
	<b>% Peruvian</b><br />
    <select size="1" name="PercentPeruvian" class = 'formbox'>
	<option value = "<%=PercentPeruvian %>" selected><%=PercentPeruvian %></option>
	<option value="0">0%</option>
	<option  value="1/8">1/8</option>
     <option value="1/4">1/4</option>
     <option value="3/8">3/8</option>
     <option  value="1/2">1/2</option>
     <option  value="5/8">5/8</option>
     <option value="3/4">3/4</option>
     <option  value="7/8">7/8</option>
	  <option value="Full Peruvian">Full Peruvian</option>
	 </select>
   </div>
</div>
<div>
	<div>
	<b>% Chilean</b><br />
    <select size="1" name="PercentChilean" class = 'formbox'>
	<option value= "<%=PercentChilean%>" selected><%=PercentChilean%></option>
	<option value="0">0%</option>
	<option value="1/8">1/8</option>
    <option value="1/4">1/4</option>
    <option value="3/8">3/8</option>
    <option value="1/2">1/2</option>
    <option value="5/8">5/8</option>
    <option value="3/4">3/4</option>
    <option value="7/8">7/8</option>
    <option  value="Full Chilean">Full Chilean</option>
 </select>
   </div>
</div>
<div>
	<div>
	<b>% Bolivian</b><br>
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
	  <option name = "PercentBolivian10" value="Full Bolivian">Full Bolivian</option>
	 </select>
   </div>
</div>
<div>
	<div>
	<b>% Other/Unknown</b><br>
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
	  <option name = "PercentUnknownOther10" value="100% Unknown">100% Unknown or Other</option>
	 </select>
   </div>
</div>
<div>
	<div>
	<b>% Accoyo</b><br>
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
	  <option name = "PercentAccoyo10" value="Full Accoyo">Full Accoyo</option>
	 </select>
   </div>
</div>


<% end if %>
<% end if %>
	
<div>
    <div>
    	<b>Vaccinations</b><br>
        	<textarea name="Vaccinations" ID="Vaccinations" cols="45" rows="8" wrap="VIRTUAL" class="form-control"><%= Vaccinations%></textarea>	

    </div>
</div>
<div>
	<div>
	    <input type = "hidden" name="FormID" value= "GeneralStats">	
        <input type = "hidden" name="ID" value= "<%= ID%>">	
    	<input type="submit" class = "regsubmit2" value="SUBMIT BASIC FACT CHANGES"  >
    <BR><BR>
</div>
</div>

</form>


</body>
</html>
<%conn.close
set Conn = nothing %>