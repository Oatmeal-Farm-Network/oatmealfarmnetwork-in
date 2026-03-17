<!DOCTYPE html>
<html xmlns="https://www.w3.org/1999/xhtml">
<head>
  <% MasterDashboard= True
  PageName="Chickens" 
  LSHeader = True
  currentbreed="Chickens" %>
  <!--#Include virtual="/Members/MembersGlobalVariables.asp"-->
  <!--#Include virtual="/Members/BreedsOfLivestock/AnimalsVariablesInclude.asp"-->
<% 
BreedlookupID = request.querystring("BreedlookupID")
if speciesID > 0 then
else
response.redirect("/default.asp")
end if
if BreedlookupID > 0 then
else
response.redirect("BreedsHome.asp")
end if
Set rs2 = Server.CreateObject("ADODB.Recordset")
sql2 = "select * from SpeciesAvailable where SpeciesID =" & SpeciesID 
rs2.Open sql2, conn, 3, 3
if not rs2.eof then 
SpeciesName = rs2("SingularTerm") 
SpeciesNamePlural = rs2("PluralTerm") 
end if
rs2.close

sql2 = "select * from SpeciesBreedLookupTable where BreedlookupID =" & BreedlookupID  & " and speciesid = " & speciesID & " Order by trim(Breed)"
rs2.Open sql2, conn, 3, 3
if rs2.eof then 
response.redirect("/" & SpeciesNamePlural & "/")
else
Breed = rs2("Breed") 
BreedID = rs2("BreedLookupID") 
BreedlookupID = rs2("BreedlookupID")
BreedlookupID2 = BreedlookupID
Breeddescription= rs2("Breeddescription")
Breeddescription2= Breeddescription 
BreedImage= rs2("BreedImage")
BreedImage2 = BreedImage
Breedvideo= rs2("Breedvideo")
Breedvideo2 = Breedvideo
BreedImageOrientation = rs2("BreedImageOrientation")
BreedImageOrientation2 = BreedImageOrientation
BreedImageCaption = rs2("BreedImageCaption")
BreedImageCaption2 = BreedImageCaption
end if
rs2.close

FUNCTION stripHTML(strHTML)
  Dim objRegExp, strOutput, tempStr
  Set objRegExp = New Regexp
  objRegExp.IgnoreCase = True
  objRegExp.Global = True
  objRegExp.Pattern = "<(.|n)+?>"
  'Replace all HTML tag matches with the empty string
  strOutput = objRegExp.Replace(strHTML, "")
  'Replace all < and > with &lt; and &gt;
  strOutput = Replace(strOutput, "<", "&lt;")
  strOutput = Replace(strOutput, ">", "&gt;")
  stripHTML = strOutput    'Return the value of strOutput
  Set objRegExp = Nothing
END FUNCTION
if len(Breeddescription) > 20 then
metadescription = stripHTML(Breeddescription)
else
metadescription = "About " & Breed & " SpeciesNamePlural "
end if
%>
<link rel="canonical" href="<%=currenturl %>?BreedLookupID=<%=BreedID %>&SpeciesID=<%=SpeciesID %>" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<title><%= trim(Breed) %>&nbsp;<%=SpeciesNamePlural  %></title>
<meta name="Title" content="About <%= trim(Breed) %>&nbsp;<%=SpeciesNamePlural  %>"/>
<meta name="description" content="<%=left(metadescription, 160)%> " />
<meta name="robots" content="follow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="Googlebot" content="follow"/>
<meta name="author" content="Oatmeal Farm Network"/>

<meta property="og:locale" content="en_US" />
<meta property="og:type" content="article" />
<meta property="og:title" content="About <%= trim(Breed) %>&nbsp;<%=SpeciesNamePlural  %>" />
<meta property="og:description" content="<%=left(metadescription, 160)%>" />
<meta property="og:url" content="<%=currenturl %>?BreedLookupID=<%=BreedID %>&SpeciesID=<%=SpeciesID %>" />
<meta property="og:site_name" content="Oatmeal Farm Network" />
<meta property="og:image" content="<%=BreedImage %>" />
<meta property="og:image:width" content="300" />
<meta name="twitter:card" content="summary" />
<meta name="twitter:description" content="<%=left(metadescription, 160)%>[&hellip;]" />
<meta name="twitter:title" content="About <%= trim(Breed) %>&nbsp;<%=SpeciesNamePlural  %>" />
</HEAD>
<body >

