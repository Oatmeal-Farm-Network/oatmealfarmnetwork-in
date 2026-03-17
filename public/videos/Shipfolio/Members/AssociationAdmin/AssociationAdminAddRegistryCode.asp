<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
</HEAD>
<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  >
<!--#Include file="AssociationGlobalVariables.asp"-->

<% AssociationID = Request.Form("AssociationID")
RegistryCode = Request.Form("RegistryCode")
SpeciesID= Request.Form("SpeciesID") 


Query =  "INSERT INTO associationregistrycodes (AssociationID,"
if len(RegistryCode) > 0 then
Query = Query & " RegistryCode,"
end if
Query = Query & " SpeciesID )"
 
Query =  Query & " Values (" & AssociationID  & "," 
if len(RegistryCode) > 0 then
Query =  Query & " '" &  RegistryCode & "', " 
end if
Query =  Query & " " &  SpeciesID & ")" 

response.write("Query=" & Query )
if len(SpeciesID) > 0 and len(RegistryCode) > 0 then
Conn.Execute(Query) 
end if
Conn.Close
Set Conn = Nothing 

response.Redirect("AssociationAcronyms.asp?AssociationID=" & AssociationID & "#RegistryCode")

 %>

 </Body>
</HTML>
