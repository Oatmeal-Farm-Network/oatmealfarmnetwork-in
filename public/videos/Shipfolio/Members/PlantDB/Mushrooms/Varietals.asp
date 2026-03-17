<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!--#Include virtual="/includefiles/globalvariables.asp"-->

<%
' --- ASP Setup ---
' Assuming conn object is available globally or established here
' Set conn = Server.CreateObject("ADODB.Connection")
' conn.Open "Your_Connection_String_Here" ' Replace with your actual connection string

Dim PlantID, PlantName, PlantDescription
PlantID = Request.QueryString("PlantID")

' Initialize variables for metadata
PlantName = "Varietals" ' Default
PlantDescription = "Explore various plant varietals." ' Default

If IsEmpty(PlantID) Or IsNull(PlantID) Or PlantID = "" Then
    ' Handle error: PlantID is missing
    Response.Write("<title>Error - Plant Not Found</title>")
    Response.Write("<meta name='description' content='Plant ID is missing.'/>")
    Response.Write("</head><body><div class='container-fluid body text-center'><h1>Error: Plant ID is missing.</h1><p>Please go back and select a valid plant.</p></div></body></html>")
    Response.End
End If

' Get PlantName and PlantDescription for the header and metadata
Dim rsPlant, sqlPlant
sqlPlant = "SELECT PlantName, PlantDescription FROM Plant WHERE PlantID = " & PlantID
Set rsPlant = Server.CreateObject("ADODB.Recordset")
rsPlant.Open sqlPlant, conn, 3, 3 ' adOpenStatic, adLockOptimistic

If Not rsPlant.EOF Then
    PlantName = rsPlant("PlantName")
    PlantDescription = rsPlant("PlantDescription")
End If
rsPlant.Close
Set rsPlant = Nothing

' Note: currenturl and WebSiteName are assumed to be defined globally or in Header.asp
' Example placeholder values if not defined:
' Dim currenturl, WebSiteName
' currenturl = Request.ServerVariables("URL")
' WebSiteName = "My Plant Wiki"
%>
<title><%=WebSiteName %> | <%=PlantName %> Varietals</title>
<meta name="title" content="<%=WebSiteName %> | <%=PlantName %> Varietals"/>
<meta name="description" content="Explore all known varietals of <%=PlantName %>, including their descriptions, growing requirements, and nutrient profiles. <%=PlantDescription %>"/>
<meta name="keywords" content="<%=PlantName %>, varietals, plant varieties, <%=PlantName %> growing, plant database, food plants, gardening, agriculture"/>

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
    h1, h2, h3 {
        color: #1f2937;
        font-weight: bold;
        margin-bottom: 1rem;
    }
    h3 {
        font-size: 1.25rem;
        margin-top: 1.5rem;
        margin-bottom: 0.75rem;
    }
    p {
        margin-bottom: 1rem;
        color: #374151;
    }
    .row {
        display: flex;
        flex-wrap: wrap;
        margin-left: -0.75rem;
        margin-right: -0.75rem;
    }
    .col-12 {
        padding-left: 0.75rem;
        padding-right: 0.75rem;
        box-sizing: border-box;
        margin-bottom: 1.5rem;
    }

    .d-none { display: none !important; }
    .d-lg-block { display: block !important; }
    .d-lg-none { display: none !important; }
    @media (min-width: 992px) {
        .d-lg-none { display: none !important; }
        .d-lg-block { display: block !important; }
    }
    @media (max-width: 991.98px) {
        .d-lg-block { display: none !important; }
        .d-lg-none { display: block !important; }
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
    /* Table specific styles */
    .varietal-table-container {
        overflow-x: auto; /* Enables horizontal scrolling for tables on small screens */
        background-color: #fff;
        border: 1px solid #e5e7eb;
        border-radius: 0.5rem;
        box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1), 0 1px 2px 0 rgba(0, 0, 0, 0.06);
        margin-bottom: 1.5rem;
    }
    .varietal-table {
        width: 100%;
        border-collapse: collapse;

    }
    .varietal-table th, .varietal-table td {
        padding: 0.75rem 1rem;
        border-bottom: 1px solid #e5e7eb;
        text-align: left;
        vertical-align: top;
    }
    .varietal-table th {
        background-color: #f9fafb;
        font-weight: bold;
        color: #4b5563;
        font-size: 0.875rem;
        text-transform: uppercase;
        letter-spacing: 0.05em;
    }
    .varietal-table tbody tr:hover {
        background-color: #f3f4f6;
    }
    .varietal-table td {
        color: #374151;
        font-size: 0.9rem;
    }
    .varietal-table td a {
        color: #3b82f6;
        text-decoration: none;
        font-weight: normal;
    }
    .varietal-table td a:hover {
        text-decoration: underline;
    }
    .description-cell {
        width: 250px; 
        text-overflow: ellipsis;
    }
    .description-cell:hover {
        white-space: normal; /* Show full text on hover */
        overflow: visible;
        max-width: none;
    }
</style>
</head>
<body>
<% Knowledgebases = True %>
<!--#Include virtual="/Members/MembersHeader.asp"-->

<div class="container-fluid" align="center" style="max-width: 1400px;">
<div class="row">
    <div class="col-12 body text-left">
        <h1><%=PlantName %> Varietals</h1><br />
        <p>Below is a list of all known varietals for <%=PlantName %>. Click on a varietal name to view more detailed information.</p>
        <br />
    </div>
