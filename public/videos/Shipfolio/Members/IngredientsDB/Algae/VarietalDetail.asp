<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!--#Include virtual="/includefiles/globalvariables.asp"-->
<%
' --- ASP Setup ---
' Assuming conn object is available globally or established here
' Set conn = Server.CreateObject("ADODB.Connection")
' conn.Open "Your_Connection_String_Here" ' Replace with your actual connection string

Dim PlantVarietyID, PlantVarietyName, PlantVarietyDescription
PlantVarietyID = Request.QueryString("PlantVarietyID")

' Initialize variables for metadata
PlantVarietyName = "Varietal Details" ' Default
PlantVarietyDescription = "Detailed information for a plant varietal." ' Default

If IsEmpty(PlantVarietyID) Or IsNull(PlantVarietyID) Or PlantVarietyID = "" Then
    ' Handle error: PlantVarietyID is missing
    Response.Write("<title>Error - Varietal Not Found</title>")
    Response.Write("<meta name='description' content='Plant Varietal ID is missing.'/>")
    Response.Write("</head><body><div class='container-fluid body text-center'><h1>Error: Plant Varietal ID is missing.</h1><p>Please go back and select a valid varietal.</p></div></body></html>")
    Response.End
End If

' --- Fetch Varietal Details and Related Lookup Data ---
Dim rsVarietalDetail, sqlVarietalDetail
sqlVarietalDetail = "SELECT PV.PlantVarietyName, PV.PlantVarietyDescription, P.PlantName, PV.PlantvarietyImage, " & _
                    "ST.SoilTexture, ST.Description AS SoilTextureDescription, " & _
                    "PH.PHRange, PH.Description AS PHRangeDescription, " & _
                    "OM.OrganicMatterContent, OM.Description AS OMDescription, OM.ImportanceToSoilAndPlants AS OMImportance, " & _
                    "SL.SalinityLevel, SL.Classification AS SalinityClassification, SL.Description AS SalinityDescription, SL.ImpactOnPlants AS SalinityImpact, " & _
                    "PHZ.Zone, PHZ.TemperatureStartRange, PHZ.TemperatureEndRange, " & _
                    "H.Classification AS HumidityClassification, H.Description AS HumidityDescription, H.ImpactOnPlants AS HumidityImpact, " & _
                    "PV.WaterRequirementMin, PV.WaterRequirementMax, " & _
                    "NL_Primary.Nutrient AS PrimaryNutrientName, NL_Primary.Description AS PrimaryNutrientDescription, NL_Primary.ImportanceToPlants AS PrimaryNutrientImportance " & _
                    "FROM PlantVariety PV " & _
                    "LEFT JOIN Plant P ON PV.PlantID = P.PlantID " & _
                    "LEFT JOIN SoilTextureLookup ST ON PV.SoilTextureID = ST.SoilTextureID " & _
                    "LEFT JOIN PHRangeLookup PH ON PV.PHRangeID = PH.PHRangeID " & _
                    "LEFT JOIN OrganicMatterLookup OM ON PV.OrganicMatterID = OM.OrganicMatterID " & _
                    "LEFT JOIN SalinityLookup SL ON PV.SalinityLevelID = SL.SalinityLevelID " & _
                    "LEFT JOIN PlantHardinessZoneLookup PHZ ON PV.ZoneID = PHZ.ZoneID " & _
                    "LEFT JOIN HumidityLookup H ON PV.HumidityID = H.HumidityID " & _
                    "LEFT JOIN NutrientLookup NL_Primary ON PV.PlantNutrientID = NL_Primary.NutrientID " & _
                    "WHERE PV.PlantVarietyID = " & PlantVarietyID

Set rsVarietalDetail = Server.CreateObject("ADODB.Recordset")
rsVarietalDetail.Open sqlVarietalDetail, conn, 3, 3 ' adOpenStatic, adLockOptimistic

If Not rsVarietalDetail.EOF Then
    PlantVarietyName = rsVarietalDetail("PlantVarietyName")
    PlantVarietyDescription = rsVarietalDetail("PlantVarietyDescription")
