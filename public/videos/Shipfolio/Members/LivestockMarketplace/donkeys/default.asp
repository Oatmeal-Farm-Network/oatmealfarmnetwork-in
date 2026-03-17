<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <% MasterDashboard= True %>
<!--#Include virtual="/members/Membersglobalvariables.asp"-->
<Title>Harvest Hub</Title>
<meta name="robots" content="nofollow">
<!--#Include file="SpeciesVariables.asp"-->

</head>
<body >
 <!--#Include virtual="/Members/MembersHeader.asp"-->
<style>
/* Place this in the <style> block in your page <head> */

.page-link {
  color: grey;
  margin: 0 3px;

  /* Makes all corners rounded. !important ensures it overrides Bootstrap's default. */
  border-radius: 8px !important; 

  /* Optional: Adds a very subtle shadow to lift the buttons off the page */
  box-shadow: 0 1px 3px rgba(0,0,0,0.08);
}

/* This keeps the active button style we set before */
.page-item.active .page-link {
    background-color: #507033;
    border-color: #aaaaaa;
    color: #fff;
}
</style>

<%
' ===================================================================
' SECTION 1: CONFIGURATION & SETUP
' ===================================================================

' --- Page Configuration ---
Const RECORDS_PER_PAGE = 10

' --- Assumed Variables ---
' This script assumes the following variables are ALREADY SET on the page:
' conn      : A valid, open ADODB.Connection object.
' SpeciesID : An integer representing the current species.
' siteCountryID : An integer for the country to get the correct states/provinces. (e.g., 1 for USA)

' --- Declare all local variables ---
Dim rs, rsFilters, cmd, p ' Database objects
Dim breeds, states ' Recordsets for search form
Dim errorMessage, sql, whereClause, orderClause, searchVariables, hasWhere, pagenumber, recordcount, totalpages, adstart, adend
Dim BreedSortID, StateIndex, currentminprice, currentmaxprice, Ancestry, Sortby, Orderby ' Form inputs

' --- Helper function to get a variable from Form or QueryString ---
Function GetVar(varName, defaultValue)
    Dim val
    val = Request.Form(varName)
    If Len(val) = 0 Then
        val = Request.QueryString(varName)
    End If
    If Len(val) = 0 Then
        GetVar = defaultValue
    Else
        GetVar = Trim(val)
    End If
End Function

' ===================================================================
' SECTION 2: PROCESS SEARCH INPUTS & BUILD THE QUERY
' ===================================================================

' --- Get all search parameters from the request ---
pagenumber          = GetVar("pagenumber", 1)
If Not IsNumeric(pagenumber) Or CInt(pagenumber) < 1 Then pagenumber = 1

BreedSortID         = GetVar("BreedSortID", 0)
StateIndex          = GetVar("StateIndex", 0)
currentminprice     = GetVar("currentminprice", 0)
currentmaxprice     = GetVar("currentmaxprice", 100000000)
Ancestry            = GetVar("Ancestry", "Any")
Sortby              = GetVar("Sortby", "Lastupdated")
Orderby             = GetVar("Orderby", "Desc")

' --- Build the dynamic WHERE clause safely ---
whereClause = "WHERE a.speciesID = " & CInt(SpeciesID) & " AND a.sold = 0 "

If IsNumeric(BreedSortID) And CInt(BreedSortID) > 0 Then whereClause = whereClause & "AND a.BreedID = " & CInt(BreedSortID) & " "
If IsNumeric(StateIndex) And CInt(StateIndex) > 0 Then whereClause = whereClause & "AND a.StateIndex = " & CInt(StateIndex) & " "
If IsNumeric(currentminprice) And CDbl(currentminprice) > 0 Then whereClause = whereClause & "AND a.Price >= " & CDbl(currentminprice) & " "
If IsNumeric(currentmaxprice) And CDbl(currentmaxprice) < 100000000 Then whereClause = whereClause & "AND a.Price <= " & CDbl(currentmaxprice) & " "
Select Case Ancestry
    Case "Full Peruvian"
        whereClause = whereClause & "AND a.PercentPeruvian = 'Full Peruvian' "
    Case "Partial Peruvian"
        ' This finds animals that have a Peruvian percentage but are not Full
        whereClause = whereClause & "AND a.PercentPeruvian <> '' AND a.PercentPeruvian IS NOT NULL AND a.PercentPeruvian <> 'Full Peruvian' "
        
    Case "Full Chilean"
        whereClause = whereClause & "AND a.PercentChilean = 'Full Chilean' "
    Case "Partial Chilean"
        whereClause = whereClause & "AND a.PercentChilean <> '' AND a.PercentChilean IS NOT NULL AND a.PercentChilean <> 'Full Chilean' "
        
    Case "Full Bolivian"
        whereClause = whereClause & "AND a.PercentBolivian = 'Full Bolivian' "
    Case "Partial Bolivian"
        whereClause = whereClause & "AND a.PercentBolivian <> '' AND a.PercentBolivian IS NOT NULL AND a.PercentBolivian <> 'Full Bolivian' "

