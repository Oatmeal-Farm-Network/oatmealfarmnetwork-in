<%
' ===================================================================
' SECTION 1: INITIALIZATION & DATA FETCHING (Corrected)
' ===================================================================

' --- Declare all variables ---
Dim conn, rs, cmd, errorMessage
Dim breeds, categories, colors, associations, states
Dim SpeciesID, country_id, BreedSortID, SpeciesCategoryID, Ancestry
Dim currentminprice, currentmaxprice, ColorSort, RegistrationID, StateIndex, Sortby, Orderby
Dim ProvinceTitle

' --- Get all Form/QueryString values and provide safe defaults ---
SpeciesID         = Request.Form("speciesID")
If Not IsNumeric(SpeciesID) Then SpeciesID = 0
country_id        = Request.Form("country_id")
If Not IsNumeric(country_id) Then country_id = 0
BreedSortID       = Request.Form("BreedSortID")
SpeciesCategoryID = Request.Form("SpeciesCategoryID")
Ancestry          = Request.Form("Ancestry")
currentminprice   = Request.Form("currentminprice")
currentmaxprice   = Request.Form("currentmaxprice")
ColorSort         = Request.Form("ColorSort")
RegistrationID    = Request.Form("RegistrationID")
StateIndex        = Request.Form("StateIndex")
Sortby            = Request.Form("Sortby")
Orderby           = Request.Form("Orderby")
ProvinceTitle     = "State / Province"

Dim i


' --- Check for any connection errors ---
If Err.Number <> 0 Then
    errorMessage = "Database Connection Error: " & Err.Description
Else
    ' --- Connection is good, prepare and execute the single command ---
    Set cmd = Server.CreateObject("ADODB.Command")
    Set cmd.ActiveConnection = conn
    cmd.CommandType = 4 ' adCmdStoredProc
    cmd.CommandText = "sp_GetSearchFilterData"

    cmd.Parameters.Append cmd.CreateParameter("@SpeciesID", 3, 1, , CInt(SpeciesID))
    cmd.Parameters.Append cmd.CreateParameter("@CountryID", 3, 1, , CInt(country_id))

    ' === THE FIX IS HERE ===
    ' 1. Create the recordset object first.
    Set rs = Server.CreateObject("ADODB.Recordset")
    ' 2. Tell it to use a powerful client-side cursor that supports cloning.
    rs.CursorLocation = 3 ' adUseClient
    ' 3. Open the recordset using the command object as the source.
    rs.Open cmd
    ' === END OF FIX ===
    
    If Err.Number <> 0 Then
        errorMessage = "Stored Procedure Execution Error: " & Err.Description
    Else
        ' --- SUCCESS: Now load all data into disconnected recordsets ---
        ' This logic now works perfectly because we have a client-side cursor.
        Set breeds = rs.Clone()
        Set rs = rs.NextRecordset()
        Set categories = rs.Clone()
        Set rs = rs.NextRecordset()
        Set colors = rs.Clone()
        Set rs = rs.NextRecordset()
        Set associations = rs.Clone()
        Set rs = rs.NextRecordset()
        If Not rs Is Nothing Then
            Set states = rs.Clone()
        End If
    End If
End If

Set rs = Nothing
Set cmd = Nothing


' ===================================================================
' SECTION 2: HELPER FUNCTIONS FOR RENDERING HTML
' ===================================================================

