<!DOCTYPE HTML>
<HTML>
<HEAD>
 <link rel="stylesheet" type="text/css" href="style.css">
 <base target="_self" />
<!--#Include file="Membersglobalvariables.asp"-->
</HEAD>
<body >
<%
'rowcount = CInt
rowcount = 1
category=Request.Form("category")
animalid=Request.Form("animalid") 
response.Write("animalid=" & animalid )
Description=Request.Form("Description") 

Dim str1
Dim str2
str1 = Description
str2 = "'"
If InStr(str1,str2) > 0 Then
Description= Replace(str1,  str2, "''")
End If  
	
Description1 = Left(description, 2000)
If Len(Description) < 2001 Then
	Description2 = ""
Else
	Rightlength = Len(Description) - 2000
'	response.write("rl=" & rightlength)
	Description2 = right(description, Rightlength)
End If 

Query =  " UPDATE Animals Set Description = '" & Description & "' ,"
Query =  Query & " Lastupdated = getdate() " 
Query =  Query & " where animalid = " & animalid & ";" 
Conn.Execute(Query) 
Conn.Close
Set Conn = Nothing 
response.redirect("MembersEditAnimalDescriptionFrame.asp?animalid=" & animalid & "&changesmade=True" & "&category=" & category & "#description")
%>
</Body>
</HTML>