</div>

<div class="row">
    <div class="col-12">
        <div class="varietal-table-container">
            <table class="varietal-table">
                <thead>
                    <tr>
                        <th>Varietal Name</th>
                        <th>Description</th>
                        <th>Soil Texture</th>
                        <th>pH Range</th>
                        <th>Organic Matter</th>
                        <th>Salinity Level</th>
                        <th>Hardiness Zone</th>
                        <th>Humidity</th>
                        <th>Water (in/wk)</th>
                        <th>Primary Nutrient</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                    Dim rsVarietals, sqlVarietals
                    sqlVarietals = "SELECT PV.PlantVarietyID, PV.PlantVarietyName, PV.PlantVarietyDescription, " & _
                                   "ST.SoilTexture, PH.PHRange, OM.OrganicMatterContent, SL.SalinityLevel, " & _
                                   "PHZ.Zone, H.Classification AS HumidityClassification, " & _
                                   "PV.WaterRequirementMin, PV.WaterRequirementMax, NL.Nutrient AS PrimaryNutrient " & _
                                   "FROM PlantVariety PV " & _
                                   "LEFT JOIN SoilTextureLookup ST ON PV.SoilTextureID = ST.SoilTextureID " & _
                                   "LEFT JOIN PHRangeLookup PH ON PV.PHRangeID = PH.PHRangeID " & _
                                   "LEFT JOIN OrganicMatterLookup OM ON PV.OrganicMatterID = OM.OrganicMatterID " & _
                                   "LEFT JOIN SalinityLookup SL ON PV.SalinityLevelID = SL.SalinityLevelID " & _
                                   "LEFT JOIN PlantHardinessZoneLookup PHZ ON PV.ZoneID = PHZ.ZoneID " & _
                                   "LEFT JOIN HumidityLookup H ON PV.HumidityID = H.HumidityID " & _
                                   "LEFT JOIN NutrientLookup NL ON PV.PlantNutrientID = NL.NutrientID " & _
                                   "WHERE PV.PlantID = " & PlantID & " " & _
                                   "ORDER BY PV.PlantVarietyName"

                    Set rsVarietals = Server.CreateObject("ADODB.Recordset")
                    rsVarietals.Open sqlVarietals, conn, 3, 3 ' adOpenStatic, adLockOptimistic

                    If Not rsVarietals.EOF Then
                        Do While Not rsVarietals.EOF
                            Dim pvID, pvName, pvDescription, soilTexture, phRange, organicMatter, salinityLevel, zone, humidity, waterMin, waterMax, primaryNutrient, waterDisplay

                            pvID = rsVarietals("PlantVarietyID")
                            pvName = rsVarietals("PlantVarietyName")
                            pvDescription = rsVarietals("PlantVarietyDescription")

                            ' Handle Nulls with If...Then...Else
                            If IsNull(rsVarietals("SoilTexture")) Then soilTexture = "N/A" Else soilTexture = rsVarietals("SoilTexture")
                            If IsNull(rsVarietals("PHRange")) Then phRange = "N/A" Else phRange = rsVarietals("PHRange")
                            If IsNull(rsVarietals("OrganicMatterContent")) Then organicMatter = "N/A" Else organicMatter = rsVarietals("OrganicMatterContent")
                            If IsNull(rsVarietals("SalinityLevel")) Then salinityLevel = "N/A" Else salinityLevel = rsVarietals("SalinityLevel")
                            If IsNull(rsVarietals("Zone")) Then zone = "N/A" Else zone = rsVarietals("Zone")
                            If IsNull(rsVarietals("HumidityClassification")) Then humidity = "N/A" Else humidity = rsVarietals("HumidityClassification")
                            If IsNull(rsVarietals("PrimaryNutrient")) Then primaryNutrient = "N/A" Else primaryNutrient = rsVarietals("PrimaryNutrient")

                            If IsNull(rsVarietals("WaterRequirementMin")) Or IsNull(rsVarietals("WaterRequirementMax")) Then
                                waterDisplay = "N/A"
                            Else
                                waterDisplay = rsVarietals("WaterRequirementMin") & " - " & rsVarietals("WaterRequirementMax")
                            End If
                    %>
                            <tr>
                                <td><a href="VarietalDetail.asp?PlantVarietyID=<%=pvID %>"><%=pvName %></a></td>
                                <td class="description-cell" title="<%=pvDescription %>" ><%=pvDescription %></td>
                                <td><%=soilTexture %></td>
                                <td><%=phRange %></td>
                                <td><%=organicMatter %></td>
                                <td><%=salinityLevel %></td>
                                <td><%=zone %></td>
                                <td><%=humidity %></td>
                                <td><%=waterDisplay %></td>
                                <td><%=primaryNutrient %></td>
                            </tr>
                    <%
                            rsVarietals.MoveNext
                        Loop
                    Else
                    %>
                        <tr>
                            <td colspan="10" class="text-center">No varietals found for <%=PlantName %> in the database.</td>
                        </tr>
                    <%
                    End If
                    rsVarietals.Close
                    Set rsVarietals = Nothing
                    %>
                </tbody>
            </table>
        </div>
    </div>
</div>
</div>

<!--#Include virtual="/Members/MembersFooter.asp"-->
</body></html>