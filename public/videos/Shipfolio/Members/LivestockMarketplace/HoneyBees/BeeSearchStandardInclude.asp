<div class="container-fluid " align = "left" style="max-width: 190px" >
<div class = "row">
  <div class = "col">
    <form action= "Default.asp#Results" id="SearchForm" method = "post">
    <input type="hidden" name = "speciesID" value = "<%=speciesID %>" >
  </div>
</div>

<% 
if rs2.state = 0 then
else
rs2.close
end if

sql2 = "select Breed, BreedLookupID from SpeciesBreedLookupTable where SpeciesID=" & SpeciesID & " order by Breed ASC"
'response.write("sql2=" & sql2)

rs2.Open sql2, conn, 3, 3
if not rs2.eof and rs2.recordcount > 1 then %>
<div class = "row">
    <div class = "col" align= "left">Breed<br />
<select size="1" name="BreedSortID" style="width: 190px" class = "formbox">

<% If Len(BreedSort) > 1 then %>
<option value= "<%=BreedSortID %>" selected><%=BreedSort %></option>
<option value= "">Any</option>
<% else %>
<option value= "">Any</option>

<% End If %>
<% while not rs2.eof %>
<% if not rs2("BreedLookupID")  = BreedSortID then %>
<option value="<%=rs2("BreedlookupID")%>" class="body"><%=rs2("Breed")%></option>
<%
end if
 rs2.movenext
wend %>
</select>


  </div>
</div>

<% end if
rs2.close %>

<% If not SpeciesID  = 23 then %>
<div class = "row">
    <div class = "col" align= "left">Gender Class<br />

<select size="1" name="SpeciesCategoryID" style="width: 190px" class = "formbox">
<% if SpeciesCategoryID > 0 and not SpeciesCategoryID = 10000 then 
sql2 = "select SpeciesCategoryPlural from SpeciesCategory where SpeciesCategoryID=" & SpeciesCategoryID 
response.write("sql2=" & sql2)
rs2.Open sql2, conn, 3, 3
Category = rs2("SpeciesCategoryPlural")
rs2.close
%>

<option value= "<%=SpeciesCategoryID %>" selected class="body"><%=Category %></option>
<option value= "10000" class="body">All Categories</option>
<% else %>
<option value= "10000" selected class="body">All Categories</option>
<% end if %>

<%sql2 = "select SpeciesCategoryID, SpeciesCategoryPlural from SpeciesCategory where SpeciesID=" & SpeciesID & " order by SpeciesCategoryOrder"
rs2.Open sql2, conn, 3, 3
if not rs2.eof then


if Category = "other" or  Category = "Other" then
Category = "Any"
end if %>

<% while not rs2.eof %>
<% if not rs2("SpeciesCategoryID")  = SpeciesCategoryID and len(rs2("SpeciesCategoryPlural")) > 1 then %>
<option value="<%=rs2("SpeciesCategoryID")%>" class="body"><%=rs2("SpeciesCategoryPlural")%></option>
<%
end if
 rs2.movenext
wend
rs2.close %>
</select>
<% end if %>
  </div>
</div>


<% if SpeciesID = 2 then %>
<div class = "row">
    <div class = "col" align= "left">Ancestry<br />
<select size="1" name="Ancestry" style="width: 190px" class = "formbox">
<% if len(Ancestry) > 9 and not(Ancestry="Any") then %>
<option value= "<%=Ancestry %>" selected><%=Ancestry %></option>
<option value= "Any" >All Ancestries</option>
<% else %>
<option value= "Any" selected>All Ancestries</option>
<% end if %>
<option value="Full Peruvian">Full Peruvian</option>
<option value="Partial Peruvian">Partial Peruvian</option>
<option value="Full Chilean">Full Chilean</option>
<option value="Partial Chilean">Partial Chilean</option>
<option value="Full Bolivian">Full Bolivian</option>
<option value="Partial Bolivian">Partial Bolivian</option>
</select>
  </div>
</div>
<% end if %>


<div class = "row">
    <div class = "col" align= "left">Min. Price<br />
