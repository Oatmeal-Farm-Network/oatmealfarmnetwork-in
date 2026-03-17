<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html >
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="/administration/style.css">
<!--#Include file="AdminGlobalVariables.asp"-->


<% 
dim ClassInfoTitle (10000)
dim ClassInfoStudentFee(10000)
dim ClassStartTime(1000)
dim ClassEndTime(10000)
dim ClassInfoRoomDesignation(10000)
dim ClassInfoDescription(10000)
dim ClassInfoID(10000)
dim ClassInfoMaterialFee(10000)
dim AddressID1(10000)
dim ClassDateDayOfWeek1(10000)
dim ClassStartTime1(10000)
dim ClassEndTime1(10000)

dim AddressID2(10000)
dim ClassDateDayOfWeek2(10000)
dim ClassStartTime2(10000)
dim ClassEndTime2(10000)

dim AddressID3(10000)
dim ClassDateDayOfWeek3(10000)
dim ClassStartTime3(10000)
dim ClassEndTime3(10000)

dim AddressID4(10000)
dim ClassDateDayOfWeek4(10000)
dim ClassStartTime4(10000)
dim ClassEndTime4(10000)

dim AddressID5(10000)
dim ClassDateDayOfWeek5(10000)
dim ClassStartTime5(10000)
dim ClassEndTime5(10000)

dim AddressID6(10000)
dim ClassDateDayOfWeek6(10000)
dim ClassStartTime6(10000)
dim ClassEndTime6(10000)

dim AddressID7(10000)
dim ClassDateDayOfWeek7(10000)
dim ClassStartTime7(10000)
dim ClassEndTime7(10000)


rowcount = 1
totalcount = request.form("totalcount")

while (cint(rowcount) < cint(totalcount + 1))
ClassInfoTitlecount = "ClassInfoTitle(" & rowcount & ")"	
ClassInfoTitle(rowcount)=Request.Form(ClassInfoTitlecount) 

ClassInfoStudentFeecount = "ClassInfoStudentFee(" & rowcount & ")"	
ClassInfoStudentFee(rowcount)=Request.Form(ClassInfoStudentFeecount) 

ClassStartTimecount = "ClassStartTime(" & rowcount & ")"	
ClassStartTime(rowcount)=Request.Form(ClassStartTimecount) 

ClassEndTimecount = "ClassEndTime(" & rowcount & ")"	
ClassEndTime(rowcount)=Request.Form(ClassEndTimecount) 

ClassInfoRoomDesignationcount = "ClassInfoRoomDesignation(" & rowcount & ")"
ClassInfoRoomDesignation(rowcount)=Request.Form(ClassInfoRoomDesignationcount) 

ClassInfoDescriptioncount = "ClassInfoDescription(" & rowcount & ")"
ClassInfoDescription(rowcount)=Request.Form(ClassInfoDescriptioncount) 

ClassInfoIDcount = "ClassInfoID(" & rowcount & ")"
ClassInfoID(rowcount)=Request.Form(ClassInfoIDcount) 

ClassInfoMaterialFeecount = "ClassInfoMaterialFee(" & rowcount & ")"
ClassInfoMaterialFee(rowcount)=Request.Form(ClassInfoMaterialFeecount) 


AddressID1count = "AddressID1(" & rowcount & ")"
AddressID1(rowcount)=Request.Form(AddressID1count) 

AddressID2count = "AddressID2(" & rowcount & ")"
AddressID2(rowcount)=Request.Form(AddressID2count) 
AddressID3count = "AddressID3(" & rowcount & ")"
AddressID3(rowcount)=Request.Form(AddressID3count) 
AddressID4count = "AddressID4(" & rowcount & ")"
AddressID4(rowcount)=Request.Form(AddressID4count) 
AddressID5count = "AddressID5(" & rowcount & ")"
AddressID5(rowcount)=Request.Form(AddressID5count) 
AddressID6count = "AddressID6(" & rowcount & ")"
AddressID6(rowcount)=Request.Form(AddressID6count) 


AddressID7count = "AddressID7(" & rowcount & ")"
AddressID7(rowcount)=Request.Form(AddressID7count) 

