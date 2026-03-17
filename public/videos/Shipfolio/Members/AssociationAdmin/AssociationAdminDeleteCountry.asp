<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<!--#Include file="AssociationGlobalVariables.asp"-->
</head>
<% 	
AssociationID = Request.Form("AssociationID")
country_id = Request.Form("country_id")


Query =  "Delete from associationcountries where AssociationID= " & AssociationID & " and country_id  = " & country_id  & ";"

response.write("Query=" & Query )
Conn.Execute(Query)

response.redirect("AssociationDirectoryCountries.asp?AssociationID=" & AssociationBreedID & "#Countries")
%>
</Body>
</HTML>
