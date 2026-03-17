<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<title><%=Sitenamelong %> Administration</title>
<meta name="Title" content="<%=Sitenamelong %> Administration"/>
<meta name="robots" content="nofollow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="revisit-after" content="1"/>
<meta name="Googlebot" content="nofollow"/>
<link rel="shortcut icon" href="/infinityknot.ico" /> 
<link rel="icon" href="http://www.alpacainfinity.com/alpacachamps/infinityknot.ico" /> 
<meta name="author" content="The Andresen Group"/>
<link rel="stylesheet" type="text/css" href="/style.css" />
</HEAD>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center">
<!--#Include file="AdminGlobalVariables.asp"-->
<% Current = "siteadmin" %>
<% Current2="siteAdmin" %> 
<!--#Include file="siteadminHeader.asp"-->
<% If not rs.State = adStateClosed Then
rs.close
End If   	
%>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth %>"><tr><td class = "roundedtop" align = "left">
<H1><div align = "left">Website Setup</div></H1>
</td></tr>
<tr><td class = "roundedBottom" align = "center" width = "<%=screenwidth %>">
<% FirstTime = False 
WebsiteType =  request.Form("WebsiteType")
if len(WebsiteType) > 0 then
else
FirstTime = True
end if
HomePageDesignAspect=  request.Form("HomePageDesignAspect")
ShowPages = request.Form("ShowPages")
PageAvailable = request.Form("PageAvailable")
MenuDropdowns= request.Form("MenuDropdowns")
AddPages= request.Form("AddPages")
SlideshowDimensions = request.Form("SlideshowDimensions")

str1 = SlideshowDimensions
str2 = "''"
If InStr(str1,str2) > 0 Then
	SlideshowDimensions= Replace(str1,  str2, "'")
End If 


'Species1ID = 0
'Species2ID = 0
'Species3ID = 0
'Species4ID = 0
'Species5ID = 0
'Species6ID = 0
'Species7ID = 0
'Species8ID = 0
'Species9ID = 0
'Species10ID = 0
'Species11ID = 0
'Species12ID = 0
'Species13ID = 0
'Species14ID = 0


Species1ID = request.Form("Species1ID")
PreferedSpecies1ID =request.Form("PreferedSpecies1ID")
Species2ID = request.Form("Species2ID")
PreferedSpecies2ID =request.Form("PreferedSpecies2ID")
Species3ID = request.Form("Species3ID")
PreferedSpecies3ID =request.Form("PreferedSpecies3ID")
Species4ID = request.Form("Species4ID")
PreferedSpecies4ID =request.Form("PreferedSpecies4ID")
Species5ID = request.Form("Species5ID")
PreferedSpecies5ID =request.Form("PreferedSpecies5ID")
Species6ID = request.Form("Species6ID")
PreferedSpecies6ID =request.Form("PreferedSpecies6ID")
Species7ID = request.Form("Species7ID")
PreferedSpecies7ID =request.Form("PreferedSpecies7ID")
Species8ID = request.Form("Species8ID")
PreferedSpecies8ID =request.Form("PreferedSpecies8ID")
Species9ID = request.Form("Species9ID")
PreferedSpecies9ID =request.Form("PreferedSpecies9ID")
Species10ID = request.Form("Species10ID")
PreferedSpecies10ID =request.Form("PreferedSpecies10ID")
Species11ID = request.Form("Species11ID")
PreferedSpecies11ID =request.Form("PreferedSpecies11ID")
Species12ID = request.Form("Species12ID")
PreferedSpecies12ID =request.Form("PreferedSpecies12ID")
Species13ID = request.Form("Species13ID")
PreferedSpecies13ID =request.Form("PreferedSpecies13ID")
Species14ID = request.Form("Species14ID")
PreferedSpecies14ID =request.Form("PreferedSpecies14ID")
PeopleID = session("PeopleID")
if (Species1ID =0 or Species1ID ="0") and len(Species1ID) > 0 then 
ClearSpecies1ID = True
else
ClearSpecies1ID = False
end if

