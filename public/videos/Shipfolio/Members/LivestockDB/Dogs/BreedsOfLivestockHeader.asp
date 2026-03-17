<table border="0" cellpadding="0" cellspacing="0" width="<%=screenwidth %>" >
<tr>
<% widthpercent="16%" 

if screenwidth < 801 then
BR="</BR>"
else
BR=""
end if
%>
<% if currentbreed="Bovines" then %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="#406D33"><a href="/Cattle/?Screenwidth=<%=Screenwidth %>" class="navBlack"><img src= "/icons/CattleIconWhite.png" border="0" width="50" alt="About Cattle" /><%=BR%>Bovines</a></td>
<% else %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="#F0BC42"><a href="/cattle/?Screenwidth=<%=Screenwidth %>" class="navBlack"><img src= "/icons/CattleIconWhite.png" border="0" width="50" alt="About Cattle" /><%=BR%>Bovines</a></td>
<% end if %>

<% if currentbreed="Camelids" then %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="#406D33"><a href="/Alpacas/?Screenwidth=<%=Screenwidth %>" class="navBlack"><img src= "/icons/AlpacaIconWhite.png" border="0" width="50" alt="About Alpacas, Llamas, and Camels"/><%=BR%>Camelids</a></td>
<% else %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="#F0BC42"><a href="/Alpacas/?Screenwidth=<%=Screenwidth %>" class="navBlack"><img src= "/icons/AlpacaIconWhite.png" border="0" width="50" alt="About Alpacas, Llamas, and Camels"/><%=BR%>Camelids</a></td>
<% end if %>


<% if currentbreed="Equines" then %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="#406D33"><a href="/Horses/?Screenwidth=<%=Screenwidth %>" class="navBlack"><img src= "/icons/HorseIconWhite.png" border="0" width="50" alt="About Horses"/><%=BR%>Equines</a></td>
<% else %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="#F0BC42"><a href="/Horses/?Screenwidth=<%=Screenwidth %>" class="navBlack"><img src= "/icons/HorseIconWhite.png" border="0" width="50" alt="About Horses"/><%=BR%>Equines</a></td>
<% end if %>


<% if currentbreed="Goats" then %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="#406D33"><a href="/Goats/?Screenwidth=<%=Screenwidth %>" class="navBlack"><img src= "/icons/GoatIconWhite.png" border="0" width="50" alt="About Goats"/><%=BR%>Goats</a></td>
<% else %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="#F0BC42"><a href="/Goats/?Screenwidth=<%=Screenwidth %>" class="navBlack"><img src= "/icons/GoatIconWhite.png" border="0" width="50" alt="About Goats"/><%=BR%>Goats</a></td>
<% end if %>

<% if currentbreed="Pigs" then %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="#406D33" valign="bottom"><a href="/Pigs/?Screenwidth=<%=Screenwidth %>" class="navBlack"><img src= "/icons/PigsIconWhite.png" border="0" alt="About Pigs" width="50"/><%=BR%>Swine</a></td>
<% else %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="#F0BC42" valign="bottom"><a href="/Pigs/?Screenwidth=<%=Screenwidth %>" class="navBlack"><img src= "/icons/PigsIconWhite.png" border="0" width="50" alt="About Pigs"/><%=BR%>Swine</a></td>
<% end if %>

<% if currentbreed="Sheep" then %>
<td class="body" align="center"  bgcolor="#406D33"><a href="/Sheep/?Screenwidth=<%=Screenwidth %>" class="navBlack"><img src= "/icons/SheepIconWhite.png" border="0" alt="About Sheep" width="40" /><%=BR%>Sheep</a></td>
<% else %>
<td class="body" align="center"  bgcolor="#F0BC42"><a href="/icons/Sheep/?Screenwidth=<%=Screenwidth %>" class="navBlack"><img src= "/icons/SheepIconwhite.png" border="0" alt="About Sheep" width="40" /><%=BR%>Sheep</a></td>
<% end if %>

</tr></table>