<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<HEAD>
 <base target="_self" />
<link rel="stylesheet" type="text/css" href="/style.css">
<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  >
<!--#Include file="Membersglobalvariables.asp"-->
<%

animalid=Request.Form("animalid") 
TotalCount= Request.Form("TotalCount")
TotalCount = CInt(TotalCount)
response.write("TotalCount=" & TotalCount)

rowcount = 1

NewAwardYear= Request.Form("NewAwardYear")
NewShow= Request.Form("NewShow")
NewAClass= Request.Form("NewAClass")
NewPlacing= Request.Form("NewPlacing")
NewAwardcomments= Request.Form("NewAwardcomments")

Query =  "INSERT INTO Awards (AnimalID, AwardYear, ShowName, Type, Placing, Awardcomments)" 
Query =  Query & " Values (" &  AnimalID & ", " & NewAwardYear & ", '" & NewShow & "', '" & NewAClass & "', '" & NewPlacing & "', '" & NewAwardcomments & "')" 
response.write(Query)
Conn.Execute(Query) 



dim AwardsID(1000)
dim Placing(1000)
dim AClass(1000)
dim AwardYear(1000)
dim Show(1000)
dim Awardcomments(1000)
dim Judge(1000)
	
while (rowcount < (TotalCount+ 1) )
AwardsIDcount = "AwardsID(" & rowcount & ")"
AwardsID(rowcount)=Request.Form(AwardsIDcount)
response.write("AwardsID=" & AwardsID(rowcount))
Placingcount = "Placing(" & rowcount & ")"
Placing(rowcount)=Request.Form(Placingcount)

AClasscount = "AClass(" & rowcount & ")"
AClass(rowcount)=Request.Form(AClasscount)

AwardYearcount = "AwardYear(" & rowcount & ")"
AwardYear(rowcount)=Request.Form(AwardYearcount)

Showcount = "Show(" & rowcount & ")"
Show(rowcount)=Request.Form(Showcount)

Awardcommentscount = "Awardcomments(" & rowcount & ")"
Awardcomments(rowcount)=Request.Form(Awardcommentscount)

rowcount = rowcount +1
Wend

 rowcount =1

while (rowcount < (TotalCount+1) )
response.write("AwardsID=" & AwardsID(rowcount))

str1 = Show(rowcount)
str2 = "'"
If InStr(str1,str2) > 0 Then
	Show(rowcount)= Replace(str1, "'", "''")
End If


str1 = AClass(rowcount)
str2 = "'"
If InStr(str1,str2) > 0 Then
	AClass(rowcount)= Replace(str1, "'", "''")
End If



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

if len(AwardsID(rowcount)) > 0 then
Query =  " UPDATE Awards Set Placing = '" &  Placing(rowcount) & "', " 
Query =  Query & " Type = '" &  AClass(rowcount) & "'," 
Query =  Query & " ShowName = '" &  Show(rowcount) & "',"
If Len(awardYear(rowcount)) > 2 Then
Query =  Query & " AwardYear = '" & AwardYear(rowcount) & "',"
else
Query =  Query & " AwardYear = null,"
End if
Query =  Query & " Judge = '" &   Judge(rowcount) & "'," 
Query =  Query & " Awardcomments = '" &  Awardcomments(rowcount) & "'," 
Query =  Query & "  animalid = " & animalid & "" 
Query =  Query & " where AwardsID = " & AwardsID(rowcount) & ";" 
response.write("Query=" & Query )
Conn.Execute(Query) 
end if
 rowcount= rowcount +1
Wend

Query =  " UPDATE Animals  Set Lastupdated = getdate() " 
Query =  Query & " where animalid = " & animalid & ";" 
'response.write(Query)	
Conn.Execute(Query) 

Conn.Close
Set Conn = Nothing  
response.redirect("MembersEditAnimalAwards.asp?animalid=" & animalid & "&changesmade=True")
%>
 </Body>
</HTML>