Else
    ' If varietal not found, redirect or show error
    Response.Write("<title>Varietal Not Found</title>")
    Response.Write("<meta name='description' content='The requested plant varietal was not found.'/>")
    Response.Write("</head><body><div class='container-fluid body text-center'><h1>Error: Varietal Not Found.</h1></div></body></html>")
    Response.End
End If

' Note: currenturl and WebSiteName are assumed to be defined globally or in Header.asp
' Example placeholder values if not defined:
' Dim currenturl, WebSiteName
' currenturl = Request.ServerVariables("URL")
' WebSiteName = "My Plant Wiki"
%>
<title><%=WebSiteName %> | <%=PlantVarietyName %></title>
<meta name="title" content="<%=WebSiteName %> | <%=PlantVarietyName %>"/>
<meta name="description" content="<%=PlantVarietyDescription %> - Detailed information on <%=PlantVarietyName %> varietal, including growing conditions, and nutrient requirements."/>
<meta name="keywords" content="<%=PlantVarietyName %>, <%=PlantVarietyName %> varietal, plant details, growing conditions, plant nutrients, <%=WebSiteName %>"/>

<link rel="canonical" href="<%=currenturl %>" />
<meta name="revisit-after" content="7 Days"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>

<style>
    body {
        font-family: sans-serif;
        background-color: #f3f4f6;
        -webkit-font-smoothing: antialiased;
        -moz-osx-font-smoothing: grayscale;
    }
    .container-fluid {
        width: 100%;
        margin-left: auto;
        margin-right: auto;
        padding-left: 1rem;
        padding-right: 1rem;
    }
    .container {
        width: 100%;
        margin-left: auto;
        margin-right: auto;
        max-width: 1400px;
    }
    .body {
        padding: 1rem;
    }
    h1, h2, h3, h4 {
        color: #1f2937;
        font-weight: bold;
        margin-bottom: 1rem;
    }
    h1 { font-size: 2.25rem; }
    h2 { font-size: 1.75rem; border-bottom: 2px solid #e5e7eb; padding-bottom: 0.5rem; margin-top: 2rem; }
    h3 { font-size: 1.25rem; margin-top: 1.5rem; margin-bottom: 0.75rem; }
    h4 { font-size: 1.1rem; margin-top: 1rem; margin-bottom: 0.5rem; }

    p {
        margin-bottom: 1rem;
        color: #374151;
        line-height: 1.6;
    }
    .row {
        display: flex;
        flex-wrap: wrap;
        margin-left: -0.75rem;
        margin-right: -0.75rem;
    }
    .col-12, .col-md-6, .col-lg-4 {
        padding-left: 0.75rem;
        padding-right: 0.75rem;
        box-sizing: border-box;
        margin-bottom: 1.5rem;
    }
    @media (min-width: 768px) {
        .col-md-6 { width: 50%; }
    }
    @media (min-width: 992px) {
        .col-lg-4 { width: 33.333%; }
    }

    .text-left { text-align: left; }
    .text-center { text-align: center; }

    a.body {
        color: #3b82f6;
        text-decoration: none;
        font-weight: bold;
    }
    a.body:hover {
        text-decoration: underline;
    }
    .detail-section {
        background-color: #fff;
        border: 1px solid #e5e7eb;
        border-radius: 0.5rem;
        padding: 1.5rem;
        box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1), 0 1px 2px 0 rgba(0, 0, 0, 0.06);
        margin-bottom: 1.5rem;
    }
    .detail-list {
        list-style: none;
        padding: 0;
        margin: 0;
    }
    .detail-list li {
        margin-bottom: 0.5rem;
        color: #374151;
        font-size: 0.95rem;
    }
    .detail-list li strong {
        color: #1f2937;
        margin-right: 0.5rem;
    }
    .nutrient-list {
        list-style: disc;
        padding-left: 1.5rem;
        margin-top: 0.5rem;
    }
    .nutrient-item {
        margin-bottom: 0.5rem;
        color: #374151;
        font-size: 0.95rem;
        text-align: left;
    }
    .nutrient-item strong {
        color: #1f2937;
    }
    .nutrient-description {
        font-size: 0.85rem;
        color: #6b7280;
        margin-left: 1.5rem;
        display: block;
    }
