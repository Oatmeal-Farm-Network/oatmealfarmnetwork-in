<!DOCTYPE HTML >
<HTML>
<HEAD>
<link rel="stylesheet" type="text/css" href="/style.css">
</head>
<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">
<!--#Include file="membersGlobalVariables.asp"-->

<% 
ID= Request.Form("ID") 


Query =  " UPDATE Photos Set AnimalVideo = ''  " 
Query =  Query & " where ID = " & ID & ";" 
Conn.Execute(Query) 
Conn.Close
Set Conn = Nothing 
response.Redirect("MembersPhotos.asp?ID=" & ID & "#Video")

%>

 </Body>
</HTML>
