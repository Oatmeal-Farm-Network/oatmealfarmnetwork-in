<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!--#Include virtual="/includefiles/GlobalVariables.asp"-->
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- SEO and Page Information -->
<title>Upcoming Events | Oatmeal Farm Network</title>
<meta name="description" content="Discover upcoming events from members of the Oatmeal Farm Network. Find workshops, markets, tours, and more local happenings in our community.">
<meta name="author" content="Oatmeal Farm Network">
<meta name="keywords" content="Oatmeal Farm Network, community events, local events, farm events, workshops, local food, Medford Oregon events">

<!-- Open Graph / Facebook -->
<meta property="og:type" content="website">
<meta property="og:url" content="https://www.oatmealfarmnetwork.com/events.asp">
<meta property="og:title" content="Upcoming Events | Oatmeal Farm Network">
<meta property="og:description" content="Discover upcoming events from members of the Oatmeal Farm Network. Find workshops, markets, tours, and more.">

<!-- Twitter -->
<meta property="twitter:card" content="summary_large_image">
<meta property="twitter:url" content="https://www.oatmealfarmnetwork.com/events.asp">
<meta property="twitter:title" content="Upcoming Events | Oatmeal Farm Network">
<meta property="twitter:description" content="Discover upcoming events from members of the Oatmeal Farm Network. Find workshops, markets, tours, and more.">

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>



</head>
<body >
<!--#Include virtual="/Members/MembersHeader.asp"-->
<%
    ' ### CORRECTED SQL QUERY ###
    ' This query now converts 24-hour time to 12-hour AM/PM format.
    strSQL = "SELECT " & _
             "E.EventID, B.BusinessName, B.BusinessID, E.EventContactEmail, E.EventLogo, E.EventName, E.EventDescription, ETL.EventType, " & _
             "EL.EventLocationName, A.AddressStreet, A.AddressCity, SP.Name AS AddressState, A.AddressZip, " & _
             "W.Website AS EventWebsite, P.Phone AS EventPhone, " & _
             "DATEFROMPARTS(ES.ScheduleDateYear, ES.ScheduleDateMonth, ES.ScheduleDateDay) AS CombinedScheduleDate, " & _
             "CAST(CASE WHEN ES.ScheduleStartTimeHour > 12 THEN ES.ScheduleStartTimeHour - 12 WHEN ES.ScheduleStartTimeHour = 0 THEN 12 ELSE ES.ScheduleStartTimeHour END AS VARCHAR(2)) + ':' + FORMAT(ES.ScheduleStartTimeMinute, '00') + ' ' + CASE WHEN ES.ScheduleStartTimeHour >= 12 THEN 'PM' ELSE 'AM' END AS FormattedStartTime, " & _
             "CAST(CASE WHEN ES.ScheduleEndTimeHour > 12 THEN ES.ScheduleEndTimeHour - 12 WHEN ES.ScheduleEndTimeHour = 0 THEN 12 ELSE ES.ScheduleEndTimeHour END AS VARCHAR(2)) + ':' + FORMAT(ES.ScheduleEndTimeMinute, '00') + ' ' + CASE WHEN ES.ScheduleEndTimeHour >= 12 THEN 'PM' ELSE 'AM' END AS FormattedEndTime " & _
             "FROM Event AS E " & _
             "INNER JOIN EventSchedule AS ES ON E.EventID = ES.EventID " & _
             "INNER JOIN Business AS B ON B.BusinessID = E.BusinessID " & _
             "LEFT JOIN EventTypesLookup AS ETL ON E.EventTypeID = ETL.EventTypeID " & _
             "LEFT JOIN EventLocation AS EL ON E.EventLocationID = EL.EventLocationID " & _
             "LEFT JOIN Address AS A ON EL.AddressID = A.AddressID " & _
             "LEFT JOIN state_province AS SP ON A.StateIndex = SP.StateIndex " & _
             "LEFT JOIN Websites AS W ON E.WebsiteID = W.WebsitesID " & _
             "LEFT JOIN Phone AS P ON EL.PhoneID = P.PhoneID " & _
             "WHERE E.Deleted = 0 AND DATEFROMPARTS(ES.ScheduleDateYear, ES.ScheduleDateMonth, ES.ScheduleDateDay) >= GETDATE() " & _
             "ORDER BY E.EventID ASC, CombinedScheduleDate ASC"

    Set rsEvents = conn.Execute(strSQL)

    Dim currentEventID
    currentEventID = 0
%>

<header class="page-header">
    <div class="container">
        <h1 class="display-4 fw-bold">Event Listings</h1>
        <p class="lead">All upcoming events from our member organizations.</p>
    </div>
