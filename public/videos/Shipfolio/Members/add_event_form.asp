<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <% MasterDashboard= True %>
    <!--#Include virtual="/Members/Membersglobalvariables.asp"-->
<link rel="canonical" href="<%=currenturl %>" />
<title>About <%=WebSiteName %></title>
<meta name="title" content="<%=WebSiteName %>"/> 
<meta name="description" content=""/>  
<meta charset="UTF-8">
<meta name="revisit-after" content="7 Days"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<% homepage = true %>
<!--#Include virtual="/members/membersHeader.asp"-->


<%
' ======================================================================================
' This script assumes the ADO connection object 'conn'
' is already instantiated and opened before this code block begins.
' ======================================================================================

Dim rsEventTypes, strSQL, strMessage, status, msg
Dim BusinessID

BusinessID = Request.QueryString("BusinessID")

If BusinessID = "" Or Not IsNumeric(BusinessID) Then
    Response.Write "<p class='error-message'>A valid BusinessID is required.</p>"
    Response.End
End If

' --- Check for status messages from the processing page ---
status = Request.QueryString("status")
If status = "success" Then
    strMessage = "<p class='success-message'>✅ Event and new location were successfully added!</p>"
ElseIf status = "error" Then
    msg = Request.QueryString("msg")
    strMessage = "<p class='error-message'>" & Server.HTMLEncode(msg) & "</p>"
End If

