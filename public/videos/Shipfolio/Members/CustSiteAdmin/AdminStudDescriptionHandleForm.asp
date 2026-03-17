<!DOCTYPE HTML>
<HTML>
<HEAD><!--#Include file="AdminGlobalvariables.asp"--> 
 <link rel="stylesheet" type="text/css" href="/administration/style.css">
 <base target="_self" />
 </head>
<% if mobiledevice = True  then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
<% end if %>
<!--#Include file="AdminHeader.asp"-->
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
	
StudDescription1 = Left(StudDescription, 2000)
If Len(StudDescription) < 2001 Then
	StudDescription2 = ""
Else
	Rightlength = Len(StudDescription) - 2000
'	response.write("rl=" & rightlength)
	StudDescription2 = right(StudDescription, Rightlength)
End If 



Query =  " UPDATE Animals Set StudDescription1 = '" & StudDescription1 & "' ,"
Query =  Query & "  StudDescription2 = '" & StudDescription2 & "' "  
Query =  Query & " where ID = " & ID & ";" 

response.write(Query)





Set DataConnection = Server.CreateObject("ADODB.Connection")





Conn.Execute(Query) 


IF DataConnection.Errors.Count <> 0 then
     Call MyErrorHandler(oDBConn, sSQL)  ' pass database connection as param
 Else

 End If

	Conn.Close
	Set Conn = Nothing 

response.redirect("AdmindescriptionFrame.asp?ID=" & ID & "&studchangesmade=True&category=" & category & "#studdescription")
%>


</Body>
</HTML>

