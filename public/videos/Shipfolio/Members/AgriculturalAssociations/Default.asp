<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<% MasterDashboard= True %>
<!--#Include virtual="/Members/Membersglobalvariables.asp"-->
<!--#Include file="SpeciesVariables.asp"-->
<title><%=Current%> Directory</title>
<META name="Title" content="<%=SingularBreed %>" Ranches" />
<META name="description" content="Find <%=Current%> on <%=WebSiteName %>.." />
<meta name="robots" content="index,follow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="revisit-after" content="7"/>
<meta name="Googlebot" content="index, follow"/>
<meta name="robots" content="All"/>
<meta name="subject" content="<%=Current%>" Directory" />
</HEAD>
<body >

<!--#Include virtual="/members/membersHeader.asp"-->
<%
Dim BusinessTypeID : BusinessTypeID = 1 
BusinessTypeName = "Agricultural Associations"
BusinessTypeIcon = "/icons/Assoc-administration-icon.svg"

' NOTE: This rewritten code assumes 'conn' (your database connection object)
' is established and available globally or included from another file.
' It also assumes 'Icon' and 'current' variables are set elsewhere if used.

' Centralize database connection and recordset
' (Assuming conn is already set up and open)

' Initialize variables early
Dim Currentcountry_id, Currentname, ProvinceTitle
Dim State, StateIndex, Name, Ownersearch
Dim sql, sql2, province, TempStateIndex, selected
Dim RanchName, namesort, ownersort, statesort, citysort
Dim totalrecords, pagescount, totalpages, pagenumber, startlimit, endlimit, adstart, adend, maxPageDisplay
Dim BusinessID, weblink, BusinessName, AddressStreet, AddressApt, AddressCity, AddressState, AddressZip, AddressCountry
Dim WebsitesID, PeopleWebsite, PeoplePhone
Dim BusinessFacebook, BusinessX, BusinessInstagram, BusinessPinterest, BusinessTruthSocial, BusinessBlog, BusinessYouTube, BusinessOtherSocial1, BusinessOtherSocial2
Dim ShowRanchLinks, LinkText, RanchProfileLink, RanchLink
Dim Logo, str1, str2, x
Dim AdFooterID(100), AdFooterImage(100), AdFooterLink(100)
Dim AdYear, AdMonth, ShowOnLOA, Lastmonth

' Set up ADODB Recordset objects
Set rs = Server.CreateObject("ADODB.Recordset")
Set rs2 = Server.CreateObject("ADODB.Recordset")

' --- Handle Form Submissions and Query String Parameters ---
Currentcountry_id = Request.Form("country_id")
If Len(Currentcountry_id) = 0 Then
Currentcountry_id = 1228
End If

State = Request.Form("State")
If Len(State) = 0 Then
State = Request.QueryString("State")
End If

StateIndex = Request.Form("StateIndex")
If Len(StateIndex) = 0 Then
StateIndex = Request.QueryString("StateIndex")
If Len(StateIndex) < 1 Then StateIndex = 0
End If

Name = Request.Form("Name")
If Len(Name) = 0 Then
Name = Request.QueryString("Name")
End If

Ownersearch = Request.Form("Ownersearch")
If Len(Ownersearch) = 0 Then
Ownersearch = Request.QueryString("Ownersearch")
End If

pagenumber = Request.QueryString("pagenumber")
If Len(pagenumber) = 0 Then
pagenumber = 1
End If
pagenumber = CInt(pagenumber) ' Ensure it's an integer

' --- Get Country and Province Title ---
sql = "SELECT name, ProvinceTitle FROM country WHERE country_id = " & Currentcountry_id
rs.Open sql, conn, 3, 3
If Not rs.EOF Then
Currentname = rs("name")
ProvinceTitle = rs("ProvinceTitle")
Else
Currentname = "Unknown"
ProvinceTitle = "State/Province" ' Default if not found
End If
rs.Close

' --- Define search criteria ---
namesort = ""
If Len(Name) > 0 Then
namesort = " AND LOWER(BusinessName) LIKE '%" & LCase(Name) & "%' "
End If

ownersort = ""
Dim ShowOwnerSearch : ShowOwnerSearch = False ' Control this via config or another variable if needed
If ShowOwnerSearch = True And Len(Ownersearch) > 0 Then
ownersort = " AND LOWER(Owners) LIKE '%" & LCase(Ownersearch) & "%' " ' Assuming Owners field exists
End If

statesort = ""
If CInt(StateIndex) > 0 And CInt(StateIndex) <> 10000 Then
statesort = " AND StateIndex = " & StateIndex & " "
End If

