<!DOCTYPE HTML>
<% ' Clean directory NEA 4/2012 %>
<HTML>
<HEAD>
<title>The Andresen Group Content Management System</title>
<link rel="stylesheet" type="text/css" href="style.css">
    <!--#Include file="AdminSecurityInclude.asp"--> 
    <!--#Include file="AdminGlobalVariables.asp"--> 
</head>
<body >



<% LinkID= Request.QueryString("LinkID") 
		If Len(LinkID) < 1 then
			LinkID= Request.Form("LinkID") 
		End If 



Query =  " UPDATE Links Set LinkImage = '' " 
Query =  Query & " where LinkID = " & LinkID & ";" 

response.write(Query)	


Set DataConnection = Server.CreateObject("ADODB.Connection")

DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) 	& ";" 


DataConnection.Execute(Query) 

	rowcount= rowcount +1
	DataConnection.Close
	Set DataConnection = Nothing 
response.redirect("AdminLinkEdit.asp?LinkID=" & LinkID)

%>

 </Body>
</HTML>
