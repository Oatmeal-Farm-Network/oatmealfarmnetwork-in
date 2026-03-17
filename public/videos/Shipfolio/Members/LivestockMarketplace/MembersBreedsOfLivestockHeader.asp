<%
' --- Configuration ---
' 1. Define colors based on your Oatmeal Farm Network logo
PrimaryColor  = "#445437" ' Dark Green from the logo
HighlightColor = "#E2A92B" ' Gold/Yellow from the logo
TextColor   = "#FFFFFF" ' White for the text

' 2. Define all navigation items in a single array for easy management.
Dim aBreedsArray(16, 3)
aBreedsArray(0, 0) = "LivestockHome": aBreedsArray(0, 1) = "/icons/BarnIconWhite.png": aBreedsArray(0, 2) = "30": aBreedsArray(0, 3) = "Breeds<br />Home"
aBreedsArray(1, 0) = "Alpacas": aBreedsArray(1, 1) = "/icons/Alpacaiconwhite.png": aBreedsArray(1, 2) = "40": aBreedsArray(1, 3) = "Alpacas"
aBreedsArray(2, 0) = "Bison": aBreedsArray(2, 1) = "/icons/buffaloiconwhite.png": aBreedsArray(2, 2) = "40": aBreedsArray(2, 3) = "Bison"
aBreedsArray(3, 0) = "Cattle": aBreedsArray(3, 1) = "/icons/CattleIconWhite.png": aBreedsArray(3, 2) = "40": aBreedsArray(3, 3) = "Cattle"
aBreedsArray(4, 0) = "Chickens": aBreedsArray(4, 1) = "/icons/Chickeniconwhite.png": aBreedsArray(4, 2) = "30": aBreedsArray(4, 3) = "Chickens"
aBreedsArray(5, 0) = "Dogs": aBreedsArray(5, 1) = "/icons/Dogiconwhite.png": aBreedsArray(5, 2) = "40": aBreedsArray(5, 3) = "Dogs"
aBreedsArray(6, 0) = "Donkeys": aBreedsArray(6, 1) = "/icons/Donkeyiconwhite.png": aBreedsArray(6, 2) = "40": aBreedsArray(6, 3) = "Donkeys"
aBreedsArray(7, 0) = "Emus": aBreedsArray(7, 1) = "/icons/Emuiconwhite.png": aBreedsArray(7, 2) = "40": aBreedsArray(7, 3) = "Emus"
aBreedsArray(8, 0) = "Goats": aBreedsArray(8, 1) = "/icons/Goaticonwhite.png": aBreedsArray(8, 2) = "40": aBreedsArray(8, 3) = "Goats"
aBreedsArray(9, 0) = "HoneyBees": aBreedsArray(9, 1) = "/icons/HoneyBeesiconwhite.png": aBreedsArray(9, 2) = "40": aBreedsArray(9, 3) = "Bees"
aBreedsArray(10, 0) = "Horses": aBreedsArray(10, 1) = "/icons/Horseiconwhite.png": aBreedsArray(10, 2) = "40": aBreedsArray(10, 3) = "Horses"
aBreedsArray(11, 0) = "Llamas": aBreedsArray(11, 1) = "/icons/Llamaiconwhite.png": aBreedsArray(11, 2) = "40": aBreedsArray(11, 3) = "Llamas"
aBreedsArray(12, 0) = "Pigs": aBreedsArray(12, 1) = "/icons/PigsIconWhite.png": aBreedsArray(12, 2) = "40": aBreedsArray(12, 3) = "Pigs"
aBreedsArray(13, 0) = "Rabbits": aBreedsArray(13, 1) = "/icons/Rabbiticonwhite.png": aBreedsArray(13, 2) = "25": aBreedsArray(13, 3) = "Rabbits"
aBreedsArray(14, 0) = "Sheep": aBreedsArray(14, 1) = "/icons/Sheepiconwhite.png": aBreedsArray(14, 2) = "40": aBreedsArray(14, 3) = "Sheep"
aBreedsArray(15, 0) = "Turkeys": aBreedsArray(15, 1) = "/icons/Turkeyiconwhite.png": aBreedsArray(15, 2) = "40": aBreedsArray(15, 3) = "Turkeys"
aBreedsArray(16, 0) = "Yaks": aBreedsArray(16, 1) = "/icons/Yakiconwhite.png": aBreedsArray(16, 2) = "40": aBreedsArray(16, 3) = "Yaks"

