

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<HEAD>
 <title>Remove Image</title>
<link rel="stylesheet" type="text/css" href="/Membersistration/style.css">

<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">

<!--#Include virtual="/Membersistration/MembersGlobalVariables.asp"--> 

<%
PeopleID=request.QueryString("PeopleID")
AdType=request.QueryString("AdType")
AdID=request.QueryString("AdID")
Returnpage = request.form("Returnpage")
if len(AdID) > 0 then
Query =  " UPDATE Ads Set AdLink = ' '  " 
Query =  Query & " where AdID = " & AdID & ";"  
else
Query =  " UPDATE Ads Set AdLink = ' '  " 
Query =  Query & " where PeopleID = " & PeopleID & " and AdType ='" & AdType & "';"  
end if
'response.write(Query)	

Conn.Execute(Query) 


Conn.Close
Set Conn = Nothing 
 	redirect = "Advertisinghome.asp?PeopleID=" & PeopleID
 	Response.Redirect(Returnpage)
%>


 </Body>
</HTML>
