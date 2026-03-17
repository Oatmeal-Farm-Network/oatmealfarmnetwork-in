<!DOCTYPE html>
<html xmlns="https://www.w3.org/1999/xhtml">
<head>
      <% MasterDashboard= True
      PageName="Bison" %>
<!--#Include virtual="/Members/MembersGlobalVariables.asp"-->
<!--#Include virtual="/Members/BreedsOfLivestock/AnimalsVariablesInclude.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>


<% title= "Bison | Breeds of Livestock"
Description = "Bison  are large, even-toed ungulatesin the genus Bison within the subfamily Bovinae."

image = "Bisonheader.jpg"
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

<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "Article",
  "headline": <%=Title %>,
  "description": <%=description %>,
  "author": {
    "@type": "Organization",
    "name": "Global Grange"
  },
  "image": <%=image %>,  "mainEntity": "Global Grange"  ]  }
</script>

</HEAD>
<body >
<% LSHeader = True
currentbreed="Bison" 
SpeciesNamePlural ="Bison"%>
<!--#Include virtual="/Members/MembersHeader.asp"-->

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
       <H1><img src= "<%=BreedIcon %>" border = "0"  alt = "About <%= trim(Breed) %>&nbsp;<%=SpeciesNamePlural  %>"  height = "40"/>&nbsp;Bison</h1><br />
      </div>
      </div>
    </div>
    </div>
 </div>
<div class = "container">
  <div>
   <div class = "body">
   <center><img src = "Bisonheader.jpg" width = 100% alt = "About Bison"/></center><br />


Millions of bison once thundered across America. Today, approximately 500,000 bison live across North America. Bison are large, even-toed ungulates in the genus Bison within the subfamily Bovinae.<br /><br />

Currently there are only 2 species of Bison; however, there are 4 species that are extinct. The 2 existing species are the American bison, B. bison, found only in North America, and often referred as a "buffalo" and B. bonasus, or Wisent, is found in Europe and the Caucasus.
 <br> 
 <form  name=Login method="post" action="AboutBison.asp" align = right><br />
<input type="submit" class = "regsubmit2" value="LEARN MORE ABOUT BISON"  >
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
<tr><td bgcolor = "#d6ceca" height = 40 colspan = 2><h3><img src = "/images/px.gif" alt ="<%=Breed2  %> - Breeds of <%=signularanimal %>" width = 3 height = 30 /><%=Breed2  %></h3></td></tr>
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
<!--#Include virtual="/Members/MarketplacelinksInclude.asp"-->
  </div>
  </div>
  </div>
<!--#Include virtual="/Members/MembersFooter.asp"-->
</body>
</html>
