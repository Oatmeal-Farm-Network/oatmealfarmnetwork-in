<!DOCTYPE html>
<html xmlns="https://www.w3.org/1999/xhtml">
<head>
<!--#Include virtual="/includefiles/GlobalVariables.asp"-->
<!--#Include virtual="/BreedsOfLivestock/AnimalsVariablesInclude.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<title>Breeds of Livestock - Turkeys Breeds</title>
<meta name="Title" content="Breeds of Livestock - Turkeys Breeds"/>
<meta name="Description" content="Turkeys are large birds (the eighth largest living bird species in terms of maximum mass) native originally to the Americas, but after European colonization turkeys were transported to Europe and today they are a common livestock in Europe, America, and many other part of the world. They are raised for their meat all year round but are closely associated in America as the star of the yearly Thanksgiving Dinner."> 
<meta name="robots" content="follow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="Googlebot" content="follow"/>
<meta name="author" content="Oatmeal Farm Network"/>

<link rel="canonical" href="<%=currenturl %>" />
<meta property="og:url" content="<%=currenturl %>" />
<meta name="Title" content="All Turkey Breeds | Oatmeal Farm Network"/>
<meta name="Author" content="Oatmeal Farm Network"/>
<meta property="og:locale" content="en_US" />
<meta property="og:type" content="article" />
<meta property="og:title" content="All Turkey Breeds | Oatmeal Farm Network" />
<meta property="og:site_name" content="Oatmeal Farm Network" />
<meta property="og:image" content="https://www.OatmealFarmNetwork.com/Turkeys/TurkeyHeader.webp" />
<meta property="og:image:width" content="800" />
<meta property="og:image:height" content="400" />
<meta property="og:description" content="Find Breed information on Narragansett, Auburn, Beltsville Small White, Black, Bourbon Red, Bronze, Buff, Castano d'Italia, Dindon de Ronquieres, Dindon de Sologne, Dindon du Bourbonnais, Dindon du Gers, Dindon rouge des Ardennes, Ermellinato di Rovigo, Midget White, Nero D'Italia, Parma e Piacenza, Royal Palm, Slate, and White Holland Turkeys." />

<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "Article",
  "headline": Turkey Breeds,
  "description":Find Breed information on Narragansett, Auburn, Beltsville Small White, Black, Bourbon Red, Bronze, Buff, Castano d'Italia, Dindon de Ronquieres, Dindon de Sologne, Dindon du Bourbonnais, Dindon du Gers, Dindon rouge des Ardennes, Ermellinato di Rovigo, Midget White, Nero D'Italia, Parma e Piacenza, Royal Palm, Slate, and White Holland Turkeys.,
  "author": {
    "@type": "Organization",
    "name": "Global Grange"
  },
  "image": <%=image %>  }
</script>



</HEAD>

<body >
<% LSHeader = True 
currentbreed="Turkeys"%>
<!--#Include virtual="/members/MembersHeader.asp"-->
<!--#Include virtual="/BreedsofLivestock/AnimalsVariablesInclude.asp"-->
   
   <a name="Top"></a>
 <div class="container-fluid" id="grad1">
    <div align = center>
      <div class = "container" >
      <div>
      <div class = "body">
       <h1><img src= "<%=BreedIcon %>" border = "0"  alt = "About <%= trim(Breed) %>&nbsp;<%=SpeciesNamePlural  %>" Height = "40"/>&nbsp;Turkeys</h1><br />
      </div>
      </div>
    </div>
    </div>
 </div>

<div class = "container">
  <div>
   <div class = "body">
       <center><img src = "/LivestockDB/Turkeys/TurkeyHeader.webp" width = 100% alt = "Turkey Breeds"/></center><br />
Turkeys are large birds (the eighth largest living bird species in terms of maximum mass) native originally to the Americas, but after European colonization turkeys were transported to Europe and today they are a common livestock in Europe, America, and many other part of the world . They are raised for their meat all year round but are closely associated in America as the star of the yearly Thanksgiving Dinner.
<br /><br />
Female domesticated turkeys are referred to as hens, and the chicks may be called poults or turkeylings. In the United States, the males are referred to as toms, while in Europe, males are stags. Male Turkeys are more colorful than female turkeys and have a distinctive fleshy wattle or protuberance that hangs from the top of the beak (called a snood). <br />
<form  name=Login method="post" action="AboutTurkeys.asp" align = right><br />
<input type="submit" class = "regsubmit2" value="LEARN MORE"  />
</form>
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
<tr><td bgcolor = "#d6ceca" height = 40 colspan = 2><h3><img src = "https://www.oatmealFarmNetwork.com/images/px.gif" alt ="<%=Breed2  %> - Breeds of <%=signularanimal %>" width = 3 height = 30 /><%=Breed2  %></h3></td></tr>
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
<!--#Include virtual="/members/MembersFooter.asp"-->
</body>
</html>
