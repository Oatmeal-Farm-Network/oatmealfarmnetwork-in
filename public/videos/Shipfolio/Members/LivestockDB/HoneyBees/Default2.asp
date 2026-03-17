<!DOCTYPE html>
<meta charset="UTF-8">
<head>
<!--#Include virtual="/includefiles/GlobalVariables.asp"-->
<link rel="canonical" href="<%=currenturl %>" />
<!--#Include virtual="/BreedsOfLivestock/AnimalsVariablesInclude.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<title>About HoneyBees | Breeds of Livestock</title>
<meta name="Title" content="About HoneyBees | Breeds of Livestock"/>
<meta name="Description" content="Honey bees are close relatives of wasps and ants. They are found on every continent on earth, except for Antarctica."> 
<meta name="robots" content="follow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="Googlebot" content="follow"/>
<meta name="author" content="Livestock Of The World"/>
</HEAD>

<body >
<% LSHeader = True 
currentbreed="HoneyBees" %>
<!--#Include virtual="/Header.asp"-->
<% If not rs.State = adStateClosed Then
  rs.close
End If 

%>
<a name="Top"></a>
   
      
<div class="container-fluid" id="grad1">
    <div align = center>
      <div class = "container" >
      <div>
      <div class = "body" >
      <br /> <h1><img src= "<%=BreedIcon %>" border = "0"  alt = "About <%= trim(Breed) %>&nbsp;<%=SpeciesNamePlural  %>" height = "40" />Honey Bees<br /><br /></h1>
      </div>
      </div>
        <div>
      </div>
    </div>
    </div>
 </div>

<div class = "container">
  <div>
   <div class = "body">

     <center><img src = "https://www.Livestockoftheworld.com/HoneyBees/Honeyheader2.jpg" width = 100% alt = "About Honey Bees"/></center><br />

<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = 100% ><tr><td class = "body" align = "left" valign = "top" >
Honey bees are close relatives of wasps and ants. They are found on every continent on earth, except for Antarctica. Bees of all varieties live on nectar and pollen. It is estimated that one-third of the human food supply depends on insect pollination. Bees have a long, straw-like tongue called a proboscis that allows them to drink the nectar from deep within blossoms. Bees are also equipped with two wings, two antennae, and three segmented body parts (the head, the thorax, and the abdomen). Honey bees are social insects that live in colonies. The hive population consists of a single queen, a few hundred drones, and thousands of worker bees.
<br>
 <form  name=Login method="post" action="AboutHoneyBees.asp" align = right><br />
<input type="submit" class = "regsubmit2" value="LEARN MORE ABOUT HONEY BEES"  >
</form>
 <br>
<br />



<a name="Breeds"></a>
<% Set rs2 = Server.CreateObject("ADODB.Recordset")

sql2 = "select * from SpeciesBreedLookupTable where SpeciesID=" & speciesID & " Order by trim(Breed)"
rs2.Open sql2, conn, 3, 3
if not rs2.eof then %>
<h2>Breeds of <% = SpeciesNamePlural %></h2>

There are the following breeds of <% = SpeciesNamePlural %>:

<% while not(rs2.eof) 
Breed2 = rs2("Breed") 
BreedLookupID2 = rs2("BreedLookupID") 
Breeddescription= rs2("Breeddescription")


BreedImage= rs2("BreedImage")
Breedvideo= rs2("Breedvideo")
BreedImageOrientation = rs2("BreedImageOrientation")
BreedImageCaption = rs2("BreedImageCaption") %>
<table width = 100%>
<tr><td bgcolor = '#888888' height = 1 colspan = 2></td></tr>
<tr><td bgcolor = "#d6ceca" height = 40 colspan = 2><h3><img src = "https://www.livestockoftheworld.com/images/px.gif" alt ="<%=Breed2  %> - Breeds of <%=signularanimal %>" width = 3 height = 30 /><%=Breed2  %></h3></td></tr>
<tr><td bgcolor = '#888888' height = 1 colspan = 2></td></tr>
<tr><td class = "body" valign = top width = 200><br>
<% if len(BreedImage) > 1 then%>
<a href="Breeds.asp?BreedLookupID=<%= BreedLookupID2%>&SpeciesID=<%= SpeciesID%>" class = body><img src = "<%= BreedImage%>" alt = "<%=BreedImageCaption%>" width = "180" align = "left" hspace="20"/></a><br>
<% end if %>
</td>
<td class = "body">
<blockquote>
<%=left(Breeddescription, 450) %>
<%if len(Breeddescription) > 450 then %>
...
<% end if %>
<%if len(Breeddescription) > 25 then %>
<br />
<div align = right>
<form  name=Login method="post" action="Breeds.asp?BreedLookupID=<%= BreedLookupID2%>&SpeciesID=<%= SpeciesID%>" >
<input type="submit" class = "regsubmit2" value="LEARN MORE"  >
</form>
</div>
<br>
<% end if %>
</blockquote>
 </td>
</tr></table>
<%
 rs2.movenext
wend %>

<% end if 

rs2.close
%>

<br />
<!--#Include virtual="/includefiles/MarketplacelinksInclude.asp"-->
  </div>
  </div>
  </div>
<!--#Include virtual="/Footer.asp"-->
</body>
</html>