</style>
<%
' --- ASP Setup ---
' Assuming conn object is available globally or established here
' Set conn = Server.CreateObject("ADODB.Connection")
' conn.Open "Your_Connection_String_Here" ' Replace with your actual connection string


PlantVarietyID = Request.QueryString("PlantVarietyID")

' Initialize variables for metadata
PlantVarietyName = "Varietal Details" ' Default
PlantVarietyDescription = "Explore various plant varietals." ' Default
PlantVarietyImage = "" ' Default

If IsEmpty(PlantVarietyID) Or IsNull(PlantVarietyID) Or PlantVarietyID = "" Then
    ' Handle error: PlantVarietyID is missing
    Response.Write("<title>Error - Varietal Not Found</title>")
    Response.Write("<meta name='description' content='Plant Varietal ID is missing.'/>")
    Response.Write("</head><body><div class='container-fluid body text-center'><h1>Error: Plant Varietal ID is missing.</h1><p>Please go back and select a valid varietal.</p></div></body></html>")
    Response.End
End If

' --- Fetch Varietal Details and Related Lookup Data ---
sqlVarietalDetail = "SELECT PL.PlantName, PV.PlantVarietyName, PV.PlantVarietyDescription, PV.PlantvarietyImage, " & _
                    "ST.SoilTexture, ST.Description AS SoilTextureDescription, " & _
                    "PH.PHRange, PH.Description AS PHRangeDescription, " & _
                    "OM.OrganicMatterContent, OM.Description AS OMDescription, OM.ImportanceToSoilAndPlants AS OMImportance, " & _
                    "SL.SalinityLevel, SL.Classification AS SalinityClassification, SL.Description AS SalinityDescription, SL.ImpactOnPlants AS SalinityImpact, " & _
                    "PHZ.Zone, PHZ.TemperatureStartRange, PHZ.TemperatureEndRange, " & _
                    "H.Classification AS HumidityClassification, H.Description AS HumidityDescription, H.ImpactOnPlants AS HumidityImpact, " & _
                    "PV.WaterRequirementMin, PV.WaterRequirementMax, " & _
                    "NL_Primary.Nutrient AS PrimaryNutrientName, NL_Primary.Description AS PrimaryNutrientDescription, NL_Primary.ImportanceToPlants AS PrimaryNutrientImportance " & _
                    "FROM PlantVariety PV " & _
                    "LEFT JOIN SoilTextureLookup ST ON PV.SoilTextureID = ST.SoilTextureID " & _
                    "LEFT JOIN Plant PL ON PV.PlantID = PL.PlantID " & _
                    "LEFT JOIN PHRangeLookup PH ON PV.PHRangeID = PH.PHRangeID " & _
                    "LEFT JOIN OrganicMatterLookup OM ON PV.OrganicMatterID = OM.OrganicMatterID " & _
                    "LEFT JOIN SalinityLookup SL ON PV.SalinityLevelID = SL.SalinityLevelID " & _
                    "LEFT JOIN PlantHardinessZoneLookup PHZ ON PV.ZoneID = PHZ.ZoneID " & _
                    "LEFT JOIN HumidityLookup H ON PV.HumidityID = H.HumidityID " & _
                    "LEFT JOIN NutrientLookup NL_Primary ON PV.PlantNutrientID = NL_Primary.NutrientID " & _
                    "WHERE PV.PlantVarietyID = " & PlantVarietyID

Set rsVarietalDetail = Server.CreateObject("ADODB.Recordset")
rsVarietalDetail.Open sqlVarietalDetail, conn, 3, 3 ' adOpenStatic, adLockOptimistic

