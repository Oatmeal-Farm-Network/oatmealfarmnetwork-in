<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <% MasterDashboard= True %>
<!--#Include virtual="/members/Membersglobalvariables.asp"-->
<Title>Harvest Hub</Title>
<meta name="robots" content="nofollow">

<%
' =================================================================================
' VBScript Link Checker Function
' Improved to check HTTP Status AND Content-Type to avoid false positives 
' (where the server returns an HTML error page with a 200 status).
' =================================================================================
Function CheckLinkValidity(ByVal sURL)
    ' Default status is false (broken)
    CheckLinkValidity = False
    
    ' Only check if the URL looks remotely valid
    If Len(sURL) < 4 Then Exit Function

    On Error Resume Next
    
    Dim oXMLHttp, sContentType
    Set oXMLHttp = Server.CreateObject("MSXML2.ServerXMLHttp")
    
    ' Set a short timeout (5 seconds) to prevent the script from stalling
    oXMLHttp.setTimeouts 5000, 5000, 5000, 5000 
    
    ' Use HEAD method to only request headers, which is faster than a full GET
    oXMLHttp.Open "HEAD", sURL, False
    oXMLHttp.Send
    
    ' Check if the request was successful and handle different success codes
    If Err.Number = 0 Then
        ' Check for standard success codes: 200 (OK)
        ' We can also include redirects (301/302) if we assume the redirect destination is valid, 
        ' but for robustness, we usually stick to 200 for existence checks.
        If oXMLHttp.Status = 200 Then
            
            ' *** CRITICAL FIX: Check the Content-Type header ***
            ' A valid image must return a content type like image/jpeg, image/png, etc.
            ' If the server sends back an HTML error page, the type will be text/html.
            sContentType = LCase(oXMLHttp.GetResponseHeader("Content-Type"))
            
            If InStr(sContentType, "image/") > 0 Then
                ' It's Status 200 AND Content-Type is image -> VALID
                CheckLinkValidity = True
            End If
            
        End If
    End If
    
    Set oXMLHttp = Nothing
    Err.Clear ' Clear any potential VBScript errors
    
    On Error GoTo 0 
End Function

'===================================================================
' HELPER FUNCTION
'===================================================================
Function HasVisibleAwardData(arr)
    Dim hasData, rowCount,  x
    hasData = False

    If IsArray(arr) Then
        Dim dim2Exists
        dim2Exists = False

        On Error Resume Next
        rowCount = UBound(arr, 2)
        If Err.Number = 0 Then
            dim2Exists = True
        Else
            rowCount = 0 ' fallback value just in case
        End If
        On Error GoTo 0

        If dim2Exists Then
            For i = 0 To rowCount
                ' Check columns 0 to 3 for meaningful data
                For x = 0 To 3
                    If Not IsNull(arr(x, i)) Then
                        If Len(Trim(CStr(arr(x, i)))) > 0 Then
                            If Trim(CStr(arr(x, i))) <> "0" Then
                                hasData = True
                                Exit For
                            End If
                        End If
                    End If
                Next
                If hasData Then Exit For
            Next
        End If
    End If

    HasVisibleAwardData = hasData
End Function


Function HasVisibleEpdData(dict)
    Dim hasData, key, importantKeys
    hasData = False
   ' On Error Resume Next
  If IsObject(dict) Then
    ' continue checking keys
    importantKeys = Array("AFD", "SDAFD", "SF", "PercentFGreaterThan30", "MC", "SDMC", "PercentM", "MSL", "FW")
    For Each key In importantKeys
        If dict.Exists(key) Then
            If Not IsNull(dict(key)) Then
                If CStr(dict(key)) <> "" Then
                    If CStr(dict(key)) <> "0" Then
                        hasData = True
                        Exit For
                    End If
                End If
            End If
        End If
    Next
End If

    On Error GoTo 0
    HasVisibleEpdData = hasData
End Function

