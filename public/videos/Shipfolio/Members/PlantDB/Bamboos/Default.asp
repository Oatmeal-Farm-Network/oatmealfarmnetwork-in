<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!--#Include virtual="/includefiles/globalvariables.asp"-->
<%Planttype = "Bamboo" 
DirectoryName = "Bamboos"
PlantTypeID = 40
description = "Explore a comprehensive list of " & Planttype & "plant types and their varieties."
%>
<link rel="canonical" href="<%=currenturl %>" />

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%=WebSiteName %> | <%=Planttype%> Varieties</title>
    <meta name="title" content= <%=WebSiteName %> | <%=Planttype%>  Varieties/>

    <meta name="description" content=<%=Description%>/>
    <meta name="keywords" content=<%=Planttype%> "varieties, plant database, food plants, gardening, agriculture"/>

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
            max-width: 1400px; /* Adjust as per your site's main container width */
        }
        .body {
            padding: 1rem; /* Adjust as needed */
        }
        h1, h2 {
            color: #1f2937;
            font-weight: bold;
            margin-bottom: 1rem;
        }
        .row {
            display: flex;
            flex-wrap: wrap;
            margin-left: -0.75rem; /* Compensate for column padding */
            margin-right: -0.75rem; /* Compensate for column padding */
        }
        .col-2, .col-4, .col-6, .col-8, .col-12 {
            padding-left: 0.75rem;
            padding-right: 0.75rem;
            box-sizing: border-box;
        }
        /* Basic responsive columns - adjust to match your Bootstrap setup */
        .col-12 { width: 100%; }
        @media (min-width: 576px) { /* Small devices (sm) */
            .col-sm-6 { width: 50%; }
            .col-sm-4 { width: 33.333%; }
            .col-sm-8 { width: 66.666%; }
        }
        @media (min-width: 768px) { /* Medium devices (md) */
            .col-md-4 { width: 33.333%; }
            .col-md-6 { width: 50%; }
        }
        @media (min-width: 992px) { /* Large devices (lg) */
            .col-lg-2 { width: 16.666%; }
            .col-lg-4 { width: 33.333%; }
            .col-lg-6 { width: 50%; }
        }

        .d-none { display: none !important; }
        .d-lg-block { display: block !important; }
        .d-lg-none { display: none !important; } /* Hide on large screens */
        @media (min-width: 992px) {
            .d-lg-none { display: none !important; }
            .d-lg-block { display: block !important; }
        }
        @media (max-width: 991.98px) { /* Hide on large screens */
            .d-lg-block { display: none !important; }
            .d-lg-none { display: block !important; }
        }

        .text-left { text-align: left; }
        .text-center { text-align: center; }

        a.body {
            color: #3b82f6; /* A shade of blue for links */
            text-decoration: none;
            font-weight: bold;
        }
        a.body:hover {
            text-decoration: underline;
        }
        img {
            max-width: 100%;
            height: auto;
            border-radius: 0.5rem; /* Rounded corners for images */
        }
        .image-container {
            width: 150px; /* Fixed width for images */
            height: 150px; /* Fixed height for images */
            overflow: hidden; /* Hide overflow if image is larger */
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 0.5rem;
        }
        .image-container img {
            width: 100%;
            height: 100%;
            object-fit: cover; /* Cover the container without distorting aspect ratio */
        }
    </style>

<%

Dim rs, sql, TotalVarieties

sql = "SELECT P.PlantID, P.PlantName, P.PlantDescription, GrownForFood, PlantImage, COUNT(PV.PlantVarietyID) AS VarietyCount " & _
      "FROM Plant P " & _
      "LEFT JOIN PlantVariety PV ON P.PlantID = PV.PlantID " & _
      "WHERE P.PlantTypeID = " & PlantTypeID & " and GrownForFood = 'True'" & _
      "GROUP BY P.PlantID, P.PlantName, P.PlantDescription, GrownForFood, PlantImage " & _
      "ORDER BY P.PlantName"
'response.write("sql=" & sql)
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3 ' adOpenStatic, adLockOptimistic

TotalVarieties = 0
If Not rs.EOF Then
    Do While Not rs.EOF
        TotalVarieties = TotalVarieties + rs("VarietyCount")
        rs.MoveNext
    Loop
    rs.MoveFirst ' Reset recordset to the beginning for display
End If

' Note: currenturl and WebSiteName are assumed to be defined globally or in Header.asp
' Example placeholder values if not defined:
' Dim currenturl, WebSiteName
' currenturl = Request.ServerVariables("URL")
' WebSiteName = "My Plant Wiki"
%>

