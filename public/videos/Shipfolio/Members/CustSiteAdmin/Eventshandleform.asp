<!DOCTYPE html><html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<HEAD>
</HEAD>
<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">
<!--#Include file="AdminGlobalVariables.asp"-->
<%
EventsID= Request.Form("EventsID")
EventsURL=  Request.Form("EventsURL")
EventsDateMonth=  Request.Form("EventsDateMonth")	
EventsDateDay =  Request.Form("EventsDateDay")
EventsDateYear = Request.Form("EventsDateYear")	
EventsDateWeekday =  Request.Form("EventsDateWeekday")	
EventsEndDateMonth =  Request.Form("EventsEndDateMonth")
EventsEndDateDay =  Request.Form("EventsEndDateDay")
EventsEndDateYear =  Request.Form("EventsEndDateYear")	
EventsEndDateWeekday =  Request.Form("EventsEndDateWeekday")
EventsTime =  Request.Form("EventsTime")
EventsPrice= Request.Form("EventsPrice")
EventsTitle= Request.Form("EventsTitle")
EventsDescription =  Request.Form("EventsDescription")	
EventsCatID =  Request.Form("EventsCatID")

if len(EventsDateMonth) > 0 then
else
EventsDateMonth = 0
end if

if len(EventsDateDay) > 0 then
else
EventsDateDay = 0
end if

if len(EventsDateYear) > 0 then
else
EventsDateYear = 0
end if

if len(EventsEndDateMonth) > 0 then
else
EventsEndDateMonth = 0
end if

if len(EventsEndDateDay) > 0 then
else
EventsEndDateDay = 0
end if

if len(EventsEndDateYear) > 0 then
else
EventsEndDateYear = 0
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


str1 = EventsDescription
str2 = "'"
If InStr(str1,str2) > 0 Then
	EventsDescription= Replace(str1, "'", "''")
End If

str1 = EventsTime
str2 = "'"
If InStr(str1,str2) > 0 Then
	EventsTime= Replace(str1, "'", "''")
End If

str1 = EventsPrice
str2 = "'"
If InStr(str1,str2) > 0 Then
	EventsPrice= Replace(str1, "'", "''")
End If

str1 = EventsPrice
str2 = "'"
If InStr(str1,str2) > 0 Then
	EventsPrice= Replace(str1, "'", "''")
End If

Query =  " UPDATE Events Set EventsDateMonth = " & EventsDateMonth & "," 
Query =  Query & " EventsDateDay = " & EventsDateDay & "," 
Query =  Query & " EventsURL = '" & EventsURL & "'," 
Query =  Query & " EventsDateYear = " & EventsDateYear & "," 
Query =  Query & " EventsDateWeekday = '" & EventsDateWeekday & "'," 
Query =  Query & " EventsEndDateMonth = " & EventsEndDateMonth & "," 
Query =  Query & " EventsEndDateDay = " & EventsEndDateDay & "," 
Query =  Query & " EventsEndDateYear = " & EventsEndDateYear & "," 
Query =  Query & " EventsEndDateWeekday = '" & EventsEndDateWeekday & "'," 
Query =  Query & " Eventstime = '" & EventsTime & "'," 
Query =  Query & " EventsPrice = '" & EventsPrice & "'," 
Query =  Query & " EventsTitle = '" & EventsTitle & "'," 
Query =  Query & " EventsDescription = '" & EventsDescription & "'" 
Query =  Query & " where EventsID = " & EventsID & ";" 
 
Conn.Execute(Query) 
Conn.Close
response.redirect("EventMantainance.asp")
%>
</Body>
</HTML>