citysort = "" ' No city search parameter seems to be processed in the original code, but kept for consistency
' If Len(City) > 0 Then
' citysort = " AND LOWER(AddressCity) LIKE '%" & LCase(City) & "%' "
' End If



sql = "SELECT BusinessID, BusinessName, Logo, weblink, AddressStreet, AddressApt, AddressCity, AddressState, AddressZip, WebsitesID, " & _
"BusinessFacebook, BusinessX, BusinessInstagram, BusinessPinterest, BusinessTruthSocial, BusinessBlog, BusinessYouTube, BusinessOtherSocial1, BusinessOtherSocial2 " & _
"FROM BusinessView WHERE BusinessTypeID = " & BusinessTypeID & " AND country_id = " & Currentcountry_id & " " & _
statesort & citysort & namesort & ownersort & _
" ORDER BY custLastAccess DESC, BusinessName, Logo ASC"

' IMPORTANT DEBUGGING: Add error handling for the main query
On Error Resume Next ' Temporarily enable error handling
rs.Open sql, conn, 3, 3
If Err.Number <> 0 Then
    Response.Write "<p style='color:red;'><b>Database Query Error:</b> " & Server.HTMLEncode(Err.Description) & "<br>SQL: " & Server.HTMLEncode(sql) & "</p>"
    totalrecords = 0 ' Set totalrecords to 0 to prevent further errors
    rs.Close ' Ensure recordset is closed
    Set rs = Nothing ' Release object
Else
    totalrecords = rs.RecordCount
End If
On Error GoTo 0 ' Disable error handling

If totalrecords = 0 Then
totalpages = 0
Else
totalpages = Int((totalrecords - 1) / 10) + 1
End If

If pagenumber > totalpages And totalpages > 0 Then pagenumber = totalpages
If pagenumber < 1 And totalpages > 0 Then pagenumber = 1

adstart = (pagenumber - 1) * 10
adend = adstart + 9 ' 0-indexed for ADODB .Move

' IMPORTANT DEBUGGING: Verify recordset state before move
Response.Write "" & VbCrLf
Response.Write "" & VbCrLf
Response.Write "" & VbCrLf
Response.Write "" & VbCrLf
Response.Write "" & VbCrLf
Response.Write "" & VbCrLf

If Not rs.EOF And adstart < totalrecords Then
    rs.MoveFirst
    Response.Write "" & VbCrLf
    Response.Write "" & VbCrLf
    
    If adstart > 0 Then ' Only move if not the first record
        rs.Move adstart
    End If
    Response.Write "" & VbCrLf
    Response.Write "" & VbCrLf
Else
    Response.Write "" & VbCrLf
End If

' Define the function to validate and correct the link
Function ValidateAndFixLink(link)
If IsNull(link) Or Len(link) = 0 Then
ValidateAndFixLink = ""
Exit Function
End If

link = Trim(link)
If InStr(LCase(link), "http://") = 1 Then
link = "https://" & Mid(link, 8) ' Change http to https
ElseIf InStr(LCase(link), "https://") <> 1 Then
link = "https://" & link
End If

' Basic validation: check for spaces and if it looks like a URL
If InStr(link, " ") = 0 And InStr(link, ".") > 0 And InStr(link, "/") > 0 Then
ValidateAndFixLink = link
Else
ValidateAndFixLink = ""
End If
End Function

' --- Fetch Footer Ads (consider moving this to an include or caching) ---
Dim footerAdCount : footerAdCount = 0
Query = "SELECT TOP 3 AdID, AdImage, AdLink FROM Ads WHERE ShowonLOA = 1 AND AdType='Logo' ORDER BY NEWID()"
rs2.Open Query, conn, 3, 3
x = 0
While Not rs2.EOF And x < 3
AdFooterID(x) = rs2("AdID")
AdFooterImage(x) = rs2("AdImage")
AdFooterLink(x) = ValidateAndFixLink(rs2("AdLink"))

If Len(AdFooterLink(x)) = 0 Then
' Fallback if link is invalid or empty
AdFooterLink(x) = "FarmListing.asp?CurrentBusinessID=" & BusinessID ' This BusinessID might be from the main loop, so be careful if ads are independent.
End If

' Update AdStats for impressions (consider a more robust tracking method than direct insert on page load)
' This should ideally be handled async or in a separate process/include for performance
' If Len(AdFooterLink(x)) > 0 Then
' Dim statQuery : statQuery = "INSERT INTO AdStats (AdID, ClickDate, AdType, Impression) Values ('" & AdFooterID(x) & "', GETDATE(), 'Logo', 1)"
' Conn.Execute(statQuery)
' End If
x = x + 1
rs2.MoveNext
Wend
footerAdCount = x ' Store actual number of ads retrieved
rs2.Close
%>

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<style>
/* General Body and Container Styles */
body {
font-family: Arial, sans-serif;
margin: 0;
padding: 0;
background-color: #f0f2f5;
}

