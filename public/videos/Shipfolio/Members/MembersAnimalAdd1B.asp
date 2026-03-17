<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="generator" content="Oatmeal AI">
    <title>Global Grange</title>
<!--#Include file="MembersGlobalVariables.asp"-->

  <script type='text/javascript'>


      function checkInput(event) {
          //Get the keyPressed
          var keyPressed = event.keyCode || event.which;
          if (keyPressed < 48 || keyPressed > 57) { return false; }
      }
</script>

<% 
BusinessID= request.Querystring("BusinessID")
speciesID= request.form("speciesID")
If len(speciesID) < 1 then
speciesID= request.querystring("speciesID")
end if

Category= request.querystring("Category")


Name= request.form("Name")
If len(Name) < 1 then
Name= request.querystring("Name")
end if

If len(Name) < 1 then
NameMissing = True
Else
NameMissing = False
end if
    
CategoryMissing= request.form("CategoryMissing")
If len(CategoryMissing) < 1 then
CategoryMissing= request.querystring("CategoryMissing")
end if


BreedMissing= request.form("BreedMissing")
If len(BreedMissing) < 1 then
BreedMissing= request.querystring("BreedMissing")
end if



NumberofAnimals= request.form("NumberofAnimals")
If len(NumberofAnimals) > 0 then
else
NumberofAnimals= request.querystring("NumberofAnimals")
end if



If len(speciesID) < 1 then
MissingSpecies = True
Else
MissingSpecies = False
end if

If len(NumberofAnimals) < 1 then
MissingQuantity = True
Else
MissingQuantity = False
end if

DOB=Request.querystring( "DOB" ) 

BreedID=Request.querystring("BreedID")
BreedID2=Request.querystring("BreedID2")
BreedID3=Request.querystring("BreedID3")
BreedID4=Request.querystring("BreedID4")
Color1=Request.querystring("Color1") 
Color2=Request.querystring("Color2") 
Color3=Request.querystring("Color3") 
Color4=Request.querystring("Color4") 
Height=Request.querystring("Height") 
Weight=Request.querystring("Weight") 
Gaited=Request.querystring("Gaited") 
Warmblood=Request.querystring("Warmblood") 
PercentPeruvian=Request.querystring("PercentPeruvian") 
PercentChilean=Request.querystring("PercentChilean") 
PercentBolivian=Request.querystring("PercentBolivian") 
PercentUnknownOther=Request.querystring("PercentUnknownOther") 
PercentAccoyo=Request.querystring("PercentAccoyo") 
PercentUSA=Request.querystring("PercentUSA") 
PercentCanadian = request.querystring("PercentCanadian")

'response.write("speciesID = " & speciesID )
'response.write("NumberofAnimals = " & NumberofAnimals )
'response.write("CategoryMissing = " & CategoryMissing )
'response.write("MissingQuantity = " & MissingQuantity )
'response.write("MissingSpecies = " & MissingSpecies )


if MissingQuantity = True or MissingSpecies = True then
response.Redirect("MembersAnimalAdd1.asp?MissingSpecies=" & MissingSpecies & "&MissingQuantity=" &MissingQuantity & "&NameMissing=" &NameMissing &  "&speciesID=" & speciesID & "&NumberofAnimals=" & NumberofAnimals )
end if 

if speciesID = 2 then
  AnimalType="Alpacas" 
end if 
if speciesID = 3 then
  AnimalType="Dogs"
end if 
if speciesID = 4 then
  AnimalType="Llamas"
end if 
if speciesID = 5 then
  AnimalType="Horses"
end if 
if speciesID = 6 then
  AnimalType="Goats"
end if 
if speciesID = 7 then
  AnimalType="Donkeys (includes Mules & Hinnies)"
end if 
if speciesID = 8 then
  AnimalType="Cattle"
end if 
if speciesID = 9 then
  AnimalType="Bison"
end if 
if speciesID = 10 then
  AnimalType="Sheep"
end if 
if speciesID = 11 then
  AnimalType="Rabbits"
end if 
if speciesID = 12 then
  AnimalType="Pigs"
end if 
if  speciesID = 13 then
 AnimalType="Chickens"
end if 
if speciesID = 14 then
  AnimalType="Turkeys"
