<!doctype html>
<%@ Language=VBScript %>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<HEAD>
<!--#Include file="AdminGlobalVariables.asp"--> 
</HEAD>
<body >
<% 
WebsiteType =  request.Form("WebsiteType")
'response.write("WebsiteType=" & WebsiteType )
HomePageDesignAspect=  request.Form("HomePageDesignAspect")

ShowPages = request.Form("ShowPages")
PageAvailable = request.Form("PageAvailable")
MenuDropdowns= request.Form("MenuDropdowns")
AddPages= request.Form("AddPages")
SlideshowDimensions = request.Form("SlideshowDimensions")
MultipleHeaders= request.form("MultipleHeaders")
ShowLOA= request.form("ShowLOA")

str1 = SlideshowDimensions
str2 = "''"
If InStr(str1,str2) > 0 Then
	SlideshowDimensions= Replace(str1,  str2, "'")
End If 


Dim DataConnection, cmdDC, RecordSet
Dim RecordToEdit, Updated
Set DataConnection = Server.CreateObject("ADODB.Connection")

Query =  " UPDATE SiteDesign Set MultipleHeaders = " & MultipleHeaders & ", "
Query =  Query & " ShowLOA= " & ShowLOA & " "
Query =  Query & " where PeopleID = 667"
response.write("Query=" & Query )
Conn.Execute(Query) 



Query =  " UPDATE SiteDesigntemp Set MultipleHeaders = " & MultipleHeaders & ", "
Query =  Query & " ShowLOA= " & ShowLOA & " "
Query =  Query & " where PeopleID = 667"
Conn.Execute(Query) 





if len(MenuDropdowns) > 1 then
Query =  " UPDATE SiteDesign Set MenuDropdowns = " & MenuDropdowns & ", "
Query =  Query & " AddPages= " & AddPages & " "
Query =  Query & " where PeopleID = 667"
Conn.Execute(Query) 


Query =  " UPDATE SiteDesigntemp Set MenuDropdowns =" & MenuDropdowns & " ,"
Query =  Query & " AddPages= " & AddPages & " "
Query =  Query & " where PeopleID = 667"
Conn.Execute(Query) 
end if


 

response.write("WebsiteType=" & WebsiteType )
str1 = WebsiteType
str2 = "Livestock"
If InStr(str1, str2) > 0  Then
ShowLivestock = True
Query =  " UPDATE WebsiteType Set Active = True "
Query =  Query & " where WebsiteTypeID = 1" 
Conn.Execute(Query) 
else
ShowLivestock = False
Query =  " UPDATE WebsiteType Set Active = False "
Query =  Query & " where WebsiteTypeID = 1" 
Conn.Execute(Query) 
end if
  

str1 = WebsiteType
str2 = "ECommerce"
If InStr(str1, str2) > 0  Then
Query =  " UPDATE WebsiteType Set Active = True "
Query =  Query & " where WebsiteTypeID = 2" 
Conn.Execute(Query) 
else
Query =  " UPDATE WebsiteType Set Active = False "
Query =  Query & " where WebsiteTypeID = 2" 
Conn.Execute(Query) 
end if

str1 = WebsiteType
str2 = "Artwork"
If InStr(str1, str2) > 0  Then
Query =  " UPDATE WebsiteType Set Active = True "
Query =  Query & " where WebsiteTypeID = 3" 
Conn.Execute(Query) 
else
Query =  " UPDATE WebsiteType Set Active = False "
Query =  Query & " where WebsiteTypeID = 3" 
Conn.Execute(Query) 
end if

  
str1 = WebsiteType
str2 = "LivestockAssociation"
If InStr(str1, str2) > 0  Then
Query =  " UPDATE WebsiteType Set Active = True "
Query =  Query & " where WebsiteTypeID = 4" 
Connection.Execute(Query) 
else
Query =  " UPDATE WebsiteType Set Active = False "
Query =  Query & " where WebsiteTypeID = 4" 
Conn.Execute(Query) 
end if

  
str1 = WebsiteType
str2 = "Services"
If InStr(str1, str2) > 0  Then
Query =  " UPDATE WebsiteType Set Active = True "
Query =  Query & " where WebsiteTypeID = 6" 
'response.Write("Query=" & Query )
Conn.Execute(Query) 
else
Query =  " UPDATE WebsiteType Set Active = False "
Query =  Query & " where WebsiteTypeID = 6" 
Conn.Execute(Query) 
end if

'if len(HomePageDesignAspect) > 0 then
response.write(HomePageDesignAspect)

slideshow2found = false

str1 = HomePageDesignAspect
str2 = "SlideShow2"
If InStr(str1, str2) > 0  Then
slideshow2found = true
Query =  " UPDATE LayoutHomePage Set HomePageDesignAspectAvailable = True "
Query =  Query & " where HomePageLayoutID = 8" 
Conn.Execute(Query) 
else
Query =  " UPDATE LayoutHomePage Set HomePageDesignAspectAvailable = False "
Query =  Query & " where HomePageLayoutID = 8" 
Conn.Execute(Query) 
end if


str1 = HomePageDesignAspect
str2 = "SlideShow"
If InStr(str1, str2) > 0 and slideshow2found = false Then
Query =  " UPDATE LayoutHomePage Set HomePageDesignAspectAvailable = True ,"
 Query =  Query & " HomePageDesignAspectTitle = '" & SlideshowDimensions & "'"