Function HasVisibleFiberData(arr)
    Dim hasData, rowCount, i, x
    hasData = False
    'On Error Resume Next
    If IsArray(arr) Then
        If UBound(arr, 2) >= 0 Then
            rowCount = UBound(arr, 2)
            For i = 0 To rowCount
                ' Check data columns (3 and up) for any real values
                For x = 3 to UBound(arr, 1) 
                    If Not IsNull(arr(x, i)) then 
                       if Len(Trim(CStr(arr(x, i)))) > 0 then
                        if  Trim(CStr(arr(x, i))) <> "0" Then
                            hasData = True
                            Exit For
                        end if
                       End If
                    end if
                Next
                If hasData Then
                    Exit For
                End If
            Next
        End If
    End If
    On Error GoTo 0
    HasVisibleFiberData = hasData
End Function




'===================================================================
' SCRIPT INITIALIZATION & DATA FETCHING
'===================================================================
Dim AnimalID, cmd, sql
Dim rs, photos, ancestryData, awards, fiberStats, epdData, progeny
Dim photoCount, awardCount, hasAncestryData

' --- Check Connection State ---
If conn Is Nothing Or conn.State <> 1 Then ' 1 = adStateOpen
    Response.Write("Critical Error: Database connection is not open or available.")
    Response.End()
End If

AnimalID = Request.QueryString("AnimalID")
If Not IsNumeric(AnimalID) Or Len(AnimalID) < 1 Then
    Response.Redirect("/Default.asp")
    Response.End()
End If

Set cmd = Server.CreateObject("ADODB.Command")
cmd.ActiveConnection = conn
sql = "SET NOCOUNT ON; EXEC sp_GetAnimalDetails @AnimalID = ?"
cmd.CommandText = sql
cmd.CommandType = 1 ' adCmdText
cmd.Parameters.Append cmd.CreateParameter("@AnimalIDParam", 3, 1, , AnimalID) ' adInteger, adParamInput

' --- Execute and Process Recordsets Sequentially ---
Set rs = cmd.Execute()

' -- Result Set 1: Main Animal Data --
If rs.State = 0 Or rs.EOF Then
    If rs.State <> 0 Then rs.Close
    conn.Close
    Set conn = Nothing
    Response.Redirect("/Default.asp")
    Response.End()
End If
' Assign main details to variables for easy use in HTML
Dim animalName, description, price, studFee, sold, businessName, city, state, photo1, singularAnimal, pluralAnimal, Show1percentemblem
animalName = rs("FullName")
description = rs("Description")
price = rs("Price")
studFee = rs("StudFee")
sold = rs.Fields("Sold")
businessName = rs("BusinessName")
city = rs("AddressCity")
state = rs("AddressState")
photo1 = rs("Photo1")
singularAnimal = rs("SingularTerm")
pluralAnimal = rs("PluralTerm")
Show1percentemblem = rs("Show1percentemblem")


' -- Result Set 2: Photos --
Set rs = rs.NextRecordset()
photoCount = 0
If rs.State = 1 And NOT rs.EOF Then
    photos = rs.GetRows()
    photoCount = UBound(photos, 2) + 1
Else
    photos = Array()
End If


