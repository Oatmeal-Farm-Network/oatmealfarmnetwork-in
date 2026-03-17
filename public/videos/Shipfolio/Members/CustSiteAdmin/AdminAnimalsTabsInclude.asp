<br />
<% if len(SpeciesID) < 1 then
SpeciesHomePage = "/administration/default.asp#animals"
SpeciesName = "Animal"
else

if SpeciesID = 2 then
SpeciesName="Alpaca" 
SpeciesPlural="Alpacas" 
end if 
if SpeciesID = 3 then
SpeciesName="Dog"
SpeciesPlural="Dogs" 
end if 
if SpeciesID = 4 then
SpeciesName="Llama"
SpeciesPlural="Llamas" 
end if 
if SpeciesID = 5 then
SpeciesName="Horse"
SpeciesPlural="Horses" 
end if 
if SpeciesID = 6 then
SpeciesName="Goat"
SpeciesPlural="Goats" 
end if 
if SpeciesID = 7 then
SpeciesName="Donkey"
SpeciesPlural="Donkeys" 
end if 
if SpeciesID = 8 then
SpeciesName="Cattle"
SpeciesPlural="Cattle" 
end if 
if SpeciesID = 9 then
SpeciesName="Bison"
SpeciesPlural="Bison" 
end if 
if SpeciesID = 10 then
SpeciesName="Sheep"
SpeciesPlural="Sheep" 
end if 
if SpeciesID = 11 then
SpeciesName="Rabbit"
SpeciesPlural="Rabbits" 
end if 
if SpeciesID = 12 then
SpeciesName="Pig"
SpeciesPlural="Pigs" 
end if 
if  SpeciesID = 13 then
SpeciesName="Chicken"
SpeciesPlural="Chickens" 
end if 
if SpeciesID = 14 then
SpeciesName="Turkey"
SpeciesPlural="Turkeys" 
end if 
if SpeciesID = 15 then
SpeciesName="Duck"
SpeciesPlural="Ducks" 
end if 
if  SpeciesID = 16 then
SpeciesName="Cat"
SpeciesPlural="Cats" 
end if 

if SpeciesID = 2 then
SpeciesHomePage = "/administration/AdminAlpacashoms.asp"
end if

end if %>
<table cellpadding = "0" cellspacing = "0" border = "0" width = "<%=screenwidth %>" height = "28" align = "center">
<tr><td width = 10></td>
<td>
<%  if Current3 = "AnimalsHome" then %>
<td class = "tabtopon" width = "100" height = "20" align = "center" ><b><a href = "Default.asp#animals" class = "menu2">List of Animals</a></b></td>
<% else %>
<td class = "tabtopoff" width = "100" height = "20" align = "center" ><b><a href = "Default.asp#animals" class = "menu">List of Animals</a></b></td>
<% end if %> 
<%  if Current3 = "AddAnimal" then %>
<td class = "tabtopon" width = "90" height = "20" align = "center" ><b><a href = "/Administration/AdminAnimalAdd1.asp" class = "menu2">Add a <%=SpeciesName%></a></b></td>
<% else %>
<td class = "tabtopoff" width = "90" height = "20" align = "center" ><b><a href = "/Administration/AdminAnimalAdd1.asp" class = "menu">Add a <%=SpeciesName%></a></b></td>
<% end if %> 


