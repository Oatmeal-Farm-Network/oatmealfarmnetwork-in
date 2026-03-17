<!DOCTYPE HTML>
<%@ Language=VBScript %>
<HTML>
<HEAD>
<title>The Andresen Group Content Management System</title>
<link rel="stylesheet" type="text/css" href="style.css">
<base target="_self" />
</head>
<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">
<!--#Include file="AdminSecurityInclude.asp"--> 
<!--#Include file="AdminGlobalVariables.asp"-->

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


	Query =  " UPDATE FemaleData Set Bred = " &  TempBred & ", " 
    'Query =  Query & " ServiceSire = '" &  TempBredTo & "'," 
    Query =  Query & " ServiceSireID = " &   TempServiceSireID & "," 

   ' Query =  Query & " RecentProgenyID = " &  TempRecentProgenyID & ","
   if len(TempDueDateMonth) > 0 then
	Query =  Query & " DueDateMonth = " &  TempDueDateMonth & "," 
    end if
   if len(TempDueDateYear) > 0 then
	Query =  Query & " DueDateYear = " &  TempDueDateYear & "," 
end if	
Query =  Query & " ExternalStudID = " &   TempXServiceSireID & "" 
    Query =  Query & " where ID = " & TempID & ";" 

response.write(Query)	
Conn.Execute(Query) 

response.redirect("AdminFemaleDataFrame.asp?ID=" & TempID & "&changesmade=True")
%>

</Body>
</HTML>
