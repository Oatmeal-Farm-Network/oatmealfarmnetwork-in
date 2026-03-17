<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!--#Include virtual="/members/membersglobalvariables.asp"-->

<!--#Include virtual="/Members/membersHeader.asp"-->
<%Planttype = "Medicinal Herbs" 
DirectoryName = "MedicinalHerbs"
PlantTypeID = 34
description = "Explore a comprehensive list of " & Planttype & "plant types and their varieties."
%>
<link rel="canonical" href="<%=currenturl %>" />

  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title><%=WebSiteName %> | <%=Planttype%> Varieties</title>
  <meta name="title" content= <%=WebSiteName %> | <%=Planttype%> Varieties/>

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

sql = "SELECT P.PlantID, P.PlantName, P.PlantDescription, P.GrownForFood, PlantImage, COUNT(PV.PlantVarietyID) AS VarietyCount " & _
   "FROM Plant P " & _
   "LEFT JOIN PlantVariety PV ON P.PlantID = PV.PlantID " & _
   "WHERE P.PlantTypeID = " & PlantTypeID & " and P.GrownForFood = 'True'" & _
   "GROUP BY P.PlantID, P.PlantName, P.PlantDescription, P.GrownForFood, PlantImage " & _
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




<div class="container-fluid " align="center" style="max-width: 1400px; min-height: 67px;">
  <div class="row">
    <div class="col body text-left">
      <img src="MedicinalHerbsHeding.webp" width="100%" alt="Delicious <%=Planttype%>" />
      <br /> <br />
         <h2><div class="text-left"><%=Planttype%> Plant Types</div></h2>  
         Under Construction: Thanks for your patience as we build this out! This information is still being finalized and is updated regularly. Check back soon for the latest version..
        </div>
  <div class="row">
    <%
    If Not rs.EOF Then
      Do While Not rs.EOF
        Dim plantID, plantName, varietyCount
        plantID = rs("PlantID")
        plantName = rs("PlantName")
        PlantDescription = rs("PlantDescription")
        PlantImage = rs("PlantImage")
        if len(PlantImage)> 0 then
        Else
          PlantImage = plantName & ".webp"
        end if
        varietyCount = rs("VarietyCount")
        if varietyCount > 1 then
          Varietyterm = "Varieties"
        else
          Varietyterm = "Variety"
        end if

    %>
        <div class="col-lg-4 col-md-6 col-sm-12 body text-left">
          <div class="flex items-center">

            <a href="/Members/PlantDB/<%=DirectoryName%>/Varietals.asp?PlantID=<%=plantID %>" >
                      <center><img src='<%=PlantImage%>' alt="<%=plantName %>" width = 200px /></center>
            </a>
            <div style="margin-left: 1rem;">
              <a href="/Members/PlantDB/<%=DirectoryName%>/Varietals.asp?PlantID=<%=plantID %>" class="body"><%=plantName %> (<%=varietyCount %>&nbsp;<%=Varietyterm%>)</a><br />
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
</div>


<!--#Include virtual="/Members/membersFooter.asp"-->
</body></html>