.container-main {
max-width: 1200px;
margin: 0 auto;
padding: 20px;
background-color: #fff;
box-shadow: 0 0 10px rgba(0,0,0,0.1);
border-radius: 8px;
}

/* Header/Navigation Styles */
.header {
background-color: #f7f7f7;
padding: 10px 20px;
border-bottom: 1px solid #eee;
display: flex;
justify-content: space-between;
align-items: center;
border-radius: 8px 8px 0 0;
}
.header .logo img {
height: 50px;
}
.header .nav-links a {
margin-left: 15px;
text-decoration: none;
color: #333;
}
.header .login-btn {
background-color: #6a9c3d;
color: white;
padding: 8px 15px;
border-radius: 5px;
text-decoration: none;
}

/* Search Section Styles */
.search-section-wrapper {
background-color: #f9f9f9;
padding: 20px;
border: 1px solid #eee;
border-radius: 8px;
margin-bottom: 20px;
}

h2.section-title {
text-align: center;
color: #333;
margin-bottom: 20px;
font-size: 1.8em;
}

.search-form-grid {
display: grid;
grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
gap: 20px;
align-items: end;
}

.search-group {
display: flex;
flex-direction: column;
gap: 5px;
}

.search-group label {
font-weight: bold;
color: #555;
margin-bottom: 3px;
}

.search-group input[type="text"],
.search-group select {
padding: 8px 12px;
border: 1px solid #ddd;
border-radius: 4px;
width: 100%;
box-sizing: border-box;
background-color: #fff;
}



/* Results Section */
.results-section {
padding: 0 10px;
}

.pagination {
text-align: center;
margin-top: 20px;
padding: 10px;
border-top: 1px solid #eee;
display: flex;
flex-wrap: wrap;
justify-content: center;
gap: 8px;
}

.pagination a, .pagination span {
display: inline-flex;
align-items: center;
justify-content: center;
min-width: 36px;
height: 36px;
padding: 0 10px;
border: 1px solid #ddd;
text-decoration: none;
color: #333;
border-radius: 4px;
box-sizing: border-box;
}

.pagination a:hover {
background-color: #f0f0f0;
}

.pagination span.current-page {
background-color: #6a9c3d;
color: white;
border-color: #6a9c3d;
font-weight: bold;
}

/* Association Card (Farm Listing) */
.association-card {
background-color: #fefefe;
border: 1px solid #ddd;
border-radius: 8px;
margin-bottom: 20px;
padding: 15px;
display: flex;
align-items: flex-start;
gap: 15px;
flex-wrap: wrap;
transition: transform 0.2s ease-in-out;
}

.association-card:hover {
transform: translateY(-3px);
}

.association-card.st-augustine {
background-color: #c0d990;
}

.association-card .logo-img {
width: 100px;
height: 100px;
border-radius: 8px;
object-fit: contain;
border: 1px solid #eee;
flex-shrink: 0;
}
.association-card .details {
flex-grow: 1;
}
.association-card h3 {
margin: 0 0 8px 0;
color: #333;
font-size: 1.3em;
}
.association-card p {
margin: 0 0 5px 0;
color: #666;
font-size: 0.95em;
line-height: 1.4;
}
.association-card .profile-btn {
background-color: #6a9c3d;
color: white;
padding: 10px 20px;
border-radius: 5px;
text-decoration: none;
font-size: 1em;
white-space: nowrap;
margin-top: 10px;
display: inline-block;
}
.association-card .profile-btn:hover {
background-color: #5a8b2d;
}

.association-card .social-icons img {
height: 24px;
width: 24px;
margin-right: 8px;
vertical-align: middle;
}

/* Utility for formbox */
.formbox {
width: 100%;
padding: .375rem .75rem;
font-size: 1rem;
line-height: 1.5;
color: #495057;
background-color: #fff;
background-clip: padding-box;
border: 1px solid #ced4da;
border-radius: .25rem;
transition: border-color .15s ease-in-out,box-shadow .15s ease-in-out;
}

.AnimalListname {
color: white;
font-size: 1.5em;
font-weight: bold;
text-decoration: none;
}
.AnimalListname:hover {
color: lightgray;
text-decoration: underline;
}

.body2 {
color: #6a9c3d;
text-decoration: none;
}
.body2:hover {
text-decoration: underline;
}

/* --- CUSTOM BUTTON LAYOUT AND RESPONSIVENESS --- */

.button-group-container {
display: flex;
align-items: center;
gap: 10px;
width: 100%;
padding-top: 10px;
justify-content: flex-end;
}

