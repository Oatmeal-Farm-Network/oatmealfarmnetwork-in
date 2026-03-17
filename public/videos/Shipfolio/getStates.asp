<%@ Language=VBScript %>

<!--#Include virtual="/includefiles/globalvariables.asp"-->

<%
Response.Buffer = True ' Buffer output to ensure all content is sent together
Response.Clear ' Clear any previous output

' No need for conn.Open or related error handling here if globalvariables.asp does it.
' If globalvariables.asp *only* sets the object but doesn't open it, you might need conn.Open here.
' Assuming globalvariables.asp opens it:
If conn.State <> 1 Then ' Check if connection is actually open
    Response.Write "<option value='-1'>Error: Database connection not open in globalvariables.asp</option>"
    Response.End
End If

' Get the country_id from the AJAX request
Dim country_id
country_id = Request.QueryString("country_id")

' Validate country_id input robustly
If Not IsNumeric(country_id) Or CInt(country_id) <= 0 Then
    country_id = 1228 ' Default to USA (or your desired default) if invalid/not provided
Else
    country_id = CInt(country_id) ' Ensure it's an integer
End If

Dim sqlStates
sqlStates = "SELECT StateIndex, name FROM state_province WHERE country_id = " & country_id & " ORDER BY name"

Dim rsStates
Set rsStates = Server.CreateObject("ADODB.Recordset")

' --- Open Recordset with Error Handling ---
'On Error Resume Next ' Temporarily enable error handling for query
rsStates.Open sqlStates, conn, 3, 3 ' adOpenStatic, adLockOptimistic
If Err.Number <> 0 Then
    Response.Write "<option value='-1'>Error executing query: " & Server.HTMLEncode(Err.Description) & " SQL: " & Server.HTMLEncode(sqlStates) & "</option>"
    ' Log the error more thoroughly in a real application
    Response.End ' Stop script execution
End If
On Error GoTo 0 ' Disable error handling

Response.ContentType = "text/html" ' Ensure the response type is HTML

' Loop through states and build options
If Not rsStates.EOF Then
    Do Until rsStates.EOF
        ' Ensure values are not Null before writing
        Dim stateIndexVal, stateNameVal
        stateIndexVal = ""
        If Not IsNull(rsStates("StateIndex")) Then stateIndexVal = rsStates("StateIndex")

        stateNameVal = ""
        If Not IsNull(rsStates("name")) Then stateNameVal = rsStates("name")

        Response.Write "<option value=""" & stateIndexVal & """>" & Server.HTMLEncode(stateNameVal) & "</option>"
        rsStates.MoveNext
    Loop
Else
    ' If no states found for the country_id, provide a default "No States" option
    Response.Write "<option value='10000'>No States/Provinces Found</option>"
End If

' Clean up
If Not rsStates Is Nothing Then
    If rsStates.State = 1 Then rsStates.Close
    Set rsStates = Nothing
End If


Response.End
%>