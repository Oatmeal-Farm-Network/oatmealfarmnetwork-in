<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
      <% MasterDashboard= True %>
<!--#Include virtual="/members/MembersGlobalVariables.asp"-->
<% 
Current1 = "MembersHome"
Current2="MembersHome" %> 
</head>
<body>
<!--#Include virtual="/members/MembersHeader.asp"-->
<style>
    @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap');


    .dashboard-section {
        background-color: #fff;
        /* Much smaller border-radius */
        border-radius: 0.5rem; 
        box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
        border: 1px solid #E5E7EB;
        padding: 1.5rem;
    }

    .dashboard-link-card {
        display: flex;
        flex-direction: row;
        align-items: center;
        padding: 0.5rem;
        background-color: #F9FAFB;
        /* Much smaller border-radius */
        border-radius: 0.375rem; 
        box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1), 0 1px 2px 0 rgba(0, 0, 0, 0.06);
        transition: transform 0.2s ease-in-out, box-shadow 0.2s ease-in-out, background-color 0.2s ease-in-out;
        border: 1px solid #F3F4F6;
        text-align: left;
        width: 100%;
        text-decoration: none;
        margin-bottom: 1rem;
    }

    .dashboard-link-card:hover {
        transform: translateY(-3px);
        box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
        background-color: #E5E7EB; /* Light grey for hover */
    }

    /* Removed icon specific styling as icons are being removed */
    .dashboard-link-card-content {
        display: flex;
        flex-direction: column;
        flex-grow: 1;
        text-align: left;
    }

    .dashboard-link-card-title {
        font-size: 11pt; /* Changed to 11pt */
        font-weight: normal;
        color: #3D6B34;
        margin: 0;
        line-height: 1.2;
        text-decoration: none;
    }

    .dashboard-link-card span {
        font-weight: normal; /* Adjusted for consistency */
        color: #1F2937;
        font-size: 11pt; /* Changed to 11pt */
    }

    .dashboard-link-card {
        font-size: 11pt; /* Changed to 11pt */
        margin-top: 0.25rem;
        display: block;
        text-decoration: none;
        color: #3D6B34;
    }

    .dashboard-table th,
    .dashboard-table td {
        padding: 0.75rem 1rem;
        text-align: left;
        border-bottom: 1px solid #E5E7EB;
    }

    .dashboard-table th {
        background-color: #F3F4F6;
        font-weight: 600;
        color: #4B5563;
        text-transform: uppercase;
        font-size: 0.75rem;
        letter-spacing: 0.05em;
    }

    .dashboard-table tr:nth-child(odd) {
        background-color: white;
    }

    .dashboard-table tr:last-child td {
        border-bottom: none;
    }

    .action-button {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        padding: 0.5rem 1rem;
        border-radius: 0.5rem;
        font-weight: 600;
        transition: background-color 0.2s ease-in-out, transform 0.1s ease-in-out;
        cursor: pointer;
        border: none;
    }

    .action-button.primary {
        background-color: black;
        color: white;
    }

    .action-button.primary:hover {
        background-color: black;
        transform: translateY(-1px);
    }

    .action-button.secondary {
        background-color: #E5E7EB;
        color: #374151;
    }

    .action-button.secondary:hover {
        background-color: #D1D5DB;
        transform: translateY(-1px);
    }

    .action-icon {
        width: 1.25rem;
        height: 1.25rem;
        color: #6B7280;
        transition: color 0.2s ease-in-out;
    }

    .action-link:hover .action-icon {
        color: black;
    }

    .dashboard-grid {
        display: grid;
        grid-template-columns: 1fr;
        gap: 2rem;
    }

    @media (min-width: 768px) {
        .dashboard-grid {
            grid-template-columns: 1fr 2fr; /* Left column 1/3, Right column 2/3 */
        }
    }

    .organization-card-content {
        display: flex;
        flex-direction: column;
        flex-grow: 1;
    }

    .organization-card-content .dashboard-card-title {
        font-size: 11pt; /* Changed to 11pt */
        font-weight: normal; /* Adjusted for consistency */
        color: #1F2937;
        margin-bottom: 0.25rem;
    }

    .organization-card-links ul {
        list-style: none;
        padding: 0;
        margin: 0;
        display: flex;
        flex-wrap: wrap;
        gap: 0.5rem 1rem;
    }

    .organization-card-links li {
        margin: 0;
    }

    .organization-card-links a {
        font-size: 11pt; /* Changed to 11pt */
        color: #3D6B34;
        text-decoration: none;
        transition: color 0.2s ease-in-out;
    }

    .organization-card-links a:hover {
        color: #10B981;
        text-decoration: underline;
    }
</style>

