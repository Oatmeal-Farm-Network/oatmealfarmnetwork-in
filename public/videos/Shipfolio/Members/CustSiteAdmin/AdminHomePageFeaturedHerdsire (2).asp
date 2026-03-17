<!DOCTYPE HTML >
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<HEAD>
<title>The Andresen Group Content Management System</title>
	<!--#Include file="AdminGlobalVariables.asp"--> 
</HEAD>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
<%


dim ID

	ID=Request.Form("ID")
If Len(ID) < 0 Then
  ID = 0
End if
Query =  " UPDATE People Set FeaturedHerdsire = '" & ID & "' " 
      Query =  Query + " where peopleID = " & session("peopleID") & ";" 


response.write(Query)	

Conn.Execute(Query) 

Conn.Close
Set Conn = Nothing 

response.redirect("Ranchhomeadmin.asp#TextBlock3")
%>
</BODY>
</HTML>