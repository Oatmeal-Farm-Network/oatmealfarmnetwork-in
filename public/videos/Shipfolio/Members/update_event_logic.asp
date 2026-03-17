<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <% MasterDashboard= True %>
    <!--#Include virtual="/Members/Membersglobalvariables.asp"-->



<%

' --- Helper Functions ---
Function Sanitize(strInput)
    If IsNull(strInput) Or strInput = "" Then Sanitize = "" Else Sanitize = Replace(CStr(strInput), "'", "''") End If
End Function
Function ToLong(val)
    If IsNumeric(val) And val <> "" Then ToLong = CLng(val) Else ToLong = 0 End If
End Function

' --- Declare all variables ---
Dim EventID, AddressID, WebsiteID, EventLocationID, PhoneID
Dim EventName, EventTypeID, EventDescription, EventContactEmail, EventLocationName, Website, Phone, Cellphone
Dim AddressStreet, AddressCity, StateIndex, AddressZip, country_id
Dim sql, redirectURL, errorMessage, i, scheduleCounter, scheduleId, scheduleDate, scheduleStartTime, scheduleEndTime
Dim firstDate, lastDate, firstStartTime, lastEndTime, deletedSchedules

' --- Get Key IDs from QueryString and Form ---
EventID = ToLong(Request.QueryString("EventID"))
AddressID = ToLong(Request.Form("AddressID"))
WebsiteID = ToLong(Request.Form("WebsiteID"))
EventLocationID = ToLong(Request.Form("EventLocationID"))
' FIX: Retrieve the PhoneID from the hidden form field
PhoneID = ToLong(Request.Form("PhoneID"))

If EventID = 0 Or AddressID = 0 Or WebsiteID = 0 Or EventLocationID = 0 Then
    Response.Redirect "edit_event.asp?EventID=" & EventID & "&status=error&msg=" & Server.URLEncode("Critical IDs are missing. Cannot update.")
End If

' --- Get all main form data and sanitize it ---
EventName = Sanitize(Request.Form("EventName"))
EventTypeID = Sanitize(Request.Form("EventTypeID"))
EventDescription = Sanitize(Request.Form("EventDescription"))
EventContactEmail = Sanitize(Request.Form("EventContactEmail"))
EventLocationName = Sanitize(Request.Form("EventLocationName"))
AddressStreet = Sanitize(Request.Form("AddressStreet"))
AddressCity = Sanitize(Request.Form("AddressCity"))
StateIndex = Sanitize(Request.Form("StateIndex"))
AddressZip = Sanitize(Request.Form("AddressZip"))
country_id = Sanitize(Request.Form("country_id"))
Website = Sanitize(Request.Form("Website"))
Phone = Sanitize(Request.Form("Phone"))
' FIX: Retrieve Cellphone from the form
Cellphone = Sanitize(Request.Form("Cellphone"))
scheduleCounter = ToLong(Request.Form("scheduleCounter"))
deletedSchedules = Request.Form("deletedSchedules")

' --- Begin Database Transaction ---
On Error Resume Next
conn.BeginTrans

' --- Step 1: Update Address table ---
sql = "UPDATE Address SET " & _
      "AddressStreet = '" & AddressStreet & "', " & _
      "AddressCity = '" & AddressCity & "', " & _
      "StateIndex = " & StateIndex & ", " & _
      "country_id = " & country_id & ", " & _
      "AddressZip = '" & AddressZip & "' " & _
      "WHERE AddressID = " & AddressID
response.write("sql=" & sql)

conn.Execute sql, , 128


' --- Step 2: Update Websites table ---
sql = "UPDATE Websites SET Website = '" & Website & "' WHERE WebsitesID = " & WebsiteID
response.write("sql=" & sql)
conn.Execute sql, , 128


' --- Step 3: Update EventLocation and Phone tables ---
' Update EventLocationName in the EventLocation table
sql = "UPDATE EventLocation SET EventLocationName = '" & EventLocationName & "' WHERE EventLocationID = " & EventLocationID
response.write("<br><br>sql=" & sql)
conn.Execute sql, , 128


' Update the separate Phone table using the PhoneID
If PhoneID > 0 Then
    sql = "UPDATE Phone SET Phone = '" & Phone & "', Cellphone = '" & Cellphone & "' WHERE PhoneID = " & PhoneID
    response.write("sql=" & sql)
    conn.Execute sql, , 128
End If


' --- Step 4: Process Schedule Entries ---
' --- First, handle deletions ---
If Len(deletedSchedules) > 0 Then
    ' Sanitize to ensure it's a comma-separated list of numbers
    Dim safeDeletedList: safeDeletedList = ""
    Dim item: For Each item In Split(deletedSchedules, ",")
        If IsNumeric(item) Then
            If Len(safeDeletedList) > 0 Then safeDeletedList = safeDeletedList & ","
            safeDeletedList = safeDeletedList & CLng(item)
        End If
    Next
    If Len(safeDeletedList) > 0 Then
        sql = "DELETE FROM eventschedule WHERE EventID = " & EventID & " AND EventScheduleID IN (" & safeDeletedList & ")"
        response.write("sql=" & sql)
        conn.Execute sql, , 128

    End If
End If

