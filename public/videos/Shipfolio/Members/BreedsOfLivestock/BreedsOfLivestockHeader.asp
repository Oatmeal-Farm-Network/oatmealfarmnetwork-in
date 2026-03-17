<div><div class="d-none d-lg-block">
<%
LivestockColor1 = "BCC4BB"
LivestockColor2  = "#865e49"
%><table border="0" cellpadding="0" cellspacing="0" height = 47 bgcolor = "<%=LivestockColor1%>" width = 100%>
<tr><td>

<table border="0" cellpadding="0" cellspacing="0" width="100%" height = 47 align = center>
<tr>






<% if CurrentBreed = "Alpacas" then %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="<%=LivestockColor2%>" valign="bottom"><a href="/Alpacas/" class="navBlack"><img src= "/icons/Alpacaiconwhite.png" border="0" width="40" alt="Alpacas" /><br />Alpacas</a><br /><br /></td>
<% else %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="<%=LivestockColor1%>" valign="bottom"><a href="/Alpacas/" class="navBlack"><img src= "/icons/Alpacaiconwhite.png" border="0" width="40" alt="Alpacas" /><br />Alpacas</a><br /><br /></td>
<% end if %>

<% if currentbreed="HoneyBees" then %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="<%=LivestockColor2%>" valign="bottom"><a href="/HoneyBees/" class="navBlack"><img src= "/icons/HoneyBeesiconwhite.png" border="0" width="40" alt="Honey Bees" /><br />Bees</a><br /><br /></td>
<% else %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="<%=LivestockColor1%>" valign="bottom"><a href="/HoneyBees/" class="navBlack"><img src= "/icons/HoneyBeesiconwhite.png" border="0" width="40" alt="HoneyBees" /><br />Bees</a><br /><br /></td>
<% end if %>


<% if currentbreed="Bison" then %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="<%=LivestockColor2%>" valign="bottom"><a href="/Bison/" class="navBlack"><img src= "/icons/buffaloiconwhite.png" border="0" width="40" alt="Bison" /><br />Bison</a><br /><br /></td>
<% else %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="<%=LivestockColor1%>" valign="bottom"><a href="/Bison/" class="navBlack"><img src= "/icons/buffaloiconwhite.png" border="0" width="40" alt="Bison" /><br />Bison</a><br /><br /></td>
<% end if %>


<% if currentbreed="Buffalo" then %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="<%=LivestockColor2%>" valign="bottom"><a href="/Buffalo/" class="navBlack"><img src= "/icons/WaterBuffaloiconwhite.png" border="0" width="40" alt="Buffalo" /><br />Buffalo</a><br /><br /></td>
<% else %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="<%=LivestockColor1%>" valign="bottom"><a href="/Buffalo/" class="navBlack"><img src= "/icons/WaterBuffaloiconwhite.png" border="0" width="40" alt="Buffalo" /><br />Buffalo</a><br /><br /></td>
<% end if %>

<% if currentbreed="Camels" then %>
<td class="body2" align="center" bgcolor="<%=LivestockColor2%>" valign="bottom" width="<%=widthpercent %>"><a href="/Camels/" class="navBlack"><img src= /icons/CamelsIconWhite.png border="0" width="40" alt="Camels" /><br />Camels</a><br /><br /></td>
<% else %>
<td class="body2" align="center" bgcolor="<%=LivestockColor1%>" valign="bottom" width="<%=widthpercent %>"><a href="/Camels/" class="navBlack"><img src= "/icons/CamelsIconWhite.png" border="0" width="40" alt="Camels" /><br />Camels</a><br /><br /></td>
<% end if %>



<% if currentbreed="Cattle" then %>
<td class="body2" align="center" bgcolor="<%=LivestockColor2%>" valign="bottom" width="<%=widthpercent %>"><a href="/Cattle/" class="navBlack"><img src= /icons/CattleIconWhite.png border="0" width="40" alt="Cattle" /><br />Cattle</a><br /><br /></td>
<% else %>
<td class="body2" align="center" bgcolor="<%=LivestockColor1%>" valign="bottom" width="<%=widthpercent %>"><a href="/Cattle/" class="navBlack"><img src= "/icons/CattleIconWhite.png" border="0" width="40" alt="Cattle" /><br />Cattle</a><br /><br /></td>
<% end if %>



