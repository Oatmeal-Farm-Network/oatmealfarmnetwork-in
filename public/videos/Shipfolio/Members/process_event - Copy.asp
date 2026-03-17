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

' --- Function to sanitize string inputs to help prevent SQL injection ---
Function Sanitize(strInput)
    If IsNull(strInput) Or strInput = "" Then
        Sanitize = ""
    Else
        Sanitize = Replace(CStr(strInput), "'", "''")
    End If
End Function

Function ToLong(val)
    If IsNumeric(val) And val <> "" Then ToLong = CLng(val) Else ToLong = 0 End If
End Function

' --- Declare all variables ---
Dim BusinessID, PeopleID, AssociationID, EventName, EventTypeID, EventDescription, EventContactEmail
Dim EventLocationName, AddressStreet, AddressCity, StateIndex, AddressZip, country_id, Website, Phone
Dim newAddressID, newWebsiteID, newEventLocationID, newEventID, sql, rs, redirectURL, i, scheduleCounter
Dim firstDate, lastDate, firstStartTime, lastEndTime, scheduleDate, scheduleStartTime, scheduleEndTime
Dim errorMessage

' --- Get required IDs from QueryString and Session ---
BusinessID = Request.QueryString("BusinessID")
PeopleID = Session("PeopleID") ' Assumes the user is logged in and PeopleID is in session

If Not IsNumeric(BusinessID) Or BusinessID = "" Then
    Response.Redirect "add_event.asp?status=error&msg=" & Server.URLEncode("Invalid Business ID provided.")
End If
If Not IsNumeric(PeopleID) Or PeopleID = "" Then
    Response.Redirect "add_event.asp?status=error&msg=" & Server.URLEncode("User session has expired. Please log in again.")
End If


' --- Get all main form data and sanitize it ---
EventName         = Sanitize(Request.Form("EventName"))
EventTypeID       = Sanitize(Request.Form("EventTypeID"))
EventDescription  = Sanitize(Request.Form("EventDescription"))
EventContactEmail = Sanitize(Request.Form("EventContactEmail"))
EventLocationName = Sanitize(Request.Form("EventLocationName"))
AddressStreet     = Sanitize(Request.Form("AddressStreet"))
AddressCity       = Sanitize(Request.Form("AddressCity"))
StateIndex        = Sanitize(Request.Form("StateIndex"))
AddressZip        = Sanitize(Request.Form("AddressZip"))
country_id        = Sanitize(Request.Form("country_id"))
Website           = Sanitize(Request.Form("Website"))
EventPhone             = Sanitize(Request.Form("EventPhone"))
scheduleCounter   = ToLong(Request.Form("scheduleCounter"))

' --- Server-side validation ---
If EventName = "" Or EventTypeID = "" Or AddressStreet = "" Or scheduleCounter = 0 Then
    Response.Redirect "add_event.asp?status=error&msg=" & Server.URLEncode("Required fields (Event Name, Type, Address, Schedule) are missing.")
End If

' --- Determine the main Event Start/End dates from the first and last schedule entries ---
firstDate = Request.Form("schedule_date_1")
lastDate = Request.Form("schedule_date_" & scheduleCounter)
firstStartTime = Request.Form("schedule_start_time_1")
lastEndTime = Request.Form("schedule_end_time_" & scheduleCounter)

' --- Begin Database Transaction ---
conn.BeginTrans

' --- Step 1: Insert into Address table ---
sql = "INSERT INTO Address (AddressStreet, AddressCity, StateIndex, country_id, AddressZip) " & _
      "VALUES ( '" & AddressStreet & "', '" & AddressCity & "', " & StateIndex & ", " & country_id & ", '" & AddressZip & "');"


conn.Execute sql, , 128

Set rs = conn.Execute("SELECT @@IDENTITY;")
newAddressID = rs(0)
rs.Close


sql = "INSERT INTO Phone (Phone) VALUES ('" & EventPhone & "');"
response.write("sql=" & sql) 
conn.Execute sql, , 128



sql = "select * from Phone where Phone = '" & EventPhone & "' order by PhoneID Desc"
response.write(sql)
Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	If Not rs.eof Then
        NewPhoneID = rs("PhoneID")
	End If 
rs.close




sql = "INSERT INTO Websites (Website) VALUES ('" & Website & "');"
response.write("sql=" & sql) 
conn.Execute sql, , 128

Set rs = conn.Execute("SELECT SCOPE_IDENTITY();") ' FIX: Using SCOPE_IDENTITY()
newWebsiteID = rs(0)
rs.Close

sql = "select * from Websites where Website = '" & Website & "' order by WebsitesID Desc"
'response.write(sql)
Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	If Not rs.eof Then
    newWebsiteID = rs("WebsitesID")
	End If 
