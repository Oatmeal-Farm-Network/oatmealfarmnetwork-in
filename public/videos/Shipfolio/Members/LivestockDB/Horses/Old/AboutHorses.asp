<!DOCTYPE html>
<meta charset="UTF-8">
<head>
<!--#Include virtual="/includefiles/GlobalVariables.asp"-->
<link rel="canonical" href="https://www.OatmealFarmNetwork.com/Horses/AboutHorses.asp" />
<!--#Include virtual="/BreedsOfLivestock/AnimalsVariablesInclude.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<title>Horse Breeds</title>
<meta name="Title" content=" Horse Breeds"/>
<meta name="Description" content="Horses have a great sense of balance, due partly to their ability to feel their footing and partly to highly developed proprioception—the unconscious sense of where the body and limbs are at all times. A horse's sense of touch is well developed. The most sensitive areas are around the eyes, ears, and nose. Horses are able to sense contact as subtle as an insect landing anywhere on the body."> 
<meta name="robots" content="follow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="Googlebot" content="follow"/>
<meta name="author" content="Livestock Of The World"/>

<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "Article",
  "headline": "Horse Breeds",
  "description": "Horses have a great sense of balance, due partly to their ability to feel their footing and partly to highly developed proprioception—the unconscious sense of where the body and limbs are at all times. A horse's sense of touch is well developed. The most sensitive areas are around the eyes, ears, and nose. Horses are able to sense contact as subtle as an insect landing anywhere on the body.",
  "author": {
    "@type": "Organization",
    "name": "Global Grange"
  },
  "image": "<%=image %>"  }
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

  .floated-media.float-left {
      float: left;
      margin-right: 25px; /* Space between media and text on its right */
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

  /* Sub-section Headings (for terminology, colors) */
  .sub-section-heading {
      color: #333;
      font-size: 2em;
      margin-top: 30px;
      margin-bottom: 15px;
      text-align: left;
      clear: both; /* Crucial: Ensure sub-heading clears any previous floats */
  }

  /* List styling for Terminology */
  .terminology-list {
      list-style: none; /* Remove default bullets */
      padding-left: 0; /* Remove default padding */
      margin-bottom: 1.5em;
  }

  .terminology-list li {
      margin-bottom: 0.5em;
      line-height: 1.4;
  }

  .terminology-list b {
      font-weight: bold; /* Ensure bold is applied */
  }

  /* Clearfix to ensure content below floats properly */
  .clearfix::after {
      content: "";
      display: table;
      clear: both;
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
currentbreed="Horses"%>
<!--#Include virtual="/members/MembersHeader.asp"-->

<% If not rs.State = adStateClosed Then
  rs.close
End If 

%>

<div class="container-wrapper">

  <div class="page-header">
      <h1>
          <img src="<%=BreedIcon %>" alt="About Horses" height="50"/>
          About Horses
      </h1>
  </div>

  <div class="main-content-text clearfix"> <% ' Add clearfix to the container of floated elements %>

      <a href="/Members/LivestockDB/Horses/#Breeds" class="view-breeds-link">View Horse Breeds</a>

      <div class="floated-media float-right">
          <img src="/images/cowboy2.jpg" alt="Horses" />
          <p class="media-caption">Photo by Mayhem Farm LLC</p>
      </div>

      <p>The modern horse has evolved over the past 45 to 55 million years from a small multi-toed animal into the large, single-toed animal of today. Humans began to domesticate horses around 4000 BC, and their domestication is believed to have been widespread by 3000 BC. Worldwide many products are many from horses, including meat, milk, hide, hair, bone, and pharmaceuticals extracted from the urine of pregnant mares; however, in the US they are predominately used for sport and recreation.</p>
      <p>Horse breeds are loosely divided into three categories based on general temperament: spirited "hot bloods" with speed and endurance; "cold bloods", such as draft horses and some ponies, suitable for slow, heavy work; and "warmbloods", developed from crosses between hot bloods and cold bloods, often focusing on creating breeds for specific riding purposes, particularly in Europe. There are more than 300 breeds of horse in the world today, developed for many different uses.</p>
      <p>Depending on breed, management and environment, the modern domestic horse has a life expectancy of 25 to 30 years. Uncommonly, a few animals live into their 40s and, occasionally, beyond. The oldest verifiable record was "Old Billy", a 19th-century horse that lived to the age of 62. In modern times, Sugar Puff, who had been listed in Guinness World Records as the world's oldest living pony, died in 2007 at age 56.</p>
      <p>Regardless of a horse or pony's actual birth date, for most competition purposes a year is added to its age each January 1 of each year in the Northern Hemisphere and each August 1 in the Southern Hemisphere. The exception is in endurance riding, where the minimum age to compete is based on the animal's actual calendar age.</p>

      <h2 class="sub-section-heading">Terminology</h2>
      <ul class="terminology-list">
          <li><b>Colt:</b> a male horse under the age of four. A common terminology error is to call any young horse a "colt", when the term actually only refers to young male horses.</li>
          <li><b>Filly:</b> a female horse under the age of four.</li>
          <li><b>Foal:</b> a horse of either sex less than one year old. A nursing foal is sometimes called a suckling and a foal that has been weaned is called a weanling. Most domesticated foals are weaned at five to seven months of age, although foals can be weaned at four months with no adverse physical effects.</li>
          <li><b>Gelding:</b> a castrated male horse of any age.</li>
          <li><b>Mare:</b> a female horse four years old and older.</li>
          <li><b>Stallion:</b> a non-castrated male horse four years old and older. The term "horse" is sometimes used colloquially to refer specifically to a stallion.</li>
          <li><b>Yearling:</b> a horse of either sex that is between one and two years old.</li>
      </ul>
      <p>In horse racing, these definitions may differ: For example, in the British Isles, Thoroughbred horse racing defines colts and fillies as less than five years old. However, Australian Thoroughbred racing defines colts and fillies as less than four years old.</p>
      <p>The English-speaking world measures the height of horses in hands and inches: one hand is equal to 4 inches (101.6 mm). The height is expressed as the number of full hands, followed by a point, then the number of additional inches, and ending with the abbreviation "h" or "hh" (for "hands high"). Thus, a horse described as "15.2 h" is 15 hands plus 2 inches, for a total of 62 inches (157.5 cm) in height.</p>
      <p>Light riding horses usually range in height from 14 to 16 hands (56 to 64 inches, 142 to 163 cm) and can weigh from 380 to 550 kilograms (840 to 1,210 lb.). Larger riding horses usually start at about 15.2 hands (62 inches, 157 cm) and often are as tall as 17 hands (68 inches, 173 cm), weighing from 500 to 600 kilograms (1,100 to 1,300 lb.). Heavy or draft horses are usually at least 16 hands (64 inches, 163 cm) high and can be as tall as 18 hands (72 inches, 183 cm) high. They can weigh from about 700 to 1,000 kilograms (1,500 to 2,200 lb.).</p>

      <div class="floated-media float-right">
          <img src="/images/smallest-horse-in-the-world.jpg" alt="Smallest Horse in the World" />
          <p class="media-caption">The largest horse in recorded history was probably a Shire horse named Mammoth, who was born in 1848. He stood 21.2 1⁄2 hands (86.5 inches, 220 cm) high and his peak weight was estimated at 1,500 kilograms (3,300lb.)</p>
      </div>

      <p>The largest horse in recorded history was probably a Shire horse named Mammoth, who was born in 1848. He stood 21.2 1⁄2 hands (86.5 inches, 220 cm) high and his peak weight was estimated at 1,500 kilograms (3,300lb.).</p>
      <p>Horses have 64 chromosomes. The horse genome was sequenced in 2007. It contains 2.7 billion DNA base pairs, which is larger than the dog genome, but smaller than the human genome or the bovine genome. The map is available to researchers. Horses exhibit a diverse array of coat colors and distinctive markings, described by a specialized vocabulary. Often, a horse is classified first by its coat color, before breed or sex. Horses of the same color may be distinguished from one another by white markings, which, along with various spotting patterns, are inherited separately from coat color.</p>
      <p>Horses which have a white coat color are often mislabeled; a horse that looks "white" is usually a middle-aged or older gray. Grays are born a darker shade, get lighter as they age, but usually keep black skin underneath their white hair coat (with the exception of pink skin under white markings). The only horses properly called white are born with a predominantly white hair coat and pink skin, a fairly rare occurrence.</p>
      <p>Mares carry their young for approximately 11 months, and a young horse can stand and run shortly following birth. Gestation lasts approximately 340 days, with an average range 320–370 days, and usually results in one foal; twins are rare.</p>
      <p>Depending on maturity, breed, and work expected, horses are usually put under saddle and trained to be ridden between the ages of two and four. Although Thoroughbred race horses are put on the track as young as the age of two in some countries, horses specifically bred for sports such as dressage are generally not put under saddle until they are three or four years old, because their bones and muscles are not solidly developed. For endurance riding competition, horses are not deemed mature enough to compete until they are a full 60 calendar months (five years) old.</p>
      <p>Adult horses have 12 incisors at the front of the mouth, adapted to biting off the grass or other vegetation. They have 24 teeth adapted for chewing, the premolars and molars, at the back of the mouth. Stallions and geldings have four additional teeth just behind the incisors, a type of canine teeth called "tushes". Some horses, both male and female, will also develop one to four very small vestigial teeth in front of the molars, known as "wolf" teeth, which are generally removed because they can interfere with the bit. There is an empty interdental space between the incisors and the molars where the bit rests directly on the gums, or "bars" of the horse's mouth when the horse is bridled.</p>
      <p>An estimate of a horse's age can be made from looking at its teeth. The teeth continue to erupt throughout life and are worn down by grazing. Therefore, the incisors show changes as the horse ages; they develop a distinct wear pattern, changes in tooth shape, and changes in the angle at which the chewing surfaces meet. This allows a very rough estimate of a horse's age, although diet and veterinary care can also affect the rate of tooth wear.</p>
      <p>Horses are herbivores with a digestive system adapted to a forage diet of grasses and other plant material, consumed steadily throughout the day. Therefore, compared to humans, they have a relatively small stomach but very long intestines to facilitate a steady flow of nutrients. A 450-kilogram (990 lb) horse will eat 7 to 11 kilograms (15 to 24 lb) of food per day and, under normal use, drink 38 liters (8.4 imp gal; 10 US gal) to 45 liters (9.9 imp gal; 12 US gal) of water. Horses have one stomach and they can digest cellulose, a major component of grass. Cellulose digestion occurs in the cecum, or "water gut", which food goes through before reaching the large intestine. Horses cannot vomit, so digestion problems can quickly cause colic, a leading cause of death.</p>
      <p>Horses have the largest eyes of any land mammal and are positioned on the sides of their heads. This means that horses have a range of vision of more than 350°, with approximately 65° of this being binocular vision and the remaining 285° monocular vision. Horses have excellent day and night vision, but they have two-color vision, similar to red-green color blindness in humans, where certain colors, especially red and related colors, appear as a shade of green.</p>
      <p>Their sense of smell, while much better than that of humans, is not quite as good as that of a dog. It is believed to play a key role in the social interactions of horses as well as detecting other key scents in the environment. Horses have two olfactory centers. The first system is in the nostrils and nasal cavity, which analyze a wide range of odors. The second, located under the nasal cavity, are the Vomeronasal organs, also called Jacobson's organs. These have a separate nerve pathway to the brain and appear to primarily analyze pheromones.</p>
      <p>A horse's hearing is good, and the pinna of each ear can rotate up to 180°, giving the potential for 360° hearing without having to move the head. Noise impacts the behavior of horses and certain kinds of noise may contribute to stress: A 2013 study in the UK indicated that stabled horses were calmest in a quiet setting, or if listening to country or classical music, but displayed signs of nervousness when listening to jazz or rock music. This study also recommended keeping music under a volume of 21 decibels. An Australian study found that stabled racehorses listening to talk radio had a higher rate of gastric ulcers than horses listening to music, and racehorses stabled where a radio was played had a higher overall rate of ulceration than horses stabled where there was no radio playing.</p>
      <p>Horses have a great sense of balance, due partly to their ability to feel their footing and partly to highly developed proprioception—the unconscious sense of where the body and limbs are at all times. A horse's sense of touch is well developed. The most sensitive areas are around the eyes, ears, and nose. Horses are able to sense contact as subtle as an insect landing anywhere on the body.</p>
      <p>Horses have an advanced sense of taste, which allows them to sort through fodder and choose what they would most like to eat, and their prehensile lips can easily sort even small grains. Horses generally will not eat poisonous plants, however, there are exceptions; horses will occasionally eat toxic amounts of poisonous plants even when there is adequate healthy food.</p>
      <p>All horses move naturally with four basic gaits: the four-beat walk, which averages 6.4 kilometers per hour (4.0 mph); the two-beat trot or jog at 13 to 19 kilometers per hour (8.1 to 11.8 mph) (faster for harness racing horses); the canter or lope, a three-beat gait that is 19 to 24 kilometers per hour (12 to 15 mph); and the gallop. The gallop averages 40 to 48 kilometers per hour (25 to 30 mph), but the world record for a horse galloping over a short, sprint distance is 88 kilometers per hour (55 mph). Besides these basic gaits, some horses perform a two-beat pace, instead of the trot. There also are several four-beat "ambling" gaits that are approximately the speed of a trot or pace, though smoother to ride. These include the lateral rack, running walk, and tölt as well as the diagonal fox trot. Ambling gaits are often genetic in some breeds, known collectively as gaited horses. Often, gaited horses replace the trot with one of the ambling gaits.</p>
      <p>Studies have indicated that horses perform a number of cognitive tasks on a daily basis, meeting mental challenges that include food procurement and identification of individuals within a social system. They also have good spatial discrimination abilities. Studies have assessed equine intelligence in areas such as problem solving, speed of learning, and memory. Horses excel at simple learning, but also are able to use more advanced cognitive abilities that involve categorization and concept learning. One study has indicated that horses can differentiate between "more or less" if the quantity involved is less than four.</p>
      <p>Unlike humans, horses do not sleep in a solid, unbroken period of time, but take many short periods of rest. Horses spend four to fifteen hours a day in standing rest, and from a few minutes to several hours lying down. Total sleep time in a 24-hour period may range from several minutes to a couple of hours, mostly in short intervals of about 15 minutes each. The average sleep time of a domestic horse is said to be 2.9 hours per day.</p>
      <p>Horses must lie down to reach REM sleep. They only have to lie down for an hour or two every few days to meet their minimum REM sleep requirements. However, if a horse is never allowed to lie down, after several days it will become sleep-deprived, and in rare cases may suddenly collapse as it involuntarily slips into REM sleep while still standing.</p>

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

  </div> <% ' End of .main-content-text %>

</div> <% ' End of .container-wrapper %>
<!--#Include virtual="/members/MembersFooter.asp"-->
</body>
</html>