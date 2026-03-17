<!DOCTYPE HTML>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<HEAD>
 <title>The Andresen Group Content Management System</title>

<!--#Include file="MembersSecurityInclude.asp"--> 
<!--#Include file="MembersGlobalVariables.asp"--> 
</HEAD>
<BODY bgcolor = "white">

<%

Dim TotalCount
dim rowcount
dim ID(200)
dim FullName(200)
dim Bred(200)
dim BredTo(200)
dim ServiceSireID(200)
dim ServiceSireLink(200)
dim RecentProgenyID(200)
dim XServiceSireID(200)
dim DueDateDay(200)
dim DueDateMonth(200)
dim DueDateYear(200)
dim ShowRecentCria(200)
dim ShowCurrentStud(200)
dim CriaPhoto(200)
dim CriaLink(200)
dim ShowOnCriasPage(200)

TotalCount= Request.Form("TotalCount")
TotalCount = CInt(TotalCount)
'rowcount = CInt(rowcount)
rowcount = 1
response.Write("TotalCount=" & TotalCount)

while (rowcount < TotalCount)
	IDcount = "ID(" & rowcount & ")"	
	FullNamecount = "FullName(" & rowcount & ")"
	Bredcount = "Bred(" & rowcount & ")"
	BredTocount = "BredTo(" & rowcount & ")"
	XServiceSireIDcount = "XServiceSireID(" & rowcount & ")"
	ServiceSireIDcount = "ServiceSireID(" & rowcount & ")"
	ServiceSireLinkcount = "ServiceSireLink(" & rowcount & ")"
	RecentProgenyIDcount = "RecentProgenyID(" & rowcount & ")"
	DueDateDaycount = "DueDateDay(" & rowcount & ")"
	DueDatemonthcount = "DueDateMonth(" & rowcount & ")"
	DueDateYearcount = "DueDateYear(" & rowcount & ")"
	ShowRecentCriacount = "ShowRecentCria(" & rowcount & ")"
	ShowCurrentStudcount = "ShowCurrentStud(" & rowcount & ")"
	CriaPhotocount = "CriaPhoto(" & rowcount & ")"
	CriaLinkcount = "CriaLink(" & rowcount & ")"
	ShowOnCriasPagecount= "ShowOnCriasPage(" & rowcount & ")"
	ShowRecentCriacount= "ShowRecentCria(" & rowcount & ")"
	
	ID(rowcount)=Request.Form(IDcount) 
	FullName(rowcount)=Request.Form(FullNamecount) 
	Bred(rowcount)=Request.Form(Bredcount )
	BredTo(rowcount)=Request.Form(BredTocount) 
	XServiceSireID(rowcount)=Request.Form(XServiceSireIDcount) 
	ServiceSireID(rowcount)=Request.Form(ServiceSireIDcount) 
	ServiceSireLink(rowcount)=Request.Form(ServiceSireLinkcount) 
	RecentProgenyID(rowcount)=Request.Form(RecentProgenyIDcount) 
	DueDateDay(rowcount)=Request.Form(DueDateDaycount)
	DueDateMonth(rowcount)=Request.Form(DueDateMonthcount)
	DueDateYear(rowcount)=Request.Form(DueDateYearcount)
	ShowRecentCria(rowcount)=Request.Form(ShowRecentCriacount)
	ShowCurrentStud(rowcount)=Request.Form(ShowCurrentStudcount)
	CriaPhoto(rowcount)=Request.Form(CriaPhotocount)
	CriaLink(rowcount)=Request.Form(CriaLinkcount)
ShowOnCriasPage(rowcount)=Request.Form(ShowOnCriasPagecount)
ShowRecentCria(rowcount)=Request.Form(ShowRecentCriacount)
	rowcount = rowcount +1
Wend

 rowcount =1

while (rowcount < TotalCount)



str1 = BredTo(rowcount) 
str2 = "'"
If InStr(str1,str2) > 0 Then
	BredTo(rowcount) = Replace(str1, "'", "''")
End If


str1 = ServiceSireID(rowcount) 
If  str1= " " or str1="" Then
	ServiceSireID(rowcount) = "0"
End If

str1 = XServiceSireID(rowcount) 
If  str1= " " or str1="" Then
	XServiceSireID(rowcount) = "0"
End If

str2 = RecentProgenyID(rowcount) 
If  str2= " " or str2="" Then
	RecentProgenyID(rowcount) = "0"
End If
if len(ShowOnCriasPage(rowcount) )> 0 then
else
ShowOnCriasPage(rowcount) = false
end if

	Query =  " UPDATE FemaleData Set Bred = " &  Bred(rowcount) & ", " 
    Query =  Query & " BredTo = '" &  BredTo(rowcount) & "'," 
    Query =  Query & " ServiceSireID = " &   ServiceSireID(rowcount) & "," 
	Query =  Query & " ExternalStudID = " &   XServiceSireID(rowcount) & "," 
	Query =  Query & " ShowOnCriasPage = " &   ShowOnCriasPage(rowcount) & "," 
    if len(ShowRecentCria(rowcount)) > 0 then
	Query =  Query & " ShowRecentCria = " &   ShowRecentCria(rowcount) & "," 
end if
    if len(DueDateDay(rowcount)) > 0 then
	Query =  Query & " DueDateDay = " &  DueDateDay(rowcount) & "," 
	end if
	if len(DueDateMonth(rowcount)) > 0 then
	Query =  Query & " DueDatemonth = " &  DueDateMonth(rowcount) & "," 
		end if
	if len(DueDateYear(rowcount)) > 0 then
	Query =  Query & " DueDateYear = " &  DueDateYear(rowcount) & "," 
	end if
	Query =  Query & " RecentProgenyID = " &  RecentProgenyID(rowcount) & ""
    Query =  Query & " where ID = " & ID(rowcount) & ";" 
    response.write("Query=" & Query )
Conn.Execute(Query) 
 rowcount= rowcount +1
Wend
Conn.Close
Set Conn = Nothing 
response.Redirect("MembersFemaleData.asp")
%>
 </Body>
</HTML>
