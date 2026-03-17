<!DOCTYPE html>
<html xmlns="https://www.w3.org/1999/xhtml">
<head>
<!--#Include virtual="/includefiles/GlobalVariables.asp"-->
<% currentbreed="GuineaFowl" %>
<!--#Include virtual="/BreedsOfLivestock/AnimalsVariablesInclude.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<% Description = "Guinea fowl are sometimes raised as livestock for their meat and eggs. Guinea fowl are hardy birds native to Africa, and are prized for their delicious meat and flavorful eggs. They are also considered to be low maintenance birds, as they are able to forage for their own food and do not require special housing or feeding arrangements. Guinea fowl are often raised in free-range or semi-free-range systems, and are often used as a more sustainable and natural alternative to traditional poultry species."
Title = "About Guinea Fowl & Guinea Fowl Breeds"
image = "https://www.OatmealFarmNetwork.com/GuineaFowl/GuineaFowlHeader.jpg"
 %>
<Title><%=Title %></Title>
<meta name="title" content="<%=Title %>" />

<meta name="description" content="<%=Description %>" />
<meta name="robots" content="follow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="Googlebot" content="follow"/>
<meta name="author" content="Oatmeal Farm Network"/>

<link rel="canonical" href="<%=currenturl %>" />
<meta property="og:url" content="<%=currenturl %>" />
<meta name="Title" content="<%=Title %>"/>
<meta name="Author" content="Oatmeal Farm Network"/>
<meta property="og:locale" content="en_US" />
<meta property="og:type" content="article" />
<meta property="og:title" content="<%=Title %>" />
<meta property="og:site_name" content="Oatmeal Farm Network" />
<meta property="og:image" content="<%=image %>" />
<meta property="og:image:width" content="800" />
<meta property="og:image:height" content="400" />
<meta property="og:description" content="<%=Description %>" />

<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "Article",
  "headline": "<%=title %>"  ,
  "description": "<%=Description %>"  ,
  "author": {
    "@type": "Organization",
    "name": "Global Grange"
  },
  "mainEntity": "Global Grange"   }
</script>


</HEAD>
<body >
<% LSHeader = True 
currentbreed="GuineaFowl"
 %>
<!--#Include virtual="/Members/MembersHeader.asp"-->
<div class="container-fluid" id="grad1">
    <div align = center>
      <div class = "container" >
      <div>
      <div class = "body">
       <h1><img src= "<%=BreedIcon %>" border = "0"  alt = "<%=SpeciesNamePlural  %>"  height = "40"/>&nbsp;<%=SpeciesNamePlural  %></h1><br />
      </div>
      </div>
    </div>
    </div>
 </div>


<% If not rs.State = adStateClosed Then
  rs.close
End If %>

<div class = "container">
  <div>
   <div class = "body">
 <center><img src = "GuineaFowlHeader.jpg" width = 100% alt = "Guinea Fowl"/></center><br />
 Guinea fowl are sometimes raised as livestock for their meat and eggs. Guinea fowl are hardy birds native to Africa, and are prized for their delicious meat and flavorful eggs. They are also considered to be low maintenance birds, as they are able to forage for their own food and do not require special housing or feeding arrangements. Guinea fowl are often raised in free-range or semi-free-range systems, and are often used as a more sustainable and natural alternative to traditional poultry species.

<form  name=Login method="post" action="AboutGuineaFowl.asp" align = right><br />
<input type="submit" class = "regsubmit2" value="LEARN MORE ABOUT"  />
</form>




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
<!--#Include virtual="/includefiles/MarketplacelinksInclude.asp"-->
  </div>
  </div>
  </div>
<!--#Include virtual="/Members/MembersFooter.asp"-->
</body>
</html>