ClassDateDayOfWeek1count = "ClassDateDayOfWeek1(" & rowcount & ")"
ClassDateDayOfWeek1(rowcount)=Request.Form(ClassDateDayOfWeek1count) 

ClassDateDayOfWeek2count = "ClassDateDayOfWeek2(" & rowcount & ")"
ClassDateDayOfWeek2(rowcount)=Request.Form(ClassDateDayOfWeek2count) 

ClassDateDayOfWeek3count = "ClassDateDayOfWeek3(" & rowcount & ")"
ClassDateDayOfWeek3(rowcount)=Request.Form(ClassDateDayOfWeek3count) 

ClassDateDayOfWeek4count = "ClassDateDayOfWeek4(" & rowcount & ")"
ClassDateDayOfWeek4(rowcount)=Request.Form(ClassDateDayOfWeek4count) 

ClassDateDayOfWeek5count = "ClassDateDayOfWeek5(" & rowcount & ")"
ClassDateDayOfWeek5(rowcount)=Request.Form(ClassDateDayOfWeek5count) 

ClassDateDayOfWeek6count = "ClassDateDayOfWeek6(" & rowcount & ")"
ClassDateDayOfWeek6(rowcount)=Request.Form(ClassDateDayOfWeek6count) 

ClassDateDayOfWeek7count = "ClassDateDayOfWeek7(" & rowcount & ")"
ClassDateDayOfWeek7(rowcount)=Request.Form(ClassDateDayOfWeek7count) 


ClassStartTime1count = "ClassStartTime1(" & rowcount & ")"
ClassStartTime1(rowcount)=Request.Form(ClassStartTime1count) 

ClassStartTime2count = "ClassStartTime2(" & rowcount & ")"
ClassStartTime2(rowcount)=Request.Form(ClassStartTime2count) 

ClassStartTime3count = "ClassStartTime3(" & rowcount & ")"
ClassStartTime3(rowcount)=Request.Form(ClassStartTime3count) 

ClassStartTime4count = "ClassStartTime4(" & rowcount & ")"
ClassStartTime4(rowcount)=Request.Form(ClassStartTime4count) 

ClassStartTime5count = "ClassStartTime5(" & rowcount & ")"
ClassStartTime5(rowcount)=Request.Form(ClassStartTime5count) 

ClassStartTime6count = "ClassStartTime6(" & rowcount & ")"
ClassStartTime6(rowcount)=Request.Form(ClassStartTime6count) 

ClassStartTime7count = "ClassStartTime7(" & rowcount & ")"
ClassStartTime7(rowcount)=Request.Form(ClassStartTime7count) 



ClassEndTime1count = "ClassEndTime1(" & rowcount & ")"
ClassEndTime1(rowcount)=Request.Form(ClassEndTime1count) 

ClassEndTime2count = "ClassEndTime2(" & rowcount & ")"
ClassEndTime2(rowcount)=Request.Form(ClassEndTime2count) 

ClassEndTime3count = "ClassEndTime3(" & rowcount & ")"
ClassEndTime3(rowcount)=Request.Form(ClassEndTime3count) 

ClassEndTime4count = "ClassEndTime4(" & rowcount & ")"
ClassEndTime4(rowcount)=Request.Form(ClassEndTime4count) 

ClassEndTime5count = "ClassEndTime5(" & rowcount & ")"
ClassEndTime5(rowcount)=Request.Form(ClassEndTime5count) 

ClassEndTime6count = "ClassEndTime6(" & rowcount & ")"
ClassEndTime6(rowcount)=Request.Form(ClassEndTime6count) 

ClassEndTime7count = "ClassEndTime7(" & rowcount & ")"
ClassEndTime7(rowcount)=Request.Form(ClassEndTime7count) 

rowcount = rowcount +1
Wend



rowcount =1
while (cint(rowcount) < cint(totalcount + 1))

str1 =ClassInfoDescription(rowcount)
str2 = "'"
If InStr(str1,str2) > 0 Then
ClassInfoDescription(rowcount)= Replace(str1,  str2, "''")
End If 
	
	
str1 =ClassInfoDescription(rowcount)
str2 = "'"
If InStr(str1,str2) > 0 Then
ClassInfoDescription(rowcount)= Replace(str1,  str2, "''")
End If 

