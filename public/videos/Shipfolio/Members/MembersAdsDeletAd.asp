<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<HEAD>
<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">
<!--#Include virtual="/Membersistration/MembersGlobalVariables.asp"--> 

<%

Returnpage=request.form("Returnpage")
response.write("Returnpage=" & Returnpage )
AdType=request.QueryString("AdType")
AdID=request.QueryString("AdID")

Query =  "Delete  From Ads where  AdID = " & AdID & ";" 

response.write(Query)	

Conn.Execute(Query) 


Conn.Close
Set Conn = Nothing 
Response.Redirect(Returnpage & "#" & AdID - 1)
%>


 </Body>
</HTML>