Query =  Query & " where HomePageLayoutID = 1" 
Conn.Execute(Query) 
else
Query =  " UPDATE LayoutHomePage Set HomePageDesignAspectAvailable = False "
Query =  Query & " where HomePageLayoutID = 1" 
Conn.Execute(Query) 
end if
response.write("Query=" & Query )


str1 = HomePageDesignAspect
str2 = "Textblocks"
If InStr(str1, str2) > 0  Then
Query =  " UPDATE LayoutHomePage Set HomePageDesignAspectAvailable = True "
Query =  Query & " where HomePageLayoutID = 7" 
Conn.Execute(Query) 
else
Query =  " UPDATE LayoutHomePage Set HomePageDesignAspectAvailable = False "
Query =  Query & " where HomePageLayoutID = 7" 
Conn.Execute(Query) 
end if


str1 = HomePageDesignAspect
str2 = "FeaturedEvent"
If InStr(str1, str2) > 0  Then
Query =  " UPDATE LayoutHomePage Set HomePageDesignAspectAvailable = True "
Query =  Query & " where HomePageLayoutID = 9" 
Conn.Execute(Query) 
else
Query =  " UPDATE LayoutHomePage Set HomePageDesignAspectAvailable = False "
Query =  Query & " where HomePageLayoutID = 9" 
Conn.Execute(Query) 
end if


str1 = HomePageDesignAspect
str2 = "FeaturedNews"
If InStr(str1, str2) > 0  Then
Query =  " UPDATE LayoutHomePage Set HomePageDesignAspectAvailable = True "
Query =  Query & " where HomePageLayoutID = 2" 
Conn.Execute(Query) 
else
Query =  " UPDATE LayoutHomePage Set HomePageDesignAspectAvailable = False "
Query =  Query & " where HomePageLayoutID = 2" 
Conn.Execute(Query) 
end if

str1 = HomePageDesignAspect
str2 = "FeaturedAnimal"
If InStr(str1, str2) > 0  Then
Query =  " UPDATE LayoutHomePage Set HomePageDesignAspectAvailable = True "
Query =  Query & " where HomePageLayoutID = 3" 
Conn.Execute(Query) 
else
Query =  " UPDATE LayoutHomePage Set HomePageDesignAspectAvailable = False "
Query =  Query & " where HomePageLayoutID = 3" 
Conn.Execute(Query) 
end if


str1 = HomePageDesignAspect
str2 = "FeaturedStud"
If InStr(str1, str2) > 0  Then
Query =  " UPDATE LayoutHomePage Set HomePageDesignAspectAvailable = True "
Query =  Query & " where HomePageLayoutID = 4" 
Conn.Execute(Query) 
else
Query =  " UPDATE LayoutHomePage Set HomePageDesignAspectAvailable = False "
Query =  Query & " where HomePageLayoutID = 4" 
Conn.Execute(Query) 
end if
response.write("Query=" & Query)

str1 = HomePageDesignAspect
str2 = "FeaturedVideo"
If InStr(str1, str2) > 0  Then
Query =  " UPDATE LayoutHomePage Set HomePageDesignAspectAvailable = True "
Query =  Query & " where HomePageLayoutID = 6" 
Conn.Execute(Query) 
else
Query =  " UPDATE LayoutHomePage Set HomePageDesignAspectAvailable = False "
Query =  Query & " where HomePageLayoutID = 6" 
Conn.Execute(Query) 
end if
response.write("Query=" & Query )


str1 = HomePageDesignAspect
str2 = "FeaturedProduct"
If InStr(str1, str2) > 0  Then
Query =  " UPDATE LayoutHomePage Set HomePageDesignAspectAvailable = True "
Query =  Query & " where HomePageLayoutID = 5" 
Conn.Execute(Query) 
else
Query =  " UPDATE LayoutHomePage Set HomePageDesignAspectAvailable = False "
Query =  Query & " where HomePageLayoutID = 5" 
Conn.Execute(Query) 
end if
'end if


sqlw = "select * from WebsiteType where WebsiteType = 'livestock' "
 Set rsw = Server.CreateObject("ADODB.Recordset")
 rsw.Open sqlw, conn, 3, 3 
if not  rsw.eof then
if rsw("Active") = True then
ShowLivestock = True
else
ShowLivestock = False
end if
end if
rsw.close
 
 sqlw = "select * from WebsiteType where WebsiteType = 'Ecommerce' "
 Set rsw = Server.CreateObject("ADODB.Recordset")
 rsw.Open sqlw, conn, 3, 3 
if not  rsw.eof then
if rsw("Active") = True then
ShowEcommerce = True
else
ShowEcommerce = False
end if
end if
rsw.close

 sqlw = "select * from WebsiteType where WebsiteType = 'Artwork' "
 Set rsw = Server.CreateObject("ADODB.Recordset")
 rsw.Open sqlw, conn, 3, 3 
if not  rsw.eof then
if rsw("Active") = True then
ShowArtwork = True
else
ShowArtwork = False
end if
end if
rsw.close

 sqlw = "select * from WebsiteType where WebsiteType = 'LivestockAssociation' "
 Set rsw = Server.CreateObject("ADODB.Recordset")
 rsw.Open sqlw, conn, 3, 3 
if not  rsw.eof then
if rsw("Active") = True then
ShowLivestockAssociation = True
else
ShowLivestockAssociation = False
end if
end if
rsw.close
response.redirect("AdminWebsitesetup.asp")
%>
 </Body>
</HTML>