<%  if Current3 = "AnimalEdit" then %>
<td class = "tabtopon" width = "90" height = "20" align = "center" ><b><a href = "/Administration/AdminAnimalEdit.asp?ID=<%=ID %>" class = "menu2">Edit <%=SpeciesName%></a></b></td>
<% else %>
<td class = "tabtopoff" width = "90" height = "20" align = "center" ><b><a href = "/Administration/AdminAnimalEdit.asp?ID=<%=ID %>" class = "menu">Edit <%=SpeciesName%></a></b></td>
<% end if %> 
<%  if Current3 = "Photos" then %>
<td class = "tabtopon" width = "90" height = "20" align = "center" ><b><a href = "/Administration/AdminPhotos.asp?ID=<%=ID %>" class = "menu2">Photos</a></b></td>
<% else %>
<td class = "tabtopoff" width = "90" height = "20" align = "center" ><b><a href = "/Administration/AdminPhotos.asp?ID=<%=ID %>" class = "menu">Photos</a></b></td>
<% end if %> 
<% showuploadepds = false
if numAlpacas > 0 and  showuploadepds = True  then
if Current3 = "UploadAlpacaEDP" then %>
<td class = "tabtopon" width = "90" height = "20" align = "center" ><b><a href = "/Administration/AdminUploadAlpacaEPDs.asp" class = "menu2">Upload EDPs1</a></b></td>
<% else %>
<td class = "tabtopoff" width = "90" height = "20" align = "center" ><b><a href = "/Administration/AdminUploadAlpacaEPDs.asp" class = "menu">Upload EDPs1</a></b></td>
<% end if %> 
<% end if %> 
<% showPreview=True
if  showPreview= True then %>
<%  if Current3 = "Preview" then %>
<td class = "tabtopon" width = "90" height = "20" align = "center" ><b><a href = "/Administration/AdminAnimalPreview.asp?ID=<%=ID %>" class = "menu2">Preview</a></b></td>
<% else %>
<td class = "tabtopoff" width = "90" height = "20" align = "center" ><b><a href = "/Administration/AdminAnimalPreview.asp?ID=<%=ID %>" class = "menu">Preview</a></b></td>
<% end if %> 
<% end if %> 
<%  if Current3 = "DeleteAnimals" then %>
<td class = "tabtopon" width = "90" height = "20" align = "center" ><b><a href = "/Administration/AdminAnimaldelete.asp" class = "menu2">Delete</a></b></td>
<% else %>
<td class = "tabtopoff" width = "90" height = "20" align = "center" ><b><a href = "/Administration/AdminAnimaldelete.asp" class = "menu">Delete</a></b></td>
<% end if %> 

<% if Current3 = "AnimalStats" then %>
<td class = "tabtopon" width = "90" height = "20" align = "center" ><b><a href = "/Administration/AdminalpacasStats.asp#Animals" class = "menu2">Statistics</a></b></td>
<% else %>
<td class = "tabtopoff" width = "90" height = "20" align = "center" ><b><a href = "/Administration/AdminalpacasStats.asp#Animals" class = "menu">Statistics</a></b></td>
<% end if %> 

<% showepds = false
if numAlpacas > 0 and showepds  then
if Current3 = "UploadAlpacaEPD" then %>
<td class = "tabtopon" width = "90" height = "20" align = "center" ><b><a href = "/Administration/AdminUploadAlpacaEPDs.asp" class = "menu2">Upload EPDs</a></b></td>
<% else %>
<td class = "tabtopoff" width = "90" height = "20" align = "center" ><b><a href = "/Administration/AdminUploadAlpacaEPDs.asp" class = "menu">Upload EPDs</a></b></td>
<% end if %> 
<% end if %> 
<% showtransfer = False
if showtransfer = True then
if Current3 = "TransferOwnership" then %>
<td class = "tabtopon" width = "100" height = "20" align = "center" ><b><a href = "/Administration/TransferAnimal.asp" class = "menu2">Transfer</a></b></td>
<% else %>
<td class = "tabtopoff" width = "100" height = "20" align = "center" ><b><a href = "/Administration/TransferAnimal.asp" class = "menu">Transfer</a></b></td>
<% end if %> 
<% end if %>   
<%  
showreports = false
if showreports = true then
if Current3 = "Reports" then %>
<td class = "tabtopon" width = "90" height = "20" align = "center" ><b><a href = "/Administration/Reports.asp" class = "menu2">Reports</a></b></td>
<% else %>
<td class = "tabtopoff" width = "90" height = "20" align = "center" ><b><a href = "/Administration/Reports.asp" class = "menu">Reports</a></b></td>
<% end if %> 
<% end if %>
 <td >&nbsp;</td>
</tr>
</table>