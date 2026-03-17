<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

<!--#Include file="MembersGlobalVariables.asp"-->
</head>
<body>
<!--#Include virtual="/members/MembersHeader.asp"-->
<% Current3 = "OrderProduce" %>
<!--#Include virtual="/Members/MembersProduceJumpLinks.asp"-->

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
$(document).ready(function() {
    // Populate the Plant dropdown based on selected Ingredient Category
    $('#IngredientCategory').change(function() {
        var IngredientCategoryID = $(this).val();
        var plantSelect = $('#PlantID');
        var ingredientSelect = $('#IngredientID');

        // Reset both Plant and Ingredient Name dropdowns
        plantSelect.html('<option value="">Select a Plant</option>').prop('disabled', true);
        ingredientSelect.html('<option value="">Select an Ingredient Name</option>').prop('disabled', true);

        if (IngredientCategoryID) {
            $.ajax({
                url: 'GetOrderPlants.asp', 
                type: 'GET',
                data: { IngredientCategoryID: IngredientCategoryID },
                dataType: 'json',
                success: function(data) {
                    if (Array.isArray(data) && data.length > 0) {
                        data.sort(function(a, b) { return a.PlantName.localeCompare(b.PlantName); });
                        $.each(data, function(index, plant) {
                            plantSelect.append($('<option></option>').attr('value', plant.PlantID).text(plant.PlantName));
                        });
                        plantSelect.prop('disabled', false);
                    } else {
                        alert('No plants found for this category. Please try another category.');
                    }
                },
                error: function(xhr, status, error) {
                    alert('An error occurred while fetching plants. Please try again.');
                }
            });
        }
    });

    // Populate the Ingredient Name dropdown based on selected Plant
    $('#PlantID').change(function() {
        var PlantID = $(this).val();
        var ingredientSelect = $('#IngredientID');

        // Reset Ingredient Name dropdown
        ingredientSelect.html('<option value="">Select an Ingredient Name</option>').prop('disabled', true);

        if (PlantID) {
            $.ajax({
                url: 'GetOrderIngredients.asp', 
                type: 'GET',
                data: { PlantID: PlantID },
                dataType: 'json',
                success: function(data) {
                    if (Array.isArray(data) && data.length > 0) {
                        data.sort(function(a, b) { return a.IngredientName.localeCompare(b.IngredientName); });
                        $.each(data, function(index, ingredient) {
                            ingredientSelect.append($('<option></option>').attr('value', ingredient.IngredientID).text(ingredient.IngredientName));
                        });
                        ingredientSelect.prop('disabled', false);
                    } else {
                        alert('No ingredients found for this plant. Please try another plant.');
                    }
                },
                error: function(xhr, status, error) {
                    alert('An error occurred while fetching ingredients. Please try again.');
                }
            });
        }
    });

    // Set the value of the third dropdown to the IngredientID
    $('#IngredientID').change(function() {
        var IngredientID = $(this).val();
        $('#IngredientID').val(IngredientID);
    });
});
</script>



<div class="container roundedtopandbottom">
    <h1>Order Produce</h1>
    <div>Raw Non-Meat Ingredients: Fruits, Vegetables, Grains, etc.</div>
    <form action="MembersProduceOrder.asp" method="post">
        <style>
            @media (min-width: 992px) {
                .form-row-lg {
                    display: flex;
                    flex-wrap: nowrap;
                    align-items: flex-end;
                }
                .form-row-lg > div {
                    flex: 1;
                    margin-right: 10px;
                }
                .form-row-lg > div:last-child {
                    margin-right: 0;
                }
                .form-row-lg label {
                    white-space: nowrap;
                }
            }
        </style>