<div class="dashboard-grid">
    <section id="account-links-section" class="dashboard-section bg-gradient-to-tr from-green-100 to-lime-100">
        <h2 class="text-3xl font-bold text-green-700 mb-6 border-b-2 border-green-300 pb-3">
            My Account
        </h2>
        <div id="account-status" class="mb-4 text-gray-700">
            </div>
        <div class="mt-6 grid grid-cols-1 gap-4">

            <% showmembership =false 
            if showmembership =true then %>
            <a href="MembersRenewSubscription.asp" class="dashboard-link-card">
                <div class="dashboard-link-card-content">
                    <span class="dashboard-link-card-title">Renew / Upgrade Membership</span>
                    <a href="MembersRenewSubscription.asp" class="body">View Options</a>
                </div>
            </a>
            <% end if %>
            <% hidefavorite = true 
            if hidefavorite = false then %>
            <a href="/Members/MembersAssociations.asp" class="dashboard-link-card">
                <div class="dashboard-link-card-content">
                    <span class="dashboard-link-card-title">Favorite Association</span>
                    <a href="/Members/MembersAssociations.asp" class="body">Manage Favorite</a>
                </div>
            </a>
            <% end if %>
        </div>
    </section>

    <section id="companies-organizations-section" class="dashboard-section bg-gradient-to-tr from-green-100 to-lime-100">
        <h2 class="text-3xl font-bold text-green-700 mb-6 border-b-2 border-green-300 pb-3">
            Companies / Organizations
        </h2>
        <div class="mt-6 grid grid-cols-1 gap-4">
            <a href="CreateNewOrgAccount.asp" class="dashboard-link-card">
                <div class="dashboard-link-card-content">
                    <span class="dashboard-link-card-title">Add a New Organization</span>
                </div>
            </a>
            <a href="AdminOrgDelete.asp" class="dashboard-link-card">
                <div class="dashboard-link-card-content">
                    <span class="dashboard-link-card-title">Delete an Organization</span>
                </div>
            </a>
            
            <%
            sql = "SELECT * from businessaccess, business, businesstypelookup WHERE businessaccess.Businessid = business.businessid and Business.BusinessTYpeID = businesstypelookup.Businesstypeid and PeopleID =" & PeopleID & " order by BusinessTypeIDOrder "

            'response.write("sql=" & sql) ' Classic ASP remark
            Set rs = Server.CreateObject("ADODB.Recordset")
            rs.Open sql, conn, 3, 3
            while not rs.eof
                CurrentBusinessID = rs("BusinessID")
                CurrentBusinessTypeID = rs("BusinessTypeID")
                CurrentBusinessName = rs("BusinessName")
                Icon= "/icons/" & rs("BusinessTypeIcon") ' Icon variable is still present for ASP logic but not used in HTML
                BusinessType = rs("BusinessType")
                'response.write("CurrentBusinessTypeID=" & CurrentBusinessTypeID ) ' Classic ASP remark
            %>

            <div class="dashboard-link-card">
                <div class="organization-card-content">
                    <span class="dashboard-card-title"><%=CurrentBusinessName %></span>
                    <span class="text-gray-600"><%=BusinessType %> Account</span>
                    <div class="organization-card-links mt-2">
                        <ul class="flex flex-wrap gap-x-4 gap-y-1">
                            <li><a class="body" href="MembersOrgAccountContactsEdit.asp?BusinessID=<%=CurrentBusinessID %>">Manage Account</a></li>
                            <% if CurrentBusinessTypeID = 8 then %>
                                <li><a class="body" href="list_events.asp?BusinessID=<%=CurrentBusinessID %>">Events</a></li>
                                <li><a class="body" href="MembersAnimalAdd1.asp?BusinessID=<%=CurrentBusinessID %>">Add Livestock</a></li>
                                <li><a class="body" href="MembersAnimalshome.asp?BusinessID=<%=CurrentBusinessID %>">List of Livestock</a></li>
                                <% hide=true 
                                if hide =false then %>
                                <li><a class="body" href="MembersProduceInventory.asp?BusinessID=<%=CurrentBusinessID %>">Produce Inventory</a></li>
                                <li><a class="body" href="MembersSellerOrders.asp?BusinessID=<%=CurrentBusinessID %>">Orders</a></li>
                                <% end if %>
                            <% else %>
                                <li><a class="body" href="list_events.asp?BusinessID=<%=CurrentBusinessID %>">Events</a></li>
                            <% end if %>
                            <li><a href="AdminOrgDelete.asp?BusinessID=<%=CurrentBusinessID %>" class="text-red-600 hover:text-red-800">Delete</a></li>
                        </ul>
                    </div>
                </div>
            </div>
            
            <%
            rs.movenext
            wend
            rs.close
            %>
        </div>
    </section>
