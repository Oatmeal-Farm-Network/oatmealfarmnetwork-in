<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<meta name="robots" content="nofollow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="revisit-after" content="1"/>
<meta name="Googlebot" content="nofollow"/>
<!--#Include virtual="/members/MembersGlobalVariables.asp"-->

</head>
<body >
<% Current1 = "AssociationHome"
Current2 = "DirectoryListing" 
Current3 = "Breeds" %> 

<!--#Include virtual="/members/AssociationAdmin/AssociationMembersHeader.asp"-->
<!--#Include file="AssociationDirectoryJumpLinks.asp"-->

<%  

sql = "select AssociationLogo  from Associations where AssociationID = " & session("AssociationID")
if rs.state > 0 then
    rs.Close
end if


rs.Open sql, conn, 3, 3 
If Not rs.eof then
	AssociationLogo = rs("AssociationLogo")
	str1 = lcase(AssociationLogo) 
	str2 = "http://www.alpacainfinity.com"
	If InStr(str1,str2) > 0 Then
		AssociationLogo=  Replace(str1, str2 , "http://www.livestockofamerica.com")
	End If  
	rs.close
end if

if rs.state = 0 then
else
rs.close
end if

Huacayas= False
sql = "select AssociationID  from AssociationBreedtable where speciesID = 2 and AssociationID = " & AssociationID
rs.Open sql, conn, 3, 3 
If Not rs.eof then
Huacayas = True
end if
rs.close

Suris = False
sql = "select AssociationID  from AssociationBreedtable where speciesID = 1 and AssociationID = " & AssociationID
rs.Open sql, conn, 3, 3 
If Not rs.eof then
Suris = True
end if
rs.close




%>

<div class="container roundedtopandbottom">
<H1>Breeds</H1>

<div class ="container border border-secondary rounded p-4" style="max-width:500px">
    <div class ="row">
        <div class ="col">
        <h2>Add a Breed</h2>
          <br />

        <% 
        Set rsSpecies = conn.Execute("SELECT SpeciesID, Species FROM SpeciesAvailable WHERE SpeciesAvailable = 1")

        ' Function to sanitize the user input
        Function SanitizeInput(input)
            input = Replace(input, "'", "''")  ' Escape single quotes
            SanitizeInput = Trim(input)
        End Function

        ' Process form submission
        If Request.ServerVariables("REQUEST_METHOD") = "POST" Then
            Dim selectedSpecies, selectedBreed
            selectedSpecies = SanitizeInput(Request.Form("SpeciesID"))
            selectedBreed = SanitizeInput(Request.Form("BreedID"))
    
            ' Check if both species and breed are selected
            If selectedSpecies <> "" And selectedBreed <> "" Then
                ' Redirect to AssociationsAddBreed.asp
            Set rs4 = Server.CreateObject("ADODB.Recordset")


                Query =  "INSERT INTO speciesassociationlinks (AssociationID,"
                Query = Query & " BreedLookupID,"
                Query = Query & " SpeciesID )"
 
                Query =  Query & " Values (" & AssociationID  & "," 
                Query =  Query & " " &  selectedBreed & ", " 
                Query =  Query & " " &  selectedSpecies & ")" 

               ' response.write("Query=" & Query )
                if len(selectedBreed) > 0 then
                Conn.Execute(Query) 
                end if



                'Response.Redirect "AssociationBreeds.asp?SpeciesID=" & selectedSpecies & "&BreedID=" & selectedBreed
            Else
                ' Handle validation error or display an error message
                Response.Write "Please select both species and breed."
            End If
        End If

        CurrentSpeciesID=request.form("SpeciesID")
            if len(CurrentSpeciesID) > 0 then
             Set rs2 = Server.CreateObject("ADODB.Recordset")
             sql = "select Species from speciesAvailable where SpeciesID= " & CurrentSpeciesID
             rs2.Open sql, conn, 3, 3     
                CurrentSpeciesName=rs2("Species")
            rs2.close
            end if
        %>

        <form action="AssociationBreeds.asp" method="post">
          <div >
            <label for="SpeciesID">Select Species</label><br />
            <select name="SpeciesID" id="SpeciesID" class="formbox" onchange="this.form.submit()" style="max-width:380px; min-width:380px" required>
                <% if len(CurrentSpeciesName) > 1 then %>
                  <option value="<%=CurrentSpeciesID %>"><%=CurrentSpeciesName %></option>
                <% else %>
                    <option value="">Select Species</option>
                <% end if %>
              <% 
              While Not rsSpecies.EOF 
                  Dim speciesID, speciesName
                  speciesID = rsSpecies("SpeciesID")
                  speciesName = rsSpecies("Species")
                  Dim selectedAttribute
                  If Request.Form("SpeciesID") = speciesID Then
                      selectedAttribute = "selected"
                  Else
                      selectedAttribute = ""
                  End If
              %>
              <option value="<%= speciesID %>" <%= selectedAttribute %>><%= speciesName %></option>
              <% 
              rsSpecies.MoveNext
              Wend 
              %>
            </select>
          </div>
           <div>

          <% If Request.Form("SpeciesID") <> "" Then
             ' Get the selected species ID from the form submission
             Dim selectedSpeciesID
             selectedSpeciesID = SanitizeInput(Request.Form("SpeciesID"))
     
             ' Query breeds based on the selected species
             Set rsBreeds = conn.Execute("SELECT DISTINCT BreedLookupID, Breed FROM SpeciesBreedlookuptable WHERE SpeciesID = " & selectedSpeciesID & " order by Breed" )
          %>
            <label for="BreedID">Select Breed</label><br />
            <select name="BreedID" id="BreedID" class="formbox" style="max-width:380px; min-width:380px" Required>
              <option value="">-- Select Breed --</option>
              <% While Not rsBreeds.EOF %>
              <option value="<%= rsBreeds("BreedLookupID") %>"><%= rsBreeds("Breed") %></option>
              <% rsBreeds.MoveNext
              Wend %>
            </select>
           <% else %>

            <label for="BreedID">Select Breed</label><br />
            <select name="BreedID" id="BreedID" class="formbox" style="max-width:380px; min-width:380px" >
              <option value="">Select A Species First</option>
     
            </select>
          <% End If %>
          </div>
           <div>
               <br />
          <button type="submit" class="regsubmit2">Add</button>
          </div>

        </form>

        <%
        ' Clean up resources
        rsSpecies.Close
        Set rsSpecies = Nothing

        %>
