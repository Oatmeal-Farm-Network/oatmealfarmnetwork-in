<!DOCTYPE HTML>
<%@ Language=VBScript %>
<HTML>
<HEAD>
</head>
<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">
<!--#Include file="MembersSecurityInclude.asp"--> 
<!--#Include file="MembersGlobalVariables.asp"-->

<% 	TotalCount= Request.Form("TotalCount")
	TotalCount = CInt(TotalCount)
	'rowcount = CInt
	rowcount = 1
	
	TempID=Request.Form("ID") 
	Response.Write("TempID=" & TempID )
	TempFullName=Request.Form("FullName") 
	TempBred=Request.Form("Bred")
	TempBredTo=Request.Form("BredTo") 
	TempXServiceSireID=Request.Form("ExternalStudID") 
	TempServiceSireID=Request.Form("ServiceSireID") 

	TempServiceSireLink=Request.Form("ServiceSireLink") 
	TempRecentProgenyID=Request.Form("RecentProgenyID") 
	TempDueDateMonth=Request.Form("DueDateMonth")
	TempDueDateYear=Request.Form("DueDateYear")
	TempShowRecentCria=Request.Form("ShowRecentCria")
	TempShowCurrentStud=Request.Form("ShowCurrentStud")
	TempCriaPhoto=Request.Form("CriaPhoto")
	TempCriaLink=Request.Form("CriaLink")
TempExternalStudLink=Request.Form("ExternalStudLink")
TempExternalStudColor=Request.Form("ExternalStudColor")
TempExternalStudPhoto=Request.Form("ExternalStudPhoto")
TempDueDateMonth=Request.Form("DueDateMonth") 
TempExternalstudname = Request.Form("Externalstudname")
	rowcount = rowcount +1

 rowcount =1

str1 = TempBredTo
str2 = "'"
If InStr(str1,str2) > 0 Then
	TempBredTo= Replace(str1, "'", "''")
End If


str1 = TempServiceSireID 
If  str1= " " or str1="" Then
	TempServiceSireID = "0"
End If

str1 = TempXServiceSireID 
If  str1= " " or str1="" Then
	TempXServiceSireID = "0"
End If

str2 = TempRecentProgenyID 
If  str2= " " or str2="" Then
	TempRecentProgenyID = "0"
End If



str1 = TempExternalstudname 
str2 = "'"
If InStr(str1,str2) > 0 Then
TempExternalstudname = Replace(str1, "'", """")
End If

str1 = TempExternalStudLink 
str2 = "'"
If InStr(str1,str2) > 0 Then
TempExternalStudLink = Replace(str1, "'", "''")
End If

str1 = lcase(TempExternalStudLink )
str2 = "http://"
If InStr(str1,str2) > 0 Then
TempExternalStudLink = Replace(str1, str2, "")
End If

str1 = lcase(TempExternalStudLink )
str2 = "http:/"
If InStr(str1,str2) > 0 Then
TempExternalStudLink = Replace(str1, str2, "")
End If

str1 = lcase(TempExternalStudLink )
str2 = "http:"
If InStr(str1,str2) > 0 Then
TempExternalStudLink = Replace(str1, str2, "")
End If

If TempBred = "False" then
TempBred = 0
Else
TempBred = 1
end if 

Query =  " UPDATE FemaleData Set Bred = " &  TempBred & ", " 
Query =  Query & " ServiceSireID = " &   TempServiceSireID & "," 
Query =  Query & " ExternalStudLink = '" &  TempExternalStudLink & "'," 
Query =  Query & " ExternalStudColor = '" & TempExternalStudColor & "'," 
Query =  Query & " ExternalStudPhoto = '" & TempExternalStudPhoto & "'," 
Query =  Query & " Externalstudname = '" & TempExternalstudname & "'," 
if len(trim(TempDueDateMonth)) > 0 then
Query =  Query & " DueDateMonth = " &  TempDueDateMonth & "," 
end if
if len(trim(TempDueDateYear)) > 0 then
Query =  Query & " DueDateYear = " &  TempDueDateYear & "," 
end if	
Query =  Query & " ExternalStudID = " &   TempXServiceSireID & "" 
Query =  Query & " where ID = " & TempID & ";" 

response.write(Query)	

Conn.Execute(Query) 

Query =  " UPDATE Animals  Set Lastupdated =  CURRENT_TIMESTAMP" 
Query =  Query & " where ID = " & TempID & ";" 

response.write(Query)	
Conn.Execute(Query) 


Conn.close
set Conn = nothing 
response.redirect("MembersFemaleDataFrame.asp?ID=" & TempID & "&changesmade=True")
%>
</Body>
</HTML>
