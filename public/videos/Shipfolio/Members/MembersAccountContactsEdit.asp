<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Account Summary</title>
    <style>
        /* Custom font for a clean look */
        body {
            font-family: "Inter", sans-serif;
            margin: 0;
            background-color: #f3f4f6; /* bg-gray-100 */
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        /* Header Styling (Placeholder) */
        header {
            background-color: #ffffff; /* bg-white */
            box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1), 0 1px 2px 0 rgba(0, 0, 0, 0.06); /* shadow */
            padding: 1rem; /* p-4 */
        }
        .header-container {
            max-width: 1280px; /* container mx-auto */
            margin-left: auto;
            margin-right: auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .header-title {
            font-size: 1.5rem; /* text-2xl */
            font-weight: bold;
            color: #1f2937; /* text-gray-800 */
        }
        .header-nav ul {
            display: flex;
            list-style: none;
            padding: 0;
            margin: 0;
            gap: 1rem; /* space-x-4 */
        }
        .header-nav a {
            color: #2563eb; /* text-blue-600 */
            text-decoration: none;
        }
        .header-nav a:hover {
            color: #1e40af; /* hover:text-blue-800 */
        }

        /* Main Content Container */
        .main-content-container {
            max-width: 1280px; /* container mx-auto */
            margin-left: auto;
            margin-right: auto;
            padding: 1rem; /* p-4 */
            flex-grow: 1;
        }

        /* Account Navigation (Jump Links) */
        .account-nav-card {
            background-color: #ffffff; /* bg-white */
            border-radius: 0.5rem; /* rounded-lg */
            box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1), 0 1px 2px 0 rgba(0, 0, 0, 0.06); /* shadow */
            padding: 1rem; /* p-4 */
            margin-bottom: 1.5rem; /* mb-6 */
        }
        .account-nav-card h2 {
            font-size: 1.25rem; /* text-xl */
            font-weight: 600; /* font-semibold */
            color: #374151; /* text-gray-700 */
            margin-bottom: 0.5rem; /* mb-2 */
        }
        .account-nav-card ul {
            display: flex;
            flex-wrap: wrap;
            list-style: none;
            padding: 0;
            margin: 0;
            column-gap: 1rem; /* gap-x-4 */
            row-gap: 0.5rem; /* gap-y-2 */
            color: #2563eb; /* text-blue-600 */
        }
        .account-nav-card a:hover {
            text-decoration: underline;
        }

        /* Main Form Card */
        .form-card {
            background-color: #ffffff; /* bg-white */
            border-radius: 0.5rem; /* rounded-lg */
            box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1), 0 1px 2px 0 rgba(0, 0, 0, 0.06); /* shadow */
            padding: 1.5rem; /* p-6 */
        }
        .form-card h1 {
            font-size: 1.875rem; /* text-3xl */
            font-weight: bold;
            color: #1f2937; /* text-gray-800 */
            margin-bottom: 1.5rem; /* mb-6 */
        }

        /* Success Message */
        .success-message {
            display: none; /* hidden */
            background-color: #d1fae5; /* bg-green-100 */
            border: 1px solid #34d399; /* border-green-400 */
            color: #065f46; /* text-green-700 */
            padding: 1rem; /* px-4 py-3 */
            border-radius: 0.375rem; /* rounded-md */
            margin-bottom: 1rem; /* mb-4 */
        }
        .success-message strong {
            font-weight: bold;
        }
        .success-message span {
            display: block;
        }
        @media (min-width: 640px) { /* sm */
            .success-message span {
                display: inline;
            }
        }

        /* Error Message */
        .error-message {
            display: none; /* hidden */
            background-color: #fee2e2; /* bg-red-100 */
            border: 1px solid #ef4444; /* border-red-500 */
            color: #b91c1c; /* text-red-700 */
            padding: 1rem; /* px-4 py-3 */
            border-radius: 0.375rem; /* rounded-md */
            margin-bottom: 1rem; /* mb-4 */
        }
        .error-message strong {
            font-weight: bold;
        }
        .error-message span {
            display: block;
        }
        @media (min-width: 640px) { /* sm */
            .error-message span {
                display: inline;
            }
        }


        /* Form Layout */
        .form-section {
            display: grid;
            grid-template-columns: 1fr; /* grid-cols-1 */
            gap: 1.5rem 2rem; /* gap-x-8 gap-y-6 */
        }
        @media (min-width: 768px) { /* md */
            .form-section {
                grid-template-columns: repeat(2, 1fr); /* md:grid-cols-2 */
            }
        }

        /* Form Field Styling */
        .form-field-group {
            margin-bottom: 1rem; /* mb-4 */
        }
        .form-label {
            display: block;
            color: #374151; /* text-gray-700 */
            font-size: 0.875rem; /* text-sm */
            font-weight: bold;
            margin-bottom: 0.5rem; /* mb-2 */
        }
        .form-input, .form-select {
            width: 100%; /* w-full */
            padding: 0.5rem; /* p-2 */
            border: 1px solid #d1d5db; /* border border-gray-300 */
            border-radius: 0.375rem; /* rounded-md */
            box-shadow: 0 1px 2px 0 rgba(0, 0, 0, 0.05); /* shadow-sm */
            text-align: left; /* Ensure left alignment */
        }
        .form-input:focus, .form-select:focus {
            outline: none;
            border-color: #3b82f6; /* focus:border-blue-500 */
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.5); /* focus:ring-blue-500 focus:ring-opacity-75 */
        }
        .text-red-500 {
            color: #ef4444;
        }
        .text-gray-500 {
            color: #6b7280;
        }
        .text-gray-900 {
            color: #111827;
        }
        .text-lg {
            font-size: 1.125rem;
        }
        .font-medium {
            font-weight: 500;
        }
        .bg-gray-50 {
            background-color: #f9fafb;
        }
        .cursor-not-allowed {
            cursor: not-allowed;
        }

        /* Button Styling */
        .btn-primary {
            padding: 0.75rem 1.5rem; /* px-6 py-3 */
            background-color: #2563eb; /* bg-blue-600 */
            color: #ffffff; /* text-white */
            font-weight: 600; /* font-semibold */
            border-radius: 0.5rem; /* rounded-lg */
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06); /* shadow-md */
            transition: background-color 150ms ease-in-out;
            border: none;
            cursor: pointer;
        }
        .btn-primary:hover {
            background-color: #1d4ed8; /* hover:bg-blue-700 */
        }
        .btn-primary:focus {
            outline: none;
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.5); /* focus:ring-2 focus:ring-blue-500 focus:ring-opacity-75 */
        }
        .flex-center {
            display: flex;
            justify-content: center;
            margin-top: 2rem; /* mt-8 */
        }

        /* Image and Social Media Styling */
        .logo-container, .social-media-container {
            margin-bottom: 1rem; /* mb-4 */
        }
        .logo-img {
            max-width: 100%; /* Ensure it fits container */
            height: auto; /* Maintain aspect ratio */
            max-height: 8rem; /* Limit height */
            object-fit: contain;
            border-radius: 0.375rem; /* rounded-md */
            border: 1px solid #e5e7eb; /* border border-gray-200 */
            padding: 0.25rem; /* p-1 */
            display: block; /* Remove extra space below image */
            margin-top: 0.5rem; /* Space from label */
        }
        .social-links {
            display: flex;
            flex-direction: column;
            gap: 0.5rem; /* space-y-2 */
        }
        .social-links a {
            color: #2563eb; /* text-blue-600 */
            text-decoration: none;
            display: block;
        }
        .social-links a:hover {
            text-decoration: underline;
        }
        .hidden {
            display: none;
        }

        /* Footer Styling */
        footer {
            background-color: #ffffff; /* bg-white */
            box-shadow: 0 -1px 3px 0 rgba(0, 0, 0, 0.1), 0 -1px 2px 0 rgba(0, 0, 0, 0.06); /* shadow */
            padding: 1rem; /* p-4 */
            margin-top: 2rem; /* mt-8 */
        }
        .footer-container {
            max-width: 1280px; /* container mx-auto */
            margin-left: auto;
            margin-right: auto;
            text-align: center;
            color: #4b5563; /* text-gray-600 */
        }
    </style>
