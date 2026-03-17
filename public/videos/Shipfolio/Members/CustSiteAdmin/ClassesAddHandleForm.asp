<HEAD>

       <link rel="stylesheet" type="text/css" href="style.css">

</HEAD>

<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">

<!--#Include file="adminGlobalvariables.asp"-->


<% 
'rowcount = CInt
rowcount = 1

Action= Request.Form("Action")
EventID = Request.Form("EventID")
MissingTitle = False
If Action = "Add" Then
ClassInfoTitle = Request.Form("ClassInfoTitle")
if len(ClassInfoTitle) < 1 then
    MissingTitle = True
 end if 
InstructorsName= Request.Form("InstructorsName")
InstructorsWebsite= Request.Form("InstructorsWebsite")
InstructorsBio= Request.Form("InstructorsBio")
ClassInfoStudentFee = Request.Form("ClassInfoStudentFee")
ClassDateMonth = Request.Form("ClassDateMonth")
ClassDateDay = Request.Form("ClassDateDay")
ClassDateYear = Request.Form("ClassDateYear")
ClassStartTime = Request.Form("ClassStartTime")
ClassEndTime = Request.Form("ClassEndTime")
ClassInfoRoomDesignation = Request.Form("ClassInfoRoomDesignation")
ClassInfoMinimumStudents = Request.Form("ClassInfoMinimumStudents")
ClassInfoMaximumStudents = Request.Form("ClassInfoMaximumStudents")
ClassInfoDescription = Request.Form("ClassInfoDescription")
ClassHomework = Request.Form("ClassHomework")
ClassInfoMaterialFee=  Request.Form("ClassInfoMaterialFee")
ClassInfoMaterialFeeOptional=  Request.Form("ClassInfoMaterialFeeOptional")

AddressID1 = Request.Form("AddressID1")
ClassDateDayOfWeek1 = Request.Form("ClassDateDayOfWeek1")
ClassStartTime1 = Request.Form("ClassStartTime1")
ClassEndTime1 = Request.Form("ClassEndTime1")

AddressID2 = Request.Form("AddressID2")
ClassDateDayOfWeek2 = Request.Form("ClassDateDayOfWeek2")
ClassStartTime2 = Request.Form("ClassStartTime2")
ClassEndTime2 = Request.Form("ClassEndTime2")

AddressID3 = Request.Form("AddressID3")
ClassDateDayOfWeek3 = Request.Form("ClassDateDayOfWeek3")
ClassStartTime3 = Request.Form("ClassStartTime3")
ClassEndTime3 = Request.Form("ClassEndTime3")

AddressID4 = Request.Form("AddressID4")
ClassDateDayOfWeek4 = Request.Form("ClassDateDayOfWeek4")
ClassStartTime4 = Request.Form("ClassStartTime4")
ClassEndTime4 = Request.Form("ClassEndTime4")

AddressID5 = Request.Form("AddressID5")
ClassDateDayOfWeek5 = Request.Form("ClassDateDayOfWeek5")
response.write("ClassDateDayOfWeek5=" & ClassDateDayOfWeek5 )
ClassStartTime5 = Request.Form("ClassStartTime5")
ClassEndTime5 = Request.Form("ClassEndTime5")

AddressID6 = Request.Form("AddressID6")
ClassDateDayOfWeek6 = Request.Form("ClassDateDayOfWeek6")
response.write("ClassDateDayOfWeek6=" & ClassDateDayOfWeek6 )
ClassStartTime6 = Request.Form("ClassStartTime6")
ClassEndTime6 = Request.Form("ClassEndTime6")

AddressID7 = Request.Form("AddressID7")
ClassDateDayOfWeek7 = Request.Form("ClassDateDayOfWeek7")
ClassStartTime7 = Request.Form("ClassStartTime7")
ClassEndTime7 = Request.Form("ClassEndTime7")


str1 =ClassStartTime1
str2 = "'"
If InStr(str1,str2) > 0 Then
ClassStartTime1= Replace(str1,  str2, "''")
End If 

str1 =ClassStartTime2
str2 = "'"
If InStr(str1,str2) > 0 Then
ClassStartTime3= Replace(str1,  str2, "''")
End If 

str1 =ClassStartTime3
str2 = "'"
If InStr(str1,str2) > 0 Then
ClassStartTime3= Replace(str1,  str2, "''")
End If 

