<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!--#Include virtual="/Members/membersglobalvariables.asp"-->

<% title= "Oatmeal Farm Network: Buy and Sell American Livestock Online"
Description = "Explore a Diverse Range of Livestock for Sale at the Oatmeal Farm Network, the Premier Online Marketplace"
Author = "Oatmeal Farm Network" %>

<Title><%=Title %></Title>
<meta name="title" content="<%=Title %> - Oatmeal Farm Network" />

<meta name="description" content="<%=Description %>" />
<meta name="robots" content="follow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="Googlebot" content="follow"/>
<meta name="author" content="<%=Author %>"/>
<link rel="canonical" href="<%=currenturl %>" />
<meta property="og:url" content="<%=currenturl %>" />
<meta name="Title" content="<%=Title %> - Oatmeal Farm Network"/>
<meta name="Author" content="<%=Author %> - Oatmeal Farm Network"/>
<meta property="og:locale" content="en_US" />
<meta property="og:type" content="article" />
<meta property="og:title" content="<%=Title %> - Oatmeal Farm Network" />
<meta property="og:site_name" content="Oatmeal Farm Network" />
<meta property="og:image" content="<%=image %>" />
<meta property="og:image:width" content="854" />
<meta property="og:image:height" content="447" />
<meta property="og:description" content="<%=Title %>" />

<meta name="keywords" content="livestock, American livestock, buy livestock, sell livestock, online marketplace, ranching, Oatmeal Farm Network, Diversity, Livestock Market, Livestock Trader, Dream Horse, Open Range, Cattle Range, Equine Now">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="format-detection" content="telephone=no">
<meta name="theme-color" content="#ffffff">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">
<meta name="mobile-web-app-capable" content="yes">
<link rel="manifest" href="/manifest.json">
<meta name="msapplication-TileColor" content="#ffffff">
<meta name="theme-color" content="#ffffff">
<meta name="robots" content="index, follow">

</head>
<body >
<!--#Include virtual="/members/MembersHeader.asp"-->
<%



' --- 1. DATA FETCHING (No changes needed) ---
Dim arrListings, numListings
Const MAX_LISTINGS = 12
Dim sql
sql = "SELECT TOP " & MAX_LISTINGS & " PeopleID, Photo1, AnimalID, FullName, Species, Breed, Price, Discount FROM USHomePageListing WHERE PeopleID IS NOT NULL AND Photo1 IS NOT NULL AND LEN(Photo1) > 1 ORDER BY NEWID()"

'response.write("sql=" & sql)

Dim rs
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 1
If Not rs.EOF Then
    arrListings = rs.GetRows()
    numListings = UBound(arrListings, 2) + 1
Else
    numListings = 0
End If
rs.Close
Set rs = Nothing

' --- 2. HELPER FUNCTIONS (CORRECTED) ---
Function FormatPhoto(rawPhotoURL)
    ' This check handles null or very short, invalid strings.
    If IsNull(rawPhotoURL) Or Len(Trim(rawPhotoURL)) < 15 Then
        FormatPhoto = "/uploads/ImageNotAvailable.webp"
        Exit Function
    End If
    
    Dim cleanURL
    cleanURL = LCase(Trim(rawPhotoURL))
    
    ' Perform URL corrections
    cleanURL = Replace(cleanURL, "http:", "https:")
    cleanURL = Replace(cleanURL, "livestockofamerica.com", "livestockoftheamerica.com")
    
    ' 👇 CORRECTED LOGIC: Reverted to a safer check.
    ' This now only marks a specific known "bad" URL as invalid,
    ' instead of incorrectly flagging valid images.
    If cleanURL = "https://www.livestockoftheamerica.com/uploads/" Then
        FormatPhoto = "/uploads/ImageNotAvailable.webp"
    Else
        FormatPhoto = cleanURL
    End If
End Function

Function FormatPrice(price, discount)
    Dim numPrice, numDiscount
    If IsNumeric(price) Then numPrice = CDbl(price)
    If IsNumeric(discount) Then numDiscount = CDbl(discount)
    If numDiscount > 0 And numPrice > 0 Then
        Dim discountedPrice
        discountedPrice = numPrice * ((100 - numDiscount) / 100)
        FormatPrice = "<span class='price-original'><strike>" & FormatCurrency(numPrice, 0) & "</strike></span> <b class='price-sale'>" & FormatCurrency(discountedPrice, 0) & "</b>"
    ElseIf numPrice > 0 Then
        FormatPrice = "<b class='price-regular'>" & FormatCurrency(numPrice, 0) & "</b>"
    Else
        FormatPrice = "<span class='price-call'>Call For Price</span>"
    End If
