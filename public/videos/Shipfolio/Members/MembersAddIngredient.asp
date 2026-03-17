<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">

<!--#Include file="conn.asp"-->

  
<% 
ingredientCategoryID= request.form("ingredientCategoryID")
ingredientID= request.form("ingredient")
quantity= request.form("quantity")
measurementID= request.form("measurementID")
  wholesalePrice= request.form("wholesalePrice")
  retailPrice= request.form("retailPrice")
  availableDate=request.form("availableDate")
  BusinessID = request.form("BusinessID")

' Validate and sanitize input
If Not IsNumeric(ingredientID) Then ingredientID = "NULL"
If Not IsNumeric(quantity) Then quantity = "NULL"
If Not IsNumeric(measurementID) Then measurementID = "NULL"
If Not IsNumeric(wholesalePrice) Then wholesalePrice = "NULL"
If Not IsNumeric(retailPrice) Then retailPrice = "NULL"

' Format date or set to NULL if empty
If Len(Trim(availableDate)) > 0 Then
    availableDate = "'" & Replace(availableDate, "'", "''") & "'"
Else
    availableDate = "NULL"
End If

' Build the SQL query dynamically
Query = "INSERT INTO produce (ingredientID, quantity, measurementID, wholesalePrice, retailPrice, BusinessID, availableDate ) VALUES ("

Query = Query & ingredientID & ", "
Query = Query & quantity & ", "
Query = Query & measurementID & ", "
Query = Query & wholesalePrice & ", "
Query = Query & retailPrice & ", "'
Query = Query & BusinessID & ", "
Query = Query & availableDate & ")"

' For debugging purposes
Response.Write "Query: " & Query & "<br>"

' Execute the query
On Error Resume Next
Conn.Execute(Query)

conn.Close
Set conn = Nothing


Response.Redirect "MembersProduceInventory.asp?BusinessID=" & BusinessID

%>



</Body>
</HTML>