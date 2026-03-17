<!DOCTYPE html>
<meta charset="utf-8">
<head>
<!--#Include virtual="/includefiles/GlobalVariables.asp"-->
<!--#Include virtual="/BreedsOfLivestock/AnimalsVariablesInclude.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>

<% Description = "Find Breed information on Ameraucana, Ancona, Andalusian, Araucana, Asturian Painted Hen, Australorp, Barnevelder, Bianca di Saluzzo, Bionda Piemontese, Braekel (Brakel), Brahma, Buckeye, California Gray, Campine, Catalana, Chantecler, Cornish (a.k.a. Indian Game), Cubalaya, Derbyshire Redcap, Dominique, Dorking, Easter Egger, Egyptian Fayoumi, Ermellinata di Rovigo, Faverolles, French Naked Neck, Holland, Iowa Blue, Italian Naked-neck, Italian Polish, Ixworth, Java, Jersey Giant, Kraienköppe (Twentse), Lakenvelder, Leghorn, Marans, Marsh Daisy, Mericanel della Brianza, Millefiori di Lonigo, Millefiori Piemontese, Minorca, Modenese, Mugellese, Naked-neck, New Hampshire, Norfolk Grey, Norwegian Jærhøne, Orloff, Orpington, Penedesenca, Pepoi, Plymouth Rock, Polish Frizzle, Poltava, Polverara, Red Shaver, Rhode Island Red, Rhode Island White, Robusta Lionata, Robusta Maculata, Romagnola, Scots Grey, Sicilian Buttercup, Sicilian hound, Sussex, Tuffled Ghigi, Valdarnese, Valdarno, WelsuBresse, White-Faced Black Spanish, Winnebago, Wyandotte."
Title = "Chicken Breeds | Livestock Of The World"
image = "https://www.Livestockoftheworld.com/Chickens/ChickenBreedsHeader.jpg"
 %>

<Title><%=Title %></Title>
<meta name="title" content="<%=Title %>" />

<meta name="description" content="<%=Description %>" />
<meta name="robots" content="follow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="Googlebot" content="follow"/>
<meta name="author" content="Livestock Of The World"/>

<link rel="canonical" href="<%=currenturl %>" />
<meta property="og:url" content="<%=currenturl %>" />
<meta name="Title" content="<%=Title %>"/>
<meta name="Author" content="Livestock Of The World"/>
<meta property="og:locale" content="en_US" />
<meta property="og:type" content="article" />
<meta property="og:title" content="<%=Title %>" />
<meta property="og:site_name" content="Livestock Of The World" />
<meta property="og:image" content="<%=image %>" />
<meta property="og:image:width" content="800" />
<meta property="og:image:height" content="400" />
<meta property="og:description" content="<%=Description %>" />


</head>
<body >
<% LSHeader = True 
currentbreed="Chickens" %>
<!--#Include virtual="/Header.asp"-->
<% If not rs.State = adStateClosed Then
  rs.close
End If 

Set rs2 = Server.CreateObject("ADODB.Recordset")
%>
   
<div class="container-fluid" id="grad1">
    <div align = center>
      <div class = "container" >
      <div>
      <div class = "body">
       <br /><h1><img src= "<%=BreedIcon %>" border = "0"  alt = "About <%= trim(Breed) %>&nbsp;<%=SpeciesNamePlural  %>" Height = "40"/>&nbsp;Chickens</h1><br />
      </div>
      </div>
    </div>
    </div>
 </div>

<div class = "container">
  <div>
   <div class = "body">

     <center><img src = "https://www.Livestockoftheworld.com/Chickens/Chickenheader2.jpg" width = 100% alt = "About Chickens"/></center><br />


<table border = "0" cellspacing="0" cellpadding = "0" align = "center"  ><tr><td class = "body" align = "left" valign = "top" height = 510>



Chickens (Gallus gallus domesticus) are domesticated birds that are raised for meat and eggs. There are over 24 billion chickens worldwide. Raising chickens is relatively inexpensive. Because of the low cost, chicken meat (also called "chicken") is one of the most common kinds of meat in the world.<br>
<br />
 <form  name=Login method="post" action="AboutChickens.asp" align = right><br />
<input type="submit" class = "regsubmit2" value="LEARN MORE ABOUT CHICKENS"  >
</form>


<a name="Breeds"></a>

<h2>Breeds of <%=Pagename %></h2>

There are the following breeds of <% = SpeciesNamePlural %>:
<br />

<% Letter = Request.Querystring("Letter")
If len(Letter)<1 then
Letter = "A"
end if
tempspeciesID= SpeciesID
%>
<a NAME="Breeds"></a>
<a href = "Default.asp?Letter=A#Breeds" class = Body>A</a>|
<a href = "Default.asp?Letter=B#Breeds" class = Body>B</a>|
<a href = "Default.asp?Letter=C#Breeds" class = Body>C</a>|
<a href = "Default.asp?Letter=D#Breeds" class = Body>D</a>|
<a href = "Default.asp?Letter=E#Breeds" class = Body>E</a>|
<a href = "Default.asp?Letter=F#Breeds" class = Body>F</a>|
<a href = "Default.asp?Letter=G#Breeds" class = Body>G</a>|
<a href = "Default.asp?Letter=H#Breeds" class = Body>H</a>|
<a href = "Default.asp?Letter=I#Breeds" class = Body>I</a>|
<a href = "Default.asp?Letter=J#Breeds" class = Body>J</a>|
<a href = "Default.asp?Letter=K#Breeds" class = Body>K</a>|
<a href = "Default.asp?Letter=L#Breeds" class = Body>L</a>|
<a href = "Default.asp?Letter=M#Breeds" class = Body>M</a>|
<a href = "Default.asp?Letter=N#Breeds" class = Body>N</a>|
<a href = "Default.asp?Letter=O#Breeds" class = Body>O</a>|
<a href = "Default.asp?Letter=P#Breeds" class = Body>P</a>|
<a href = "Default.asp?Letter=Q#Breeds" class = Body>Q</a>|
<a href = "Default.asp?Letter=R#Breeds" class = Body>R</a>|
<a href = "Default.asp?Letter=S#Breeds" class = Body>S</a>|
<a href = "Default.asp?Letter=T#Breeds" class = Body>T</a>|
<a href = "Default.asp?Letter=U#Breeds" class = Body>U</a>|
<a href = "Default.asp?Letter=V#Breeds" class = Body>V</a>|
<a href = "Default.asp?Letter=W#Breeds" class = Body>W</a>|
<a href = "Default.asp?Letter=X#Breeds" class = Body>X</a>|
<a href = "Default.asp?Letter=Y#Breeds" class = Body>Y</a>|
<a href = "Default.asp?Letter=Z#Breeds" class = Body>Z</a>|

<iframe width = "100%" height = "4000"  title="<% = SpeciesNamePlural %> Breeds" src="livestockbreedinclude3.asp?Letter=<%=Letter%>&tempspeciesID=<%=tempspeciesID%>" ></iframe>
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
<a href = "#Top" class = "body2"><center>Top</center></a>
</td>
</tr>
</table>

</div></div></div>
<!--#Include virtual="/Footer.asp"-->
</body>
</html>