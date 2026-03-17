<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
<HEAD>
 <title>Add Event Handle Page</title>
       <Link rel="stylesheet" type="text/css" href="/administration/style.css">
</HEAD>

<BODY bgcolor = "white">
<!--#Include virtual="/Administration/Header.asp"--> 
<%

dim CalendarDateMonth1
dim CalendarDateDay1
dim CalendarDateYear1
dim CalendarDateWeekday1
dim CalendarEndDateMonth1
dim CalendarEndDateDay1
dim CalendarEndDateYear1
dim CalendarEndDateWeekday1
dim CalendarTime1
dim CalendarPrice1
dim CalendarTitle1
dim CalendarText1
dim Calendar1
dim CalendarDescription1
dim CalendarCatID1

	CalendarDateMonth1=Request.Form("CalendarDateMonth" ) 
		CalendarDateDay1=Request.Form("CalendarDateDay" ) 
			CalendarDateYear1=Request.Form("CalendarDateYear" ) 
				CalendarDateWeekday1=Request.Form("CalendarDateWeekday" ) 

CalendarEndDateMonth1=Request.Form("CalendarEndDateMonth" ) 
		CalendarEndDateDay1=Request.Form("CalendarEndDateDay" ) 
			CalendarEndDateYear1=Request.Form("CalendarEndDateYear" ) 
				CalendarEndDateWeekday1=Request.Form("CalendarEndDateWeekday" ) 

	CalendarTime1=Request.Form("CalendarTime" ) 
	CalendarPrice1=Request.Form("CalendarPrice" ) 
	CalendarTitle1=Request.Form("CalendarTitle" ) 
	Calendar1=Request.Form("Calendar" ) 
	CalendarDescription1=Request.Form( "CalendarDescription" ) 
	CalendarCatID1=Request.Form( "CatID" ) 

str1 = CalendarTitle1
str2 = "'"
If InStr(str1,str2) > 0 Then
	CalendarTitle1= Replace(str1, "'", "''")
End If


str1 = CalendarPrice1
str2 = "'"
If InStr(str1,str2) > 0 Then
	CalendarPrice1= Replace(str1, "'", "''")
End If


str1 = CalendarDescription1
str2 = "'"
If InStr(str1,str2) > 0 Then
	CalendarDescription1= Replace(str1, "'", "''")
End If

If Len(CalendarCatID1)<1 Then
	CalendarCatID1 = 8
End if


		Query =  "INSERT INTO Calendar ( CalendarDateMonth, CalendarDateDay, CalendarDateYear, CalendarDateWeekday, CalendarEndDateMonth, CalendarEndDateDay, CalendarEndDateYear, CalendarEndDateWeekday, CalendarTime, CalendarPrice, CalendarTitle, CalendarCatID, CalendarDescription)" 
		Query =  Query + " Values ('" & CalendarDateMonth1 & "'," 
		Query =  Query & " '" &   CalendarDateDay1 & "',"
		Query =  Query & " '" &   CalendarDateYear1 & "'," 
		Query =  Query & " '" &   CalendarDateWeekDay1 & "'," 
		Query =  Query & " '" &   CalendarEndDateMonth1 & "'," 
		Query =  Query & " '" &   CalendarEndDateDay1 & "',"
		Query =  Query & " '" &   CalendarEndDateYear1 & "'," 
		Query =  Query & " '" &   CalendarEndDateWeekDay1 & "'," 
		Query =  Query & " '" &   CalendarTime1 & "'," 
		Query =  Query & " '" &   CalendarPrice1 & "'," 
		Query =  Query & " '" &   CalendarTitle1 & "'," 
		Query =  Query & " " &  CalendarCatID1 & "," 
		Query =  Query & " '" &  CalendarDescription1  & "')"

		Set DataConnection = Server.CreateObject("ADODB.Connection")

		DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) 	& ";" 
'response.write(Query)
		DataConnection.Execute(Query) 
		DataConnection.Close
		Set DataConnection = Nothing 


 %>
<div align = "center"><H2>Your changes have successfully been made.</H2><br><br>

<%

		Response.Redirect("/Administration/CalendarMantainance.asp#Edit")


%>
 </Body>
</HTML>