<% if currentbreed="Chickens" then %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="<%=LivestockColor2%>" valign="bottom"><a href="/Chickens/" class="navBlack"><img src= "/icons/Chickeniconwhite.png" border="0" width="30" alt="Chicken" /><br />Chickens</a><br /><br /></td>
<% else %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="<%=LivestockColor1%>" valign="bottom"><a href="/Chickens/" class="navBlack"><img src= "/icons/Chickeniconwhite.png" border="0" width="30" alt="Chickens" /><br />Chickens</a><br /><br /></td>
<% end if %>

<% if currentbreed="Crocodile / Alligator" then %>
<td class="body2" align="center" style="max-width:60px" bgcolor="<%=LivestockColor2%>" valign="bottom"><a href="/Crocodiles/" class="navBlack"><img src= "/icons/AlligatorIconWhite.png" border="0" width="40" alt="Crocodiles & Alligators" /><br />Crocs <br />& Gators</a><br /></td>
<% else %>
<td class="body2" align="center" style="max-width:60px" bgcolor="<%=LivestockColor1%>" valign="bottom"><a href="/Crocodiles/" class="navBlack"><img src= "/icons/AlligatorIconWhite.png" border="0" width="40" alt="Crocodiles & Alligators" /><br />Crocs <br />& Gators</a><br /></td>
<% end if %>


<% if currentbreed="Deer" then %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="<%=LivestockColor2%>" valign="bottom"><a href="/Deer/" class="navBlack"><img src= "/icons/Deericonwhite.png" border="0" width="40" alt="Deer" /><br />Deer</a><br /><br /></td>
<% else %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="<%=LivestockColor1%>" valign="bottom"><a href="/Deer/" class="navBlack"><img src= "/icons/Deericonwhite.png" border="0" width="40" alt="Deer" /><br />Deer</a><br /><br /></td>
<% end if %>


<% if currentbreed="Dogs" then %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="<%=LivestockColor2%>" valign="bottom"><a href="/Dogs/" class="navBlack"><img src= "/icons/Dogiconwhite.png" border="0" width="40" alt="Dogs" /><br />Dogs</a><br /><br /></td>
<% else %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="<%=LivestockColor1%>" valign="bottom"><a href="/Dogs/" class="navBlack"><img src= "/icons/Dogiconwhite.png" border="0" width="40" alt="Donkeys" /><br />Dogs</a><br /><br /></td>
<% end if %>

<% if currentbreed="Donkeys" then %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="<%=LivestockColor2%>" valign="bottom"><a href="/Donkeys/" class="navBlack"><img src= "/icons/Donkeyiconwhite.png" border="0" width="40" alt="Donkeys" /><br />Donkeys</a><br /><br /></td>
<% else %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="<%=LivestockColor1%>" valign="bottom"><a href="/Donkeys/" class="navBlack"><img src= "/icons/Donkeyiconwhite.png" border="0" width="40" alt="Donkeys" /><br />Donkeys</a><br /><br /></td>
<% end if %>

<% if currentbreed="Ducks" then %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="<%=LivestockColor2%>" valign="bottom"><a href="/Donkeys/" class="navBlack"><img src= "/icons/Duckiconwhite.png" border="0" width="40" alt="Donkeys" /><br />Ducks</a><br /><br /></td>
<% else %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="<%=LivestockColor1%>" valign="bottom"><a href="/Ducks/" class="navBlack"><img src= "/icons/Duckiconwhite.png" border="0" width="40" alt="Ducks" /><br />Ducks</a><br /><br /></td>
<% end if %>


<% if currentbreed="Emus" then %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="<%=LivestockColor2%>" valign="bottom"><a href="/Emus/" class="navBlack"><img src= "/icons/emuiconwhite.png" border="0" width="40" alt="Emus" /><br />Emus</a><br /><br /></td>
<% else %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="<%=LivestockColor1%>" valign="bottom"><a href="/Emus/" class="navBlack"><img src= "/icons/emuiconwhite.png" border="0" width="40" alt="Emus" /><br />Emus</a><br /><br /></td>
<% end if %>


