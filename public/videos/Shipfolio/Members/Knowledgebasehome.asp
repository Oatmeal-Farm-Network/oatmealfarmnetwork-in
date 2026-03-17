<%@LANGUAGE="VBScript"

%>
<!--#Include virtual="/members/Membersglobalvariables.asp"-->
<!--#include file="aspJSON1.19.asp"-->
<!--#Include virtual="/members/JSON.asp"-->


</head>
<body>
    <% 
Current1 = "MembersHome"
Current2="MembersHome" 
pagename = "Dashboard"%> 
<!--#Include virtual="/members/membersheader.asp"-->



<style>
  /* Dashboard Section */
  .dashboard-section {
      background-color: #fff;
      border-radius: 0.5rem;
      box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1),
                  0 4px 6px -2px rgba(0, 0, 0, 0.05);
      border: 1px solid #E5E7EB;
      padding: 1.5rem;
    }
  
    /* Dashboard Link Card */
    .dashboard-link-card {
      display: flex;
      flex-direction: row;
      align-items: center;
      padding: 0.5rem;
      background-color: #F9FAFB;
      border-radius: 0.375rem;
      box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1),
                  0 1px 2px 0 rgba(0, 0, 0, 0.06);
      transition: transform 0.2s ease-in-out,
                  box-shadow 0.2s ease-in-out,
                  background-color 0.2s ease-in-out;
      border: 1px solid #F3F4F6;
      text-align: left;
      width: 100%;
      text-decoration: none;
      margin-bottom: 1rem;
      font-size: 11pt;
      color: #3D6B34;
    }
  
    .dashboard-link-card:hover {
      transform: translateY(-3px);
      box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1),
                  0 4px 6px -2px rgba(0, 0, 0, 0.05);
      background-color: #E5E7EB;
    }
  
    .dashboard-link-card-content {
      display: flex;
      flex-direction: column;
      flex-grow: 1;
      text-align: left;
    }
  
    .dashboard-link-card-title {
      font-size: 11pt;
      font-weight: normal;
      color: #3D6B34;
      margin: 0;
      line-height: 1.2;
      text-decoration: none;
    }
  
    .dashboard-link-card span {
      font-weight: normal;
      color: #1F2937;
      font-size: 11pt;
    }
  
    /* Dashboard Table */
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
  
    /* Buttons */
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
  


  /* Custom CSS for the weather card */
  .weather-card {
    display: flex;
    flex-direction: column;
    height: 100%;
  }

  /* Reduces top margin on the main title */
  .weather-card h5 {
    margin-top: 0.5rem;
    margin-bottom: 0.5rem;
  }

  .weather-current-temp {
    font-size: 2rem;
  }

  .weather-icon {
    width: 3rem;
    height: 3rem;
  }

  .weather-details small {
    font-size: 0.8rem;
  }

  /* Adjustments for horizontal layout */
  .hourly-forecast-container {
    display: flex;
    flex-direction: row;
    overflow-x: auto;
    white-space: nowrap;
    margin-bottom: 0.5rem; /* Reduced bottom margin */
  }

  .hourly-item {
    display: flex;
    flex-direction: column;
    align-items: center;
    text-align: center;
    padding: 0.2rem; /* Reduced padding */
    flex: 0 0 auto;
  }

  .hourly-item-icon {
    width: 2.5rem;
    height: 2rem;
  }

  .hourly-item-temp,
  .hourly-item-time {
    font-size: 0.7rem;
  }

  .daily-forecast-container .row {
    flex-wrap: nowrap;
    overflow-x: auto;
    margin-top: 0.5rem; /* Added a small top margin */
  }

  .daily-item {
    display: flex;
    flex-direction: column;
    align-items: center;
    text-align: center;
    padding: 0.2rem; /* Reduced padding */
  }

  .daily-item-day {
    font-size: 0.7rem;
  }

  .daily-item-icon {
    width: 2rem;
    height: 2rem;
  }

  .daily-item-temps {
    font-size: 0.7rem;
  }
</style>

<% 