</head>
<body class="bg-gray-100 min-h-screen flex flex-col">

    <% MasterDashboard= True 
    BladeSection = "users"
    Pagename = "user"%>
    <!--#Include virtual="/Members/Membersglobalvariables.asp"-->
    
    <% 
        If IsEmpty(PeopleID) Then PeopleID = Request.QueryString("PeopleID") ' Fallback if not set globally

        Preferedspecies = "" : country_id = "" : StateIndex = "" : PreferedBreed = "" : SubscriptionLevel = ""
        PeopleEmail = "" : PeopleFirstName = "" : PeopleLastName = "" : PeoplePhone = "" : AddressApt = ""
        AddressCity = "" : AddressZip = "" : AddressStreet = "" : WebsitesID = "" : PeopleCell = ""
        PeopleFax = "" : Logo = "" : Owners = "" : BusinessName = "" : BusinessLogo = "" : BusinessID = ""
        BusinessFacebook = "" : BusinessX = "" : BusinessInstagram = "" : BusinessPinterest = ""
        BusinessTruthSocial = "" : BusinessBlog = "" : BusinessYouTube = "" : BusinessOtherSocial1 = ""
        BusinessOtherSocial2 = "" : AddressCountry = "" : AddressState = "" : PeopleWebsite = ""

        ' Fetch People and Address Data
        If Not IsEmpty(PeopleID) And IsNumeric(PeopleID) Then
            sql = "SELECT People.*, Address.* FROM People JOIN Address ON People.AddressID = Address.AddressID WHERE People.PeopleID = " & PeopleID
            Set rs = Server.CreateObject("ADODB.Recordset")
            rs.Open sql, conn, 3, 3 ' adOpenStatic, adLockOptimistic
            
            If Not rs.EOF Then 
                Preferedspecies = rs("Preferedspecies") 
                country_id = rs("country_id")
                StateIndex = rs("StateIndex")

                Dim PreferedspeciesName ' Declare here
                Select Case Preferedspecies
                    Case 2 : PreferedspeciesName = "Alpacas" 
                    Case 3 : PreferedspeciesName = "Dogs"
                    Case 4 : PreferedspeciesName = "Llamas"
                    Case 5 : PreferedspeciesName = "Horses"
                    Case 6 : PreferedspeciesName = "Goats"
                    Case 7 : PreferedspeciesName = "Donkeys (includes Mules & Hinnies)"
                    Case 8 : PreferedspeciesName = "Cattle"
                    Case 9 : PreferedspeciesName = "Bison"
                    Case 10 : PreferedspeciesName = "Sheep"
                    Case 11 : PreferedspeciesName = "Rabbits"
                    Case 12 : PreferedspeciesName = "Pigs"
                    Case 13 : PreferedspeciesName = "Chickens"
                    Case 14 : PreferedspeciesName = "Turkeys"
                    Case 15 : PreferedspeciesName = "Ducks (and other Fowl)"
                    Case 16 : PreferedspeciesName = "Cats"
                    Case 17 : PreferedspeciesName = "Yaks"
                    Case 18 : PreferedspeciesName = "Camels"
                    Case 19 : PreferedspeciesName = "Emus"
                    Case 20 : PreferedspeciesName = "Elks"
                    Case 21 : PreferedspeciesName = "Deer"
                    Case 22 : PreferedspeciesName = "Geese"
                    Case Else : PreferedspeciesName = "" ' Default if not matched
                End Select

                PreferedBreed = rs("PreferedBreed") 
                SubscriptionLevel = rs("SubscriptionLevel") 
                UserName = rs("UserName")
                PeopleEmail = rs("PeopleEmail")
                PeopleFirstName = rs("PeopleFirstName")
                PeopleLastName = rs("PeopleLastName")
                PeoplePhone = rs("PeoplePhone")
                AddressApt = rs("AddressApt")
                AddressCity = rs("AddressCity")
                AddressZip = rs("AddressZip")
                AddressStreet = rs("AddressStreet")
                  PeopleCell = rs("PeopleCell")
                PeopleFax = rs("PeopleFax")
                Logo = rs("Logo")
                
                ' Original logo replacement logic
                Dim str1, str2
                str1 = LCase(Logo) 
                str2 = "http://www.alpacainfinity.com"
                If InStr(str1, str2) > 0 Then
                    Logo = Replace(str1, str2 , "http://www.livestockofamerica.com")
                End If 
                
                Owners = rs("Owners")
                rs.Close
            End If
        End If

        ' Fetch Country Name
        If Len(country_id) > 0 Then 
            sql = "SELECT name FROM country WHERE country_id = " & country_id
            Set rs = Server.CreateObject("ADODB.Recordset")
            rs.Open sql, conn, 3, 3 
            If Not rs.EOF Then 
                AddressCountry = rs("name")
            End If
            rs.Close
        End If

        ' Fetch State/Province Name
        If Len(StateIndex) > 0 Then 
            sql = "SELECT name FROM state_province WHERE StateIndex = " & StateIndex
            Set rs = Server.CreateObject("ADODB.Recordset")
            rs.Open sql, conn, 3, 3 
            If Not rs.EOF Then 
                AddressState = rs("name")
            End If
            rs.Close
        End If


    %>

    <!--#Include file="MembersHeader.asp"-->

    <div class="main-content-container">


        <div class="form-card">
            <h1>My Profile</h1>

            <!-- Success Message Display -->
            <div id="successMessage" class="success-message" role="alert">
                <strong>Success!</strong>
                <span>Your changes have been made.</span>
            </div>

            <!-- Error Message Display -->
            <div id="errorMessage" class="error-message" role="alert">
                <strong>Error!</strong>
                <span id="errorMessageText">An unexpected error occurred. Please try again.</span>
            </div>

            <form id="accountForm" method="post" action="membersContactsUpdateAccount.asp?PeopleID=<%=PeopleID%>">
                <!-- Two-column layout for medium and larger screens -->
                <div class="form-section">
                  
                    <!-- Left Column -->
                    <div>
                        <div class="form-field-group">
                            User Account ID: <%=PeopleID%>
                        </div>

                      <div class="form-field-group">
                        <label for="UserName" class="form-label">User Name<span class="text-red-500">*</span></label>
                        <input type="text" id=UserName" name="UserName" value="<%=UserName%>" required class="form-input">
                    </div>


                        <div class="form-field-group">
                            <label for="PeopleFirstName" class="form-label">First Name<span class="text-red-500">*</span></label>
                            <input type="text" id="PeopleFirstName" name="PeopleFirstName" value="<%=PeopleFirstName%>" required class="form-input">
                        </div>

                        <div class="form-field-group">
                            <label for="PeopleLastName" class="form-label">Last Name<span class="text-red-500">*</span></label>
                            <input type="text" id="PeopleLastName" name="PeopleLastName" value="<%=PeopleLastName%>" required class="form-input">
                        </div>

                        <div class="form-field-group">
                            <label for="AddressStreet" class="form-label">Street <span class="text-gray-500">(Optional)</span></label>
                            <input type="text" id="AddressStreet" name="AddressStreet" value="<%=AddressStreet%>" class="form-input">
                        </div>

                        <div class="form-field-group">
                            <label for="AddressApt" class="form-label">Street 2 <span class="text-gray-500">(Optional)</span></label>
                            <input type="text" id="AddressApt" name="AddressApt" value="<%=AddressApt%>" class="form-input">
                        </div>

                        <div class="form-field-group">
                            <label for="AddressCity" class="form-label">City <span class="text-gray-500">(Optional)</span></label>
                            <input type="text" id="AddressCity" name="AddressCity" value="<%=AddressCity%>" class="form-input">
                        </div>

                        <div class="form-field-group">
                            <label for="country_id" class="form-label">Country<span class="text-red-500">*</span></label>
                            <select id="country_id" name="country_id" required class="form-select">
                                <% 
                                ' Populate Country dropdown using ASP
                                Set rs = Server.CreateObject("ADODB.Recordset")
                                sql = "SELECT country_id, name FROM country WHERE active = 1 ORDER BY name"
                                rs.Open sql, conn, 3, 3 
                                Response.Write "<option value=''>Select...</option>"
                                Do While Not rs.EOF
                                    Dim selectedCountry
                                    selectedCountry = ""
                                    If CStr(rs("country_id")) = CStr(country_id) Then selectedCountry = " selected"
                                    Response.Write "<option value=""" & rs("country_id") & """" & selectedCountry & ">" & rs("name") & "</option>"
                                    rs.MoveNext
                                Loop
                                rs.Close
                                %>
                            </select>
                        </div>

                        <div class="form-field-group">
                            <label for="StateIndex" id="stateProvinceLabel" class="form-label">
                                <% If CStr(country_id) = "1228" Then %>State<% Else %>Province<% End If %> <span class="text-gray-500">(Optional)</span>
                            </label>
                            <select id="StateIndex" name="StateIndex" class="form-select">
                                <% 
                                ' Populate State/Province dropdown using ASP based on current country_id
                                ' This will be replaced by AJAX on change. Initial load is from server.
                                If Len(country_id) > 0 Then
                                    Set rs = Server.CreateObject("ADODB.Recordset")
                                    sql = "SELECT StateIndex, name FROM state_province WHERE country_id = " & country_id & " ORDER BY name"
                                    rs.Open sql, conn, 3, 3 
                                    Response.Write "<option value=''>Select...</option>"
                                    Do While Not rs.EOF
                                        Dim selectedState
                                        selectedState = ""
                                        If CStr(rs("StateIndex")) = CStr(StateIndex) Then selectedState = " selected"
                                        Response.Write "<option value=""" & rs("StateIndex") & """" & selectedState & ">" & rs("name") & "</option>"
                                        rs.MoveNext
                                    Loop
                                    rs.Close
                                End If
                                %>
                            </select>
                        </div>

                        <div class="form-field-group">
                            <label for="AddressZip" class="form-label">Postal Code <span class="text-gray-500">(Optional)</span></label>
                            <input type="text" id="AddressZip" name="AddressZip" value="<%=AddressZip%>" class="form-input">
                        </div>
           </div>
           <div>
                        <div class="form-field-group">
                            <label for="PeopleEmail" class="form-label">Email<span class="text-red-500">*</span></label>
                            <input type="email" id="PeopleEmail" name="PeopleEmail" value="<%=PeopleEmail%>" required class="form-input">
                        </div>

                        <div class="form-field-group">
                            <label for="PeoplePhone" class="form-label">Phone <span class="text-gray-500">(Optional)</span></label>
                            <input type="tel" id="PeoplePhone" name="PeoplePhone" value="<%=PeoplePhone%>" class="form-input">
                        </div>

                        <div class="form-field-group">
                            <label for="PeopleCell" class="form-label">Cell <span class="text-gray-500">(Optional)</span></label>
                            <input type="tel" id="PeopleCell" name="PeopleCell" value="<%=PeopleCell%>" class="form-input">
                        </div>



                      
                      </div>

                      <!-- Right Column -->
                      <div>

                     

                      </div>
                </div>

                <!-- Hidden inputs for form submission -->
                <input name="ReturnPage" value="membersAccountContactsEdit3.asp?changesmade=True" type="hidden">
                <input name="PeopleID" type="hidden" value="<%=PeopleID%>">
                <input name="EventID" type="hidden" value="<%=EventID%>">

                <div class="flex-center">
                    <button type="submit" class="regsubmit2">Update</button>
                </div>
            </form>
        </div>
    </div>

  

    <script>
        // Function to update state/province dropdown based on selected country
        function updateStatesProvinces() {
            const countrySelect = document.getElementById('country_id');
            const stateSelect = document.getElementById('StateIndex');
            const stateProvinceLabel = document.getElementById('stateProvinceLabel');
            const selectedCountryId = countrySelect.value;

            // Update label text based on country (assuming 1228 is USA)
            if (selectedCountryId === "1228") {
                stateProvinceLabel.innerHTML = 'State <span class="text-gray-500">(Optional)</span>';
            } else {
                stateProvinceLabel.innerHTML = 'Province <span class="text-gray-500">(Optional)</span>';
            }

            // Make AJAX call to getstates.asp to fetch new states/provinces
            if (selectedCountryId) { // Only fetch if a country is selected
                fetch(`getstates.asp?country_id=${selectedCountryId}`)
                    .then(response => {
                        if (!response.ok) {
                            throw new Error('Network response was not ok ' + response.statusText);
                        }
                        return response.text();
                    })
                    .then(html => {
                        stateSelect.innerHTML = html; // Populate the dropdown with new options
                    })
                    .catch(error => {
                        console.error('Error fetching states:', error);
                        stateSelect.innerHTML = '<option value="">Error loading states</option>'; // Display error
                    });
            } else {
                stateSelect.innerHTML = '<option value="">Select...</option>'; // Clear if no country selected
            }
        }

        // Function to preview the logo image
        function updateLogoPreview() {
            const logoInput = document.getElementById('BusinessLogoInput');
            const logoPreview = document.getElementById('BusinessLogoPreview');
            const logoDisplayContainer = document.getElementById('logoDisplayContainer');

            if (logoInput.value) {
                logoPreview.src = logoInput.value;
                logoDisplayContainer.classList.remove('hidden');
            } else {
                logoPreview.src = ''; // Clear src if input is empty
                logoDisplayContainer.classList.add('hidden');
            }
        }


        // Event Listeners
        document.addEventListener('DOMContentLoaded', () => {
            // Add event listener for country change to update states/provinces dropdown
            document.getElementById('country_id').addEventListener('change', updateStatesProvinces);

            // Add event listener for logo input changes to update preview
            document.getElementById('BusinessLogoInput').addEventListener('input', updateLogoPreview);

            // Handle success/error messages on page load
            const urlParams = new URLSearchParams(window.location.search);
            const successMessageDiv = document.getElementById('successMessage');
            const errorMessageDiv = document.getElementById('errorMessage');
            const errorMessageTextSpan = document.getElementById('errorMessageText');

            if (urlParams.get('changesmade') === 'True') {
                successMessageDiv.style.display = 'block';
                // Remove query parameter and hide message after a delay
                setTimeout(() => {
                    const newUrl = window.location.protocol + "//" + window.location.host + window.location.pathname;
                    window.history.pushState({ path: newUrl }, '', newUrl);
                    successMessageDiv.style.display = 'none';
                }, 3000);
            } else if (urlParams.get('error') === 'True') {
                errorMessageDiv.style.display = 'block';
                const errorMessage = urlParams.get('message');
                if (errorMessage) {
                    errorMessageTextSpan.textContent = decodeURIComponent(errorMessage);
                }
                // Remove query parameter and hide message after a delay
                setTimeout(() => {
                    const newUrl = window.location.protocol + "//" + window.location.host + window.location.pathname;
                    window.history.pushState({ path: newUrl }, '', newUrl);
                    errorMessageDiv.style.display = 'none';
                }, 5000); // Longer display for errors
            }
        });
    </script>
        <!--#Include file="MembersFooter.asp"-->
</body>
</html>