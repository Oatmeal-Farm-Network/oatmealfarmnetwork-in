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
<style>
    body { font-family: sans-serif; } .form-group { margin-bottom: 15px; } fieldset { border: 1px solid #ddd; padding: 15px; margin-bottom: 20px; border-radius: 4px; } legend { font-weight: bold; font-size: 1.2em; padding: 0 10px; } label { display: block; margin-bottom: 5px; font-weight: bold; } input[type="text"], input[type="date"], input[type="time"], input[type="url"], textarea, select { width: 100%; padding: 8px; border: 1px solid #ccc; border-radius: 3px; box-sizing: border-box; text-align: left; } input[type="submit"], .btn-back { display: inline-block; text-decoration: none; text-align: center; border: none; padding: 12px 20px; border-radius: 3px; cursor: pointer; font-size: 16px; } input[type="submit"] { background-color: #007bff; color: white; } .btn-back { background-color: #6c757d; color: white; } .form-actions { display: flex; justify-content: space-between; } .error-message, .success-message { padding: 10px; margin-bottom: 15px; border-radius: 3px; } .success-message { color: green; border: 1px solid green; background-color: #f0fff0; } .error-message { color: red; border: 1px solid red; background-color: #fff0f0; } .grid-2, .grid-3 { display: grid; grid-gap: 15px; } .grid-2 { grid-template-columns: repeat(2, 1fr); } .grid-3 { grid-template-columns: repeat(3, 1fr); }
</style>

</head>
<body>
<% homepage = true %>
<!--#Include virtual="/members/membersHeader.asp"-->


<%
' ======================================================================================
' This script assumes the ADO connection object 'conn' is already open.
' ======================================================================================

Const adVarChar = 200, adInteger = 3, adParamInput = 1, adCmdStoredProc = 4, adVarWChar = 202

' --- Helper Functions ---
Function ToLong(val)
    If IsNumeric(val) And val <> "" Then ToLong = CLng(val) Else ToLong = 0
End Function

Function FormatDate(yr, mo, da)
    If ToLong(yr) > 0 And ToLong(mo) > 0 And ToLong(da) > 0 Then FormatDate = yr & "-" & Right("0" & mo, 2) & "-" & Right("0" & da, 2) Else FormatDate = ""
End Function

Function EncodeText(val)
    If IsNull(val) Then EncodeText = "" Else EncodeText = Server.HTMLEncode(val)
End Function


Dim cmd, rsEventData, rsEventTypes, strSQL
Dim EventID, BusinessID, strMessage

EventID = ToLong(Request.QueryString("EventID"))
If EventID = 0 Then
    Response.Write("A valid EventID is required.")
    Response.End
End If

If Request.ServerVariables("REQUEST_METHOD") = "POST" Then
    ' --- PROCESS THE FORM SUBMISSION (UPDATE) ---
    On Error Resume Next
    
    Set cmd = Server.CreateObject("ADODB.Command")
    cmd.ActiveConnection = conn
    cmd.CommandText = "dbo.usp_UpdateEvent"
    cmd.CommandType = adCmdStoredProc

    ' Append all parameters for the update procedure
    cmd.Parameters.Append cmd.CreateParameter("@EventID", adInteger, adParamInput, , EventID)
    cmd.Parameters.Append cmd.CreateParameter("@EventLocationID", adInteger, adParamInput, , ToLong(Request.Form("EventLocationID")))
    cmd.Parameters.Append cmd.CreateParameter("@AddressID", adInteger, adParamInput, , ToLong(Request.Form("AddressID")))
    cmd.Parameters.Append cmd.CreateParameter("@WebsiteID", adInteger, adParamInput, , ToLong(Request.Form("WebsiteID")))
    cmd.Parameters.Append cmd.CreateParameter("@PhoneID", adInteger, adParamInput, , ToLong(Request.Form("PhoneID")))
    cmd.Parameters.Append cmd.CreateParameter("@BusinessID", adInteger, adParamInput, , ToLong(Request.Form("BusinessID")))
    cmd.Parameters.Append cmd.CreateParameter("@EventName", adVarChar, adParamInput, 255, Request.Form("EventName"))
    cmd.Parameters.Append cmd.CreateParameter("@EventTypeID", adInteger, adParamInput, , ToLong(Request.Form("EventTypeID")))
    cmd.Parameters.Append cmd.CreateParameter("@EventStartYear", adInteger, adParamInput, , ToLong(Request.Form("EventStartYear")))
    cmd.Parameters.Append cmd.CreateParameter("@EventStartMonth", adInteger, adParamInput, , ToLong(Request.Form("EventStartMonth")))
    cmd.Parameters.Append cmd.CreateParameter("@EventStartDay", adInteger, adParamInput, , ToLong(Request.Form("EventStartDay")))
    cmd.Parameters.Append cmd.CreateParameter("@EventEndYear", adInteger, adParamInput, , ToLong(Request.Form("EventEndYear")))
    cmd.Parameters.Append cmd.CreateParameter("@EventEndMonth", adInteger, adParamInput, , ToLong(Request.Form("EventEndMonth")))
    cmd.Parameters.Append cmd.CreateParameter("@EventEndDay", adInteger, adParamInput, , ToLong(Request.Form("EventEndDay")))
    cmd.Parameters.Append cmd.CreateParameter("@EventStartTime", adVarChar, adParamInput, 50, Request.Form("EventStartTime"))
    cmd.Parameters.Append cmd.CreateParameter("@EventEndTime", adVarChar, adParamInput, 50, Request.Form("EventEndTime"))
    cmd.Parameters.Append cmd.CreateParameter("@EventDescription", adVarWChar, adParamInput, 8000, Request.Form("EventDescription"))
    cmd.Parameters.Append cmd.CreateParameter("@EventContactEmail", adVarChar, adParamInput, 255, Request.Form("EventContactEmail"))
    cmd.Parameters.Append cmd.CreateParameter("@EventLocationName", adVarChar, adParamInput, 255, Request.Form("EventLocationName"))
    cmd.Parameters.Append cmd.CreateParameter("@Website", adVarChar, adParamInput, 255, Request.Form("Website"))
    cmd.Parameters.Append cmd.CreateParameter("@Phone", adVarChar, adParamInput, 50, Request.Form("Phone"))
    cmd.Parameters.Append cmd.CreateParameter("@Cellphone", adVarChar, adParamInput, 50, Request.Form("Cellphone"))
    cmd.Parameters.Append cmd.CreateParameter("@AddressStreet", adVarChar, adParamInput, 255, Request.Form("AddressStreet"))
    cmd.Parameters.Append cmd.CreateParameter("@AddressCity", adVarChar, adParamInput, 100, Request.Form("AddressCity"))
    cmd.Parameters.Append cmd.CreateParameter("@AddressState", adVarChar, adParamInput, 50, Request.Form("AddressState"))
    cmd.Parameters.Append cmd.CreateParameter("@AddressZip", adVarChar, adParamInput, 20, Request.Form("AddressZip"))
    cmd.Parameters.Append cmd.CreateParameter("@AddressCountry", adVarChar, adParamInput, 100, Request.Form("AddressCountry"))
    
    cmd.Execute
    
    If Err.Number <> 0 Then
        strMessage = "<p class='error-message'>An error occurred while saving: " & Err.Description & "</p>"
    Else
        strMessage = "<p class='success-message'>✅ Changes saved successfully!</p>"

    End If
End If

' --- This block now runs for BOTH GET requests AND after a POST request ---
Set cmd = Server.CreateObject("ADODB.Command")
cmd.ActiveConnection = conn
cmd.CommandText = "dbo.usp_GetEventDetails"
cmd.CommandType = adCmdStoredProc
cmd.Parameters.Append cmd.CreateParameter("@EventID", adInteger, adParamInput, , EventID)
Set rsEventData = cmd.Execute

If rsEventData.EOF Then
    Response.Write("This event could not be found or you do not have permission to edit it.")
    Response.End
End If

BusinessID = rsEventData("BusinessID") ' Get BusinessID for the "Back" link

' Load Event Types for the dropdown menu
Set rsEventTypes = Server.CreateObject("ADODB.Recordset")
strSQL = "SELECT EventTypeID, EventType FROM eventtypeslookup ORDER BY EventType"
rsEventTypes.Open strSQL, conn
%>



<div class="container">
    <h2><img src="/icons/Assoc-events-icon.svg" width="40px"> Edit Event</h2>

    <% If Not IsEmpty(strMessage) Then Response.Write(strMessage) %>

    <form id="eventForm" action="edit_event.asp?EventID=<%=EventID%>" method="post">
        <input type="hidden" name="EventLocationID" value="<%=rsEventData("EventLocationID")%>">
        <input type="hidden" name="AddressID" value="<%=rsEventData("AddressID")%>">
        <input type="hidden" name="WebsiteID" value="<%=rsEventData("WebsiteID")%>">
        <input type="hidden" name="PhoneID" value="<%=rsEventData("PhoneID")%>">
        <input type="hidden" name="BusinessID" value="<%=rsEventData("BusinessID")%>">

        <fieldset>
            <legend>Event Details</legend>
             <div class="form-group">
                <label for="EventName">Event Name:</label>
                <input type="text" id="EventName" name="EventName" value="<%=EncodeText(rsEventData("EventName"))%>" required>
            </div>
            <div class="form-group">
                <label for="EventDescription">Event Description:</label>
                <textarea id="EventDescription" name="EventDescription" rows="5"><%=EncodeText(rsEventData("EventDescription"))%></textarea>
            </div>
             <div class="grid-2">
                <div class="form-group">
                    <label for="EventTypeID">Event Type:</label>
                    <select id="EventTypeID" name="EventTypeID" required>
                        <option value="">-- Select a Type --</option>
                        <% Do While Not rsEventTypes.EOF %>
                            <option value="<%=rsEventTypes("EventTypeID")%>"<%If CStr(rsEventTypes("EventTypeID")) = CStr(rsEventData("EventTypeID")) Then Response.Write " selected"%>>
                                <%=rsEventTypes("EventType")%>
                            </option>
                        <% rsEventTypes.MoveNext : Loop %>
                    </select>
                </div>
                <div class="form-group">
                    <label for="EventContactEmail">Public Contact Email:</label>
                    <input type="text" id="EventContactEmail" name="EventContactEmail" value="<%=EncodeText(rsEventData("EventContactEmail"))%>">
                </div>
                <div class="form-group">
                    <label for="EventStartDate">Event Start Date:</label>
                    <input type="date" id="EventStartDate" name="EventStartDate" value="<%=FormatDate(rsEventData("EventStartYear"), rsEventData("EventStartMonth"), rsEventData("EventStartDay"))%>" required>
                </div>
                <div class="form-group">
                    <label for="EventEndDate">Event End Date:</label>
                    <input type="date" id="EventEndDate" name="EventEndDate" value="<%=FormatDate(rsEventData("EventEndYear"), rsEventData("EventEndMonth"), rsEventData("EventEndDay"))%>">
                </div>
                <div class="form-group">
                    <label for="EventStartTime">Start Time:</label>
                    <input type="time" id="EventStartTime" name="EventStartTime" value="<%=EncodeText(rsEventData("EventStartTime"))%>">
                </div>
                <div class="form-group">
                    <label for="EventEndTime">End Time:</label>
                    <input type="time" id="EventEndTime" name="EventEndTime" value="<%=EncodeText(rsEventData("EventEndTime"))%>">
                </div>
            </div>
        </fieldset>

        <fieldset>
            <legend>Location & Contact Info</legend>
            <div class="form-group"><label for="EventLocationName">Location Name:</label><input type="text" id="EventLocationName" name="EventLocationName" value="<%=EncodeText(rsEventData("EventLocationName"))%>" required></div>
            <div class="form-group"><label for="AddressStreet">Street Address:</label><input type="text" id="AddressStreet" name="AddressStreet" value="<%=EncodeText(rsEventData("AddressStreet"))%>" required></div>
            <div class="grid-3">
                <div class="form-group"><label for="AddressCity">City:</label><input type="text" id="AddressCity" name="AddressCity" value="<%=EncodeText(rsEventData("AddressCity"))%>" required></div>
                <div class="form-group"><label for="AddressState">State / Province:</label><input type="text" id="AddressState" name="AddressState" value="<%=EncodeText(rsEventData("AddressState"))%>" required></div>
                <div class="form-group"><label for="AddressZip">Zip / Postal Code:</label><input type="text" id="AddressZip" name="AddressZip" value="<%=EncodeText(rsEventData("AddressZip"))%>" required></div>
            </div>
            <div class="form-group"><label for="AddressCountry">Country:</label><input type="text" id="AddressCountry" name="AddressCountry" value="<%=EncodeText(rsEventData("AddressCountry"))%>"></div>
            <div class="form-group"><label for="Website">Website URL:</label><input type="url" id="Website" name="Website" value="<%=EncodeText(rsEventData("Website"))%>"></div>
            <div class="grid-3">
                 <div class="form-group"><label for="Phone">Main Phone:</label><input type="text" id="Phone" name="Phone" value="<%=EncodeText(rsEventData("Phone"))%>"></div>
                <div class="form-group"><label for="Cellphone">Cellphone:</label><input type="text" id="Cellphone" name="Cellphone" value="<%=EncodeText(rsEventData("Cellphone"))%>"></div>
            </div>
        </fieldset>
        
        <input type="hidden" id="EventStartYear" name="EventStartYear"><input type="hidden" id="EventStartMonth" name="EventStartMonth"><input type="hidden" id="EventStartDay" name="EventStartDay">
        <input type="hidden" id="EventEndYear" name="EventEndYear"><input type="hidden" id="EventEndMonth" name="EventEndMonth"><input type="hidden" id="EventEndDay" name="EventEndDay">
        
        <div class="form-actions">
            <a href="list_events.asp?BusinessID=<%=BusinessID%>" class="btn-back">Back to List</a>
            <input type="submit" value="Save Changes">
        </div>
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
             document.getElementById(yearField).value = 0; document.getElementById(monthField).value = 0; document.getElementById(dayField).value = 0;
        }
    }
    parseDate(document.getElementById('EventStartDate').value, 'EventStartYear', 'EventStartMonth', 'EventStartDay');
    parseDate(document.getElementById('EventEndDate').value, 'EventEndYear', 'EventEndMonth', 'EventEndDay');
});
</script>

</body>
</html>
<%
Set cmd = Nothing
If IsObject(rsEventData) Then rsEventData.Close
Set rsEventData = Nothing
If IsObject(rsEventTypes) Then rsEventTypes.Close
Set rsEventTypes = Nothing
%>

<!--#Include virtual="/members/membersFooter.asp"-->
</body></html>