.small-reset-button {
padding: 5px 10px;
font-size: 0.85em;
background-color: #f0f0f0;
color: #555;
border: 1px solid #ccc;
flex-shrink: 0;
width: 80px;
text-align: center;
}

.small-reset-button:hover {
background-color: #e0e0e0;
color: #333;
}

.apply-filters-button {
flex-grow: 0;
flex-shrink: 0;
width: auto;
}

/* Override the general .search-group button rule for this specific button group */
.search-group.button-group-container button {
width: auto !important;
margin-top: 0 !important;
box-sizing: border-box;
}
.search-group.button-group-container .apply-filters-button {
width: auto !important;
}


/* Media Queries for Responsive Adjustments */

@media (max-width: 992px) {
.search-form-grid {
grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
}
.button-group-container {
justify-content: flex-end;
}
.small-reset-button {
width: 80px;
}
.apply-filters-button {
width: auto;
}
}

@media (max-width: 768px) {
.search-form-grid {
grid-template-columns: 1fr;
}
.search-group {
align-items: flex-start;
}
.button-group-container {
flex-direction: row;
justify-content: flex-end;
align-items: center;
}
.small-reset-button {
width: 80px;
padding: .375rem .75rem;
font-size: 1rem;
}
.apply-filters-button {
width: auto;
}
}

@media (max-width: 480px) {
.container-main {
padding: 10px;
}
.header {
flex-direction: column;
text-align: center;
padding: 10px;
}
.header .nav-links {
margin-top: 10px;
}
.header .nav-links a {
margin: 0 8px;
}
.search-section-wrapper {
padding: 15px;
}
.association-card {
padding: 10px;
}
.pagination {
padding: 5px;
}

.button-group-container {
flex-direction: column;
align-items: stretch;
justify-content: flex-start;
}
.small-reset-button,
.apply-filters-button {
width: 100%;
margin-bottom: 10px;
padding: 8px 15px;
font-size: 1em;
}
.button-group-container button:last-child {
margin-bottom: 0;
}
}
</style>



<div class="container-main">
<div class="row justify-content-center">
<div ">
<h1>
<img src="<%=BusinessTypeIcon %>" class="img-fluid" style="max-width: 70px; max-height: 70px; object-fit: contain;" alt="<%=BusinessTypeName%>">
&nbsp;<%=BusinessTypeName%>
</h1>
</div>
</div>

<div class="search-section-wrapper">
<form method="POST" action="" class="search-form-grid">
<input type="hidden" name="pagenumber" value="1">

<div class="search-group">
<% ' Querying ALL countries directly from the 'country' table %>
<% sql = "SELECT country_id, name FROM country ORDER BY name" %>
<label for="country_id">Country</label>
<select id="country_id" name="country_id" class="formbox">
<% rs2.Open sql, conn, 3, 3
While Not rs2.EOF
Dim tempCountryId : tempCountryId = rs2("country_id")
Dim countryName : countryName = rs2("name")
selected = ""
If CInt(Currentcountry_id) = CInt(tempCountryId) Then
selected = "selected"
End If
%>
<option value="<%=tempCountryId %>" <%=selected%>><%=countryName %></option>
<%
rs2.MoveNext
Wend
rs2.Close
%>
</select>
</div>

<div class="search-group">
<label for="StateIndex"><%=ProvinceTitle %></label>
<select id="StateIndex" name="StateIndex" class="formbox">
<option value="10000" <% If CInt(StateIndex) = 10000 Then Response.Write "selected" %>>Any</option>
<%
' This SQL is for initial page load; JavaScript updates on country change
sql = "SELECT StateIndex, name FROM state_province WHERE country_id = " & Currentcountry_id & " ORDER BY name"
rs2.Open sql, conn, 3, 3
While Not rs2.EOF
Dim tempStateIdx : tempStateIdx = rs2("StateIndex")
Dim stateName : stateName = rs2("name")
selected = ""
If CInt(StateIndex) = CInt(tempStateIdx) Then
selected = "selected"
End If
%>
<option value="<%=tempStateIdx %>" <%=selected%>><%=stateName %></option>
<%
rs2.MoveNext
Wend
rs2.Close
%>
</select>
</div>

<div class="search-group">
<label for="Name">Business Name</label>
<input type="text" id="Name" name="Name" value="<%=Server.HTMLEncode(Name) %>" class="formbox" placeholder="Search by name">
</div>

<% If ShowOwnerSearch = True Then %>
<div class="search-group">
<label for="Ownersearch">Owners' Name</label>
<input type="text" id="Ownersearch" name="Ownersearch" value="<%=Server.HTMLEncode(Ownersearch) %>" class="formbox" placeholder="Search by owner">
</div>
<% End If %>

