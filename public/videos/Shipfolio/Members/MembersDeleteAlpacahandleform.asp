<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<meta name="robots" content="nofollow"/>
</head>
<body >
<!--#Include file="MembersGlobalVariables.asp"-->
<% Current1="Animals"
Current2 = "AnimalDelete" 
Current3 = "Delete" %> 
<!--#Include file="MembersHeader.asp"-->
<div class ="container roundedtopandbottom">
<H1>Delete an Animal Listing</H1>
<% 
animalID=request.Form("animalID")
Query =  "Delete  From Ancestors where animalID = " &  animalID & "" 
'response.write("Query=" & Query )
conn.Execute(Query) 
Query =  "Delete  From Awards where animalID = " &  animalID & "" 
conn.Execute(Query) 
Query =  "Delete  From Animals where animalID = " &  animalID & "" 
conn.Execute(Query) 
Query =  "Delete  From FemaleData where animalID = " &  animalID & "" 
conn.Execute(Query) 
Query =  "Delete  From Fiber where animalID = " & animalID & "" 
conn.Execute(Query) 
Query =  "Delete From Photos where animalID = " &  animalID & "" 
conn.Execute(Query) 
Query =  "Delete From Pricing where animalID = " &  animalID & "" 
conn.Execute(Query) 
Query =  "Delete From MaleData where animalID = " &  animalID & "" 
conn.Execute(Query) 
Query =  "Delete From EPDAlpacas where animalID = " &  animalID & "" 
conn.Execute(Query) 


'response.redirect("MembersdeleteAnimal.asp?deletedone=true")
%>
<h2>Your animal has successfully been deleted.</H2>

<br><br><br><br><br><br><br><br><br><br><br><br>
</div>
<br>
<!--#Include file="membersFooter.asp"-->
</Body>
</HTML>