end if 
if speciesID = 15 then
  AnimalType="Ducks"
end if 
if  speciesID = 16 then
 AnimalType="Cats"
end if 

if speciesID = 16 then
 AnimalType="Cats"
end if 

if speciesID = 17 then
 AnimalType="Yaks"
end if 

if  speciesID = 18 then
 AnimalType="Camels"
end if 

if speciesID = 19 then
 AnimalType="Emus"
end if 

if speciesID = 21 then
 AnimalType="Deer"
end if 

if speciesID = 22 then
 AnimalType="Geese"
end if 

if speciesID = 23 then
 AnimalType="Bees"
end if 

if speciesID = 25 then
 AnimalType="Alligators"
end if 

if speciesID = 26 then
 AnimalType="Guinea Fowl"
end if 

if speciesID = 27 then
 AnimalType="Musk Ox"
end if 

if speciesID = 28 then
 AnimalType="Ostriches"
end if 

if speciesID = 29 then
 AnimalType="Pheasants"
end if 

if speciesID = 30 then
 AnimalType="Pigeons"
end if 

if speciesID = 31 then
 AnimalType="Quails"
end if 

if speciesID = 33 then
 AnimalType="Snails"
end if 

if speciesID = 34 then
 AnimalType="Buffalo"
end if 



sql = "select * from SpeciesAvailable where SpeciesAvailableonSite = 1 Order by SpeciesPriority "
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
if not rs.eof then
  numspecies = rs.recordcount
  if numspecies = 1 then
  speciesID = rs("speciesID")
  end if
end if
if len(speciesID) >0 then 
sql = "select * from SpeciesAvailable where Species=  '" & AnimalType &"'"
 'response.Write("sql=" & sql)
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
if not rs.eof then
PreferedspeciesID= rs("PreferedspeciesID")
else
PreferedspeciesID= ""
end if
if len(PreferedspeciesID) > 0 then
 sql2 = "select Breed from SpeciesBreedLookupTable where BreedLookupID=" & PreferedspeciesID
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

Current1="Animals" 
Current2 = "AddAnimals"
BladeSection = "accounts" 
pagename = BusinessName
Hidelinks = True 
rs.close    
    
    %> 
    </head>
<body>
<!--#Include file="MembersHeader.asp"-->

<div class ="container roundedtopandbottom">
<div class="row">
        <div class="col-sm-12 body">
            <H3>General Facts</H3><a name="Top"></a>
        </div>
</div>

<%
if rs.state = 0 then
else
rs.close
end if


 if len(speciesID) > 0 then 
sql = "select Species from SpeciesAvailable where speciesID = " & speciesID & "  Order by Species "
rs.Open sql, conn, 3, 3   
if not rs.eof then	
SpeciesName = rs("Species")
end if
rs.close
end if

Name = CStr(Name)
speciesID  = CInt(speciesID)
' Remove single quotes
Name = Replace(Name, "'", "''")

