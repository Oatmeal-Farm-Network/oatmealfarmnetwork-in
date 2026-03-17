
<form action= "Default.asp#Results" method = "post">
<input type="hidden" name = "speciesID" value = "<%=speciesID %>" >
<div class="container-fluid" align = "center">
<div class = "row">
  <div class = "col-12" style="background-color:#dddddd">
  <b>Search</b>
  </div>
<div class = "row">
    <div class = "col-6" align= "left">Breed<br />
<% 
if rs2.state = 0 then
else
rs2.close
end if

sql2 = "select Breed, BreedLookupID from SpeciesBreedLookupTable where SpeciesID=" & SpeciesID & " order by Breed ASC"
rs2.Open sql2, conn, 3, 3
if not rs2.eof then %>

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
wend%>
 </select>   
<% else %>
    N/A
<% end if
rs2.close %>

  </div>

<% If SpeciesID  = 23 then %>
<div class = "col-6" align= "left"></div>
</div>
<% else %>

   <div class = "col-6" align= "left">Gender Class<br />

<select size="1" name="SpeciesCategoryID" style="width: 190px" class = "formbox">
<% if SpeciesCategoryID > 0 and not SpeciesCategoryID = 10000 then 
sql2 = "select SpeciesCategoryPlural from SpeciesCategory where SpeciesCategoryID=" & SpeciesCategoryID 
response.write("sql2=" & sql2)
rs2.Open sql2, conn, 3, 3
Category = rs2("SpeciesCategoryPlural")
rs2.close
%>

<option value= "<%=SpeciesCategoryID  %>" selected class="body"><%=Category %></option>
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

<div class = "row">
<div class = "col-6" align= "left">Color<br />
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

<% 
if len(RegistrationID) < 1 then RegistrationID = 0 end if 
 %>

<div class = "col-6" align= "left"><label for="Registration">Registration</label><br />

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



<% if SpeciesID = 2 then %>
<div class = "row">
    <div class = "col-6" align= "left">Ancestry<br />
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
<% if len(country_id)> 0 then %>
<div class = "col-6" align= "left">
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

<% end if %>
<% end if %>


<div class = "row">
    <div class = "col-6" align= "left">Min. Price<br />
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



<div class = "col-6" align= "left">Max. Price<br />
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





<% showages = True
if showages = True then %>
<div class = "row">
    <div class = "col-6" align= "left">Min. Age<br />
<select size="1" name="MinAge" style="width: 190px" class = "formbox">
<% if len(MinAge) > 0 and not(MinAge = "Any") then %>
<option value= "<%=MinAge %>" selected><%=MinAge %> Year<% if MinAge > 1 then %>s<% end if %></option>
<option value= "Any" >No Minimum</option>
<% else %>
<option value= "Any" selected>No Minimum</option>
<% end if %>
<option value="1">1 Year</option>
<option value="2">2 Years</option>
<option value="3">3 Years</option>
<option value="4">4 Years</option>
<option value="5">5 Years</option>
<option value="6">6 Years</option>
<option value="7">7 Years</option>
<option value="8">8 Years</option>
<option value="9">9 Years</option>
<option value="10">10 Years</option>
<option value="15">15 Years</option>
</select>
  </div>




    <div class = "col-6" align= "left">Max. Age<br />
<select size="1" name="MaxAge" style="width: 190px" class = "formbox">
<% if len(MaxAge) > 0 and not(MaxAge = "Any") then %>
<option value= "<%=MaxAge %>" selected><%=MaxAge %> Year<% if MaxAge > 1 then %>s<% end if %></option>
<option value= "Any" >No Maximum</option>
<% else %>
<option value= "Any" selected>No Maximum</option>
<% end if %>
<option value="1">1 Year</option>
<option value="2">2 Years</option>
<option value="3">3 Years</option>
<option value="4">4 Years</option>
<option value="5">5 Years</option>
<option value="6">6 Years</option>
<option value="7">7 Years</option>
<option value="8">8 Years</option>
<option value="9">9 Years</option>
<option value="10">10 Years</option>
<option value="15">15 Years</option>
<option value="20">20 Years</option>
</select>

  </div>
</div>


<% end if %>


<div class = "row">
    <div class = "col-12" align= "center"><br />Sort By 
    <% if Sortby = "Category" then Sortby = "" %>
<select size="1" name="Sortby" style="width: 190px" class = "formbox">
<% if Sortby= "Breed" then %>
<option value="Breed"  selected>Breed</option>
<option value= "Price">Price</option>
<option value="Color1">Color</option>
<option value="Name" >Name</option>
<option value="Age" >Age</option>
<% end if %>
<% if Sortby= "Color1" then %>
<option value="Color1" selected>Color</option>
<option value="Breed" >Breed</option>
<option value= "Price">Price</option>
<option value="Name"  >Name</option>
<option value="Age"  >Age</option>
<% end if %>
<% if Sortby= "Name" then %>
<option value="Color1" >Color</option>
<option value="Breed" >Breed</option>
<option value= "Price">Price</option>
<option value="Name" selected >Name</option>
<option value="Age"  >Age</option>
<% end if %>
<% if Sortby= "Age" then %>
<option value="Color1" >Color</option>
<option value="Breed" >Breed</option>
<option value= "Price">Price</option>
<option value="Name"  >Name</option>
<option value="Age" selected >Age</option>
<% end if %>
<% if len(Sortby) < 3 or trim(Sortby)= "Price" or trim(Sortby) = "Most Current" then %>
<option value= "Price" selected>Price</option>
<option value="Breed">Breed</option>
<option value="Color1">Color</option>
<option value="Name">Name</option>
<option value="Age" >Age</option>
<% end if %>
</select>
  </div>




<% showorderby = False
if showorderby = True then %>

    <div class = "col-6" align= "left">Order By<br />
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
    <div class = "col-12" align= "center">
<br />
<center><input type=submit value = "Search" class = "regsubmit2"  class = "body" ></center>
<br />


</div>
</div>
</div>
</form>
</div>
</div>