<%
' --- Configuration ---
' 1. Define colors based on your Oatmeal Farm Network logo
Dim PrimaryColor, HighlightColor, TextColor
PrimaryColor   = "#445437" ' Dark Green from the logo
HighlightColor = "#E2A92B" ' Gold/Yellow from the logo
TextColor      = "#FFFFFF" ' White for the text

' 2. Define all navigation items in a single array for easy management.
' REVISED: "InternalName" for home is now "Home" for clarity.
Dim aBreeds(16, 3)
aBreeds(0, 0) = "Home": aBreeds(0, 1) = "/icons/BarnIconWhite.png": aBreeds(0, 2) = "30": aBreeds(0, 3) = "Breeds<br />Home"
aBreeds(1, 0) = "Alpacas": aBreeds(1, 1) = "/icons/Alpacaiconwhite.png": aBreeds(1, 2) = "40": aBreeds(1, 3) = "Alpacas"
aBreeds(2, 0) = "Bison": aBreeds(2, 1) = "/icons/buffaloiconwhite.png": aBreeds(2, 2) = "40": aBreeds(2, 3) = "Bison"
aBreeds(3, 0) = "Cattle": aBreeds(3, 1) = "/icons/CattleIconWhite.png": aBreeds(3, 2) = "40": aBreeds(3, 3) = "Cattle"
aBreeds(4, 0) = "Chickens": aBreeds(4, 1) = "/icons/Chickeniconwhite.png": aBreeds(4, 2) = "30": aBreeds(4, 3) = "Chickens"
aBreeds(5, 0) = "Dogs": aBreeds(5, 1) = "/icons/Dogiconwhite.png": aBreeds(5, 2) = "40": aBreeds(5, 3) = "Dogs"
aBreeds(6, 0) = "Donkeys": aBreeds(6, 1) = "/icons/Donkeyiconwhite.png": aBreeds(6, 2) = "40": aBreeds(6, 3) = "Donkeys"
aBreeds(7, 0) = "Emus": aBreeds(7, 1) = "/icons/Emuiconwhite.png": aBreeds(7, 2) = "40": aBreeds(7, 3) = "Emus"
aBreeds(8, 0) = "Goats": aBreeds(8, 1) = "/icons/Goaticonwhite.png": aBreeds(8, 2) = "40": aBreeds(8, 3) = "Goats"
aBreeds(9, 0) = "HoneyBees": aBreeds(9, 1) = "/icons/HoneyBeesiconwhite.png": aBreeds(9, 2) = "40": aBreeds(9, 3) = "Bees"
aBreeds(10, 0) = "Horses": aBreeds(10, 1) = "/icons/Horseiconwhite.png": aBreeds(10, 2) = "40": aBreeds(10, 3) = "Horses"
aBreeds(11, 0) = "Llamas": aBreeds(11, 1) = "/icons/Llamaiconwhite.png": aBreeds(11, 2) = "40": aBreeds(11, 3) = "Llamas"
aBreeds(12, 0) = "Pigs": aBreeds(12, 1) = "/icons/PigsIconWhite.png": aBreeds(12, 2) = "40": aBreeds(12, 3) = "Pigs"
aBreeds(13, 0) = "Rabbits": aBreeds(13, 1) = "/icons/Rabbiticonwhite.png": aBreeds(13, 2) = "25": aBreeds(13, 3) = "Rabbits"
aBreeds(14, 0) = "Sheep": aBreeds(14, 1) = "/icons/Sheepiconwhite.png": aBreeds(14, 2) = "40": aBreeds(14, 3) = "Sheep"
aBreeds(15, 0) = "Turkeys": aBreeds(15, 1) = "/icons/Turkeyiconwhite.png": aBreeds(15, 2) = "40": aBreeds(15, 3) = "Turkeys"
aBreeds(16, 0) = "Yaks": aBreeds(16, 1) = "/icons/Yakiconwhite.png": aBreeds(16, 2) = "40": aBreeds(16, 3) = "Yaks"
%>

<style>
    @import url('https://fonts.googleapis.com/css2?family=Cinzel:wght@400;700&display=swap');
    .farm-nav-bar { font-family: 'Cinzel', serif; display: flex; justify-content: space-evenly; align-items: stretch; background-color: <%=PrimaryColor%>; width: 100%; box-sizing: border-box; }
    .farm-nav-item { display: flex; flex-direction: column; justify-content: flex-end; color: <%=TextColor%>; text-align: center; text-decoration: none; padding: 10px 5px; flex-grow: 1; transition: background-color 0.3s ease, color 0.3s ease; font-size: 14px; line-height: 1.2; }
    .farm-nav-item:hover { background-color: <%=HighlightColor%>; color: #333; text-decoration: none; }
    .farm-nav-item.active { background-color: <%=HighlightColor%>; color: #000; }
    .farm-nav-item img { display: block; margin: 0 auto 5px; max-height: 40px; }
</style>

<div class="d-none d-lg-block">
    <nav class="farm-nav-bar">
        <%
        Dim i, sBreedName, sIconPath, sIconWidth, sLinkText, sActiveClass, sLinkURL
        
        ' NEW: Get the current page's URL path to determine the active tab reliably.
           sCurrentPath = Request.ServerVariables("SCRIPT_NAME")
        
        For i = 0 To UBound(aBreeds, 1)
            sBreedName = aBreeds(i, 0)
            sIconPath = aBreeds(i, 1)
            sIconWidth = aBreeds(i, 2)
            sLinkText = aBreeds(i, 3)
            sActiveClass = ""
            
            ' NEW: Special handling for the "Breeds Home" link URL
            If sBreedName = "Home" Then
                sLinkURL = "/Members/LivestockDB/"
            Else
                sLinkURL = "/Members/LivestockDB/" & sBreedName & "/"
            End If
            
            ' REVISED LOGIC: Check if the breed name is in the current URL path.
            ' This is much more reliable than using an external variable.
            If sBreedName <> "Home" And InStr(1, sCurrentPath, "/" & sBreedName & "/", vbTextCompare) > 0 Then
                sActiveClass = " active"
            ' Logic to highlight the "Home" button correctly.
            ElseIf sBreedName = "Home" And LCase(sCurrentPath) = "/Members/livestockdb/default.asp" Or LCase(sCurrentPath) = "/livestockdb/" Then
                sActiveClass = " active"
            End If
            
            ' Generate the link using the corrected URL
            Response.Write "<a href='" & sLinkURL & "?Screenwidth=" & Server.HTMLEncode(Screenwidth) & "' class='farm-nav-item" & sActiveClass & "'>"
            Response.Write "  <img src='" & sIconPath & "' width='" & sIconWidth & "' alt='" & sBreedName & "' />"
            Response.Write "  <span>" & sLinkText & "</span>"
            Response.Write "</a>" & vbCrLf
        Next
        %>
    </nav>
</div>
<br>