' -- Result Set 3: Ancestry --
Set rs = rs.NextRecordset()
hasAncestryData = false
If rs.State = 1 And NOT rs.EOF Then
    Set ancestryData = Server.CreateObject("Scripting.Dictionary")

    ancestryData("Sire") = rs("Sire") : ancestryData("SireColor") = rs("SireColor")
    if len(ancestryData("Sire")) > 2 then
        hasAncestryData = true
    end if
    ancestryData("Dam") = rs("Dam") : ancestryData("DamColor") = rs("DamColor")
        if len(ancestryData("Dam")) > 2 then
        hasAncestryData = true
    end if
    ancestryData("SireSire") = rs("SireSire") : ancestryData("SireSireColor") = rs("SireSireColor")
        if len(ancestryData("SireSire")) > 2 then
        hasAncestryData = true
    end if
    ancestryData("Siredam") = rs("Siredam") : ancestryData("SiredamColor") = rs("SiredamColor")
        if len(ancestryData("Siredam")) > 2 then
        hasAncestryData = true
    end if
    ancestryData("DamSire") = rs("DamSire") : ancestryData("DamSireColor") = rs("DamSireColor")
        if len(ancestryData("DamSire")) > 2 then
        hasAncestryData = true
    end if
    ancestryData("DamDam") = rs("DamDam") : ancestryData("DamDamColor") = rs("DamDamColor")
        if len(ancestryData("DamDam")) > 2 then
        hasAncestryData = true
    end if
    ancestryData("SireSireSire") = rs("SireSireSire") : ancestryData("SireSireSireColor") = rs("SireSireSireColor")
        if len(ancestryData("SireSireSire")) > 2 then
        hasAncestryData = true
    end if
    ancestryData("SireSireDam") = rs("SireSireDam") : ancestryData("SireSireDamColor") = rs("SireSireDamColor")
        if len(ancestryData("SireSireDam")) > 2 then
        hasAncestryData = true
    end if
    ancestryData("SireDamSire") = rs("SireDamSire") : ancestryData("SireDamSireColor") = rs("SireDamSireColor")
        if len(ancestryData("SireDamSire")) > 2 then
        hasAncestryData = true
    end if
    ancestryData("SireDamDam") = rs("SireDamDam") : ancestryData("SireDamDamColor") = rs("SireDamDamColor")
        if len(ancestryData("SireDamDam")) > 2 then
        hasAncestryData = true
    end if
    ancestryData("DamSireSire") = rs("DamSireSire") : ancestryData("DamSireSireColor") = rs("DamSireSireColor")
        if len(ancestryData("DamSireSire")) > 2 then
        hasAncestryData = true
    end if
    ancestryData("DamSireDam") = rs("DamSireDam") : ancestryData("DamSireDamColor") = rs("DamSireDamColor")
        if len(ancestryData("DamSireDam")) > 2 then
        hasAncestryData = true
    end if
    ancestryData("DamDamSire") = rs("DamDamSire") : ancestryData("DamDamSireColor") = rs("DamDamSireColor")
        if len(ancestryData("DamDamSire")) > 2 then
        hasAncestryData = true
    end if
    ancestryData("DamDamDam") = rs("DamDamDam") : ancestryData("DamDamDamColor") = rs("DamDamDamColor")
        if len(ancestryData("DamDamDam")) > 2 then
        hasAncestryData = true
    end if
End If


' -- Result Set 4: Awards --
Set rs = rs.NextRecordset()
awardCount = 0
If rs.State = 1 And NOT rs.EOF Then
    awards = rs.GetRows()
    awardCount = UBound(awards, 2) + 1
Else
    awards = Array()
End If


' -- Result Set 5: Fiber Stats --
Set rs = rs.NextRecordset()
If rs.State = 1 And NOT rs.EOF Then
    fiberStats = rs.GetRows()
End If


' -- Result Set 6: EPD Data --
Set rs = rs.NextRecordset()

hasEpdData = false
If rs.State = 1 And NOT rs.EOF Then
    hasEpdData = true
    Set epdData = Server.CreateObject("Scripting.Dictionary")
    For Each f In rs.Fields
        epdData(f.Name) = f.Value
    Next
End If


' -- Result Set 7: Progeny --
Set rs = rs.NextRecordset()
If rs.State = 1 And NOT rs.EOF Then
    progeny = rs.GetRows()
End If


' --- Cleanup ---
If Not rs Is Nothing And rs.State = 1 Then rs.Close
Set rs = Nothing
Set cmd = Nothing
conn.Close
Set conn = Nothing
%>