If Not rsVarietalDetail.EOF Then
    PlantName = rsVarietalDetail("PlantName")
    PlantVarietyName = rsVarietalDetail("PlantVarietyName")
    PlantVarietyDescription = rsVarietalDetail("PlantVarietyDescription")
    PlantVarietyImage = rsVarietalDetail("PlantvarietyImage") ' Get the image path
Else
    ' If varietal not found, redirect or show error
    Response.Write("<title>Varietal Not Found</title>")
    Response.Write("<meta name='description' content='The requested plant varietal was not found.'/>")
    Response.Write("</head><body><div class='container-fluid body text-center'><h1>Error: Varietal Not Found.</h1></div></body></html>")
    Response.End
End If

' Note: currenturl and WebSiteName are assumed to be defined globally or in Header.asp
' Example placeholder values if not defined:
' Dim currenturl, WebSiteName
' currenturl = Request.ServerVariables("URL")
' WebSiteName = "My Plant Wiki"
%>
<title><%=WebSiteName %> | <%=PlantVarietyName %></title>
<meta name="title" content="<%=WebSiteName %> | <%=PlantVarietyName %>"/>
<meta name="description" content="<%=PlantVarietyDescription %> - Detailed information on <%=PlantVarietyName %> varietal, including growing conditions, and nutrient requirements."/>
<meta name="keywords" content="<%=PlantVarietyName %>, <%=PlantVarietyName %> varietal, plant details, growing conditions, plant nutrients, <%=WebSiteName %>"/>

<link rel="canonical" href="<%=currenturl %>" />
<meta name="revisit-after" content="7 Days"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>

<style>
    body {
        font-family: sans-serif;
        background-color: #f3f4f6;
        -webkit-font-smoothing: antialiased;
        -moz-osx-font-smoothing: grayscale;
    }
    .container-fluid {
        width: 100%;
        margin-left: auto;
        margin-right: auto;
        padding-left: 1rem;
        padding-right: 1rem;
    }
    .container {
        width: 100%;
        margin-left: auto;
        margin-right: auto;
        max-width: 1400px;
    }
    .body {
        padding: 1rem;
    }
    h1, h2, h3, h4 {
        color: #1f2937;
        font-weight: bold;
        margin-bottom: 1rem;
    }
    h1 { font-size: 2.25rem; }
    h2 { font-size: 1.75rem; border-bottom: 2px solid #e5e7eb; padding-bottom: 0.5rem; margin-top: 2rem; }
    h3 { font-size: 1.25rem; margin-top: 1.5rem; margin-bottom: 0.75rem; }
    h4 { font-size: 1.1rem; margin-top: 1rem; margin-bottom: 0.5rem; }

    p {
        margin-bottom: 1rem;
        color: #374151;
        line-height: 1.6;
    }
    .row {
        display: flex;
        flex-wrap: wrap;
        margin-left: -0.75rem;
        margin-right: -0.75rem;
    }
    .col-12, .col-md-6, .col-lg-4 {
        padding-left: 0.75rem;
        padding-right: 0.75rem;
        box-sizing: border-box;
        margin-bottom: 1.5rem;
    }
    @media (min-width: 768px) {
        .col-md-6 { width: 50%; }
    }
    @media (min-width: 992px) {
        .col-lg-4 { width: 33.333%; }
    }

    .text-left { text-align: left; }
    .text-center { text-align: center; }

    a.body {
        color: #3b82f6;
        text-decoration: none;
        font-weight: bold;
    }
    a.body:hover {
        text-decoration: underline;
    }
    .detail-section {
        background-color: #fff;
        border: 1px solid #e5e7eb;
        border-radius: 0.5rem;
        padding: 1.5rem;
        box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1), 0 1px 2px 0 rgba(0, 0, 0, 0.06);
        margin-bottom: 1.5rem;
    }
    .detail-list {
        list-style: none;
        padding: 0;
        margin: 0;
    }
    .detail-list li {
        margin-bottom: 0.5rem;
        color: #374151;
        font-size: 0.95rem;
    }
    .detail-list li strong {
        color: #1f2937;
        margin-right: 0.5rem;
    }
    .nutrient-list {
        list-style: disc;
        padding-left: 1.5rem;
        margin-top: 0.5rem;
    }
    .nutrient-item {
        margin-bottom: 0.5rem;
        color: #374151;
        font-size: 0.95rem;
    }
    .nutrient-item strong {
        color: #1f2937;
    }
    .nutrient-description {
        font-size: 0.85rem;
        color: #6b7280;
        margin-left: 1.5rem;
        display: block;
    }
    .varietal-image {
        max-width: 100%;
        height: auto;
        border-radius: 0.5rem;
        box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
        margin-bottom: 1.5rem;
    }
