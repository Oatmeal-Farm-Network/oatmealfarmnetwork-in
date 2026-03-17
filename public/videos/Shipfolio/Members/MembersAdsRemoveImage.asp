<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<HEAD>
<title>Remove Image</title>
<link rel="stylesheet" type="text/css" href="/Membersistration/style.css">
<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">
<!--#Include virtual="/Membersistration/MembersGlobalVariables.asp"--> 
<%
Returnpage = request.form("Returnpage")
PeopleID=request.QueryString("PeopleID")
AdType=request.QueryString("AdType")
AdID=request.QueryString("AdID")
if AdType = "MegaAdComboBackground" then
Query =  " UPDATE Ads Set AdImageBackground = '' " 
Query =  Query & " where PeopleID = " & PeopleID & " and AdType = 'Mega Ad Combo';" 

else
if len(AdID) > 0 then
Query =  " UPDATE Ads Set AdImage = ''  " 
Query =  Query & " where AdID = " & AdID & ";" 
else
Query =  " UPDATE Ads Set AdImage = ''  " 
Query =  Query & " where PeopleID = " & PeopleID & " and AdType ='" & AdType & "';"  
end if
end if
response.write(Query)	
Conn.Execute(Query) 

Conn.Close
Set Conn = Nothing 
redirect = "Advertisinghome.asp?PeopleID=" & PeopleID
Response.Redirect(Returnpage)
%>
</Body>
</HTML>
