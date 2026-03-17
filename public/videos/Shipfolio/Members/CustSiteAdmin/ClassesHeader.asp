<% Current = "Classes" %><br />
<table cellpadding = "0" cellspacing = "0" border = "0" width = "100%" height = "34" >
<tr><td  width = "10"><img src = "images/px.gif" width = "1" height = "1"></td>

<% if Current3 = "Classes Home" then %>
<td class = "tabtopon" width = "100" height = "20" align = "center" ><b><a href = "/Administration/ClassesHome.asp" class = "menu2">Classes Overview</a></b></td>
<% else %>
<td class = "tabtopoff" width = "100" height = "20" align = "center" ><b><a href = "/Administration/ClassesHome.asp" class = "menu">Classes Overview</a></b></td>
<% end if %> 

<% if Current3 = "Add Classes" then %>
<td class = "tabtopon" width = "100" height = "20" align = "center" ><b><a href = "/Administration/ClassesAdd.asp" class = "menu2">Add Classes</a></b></td>
<% else %>
<td class = "tabtopoff" width = "100" height = "20" align = "center" ><b><a href = "/Administration/ClassesAdd.asp" class = "menu">Add Classes</a></b></td>
<% end if %> 

<% if Current3 = "Edit Classes" then %>
<td class = "tabtopon" width = "100" height = "20" align = "center" ><b><a href = "/Administration/ClassesEditDetails2.asp" class = "menu2">Edit Classes</a></b></td>
<% else %>
<td class = "tabtopoff" width = "100" height = "20" align = "center" ><b><a href = "/Administration/ClassesEditDetails2.asp" class = "menu">Edit Classes</a></b></td>
<% end if %> 


<% if Current3 = "Delete Class" then %>
<td class = "tabtopon" width = "100" height = "20" align = "center" ><b><a href = "/Administration/AdminClassesDelete.asp" class = "menu2">Delete Class</a></b></td>
<% else %>
<td class = "tabtopoff" width = "100" height = "20" align = "center" ><b><a href = "/Administration/AdminClassesDelete.asp" class = "menu">Delete Class</a></b></td>
<% end if %> 


<% if Current3 = "Add Addresses" then %>
<td class = "tabtopon" width = "100" height = "20" align = "center" ><b><a href = "/Administration/AdminClassesAddressAdd.asp" class = "menu2">Add Address</a></b></td>
<% else %>
<td class = "tabtopoff" width = "100" height = "20" align = "center" ><b><a href = "/Administration/AdminClassesAddressAdd.asp" class = "menu">Add Address</a></b></td>
<% end if %> 



<% if Current3 = "Edit Addresses" then %>
<td class = "tabtopon" width = "100" height = "20" align = "center" ><b><a href = "/Administration/AdminClassesAddressEdit.asp" class = "menu2">Edit Address</a></b></td>
<% else %>
<td class = "tabtopoff" width = "100" height = "20" align = "center" ><b><a href = "/Administration/AdminClassesAddressEdit.asp" class = "menu">Edit Address</a></b></td>
<% end if %> 

<% if Current3 = "Delete Addresses" then %>
<td class = "tabtopon" width = "100" height = "20" align = "center" ><b><a href = "/Administration/AdminClassesAddressDelete.asp" class = "menu2">Delete Address</a></b></td>
<% else %>
<td class = "tabtopoff" width = "100" height = "20" align = "center" ><b><a href = "/Administration/AdminClassesAddressdelete.asp" class = "menu">Delete Address</a></b></td>
<% end if %> 

<% 
showstudents = false
if showstudents = TRue then


if Current3 = "Photos" then %>
<td class = "tabtopon" width = "100" height = "20" align = "center" ><b><a href = "/Administration/ClassesPhotos.asp" class = "menu2">Photos</a></b></td>
<% else %>
<td class = "tabtopoff" width = "100" height = "20" align = "center" ><b><a href = "/Administration/ClassesPhotos.asp" class = "menu">Photos</a></b></td>
<% end if %> 


<% if Current3 = "Add Students" then %>
<td class = "tabtopon" width = "100" height = "20" align = "center" ><b><a href = "/Administration/StudentsAdd.asp" class = "menu2">Add Students</a></b></td>
<% else %>
<td class = "tabtopoff" width = "100" height = "20" align = "center" ><b><a href = "/Administration/StudentsAdd.asp" class = "menu">Add Students</a></b></td>
<% end if %> 

<% if Current3 = "Edit Students" then %>
<td class = "tabtopon" width = "100" height = "20" align = "center" ><b><a href = "/Administration/StudentsEdit.asp" class = "menu2">Edit Students</a></b></td>
<% else %>
<td class = "tabtopoff" width = "100" height = "20" align = "center" ><b><a href = "/Administration/StudentsEdit.asp" class = "menu">Edit Students</a></b></td>
<% end if %> 

<% end if %> 
<td ><img src = "images/px.gif" width = "1" height = "1"></td>
	</tr>
</table>

