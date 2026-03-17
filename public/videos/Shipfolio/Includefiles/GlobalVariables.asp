<!--#Include virtual="/includefiles/Conn.asp"-->

<HTTP-EQUIV="PRAGMA" CONTENT="NO-CACHE">
	<link rel="icon" type="image/x-icon" href="/logos/OFNFavicon.png">
    <link rel="shortcut icon" type="image/png" href="/logos/OFNFavicon.png"/>

	<%
' --- Function to return the path and filename as a pipe-separated string ---
Function GetPathAndFile()
    
    ' Get the full URL path (e.g., /PlantDB/index.asp)
    Dim strCurrentPath
    strCurrentPath = Request.ServerVariables("URL")
    
    ' Get the last part of the URL, which is the full script name (e.g., index.asp)
    Dim strCurrentFile
    strCurrentFile = Mid(strCurrentPath, InStrRev(strCurrentPath, "/") + 1)
    
    ' Handle case where URL might not have a file (e.g., /PlantDB/)
    If strCurrentFile = "" Then
        strCurrentFile = "default" ' Use a default name if it ends in a slash
    End If
    
    ' ----------------------------------------------------
    ' --- Logic to find PathAfterMembers (same as before) ---
    ' ----------------------------------------------------
    
    Dim strSearchString


    Dim intStartPos
    ' Use LCase on the path for case-insensitive matching of "/"

    strSearchString = "/"
    intStartPos = InStr(1, LCase(strCurrentPath), strSearchString, vbTextCompare)

    Dim strPathAfterMembers
    
    If intStartPos > 0 Then
        
        ' 1. Calculate the starting position *after* "/"
        Dim intSubStart
        intSubStart = intStartPos + Len(strSearchString)

        ' 2. Extract the remaining part of the URL (e.g., "PlantDB/index.asp")
        Dim strDirectoryPath
        strDirectoryPath = Mid(strCurrentPath, intSubStart)
        
        ' 3. Find the position of the first slash in the remaining path
        Dim intEndPos
        intEndPos = InStr(1, strDirectoryPath, "/")
        
        If intEndPos > 0 Then
            ' 4. Extract the directory name up to the first slash
            strPathAfterMembers = Left(strDirectoryPath, intEndPos - 1)
        Else
            ' This handles a URL like /PlantDB (no trailing slash)
            strPathAfterMembers = strDirectoryPath
        End If
    Else
        strPathAfterMembers = ""
    End If
    
    ' ----------------------------------------------------
    
    ' Return the two results separated by a pipe (|)
    GetPathAndFile = strPathAfterMembers & "|" & strCurrentFile
    
End Function


' --- Execution and Parsing ---

Dim strResults
strResults = GetPathAndFile()

' Split the string into an array
Dim arrResults
arrResults = Split(strResults, "|")

' Assign array elements to descriptive variables
Dim PathAfterMembers
PathAfterMembers = arrResults(0)

Dim CurrentFile
CurrentFile = arrResults(1) ' Assumes a filename was found or 'default' was set

' --- Output ---
'Response.Write "<p><strong>Path after /:</strong> " & PathAfterMembers & "</p>"
'Response.Write "<p><strong>Current File Name:</strong> " & CurrentFile & "</p>"


If Currentfile = "MembersAccountContactsEdit.asp" then Menu2 = "Account"
If Currentfile = "MembersPasswordChange.asp" then Menu2 = "Account"