<% AnimalID= Request.QueryString("AnimalID") %>
 <link rel="canonical" href="<%=currenturl %>?AnimalID=<%=AnimalID %>" />
 

<meta property="og:image" content="<%=Photo1 %>" />
<title><%=animalName%> at <%= BusinessName %> - <%=signularanimal %> For Sale</title>
<meta name="Title" content="<%=Name%> - <%= BusinessName %>"/>
<meta name="description" content="<%=left(description, 160)%>[&hellip;]" />
<meta name="robots" content="index, follow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="revisit-after" content="1 day"/>
<meta name="Googlebot" content="index, follow"/>
<meta name="robots" content="All"/>
<meta name="subject" content="<%=signularanimal %> For Sale" />

<meta property="og:locale" content="en_US" />
<meta property="og:type" content="article" />
<meta property="og:title" content="<%=Name%> at <%= BusinessName %> - <%=signularanimal %> For Sale" />
<meta property="og:description" content="<%=left(Description, 160)%>" />
<meta property="og:url" content="<%=currenturl %>?BreedLookupID=<%=BreedID %>&SpeciesID=<%=SpeciesID %>" />
<meta property="og:site_name" content="<%=WebSiteName %>" />

<meta property="og:image:width" content="600" />
<meta name="twitter:card" content="summary" />
<meta name="twitter:description" content="<%=left(description, 160)%>[&hellip;]" />
<meta name="twitter:title" content="<%=Name%> at <%= BusinessName %> - <%=signularanimal %> For Sale" />