</header>

<main class="container-fluid">
    <div class="row">
        <div class="col-12">
            <% If rsEvents.EOF Then %>
                <div class="alert alert-info" role="alert">
                    There are no upcoming events scheduled at this time. Please check back later!
                </div>
            <% Else %>
                <% Do While Not rsEvents.EOF %>
                    <% 
                        ' --- Check if we are starting a new event card ---
                        If rsEvents("EventID") <> currentEventID Then 
                            ' If this isn't the first card, close the previous one
                            If currentEventID <> 0 Then 
                    %>
                                </ul> 
                                <hr>
                                <p class="card-text text-muted mb-0">
                                    Hosted by: <a href="/Directory/FarmListing.asp?BusinessID=<%= PrevBusinessID %>"><%= Server.HTMLEncode(PrevBusinessName) %></a>
                                </p>
                            </div> 
                        </div> 
                    <% 
                            End If 
                            currentEventID = rsEvents("EventID") 
                    %>
                    
                    <div class="card event-card mb-4 shadow-sm">
                        <div class="card-body">
                            <h4 class="card-title mb-3"><%= Server.HTMLEncode(rsEvents("EventName")) %></h4>
                            
                            <% If Not IsNull(rsEvents("EventLocationName")) AND rsEvents("EventLocationName") <> "" Then %>
                            <div class="event-detail">
                                <span>
                                    <strong><%= Server.HTMLEncode(rsEvents("EventLocationName")) %></strong>
                                    <% If Not IsNull(rsEvents("AddressStreet")) AND rsEvents("AddressStreet") <> "" Then %>
                                    <br><%= Server.HTMLEncode(rsEvents("AddressStreet")) %>, <%= Server.HTMLEncode(rsEvents("AddressCity")) %>, <%= Server.HTMLEncode(rsEvents("AddressState")) %> &nbsp;<%= Server.HTMLEncode(rsEvents("AddressZip")) %>
                                    <% End If %>
                                </span>
                            </div>
                            <% End If %>
                            
                            <hr>
                            <p class="card-text mb-3"><%= Server.HTMLEncode(rsEvents("EventDescription")) %></p>
                            
                            <% If Not IsNull(rsEvents("EventWebsite")) AND rsEvents("EventWebsite") <> "" Then %>
                                <a href="<%= Server.HTMLEncode(rsEvents("EventWebsite")) %>" class="btn btn-outline-primary btn-sm mb-2" target="_blank">Event Website</a>
                            <% End If %>
                            <% If Not IsNull(rsEvents("EventContactEmail")) AND rsEvents("EventContactEmail") <> "" Then %>
                                <a href="mailto:<%= Server.HTMLEncode(rsEvents("EventContactEmail")) %>" class="btn btn-outline-info btn-sm mb-2">Contact Email</a>
                            <% End If %>
                            <% If Not IsNull(rsEvents("EventPhone")) AND rsEvents("EventPhone") <> "" Then %>
                                <a href="tel:<%= Server.HTMLEncode(rsEvents("EventPhone")) %>" class="btn btn-outline-secondary btn-sm mb-2">Call: <%= Server.HTMLEncode(rsEvents("EventPhone")) %></a>
                            <% End If %>
                            
                            <hr>
                            <ul class="schedule-list">
                    <% 
                        End If 
                        
                        ' --- Store details for the "Hosted By" section before moving to the next record ---
                        Dim PrevBusinessID, PrevBusinessName
                        PrevBusinessID = rsEvents("BusinessID")
                        PrevBusinessName = rsEvents("BusinessName")
                    %>
                        
                        <li>
                            <strong><%= FormatDateTime(rsEvents("CombinedScheduleDate"), vbLongDate) %></strong>: 
                            <%= rsEvents("FormattedStartTime") %> - <%= rsEvents("FormattedEndTime") %>
                        </li>
                    
                    <% 
                        rsEvents.MoveNext 
                    Loop 
                    
                    ' --- After the loop, close the very last card ---
                    If currentEventID <> 0 Then
                    %>
                                </ul> 
                                <hr>
                                <p class="card-text text-muted mb-0">
                                    Hosted by: <a href="/Directory/FarmListing.asp?BusinessID=<%= PrevBusinessID %>"><%= Server.HTMLEncode(PrevBusinessName) %></a>
                                </p>
                            </div> 
                        </div> 
                    <% 
                    End If
                End If
                    %>
        </div>
    </div>
</main>

<%
    ' Clean up
    rsEvents.Close
    Set rsEvents = Nothing
%>
<br />
<!--#Include virtual="/Members/MembersFooter.asp"-->
</div>
</body>
</html>