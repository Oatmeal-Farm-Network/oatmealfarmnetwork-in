<!DOCTYPE HTML>
<HTML>
<HEAD>
<title>The Andresen Group Content Management System</title>
       <link rel="stylesheet" type="text/css" href="/administration/style.css">
</HEAD>

<BODY bgcolor = "white">

    <!--#Include File="AdminSecurityInclude.asp"--> 
    <!--#Include File="AdminGlobalVariables.asp"-->
 
<%
dim LinkText1
dim Link1
dim LinkDescription1
dim CatID1

	LinkText1=Request.Form("LinkText" ) 
	Link1=Request.Form("Link" ) 
	LinkDescription1=Request.Form("LinkDescription") 
	CatID1=Request.Form("CatID") 
	LinkShowOnfooter=Request.Form("LinkShowOnfooter") 
	variables = "LinkText1=" & LinkText & "&Link=" & Link1 & "&LinkDescription=" & LinkDescription & "&CatID=" & CatID1 & "&LinkShowOnfooter=" & LinkShowOnfooter
missing = False
if len(LinkText1) > 0 then
else
missing = True
missingtext = "<li>Title</li>"
end if

if len(Link1) > 0 then
else
missing = True
missingtext = missingtext & "<li>Web Address</li>"
end if

if missing = True then
   response.Redirect("AdminLinksHome.asp?Missing=" & missingtext & "&" & variables)
end if

if len(CatID1) > 0 then
else
CatID1 = 2
end if

If Len(LinkText1) > 1 Then
 Else
 LinkText1 = " "
 End If 

If Len(Link1) > 1 Then
 Else
Link1 = " "
 End If 

If Len(LinkDescription1) > 1 Then
 Else
	LinkDescription1 = " "
 End If 

If Len(CatID1) > 0 Then
 Else
	CatID1 = 0
 End If 

str1 = LinkText1
str2 = "'"
If InStr(str1,str2) > 0 Then
	LinkText1= Replace(str1, "'", "''")
End If

str1 = LinkDescription1
str2 = "'"
If InStr(str1,str2) > 0 Then
	LinkDescription1= Replace(str1, "'", "''")
End If


str1 = Link1
str2 = "'"
If InStr(str1,str2) > 0 Then
	Link1= Replace(str1, "'", "''")
End If

str1 = lcase(Link1)
str2 = "http://"
If InStr(str1,str2) > 0 Then
	Link1= Replace(str1, str2, "")
End If

str1 = lcase(Link1)
str2 = "http:/"
If InStr(str1,str2) > 0 Then
	Link1= Replace(str1, str2, "")
End If

str1 = lcase(Link1)
str2 = "http:"
If InStr(str1,str2) > 0 Then
	Link1= Replace(str1, str2, "")
End If

imagefound =False 
LinkImage = "/uploads/ImageNotAvailable.jpg"


if (instr(1, trim(lcase(LinkText1)), "alpaca infinity") > 0 or instr(1, trim(lcase(LinkText1)), "alpacainfinity") > 0 ) and  imagefound =False  then 
        imagefound =True 
        LinkImage = "/images/AlpacaInfinityBig.jpg" 
        CatID1 = 7
 end if 
 
 if instr(1, trim(lcase(LinkText1)), "etsy") > 0 and  imagefound =False  then 
        imagefound =True 
        LinkImage = "/images/EtsyBig.jpg" 
        CatID1 = 7
 end if 
 
   if (instr(1, trim(lcase(LinkText1)), "alpacaseller") > 0 or instr(1, trim(lcase(LinkText1)), "alpaca seller") > 0 ) and  imagefound =False  then 
        imagefound =True 
        LinkImage = "/images/AlpacaSellerBig.jpg" 
        CatID1 = 7
 end if 
 
   if (instr(1, trim(lcase(LinkText1)), "alpacastreet") > 0 or instr(1, trim(lcase(LinkText1)), "alpaca street") > 0 ) and  imagefound =False  then 
        imagefound =True 
        LinkImage = "/images/AlpacaStreetBig.jpg" 
        CatID1 = 7
 end if 
    
if (instr(trim(lcase(LinkText1)), "alpacanation") > 0 or instr(trim(lcase(LinkText1)), "alpaca nation") > 0 ) and  imagefound =False  then 
        imagefound =True 
        LinkImage = "/images/AlpacaNationBig.jpg" 
        CatID1 = 7
 end if 
 
 if (instr(1, trim(lcase(LinkText1)), "openherd") > 0 or instr(1, trim(lcase(LinkText1)), "open herd") > 0 ) and  imagefound =False  then 
        imagefound =True 
        LinkImage = "/images/OpenHerdBig.jpg" 
        CatID1 = 7
 end if 
 
 
  if (instr(1, trim(lcase(LinkText1)), "facebook") > 0 or instr(1, trim(lcase(LinkText1)), "face book") > 0 ) and  imagefound =False  then 
        imagefound =True 
        LinkImage = "/images/FacebookBig.jpg" 
        CatID1 = 3
 end if 
 
   if (instr(1, trim(lcase(LinkText1)), "twitter") > 0 or instr(1, trim(lcase(LinkText1)), "twiter") > 0 ) and  imagefound =False  then 
        imagefound =True 
        LinkImage = "/images/TwitterBig.jpg" 
        CatID1 = 3
 end if 
 
 
