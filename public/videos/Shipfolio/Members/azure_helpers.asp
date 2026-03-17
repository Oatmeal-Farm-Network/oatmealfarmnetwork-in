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
' --- Helper Functions ---
Function ToLong(val)
    If IsNumeric(val) And val <> "" Then ToLong = CLng(val) Else ToLong = 0 End If
End Function
Function FormatDate(yr, mo, da)
    If ToLong(yr) > 0 And ToLong(mo) > 0 And ToLong(da) > 0 Then FormatDate = yr & "-" & Right("0" & mo, 2) & "-" & Right("0" & da, 2) Else FormatDate = "" End If
End Function
Function FormatTime(hr, min)
    If hr <> "" And min <> "" Then FormatTime = Right("0" & hr, 2) & ":" & Right("0" & min, 2) Else FormatTime = "" End If
End Function
Function Encode(val)
    If IsNull(val) Then Encode = "" Else Encode = Server.HTMLEncode(val) End If
End Function

' --- Variable Declarations ---
Dim EventID, BusinessID, strMessage, status, msg, sql, rsEvent, rsEventTypes, rsSchedule, rsCountry, rsWebsite
Dim userCountryID, userStateID, statesJson, jsObject

' --- Get EventID and check for status messages ---
EventID = ToLong(Request.QueryString("EventID"))
If EventID = 0 Then Response.End ' A valid EventID is required.

status = Request.QueryString("status")
If status = "success" Then
    strMessage = "<p class='success-message'>✅ Event updated successfully!</p>"
ElseIf status = "error" Then
    msg = Request.QueryString("msg")
    strMessage = "<p class='error-message'>Error: " & Encode(msg) & "</p>"
End If

' --- Fetch Main Event Data ---
' FIX: This query now correctly joins the Phone table to get all details.
sql = "SELECT e.*, el.EventLocationName, el.PhoneID, a.AddressStreet, a.AddressCity, a.StateIndex, a.country_id, a.AddressZip, e.Websiteid, p.Phone, p.Cellphone " & _
      "FROM Event e " & _
      "LEFT JOIN EventLocation el ON e.EventLocationID = el.EventLocationID " & _
      "LEFT JOIN Address a ON e.AddressID = a.AddressID " & _
      "LEFT JOIN Phone p ON el.PhoneID = p.PhoneID " & _
      "WHERE e.EventID = " & EventID
'response.write("sql=" & sql)

Set rsEvent = conn.Execute(sql)

Websiteid = rsEvent("Websiteid")


sql = "SELECT Website from Websites WHERE WebsitesID = " & WebsiteID
'response.write("sql=" & sql)

Set rsWebsite = conn.Execute(sql)
EventWebsite = rsWebsite("Website")


If rsEvent.EOF Then Response.End ' Event not found.

userCountryID = rsEvent("country_id")
userStateID = rsEvent("StateIndex")
BusinessID = rsEvent("BusinessID")

' --- Pre-load all states/provinces for the dynamic dropdown ---
Set statesJson = Server.CreateObject("Scripting.Dictionary")
sql = "SELECT StateIndex, name, country_id FROM state_province ORDER BY country_id, name"
Dim stateRs: Set stateRs = conn.Execute(sql)
If Not stateRs.EOF Then
    Dim countryIdForLoop: countryIdForLoop = stateRs("country_id")
    Do While Not stateRs.EOF
        If Not statesJson.Exists(countryIdForLoop) Then statesJson.Add countryIdForLoop, "" End If
        Dim stateString: stateString = "{""id"":" & stateRs("StateIndex") & ",""name"":""" & Replace(stateRs("name"), """", "\""") & """}"
        If Len(statesJson(countryIdForLoop)) > 0 Then statesJson(countryIdForLoop) = statesJson(countryIdForLoop) & "," & stateString Else statesJson(countryIdForLoop) = stateString End If
        stateRs.MoveNext
        If Not stateRs.EOF Then countryIdForLoop = stateRs("country_id") End If
    Loop
End If
stateRs.Close
jsObject = "{"
Dim firstCountry: firstCountry = True
Dim key: For Each key In statesJson.Keys
    If Not firstCountry Then jsObject = jsObject & "," End If
    jsObject = jsObject & """" & key & """:[" & statesJson(key) & "]"
    firstCountry = False
