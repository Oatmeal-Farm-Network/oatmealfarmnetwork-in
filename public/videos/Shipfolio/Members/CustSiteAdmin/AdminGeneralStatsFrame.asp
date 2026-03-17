<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<link rel="stylesheet" type="text/css" href="style.css">
<!--#Include file="AdminGlobalVariables.asp"-->
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

<% dim	IDArray(9999) 
dim	alpacaName(9999) 
ID = request.QueryString("ID")
if len(ID) < 1 then
ID = Request.Form("ID")
end if
%>
<% If Len(ID) > 0 and ShowLOA = True and AutoTransfer = True then %>
	<!--#Include virtual="/Administration/Transfers/GatherAnimalData.asp"-->
	<!--#Include virtual="/Administration/Transfers/TransferMovedata.asp"-->
<% end if %>
 <!--#Include virtual="/administration/adminDetailDBInclude.asp"--> 
<% Set rs2 = Server.CreateObject("ADODB.Recordset")
Set rs3 = Server.CreateObject("ADODB.Recordset")%>
 <a name="BasicFacts"></a><table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%"><tr><td class = "roundedtop" align = "left">
<H1><div align = "left">Basic Facts</div></H1>
</td></tr>
<tr><td class = "roundedBottom" align = "center">
<% changesmade = request.querystring("changesmade")
if changesmade = "True" then %>
<div align = "left"><font class="blink_text"><b>Your Basic Facts Changes Have Been Made.</b></font></div>
<% end if %>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 bordercolor = "" align = "center" width = "100%">
<tr><td>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 bordercolor = "" align = "center" width = "100%">
<tr>
<td width = "10">&nbsp;</td>
<td>
<form action= 'AdminGeneralStatsHandle.asp' method = "post" name = "g1">
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "left">
<tr>
<td width = "300"  class = "body" align = "left">	
<br><b>Full Name:</b>
</td>
<td class = "body" width = "170" align = "left" >
<a class="tooltip" href="#"><b>Temperament</b><span class="custom info"><em>Temperament</em>1=Very Calm, 10=Very High-Spirited</span></a>
</td>


<td class = "body" width = "200" align = "left">
 <% If AdministrationID  = 2 then %>
<b>Date of Birth (DD/MM/YY):</b>
<% else %>
<b>Date of Birth (MM/DD/YY):</b>
<% end if %> 
</td>
<td class = "body" width = "170" align = "left" >

</td>
</tr>
<tr>
<td align = "left">
<% 
str1 = name
str2 = """"
If InStr(str1,str2) > 0 Then
	name = Replace(str1, """", "''")
End If
%>
<input name="Name" size = "40" value = "<%=name%>">
</td>
<td align = "left">
	<select size="1" name="Temperment">
<% if len(Temperment) > 0 then 
if Temperment = 0 then
Temperment = ""
end if
%>
<option  value= "<%=Temperment%>" selected><%=Temperment%></option>
<option  value= "" >-</option>
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
<td align = "left">
 <% If AdministrationID  = 2 then %>
 <select size="1" name="DOBDay">
<option value="<%=DOBDay%>" selected><%=DOBDay%></option>
<option value="">-</option>
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
<option value="">-</option>
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
<option value="">-</option>
<% currentyear = year(date) 
'response.write(currentyear)
For yearv=1983 To currentyear %>
<option value="<%=yearv%>"><%=yearv%></option>
<% Next %></select>
<% else %>
<select size="1" name="DOBMonth">
<option value="<%=DOBMonth%>" selected><%=DOBMonth%></option>
<option value="">-</option>
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
<option value="">-</option>
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
<option value="">-</option>
<% currentyear = year(date) 
'response.write(currentyear)
For yearv=1983 To currentyear %>
<option value="<%=yearv%>"><%=yearv%></option>
<% Next %></select>
<% end if %> 
</td>

<td align = "left">
	
</td>
	</tr>