<style>
   .pedigree-table { width: 100%; border-collapse: separate; border-spacing: 5px; font-size: 0.9em; }
        .pedigree-table td { width: 33%; vertical-align: middle; padding: 5px; border-radius: 4px; min-height: 50px; }
        .pedigree-box { min-height: 45px; padding: 5px; border-radius: 4px; }
        /* --- UPDATED TRADITIONAL COLORS --- */
        .male { border: 2px solid #AEC6CF; background-color: #E6F0FF; } /* Light Cornflower Blue */
        .female { border: 2px solid #E7AAB4; background-color: #FFE4E1; } /* Indian Red Light */
        .small-text { font-size: 0.9em; }

    body { font-family: Arial, sans-serif; }
    .container { max-width: 1200px; margin: 0 auto; padding: 15px; }
    .grid { display: grid; grid-template-columns: 2fr 1fr; gap: 20px; }
    .main-image { width: 100%; height: auto; border: 1px solid #ddd; }
    .thumbnails { display: grid; grid-template-columns: repeat(4, 1fr); gap: 10px; margin-top: 10px; }
    .thumb-img { width: 100%; height: auto; cursor: pointer; border: 2px solid transparent; }
    .thumb-img:hover { border-color: #007bff; }
    .details-table { width: 100%; border-collapse: collapse; }
    .details-table td { padding: 8px; border-bottom: 1px solid #eee; }
    .details-table td:first-child { font-weight: bold; width: 120px; }
    .round-loope { border-radius: 50%; border: 5px solid #F0F0F0; }
    h1, h2 { color: #333; }

    /* --- Responsive Design --- */
    @media (max-width: 992px) { /* Medium screens and below */
        .grid {
            grid-template-columns: 1fr; /* Single column */
        }
        .photo-gallery {
            order: -1; /* Move image section to the top */
            margin-bottom: 20px; /* Add some space below the image */
        }
    }


    /* --- EPD & Progeny Styles (NEW) --- */
        .epd-table th, .epd-table td { text-align: center; }
        .epd-table th { background-color: #f7f7f7; }
        .progeny-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
            gap: 15px;
        }
        .progeny-card {
            text-align: center;
            font-size: 0.9em;
        }
        .progeny-card img {
            width: 100%;
            height: auto;
            border-radius: 4px;
            margin-bottom: 5px;
        }

        /* --- Data Table Formatting (NEW) --- */
        .data-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        .data-table th, .data-table td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: center;
        }
        .data-table th {
            background-color: #f7f7f7;
            font-weight: bold;
        }
        .data-table td.label {
            text-align: left;
            font-weight: bold;
        }
</style>

    </head>
<body >

 <!--#Include virtual="/members/MembersHeader.asp"-->
 <div class="container">
    <div class="container">
        <h1>
            <%=animalName%>
            <% If Show1percentemblem Then %>
                <a href="#EPD"><img src="/images/TopEPD.gif" alt="<%=animalName%> EPD" width="50" border="0"></a>
            <% End If %>
        </h1>
        <p>Offered by <%=businessName%> in <%=city%>, <%=state%></p>

        <div class="grid">
            <div class="details-section">
                
                <table class="details-table">
                    <% If sold Then %>
                        <tr><td colspan="2"><strong style="color: #d9534f;">SOLD</strong></td></tr>
                    <% ElseIf Not IsNull(price) then
                        if  CDbl(price) > 0 Then %>
                        <tr><td>Price</td><td><%=FormatCurrency(price, 0)%></td></tr>
                    <% 
                       end if
                    Else %>
                        <tr><td>Price</td><td>Call for Price</td></tr>
                    <% End If %>
                    
                    <% If Not IsNull(studFee) then
                      if CDbl(studFee) > 0 Then %>
                        <tr><td>Stud Fee</td><td><%=FormatCurrency(studFee, 0)%></td></tr>
                    <% 
                    end if
                    End If %>

                    <tr><td>Species</td><td><%=singularAnimal%></td></tr>
                </table>

                <h2>Description</h2>
                <p><%=description%></p>

                <% If HasVisibleAwardData(awards) Then %>
                    <h2>Awards</h2>
                    <table class="details-table">
                        <%
                        Dim awardOutput, awardPlacing, awardType, awardShowname, awardYear
                        For i = 0 To UBound(awards, 2)
                            awardOutput = ""
                            awardYear     = awards(0, i)
                            awardShowname = awards(1, i)
                            awardPlacing  = awards(2, i)
                            awardType     = awards(3, i)
                            if len(awardPlacing) > 0 then
                                If Not IsNull(awardPlacing) AND Len(Trim(CStr(awardPlacing))) > 0 AND Trim(CStr(awardPlacing)) <> "0" Then
                                    awardOutput = awardOutput & Server.HTMLEncode(Trim(CStr(awardPlacing)))
                                End If
                            end if
                            if len(awardType) > 0 then
                                If Not IsNull(awardType) AND Len(Trim(CStr(awardType))) > 0 AND Trim(CStr(awardType)) <> "0" Then
                                    awardOutput = awardOutput & " " & Server.HTMLEncode(Trim(CStr(awardType)))
                                End If
                            end if
                            if len(awardShowname) > 0 then
                                If Not IsNull(awardShowname) AND Len(Trim(CStr(awardShowname))) > 0 AND Trim(CStr(awardShowname)) <> "0" Then
                                    awardOutput = awardOutput & " at " & Server.HTMLEncode(Trim(CStr(awardShowname)))
                                End If
                            end if 
                           if len(awardYear) > 0 then           
                                If Not IsNull(awardYear) AND Len(Trim(CStr(awardYear))) > 0 AND Trim(CStr(awardYear)) <> "0" Then
                                    awardOutput = awardOutput & " (" & Server.HTMLEncode(Trim(CStr(awardYear))) & ")"
                                End If
                            end if

                            If Len(Trim(awardOutput)) > 0 Then
                        %>
                        <tr>
                            <td><%=awardOutput%></td>
                        </tr>
                        <%
                            End If
                        Next
                        %>
                    </table>
                <% End If %>
            </div>

           <div class="photo-gallery">
          

            <% if len(photo1)> 3 then %>
                <img src="<%=photo1%>" id="main-animal-image" class="main-image my-foto" alt="Main image of <%=animalName%>">
             <% else %>
                <img src="/uploads/imagenotavailable.webp" id="main-animal-image" class="main-image my-foto" alt="<%=animalName%>">
             <% End If %>
                <% If photoCount > 1 Then %>
                <div class="thumbnails" id="thumbnail-container">
                    <% For i = 0 To photoCount - 1 %>

                  <%  If CheckLinkValidity(photos(0, i)) Then %>
                        <img src="<%=photos(0, i)%>" alt="<%=photos(1, i)%>" class="thumb-img" loading="lazy" onmouseover="swapImage(this.src); this.style.cursor='pointer';">
                  <% end if%>
                    
                        <% Next %>
                </div>
                <% End If %>


            </div>
        </div>
    </div> 
    

<% If IsArray(progeny) Then %>
  <div class="container">
        <div>
    <h2>Progeny</h2>
    <div class="progeny-grid">
        <% For i = 0 To UBound(progeny, 2) %>
            <div class="progeny-card">
                <a href="Details.asp?AnimalID=<%=progeny(0, i)%>">
                    <img src="<% If Not IsNull(progeny(3,i)) AND Len(progeny(3,i)) > 4 Then Response.Write(progeny(3,i)) Else Response.Write("/uploads/ImageNotAvailable.webp") End If %>" alt="<%=progeny(1, i)%>" loading="lazy">
                    <%=progeny(1, i)%>
                </a>
            </div>
        <% Next %>
    </div>
    </div>
</div>
<% End If %>




<%
'===================================================================
' HELPER SUB-ROUTINES FOR EPD & FIBER TABLES
'===================================================================

Sub PrintEPDRow(trait, valueKey, accKey, rankKey1, rankKey2)
    Response.Write("<tr>")
    Response.Write("<td class='label'>" & trait & "</td>")
    
    ' Print Value or -
    If hasEpdData AND epdData.Exists(valueKey) AND Not IsNull(epdData(valueKey)) Then Response.Write("<td>" & epdData(valueKey) & "</td>") Else Response.Write("<td>-</td>") End If
    
    ' Print Accuracy or -
    If hasEpdData AND epdData.Exists(accKey) then 
       if Not IsNull(epdData(accKey)) Then 
          Response.Write("<td>" & epdData(accKey) & "</td>") 
          Else 
            Response.Write("<td>-</td>") 
       End If
    end if
    ' Print Rank or -
    If hasEpdData AND epdData.Exists(rankKey1) AND epdData.Exists(rankKey2) AND Not IsNull(epdData(rankKey1)) AND Not IsNull(epdData(rankKey2)) AND epdData(rankKey1) > 0 Then
        Response.Write("<td>" & epdData(rankKey1) & " of " & epdData(rankKey2) & "</td>")
    Else
        Response.Write("<td>-</td>")
    End If
    
    Response.Write("</tr>")
End Sub

Sub PrintStat(val)
    If Not IsNull(val) AND CStr(val) <> "" Then Response.Write("<td>" & val & "</td>") Else Response.Write("<td>-</td>") End If
End Sub
%>

<% If hasEpdData AND HasVisibleEpdData(epdData) Then %>
    <h2>EPDs</h2>
    <table class="data-table">
        <thead>
            <tr>
                <th>Trait</th>
                <th>Value</th>
                <th>Accuracy</th>
                <th>Rank</th>
            </tr>
        </thead>
        <tbody>
            <%
            PrintEPDRow "AFD", "AFD", "AFDAcc", "AFDRank", "AFDRank2"
            PrintEPDRow "SDAFD", "SDAFD", "SDAFDAcc", "SDAFDRank", "SDAFDRank2"
            PrintEPDRow "SF", "SF", "SFAcc", "SFRank", "SFRank2"
            PrintEPDRow "%F>30", "PercentFGreaterThan30", "percentFgreaterThan30Acc", "percentFGreaterThan30Rank", "percentFGreaterThan30Rank2"
            PrintEPDRow "MC", "MC", "MCAcc", "MCRank", "MCRank2"
            PrintEPDRow "SDMC", "SDMC", "SDMCAcc", "SDMCRank", "SDMCRank2"
            PrintEPDRow "%M", "PercentM", "PercentMAcc", "PercentMRank", "PercentMRank2"
            PrintEPDRow "MSL", "MSL", "MSLAcc", "MSLRank", "MSLRank2"
            PrintEPDRow "FW", "FW", "FWAcc", "FWRank", "FWRank2"
            %>
        </tbody>
    </table>
<% End If %>

<% If IsArray(fiberStats) AND HasVisibleFiberData(fiberStats) Then %>
    <h2>Fiber Stats</h2>
    <table class="data-table">
        <thead>
            <tr>
                <th>Sample Date</th>
                <th>AFD</th>
                <th>SD</th>
                <th>COV</th>
                <th>%>30µ</th>
                <th>CF</th>
                <th>Curve</th>
            </tr>
        </thead>
        <tbody>
        <%
       
        For i = 0 To UBound(fiberStats, 2)
        
            ' --- NEW CHECK ---
            ' Before printing a row, check if it contains any visible data.
            hasRowData = false
            ' Loop through the actual stat columns (3 and up) for this specific row 'i'
            For x = 3 to UBound(fiberStats, 1)
                If Not IsNull(fiberStats(x, i)) then
                  if Len(Trim(CStr(fiberStats(x, i)))) > 0 AND Trim(CStr(fiberStats(x, i))) <> "0" Then
                    hasRowData = True
                    Exit For ' Found data, no need to check further for this row
                End If
                end if
            Next

            ' --- Only print the row if the check above passed ---
            If hasRowData Then
                Response.Write("<tr>")
                
                ' Column 1: Date
                Dim sampleDate
                sampleDate = ""
                If Not IsNull(fiberStats(0, i)) And fiberStats(0, i) > 0 Then sampleDate = sampleDate & fiberStats(0, i) & "/"
                If Not IsNull(fiberStats(1, i)) And fiberStats(1, i) > 0 Then sampleDate = sampleDate & fiberStats(1, i) & "/"
                If Not IsNull(fiberStats(2, i)) And fiberStats(2, i) > 0 Then sampleDate = sampleDate & fiberStats(2, i)
                If sampleDate = "" Then sampleDate = "-"
                Response.Write("<td>" & sampleDate & "</td>")
                
                ' Columns 2-7: The Stats (calling the helper Sub)
                PrintStat(fiberStats(3, i))  ' Average (AFD)
                PrintStat(fiberStats(4, i))  ' StandardDev (SD)
                PrintStat(fiberStats(5, i))  ' COV
                PrintStat(fiberStats(6, i))  ' GreaterThan30
                PrintStat(fiberStats(9, i))  ' CF
                PrintStat(fiberStats(11, i)) ' Curve
                
                Response.Write("</tr>")
            End If
        Next
        %>
        </tbody>
    </table>
<% End If %>
    
    
    <% If hasAncestryData Then %>
        <div class="container">
            <h2>Ancestry</h2>
            <table class="pedigree-table">
                <%
              Sub PrintAncestorBox(gender, name, color)
                    ' --- NEW LOGIC ---
                    ' First, check if there is ANY data to display before drawing the box.
                    If (Not IsNull(name) ) then
                      if  Len(Trim(CStr(name))) > 0 OR (Not IsNull(color) AND Len(Trim(CStr(color))) > 0) Then
                        
                        ' If we have data, then print the colored box and its contents.
                        Dim boxClass
                        If gender = "Male" Then boxClass = "male" Else boxClass = "female"
                        
                        Response.Write("<div class='pedigree-box " & boxClass & "'>")
                        If Not IsNull(name) AND Len(Trim(CStr(name))) > 0 Then
                            Response.Write("<b>" & Server.HTMLEncode(name) & "</b>")
                        End If
                        If Not IsNull(color) AND Len(Trim(CStr(color))) > 0 Then
                            Response.Write("<br><span class='small-text'>" & Server.HTMLEncode(color) & "</span>")
                        End If
                        Response.Write("</div>")
                       end if            
                    Else
                        ' If both name and color are empty, do nothing. This leaves the table cell blank and invisible.
                    End If
                End Sub
                %>
                <tr>
                    <td rowspan="8"><% PrintAncestorBox "Male", ancestryData("Sire"), ancestryData("SireColor") %></td>
                    <td rowspan="4"><% PrintAncestorBox "Male", ancestryData("SireSire"), ancestryData("SireSireColor") %></td>
                    <td rowspan="2"><% PrintAncestorBox "Male", ancestryData("SireSireSire"), ancestryData("SireSireSireColor") %></td>
                </tr>
                <tr>
                </tr>
                <tr>
                    <td rowspan="2"><% PrintAncestorBox "Female", ancestryData("SireSireDam"), ancestryData("SireSireDamColor") %></td>
                </tr>
                <tr>
                </tr>
                <tr>
                    <td rowspan="4"><% PrintAncestorBox "Female", ancestryData("Siredam"), ancestryData("SiredamColor") %></td>
                    <td rowspan="2"><% PrintAncestorBox "Male", ancestryData("SireDamSire"), ancestryData("SireDamSireColor") %></td>
                </tr>
                 <tr>
                </tr>
                <tr>
                    <td rowspan="2"><% PrintAncestorBox "Female", ancestryData("SireDamDam"), ancestryData("SireDamDamColor") %></td>
                </tr>
                 <tr>
                </tr>

                <tr>
                    <td rowspan="8"><% PrintAncestorBox "Female", ancestryData("Dam"), ancestryData("DamColor") %></td>
                    <td rowspan="4"><% PrintAncestorBox "Male", ancestryData("DamSire"), ancestryData("DamSireColor") %></td>
                    <td rowspan="2"><% PrintAncestorBox "Male", ancestryData("DamSireSire"), ancestryData("DamSireSireColor") %></td>
                </tr>
                 <tr>
                </tr>
                <tr>
                    <td rowspan="2"><% PrintAncestorBox "Female", ancestryData("DamSireDam"), ancestryData("DamSireDamColor") %></td>
                </tr>
                 <tr>
                </tr>
                <tr>
                    <td rowspan="4"><% PrintAncestorBox "Female", ancestryData("DamDam"), ancestryData("DamDamColor") %></td>
                    <td rowspan="2"><% PrintAncestorBox "Male", ancestryData("DamDamSire"), ancestryData("DamDamSireColor") %></td>
                </tr>
                 <tr>
                </tr>
                <tr>
                    <td rowspan="2"><% PrintAncestorBox "Female", ancestryData("DamDamDam"), ancestryData("DamDamDamColor") %></td>
                </tr>
                 <tr>
                </tr>
            </table>
        </div>
    <% End If %>
</div>

    <script src="https://code.jquery.com/jquery-3.7.1.min.js" defer></script>
    <script src="https://www.Oatmealfarmnetwork.com/js/zoomsl-3.0.min.js" defer></script>
    <script defer>
        function swapImage(newSrc) {
            document.getElementById('main-animal-image').src = newSrc;
        }
        document.addEventListener('DOMContentLoaded', function() {
            if (window.jQuery && $.fn.imagezoomsl) {
                $('.my-foto').imagezoomsl({
                    innerzoommagnifier: true,
                    magnifierborder: "5px solid #F0F0F0",
                    zoomrange: [2, 3],
                    zoomstart: 2,
                    magnifiersize: [200, 200]
                });
            } else {
                // Silently fail if jquery or plugin isn't available
            }
        });
    </script>



<!--#Include virtual="/Members/MembersFooter.asp"--> 
</body>
</html>