Accounts = False
if CurrentFile = "Accounts.asp" or _
       CurrentFile = "CreateNewOrgAccount.asp" or _
       CurrentFile="MembersAnimalshome.asp" or _
       CurrentFile = "SetupAccountPlusstep2.asp" or _
       CurrentFile = "MembersOrgAccountContactsEdit.asp" or _
       CurrentFile = "MembersAnimalAdd1.asp" or _
       CurrentFile = "MembersAnimalAdd1B.asp" or _
       CurrentFile = "MembersAnimalAdd2.ASP" or _
       CurrentFile = "MembersAnimalAdd3.asp" or _
       CurrentFile = "MembersAnimalAdd4.asp" or _
       CurrentFile = "MembersAnimalAdd5.asp" or _
       CurrentFile = "MembersAnimalAdd6.asp" or _
       CurrentFile = "MembersAnimalAdd7.asp" or _
       CurrentFile = "MembersAnimalAdd8.asp" or _
       CurrentFile = "MembersPhotos.asp" or _
       CurrentFile = "MembersEditAnimalBasics.asp"  or _
       CurrentFile = "MembersEditAnimalPricing.asp"  or _
       CurrentFile = "MembersEditAnimalDescription.asp"  or _
       CurrentFile = "MembersEditAnimalFiber.asp"  or _
       CurrentFile = "MembersEditAnimalAncestry.asp"  or _
       CurrentFile = "membersPhotos.asp"  or _
       CurrentFile = "MembersAnimalsStats.asp"  or _
       CurrentFile = "MembersTransferAnimal.asp"  or _
       CurrentFile = "search_ranch.asp"  or _
       CurrentFile = "MembersTransferAnimalStep3.asp"  or _
       CurrentFile = "MembersTransferAnimalStep3.asp"  or _
       CurrentFile = "MembersTransferAnimalStep4.asp"  or _
       CurrentFile = "MembersTransferAnimalStep4.asp"  or _

       CurrentFile = "AccountHome.asp" or _
       CurrentFile = "MembersPasswordChange.asp" then
    Accounts = True
end if  

Knowledgebases =False
if CurrentFile = "KnowledgbasesHome.asp" or _
       CurrentFile = "SetupAccountPlusstep2.asp" or _
       lcase(PathAfterMembers)="plantdb" or _
       lcase(PathAfterMembers)="livestockdb" or _
       CurrentFile = "MembersProduceInventory.asp" or _

       lcase(PathAfterMembers)="ingredientsdb" then
       Knowledgebases = True
end if 


Marketplaces =False
if lcase(PathAfterMembers)="livestockmarketplace" or _
    lcase(PathAfterMembers)="animals"  then
    Marketplaces = True
end if 

LivestockMarketplace =False
if lcase(PathAfterMembers)="livestockmarketplace" then
    LivestockMarketplace  = True
end if 

LivestockKnowledgebase =False
if lcase(PathAfterMembers)="livestockdb"  or _
    CurrentFile = "Details.asp" then
       LivestockKnowledgebase  = True
end if 

%>


<% WebSiteName = "Oatmeal AI"
BorderColor = "#ebebeb"
sitename = "Oatmeal AI"
sitecountry = "USA"
searchcountry = "USA"
fullcountryname = "United States Of America"
currencycode = "USD"
country_id = 1228

CurrentWebsiteURL = "www.LivestockofAmerica.com"
CountryADText = " and ShowOnLOA  = 1 "
custexclusionstring = " "
CurrentWebsite = "LivestockofAmerica" 
countrysearch = " and (custcountry = 'USA' or custcountry = 'America' or custcountry = 'USA' ) "
websiteURL = "https://www.oatmealfarmnetwork.com/"

Provincelist = "<option value=Alabama>Alabama</option><option value= Alaska >Alaska</option><option value= Arizona >Arizona</option><option value= Arkansas >Arkansas</option><option value= California >California</option><option value= Colorado >Colorado</option><option value= Connecticut >Connecticut</option><option value= Delaware >Delaware</option><option value= 'District Of Columbia' >District Of Columbia</option><option value= Florida >Florida</option><option value= Georgia >Georgia</option><option value= Hawaii >Hawaii</option><option value= Idaho >Idaho</option><option value= Illinois >Illinois</option><option value= Indiana >Indiana</option><option value= Iowa >Iowa</option><option value= Kansas >Kansas</option><option value= Kentucky >Kentucky</option><option value= Louisiana >Louisiana</option><option value= Maine >Maine</option><option value= Maryland >Maryland</option><option value= Massachusetts >Massachusetts</option><option value= Michigan >Michigan</option><option value= Minnesota >Minnesota</option><option value= Mississippi >Mississippi</option><option value= Missouri >Missouri</option><option value= Montana >Montana</option><option value= Nebraska >Nebraska</option><option value= Nevada >Nevada</option><option value= 'New Hampshire' >New Hampshire</option><option value= 'New Jersey' >New Jersey</option><option value= 'New Mexico' >New Mexico</option><option value= 'New York' >New York</option><option value= 'North Carolina' >North Carolina</option><option value= 'North Dakota' >North Dakota</option><option value= Ohio >Ohio</option><option value= Oklahoma >Oklahoma</option><option value= 'Oregon' >Oregon</option><option value= Pennsylvania >Pennsylvania</option><option value= 'Rhode Island' >Rhode Island</option><option value= 'South Carolina' >South Carolina</option><option value= 'South Dakota' >South Dakota</option><option value= Tennessee >Tennessee</option><option value= Texas >Texas</option><option value= Utah >Utah</option><option value= Vermont >Vermont</option><option value= Virginia >Virginia</option><option value= Washington >Washington</option><option value= 'West Virginia' >West Virginia</option><option value= Wisconsin >Wisconsin</option><option value= Wyoming >Wyoming</option></select>"