<div class="">
<button type="submit" class="regsubmit2">Apply Filters</button>
</div>
</form>

<% If footerAdCount > 0 Then %>
<div class="text-center mt-4">
<% For x = 0 To footerAdCount - 1 %>
<% If Len(AdFooterLink(x)) > 0 Then %>
<a href="<%=AdFooterLink(x) %>" target="_blank" class="d-inline-block mx-2 mb-2">
<img src="<%= AdFooterImage(x)%>" width="200" style="max-width:200px" border="0" alt="Advertisement">
</a>
<% End If %>
<% Next %>
</div>
<% End If %>
</div>
<div class="results-section">
<div class="text-right mb-3">
<% If totalrecords > 0 Then %>
<p class="mb-0 text-muted"><%= adstart + 1 %> - <%
If (adend + 1) > totalrecords Then
Response.Write totalrecords
Else
Response.Write (adend + 1)
End If
%> of <%= totalrecords %> Results</p>
<% End If %>
</div>

<div class="pagination">
<% If totalpages > 1 Then %>
<% If pagenumber > 1 Then %>
<a href="?country_id=<%=Currentcountry_id%>&StateIndex=<%= StateIndex %>&Name=<%= Server.URLEncode(Name) %>&Ownersearch=<%= Server.URLEncode(Ownersearch) %>&pagenumber=1" class="NumLinks">1st</a>
<a href="?country_id=<%=Currentcountry_id%>&StateIndex=<%= StateIndex %>&Name=<%= Server.URLEncode(Name) %>&Ownersearch=<%= Server.URLEncode(Ownersearch) %>&pagenumber=<%= pagenumber - 1 %>" class="NumLinks">&lt;</a>
<% End If %>

<%
maxPageDisplay = 5
Dim pageRangeStart, pageRangeEnd

pageRangeStart = pagenumber - Int(maxPageDisplay / 2)
If pageRangeStart < 1 Then pageRangeStart = 1

pageRangeEnd = pageRangeStart + maxPageDisplay - 1
If pageRangeEnd > totalpages Then
pageRangeEnd = totalpages
pageRangeStart = pageRangeEnd - maxPageDisplay + 1
If pageRangeStart < 1 Then pageRangeStart = 1
End If

For i = pageRangeStart To pageRangeEnd %>
<% If i = pagenumber Then %>
<span class="pagination-link current-page"><b><%= i %></b></span>
<% Else %>
<a href="?country_id=<%=Currentcountry_id%>&StateIndex=<%= StateIndex %>&Name=<%= Server.URLEncode(Name) %>&Ownersearch=<%= Server.URLEncode(Ownersearch) %>&pagenumber=<%= i %>" class="NumLinks">
<%= i %>
</a>
<% End If %>
<% Next %>

<% If pagenumber < totalpages Then %>
<a href="?country_id=<%=Currentcountry_id%>&StateIndex=<%= StateIndex %>&Name=<%= Server.URLEncode(Name) %>&Ownersearch=<%= Server.URLEncode(Ownersearch) %>&pagenumber=<%= pagenumber + 1 %>" class="NumLinks">&gt;</a>
<a href="?country_id=<%=Currentcountry_id%>&StateIndex=<%= StateIndex %>&Name=<%= Server.URLEncode(Name) %>&Ownersearch=<%= Server.URLEncode(Ownersearch) %>&pagenumber=<%= totalpages %>" class="NumLinks">Last</a>
<% End If %>
<% End If %>
</div>

<% ' --- START: Debugging output for results section --- %>
<% Response.Write "" & VbCrLf %>
<% Response.Write "" & VbCrLf %>
<% Response.Write "" & VbCrLf %>
<% Response.Write "" & VbCrLf %>
<% Response.Write "" & VbCrLf %>
<% If Not rs Is Nothing And rs.State = 1 Then %>
<% Response.Write "" & VbCrLf %>
<% Response.Write "" & VbCrLf %>
<% Else %>
<% Response.Write "" & VbCrLf %>
<% End If %>
<% ' --- END: Debugging output for results section --- %>


