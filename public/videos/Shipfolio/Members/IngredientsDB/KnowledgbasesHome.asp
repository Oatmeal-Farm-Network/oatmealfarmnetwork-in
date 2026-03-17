<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <% MasterDashboard= True %>
    <!--#Include virtual="/globalvariables.asp"-->
<link rel="canonical" href="<%=currenturl %>" />
<title>About <%=WebSiteName %></title>
<meta name="title" content="<%=WebSiteName %>"/> 
<meta name="description" content=""/>  
<meta charset="UTF-8">
<meta name="revisit-after" content="7 Days"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<style>
    /* Container for the whole page */
    .knowledgebase-home-container {
        max-width: 1200px;
        margin: 40px auto;
        padding: 0 20px;
        min-height: 600px;
    }
    
    

    
    /* Grid Layout for the Cards */
    .knowledgebase-grid {
        display: grid;
        /* Create three equal columns for the cards */
        grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
        gap: 30px; /* Space between the cards */
    }
    
    /* Styling for Individual Cards */
    .knowledgebase-card {
        border: 1px solid #ddd;
        border-radius: 8px;
        padding: 0;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
        transition: transform 0.3s, box-shadow 0.3s;
        overflow: hidden;
        display: flex;
        flex-direction: column;
    }
    
    .knowledgebase-card:hover {
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
    
    
    .knowledgebase-card {
        color: #007bff;
        margin: 20px 20px 10px 20px;
    }
    
    .knowledgebase-card {
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
<% pagename = "KnowledgebaseHome"
homepage = true %>
<!--#Include virtual="/Header.asp"-->

<div class="container body">
    <h1>Our Comprehensive Knowledgebases</h1>

    <p class="intro-text">Explore our three specialized knowledgebases to find detailed, up-to-date information across key domains.</p>

    <div class="knowledgebase-grid">
        <div class="knowledgebase-card">
            <div class="card-image-container body">
                <a href="/Livestockdb/"><img src="/members/images/KnowldegebasehomeLivestock.png" alt="Cows and sheep in a barn"></a>
            </div>
            <h2>Livestock Knowledgebase</h2>
            Comprehensive information on animal health, breeding practices, welfare standards, and common diseases across different livestock species.
            <a href="/Livestockdb/" class="regsubmit2">Explore Livestock</a>
        </div>

        <div class="knowledgebase-card">
            <div class="card-image-container">
                <a href="/Plantdb/" ></a><img src="/members/images/KnowledgebasehomePlant.png" alt="Healthy plant growing in a greenhouse"></a>
            </div>
            <h2>Plant Knowledgebase</h2>
            <p>Detailed data on crop varieties, agronomy best practices, pest and disease management, and sustainable cultivation techniques.</p>
            <a href="/Plantdb/" class="regsubmit2">Explore Plants</a>
        </div>
        <div class="knowledgebase-card">
            <div class="card-image-container">
                <a href="/IngredientsDB/"><img src="/members/images/KnowledgebasehomeIngredients.png" alt="Ingredients and spices on a table"></a>
            </div>
            <h2>Ingredient Knowledgebase</h2>
            <p>A deep dive into the properties, sources, nutritional facts, and regulatory status of various raw materials and food components.<br></p>
            <a href="/IngredientsDB/" class="regsubmit2">Explore Ingredients</a><br>
        </div>
    </div>
</div>

<!--#Include virtual="/Footer.asp"-->
</body></html>

