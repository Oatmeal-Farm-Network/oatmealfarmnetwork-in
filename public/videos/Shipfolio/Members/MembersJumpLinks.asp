<%
' --- Optimized Animal Page ---

' --- 1. GET AND VALIDATE ANIMAL ID (ONCE) ---

BusinessID=Request.querystring("BusinessID")

' --- Dictionaries for cleaner lookups ---
Set SpeciesDict = Server.CreateObject("Scripting.Dictionary")
SpeciesDict.Add "2", "Alpaca"
SpeciesDict.Add "3", "Dog"
SpeciesDict.Add "4", "Llama"
SpeciesDict.Add "5", "Horse"
SpeciesDict.Add "6", "Goat"
SpeciesDict.Add "7", "Donkey"
SpeciesDict.Add "8", "Cattle"
SpeciesDict.Add "9", "Bison"
SpeciesDict.Add "10", "Sheep"
SpeciesDict.Add "11", "Rabbit"
SpeciesDict.Add "12", "Pig"
SpeciesDict.Add "13", "Chicken"
SpeciesDict.Add "14", "Turkey"
SpeciesDict.Add "15", "Duck"
SpeciesDict.Add "16", "Cat"
SpeciesDict.Add "17", "Yak"
SpeciesDict.Add "19", "Emu"
' Add other species here...

' Categories that allow 'Breedings' link
Set CategoryBreedingsDict = Server.CreateObject("Scripting.Dictionary")
For Each item In Array("2","8","17","49","51","62","63","80","82","90","91","96","98","102","103","107","117")
    CategoryBreedingsDict.Add item, True
Next

' Species that allow 'Fiber' link
Set CategoryFiberDict = Server.CreateObject("Scripting.Dictionary")
For Each item In Array("2", "4", "6", "10", "11")
    CategoryFiberDict.Add CStr(item), True
Next


If IsValidID Then
    ' This single query uses LEFT JOINs to get all data at once.
    ' It's much faster than running 5 separate queries.
    sql = "SELECT " & _
          "  A.AnimalID, A.FullName, A.SpeciesID, A.Category, A.NumberofAnimals, A.Horns, A.Vaccinations, " & _
          "  A.DOBMonth, A.DOBDay, A.DOBYear, A.Temperment, A.Weight, A.Height, A.Gaited, A.Warmblooded, " & _
          "  A.BreedID, A.BreedID2, A.BreedID3, A.BreedID4, " & _
          "  SA.SpeciesSalesType, " & _
          "  AP.PercentPeruvian, AP.PercentAccoyo, AP.PercentBolivian, AP.PercentChilean, AP.PercentUnknownOther, " & _
          "  C.Color1, C.Color2, C.Color3, C.Color4, C.Color5 " & _
          "FROM Animals AS A " & _
          "LEFT JOIN SpeciesAvailable AS SA ON A.SpeciesID = SA.SpeciesID " & _
          "LEFT JOIN AncestryPercents AS AP ON A.AnimalID = AP.AnimalID " & _
          "LEFT JOIN Colors AS C ON A.AnimalID = C.AnimalID " & _
          "WHERE A.AnimalID = " & AnimalID

         ' response.write("sql=" & sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 0, 1 ' adOpenForwardOnly, adLockReadOnly for best performance

    If Not rs.EOF Then
        ' --- 3. STORE ALL VALUES IN LOCAL VARIABLES ---
        AnimalName = rs("FullName") & ""
        SpeciesID = rs("SpeciesID")
        Category = rs("Category") & ""
        NumberOfAnimals = rs("NumberOfAnimals")
        if len(NumberOfAnimals) > 0 then 
        else
        NumberOfAnimals = 1
        end if

        If  NumberOfAnimals = 0 Then NumberOfAnimals = 1
        SpeciesSalesType = rs("SpeciesSalesType") & ""
        
        ' You can get all other fields from the recordset here as needed
        ' e.g., DOBMonth = rs("DOBMonth"), etc.
    End If
    rs.Close
    Set rs = Nothing
End If

' --- Get Species Name from Dictionary ---
If SpeciesDict.Exists(CStr(SpeciesID)) Then
    SpeciesName = SpeciesDict(CStr(SpeciesID))
Else
    SpeciesName = "Unknown"
End If

%>
<style>
    /* --- Responsive Wrapping Navigation Links --- */

    /* The main wrapper that controls the flow */
    .nav-wrapper-wrap {
        /* Use Flexbox to manage the link alignment and wrapping */
        display: flex;
        /* Crucial: Allows items to drop to the next line when space runs out */
        flex-wrap: wrap; 
        /* Aligns links to the start, but you can use 'center' if preferred */
        justify-content: flex-start; 
        
        background-color: #f1f1f1;
        border-bottom: 3px solid #ccc;
        padding: 5px 0; /* Add some vertical padding around the links */
    }

    /* Style for each individual link cell */
    .nav-wrapper-wrap li {
        /* Remove default list styling */
        list-style-type: none;
        /* Reset margins/padding */
        margin: 5px; 
        padding: 0;
        /* Ensures the link block takes up the whole list item, 
           making the hover effect cover the cell */
        display: inline-block; 
    }

    /* Style for the actual clickable <a> element */
    .nav-wrapper-wrap li a {
        display: block;
        color: #000;
        padding: 0px 15px; /* Adjust padding for a button-like feel */
        text-decoration: none;
        text-align: center;
        /* Make it look like a button/cell */
        border-radius: 4px; /* Slightly rounded corners */
   
        transition: background-color 0.2s; /* Smooth transition for hover */
        /* Set a minimum width for small links to avoid them being too narrow */
        min-width: 80px; 

    }

    /* Hover effect */
    .nav-wrapper-wrap li a:hover {
        background-color: #ddd;
        border-color: #aaa;
    }

    /* Current/Active link styling */
    .nav-wrapper-wrap li a.current {
        background-color: #4CAF50;
        color: white;
        font-weight: bold;
        border-color: #4CAF50;
    }