str1 =ClassStartTime4
str2 = "'"
If InStr(str1,str2) > 0 Then
ClassStartTime4= Replace(str1,  str2, "''")
End If 

str1 =ClassStartTime5
str2 = "'"
If InStr(str1,str2) > 0 Then
ClassStartTime5= Replace(str1,  str2, "''")
End If 

str1 =ClassStartTime6
str2 = "'"
If InStr(str1,str2) > 0 Then
ClassStartTime6= Replace(str1,  str2, "''")
End If 

str1 =ClassStartTime7
str2 = "'"
If InStr(str1,str2) > 0 Then
ClassStartTime7= Replace(str1,  str2, "''")
End If 


str1 =ClassEndTime1
str2 = "'"
If InStr(str1,str2) > 0 Then
ClassEndTime1= Replace(str1,  str2, "''")
End If 

str1 =ClassEndTime2
str2 = "'"
If InStr(str1,str2) > 0 Then
ClassEndTime2= Replace(str1,  str2, "''")
End If 

str1 =ClassEndTime3
str2 = "'"
If InStr(str1,str2) > 0 Then
ClassEndTime3= Replace(str1,  str2, "''")
End If 

str1 =ClassEndTime4
str2 = "'"
If InStr(str1,str2) > 0 Then
ClassEndTime4= Replace(str1,  str2, "''")
End If 

str1 =ClassEndTime5
str2 = "'"
If InStr(str1,str2) > 0 Then
ClassEndTime5= Replace(str1,  str2, "''")
End If 

str1 =ClassEndTime6
str2 = "'"
If InStr(str1,str2) > 0 Then
ClassEndTime6= Replace(str1,  str2, "''")
End If 

str1 =ClassEndTime7
str2 = "'"
If InStr(str1,str2) > 0 Then
ClassEndTime7= Replace(str1,  str2, "''")
End If 


str1 =ClassInfoMaterialFee
str2 = "'"
If InStr(str1,str2) > 0 Then
ClassInfoMaterialFee= Replace(str1,  str2, "''")
End If 


str1 =Lcase(InstructorsWebsite)
str2 = "http://"
If InStr(str1,str2) > 0 Then
InstructorsWebsite= Replace(str1,  str2, "")
End If 

str1 =Lcase(InstructorsWebsite)
str2 = "http:/"
If InStr(str1,str2) > 0 Then
InstructorsWebsite= Replace(str1,  str2, "")
End If 

str1 =Lcase(InstructorsWebsite)
str2 = "http:"
If InStr(str1,str2) > 0 Then
InstructorsWebsite= Replace(str1,  str2, "")
End If 

str1 =Lcase(InstructorsWebsite)
str2 = "http"
If InStr(str1,str2) > 0 Then
InstructorsWebsite= Replace(str1,  str2, "")
End If 

if not   MissingTitle = True then

str1 =InstructorsName
str2 = "'"
If InStr(str1,str2) > 0 Then
InstructorsName= Replace(str1,  str2, "''")
End If 

str1 =InstructorsWebsite
str2 = "'"
If InStr(str1,str2) > 0 Then
InstructorsWebsite= Replace(str1,  str2, "''")
End If 

str1 =InstructorsBio
str2 = "'"
If InStr(str1,str2) > 0 Then
InstructorsBio= Replace(str1,  str2, "''")
End If 


str1 =ClassHomework
str2 = "'"
If InStr(str1,str2) > 0 Then
ClassHomework= Replace(str1,  str2, "''")
End If 

str1 =ClassInfoTitle
str2 = "'"
If InStr(str1,str2) > 0 Then
ClassInfoTitle= Replace(str1,  str2, "''")
End If  


str1 =ClassInfoStudentFee
str2 = "'"
If InStr(str1,str2) > 0 Then
ClassInfoStudentFee= Replace(str1,  str2, "''")
End If 

str1 =ClassStartTime
str2 = "'"
If InStr(str1,str2) > 0 Then
ClassStartTime= Replace(str1,  str2, "''")
End If 

str1 =ClassEndTime
str2 = "'"
If InStr(str1,str2) > 0 Then
ClassEndTime= Replace(str1,  str2, "''")
End If 

str1 =ClassInfoRoomDesignation
str2 = "'"
If InStr(str1,str2) > 0 Then
ClassInfoRoomDesignation= Replace(str1,  str2, "''")
End If 

str1 =ClassInfoDescription 
str2 = "'"
If InStr(str1,str2) > 0 Then
ClassInfoDescription = Replace(str1,  str2, "''")
End If 