' *** NEW: Define the variable representing the current directory/active breed ***
' For demonstration purposes, we hardcode it to "Goats". 
' In your production environment, this value would be extracted from the URL (e.g., using Request.ServerVariables("URL")).

strCurrentPath = Request.ServerVariables("URL")
strSearchString = "/LivestockMarketplace/"
intStartPos = InStr(1, LCase(strCurrentPath), strSearchString, vbTextCompare)
Dim strPathAfterLivestockMarketplace

If intStartPos > 0 Then
    
    intSubStart = intStartPos + Len(strSearchString)

    strDirectoryPath = Mid(strCurrentPath, intSubStart)
    
    Dim intEndPos
    intEndPos = InStr(1, strDirectoryPath, "/")
    
    If intEndPos > 0 Then
        strPathAfterLivestockMarketplace = Left(strDirectoryPath, intEndPos - 1)
    Else
        ' This handles a URL like /Members/PlantDB (no trailing slash)
        strPathAfterLivestockMarketplace = strDirectoryPath
    End If
Else
    strPathAfterLivestockMarketplace = ""
End If

sCurrentDirectory = strPathAfterLivestockMarketplace
'Response.write("sCurrentDirectory=" & sCurrentDirectory)
%>

<style>
	/* A font that matches the "Oatmeal Farm Network" serif style */
	@import url('https://fonts.googleapis.com/css2?family=Cinzel:wght@400;700&display=swap');

	.farm-nav-bar {
		font-family: 'Cinzel', serif;
		display: flex;
		justify-content: space-evenly;
		align-items: stretch;
		background-color: <%=PrimaryColor%>;
		width: 100%;
		box-sizing: border-box;
	}
	.farm-nav-item {
		/* Correctly aligns content to the bottom */
		display: flex;
		flex-direction: column;
		justify-content: flex-end;
		
		color: <%=TextColor%>;
		text-align: center;
		text-decoration: none;
		padding: 10px 5px;
		flex-grow: 1;
		transition: background-color 0.3s ease, color 0.3s ease;
		font-size: 14px;
		line-height: 1.2;
		min-height: 80px; /* Ensure all items have a minimum height */
	}
	.farm-nav-item:hover {
		background-color: <%=HighlightColor%>;
		color: #333;
		text-decoration: none;
	}
	.farm-nav-item.active {
		/* This applies the HighlightColor for the active item */
		background-color: <%=HighlightColor%>;
		color: #000;
		font-weight: 700;
	}
	.farm-nav-item img {
		display: block;
		margin: 0 auto 5px;
		max-height: 40px;
	}
</style>

<div class="d-none d-lg-block">
	<nav class="farm-nav-bar">
		<%
		
		For i = 0 To UBound(aBreedsArray, 1)
			sBreedName = aBreedsArray(i, 0)
			sIconPath = aBreedsArray(i, 1)
			sIconWidth = aBreedsArray(i, 2)
			sLinkText = aBreedsArray(i, 3)
			sActiveClass = ""
			
			' *** REVISED LOGIC: Check if the current directory matches the breed name (case-insensitive) ***
			' This implements: If LCase(Trim(sCurrentDirectory)) = LCase(Trim(sBreedName)) Then
			If LCase(Trim(lcase(sCurrentDirectory))) = LCase(Trim(sBreedName)) Then
				sActiveClass = " active"
			End If
			
			' Generate the link using the data from the array
			Response.Write "<a href='/Members/LivestockMarketplace/" & sBreedName & "' class='farm-nav-item" & sActiveClass & "'>"
			Response.Write " <img src='" & sIconPath & "' width='" & sIconWidth & "' alt='" & sBreedName & "' />"
			Response.Write " <span>" & sLinkText & "</span>"
			Response.Write "</a>" & vbCrLf
		Next
		%>
	</nav>
</div>