</style>
<div>
    <a name="Top"></a>
    
    <ul class="nav-wrapper-wrap"> 
        <li class="nav-item "><a class="dropdown-item" href="MembersAnimalshome.asp?animalID=<%=AnimalID %>&BusinessID=<%=BusinessID %>#top">List</a></li>
        <li class="nav-item "><a class="dropdown-item" href="MembersAnimalAdd1.asp?animalID=<%=AnimalID %>&BusinessID=<%=BusinessID %>#top">Add</a></li>
        <% If IsValidID And AnimalID > 0 Then %>
            <li class="nav-item "><a class="dropdown-item" href="MembersEditAnimalBasics.asp?animalID=<%=AnimalID %>&BusinessID=<%=BusinessID %>#top">Basics</a></li>
            <li class="nav-item "><a class="dropdown-item" href="MembersEditAnimalPricing.asp?animalID=<%=AnimalID %>&BusinessID=<%=BusinessID %>#top">Pricing</a></li>
            <% If CategoryBreedingsDict.Exists(Category) And AnimalID > 0 Then %>
                <li class="nav-item "><a class="dropdown-item" href="MembersFemaleDataFrame.asp?animalID=<%=AnimalID %>&BusinessID=<%=BusinessID %>#top">Breedings</a></li>
            <% End If %>
            <li class="nav-item "><a class="dropdown-item" href="MembersEditAnimalDescription.asp?animalID=<%=AnimalID %>&BusinessID=<%=BusinessID %>#top">Description</a></li>
            <% If NumberOfAnimals < 2 And AnimalID > 0 And CStr(SpeciesID) <> "33" Then %>
                <li class="nav-item "><a class="dropdown-item" href="MembersEditAnimalAwards.asp?animalID=<%=AnimalID %>&BusinessID=<%=BusinessID %>#top">Awards</a></li>
            <% End If %>
            <% If NumberOfAnimals < 2 And AnimalID > 0 And CategoryFiberDict.Exists(CStr(SpeciesID)) Then %>
                <li class="nav-item "><a class="dropdown-item" href="MembersEditAnimalFiber.asp?animalID=<%=AnimalID %>&BusinessID=<%=BusinessID %>#top">Fiber / Wool</a></li>
            <% End If %>
            <% If showEPDs Then %>
                <li class="nav-item "><a class="dropdown-item" href="MembersAlpacaEPDFrame?animalID=<%=AnimalID %>&BusinessID=<%=BusinessID %>#top">EPDs</a></li>
            <% End If %>
            <% If NumberOfAnimals < 2 And AnimalID > 0 And CStr(SpeciesID) <> "33" Then %>
                <li class="nav-item "><a class="dropdown-item" href="MembersEditAnimalAncestry.asp?animalID=<%=AnimalID %>&BusinessID=<%=BusinessID %>#top">Ancestry</a></li>
            <% End If %>
            <li class="nav-item "><a class="dropdown-item" href="membersPhotos.asp?animalID=<%=AnimalID %>&BusinessID=<%=BusinessID %>#top">Photos</a></li>
            <li class="nav-item "><a class="dropdown-item" href="MembersAnimalsStats.asp?animalID=<%=AnimalID %>&BusinessID=<%=BusinessID %>#top">Stats</a></li>
        <% End If %>
        <li class="nav-item "><a class="dropdown-item" href="MembersTransferAnimal.asp?BusinessID=<%=BusinessID %>#top">Transfer</a></li>
    </ul>
<% 
if AnimalID > 0 then %>
    <table width="100%" class="body"><tr><td class="body"><h3><%= Server.HTMLEncode(AnimalName) %></h3></td></tr></table>

    <% If IsValidID And Not (Current3 = "Summary" Or Current3 = "Delete" Or Current3 = "Statistics" Or Current3 = "AddAnimals") Then %>
        <div class="embed-responsive embed-responsive-16by9">
            <iframe class="embed-responsive-item roundedtopandbottom" src="MembersAnimalPublishFrame.asp?AnimalID=<%=AnimalID %>&BusinessID=<%=BusinessID %>&NumberofAnimals=<%=NumberOfAnimals %>" style="width:100%; height:220px; border:none; background-color:white;" scrolling="no"></iframe>
        </div>
    <% End If %>
    <% End If %>
</div>