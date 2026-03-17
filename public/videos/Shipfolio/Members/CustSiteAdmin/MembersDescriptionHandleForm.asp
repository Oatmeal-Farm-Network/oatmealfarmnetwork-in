<!DOCTYPE HTML>
<HTML>
<HEAD>
 <link rel="stylesheet" type="text/css" href="style.css">
 <base target="_self" />
<!--#Include file="Membersglobalvariables.asp"-->
<!--#Include file="AdminMobileWidthInclude.asp"--> 
</HEAD>
<body >
<%
'rowcount = CInt
rowcount = 1
category=Request.Form("category")
ID=Request.Form("ID") 
response.Write("ID=" & ID )
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
Query =  Query & " where ID = " & ID & ";" 
connLOA.Execute(Query) 
connLOA.Close
Set connLOA = Nothing 
response.redirect("MembersDescriptionFrame.asp?ID=" & ID & "&changesmade=True&screenwidth=" & screenwidth & "&category=" & category & "#description")
%>
</Body>
</HTML>
