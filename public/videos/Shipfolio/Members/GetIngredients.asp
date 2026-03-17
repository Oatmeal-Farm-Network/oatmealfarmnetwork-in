
<!--#Include virtual="/members/Conn.asp"-->
<%
' Set content type to JSON
Response.ContentType = "application/json"

' Your database query here
Set rsIngredients = Server.CreateObject("ADODB.Recordset")
sqlIngredients = "SELECT IngredientID, IngredientName FROM Ingredients WHERE IngredientCategoryID = " & Request.QueryString("IngredientCategoryID")
rsIngredients.Open sqlIngredients, conn

' Initialize an empty array to store the ingredients
Dim ingredientsArray()
ReDim ingredientsArray(-1)

' Loop through the recordset and build the JSON
Do While Not rsIngredients.EOF
    ' Increment array size
    ReDim Preserve ingredientsArray(UBound(ingredientsArray) + 1)

    ' Add a new object for each ingredient
    ingredientsArray(UBound(ingredientsArray)) = "{""IngredientID"":""" & rsIngredients("IngredientID") & """, ""IngredientName"":""" & rsIngredients("IngredientName") & """}"

    rsIngredients.MoveNext
Loop

rsIngredients.Close
Set rsIngredients = Nothing

' Output the JSON array
Response.Write "[" & Join(ingredientsArray, ",") & "]"
%>