str1 = ClassInfoTitle(rowcount)
str2 = "'"
If InStr(str1,str2) > 0 Then
ClassInfoTitle(rowcount)= Replace(str1, "'", "''")
End If

str1 =ClassStartTime1(rowcount)
str2 = "'"
If InStr(str1,str2) > 0 Then
ClassStartTime1(rowcount)= Replace(str1,  str2, "''")
End If 

str1 =ClassStartTime2(rowcount)
str2 = "'"
If InStr(str1,str2) > 0 Then
ClassStartTime2(rowcount)= Replace(str1,  str2, "''")
End If 

str1 =ClassStartTime3(rowcount)
str2 = "'"
If InStr(str1,str2) > 0 Then
ClassStartTime3(rowcount)= Replace(str1,  str2, "''")
End If 

str1 =ClassStartTime4(rowcount)
str2 = "'"
If InStr(str1,str2) > 0 Then
ClassStartTime4(rowcount)= Replace(str1,  str2, "''")
End If 

str1 =ClassStartTime5(rowcount)
str2 = "'"
If InStr(str1,str2) > 0 Then
ClassStartTime5(rowcount)= Replace(str1,  str2, "''")
End If 

str1 =ClassStartTime6(rowcount)
str2 = "'"
If InStr(str1,str2) > 0 Then
ClassStartTime6(rowcount)= Replace(str1,  str2, "''")
End If 

str1 =ClassStartTime7(rowcount)
str2 = "'"
If InStr(str1,str2) > 0 Then
ClassStartTime7(rowcount)= Replace(str1,  str2, "''")
End If 
	
str1 =ClassEndTime1(rowcount)
str2 = "'"
If InStr(str1,str2) > 0 Then
ClassEndTime1(rowcount)= Replace(str1,  str2, "''")
End If 

str1 =ClassEndTime2(rowcount)
str2 = "'"
If InStr(str1,str2) > 0 Then
ClassEndTime2(rowcount)= Replace(str1,  str2, "''")
End If 

str1 =ClassEndTime3(rowcount)
str2 = "'"
If InStr(str1,str2) > 0 Then
ClassEndTime3(rowcount)= Replace(str1,  str2, "''")
End If 

str1 =ClassEndTime4(rowcount)
str2 = "'"
If InStr(str1,str2) > 0 Then
ClassEndTime4(rowcount)= Replace(str1,  str2, "''")
End If 

str1 =ClassEndTime5(rowcount)
str2 = "'"
If InStr(str1,str2) > 0 Then
ClassEndTime5(rowcount)= Replace(str1,  str2, "''")
End If 

str1 =ClassEndTime6(rowcount)
str2 = "'"
If InStr(str1,str2) > 0 Then
ClassEndTime6(rowcount)= Replace(str1,  str2, "''")
End If 

str1 =ClassEndTime7(rowcount)
str2 = "'"
If InStr(str1,str2) > 0 Then
ClassEndTime7(rowcount)= Replace(str1,  str2, "''")
End If 
	
str1 =ClassInfoRoomDesignation(rowcount)
str2 = "'"
If InStr(str1,str2) > 0 Then
ClassInfoRoomDesignation(rowcount)= Replace(str1,  str2, "''")
End If 

Query =  " UPDATE ClassInfo Set ClassInfoTitle = '" &  ClassInfoTitle(rowcount) & "', " 
if len(ClassInfoStudentFee(rowcount))> 0 then
Query =  Query & "  ClassInfoStudentFee = " & ClassInfoStudentFee(rowcount) & "," 
end if 
Query =  Query & "  ClassInfoDescription = '" & ClassInfoDescription(rowcount) & "', " 
if len(ClassInfoMaterialFee(rowcount)) > 0 then
Query =  Query & " ClassInfoMaterialFee = " & ClassInfoMaterialFee(rowcount) & " ,"
end if 

