<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<HEAD>
 <base target="_self" />
<link rel="stylesheet" type="text/css" href="/style.css">
<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  >
<!--#Include file="adminglobalvariables.asp"-->
<%

ID=Request.Form("ID") 
TotalCount= Request.Form("TotalCount")
TotalCount = CInt(TotalCount)
rowcount = 1

dim AwardsID(1000)
dim Placing(1000)
dim AClass(1000)
dim AwardYear(1000)
dim Show(1000)
dim Awardcomments(1000)
dim Judge(1000)
	
while (rowcount < TotalCount )
AwardsIDcount = "AwardsID(" & rowcount & ")"
AwardsID(rowcount)=Request.Form(AwardsIDcount)

Placingcount = "Placing(" & rowcount & ")"
Placing(rowcount)=Request.Form(Placingcount)

AClasscount = "AClass(" & rowcount & ")"
AClass(rowcount)=Request.Form(AClasscount)

AwardYearcount = "AwardYear(" & rowcount & ")"
AwardYear(rowcount)=Request.Form(AwardYearcount)

Showcount = "Show(" & rowcount & ")"
Show(rowcount)=Request.Form(Showcount)
response.write("Show=" & Show(rowcount))

Awardcommentscount = "Awardcomments(" & rowcount & ")"
Awardcomments(rowcount)=Request.Form(Awardcommentscount)

rowcount = rowcount +1
Wend

 rowcount =1

while (rowcount < TotalCount )


str1 = Show(rowcount)
str2 = "'"
If InStr(str1,str2) > 0 Then
	Show(rowcount)= Replace(str1, "'", "''")
End If

If Len(awardYear(rowcount)) < 2 Then
	AwardYear(rowcount) = 0
End if


str1 = Placing(rowcount)
str2 = "'"
If InStr(str1,str2) > 0 Then
	Placing(rowcount)= Replace(str1, "'", "''")
End If
str1 = Awardcomments(rowcount)
str2 = "'"
If InStr(str1,str2) > 0 Then
Awardcomments(rowcount)= Replace(str1, "'", "''")
End If


Query =  " UPDATE Awards Set Placing = '" &  Placing(rowcount) & "', " 
Query =  Query & " Type = '" &  AClass(rowcount) & "'," 
Query =  Query & " Show = '" &  Show(rowcount) & "'," 
Query =  Query & " AwardYear = " & AwardYear(rowcount) & "," 
Query =  Query & " Judge = '" &   Judge(rowcount) & "'," 
Query =  Query & " Awardcomments = '" &  Awardcomments(rowcount) & "'," 
Query =  Query & "  ID = " & ID & "" 
Query =  Query & " where AwardsID = " & AwardsID(rowcount) & ";" 
response.write("Query=" & Query )
Conn.Execute(Query) 

 rowcount= rowcount +1
Wend
Conn.Close
Set Conn = Nothing  
response.redirect("AdminAwardsFrame.asp?ID=" & ID & "&changesmade=True")
%>
 </Body>
</HTML>
