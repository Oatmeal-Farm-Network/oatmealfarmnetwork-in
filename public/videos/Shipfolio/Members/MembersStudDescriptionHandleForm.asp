<!DOCTYPE HTML>
<HTML>
<HEAD><!--#Include file="membersGlobalvariables.asp"--> 
 <link rel="stylesheet" type="text/css" href="/members/style.css">
 <base target="_self" />
 </head>
<% if mobiledevice = True  then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
<% end if %>
<!--#Include file="membersHeader.asp"-->
<%
'rowcount = CInt
rowcount = 1
category=Request.Form("category")
ID=Request.Form("ID") 
StudDescription=Request.Form("StudDescription") 

Dim str1
Dim str2
str1 = StudDescription
str2 = "'"
If InStr(str1,str2) > 0 Then
	StudDescription= Replace(str1,  str2, "''")
	
End If  

str1 = StudDescription
str2 = vbCrLf
If InStr(str1,str2) > 0 Then
	StudDescription= Replace(str1, str2 , "</br>")
	
End If  
	


Query =  " UPDATE Animals Set StudDescription = '" & StudDescription & "', "
    Query =  Query & " Lastupdated = now() " 
Query =  Query & " where ID = " & ID & ";" 

response.write(Query)
Conn.Execute(Query) 
Conn.Close
Set Conn = Nothing 

response.redirect("membersdescriptionFrame.asp?ID=" & ID & "&studchangesmade=True&category=" & category & "#studdescription")
%>


</Body>
</HTML>