<% If rs.EOF Then %>
<p class="text-center mt-5">We currently do not have any listings that fit that criteria.</p>
<% Else %>
<% Dim currentRecordNum : currentRecordNum = adstart + 1 %>
<% While Not rs.EOF And currentRecordNum <= (adstart + 10) And currentRecordNum <= totalrecords %>
<%
' Retrieve data for the current record, ensuring NULL values are handled
BusinessID = rs("BusinessID")
weblink = "" : If Not IsNull(rs("weblink")) Then weblink = rs("weblink")
BusinessName = "" : If Not IsNull(rs("BusinessName")) Then BusinessName = rs("BusinessName")
AddressStreet = "" : If Not IsNull(rs("AddressStreet")) Then AddressStreet = rs("AddressStreet")
AddressApt = "" : If Not IsNull(rs("AddressApt")) Then AddressApt = rs("AddressApt")
AddressCity = "" : If Not IsNull(rs("AddressCity")) Then AddressCity = rs("AddressCity")
AddressState = "" : If Not IsNull(rs("AddressState")) Then AddressState = rs("AddressState")
AddressZip = "" : If Not IsNull(rs("AddressZip")) Then AddressZip = rs("AddressZip")
WebsitesID = "" : If Not IsNull(rs("WebsitesID")) Then WebsitesID = rs("WebsitesID")
BusinessFacebook = "" : If Not IsNull(rs("BusinessFacebook")) Then BusinessFacebook = rs("BusinessFacebook")
BusinessX = "" : If Not IsNull(rs("BusinessX")) Then BusinessX = rs("BusinessX")
BusinessInstagram = "" : If Not IsNull(rs("BusinessInstagram")) Then BusinessInstagram = rs("BusinessInstagram")
BusinessPinterest = "" : If Not IsNull(rs("BusinessPinterest")) Then BusinessPinterest = rs("BusinessPinterest")
BusinessTruthSocial = "" : If Not IsNull(rs("BusinessTruthSocial")) Then BusinessTruthSocial = rs("BusinessTruthSocial")
BusinessBlog = "" : If Not IsNull(rs("BusinessBlog")) Then BusinessBlog = rs("BusinessBlog")
BusinessYouTube = "" : If Not IsNull(rs("BusinessYouTube")) Then BusinessYouTube = rs("BusinessYouTube")
BusinessOtherSocial1 = "" : If Not IsNull(rs("BusinessOtherSocial1")) Then BusinessOtherSocial1 = rs("BusinessOtherSocial1")
BusinessOtherSocial2 = "" : If Not IsNull(rs("BusinessOtherSocial2")) Then BusinessOtherSocial2 = rs("BusinessOtherSocial2")
Logo = "" : If Not IsNull(rs("Logo")) Then Logo = rs("Logo")

' Get Country Name for display (using rs2 for this)
AddressCountry = ""
sql2 = "SELECT name FROM Country WHERE country_id = " & Currentcountry_id
rs2.Open sql2, conn, 3, 3
If Not rs2.EOF Then
AddressCountry = rs2("name")
End If
rs2.Close

' Get PeopleWebsite (Assuming it's related to WebsitesID)
PeopleWebsite = ""
If WebsitesID <> "" Then ' WebsitesID should be a string here if initialized with ""
If IsNumeric(WebsitesID) Then ' Ensure it's numeric before using in SQL
sql2 = "SELECT Website FROM Websites WHERE WebsitesID = " & WebsitesID
rs2.Open sql2, conn, 3, 3
If Not rs2.EOF Then
PeopleWebsite = rs2("Website")
End If
rs2.Close
End If
End If

' Clean and validate Logo URL
If Len(Logo) > 2 Then
Logo = Replace(LCase(Logo), "http://www.alpacainfinity.com", "https://www.OatmealFarmNetwork.com")
Logo = Replace(LCase(Logo), "https://www.livestockoftheworld.com", "") ' Blank if this specific URL
Logo = Replace(LCase(Logo), "http:", "https:") ' Ensure HTTPS
Else
Logo = "" ' Ensure Logo is empty string if null or too short
End If

' Determine RanchLink and RanchProfileLink
ShowRanchLinks = False ' Set this boolean based on your application logic
If ShowRanchLinks Then
LinkText = "View Listing"
RanchProfileLink = "FarmListing.asp?BusinessID=" & BusinessID
RanchLink = RanchProfileLink ' Use same link if viewing listing
Else
LinkText = "Contact"
RanchLink = "FarmListing.asp?CurrentBusinessID=" & BusinessID ' Assuming this is for a general contact page
RanchProfileLink = "FarmListing.asp?BusinessID=" & BusinessID ' This is for the profile button
End If

                        ' IMPORTANT DEBUGGING: Output current record details
                        Response.Write "" & VbCrLf
                        Response.Write "" & VbCrLf
                        Response.Write "" & VbCrLf
                        Response.Write "" & VbCrLf
                        Response.Write "" & VbCrLf
%>

<div class="association-card">
<% ' Ensure Logo exists and is valid before showing logo container %>
<% If Len(Logo) > 4 Then %>
<div class="logo-container">
<a href="<%=RanchLink %>">
<img src="<%=Logo%>" class="logo-img" alt="<%=Server.HTMLEncode(BusinessName)%> Logo" onerror="this.style.display='none';" />
</a>
</div>
<% Else %>
                            <div class="logo-container" style="display:none;"></div> 
                        <% End If %>
