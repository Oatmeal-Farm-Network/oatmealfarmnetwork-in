<!DOCTYPE html>
 <!doctype html>
<head>
<!--#Include virtual="/includefiles/GlobalVariables.asp"-->
<link rel="canonical" href="https://www.livestockoftheworld.com/Dogs/AboutDogs.asp" />
<!--#Include virtual="/BreedsOfLivestock/AnimalsVariablesInclude.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<title>About Dogs | Breeds of Dogs</title>
<meta name="Title" content="About Dogs | Breeds of Dogs"/>
<meta name="Description" content="In general Dogs are quite intelligent, cautious, friendly, playful, and eager to learn. Dogs have a notorious reputation for stubbornness, but this has been attributed to a very strong sense of self preservation. Likely based on a stronger prey instinct and a weaker connection with man, it is considerably more difficult to force or frighten a Dog into doing something it perceives to be dangerous for whatever reason. Once a person has earned their confidence they may be willing partners and very dependable in work. "> 
<meta name="robots" content="follow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="Googlebot" content="follow"/>
<meta name="author" content="Livestock Of The World"/>
</HEAD>
<body >
<% LSHeader = True 
currentbreed="Dogs"%>
<!--#Include virtual="/Header.asp"-->
<!--#Include virtual="/BreedsofLivestock/AnimalsVariablesInclude.asp"-->


<% If not rs.State = adStateClosed Then
  rs.close
End If 
%>
<div class="container-fluid" id="grad1">
    <div align = center>
      <div class = "container" >
      <div>
      <div class = "body">
      <h1><img src= "<%=BreedIcon %>" border = "0"  alt = "About <%= trim(Breed) %>&nbsp;<%=SpeciesNamePlural  %>"  width = "40"/>About Dogs</h1><br />
      </div>
      </div>
    </div>
    </div>
 </div>

<div class = "container">
  <div>
   <div class = "body"><br />
        <a href = "/Dogs/#Breeds" class = "body">View Dog Breeds</a><br />

<table border = "0" cellspacing="0" cellpadding = "0" align = "center" bgcolor = "white" width = "100%" >
<tr>
<td valign = "top" class = "body"> 
<table align = "right" width = "300" class="roundedtopandbottom" style="margin-left:12px;"><tr><td><img src = "/images/Dogs.jpg" alt="Dogs" width = "300"  /></td></tr></table>
<br />

    Throughout the annals of human history, man and dog have forged a bond that spans millennia. From the pastoral fields to the bustling streets, these loyal canines have etched an indelible mark on our shared existence.<br /><br />

In ancient Egypt, dogs were entrusted with vital roles in hunting, herding, and safeguarding. Hellenic and Roman civilizations followed suit, employing these noble creatures in a myriad of tasks, from guarding livestock and property to waging war.<br /><br />

The Middle Ages witnessed a pivotal shift, as working dogs assumed an indispensable role in the agricultural tapestry. They labored tirelessly to gather livestock, plow the earth, and transport goods. Their keen senses also proved invaluable in hunting and safeguarding, further cementing their place in our world.<br /><br />

The Industrial Revolution ushered in a new era of specialized working dogs. Bloodhounds tracked criminals with unerring determination, while St. Bernards undertook heroic Alpine rescues. German shepherds stood sentinel as guardians of law and order, their steadfast loyalty and courage unmatched.<br /><br />

World War I and II saw working dogs on both sides of the conflict demonstrate valor beyond compare. They served as messengers, scouts, and guardians, their bond with their human companions unbreakable. German shepherds traversed treacherous battlefields with fleetness of foot and clarity of mind, delivering messages that bridged the divide. Belgian Malinois unearthed hidden dangers in the form of mines and explosives with their keen noses.<br /><br />

In the modern era, working dogs continue to play a vital role in our society, their tireless devotion spanning a vast array of vocations. From therapy and education to law enforcement and the military, these steadfast companions offer solace, enlightenment, protection, and emotional succor.<br /><br />

A rich diversity of working dog breeds, each with its own unique proficiencies, emerges from the tapestry of history. Vigilant herders—border collies, German shepherds, and Australian kelpies—steadfastly watch over and guide our flocks. Guardians—Rottweilers, Doberman pinschers, and their ilk—stand resolute in their charge to protect both life and property. Stalwart police forces led by German shepherds, Belgian Malinois, and Labrador retrievers valiantly uphold the mantle of law and order. Military endeavors are bolstered by the indomitable spirit of German shepherds, Belgian Malinois, and Labrador retrievers, discerning foes and locating the lost. In the heart of the wilderness, search and rescue missions are embarked upon by German shepherds, Labrador retrievers, and golden retrievers, unyielding in their pursuit of those in need. Medical assistance dogs—guiding lights for the sightless and vigilant sentinels for the hearing impaired— bestow independence and dignity upon those they serve.<br /><br />

Working dogs are more than mere adjuncts to our lives; they are steadfast companions who offer both protection and emotional succor. They are the sentinels that keep us safe, the emissaries that bridge the divide, and the steadfast beacons that guide us through life's labyrinth.<br /><br />

Let us be ever grateful for the profound contributions these remarkable creatures make to our collective existence.<br /><br />


<% sql2 = "select * from SpeciesColorlookupTable where SpeciesID =  " & SpeciesID & " order by SpeciesColor "
rs.Open sql2, conn, 3, 3   
if not rs.eof then %>
<h2><% = SpeciesName %> Colors </h2>
 <% = SpeciesNamePlural %> come in the following colors:
 <ul>
<%while not rs.eof	 %>
<li ><%=rs("SpeciesColor")%></li>
<% rs.movenext
wend %>
</ul>
<% end if
rs.close %>
</blockquote>
<br />
</td>
</tr>
</table>
</div></div></div>
<!--#Include virtual="/Footer.asp"-->
</body>
</html>