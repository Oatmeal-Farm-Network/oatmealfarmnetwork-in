<table border = "0" cellpadding = "0" cellspacing = "0" width = "<%=screenwidth %>" align = "left">
<tr>
<% widthpercent = "25%" 

if screenwidth < 801 then
BR=""
else
BR = ""
end if
%>


<% if currentbreed2= "Horses" then %>
<td class = "body2" align = "center" width = "<%=widthpercent %>" bgcolor = "#2B5600"><a href = "/Horses/?screenwidth=<%=screenwidth %>" class = "nav1"><img src= "/icons/horseIconWhite.png" border = "0" width = "50" alt = "Horse Information"/><%=BR%>Horses</a></td>
<%else%>
<td class = "body2" align = "center" width = "<%=widthpercent %>" bgcolor = "#406D33"><a href = "/Cattle/?screenwidth=<%=screenwidth %>" class = "nav1"><img src= "/icons/horseIconWhite.png" border = "0" width = "50" alt = "Horse Information"/><%=BR%>Horses</a></td>
<% end if %>



<% if currentbreed2= "Donkeys" then %>
<td class = "body2" align = "center" width = "<%=widthpercent %>" bgcolor = "#2B5600"><a href = "/Donkeys/?screenwidth=<%=screenwidth %>" class = "nav1"><img src= "/icons/donkeyIconWhite.png" border = "0" width = "50" alt = "Donkey Information"/><%=BR%>Donkeys</a></td>
<% else %>
<td class = "body2" align = "center" width = "<%=widthpercent %>" bgcolor = "#406D33"><a href = "/Donkeys/?screenwidth=<%=screenwidth %>" class = "nav1"><img src= "/icons/donkeyIconWhite.png" border = "0" width = "50" alt = "Donkey Information"/><%=BR%>Donkeys</a></td>
<% end if %>

</tr></table>
