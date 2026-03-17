<!DOCTYPE HTML >
<HTML>
<HEAD>
<link rel="stylesheet" type="text/css" href="/style.css">
</head>
<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">
 <!--#Include virtual="/connloa.asp"--> 

<% 
ID= Request.Form("ID") 


Query =  " UPDATE Photos Set AnimalVideo = ''  " 
Query =  Query & " where ID = " & ID & ";" 
Connloa.Execute(Query) 
Connloa.Close
Set Connloa = Nothing 
response.Redirect("membersPhotos.asp?ID=" & ID & "#Video")

%>

 </Body>
</HTML>