if (instr(1, trim(lcase(LinkText1)), "linkedin") > 0 or instr(1, trim(lcase(LinkText1)), "linked in") > 0 ) and  imagefound =False  then 
        imagefound =True 
        LinkImage = "/images/LinkedInBig.jpg" 
        CatID1 = 3
 end if 
 
 if instr(1, trim(lcase(LinkText1)), "manta") > 0 and imagefound =False  then 
        imagefound =True 
        LinkImage = "/images/MantaBig.jpg" 
        CatID1 = 3
 end if 
 
 
  if ( instr(1, trim(lcase(LinkText1)), "blogspot") > 0 or  instr(1, trim(lcase(LinkText1)), "blog spot") > 0 or  instr(1, trim(lcase(Link1)), "blogspot") > 0 ) and imagefound =False  then 
        imagefound =True 
        LinkImage = "/uploads/Blogspot.png" 
        CatID1 = 3
 end if 
 
 
 
 
 if ( instr(1, trim(lcase(LinkText1)), "suri network") > 0 or  instr(1, trim(lcase(LinkText1)), "surinetwork") > 0 or  instr(1, trim(lcase(Link1)), "surinetwork.org") > 0 ) and imagefound =False  then 
        imagefound =True 
        LinkImage = "/uploads/SuriNetwork.png" 
        CatID1 = 1
 end if 
 
  if instr(1, trim(lcase(LinkText1)), "aaww") > 0 and imagefound =False  then 
        imagefound =True 
        LinkImage = "/uploads/AAWW.jpg" 
        CatID1 = 1
 end if 
 
if (instr(1, trim(lcase(LinkText1)), "aoba") > 0 or instr(1, trim(lcase(LinkText1)), "alpaca owners and breeders association") > 0    or instr(1, trim(lcase(Link1)), "alpacainfo") > 0) and  imagefound =False  then 
        imagefound =True 
        LinkImage = "/uploads/aoba.jpg" 
        CatID1 = 1
 end if 
 
    if (instr(1, trim(lcase(LinkText1)), "ari") > 0 or instr(1, trim(lcase(Link1)), "alpacaregistry") > 0 ) and imagefound =False  then 
        imagefound =True 
        LinkImage = "/uploads/ARI.jpg" 
        CatID1 = 1
 end if 
 
     if (instr(1, trim(lcase(LinkText1)), "pnaa") > 0 or instr(1, trim(lcase(Link1)), "pnaa.org") > 0 ) and imagefound =False  then 
        imagefound =True 
        LinkImage = "/uploads/PNAA.jpg" 
        CatID1 = 1
 end if 
 
 if (instr(1, trim(lcase(LinkText1)), "sojaa") > 0 or instr(1, trim(lcase(Link1)), "sojaa.org") > 0 ) and imagefound =False  then 
        imagefound =True 
        LinkImage = "/uploads/sojaa_logo.jpg" 
        CatID1 = 1
 end if 


 if (instr(1, trim(lcase(LinkText1)), "afcna") > 0 or  instr(1, trim(lcase(LinkText1)), "fiber cooperative") > 0 or  instr(1, trim(lcase(LinkText1)), "fiber co-op") > 0 or instr(1, trim(lcase(Link1)), "afcna.com") > 0 ) and imagefound =False  then 
        imagefound =True 
        LinkImage = "/uploads/AFCNAlogo.png" 
        CatID1 = 1
 end if 


if (instr(1, trim(lcase(LinkText1)), "alpaca llama show association") > 0 or  instr(1, trim(lcase(LinkText1)), "alsa") > 0 or instr(1, trim(lcase(Link1)), "alsashow.net") > 0 ) and imagefound =False  then 
        imagefound =True 
        LinkImage = "/uploads/alsatrans2.jpg" 
        CatID1 = 1
 end if 
 

if (instr(1, trim(lcase(LinkText1)), "arf") > 0 or  instr(1, trim(lcase(LinkText1)), "alpaca research foundation") > 0 or instr(1, trim(lcase(Link1)), "alpacaresearch.org") > 0 ) and imagefound =False  then 
        imagefound =True 
        LinkImage = "/uploads/arf.gif" 
        CatID1 = 1
 end if 
 
 if (instr(1, trim(lcase(LinkText1)), "alpaca united") > 0 or  instr(1, trim(lcase(LinkText1)), "alpacaunited") > 0 or instr(1, trim(lcase(Link1)), "alpacaunited.com") > 0 ) and imagefound =False  then 
        imagefound =True 
        LinkImage = "/uploads/alpacaunited.gif" 
        CatID1 = 1
 end if 
 
 


Query =  "INSERT INTO Links ( LinkText, Link, LinkImage, CatID, LinkShowOnfooter, LinkDescription)" 
Query =  Query + " Values ('" &  LinkText1 & "'," 
Query =  Query & " '" &  Link1 & "'," 
Query =  Query & " '" &  LinkImage & "'," 
Query =  Query & " " &  CatID1 & "," 
Query =  Query & " " &  LinkShowOnfooter & "," 
Query =  Query & " '" &  LinkDescription1  & "')"

Set DataConnection = Server.CreateObject("ADODB.Connection")

DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) 	& ";" 
response.write(Query)
DataConnection.Execute(Query) 
DataConnection.Close
Set DataConnection = Nothing 

Response.Redirect("AdminLinksHome.asp#Existing")
%>
</Body>
</HTML>