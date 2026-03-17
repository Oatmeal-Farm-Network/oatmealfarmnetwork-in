<!DOCTYPE html>
<html xmlns="https://www.w3.org/1999/xhtml">
<head>

<!--#Include virtual="/includefiles/GlobalVariables.asp"-->
<% currentbreed="muskox" %>
<!--#Include virtual="/BreedsOfLivestock/AnimalsVariablesInclude.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>


<% Description = "Musk Oxen are large, Arctic-dwelling mammal that are known for their shaggy coat and distinctive curved horns. They are members of the Bovidae family, which includes other hoofed mammals such as cows, sheep, and goats."
Title = "About Musk Ox"
image = "MuskOxheader.jpg"
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
    "name": "Oatmeal Farm Network"
  },
  "image": "<%=image %>"  }
</script>
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
  .article-body p { margin-bottom: 1.5em; text-align: justify; }
  .article-body a { color: #819360; text-decoration: none; }
  .article-body a:hover { text-decoration: underline; }
  
  /* Styles for floating elements */
  .article-float-left {
      float: left;
      width: 100%;
      max-width: 300px;
      margin: 5px 25px 15px 0;
  }
  .article-float-left img {
       width: 100%;
       border-radius: 8px;
  }
  .image-caption {
      font-size: 0.8em;
      color: #888;
      margin-top: -10px;
      text-align: left;
  }
  .clearfix::after { content: ""; clear: both; display: table; }

</style>
</head>
<body>

<% LSHeader = True %>
<% currentbreed="muskox" %>
<!--#Include virtual="/Members/MembersHeader.asp"-->

<div class="container">
<div class="article-container">

  <h1><img src="<%=BreedIcon %>" alt="<%=SpeciesNamePlural %>" height="40" /> <%=SpeciesNamePlural %></h1>
  <img src="<%=image %>" class="main-article-image" alt="About Musk Oxen" width = 100%/>
  <div class="article-body clearfix">

      <p>The musk ox (Ovibos moschatus) is a large, Arctic-dwelling mammal that is known for its shaggy coat and distinctive curved horns. They are members of the Bovidae family, which includes other hoofed mammals such as cows, sheep, and goats.</p>
      
      <p>Musk oxen are native to the Arctic tundra of North America and Greenland, where they are well adapted to life in the harsh environment. They have a thick, shaggy coat that protects them from the cold and wind, as well as long, curved horns that serve as a defense against predators and for digging in the snow for food.</p>
      
      <p>The musk oxen's diet primarily consists of lichens, mosses, and low-lying shrubs, which they find by digging through the snow. They are social animals that live in herds and form close bonds with each other, especially between mothers and their calves.</p>
      
      <p>Musk oxen have a slow reproductive rate and a low population density, which makes them vulnerable to habitat loss and hunting. However, their populations have stabilized in recent decades due to conservation efforts, and they are now considered a "near threatened" species by the International Union for Conservation of Nature (IUCN).</p>

      <p>In addition to their ecological significance, musk oxen also have cultural importance to indigenous peoples of the Arctic, who have hunted and used their meat, hide, and horns for thousands of years. Today, musk oxen can be found in zoos and wildlife parks around the world, where they are kept for educational and research purposes.</p>

      <div class="article-float-left">
          <img src="MuskOxMeat.jpg" alt="Musk Ox Meat"/><br><br>
          <p class="image-caption">Photo Source: <a href="http://atasteofgreenland.com/" target="_blank">ATasteOfGreenland.com</a></p>
      </div>

      <p>Musk ox meat is a traditional food source for indigenous peoples of the Arctic, who have hunted and used it for thousands of years. Today, it is also considered a specialty food item in some countries and is sold in specialty food markets and online.</p>
      
      <p>Musk ox meat is prized for its lean and tender texture, as well as its rich, slightly sweet flavor. It is a lean meat that is low in saturated fat and high in protein, making it a nutritious food choice.</p>
      
      <p>The meat is typically prepared in a variety of ways, including roasting, grilling, and stewing, and it can also be made into sausages and other processed meat products. In indigenous cultures, it is often served as a traditional dish during special celebrations and feasts.</p>

  </div>
</div>
</div>


<!--#Include virtual="/Members/MembersFooter.asp"-->
</body>
</html>