str1 =ClassHomework 
str2 = "'"
If InStr(str1,str2) > 0 Then
ClassHomework = Replace(str1,  str2, "''")
End If 

str1 = ClassInfoStudentFee
str2 = ","
If InStr(str1,str2) > 0 Then
ClassInfoStudentFee = Replace(str1, ",", "")
End If


if len(ClassInfoTitle) > 0 or len(InstructorID) > 0 or len(ClassInfoDescription) > 0 or len(ClassInfoStudentFee) > 0 or len(ClassHomework) > 0  or len(ClassInfoStudentFee) > 0  or len(ClassInfoDescription) > 0  or len(ClassInfoRoomDesignation) > 0 then
'response.write("Long If statement" & "<br/>")
Query = "INSERT INTO ClassInfo (ClassInfoTitle, ClassInfoDescription, ClassDateDayOfWeek1, ClassStartTime1, ClassEndTime1,  ClassDateDayOfWeek2, ClassStartTime2, ClassEndTime2, ClassDateDayOfWeek3, ClassStartTime3, ClassEndTime3, ClassDateDayOfWeek4, ClassStartTime4, ClassEndTime4, ClassDateDayOfWeek5, ClassStartTime5, ClassEndTime5, ClassDateDayOfWeek6, ClassStartTime6, ClassEndTime6, ClassDateDayOfWeek7, ClassStartTime7, ClassEndTime7," 

if len(AddressID1) > 0 then
Query =  Query &   " AddressID1 ,"
end if

if len(AddressID2) > 0 then
Query =  Query &   " AddressID2 ,"
end if

if len(AddressID3) > 0 then
Query =  Query &   " AddressID3 ,"
end if

if len(AddressID4) > 0 then
Query =  Query &   " AddressID4 ,"
end if

if len(AddressID5) > 0 then
Query =  Query &   " AddressID5 ,"
end if

if len(AddressID6) > 0 then
Query =  Query &   " AddressID6 ,"
end if

if len(AddressID7) > 0 then
Query =  Query &   " AddressID7 ,"
end if

if len(ClassInfoStudentFee) > 0 then
Query =  Query &   " ClassInfoStudentFee ,"
end if
if len(ClassDateMonth) > 0 then
Query =  Query &  " ClassDateMonth ,"
end if
if len(ClassDateDay) > 0 then
Query =  Query &  " ClassDateDay ,"
end if
if len(ClassDateYear) > 0 then
Query =  Query &  " ClassDateYear ,"
end if

if len(ClassInfoMaximumStudents) > 0 then
Query =  Query &  " ClassInfoMaximumStudents ,"
end if

Query =  Query &  " ClassStartTime, ClassEndTime )"
Query =  Query & " Values ('" &  ClassInfoTitle & "' ,"
Query =  Query & " '" &  ClassInfoDescription & "' ,"

Query =  Query & " '" & ClassDateDayOfWeek1 & "',"
Query =  Query & " '" & ClassStartTime1 & "',"
Query =  Query & " '" & ClassEndTime1 & "',"

Query =  Query & " '" & ClassDateDayOfWeek2 & "',"
Query =  Query & " '" & ClassStartTime2 & "',"
Query =  Query & " '" & ClassEndTime2 & "',"

Query =  Query & " '" & ClassDateDayOfWeek3 & "',"
Query =  Query & " '" & ClassStartTime3 & "',"
Query =  Query & " '" & ClassEndTime3 & "',"

Query =  Query & " '" & ClassDateDayOfWeek4 & "',"
Query =  Query & " '" & ClassStartTime4 & "',"
Query =  Query & " '" & ClassEndTime4 & "',"

Query =  Query & " '" & ClassDateDayOfWeek5 & "',"
Query =  Query & " '" & ClassStartTime5 & "',"
Query =  Query & " '" & ClassEndTime5 & "',"

Query =  Query & " '" & ClassDateDayOfWeek6 & "',"
Query =  Query & " '" & ClassStartTime6 & "',"
Query =  Query & " '" & ClassEndTime6 & "',"

Query =  Query & " '" & ClassDateDayOfWeek7 & "',"
Query =  Query & " '" & ClassStartTime7 & "',"
Query =  Query & " '" & ClassEndTime7 & "',"

