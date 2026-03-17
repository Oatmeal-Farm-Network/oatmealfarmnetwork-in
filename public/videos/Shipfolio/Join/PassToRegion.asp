<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<meta name="robots" content="nofollow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="revisit-after" content="1"/>
<meta name="Googlebot" content="nofollow"/>
</head>
<body>


<% dim Region
Region = Request.Form("Region")

response.write("Region=" & Region )
if len(Region) < 2 or Region="Country / Region" then
   response.redirect("/Join/Default.asp?Message=Please choose a Country/Region.")  
end if


If Region = "Australia" Then response.redirect("/Join/Australia/Default.asp") end if

If Region = "Africa" Then response.redirect("/Join/Africa/Default.asp") end if
If Region = "Asia" Then response.redirect("/Join/Asia/Default.asp") end if
If Region = "Canada" Then response.redirect("/Join/Canada/Default.asp") end if
If Region = "Caribbean" Then response.redirect("/Join/Caribbean/Default.asp") end if
If Region = "Central America" Then response.redirect("/Join/CentralAmerica/Default.asp") end if
If Region = "Europe" Then response.redirect("/Join/Europe/Default.asp") end if
If Region = "Japan" Then response.redirect("/Join/Japan/Default.asp") end if
If Region = "USA" Then response.redirect("/Join/USA/Default.asp") end if
If Region = "UK" Then response.redirect("/Join/UK/Default.asp") end if
If Region = "Mexico" Then response.redirect("/Join/Mexico/Default.asp") end if
If Region = "SaudiArabia" Then response.redirect("/Join/SaudiArabia/Default.asp") end if
If Region = "New Zealand" Then response.redirect("/Join/NewZealand/Default.asp") end if
If Region = "Russia" Then response.redirect("/Join/Russia/Default.asp") end if
If Region = "South America" Then response.redirect("/Join/SouthAmerica/Default.asp") end if
If Region = "South Pacific" Then response.redirect("/Join/SouthPacific/Default.asp") end if
If Region = "Other" Then response.redirect("/Join/Other/Default.asp") end if
%>
</body>
</html>

