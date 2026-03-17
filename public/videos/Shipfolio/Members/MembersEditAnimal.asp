<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="author" content="John Andresen">
    <meta name="generator" content="LOTW">
    <title>Livestock Of The World</title>
<!--#Include file="MembersGlobalVariables.asp"-->
<% ID = request.QueryString("ID")
if len(ID) < 1 then
ID = Request.Form("ID")
if len(ID) > 0 then
Response.redirect("memberseditanimal.asp?ID=" & ID)
end if

end if
%>

<link rel="stylesheet" href="/includefiles/Style.css">

</head>
<body >

<% Current1="Animals"
Current2 = "EditAnimals"  %> 
<!--#Include file="MembersHeader.asp"-->
<% 
Set rs2 = Server.CreateObject("ADODB.Recordset")


If Len(ID) > 0 then
sql2 = "select * from Photos where ID = " &  ID & ";" 

rs2.Open sql2, conn, 3, 3   
If rs2.eof Then
Query =  "INSERT INTO Photos (ID)" 
Query =  Query & " Values (" &  ID & ")"
Conn.Execute(Query) 
End If 
End if

sql2 = "select Animals.ID, Animals.FullName from Animals where PeopleID = " & session("PeopleID") & " order by trim(Fullname)"
acounter = 1
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3 
	if rs2.eof then 
   'NumberofAnimals = rs2("NumberofAnimals")  
    %>

		<H2><div align = "left">Edit a Listing</div></H2>
        Currently you do not have any animals entered. To add animals please select the <a href = "MembersAnimalAdd1.asp" class = "body">Add Animals</a> tab.<br /><br />


        
<%	else
	
	While Not rs2.eof  
		IDArray(acounter) = rs2("ID")
		alpacaName(acounter) = rs2("FullName")
		'response.write (SSName(studcounter))

str1 = alpacaName(acounter)
str2 = "''"
If InStr(str1,str2) > 0 Then
alpacaName(acounter)= Replace(str1,  str2, "'")
End If  
		acounter = acounter +1
		rs2.movenext
	Wend		
	
		rs2.close
		set rs2=nothing

 If Len(ID) = 0 Then %>

 <div class = "row" >
   <div class="col-12">
    <H1>Edit an Animal's Listing</H1>
        <form  action="memberseditanimal.asp" method = "post" name = "edit1">
			<br>Select one of your animals:
			<select size="1" name="ID" class = formbox>
	    		<option name = "AID0" value= "" selected></option>
				<% count = 1
					while count < acounter
					'response.write(count)	%>
				    <option name = "AID1" value="<%=IDArray(count)%>"><%=alpacaName(count)%></option>
				<% 	count = count + 1
				wend %>
			</select>
            <input type=submit Value = "Submit" class = "regsubmit2" >
      </form>
	</div>
 </div>

		 
<br><br><br>


<% else
sql2 = "select Animals.ID, Animals.FullName, NumberofAnimals, SpeciesID, Category from Animals where ID = " & ID & " order by trim(Fullname)"
acounter = 1
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3 
NumberofAnimals = rs2("NumberofAnimals")
name = rs2("FullName")
SpeciesID = rs2("SpeciesID")
Category = rs2("Category")
if len(NumberofAnimals) > 0 then
else
NumberofAnimals = 1
end if
%>
 <div class = "row" >
   <div class="col-12 bg-light" >
    <!--#Include virtual="/members/membersEditPagecontentInclude.asp"--> 
    </div>
</div>

<% End if 
end if%>

<!--#Include file="MembersFooter.asp"-->

 </Body>
</HTML>