<select  name="currentminprice" style="width: 190px" class = "formbox">
<% If Len(currentminprice) > 1 then %>
<option  value= "<%=currentminprice %>" selected><%=formatcurrency(currentminprice,0) %></option>
<option  value= "0">No Minimum</option>
<% else %>
<option  value= "0" selected>No Minimum</option>
<% End If %>
<option value= "500">$500 </option>
<option value= "1000">$1,000 </option>
<option  value= "5000">$5,000</option>
<option  value= "10000">$10,000</option>
<option  value= "15000">$15,000</option>
<option  value= "50000">$50,000</option>
<option  value= "75000">$75,000</option>
</select>
  </div>
</div>

<div class = "row">
    <div class = "col" align= "left">Max. Price<br />
<select  name="currentmaxprice" style="width: 190px" class = "formbox">
<% If Len(currentmaxprice) > 1 and not currentmaxprice = "100000000"  then %>
<option  value= "<%=currentmaxprice %>" selected><%=formatcurrency(currentmaxprice,0) %></option>
<option  value= "100000000">No Maximum</option>
<% Else%>
<option  value= "100000000" selected>No Maximum</option>
<% End If %>
<option value= "1000">$1,000 </option>
<option value= "5000">$5,000</option>
<option value= "10000">$10,000</option>
<option value= "15000">$15,000</option>
<option value= "50000">$50,000</option>
<option value= "75000">$75,000</option>
<option value= "100000">$100,000</option>
<option value= "500000">$500,000</option>
<option value= "1000000">$1,000,000</option>
</select>
  </div>
</div>

<div class = "row">
    <div class = "col" align= "left">Color<br />
<select size="1" name="ColorSort" style="width: 190px" class = "formbox">
<% if len(ColorSort) > 0 then %>
<option value= "<%=ColorSort %>" selected><%=ColorSort %></option>
<option value= "Any" >All Colors</option>
<% else %>
<option value= "Any" selected>All Colors</option>
<% end if %>
<% sql = "select * from SpeciesColorlookupTable where SpeciesID =  " & SpeciesID & " order by SpeciesColor "
if rs.state = 0 then
else
rs.close
end if
rs.Open sql, conn, 3, 3   
while not rs.eof	 %>
<option  value= "<%=rs("SpeciesColor")%>" ><%=rs("SpeciesColor")%></option>
<% rs.movenext
wend
rs.close
%>
</select>
  </div>
</div>


<% 
if len(RegistrationID) < 1 then RegistrationID = 0 end if 
 %>
<div class = "row">
    <div class = "col-6" align= "left">
    <label for="Registration">Registration</label>

<select size="1" id = "Registration" name="RegistrationID" style="width: 190px" class = "formbox">
<% if RegistrationID > 0 and not RegistrationID = 10000 then 
sql2 = "select AssociationAcronym from associations where AssociationID=" & RegistrationID
response.write("sql2=" & sql2)
rs2.Open sql2, conn, 3, 3
AssociationAcronym = rs2("AssociationAcronym")
rs2.close
%>

<option value= "<%=RegistrationID %>" selected class="body"><%=AssociationAcronym %></option>
<option value= "10000" class="body">Any</option>
<% else %>
<option value= "10000" selected class="body">Any</option>
<% end if %>

<% sql = "select * from associations where registry = 1 and SpeciesID =  " & SpeciesID & " order by AssociationAcronym "
if rs.state = 0 then
else
rs.close
end if
rs.Open sql, conn, 3, 3   
while not rs.eof	 %>
<option  value= "<%=rs("AssociationID")%>" ><%=rs("AssociationAcronym")%></option>
<% rs.movenext
wend
rs.close
%>

</select>
  </div>
</div>



<% showages = false
if showages = True then %>
<div class = "row">
    <div class = "col" align= "left">Min. Age<br />
<select size="1" name="MinAge" style="width: 190px" class = "formbox">
<% if len(MinAge) > 0 and not(MinAge = "Any") then %>
<option value= "<%=MinAge %>" selected><%=MinAge %> Year<% if MinAge > 1 then %>s<% end if %></option>
<option value= "Any" >No Minimum</option>
<% else %>
<option value= "Any" selected>No Minimum</option>
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
<option value="15">15</option>
<option value="20">20</option>
</select> Years
  </div>
</div>


<div class = "row">
    <div class = "col" align= "left">Max. Age<br />
