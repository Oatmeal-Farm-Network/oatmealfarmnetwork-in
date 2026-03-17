<!DOCTYPE html><html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<HEAD>
</HEAD>
<BODY bgcolor = "white">
<!--#Include file="AdminGlobalVariables.asp"-->
<%
dim EventsDateMonth1
dim EventsDateDay1
dim EventsDateYear1
dim EventsDateWeekday1
dim EventsEndDateMonth1
dim EventsEndDateDay1
dim EventsEndDateYear1
dim EventsEndDateWeekday1
dim EventsTime1
dim EventsPrice1
dim EventsTitle1
dim EventsText1
dim Events1
dim EventsDescription1
dim EventsCatID1

EventsURL = request.Form("EventsURL")
EventsStartDateMonth1=Request.Form("EventsStartDateMonth" ) 
EventsStartDateDay1=Request.Form("EventsStartDateDay" ) 
EventsStartDateYear1=Request.Form("EventsStartDateYear" ) 
EventsStartDateWeekday1=Request.Form("EventsStartDateWeekday" ) 
EventsEndDateMonth1=Request.Form("EventsEndDateMonth" ) 
EventsEndDateDay1=Request.Form("EventsEndDateDay" ) 
EventsEndDateYear1=Request.Form("EventsEndDateYear" ) 
EventsEndDateWeekday1=Request.Form("EventsEndDateWeekday" ) 
EventsTime1=Request.Form("EventsTime" ) 
EventsPrice1=Request.Form("EventsPrice" ) 
EventsTitle1=Request.Form("EventsTitle" ) 
Events1=Request.Form("Events" ) 
EventsDescription1=Request.Form( "EventsDescription" ) 
EventsCatID1=Request.Form( "CatID" ) 

str1 = EventsTitle1
str2 = "'"
If InStr(str1,str2) > 0 Then
	EventsTitle1= Replace(str1, "'", "''")
End If

str1 = EventsDescription1
str2 = "'"
If InStr(str1,str2) > 0 Then
	EventsDescription1= Replace(str1, "'", "''")
End If

If Len(EventsCatID1)<1 Then
	EventsCatID1 = 8
End if

if len(EventsStartDateMonth1) > 0 then
else
EventsStartDateMonth1 = 0
end if

if len(EventsStartDateDay1) > 0 then
else
EventsStartDateDay1 = 0
end if

if len(EventsStartDateYear1) > 0 then
else
EventsStartDateYear1 = 0
end if

if len(EventsEndDateMonth1) > 0 then
else
EventsEndDateMonth1 = 0
end if

if len(EventsEndDateDay1) > 0 then
else
EventsEndDateDay1 = 0
end if

if len(EventsEndDateYear1) > 0 then
else
EventsEndDateYear1 = 0
end if

str1 = EventsURL
str2 = "'"
If InStr(str1,str2) > 0 Then
EventsURL= Replace(str1, "'", "''")
End If

str1 = lcase(EventsURL)
str2 = "http://"
If InStr(str1,str2) > 0 Then
EventsURL= Replace(str1, "http://", "")
End If

str1 = lcase(EventsURL)
str2 = "http:"
If InStr(str1,str2) > 0 Then
EventsURL= Replace(str1, "http:", "")
End If

Query =  "INSERT INTO Events ( EventsDateMonth, EventsURL, EventsDateDay, EventsDateYear, EventsDateWeekday, EventsEndDateMonth, EventsEndDateDay, EventsEndDateYear, EventsEndDateWeekday, EventsTime, EventsPrice, EventsTitle, EventsCatID, EventsDescription)" 
Query =  Query & " Values (" & EventsStartDateMonth1 & "," 
Query =  Query & " '" &   EventsURL & "',"
Query =  Query & " " &   EventsStartDateDay1 & ","
Query =  Query & " " &   EventsStartDateYear1 & "," 
Query =  Query & " '" &   EventsStartDateWeekDay1 & "'," 
Query =  Query & " " &   EventsEndDateMonth1 & ","
Query =  Query & " " &   EventsEndDateDay1 & ","
Query =  Query & " " &   EventsEndDateYear1 & "," 
Query =  Query & " '" &   EventsEndDateWeekDay1 & "'," 
Query =  Query & " '" &   EventsTime1 & "'," 
Query =  Query & " '" &   EventsPrice1 & "'," 
Query =  Query & " '" &   EventsTitle1 & "'," 
Query =  Query & " " &  EventsCatID1 & "," 
Query =  Query & " '" &  EventsDescription1  & "')"
response.write("Query =" & Query)
 Set DataConnection = Server.CreateObject("ADODB.Connection")
 DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 
 DataConnection.Execute(Query) 
DataConnection.Close
Response.Redirect("EventMantainance.asp")
%>
 </Body>
</HTML>
