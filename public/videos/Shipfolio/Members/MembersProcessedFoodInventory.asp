<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

<!--#Include file="MembersGlobalVariables.asp"-->
</head>
<body>
<!--#Include virtual="/members/MembersHeader.asp"-->
<!--#Include virtual="/Members/MembersProcessedFoodJumpLinks.asp"-->

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>


<style>
    @media (min-width: 768px) {
        .form-row {
            display: flex;
            align-items: flex-end;
        }
        .form-row > div {
            margin-right: 10px;
        }
        .form-row > div:last-child {
            margin-right: 0;
        }
    }
</style>



<div class="container roundedtopandbottom">
    <h1>Processed Food Inventory</h1>
    <div>Processed Foods: Jams, sauces, baked goods, etc.</div>
    <form action="MembersAddProcessedFood.asp" method="post">
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


<h2>Add Processed Food</h2>

        <div class="form-row-lg">
             <div class="col">
                            <label for="processedFood" class="form-label"><b>Item Name: </b></label>
                            <input type="text" id="processedFood" name="Name" class="formbox" size="56">
             </div>
        </div>
        <div class="form-row-lg">
            <div class="col-lg-2">

                <input name="BusinessID" Value="<%=BusinessID%>" type = "hidden"> 
                <% Set rsCat = Server.CreateObject("ADODB.Recordset")
                sqlCat = "SELECT ProcessedFoodCategoryID, CategoryName FROM ProcessedFoodCategoryLookup ORDER BY ProcessedFoodCategoryOrder"
                rsCat.Open sqlCat, conn, 3, 3 %>
                <label for=" ProcessedFoodCategoryID" class="form-label"><b>Processed Food Category</b></label>
                <select id=" ProcessedFoodCategoryID" name=" ProcessedFoodCategoryID" class="form-select" required>
                    <option value="">Select a category</option>
                    <% While Not rsCat.EOF %>
                        <option value="<%=rsCat("ProcessedFoodCategoryID")%>"><%= rsCat("CategoryName") %></option>
                        <% rsCat.MoveNext
                    Wend
                    rsCat.Close
                    Set rsCat = Nothing %>
                </select>
            </div>


            <!-- Quantity and Measurement -->

                <div class="col-lg-1" style="width:90px">
                    <label for="quantity" class="form-label"><b># Available</b></label><br>
                    <input type="number" id="quantity" name="Quantity" class="formbox" style="max-width:100px" >
                </div>


            <!-- Wholesale Price -->
            <div class="col-lg-2">
                <label for="wholesalePrice" class="form-label"><b>Wholesale Price (USD)</b></label>
                <div class="input-group">
                    <span class="input-group-text">$</span>
                    <input type="number" id="wholesalePrice" name="wholesalePrice" class="formbox" step="0.01" style="max-width:100px;">
                </div>
            </div>

            <!-- Retail Price -->
            <div class="col-lg-2">
                <label for="retailPrice" class="form-label"><b>Retail Price (USD)</b></label>
                <div class="input-group">
                    <span class="input-group-text">$</span>
                    <input type="number" id="retailPrice" name="retailPrice" class="formbox" step="0.01" style="max-width:90px;">
                </div>
            </div>


        </div>

        <div class="row">
            <div class="col-12">
                <div align="right"><br>
                    <button type="submit" class="regsubmit" style="min-width:200px"><b>Add Processed Food</b></button>
                </div>
            </div>
        </div>
    </form>

<H2>Inventory</H2>

 <%  
row = "even"
sql2 = " select * from ProcessedFood, ProcessedFoodCategoryLookup where ProcessedFood.ProcessedFoodCategoryID= ProcessedFoodCategoryLookup.ProcessedFoodCategoryID and BusinessID = " & BusinessID & " order by Name "
'response.write("sql2=" & sql2)
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3 
if  rs2.eof then %>
 <br>   You do not currently have any processed foods listed.