if (Species2ID =0 or Species2ID ="0") and len(Species2ID) > 0 then 
ClearSpecies2ID = True
else
ClearSpecies2ID = False
end if
if (Species3ID =0 or Species3ID ="0") and len(Species3ID) > 0 then 
ClearSpecies3ID = True
else
ClearSpecies3ID = False
end if
if (Species4ID =0 or Species4ID ="0") and len(Species4ID) > 0 then 
ClearSpecies4ID = True
else
ClearSpecies4ID = False
end if
if (Species5ID =0 or Species5ID ="0") and len(Species5ID) > 0 then 
ClearSpecies5ID = True
else
ClearSpecies5ID = False
end if
if (Species6ID =0 or Species6ID ="0") and len(Species6ID) > 0 then 
ClearSpecies6ID = True
else
ClearSpecies6ID = False
end if
if (Species7ID =0 or Species7ID ="0") and len(Species7ID) > 0 then 
ClearSpecies7ID = True
else
ClearSpecies7ID = False
end if
if (Species8ID =0 or Species8ID ="0") and len(Species8ID) > 0 then 
ClearSpecies8ID = True
else
ClearSpecies8ID = False
end if
if (Species9ID =0 or Species9ID ="0") and len(Species9ID) > 0 then 
ClearSpecies9ID = True
else
ClearSpecies9ID = False
end if

if (Species10ID =0 or Species10ID ="0") and len(Species10ID) > 0 then 
ClearSpecies10ID = True
else
ClearSpecies10ID = False
end if
if (Species11ID =0 or Species11ID ="0") and len(Species11ID) > 0 then 
ClearSpecies11ID = True
else
ClearSpecies11ID = False
end if
if (Species12ID =0 or Species12ID ="0") and len(Species12ID) > 0 then 
ClearSpecies12ID = True
else
ClearSpecies12ID = False
end if
if (Species13ID =0 or Species13ID ="0") and len(Species13ID) > 0 then 
ClearSpecies13ID = True
else
ClearSpecies13ID = False
end if
if (Species14ID =0 or Species14ID ="0") and len(Species14ID) > 0 then 
ClearSpecies14ID = True
else
ClearSpecies14ID = False
end if



if Species1ID > 0 then 
Query =  " UPDATE SpeciesAvailable Set SpeciesAvailableonSite = True,"
Query =  Query & " SpeciesPriority = 1 "
Query =  Query & " where SpeciesID = " & Species1ID
Conn.Execute(Query) 
else
'ClearSpecies1ID = True
end if 


if Species2ID> 0 then
Query =  " UPDATE SpeciesAvailable Set SpeciesAvailableonSite = True,"
Query =  Query & " SpeciesPriority = 2 "
Query =  Query & " where SpeciesID = " & Species2ID
Conn.Execute(Query) 
else
'ClearSpecies2ID = True
end if 

if Species3ID> 0 then
Query =  " UPDATE SpeciesAvailable Set SpeciesAvailableonSite = True,"
Query =  Query & " SpeciesPriority = 3 "
Query =  Query & " where SpeciesID = " & Species3ID
Conn.Execute(Query) 
else
'ClearSpecies3ID = True
end if 

if Species4ID> 0 then
Query =  " UPDATE SpeciesAvailable Set SpeciesAvailableonSite = True,"
Query =  Query & " SpeciesPriority = 4 "
Query =  Query & " where SpeciesID = " & Species4ID
Conn.Execute(Query) 
else
'ClearSpecies4ID = True
end if 

if Species5ID > 0 then
Query =  " UPDATE SpeciesAvailable Set SpeciesAvailableonSite = True,"
Query =  Query & " SpeciesPriority = 5 "
Query =  Query & " where SpeciesID = " & Species5ID
Conn.Execute(Query) 
else
'ClearSpecies5ID = True
end if 

if Species6ID> 0 then
Query =  " UPDATE SpeciesAvailable Set SpeciesAvailableonSite = True,"
Query =  Query & " SpeciesPriority = 6 "
Query =  Query & " where SpeciesID = " & Species6ID
Conn.Execute(Query) 
else
'ClearSpecies6ID = True
end if 

if Species7ID> 0 then
Query =  " UPDATE SpeciesAvailable Set SpeciesAvailableonSite = True,"
Query =  Query & " SpeciesPriority = 7 "
Query =  Query & " where SpeciesID = " & Species7ID
Conn.Execute(Query) 
else
'ClearSpecies7ID = True
end if 

if Species8ID > 0 then
Query =  " UPDATE SpeciesAvailable Set SpeciesAvailableonSite = True,"
Query =  Query & " SpeciesPriority = 8 "
Query =  Query & " where SpeciesID = " & Species8ID
Conn.Execute(Query) 
else
'ClearSpecies8ID = True
end if 
 
 
if Species9ID > 0 then
Query =  " UPDATE SpeciesAvailable Set SpeciesAvailableonSite = True,"
Query =  Query & " SpeciesPriority = 9 "
Query =  Query & " where SpeciesID = " & Species9ID  
Conn.Execute(Query) 
else
'ClearSpecies9ID = True
end if 


