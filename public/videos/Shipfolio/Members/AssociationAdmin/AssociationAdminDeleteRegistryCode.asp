<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<!--#Include file="AssociationGlobalVariables.asp"-->
</head>
<% 	
AssociationID = Request.Form("AssociationID")
RegistryCode = Request.Form("RegistryCode")
SpeciesID= Request.Form("SpeciesID") 
AssociationRegistryCodeId = request.form("AssociationRegistryCodeId")

Query =  "Delete from associationregistrycodes where AssociationID= " & AssociationID & " and trim(lower(AssociationRegistryCodeId	))  = " & AssociationRegistryCodeId  & ";"

response.write("Query=" & Query )
Conn.Execute(Query)

response.redirect("AssociationAcronyms.asp")
%>
</Body>
</HTML>
