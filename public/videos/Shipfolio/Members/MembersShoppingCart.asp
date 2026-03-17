<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

<!--#Include file="MembersGlobalVariables.asp"-->
</head>
<body>
<!--#Include virtual="/members/MembersHeader.asp"-->
<!--#Include virtual="/Members/MembersProduceJumpLinks.asp"-->

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<script>
    function validateQuantity(input, maxQuantity) {
        const value = parseInt(input.value, 10);

        // Ensure the value is not negative
        if (value < 0) {
            input.value = 0; // Reset to 0 if a negative number is entered
            alert("Quantity cannot be negative.");
        }
        // Enforce maximum quantity restriction
        else if (value > maxQuantity) {
            input.value = maxQuantity; // Restrict to maxQuantity
            alert(`The maximum allowable quantity is ${maxQuantity}.`);
        }

        // Automatically submit the form if the value is valid
        if (value >= 0 && value <= maxQuantity) {
            input.form.submit();
        }
    }
</script>




<div class="container roundedtopandbottom">
    <h1>Shopping Cart</h1>
  
  
<div class="container">

    <%
        Query = "Select IngredientShoppingCart.*, ingredients.PlantId, Ingredients.IngredientName, Produce.QualityID, Produce.MeasurementID, Produce.WholesalePrice, Produce.AvailableDate, Produce.Quantity as MaxQuantity from IngredientShoppingCart , Produce , ingredients " &_ 
                " where IngredientShoppingCart.produceid=Produce.produceid  " &_ 
                " and ingredients.Ingredientid = Produce.IngredientID and BuyerBusinessID = " & Session("BusinessID") & " and Status='AddedToCart' order by ingredients.IngredientName "
       ' response.write("Query=" & Query)
        Set rs = Server.CreateObject("ADODB.Recordset")
        rs.Open Query, conn, 3, 3  

        If rs.eof Then 
    %>
    <p>Your shopping cart is empty.</p>
    <%
        Else 
    %>
    <table class="table" style="width: 100%;">
        <thead>
            <tr>
                <th width = 200px >Ingredient</th>
               
                <th><center>Quality</center></th>
                <th><center>Available Date</center></th>
                <th ><center>Quantity</center></th>
                <th><center>Unit Price</center></th>
                <th><center>Total</center></th>
                <th></th>
            </tr>
        </thead>
        <tbody>
            <% 
            rowcount = 1
            TotalOrderPrice = 0
            While Not rs.eof  
                ShoppingCartID = rs("ShoppingCartID")
                PlantID = rs("PlantID")
                QualityID = rs("QualityID")
                MeasurementID = rs("MeasurementID")
                IngredientName = rs("IngredientName")
                ProduceID = rs("ProduceID")
                WholesalePrice = rs("WholesalePrice")
                IngredientID = rs("IngredientID")
                OrderQuantity = rs("Quantity")
                
                Quantity = rs("Quantity")
                MaxQuantity = rs("MaxQuantity")
                'response.write("MaxQuantity=" & MaxQuantity)
                'RetailPrice = rs("RetailPrice")
                PlantID = rs("PlantID")
                AvailableDate =rs("AvailableDate")
            if len(QualityID)> 0 then
                sql2 = "SELECT * FROM IngredientQuality where QualityID = " & QualityID
                Set rs2 = Server.CreateObject("ADODB.Recordset")
                rs2.Open sql2, conn, 3, 3 
                if not rs2.eof then 
                    QualityName = rs2("QualityName")

                end if 
                rs2.close
            else
            QualityID = 1
            end if


            if len(PlantID)> 0 then
            sql2 = "SELECT Plantname FROM Plant where PlantID = " & PlantID
            Set rs2 = Server.CreateObject("ADODB.Recordset")
            rs2.Open sql2, conn, 3, 3 
            if not rs2.eof then 
                Plantname = rs2("Plantname")

            end if 
            rs2.close
     
        end if



            %>
            <form name="UpdatePagesform" method="post" action="MembersUpdateShoppingCart.asp?Update=True&ShoppingCartID=<%=ShoppingCartID%>">
                <input type="hidden" name="BusinessID" value="<%=BusinessID%>" class="formbox">
                <input type="hidden" name="MaxQuantity" value="<%=MaxQuantity%>" class="formbox">
                <tr>
                    <td>
                        <input name="IngredientID" value="<%=IngredientID %>" type="hidden">
                        <%=IngredientName %>&nbsp;(<%=PlantName %>)
                    </td>
                    
                    <td class="col-lg-1 body" style="width:90px">
                        <center><%=Qualityname %></center>
                    </td>
                    
                    <td align="center">
                        <%= FormatDateTime(AvailableDate, vbShortDate) %>
                    </td>
                    <td align="center">
                        <input type="number" 
                               name="quantity" 
                               class="formbox" 
                               style="width: 12ch; text-align: right;" 
                               value="<%=Quantity%>" 
                               oninput="validateAndSubmit(this, <%=MaxQuantity%>);">
            
                        <% 
                        sql2 = "SELECT * FROM MeasurementLookup where MeasurementID= " & MeasurementID
                        Set rs2 = Server.CreateObject("ADODB.Recordset")
                        rs2.Open sql2, conn, 3, 3 
                        if not rs2.eof then %>
                            <%=rs2("Measurement") %>
                        <% end if
                        rs2.close %> 
                        <br>
                        Max: <%= MaxQuantity %>
                    </td>
                    
                    <td align="center">
                        <% if len(WholesalePrice) > 0 then %>
                        $<%=FormatNumber(WholesalePrice, 2)%>
                        <% end if %>
                    </td>
            
                    <td align="center">
                        <% 
                        ItemPrice = FormatNumber(WholesalePrice, 2) * FormatNumber(Quantity, 2) 
                        TotalOrderPrice=  TotalOrderPrice + ItemPrice %>
                        <b>$<%=FormatNumber(ItemPrice, 2)%></b>
                    </td>
            
                    <td align="center">
                        <button type="submit" name="Update" value="True" style="border: 0px; background: none; cursor: pointer;">
                            <img src="images/edit.svg" alt="edit" height="26" border="0">
                        </button>
                        |
                        <button type="button" onclick="confirmDelete(<%=ShoppingCartID%>)" style="border: 0px; background: none; cursor: pointer;">
                            <img src="images/delete.svg" height="26" border="0" alt="Delete">
                        </button>
                    </td>
                </tr>
            </form>
            
            <script>
                function validateAndSubmit(input, maxQuantity) {
                    // Ensure quantity is non-negative
                    if (input.value < 0) {
                        input.value = 0;
                        alert("Quantity cannot be negative.");
                    }
                    // Enforce maximum quantity restriction
                    if (parseInt(input.value, 10) > maxQuantity) {
                        input.value = maxQuantity;
                        alert(`The maximum allowable quantity is ${maxQuantity}.`);
                    }
                    // Submit the form automatically
                    input.form.submit();
                }
            
                function confirmDelete(id) {
                    if (confirm("Are you sure you want to delete this Item?\n\nClick 'OK' to delete or 'Cancel' to keep it.")) {
                        window.location.href = 'MembersUpdateShoppingCart.asp?ShoppingCartID=' + id + '&Delete=True';
                    }
                }
            </script>
            
            
            <% 
                rowcount = rowcount + 1
                rs.movenext
            Wend
            end if
            rs.close 
            %>
        </tbody>
        <% if TotalOrderPrice > 0 then %>
        <tr>
            <td class = "body" colspan = 5><style align = "right">Total:</style> </td>
            <td><center><b>$<%=FormatNumber(TotalOrderPrice, 2)%></b></center></td>
            <td> 
                <form action="MembersShoppingCartConfirm.asp" method="post">
                        <input type="hidden" name="BusinessID" value="<%=BusinessID%>" class="formbox">
                    <button type="submit" class="regsubmit2" style="min-width: 120px"><b><font class="body">Submit Order</font></b></button>
                </form>
            </td>
        </tr>
        <% end if %>
    </table>
</div>

<div class="row">
    <div class="col">
        <br />
    </div>
</div>



 
<!--#Include file="MembersFooter.asp"-->

</body>
</html>