Next
jsObject = jsObject & "}"
%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Event</title>
    <style>
        body { font-family: sans-serif; } .container { max-width: 800px; margin: auto; padding: 20px; } .form-group { margin-bottom: 15px; } fieldset { border: 1px solid #ddd; padding: 15px; margin-bottom: 20px; border-radius: 4px; } legend { font-weight: bold; font-size: 1.2em; padding: 0 10px; } label { display: block; margin-bottom: 5px; font-weight: bold; } input[type="text"], input[type="date"], input[type="time"], input[type="url"], input[type="email"], textarea, select { width: 100%; padding: 8px; border: 1px solid #ccc; border-radius: 3px; box-sizing: border-box; text-align: left; } input[type="submit"], .btn { background-color: #4CAF50; color: white; padding: 12px 20px; border: none; border-radius: 3px; cursor: pointer; font-size: 16px; text-decoration: none; display: inline-block; } .btn-remove { background-color: #f44336; margin-left: 10px; padding: 8px 12px; font-size: 14px; } .success-message { color: green; border: 1px solid green; padding: 10px; margin-bottom: 15px; border-radius: 3px; background-color: #f0fff0; } .error-message { color: red; border: 1px solid red; padding: 10px; margin-bottom: 15px; border-radius: 3px; background-color: #fff0f0; } .grid-2, .grid-3 { display: grid; grid-gap: 15px; } .grid-2 { grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); } .grid-3 { grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); } .schedule-row { display: grid; grid-template-columns: 1fr 1fr 1fr auto; grid-gap: 15px; align-items: flex-end; margin-bottom: 10px; } .form-actions { display: flex; justify-content: space-between; align-items: center; } .btn-back { background-color: #555; }
    </style>
</head>
<body>
<div class="container">
    <h2><img src="/icons/Assoc-events-icon.svg" width="40px" alt="Events Icon"> Edit Event</h2>
    <% If Not IsEmpty(strMessage) Then Response.Write(strMessage) %>
    <form id="eventForm" action="update_event_logic.asp?EventID=<%=EventID%>" method="post">
        <input type="hidden" name="AddressID" value="<%=rsEvent("AddressID")%>">
        <input type="hidden" name="WebsiteID" value="<%=rsEvent("WebsiteID")%>">
        <input type="hidden" name="EventLocationID" value="<%=rsEvent("EventLocationID")%>">
        <input type="hidden" name="PhoneID" value="<%=rsEvent("PhoneID")%>">

        <fieldset><legend>Event Details</legend>
            <div class="form-group"><label for="EventName">Event Name:</label><input type="text" id="EventName" name="EventName" value="<%=Encode(rsEvent("EventName"))%>" required></div>
            <div class="form-group"><label for="EventDescription">Event Description:</label><textarea id="EventDescription" name="EventDescription" rows="5"><%=Encode(rsEvent("EventDescription"))%></textarea></div>
            <div class="grid-2">
                <div class="form-group"><label for="EventTypeID">Event Type:</label>
                    <select id="EventTypeID" name="EventTypeID" required>
                        <option value="">-- Select a Type --</option>
                        <%
                        Set rsEventTypes = conn.Execute("SELECT EventTypeID, EventType FROM eventtypeslookup ORDER BY EventType")
                        Do While Not rsEventTypes.EOF
                            Response.Write "<option value='" & rsEventTypes("EventTypeID") & "'"
                            If CStr(rsEventTypes("EventTypeID")) = CStr(rsEvent("EventTypeID")) Then Response.Write " selected"
                            Response.Write ">" & rsEventTypes("EventType") & "</option>"
                            rsEventTypes.MoveNext
                        Loop
                        %>
                    </select>
                </div>
                <div class="form-group"><label for="EventContactEmail">Public Contact Email:</label><input type="email" id="EventContactEmail" name="EventContactEmail" value="<%=Encode(rsEvent("EventContactEmail"))%>"></div>
            </div>
        </fieldset>

        <fieldset><legend>Event Schedule</legend>
            <div id="scheduleContainer">
            <%
            sql = "SELECT * FROM eventschedule WHERE EventID = " & EventID & " ORDER BY ScheduleDateYear, ScheduleDateMonth, ScheduleDateDay"
            Set rsSchedule = conn.Execute(sql)
            Dim scheduleCount: scheduleCount = 0
            While Not rsSchedule.EOF
                scheduleCount = scheduleCount + 1
            %>
                <div class="schedule-row" id="schedule_row_<%=scheduleCount%>">
                    <input type="hidden" name="schedule_id_<%=scheduleCount%>" value="<%=rsSchedule("EventScheduleID")%>">
                    <div><label for="schedule_date_<%=scheduleCount%>">Date:</label><input type="date" id="schedule_date_<%=scheduleCount%>" name="schedule_date_<%=scheduleCount%>" value="<%=FormatDate(rsSchedule("ScheduleDateYear"), rsSchedule("ScheduleDateMonth"), rsSchedule("ScheduleDateDay"))%>" required></div>
                    <div><label for="schedule_start_time_<%=scheduleCount%>">Start Time:</label><input type="time" id="schedule_start_time_<%=scheduleCount%>" name="schedule_start_time_<%=scheduleCount%>" value="<%=FormatTime(rsSchedule("ScheduleStartTimeHour"), rsSchedule("ScheduleStartTimeMinute"))%>"></div>
                    <div><label for="schedule_end_time_<%=scheduleCount%>">End Time:</label><input type="time" id="schedule_end_time_<%=scheduleCount%>" name="schedule_end_time_<%=scheduleCount%>" value="<%=FormatTime(rsSchedule("ScheduleEndTimeHour"), rsSchedule("ScheduleEndTimeMinute"))%>"></div>
                    <div><button type="button" class="btn btn-remove" data-row-id="<%=scheduleCount%>" data-schedule-id="<%=rsSchedule("EventScheduleID")%>">Remove</button></div>
                </div>
            <%
                rsSchedule.MoveNext
            Wend
            %>
            </div>
            <button type="button" id="addScheduleBtn" class="btn">Add Date</button>
        </fieldset>

        <fieldset><legend>Location</legend>
            <div class="form-group"><label for="EventLocationName">Location Name:</label><input type="text" id="EventLocationName" name="EventLocationName" value="<%=Encode(rsEvent("EventLocationName"))%>" ></div>
            <div class="form-group"><label for="AddressStreet">Street Address:</label><input type="text" id="AddressStreet" name="AddressStreet" value="<%=Encode(rsEvent("AddressStreet"))%>" ></div>
            <div class="grid-3">
                <div class="form-group"><label for="AddressCity">City:</label><input type="text" id="AddressCity" name="AddressCity" value="<%=Encode(rsEvent("AddressCity"))%>" ></div>
                <div class="form-group"><label for="country_id">Country:</label>
                    <select id="country_id" name="country_id" required>
                        <option value="">-- Select Country --</option>
                        <%
                        Set rsCountry = conn.Execute("SELECT country_id, name FROM Country ORDER BY name")


                        While Not rsCountry.EOF
                            Response.Write "<option value='" & rsCountry("country_id") & "'"
                            If CStr(rsCountry("country_id")) = CStr(userCountryID) Then Response.Write " selected"
                            Response.Write ">" & rsCountry("name") & "</option>"
                            rsCountry.MoveNext
                        Wend
                        %>
                    </select>
                </div>
                <div class="form-group"><label for="StateIndex" id="provinceTypeLabel">State / Province:</label><select id="StateIndex" name="StateIndex" required disabled><option value="">-- Select Country First --</option></select></div>
                <div class="form-group"><label for="AddressZip">Zip / Postal Code:</label><input type="text" id="AddressZip" name="AddressZip" value="<%=Encode(rsEvent("AddressZip"))%>" required></div>
            </div>
            <div class="grid-3">
                <div class="form-group"><label for="Website">Event Website URL:</label><input type="url" id="Website" name="Website" value="<%=EventWebsite%>")" placeholder="https://www.example.com"></div>
                <div class="form-group"><label for="Phone">Location Phone:</label><input type="text" id="Phone" name="Phone" value="<%=Encode(rsEvent("Phone"))%>"></div>
                <div class="form-group"><label for="Cellphone">Location Cellphone:</label><input type="text" id="Cellphone" name="Cellphone" value="<%=Encode(rsEvent("Cellphone"))%>"></div>
            </div>
        </fieldset>
        
        <input type="hidden" id="scheduleCounter" name="scheduleCounter" value="<%=scheduleCount%>">
        <input type="hidden" id="deletedSchedules" name="deletedSchedules" value="">
        
        <br>
        <div class="form-actions">
            <a href="some_other_page.asp?BusinessID=<%=BusinessID%>" class="btn btn-back">Back to Events</a>
            <input type="submit" value="Save Changes">
        </div>
    </form>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    var allStatesData = <%= jsObject %>;
    var userStateID = '<%= userStateID %>';
    var countryDropdown = document.getElementById('country_id');
    var stateDropdown = document.getElementById('StateIndex');
    var provinceLabel = document.getElementById('provinceTypeLabel');
    var scheduleContainer = document.getElementById('scheduleContainer');
    var addScheduleBtn = document.getElementById('addScheduleBtn');
    var scheduleCounterInput = document.getElementById('scheduleCounter');
    var deletedSchedulesInput = document.getElementById('deletedSchedules');

    function addScheduleRow() {
        var count = parseInt(scheduleCounterInput.value) + 1;
        scheduleCounterInput.value = count;
        var row = document.createElement('div');
        row.className = 'schedule-row';
        row.id = 'schedule_row_' + count;
        row.innerHTML = `
            <input type="hidden" name="schedule_id_${count}" value="0"> <!-- New rows have ID 0 -->
            <div><label for="schedule_date_${count}">Date:</label><input type="date" name="schedule_date_${count}" required></div>
            <div><label for="schedule_start_time_${count}">Start Time:</label><input type="time" name="schedule_start_time_${count}"></div>
            <div><label for="schedule_end_time_${count}">End Time:</label><input type="time" name="schedule_end_time_${count}"></div>
            <div><button type="button" class="btn btn-remove" data-row-id="${count}" data-schedule-id="0">Remove</button></div>
        `;
        scheduleContainer.appendChild(row);
    }

    addScheduleBtn.addEventListener('click', addScheduleRow);

    scheduleContainer.addEventListener('click', function(e) {
        if (e.target && e.target.classList.contains('btn-remove')) {
            var scheduleId = e.target.getAttribute('data-schedule-id');
            if (scheduleId && scheduleId !== '0') {
                var currentDeleted = deletedSchedulesInput.value;
                deletedSchedulesInput.value = currentDeleted ? currentDeleted + ',' + scheduleId : scheduleId;
            }
            var rowId = e.target.getAttribute('data-row-id');
            document.getElementById('schedule_row_' + rowId).remove();
        }
    });

    function populateStates(countryId, selectedStateId) {
        var countryName = countryDropdown.options[countryDropdown.selectedIndex].text;
        provinceLabel.textContent = (countryName === 'United States') ? 'State' : 'Province';
        stateDropdown.innerHTML = '';
        stateDropdown.disabled = true;
        if (!countryId || !allStatesData[countryId]) {
            stateDropdown.innerHTML = '<option value="">-- Select Country First --</option>';
            return;
        }
        var selectOption = document.createElement('option');
        selectOption.value = '';
        selectOption.textContent = '-- Select ' + provinceLabel.textContent + ' --';
        stateDropdown.appendChild(selectOption);
        allStatesData[countryId].forEach(function(state) {
            var option = document.createElement('option');
            option.value = state.id;
            option.textContent = state.name;
            if (state.id.toString() === selectedStateId) {
                option.selected = true;
            }
            stateDropdown.appendChild(option);
        });
        stateDropdown.disabled = false;
    }

    countryDropdown.addEventListener('change', function() {
        populateStates(this.value, ''); // No pre-selected state on change
    });

    // Initial population on page load
    if (countryDropdown.value) {
        populateStates(countryDropdown.value, userStateID);
    }
});
</script>

<%
rsEvent.Close
rsEventTypes.Close
rsSchedule.Close
rsCountry.Close
Set rsEvent = Nothing
Set rsEventTypes = Nothing
Set rsSchedule = Nothing
Set rsCountry = Nothing
Set stateRs = Nothing
Set statesJson = Nothing
%>


<!--#Include virtual="/members/membersFooter.asp"-->
</body></html>