</table>
<br />
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "left">
<tr>
<td class = "body" width = "300" align = "left">
<br><b>Category:</b>
</td>
<td width = "2"></td>
<td class = "body" width = "100" align = "left">
<br><b>Species:</b>
</td>
</tr>
<tr>
<td align = "left">
	<select size="1" name="Category">
	<option name = "Category2" value= "<%=Category%>" selected><%=Category%></option>
	<option name = "Category12" value="Experienced Male">Experienced Male<small>(gotten at least one female pregnant)</small></option>
	<option name = "Category12" value="Inexperienced Male">Inexperienced Male<small>(never gotten a female pregnant)</small></option>
     <option name = "Category14" value="Experienced Female">Experienced Female<small>(has been pregnant at least once.)</small></option>
	 <option name = "Category13" value="Inexperienced Female">Inexperienced Female<small>(has never been pregnant)</small></option>
     <option name = "Category15" value="Non-Breeder">Non-Breeder</option>
	</select>
</td><td width = "2"></td>
<td align = "left">
<select size="1" name="SpeciesID">
<%
 if len(SpeciesName) > 0 then %>
<option value="<%=SpeciesID %>" selected><%=SpeciesName %></option>
<% end if
sql2 = "select * from SpeciesAvailable Order by Species "
rs2.Open sql2, conn, 3, 3   
while not rs2.eof
if len(SpeciesID) < 1 then
if  not (rs2("SpeciesID") =  SpeciesID) then  %>
<option  value= "<%=rs2("SpeciesID")%>"><%=rs2("SingularTerm")%></option>
<% end if 
else %>
<option  value= "<%=rs2("SpeciesID")%>"><%=rs2("SingularTerm")%></option>
<% end if 
rs2.movenext
wend
rs2.close
%>
</select>
</td>
</tr>
<tr><td class = body><b>Gender:</b></td></tr>
<tr><td class = body><select size="1" name="Female">
<% If Female = True then %>
	<option name = "Female" value= "Yes" selected>Female</option>
   	<option name = "Female" value= "No" >Male</option>
<% else %>
	<option name = "Female" value= "Yes" >Female</option>
   	<option name = "Female" value= "No" selected>Male</option>
<% end if %>
	</select></td></tr>
</table>
<%  if SpeciesID = 5 then %>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%">
<tr>
<td width = "100"  class = "body" align = "left">	
<b>Height:</b>
</td>
<td width = "100"  class = "body" align = "left">	
<b>Weight:</b>
</td>
<td width = "100"  class = "body" align = "left">	
<b>Gaited:</b>
</td>
<td width = "100"  class = "body" align = "left">	
<b>Warmblood:</b>
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

<select size="1" name="Gaited">
<% if len(Gaited) > 1 then  %>
<option value="<%=Gaited%>" selected><%=Gaited%></option>
<option value="">Not Set</option>
<% else %>
<option value="">Not Set</option>
<% end if %>
<option value="Yes">Yes</option>
<option  value="No">No</option>
</select>

</td>
<td width = "100"  class = "body" align = "left">	
<select size="1" name="Warmblooded">
<% if len(Warmblooded) > 1 then  %>
<option value="<%=Warmblooded%>" selected><%=Warmblooded%></option>
<option value="">Not Set</option>
<% else %>
<option value="">Not Set</option>
<% end if %>
<option value="Yes">Yes</option>
<option  value="No">No</option>
</select>
</td>
</tr>
</table>
<% end if %>


<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
<%
dim RegistrationType(100)
dim RegistrationNumber(100)
x = 0


