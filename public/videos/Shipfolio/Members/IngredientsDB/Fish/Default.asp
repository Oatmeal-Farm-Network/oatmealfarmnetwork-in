<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!--#Include virtual="/members/membersglobalvariables.asp"-->


<%
' --- CORE VARIABLE CHANGES ---
IngredientType = "Fish" 
DirectoryName = "Fish"
IngredientCategoryID = 4 ' Use the specific ID for Algae as defined in your IngredientType table
description = "Explore a comprehensive list of " & IngredientType & " Ingredients and their varieties."
' --- END CORE VARIABLE CHANGES ---
%>
<link rel="canonical" href="<%=currenturl %>" />

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title><%=WebSiteName %> | <%=IngredientType%> Varieties</title>
<meta name="title" content= <%=WebSiteName %> | <%=IngredientType%> Varieties/>

<meta name="description" content=<%=Description%>/>
<meta name="keywords" content=<%=IngredientType%> "varieties, Ingredient database, food, nutrition, agriculture"/>

<link rel="canonical" href="<%=currenturl %>" />
<meta name="revisit-after" content="7 Days"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>

<style>
    /* Note: It's recommended to move this CSS into an external file 
       to allow browser caching and further speed up subsequent loads. */
    .row {
        display: flex;
        flex-wrap: wrap;
        margin-left: -0.75rem;
        margin-right: -0.75rem;
    }
    .col-2, .col-4, .col-6, .col-8, .col-12 {
        padding-left: 0.75rem;
        padding-right: 0.75rem;
        box-sizing: border-box;
    }
    /* Basic responsive columns - adjust to match your Bootstrap setup */
    .col-12 { width: 100%; }
    @media (min-width: 576px) { /* Small devices (sm) */
        .col-sm-6 { width: 50%; }
        .col-sm-4 { width: 33.333%; }
        .col-sm-8 { width: 66.666%; }
    }
    @media (min-width: 768px) { /* Medium devices (md) */
        .col-md-4 { width: 33.333%; }
        .col-md-6 { width: 50%; }
    }
    @media (min-width: 992px) { /* Large devices (lg) */
        .col-lg-2 { width: 16.666%; }
        .col-lg-4 { width: 33.333%; }
        .col-lg-6 { width: 50%; }
    }

    .d-none { display: none !important; }
    .d-lg-block { display: block !important; }
    .d-lg-none { display: none !important; }
    @media (min-width: 992px) {
        .d-lg-none { display: none !important; }
        .d-lg-block { display: block !important; }
    }
    @media (max-width: 991.98px) {
        .d-lg-block { display: none !important; }
        .d-lg-none { display: block !important; }
    }

    .text-left { text-align: left; }
    .text-center { text-align: center; }

    img {
        max-width: 100%;
        height: auto;
        border-radius: 0.5rem;
    }
    .image-container {
        width: 150px;
        height: 150px;
        overflow: hidden;
        display: flex;
        align-items: center;
        justify-content: center;
        margin-bottom: 0.5rem;
    }
    .image-container img {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }
</style>

<!--#Include virtual="/members/MembersHeader.asp"-->
<%

Dim rs, sql
' --- CRITICAL PERFORMANCE IMPROVEMENT: Single Query ---
' The main query now retrieves all the data needed, including the count (VarietyCount)
' which was previously done in a separate, inefficient query inside the loop.
sql = "SELECT I.IngredientID, I.IngredientName, I.IngredientDescription, I.IngredientImage, COUNT(IV.IngredientID) AS VarietyCount "
sql = sql & "FROM Ingredients I "
sql = sql & "LEFT JOIN IngredientsVarieties IV ON I.IngredientID = IV.IngredientID "
sql = sql & "WHERE I.IngredientCategoryID = " & IngredientCategoryID
sql = sql & " GROUP BY I.IngredientID, I.IngredientName, I.IngredientDescription, I.IngredientImage "
sql = sql & "ORDER BY I.IngredientName"
'response.write("sql=" & sql)

Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3 ' adOpenStatic, adLockOptimistic

' TotalVarieties is no longer calculated in a pre-loop, as it wasn't used later. 
' If you need the sum, it can be done with a separate SUM query or calculated during this loop.
%>

<div class="container-fluid " align="center" style="max-width: 1400px; min-height: 67px;">
<div class="row">
    <div class="col body text-left">
        <img src="FishIngredientHeader.webp" width="100%" alt="Delicious <%=IngredientType%>" />
        <br /> <br />
        <h2><div class="text-left"><%=IngredientType%> Ingredient Types</div></h2>     </div>
</div>

<div class="row">
    <%
    If Not rs.EOF Then
        Do While Not rs.EOF
            Dim IngredientID, IngredientName, IngredientDescription, IngredientImage, ingredientcount
            
            IngredientID = rs("IngredientID")
            IngredientName = rs("IngredientName")
            IngredientDescription = rs("IngredientDescription")
            IngredientImage = rs("IngredientImage")
            ' This variable now uses the result of the main, fast query:
            ingredientcount = rs("VarietyCount")
    %>
            <div class="col-lg-4 col-md-6 col-sm-12 body text-left">
                <div class="flex items-center">
                    <% if Len(IngredientImage) > 0 then %>
                        <% if ingredientcount > 0 then %>
                        <a href="/members/IngredientsDB/<%=DirectoryName%>/Varieties.asp?IngredientID=<%=IngredientID %>" class="body image-container">
                        <% end if %>
                           <img src='<%=IngredientImage%>' alt="<%=IngredientName %>" loading="lazy" />
                        <% if ingredientcount > 0 then %>
                        </a>
                        <% end if %>
                    <% end if %>
                    <div style="margin-left: 1rem;">
                        <% if ingredientcount > 0 then %>
                        <a href="/members/IngredientsDB/<%=DirectoryName%>/Varieties.asp?IngredientID=<%=IngredientID %>" class="body"><b><%=IngredientName %></b> </a><br />
                        <% else %>
                            <b><%=IngredientName %></b><br />
                        <% end if %>
                        <%=IngredientDescription %>
                    </div>
                </div>
                <br /><br />
            </div>
    <% 
            rs.MoveNext
        Loop
    Else
    %>
        <div class="col-12 body text-center">
            <p>No <%=IngredientType%> Ingredient types found in the database.</p>
        </div>
    <%
    End If
    ' Close the main recordset
    rs.close
    Set rs = Nothing
    %>
</div>
</div>



<!--#Include virtual="/members/MembersFooter.asp"-->
</body></html>