ProvinceTitle = "State"
LivestockColor1 = "#A32715"
LivestockColor2 = "#EFAE15"

ProductColor1 = "darkgreen"
ProductColor2 = "#EFAE15"

RanchColor1 = "#3393B8"
RanchColor2 = "#EFAE15"


Set rs = Server.CreateObject("ADODB.Recordset")


Session.Timeout = 30



currentdate = now
HeaderAdfound = false
FFAADiscount = 40


currenturl = "https://www.oatmealfarmnetwork.com/" & Request.ServerVariables("URL")
servername = Request.ServerVariables("URL")
str1 = lcase(servername)
str2 = "alpacas"
If InStr(str1,str2) > 0 Then
	SpeciesID=2
End If  
str1 = lcase(servername)
str2 = "dogs"
If InStr(str1,str2) > 0 Then
	SpeciesID=3
End If 
str1 = lcase(servername)
str2 = "llamas"
If InStr(str1,str2) > 0 Then
	SpeciesID=4
End If 
str1 = lcase(servername)
str2 = "horses"
If InStr(str1,str2) > 0 Then
	SpeciesID=5
End If 
str1 = lcase(servername)
str2 = "goats"
If InStr(str1,str2) > 0 Then
	SpeciesID=6
End If 
str1 = lcase(servername)
str2 = "donkeys"
If InStr(str1,str2) > 0 Then
	SpeciesID=7
End If 
str1 = lcase(servername)
str2 = "cattle"
If InStr(str1,str2) > 0 Then
	SpeciesID=7
End If 
str1 = lcase(servername)
str2 = "bison"
If InStr(str1,str2) > 0 Then
	SpeciesID=9
End If 
str1 = lcase(servername)
str2 = "sheep"
If InStr(str1,str2) > 0 Then
	SpeciesID=10
End If 
str1 = lcase(servername)
str2 = "rabbits"
If InStr(str1,str2) > 0 Then
	SpeciesID=11
End If 
str1 = lcase(servername)
str2 = "pigs"
If InStr(str1,str2) > 0 Then
	SpeciesID=12
End If 
str1 = lcase(servername)
str2 = "chickens"
If InStr(str1,str2) > 0 Then
	SpeciesID=13
End If 
str1 = lcase(servername)
str2 = "turkeys"
If InStr(str1,str2) > 0 Then
	SpeciesID=14
End If 
str1 = lcase(servername)
str2 = "ducks"
If InStr(str1,str2) > 0 Then
	SpeciesID=15
End If 
str1 = lcase(servername)
str2 = "cats"
If InStr(str1,str2) > 0 Then
	SpeciesID=16
End If 
 
str1 = lcase(servername)
str2 = "yaks"
If InStr(str1,str2) > 0 Then
	SpeciesID=17
End If 

str1 = lcase(servername)
str2 = "camels"
If InStr(str1,str2) > 0 Then
	SpeciesID=18
End If 
str1 = lcase(servername)
str2 = "emus"
If InStr(str1,str2) > 0 Then
	SpeciesID=19
End If 

%>



 