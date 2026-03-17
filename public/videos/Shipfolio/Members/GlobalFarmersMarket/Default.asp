<!doctype html>
<html lang="en">
   <head>
    <title>The Global Farmers' Market - Coming Soon</title>
     
      <link rel="icon" type="image/x-icon" href="/logos/OFNFavicon.png">
      <link rel="shortcut icon" type="image/png" href="/logos/OFNFavicon.png"/>
      
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />

    <style>

        .header-section {
            background-color: #fff;
            padding: 0rem 0;
            text-align: center;
            border-bottom: 1px solid #e9ecef;
        }
        .header-section p {
            font-size: 1.25rem;
            color: #6c757d;
            max-width: 700px;
            margin: 0 auto;
        }
        .content-section {
            padding: 0rem 0;
        }
        .feature-card {
            background-color: #fff;
            padding: 2.5rem;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.05);
            height: 100%;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .feature-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 16px rgba(0,0,0,0.1);
        }
        .feature-card h3 {
            color: #007bff;
            font-weight: 600;
            margin-bottom: 1rem;
        }
        .feature-card p {
            color: #555;
            font-size: 1rem;
            line-height: 1.6;
        }
        .cta-section {
            background-color: #e9ecef;
            padding: 5rem 0;
            text-align: center;
        }
        .cta-section h2 {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 1rem;
        }
        .cta-section p {
            font-size: 1.25rem;
            color: #495057;
            margin-bottom: 2rem;
        }
        .form-control {
            max-width: 400px;
            margin: 0 auto;
        }


    </style>
 
    </head>
  
  <body>
<% currentpage = "Charlie" %>
<!--#Include virtual="/Members/MembersHeader.asp"-->

<div class="header-section">
    <div class="container">
        <img src="GlobalFarmersMarketLogo.webp" style="margin:10px" class="img-fluid" alt="Global Farmers' Market Logo">
        <h1>The Global Farmers' Market: Coming Soon</h1>
        <p>A new paradigm for farm-to-kitchen procurement. We are building a smarter, more efficient solution that creates a direct and transparent connection between farms and professional kitchens.</p>
    </div>
</div>

<div class="content-section bg-light">
    <div class="container"><br>
        <h2 class="text-center mb-5">The Power of AI-Powered Agents</h2>
        <div class="row g-4">
            <div class="col-md-6">
                <div class="feature-card">
                    <h3>For Farms: Meet Charlie.</h3>
                    <p>Charlie is your autonomous sales and inventory manager. It uses real-time market data to dynamically price your products and proactively market your available inventory to the most relevant buyers. This ensures you get a fair price and a consistent stream of orders, helping you plan for the future with confidence.</p>
                </div>
            </div>
            <div class="col-md-6">
                <div class="feature-card">
                    <h3>For Restaurants: Meet David.</h3>
                    <p>David is your personal procurement specialist. It anticipates your ingredient needs, manages your budget, and places orders based on your unique sourcing criteria. With David, you'll save countless hours on paperwork and ensure you always have the freshest ingredients.</p>
                </div>
            </div>
        </div>
        <div class="row mt-5">
            <div class="col-12">
                <div class="text-center">
                    <h3 class="mb-3">The Automated Negotiation Protocol</h3>
                    <p class="lead">The true innovation is the Automated Negotiation Protocol. Our agents will negotiate directly on the platform on your behalf, finding the perfect equilibrium of price, quantity, and delivery logistics in real-time -- no calls, no emails, just a confirmed order and a fair deal for all, with your approval.</p>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="cta-section">
    <div class="container">
        <h2>Redefining the Supply Chain</h2>
        <p>The Global Farmers' Market is more than a marketplace; it is a new model for the food industry.</p>
        <div class="row justify-content-center text-start">
            <div class="col-lg-8">
                <ul>
                    <li><strong>Higher Margins for Farmers:</strong> Get paid what your products are truly worth.</li>
                    <li><strong>Lower Costs for Restaurants:</strong> Streamline your supply chain and reduce operational expenses.</li>
                    <li><strong>Superior Quality:</strong> Ensure your menu is built with the freshest, most local ingredients available.</li>
                    <li><strong>Unprecedented Efficiency:</strong> Automate your most time-consuming tasks and focus on your business.</li>
                </ul>
            </div>
        </div>
        <p class="mt-4">We are launching in select regions soon. Join our list to get exclusive access to our beta program and be among the first to transform your business.</p>
        <form class="mt-4">
            <div class="input-group mb-3">
                <input type="email" class="form-control" placeholder="Enter your business email" aria-label="Recipient's business email" aria-describedby="button-addon2">
                <button class="btn btn-primary" type="button" id="button-addon2">Stay Ahead of the Curve</button>
            </div>
        </form>
    </div>
</div>

<!--#Include virtual="/Members/MembersFooter.asp"--> 
</body></html>