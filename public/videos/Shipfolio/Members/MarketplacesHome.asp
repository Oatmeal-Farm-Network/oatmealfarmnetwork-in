<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <% MasterDashboard= True %>
    <!--#Include virtual="/Members/Membersglobalvariables.asp"-->
<link rel="canonical" href="<%=currenturl %>" />
<title>About <%=WebSiteName %></title>
<meta name="title" content="<%=WebSiteName %>"/> 
<meta name="description" content=""/>  
<meta charset="UTF-8">
<meta name="revisit-after" content="7 Days"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<style>
    /* Container for the whole page */
    .Marketplace-home-container {
        max-width: 1200px;
        margin: 40px auto;
        padding: 0 20px;
        min-height: 600px;
    }
    
    

    
    /* Grid Layout for the Cards */
    .Marketplace-grid {
        display: grid;
        /* Create three equal columns for the cards */
        grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
        gap: 30px; /* Space between the cards */
    }
    
    /* Styling for Individual Cards */
    .Marketplace-card {
        border: 1px solid #ddd;
        border-radius: 8px;
        padding: 0;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
        transition: transform 0.3s, box-shadow 0.3s;
        overflow: hidden;
        display: flex;
        flex-direction: column;
    }
    
    .Marketplace-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
    }
    
    /* --- IMAGE STYLES --- */
    .card-image-container {
        height: 180px; /* Fixed height for consistent card tops */
        background-color: #f0f0f0; /* Placeholder */
    }
    
    .card-image-container img {
        width: 100%;
        height: 100%;
        /* This is the key: it forces the image to cover the container while maintaining its aspect ratio, cropping if necessary. */
        object-fit: cover;
    } 
    /* --- END IMAGE STYLES --- */
    
    
    .Marketplace-card {
        color: #007bff;
        margin: 20px 20px 10px 20px;
    }
    
    .Marketplace-card {
        color: #555;
        padding: 0 20px 20px 20px;
        flex-grow: 1;
    }
    
    /* Styling for the Button (Card Button and your existing class) */
    .card-button {
        display: block;
        text-align: center;
        padding: 12px 0;
        margin: 0 20px 20px 20px;
        background-color: #28a745;
        text-decoration: none;
        border-radius: 6px;
        transition: background-color 0.2s;
        border: none; 
        cursor: pointer;
    }
    
    </style>
<% Marketplaces = True
pagename = "MarketplacesHome"
homepage = true %>
<!--#Include virtual="/members/membersHeader.asp"-->

<div class="container body">
    <h1>Our Comprehensive Marketplaces</h1>

    <p class="intro-text">Explore our three specialized Marketplaces to find detailed, up-to-date information across key domains.</p>

    <div class="Marketplace-grid">
        <div class="Marketplace-card">
            <div class="card-image-container body">
                <a href="LivestockMarketplace" ><img src="/members/images/Marketplaceshomelivestock.png" alt="Livestock Marketplace"></a>
            </div>
            <h2>Livestock Marketplace<br><Font color="maroon">Coming Soon!</Font></h2>
            Scroll through thousands of livestock listings. We make it simple to find the exact animals you need.
            <% show = false
            if show = True then %>
            <a href="LivestockMarketplace" class="regsubmit2">Explore Livestock</a>
            <% end if %>
        </div>

        <div class="Marketplace-card">
            <div class="card-image-container">
                <img src="/members/images/MarketplaceshomeFarm2Table.png" alt="Farm 2 Table Marketplace">
            </div>
            <h2>Farm 2 Table Marketplace <br><Font color="maroon">Coming Soon!</Font></h2>
            <p>A new paradigm for farm-to-kitchen procurement. We are building a smarter, more efficient solution that creates a direct and transparent connection between farms and professional kitchens.</p>
        </div>

    </div>
</div>

<!--#Include virtual="/members/membersFooter.asp"-->
</body></html>

