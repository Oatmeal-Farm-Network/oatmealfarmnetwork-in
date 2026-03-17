<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="author" content="John Andresen">
<!--#Include file="MembersGlobalVariables.asp"-->
<link rel="stylesheet" href="/members/Membersstyle.css">
</head>
<body >
<% Current1="Animals"
Current2 = "EditAnimals" 
Current3 = "Description" %> 
<!--#Include file="MembersHeader.asp"-->


<% category = request.QueryString("category")

Dim Showname(1000)
order = "even"		
Set rs = Server.CreateObject("ADODB.Recordset")	

sql = "select SpeciesID, NumberOfAnimals from Animals where animalid=" & animalid

rs.Open sql, conn, 3, 3
    SpeciesID  = rs("SpeciesID")
    NumberOfAnimals = rs("NumberOfAnimals")
rs.close

sql = "select Count(*) as count from awards where animalid = " & animalid & " and (not(Len(Placing)< 1) or not(Len(Class)< 1) or not(Len(AwardYear)< 2)  or not(Len(Awardcomments)< 1)  or not(Len(Showname)< 1)  or not(Len(Judge)< 1) )  "
rs.Open sql, conn, 3, 3  
FilledRecordcount = rs("count")
rs.close  
 
sql = "select Count(*) as count from awards where animalid = " & animalid 
rs.Open sql, conn, 3, 3  
Recordcount = rs.RecordCount
rs.close

if cLng(Recordcount) < cLng(FilledRecordcount) + 6 then
Query =  "INSERT INTO Awards (animalid)" 
Query =  Query & " Values ('" &  animalid & "')"
'response.write("Query=" & Query )
Conn.Execute(Query) 

Query =  "INSERT INTO Awards (animalid)" 
Query =  Query & " Values ('" &  animalid & "')"
'response.write("Query=" & Query )
Conn.Execute(Query) 

Query =  "INSERT INTO Awards (animalid)" 
Query =  Query & " Values ('" &  animalid & "')"
'response.write("Query=" & Query )
Conn.Execute(Query) 
end if

%>

<div class="container roundedtopandbottom">

    <form action='MembersGeneralStatsHandle.asp?Businessid=<%=Businessid%>&AnimalID=<%=AnimalID%>' method="post" name="g1">
        <div class="col">
            <div class="card-header">
               <!--#Include file="MembersJumpLinks.asp"-->
            </div>
            <div class="card-header">
                <h4 class="mb-0">Description</h4>
            </div>
            <div class="card-body p-4">

<div class="container py-4">
    <iframe 
        src="MembersEditAnimalDescriptionFrame.asp?animalid=<%=animalid %>" 
        class="w-100 shadow-sm rounded" 
        style="height: 650px; border: none;"
        title="Animal Description Editor">
    </iframe>
</div>
</div><div></div>


<!--#Include file="membersFooter.asp"--> </Body>
</HTML>