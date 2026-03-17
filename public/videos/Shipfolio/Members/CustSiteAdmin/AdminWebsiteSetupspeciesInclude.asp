<tr>
<td class = "body2" align = "right">
Species <%=TempSpeciesNum %>:
</td>
<td class = "body" align = "left">
	<%
	 TempSpeciesBreed = ""
	if len(TempspeciesID) > 0 then 
 sql2 = "select Species from SpeciesAvailable where SpeciesID=" & TempspeciesID
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3
if not rs2.eof then
 TempSpeciesBreed = rs2("Species")
 else
 TempSpeciesBreed = ""
end if
rs2.close
end if
%>

	<select size="1" name=<%=TempSpeciesIDName %> onchange="this.form.submit()">

<% if len(TempSpeciesBreed) > 0 then %>
	<option value="<%=TempspeciesID %>" selected><%=TempSpeciesBreed %></option>
	<option value="0" >N/A</option>
	<%else%>
	<option value="0" selected>N/A</option>
	<% end if %>
			
		<option value="2">Alpacas</option>
		<option  value="3">Dogs</option>
		<option  value="4">Llamas</option>
		<option  value="5">Horses</option>
		<option  value="6">Goats</option>
		<option  value="7">Donkeys (includes Mules & Hinnies)</option>
		<option  value="8">Cattle</option>
		<option  value="9">Bison</option>
		<option  value="10">Sheep</option>
		<option  value="11">Rabbits</option>
		<option  value="12">Pigs</option>
		<option  value="13">Chickens</option>
		<option  value="14">Turkeys</option>
		<option  value="15">Ducks</option>
	</select>
</td>
<td class = "body" align = "right">
<% 
if len(TempspeciesID) > 0 then
sql2 = "select * from SpeciesBreedLookupTable where SpeciesID=" & TempspeciesID
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3
if not rs2.eof then %>
Prefered Species:
<% end if 
rs2.close 
end if %>
</td>
<td class = "body" align = "left">
<% if len(TempspeciesID) > 0 then 
 if len(TempPreferedSpeciesID) > 0 then
 sql2 = "select Breed from SpeciesBreedLookupTable where BreedLookupID=" & TempPreferedSpeciesID
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3
if not rs2.eof then
 TempPreferedSpeciesBreed = rs2("Breed")
else
TempPreferedSpeciesBreed = 0
end if
rs2.close
 end if
 
 sql2 = "select * from SpeciesBreedLookupTable where SpeciesID=" & TempspeciesID
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3
if not rs2.eof then %>
   <select size="1" name="PreferedSpecies<%=TempSpeciesNum %>ID" onchange="this.form.submit()">
   	<% if TempPreferedSpeciesID > 0 then %>
			<option value="<%=TempPreferedSpeciesID %>" selected><%=TempPreferedSpeciesBreed %></option>
	<% else %>
		<option value="" selected>N/A</option>
	<% end if %>
<%
end if

while not(rs2.eof)  %>
<option value="<%=rs2("BreedLookupID")%>" class="body"><%=rs2("Breed")%></option>

<% rs2.movenext
wend %>
	</select>
<% end if
 if len(TempPreferedSpeciesID) > 0 then
rs2.close
end if
 %>


</td>
</tr>
