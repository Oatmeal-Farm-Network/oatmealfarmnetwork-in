<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!--#Include virtual="/members/Membersglobalvariables.asp"-->
<!--#Include virtual="/members/MembersHeader.asp"-->

<%
' --- ASP Setup ---
' Assuming conn object is available globally or established here

Dim IngredientID, IngredientName, IngredientDescription
IngredientID = Request.QueryString("IngredientID") ' Expecting IngredientID instead of PlantID

' Initialize variables for metadata
IngredientName = "Ingredient Varietals" ' Default
IngredientDescription = "Explore various ingredient varietals." ' Default

If IsEmpty(IngredientID) Or IsNull(IngredientID) Or IngredientID = "" Then
    ' Handle error: IngredientID is missing
    Response.Write("<title>Error - Ingredient Not Found</title>")
    Response.Write("<meta name='description' content='Ingredient ID is missing.'/>")
    Response.Write("</head><body><div class='container-fluid body text-center'><h1>Error: Ingredient ID is missing.</h1><p>Please go back and select a valid ingredient.</p></div></body></html>")
    Response.End
End If

' Get IngredientName and IngredientDescription for the header and metadata
Dim rsIngredient, sqlIngredient
' ASSUMPTION: The main ingredient data is in a table named 'Ingredient'
sqlIngredient = "SELECT IngredientName, IngredientDescription FROM Ingredients WHERE IngredientID = " & IngredientID
Set rsIngredient = Server.CreateObject("ADODB.Recordset")
rsIngredient.Open sqlIngredient, conn, 3, 3 ' adOpenStatic, adLockOptimistic

If Not rsIngredient.EOF Then
    IngredientName = rsIngredient("IngredientName")
    IngredientDescription = rsIngredient("IngredientDescription")
End If
rsIngredient.Close
Set rsIngredient = Nothing

' Note: currenturl and WebSiteName are assumed to be defined globally or in Header.asp
%>
<title><%=WebSiteName %> | <%=IngredientName %> Varieties</title>
<meta name="title" content="<%=WebSiteName %> | <%=IngredientName %> Varieties"/>
<meta name="description" content="Explore all known varieties of <%=IngredientName %>, including their nutrient profiles. <%=IngredientDescription %>"/>
<meta name="keywords" content="<%=IngredientName %>, varieties, ingredient, nutrient profiles, food database, nutrition"/>

<link rel="canonical" href="<%=currenturl %>" />
<meta name="revisit-after" content="7 Days"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>

<style>
    /* NOTE: All CSS styles remain the same for layout preservation */
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
        overflow-x: auto;
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
        white-space: normal;
        overflow: visible;
        max-width: none;
    }
</style>
</head>
<body>


<div class="container-fluid" align="center" style="max-width: 1400px;">
    <h1><%=IngredientName %> Varieties</h1><br />

<div class="row">
    <div class="col-12 body text-left">
        <p>Below is a list of all known varieties for <%=IngredientName %>. Click on a variety name to view more detailed nutrient and sourcing information.</p>
        <br />
    </div>
</div>

<div class="row">
    <div class="col-12">
        <div class="varietal-table-container">
            <table class="varietal-table">
                <thead>
                    <tr>
                        <th>Variety Name</th>
                        <th>Description</th>
                    </tr>
                </thead>
                <tbody>
                    <%
     
                    
                    sqlVarietals = "SELECT IV.*, ISNULL(T.Nutrientcount, 0) AS Nutrientcount " & _
                    "FROM IngredientsVarieties IV " & _
                    "LEFT JOIN ( " & _
                    "    SELECT IngredientVarietyPK, COUNT(DISTINCT NutrientID) AS Nutrientcount " & _
                    "    FROM [dbo].[IngredientNutrient] " & _
                    "    WHERE IngredientVarietyPK IS NOT NULL " & _
                    "    GROUP BY IngredientVarietyPK " & _
                    ") T ON IV.IngredientVarietyPK = T.IngredientVarietyPK " & _
                    "WHERE IV.IngredientID = " & IngredientID & " " & _
                    "ORDER BY IV.IngredientName"
     
     
               'response.write("sqlVarietals=" & sqlVarietals)
                    Set rsVarietals = Server.CreateObject("ADODB.Recordset")
                    rsVarietals.Open sqlVarietals, conn, 3, 3 ' adOpenStatic, adLockOptimistic

                    If Not rsVarietals.EOF Then
                        ' Group by variety, displaying a row for each variety-nutrient pair
                        Dim currentVarietyID
                        currentVarietyID = ""
                        
                        Do While Not rsVarietals.EOF

                            Nutrientcount =  rsVarietals("Nutrientcount")
                            pvID = rsVarietals("IngredientVarietyPK")
                            pvName = rsVarietals("IngredientName")
                            pvDescription = rsVarietals("IngredientDescription")
        
                            
                            If IsNull(rsVarietals("IngredientDescription")) Then IngredientDescription = "" Else IngredientDescription = rsVarietals("IngredientDescription")

                    %>
                            <tr>
                                <td>
                                    <% if Nutrientcount > 0 Then %>
                                        <a href="VarietyDetail.asp?IngredientvarietyID=<%=pvID %>" style="max-width: 80px"><%=pvName %> </a>
                                    <% Else %>
                                       <%=pvName %>
                                    <% End If %>
                                    </td>
                                <td  title="<%=pvDescription %>" ><%=pvDescription %></td>
                            </tr>
                    <%
                            rsVarietals.MoveNext
                        Loop
                    Else
                    %>
                        <tr>
                            <td colspan="5" class="text-center">No varieties found for <%=IngredientName %> in the database.</td>
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



<!--#Include virtual="/members/MembersFooter.asp"-->
</body></html>