if len(SpeciesID) > 0 then 
 sql2 = "select * from SpeciesRegistrationTypeLookupTable where SpeciesID=" & speciesID
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3
while not(rs2.eof)  
RegNumber = ""
SpeciesRegistrationType = rs2("SpeciesRegistrationType")
sql3 = "select * from Animalregistration where RegType = '" & SpeciesRegistrationType & "' and AnimalID = " & ID
rs3.Open sql3, conn, 3, 3   
if not rs3.eof then
RegNumber = rs3("Regnumber")
end if
rs3.close
x = x + 1%>
<% if x = 1  or  x = 5 or x = 9 or x = 13 or  x = 17 or x = 21 or x = 25 then %>
<tr>
<% end if %>
<td width = "200"  class = "body" align = "left">
<b><%=SpeciesRegistrationType %></b><br />
<input name="SpeciesRegistrationType(<%=x%>)"  type = "hidden" value="<%=SpeciesRegistrationType %>">
<input name="RegistrationNumber(<%=x%>)" size = "20" value="<%=RegNumber %>">
</td>
<% if x = 4  or  x = 8 or  x = 12 or  x = 16  or  x = 20  or  x = 24 or x = (rs2.recordcount + 1) then %>
</tr>
<% end if %>
<% rs2.movenext
wend 
rs2.close 	
end if%>	

<input type = 'hidden' name="totalregistrations"  value="<%=x%>">

</table>


<% if len(SpeciesID) > 0 then 
else
SpeciesID = 1
end if
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
Currentbreed = rsb("Breed")
end if
rsb.close
end if
%>
<select size="1" name="BreedID">

<% if len(BreedID) > 0 then %>
<option value="<%=BreedID %>" selected><%=Currentbreed %></option>
<% else %>
<% if len(PreferedSpeciesBreed) > 0 then %>
<option value="<%=PreferedSpeciesBreed %>" selected><%=PreferedSpeciesBreed %></option>
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

<% if len(SpeciesName) > 0 then %>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
	<tr>
<td class = "body" width = "160" align = "left">
	<br><b>Color 1:</b>
</td>
<td class = "body" width = "160" align = "left">
	<br><b>Color 2:</b>
</td>
<td class = "body" width = "160" align = "left">
	<br><b>Color 3:</b>
</td>
<td class = "body" width = "160" align = "left">
	<br><b>Color 4:</b>
</td>
	<td class = "body" width = "160" align = "left">
	<br><b>Color 5:</b>
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
<td>
<select size="1" name="Color2" align = "left">
<% if len(Color2) > 0 then %>
<option  value= "<%=Color2 %>" selected><%=Color2 %></option>
<option  value= "">--</option>
<% else %>
<option  value= "" selected>--</option>
<% end if %>
<% sqlc = "select * from SpeciesColorlookupTable where SpeciesID =  " & SpeciesID & " order by SpeciesColor "
Set rsc = Server.CreateObject("ADODB.Recordset")
rsc.Open sqlc, conn, 3, 3   
while not rsc.eof	
if not rsc("SpeciesColor") = Color2 then %>
<option  value= "<%=rsc("SpeciesColor")%>" ><%=rsc("SpeciesColor")%></option>
<% end if 
rsc.movenext
wend
rsc.close
%>
</td>
<td>
<select size="1" name="Color3" align = "left">
<% if len(Color3) > 0 then %>
<option  value= "<%=Color3 %>" selected><%=Color3 %></option>
<option  value= "">--</option>
<% else %>
<option  value= "" selected>--</option>
<% end if %>
<% sqlc = "select * from SpeciesColorlookupTable where SpeciesID =  " & SpeciesID & " order by SpeciesColor "
Set rsc = Server.CreateObject("ADODB.Recordset")
rsc.Open sqlc, conn, 3, 3   
while not rsc.eof	
if not rsc("SpeciesColor") = Color3 then %>
<option  value= "<%=rsc("SpeciesColor")%>" ><%=rsc("SpeciesColor")%></option>
<% end if 
rsc.movenext
wend
rsc.close
%>
</td>
<td>
<select size="1" name="Color4" align = "left">
<% if len(Color4) > 0 then %>
<option  value= "<%=Color4 %>" selected><%=Color4 %></option>
<option  value= "">--</option>
<% else %>
<option  value= "" selected>--</option>
<% end if %>
<% sqlc = "select * from SpeciesColorlookupTable where SpeciesID =  " & SpeciesID & " order by SpeciesColor "
Set rsc = Server.CreateObject("ADODB.Recordset")
rsc.Open sqlc, conn, 3, 3   
while not rsc.eof	
if not rsc("SpeciesColor") = Color4 then %>
<option  value= "<%=rsc("SpeciesColor")%>" ><%=rsc("SpeciesColor")%></option>
<% end if 
rsc.movenext
wend
rsc.close
%>
</td>
<td>
<select size="1" name="Color5" align = "left">
<% if len(Color5) > 0 then %>
<option  value= "<%=Color5 %>" selected><%=Color5 %></option>
<option  value= "">--</option>
<% else %>
<option  value= "" selected>--</option>
<% end if %>
<% sqlc = "select * from SpeciesColorlookupTable where SpeciesID =  " & SpeciesID & " order by SpeciesColor "
Set rsc = Server.CreateObject("ADODB.Recordset")
rsc.Open sqlc, conn, 3, 3   
while not rsc.eof	
if not rsc("SpeciesColor") = Color5 then %>
<option  value= "<%=rsc("SpeciesColor")%>" ><%=rsc("SpeciesColor")%></option>
<% end if 
rsc.movenext
wend
rsc.close
%>
</td>
	</tr>