</style>
</head>
<body>

<!--#Include virtual="/Members/MembersHeader.asp"-->
<br>
<div class="container-fluid" >
    <div class="container-fluid" id="grad1">
        <div class="container mx-auto py-6">
            <div class="flex flex-col md:flex-row items-center md:items-start md:space-x-8">
                <div class="flex-shrink-0 mb-4 md:mb-0">
                    <% If Len(PlantVarietyImage) > 0 Then %>
                        <img src="<%=PlantVarietyImage %>" alt="<%=PlantVarietyName %> Image"
                             class="varietal-image w-48 h-48 md:w-64 md:h-64 object-cover rounded-lg shadow-md"
                             onerror="this.onerror=null;this.src='https://placehold.co/256x256/CCCCCC/333333?text=Image+Not+Available';">
                    <% Else %>
                    <% End If %>
                </div>
                <div class="flex-grow md:text-left">
                    <h1 class="text-3xl md:text-4xl font-bold text-gray-800 mb-2"><%=PlantVarietyName %></h1>
                    
                    <p class="text-gray-700 text-lg leading-relaxed"><%=PlantName %><br><%=PlantVarietyDescription %></p>
                </div>
            </div>
        </div>
    </div>
    
    <style>
        /* Add these styles to your existing <style> block or CSS file */
        /* Adjust .container, .container-fluid, .mx-auto, .py-6 as per your global styles */
    
        .flex { display: flex; }
        .flex-col { flex-direction: column; }
        .md\:flex-row { /* For medium screens and up */
            flex-direction: row;
        }
        .items-center { align-items: center; }
        .md\:items-start { /* For medium screens and up */
            align-items: flex-start;
        }
        .md\:space-x-8 > *:not(:last-child) { /* For medium screens and up */
            margin-right: 2rem; /* space-x-8 */
        }
        .flex-shrink-0 { flex-shrink: 0; }
        .mb-4 { margin-bottom: 1rem; }
        .md\:mb-0 { /* For medium screens and up */
            margin-bottom: 0;
        }
        .varietal-image {
            width: 12rem; /* w-48 */
            height: 12rem; /* h-48 */
            object-fit: cover;
            border-radius: 0.5rem; /* rounded-lg */
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06); /* shadow-md */
        }
        @media (min-width: 768px) { /* md breakpoint */
            .varietal-image {
                width: 16rem; /* md:w-64 */
                height: 16rem; /* md:h-64 */
            }
        }
        .flex-grow { flex-grow: 1; }
        .text-center { text-align: center; }
        .md\:text-left { /* For medium screens and up */
            text-align: left;
        }
        .text-3xl { font-size: 1.875rem; line-height: 2.25rem; }
        @media (min-width: 768px) { /* md breakpoint */
            .md\:text-4xl { font-size: 2.25rem; line-height: 2.5rem; }
        }
        .font-bold { font-weight: 700; }
        .text-gray-800 { color: #1f2937; }
        .mb-2 { margin-bottom: 0.5rem; }
        .text-gray-700 { color: #374151; }
        .text-lg { font-size: 1.125rem; line-height: 1.75rem; }
        .leading-relaxed { line-height: 1.625; }
    </style>


</div>

<div class="container-fluid" align="center" style="max-width: 1400px;">
<div class="row">
    <div class="col-lg-6 col-12">
        <div class="detail-section">
            <h2>Growing Environment</h2>
            <ul class="detail-list">
                <%
                Dim soilTexture, phRange, organicMatter, salinityLevel, zone, humidity, waterMin, waterMax, primaryNutrientName
                Dim soilTextureDesc, phRangeDesc, omContent, omDesc, omImportance, salinityClass, salinityDesc, salinityImpact, tempStart, tempEnd, humidityClass, humidityDesc, humidityImpact
                Dim primaryNutrientDesc, primaryNutrientImportance

                ' Assign values, handling Nulls
                If Not IsNull(rsVarietalDetail("SoilTexture")) Then soilTexture = rsVarietalDetail("SoilTexture") Else soilTexture = "N/A"
                If Not IsNull(rsVarietalDetail("SoilTextureDescription")) Then soilTextureDesc = rsVarietalDetail("SoilTextureDescription") Else soilTextureDesc = "N/A"

                If Not IsNull(rsVarietalDetail("PHRange")) Then phRange = rsVarietalDetail("PHRange") Else phRange = "N/A"
                If Not IsNull(rsVarietalDetail("PHRangeDescription")) Then phRangeDesc = rsVarietalDetail("PHRangeDescription") Else phRangeDesc = "N/A"

                If Not IsNull(rsVarietalDetail("OrganicMatterContent")) Then omContent = rsVarietalDetail("OrganicMatterContent") Else omContent = "N/A"
                If Not IsNull(rsVarietalDetail("OMDescription")) Then omDesc = rsVarietalDetail("OMDescription") Else omDesc = "N/A"
                If Not IsNull(rsVarietalDetail("OMImportance")) Then omImportance = rsVarietalDetail("OMImportance") Else omImportance = "N/A"

                If Not IsNull(rsVarietalDetail("SalinityLevel")) Then salinityLevel = rsVarietalDetail("SalinityLevel") Else salinityLevel = "N/A"
                If Not IsNull(rsVarietalDetail("SalinityClassification")) Then salinityClass = rsVarietalDetail("SalinityClassification") Else salinityClass = "N/A"
                If Not IsNull(rsVarietalDetail("SalinityDescription")) Then salinityDesc = rsVarietalDetail("SalinityDescription") Else salinityDesc = "N/A"
                If Not IsNull(rsVarietalDetail("SalinityImpact")) Then salinityImpact = rsVarietalDetail("SalinityImpact") Else salinityImpact = "N/A"

                If Not IsNull(rsVarietalDetail("Zone")) Then zone = rsVarietalDetail("Zone") Else zone = "N/A"
                If Not IsNull(rsVarietalDetail("TemperatureStartRange")) Then tempStart = rsVarietalDetail("TemperatureStartRange") Else tempStart = "N/A"
                If Not IsNull(rsVarietalDetail("TemperatureEndRange")) Then tempEnd = rsVarietalDetail("TemperatureEndRange") Else tempEnd = "N/A"

                If Not IsNull(rsVarietalDetail("HumidityClassification")) Then humidityClass = rsVarietalDetail("HumidityClassification") Else humidityClass = "N/A"
                If Not IsNull(rsVarietalDetail("HumidityDescription")) Then humidityDesc = rsVarietalDetail("HumidityDescription") Else humidityDesc = "N/A"
                If Not IsNull(rsVarietalDetail("HumidityImpact")) Then humidityImpact = rsVarietalDetail("HumidityImpact") Else humidityImpact = "N/A"

                If Not IsNull(rsVarietalDetail("WaterRequirementMin")) Then waterMin = rsVarietalDetail("WaterRequirementMin") Else waterMin = "N/A"
                If Not IsNull(rsVarietalDetail("WaterRequirementMax")) Then waterMax = rsVarietalDetail("WaterRequirementMax") Else waterMax = "N/A"
                
                If Not IsNull(rsVarietalDetail("PrimaryNutrientName")) Then primaryNutrientName = rsVarietalDetail("PrimaryNutrientName") Else primaryNutrientName = "N/A"
                If Not IsNull(rsVarietalDetail("PrimaryNutrientDescription")) Then primaryNutrientDesc = rsVarietalDetail("PrimaryNutrientDescription") Else primaryNutrientDesc = "N/A"
                If Not IsNull(rsVarietalDetail("PrimaryNutrientImportance")) Then primaryNutrientImportance = rsVarietalDetail("PrimaryNutrientImportance") Else primaryNutrientImportance = "N/A"
                %>

                <li><strong>Soil Texture:</strong> <%=soilTexture %>
                    <p class="nutrient-description"><%=soilTextureDesc %></p>
                </li>
                <li><strong>pH Range:</strong> <%=phRange %>
                    <p class="nutrient-description"><%=phRangeDesc %></p>
                </li>
                <li><strong>Organic Matter:</strong> <%=omContent %>
                    <p class="nutrient-description"><%=omDesc %><br></p>
                </li>
                <li><strong>Salinity Level:</strong> <%=salinityLevel %> (<%=salinityClass %>)
                    <p class="nutrient-description"><%=salinityDesc %><br><em>Impact:</em> <%=salinityImpact %></p>
                </li>
                <li><strong>Hardiness Zone:</strong> <%=zone %> (Min: <%=tempStart %>°F, Max: <%=tempEnd %>°F)</li>
                <li><strong>Humidity:</strong> <%=humidityClass %>
                    <p class="nutrient-description"><%=humidityDesc %><br><em>Impact:</em> <%=humidityImpact %></p>
                </li>
                <li><strong>Water Requirement:</strong> <%=waterMin %> - <%=waterMax %> inches per week</li>
            </ul>
        </div>
    </div>

    <div class="col-lg-6 col-12">
        <div class="detail-section">
            <h2>Nutrient Profile</h2>

            <ul class="nutrient-list">
                <%
                ' --- Fetch Additional Nutrients from PlantNutrient table ---
                Dim rsAdditionalNutrients, sqlAdditionalNutrients
                sqlAdditionalNutrients = "SELECT PNT.NutrientLow, PNT.NutrientID AS PNTNutrientValue, NL.Nutrient AS LookupNutrientName, NL.Description AS LookupDescription, NL.ImportanceToPlants AS LookupImportance " & _
                                         "FROM PlantNutrient PNT " & _
                                         "JOIN NutrientLookup NL ON PNT.NutrientID = NL.NutrientID " & _
                                         "WHERE PNT.PlantVarietyID = " & PlantVarietyID & " " & _
                                         "ORDER BY LookupNutrientName" ' Order by the aliased name
                
                Set rsAdditionalNutrients = Server.CreateObject("ADODB.Recordset")
                rsAdditionalNutrients.Open sqlAdditionalNutrients, conn, 3, 3

                If Not rsAdditionalNutrients.EOF Then
                    Do While Not rsAdditionalNutrients.EOF
                        Dim nutrientName, nutrientDesc, nutrientImportance, nutrientLow, nutrientHighValue
                        nutrientName = rsAdditionalNutrients("LookupNutrientName")
                        nutrientDesc = rsAdditionalNutrients("LookupDescription")
                        nutrientImportance = rsAdditionalNutrients("LookupImportance")
                        nutrientLow = rsAdditionalNutrients("NutrientLow")
                        nutrientHighValue = rsAdditionalNutrients("PNTNutrientValue") ' Use the aliased name
                %>
                        <li class="nutrient-item">
                            <strong><%=nutrientName %></strong>
                            (<%=nutrientLow %> - <%=nutrientHighValue %>)
                            <p class="nutrient-description"><%=nutrientDesc %><br></p>
                        </li>
                <%
                        rsAdditionalNutrients.MoveNext
                    Loop
                Else
                %>
           
                <%
                End If
                rsAdditionalNutrients.Close
                Set rsAdditionalNutrients = Nothing
                %>
            </ul>
        </div>
    </div>
</div>
</div>


<!--#Include virtual="/Members/MembersFooter.asp"-->
</body></html>