sql = "SELECT address.country_id,AddressCity, state_province.abbreviation AS State, country.Name AS Country FROM address, people, country, state_province where address.country_id = country.country_id and address.StateIndex = state_province.StateIndex and address.country_id = state_province.country_id and people.addressid = address.addressid and people.PeopleID = " & PeopleID
'response.write("sql=" & sql)

Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof then
tempcity = rs("AddressCity")
tempstate = rs("State")
tempcountry = rs("Country")
'response.write("tempcity=" & tempcity)
'response.write("tempstate=" & tempstate)
'response.write("tempcountry=" & tempcountry)
else
  tempcity = "Medford"
  tempstate = "OR"
  tempcountry = "USA"
end if



' --- Configuration ---

apiKey = "8cc8baea4a6f46b68d0213631252908" ' Your WeatherAPI.com key
city = tempcity
state = tempstate
country = tempcountry

' --- VBScript for API Calls ---


' WeatherAPI.com uses a single forecast endpoint for all data.
' The "days=7" parameter now gets current, 24-hour, and 7-day forecast data.
api_url = "https://api.weatherapi.com/v1/forecast.json?key=" & apiKey & _
"&q=" & city & "," & state & _
"&days=7&aqi=no&alerts=no"
responseText = getAPIResponse(api_url)

' --- JSON Parsing using the aspJSON1.19.asp library directly ---
Set oParser = New aspJSON
' Strip the outer array characters and process the inner object
If Left(responseText, 1) = "[" And Right(responseText, 1) = "]" Then
    responseText = Mid(responseText, 2, Len(responseText) - 2)
End If

oParser.loadJSON(responseText)
Set oData = oParser.data


' Function to make the HTTP request and return the response text
Function getAPIResponse(url)
    Dim objXMLHTTP
    Set objXMLHTTP = Server.CreateObject("MSXML2.XMLHTTP")
    
    objXMLHTTP.Open "GET", url, False
    objXMLHTTP.setRequestHeader "Content-Type", "application/json"
    objXMLHTTP.setRequestHeader "X-Api-Key", apiKey
    objXMLHTTP.Send
    
    getAPIResponse = objXMLHTTP.responseText
    Set objXMLHTTP = Nothing
End Function
rs.close
sql = "select COUNT(*) as count from associationmembers where PeopleID = " & PeopleID 
'response.write("sql=" & sql)
rs.Open sql, conn, 3, 3   
If Not rs.eof Then
 associationcount = rs("count")
end if
rs.close




%>

