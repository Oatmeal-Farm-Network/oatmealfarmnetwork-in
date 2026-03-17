<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">

<!--#Include file="conn.asp"-->
<% 
ProcessedFoodCategoryID = request.form(" ProcessedFoodCategoryID")
Name = request.form("Name")
quantity = request.form("quantity")
measurementID = request.form("MeasurementID")
wholesalePrice = request.form("wholesalePrice")
retailPrice = request.form("retailPrice")
BusinessID = request.form("BusinessID")

' Validate and sanitize input
If Not IsNumeric(ProcessedFoodCategoryID) Then ProcessedFoodCategoryID = "NULL"
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

' Sanitize ProcessedFoodName
ProcessedFoodName = Replace(ProcessedFoodName, "'", "''")

' Build the SQL query dynamically
Query = "INSERT INTO ProcessedFood (ProcessedFoodCategoryID, Name, Quantity, WholesalePrice, RetailPrice, BusinessID) VALUES ("

Query = Query & ProcessedFoodCategoryID & ", "
Query = Query & "'" & Name & "', "
Query = Query & quantity & ", "
Query = Query & wholesalePrice & ", "
Query = Query & retailPrice & ", "
Query = Query & BusinessID & ")"

' For debugging purposes
Response.Write "Query: " & Query & "<br>"

' Execute the query
On Error Resume Next
Conn.Execute(Query)

If Err.Number <> 0 Then
    Response.Write "Error: " & Err.Description
Else
    conn.Close
    Set conn = Nothing
    Response.Redirect "MembersProcessedFoodInventory.asp"
End If
%>



</Body>
</HTML>