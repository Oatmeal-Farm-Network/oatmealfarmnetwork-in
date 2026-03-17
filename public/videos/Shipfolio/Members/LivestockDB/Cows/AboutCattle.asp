<!DOCTYPE html>
<meta charset="utf-8">
<head>
<!--#Include virtual="/includefiles/GlobalVariables.asp"-->
<!--#Include virtual="/BreedsOfLivestock/AnimalsVariablesInclude.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<title>Breeds of Livestock - Cattle Breeds</title>
<meta name="Title" content="Breeds of Livestock - Cattle Breeds"/>
<meta name="Description" content="Cattle were first domesticated at least 10,000 years ago, and they are raised as for meat, milk and other dairy products, and as draft animals."> 
<meta name="robots" content="follow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="Googlebot" content="follow"/>
<meta name="author" content="The Andresen Group"/>
<link rel="stylesheet" type="text/css" href="/includefiles/style.css" />
</HEAD>
<body >
<% LSHeader = True 
currentbreed="Cattle"%>
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
       <br /><H1><img src= "/icons/cattleiconwhite.png" border = "0"  alt = "Cattle Breeds" height = "50"/>About Cattle (Cows)</h1><br />
      </div>
      </div>
    </div>
    </div>
 </div>
<div class = "container">
  <div>
   <div class = "body">


<table width = 100%>
<tr>
<td valign = "top" class = "body"> 
  <a href = "/Cattle/#Breeds" class = "body">View Cattle Breeds</a><br /><br />
<br />
<img src = "/images/Cow.jpg" alt="Cows" width = "300" align= "right" />The first cattle were domesticated at least 10,000 years ago, and they are raised as for meat (beef and veal), dairy animals for milk and other dairy products, and as draft animals (pulling carts, plows and the like). Also they are raised to produce leather and their manure is used for fertilizer. Cattle were the first livestock animal to have a fully mapped genome and there is an estimated 1.3 billion cattle in the world today.<br /><br />
Cattle raised for human consumption are called "beef cattle". Within the beef cattle industry in parts of the United States, the term "beef" (plural "beeves") is still used in its archaic sense to refer to an animal of either sex. Cows of certain breeds that are kept for the milk they give are called "dairy cows" or "milking cows". Most young male offspring of dairy cows are sold for veal, and may be referred to as veal calves.<br /><br />
Cattle have cloven hooves and most breeds have horns, which can range greatly in size. Careful genetic selection has allowed polled (hornless) cattle to become widespread.<br /><br />
Cattle are ruminants, meaning their digestive system is highly specialized to allow the use of poorly digestible plants as food. Cattle have one stomach with four compartments, the rumen, reticulum, omasum, and abomasum, with the rumen being the largest compartment. Cattle are known for regurgitating and re-chewing their food, known as "cud" chewing. The reticulum, the smallest compartment, is known as the "honeycomb". Cattle sometimes consume metal objects which are deposited in the reticulum and irritation from the metal objects causes”hardware disease”. The omasum's main function is to absorb water and nutrients from the digestible feed. The omasum is known as the "many plies". The abomasum is like the human stomach; this is why it is known as the "true stomach". The cud is then reswallowed and further digested by specialized microorganisms in the rumen. These microbes are primarily responsible for decomposing cellulose and other carbohydrates into volatile fatty acids cattle use as their primary metabolic fuel. The microbes inside the rumen also synthesize amino acids. As these microbes reproduce in the rumen, older generations die and their cells continue on through the digestive tract. These cells are then partially digested in the small intestines, allowing cattle to gain a high-quality protein source. These features allow cattle to thrive on grasses and other vegetation.<br /><br />
The gestation period for a cow is about nine months long. A newborn calf's size can vary among breeds, but a typical calf typically weighs 25 to 45 kg (55 to 99 lb). Adult size and weight vary significantly among breeds and sex. The world record for the heaviest bull was 1,740 kg (3,840 lb), a Chianina cow named Donetto, when he was exhibited at the Arezzo show in 1955. The heaviest steer was eight-year-old ‘Old Ben’, a Shorthorn/Hereford cross weighing in at 2,140 kg (4,720 lb) in 1910. Steers are generally killed before reaching 750 kg (1,650 lb). Breeding stock may be allowed a longer lifespan, occasionally living as long as 25 years. The oldest recorded cow, Big Bertha, died at the age of 48 in 1993.<br /><br />
<table align = "right" width = "300" class="roundedtopandbottom" style="margin-left:12px;"><tr><td><img src = "/images/bullfighting.jpg" alt="Bulls can't see red." width = "300"  /></td></tr><tr><td class = "body">A common misconception about cattle (particularly bulls) is that they are enraged by the color red. This is incorrect, as cattle are red-green color-blind. The myth arose from the use of red capes in the sport of bullfighting. </td></tr></table>
The term "dogies" is used to describe orphaned calves in the context of ranch work in the American West, as in "Keep them dogies moving". In some places, a cow kept to provide milk for one family is called a "house cow".
<br /><br />
In the April 24, 2009, edition of the journal Science, a team of researchers led by the National Institutes of Health and the US Department of Agriculture reported having mapped the genome. Cattle have about 22,000 genes, and 80% of their genes are shared with humans, and they share about 1000 genes with dogs and rodents, but are not found in humans. 
<br />
<br />
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
</blockquote><br />
</td>
</tr>
</table>
</div></div></div>
<!--#Include virtual="/Footer.asp"-->
</body>
</html>