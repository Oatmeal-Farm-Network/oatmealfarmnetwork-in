<!--#Include virtual="/includefiles/Conn.asp"-->
<% WebSiteName = "Agriculture Associations"
BorderColor = "white"
sitename = "Agriculture Associations"
Sitenamelong = "Agriculture Associations"
Set rs = Server.CreateObject("ADODB.Recordset")
PeopleID = request.QueryString("PeopleID")
if len(PeopleID) < 1 then
PeopleID = session("currentPeopleID")
end if
if len(PeopleID) < 1 then
PeopleID = session("PeopleID")
end if
CurrentPeopleID = PeopleID
currentdate = now
HeaderAdfound = false
FFAADiscount = 40

currenturl = "https://www.Livestockoftheworld.com" & Request.ServerVariables("URL")
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
	SpeciesID=8
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

<link rel="shortcut icon" type="image/png" href="/images/LOTWFavIcon.png"/>
<link rel="shortcut icon" type="image/png" href="https://www.LivestockOfTheWorld.com/images/LOTWFavIcon.png"/>


<meta name="msvalidate.01" content="B3CD3001A90F0BEAD4B91C6F98650E6C" />


<meta name="viewport" content="width=480">

<meta property="fb:app_id" content="293033627835665"/>
<div id="fb-root"></div>
<script>    (function (d, s, id) {
        var js, fjs = d.getElementsByTagName(s)[0];
        if (d.getElementById(id)) return;
        js = d.createElement(s); js.id = id;
        js.src = "//connect.facebook.net/en_US/sdk.js#xfbml=1&version=v2.10&appId=293033627835665";
        fjs.parentNode.insertBefore(js, fjs);
    } (document, 'script', 'facebook-jssdk'));</script>