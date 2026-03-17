<tr>
<td class = "body2" align = "right">
Species <%=TempSpeciesNum %>:
</td>
<td class = "body" align = "left">
	<%
	 TempSpeciesBreed = ""
	if len(TempspeciesID) > 0 then 
 sql2 = "select Species from SpeciesAvailable where SpeciesID=" & TempspeciesID
 response.write("sql2=" & sql2)
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
        <option  value="16">Cats</option>
	</select>
</td>

</tr>
