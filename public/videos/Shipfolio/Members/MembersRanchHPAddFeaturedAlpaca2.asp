<!DOCTYPE HTML >
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<HEAD>
 <title>Add Featured Alpacas</title>
</HEAD>
<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
		<!--#Include file="MembersGlobalVariables.asp"--> 
<%


dim ID

	ID=Request.Form("ID")
If Len(ID) < 0 Then
  ID = 0
End if
Query =  " UPDATE People Set FeaturedAlpaca2 = '" & ID & "' " 
      Query =  Query + " where peopleID = " & session("peopleID") & ";" 


response.write(Query)	

Conn.Execute(Query) 

Conn.Close
Set Conn = Nothing 

response.redirect("RanchhomeMembers.asp#TextBlock3")
%>
</BODY>
</HTML>

