<table border="0" cellpadding="0" cellspacing="0" width="100%" >
<tr>
<% 
if screenwidth > 1100 then
widthpercent="6.6%" 
end if

if screenwidth < 1100 and screenwidth > 700 then
widthpercent="14%" 
end if

if screenwidth < 700 then
widthpercent="20%" 
end if

%>

<% 

if CurrentBreed = "RanchHome" then %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="<%=RanchColor2%>" valign="bottom"><a href="/Ranches/?Screenwidth=<%=Screenwidth %>" class="nav1"><img src= "/icons/BarnIconWhite.png" border="0" width="30" alt="Livestock Ranches" /><br />Ranch<br /> Home</a></td>
<% else %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="<%=RanchColor1%>" valign="bottom"><a href="/Ranches/?Screenwidth=<%=Screenwidth %>" class="nav1"><img src= "/icons/BarnIconWhite.png" border="0" width="30" alt="Livestock Ranches" /><br />Ranch<br>Homes</a></td>
<% end if %>


<% if CurrentBreed = "Alpacas" then %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="<%=RanchColor2%>" valign="bottom"><a href="/AlpacaRanches/?Screenwidth=<%=Screenwidth %>" class="nav1"><img src= "/icons/Alpacaiconwhite.png" border="0" width="50" alt="Alpaca Ranches" /><br />Alpaca<br />Ranches</a></td>
<% else %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="<%=RanchColor1%>" valign="bottom"><a href="/AlpacaRanches/?Screenwidth=<%=Screenwidth %>" class="nav1"><img src= "/icons/Alpacaiconwhite.png" border="0" width="50" alt="Alpaca Ranches" /><br />Alpaca<br />Ranches</a></td>
<% end if %>

<% if currentbreed="Bison" then %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="<%=RanchColor2%>" valign="bottom"><a href="/BisonRanches/?Screenwidth=<%=Screenwidth %>" class="nav1"><img src= "/icons/buffaloiconwhite.png" border="0" width="50" alt="Bison Ranches" /><br />Buffalo<br />Ranches</a></td>
<% else %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="<%=RanchColor1%>" valign="bottom"><a href="/BisonRanches/?Screenwidth=<%=Screenwidth %>" class="nav1"><img src= "/icons/buffaloiconwhite.png" border="0" width="50" alt="Bison Ranches" /><br />Buffalo<br />Ranches</a></td>
<% end if %>

<% if currentbreed="Cattle" then %>
<td class="body2" align="center" bgcolor="<%=RanchColor2%>" valign="bottom" width="<%=widthpercent %>"><a href="/CattleRanches/?Screenwidth=<%=Screenwidth %>" class="nav1"><img src= "/icons/CattleIconWhite.png" border="0" width="50" alt="Cattle Ranches" /><br />Cattle<br />Ranches</a></td>
<% else %>
<td class="body2" align="center" bgcolor="<%=RanchColor1%>" valign="bottom" width="<%=widthpercent %>"><a href="/CattleRanches/?Screenwidth=<%=Screenwidth %>" class="nav1"><img src= "/icons/CattleIconWhite.png" border="0" width="50" alt="Cattle Ranches" /><br />Cattle<br />Ranches</a></td>
<% end if %>



<% if currentbreed="Chickens" then %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="<%=RanchColor2%>" valign="bottom"><a href="/ChickenRanches/?Screenwidth=<%=Screenwidth %>" class="nav1"><img src= "/icons/Chickeniconwhite.png" border="0" width="30" alt="Chicken Ranches" /><br />Chicken<br />Ranches</a></td>
<% else %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="<%=RanchColor1%>" valign="bottom"><a href="/ChickenRanches/?Screenwidth=<%=Screenwidth %>" class="nav1"><img src= "/icons/Chickeniconwhite.png" border="0" width="30" alt="Chicken Ranches" /><br />Chicken<br />Ranches</a></td>

<% end if %>