<div class="container">
        <input type="hidden" name="BusinessID" Value="<%=Session("BusinessID")%>" >
    <%  Set rsIngredientCategory = Server.CreateObject("ADODB.Recordset")
    sqlIngredient = "SELECT distinct IngredientCategoryLookup.* FROM IngredientCategoryLookup, ingredients, Produce where IngredientCategoryLookup.IngredientCategoryid = ingredients.IngredientCategoryid and ingredients.ingredientid = Produce.ingredientid and not ( IngredientCategoryLookup.IngredientCategoryID=6 or IngredientCategoryLookup.IngredientCategoryID=27 or IngredientCategoryLookup.IngredientCategoryID=32 or IngredientCategoryLookup.IngredientCategoryID=1 or IngredientCategoryLookup.IngredientCategoryID=10 or IngredientCategoryLookup.IngredientCategoryID=3 or IngredientCategoryLookup.IngredientCategoryID=15 or IngredientCategoryLookup.IngredientCategoryID=4 or IngredientCategoryLookup.IngredientCategoryID=31 or IngredientCategoryLookup.IngredientCategoryID=20 or IngredientCategoryLookup.IngredientCategoryID=30 ) ORDER BY IngredientCategory "
    'response.write("sqlIngredient =" & sqlIngredient )
    rsIngredientCategory.Open sqlIngredient, conn, 3, 3 
    %>
        <div class="form-row-lg">
            <div class="col-lg-2 body">
                <label for="IngredientCategory" class="form-label"><b>Category</b></label>
                <select id="IngredientCategory" name="IngredientCategory" class="form-select" required>
                    <option value="">Select a Category</option>
                    <% 
                       
                        While Not rsIngredientCategory.EOF 
                    %>
                        <option value="<%=rsIngredientCategory("IngredientCategoryID")%>"><%= rsIngredientCategory("IngredientCategory") %></option>
                    <% 
                        rsIngredientCategory.MoveNext
                        Wend
                        rsIngredientCategory.Close
                        Set rsIngredientCategory = Nothing 
                    %>
                </select>
            </div>
            <div class="col-lg-2 body">
                <label for="PlantID" class="form-label"><b>Ingredient</b></label>
                <select id="PlantID" name="PlantID" class="form-select" required>
                    <option value="">Select a Plant</option>
                </select>
            </div>
            <div class="col-lg-2 body">
                <label for="IngredientID" class="form-label"><b>Varietal</b> (Optional)</label>
                <select id="IngredientID" name="IngredientID" class="form-select" >
                    <option value="">Select an Varietal</option>
                </select>
            </div>
   

<!-- Quantity and Measurement -->
 <% show = false 
 if show = true then%>
<div class="col-lg-1 body" style="width:90px">
    <label for="quantity" class="form-label"><b>Quantity</b></label>
    <input type="number" id="quantity" name="quantity" class="form-control" >
</div>
<div class="col-lg-1 body" style="width:90px">
    <% sql2 = "SELECT * FROM MeasurementLookup ORDER BY MeasurementOrder"
    Set rs2 = Server.CreateObject("ADODB.Recordset")
    rs2.Open sql2, conn, 3, 3 
    if not rs2.eof then %>
    <label for="measurementID" class="form-label"><b>Measurement</b></label>
    <select id="measurementID" name="measurementID" class="form-select" >
        <option value=""></option>
        <% while not rs2.eof %>
            <option value="<%=rs2("MeasurementID") %>"><%=rs2("Measurement") %> (<%=rs2("MeasurementAbbreviation") %>)</option>
        <% rs2.movenext
        wend %>
    </select>
    <% end if
    rs2.close %> 
</div>
<div class="col-lg-1 body" style="width:90px">
    <% sql2 = "SELECT * FROM IngredientQuality ORDER BY QualityID"
    Set rs2 = Server.CreateObject("ADODB.Recordset")
    rs2.Open sql2, conn, 3, 3 
    if not rs2.eof then %>
    <label for="QualityID" class="form-label"><b>Quality</b></label>
    <select id="QualityID" name="QualityID" class="form-select" >
        <option value=""></option>
        <% while not rs2.eof %>
            <option value="<%=rs2("QualityID") %>"><%=rs2("Qualityname") %></option>
        <% rs2.movenext
        wend %>
    </select>
    <% end if
    rs2.close %> 
</div>
<% end if %>
<!-- Wholesale Price -->
 <% showmaxprice = false
 if showmaxprice =  True then %>
<div class="col-lg-2">
    <label for="MaxPrice" class="form-label body"><b>Max Price (USD)</b> (Optional)</label>
    <div class="input-group">
        <span class="input-group-text">$</span>
        <input type="number" id="MaxPrice" name="MaxPrice" class="form-control" step="0.01" style="max-width:100px;">
    </div>
