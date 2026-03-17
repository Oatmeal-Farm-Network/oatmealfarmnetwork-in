<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="author" content="John Andresen">
    <meta name="generator" content="Oatmeal Farm Network">
    <title>Harvest Hub</title>
<!--#Include file="MembersGlobalVariables.asp"-->

<body >
<%



Current1 = "MembersHome"
Current2="MembersHome"
BladeSection = "accounts" 
pagename = BusinessName 
AnimalID =0 %> 
<!--#Include file="MembersHeader.asp"-->

<% AnimalID =0%>
<div class="container roundedtopandbottom">
<!--#Include file="MembersJumpLinks.asp"-->
    


    <h3>My Animals</h3><a name="Animals"></a>
    <%
    ' --- OPTIMIZED & CORRECTED SQL QUERY (Revision 3) ---
    ' 1. Removed the reference to 'SpeciesName' from the SQL query to fix the "Invalid column name" error.
    ' 2. We will now determine the species name using VBScript logic, as it was in the original version, since the column name is not available.

    sql = "SELECT A.AnimalID, A.FullName, A.PublishForSale, A.PublishStud, A.Category, A.speciesID, " & _
          "S.SpeciesPriority, " & _
          "P.Price, P.StudFee, P.Discount " & _
          "FROM (Animals AS A " & _
          "INNER JOIN speciesavailable AS S ON A.speciesID = S.SpeciesID) " & _
          "LEFT JOIN Pricing AS P ON A.AnimalID = P.AnimalID " & _
          "WHERE A.PeopleID = " & Session("PeopleID") & " " & _
          "ORDER BY S.SpeciesPriority, A.FullName"

