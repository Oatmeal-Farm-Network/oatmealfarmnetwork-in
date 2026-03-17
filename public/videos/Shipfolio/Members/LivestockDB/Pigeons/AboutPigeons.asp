<!DOCTYPE html>
<meta charset="utf-8">
<head>
<!--#Include virtual="/includefiles/GlobalVariables.asp"-->
<link rel="canonical" href="https://www.OatmealFarmNetwork.com/Pigeons/AboutPigeons.asp" />
<!--#Include virtual="/BreedsOfLivestock/AnimalsVariablesInclude.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<title>About Pigeons</title>
<meta name="Title" content="Breeds of Livestock - Pigeons Breeds"/>
<meta name="Description" content="Pigeons were first domesticated at least 10,000 years ago, and they are raised as for meat, milk and other dairy products, and as draft animals."> 
<meta name="robots" content="follow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="Googlebot" content="follow"/>
<meta name="author" content="The Andresen Group"/>

<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "Article",
  "headline": "About Pigeons",
  "description": "Pigeons were first domesticated at least 10,000 years ago, and they are raised as for meat, milk and other dairy products, and as draft animals.",
  "author": {
    "@type": "Organization",
    "name": "Global Grange"
  },
  "image": <%=image %>  }
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

  /* Clearfix to ensure content below floats properly */
  .clearfix::after {
      content: "";
      display: table;
      clear: both;
  }

  /* Source Link */
  .source-link {
      display: block;
      text-align: right;
      margin-top: 20px;
      font-size: 0.9em;
      color: #555;
      clear: both; /* Ensure source link clears previous floats */
  }
  .source-link a {
      color: #007bff;
      text-decoration: none;
  }
  .source-link a:hover {
      text-decoration: underline;
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
<% LSHeader = True %>
<!--#Include virtual="/Members/MembersHeader.asp"-->

<% If not rs.State = adStateClosed Then
  rs.close
End If 

Set rs2 = Server.CreateObject("ADODB.Recordset")
%>
<div class="container-wrapper">

  <div class="page-header">
      <h1>
          <img src="/icons/Pigeoniconwhite.png" alt="About Pigeons" height="50"/>
          About Pigeons
      </h1>
  </div>

  <div class="main-content-text clearfix"> <% ' Add clearfix to the container of floated elements %>

      <a href="/Members/LivestockDB/Pigeons/#Breeds" class="view-breeds-link">View Pigeon Breeds</a>

      <div class="floated-media float-right">
          <img src="Pigeon.jpg" alt="Pigeon" />
          <p class="media-caption">"Bonjour, mes amis! Let me tell you about the delightful bird that is the pigeon. These domesticated fowls are not only a beautiful addition to our ornamental gardens, but they also serve as a delectable source of nourishment. Yes, you heard that right, these birds are used for their meat, known as "squab."</p>
      </div>

      <p>Ah, squab, the epitome of flavor, much like a rich and tender chicken. It is the meat of an immature pigeon that is under the age of four weeks. The term is believed to have originated from the Swedish word "skvabb," meaning "loose, fat flesh."</p>
      <p>In the days of yore, the term squab was used for all types of doves and pigeons, such as the wood pigeon, mourning dove, and even the extinct socorro dove. However, today, squab meat almost exclusively comes from our domesticated pigeons. I must remind you, the meat of doves and pigeons hunted for sport should not be referred to as squab.</p>
      <p>Pigeon farming, although a niche industry, is practiced in many countries, including France, Belgium, and the Netherlands. Yet, it can be quite the challenge, as pigeons are prone to disease and predation, and require specialized care and management. But the end result, a beautifully roasted squab, is worth every effort!</p>
      <p>As a passionate cook, I have always been intrigued by the history of food. Pigeon, or squab, is no exception. It seems that the practice of raising pigeons for their meat can be traced back to North Africa, and throughout the ages, squab has been a popular delicacy in civilizations like ancient Egypt, Rome, China, India, and medieval Europe.</p>
      <p>Ah, the rich history of squab! Domesticated pigeons, also known as squabs, have been a source of sustenance for civilizations dating as far back as Ancient Egypt and Rome. In fact, texts detailing the raising of pigeons for meat date back to AD 60 in Spain, where it was a cheap and readily available source of protein. The practice of keeping dovecotes, or pigeon houses, was widespread throughout the Middle Ages and served as a supplement to self-sufficient estates, providing meat for unexpected guests and even a source of income from surplus birds.</p>
      <p>The squab industry today primarily uses utility pigeons, which are raised until they reach adult size but have not yet flown, and then slaughtered. The meat of these birds is known for its rich flavor, often described as tasting like dark chicken.</p>
      <p>While historically squab was highly valued and even believed to have medicinal properties, it is generally considered exotic and not a staple food in contemporary times. Nevertheless, its significance and popularity have lasted throughout the ages and across cultures, making it a fascinating aspect of culinary history.</p>
      <p>One interesting characteristic of pigeons is that they form pair bonds to breed, and both parents are responsible for brooding and feeding the squabs until they reach four weeks old. A pair of pigeons can produce up to 15 squabs a year, and ten pairs can produce eight squabs per month without assistance from their keepers. These birds are highly adaptable, often returning to their dovecote to rest and breed after foraging.</p>
      <p>Utility pigeons, selected for their quick growth, weight gain, and overall health, are typically used in commercial squab production. To increase yields, a two-nest system may be utilized, where the mother can lay eggs in a second nest while her offspring are still growing in the first. Establishing two breeding lines, one for prolificacy and one for "parental performance," has also been suggested for higher yields.</p>
      <p>While hatching success is estimated to be between 15-20% in well-maintained pigeon lofts, egg size is important for the initial size and mortality of squabs. However, it becomes less important as they age.</p>
      <p>Finally, after roughly a month, the squabs reach adult size but have not yet flown, making them easier to catch and slaughter. I hope you have enjoyed learning a bit more about this interesting culinary tradition.</p>

      <div class="floated-media float-left">
          <img src="PigeonMeat.jpg" alt="Squab" />
          <p class="media-caption">Ah, squab! This tender, moist and richly flavored bird is a favorite in many Chinese-American restaurants. With its silky texture and mild berry flavor, squab is a real treat for the taste buds. Unlike other poultry, squab is dark meat with a fatty skin that is similar to duck, and its lean meat is easily digestible, rich in vitamins, minerals and proteins.</p>
      </div>

      <p>In the 1997 edition of Joy of Cooking, it was warned that if squab was cooked beyond medium-rare, its flavor would become "livery." To bring out the best flavor in squab, complex red or white wines are recommended. The friar Luca Pacioli even included "How to Kill a Squab by Hitting with a Feather on the Head" in his book of "culinary secrets."</p>
      <p>Ah, the delectable and versatile dish of Pastales de pollos y pichones, or Chicken and Squab Pastry! This 19th-century recipe hailing from California is a delightful savory pie with alternating layers of chicken and squab, paired with a picadillo made of minced veal, bacon, ham, and an array of flavorsome ingredients including onion, mushrooms, apples, artichokes, tomatoes, and seasonings.</p>
      <p>When it comes to cooking these birds, commercially raised birds are best for roasting, grilling, or searing and can be ready in half the time it takes to cook traditionally raised birds. On the other hand, traditionally raised birds are more suited for slow-cooked casseroles and stews, as their meat is much tougher than squab and requires a longer cooking time to become tender.</p>
      <p>In the United States, squab has become a specialty item, as it is now more expensive than chicken. However, it continues to be served in high-end restaurants such as Le Cirque and the French Laundry, and is endorsed by many celebrity chefs. Squab is often sold for a high price, sometimes reaching up to eight dollars per pound!</p>
      <p>In Indian cuisine, squab is particularly popular in the Northeast and is often cooked as a curry, sometimes with the addition of banana blossom. It is favored by both tribal and non-tribal populations and is associated with strength and good health. In some Hindu temples, such as the Kamakhya temple in India, pigeon is even sacrificed as an offering and can then be consumed.</p>
      <p>In Chinese cuisine, squab is a staple at celebratory banquets, particularly during Chinese New Year, and is usually deep-fried. Cantonese-style pigeon is braised in a mixture of soy sauce, rice wine, and star anise, then roasted to perfection, yielding crispy skin and tender meat. Squabs can be purchased live in Chinese marketplaces for maximum freshness, and are dressed in either the "Chinese-style" or "New York-dressed" style.</p>
      <p>In Indonesian cuisine, squab is a popular dish, especially in Sundanese and Javanese cuisine, where it is seasoned and spiced with coriander, turmeric, garlic, and deep-fried in palm oil. It is served with sambal, tempeh, tofu, vegetables, and rice wrapped in banana leaf.</p>
      <p>Although squab is relatively easy to raise, it is not commonly considered as a potential source of food security. In some parts of the world, the consumption of squab is avoided due to the negative connotation of feral pigeons as unsanitary urban pests. However, squab meat is actually considered safer than other poultry products as it harbors fewer pathogens and can be served between medium and well-done.</p>
      <p>Despite its history as a luxurious dish, I believe that the rich, dark meat of the squab has a flavor that deserves to be celebrated in kitchens everywhere. Bon appétit!</p>

      <p class="source-link">Tasty Photo Source: <a href="https://www.thespruceeats.com/what-is-squab-2313817" target="_blank">The Spruce Eats</a></p>

      <% If Not rs.State = adStateClosed Then
          rs.Close
      End If %> 


  </div> 

</div>
<!--#Include virtual="/Members/MembersFooter.asp"-->
</body>
</html>