<% if currentbreed="Dogs" then %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="<%=RanchColor2%>" valign="bottom"><a href="/DogRanches/?Screenwidth=<%=Screenwidth %>" class="nav1"><img src= "/icons/Dogiconwhite.png" border="0" width="40" alt="Dog Ranches" /><br />Dog<br />Ranches</a></td>
<% else %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="<%=RanchColor1%>" valign="bottom"><a href="/DogRanches/?Screenwidth=<%=Screenwidth %>" class="nav1"><img src= "/icons/Dogiconwhite.png" border="0" width="40" alt="Dog Ranches" /><br />Dog<br />Ranches</a></td>
<% end if %>

<% if screenwidth < 700 then %>
<tr>
</tr>
<% end if %>


<% if currentbreed="Donkeys" then %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="<%=RanchColor2%>" valign="bottom"><a href="/DonkeyRanches/?Screenwidth=<%=Screenwidth %>" class="nav1"><img src= "/icons/Donkeyiconwhite.png" border="0" width="50" alt="Donkey Ranches" /><br />Donkey<br />Ranches</a></td>
<% else %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="<%=RanchColor1%>" valign="bottom"><a href="/DonkeyRanches/?Screenwidth=<%=Screenwidth %>" class="nav1"><img src= "/icons/Donkeyiconwhite.png" border="0" width="50" alt="Donkey Ranches" /><br />Donkey<br />Ranches</a></td>
<% end if %>



<% if currentbreed="Emus" then %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="<%=RanchColor2%>" valign="bottom"><a href="/EmuRanches/?Screenwidth=<%=Screenwidth %>" class="nav1"><img src= "/icons/Emuiconwhite.png" border="0" width="50" alt="Emu Ranches" /><br />Emu<br />Ranches</a></td>
<% else %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="<%=RanchColor1%>" valign="bottom"><a href="/EmuRanches/?Screenwidth=<%=Screenwidth %>" class="nav1"><img src= "/icons/Emuiconwhite.png" border="0" width="50" alt="Emu Ranches" /><br />Emu<br />Ranches</a></td>
<% end if %>
<% if screenwidth > 700 and screenwidth < 1100 then %>
<tr>
</tr>
<% end if %>



<% if currentbreed="Goats" then %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="<%=RanchColor2%>" valign="bottom"><a href="/GoatRanches/?Screenwidth=<%=Screenwidth %>" class="nav1"><img src= "/icons/Goaticonwhite.png" border="0" width="50" alt="Goat Ranches" /><br />Goat<br />Ranches</a></td>
<% else %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="<%=RanchColor1%>" valign="bottom"><a href="/GoatRanches/?Screenwidth=<%=Screenwidth %>" class="nav1"><img src= "/icons/Goaticonwhite.png" border="0" width="50" alt="Goat Ranches" /><br />Goat<br />Ranches</a></td>
<% end if %>

<% if currentbreed="Horses" then %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="<%=RanchColor2%>" valign="bottom"><a href="/HorseRanches/?Screenwidth=<%=Screenwidth %>" class="nav1"><img src= "/icons/Horseiconwhite.png" border="0" width="50" alt="Horse Ranches" /><br />Horse<br />Ranches</a></td>
<% else %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="<%=RanchColor1%>" valign="bottom"><a href="/HorseRanches/?Screenwidth=<%=Screenwidth %>" class="nav1"><img src= "/icons/Horseiconwhite.png" border="0" width="50" alt="Horse Ranches" /><br />Horse<br />Ranches</a></td>
<% end if %>

<% if currentbreed="Llamas" then %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="<%=RanchColor2%>" valign="bottom"><a href="/LlamaRanches/?Screenwidth=<%=Screenwidth %>" class="nav1"><img src= "/icons/Llamaiconwhite.png" border="0" width="50" alt="Llama Ranches" /><br />Llama<br />Ranches</a></td>
<% else %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="<%=RanchColor1%>" valign="bottom"><a href="/LlamaRanches/?Screenwidth=<%=Screenwidth %>" class="nav1"><img src= "/icons/Llamaiconwhite.png" border="0" width="50" alt="Llama Ranches" /><br />Llama<br />Ranches</a></td>
<% end if %>