</div></div>
</div>

<br /><br />



<div class ="container border border-secondary rounded p-4" style="max-width:500px">
<h2>Association Breeds</h2>
Your organization accepts registration for the following breeds of livestock:


<%Set rs2 = Server.CreateObject("ADODB.Recordset")
Set rs3 = Server.CreateObject("ADODB.Recordset")
Set rs4 = Server.CreateObject("ADODB.Recordset")

dim AssociationSpeciesIDarray(30)
dim AssociationSpeciesIDarray2(30)
dim AssociationSpeciesNamearray(30)
dim AssociationSpeciesNamearray2(30)

 
AssociationSpeciesTotal = x1
%>

<br />
<a name="Associations"></a>
<div class="row">
    <div class  ="col">
        <a name="AssociationBreeds"></a>

<table width = "100%" border = 0 cellpadding = 5 cellspacing = 5 class = >
<tr><td class = "body2" align = "center" >
<b>Species</b>
</td>
<td class = "body2" align = "center" >
<b>Breed</b>
</td>
</tr>
<%Set rs2 = Server.CreateObject("ADODB.Recordset")
sql = "select distinct BreedLookupID, SpeciesID from speciesassociationlinks where AssociationID= " & AssociationID
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
while Not rs.eof    
BreedID = rs("BreedLookupID")
SpeciesID = rs("SpeciesID")

if len(BreedID) > 0 then
sql2 = "select distinct Breed from speciesbreedlookuptable where BreedLookupID= " & BreedID
rs2.Open sql2, conn, 3, 3   
if Not rs2.eof then
Breed = rs2("Breed")
end if 
rs2.close
end if

if len(SpeciesID) > 0 then
sql2 = "select distinct Species from SpeciesAvailable where SpeciesID= " & SpeciesID 
rs2.Open sql2, conn, 3, 3   
if Not rs2.eof then
Species = rs2("Species")
end if 
rs2.close
end if
%>
<tr><td class = "body"><%=Species %></td>
<td class = "body"><%=Breed %></td>
<td class = "body">
<form  action="AssociationsDeleteAssignment.asp" method = "post">
<input name = "AssociationID" value="<%= AssociationID %>" type = hidden />
<input name = "BreedID" value="<%= BreedID %>" type = hidden />
<input type=submit value = "Unassign" class = "regsubmit2" >
</form>
</td>
</tr>
<% rs.movenext
wend %>
</table>

    
</div>
    </div></div>
<br /><br />


    </div>
<!--#Include virtual="/Members/AssociationAdmin/AssociationFooter.asp"--> 
</body>
</HTML>