if Species10ID> 0 then
Query =  " UPDATE SpeciesAvailable Set SpeciesAvailableonSite = True,"
Query =  Query & " SpeciesPriority = 10 "
Query =  Query & " where SpeciesID = " & Species10ID
Conn.Execute(Query) 
else
'ClearSpecies10ID = True
end if 

if Species11ID> 0 then
Query =  " UPDATE SpeciesAvailable Set SpeciesAvailableonSite = True,"
Query =  Query & " SpeciesPriority = 11 "
Query =  Query & " where SpeciesID = " & Species11ID
Conn.Execute(Query) 
else
'ClearSpecies11ID = True
end if 

if Species12ID> 0 then
Query =  " UPDATE SpeciesAvailable Set SpeciesAvailableonSite = True,"
Query =  Query & " SpeciesPriority = 12 "
Query =  Query & " where SpeciesID = " & Species12ID
Conn.Execute(Query) 
else
'ClearSpecies12ID = True
end if 

if Species13ID> 0 then
Query =  " UPDATE SpeciesAvailable Set SpeciesAvailableonSite = True,"
Query =  Query & " SpeciesPriority = 13 "
Query =  Query & " where SpeciesID = " & Species13ID
Conn.Execute(Query) 
else
'ClearSpecies13ID = True
end if 

if Species14ID> 0 then
Query =  " UPDATE SpeciesAvailable Set SpeciesAvailableonSite = True,"
Query =  Query & " SpeciesPriority = 14 "
Query =  Query & " where SpeciesID = " & Species14ID
Conn.Execute(Query) 
else
'ClearSpecies14ID = True
end if 



 sql = "select * from SpeciesAvailable where SpeciesAvailableonSite = True Order by SpeciesPriority "
		
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof	 then
Species1ID = rs("SpeciesID")
if ClearSpecies1ID = True then
Query =  " UPDATE SpeciesAvailable Set SpeciesAvailableonSite = False,"
Query =  Query & " SpeciesPriority = 0 "
Query =  Query & " where SpeciesID = " & Species1ID
Conn.Execute(Query) 
end if
if rs.recordcount > 1 then
rs.movenext
Species2ID = rs("SpeciesID")

if ClearSpecies2ID = True then
Query =  " UPDATE SpeciesAvailable Set SpeciesAvailableonSite = False,"
Query =  Query & " SpeciesPriority = 0 "
Query =  Query & " where SpeciesID = " & Species2ID
Conn.Execute(Query) 
end if
end if

if rs.recordcount > 2 then
rs.movenext
Species3ID = rs("SpeciesID")
if ClearSpecies3ID = True then
Query =  " UPDATE SpeciesAvailable Set SpeciesAvailableonSite = False,"
Query =  Query & " SpeciesPriority = 0 "
Query =  Query & " where SpeciesID = " & Species3ID
Conn.Execute(Query) 
end if
end if

if rs.recordcount > 3 then
rs.movenext
Species4ID = rs("SpeciesID")
if ClearSpecies4ID = True then
Query =  " UPDATE SpeciesAvailable Set SpeciesAvailableonSite = False,"
Query =  Query & " SpeciesPriority = 0 "
Query =  Query & " where SpeciesID = " & Species4ID
Conn.Execute(Query) 
end if
end if


if rs.recordcount > 4 then
rs.movenext
Species5ID = rs("SpeciesID")
if ClearSpecies5ID = True then
Query =  " UPDATE SpeciesAvailable Set SpeciesAvailableonSite = False,"
Query =  Query & " SpeciesPriority = 0 "
Query =  Query & " where SpeciesID = " & Species5ID
Conn.Execute(Query) 
end if
end if

if rs.recordcount > 5 then
rs.movenext
Species6ID = rs("SpeciesID")
if ClearSpecies6ID = True then
Query =  " UPDATE SpeciesAvailable Set SpeciesAvailableonSite = False,"
Query =  Query & " SpeciesPriority = 0 "
Query =  Query & " where SpeciesID = " & Species6ID
Conn.Execute(Query) 
end if
end if


if rs.recordcount > 6 then
rs.movenext
Species7ID = rs("SpeciesID")
if ClearSpecies7ID = True then
Query =  " UPDATE SpeciesAvailable Set SpeciesAvailableonSite = False,"
Query =  Query & " SpeciesPriority = 0 "
Query =  Query & " where SpeciesID = " & Species7ID
Conn.Execute(Query) 
end if
end if