<% if currentbreed="Pigs" then %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="<%=RanchColor2%>" valign="bottom"><a href="/PigRanches/?Screenwidth=<%=Screenwidth %>" class="nav1"><img src= "/icons/PigsIconWhite.png" border="0" width="40" alt="Pig Ranches" /><br />Pig<br />Ranches</a></td>
<% else %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="<%=RanchColor1%>" valign="bottom"><a href="/PigRanches/?Screenwidth=<%=Screenwidth %>" class="nav1"><img src= "/icons/PigsIconWhite.png" border="0" width="40" alt="Pig Ranches" /><br />Pig<br />Ranches</a></td>
<% end if %>



<% if screenwidth < 700 then %>
<tr>
</tr>
<% end if %>



<% if currentbreed="Rabbits" then %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="<%=RanchColor2%>" valign="bottom"><a href="/RabbitRanches/?Screenwidth=<%=Screenwidth %>" class="nav1"><img src= "/icons/Rabbiticonwhite.png" border="0" width="25" alt="Rabbit Ranches" /><br />Rabbit<br />Ranches</a></td>
<% else %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="<%=RanchColor1%>" valign="bottom"><a href="/RabbitRanches/?Screenwidth=<%=Screenwidth %>" class="nav1"><img src= "/icons/Rabbiticonwhite.png" border="0" width="25" alt="Rabbit Ranches" /><br />Rabbit<br />Ranches</a></td>
<% end if %>

<% if currentbreed="Sheep" then %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="<%=RanchColor2%>" valign="bottom"><a href="/SheepRanches/?Screenwidth=<%=Screenwidth %>" class="nav1"><img src= "/icons/Sheepiconwhite.png" border="0" width="25" alt="Sheep Ranches" /><br />Sheep<br />Ranches</a></td>
<% else %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="<%=RanchColor1%>" valign="bottom"><a href="/SheepRanches/?Screenwidth=<%=Screenwidth %>" class="nav1"><img src= "/icons/Sheepiconwhite.png" border="0" width="25" alt="Sheep Ranches" /><br />Sheep<br />Ranches</a></td>
<% end if %>


<% if currentbreed="Turkeys" then %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="<%=RanchColor2%>" valign="bottom"><a href="/TurkeyRanches/?Screenwidth=<%=Screenwidth %>" class="nav1"><img src= "/icons/Turkeyiconwhite.png" border="0" width="50" alt="Turkey Ranches" /><br />Turkey<br />Ranches</a></td>
<% else %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="<%=RanchColor1%>" valign="bottom"><a href="/TurkeyRanches/?Screenwidth=<%=Screenwidth %>" class="nav1"><img src= "/icons/Turkeyiconwhite.png" border="0" width="50" alt="Turkey Ranches" /><br />Turkey<br />Ranches</a></td>
<% end if %>




<% if currentbreed="Yaks" then %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="<%=RanchColor2%>" valign="bottom"><a href="/YakRanches/?Screenwidth=<%=Screenwidth %>" class="nav1"><img src= "/icons/Yakiconwhite.png" border="0" width="45" alt="Yak Ranches" /><br />Yak<br />Ranches</a></td>
<% else %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="<%=RanchColor1%>" valign="bottom"><a href="/YakRanches/?Screenwidth=<%=Screenwidth %>" class="nav1"><img src= "/icons/Yakiconwhite.png" border="0" width="45" alt="Yak Ranches" /><br />Yak<br />Ranches</a></td>
<% end if %>
<td class="body2" align="center" bgcolor="<%=RanchColor1%>" valign="bottom"></td>

</tr></table>