</div>
<% end if %>

</div>
<div>
<div class="row">
    <div class="col-12">
        <div align="right"><br>
            <button type="submit" class="regsubmit" style="min-width:200px"><b>Search</b></button>
        </div>
    </div>
</div>
</form>
<br>
</div>
</div>
<div class="container">

    <%



        Query = "SELECT Produce.*, IngredientName, Plant.PlantName, MeasurementAbbreviation FROM produce, ingredients, MeasurementLookup, Plant WHERE produce.ingredientID = ingredients.ingredientID and Ingredients.plantID = Plant.PlantID and produce.MeasurementID=MeasurementLookup.MeasurementID and BusinessID = " & Session("BusinessID") & ""
        'response.write("Query=" & Query)
        Set rs = Server.CreateObject("ADODB.Recordset")
        rs.Open Query, conn, 3, 3  

        If rs.eof Then 
    %>
    <%
        Else 
    %>

            <% 
 
            end if
            rs.close 
            %>
        </tbody>
    </table>
</div>

<div class="row">
    <div class="col">

<% IngredientCategory = request.form("IngredientCategory")
IngredientID = request.form("IngredientID")
'response.write("IngredientID=" & IngredinetID)
BusinessIDX = request.form("BusinessID")
'response.write("BusinessIDX=" & BusinessIDX)

PlantName = request.form("PlantName")
'response.write("PlantName=" & PlantName)

QualityID = request.form("QualityID")
'response.write("QualityID=" & QualityID)

measurementID =request.form("measurementID") 
'response.write("measurementID=" & measurementID)

MaxPrice= request.form("MaxPrice") 
'response.write("MaxPrice=" & MaxPrice)

PlantID= request.form("PlantID") 
'response.write("PlantID=" & PlantID)

if len(PlantID)> 0 then
if len(IngredientID)> 0 then
    Query = "SELECT distinct Produce.BusinessID, Business.BusinessName, Business.AddressID, Produce.ProduceID, Produce.measurementID, Produce.QualityID, IngredientName, Plant.PlantName, MeasurementAbbreviation, WholesalePrice, Quantity " &_
            " From Business, produce, ingredients, MeasurementLookup, Plant, IngredientQuality " &_
            " WHERE produce.BusinessID=business.BusinessID and produce.ingredientID = ingredients.ingredientID and Ingredients.plantID = Plant.PlantID " &_
            " and produce.MeasurementID=MeasurementLookup.MeasurementID and ingredients.ingredientID = " & IngredientID & ""

else
            Query = "SELECT distinct Produce.BusinessID, Business.BusinessName, Business.AddressID, Produce.ProduceID, Produce.measurementID, Produce.QualityID, IngredientName, Plant.PlantName, MeasurementAbbreviation, WholesalePrice, Quantity " &_
            " From Business, produce, ingredients, MeasurementLookup, Plant, IngredientQuality " &_
            " WHERE produce.BusinessID=business.BusinessID and produce.ingredientID = ingredients.ingredientID and Ingredients.plantID = Plant.PlantID " &_
            " and produce.MeasurementID=MeasurementLookup.MeasurementID and ingredients.PlantID = " & PlantID & ""

end if

'response.write("Query=" & Query)
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open Query, conn, 3, 3  
if rs.eof then %>

Sorry, we do not currently have <%=IngredientName%> available.
<% else %>
<Table width = 100%>
    <tr>
        <td class="flex-grow-1" style="max-width: 200px;">
            
        </td>
    <td class="flex-grow-1" style="max-width: 300px;">
      <strong>Ingredient</strong>
    </td>
    <td class="flex-grow-1 text-center">
      <strong>Quantity</strong>
    </td>
    <td class="flex-grow-1 text-center">
      <strong>Quality</strong>
    </td>
    <td class="flex-grow-1 text-center">
      <strong>Price</strong>
    </td>
    <td class="flex-grow-1 text-end">
      <strong></strong>
    </td>
</tr>
  