' Remove double quotes
Name = Replace(Name, """", "")

sql2 = "select Animals.AnimalID from Animals where BusinessID = " & BusinessID & " and FullName = '" & Name & "' and speciesID = " & speciesID 

'response.write("sql2=" & sql2 )



Set rs2 = Server.CreateObject("ADODB.Recordset")
    rs2.Open sql2, conn, 3, 3   

   If not rs2.eof Then
response.Redirect("MembersAnimalAdd1.asp?Duplicate=True&SpeciesName=" & SpeciesName & "&NumberofAnimals=" & NumberofAnimals & "&speciesID=" & speciesID & "&Name=" & Name & "&DOBMonth=" & DOBMonth & "&DOBDay=" & DOBDay & "&DOBYear=" & DOBYear & "&Category=" & Category & "&BreedID=" & BreedID & "&BreedID2=" & BreedID2  & "&BreedID3=" & BreedID3  & "&BreedID4=" & BreedID4 & "&Color1=" & Color1 & "&Color2=" & Color2 & "&Color3=" & Color3 & "&Color4=" & Color4 & "&Color5=" & Color5 & "&PercentPeruvian=" & PercentPeruvian & "&PercentChilean=" & PercentChilean & "&PercentBolivian=" & PercentBolivian & "&PercentUnknownOther=" & PercentUnknownOther & "&PercentAccoyo=" & PercentAccoyo & "&Height=" & Height & "&Weight=" & Weight & "&Gaited=" & Gaited & "Warmblooded=" & Warmblooded )
end if 

 %> 

<% if BreedMissing = "True" then %>
   <b><font color ="maroon">Please select a breed.</font></b><br />
<% end if %>
<form  name=form method="post" action="MembersAnimalAdd2A.asp?wizard=True&BusinessID=<%=BusinessID %>">
<input name="speciesID" value="<%=speciesID %>" type = "hidden" >		
<input name="Name" value="<%=Name %>" type = "hidden" >	
<input name="NumberofAnimals" value="<%=NumberofAnimals %>" type = "hidden" >		

<%
dim RegistrationType(100)
dim RegistrationNumber(100)
x = 0
lastx = 0
firstx = 0
if len(speciesID) > 0 then
else
speciesID = 1
end if
if len(speciesID) > 0 then 
    sql2 = "select * from SpeciesRegistrationTypeLookupTable where speciesID=" & speciesID & " and country_id = " & country_id & " or country_id = 100000 "
   'response.write("sql2=" & sql2)
    Set rs2 = Server.CreateObject("ADODB.Recordset")
    rs2.Open sql2, conn, 3, 3
    while not(rs2.eof)  
 %>
            <div class = "row">

        <div class = "col-3">
            <b><%=rs2("SpeciesRegistrationType")%></b><br />
            <input name="RegistrationNumber(<%=x%>)" size = "20" class = "body" value="" style="width: 400px; text-align: left">
        </div>

        </div>

        <% rs2.movenext
    wend 
    rs2.close 
end if%>
<input type = 'hidden' name="totalregistrations"  value="<%=x%>">
<% if not (speciesID = 33 or speciesID = 23) and NumberofAnimals < 2 then %>
<div class = "row">
    <div class = "col-12 body">
        Date of Birth
    </div>
</div>
<% end if %>
<% if not ( speciesID = 23 or speciesID = 33) and NumberofAnimals < 2  then %>
<div class = "row">
     <div class="col-12 body" style ="min-height: 50px"  >

   <%
Dim maxDate
maxDate = Year(Date()) & "-" & Right("0" & Month(Date()), 2) & "-" & Right("0" & Day(Date()), 2)
%>

<input type="date" value="<%= DOB %>" name="DOB" class="formbox" max="<%= maxDate %>">


    </div>
</div>
<% end if %>

<% if speciesID = 23 or speciesID = 33  then %>
   <input type ="hidden" name="Category" Value = 343 />
<% else %>
<div class = "row">
     <div class="col-12 body"   >
        <% If CategoryMissing = "True" then %>
             <b><font color ="maroon">*Category</font></b>
        <% else %>
            <font color ="maroon">*</font>Category
        <% end if %>
    </div>
</div>
<% end if %>


<% if not (speciesID = 23 or speciesID = 33 ) then %>
<div class = "row">
  <div class="col-12 body" style ="min-height: 50px "  >

<% sql2 = "select * from speciescategory where speciesID=" & speciesID & QuantityTypeScrtipt  & " Order by SpeciesCategoryOrder"
    
    DamName = "dam"
if speciesID = 3 then
DamName = "bitch"
end if %>

   <select size="1" size = "20" name="Category" style="height: 30px; width: 400px; text-align: left;" class="formbox" required >
        <option  value= "" selected>--</option>
<% 
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3

if NumberofAnimals > 1 then
    if not rs2.eof then 
        i = 0
        while not rs2.eof
        i = i +1 
        if i = 1 then%>
            <option  value= "<%=rs2("SpeciesCategoryID")%>" ><%=rs2("SpeciesCategoryPlural")%></option>
        <% else %>
            <option  value= "<%=rs2("SpeciesCategoryID")%>" ><%=rs2("SpeciesCategoryPlural")%></option>
        <% end if %>
        <% rs2.movenext
        wend 
    end if %>

<% else %>

    <% if not rs2.eof then 
        i = 0
        while not rs2.eof 
         if rs2("SpeciesCategory") = "Assortment" then
         else


        i = i +1 
        if i = 1 then%>
            <option  value= "<%=rs2("SpeciesCategoryID")%>" ><%=rs2("SpeciesCategory")%></option>
        <% else %>
            <option  value= "<%=rs2("SpeciesCategoryID")%>" ><%=rs2("SpeciesCategory")%></option>
        <% end if %>

       <% end if %>

        <% rs2.movenext
        wend 
 end if 
            
 end if           %>
</select>
</div>
</div>
<% end if %>
<% 
speciesIDfound = false
sql2 = "select * from SpeciesBreedLookupTable where speciesID=" & speciesID & " Order by Breedlookupid"
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
    <div class = "col-12 body body">
    <% if speciesID = 4 or speciesID = 23 then %>
        <b><font color ="maroon">*</font>Type</b>
    <% else %>
        <font color ="maroon">*</font>Breed <%if not speciesID = 33 then %>1<% end if %>
    <% end if %>
</div>
</div>


<div class = "row">
    <div class = "col-12 body" width = "160" align = "left" style ="min-height: 50px">
<%
Set rsb = Server.CreateObject("ADODB.Recordset")
if speciesID = 3 then
sql2 = "select * from SpeciesBreedLookupTable where BreedLookupID = 10 or BreedLookupID = 12 or BreedLookupID = 16 or BreedLookupID = 17 or BreedLookupID = 28 or BreedLookupID =32 or BreedLookupID = 41 or BreedLookupID = 51 or BreedLookupID = 64 or BreedLookupID = 65 or BreedLookupID = 66 or BreedLookupID = 67 or BreedLookupID = 68 or BreedLookupID = 72 or BreedLookupID = 79 or BreedLookupID = 84 or BreedLookupID =87 or BreedLookupID = 96 or BreedLookupID = 109 or BreedLookupID = 114 or BreedLookupID = 118 or BreedLookupID = 120 or BreedLookupID = 125 or BreedLookupID = 127 or BreedLookupID = 128 or BreedLookupID = 130 or BreedLookupID = 154 or BreedLookupID = 161 or BreedLookupID = 162 or BreedLookupID = 168 or BreedLookupID = 170 or BreedLookupID = 176 or BreedLookupID = 179 or BreedLookupID = 188 or BreedLookupID = 201 or BreedLookupID = 202 or BreedLookupID = 207 or BreedLookupID = 216 or BreedLookupID = 217 or BreedLookupID = 218 or BreedLookupID = 231 or BreedLookupID = 239 or BreedLookupID = 264 or BreedLookupID = 270 or BreedLookupID = 273 or BreedLookupID = 280 or BreedLookupID = 282 or BreedLookupID = 289 or BreedLookupID = 299 or BreedLookupID = 302 or BreedLookupID = 318 or BreedLookupID = 319 or BreedLookupID = 331 or BreedLookupID = 333 or BreedLookupID = 341 or BreedLookupID = 353 or BreedLookupID = 354 or BreedLookupID = 361 or BreedLookupID = 369 or BreedLookupID = 377 or BreedLookupID = 384 or BreedLookupID = 386 or BreedLookupID = 394 or BreedLookupID = 402 or BreedLookupID = 406 or BreedLookupID = 410 or BreedLookupID = 411 or BreedLookupID = 427 or BreedLookupID = 428 or BreedLookupID = 442 or BreedLookupID = 458 or BreedLookupID = 467 or BreedLookupID = 893 or BreedLookupID = 1023 or BreedLookupID = 1487 order by Breed"
else
sql2 = "select * from SpeciesBreedLookupTable where speciesID=" & speciesID & " Order by trim(Breed)"
end if

rs2.Open sql2, conn, 3, 3
if not rs2.eof then 

if len(BreedID) > 0 then 
sqlb = "select * from SpeciesBreedLookupTable where BreedlookupID=" & BreedID
'response.write("sqlb=" & sqlb )
rsb.Open sqlb, conn, 3, 3
if not rsb.eof then 
Currentbreed = rsb("BreedLookupID")
end if
rsb.close
end if

 sqlb = "select BreedLookupID from SpeciesBreedLookupTable where Breed='" & PreferedSpeciesBreed & "'"
  '  response.write("sqlb=" & sqlb )

%>
<select size="1" name="BreedID" style="height: 30px; width: 400px; text-align: left;" class ="formbox" required>


<option value="" class="body">--</option>
<% 


while not(rs2.eof) 
Breed = rs2("Breed") 
BreedID = rs2("BreedLookupID") %>

<option value="<%= BreedID %>" class="body"><%= trim(Breed) %></option>
<%

 rs2.movenext
wend 
end if
rs2.close 
%>
</select>
</div>
</div>

 <% if not ( speciesID = 18 or speciesID = 4 or speciesID = 33 or speciesID = 23 or speciesID = 34) then  %>
<div class = "row">
    <div>
      Breed 2
    </div>
</div>
  <% end if %>
<% if not ( speciesID = 18  or speciesID = 4 or speciesID = 33 or speciesID = 23 or speciesID = 34) then  %>
<div class = "row">
    <div class = "col-12 body" width = "160" align = "left" style ="min-height: 50px" >
<% if speciesID = 3 then
sql2 = "select * from SpeciesBreedLookupTable where BreedLookupID = 10 or BreedLookupID = 12 or BreedLookupID = 16 or BreedLookupID = 17 or BreedLookupID = 28 or BreedLookupID =32 or BreedLookupID = 41 or BreedLookupID = 51 or BreedLookupID = 64 or BreedLookupID = 65 or BreedLookupID = 66 or BreedLookupID = 67 or BreedLookupID = 68 or BreedLookupID = 72 or BreedLookupID = 79 or BreedLookupID = 84 or BreedLookupID =87 or BreedLookupID = 96 or BreedLookupID = 109 or BreedLookupID = 114 or BreedLookupID = 118 or BreedLookupID = 120 or BreedLookupID = 125 or BreedLookupID = 127 or BreedLookupID = 128 or BreedLookupID = 130 or BreedLookupID = 154 or BreedLookupID = 161 or BreedLookupID = 162 or BreedLookupID = 168 or BreedLookupID = 170 or BreedLookupID = 176 or BreedLookupID = 179 or BreedLookupID = 188 or BreedLookupID = 201 or BreedLookupID = 202 or BreedLookupID = 207 or BreedLookupID = 216 or BreedLookupID = 217 or BreedLookupID = 218 or BreedLookupID = 231 or BreedLookupID = 239 or BreedLookupID = 264 or BreedLookupID = 270 or BreedLookupID = 273 or BreedLookupID = 280 or BreedLookupID = 282 or BreedLookupID = 289 or BreedLookupID = 299 or BreedLookupID = 302 or BreedLookupID = 318 or BreedLookupID = 319 or BreedLookupID = 331 or BreedLookupID = 333 or BreedLookupID = 341 or BreedLookupID = 353 or BreedLookupID = 354 or BreedLookupID = 361 or BreedLookupID = 369 or BreedLookupID = 377 or BreedLookupID = 384 or BreedLookupID = 386 or BreedLookupID = 394 or BreedLookupID = 402 or BreedLookupID = 406 or BreedLookupID = 410 or BreedLookupID = 411 or BreedLookupID = 427 or BreedLookupID = 428 or BreedLookupID = 442 or BreedLookupID = 458 or BreedLookupID = 467 or BreedLookupID = 893 or BreedLookupID = 1023 or BreedLookupID = 1487 order by Breed"
else
sql2 = "select * from SpeciesBreedLookupTable where speciesID=" & speciesID & " Order by trim(Breed)"
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

<select size="1" name="BreedID2" style="height: 30px; width: 400px; text-align: left;" class ="formbox">
<% if len(BreedlookupID2 ) > 0 then
 if BreedlookupID2 =  0 then 
  CurrentBreed = ""%>
<option value="" class="body">--</option>
 <% else %>
<option value="<%=BreedlookupID2  %>" selected><%=CurrentBreed %></option>
<option value="0" class="body"> - </option>
<% end if %>
<% else %>
<option value="" class="body">--</option>
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
</div>
</div>

<% end if
rs2.close
%>

<% if not(speciesID= 2 or speciesID = 18 or speciesID = 33 or speciesID = 9 or speciesID = 23) then%>
<div class = "row">
    <div class = "col-12 body" width = "160" align = "left">
       Breed 3 
    </div>
</div>


<div class = "row">
    <div class = "col-12 body" width = "160" align = "left" style ="min-height: 50px">
       
<% if speciesID = 3 then %>

    <% sql2 = "select * from SpeciesBreedLookupTable where BreedLookupID = 10 or BreedLookupID = 12 or BreedLookupID = 16 or BreedLookupID = 17 or BreedLookupID = 28 or BreedLookupID =32 or BreedLookupID = 41 or BreedLookupID = 51 or BreedLookupID = 64 or BreedLookupID = 65 or BreedLookupID = 66 or BreedLookupID = 67 or BreedLookupID = 68 or BreedLookupID = 72 or BreedLookupID = 79 or BreedLookupID = 84 or BreedLookupID =87 or BreedLookupID = 96 or BreedLookupID = 109 or BreedLookupID = 114 or BreedLookupID = 118 or BreedLookupID = 120 or BreedLookupID = 125 or BreedLookupID = 127 or BreedLookupID = 128 or BreedLookupID = 130 or BreedLookupID = 154 or BreedLookupID = 161 or BreedLookupID = 162 or BreedLookupID = 168 or BreedLookupID = 170 or BreedLookupID = 176 or BreedLookupID = 179 or BreedLookupID = 188 or BreedLookupID = 201 or BreedLookupID = 202 or BreedLookupID = 207 or BreedLookupID = 216 or BreedLookupID = 217 or BreedLookupID = 218 or BreedLookupID = 231 or BreedLookupID = 239 or BreedLookupID = 264 or BreedLookupID = 270 or BreedLookupID = 273 or BreedLookupID = 280 or BreedLookupID = 282 or BreedLookupID = 289 or BreedLookupID = 299 or BreedLookupID = 302 or BreedLookupID = 318 or BreedLookupID = 319 or BreedLookupID = 331 or BreedLookupID = 333 or BreedLookupID = 341 or BreedLookupID = 353 or BreedLookupID = 354 or BreedLookupID = 361 or BreedLookupID = 369 or BreedLookupID = 377 or BreedLookupID = 384 or BreedLookupID = 386 or BreedLookupID = 394 or BreedLookupID = 402 or BreedLookupID = 406 or BreedLookupID = 410 or BreedLookupID = 411 or BreedLookupID = 427 or BreedLookupID = 428 or BreedLookupID = 442 or BreedLookupID = 458 or BreedLookupID = 467 or BreedLookupID = 893 or BreedLookupID = 1023 or BreedLookupID = 1487 order by Breed"
   else
      sql2 = "select * from SpeciesBreedLookupTable where speciesID=" & speciesID & " Order by trim(Breed)"
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
        <select size="1" name="BreedID3" style="height: 30px; width: 400px; text-align: left;" class ="formbox">
        <% if len(BreedlookupID3 ) > 0 then
            if BreedlookupID3 =  0 then 
                CurrentBreed = ""%>
                <option value="" class="body"></option>
          <% else %>
                <option value="<%=BreedlookupID3  %>" selected><%=CurrentBreed %></option>
                <option value="0" class="body"> - </option>
          <% end if %>
        <% else %>
             <option value="" class="body"></option>
        <% end if %>
       <% while not(rs2.eof) 
        Breed = rs2("Breed") 
        BreedID = rs2("BreedLookupID") %>
        <% if not( Breed  = PreferedSpeciesBreed) and not(trim(Breed) = trim(Currentbreed))  then %>
               <option value="<%= BreedID %>" class="body"><%= trim(Breed) %></option>
        <% end if
        rs2.movenext
         wend %>
        </select>
</div>
</div>
 <%  rs2.close %>
<% end if %>


<% if speciesID = 3 then
sql2 = "select * from SpeciesBreedLookupTable where BreedLookupID = 10 or BreedLookupID = 12 or BreedLookupID = 16 or BreedLookupID = 17 or BreedLookupID = 28 or BreedLookupID =32 or BreedLookupID = 41 or BreedLookupID = 51 or BreedLookupID = 64 or BreedLookupID = 65 or BreedLookupID = 66 or BreedLookupID = 67 or BreedLookupID = 68 or BreedLookupID = 72 or BreedLookupID = 79 or BreedLookupID = 84 or BreedLookupID =87 or BreedLookupID = 96 or BreedLookupID = 109 or BreedLookupID = 114 or BreedLookupID = 118 or BreedLookupID = 120 or BreedLookupID = 125 or BreedLookupID = 127 or BreedLookupID = 128 or BreedLookupID = 130 or BreedLookupID = 154 or BreedLookupID = 161 or BreedLookupID = 162 or BreedLookupID = 168 or BreedLookupID = 170 or BreedLookupID = 176 or BreedLookupID = 179 or BreedLookupID = 188 or BreedLookupID = 201 or BreedLookupID = 202 or BreedLookupID = 207 or BreedLookupID = 216 or BreedLookupID = 217 or BreedLookupID = 218 or BreedLookupID = 231 or BreedLookupID = 239 or BreedLookupID = 264 or BreedLookupID = 270 or BreedLookupID = 273 or BreedLookupID = 280 or BreedLookupID = 282 or BreedLookupID = 289 or BreedLookupID = 299 or BreedLookupID = 302 or BreedLookupID = 318 or BreedLookupID = 319 or BreedLookupID = 331 or BreedLookupID = 333 or BreedLookupID = 341 or BreedLookupID = 353 or BreedLookupID = 354 or BreedLookupID = 361 or BreedLookupID = 369 or BreedLookupID = 377 or BreedLookupID = 384 or BreedLookupID = 386 or BreedLookupID = 394 or BreedLookupID = 402 or BreedLookupID = 406 or BreedLookupID = 410 or BreedLookupID = 411 or BreedLookupID = 427 or BreedLookupID = 428 or BreedLookupID = 442 or BreedLookupID = 458 or BreedLookupID = 467 or BreedLookupID = 893 or BreedLookupID = 1023 or BreedLookupID = 1487 order by Breed"
else
sql2 = "select * from SpeciesBreedLookupTable where speciesID=" & speciesID & " Order by trim(Breed)"
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
<div class = "row">
    <div class = "col-12 body" width = "160" align = "left">
        Breed 4
    </div>
</div>
<div class = "row">
    <div class = "col-12 body" width = "160" align = "left" style ="min-height: 50px">

<select size="1" name="BreedID4" style="height: 30px; width: 400px; text-align: left;" class ="formbox">
<% if len(BreedlookupID4 ) > 0 then
 if BreedlookupID4 =  0 then 
 CurrentBreed = ""%>
<option value="" class="body"></option>
 <% else %>
<option value="<%=BreedlookupID4  %>" selected><%=CurrentBreed %></option>
<option value="0" class="body"> - </option>
<% end if %>
<% else %>
<option value="" class="body"></option>
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
<% end if %>
<% end if %>


<% end if %>




<% if not(speciesID = 15) and  not(speciesID = 23) and  not(speciesID = 22)  and not (speciesID = 18) and not (speciesID = 21)  and not (speciesID = 19) and not (speciesID = 25) and not (speciesID = 26) and not (speciesID = 28) and not (speciesID = 29) and not (speciesID = 30)  and not (speciesID = 31) and not (speciesID = 27) and not (speciesID = 33) then%>

<div class = "row">
    <div class = "col-4 body" width = "160" align = "left">
       Color 1 
    </div>
 <div class = "col-1  ">
    </div>
        <div class = "col-5 body" width = "160" align = "left">
        Color 2
    </div>
    <div class = "col-2 d-sm-none d-md-block"> </div>
</div>

<div class = "row">
    <div class = "col-4 body" width = "160" align = "left" style ="min-height: 50px">
        <select size="1" name="Color1" style="height: 30px;" class ="formbox">
          <% if len(Color1) > 0 then %>
            <option  value= "<%=Color1 %>" selected><%=Color1 %></option>
            <option  value= "">--</option>
         <% else %>
            <option  value= "" selected>--</option>
         <% end if %>
        <% sqlc = "select * from SpeciesColorlookupTable where speciesID =  " & speciesID & " order by SpeciesColor "
            Set rsc = Server.CreateObject("ADODB.Recordset")
            rsc.Open sqlc, conn, 3, 3   
            while not rsc.eof	
            if not rsc("SpeciesColor") = Color1 then %>
                <option  value= "<%=rsc("SpeciesColor")%>" ><%=rsc("SpeciesColor")%></option>
            <% end if 
            rsc.movenext
            wend
            rsc.close %>
        </select>
    </div>
<div class = "col-1 "> </div>
        <div class = "col-5 body" width = "160" align = "left">
              <select size="1" name="Color2" style="height: 30px;" class ="formbox">
          <% if len(Color2) > 0 then %>
            <option  value= "<%=Color2 %>" selected><%=Color2 %></option>
            <option  value= "">--</option>
         <% else %>
            <option  value= "" selected>--</option>
         <% end if %>
        <% sqlc = "select * from SpeciesColorlookupTable where speciesID =  " & speciesID & " order by SpeciesColor "
            Set rsc = Server.CreateObject("ADODB.Recordset")
            rsc.Open sqlc, conn, 3, 3   
            while not rsc.eof	
            if not rsc("SpeciesColor") = Color2 then %>
                <option  value= "<%=rsc("SpeciesColor")%>" ><%=rsc("SpeciesColor")%></option>
            <% end if 
            rsc.movenext
            wend
            rsc.close %>
        </select>
    </div>
    <div class = "col-2 d-sm-none d-md-block"> </div>
</div>


<% if not(speciesID= 14 or speciesID = 21 or speciesID = 33 or speciesID = 23 or speciesID = 22 or speciesID = 15 ) then%>
<div class = "row">
    <div class = "col-4 body" width = "160" align = "left">
        Color 3 
    </div>
      <div class = "col-1 ">
    </div>
        <div class = "col-5 body" width = "160" align = "left">
        Color 4
    </div>
     <div class = "col-2 d-sm-none d-md-block"> </div>
</div>

<div class = "row">
        <div class = "col-4 body" style ="min-height: 50px" align = "left">
              <select size="1" name="Color3" style="height: 30px;" class ="formbox">
          <% if len(Color3) > 0 then %>
            <option  value= "<%=Color3 %>" selected><%=Color3 %></option>
            <option  value= "">--</option>
         <% else %>
            <option  value= "" selected>--</option>
         <% end if %>
        <% sqlc = "select * from SpeciesColorlookupTable where speciesID =  " & speciesID & " order by SpeciesColor "
            Set rsc = Server.CreateObject("ADODB.Recordset")
            rsc.Open sqlc, conn, 3, 3   
            while not rsc.eof	
            if not rsc("SpeciesColor") = Color2 then %>
                <option  value= "<%=rsc("SpeciesColor")%>" ><%=rsc("SpeciesColor")%></option>
            <% end if 
            rsc.movenext
            wend
            rsc.close %>
        </select>
    </div>
     <div class = "col-1">
    </div>
        <div class = "col-5 body" width = "160" align = "left" style ="min-height: 50px">
               <select size="1" name="Color4" style="height: 30px;" class="formbox">
          <% if len(Color4) > 0 then %>
            <option  value= "<%=Color4 %>" selected><%=Color4 %></option>
            <option  value= "">--</option>
         <% else %>
            <option  value= "" selected>--</option>
         <% end if %>
        <% sqlc = "select * from SpeciesColorlookupTable where speciesID =  " & speciesID & " order by SpeciesColor "
            Set rsc = Server.CreateObject("ADODB.Recordset")
            rsc.Open sqlc, conn, 3, 3   
            while not rsc.eof	
            if not rsc("SpeciesColor") = Color3 then %>
                <option  value= "<%=rsc("SpeciesColor")%>" ><%=rsc("SpeciesColor")%></option>
            <% end if 
            rsc.movenext
            wend
            rsc.close %>
        </select>
    </div>
    <div class = "col-2 d-sm-none d-md-block"> </div>
</div>
<% end if %>


<% end if %>
<% end if %>
<div>
  <div>
  <br />
<center><input type="submit" value = "Next" class="regsubmit2" <%=Disablebutton %> ></center>
<br /><br />
</form>
</div>
</div>
</div>

<!--#Include file="MembersFooter.asp"--> 
</Body>
</HTML>