' --- Next, handle inserts and updates ---
For i = 1 To scheduleCounter
    scheduleId = ToLong(Request.Form("schedule_id_" & i))
    scheduleDate = Request.Form("schedule_date_" & i)
    scheduleStartTime = Request.Form("schedule_start_time_" & i)
    scheduleEndTime = Request.Form("schedule_end_time_" & i)

    If IsDate(scheduleDate) Then
        Dim sYear, sMonth, sDay, sStartHour, sStartMin, sEndHour, sEndMin
        sYear = Year(scheduleDate) : sMonth = Month(scheduleDate) : sDay = Day(scheduleDate)
        sStartHour = 0 : sStartMin = 0 : sEndHour = 0 : sEndMin = 0
        If InStr(scheduleStartTime, ":") > 0 Then Dim startTimeParts: startTimeParts = Split(scheduleStartTime, ":"): sStartHour = ToLong(startTimeParts(0)) : sStartMin = ToLong(startTimeParts(1)) End If
        If InStr(scheduleEndTime, ":") > 0 Then Dim endTimeParts: endTimeParts = Split(scheduleEndTime, ":"): sEndHour = ToLong(endTimeParts(0)) : sEndMin = ToLong(endTimeParts(1)) End If

        If scheduleId > 0 Then ' This is an existing record, so UPDATE it
            sql = "UPDATE eventschedule SET " & _
                  "ScheduleDateMonth = " & sMonth & ", ScheduleDateDay = " & sDay & ", ScheduleDateYear = " & sYear & ", " & _
                  "ScheduleStartTimeHour = " & sStartHour & ", ScheduleStartTimeMinute = " & sStartMin & ", " & _
                  "ScheduleEndTimeHour = " & sEndHour & ", ScheduleEndTimeMinute = " & sEndMin & " " & _
                  "WHERE EventScheduleID = " & scheduleId
        Else ' This is a new record (scheduleId=0), so INSERT it
            sql = "INSERT INTO eventschedule (EventID, ScheduleDateMonth, ScheduleDateDay, ScheduleDateYear, " & _
                  "ScheduleStartTimeHour, ScheduleStartTimeMinute, ScheduleEndTimeHour, ScheduleEndTimeMinute) " & _
                  "VALUES (" & EventID & ", " & sMonth & ", " & sDay & ", " & sYear & ", " & _
                  sStartHour & ", " & sStartMin & ", " & sEndHour & ", " & sEndMin & ");"
        End If
        response.write("sql=" & sql)
        conn.Execute sql, , 128
    End If
Next

' --- Step 5: Update the main Event table ---
' --- We do this last, after all schedule changes are processed ---
Dim rsDates: Set rsDates = conn.Execute("SELECT MIN(CAST(CAST(ScheduleDateYear AS VARCHAR) + '-' + CAST(ScheduleDateMonth AS VARCHAR) + '-' + CAST(ScheduleDateDay AS VARCHAR) AS DATE)) AS MinDate, MAX(CAST(CAST(ScheduleDateYear AS VARCHAR) + '-' + CAST(ScheduleDateMonth AS VARCHAR) + '-' + CAST(ScheduleDateDay AS VARCHAR) AS DATE)) AS MaxDate FROM eventschedule WHERE EventID = " & EventID)
If Not rsDates.EOF Then
    firstDate = rsDates("MinDate")
    lastDate = rsDates("MaxDate")
End If
rsDates.Close

Dim EventStartYear, EventStartMonth, EventStartDay, EventEndYear, EventEndMonth, EventEndDay
If IsDate(firstDate) Then EventStartYear = Year(firstDate) : EventStartMonth = Month(firstDate) : EventStartDay = Day(firstDate) Else EventStartYear = 0: EventStartMonth = 0: EventStartDay = 0 End If
If IsDate(lastDate) Then EventEndYear = Year(lastDate) : EventEndMonth = Month(lastDate) : EventEndDay = Day(lastDate) Else EventEndYear = 0: EventEndMonth = 0: EventEndDay = 0 End If

sql = "UPDATE Event SET " & _
      "EventName = '" & EventName & "', " & _
      "EventTypeID = " & EventTypeID & ", " & _
      "EventDescription = '" & EventDescription & "', " & _
      "EventContactEmail = '" & EventContactEmail & "', " & _
      "EventStartMonth = " & EventStartMonth & ", EventStartDay = " & EventStartDay & ", EventStartYear = " & EventStartYear & ", " & _
      "EventEndMonth = " & EventEndMonth & ", EventEndDay = " & EventEndDay & ", EventEndYear = " & EventEndYear & " " & _
      "WHERE EventID = " & EventID
      edit_event.asp
      update_event_logic.asp
      conn.Execute sql, , 128


' --- If we get here, all is well. Commit the transaction. ---
conn.CommitTrans
redirectURL = "edit_event.asp?EventID=" & EventID & "&status=success"
'GoTo CleanupAndRedirect

' --- Error handling block ---
HandleError:
conn.RollbackTrans
redirectURL = "edit_event.asp?EventID=" & EventID 
Response.Redirect redirectURL


' --- Final cleanup and redirect ---
CleanupAndRedirect:
'On Error GoTo 0
Set conn = Nothing
Response.Redirect redirectURL
%>



<!--#Include virtual="/members/membersFooter.asp"-->
</body></html>

