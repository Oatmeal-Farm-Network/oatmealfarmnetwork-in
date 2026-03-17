<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<HEAD>
<link rel="stylesheet" type="text/css" href="/administration/style.css">
<!--#Include file="AdminGlobalVariables.asp"-->
</HEAD>
<% if mobiledevice = True  then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
<% end if %>
<%
OwnerPeopleID = 667

Query =  " UPDATE SiteDesign Set Header = ''  " 
Query =  Query & " where PeopleID = " & OwnerPeopleID  

'response.write(Query)	
Conn.Execute(Query) 
Query =  " UPDATE SiteDesignTemp Set Header = ''  " 
Query =  Query & " where PeopleID = " & OwnerPeopleID  
Conn.Execute(Query) 
Conn.Close
Set Conn = Nothing 
Response.Redirect("AdminUpdateHeader.asp") %>
 </Body>
</HTML>