if len(AddressID1) > 0 then
Query =  Query & " " & AddressID1 & ","
end if
if len(AddressID2) > 0 then
Query =  Query & " " & AddressID2 & ","
end if
if len(AddressID3) > 0 then
Query =  Query & " " & AddressID3 & ","
end if
if len(AddressID4) > 0 then
Query =  Query & " " & AddressID4 & ","
end if
if len(AddressID5) > 0 then
Query =  Query & " " & AddressID5 & ","
end if
if len(AddressID6) > 0 then
Query =  Query & " " & AddressID6 & ","
end if
if len(AddressID7) > 0 then
Query =  Query & " " & AddressID7 & ","
end if

if len(ClassInfoStudentFee) > 0 then
Query =  Query & " " &  ClassInfoStudentFee & " ,"
end if
if len(ClassDateMonth) > 0 then
Query =  Query & " " &  ClassDateMonth & " ,"
end if
if len(ClassDateDay) > 0 then
Query =  Query & " " &  ClassDateDay & " ,"
end if
if len(ClassDateYear) > 0 then
Query =  Query & " " &  ClassDateYear & " ,"
end if

if len(ClassInfoMaximumStudents) > 0 then
Query =  Query & " " &  ClassInfoMaximumStudents & " ,"
end if

Query =  Query & " '" &  ClassStartTime & "' ,"
Query =  Query & " '" &  ClassEndTime & "')" 

response.write("Query= " & Query & "<br/>")


Conn.Execute(Query) 
end if
 end if 
end if


If Action = "Update" Then

TotalCount= Request.Form("TotalCount")
TotalCount = CInt(TotalCount)
rowcount = 1

dim ClassInfoTitle(10000)
dim Instructor(10000)
dim ClassInfoStudentFee(10000)
dim ClassDateMonth(10000)
dim ClassDateDay(10000)
dim ClassDateYear(10000)
dim ClassStartTime(10000)
dim ClassEndTime(10000)
dim ClassInfoRoomDesignation(10000)
dim ClassInfoMaximumStudents(10000) 
dim ClassInfoDescription(10000)
dim ClassHomework(10000)
dim ClassInfoID(10000)
dim delete(10000)



while (rowcount < TotalCount + 1)
ClassInfoTitlecount = "ClassInfoTitle(" & rowcount & ")"
ClassInfoDescriptioncount = "ClassInfoDescription(" & rowcount & ")"
ClassInfoStudentFeecount = "ClassInfoStudentFee(" & rowcount & ")"
ClassInfoMaximumStudentscount = "ClassInfoMaximumStudents(" & rowcount & ")"
ClassInfoIDcount = "ClassInfoID(" & rowcount & ")"
Instructorcount = "Instructor(" & rowcount & ")"
ClassDateMonthcount = "ClassDateMonth(" & rowcount & ")"
ClassDateDaycount = "ClassDateDay(" & rowcount & ")"
ClassDateYearcount = "ClassDateYear(" & rowcount & ")"
ClassStartTimecount = "ClassStartTime(" & rowcount & ")" 
ClassEndTimecount = "ClassEndTime(" & rowcount & ")"
ClassInfoRoomDesignationcount = "ClassInfoRoomDesignation(" & rowcount & ")"
ClassHomeworkcount = "ClassHomework(" & rowcount & ")"
Deletecount = "Delete(" & rowcount & ")"

ClassInfoDescription(rowcount)=Request.Form(ClassInfoDescriptioncount) 
ClassInfoTitle(rowcount)=Request.Form(ClassInfoTitlecount) 
ClassInfoStudentFee(rowcount)=Request.Form(ClassInfoStudentFeecount) 
ClassInfoMaximumStudents(rowcount)=Request.Form(ClassInfoMaximumStudentscount )
ClassInfoID(rowcount)=Request.Form(ClassInfoIDcount)
Instructor(rowcount)=Request.Form(Instructorcount)
ClassDateMonth(rowcount)=Request.Form(ClassDateMonthcount)
ClassDateDay(rowcount)=Request.Form(ClassDateDaycount)
ClassDateYear(rowcount)=Request.Form(ClassDateYearcount)
ClassStartTime(rowcount)=Request.Form(ClassStartTimecount) 
ClassEndTime(rowcount)=Request.Form(ClassEndTimecount)
ClassInfoRoomDesignation(rowcount)=Request.Form(ClassInfoRoomDesignationcount)
ClassHomework(rowcount)=Request.Form(ClassHomeworkcount)
Delete(rowcount)=Request.Form(Deletecount)