</div>

<script>
    // Mock Data (replace with your actual data fetching logic)
    const mockData = {
        currentUser: {
            isFirstTime: true, // Set to true to simulate first-time user
            subscriptionLevel: 4, // 0: Expired, 1: Basic, 4: Premium, 5: Vendor, 19: Lifetime
            custAIEndService: new Date(2026, 0, 15) // January 15, 2026 (Year, Month (0-11), Day)
        },
        subscriptionLevelNames: {
            0: { name: "Expired", color: "red" },
            1: { name: "Basic", color: "gray" },
            4: { name: "Premium", color: "blue" },
            5: { name: "Vendor", color: "purple" },
            19: { name: "Lifetime", color: "green" }
        },
        animals: [
            // Example animal data
            { fullName: "Babe", speciesID: 1, publishForSale: 1, publishStud: 0, lastUpdated: new Date(2025, 6, 10) },
            { fullName: "Wilbur", speciesID: 1, publishForSale: 0, publishStud: 1, lastUpdated: new Date(2025, 5, 20) },
            { fullName: "Shep", speciesID: 2, publishForSale: 1, publishStud: 1, lastUpdated: new Date(2025, 4, 15) }
        ],
        products: [
            // Example product data
            { prodName: "Organic Apples", prodCategoryId: 3, prodPrice: 3.99, prodQuantityAvailable: 50, prodForSale: 1 },
            { prodName: "Fresh Eggs (Dozen)", prodCategoryId: 4, prodPrice: 5.50, prodQuantityAvailable: 20, prodForSale: 1 },
            { prodName: "Homemade Jam", prodCategoryId: 5, prodPrice: 7.00, prodQuantityAvailable: 0, prodForSale: 0 }
        ],
        packages: [], // Example package data
        properties: [], // Example property data
        speciesMap: {
            1: "Pig",
            2: "Sheep",
            3: "Fruit",
            4: "Poultry",
            5: "Processed Food"
        }
    };

    // DOM elements (only relevant ones are kept for brevity)
    const accountStatusElement = document.getElementById('account-status');

    /**
     * Formats a date object to a localized date string (e.g., "M/D/YYYY").
     * @param {Date} date - The date object to format.
     * @returns {string} The formatted date string.
     */
    function formatDate(date) {
        if (!(date instanceof Date) || isNaN(date)) {
            return "Not Set";
        }
        return date.toLocaleDateString();
    }

    /**
     * Renders the account status section.
     */
    function renderAccountStatus() {
        const { subscriptionLevel, custAIEndService } = mockData.currentUser;
        const now = new Date();
        let statusHtml = '';
        
        // Check if subscription has expired
        if (subscriptionLevel === 0 || (custAIEndService && custAIEndService < now && subscriptionLevel !== 19)) {
            statusHtml += `
                <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded-md relative mb-4" role="alert">
                    <strong class="font-bold">Your Account Has Expired!</strong>
                    <span class="block sm:inline">Your products and animals are not currently appearing.</span>
                    <ul class="mt-2 list-disc list-inside">
                        <li>Renew your account by clicking the button below.</li>
                        <li>Republish your animals and products.</li>
                    </ul>
                </div>
            `;
        } else if (subscriptionLevel < 1 && custAIEndService > now) {
            statusHtml += `
                <div class="bg-blue-100 border border-blue-400 text-blue-700 px-4 py-3 rounded-md relative mb-4" role="alert">
                    <strong class="font-bold">Your Account is Not Currently Active!</strong>
                    <span class="block sm:inline">A payment for your account has not been processed yet. If you just signed up, your payment might take a little time to process.</span>
                </div>
            `;
        }

        const subLevelInfo = mockData.subscriptionLevelNames[subscriptionLevel] || { name: "Unknown", color: "gray" };

        statusHtml += `
            <p class="body">Membership Level: <b style="color:${subLevelInfo.color};">${subLevelInfo.name}</b></br>
            Membership Ends: <b>${formatDate(custAIEndService)}</b></p> 
            <p class="body"><a href="MembersAccountContactsEdit.asp#top" class="body">Manage Account</a></br>
            <a href="/members/MembersPasswordChange.asp?ID=<%=ID %>" class="body">Password</a></p>

        `;

        if (accountStatusElement) {
            accountStatusElement.innerHTML = statusHtml;
        }
    }

    // Initialize dashboard rendering on DOMContentLoaded
    document.addEventListener('DOMContentLoaded', () => {
        renderAccountStatus();
    });
</script>

<!--#Include virtual ="/Members/MembersFooter.asp"--> 
</body></html>