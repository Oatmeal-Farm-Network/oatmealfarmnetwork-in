<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<HEAD>
 <title>Remove Logo</title>
       


<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">

<!--#Include virtual="/Members/Membersglobalvariables.asp"--> 

<%
PeopleID = Session("PeopleID")

Query =  " UPDATE RanchSiteDesign Set logo = '0'  " 
Query =  Query & " where PeopleID = " & PeopleID & ";" 
Conn.Execute(Query) 


Query =  " UPDATE People Set logo = '0'  " 
Query =  Query & " where PeopleID = " & PeopleID & ";" 

Conn.Execute(Query) 

Conn.Close
Set Conn = Nothing 
 Response.Redirect("MembersSiteDesign.asp") %>


 </Body>
</HTML>