'response.write("sql=" & sql)

    Set rs = Server.CreateObject("ADODB.Recordset")
    ' Use a read-only, forward-only cursor for maximum performance when just reading data.
    rs.Open sql, conn, 0, 1 ' adOpenForwardOnly, adLockReadOnly

    If rs.EOF Then
    %>
        Currently you do not have any animals listed. To add an animal <a href="MembersAnimalAdd1.asp&Businessid=<%=businessID%>&">click here</a>.
    <% Else %>
        <table width="100%">
            <thead>
                <tr>
                    <td class="text-left body">Listing</td>
                    <td class="text-left body d-none d-md-table-cell">Category</td>
                    <td class="text-left body" width="125px" style="max-width:125px; min-width:125px">Species</td>
                    <td class="text-right body">Price (Discount)</td>
                    <td class="text-right body d-none d-md-table-cell">Stud Fee</td>
                    <td class="text-center body d-none d-md-table-cell">Options</td>
                </tr>
                <tr>
                    <td colspan="6" style="background-color: #abacab; height: 1px; line-height: 1px;">&nbsp;</td>
                </tr>
            </thead>
            <tbody>
            <%
            ' --- EFFICIENT ROW-BY-ROW PROCESSING ---
            While Not rs.EOF
                ' Get all values from the current record
                animalID = rs("AnimalID")
                fullName = rs("FullName") & "" ' Append "" to prevent errors if data is NULL
                category = rs("Category") & ""
                speciesID = rs("speciesID")
                
                ' --- RELIABLE SPECIES NAME LOGIC ---
                ' Re-implementing the original logic to determine species name, as this is known to work with your database.
                speciesName = ""
                if speciesID = 2 then speciesName="Alpaca"
                if speciesID = 3 then speciesName="Dog"
                if speciesID = 4 then speciesName="Llama"
                if speciesID = 5 then speciesName="Horse"
                if speciesID = 6 then speciesName="Goat"
                if speciesID = 7 then speciesName="Donkey"
                if speciesID = 8 then speciesName="Cattle"
                if speciesID = 9 then speciesName="Bison"
                if speciesID = 10 then speciesName="Sheep"
                if speciesID = 11 then speciesName="Rabbit"
                if speciesID = 12 then speciesName="Pig"
                if speciesID = 13 then speciesName="Chicken"
                if speciesID = 14 then speciesName="Turkey"
                if speciesID = 15 then speciesName="Duck"
                if speciesID = 17 then speciesName="Yak"
                if speciesID = 18 then speciesName="Camels"
                if speciesID = 19 then speciesName="Emus"
                if speciesID = 21 then speciesName="Deer"
                if speciesID = 22 then speciesName="Geese"
                if speciesID = 23 then speciesName="Bees"
                if speciesID = 25 then speciesName="Alligators"
                if speciesID = 26 then speciesName="Guinea Fowl"
                if speciesID = 27 then speciesName="Musk Ox"
                if speciesID = 28 then speciesName="Ostriches"
                if speciesID = 29 then speciesName="Pheasants"
                if speciesID = 30 then speciesName="Pigeons"
                if speciesID = 31 then speciesName="Quails"
                if speciesID = 33 then speciesName="Snails"
                if speciesID = 34 then speciesName="Buffalo"
                
                ' Get currency values safely
                price = rs("Price")
               '' If IsNull(price) Or Not IsNumeric(price) Then price = 0
                
                studFee = rs("StudFee")
               '' If IsNull(studFee) Or Not IsNumeric(studFee) Then studFee = 0
                
                discount = rs("Discount")
              ''  If IsNull(discount) Or Not IsNumeric(discount) Then discount = 0

                ' Calculate discount price
                Dim discountedPrice : discountedPrice = 0
                If discount > 0 Then
                    discountedPrice = cint(price) * (cint(discount) / 100)
                End If
            %>
                <tr>
                    <td>
                        <a href="MembersEditAnimalBasics.asp?Businessid=<%=businessID%>&AnimalID=<%= animalID %>#top" class="body"><%= Server.HTMLEncode(fullName) %> (edit)</a>
                    </td>
                    <td class="body d-none d-md-table-cell">
                        <%= Server.HTMLEncode(category) %>
                    </td>
                    <td class="body">
                        <%= Server.HTMLEncode(speciesName) %>
                    </td>
                    <td class="body" style="text-align:right">
                        <% If len(price) > 0 Then %>
                            <%= FormatCurrency(price, 2) %>
                        <% End If %>
                        <% If len(discountedPrice) > 1 Then %>
                            &nbsp;(<%= FormatCurrency(discountedPrice) %>)
                        <% End If %>
                    </td>
                    <td class="body d-none d-md-table-cell" style="text-align:right">
                        <% If studFee > 0 Then %>
                            <%= FormatCurrency(studFee, 2) %>
                        <% Else %>
                            N/A
                        <% End If %>&nbsp;
                    </td>
                    <td class="text-center body d-none d-md-table-cell" style="text-align:center">
                        <a href = "MembersEditAnimalBasics.asp?Businessid=<%=businessID%>&AnimalID=<%= animalID %>#top" class = "body">&nbsp;&nbsp;<img src= "images/edit.gif" alt = "edit" height ="12" border = "0"></a>
                        |&nbsp;<a href = "membersPhotos.asp?Businessid=<%=businessID%>&animalID=<%=animalID%>" class = "body"><img src = "images/Photo.gif" height = "18" border = "0" alt = "Upload Photos"></a>
                        |&nbsp;<a href = "membersDeleteAnimalhandleform1.asp?Businessid=<%=businessID%>&animalID=<%= animalID %>" class = "body"><img src= "images/Delete.jpg" alt = "edit" height ="18" border = "0"></a>

                    </td>
                </tr>
                <tr>
                    <td colspan="6" style="background-color: #dddddd; height: 1px; line-height: 1px;">&nbsp;</td>
                </tr>
            <%
                rs.MoveNext
            Wend
            %>
            </tbody>
        </table>
    <%
    End If
    rs.Close
    Set rs = Nothing
    %>
</div>

<div class="row">
    <div class="col">
        <br />
    </div>
</div>
<!--#Include file="membersFooter.asp"-->

</BODY>
</HTML>