rs.close


sql = "INSERT INTO EventLocation (EventLocationName, AddressID, WebsiteID, PhoneID) " & _
      "VALUES ('" & EventLocationName & "', " & newAddressID & ", " & newWebsiteID & ", '" & NewPhoneID & "');"
 response.write("sql=" & sql) 
conn.Execute sql, , 128

sql = "select * from EventLocation where EventLocationName = '" & EventLocationName & "' order by EventLocationID Desc"
'response.write(sql)
Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	If Not rs.eof Then
    newEventLocationID = rs("EventLocationID")
	End If 
rs.close

' --- Step 4: Insert into Event table ---
Dim EventStartYear, EventStartMonth, EventStartDay, EventEndYear, EventEndMonth, EventEndDay
If IsDate(firstDate) Then
    EventStartYear = Year(firstDate) : EventStartMonth = Month(firstDate) : EventStartDay = Day(firstDate)
Else
    EventStartYear = 0: EventStartMonth = 0: EventStartDay = 0
End If
If IsDate(lastDate) Then
    EventEndYear = Year(lastDate) : EventEndMonth = Month(lastDate) : EventEndDay = Day(lastDate)
Else
    EventEndYear = 0: EventEndMonth = 0: EventEndDay = 0
End If

sql = "INSERT INTO Event (PeopleID,  EventName, EventTypeID, AddressID, WebsiteID, EventLocationID, BusinessID, " & _
      "PublishedDate, EventStartMonth, EventStartDay, EventStartYear, EventEndMonth, EventEndDay, EventEndYear, " & _
      "EventDescription, EventContactEmail, EventStartTime, EventEndTime, EventStatus, Deleted) " & _
      "VALUES (" & PeopleID & ", '" & EventName & "', " & EventTypeID & ", " & newAddressID & ", " & newWebsiteID & ", " & newEventLocationID & ", " & BusinessID & ", " & _
      "GETDATE(), " & EventStartMonth & ", " & EventStartDay & ", " & EventStartYear & ", " & EventEndMonth & ", " & EventEndDay & ", " & EventEndYear & ", " & _
      "'" & EventDescription & "', '" & EventContactEmail & "', '" & Sanitize(firstStartTime) & "', '" & Sanitize(lastEndTime) & "', 'Active', 0);"

      response.write("<br><br>sql=" & sql) 
conn.Execute sql, , 128

Set rs = conn.Execute("SELECT @@IDENTITY;")
newEventID = rs(0)
rs.Close

' --- Step 5: Loop through schedule entries and insert into eventschedule table ---
For i = 1 To scheduleCounter
    scheduleDate = Request.Form("schedule_date_" & i)
    scheduleStartTime = Request.Form("schedule_start_time_" & i)
    scheduleEndTime = Request.Form("schedule_end_time_" & i)

    If IsDate(scheduleDate) Then
        Dim sYear, sMonth, sDay, sStartHour, sStartMin, sEndHour, sEndMin
        sYear = Year(scheduleDate) : sMonth = Month(scheduleDate) : sDay = Day(scheduleDate)
        sStartHour = 0 : sStartMin = 0 : sEndHour = 0 : sEndMin = 0

        If InStr(scheduleStartTime, ":") > 0 Then
            Dim startTimeParts: startTimeParts = Split(scheduleStartTime, ":")
            sStartHour = ToLong(startTimeParts(0)) : sStartMin = ToLong(startTimeParts(1))
        End If
        
        If InStr(scheduleEndTime, ":") > 0 Then
            Dim endTimeParts: endTimeParts = Split(scheduleEndTime, ":")
            sEndHour = ToLong(endTimeParts(0)) : sEndMin = ToLong(endTimeParts(1))
        End If

        sql = "INSERT INTO eventschedule (EventID, ScheduleDateMonth, ScheduleDateDay, ScheduleDateYear, " & _
              "ScheduleStartTimeHour, ScheduleStartTimeMinute, ScheduleEndTimeHour, ScheduleEndTimeMinute) " & _
              "VALUES (" & newEventID & ", " & sMonth & ", " & sDay & ", " & sYear & ", " & _
              sStartHour & ", " & sStartMin & ", " & sEndHour & ", " & sEndMin & ");"

              response.write("sql=" & sql) 
              conn.Execute sql, , 128

    End If
Next

' --- If we get here, all is well. Commit the transaction. ---
conn.CommitTrans
redirectURL = "list_events.asp&BusinessID=" & BusinessID


redirectURL = "list_events.asp?BusinessID=" & BusinessID
Response.Redirect redirectURL
Set rs = Nothing
Set conn = Nothing

%>



<!--#Include virtual="/members/membersFooter.asp"-->
</body></html>