<div class="container">
  <div class="row">
    <div class="col-md-6 col-lg-6 dashboard-section bg-gradient-to-tr from-green-100 to-lime-100">
      <div >
    <div  class="mb-4 text-gray-700">
      <section id="companies-organizations-section" >
        <h2 class="text-3xl font-bold text-green-700 mb-6 border-b-2 border-green-300 pb-3">
            My Accounts 
        </h2>
        <div class="mt-6 grid grid-cols-1 gap-4">
            <a href="CreateNewOrgAccount.asp" class="dashboard-link-card">
                <div class="dashboard-link-card-content">
                    <span class="dashboard-link-card-title">Add a New Account</span>
                </div>
            </a>
            <a href="AdminOrgDelete.asp" class="dashboard-link-card">
                <div class="dashboard-link-card-content">
                    <span class="dashboard-link-card-title">Delete an Account</span>
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
                    <span class="dashboard-card-title"><b> <a href="AccountHome.asp?BusinessID=<%=CurrentBusinessID %>"><%=CurrentBusinessName %></a></b></span><br>
                    <span class="text-gray-600"><%=BusinessType %> Account</span>
                  
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
    <div class="mt-6 grid grid-cols-1  body">
    
    </div></div>
    </div>
    <div class="col-md-6 col-lg-6 dashboard-section bg-gradient-to-tr from-green-100 to-lime-100">
      <div > <% If IsObject(oData) And Not IsEmpty(oData) Then %>
        <div class="weather-card">
          <h5 class="mb-1 text-center">Weather for <%=City%>&nbsp;<%=State%>,&nbsp; <%=Country%></h5> 
          <div class="d-flex align-items-center justify-content-between mb-1"> 
            <div class="d-flex align-items-center">
              <span class="weather-current-temp me-1"><%=Int(oData("current")("temp_f"))%>&deg;F</span>
              <img src="https://<%=Mid(oData("current")("condition")("icon"), 3)%>" alt="Weather icon" class="weather-icon me-1">
              <div class="weather-details">
                <small class="d-block"><%=oData("current")("condition")("text")%></small>
                <small class="d-block">H:&nbsp<%=Int(oData("forecast")("forecastday")(0)("day")("maxtemp_f"))%>&deg;F | L:&nbsp <%=Int(oData("forecast")("forecastday")(0)("day")("mintemp_f"))%>&deg;F</small>
              </div>
            </div>
            <div class="text-end"><br><br>
              <small class="d-block">Feels like: <%=Int(oData("current")("feelslike_f"))%>&deg;F</small>
              <small class="d-block">Wind: <%=Int(oData("current")("wind_mph"))%> mph</small>
              <small class="d-block">Humidity: <%=oData("current")("humidity")%>%</small>
            </div>
          </div>
          <hr class="my-1"> <div class="hourly-forecast-container">
            <%
            Dim hourly_items
            Set hourly_items = oData("forecast")("forecastday")(0)("hour")
            If IsObject(hourly_items) Then
              current_dt_text = oData("current")("last_updated")
              current_hour = Hour(CDate(current_dt_text))
              For i = 0 To 23 Step 3
                hourIndex = (current_hour + i) Mod 24
                Set hourlyItem = hourly_items(hourIndex)
                forecastTime = hourlyItem("time")
                formattedTime = ""
                If Hour(CDate(forecastTime)) = 0 Then
                  formattedTime = "12a"
                ElseIf Hour(CDate(forecastTime)) >= 1 And Hour(CDate(forecastTime)) <= 11 Then
                  formattedTime = Hour(CDate(forecastTime)) & "am"
                ElseIf Hour(CDate(forecastTime)) = 12 Then
                  formattedTime = "Noon"
                Else
                  formattedTime = (Hour(CDate(forecastTime)) - 12) & "pm"
                End If
            %>
            <div class="hourly-item">
              <span class="hourly-item-time"><%=formattedTime%></span>
              <img src="https://<%=Mid(hourlyItem("condition")("icon"), 3)%>" alt="Weather icon" class="hourly-item-icon">
              <span class="hourly-item-temp"><%=Int(hourlyItem("temp_f"))%>&deg;F</span>
            </div>
            <%
              Next
            End If
            %>
          </div>

          <hr class="my-1"> <div class="daily-forecast-container">
            <div class="row g-0 flex-nowrap overflow-x-auto">
              <%
              Dim forecast_items
              Set forecast_items = oData("forecast")("forecastday")
              For i = 0 To forecast_items.Count - 1
                Set day_forecast = forecast_items(i)
              %>
              <div class="col daily-item">
                <span class="daily-item-day"><%=WeekdayName(Weekday(day_forecast("date")))%></span>
                <img src="https://<%=Mid(day_forecast("day")("condition")("icon"), 3)%>" alt="Weather icon" class="daily-item-icon">
                <div class="daily-item-temps">
                  <span class="daily-item-high">H:&nbsp;<%=Int(day_forecast("day")("maxtemp_f"))%>&deg;F</span><br>
                  <span class="daily-item-low">L:&nbsp;<%=Int(day_forecast("day")("mintemp_f"))%>&deg;F</span>
                </div>
              </div>
              <%
              Next
              %>
            </div>
          </div>
        </div>
        <% Else %>
        <div class="alert alert-danger" role="alert">
          An error occurred with the WeatherAPI request. Please check your API key.
        </div>
        <% End If %>
      </div>
    </div>
 


  </div>
</div>



        <script>
          
        
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
        
                statusHtml += ` `;
        
                if (accountStatusElement) {
                    accountStatusElement.innerHTML = statusHtml;
                }
            }
        
            // Initialize dashboard rendering on DOMContentLoaded
            document.addEventListener('DOMContentLoaded', () => {
                renderAccountStatus();
            });
        </script>


<!--#Include virtual="/members/membersfooter.asp"-->
</body>
</html>