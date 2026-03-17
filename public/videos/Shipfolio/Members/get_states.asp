<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <title>Harvest Hub Dashboard</title>
      <% MasterDashboard= True %>
<!--#Include virtual="/members/MembersGlobalVariables.asp"-->
<%

Response.ContentType = "application/json"
Response.CharSet = "UTF-8"

Dim conn        ' Assuming 'conn' is created in an include file
Dim sql, rs
Dim country_id
Dim jsonOutput, jsonArray, recordCount

'-- 1. Get and validate the country_id from the query string --
country_id = Request.QueryString("country_id")
if len(country_id) < 2 then country_id=1228

If Not IsNumeric(country_id) Or Len(country_id) = 0 Then
    ' If country_id is invalid or missing, return an empty JSON array
    Response.Write "[]"
    Response.End
End If

'-- 2. Fetch the data from the database --
sql = "SELECT StateIndex, name FROM state_province WHERE country_id = " & CLng(country_id) & " ORDER BY name"

Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 1, 1 ' adOpenForwardOnly, adLockReadOnly for best performance

jsonArray = ""
recordCount = 0

If Not rs.EOF Then
    '-- 3. Build the JSON string manually --
    ' For modern systems, a JSON library would be better, but this works universally.
    Do While Not rs.EOF
        If recordCount > 0 Then
            jsonArray = jsonArray & ","
        End If

        jsonArray = jsonArray & "{"
        jsonArray = jsonArray & """id"": " & rs("StateIndex") & ","
        ' Simple JSON encoding for the name to handle quotes or special characters
        jsonArray = jsonArray & """name"": """ & Replace(rs("name"), """", "\""") & """"
        jsonArray = jsonArray & "}"

        recordCount = recordCount + 1
        rs.MoveNext
    Loop
End If

rs.Close
Set rs = Nothing
Set conn = Nothing

'-- 4. Output the final JSON array --
jsonOutput = "[" & jsonArray & "]"
Response.Write jsonOutput
%>

</body>
</HTML>