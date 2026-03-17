<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <% MasterDashboard= True %>
    <!--#Include virtual="/members/MembersGlobalVariables.asp"-->
</head>
<body>
<!--#Include virtual="/members/MembersHeader.asp"-->


<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script>
$(document).ready(function() {
    $('#IngredientCategory').change(function() {
        var IngredientCategoryID = $(this).val();
        var ingredientSelect = $('#ingredient');
        ingredientSelect.html('<option value="">Select an ingredient</option>');
        ingredientSelect.prop('disabled', true);

        if (IngredientCategoryID) {
            $.ajax({
                url: 'GetIngredients.asp', 
                type: 'GET',
                data: { IngredientCategoryID: IngredientCategoryID },
                dataType: 'json',
                success: function(data) {
                    if (Array.isArray(data) && data.length > 0) {
                        $.each(data, function(index, ingredient) {
                            ingredientSelect.append($('<option></option>')
                                .attr('value', ingredient.IngredientID)
                                .text(ingredient.IngredientName));
                        });
                        ingredientSelect.prop('disabled', false);
                    } else {
                        console.error('No ingredients found or invalid data format');
                        alert('No ingredients found for this category. Please try another category.');
                    }
                },
                error: function(xhr, status, error) {
                    console.error('Error fetching ingredients:', error);
                    alert('An error occurred while fetching ingredients. Please try again.');
                }
            });
        }
    });
});
</script>

 



    <div class="container roundedtopandbottom">
 <!--#Include virtual="/Members/MembersProduceJumpLinks.asp"-->
  
        <h1>Produce</h1>
    
        <form action="MembersAddIngredient.asp?BusinessID=<%=BusinessID%>" method="post">
            <style>
                @media (min-width: 992px) {
                    .form-row-lg {
                        display: flex;
                        flex-wrap: nowrap;
                        align-items: flex-end; /* Align fields and labels at the bottom */
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
                    /* Additional style to ensure all inputs have a uniform height for alignment */
                    .form-row-lg .form-control,
                    .form-row-lg .form-select {
                        margin-bottom: 0; /* Clear any default margin */
                    }
                }
            </style>
    
            <h2>Add Produce</h2>
    
            <div class="form-row-lg">
                <div class="col-lg-2">
                    <input name="BusinessID" Value="<%=BusinessID%>" type="hidden">
                    <% Set rsCat = Server.CreateObject("ADODB.Recordset")
                    sqlCat = "SELECT IngredientCategoryID, IngredientCategory FROM IngredientCategoryLookup ORDER BY IngredientCategory"
                    rsCat.Open sqlCat, conn, 3, 3 %>
                    <label for="IngredientCategory" class="body">Ingredient Category</label>
                    <select id="IngredientCategory" name="IngredientCategory" class="form-select" required>
                        <option value="">Select a category</option>
                        <% While Not rsCat.EOF %>
                            <option value="<%=rsCat("IngredientCategoryID")%>"><%= rsCat("IngredientCategory") %></option>
                            <% rsCat.MoveNext
                            Wend
                            rsCat.Close
                            Set rsCat = Nothing %>
                    </select>
                </div>
    
                <div class="col-lg-2">
                    <label for="ingredient" class="body">Ingredient</label>
                    <select id="ingredient" name="ingredient" class="form-select" required>
                        <option value=""></option>
                    </select>
                </div>
                
                <div class="col-lg-1">
                    <label for="quantity" class="body">Quantity</label>
                    <input type="number" id="quantity" name="quantity" class="form-control">
                </div>
                
                <div class="col-lg-2">
                    <% sql2 = "SELECT * FROM MeasurementLookup ORDER BY MeasurementOrder"
                    Set rs2 = Server.CreateObject("ADODB.Recordset")
                    rs2.Open sql2, conn, 3, 3 
                    if not rs2.eof then %>
                    <label for="measurementID" class="body">Measurement</label>
                    <select id="measurementID" name="measurementID" class="form-select">
                        <option value=""></option>
                        <% while not rs2.eof %>
                            <option value="<%=rs2("MeasurementID") %>"><%=rs2("Measurement") %> (<%=rs2("MeasurementAbbreviation") %>)</option>
                        <% rs2.movenext
                        wend %>
                    </select>
                    <% end if
                    rs2.close %> 
                </div>
    
                <div class="col-lg-2">
                    <label for="wholesalePrice" class="body">Wholesale (USD)</label>
                    <div class="input-group">
                        <span class="input-group-text">$</span>
                        <input type="number" id="wholesalePrice" name="wholesalePrice" class="form-control" step="0.01">
                    </div>
                </div>
    
                <div class="col-lg-2">
                    <label for="retailPrice" class="body">Retail(USD)</label>
                    <div class="input-group">
                        <span class="input-group-text">$</span>
                        <input type="number" id="retailPrice" name="retailPrice" class="form-control" step="0.01">
                    </div>
                </div>
    
                <div class="col-lg-2">
                    <label for="availableDate" class="body">Available</label>
                    <input type="date" id="availableDate" name="availableDate" class="form-control">
                </div>
            </div>
            
            <div class="row">
                <div class="col-12">
                    <div align="right"><br>
                        <button type="submit" class="regsubmit2" style="min-width:200px">Add Produce</button>
                    </div>
                </div>
            </div>
        </form>

    <H2 id="inventory">Inventory</H2>
    
    <% 
    row = "even"
    sql2 = " select Produce.*, Ingredients.* , MeasurementLookup.* from MeasurementLookup , produce, Ingredients where produce.MeasurementID= MeasurementLookup.MeasurementID and produce.IngredientID= Ingredients.IngredientID and BusinessID = " & BusinessID & " order by IngredientName "
    'response.write("sql2=" & sql2)
    Set rs2 = Server.CreateObject("ADODB.Recordset")
    rs2.Open sql2, conn, 3, 3 
    if rs2.eof then %>
        <br> You do not currently have any produce listed.
    
    <% else
    'response.write("showpageorder =" & showpageorder )
    acounter = 1
    recordcount = rs2.recordcount
    'response.write("recordcount=" & recordcount)
    
    showpageorder = True

    linecount = 0
    If Not rs2.EOF Then
        Do While Not rs2.EOF
            ' Check for success message
            If Session("SuccessMessage") <> "" Then
                Response.Write "<script>alert('" & Session("SuccessMessage") & "');</script>"
                Session("SuccessMessage") = "" ' Clear the message after displaying
            End If
    
            linecount = linecount + 1
            ProduceID=rs2("ProduceID")
            Quantity = rs2("Quantity")
            IngredientName = rs2("IngredientName")
            MeasurementID = rs2("MeasurementID")
            MeasurementAbbreviation = rs2("MeasurementAbbreviation")
            RetailPrice = rs2("RetailPrice")
            WholesalePrice = rs2("WholesalePrice")
            AvailableDate = rs2("AvailableDate")
            IngredientID = rs2("IngredientID")
            ShowProduce = rs2("ShowProduce")
    %>
    <form name="UpdatePagesform" method="post" action="MembersUpdateProduce.asp?BusinessID=<%=BusinessID%>&ProduceID=<%=ProduceID%>">
        <input name="BusinessID" value="<%=BusinessID%>" type="hidden">
        <div class="form-row-lg">    


            <div class="col-lg-2">
                <label for="IngredientID" class="body">Ingredient</label>
                <div class="input-group">
                <input type="hidden" name="IngredientID" value="<%=IngredientID%>"><b><%=IngredientName %></b><br>
                </div>
            </div>
    
            <div class="col-lg-2">
                <div class="input-group">
                    <label for="WholesalePrice" class="body">Wholesale</label>
                    <div class="input-group">
                    <span class="input-group-text">$</span>
                    <input type="number" id="WholesalePrice" name="WholesalePrice" class="form-control" step="0.01" value="<%=FormatNumber(WholesalePrice, 2)%>" >
                </div>
                </div>
            </div>
    
            <div class="col-lg-2">
                    <label for="retailPrice" class="body">Retail</label>
                    <div class="input-group">
                    <span class="input-group-text">$</span>
                    <input type="number" id="retailPrice" name="retailPrice" class="form-control" step="0.01" value="<%=FormatNumber(RetailPrice, 2)%>" >
                    </div>
               </div>
    
            <div class="col-lg-1" >
                <label for="Quantity" class="body">Quantity</label>
                <div class="input-group">
                <input type="number" name="Quantity" value="<%=Quantity%>" class="form-control">
                </div>
            </div>
    
            <div class="col-lg-2">
                <label for="MeasurementID" class="body">Measurement</label>
                <div class="input-group">
                <% 
                sql3 = "SELECT * FROM MeasurementLookup ORDER BY MeasurementOrder"
                Set rs3 = Server.CreateObject("ADODB.Recordset")
                rs3.Open sql3, conn, 3, 3 
                if not rs3.eof then 
                %>
                <select name="MeasurementID" class="form-select">
                    <% 
                    do while not rs3.eof
                        selected = ""
                        if CStr(rs3("MeasurementID")) = CStr(MeasurementID) then
                            selected = "selected"
                        end if
                    %>
                        <option value="<%=rs3("MeasurementID")%>" <%=selected%>>
                            <%=rs3("MeasurementAbbreviation")%>
                        </option>
                    <%
                        rs3.movenext
                    loop
                    %>
                </select>
                <% 
                end if
                rs3.close 
                Set rs3 = Nothing
                %>
            </div>
        </div>

            <div class="col-lg-2">
                <label for="AvailableDate" class="body">Available</label>
                <div class="input-group">
                <input type="date" name="AvailableDate" value="<%=AvailableDate%>" class="form-control">
                </div>
            </div>
            
            <div class="col-lg-2" >
                Show: <input type="checkbox" name="ShowProduce" value="1" <% If ShowProduce = 1 Then Response.Write "checked" %>><br><br>
                
            </div>
    
            <div class="col-lg-2">
                <div align = Right>
                <button type="submit" name="Update" value="True" style="border: 0px; background: none; cursor: pointer;"><img src="images/edit.svg" alt="edit" height="26" border="0"></button>
                |
                <button type="button" onclick="confirmDelete()" style="border: 0px; background: none; cursor: pointer;"><img src="images/delete.svg" height="26" border="0" alt="Delete"></button>
                <script>
                function confirmDelete() {
                    if (confirm("Are you sure you want to delete this Produce?\n\nClick 'Delete' to delete or 'Cancel' to keep it.")) {
                        window.location.href = 'MembersUpdateProduce.asp?ProduceID=<%=ProduceID%>&BusinessID=<%=BusinessID%>&Delete=True';
                    }
                }
                </script>
                </div>
            </div>
        </div>
    </form>
    <%
            rs2.MoveNext
        Loop

    %>
   
    
    <br>
    <br>
    
    <% 
    Else 
        Response.Write "<p>No ingredients found.</p>"
    End If
    rs2.Close
    Set rs2 = Nothing
    
    end if
    %>
</div>


 
<!--#Include file="MembersFooter.asp"-->

</body>
</html>