' --- Load Event Types for the dropdown menu ---
Set rsEventTypes = Server.CreateObject("ADODB.Recordset")
strSQL = "SELECT EventTypeID, EventType FROM eventtypeslookup ORDER BY EventType"
rsEventTypes.Open strSQL, conn
%>
<!DOCTYPE html>
<html>
<head>
    <title>Add a New Event</title>
    <style>
        body { font-family: sans-serif; }
        .form-group { margin-bottom: 15px; }
        fieldset { border: 1px solid #ddd; padding: 15px; margin-bottom: 20px; border-radius: 4px; }
        legend { font-weight: bold; font-size: 1.2em; padding: 0 10px; }
        label { display: block; margin-bottom: 5px; font-weight: bold; }
        input[type="text"], input[type="date"], input[type="time"], input[type="url"], textarea, select {
            width: 100%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 3px;
            box-sizing: border-box;
            text-align: left; /* Explicitly align text to the left */
        }
        input[type="submit"] { background-color: #4CAF50; color: white; padding: 12px 20px; border: none; border-radius: 3px; cursor: pointer; font-size: 16px; }
        .success-message { color: green; border: 1px solid green; padding: 10px; margin-bottom: 15px; border-radius: 3px; background-color: #f0fff0; }
        .error-message { color: red; border: 1px solid red; padding: 10px; margin-bottom: 15px; border-radius: 3px; background-color: #fff0f0; }
        .grid-2, .grid-3 { display: grid; grid-gap: 15px; }
        .grid-2 { grid-template-columns: repeat(2, 1fr); }
        .grid-3 { grid-template-columns: repeat(3, 1fr); }
    </style>
</head>
<body>
<div class="container">
    <h2><img src="/icons/Assoc-events-icon.svg" width="40px">  Add New Event</h2>

    <% If Not IsEmpty(strMessage) Then Response.Write(strMessage) %>

    <form id="eventForm" action="process_event.asp?BusinessID=<%=BusinessID%>" method="post">

        <fieldset>
            <legend>Event Details</legend>
             <div class="form-group">
                <label for="EventName">Event Name:</label>
                <input type="text" id="EventName" name="EventName" required>
            </div>
            <div class="form-group">
                <label for="EventDescription">Event Description:</label>
                <textarea id="EventDescription" name="EventDescription" rows="5"></textarea>
            </div>
             <div class="grid-2">
                <div class="form-group">
                    <label for="EventTypeID">Event Type:</label>
                    <select id="EventTypeID" name="EventTypeID" required>
                        <option value="">-- Select a Type --</option>
                        <%
                        If Not rsEventTypes.EOF Then
                            Do While Not rsEventTypes.EOF
                                Response.Write "<option value='" & rsEventTypes("EventTypeID") & "'>" & rsEventTypes("EventType") & "</option>"
                                rsEventTypes.MoveNext
                            Loop
                        End If
                        %>
                    </select>
                </div>
                <div class="form-group">
                    <label for="EventContactEmail">Public Contact Email:</label>
                    <input type="text" id="EventContactEmail" name="EventContactEmail">
                </div>
                <div class="form-group">
                    <label for="EventStartDate">Event Start Date:</label>
                    <input type="date" id="EventStartDate" name="EventStartDate" required>
                </div>
                <div class="form-group">
                    <label for="EventEndDate">Event End Date:</label>
                    <input type="date" id="EventEndDate" name="EventEndDate">
                </div>
                <div class="form-group">
                    <label for="EventStartTime">Start Time:</label>
                    <input type="time" id="EventStartTime" name="EventStartTime">
                </div>
                <div class="form-group">
                    <label for="EventEndTime">End Time:</label>
                    <input type="time" id="EventEndTime" name="EventEndTime">
                </div>
            </div>
        </fieldset>

        <fieldset>
            <legend>Location & Contact Info</legend>
            <div class="form-group">
                <label for="EventLocationName">Location Name (e.g., "Main Conference Hall"):</label>
                <input type="text" id="EventLocationName" name="EventLocationName" required>
            </div>
            <div class="form-group">
                <label for="AddressStreet">Street Address:</label>
                <input type="text" id="AddressStreet" name="AddressStreet" required>
            </div>
            <div class="grid-3">
                <div class="form-group">
                    <label for="AddressCity">City:</label>
                    <input type="text" id="AddressCity" name="AddressCity" required>
                </div>
                <div class="form-group">
                    <label for="AddressState">State / Province:</label>
                    <input type="text" id="AddressState" name="AddressState" required>
                </div>
                <div class="form-group">
                    <label for="AddressZip">Zip / Postal Code:</label>
                    <input type="text" id="AddressZip" name="AddressZip" required>
                </div>
            </div>
             <div class="form-group">
                <label for="AddressCountry">Country:</label>
                <input type="text" id="AddressCountry" name="AddressCountry" value="USA">
            </div>
             <div class="form-group">
                <label for="Website">Website URL:</label>
                <input type="url" id="Website" name="Website" placeholder="https://www.example.com">
            </div>
             <div class="grid-3">
                 <div class="form-group">
                    <label for="Phone">Main Phone:</label>
                    <input type="text" id="Phone" name="Phone">
                </div>
                <div class="form-group">
                    <label for="Cellphone">Cellphone:</label>
                    <input type="text" id="Cellphone" name="Cellphone">
                </div>
                <div class="form-group">
                    <label for="Fax">Fax:</label>
                    <input type="text" id="Fax" name="Fax">
                </div>
            </div>
        </fieldset>
        
        <input type="hidden" id="EventStartYear" name="EventStartYear"><input type="hidden" id="EventStartMonth" name="EventStartMonth"><input type="hidden" id="EventStartDay" name="EventStartDay">
        <input type="hidden" id="EventEndYear" name="EventEndYear"><input type="hidden" id="EventEndMonth" name="EventEndMonth"><input type="hidden" id="EventEndDay" name="EventEndDay">
        
        <input type="submit" value="Add Event and Location">
    </form>
</div>

<script>
document.getElementById('eventForm').addEventListener('submit', function(e) {
    function parseDate(dateValue, yearField, monthField, dayField) {
        if (dateValue) {
            const dateObj = new Date(dateValue + 'T00:00:00');
            document.getElementById(yearField).value = dateObj.getFullYear();
            document.getElementById(monthField).value = dateObj.getMonth() + 1;
            document.getElementById(dayField).value = dateObj.getDate();
        } else {
             document.getElementById(yearField).value = 0;
             document.getElementById(monthField).value = 0;
             document.getElementById(dayField).value = 0;
        }
    }
    parseDate(document.getElementById('EventStartDate').value, 'EventStartYear', 'EventStartMonth', 'EventStartDay');
    parseDate(document.getElementById('EventEndDate').value, 'EventEndYear', 'EventEndMonth', 'EventEndDay');
});
</script>


<%
rsEventTypes.Close
Set rsEventTypes = Nothing
%>

<!--#Include virtual="/members/membersFooter.asp"-->
</body></html>