<% while not rs.eof
    BusinessID = rs("BusinessID")
    'AddressCity = rs("AddressCity")
    'AddressState = rs("AddressState")
    BusinessName = rs("BusinessName")
    ProduceID= rs("ProduceID")
    'IngredientCategory = rs("IngredientCategory")
    IngredientName = rs("IngredientName")
    PlantName = rs("PlantName")
    measurementID = rs("measurementID")
    MeasurementAbbreviation = rs("MeasurementAbbreviation")
    QualityID = rs("QualityID")
    Select Case QualityID
    Case 1
        QualityName = "High"
    Case 2
        QualityName = "Medium"
    Case 3
        QualityName = "Low"
    Case 4
        QualityName = "Compost"
    Case Else
        QualityName = "Unknown" ' Default value if QualityID doesn't match any case
End Select
    WholesalePrice = rs("WholesalePrice")
    maxQuantity = cint(rs("Quantity"))

   sql2 = "SELECT address.AddressCity, state_province.name FROM address, state_province where address.Stateindex= state_province.Stateindex and address.AddressID=" & AddressID
   'response.write("Sql2=" & Sql2)
   
   Set rs2 = Server.CreateObject("ADODB.Recordset")
    rs2.Open sql2, conn, 3, 3 
    if not rs2.eof then 
    AddressCity= rs2("AddressCity")
    AddressState= rs2("name")
    end if
    rs2.close
    %>

<form name="OrderIngredients" method="post" action="MembersAddProduceToshoppingCart.asp?ProduceID=<%=ProduceID%>">
<tr>
    <td class="flex-grow-1" style="max-width: 200px;" style="text-align: center; vertical-align: top;">
        <img src="/uploads/Imagenotavailable.jpg" style="max-width: 120px;">
    </td>
      <td class="col-3" style="text-align: leftr; vertical-align: top;">
        <strong><%= IngredientName %></strong> (<%= PlantName %>)
        <input type="hidden" name="IngredientID" value="<%= IngredientID %>">
        <input type="hidden" name="BusinessID" value="<%= BusinessID %>">
        <input type="hidden" name="WholesalePrice" value="<%= WholesalePrice %>">
        <input type="hidden" name="measurementID" value="<%= measurementID %>">
        <br>Seller: <%= BusinessName %><br>
        <img src="images/px.gif" width = 49px height = 12px><%=AddressCity%>, <%=AddressState %>        <br>
      </td>
      <td class="col-1" style="text-align: center; vertical-align: bottom;">
        <% If maxQuantity > 0 Then %>
              <input 
              type="number" 
              id="quantityInput" 
              name="quantity" 
              value="1" 
              class="formbox" 
              style="width: 8ch; text-align: right;" 
              min="1" 
              max="<%= maxQuantity %>" 
              step="1"
              required
            ><%= MeasurementAbbreviation %><br>
            <small class="form-text text-muted">Max:&nbsp;<%= maxQuantity %> <%= MeasurementAbbreviation %></small>
          <% end if %>
     <br><br>
      </td>
      <td class="col-1" style="text-align: center; vertical-align: bottom;">
            <% sql2 = "SELECT * FROM IngredientQuality ORDER BY QualityID"
            Set rs2 = Server.CreateObject("ADODB.Recordset")
            rs2.Open sql2, conn, 3, 3 
            if not rs2.eof then %>
            <select id="QualityID" name="QualityID" class="formbox" >
                <option value="<%=QualityID%>"><%=QualityName%></option>
                <% while not rs2.eof %>
                    <option value="<%=rs2("QualityID") %>"><%=rs2("Qualityname") %></option>
                <% rs2.movenext
                wend %>
            </select>
            <% end if
            rs2.close %> 
            <br><br><br>
        </td>


      <td class="col-2" style="text-align: center; vertical-align: bottom;">
        <% if len(WholesalePrice)> 0 then %>
        $<%= FormatNumber(WholesalePrice, 2) %>
        <% end if %>
        <br><br><br>
      </td>
      <td class="col-2 style="text-align: center; vertical-align: top;"><button class="regsubmit" style = "min-width: 130px; text-align: center; vertical-align: top;">Add to Cart</button></td>
    </tr>
  </form>


<% rs.movenext
wend %>
</table>
</div>
</div>
<% end if
end if
%>


        <br />
    </div>
</div>



 
<!--#Include file="MembersFooter.asp"-->

</body>
</html>