<% if currentbreed="Geese" then %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="<%=LivestockColor2%>" valign="bottom"><a href="/Geese/" class="navBlack"><img src= "/icons/GeeseIconWhite.png" border="0" width="40" alt="Geese" /><br />Geese</a><br /><br /></td>
<% else %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="<%=LivestockColor1%>" valign="bottom"><a href="/Geese/" class="navBlack"><img src= "/icons/GeeseIconWhite.png" border="0" width="40" alt="Geese" /><br />Geese</a><br /><br /></td>
<% end if %>


</tr>
<tr>

<% if currentbreed="Goats" then %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="<%=LivestockColor2%>" valign="bottom"><a href="/Goats/" class="navBlack"><img src= "/icons/Goaticonwhite.png" border="0" width="40" alt="Goats" /><br />Goats</a><br /></td>
<% else %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="<%=LivestockColor1%>" valign="bottom"><a href="/Goats/" class="navBlack"><img src= "/icons/Goaticonwhite.png" border="0" width="40" alt="Goats" /><br />Goats</a><br /></td>
<% end if %>




<% if currentbreed="GuineaFowl" then %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="<%=LivestockColor2%>" valign="bottom"><a href="/GuineaFowl/" class="navBlack"><img src= "/icons/GuineaFowliconwhite.png" border="0" width="30" alt="GuineaFowl" /><br />GuineaFowl</a></td>
<% else %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="<%=LivestockColor1%>" valign="bottom"><a href="/GuineaFowl/" class="navBlack"><img src= "/icons/GuineaFowliconwhite.png" border="0" width="30" alt="GuineaFowl" /><br />GuineaFowl</a></td>
<% end if %>


<% if currentbreed="Horses" then %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="<%=LivestockColor2%>" valign="bottom"><a href="/Horses/" class="navBlack"><img src= "/icons/Horseiconwhite.png" border="0" width="40" alt="Horses" /><br />Horses</a></td>
<% else %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="<%=LivestockColor1%>" valign="bottom"><a href="/Horses/" class="navBlack"><img src= "/icons/Horseiconwhite.png" border="0" width="40" alt="Horses" /><br />Horses</a></td>
<% end if %>

<% if currentbreed="Llamas" then %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="<%=LivestockColor2%>" valign="bottom"><a href="/Llamas/" class="navBlack"><img src= "/icons/LlamaIconWhite.png" border="0" width="40" alt="Llamas" /><br />Llamas</a></td>
<% else %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="<%=LivestockColor1%>" valign="bottom"><a href="/Llamas/" class="navBlack"><img src= "/icons/LlamaIconWhite.png" border="0" width="40" alt="Llamas" /><br />Llamas</a></td>
<% end if %>

<% hidemuskox = True
if hidemuskox = false then   %>

<% if currentbreed="muskox" then %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="<%=LivestockColor2%>" valign="bottom"><a href="/MuskOx/" class="navBlack"><img src= "/icons/MuskOxiconwhite.png" border="0" width="40" alt="MuskOx" /><br />Musk Ox</a></td>
<% else %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="<%=LivestockColor1%>" valign="bottom"><a href="/MuskOx/" class="navBlack"><img src= "/icons/MuskOxiconwhite.png" border="0" width="40" alt="MuskOx" /><br />Musk Ox</a></td>
<% end if %>
<% end if %>

<% if currentbreed="Ostriches" then %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="<%=LivestockColor2%>" valign="bottom"><a href="/Ostriches/" class="navBlack"><img src= "/icons/OstricheIconWhite.png" border="0" width="40" alt="Ostriches" /><br />Ostriches</a></td>
<% else %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="<%=LivestockColor1%>" valign="bottom"><a href="/Ostriches/" class="navBlack"><img src= "/icons/OstricheIconWhite.png" border="0" width="40" alt="Ostriches" /><br />Ostriches</a></td>
<% end if %>


<% if currentbreed="Pheasants" then %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="<%=LivestockColor2%>" valign="bottom"><a href="/Pheasants/" class="navBlack"><img src= "/icons/PheasantIconWhite.png" border="0" width="40" alt="Pheasants" /><br />Pheasants</a></td>
<% else %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="<%=LivestockColor1%>" valign="bottom"><a href="/Pheasants/" class="navBlack"><img src= "/icons/PheasantIconWhite.png" border="0" width="40" alt="Pheasants" /><br />Pheasants</a></td>
<% end if %>



