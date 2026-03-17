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
Function ToLong(val)
    If IsNumeric(val) And val <> "" Then
        ToLong = CLng(val)
    Else
        ToLong = 0
    End If
End Function

Dim cmd
Dim BusinessID, strMessage

' --- Make sure this page was called from a POST request ---
If Request.ServerVariables("REQUEST_METHOD") <> "POST" Then
    Response.Write("This page cannot be accessed directly.")
    Response.End
End If

On Error Resume Next

BusinessID = Request.QueryString("BusinessID")
strMessage = ""

Set cmd = Server.CreateObject("ADODB.Command")
cmd.ActiveConnection = conn
cmd.CommandText = "dbo.usp_CreateNewEvent" ' The name of the stored procedure
cmd.CommandType = adCmdStoredProc ' Tell ADO this is a stored procedure

' ADO Numeric Constants
Const adVarChar = 200
Const adInteger = 3
Const adParamInput = 1
Const adParamOutput = 2
Const adVarWChar = 202 

' ✅ FIX: Using the ToLong() helper function for all numeric fields to prevent errors.
cmd.Parameters.Append cmd.CreateParameter("@BusinessID", adInteger, adParamInput, , ToLong(BusinessID))
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
cmd.Parameters.Append cmd.CreateParameter("@Fax", adVarChar, adParamInput, 50, Request.Form("Fax"))
cmd.Parameters.Append cmd.CreateParameter("@AddressStreet", adVarChar, adParamInput, 255, Request.Form("AddressStreet"))
cmd.Parameters.Append cmd.CreateParameter("@AddressCity", adVarChar, adParamInput, 100, Request.Form("AddressCity"))
cmd.Parameters.Append cmd.CreateParameter("@AddressState", adVarChar, adParamInput, 50, Request.Form("AddressState"))
cmd.Parameters.Append cmd.CreateParameter("@AddressZip", adVarChar, adParamInput, 20, Request.Form("AddressZip"))
cmd.Parameters.Append cmd.CreateParameter("@AddressCountry", adVarChar, adParamInput, 100, Request.Form("AddressCountry"))

' Setup the OUTPUT parameter to get the new EventID back from the stored procedure
cmd.Parameters.Append cmd.CreateParameter("@NewEventID", adInteger, adParamOutput)

' Execute the stored procedure
cmd.Execute

' Check for script errors and see if we got a valid ID back
If Err.Number = 0 AND CLng(cmd.Parameters("@NewEventID").Value) > 0 Then
    ' Success
Else
    ' If there was an error, capture it for the redirect message.
    If Err.Number <> 0 Then
       ' strMessage = "A script error occurred: " & Err.Description
    Else
        strMessage = "An unknown error occurred in the database. The operation was rolled back."
    End If
End If

Set cmd = Nothing

'--- Finalize and Redirect ---
If strMessage = "" Then
   Response.Redirect "add_event_form.asp?BusinessID=" & BusinessID & "&status=success"
Else
    Response.Redirect "add_event_form.asp?BusinessID=" & BusinessID & "&status=error&msg=" & Server.URLEncode(strMessage)
End If

%>


<!--#Include virtual="/members/membersFooter.asp"-->
</body></html>

