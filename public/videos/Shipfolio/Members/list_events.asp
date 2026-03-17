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

Dim cmd, rsEvents, strSQL, strMessage, action
Dim BusinessID, EventID_to_delete, strFormattedDate

' --- 1. Get and Validate BusinessID ---
BusinessID = Request.QueryString("BusinessID")
If BusinessID = "" Or Not IsNumeric(BusinessID) Then
    Response.Write "<p class='error-message'>A valid BusinessID is required to view this page.</p>"
    Response.End
End If


' --- 2. Handle Actions (like Delete) ---
action = Request.QueryString("action")

If LCase(action) = "delete" Then
    EventID_to_delete = Request.QueryString("EventID")
    If EventID_to_delete <> "" And IsNumeric(EventID_to_delete) Then
        
        ' Create a universally accepted SQL date/time format: YYYY-MM-DD HH:MI:SS
        strFormattedDate = Year(Now()) & "-" & Right("0" & Month(Now()), 2) & "-" & Right("0" & Day(Now()), 2) & " " & Right("0" & Hour(Now()), 2) & ":" & Right("0" & Minute(Now()), 2) & ":" & Right("0" & Second(Now()), 2)

        ' Perform a "soft delete" by updating the Deleted flag and DeletedDate
        ' CRITICAL: Also check the BusinessID to ensure a user can only delete their own events.
        strSQL = "UPDATE Event SET Deleted = ?, DeletedDate = ? WHERE EventID = ? AND BusinessID = ?"
        
        Set cmd = Server.CreateObject("ADODB.Command")
        cmd.ActiveConnection = conn
        cmd.CommandText = strSQL
        
        ' ADO Numeric Constants
        Const adInteger = 3
        Const adVarChar = 200

        cmd.Parameters.Append cmd.CreateParameter("@Deleted", adInteger, 1, , 1) ' 1 for True
        cmd.Parameters.Append cmd.CreateParameter("@DeletedDate", adVarChar, 1, 20, strFormattedDate)
        cmd.Parameters.Append cmd.CreateParameter("@EventID", adInteger, 1, , CInt(EventID_to_delete))
        cmd.Parameters.Append cmd.CreateParameter("@BusinessID", adInteger, 1, , CInt(BusinessID))
        
        On Error Resume Next
        cmd.Execute
        If Err.Number = 0 Then
            strMessage = "<p class='success-message'>Event successfully deleted.</p>"
        Else
            strMessage = "<p class='error-message'>Error deleting event: " & Err.Description & "</p>"
        End If
        On Error GoTo 0
        
        Set cmd = Nothing
    End If
End If


' --- 3. Retrieve Event List for Display ---
' ✅ FIX: Changed INNER JOIN to LEFT JOIN to show events even with broken location links.
strSQL = "SELECT E.EventID, E.EventName, E.EventStartYear, E.EventStartMonth, E.EventStartDay, EL.EventLocationName " & _
         "FROM Event AS E LEFT JOIN eventlocation AS EL ON E.EventLocationID = EL.EventLocationID " & _
         "WHERE E.BusinessID = ? AND E.Deleted = 0 " & _
         "ORDER BY E.EventStartYear DESC, E.EventStartMonth DESC, E.EventStartDay DESC"
'response.write("strSQL=" & strSQL)
Set cmd = Server.CreateObject("ADODB.Command")
cmd.ActiveConnection = conn
cmd.CommandText = strSQL
cmd.Parameters.Append cmd.CreateParameter("@BusinessID", 3, 1, , CInt(BusinessID)) ' 3 = adInteger, 1 = adParamInput

Set rsEvents = cmd.Execute

%>
    <style>
        body { font-family: sans-serif; background-color: #f4f4f9; }
        h2 { border-bottom: 2px solid #eee; padding-bottom: 10px; }
        .action-bar { margin-bottom: 20px; text-align: right; }
        .events-table { width: 100%; border-collapse: collapse; }
        .events-table th, .events-table td { padding: 12px; border-bottom: 1px solid #ddd; text-align: left; }
        .events-table th { background-color: #f8f8f8; }
        .events-table tr:hover { background-color: #f1f1f1; }
        .no-events { text-align: center; padding: 40px; color: #777; font-size: 1.2em; }
        .success-message, .error-message { padding: 10px; margin-bottom: 15px; border-radius: 3px; }
        .success-message { color: green; border: 1px solid green; background-color: #f0fff0; }
        .error-message { color: red; border: 1px solid red; background-color: #fff0f0; }
    </style>
</head>
<body>

<div class="container">
    <h2><img src="/icons/Assoc-events-icon.svg" width="40px"> Your Event Listings</h2>

    <div class="action-bar">
        <a href="add_event_form.asp?BusinessID=<%=BusinessID%>"> <img src="/icons/Add.png" width="40px"></a>
    </div>

    <% If Not IsEmpty(strMessage) Then Response.Write(strMessage) %>

    <% If rsEvents.EOF Then %>
        <div class="no-events">
            You have no active events. Click "Add New Event" to get started!
        </div>
    <% Else %>
        <table class="events-table">
            <thead>
                <tr>
                    <th>Event Name</th>
                    <th>Date</th>
                    <th>Location</th>
                    <th style="text-align:center;">Actions</th>
                </tr>
            </thead>
            <tbody>
            <% Do While Not rsEvents.EOF %>
                <tr>
                    <td> <a href="edit_event.asp?EventID=<%=rsEvents("EventID")%>" ><%=Server.HTMLEncode(rsEvents("EventName"))%></a></td>
                    <td><%=rsEvents("EventStartMonth") & "/" & rsEvents("EventStartDay") & "/" & rsEvents("EventStartYear")%></td>
                    <td><% if len(rsEvents("EventLocationName")) > 0 then %>
                        <%=Server.HTMLEncode(rsEvents("EventLocationName"))%>
                    <% end if %>
                    </td>
                    <td style="text-align:center;">
                        <a href="edit_event.asp?EventID=<%=rsEvents("EventID")%>" ><img src="/icons/Edit.png" width="40px"></a> |
                        <a href="list_events.asp?BusinessID=<%=BusinessID%>&action=delete&EventID=<%=rsEvents("EventID")%>" onclick="return confirm('Are you sure you want to delete this event?');">
                            <img src="/icons/Delete.png" width="40px">
                        </a>
                    </td>
                </tr>
            <% 
                rsEvents.MoveNext
            Loop 
            %>
            </tbody>
        </table>
    <% End If %>
    </div>
<%
' --- 4. Clean up objects ---
rsEvents.Close
Set rsEvents = Nothing
Set cmd = Nothing
%>

<!--#Include virtual="/members/membersFooter.asp"-->
</body></html>