<div class="details">
<h3><a href="<%=RanchLink %>" class="AnimalListname" style="color:#441c15;"><%=Server.HTMLEncode(BusinessName) %></a></h3>
<p>
<% If Len(AddressCity) > 1 Then Response.Write Server.HTMLEncode(AddressCity) & ", " %>
<% If Len(AddressState) > 1 Then Response.Write Server.HTMLEncode(AddressState) %>
&nbsp;<%=Server.HTMLEncode(AddressCountry) %>
</p>
<% If Len(PeopleWebsite) > 4 Then %>
<p><a href="http://<%=Server.HTMLEncode(PeopleWebsite)%>" class="body2" target="_blank"><%=Server.HTMLEncode(PeopleWebsite) %></a></p>
<% End If %>

<div class="social-icons mb-2">
<% If Len(BusinessFacebook) > 0 Then %><a href="<%=ValidateAndFixLink(BusinessFacebook) %>" target="_blank"><img src="/icons/facebook.png" alt="Facebook" /></a><% End If %>
<% If Len(BusinessX) > 0 Then %><a href="<%=ValidateAndFixLink(BusinessX) %>" target="_blank"><img src="/icons/TwitterX.png" alt="Twitter/X" /></a><% End If %>
<% If Len(BusinessInstagram) > 0 Then %><a href="<%=ValidateAndFixLink(BusinessInstagram) %>" target="_blank"><img src="/icons/instagramicon.png" alt="Instagram" /></a><% End If %>
<% If Len(BusinessPinterest) > 0 Then %><a href="<%=ValidateAndFixLink(BusinessPinterest) %>" target="_blank"><img src="/icons/PinterestLogo.png" alt="Pinterest" /></a><% End If %>
<% If Len(BusinessTruthSocial) > 0 Then %><a href="<%=ValidateAndFixLink(BusinessTruthSocial) %>" target="_blank"><img src="/icons/Truthsocial.png" alt="Truth Social" /></a><% End If %>
<% If Len(BusinessBlog) > 0 Then %><a href="<%=ValidateAndFixLink(BusinessBlog) %>" target="_blank"><img src="/icons/BlogIcon.png" alt="Blog" /></a><% End If %>
<% If Len(BusinessYouTube) > 0 Then %><a href="<%=ValidateAndFixLink(BusinessYouTube) %>" target="_blank"><img src="/icons/YouTube.jpg" alt="YouTube" /></a><% End If %>
<% If Len(BusinessOtherSocial1) > 0 Then %><a href="<%=ValidateAndFixLink(BusinessOtherSocial1) %>" target="_blank"><img src="/icons/GeneralSocialIcon.png" alt="Social Media" /></a><% End If %>
<% If Len(BusinessOtherSocial2) > 0 Then %><a href="<%=ValidateAndFixLink(BusinessOtherSocial2) %>" target="_blank"><img src="/icons/GeneralSocialIcon.png" alt="Social Media" /></a><% End If %>

</div>

<form name="Details" method="post" action="<%=RanchProfileLink %>">
<input type="submit" value="Profile" class="profile-btn">
</form>
</div>
</div>
<%
rs.MoveNext
currentRecordNum = currentRecordNum + 1
Wend
End If
rs.Close
%>

<div class="pagination">
<% If totalpages > 1 Then %>
<% If pagenumber > 1 Then %>
<a href="?country_id=<%=Currentcountry_id%>&StateIndex=<%= StateIndex %>&Name=<%= Server.URLEncode(Name) %>&Ownersearch=<%= Server.URLEncode(Ownersearch) %>&pagenumber=1" class="NumLinks">1st</a>
<a href="?country_id=<%=Currentcountry_id%>&StateIndex=<%= StateIndex %>&Name=<%= Server.URLEncode(Name) %>&Ownersearch=<%= Server.URLEncode(Ownersearch) %>&pagenumber=<%= pagenumber - 1 %>" class="NumLinks">&lt;</a>
<% End If %>

<%
maxPageDisplay = 5

pageRangeStart = pagenumber - Int(maxPageDisplay / 2)
If pageRangeStart < 1 Then pageRangeStart = 1

pageRangeEnd = pageRangeStart + maxPageDisplay - 1
If pageRangeEnd > totalpages Then
pageRangeEnd = totalpages
pageRangeStart = pageRangeEnd - maxPageDisplay + 1
If pageRangeStart < 1 Then pageRangeStart = 1
End If