<% if currentbreed="Pigeons" then %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="<%=LivestockColor2%>" valign="bottom"><a href="/Pigeons/" class="navBlack"><img src= "/icons/PigeonIconWhite.png" border="0" width="40" alt="Pigeons" /><br />Pigeons</a></td>
<% else %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="<%=LivestockColor1%>" valign="bottom"><a href="/Pigeons/" class="navBlack"><img src= "/icons/PigeonIconWhite.png" border="0" width="40" alt="Pigeons" /><br />Pigeons</a></td>
<% end if %>

<% if currentbreed="Pigs" then %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="<%=LivestockColor2%>" valign="bottom"><a href="/Pigs/" class="navBlack"><img src= "/icons/PigsIconWhite.png" border="0" width="40" alt="Pigs" /><br />Pigs</a></td>
<% else %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="<%=LivestockColor1%>" valign="bottom"><a href="/Pigs/" class="navBlack"><img src= "/icons/PigsIconWhite.png" border="0" width="40" alt="Pigs" /><br />Pigs</a></td>
<% end if %>


<% if currentbreed="Quails" then %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="<%=LivestockColor2%>" valign="bottom"><a href="/Quails/" class="navBlack"><img src= "/icons/Quailiconwhite.png" border="0" width="40" alt="Emus" /><br />Quail</a></td>
<% else %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="<%=LivestockColor1%>" valign="bottom"><a href="/Quails/" class="navBlack"><img src= "/icons/Quailiconwhite.png" border="0" width="40" alt="Emus" /><br />Quail</a></td>
<% end if %>


<% if currentbreed="Rabbits" then %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="<%=LivestockColor2%>" valign="bottom"><a href="/Rabbits/" class="navBlack"><img src= "/icons/Rabbiticonwhite.png" border="0" width="25" alt="Rabbits" /><br />Rabbits</a></td>
<% else %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="<%=LivestockColor1%>" valign="bottom"><a href="/Rabbits/" class="navBlack"><img src= "/icons/Rabbiticonwhite.png" border="0" width="25" alt="Rabbits" /><br />Rabbits</a></td>
<% end if %>


<% if currentbreed="Sheep" then %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="<%=LivestockColor2%>" valign="bottom"><a href="/Sheep/" class="navBlack"><img src= "/icons/Sheepiconwhite.png" border="0" width="40" alt="Sheep" /><br />Sheep</a></td>
<% else %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="<%=LivestockColor1%>" valign="bottom"><a href="/Sheep/" class="navBlack"><img src= "/icons/Sheepiconwhite.png" border="0" width="40" alt="Sheep" /><br />Sheep</a></td>
<% end if %>

<% if currentbreed="Snails" then %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="<%=LivestockColor2%>" valign="bottom"><a href="/Snails/" class="navBlack"><img src= "/icons/Snailiconwhite.png" border="0" width="40" alt="Snails" /><br />Snails</a></td>
<% else %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="<%=LivestockColor1%>" valign="bottom"><a href="/Snails/" class="navBlack"><img src= "/icons/Snailiconwhite.png" border="0" width="40" alt="Snails" /><br />Snails</a></td>
<% end if %>


<% if currentbreed="Turkeys" then %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="<%=LivestockColor2%>" valign="bottom"><a href="/Turkeys/" class="navBlack"><img src= "/icons/Turkeyiconwhite.png" border="0" width="40" alt="Turkeys" /><br />Turkeys</a></td>
<% else %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="<%=LivestockColor1%>" valign="bottom"><a href="/Turkeys/" class="navBlack"><img src= "/icons/Turkeyiconwhite.png" border="0" width="40" alt="Turkeys" /><br />Turkeys</a></td>
<% end if %>



<% if currentbreed="Yaks" then %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="<%=LivestockColor2%>" valign="bottom"><a href="/Yaks/" class="navBlack"><img src= "/icons/Yakiconwhite.png" border="0" width="40" alt="Yaks" /><br />Yaks</a></td>
<% else %>
<td class="body2" align="center" width="<%=widthpercent %>" bgcolor="<%=LivestockColor1%>" valign="bottom"><a href="/Yaks/" class="navBlack"><img src= "/icons/Yakiconwhite.png" border="0" width="40" alt="Yaks" /><br />Yaks</a></td>
<% end if %>
</tr>



</table></td></tr></table></div></div>
<div class ="container" style="background-color:white; padding: 0px">