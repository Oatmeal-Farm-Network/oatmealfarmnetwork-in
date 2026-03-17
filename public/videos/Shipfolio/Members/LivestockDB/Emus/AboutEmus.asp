<!DOCTYPE html>
<meta charset="UTF-8">

<head>
<!--#Include virtual="/includefiles/GlobalVariables.asp"-->
<link rel="canonical" href="<%=currenturl %>" />
<!--#Include virtual="/BreedsOfLivestock/AnimalsVariablesInclude.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<title>Emus | About Emus | Breeds of Livestock</title>
<meta name="Title" content="Emus | About Emus | Breeds of Livestock"/>
<meta name="Description" content="Emu are the second-largest living bird by height, after the ostrich, and the largest native bird in Australia. Emus are raised for their meat, leather, feathers and oil."> 
<meta name="robots" content="follow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="Googlebot" content="follow"/>
<meta name="author" content="Livestock Of The World"/>
<link rel="stylesheet" type="text/css" href="/style.css" />
</HEAD>
<% if mobiledevice = True or is_iPad = true then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<% end if %>
<!--#Include virtual="/Header.asp"-->
<!--#Include virtual="/BreedsofLivestock/BreedsOfLivestockHeader.asp"-->
<% if screenwidth < 700 then %>
<!--#Include virtual="/Emus/FowlHeader.asp"--> 
<% end if %>
<% If not rs.State = adStateClosed Then
  rs.close
End If 
if screenwidth > 800 then
contentwidth = screenwidth 
else 
contentwidth = 800
end if 	
Set rs2 = Server.CreateObject("ADODB.Recordset")
%>
<table border = "0" cellspacing="0" cellpadding = "0" align = "left" bgcolor = "white" width = "<%=screenwidth %>" height = "<%=screenwidth/3 %>">
<tr>

<% if screenwidth > 700 then %>
<td  align = "center" valign = "top">
<table border = "0" cellspacing="5" cellpadding = "0" align = "left" bgcolor = "white" width = "<%=screenwidth %>" >
<tr>
  <td width = "200"  class = "body" valign = "top" >
  <table cellpadding = 0 cellspacing = 0 width = 100% border = 0>

  <tr bgcolor = "#006533" height= 50>
   <td class = "body" >
  <a href = "/Emus/?Screenwidth=<%=Screenwidth %>" class = "body" ><img src= "/icons/emuiconwhite.png" border = "0" height= 50 alt = "Emus"/></a><br>
  </td>
 </td>
    <td class = "body" >
  <a href = "/Emus/?Screenwidth=<%=Screenwidth %>" class = "navwhiteblack" ><big>Emus</big></a><br>
  </td>
  </tr>
   <tr>
   <td colspan = 2 height = 8></td>
  </tr>



  <tr>
   <td colspan = 2  height = 28 valign = Bottom>
<b>Emus for Sale At:</b><br>
  </td>
</tr>
  <tr>
   <td colspan = 2 height = 8></td>
  </tr>
  <tr>
   <td colspan = 2 bgcolor = "#006533" height = 28>
&nbsp;&nbsp;&nbsp;<a href = "https://www.livestockofamerica.com/Emus/Default.asp" target ="_blank" class="navwhiteblack" >Livestock Of America</a><br>
  </td>
</tr>
  <tr>
   <td colspan = 2 height = 8></td>
  </tr>
  <tr>
   <td colspan = 2 bgcolor = "#006533" height = 28>
&nbsp;&nbsp;&nbsp;<a href = "https://www.livestockofamerica.com/Emus/Default.asp" target ="_blank" class="navwhiteblack" >Livestock Of Canada</a><br>
  </td>
</tr>
<tr>
   <td colspan = 2 height = 8></td>
</tr>

<tr bgcolor="#428762" height= 50>
  <td class = "body" >
  <a href = "/Chickens/?Screenwidth=<%=Screenwidth %>" class = "body"><img src= "/icons/chickeniconwhite.png" border = "0" height= 50 alt = "Chickens"/></a>
    </td>
    <td class = "body" >
  <a href = "/Chickens/?Screenwidth=<%=Screenwidth %>" class="navwhiteblack"><big>Chickens</big></a>
   </td>
</tr>
<tr>
   <td colspan = 2 height = 8></td>
</tr>

<% 
showducksandemuls =false
if showducksandemuls =true then %>
  <tr>
   <td colspan = 2 height = 8></td>
  </tr>
<tr bgcolor="#428762" height= 50>
  <td class = "body" >
  <a href = "/Ducks/?Screenwidth=<%=Screenwidth %>" class = "body"><img src= "/icons/duckiconwhite.png" border = "0" height= "40" alt = "Ducks"/></a>
    </td>
    <td class = "body" >
  <a href = "/Ducks/?Screenwidth=<%=Screenwidth %>" class="navwhiteblack"><big>Ducks</big></a>
   </td>
</tr>
  <tr>
   <td colspan = 2 height = 8></td>
  </tr>



<tr bgcolor="#428762" height= 50>
  <td class = "body" >
  <a href = "/Geese/?Screenwidth=<%=Screenwidth %>" class = "body"><img src= "/icons/gooseiconwhite.png" border = "0" height= 50 alt = "Geese"/></a>
    </td>
    <td class = "body" >
  <a href = "/Geese/?Screenwidth=<%=Screenwidth %>" class="navwhiteblack"><big>Geese</big></a>
   </td>
</tr>

<tr>
   <td colspan = 2 height = 8></td>