End Select

' --- Build ORDER BY clause safely using a Select Case ---
Select Case LCase(Sortby)
    Case "breed":       orderClause = "Breed1 " & Orderby
    Case "name":        orderClause = "FullName " & Orderby
    Case "price":       orderClause = "Price " & Orderby
    Case Else:          orderClause = "Lastupdated Desc"
End Select

' --- Build searchvariables string for pagination links ---
searchVariables = "BreedSortID=" & Server.URLEncode(BreedSortID) & "&StateIndex=" & Server.URLEncode(StateIndex) & "&currentminprice=" & Server.URLEncode(currentminprice) & "&currentmaxprice=" & Server.URLEncode(currentmaxprice) & "&Ancestry=" & Server.URLEncode(Ancestry)

' ===================================================================
' SECTION 3: DATABASE INTERACTION (Corrected)
' ===================================================================

On Error Resume Next

' --- Check if the existing connection is valid before using it ---
If conn Is Nothing Or conn.State = 0 Then
    errorMessage = "Database connection is not available."
Else
    ' --- Query 1: Get data for the Search Form Dropdowns ---
    Set cmd = Server.CreateObject("ADODB.Command")
    Set cmd.ActiveConnection = conn
    cmd.CommandType = 4 ' adCmdStoredProc
    cmd.CommandText = "sp_GetSearchFilterData"
    cmd.Parameters.Append cmd.CreateParameter("@SpeciesID", 3, 1, , SpeciesID)
    cmd.Parameters.Append cmd.CreateParameter("@CountryID", 3, 1, , 1228) ' Assumes USA=1228, get this from site settings

    Set rsFilters = Server.CreateObject("ADODB.Recordset")
    rsFilters.CursorLocation = 3 ' adUseClient is required for .Clone
    rsFilters.Open cmd
    
    If Err.Number <> 0 Then
        errorMessage = "Could not load search filter data. SP Error. " & Err.Description
    Else
        ' --- THE FIX IS HERE: Correctly navigate through all recordsets ---
        ' This code is now more robust and navigates correctly.
        
        ' 1. Clone the first recordset (Breeds)
        Set breeds = rsFilters.Clone()

        ' 2. Advance pointer past Categories
        Set rsFilters = rsFilters.NextRecordset()

        ' 3. Advance pointer past Colors
        If Not rsFilters Is Nothing Then Set rsFilters = rsFilters.NextRecordset()
        
        ' 4. Advance pointer past Associations
        If Not rsFilters Is Nothing Then Set rsFilters = rsFilters.NextRecordset()
        
        ' 5. Advance pointer TO States
        If Not rsFilters Is Nothing Then Set rsFilters = rsFilters.NextRecordset()

        ' 6. Now, clone the current recordset (States)
        If Not rsFilters Is Nothing Then Set states = rsFilters.Clone()
        ' --- END OF FIX ---
    End If

    If IsObject(rsFilters) Then If rsFilters.State = 1 Then rsFilters.Close
    Set rsFilters = Nothing
    Set cmd = Nothing
    
    ' --- Query 2: Get the main, paginated animal data ---
    ' This part of the logic remains unchanged and is correct.
    sql = "WITH PagedResults AS ( " & _
          "  SELECT " & _
          "    a.*, b.BusinessName, b.GGWebsite, breed1.Breed AS Breed1, " & _
          "    ROW_NUMBER() OVER (ORDER BY " & orderClause & ") as RowNum, " & _
          "    COUNT(*) OVER () as TotalRecordCount " & _
          "  FROM AnimalDetailsView a " & _
          "  LEFT JOIN Business b ON a.BusinessID = b.BusinessID " & _
          "  LEFT JOIN SpeciesBreedLookupTable breed1 ON a.BreedID = breed1.BreedLookupID " & _
          whereClause & _
          ") " & _
          "SELECT * FROM PagedResults " & _
          "WHERE RowNum BETWEEN " & ((pagenumber - 1) * RECORDS_PER_PAGE + 1) & " AND " & (pagenumber * RECORDS_PER_PAGE)

    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3 ' adOpenStatic, adLockReadOnly

    If Err.Number <> 0 Then
        errorMessage = "Search query failed. Check search criteria."
        ' To debug, uncomment the line below
        ' errorMessage = errorMessage & "<pre>" & sql & "</pre>"
    Else
        If Not rs.EOF Then recordcount = rs("TotalRecordCount") Else recordcount = 0
    End If
