<!DOCTYPE html>
<html xmlns="https://www.w3.org/1999/xhtml">
<head>
<!--#Include virtual="/includefiles/GlobalVariables.asp"-->
<!--#Include virtual="/BreedsOfLivestock/AnimalsVariablesInclude.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<% Description = " Pheasants are raised for their meat, feathers, and eggs. Pheasant meat is considered a delicacy in many parts of the world and is used in a variety of dishes, such as stews, roasts, and casseroles.  Pheasant eggs are also considered a delicacy and are used in cooking and baking."
Title = "About Pheasants"
image = "/LivestockDB/Pheasants/PheasantHeader.jpg"
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
  "headline": <%=Title %>,
  "description": <%=Description %>,
  "author": {
    "@type": "Organization",
    "name": "Global Grange"
  },
  "image": <%=image %>,  "mainEntity": "https://www.OatmealfarmNetwork.com"  }
</script>

</HEAD>
<body >
<% LSHeader = True %>
<!--#Include virtual="/Members/MembersHeader.asp"-->
<div class="container-fluid" id="grad1">
    <div align = center>
      <div class = "container" >
      <div>
      <div class = "body">
       <h1><img src= "<%=BreedIcon %>" border = "0"  alt = "<%=SpeciesNamePlural  %>"  height = "40"/>&nbsp;<%=signularanimal %></h1><br />
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
 <center><img src = "<%=image %>" width = 100% alt = "About Pheasants"/></center><br />

 Pheasants are raised for their meat, feathers, and eggs. Pheasant meat is considered a delicacy in many parts of the world and is used in a variety of dishes, such as stews, roasts, and casseroles.  Pheasant eggs are also considered a delicacy and are used in cooking and baking.

  <br> 
 <form  name=Login method="post" action="AboutPheasants.asp" align = right><br />
<input type="submit" class = "regsubmit2" value="LEARN MORE"  >
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