' --- Function to generate <option> tags from a recordset ---
Function GenerateOptions(rsData, valueField, textField, selectedValue)
    Dim html, currentValue, currentText
    html = ""
    If Not rsData Is Nothing Then
        If Not rsData.EOF Then
            rsData.MoveFirst
            While Not rsData.EOF
                currentValue = rsData(valueField)
                currentText = rsData(textField)
                html = html & "<option value=""" & currentValue & """"
                If CStr(currentValue) = CStr(selectedValue) Then
                    html = html & " selected"
                End If
                html = html & ">" & Server.HTMLEncode(currentText) & "</option>" & vbCrLf
                rsData.MoveNext
            Wend
        End If
    End If
    GenerateOptions = html
End Function
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* Simple styling for the container */
        body { background-color: #f8f9fa; }
        .search-container { max-width: 240px; background-color: #fff; padding: 20px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
    </style>
</head>
<body>

<div class="container mt-4">
    <div class="search-container">
        <h4 class="mb-3">Search Filters</h4>

        <% ' --- Display a prominent error if the database fetch failed ---
        If Len(errorMessage) > 0 Then %>
            <div class="alert alert-danger">
                <strong>Error:</strong> <%= Server.HTMLEncode(errorMessage) %>
                <p class="small mt-2">Could not load search filters. Please try again later.</p>
            </div>
        <% Else %>
            <form action="Default.asp#Results" id="SearchForm" method="post">
                <input type="hidden" name="speciesID" value="<%=SpeciesID %>">
                <input type="hidden" name="country_id" value="<%=country_id %>">

                <% If Not breeds.EOF And breeds.RecordCount > 1 Then %>
                <div class="mb-3">
                    <label for="BreedSortID" class="form-label">Breed</label>
                    <select id="BreedSortID" name="BreedSortID" class="form-select">
                        <option value="">Any</option>
                        <%=GenerateOptions(breeds, "BreedLookupID", "Breed", BreedSortID) %>
                    </select>
                </div>
                <% End If %>

                <% If CInt(SpeciesID) <> 23 Then %>
                <div class="mb-3">
                    <label for="SpeciesCategoryID" class="form-label">Gender Class</label>
                    <select id="SpeciesCategoryID" name="SpeciesCategoryID" class="form-select">
                        <option value="10000">All Categories</option>
                        <%=GenerateOptions(categories, "SpeciesCategoryID", "SpeciesCategoryPlural", SpeciesCategoryID) %>
                    </select>
                </div>
                <% End If %>

                <% if CInt(SpeciesID) = 2 then %>
                <div class="mb-3">
                     <label for="Ancestry" class="form-label">Ancestry</label>
                     <select id="Ancestry" name="Ancestry" class="form-select">
                        <option value="Any" <% If Ancestry="Any" Or Len(Ancestry)=0 Then Response.Write "selected" %>>All Ancestries</option>
                        <option value="Full Peruvian" <% If Ancestry="Full Peruvian" Then Response.Write "selected" %>>Full Peruvian</option>
                        <option value="Partial Peruvian" <% If Ancestry="Partial Peruvian" Then Response.Write "selected" %>>Partial Peruvian</option>
                        <option value="Full Chilean" <% If Ancestry="Full Chilean" Then Response.Write "selected" %>>Full Chilean</option>
                        <option value="Partial Chilean" <% If Ancestry="Partial Chilean" Then Response.Write "selected" %>>Partial Chilean</option>
                        <option value="Full Bolivian" <% If Ancestry="Full Bolivian" Then Response.Write "selected" %>>Full Bolivian</option>
                        <option value="Partial Bolivian" <% If Ancestry="Partial Bolivian" Then Response.Write "selected" %>>Partial Bolivian</option>
                     </select>
                </div>
                <% end if %>
                
                <div class="mb-3">
                     <label for="currentminprice" class="form-label">Min. Price</label>
                     <select id="currentminprice" name="currentminprice" class="form-select">
                        <option value="0" <% If CStr(currentminprice) = "0" Or Len(currentminprice)=0 Then Response.Write "selected" %>>No Minimum</option>
                        <% Dim minPrices, minPrice
                           minPrices = Array(500, 1000, 5000, 10000, 15000, 50000, 75000)
                           For Each minPrice In minPrices %>
                           <option value="<%=minPrice%>" <%If CStr(minPrice) = CStr(currentminprice) Then Response.Write "selected" %>><%=FormatCurrency(minPrice, 0)%></option>
                           <% Next %>
                     </select>
                </div>
                <div class="mb-3">
                     <label for="currentmaxprice" class="form-label">Max. Price</label>
                     <select id="currentmaxprice" name="currentmaxprice" class="form-select">
                        <option value="100000000" <% If CStr(currentmaxprice)="100000000" Or Len(currentmaxprice)=0 Then Response.Write "selected" %>>No Maximum</option>
                         <% Dim maxPrices, maxPrice
                           maxPrices = Array(1000, 5000, 10000, 15000, 50000, 75000, 100000, 500000, 1000000)
                           For Each maxPrice In maxPrices %>
                           <option value="<%=maxPrice%>" <%If CStr(maxPrice) = CStr(currentmaxprice) Then Response.Write "selected" %>><%=FormatCurrency(maxPrice, 0)%></option>
                           <% Next %>
                     </select>
                </div>
<% end if %>