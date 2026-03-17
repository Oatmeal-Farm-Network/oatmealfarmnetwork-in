<%@ Language=VBScript %><HTML>
<HEAD>
<% attrDetailID = request.QueryString("attrDetailID") %>
<!--#Include file="AdminGlobalVariables.asp"-->
<title>Photo delete</title>
</HEAD>
<body >

<%
Query =  " UPDATE sfattributeDetail Set attrDetailImage = '' " 
Query =  Query & " where attrDetailID = " & attrDetailID & ";" 
response.write(Query)
Conn.Execute(Query) 

 response.redirect("AdminFrameAddAttributephotos.asp?attrDetailID=" & attrDetailID )
%>

</BODY>
</HTML>