if len(AddressID1(rowcount)) < 1 then
else
Query =  Query & "  AddressID1 = " & AddressID1(rowcount) & " ," 
end if

if len(AddressID2(rowcount)) < 1 then
else
Query =  Query & "  AddressID2 = " & AddressID2(rowcount) & " ," 
end if

if len(AddressID3(rowcount)) < 1 then
else
Query =  Query & "  AddressID3 = " & AddressID3(rowcount) & " ," 
end if

if len(AddressID4(rowcount)) < 1 then
else
Query =  Query & "  AddressID4 = " & AddressID4(rowcount) & " ," 
end if

if len(AddressID5(rowcount)) < 1 then
else
Query =  Query & "  AddressID5 = " & AddressID5(rowcount) & " ," 
end if

if len(AddressID6(rowcount)) < 1 then
else
Query =  Query & "  AddressID6 = " & AddressID6(rowcount) & " ," 
end if

if len(AddressID7(rowcount)) < 1 then
else
Query =  Query & "  AddressID7 = " & AddressID7(rowcount) & " ," 
end if

Query =  Query & " ClassDateDayOfWeek1 = '" & ClassDateDayOfWeek1(rowcount) & "' ," 
Query =  Query & " ClassStartTime1 = '" & ClassStartTime1(rowcount) & "' ," 
Query =  Query & " ClassEndTime1 = '" & ClassEndTime1(rowcount) & "' ," 

Query =  Query & " ClassDateDayOfWeek2 = '" & ClassDateDayOfWeek2(rowcount) & "' ," 
Query =  Query & " ClassStartTime2 = '" & ClassStartTime2(rowcount) & "' ," 
Query =  Query & " ClassEndTime2 = '" & ClassEndTime2(rowcount) & "' ," 

Query =  Query & " ClassDateDayOfWeek3 = '" & ClassDateDayOfWeek3(rowcount) & "' ," 
Query =  Query & " ClassStartTime3 = '" & ClassStartTime3(rowcount) & "' ," 
Query =  Query & " ClassEndTime3 = '" & ClassEndTime3(rowcount) & "' ," 

Query =  Query & " ClassDateDayOfWeek4 = '" & ClassDateDayOfWeek4(rowcount) & "' ," 
Query =  Query & " ClassStartTime4 = '" & ClassStartTime4(rowcount) & "' ," 
Query =  Query & " ClassEndTime4 = '" & ClassEndTime4(rowcount) & "' ," 

Query =  Query & " ClassDateDayOfWeek5 = '" & ClassDateDayOfWeek5(rowcount) & "' ," 
Query =  Query & " ClassStartTime5 = '" & ClassStartTime5(rowcount) & "' ," 
Query =  Query & " ClassEndTime5 = '" & ClassEndTime5(rowcount) & "' ," 

Query =  Query & " ClassDateDayOfWeek6 = '" & ClassDateDayOfWeek6(rowcount) & "' ," 
Query =  Query & " ClassStartTime6 = '" & ClassStartTime6(rowcount) & "' ," 
Query =  Query & " ClassEndTime6 = '" & ClassEndTime6(rowcount) & "' ," 

Query =  Query & " ClassDateDayOfWeek7 = '" & ClassDateDayOfWeek7(rowcount) & "' ," 
Query =  Query & " ClassStartTime7 = '" & ClassStartTime7(rowcount) & "' ," 
Query =  Query & " ClassEndTime7 = '" & ClassEndTime7(rowcount) & "' ," 



Query =  Query & "  ClassStartTime = '" & ClassStartTime(rowcount) & "' ," 
Query =  Query & "  ClassEndTime = '" & ClassEndTime(rowcount) & "' ," 
Query =  Query & "  ClassInfoRoomDesignation = '" & ClassInfoRoomDesignation(rowcount) & "' " 
Query =  Query & " where ClassInfoID = " & ClassInfoID(rowcount) & ";" 
response.write("Query = " & Query & "<br>")
Conn.Execute(Query) 
rowcount= rowcount +1
wend
%>
<% Message = "Your Class Have Been Updated"
Response.Redirect("ClassesEditDetails2.asp" ) %>

</Body>
</HTML>