<% else
'response.write("showpageorder =" & showpageorder )
 acounter = 1
recordcount = rs2.recordcount
'response.write("recordcount=" & recordcount)

showpageorder = True
%>

<table class="table" width="100%">


<input name="BusinessID" value="<%=BusinessID%>" type="hidden">

<tr>
    <th class="body"><b>Processed Food</b></th>
    <th class="body" align="right"><b>Wholesale Price</b></th>
    <th class="body" align="Right"><b>Retail Price</b></th>
    <th class="body" align="center"><b>Qty</b></th>
    <th class="body" align="center"><b>Available</b></th>
    <th class="body" align="center"><b>Display</b></th>
    <th class="body" align="center"><b>Options</b></th>
</tr>
<% 
linecount = 0
If Not rs2.EOF Then
    Do While Not rs2.EOF
        ' Check for success message
        If Session("SuccessMessage") <> "" Then
            Response.Write "<script>alert('" & Session("SuccessMessage") & "');</script>"
            Session("SuccessMessage") = "" ' Clear the message after displaying
        End If

        linecount = linecount + 1
        ProcessedFoodID=rs2("ProcessedFoodID")
        Quantity = rs2("Quantity")
        Name = rs2("Name")
        RetailPrice = rs2("RetailPrice")
        WholesalePrice = rs2("WholesalePrice")
        ProcessedFoodID = rs2("ProcessedFoodID")
        ShowProcessedFood = rs2("ShowProcessedFood")
%>
<form name="UpdatePagesform" method="post" action="MembersUpdateProcessedFood.asp?ProcessedFoodID=<%=ProcessedFoodID%>">
    <input type="hidden" name="BusinessID" value="<%=BusinessID%>" class="formbox" style="max-width:90px" step="0.01">
    <tr>
        <td class="body"><input type="hidden" name="ProcessedFoodID" value="<%=ProcessedFoodID%>" ><%=Name %></td>
        <td class="body" align="center">$<input type="number" name="WholesalePrice" value="<%=FormatNumber(WholesalePrice, 2)%>" class="formbox" style="max-width:90px" step="0.01"></td>
        <td class="body" align="center">$<input type="number" name="RetailPrice" value="<%=FormatNumber(RetailPrice, 2)%>" class="formbox" style="max-width:90px"  step="0.01"></td>
        <td class="body" align="center">
            <input type="number" name="Quantity" value="<%=Quantity%>" class="formbox" style="width: 90px; display: inline-block;">
        </td>
        <td class="body" align="center"><input type="date" name="AvailableDate" value="<%=AvailableDate%>" class="formbox"></td>
        <td class="body" align="center">
            <input type="checkbox" name="ShowProcessedFood" value="1" <% If ShowProcessedFood = 1 Then Response.Write "checked" %>>



        </td>
        <td class="body" align="center">
            <button type="submit" name="Update" value="True" style="border: 0px; background: none; cursor: pointer;"><img src= "images/edit.svg" alt = "edit" height ="26" border = "0"></button>
            |
            <button type="button" onclick="confirmDelete()" style="border: 0px; background: none; cursor: pointer;"><img src="images/delete.svg" height="26" border="0" alt="Delete"></button>
            <script>
            function confirmDelete() {
                if (confirm("Are you sure you want to delete this Processed Food?\n\nClick 'OK' to delete or 'Cancel' to keep it.")) {
                    window.location.href = 'MembersUpdateProcessedFood.asp?ProcessedFoodID=<%=ProcessedFoodID%>&Delete=True';
                }
            }
            </script>
        </td>
    </tr>
</form>
<%
        rs2.MoveNext
    Loop
%>

</table>

<br>

</div>
<br>

<% 
Else 
    Response.Write "<p>No processed foods found.</p>"
End If
rs2.Close

end if
%>
</div>



 
<!--#Include file="MembersFooter.asp"-->

</body>
</html>