if rs.recordcount > 7 then
rs.movenext
Species8ID = rs("SpeciesID")
if ClearSpecies8ID = True then
Query =  " UPDATE SpeciesAvailable Set SpeciesAvailableonSite = False,"
Query =  Query & " SpeciesPriority = 0 "
Query =  Query & " where SpeciesID = " & Species8ID
Conn.Execute(Query) 
end if
end if


if rs.recordcount > 8 then
rs.movenext
Species9ID = rs("SpeciesID")
if ClearSpecies9ID = True then
Query =  " UPDATE SpeciesAvailable Set SpeciesAvailableonSite = False,"
Query =  Query & " SpeciesPriority = 0 "
Query =  Query & " where SpeciesID = " & Species9ID
Conn.Execute(Query) 
end if
end if

if rs.recordcount > 9 then
rs.movenext
Species10ID = rs("SpeciesID")
if ClearSpecies10ID = True then
Query =  " UPDATE SpeciesAvailable Set SpeciesAvailableonSite = False,"
Query =  Query & " SpeciesPriority = 0 "
Query =  Query & " where SpeciesID = " & Species10ID
Conn.Execute(Query) 
end if
end if


if rs.recordcount > 10 then
rs.movenext
Species11ID = rs("SpeciesID")
if ClearSpecies11ID = True then
Query =  " UPDATE SpeciesAvailable Set SpeciesAvailableonSite = False,"
Query =  Query & " SpeciesPriority = 0 "
Query =  Query & " where SpeciesID = " & Species11ID
Conn.Execute(Query) 
end if
end if



if rs.recordcount > 11 then
rs.movenext
Species12ID = rs("SpeciesID")
if ClearSpecies12ID = True then
Query =  " UPDATE SpeciesAvailable Set SpeciesAvailableonSite = False,"
Query =  Query & " SpeciesPriority = 0 "
Query =  Query & " where SpeciesID = " & Species12ID
Conn.Execute(Query) 
end if
end if

if rs.recordcount > 12 then
rs.movenext
Species13ID = rs("SpeciesID")
if ClearSpecies13ID = True then
Query =  " UPDATE SpeciesAvailable Set SpeciesAvailableonSite = False,"
Query =  Query & " SpeciesPriority = 0 "
Query =  Query & " where SpeciesID = " & Species13ID
Conn.Execute(Query) 
end if
end if


if rs.recordcount > 13 then
rs.movenext
Species14ID = rs("SpeciesID")
if ClearSpecies14ID = True then
Query =  " UPDATE SpeciesAvailable Set SpeciesAvailableonSite = False,"
Query =  Query & " SpeciesPriority = 0 "
Query =  Query & " where SpeciesID = " & Species14ID
Conn.Execute(Query) 
end if
end if
end if
rs.close




 sql = "select * from SpeciesAvailable where SpeciesAvailableonSite = True Order by SpeciesPriority "
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not rs.eof	 then
Species1ID = rs("SpeciesID")
rs.movenext
else
Species1ID =""
end if


if not rs.eof	 then
Species2ID = rs("SpeciesID")
rs.movenext
else
Species2ID =""
end if

if not rs.eof	 then
Species3ID = rs("SpeciesID")
rs.movenext
else
Species3ID =""
end if

if not rs.eof	 then
Species4ID = rs("SpeciesID")
rs.movenext
else
Species4ID =""
end if

if not rs.eof	 then
Species5ID = rs("SpeciesID")
rs.movenext
else
Species5ID =""
end if

if not rs.eof then
Species6ID = rs("SpeciesID")
rs.movenext
else
Species6ID =""
end if

if not rs.eof	 then
Species7ID = rs("SpeciesID")
rs.movenext
else
Species7ID =""
end if

if not rs.eof	 then
Species8ID = rs("SpeciesID")
rs.movenext
else
Species8ID =""
end if

if not rs.eof	 then
Species9ID = rs("SpeciesID")
rs.movenext
else
Species9ID =""
end if

if not rs.eof	 then
Species10ID = rs("SpeciesID")
rs.movenext
else
Species10ID =""
end if

if not rs.eof	 then
Species11ID = rs("SpeciesID")
rs.movenext
else
Species11ID =""
end if


if not rs.eof	 then
Species12ID = rs("SpeciesID")
PreferedSpecies12ID= rs("PreferedSpeciesID")
rs.movenext
else
Species12ID =""
end if

if not rs.eof	 then
Species13ID = rs("SpeciesID")
rs.movenext
else
Species13ID =""
end if
if not rs.eof	 then
Species14ID = rs("SpeciesID")
rs.movenext
else
Species14ID =""
end if
rs.close

