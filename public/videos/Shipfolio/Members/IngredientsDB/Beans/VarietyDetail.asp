<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!--#Include virtual="/members/Membersglobalvariables.asp"-->
<!--#Include virtual="/members/MembersHeader.asp"-->
<%
' --- ASP Setup ---
' This page displays the aggregated nutritional data for a single Ingredient.
' Expects Request.QueryString("IngredientID")
' Assumes 'conn' object is established globally.

IngredientvarietyID = Request.QueryString("IngredientvarietyID") 

' Initialize variables
IngredientName = "Ingredient Details" 
IngredientDescription = "Detailed nutritional information for an ingredient." 
IngredientImage = "" 

' --- 1. Validate Input and Handle Missing ID ---
If IsEmpty(IngredientvarietyID) Or IsNull(IngredientvarietyID) Or IngredientvarietyID = "" Then
    Response.Write("<title>Error - Ingredient Not Found</title>")
    Response.Write("<meta name='description' content='Ingredient ID is missing.'/>")
    Response.Write("</head><body><div class='container-fluid body text-center'><h1>Error: Ingredient ID is missing.</h1><p>Please go back and select a valid ingredient.</p></div></body></html>")
    Response.End
End If

' --- 2. Fetch Ingredient Details (Name, Description, Image) ---
Dim rsIngredientDetail, sqlIngredientDetail
sqlIngredientDetail = "SELECT IngredientName, IngredientDescription, IngredientImage " & _
                      "FROM IngredientsVarieties " & _
                      "WHERE IngredientVarietyPK = " & IngredientvarietyID

Set rsIngredientDetail = Server.CreateObject("ADODB.Recordset")
rsIngredientDetail.Open sqlIngredientDetail, conn, 3, 3 ' adOpenStatic, adLockOptimistic

If Not rsIngredientDetail.EOF Then
    IngredientName = rsIngredientDetail("IngredientName")
    IngredientDescription = rsIngredientDetail("IngredientDescription")
    
    If Not IsNull(rsIngredientDetail("IngredientImage")) Then 
        IngredientImage = rsIngredientDetail("IngredientImage")
    End If
Else
    ' If ingredient not found
    'Response.Write("<title>Ingredient Not Found</title>")
    'Response.Write("<meta name='description' content='The requested ingredient was not found.'/>")
    'Response.Write("</head><body><div class='container-fluid body text-center'><h1>Error: Ingredient Not Found.</h1></div></body></html>")
   '' Response.End
End If
rsIngredientDetail.Close
Set rsIngredientDetail = Nothing

' Note: currenturl and WebSiteName are assumed to be defined globally
%>
<!DOCTYPE html>
<html lang="en">
<head>
<title><%=WebSiteName %> | <%=IngredientName %></title>
<meta name="title" content="<%=WebSiteName %> | <%=IngredientName %>"/>
<meta name="description" content="Nutritional profile for <%=IngredientName %>, based on aggregated data across all known varieties."/>
<meta name="keywords" content="<%=IngredientName %>, nutrition facts, nutrient profile, food details, aggregated data"/>

<link rel="canonical" href="<%=currenturl %>" />
<meta name="revisit-after" content="7 Days"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>