End Function
%>

<style>
  @import url('https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap');
  @import url('https://fonts.googleapis.com/css2?family=Cinzel:wght@700&display=swap');

  /* This is the key CSS for the video and its container */
  .video-container {
    width: 100%;
    /* * This padding-top value (30%) sets the container's height to 30% of its width,
     * which effectively crops the video to its top 30%.
     */
    padding-top: -40%; 
    padding-bottom: 19%; 
    position: relative;
    overflow: hidden;
  }

  .video-container video {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    object-fit: cover;
    display: block;
  }

  .intro-section {
    background-color: #ffffff;
    padding: 0 1rem;
    border-bottom: 1px solid #dee2e6;
  }
  .intro-section .lead {
    margin-top: 0;
    margin-bottom: 1rem;
  }
  .intro-section section {
    margin: 0;
    padding: 0;
    line-height: 0;
    font-size: 0;
  }
  .btn-brand { background-color: #E2A92B; color: #445437; font-weight: bold; padding: 0.75rem 1.5rem; border: none; border-radius: 5px; transition: background-color 0.2s ease; }
  .btn-brand:hover { background-color: #c99420; color: #FFFFFF; }
  .listings-section { padding: 0rem 1rem; }

  .product-card { background-color: #ffffff; border: 1px solid #dee2e6; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.05); transition: all 0.3s ease; display: flex; flex-direction: column; }
  .product-card:hover { box-shadow: 0 8px 16px rgba(0,0,0,0.1); transform: translateY(-5px); }
  .product-card-img-link { display: block; border-bottom: 1px solid #dee2e6; }
  
  .product-card-img {
    width: 100%;
    height: 200px;
    object-fit: contain;
    border-top-left-radius: 8px;
    border-top-right-radius: 8px;
  }

  .product-card .card-body { padding: 1rem; display: flex; flex-direction: column; flex-grow: 1; }
  .product-card-title { font-size: 1.1rem; font-weight: 500; margin-bottom: 0.25rem; }
  .product-card-title a { color: #343a40; text-decoration: none; }
  .product-card-title a:hover { color: #445437; }
  .product-card-details { font-size: 0.9rem; color: #6c757d; margin-bottom: 1rem; }
  .product-card-price { margin-top: auto; font-size: 1.1rem; color: #445437; }
</style>


<% If numListings > 0 Then %>
<div class="listings-section">

  


  <div class="container">

    <h1 style="margin-bottom:0;">Livestock Marketplace</h1>
    
    <div class="video-container">
      <video 
        src="LivestockMarketplaceHeader.mp4" 
        autoplay 
        loop 
        muted 
        playsinline
      >
      </video>
    </div>


    <div class="text-center mb-5">
      <h2>Featured Listings</h2>
    </div>
    
    <div class="row">
      <% 
      For i = 0 To numListings - 1
          Dim peopleId, photoUrl, animalId, fullName, species, breed, price, discount
          peopleId  = arrListings(0, i)
          photoUrl  = arrListings(1, i)
          animalId  = arrListings(2, i)
          fullName  = arrListings(3, i)
          species   = arrListings(4, i)
          breed     = arrListings(5, i)
          price     = arrListings(6, i)
          discount  = arrListings(7, i)
          
          Dim finalPhotoUrl
          finalPhotoUrl = FormatPhoto(photoUrl)
          
          If finalPhotoUrl <> "/uploads/ImageNotAvailable.webp" Then
              Dim detailLink
              detailLink = "/Members/Animals/Details.asp?AnimalID=" & animalId & "&CurrentPeopleID=" & peopleId
      %>
      <div class="col-lg-3 col-md-4 col-sm-6 mb-4">
        <div class="product-card h-100">
          <a href="<%= detailLink %>" class="product-card-img-link">
            <img src="<%= finalPhotoUrl %>" class="product-card-img" alt="<%= Server.HTMLEncode(fullName) %>">
          </a>
          <div class="card-body text-center">
            <h3 class="product-card-title">
              <a href="<%= detailLink %>">
                <% If Len(fullName) > 25 Then %>
                  <%= Left(fullName, 25) %>&hellip;
                <% Else %>
                  <%= fullName %>
                <% End If %>
              </a>
            </h3>
            <p class="product-card-details"><%= breed %>&nbsp;<%= species %></p>
            <div class="product-card-price">
              <%= FormatPrice(price, discount) %>
            </div>
          </div>
        </div>
      </div>
      <%
          End If
      Next 
      %>
    </div>
  </div>
</div>
<% End If %>
<!--#Include virtual="/members/MembersFooter.asp"-->
</body></html>