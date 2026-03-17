
<form action= "Studs.asp#Results" method = "post">
<input type="hidden" name = "speciesID" value = "<%=speciesID %>" >
<div class="container-fluid" align = "center">
<div class = "row">
  <div class = "col-12" style="background-color:#dddddd">
  <b>Search</b>
  </div>

<% 
if rs2.state = 0 then
else
rs2.close
end if

sql2 = "select Breed, BreedLookupID from SpeciesBreedLookupTable where SpeciesID=" & SpeciesID & " order by Breed ASC"
rs2.Open sql2, conn, 3, 3
if not rs2.eof then %>
<div class = "row">
    <div class = "col-6" align= "left">Breed<br />
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


<% end if
rs2.close %>


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
</div>



<div class = "row">
    <div class = "col-6" align= "left">Min. Fee<br />
<select  name="currentminStudFee" style="width: 190px" class = "formbox">
<% If Len(currentminStudFee) > 1 then %>
<option  value= "<%=currentminStudFee %>" selected><%=formatcurrency(currentminStudFee ,0) %></option>
<option  value= "0">No Minimum</option>
<% else %>
<option  value= "0" selected>No Minimum</option>
<% End If %>
<option value= "50">$50 </option>
<option value= "100">$100</option>
<option  value= "500">$500</option>
<option  value= "1000">$1,000</option>
<option  value= "1500">$1,5000</option>
<option  value= "5000">$5,000</option>
<option  value= "7500">$7,000</option>
</select>
  </div>


    <div class = "col-6" align= "left">Max. Fee<br />
<select  name="currentmaxStudFee" style="width: 190px" class = "formbox">
<% If Len(currentmaxStudFee) > 1 and not currentmaxStudFee = "100000000"  then %>
<option  value= "<%=currentmaxStudFee %>" selected><%=formatcurrency(currentmaxStudFee,0) %></option>
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




<% 
if len(RegistrationID) < 1 then RegistrationID = 0 end if 
 %>
<div class = "row">
    <div class = "col-6" align= "left">
    <label for="Registration">Registration</label><br />

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
<div class = "row">
    <div class = "col-12" align= "center">
    <br />Sort By 

<% if Sortby = "Category" or SortBy="Most Current" then Sortby = "StudFee Asc" %>
<select size="1" name="Sortby" style="width: 190px" class = "formbox">
<% if len(trim(Sortby)) < 3  then %>
<option value= "StudFee Desc" >Stud Fee Desc</option>
<option value= "StudFee Asc" >Stud Fee Asc</option>
<option value="Breed">Breed</option>
<option value="Color1">Color</option>
<option value="Name">Name</option>
<option value="Age" >Age</option>
<% end if %>
<% if Sortby= "Breed" then %>
<option value= "StudFee Desc" >Stud Fee Desc</option>
<option value= "StudFee Asc" >Stud Fee Asc</option>
<option value="Breed" selected>Breed</option>
<option value="Color1">Color</option>
<option value="Name">Name</option>
<option value="Age" >Age</option>
<% end if %>
<% if Sortby= "Color1" then %>
<option value= "StudFee Desc" >Stud Fee Desc</option>
<option value= "StudFee Asc" >Stud Fee Asc</option>
<option value="Breed">Breed</option>
<option value="Color1" selected>Color</option>
<option value="Name">Name</option>
<option value="Age" >Age</option>
<% end if %>
<% if Sortby= "Name" then %>
<option value= "StudFee Desc" >Stud Fee Desc</option>
<option value= "StudFee Asc" >Stud Fee Asc</option>
<option value="Breed">Breed</option>
<option value="Color1">Color</option>
<option value="Name" selected>Name</option>
<option value="Age" >Age</option>
<% end if %>
<% if Sortby= "Age" then %>
<option value= "StudFee Desc" >Stud Fee Desc</option>
<option value= "StudFee Asc" >Stud Fee Asc</option>
<option value="Breed">Breed</option>
<option value="Color1">Color</option>
<option value="Name">Name</option>
<option value="Age" selected>Age</option>
<% end if %>
<% if trim(Sortby)= "StudFee Desc" then %>
<option value= "StudFee Desc" selected>Stud Fee Desc</option>
<option value= "StudFee Asc" >Stud Fee Asc</option>
<option value="Breed">Breed</option>
<option value="Category">Gender</option>
<option value="Name">Name</option>
<option value="Age" >Age</option>
<% end if %>
<% if trim(Sortby)= "StudFee Asc"  then %>
<option value= "StudFee Desc" >Stud Fee Desc</option>
<option value= "StudFee Asc" selected>Stud Fee Asc</option>
<option value="Breed">Breed</option>
<option value="Color1">Color</option>
<option value="Name">Name</option>
<option value="Age" >Age</option>
<% end if %>
</select>
  </div>
</div>


<div class = "row">
    <div class = "col" align= "center">
<br />
<center><input type=submit value = "Search" class = "regsubmit2"  class = "body" ></center>
<br />
</form>

</div>
</div>
</div>
</div>