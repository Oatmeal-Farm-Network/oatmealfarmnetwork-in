<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<!--#Include file="AssociationGlobalVariables.asp"-->
</head>
<% 	
AssociationID = Request.Form("AssociationID")
BreedID = Request.Form("BreedID")

Query =  "Delete from speciesassociationlinks where BreedLookupID= " & BreedID & " and AssociationID = " & AssociationID & ";"

response.write("Query=" & Query )
Conn.Execute(Query)

response.redirect("AssociationBreeds.asp#Associations")
%>
</Body>
</HTML>