<!--#Include virtual="/Header.asp"-->


<div class="container-fluid d-none d-lg-block" align="center" style="max-width: 1400px; min-height: 67px;">
    <div class="row">
        <div class="col body text-left">
            <img src="AlgaeHeader.webp" width="100%" alt="Delicious <%=Planttype%>" />
            <br /> <br />
                  <h2><div class="text-left"><%=Planttype%> Plant Types</div></h2>    </div>

    <div class="row">
        <%
        If Not rs.EOF Then
            Do While Not rs.EOF
                Dim plantID, plantName, varietyCount
                plantID = rs("PlantID")
                plantName = rs("PlantName")
                PlantDescription = rs("PlantDescription")
                PlantImage = rs("PlantImage")
                varietyCount = rs("VarietyCount")
        %>
                <div class="col-lg-4 col-md-6 col-sm-12 body text-left">
                    <div class="flex items-center">
                        <a href="/PlantDB/" & DirectoryName & "/Varietals.asp?PlantID=<%=plantID %>" class="body image-container">
                                            <img src='<%=PlantImage%>' alt="<%=plantName %>" />
                        </a>
                        <div style="margin-left: 1rem;">
                            <a href="/PlantDB/<%=DirectoryName%>/Varietals.asp?PlantID=<%=plantID %>" class="body"><%=plantName %> (<%=varietyCount %> Varieties)</a><br />
                            <%=PlantDescription %>
                        </div>
                    </div>
                    <br /><br />
                </div>
        <%
                rs.MoveNext
            Loop
        Else
        %>
            <div class="col-12 body text-center">
                <p>No<%=Planttype%> plant types found in the database.</p>
            </div>
        <%
        End If
        %>
    </div>
</div>

<% ' XS and SM navigation %>
<div class="container-fluid d-lg-none">
    <div class="row">
        <div class="col body text-left">
            <img src="https://placehold.co/600x100/FFC107/FFFFFF?text=Delicious+<%=DirectoryName%>" width="100%" alt="Delicious<%=Planttype%>" />
            <br /> <br />
            Our database features a wide array of<%=Planttype%> plants, from common apples to exotic berries. We have documented <b><%=TotalVarieties %> Varieties</b> across various<%=Planttype%> types so far. We are continuously expanding our collection with more information and photos. If you would like to contribute photos, descriptions, or correct any errors, please <a href="ContactUs.asp" class="body">Contact Us</a>. The more community involvement, the more comprehensive our information becomes.
            <h2><div class="text-left">Categories of Food Plants</div></h2>
        </div>
    </div>

    <div class="row">
        <%
        If Not rs.BOF Then rs.MoveFirst ' Reset recordset for mobile view
        If Not rs.EOF Then
            Do While Not rs.EOF
                Dim plantID_sm, plantName_sm, varietyCount_sm
                plantID_sm = rs("PlantID")
                plantName_sm = rs("PlantName")
                varietyCount_sm = rs("VarietyCount")
        %>
                <div class="col-sm-6 col-12 body text-left">
                    <div class="flex items-center">
                        <a href="/PlantDB/Bulbs/Varietals.asp?PlantID=<%=plantID_sm %>" class="body image-container" style="width: 100px; height: 100px;">
                            <% ' Placeholder image - smaller for mobile %>
                            <img src='https://placehold.co/100x100/FFC107/FFFFFF?text=<%=Server.URLEncode(Left(plantName_sm, 8))%>' alt="<%=plantName_sm %>" />
                        </a>
                        <div style="margin-left: 0.5rem;">
                            <a href="/PlantDB/Bulbs/Varietals.asp?PlantID=<%=plantID_sm %>" class="body"><%=plantName_sm %> (<%=varietyCount_sm %> Varieties)</a><br />
                            <% ' Short description for the<%=Planttype%> type %>
                            A delicious<%=Planttype%> type.
                        </div>
                    </div>
                    <br /><br />
                </div>
        <%
                rs.MoveNext
            Loop
        End If
        %>
    </div>
</div>

<%
' Close the recordset and connection if they were opened on this page
If Not rs Is Nothing Then
    If rs.State = 1 Then rs.Close
    Set rs = Nothing
End If
' If conn was opened here, close it
' If Not conn Is Nothing Then
'     If conn.State = 1 Then conn.Close
'     Set conn = Nothing
' End If
%>



<!--#Include virtual="/Footer.asp"-->
</body></html>