For i = pageRangeStart To pageRangeEnd %>
<% If i = pagenumber Then %>
<span class="pagination-link current-page"><b><%= i %></b></span>
<% Else %>
<a href="?country_id=<%=Currentcountry_id%>&StateIndex=<%= StateIndex %>&Name=<%= Server.URLEncode(Name) %>&Ownersearch=<%= Server.URLEncode(Ownersearch) %>&pagenumber=<%= i %>" class="NumLinks">
<%= i %>
</a>
<% End If %>
<% Next %>

<% If pagenumber < totalpages Then %>
<a href="?country_id=<%=Currentcountry_id%>&StateIndex=<%= StateIndex %>&Name=<%= Server.URLEncode(Name) %>&Ownersearch=<%= Server.URLEncode(Ownersearch) %>&pagenumber=<%= pagenumber + 1 %>" class="NumLinks">&gt;</a>
<a href="?country_id=<%=Currentcountry_id%>&StateIndex=<%= StateIndex %>&Name=<%= Server.URLEncode(Name) %>&Ownersearch=<%= Server.URLEncode(Ownersearch) %>&pagenumber=<%= totalpages %>" class="NumLinks">Last</a>
<% End If %>
<% End If %>
</div>
</div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script> 
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script>
// Function to reset the search form
function resetSearchForm() {
const countrySelect = document.getElementById('country_id');
const stateSelect = document.getElementById('StateIndex');
const nameInput = document.getElementById('Name');
const ownerSearchInput = document.getElementById('Ownersearch');

countrySelect.value = '1228'; // Default to USA ID
stateSelect.value = '10000'; // Default to "Any" state

nameInput.value = '';
if (ownerSearchInput) {
ownerSearchInput.value = '';
}

document.querySelector('input[name="pagenumber"]').value = '1';
document.querySelector('.search-form-grid').submit();
}

// --- JavaScript for Dynamic State/Province Dropdown ---
$(document).ready(function() {
            console.log("jQuery loaded and ready.");
            console.log("Is $.ajax available?", typeof $.ajax === 'function'); 

$('#country_id').change(function() {
console.log('Country dropdown change detected!');
var selectedCountryId = $(this).val();
var stateDropdown = $('#StateIndex');
var previousStateIndex = stateDropdown.val(); // Capture current selection before emptying

if (selectedCountryId) {
console.log('Making AJAX call for country_id:', selectedCountryId);
$.ajax({
url: '/getStates.asp',
type: 'GET',
data: { country_id: selectedCountryId },
dataType: 'html', // Explicitly tell jQuery to expect HTML
success: function(data) {
console.log('AJAX Success! Data received (length ' + data.length + '):', data);
stateDropdown.empty();
stateDropdown.append('<option value="10000">Any</option>');

stateDropdown.append(data); 

console.log('State dropdown new content:', stateDropdown.html());

if (stateDropdown.find('option[value="' + previousStateIndex + '"]').length > 0) {
stateDropdown.val(previousStateIndex);
console.log('Re-selected previous state:', previousStateIndex);
} else {
stateDropdown.val('10000');
console.log('Previous state not found, defaulted to Any (10000).');
}
},
error: function(xhr, status, error) {
console.error("Error fetching states:", status, error, xhr.responseText);
stateDropdown.empty();
stateDropdown.append('<option value="10000">Error loading states</option>');
}
});
} else {
console.log('No country selected, clearing states.');
stateDropdown.empty();
stateDropdown.append('<option value="10000">Select Country First</option>');
}
});

// --- Geolocation for Default Country (on initial page load) ---
const initialCountryId = <%= Currentcountry_id %>;

setTimeout(function() {
if (initialCountryId === 1228) {
$.ajax({
url: 'https://ip-api.com/json/?fields=countryCode',
type: 'GET',
dataType: 'json',
success: function(data) {
if (data && data.countryCode) {
var ipCountryCode = data.countryCode;
var newCountryId;

switch (ipCountryCode) {
case 'US': newCountryId = 1228; break;
case 'CA': newCountryId = 39; break;
case 'GB': newCountryId = 224; break;
case 'AU': newCountryId = 14; break;
default: newCountryId = initialCountryId;
}

if (newCountryId && $('#country_id').val() == initialCountryId) {
console.log('Geolocation detected country:', ipCountryCode, 'Setting ID:', newCountryId);
$('#country_id').val(newCountryId).change();
}
}
},
error: function(xhr, status, error) {
console.warn("Could not detect user country via IP. Using default.", error);
}
});
}
}, 500);
});
</script>


<%
' Close the main connection object if not managed globally
If Not conn Is Nothing Then
If conn.State = 1 Then conn.Close
Set conn = Nothing
End If
Set rs = Nothing
Set rs2 = Nothing
%>
<!--#Include virtual="/members/membersFooter.asp"-->

