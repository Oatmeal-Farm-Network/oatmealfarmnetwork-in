<!DOCTYPE html>
<html xmlns="https://www.w3.org/1999/xhtml">
<head>
<% MasterDashboard= True
PageName="Buffalo" 
LSHeader = True
currentbreed="Buffalo" %>
<!--#Include virtual="/Members/MembersGlobalVariables.asp"-->
<!--#Include virtual="/Members/BreedsOfLivestock/AnimalsVariablesInclude.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>

</HEAD>
<body >

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
       <H1><img src= "<%=BreedIcon %>" border = "0"  alt = "About <%= trim(Breed) %>&nbsp;<%=SpeciesNamePlural  %>"  height = "40"/>&nbsp;Buffalo</h1><br />
      </div>
      </div>
    </div>
    </div>
 </div>
<div class = "container">
  <div>
   <div class = "body">
   <center><img src = "Buffaloheader.jpg" width = 100% alt = "About Buffalo"/></center><br />

The term buffalo is used to refer to several different species of bovine animals, including the African buffalo and water Buffalo. Sometimes the term is used incorrectly to refer American  Bison, Bison are not a type of Buffalo. In most cases demesticated Buffalo are Water Buffalo.<br />
 <br>
 Water Buffalo (also known as Asian buffalo, or domestic Asian water buffalo) are a large domestic bovid that is native to Southeast Asia. They are one of the largest domestic animals, with adult males weighing between 800-1,200 kilograms (1,765-2,646 pounds) and adult females weighing between 500-800 kilograms (1,102-1,764 pounds).  <br>
 <form  name=Login method="post" action="AboutBuffalo.asp" align = right><br />
<input type="submit" class = "regsubmit2" value="LEARN MORE ABOUT BUFFALO"  >
</form>
<br />



<a name="Breeds"></a>
<% Set rs2 = Server.CreateObject("ADODB.Recordset")

sql2 = "select * from SpeciesBreedLookupTable where SpeciesID=" & speciesID & " Order by trim(Breed)"
rs2.Open sql2, conn, 3, 3
if not rs2.eof then %>
<h2>Breeds of <% = currentbreed %></h2>

There are the following breeds of <% = currentbreed %>:

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
<!--#Include virtual="/Members/membersFooter.asp"-->
</body>
</html>