<% LSHeader = True 
currentbreed="Chickens" %>
<!--#Include virtual="/Members/membersHeader.asp"-->
<!--#Include virtual="/BreedsofLivestock/AnimalsVariablesInclude.asp"-->


<div class="container-fluid" id="grad1">
    <div align = center>
      <div class = "container" >
      <div>
      <div class = "body">
       <br /><h1><img src= "<%=BreedIcon %>" border = "0"  alt = "About <%= trim(Breed) %>&nbsp;<%=SpeciesNamePlural  %>" Height = "40"/>About <%= trim(Breed) %>&nbsp;<%=SpeciesNamePlural  %></h1><br />
      </div>
      </div>
    </div>
    </div>
 </div>

<div class = "container">
  <div>
   <div class = "body" valign="top">
     


<% if len(BreedImage2) > 1 then%>
<table align = "<%=BreedImageOrientation %>" width = "450" style="margin-left:12px;margin-right:12px;"><tr>
  <td><img src = "<%= BreedImage%>" alt = "<%=BreedImageCaption%>" width = "450"/></td></tr><tr><td class = "body"><%=BreedImageCaption %></td></tr></table><br /><br />
<% end if %>
<% if  len(trim(Breeddescription2) ) > 12 then%>
<%= trim(Breeddescription2) %>
<% else %>
Sorry, we do not have a description of <%= trim(Breed2) %>&nbsp;<%=SpeciesNamePlural  %>. But if you have one that you would like to submit please <a href = "/contactus.asp">contact us </a>and let us know!
<% end if %>
<br />
<br />
<br />

</td></tr>

<%  sqld = "select * from SpeciesassociationLinks, associations where SpeciesassociationLinks.associationid = associations.associationid and BreedLookupID = " & BreedLookupID & " order by AssociationName"
Set rsd = Server.CreateObject("ADODB.Recordset")
rsd.Open sqld, conn, 3, 3  
if not rsd.eof then %>

 <table border = "0" cellspacing="0" cellpadding = "0" align = "left" width = "100%">
 <tr><td  align = "left" valign = "top" colspan = 2>
<h2> <%= trim(Breed) %>&nbsp;<%=SpeciesNamePlural  %> Associations</h2>
  </td>
 </tr>	
 <% 
 count = 0
 while not rsd.eof 
 count = count+1
AssociationName=rsd("AssociationName")
Associationwebsite=rsd("Associationwebsite")
AssociationDescription=rsd("AssociationDescription")
AssociationLogo=rsd("AssociationLogo")
AssociationID=rsd("AssociationID")
 %>
<tr>
<td width = "200">
<% if len(AssociationLogo) > 4 then %>
<a href = "https://<%=Associationwebsite%>" class = "body" target = "blank"><img src = "<%=AssociationLogo%>" width = "190" alt="<%=AssociationName%>"/></a>
<% end if %>
</td>
<td  class = "body" align = "left" valign = "top" >
<a href = "https://<%=Associationwebsite%>" class = "body" target = "blank"><b><%=AssociationName%></b></a> - <a href = "https://<%=Associationwebsite%>" class = "body" target = "blank"><big><%=Associationwebsite%></big></a><br />
<%=SALDescription%><br><br />
</td>
</tr>

<%
   rsd.movenext
   wend %>
</table>
<% end if 
 rsd.close
 %>

       <!--#Include virtual="/includefiles/MarketplacelinksInclude.asp"--> 
   </div>
  </div>
</div>
<!--#Include virtual="/Members/membersFooter.asp"-->
</body>
</html>