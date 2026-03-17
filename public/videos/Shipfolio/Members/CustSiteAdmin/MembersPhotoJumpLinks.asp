<br /><br />
<table  border = "0" height = "25" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 bordercolor = "" align = "right" >
  <tr>
  <td ><div class = "body">Jump To: &nbsp;<br>
     <% if not (speciesID = 13 or speciesID = 14 or speciesID = 19) then %>
    <a href = "#Registration" class = "body">Registration Cert.</a>&nbsp;|&nbsp;
   <% if speciesID = 2 or speciesID = 4 or speciesID = 6 or speciesID = 10 or speciesID = 11 then %>

    <a href = "#Histogram" class = "body">Histogram</a>&nbsp;|&nbsp;
   <a href = "#FiberAnalysis" class = "body">Fiber Analysis</a>&nbsp;|&nbsp;
   <% end if %>
   <% end if %>

   <% if Subscriptionlevel > 3 then %>
   <a href = "#Photos" class = "body">Photos</a>&nbsp;|&nbsp;
   <% else %>
   <a href = "#Photos" class = "body">Photo</a>&nbsp;|&nbsp;
   <% end if %>
<a href = "MembersEditAnimal.asp?ID=<%=ID%>#BasicFacts" class = "body">Edit <%=name%>'s Information</a>
</div>
</td>
</tr>
</table>