</tr>
<% end if %>
<tr bgcolor="#428762" height= 50>
  <td class = "body" >
  <a href = "/Turkeys/?Screenwidth=<%=Screenwidth %>" class = "body"><img src= "/icons/turkeyiconwhite.png" border = "0" height= 50 alt = "Turkeys"/></a>
    </td>
    <td class = "body" >
  <a href = "/Turkeys/?Screenwidth=<%=Screenwidth %>" class="navwhiteblack"><big>Turkeys</big></a>
   </td>
</tr>
<tr>
   <td colspan = 2 height = 8></td>
</tr>

<tr>
<td class= body colspan = 2>


</td>
</tr>
</table>
</td>
<% end if %>



<td valign = "top">    
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = 100% ><tr><td class = "body" align = "left" valign = "top" height = 510>
<table align = "right" width = "300"  style="margin-left:12px;"><tr><td><img src = "Emu.jpg" alt="Emu" width = "300"  /></td></tr></table>
<H1>About Emus</h1>
Emu are the second-largest living bird by height, after the ostrich, and the largest native bird in Australia. Emus are raised for their meat, leather, feathers and oil.

<h2>Emu Meat</h2>
Most of the usable meat portions (the best cuts come from the thigh and the larger muscles of the drum or lower leg) are, like other poultry, dark meat. Emu meat is considered by the US Food and Drug Administration to be a red meat because its red color and pH value approximate that of beef, but for inspection purposes it is considered to be poultry. <br /><br /> 
Emu meat is served in some fine restaurants in Europe and the US and has been mentions favorable on some of Gordon Ramsey’s cooking shows.

<h2>Emu Oil</h2>
Emu oil is processed from their fat and is used for cosmetics, dietary supplements, and therapeutic products. Emu oil is used to improve cholesterol levels and is a good source of fatty acids. It is also used for weight loss and as cough syrup for colds. The Oil consists mainly of fatty acids of which oleic acid (42%), linoleic and palmitic acids (21% each) are the main components.  It also contains various anti-oxidants, notably carotenoids and flavones. There is some evidence that emu oil has anti-inflammatory properties; however, there have not yet been extensive tests". However, It has been scientifically shown to improve the rate of wound healing, but the mechanism responsible for this effect is not understood.

<h2>Emu Leather</h2>
Emu leather has a distinctive patterned surface, due to a raised area around the feather follicles in the skin; the leather is used in such items as wallets, handbags, shoes and clothes.

<h2>Emu Feathers</h2>
Emu feathers are very soft and are used in decorative arts and crafts, including fishing lures, clothing accents, flower arrangements, hats.
 Emu feathers have a double plume, which makes them most rare. The Emu and its cousin the cassowary are the only birds in the world that have two feathers of the same length originating from the one quill.

<h2>Emu Eggs</h2>
<table align = "left" width = "300"  style="margin-left:12px;"><tr><td><img src = "Emueggs.jpg" alt="Emu Eggs" width = "300"  /></td></tr></table>Emu eggs are large (generally the equivalent it size to 12 chicken eggs) and dark green. They are as 'a touch milder' in taste than chicken eggs with a fluffier texture.
Emptied emu eggs have been engraved with portraits, similar to cameos, and scenes of Australian native animals. They are also outstanding as Easter eggs.<br /><br /> 
Due to increased popularity in Emu Oil and Meat in particular Emu farming is quickly spreading beyond Australia and Emu farms can be widely found in North America and Europe in particular.

<h2>Emus in Australia</h2>
Emu are fairly common in Australia and their range covers most of mainland Australia. At one point there were Tasmanian and King Island subspecies of Emus but they became extinct after the European settlement of Australia in 1788. <br /><br /> 

Emus are soft-feathered, brown, flightless birds with long necks and legs, and can reach up to 1.9 metres (6.2 ft) in height. Emus can travel great distances, and when necessary can sprint at 50 km/h (31 mph). They forage for a variety of plants and insects, but have been known to go for weeks without eating. They drink infrequently, but take in copious amounts of water when the opportunity arises.<br /><br /> 

Emu breeding takes place in May and June. Female Emus can mate several times and lay several clutches of eggs in one season. The male does the incubation; during this process he hardly eats or drinks and loses a large amount of weight. Their eggs hatch after around eight weeks, and the young are nurtured by their fathers. They reach full size after around six months, but can remain as a family unit until the next breeding season.<br /><br /> 
Emus are an important cultural icon for Australia, and they appear on the coat of arms and various coins. Emus also are prominently found in Indigenous Australian mythology.

<br />
<br />
<table cellspadding = 0 cellspacing = 0 border = 0>
<tr><td colpsan = 5 class = "body"><h2><%=pagename %> for Sale</h2></td></tr>
<tr><td class = "body">

<b>View <%=pagename %> for Sale At</b><br />
<a href = "https://www.livestockofamerica.com/<%=pagename %>/Default.asp?screenwidth=<%=screenwidth %>" target ="_blank" class="body" > <img src = "/images/LOALogoMenu.png" border = 0 height = 60><br />
www.livestockofamerica.com/<%=pagename %>/</a></center>

</td>
<td width = 3></td>
<td class = "body">
<br />
<a href = "https://www.livestockofCanada.com/<%=pagename %>/Default.asp?screenwidth=<%=screenwidth %>" target ="_blank" class="body" > <img src = "/images/LOCLogo.png" border = 0 height = 60><br />
www.livestockofCanada.com/<%=pagename %>/</a></center>

</td>
<td colspan = 2></td>
</tr></table>
<br />

</td>
</tr>
</table>
<!--#Include virtual="/Footer.asp"-->
</body>
</html>