<style>
    /* NOTE: Tailwind-like classes are defined below for layout compatibility */
      .container-fluid { width: 100%; margin: 0 auto; padding: 1rem; }
    .container { width: 100%; margin-left: auto; margin-right: auto; max-width: 1400px; }
    .detail-section { background-color: #fff; border: 1px solid #e5e7eb; border-radius: 0.5rem; padding: 1.5rem; box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1); margin-bottom: 1.5rem; }
    .nutrient-list { list-style: none; padding: 0; margin-top: 0.5rem; }
    .nutrient-item { margin-bottom: 0.5rem; color: #374151;  border-bottom: 1px dotted #e5e7eb; padding-bottom: 0.5rem; text-align: left; }
    .nutrient-item:last-child { border-bottom: none; }
    .nutrient-item strong { color: #1f2937; display: inline-block; min-width: 200px; }
    .nutrient-value { font-weight: bold;  }
    .nutrient-description { font-size: 0.8em; color: #6b7280; margin-left: 205px; display: block; } 
    .varietal-image { max-width: 100%; height: auto; border-radius: 0.5rem; box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1); margin-bottom: 1.5rem; }
    
    /* Layout Helpers (minimalistic Tailwind emulation) */
    .flex { display: flex; }
    .flex-col { flex-direction: column; }
    .flex-grow { flex-grow: 1; }
    .flex-shrink-0 { flex-shrink: 0; }
    .mb-4 { margin-bottom: 1rem; }
    .text-3xl { font-size: 1.875rem; line-height: 2.25rem; }
    .text-gray-800 { color: #1f2937; }
    .text-gray-700 { color: #374151; }
    .text-lg { font-size: 1.125rem; }
    .font-bold { font-weight: 700; }

    @media (min-width: 768px) { /* md breakpoint */
        .md\:flex-row { flex-direction: row; }
        .md\:items-start { align-items: flex-start; }
        .md\:space-x-8 > *:not(:last-child) { margin-right: 2rem; }
        .md\:mb-0 { margin-bottom: 0; }
        .md\:text-4xl { font-size: 2.25rem; line-height: 2.5rem; }
        .md\:text-left { text-align: left; }
        .varietal-image { width: 16rem; height: 16rem; }
        .col-lg-12 { width: 100%; }
    }
    @media (max-width: 767px) {
         .col-lg-12 { width: 100%; }
    }
</style>
</head>
<body>

<br>
<div class="container-fluid" >
    <div class="container-fluid" id="grad1">
        <div class="container mx-auto py-6">
            <div class="flex flex-col md:flex-row items-center md:items-start md:space-x-8">
                <div class="flex-shrink-0 mb-4 md:mb-0">
                    <% If Len(IngredientImage) > 0 Then %>
                        <img src="<%=IngredientImage %>" alt="<%=IngredientName %> Image"
                             class="varietal-image w-48 h-48 md:w-64 md:h-64 object-cover rounded-lg shadow-md"
                             onerror="this.onerror=null;this.src='https://placehold.co/256x256/CCCCCC/333333?text=Image+Not+Available';">
                    <% End If %>
                </div>
                <div class="flex-grow md:text-left">
                    <h1 class="text-3xl md:text-4xl font-bold text-gray-800 mb-2"><%=IngredientName %></h1>
                    <p class="text-gray-700 text-lg leading-relaxed"><%=IngredientDescription %></p>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="container-fluid" align="center" style="max-width: 1400px;">

<div class="row">
    <div class="col-lg-12 col-12">
        <div class="detail-section">
            <h2>Nutritional Profile per Serving</h2>
            <p>This profile represents the **average** nutrient content for the **<%=IngredientName %>** ingredient, aggregated across all known varieties.</p>
            
            <ul class="nutrient-list">
                <%
                ' --- 3. Fetch and Aggregate All Nutrients for this Ingredient ---
                Dim rsNutrients, sqlNutrients
                
                ' FINAL CORRECTED QUERY: Joins to NutrientLookup (NL) AND MeasurementLookup (ML)
                sqlNutrients = " SELECT * FROM IngredientNutrient, NutrientLookup, MeasurementLookup " & _
                               " WHERE IngredientNutrient.MeasurementID = MeasurementLookup.MeasurementID " & _
                               " and IngredientNutrient.NutrientID = NutrientLookup.NutrientID and IngredientVarietyPK =" & IngredientvarietyID & " " & _
                               "ORDER BY Nutrient"
                'response.write("sqlNutrients=" & sqlNutrients)
                Set rsNutrients = Server.CreateObject("ADODB.Recordset")
                rsNutrients.Open sqlNutrients, conn, 3, 3

                If Not rsNutrients.EOF Then
                    Do While Not rsNutrients.EOF
                        Dim nutrientName, nutrientSymbol, nutrientDescription, averageAmount, measurementAbbreviation
                        
                        nutrientName = rsNutrients("Nutrient")
                        nutrientSymbol = rsNutrients("Symbol")
                        nutrientDescription = rsNutrients("Description")
                        averageAmount = rsNutrients("NutrientAmount")
                        measurementAbbreviation = rsNutrients("MeasurementAbbreviation") 
                        
                        ' Format the average amount to two decimal places
                        averageAmount = FormatNumber(averageAmount, 2)
                        
                        If IsNull(nutrientSymbol) Then nutrientSymbol = "" Else nutrientSymbol = " (" & nutrientSymbol & ")"
                        
                        ' Handle null measurement gracefully (e.g., if MeasurementLookup data is missing)
                        If IsNull(measurementAbbreviation) Then measurementAbbreviation = "Unit N/A" 
                %>
                        <li class="nutrient-item">
                            <strong><%=nutrientName %>:</strong>
                            <span class="nutrient-value"><%=averageAmount %>&nbsp;<%=measurementAbbreviation %></span>
                            <span class="nutrient-description"><%=nutrientDescription %></span>
                        </li>
                <%
                        rsNutrients.MoveNext
                    Loop
                Else
                %>
                    <li class="nutrient-item text-center" style="border-bottom: none;">
                        <p class="text-gray-600">Nutritional data is currently unavailable for this ingredient.</p>
                    </li>
                <%
                End If
                rsNutrients.Close
                Set rsNutrients = Nothing
                %>
            </ul>
        </div>
    </div>
</div>
</div>

<!--#Include virtual="/members/MembersFooter.asp"-->
</body></html>