</table>
<% if speciesId =2 then %>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
	<tr>
<td class = "body" width = "160" align = "left">
	<br><b>% Peruvian:</b>
</td>
<td class = "body" width = "160" align = "left">
	<br><b>% Chilean:</b>
</td>
<td class = "body" width = "160" align = "left">
	<br><b>% Bolivian:</b>
</td>
<td class = "body" width = "160" align = "left">
	<br><b>% Other/Unknown:</b>
</td>
	<td class = "body" width = "160" align = "left">
	<br><b>% Accoyo:</b>
</td>
	</tr>
	<tr>
<td align = "left">
<select size="1" name="PercentPeruvian">
	<option name = "PercentPeruvian" value= "<%=PercentPeruvian%>" selected><%=PercentPeruvian%></option>
	<option name = "PercentPeruvian2" value="0">0%</option>
	<option name = "PercentPeruvian3" value="1/8">1/8</option>
     <option name = "PercentPeruvian4" value="1/4">1/4</option>
     <option name = "PercentPeruvian5" value="3/8">3/8</option>
     <option name = "PercentPeruvian6" value="1/2">1/2</option>
     <option name = "PercentPeruvian7" value="5/8">5/8</option>
     <option name = "PercentPeruvian8" value="3/4">3/4</option>
     <option name = "PercentPeruvian9" value="7/8">7/8</option>
	  <option name = "PercentPeruvian10" value="Full Peruvian">Full Peruvian</option>
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
	  <option name = "PercentChilean10" value="Full Chilean">Full Chilean</option>
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
	  <option name = "PercentBolivian10" value="Full Bolivian">Full Bolivian</option>
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
	  <option name = "PercentUnknownOther10" value="100% Unknown">100% Unknown or Other</option>
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
	  <option name = "PercentAccoyo10" value="Full Accoyo">Full Accoyo</option>
	 </select>
</td>
	</tr>
</table>
<% end if %>
<% end if %>

<br></td>
	</tr>
	</table>	
<table width = "100%" border = "0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
	<tr>
	<td  align = "center">
	<input type = "hidden" name="FormID" value= "GeneralStats">	
<input type = "hidden" name="ID" value= "<%= ID%>">	
	<input type="submit" class = "regsubmit2" value="Submit Basic Facts"  >
</td>
</tr>
</table></td>
</tr>
</table>
</td>
</tr>
</table>	
</form>

</body>
</html>
