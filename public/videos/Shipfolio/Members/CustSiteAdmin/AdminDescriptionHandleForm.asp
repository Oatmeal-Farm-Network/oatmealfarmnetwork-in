<!DOCTYPE HTML>
<HTML>
<HEAD>
 <link rel="stylesheet" type="text/css" href="style.css">
 <base target="_self" />
<!--#Include file="AdminGlobalVariables.asp"-->
</HEAD>
<% if mobiledevice = True  then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
<% end if %>
<!--#Include File="AdminDetailDBInclude.asp"--> 
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

Query =  " UPDATE Animals Set Description1 = '" & Description1 & "' ,"
Query =  Query & "  Description2 = '" & Description2 & "' "  
Query =  Query & " where ID = " & ID & ";" 

response.write(Query)
Conn.Execute(Query) 
Conn.Close
Set Conn = Nothing 
response.redirect("AdmindescriptionFrame.asp?ID=" & ID & "&changesmade=True&category=" & category & "#description")
%>
</Body>
</HTML>