End If

On Error Goto 0

' --- Pagination Calculations ---
totalpages = 0
If recordcount > 0 Then totalpages = Int((recordcount + RECORDS_PER_PAGE - 1) / RECORDS_PER_PAGE)
adstart = (pagenumber - 1) * RECORDS_PER_PAGE + 1
adend = pagenumber * RECORDS_PER_PAGE
If adend > recordcount Then adend = recordcount

' ===================================================================
' SECTION 4: HELPER SUBROUTINES FOR RENDERING HTML
' ===================================================================

Sub RenderPagination(currentPage, totalPages, searchVars)
    ' Exit immediately if there's only one page or no pages to show.
    If CInt(totalPages) <= 1 Then Exit Sub

    ' --- TEMPORARY DEBUGGING LINE ---
    ' This line prints the raw values to your HTML source code so we can see them.
    Response.Write ""
    ' --- END DEBUGGING LINE ---

    ' Convert variables to integers for reliable comparison and math
    Dim intCurrentPage, intTotalPages
    If IsNumeric(currentPage) Then intCurrentPage = CInt(currentPage) Else intCurrentPage = 1
    If IsNumeric(totalPages) Then intTotalPages = CInt(totalPages) Else intTotalPages = 0
    
    Dim k, pageToShow

    ' Start the navigation HTML.
    Response.Write "<nav aria-label=""Page navigation"" class=""mb-4""><ul class=""pagination"">"
    
    ' --- FIRST & PREVIOUS BUTTONS (CORRECTED) ---
    ' Using the integer version of currentPage for comparison
    If intCurrentPage > 1 Then
        Response.Write "<li class=""page-item""><a class=""page-link"" href=""?pagenumber=1&" & searchVars & """>First</a></li>"
        Response.Write "<li class=""page-item""><a class=""page-link"" href=""?pagenumber=" & (intCurrentPage - 1) & "&" & searchVars & """>Previous</a></li>"
    Else
        Response.Write "<li class=""page-item disabled""><span class=""page-link"">First</span></li>"
        Response.Write "<li class=""page-item disabled""><span class=""page-link"">Previous</span></li>"
    End If
    
    ' --- CURRENT PAGE NUMBER (Responsive) ---
    Response.Write "<li class=""page-item active d-none d-md-block"" aria-current=""page""><span class=""page-link"">" & intCurrentPage & "</span></li>"
    
    ' --- NEXT 3 PAGE NUMBERS ---
    For k = 1 to 3
        pageToShow = intCurrentPage + k
        If pageToShow <= intTotalPages Then
            Response.Write "<li class=""page-item d-none d-md-block""><a class=""page-link"" href=""?pagenumber=" & pageToShow & "&" & searchVars & """>" & pageToShow & "</a></li>"
        Else
            Exit For
        End If
    Next
    
    ' --- NEXT & LAST BUTTONS ---
    If intCurrentPage < intTotalPages Then
        Response.Write "<li class=""page-item""><a class=""page-link"" href=""?pagenumber=" & (intCurrentPage + 1) & "&" & searchVars & """>Next</a></li>"
        Response.Write "<li class=""page-item""><a class=""page-link"" href=""?pagenumber=" & intTotalPages & "&" & searchVars & """>Last</a></li>"
    Else
        Response.Write "<li class=""page-item disabled""><span class=""page-link"">Next</span></li>"
        Response.Write "<li class=""page-item disabled""><span class=""page-link"">Last</span></li>"
    End If
    
    Response.Write "</ul></nav>"
End Sub

Function GenerateOptions(rsData, valueField, textField, selectedValue, defaultText, defaultValue)
    Dim html: html = "<option value=""" & defaultValue & """>" & defaultText & "</option>" & vbCrLf
    If rsData Is Nothing Or rsData.State = 0 Then GenerateOptions = html: Exit Function
    If Not rsData.EOF Then rsData.MoveFirst
    While Not rsData.EOF
        html = html & "<option value=""" & rsData(valueField) & """"
        If CStr(rsData(valueField)) = CStr(selectedValue) Then html = html & " selected"
        html = html & ">" & Server.HTMLEncode(rsData(textField)) & "</option>" & vbCrLf
        rsData.MoveNext
    Wend
    GenerateOptions = html
End Function
%>

<div class="container-fluid mt-4">
    <div class="row">
        <div class="col-lg-3">
            <div class="p-3 border rounded bg-light">
                <h4>Search Filters</h4>
                <form action="<%=Request.ServerVariables("SCRIPT_NAME")%>#Results" id="SearchForm" method="post">
                    <div class="mb-3">
                        <label for="BreedSortID" class="form-label">Breed</label>
                        <select id="BreedSortID" name="BreedSortID" class="form-select">
                            <%=GenerateOptions(breeds, "BreedLookupID", "Breed", BreedSortID, "Any Breed", 0) %>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="StateIndex" class="form-label">State / Province</label>
                        <select id="StateIndex" name="StateIndex" class="form-select">
                           <%=GenerateOptions(states, "StateIndex", "name", StateIndex, "Any State", 0) %>
                        </select>
                    </div>

                    <div class="row">
                        <div class="col-6 mb-3"><label for="currentminprice" class="form-label">Min. Price</label><select id="currentminprice" name="currentminprice" class="form-select"><option value="0">Any</option><option value="500" <% If CStr(currentminprice)="500" Then Response.Write "selected" %>>$500</option><option value="1000" <% If CStr(currentminprice)="1000" Then Response.Write "selected" %>>$1,000</option></select></div>
                        <div class="col-6 mb-3"><label for="currentmaxprice" class="form-label">Max. Price</label><select id="currentmaxprice" name="currentmaxprice" class="form-select"><option value="100000000">Any</option><option value="5000" <% If CStr(currentmaxprice)="5000" Then Response.Write "selected" %>>$5,000</option><option value="10000" <% If CStr(currentmaxprice)="10000" Then Response.Write "selected" %>>$10,000</option></select></div>
                    </div>
                    <div class="d-grid"><button type="submit" class="regsubmit">Apply Filters&nbsp;</button></div>
                </form>
            </div>
        </div>

        <div class="col-lg-9">
            <a name="Results"></a>
            <div class="d-flex justify-content-between align-items-center mb-3">
                <div class="fw-bold">
                    <% If recordcount > 0 Then %> <%=adstart%> - <%=adend%> of <%=recordcount%> Results<% End If %>
                </div>
            </div>

            <% Call RenderPagination(pagenumber, totalpages, searchVariables) %>

            <% If Len(errorMessage) > 0 Then %>
                <div class="alert alert-danger"><strong>Error:</strong> <%=errorMessage%></div>
            <% ElseIf recordcount = 0 Then %>
                <div class="body"><h4>No Results Found</h4></div>
            <% Else %>
                <% While Not rs.EOF %>
                <div class="card mb-3">
                    <div class="card-header" style="background:#507033"><a href="/members/Animals/Details.asp?ID=<%=rs("ID")%>" class="text-white text-decoration-none h5"><%=rs("FullName")%></a></div>
                    <div class="row g-0">
                        <div class="col-md-4 text-center p-2">
                          <% Photo1 = rs("Photo1")
                          if len(Photo1) > 3 then 
                          else 
                          Photo1="/uploads/ImageNotAvailable.webp" 
                          end if %>
                          <img src="<%=Photo1%>" class="img-fluid rounded" alt="<%=rs("FullName")%>" style="max-height: 200px;"></div>
                        <div class="col-md-8"><div class="card-body">
                            <p class="card-text">
                                <strong>Price:</strong> <% If IsNumeric(rs("Price")) And len(rs("Price")) > 0 Then Response.Write(FormatCurrency(rs("Price"), 0)) Else Response.Write("Call for Price") %><br/>
                                <strong>Breed:</strong> <%=rs("Breed1")%><br/>
                                <strong>Location:</strong> <%=rs("AddressCity")%>, <%=rs("AddressState")%><br/>
                                <strong>Seller:</strong> <%=rs("BusinessName")%>
                            </p><a href="/members/Animals/Details.asp?ID=<%=rs("ID")%>" class="btn btn-secondary btn-sm">View Details</a>
                        </div></div>
                    </div>
                </div>
                <% rs.MoveNext : Wend %>
            <% End If %>

            <% Call RenderPagination(pagenumber, totalpages, searchVariables) %>

        </div>
    </div>
</div>

<%
' ===================================================================
' SECTION 5: CLEANUP
' ===================================================================
' The calling page is responsible for closing the global 'conn' object.
If IsObject(rs) Then
    If rs.State = 1 Then rs.Close
    Set rs = Nothing
End If
If IsObject(breeds) Then Set breeds = Nothing
If IsObject(states) Then Set states = Nothing
%>


<!--#Include virtual="/Members/MembersFooter.asp"-->

</body>
</html>