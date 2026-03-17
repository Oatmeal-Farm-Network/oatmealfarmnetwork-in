<!DOCTYPE html>
<meta charset="UTF-8">
<head>
<!--#Include virtual="/includefiles/GlobalVariables.asp"-->
<!--#Include virtual="/BreedsOfLivestock/AnimalsVariablesInclude.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<title>About Honey Bees | Breeds of Livestock</title>
<meta name="Title" content="About HoneyBees | Breeds of Livestock"/>
<meta name="Description" content="Honey bees are close relatives of wasps and ants. They are found on every continent on earth, except for Antarctica."> 
<meta name="robots" content="follow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="Googlebot" content="follow"/>
<meta name="author" content="Livestock Of The World"/>
<link rel="canonical" href="https://www.OatmealFarmNetwork.com/HoneyBees/AboutHoneyBees.asp" />

<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "Article",
  "headline": "About Honey Bees",
  "description": "Honey bees are close relatives of wasps and ants. They are found on every continent on earth, except for Antarctica.",
  "author": {
    "@type": "Organization",
    "name": "Global Grange"
  },
  "image": "https://www.OatmealFarmNetwork.com/HoneyBees/Abouthoneybees.jpg"  }
</script>

<style>
  /* General Body and Container Styles */
  body {
      font-family: Arial, sans-serif;
      margin: 0;
      background-color: #f8f8f8; /* Light background */
      color: #333;
      line-height: 1.6;
      font-size: 1em; /* Base font size */
  }

  .container-wrapper {
      max-width: 960px; /* Max width for central content */
      margin: 30px auto; /* Center the container with some top/bottom margin */
      background-color: #fff;
      padding: 30px;
      border-radius: 8px;
      box-shadow: 0 4px 15px rgba(0,0,0,0.1);
  }

  /* Header for the Page */
  .page-header {
      text-align: center;
      margin-bottom: 30px;
      padding-bottom: 15px;
      border-bottom: 2px solid #ddd;
  }

  .page-header h1 {
      color: #000; /* H1 color set to BLACK as requested */
      font-size: 2.5em;
      margin: 0;
      display: inline-flex; /* Align icon and text */
      align-items: center;
  }

  .page-header h1 img {
      margin-right: 15px;
      vertical-align: middle;
  }

  /* View Breeds Link */
  .view-breeds-link {
      display: block; /* Make it a block to take full width */
      text-align: left; /* Align to left */
      margin-bottom: 20px;
      font-size: 1.1em;
      font-weight: bold;
      color: #007bff; /* Link color */
      text-decoration: none;
  }
  .view-breeds-link:hover {
      text-decoration: underline;
  }

  /* Floated Media (Image) Styles */
  .floated-media {
      width: 300px; /* Fixed width for floated content */
      margin-bottom: 20px; /* Space below the media block */
      box-sizing: border-box;
      border-radius: 8px;
      overflow: hidden;
      box-shadow: 0 2px 8px rgba(0,0,0,0.1);
      background-color: #f0f0f0;
      padding: 10px;
  }

  .floated-media.float-right {
      float: right;
      margin-left: 25px; /* Space between media and text on its left */
  }

  .floated-media img {
      max-width: 100%;
      height: auto;
      display: block;
      border-radius: 5px;
  }

  .media-caption {
      font-size: 0.9em;
      color: #666;
      margin-top: 8px;
      text-align: center;
  }

  /* Main Content Paragraphs */
  .main-content-text p {
      margin-bottom: 1em;
      text-align: justify; /* Justify text for a cleaner block look */
  }

  /* Clearfix to ensure content below floats properly */
  .clearfix::after {
      content: "";
      display: table;
      clear: both;
  }

  /* Sub-section Heading (for Queen Bee, Workers, Drones) */
  .sub-section-heading {
      color: #333; /* Darker color for sub-headings */
      font-size: 2em;
      margin-top: 30px; /* Space above sub-heading */
      margin-bottom: 15px;
      text-align: left;
      clear: both; /* Crucial: Ensure sub-heading clears any previous floats */
  }

  /* Colors Section */
  .colors-section {
      margin-top: 30px;
      padding-top: 20px;
      border-top: 1px solid #eee;
      clear: both; /* Ensure colors section clears all previous floats */
  }

  .colors-section h2 {
      color: #4CAF50;
      font-size: 1.8em;
      margin-bottom: 15px;
      text-align: left;
  }

  .colors-section ul {
      list-style: disc;
      padding-left: 25px;
      margin-bottom: 0;
  }

  .colors-section li {
      margin-bottom: 5px;
  }

  /* Responsive Adjustments */
  @media (max-width: 768px) {
      .floated-media {
          float: none;
          margin: 20px auto;
          width: 90%;
          max-width: 350px;
      }
  }
