<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<% PageName="Emu" 
signularanimal = "Emu"
SpeciesNamePlural ="Emus"
SpeciesID = 19
BreedIcon = "https://www.OatmealfarmNetwork.com/icons/emuiconwhite.png"
CurrentBreed = "Emus"
currentbreed2 = "Emus"

 %>
<!--#Include virtual="/members/membersGlobalVariables.asp"-->
<!--#Include virtual="/BreedsOfLivestock/AnimalsVariablesInclude.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>

<% Description = "Emu are the second-largest living bird by height, after the ostrich, and the largest native bird in Australia. Emus are raised for their meat, leather, feathers and oil."
Title = "About Emus"
image = "EmuHeader.jpg"
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
  "headline": <%= Title %>,
  "description": <%=Description %>,
  "author": {
    "@type": "Organization",
    "name": "Oatmeal Farm Network"
  },
  "image": <%=image %> }
</script>


</HEAD>
<body >
<% LSHeader = True 
currentbreed="Emus"%>
<!--#Include virtual="/Members/MembersHeader.asp"-->
<!--#Include virtual="/BreedsofLivestock/AnimalsVariablesInclude.asp"-->
<style>
  /* Consistent styles from previous pages */
  body { font-family: Arial, sans-serif; margin: 0; background-color: #f0f5f9; color: #333; }
  .container-fluid { width: 100%; }
  .container { max-width: 960px; margin: 0 auto; padding: 0 15px; }

  .page-header { padding: 20px 0; background-color: #fff; border-bottom: 1px solid #ddd; }
  .page-header h1 { color: black; font-size: 2.2em; margin: 0; display: inline-flex; align-items: center; }
  .page-header h1 img { margin-right: 10px; }
  
  .article-container { background-color: #ffffff; padding: 20px 30px 40px 30px; border-radius: 8px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); margin-top: 30px; margin-bottom: 30px; }
  .article-container .main-article-image { max-width: 100%; height: auto; border-radius: 8px; margin: 0 auto 25px auto; display: block; }

  .article-body { line-height: 1.7; font-size: 1.1em; }
  .article-body h2 { color: #3f51b5; font-size: 1.8em; margin-top: 40px; border-bottom: 2px solid #eee; padding-bottom: 5px; }
  .article-body p { margin-bottom: 1.5em; }
  
  /* Styles for floating elements within the article */
  .article-float-right {
      float: right;
      width: 100%;
      max-width: 380px;
      margin: 5px 0 15px 25px;
  }
  .article-float-left {
      float: left;
      width: 100%;
      max-width: 300px;
      margin: 5px 25px 15px 0;
  }
  .article-float-left img, .article-float-right img {
       width: 100%;
       border-radius: 8px;
  }

  .clearfix::after { content: ""; clear: both; display: table; }

</style>
</head>
<body>

<% LSHeader = True %>

<div class="container">
<div class="article-container">


  <img src="<%=image %>" class="main-article-image" alt="About Emus" width = 100%/>
  <div class="article-body clearfix">



      <p>Emu are the second-largest living bird by height, after the ostrich, and the largest native bird in Australia. Emus are raised for their meat, leather, feathers and oil. <b>There is only one species of emu, which is called Dromaius novaehollandiae, but there are no recognized subspecies or breeds of emu.</b></p>
      
      <h2>Emu Meat</h2>
      <p>Most of the usable meat portions (the best cuts come from the thigh and the larger muscles of the drum or lower leg) are, like other poultry, dark meat. Emu meat is considered by the US Food and Drug Administration to be a red meat because its red color and pH value approximate that of beef, but for inspection purposes it is considered to be poultry.</p>
      <p>Emu meat is served in some fine restaurants in Europe and the US and has been mentioned favorably on some of Gordon Ramsey's cooking shows.</p>

      <h2>Emu Oil</h2>
      <p>Emu oil is processed from their fat and is used for cosmetics, dietary supplements, and therapeutic products. Emu oil is used to improve cholesterol levels and is a good source of fatty acids. It is also used for weight loss and as cough syrup for colds. The Oil consists mainly of fatty acids of which oleic acid (42%), linoleic and palmitic acids (21% each) are the main components. It also contains various anti-oxidants, notably carotenoids and flavones. There is some evidence that emu oil has anti-inflammatory properties; however, there have not yet been extensive tests. However, It has been scientifically shown to improve the rate of wound healing, but the mechanism responsible for this effect is not understood.</p>
      
      <h2>Emu Leather</h2>
      <p>Emu leather has a distinctive patterned surface, due to a raised area around the feather follicles in the skin; the leather is used in such items as wallets, handbags, shoes and clothes.</p>
      
      <h2>Emu Feathers</h2>
      <p>Emu feathers are very soft and are used in decorative arts and crafts, including fishing lures, clothing accents, flower arrangements, and hats. Emu feathers have a double plume, which makes them most rare. The Emu and its cousin the cassowary are the only birds in the world that have two feathers of the same length originating from the one quill.</p>
      
      <div class="article-float-left">
           <img src="Emueggs.jpg" alt="Emu Eggs"/>
      </div>

      <h2>Emu Eggs</h2>
      <p>Emu eggs are large (generally the equivalent in size to 12 chicken eggs) and dark green. They are 'a touch milder' in taste than chicken eggs with a fluffier texture.</p>
      <p>Emptied emu eggs have been engraved with portraits, similar to cameos, and scenes of Australian native animals. They are also outstanding as Easter eggs.</p>
      <p>Due to increased popularity in Emu Oil and Meat in particular, Emu farming is quickly spreading beyond Australia and Emu farms can be widely found in North America and Europe in particular.</p>
      
      <h2>Emus in Australia</h2>
      <p>Emu are fairly common in Australia and their range covers most of mainland Australia. At one point there were Tasmanian and King Island subspecies of Emus but they became extinct after the European settlement of Australia in 1788.</p>
      <p>Emus are soft-feathered, brown, flightless birds with long necks and legs, and can reach up to 1.9 metres (6.2 ft) in height. Emus can travel great distances, and when necessary can sprint at 50 km/h (31 mph). They forage for a variety of plants and insects, but have been known to go for weeks without eating. They drink infrequently, but take in copious amounts of water when the opportunity arises.</p>
      <p>Emu breeding takes place in May and June. Female Emus can mate several times and lay several clutches of eggs in one season. The male does the incubation; during this process he hardly eats or drinks and loses a large amount of weight. Their eggs hatch after around eight weeks, and the young are nurtured by their fathers. They reach full size after around six months, but can remain as a family unit until the next breeding season.</p>
      <p>Emus are an important cultural icon for Australia, and they appear on the coat of arms and various coins. Emus also are prominently found in Indigenous Australian mythology.</p>

  </div>
</div>
</div>
<!--#Include virtual="/Members/MembersFooter.asp"-->
</body>
</html>