%>
<form  name=form method="post" action="AdminWebsitesetup.asp">
<table width = "900" cellpadding = "0" cellspacing = "0" border = "0" align = "left">
<tr>
<td class = "body2" align = "right" height = "25">
<b>Types of Livestock:</b>
</td>
<td></td>
</tr>
<% 
 TempSpeciesNum = 1
 TempSpeciesIDName = "Species1ID"
 TempPreferedSpeciesID = PreferedSpecies1ID
if len(Species1ID) > 0 then
TempspeciesID=Species1ID
else
TempspeciesID = ""
end if %>
<!--#Include file="AdminWebsiteSetupspeciesInclude.asp"-->

<% 
 TempSpeciesNum = 2
TempSpeciesIDName = "Species2ID"
if len(Species2ID) > 0 then
TempspeciesID=Species2ID
else
TempspeciesID = ""
end if

%>
<!--#Include file="AdminWebsiteSetupspeciesInclude.asp"-->


<%
 TempSpeciesNum = 3
TempSpeciesIDName = "Species3ID"
if len(Species3ID) > 0 then
TempspeciesID=Species3ID
else
TempspeciesID = ""

%>
<!--#Include file="AdminWebsiteSetupspeciesInclude.asp"-->
<% end if %>

<% 
 TempSpeciesNum = 4
TempSpeciesIDName = "Species4ID"
if len(Species4ID) > 0 then
TempspeciesID=Species4ID
else
TempspeciesID = ""
end if
%>
<!--#Include file="AdminWebsiteSetupspeciesInclude.asp"-->


<%
 TempSpeciesNum = 5
TempSpeciesIDName = "Species5ID"
if len(Species5ID) > 0 then
TempspeciesID=Species5ID
else
TempspeciesID = ""
end if
%>
<!--#Include file="AdminWebsiteSetupspeciesInclude.asp"-->


<% 
 TempSpeciesNum = 6
TempSpeciesIDName = "Species6ID"
if len(Species6ID) > 0 then
TempspeciesID=Species6ID
else
TempspeciesID = ""
end if
%>
<!--#Include file="AdminWebsiteSetupspeciesInclude.asp"-->


<%
 TempSpeciesNum = 7

TempSpeciesIDName = "Species7ID"
if len(Species7ID) > 0 then
TempspeciesID=Species7ID
else
TempspeciesID = ""
end if
%>
<!--#Include file="AdminWebsiteSetupspeciesInclude.asp"-->


<% 
 TempSpeciesNum = 8
TempSpeciesIDName = "Species8ID"
if len(Species8ID) > 0 then
TempspeciesID=Species8ID
else
TempspeciesID = ""
end if
%>
<!--#Include file="AdminWebsiteSetupspeciesInclude.asp"-->

<% 
 TempSpeciesNum = 9
TempSpeciesIDName = "Species9ID"
if len(Species9ID) > 0 then
TempspeciesID=Species9ID
else
TempspeciesID = ""
end if
%>
<!--#Include file="AdminWebsiteSetupspeciesInclude.asp"-->
<% 
 TempSpeciesNum = 10
TempSpeciesIDName = "Species10ID"
if len(Species10ID) > 0 then
TempspeciesID=Species10ID
else
TempspeciesID = ""
end if
%>
<!--#Include file="AdminWebsiteSetupspeciesInclude.asp"-->

<% 
 TempSpeciesNum = 11
TempSpeciesIDName = "Species11ID"
if len(Species11ID) > 0 then
TempspeciesID=Species11ID
else
TempspeciesID = ""
end if
%>
<!--#Include file="AdminWebsiteSetupspeciesInclude.asp"-->

<% 
 TempSpeciesNum = 12
TempSpeciesIDName = "Species12ID"
if len(Species12ID) > 0 then
TempspeciesID=Species12ID
else
TempspeciesID = ""
end if
%>
<!--#Include file="AdminWebsiteSetupspeciesInclude.asp"-->

<% 
 TempSpeciesNum = 13
TempSpeciesIDName = "Species13ID"
if len(Species13ID) > 0 then
TempspeciesID=Species13ID
else
TempspeciesID = ""
end if
%>
<!--#Include file="AdminWebsiteSetupspeciesInclude.asp"-->

<%
TempSpeciesNum = 14
TempSpeciesIDName = "Species14ID"
if len(Species14ID) > 0 then
TempspeciesID=Species14ID
else
TempspeciesID = ""
end if
%>
<!--#Include file="AdminWebsiteSetupspeciesInclude.asp"-->


 
</td>
</tr>
</table>

	
<!-- #include virtual="/Footer.asp" -->
 </Body>
</HTML>