</style>
</HEAD>

<body >
<% LSHeader = True 
currentbreed="HoneyBees" %>
<!--#Include virtual="/members/membersHeader.asp"-->

<% If not rs.State = adStateClosed Then
  rs.close
End If 

%>

<div class="container-wrapper">

  <div class="page-header">
      <h1>
          <img src="<%=BreedIcon %>" alt="About Honey Bees" width="40"/>
          About Honey Bees
      </h1>
  </div>

  <div class="main-content-text clearfix"> <% ' Add clearfix to the container of floated elements %>

      <a href="/members/livestockDB/HoneyBees/#Breeds" class="view-breeds-link">View Honey Bee Breeds</a>

      <div class="floated-media float-right">
          <img src="Abouthoneybees.jpg" alt="A HoneyBee" />
          <p class="media-caption">Looking For Honey?</p>
      </div>

      <p>Honey bees are close relatives of wasps and ants. They are found on every continent on earth, except for Antarctica.</p>
      <p>Bees of all varieties live on nectar and pollen. It is estimated that one-third of the human food supply depends on insect pollination. Bees have a long, straw-like tongue called a proboscis that allows them to drink the nectar from deep within blossoms. Bees are also equipped with two wings, two antennae, and three segmented body parts (the head, the thorax, and the abdomen). Honey bees are social insects that live in colonies. The hive population consists of a single queen, a few hundred drones, and thousands of worker bees.</p>
      <p>The Honey bees forage for nectar and pollen from flowering plants. They use the nectar collected to create honey. When carrying the nectar back to the hive, their bodies break down the complex sucrose of the nectar into two simple sugars: fructose and glucose. The bees deposit the honey into a honeycomb cell, then beat their wings furiously over the top of this syrupy sweet liquid to fan out the moisture and thicken the substance. When it is complete, the bees will cap that cell with beeswax, sealing the perfected honey for consumption later on.</p>
      <p>A honey bee that is away from the hive, foraging for nectar or pollen, will rarely sting, except when stepped on or roughly handled. Honey bees will actively seek out and sting when they perceive the hive to be threatened, often being alerted to this by the release of attack pheromones. Although it is widely believed that a worker honey bee can sting only once, this is a partial misconception: although the stinger is in fact barbed so that it lodges in the victim's skin, tearing loose from the bee's abdomen and leading to its death in minutes, this only happens if the skin of the victim is sufficiently thick, such as a mammal's. Honey bees are the only hymenoptera (Hymenoptera are a large order of insects, comprising the sawflies, wasps, bees, and ants) with a strongly barbed sting, though yellow jackets and some other wasps have small barbs.</p>
      <p>Bees with barbed stingers can often sting other insects without harming themselves. Queen Honey bees have smoother stingers with smaller barbs, and can sting mammals repeatedly.</p>
      <p>The sting's injection of apitoxin into the victim is accompanied by the release of alarm pheromones, a process which is accelerated if the bee is fatally injured. The release of alarm pheromones near a hive may attract other bees to the location, where they will likewise exhibit defensive behaviors until there is no longer a threat, typically because the victim has either fled or been killed. (Note: A bee swarm, seen as a mass of bees flying or clumped together, is generally not hostile; it has deserted its hive and has no comb or young to defend.) These pheromones do not dissipate or wash off quickly, and if their target enters water, bees will resume their attack as soon as it leaves the water. The alarm pheromone emitted when a bee stings another animal smells like a banana.</p>
      <p>Honey bees are native to Africa, Europe, and Asia, along with continental islands such as Japan, the Philippines, Taiwan, and much of the Indonesian archipelago. Previously unknown in the New World, they were carried on board Spanish galleons from Europe to Mexico's central plateau early in the 16th century. As colonies' reproductive swarms left, descendants of these bees migrated northward toward the United States. A typical book on beekeeping lore states that honey bees were independently introduced into the Virginia colonies from England sometime between 1621 and 1638.</p>
      <p>Early accounts indicate that these early bee immigrants were colonizing new territory at the rate of at least 50 miles per year, moving westward across the United States even without being transported by man. Records left by Thomas Jefferson and others inform us that the advancing bee front was often 100 to 200 miles ahead of civilized outposts.</p>
      <p>A common Native American expression for honey bees, "white man's flies," used by the Cherokee and other indigenous cultures, is attributed to John Elliot, who was translating the Bible into Indian dialects and discovered that these peoples had no words for honey or wax. Some tribes, such as the Cherokee in Georgia, quickly adapted to raiding wild bee nests for the liquid gold sweets they contained.</p>
      <p>Individual colonies can house tens of thousands of bees. Colony activities are organized by complex communication between individuals, through both pheromones and the dance language. There are different types of bees in a honey bee hive: worker, drone and queen. Each has its own important roles and performs specific duties in a bee colony.</p>

      <h2 class="sub-section-heading">Queen Bee</h2>
      <div class="floated-media float-right">
          <img src="queenrbee.jpg" alt="Queen Bee" width="200" /> <% ' Original width was 200, apply here %>
          <% ' No caption in original, add if needed: <p class="media-caption">Your Caption</p> %>
      </div>
      <p>Queen bees can be recognized by her abdomen, which is usually smooth and elongated, extending well beyond her folded wings. Her function in the hive is one of production. She is normally the only reproductive female in the colony. Egg-laying begins in early spring, initiated when the first fresh pollen is brought home by the workers. Egg production will continue until fall, or as long as pollen is available. At the height of her productivity, the queen could lay as many as 2000 eggs each day. A queen bee can live for up to five years, but her period of usefulness rarely exceeds two or three years. Younger queens produce many more eggs, and older ones may produce excessive drones. Many beekeepers re-queen their colonies every year or two. Older queens are often superseded (replaced) by the workers without any assistance, or even knowledge, of the beekeeper. Good quality queens can be reared by an experienced beekeeper, but a beginner will usually do better to buy good queens from a reputable producer.</p>
      <p>Queen bees also produce a pheromone known as queen substance. This mixture of chemicals is passed individually from bee to bee throughout the entire hive as they share food. If a queen bee is removed from a colony, the workers will notice her absence within several hours because of the drop in the level of this pheromone. This queenless state quickly initiates the urge to rear a new emergency queen from the youngest available larvae (1-3 days old). The presence of this pheromone also inhibits the development of the workers' ovaries. After a period of queenlessness, some may become laying workers. Workers also evaluate their queen based on the quantity of the pheromones she produces. If workers begin to receive an insufficient dose each day, they may perceive her as poor quality, and begin making preparations to supersede her. Beekeepers often mark the queen's thorax with a dot of paint to make her easy to find, and to determine if she has been replaced.</p>

      <h2 class="sub-section-heading">Workers</h2>
      <div class="floated-media float-right">
          <img src="workerbee.jpg" alt="Worker Bee" width="200" /> <% ' Original width was 200, apply here %>
          <% ' No caption in original, add if needed: <p class="media-caption">Your Caption</p> %>
      </div>
      <p>Workers are the smallest of the bee castes, but are by far the most numerous. All workers are female, and normally incapable of reproduction. They are unable to mate, but in a hopelessly queenless colony, workers may begin to lay unfertilized eggs, which develop into drones. Workers do all of the necessary tasks within a colony. They secrete the wax used in the hive, and form it into honeycombs. They forage for all of the nectar and pollen brought into the hive, and transform the nectar into honey. They produce royal jelly to feed to the queen and young larvae. They also tend to the needs of the larvae and queens. They cap the cells of mature larvae for pupation and remove debris and dead bees from the hive. Worker bees defend the hive against intruders and maintain optimal conditions by heating, cooling, and ventilating the hive. Workers have well-developed compound eyes on the sides of their heads, and three simple eyes (ocelli) at the vertex. Their tongue is well developed and elongated for taking up nectar from flowers.</p>
      <p>Workers reared in the spring and early summers tend to live for five to six weeks. The first two weeks of their lives are spent as house bees, doing tasks in the hive. The remainder of their time is spent as field bees, foraging for food outside the hive. Workers that reach maturity in the late fall may live well into the following spring. They must maintain a cluster of bodies around the queen bee, keeping her warm through the winter months. Later, when egg-laying resumes, they must raise the first generation of young bees the next year.</p>

      <h2 class="sub-section-heading">Drones</h2>
      <div class="floated-media float-right">
          <img src="dronebee.jpg" alt="Drone Bee" width="200" /> <% ' Original width was 200, apply here %>
          <% ' No caption in original, add if needed: <p class="media-caption">Your Caption</p> %>
      </div>
      <p>Drones are male honey bees. They are visibly larger and stouter than workers. They possess large distinctive eyes that meet on the top of their heads, and have antennae slightly longer than the workers or queen. Their mouth parts are generally reduced. Drones develop from unfertilized eggs, and drone cells are visibly larger than those of workers. Drones do not tend the brood, produce wax, or collect pollen or nectar. They will feed themselves directly from honey cells in the hive, or beg food from worker bees. They do not have stingers.</p>
      <p>The only function of a drone is to fertilize a young queen bee. They are reared chiefly in the spring and summer, beginning about four weeks before new queens are produced, thus ensuring that ample drones will be available to mate with emerging queens. Their day is typically divided between periods of eating and resting, and patrolling mating sites known as drone congregation areas. Drone production will cease in the late summer, as the quantity of available food declines. Before winter, the drones are usually driven out of the hive by workers, who guard against their return. A colony that has lost its queen may develop laying workers, who can produce only drones. When this occurs, the colony is effectively doomed. The production of many drones, therefore, will be their final effort to pass on the colony's genetic line by mating with a virgin queen from another colony.</p>

      <% If Not rs.State = adStateClosed Then
          rs.Close
      End If %> <% ' Ensure previous recordset is closed before re-using 'rs' %>

      <%
      Set rs = Server.CreateObject("ADODB.Recordset") ' Re-create recordset for colors
      sql2 = "select * from SpeciesColorlookupTable where SpeciesID = " & SpeciesID & " order by SpeciesColor "
      rs.Open sql2, conn, 3, 3

      If Not rs.EOF Then %>
          <div class="colors-section">
              <h2><%= SpeciesName %> Colors</h2>
              <p><%= SpeciesNamePlural %> come in the following colors:</p>
              <ul>
                  <% While Not rs.EOF %>
                      <li><%=rs("SpeciesColor")%></li>
                  <%
                      rs.MoveNext
                  Wend %>
              </ul>
          </div>
      <% End If

      rs.Close
      Set rs = Nothing ' Clear recordset object
      %>

  </div> 

</div> 
<!--#Include virtual="/members/membersFooter.asp"-->
</body>
</html>