<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<HEAD>
<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">
<!--#Include virtual="/Membersistration/MembersGlobalVariables.asp"--> 

<%
SpeciesID = request.form("SpeciesID")
Returnpage=request.form("Returnpage")
response.write("Returnpage=" & Returnpage )
AdType=request.QueryString("AdType")
AdID=request.QueryString("AdID")
AdType =request.form("AdType")
NewAdDateMonth =request.form("NewAdDateMonth")
NewAdDateYear =request.form("NewAdDateYear")

Query =  "INSERT INTO Ads (AdType, AdMonth, adWebsite, AdPaidFor, AdPublish,  "
if len(SpeciesID) > 0 then
Query = Query & " SpeciesID, "
end if
Query = Query & " AdYear)" 
Query =  Query & " Values ('" &  AdType & "' ,"
Query =  Query &   " " & NewAdDateMonth & ","
Query =  Query &   " 'Livestock Of America' ,"
Query =  Query &   " 1 , "
Query =  Query &   " 1 , "
if len(SpeciesID) > 0 then
Query =  Query &   " " & SpeciesID & ","
end if
Query =  Query &   " " & NewAdDateYear & ")" 

response.write(Query)	

Conn.Execute(Query) 


Conn.Close
Set Conn = Nothing 
Response.Redirect(Returnpage )
%>


 </Body>
</HTML>