rowcount = rowcount +1

Wend

 rowcount =1

while (rowcount < TotalCount + 1)

str1 = ClassInfoTitle(rowcount)
str2 = "'"
If InStr(str1,str2) > 0 Then
ClassInfoTitle(rowcount)= Replace(str1, "'", "''")
End If


str1 = ClassInfoDescription(rowcount)
str2 = "'"
If InStr(str1,str2) > 0 Then
ClassInfoDescription(rowcount)= Replace(str1, "'", "''")
End If

'response.write("Delete(" & rowcount & )=" & Delete(rowcount))
if Delete(rowcount) = "Yes" then
 Query =  "Delete * From ClassInfo where ClassInfoID = " & ClassInfoID(rowcount) & ";" 
Message = "Your Class Has Been Deleted"

Else





Query =  " UPDATE ClassInfo Set ClassInfoTitle = '" &  ClassInfoTitle(rowcount) & "', " 
if len(ClassInfoStudentFee(rowcount))> 0 then
Query =  Query & "  ClassInfoStudentFee = " & ClassInfoStudentFee(rowcount) & "," 
end if 
if len(ClassInfoMinimumStudents(rowcount))> 0 then
    Query =  Query & "  ClassInfoMaximumStudents = " & ClassInfoMinimumStudents(rowcount) & "," 
    end if
    if len(ClassInfoMaximumStudents(rowcount))> 0 then
    Query =  Query & "  ClassInfoMaximumStudents = " & ClassInfoMaximumStudents(rowcount) & "," 
    end if

    Query =  Query & "  ClassInfoDescription = '" & ClassInfoDescription(rowcount) & "', " 
    Query =  Query & "  Instructor = '" & Instructor(rowcount) & "', " 
    if len(ClassDateMonth(rowcount))> 0 then
    Query =  Query & "  ClassDateMonth = " & ClassDateMonth(rowcount) & " ," 
end if
if len(ClassDateDay(rowcount))> 0 then
    Query =  Query & "  ClassDateDay = " & ClassDateDay(rowcount) & ", " 
    end if
    if len(ClassDateYear(rowcount))> 0 then
    Query =  Query & "  ClassDateYear = " & ClassDateYear(rowcount) & ", " 
    end if 
    Query =  Query & "  ClassStartTime = '" & ClassStartTime(rowcount) & "' ," 
        Query =  Query & "  ClassEndTime = '" & ClassEndTime(rowcount) & "' ," 
    Query =  Query & "  ClassInfoRoomDesignation = '" & ClassInfoRoomDesignation(rowcount) & "' ," 
    Query =  Query & " ClassHomework = '" & ClassHomework(rowcount) & "' " 
    Query =  Query & " where ClassInfoID = " & ClassInfoID(rowcount) & ";" 

end if


Dim cmdDC, RecordSet
Dim RecordToEdit, Updated
'response.write(Query)
Conn.Execute(Query) 

  rowcount= rowcount +1
Wend

End If 
if MissingTitle = True then
 response.Redirect("ClassesAdd.asp?EventID=" & EventID & "&MissingTitle=True&InstructorsName=" & InstructorsName & "&InstructorsWebsite=" & InstructorsWebsite & "&InstructorsBio=" & InstructorsBio & "&ClassInfoStudentFee=" & ClassInfoStudentFee & "&ClassDateMonth=" & ClassDateMonth & "&ClassDateDay=" & ClassDateDay & "&ClassDateYear=" & ClassDateYear & "&ClassStartTime=" & ClassStartTime & "&ClassEndTime=" & ClassEndTime & "&ClassInfoRoomDesignation=" & ClassInfoRoomDesignation & "&ClassInfoMinimumStudents=" & ClassInfoMinimumStudents & "&ClassInfoMaximumStudents=" & ClassInfoMaximumStudents & "&ClassInfoDescription=" & ClassInfoDescription )
 else
 sql2 = "select ClassInfoID from ClassInfo  where ClassInfoTitle = '" & ClassInfoTitle & "' Order by ClassInfoID Desc"

Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3 
if not rs2.eof then
        ClassInfoID = rs2("ClassInfoID")
    end if
   rs2.close
 
' response.write("ClassInfoID=" & ClassInfoID )
response.Redirect("ClassesEditDetails2.asp?ClassInfoID=" & ClassInfoID)
 
end if 

%>

</Body>
</HTML>