<select size="1" name="MaxAge" style="width: 190px" class = "formbox">
<% if len(MaxAge) > 0 and not(MaxAge = "Any") then %>
<option value= "<%=MaxAge %>" selected><%=MaxAge %> Year<% if MaxAge > 1 then %>s<% end if %></option>
<option value= "Any" >No Maximum</option>
<% else %>
<option value= "Any" selected>No Maximum</option>
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
<option value="12">12</option>
<option value="14">14</option>
<option value="16">16</option>
<option value="18">18</option>
<option value="20">20</option>
<option value="22">22</option>
<option value="24">24</option>
<option value= "26">26</option>
</select> years

  </div>
</div>


<% end if %>


<div class = "row">
    <div class = "col" align= "left">
        <%=ProvinceTitle %><br />
<select size="1" name="StateIndex" style="width: 190px" class = "formbox">

<% if len(StateIndex) < 1 then StateIndex = 0
    
    if StateIndex > 0 and not StateIndex = 10000 then 
        sql2 = "select name from state_province where StateIndex=" & StateIndex
        response.write("sql2=" & sql2)
        rs2.Open sql2, conn, 3, 3
            name = rs2("name")
        rs2.close %>
        <option value="<%=StateIndex %>" selected><%=name %></option>
        <option value="10000"><br />Any</option>
    <% else %>
        <option value="10000">Any</option>
    <% end if %>


<% sql = "select *  from state_province where country_id =" & country_id & " order by name"
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3 
while Not rs.eof 
    province = rs("name") 
    TempStateIndex= rs("StateIndex") 

    if lcase(province) = lcase(AddressState) then
        selected = "Selected"
    else
        selected = ""
    end if
%>
<option value="<%=TempStateIndex %>" <%=selected%> > <%=province %></option>


<% rs.movenext
wend 
rs.close 
 %>
</select>
  </div>
</div>
<div class = "row">
    <div class = "col" align= "left">Sort By<br />

<% if Sortby = "Category" then Sortby = "" %>
<select size="1" name="Sortby" style="width: 190px" class = "formbox">
<% if len(Sortby) < 3 then %>
<option value= "Price" >Price</option>
<option value="Breed">Breed</option>
<option value="Color1">Color</option>
<option value="Name">Name</option>
<option value="Age" >Age</option>
<option value="" selected>Most Current</option>
<% end if %>
<% if Sortby= "Breed" then %>
<option value="Breed"  selected>Breed</option>
<option value= "Price">Price</option>
<option value="Color1">Color</option>
<option value="Name" >Name</option>
<option value="Age" >Age</option>
<option value="" >Most Current</option>
<% end if %>
<% if Sortby= "Color1" then %>
<option value="Color1" selected>Color</option>
<option value="Breed" >Breed</option>
<option value= "Price">Price</option>
<option value="Name"  >Name</option>
<option value="Age"  >Age</option>
<option value="" >Most Current</option>
<% end if %>
<% if Sortby= "Name" then %>
<option value="Color1" >Color</option>
<option value="Breed" >Breed</option>
<option value= "Price">Price</option>
<option value="Name" selected >Name</option>
<option value="Age"  >Age</option>
<option value="" >Most Current</option>
<% end if %>
<% if Sortby= "Age" then %>
<option value="Color1" >Color</option>
<option value="Breed" >Breed</option>
<option value= "Price">Price</option>
<option value="Name"  >Name</option>
<option value="Age" selected >Age</option>
<option value="" >Most Current</option>
<% end if %>
<% if trim(Sortby)= "Price" then %>
<option value= "Price" selected>Price</option>
<option value="Breed">Breed</option>
<option value="Color1">Color</option>
<option value="Name">Name</option>
<option value="Age" >Age</option>
<option value="" >Most Current</option>
<% end if %>
</select>
  </div>
</div>




<% showorderby = True
if showorderby = True then %>
<div class = "row">
    <div class = "col" align= "left">Order By<br />
<select size="1" name="Orderby" style="width: 190px" class = "formbox">
<% if Orderby = "Asc" then %>
<option value= "Asc" selected>Lowest to Highest</option>
<option value="Desc">Highest to Lowest</option>
<% else %>
<option value="Desc" selected>Highest to Lowest</option>
<option value= "Asc" >Lowest to Highest</option>
<% end if %>
</select>
</div>
</div>


<% end if %>
<% end if %>


<div class = "row">
    <div class = "col" align= "center">
<br />
<center><input type=submit value = "SEARCH" class = "regsubmit2"  class = "body" ></center>
<br />
</form>

</div>
</div>
</div>

